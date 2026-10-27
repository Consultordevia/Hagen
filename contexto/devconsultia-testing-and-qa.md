<!-- GENERADO — NO EDITAR -->

# devconsultia-testing-and-qa

*Copia generada de `skills/devconsultia-testing-and-qa/SKILL.md` del Manual. GENERADO — NO EDITAR:*
*si algo de aquí está mal o desactualizado, se corrige en el Manual, no aquí.*

---

---
name: devconsultia-testing-and-qa
description: 'Testing y QA en DevConsultIA: qué cuenta como evidencia de calidad, estándar mínimo por stack (AL, Python, Node) y validación pre-entrega en sandbox. Triggers: "test", "QA", "pytest", "cobertura", "validar antes de entregar".'
---

# DevConsultIA · Testing y QA

Fecha de auditoría del estado real: **2026-07-06**. Revisión de neutralidad: **2026-08-16**.
Audiencia: quien trabaje en `C:\DevConsultIA-repos`.

Esta skill es de **núcleo**: viaja en el contexto de cualquier repositorio, incluidos los de cliente. Por eso los ejemplos son genéricos y no nombran repos, clientes ni entornos concretos.

## Cuándo NO usar esta skill

- Publicar, empaquetar o desplegar una app → `devconsultia-release-and-deploy`.
- Diagnosticar un error en producción o sandbox → `devconsultia-debugging-playbook`.
- Esta skill responde a UNA pregunta: **¿qué evidencia de calidad tengo que producir antes de dar algo por hecho?**

---

## 1. Estado real de los tests — honestidad primero

**Re-medido el 2026-09-24** (`test_*.py`, `*.test.ts(x)`, `*.test.mjs`, codeunits AL con
`Subtype = Test`; comandos al final). En julio de 2026 solo había una suite pytest, un
script de coherencia y dos codeunits de test esqueleto; desde entonces:

- **Python:** suites pytest reales en varios servicios (la del solver de planificación sigue
  siendo la plantilla, §2.2; los backends de CRM ya cubren conector BC y reglas de negocio).
  Un motor financiero valida con un script standalone (`python test_engine.py`) usado como
  gate de su pipeline: funciona, pero no es el modelo a copiar.
- **Node/TypeScript:** suites `vitest` en algunos portales, en la plantilla web y en el
  paquete compartido de BC.
- **AL:** apps de test separadas (producto + app `Tests`) en varios productos, con tests de
  negocio; los repos AL de cliente y los productos antiguos siguen sin ninguno.

Qué repo concreto tiene suite es estado del portfolio (conocimiento interno): **antes de
citar una suite, compruébala en el repo**, y no inventes las que no existan.

**Trampa ya vista:** un fichero de test AL se llamaba `Cod72213.*.al` y declaraba
`codeunit 50298`. El nombre del fichero lleva el ID real del objeto.

**Consecuencia operativa:** la mayoría del código que se entrega sigue validándose **a mano
en sandbox**. Cuando toques código sin tests, tu evidencia de calidad es la checklist de la
sección 4, no una suite verde.

---

## 2. Estándar mínimo por stack (PROPUESTA, no práctica vigente)

Lo siguiente es el estándar al que se quiere converger. Etiquétalo como propuesta si lo comunicas al cliente o al equipo. Al crear código nuevo, aplícalo por defecto.

### 2.0 Disciplina TDD (antes del estándar por stack)

Regla base para cualquier lógica nueva, en cualquier stack: el test se escribe ANTES del código que lo hace pasar. No es un ritual: es la única forma barata de comprobar que el test realmente prueba algo — si nunca lo viste fallar, no sabes si comprueba lo correcto.

Ciclo:

1. **ROJO** — escribe el test mínimo que exprese el comportamiento esperado. Debe fallar, y fallar por el motivo correcto (no por un error de compilación o de fixture).
2. **VERDE** — escribe el código mínimo que lo hace pasar. Nada de features no pedidas ni de "ya que estoy": el objetivo es pasar el test, no anticipar el siguiente.
3. **REFACTOR** — limpia (nombres, duplicación) con el test en verde todo el rato. No añadas comportamiento en este paso.

Entre pasos: tras escribir el test, ejecútalo y confirma que falla como esperabas; tras el fix, ejecuta la suite entera del módulo, no solo el test nuevo. El código escrito antes del test se borra, no se adapta.

Excepciones: prototipo desechable, código generado, ficheros de configuración — y solo con acuerdo explícito de a quién se lo pides. Fuera de eso, sin test antes no hay código de producción.

Aplicación aquí: como la mayor parte del parque valida en sandbox (sección 1), aplicar TDD en código nuevo es la palanca más barata para que mañana exista suite. Empieza por la lógica pura que hoy no tiene ningún test (cálculos, validaciones, invariantes de negocio) — es justo donde más rinde según la sección 3.

### 2.1 AL (Business Central)

**Regla:** lógica pura de cálculo → test codeunit con `Subtype = Test`. UI, flujos de páginas y wizards → validación manual guiada (sección 4); no intentes testear UI con codeunits.

Estructura: carpeta `Tests\` como app separada que depende de la app principal (patrón ya usado en una app de la casa: app `Extension\` + app `Tests\`), con dependencia de las Microsoft *Library Assert* / *Any*.

Ejemplo completo y ejecutable — test de una función de cálculo de comisiones:

```al
codeunit 50290 "XXX Calculo Comision Tests"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";

    [Test]
    procedure ComisionEstandarEsPorcentajeSobreBase()
    var
        CalculoComision: Codeunit "XXX Calculo Comision";
        Resultado: Decimal;
    begin
        // [GIVEN] Base imponible 1.000, tarifa 5 %
        // [WHEN] Se calcula la comisión
        Resultado := CalculoComision.CalcularComision(1000, 5);
        // [THEN] La comisión es 50
        Assert.AreEqual(50, Resultado, 'Comisión estándar incorrecta');
    end;

    [Test]
    procedure ComisionNuncaEsNegativa()
    var
        CalculoComision: Codeunit "XXX Calculo Comision";
    begin
        // [THEN] Un abono (base negativa) no genera comisión negativa
        Assert.IsTrue(CalculoComision.CalcularComision(-500, 5) >= 0,
            'La comisión no puede ser negativa: es un invariante de negocio');
    end;

    [Test]
    procedure TarifaCeroDevuelveCero()
    var
        CalculoComision: Codeunit "XXX Calculo Comision";
    begin
        Assert.AreEqual(0, CalculoComision.CalcularComision(1000, 0), 'Tarifa 0 debe dar comisión 0');
    end;
}
```

Ejecuta con AL Test Runner (VS Code) o `Run-ALTest` en el contenedor Docker de desarrollo. Sustituye `XXX` por el acrónimo real de la app y usa un ID del rango del `devconsultia-id-registry`.

**Vuelta rápida sin BC (AL Runner, alpha):** `node C:/DevConsultIA-repos/.claude/herramientas/probar-al.mjs --proyecto <app> [--dep <app nuestra>]` ejecuta las codeunits `[Test]` en memoria con CRONUS ES: 1-5 s por vuelta, frente a minutos en sandbox. **Pasa** es buena señal, no prueba: lo que cuenta sigue siendo el Sandbox (§6, §8). **No ejecutada** es lo que AL Runner aún no sabe hacer; no se toca la app por eso. **Falla** se confirma en sandbox antes de cambiar código: salen falsos fallos, fallos por datos que CRONUS no tiene y pruebas que con el runner estándar fallan (`Commit` con `AutoRollback`, `Confirm` sin handler). No ve ejecutores propios lanzados por API, concede todos los permisos y no tiene red. No es puerta de pipeline mientras sea alpha.

**Datos de prueba: delega en las librerías estándar, no repliques CRONUS a mano.** Antes de montar tu propio helper para crear un Customer/Item/Sales Header de prueba, comprueba si ya existe un codeunit `Library - ...` de Microsoft (Test Library de BC) que lo haga; añade una capa propia solo para los campos que tu extensión añade encima. Los helpers no llevan variables globales: reciben lo que necesitan y devuelven el registro creado, para que dos tests no compartan estado por accidente.

Para escenarios con muchos parámetros opcionales, usa un builder encadenado en vez de un procedure con quince parámetros:

```al
SalesHeader := ComisionTestBuilder.Nuevo()
    .ConCliente(ClienteDemo."No.")
    .ConLinea('ITEM-A', 10)
    .ConTarifaComision(5)
    .Crear();
```

Un test que empieza con tres líneas de builder legible vale más que uno con quince parámetros posicionales que nadie sabe qué significan sin abrir la definición.

**UI:** usa `TestPage` para verificar comportamiento de página (visibilidad de campo, valor tras `Validate`, acción disponible) sin abrir BC a mano; no repliques con TestPage lo que un test de codeunit sobre la lógica ya cubre. Diálogos (`Confirm`, `Message`, otra página modal) se interceptan declarando el handler en `[HandlerFunctions('MiConfirmHandler')]` sobre el método de test — sin eso, un `Confirm` en un test cuelga la ejecución.

**Aislamiento entre tests — tres propiedades del codeunit de test que NO son lo mismo:**

| Propiedad | Qué decide | Trampa si la confundes |
|---|---|---|
| `TestPermissions` | Con qué permisos corre el test (`Restrictive` por defecto) | No hace rollback de nada; si necesitas simular un usuario sin permisos, esto es lo que tocas — no la transacción |
| `TransactionModel` | Si BC deshace los cambios al terminar el método (`AutoRollback` por defecto) | Ponerlo a algo distinto de `AutoRollback` deja datos de un test contaminando el siguiente si no limpias a mano |
| `TestIsolation` | Si el rollback se aplica entre MÉTODOS del mismo codeunit o solo entre codeunits | Con `Disabled`, dos métodos del mismo codeunit pueden verse los datos el uno al otro — motivo típico de "el test solo pasa si lo ejecuto suelto" |

Regla práctica: dos tests nunca dependen del orden de ejecución ni de datos que dejó otro. Si un test solo pasa ejecutado después de otro, el aislamiento está mal — no lo "arregles" reordenando.

**Cuánto testear, por riesgo (no cobertura por cobertura):**

| Qué es | Cuánto | Motivo |
|---|---|---|
| Cálculo/lógica de negocio pura (comisiones, validaciones, invariantes) | Alto — caso normal, límite y negativo | Es lo que más varía y menos se ve al probar a mano |
| Camino de integración (llamada a WS, import EDI) | Medio — feliz + error controlado | El resto lo cubre el log request/response de `devconsultia-al-integrations` §5 |
| Interacción de UI pura (orden de campos, tooltips) | Bajo/nulo con codeunits — usa la checklist de sandbox (sección 4) | Un TestPage que solo comprueba que un campo es visible no vale el mantenimiento |
| Manejo de errores esperados (`asserterror`, validación que debe bloquear) | Alto | Un error que deja de saltar en silencio es el bug más caro de detectar en producción |

No repliques como codeunit de test lo que la checklist de sandbox (sección 4) ya obliga a probar a mano — competirían por mantenimiento y perdería el codeunit.

### 2.2 Python

**Regla:** pytest, siguiendo el modelo de la suite del servicio de planificación (§1) — es la plantilla, cópiala.

- Helpers de construcción de datos arriba del fichero (`op(...)`, `base_request(...)`): el test se lee como una frase de negocio, no como un volcado de fixtures.
- Tests de invariantes sobre el motor (ver sección 3) + tests de contrato HTTP con `fastapi.testclient.TestClient`. Un test que verifica que la respuesta al frontend va en camelCase es un **contrato**, no un detalle de estilo: protégelo.
- Ejecutar: `python -m pytest tests/ -q` desde la raíz del servicio, con el `.venv` del repo activado.

Para un servicio nuevo, arranca copiando la estructura `tests/` de esa suite y adapta los helpers.

**Suite de más de ~2 minutos: en paralelo.** `pytest-xdist` en los requisitos de desarrollo y
`addopts = -n auto` en `pytest.ini`; exige que cada prueba tenga su propia base (SQLite en
`tmp_path`, nunca `tempfile.mkdtemp()`, que no se borra). Antes de paralelizar, mide dónde se va
el tiempo con `--durations=10`: en una suite de 1.300 pruebas el 99 % era la *preparación*
(reimportar la aplicación en cada prueba); en serie eran 70 minutos, en paralelo 7 (REQ-000900). Node no lo necesita:
`node --test`, vitest y jest ya reparten entre núcleos; no les pongas `--runInBand` ni
concurrencia 1 sin un motivo escrito.

### 2.3 Node / TypeScript

**Regla:** vitest para rutas API que tocan Business Central, con el cliente BC **mockeado** (`vi.mock` del módulo cliente). Nunca un test unitario contra un tenant real.

```ts
import { describe, it, expect, vi } from "vitest";
vi.mock("../src/bcClient", () => ({
  getCustomers: vi.fn().mockResolvedValue([{ no: "C001", name: "Cliente Ejemplo, S.L." }]),
}));
import { handler } from "../src/routes/customers";

describe("GET /customers", () => {
  it("devuelve los clientes que entrega el cliente BC", async () => {
    const res = await handler({ query: {} });
    expect(res.status).toBe(200);
    expect(res.body[0].no).toBe("C001");
  });
});
```

Para tests de integración de verdad contra un BC "real", usa el simulador embebido (sección 5), no mocks.

---

## 3. Filosofía: un test protege un invariante de negocio

El criterio para decidir QUÉ testear viene de la suite del solver. Un buen test protege una regla que el negocio da por supuesta; un mal test fija un detalle de implementación que mañana cambiará.

Ejemplos reales de esa suite — úsalos como patrón mental:

- `test_precedence_within_order`: la operación 10 termina antes de que empiece la 20 dentro de la misma OF. **Invariante de routing.** No comprueba en qué minuto exacto se planifica cada una (eso es implementación del solver).
- `test_no_overlap_same_machine`: dos operaciones en M1 no se solapan. **Invariante físico.**
- `test_machine_eligibility_spreads_load`: solo afirma que se usan ambas máquinas, no cuál OF va a cuál. Deja libertad al optimizador.
- `test_frozen_operation_not_moved`: lo que el planificador fijó a mano no se mueve. **Contrato con el usuario.**
- `test_kpis_report_tardiness`: construye un escenario donde el retraso es matemáticamente inevitable (`assert late_order_count >= 1`), no uno donde depende de la heurística.

Regla práctica antes de escribir un test: formula el invariante en una frase que un consultor funcional firmaría ("una operación congelada nunca se mueve"). Si no puedes, estás testeando implementación — bórralo.

---

## 4. Validación pre-entrega a cliente (el QA real de la casa)

Mientras la cobertura sea la que es (sección 1), esto es el gate de calidad. Ejecútalo en un sandbox del cliente o contenedor limpio, no solo en tu entorno de desarrollo.

**Checklist de sandbox (obligatoria antes de entregar):**

1. **Instalar** la app desde el `.app` compilado (no desde RAD — Rapid Application Development, el publish incremental de VS Code). Si hay versión previa: probar también el **upgrade** con datos existentes.
2. **Configurar el setup** desde cero siguiendo solo la UI (guided setup si existe). Si necesitas tocar tablas a mano, el setup está incompleto: arréglalo.
3. **Flujo completo del módulo** de principio a fin con un caso realista (p. ej. pedido → envío → factura, o configuración → cálculo → registro).
4. **Permisos:** repetir el flujo con un usuario NO superadministrador y el permission set de la app. Los fallos de permisos solo aparecen aquí.
5. **Datos demo:** verificar comportamiento con datos vacíos/mínimos, no solo con la empresa CRONUS bien poblada.

**Integraciones — usa el entorno de pruebas del proveedor, existe y está en el código:**

- **AEAT VeriFactu:** nuestra app de VeriFactu lleva en su tabla de configuración un campo `"Entorno de pruebas"` (Boolean) que conmuta los endpoints al entorno de preproducción de la AEAT (`https://prewww1.aeat.es/...VerifactuSOAP`) y el QR a `https://prewww2.aeat.es/...ValidarQR`. Se valida contra prewww antes de activar producción.
- **Transportistas:** en nuestras integraciones de carriers no se han encontrado endpoints de test dedicados — alguna apunta directamente a la URL de producción del proveedor. Antes de tocar una integración de transportista, pregunta al proveedor (GLS, Correos, MRW, etc.) por su entorno de test y documéntalo en el setup — hoy ese hueco existe, no lo disimules.
- Cualquier integración nueva: el setup incluye un flag de entorno de pruebas al estilo VeriFactu. Es el patrón de la casa.

---

## 5. Patrón replicable: el simulador BC embebido

Uno de nuestros backends Python incluye un módulo `backend/bc_sim/` que imita BC / Microsoft Graph / el proveedor de email marketing (OAuth incluido) para ejercitar los conectores reales sin tenant ni claves; replícalo en cualquier servicio que hable con BC/Graph/API externa. Arranque: `python -m uvicorn bc_sim.app:app --port 8090` (desde `backend\`). Detalle completo del patrón en `devconsultia-python-standard` §3.

---

## 6. Definición de "hecho" (Definition of Done)

Una tarea NO está terminada hasta que puedas afirmar todo esto:

1. **Compila sin warnings de cops** (CodeCop/UICop/AppSourceCop según `ruleset` del repo; lint/tsc en Node; sin errores de tipo en Python).
2. **Tooltips presentes** en todos los campos y acciones de UI propia, en español (regla global de la casa).
3. **Install y upgrade probados**: el `.app` instala limpio y actualiza sobre la versión anterior sin pérdida de datos.
4. **Flujo validado en sandbox** con la checklist de la sección 4 (incluido usuario no-admin).
5. **Sin secretos** en el código ni en el repo: nada de tokens, passwords ni connection strings hardcodeados; usa setup tables / variables de entorno / `.env.example`.
6. Si hay lógica pura nueva: **test que protege su invariante** (sección 2), o justificación explícita de por qué no.

---

## 7. Diseño acordado antes de programar

Antes del ROJO de la sección 2.0 tiene que haber un diseño, aunque sea de dos frases. Escribir el primer test ya es empezar a programar: si el "qué" todavía no está acordado, el test que escribas fijará una decisión que nadie aprobó.

Regla práctica según el semáforo de autonomía de `AGENTS.md`:

- **Cambio acotado** (tocar una función, un endpoint, un codeunit existente): antes de tocar código, di en una frase qué vas a cambiar y por qué — no hace falta documento ni aprobación si cae en 🟢 verde del semáforo.
- **Cambio ambiguo o con varias formas razonables de hacerlo, arquitectura nueva, dependencia nueva o cambio de contrato**: eso ya es 🟡 amarillo — propón 1-2 opciones con tu recomendación y espera el OK explícito antes de escribir el primer test o la primera línea. No lo canjees por "ya lo genero y ya se verá"; deshacer código escrito sale más caro que dos frases de diseño.
- Si la complejidad real aparece a mitad de tarea (lo acotado deja de serlo), sube de categoría — nunca al revés.

Esto **no** es licencia para crear worktree ni cambiar de carpeta en trabajo supervisado: sigue el modo de operación vigente (INTERACTIVE por defecto, ver ADR-AIOS-001 R12 en `AGENTS.md`) — el diseño se acuerda en el chat, no en una carpeta aparte.

---

## 8. Verificar antes de dar por terminado

Regla dura: **no se declara nada terminado sin evidencia fresca, ejecutada en este momento.** "Debería funcionar" o citar una ejecución de hace media hora no son evidencia.

Antes de decir "hecho" (también en una PR):

1. **Identifica el comando que demuestra la afirmación** — el test que reproduce el bug, la suite del módulo, el build, el linter.
2. **Ejecútalo entero, ahora**, no de memoria ni copiando un resultado anterior.
3. **Lee la salida completa y el código de salida** — no solo la última línea ni el resumen que tú mismo escribiste.
4. **Comprueba que esa salida confirma justo lo que vas a afirmar** (no un resultado parecido; no "no dio error" cuando la afirmación es "arregla X").
5. Solo entonces, afirma el resultado citando la evidencia concreta ("34/34 tests en verde", "build exit 0", "el escenario que fallaba ahora pasa").

Vale también para lo que te cuente un sub-agente u otra sesión: se comprueba antes de darlo por bueno y se repite tras el último cambio.

Aplicado aquí: en AL, "verificado" significa que has instalado o publicado el `.app` y ejecutado la checklist de sandbox (sección 4) o el codeunit de test, no que has releído el código. Sin comando (típico en UI), la evidencia es la checklist de sandbox paso a paso.

**Recibo y revisión.** Con `verificacion.json`, la PR pide tras el último commit `node C:/DevConsultIA-repos/.claude/herramientas/verificar.mjs run` (atado al HEAD) y, si lleva `revision`, `verificar.mjs revisar`: otro Claude, sin tu contexto, revisa el diff con el `REVIEW.md` del repo, y cada hallazgo se cierra. Vuelta atrás: `volver-atras.mjs`. Detalle: `docs/revision-antes-de-pr.md` del Manual.

---

## Provenance y mantenimiento

- Basado en auditoría directa del código el **2026-07-06**: lectura de la suite pytest del servicio de planificación, del script standalone del motor financiero, de los codeunits de test AL existentes, del simulador BC embebido, de la tabla de configuración de VeriFactu y búsqueda global de patrones de test en los ~75 repos del parque.
- Neutralizada el 2026-08-16 (REQ-000380): se retiraron los nombres de repo, fichero y cliente, porque esta skill se empaqueta hacia repositorios de cliente. El material retirado está íntegro en el Manual (`conocimiento/extraido/devconsultia-testing-and-qa.md`), que NO se empaqueta.
- Comandos de re-verificación (PowerShell, desde `C:\DevConsultIA-repos`):

```powershell
# Tests Python
Get-ChildItem -Recurse -Filter 'test_*.py' | Where-Object FullName -NotMatch 'node_modules|\.venv'
# Tests Node
Get-ChildItem -Recurse -Include '*.test.ts','*.spec.ts' | Where-Object FullName -NotMatch 'node_modules'
# Codeunits AL de test
Get-ChildItem -Recurse -Filter *.al | Select-String -Pattern 'Subtype\s*=\s*Test' -List
```

- Las secciones 2 (incluida 2.0), 6, 7 y 8 son **propuesta de estándar**, no descripción de práctica existente; las secciones 1, 3, 4 (parte AEAT) y 5 describen hechos verificados en el código.
- Revisa esta skill cuando: aparezca una suite nueva en cualquier repo, cambie el endpoint de pruebas de AEAT, o se adopte formalmente el estándar de la sección 2 (entonces re-etiquetar). No reintroduzcas nombres de repo ni de cliente: si necesitas apuntar a uno, hazlo en el Manual interno.
- Skills hermanas: `devconsultia-release-and-deploy`, `devconsultia-debugging-playbook`, `devconsultia-id-registry`, `devconsultia-al-integrations`.
