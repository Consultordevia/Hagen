<!-- GENERADO — NO EDITAR -->

# devconsultia-al-performance

*Copia generada de `skills/devconsultia-al-performance/SKILL.md` del Manual. GENERADO — NO EDITAR:*
*si algo de aquí está mal o desactualizado, se corrige en el Manual, no aquí.*

---

---
name: devconsultia-al-performance
description: 'Rendimiento en AL: SetLoadFields, filtrar antes de leer, CalcSums/CalcFields, tablas temporales, trampas de FlowField (AL0896). Usar ante lentitud, timeouts o revisión de bucles sobre registros en AL. Triggers: "rendimiento", "lento", "SetLoadFields", "FlowField", "CalcSums", "timeout", "optimizar".'
---

# Rendimiento en AL (Business Central) — DevConsultIA

**Fecha:** 2026-09-22. **Audiencia:** desarrollador AL mid-level trabajando en los repos de `C:\DevConsultIA-repos`.

Esta skill es de **stack AL** (se incluye por tecnología, no por ámbito): patrones de rendimiento genéricos, sin nombrar repos, clientes ni entornos concretos. Todo lo de aquí es **PROPUESTA de estándar**, salvo que se indique lo contrario — la disciplina de perfilar antes/después de cada cambio la debe aportar quien lo aplica, no esta skill.

## Cuándo NO usar esta skill

- Bug funcional sin componente de rendimiento (dato mal calculado, permiso que falta) → `devconsultia-debugging-playbook`.
- Diseño de integraciones externas (HttpClient, SOAP, reintentos) → `devconsultia-al-integrations`.
- Estructura de página, UI, tooltips → `devconsultia-al-ui-patterns`.
- Esta skill responde a UNA pregunta: **¿por qué esta operación AL habla más con la base de datos de lo necesario, y cómo se reduce?**

---

## 1. Filtra antes de leer, y carga solo lo que necesites

Lo que importa es que **filtros y `SetLoadFields` estén puestos ANTES de la lectura** (`FindSet`/`FindFirst`/`Get`): entre ellos el orden da igual. Un `SetLoadFields` puesto después del `Find` ya no sirve para esa lectura. Y los campos que uses en el filtro no hace falta añadirlos a `SetLoadFields`, pero cualquier campo que leas y no esté en la lista provoca una segunda consulta para ir a por él (*JIT load*): es peor que no haber puesto `SetLoadFields`.

```al
Customer.SetRange("Country/Region Code", 'ES');
Customer.SetLoadFields("No.", Name, "E-Mail"); // solo los campos que vas a leer/mostrar
if Customer.FindSet() then
    repeat
        // ...
    until Customer.Next() = 0;
```

Reglas:

1. **`SetLoadFields` en todo bucle que no vaya a tocar TODOS los campos del registro.** Sin él, BC trae la fila completa — incluidos Blobs y campos que nunca lees. Es el cambio de mayor impacto y menor riesgo de todos los de esta skill: no cambia comportamiento, solo lo que viaja por red/disco.
2. **No mezcles `SetLoadFields` con un `Validate`/`Modify` posterior sobre campos no cargados** — BC los sobreescribe con valores por defecto si el registro no los trajo. Si vas a modificar, carga (o vuelve a leer completo) los campos que vas a escribir.
3. **`IsEmpty()`/`Count()` en vez de `FindFirst()` + comprobar** cuando solo necesitas saber si hay filas o cuántas — evita traer el primer registro entero para descartarlo.
4. **Nunca un bucle `while`/`repeat` sin filtro previo** sobre una tabla grande (Ledger Entries, Item Journal Line) esperando descartar filas dentro del bucle. El filtro va en `SetRange`/`SetFilter`, nunca en un `if` dentro del `repeat`.

## 2. Agregaciones: que las sume la base de datos, no tu bucle AL

Un bucle que acumula un `Decimal` recorriendo miles de líneas es la forma más cara de sumar que existe en AL. `CalcSums` empuja la suma a SQL:

```al
// Mal: recorre y acumula en AL
SalesLine.SetRange("Document No.", DocNo);
if SalesLine.FindSet() then
    repeat
        Total += SalesLine.Amount;
    until SalesLine.Next() = 0;

// Bien: una sola llamada, la suma la hace la base de datos
SalesLine.SetRange("Document No.", DocNo);
SalesLine.CalcSums(Amount);
Total := SalesLine.Amount;
```

Sobre FlowFields: **no se autocalculan fuera del contexto de página.** Si lees un campo FlowField desde un codeunit o un report, tienes que llamar `CalcFields` explícitamente antes de leerlo — de lo contrario el valor es 0/vacío y el bug es silencioso (no da error, solo da un dato incorrecto). Si vas a leer el mismo FlowField sobre muchas filas, ese es exactamente el caso para tabla temporal + `CalcSums` en vez de `CalcFields` fila a fila (§3).

## 3. Tabla temporal como caché de una pasada

Cuando el mismo dato maestro (tarifas, datos de cliente, configuración) se necesita en cada iteración de un bucle grande, cárgalo UNA vez en una tabla temporal, `Dictionary` o `List` antes del bucle, y consúltalo en memoria dentro de él — nunca una consulta a base de datos por cada vuelta.

```al
// Antes del bucle: una sola consulta
TempCustomerRate.Reset();
TempCustomerRate.DeleteAll();
CustomerRate.SetLoadFields("Customer No.", Rate);
if CustomerRate.FindSet() then
    repeat
        TempCustomerRate := CustomerRate;
        TempCustomerRate.Insert();
    until CustomerRate.Next() = 0;

// Dentro del bucle: solo memoria, cero ida y vuelta a base de datos
SalesLine.SetLoadFields("Customer No.", Amount);
if SalesLine.FindSet() then
    repeat
        TempCustomerRate.SetRange("Customer No.", SalesLine."Sell-to Customer No.");
        if TempCustomerRate.FindFirst() then
            ...
    until SalesLine.Next() = 0;
```

Esto es lo mismo que evitar una consulta N+1 en cualquier otro stack: una consulta dentro de un bucle que recorre N filas es, en el peor caso, N consultas. Muévela fuera y pásala a memoria.

## 4. FlowField: la referencia circular (AL0896) y cómo resolverla

Un `CalcFormula` que, siguiendo la cadena de FlowFields, acaba dependiendo de sí mismo produce el error de compilación `AL0896`. Aparece típicamente al añadir un FlowField nuevo sobre una tabla extendida que ya tenía otro FlowField apuntando, directa o indirectamente, de vuelta a la primera.

Orden de resolución, de menos a más invasivo:

1. **Rompe la cadena**: convierte uno de los dos FlowFields en campo normal, calculado y guardado explícitamente en el evento donde cambian sus datos de origen (p. ej. `OnAfterModify`/`OnAfterInsert` del documento origen).
2. **Sustituye por `CalcSums` explícito** en el punto donde se necesita el valor, en vez de declarar un FlowField nuevo que cierra el ciclo.
3. **Restructura el cálculo en un codeunit** que reciba los datos ya resueltos y no dependa de que el motor de FlowFields infiera el orden.
4. **Claves SIFT (`SumIndexFields`)** cuando el cuello de botella es el propio `CalcFields`/`CalcSums` sobre una tabla grande sin índice de suma adecuado — añade la clave con los campos que se suman habitualmente juntos.

No "resuelvas" un AL0896 quitando el `CalcFormula` y sumando a mano en un bucle sobre la tabla completa: cambias un error de compilación por un problema de rendimiento silencioso, que es peor porque no avisa.

## 5. Objetivos concretos (referencia, no ley física)

| Métrica | Objetivo |
|---|---|
| Carga de página | < 2 s |
| Generación de informe (dataset estándar de cliente) | < 10 s |
| Respuesta de API/página expuesta | < 500 ms |
| Proceso batch (Job Queue, import masivo) | > 1.000 registros/minuto |

Son objetivos de referencia para decidir si algo "va lento" merece trabajo, no un contrato con el cliente. Documenta el dataset con el que mediste (tamaño de tabla, nº de líneas) — un "va rápido" medido con CRONUS vacío no dice nada del entorno real del cliente.

## 6. Cómo triar un caso de rendimiento

1. **Reproduce con un dataset del tamaño real del cliente**, no con datos de demo — la mayoría de problemas de rendimiento de AL solo aparecen con volumen.
2. **Perfila antes de tocar código**: captura CPU/SQL con el Profiler de BC en VS Code (o `Diagnostics` del cliente web) para el caso lento concreto. No adivines dónde está el cuello de botella — mídelo.
3. **Escanea primero los antipatrones estructurales** de las secciones 1-3: `FindSet`/bucle sin `SetLoadFields`, `SetRange` puesto DESPUÉS de empezar a iterar, sumas acumuladas en AL en vez de `CalcSums`, consultas dentro de un bucle.
4. **Aplica el cambio mínimo**, recompila, vuelve a perfilar con el mismo dataset — compara antes/después con número, no con sensación.
5. **Documenta** el antes/después (tiempo, nº de consultas si el profiler las da) en el commit o en la petición: es la evidencia de que el cambio sirvió, no una opinión sobre el código.

No cambies rendimiento y comportamiento funcional en el mismo commit — si el fix de rendimiento requiere cambiar qué hace el proceso (no solo cómo lo hace), sepáralo en dos cambios revisables por separado.

---

## Provenance y mantenimiento

Patrones destilados de prácticas estándar de rendimiento en AL/Business Central (`SetLoadFields`, `CalcSums`/`CalcFields`, tablas temporales como caché, SIFT) y de errores de compilación conocidos del motor de FlowFields (AL0896). Etiquetado como PROPUESTA de estándar porque no hay, a día de hoy, un caso de triaje de rendimiento auditado en el código del portfolio del que extraer "así se hizo aquí" — a diferencia de `devconsultia-al-integrations` o `devconsultia-debugging-playbook`, que sí citan commits reales.

Actualiza esta skill cuando: se resuelva un caso de rendimiento real en el portfolio (añade el patrón con su medida antes/después, sin nombrar repo ni cliente si esta skill se empaqueta hacia cliente), o cambien los objetivos de la sección 5 por acuerdo con el equipo.

Skills hermanas: `devconsultia-al-standard`, `devconsultia-al-integrations`, `devconsultia-debugging-playbook`, `devconsultia-testing-and-qa`.
