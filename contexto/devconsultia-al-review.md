<!-- GENERADO — NO EDITAR -->

# devconsultia-al-review

*Copia generada de `skills/devconsultia-al-review/SKILL.md` del Manual. GENERADO — NO EDITAR:*
*si algo de aquí está mal o desactualizado, se corrige en el Manual, no aquí.*

---

---
name: devconsultia-al-review
description: 'Revisión de código AL con BCQuality (330 artículos MS con ejemplo malo/bueno: rendimiento, seguridad, privacidad, upgrade, eventos, UI). Usar para auditorías o code review AL, no para escribir código nuevo. Triggers: "revisa esta app AL", "code review AL", "auditoría de calidad", "BCQuality".'
---

# Revisar AL con BCQuality

**Fecha:** 2026-09-23 (REQ-000837). BCQuality es de Microsoft, licencia MIT, y está clonado en
`C:\DevConsultIA-repos\Microsoft__BCQuality` (remoto: `github.com/microsoft/BCQuality`).
No es un analizador ni un ejecutable: es conocimiento y un protocolo que el agente lee y sigue.
No repite lo que ya detectan el compilador y los analizadores (CodeCop, AppSourceCop…).

## Antes de empezar

- Pon el clon al día: `git -C C:\DevConsultIA-repos\Microsoft__BCQuality pull --ff-only`.
- La revisión es **de solo lectura** sobre la app: no se toca el código hasta que alguien decida
  qué hallazgos se arreglan.

## Cómo se lanza

Pide a un subagente (o hazlo tú) exactamente esto, cambiando la carpeta y la versión de BC
(sale de `application` en el `app.json`; si no se sabe, se omite):

```text
BCQuality root: C:\DevConsultIA-repos\Microsoft__BCQuality
Review input: folder-path = C:\DevConsultIA-repos\<Carpeta de la app>

Read BCQuality's skills\entry.md and follow it with this task context:
task-context:
  goal: Review the complete AL app without changing its source files.
  inputs-available: [folder-path]
  technologies: [al]
  bc-version: <27, 28...>
  enabled-layers: [microsoft, community, custom]
  disabled-skills: []

Resolve BCQuality instructions, knowledge, and index preparation against the BCQuality root,
not the app directory (index: pwsh C:\DevConsultIA-repos\Microsoft__BCQuality\tools\Build-KnowledgeIndex.ps1).
Execute every dispatched action skill with its exact input subset. Return each findings report
unchanged. Ignore the .alpackages folder.
```

Para revisar **solo un cambio**, `inputs-available: [pr-diff]` con el diff; para **un tema**,
dilo en `goal` ("review performance only"). Es mucho más barato que la app entera.

## Qué esperar (medido en FactorIA, 170 ficheros)

- **Coste: 15–20 min y unos 2,7 M de tokens** para la app completa (19 dominios, un subagente
  por dominio). Es una auditoría, no algo para cada PR. Para PR: diff o un solo dominio.
- **105 hallazgos**: unos 35–40 reales y accionables, unos 40 de higiene barata (estilo, UI,
  `DataAccessIntent`), 10–15 ruido. Ninguna referencia inventada.
- **Lo más valioso: seguridad, privacidad, modelo de datos, SCM, permisos y rendimiento.**
  Encontró una suplantación de PIN, un descarte contabilizado dos veces y usuarios bloqueados.
- **Los hallazgos que el agente saca por su cuenta (sin artículo) salen como *minor* como
  mucho, y fueron de los mejores** (la suplantación de PIN era uno). **No filtres por
  gravedad**: lee también los *minor* de seguridad y de datos.
- Upgrade y breaking-changes rinden poco sobre una carpeta suelta (no hay versión anterior con
  la que comparar).

## Cómo se entrega

1. Guarda el informe en bruto y un resumen priorizado **en el repo de la app**:
   `docs/revisiones/bcquality-<fecha>.report.json` y `.md` (la carpeta temporal se borra).
2. En el resumen, separa: **arreglar ya** (comprobado contra el código), **correcto pero de
   prioridad baja**, y **no aplicar sin pensar** (hallazgos que rompen un contrato: ids de API
   que usa un BFF, errores que son contrato, cambios OnPrem/SaaS deliberados).
3. Cada arreglo, en su petición y su PR. Nunca "arreglar los 105" de golpe.

## Trampas del primer uso

- Entry es texto, no un script: el registro de despacho lo monta el agente.
- En Windows, las barras invertidas de las rutas rompen los JSON que escriben los subagentes;
  que escriban rutas con `/`.
- El índice (`Build-KnowledgeIndex.ps1`) se genera en el clon y está en su `.gitignore`: el clon
  no queda sucio.

## Nuestras reglas en la capa `custom` (pendiente)

BCQuality tiene una capa `custom/` para reglas de la casa. Candidatas, todas ya pagadas:
`resourceExposurePolicy` abierta en apps nuestras, `RDLCLayout` con ruta mal puesta (compila y
sale en blanco), `RoleID` de más de 20 caracteres en permission sets XML, versión subida después
de compilar, `ForceSync` en `launch.json`, y escrituras de caché dentro de la transacción de
registro del cliente. Irían en un fork nuestro en Azure DevOps.
