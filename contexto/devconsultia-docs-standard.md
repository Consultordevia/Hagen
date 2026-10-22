<!-- GENERADO — NO EDITAR -->

# devconsultia-docs-standard

*Copia generada de `skills/devconsultia-docs-standard/SKILL.md` del Manual. GENERADO — NO EDITAR:*
*si algo de aquí está mal o desactualizado, se corrige en el Manual, no aquí.*

---

---
name: devconsultia-docs-standard
description: 'Estándar de documentación de repos de DevConsultIA (README, CLAUDE.md, PRODUCTO.md, handoff), con plantillas, reglas de estilo y checklist de retrofit. Usar al crear o revisar documentación de un repo. Triggers: "documentar repo", "README", "CLAUDE.md", "handoff", "traspaso".'
---

# Estándar de documentación de repos DevConsultIA

Fecha del estándar: 2026-07-06. Revisión de neutralidad: 2026-08-16.
Audiencia: quien abre un repo de `C:\DevConsultIA-repos` y necesita documentarlo o entenderlo.

Esta skill es de **núcleo**: viaja en el contexto de cualquier repositorio, incluidos los de cliente. Por eso enuncia criterios, no inventarios: no nombra repos, clientes ni entornos concretos.

## Cuándo usar esta skill

- Crear o completar el README.md, CLAUDE.md o PRODUCTO.md de un repo.
- Preparar un documento de HANDOFF para un traspaso o proyecto grande.
- Auditar la documentación de un repo heredado ("¿qué le falta a este repo?").
- Decidir qué repos documentar primero.

## Cuándo NO usar

- Contenido técnico del código en sí (reglas AL, patrones Next.js, solver Python): eso va en las skills de cada stack o en el CLAUDE.md del repo concreto, no aquí.
- Documentación funcional para usuario final (guías dentro de BC, manuales de cliente).
- Decidir arquitectura: esta skill dicta CÓMO documentar decisiones, no cuáles tomar.

## Qué distingue a un repo bien documentado (verificado 2026-07-06)

Rasgos observados en los mejores repos del parque. Son el listón: si el repo que tienes delante no los cumple, ahí está el trabajo.

| Documento | Qué hace bien el mejor ejemplo del parque |
|---|---|
| `README.md` | Dice qué es, en qué estado está, cómo se arranca, qué falta y cómo está organizado el árbol de carpetas. Un lector nuevo lo tiene funcionando sin preguntar. |
| `README.md` de proyecto multi-pieza | Tabla de piezas (AL / web / servicio) con **comando de validación por pieza**, más una sección "Decisiones de arquitectura" fechada. |
| `CLAUDE.md` | Reglas duras y verificables: prefijo de objetos, rango de IDs reservado, reglas UX/UI numeradas, auditoría obligatoria de cierre. |
| `PRODUCTO.md` | Descripción comercial, funcionalidad actual, comparativa contra la alternativa estándar de BC y roadmap priorizado con tabla esfuerzo/impacto. |
| `HANDOFF-*.md` | Traspaso completo con De/Para/Owner, decisiones razonadas y trampas conocidas (§2). |
| Carpeta `docs/` | README de arranque rápido en la raíz + `docs/` con handoff, setup de cloud, integraciones y despliegue. |

**Anti-patrón dominante:** 17 carpetas del parque (grep del 2026-09-24; 18 el 2026-07-06) conservan el README plantilla de Azure DevOps "TODO: Give a short introduction...". Un README plantilla es PEOR que ninguno: parece documentación y no dice nada.

**Incidente real de seguridad:** un documento de HANDOFF de la casa dejó secretos en claro dentro del repo — motiva la regla 3 de estilo; inventario y runbook de rotación en `devconsultia-secrets-and-config` §1.

---

## 1. Los 3 documentos canónicos por repo

Todo repo de DevConsultIA lleva como mínimo **README.md** y **CLAUDE.md**. Los repos de producto propio (extensiones de catálogo que se venden a más de un cliente) llevan además **PRODUCTO.md**.

### 1.1 Plantilla README.md

Basada en los README de referencia del parque. Sustituye todo lo que va entre `<>`.

```markdown
# <Nombre del proyecto> (<ACRÓNIMO>)

<1-3 frases: qué es, qué problema resuelve. Si sustituye o deriva de algo, dilo.>

> **Lee `CLAUDE.md`** antes de cualquier cambio: contiene las reglas obligatorias del repo.

## Cliente / destino

<A quién se vende o para qué cliente es: "Producto Devconsultia (per-tenant / AppSource)"
o "Desarrollo a medida para <Cliente>, entorno <sandbox/producción>">

## Stack

| Pieza | Tecnología | Validación |
|---|---|---|
| <al/> | <Extensión BC "X" vN, runtime N, idRange NNNNN-NNNNN, prefijo XXX> | <alc.exe ... → 0 errores> |
| <web/> | <Next.js N + ...> | <pnpm typecheck && pnpm lint && pnpm build> |

(Filas solo para las piezas que existan. Si es solo AL, una fila.)

## Cómo compilar / arrancar

1. <Paso imperativo con comando exacto: abrir en VS Code, AL: Download symbols...>
2. <Ctrl+F5 / pnpm dev -p NNNN / uvicorn ...>
3. <Cómo probar que funciona: primera pantalla, smoke test.>

## Dependencias

- <Apps BC de las que depende (con versión), servicios externos, App Registrations
  (solo nombre/propósito, NUNCA secretos).>

## Estado actual

<Qué funciona hoy. Si aplica, tabla de objetos (Objeto | ID | Tipo | Propósito).>

## Próximos pasos

1. <Ordenados. Qué falta y en qué orden se atacaría.>

## Estructura de carpetas

```
<árbol breve con comentario por carpeta relevante>
```
```

Reglas al rellenarlo:
- El bloque "Cómo compilar / arrancar" debe permitir a alguien que NO conoce el repo tenerlo funcionando sin preguntar a nadie.
- Ejemplo de `.env` → siempre con placeholders (`BC_CLIENT_SECRET=<en el vault>`), jamás valores reales.
- Si el repo genera `.app`, di dónde acaban y cómo se publican.

### 1.2 Plantilla CLAUDE.md

Modelada sobre el CLAUDE.md de referencia del parque. Son las **reglas duras del repo para sesiones IA**: identidad, rangos, reglas UI, qué no tocar, auditoría de cierre. Debe ser corto, imperativo y sin ambigüedad.

```markdown
# CLAUDE.md — <Nombre> (<ACRÓNIMO>)

Contexto y estándares obligatorios para todo el código de este proyecto.

## Identidad del proyecto
- **Nombre**: <Nombre>
- **Publisher**: DevConsultIA
- **Acrónimo (prefijo de objetos y captions)**: `<XXX>`
- **Target**: <Cloud (BC SaaS) / OnPrem BCnn / Web / ...>
- **ID range**: <NNNNN-NNNNN>
- **Idioma de interfaz**: Español (captions, tooltips, labels)

## Reglas UI (solo si el repo tiene UI en AL)
1. ToolTip explicativo en español en todos los campos visibles y acciones (en la capa page).
2. Caption con prefijo `(<XXX>)` en español en cada page propia (no en pageextensions de pages estándar).
3. PageExtensions: campos dentro de un `group` propio con caption `(<XXX>) ...`, no sueltos
   en grupos estándar. Acciones promoted (`Promoted`, `PromotedCategory`, `PromotedIsBig` en
   las principales).
4. <Si aplica: Role Center propio con cues KPI por módulo, guía integrada (tutorial guide)
   y wizard de setup. Enúncialas como reglas numeradas igual que las anteriores, con el
   prefijo del repo; el detalle de cada patrón está en `devconsultia-al-ui-patterns`.>

## Qué NO tocar
- <Objetos/tablas/datos estándar prohibidos. Ej. en una app que extiende fabricación:
  "lo estándar no se toca: ni escrituras ni Validate sobre las líneas de ruta".>
- <Rangos de ID reservados por otros, archivos generados, .app versionados...>

## Convenciones
- Un objeto por archivo: `<Prefix><Name>.<Type>.al`. Carpetas por módulo en `src/`.
- Errores como `Label` con `Comment` para traducción.
- <Convenciones extra del repo: API namespace propio, patrón worker asíncrono, etc.>

## Auditoría obligatoria antes de cerrar cualquier cambio
1. ¿Compila con 0 errores (<comando exacto>)?
2. ¿Cada campo/acción nuevo cumple las reglas UI?
3. <Checks específicos del repo: ¿page nueva añadida al Role Center? ¿permission set actualizado?>
```

Reglas al rellenarlo:
- Si el acrónimo o el rango de IDs no salen de `app.json` ni de `devconsultia-id-registry`, pregúntalos antes de escribir el archivo; no los inventes.
- En repos sin UI (APIs, integraciones, solver), elimina la sección UI: no fuerces reglas que no aplican.
- La sección "Qué NO tocar" es la más valiosa para una sesión IA: sé explícito.

### 1.3 Plantilla PRODUCTO.md (solo productos propios)

Modelada sobre el PRODUCTO.md de referencia del parque. Es el documento comercial/roadmap: qué es, qué hace hoy, contra quién compite y qué viene.

```markdown
# <Nombre producto> — Descripción del producto y roadmap

## Qué es
<Pitch de 2-4 frases: qué hace y por qué es mejor que la alternativa obvia.>

## Qué hace hoy (funcionalidad actual)
### <Bloque funcional 1>
- <Funcionalidad concreta, en presente, verificable en el código.>
### <Bloque funcional 2>
...

## Comparación con <competidor/alternativa estándar de BC>
| Característica | <Alternativa> | <Producto> |
|---|---|---|
| ... | ... | ... |

## Roadmap
### PRIORIDAD 1: <tema>
#### 1.1 <Mejora>
**Problema actual:** <...>
**Solución:** <...>
(Repetir por prioridad. Cerrar con tabla resumen:)

## Resumen de impacto por mejora
| Mejora | Esfuerzo | Impacto | Prioridad |
|---|---|---|---|

## Estado comercial
- Modelo: <per-tenant / AppSource / interno>. Clientes/pilotos: <...>. Precio: <si está decidido>.
- Última revisión: <AAAA-MM-DD>
```

---

## 2. Documento de HANDOFF (traspasos y proyectos grandes)

Cuándo crearlo: al traspasar un proyecto a otra persona/sesión, al cerrar una fase larga, o cuando el contexto no cabe en el README. Nómbralo `HANDOFF-<tema>-<AAAA-MM-DD>.md` en la raíz del repo (o `docs/`).

Lo que hace bueno a un handoff (replícalo): De/Para/Owner explícitos; recomendación tecnológica RAZONADA en tabla; reglas del owner marcadas como innegociables; inventario de lo que ya existe vs lo que falta; sección de trampas conocidas ("heredadas con sangre"); tabla "quieres X → mira archivo Y"; incluso cómo trabajar con el owner. Lo que hizo MAL el mejor handoff de la casa (no lo repitas): incluir un client secret en claro — ver regla 3.

```markdown
# HANDOFF — <Proyecto/fase> (<AAAA-MM-DD>)

**De**: <quién entrega (persona o sesión IA + fecha)>
**Para**: <quién recibe>
**Owner**: <responsable de negocio y contacto>
**Estado del proyecto**: <una línea: qué está cerrado, qué está abierto>

Léelo entero antes de empezar: las decisiones (§2) y las trampas (§6) no se deducen del código.

## 1 · Qué se pide construir / continuar
<Objetivo con el criterio de "hecho".>

## 2 · Decisiones de arquitectura (con razones)
| Capa/tema | Decisión | Por qué |
|---|---|---|
<Incluye las reglas INNEGOCIABLES del owner en lista aparte, marcadas como tales.>

## 3 · Contexto que heredas
<Tabla de repos/rutas/carpetas relevantes y qué es cada una. Entornos y credenciales:
solo NOMBRE del entorno y DÓNDE están las credenciales (vault/.env.local), nunca valores.>

## 4 · Estado actual — qué funciona ya
<Lista verificable. Comandos de validación exactos (compilar, typecheck, tests).>

## 5 · Qué falta (siguientes pasos, ordenados)
1. <Paso con entregable claro. IDs/rangos libres si es AL.>

## 6 · Trampas conocidas
- <Cada bug/peculiaridad ya sufrida, para no redescubrirla.>

## 7 · Dónde mirar código de referencia
| Quieres... | Mira |
|---|---|
```

---

## 3. Reglas de estilo (obligatorias en todos los docs)

1. **Español.** Toda la documentación en español. Términos técnicos (nombres de objetos, comandos, APIs) quedan en su forma original.
2. **Fechas ISO en datos volátiles.** Todo dato que caduca (estado, roadmap, decisiones, versiones) lleva fecha `AAAA-MM-DD`: "Decisiones de arquitectura (2026-06-12)", "Última revisión: 2026-07-06". Los handoffs llevan la fecha en el nombre del archivo.
3. **Sin secretos.** Ningún client secret, password, connection string, NEXTAUTH_SECRET ni token en ningún .md, aunque sea "temporal" o esté "marcado para rotar" (hay un incidente real detrás de esta regla: detalle en `devconsultia-secrets-and-config` §1). Patrón correcto: `BC_CLIENT_SECRET=<ver vault / .env.local, no versionado>`. IDs de tenant/environment/company y ClientId son aceptables si el repo es privado, pero el secret nunca. Si encuentras un secreto en un doc existente: avisa, propón rotación (runbook en `devconsultia-secrets-and-config` §2) y límpialo.
4. **Rutas relativas al repo.** En los docs escribe `src/Codeunits/...`, `docs/deployment.md` — nunca `C:\Users\...` ni rutas absolutas de una máquina concreta. Excepción: un handoff puede referenciar rutas externas al repo si es imprescindible, señalando que son locales del autor.
5. **Un repo, su cliente y nadie más.** La documentación de un repo no nombra a otros clientes de la casa ni sus entornos, tenants o incidencias. Si necesitas un ejemplo, usa uno genérico ("un repo de cliente activo", "un portal web"). Los inventarios transversales viven en el Manual interno, no en el repo.

---

## 4. Checklists

### Repo nuevo documentado (antes del primer push "serio")

- [ ] `README.md` con las 8 secciones de la plantilla (nada de "TODO: Give a short introduction").
- [ ] `CLAUDE.md` con acrónimo, rango de IDs, reglas UI (si aplica), "Qué NO tocar" y auditoría de cierre.
- [ ] Si es producto propio: `PRODUCTO.md` con roadmap fechado.
- [ ] `.gitignore` cubre `.env*`, `.alpackages/`, artefactos de build.
- [ ] Grep de secretos en los .md antes de commitear: `grep -rniE "client_secret|password\s*[:=]|NEXTAUTH_SECRET" --include="*.md" .` y revisar hits.
- [ ] Fechas ISO en toda sección de estado/decisiones.
- [ ] Ningún otro cliente nombrado en la documentación (regla 5 de estilo).

### Repo heredado por documentar

- [ ] Lee `app.json` / `package.json` / estructura para extraer stack, rango de IDs, prefijo y dependencias reales — documenta solo verdad verificada en el código.
- [ ] Sustituye el README plantilla por la plantilla de §1.1 rellenada.
- [ ] Crea `CLAUDE.md`; si no puedes deducir el prefijo/rango del código, pregunta al owner.
- [ ] Busca documentación dispersa (docs/, comentarios, .md sueltos) y consolídala o enlázala.
- [ ] Pasa el grep de secretos a TODOS los .md existentes (regla 3): reporta y limpia.
- [ ] Marca en el README lo que no pudiste verificar como "Por confirmar (AAAA-MM-DD)".

---

## 5. Prioridad de retrofit

Orden de urgencia para documentar el parque. El criterio, no la lista: el inventario nominal de qué repo está en qué grupo se mantiene en el Manual interno, fuera de esta skill.

1. **Repos de cliente activos con README plantilla.** Van primero: son los que otro tendrá que tocar sin contexto y bajo presión. Dentro del grupo, primero el repo de *dependencias* de cada cliente (si está sin documentar, rompe compilaciones ajenas) y los repos que contienen más de una app.
2. **Resto de plantillas vacías** — repos internos, productos y pruebas de concepto que siguen con el README de Azure DevOps.
3. **Repos sin README** — algunos tienen `PRODUCTO.md` pero nunca tuvieron README; añade el que falte.
4. **Productos con README pero sin CLAUDE.md**: deben ganarlo, con las reglas duras del repo.
5. **Limpieza de incidentes de secretos**: rotar y sanear cualquier secreto que siga en un `.md` versionado (máxima urgencia de seguridad, independiente del orden documental; runbook en `devconsultia-secrets-and-config` §2).

---

## Provenance y mantenimiento

- Escrita el 2026-07-06 a partir de la verificación directa de `C:\DevConsultIA-repos`: los README, CLAUDE.md, PRODUCTO.md, HANDOFF y carpetas `docs/` de referencia del parque, más el grep del README plantilla (18 repos afectados).
- Neutralizada el 2026-08-16 (REQ-000380): se retiraron los nombres de repo, de cliente y los inventarios nominales, porque esta skill se empaqueta hacia repositorios de cliente. El material retirado está íntegro en el Manual (`conocimiento/extraido/devconsultia-docs-standard.md`), que NO se empaqueta.
- Todo lo afirmado aquí sobre el estado del parque estaba verificado a 2026-07-06; al usar la skill, re-verifica antes de afirmar el estado de un repo (los repos cambian).
- Mantenimiento: cuando un grupo de la lista de retrofit quede cubierto, actualiza §5. Si aparece un CLAUDE.md o un README mejor que los actuales de referencia, actualiza las plantillas y la fecha de esta skill. No reintroduzcas nombres propios: si necesitas apuntar a un repo modelo, hazlo en el Manual interno.
- Comandos de re-verificación (PowerShell, desde `C:\DevConsultIA-repos`):

```powershell
# ¿Qué repos siguen con el README plantilla de Azure DevOps?
Get-ChildItem -Recurse -Filter README.md -Depth 2 | Select-String 'TODO: Give a short introduction' -List
# ¿Qué repos tienen CLAUDE.md?
Get-ChildItem -Recurse -Filter CLAUDE.md -Depth 2 | Select-Object FullName
# Grep de secretos en .md antes de commitear docs
Get-ChildItem -Recurse -Include *.md | Select-String -Pattern 'client_secret|password\s*[:=]|NEXTAUTH_SECRET' -List
```
