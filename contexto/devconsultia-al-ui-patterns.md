<!-- GENERADO — NO EDITAR -->

# devconsultia-al-ui-patterns

*Copia generada de `skills/devconsultia-al-ui-patterns/SKILL.md` del Manual. GENERADO — NO EDITAR:*
*si algo de aquí está mal o desactualizado, se corrige en el Manual, no aquí.*

---

---
name: devconsultia-al-ui-patterns
description: 'Patrones de UI en AL: pages, page extensions, role centers, cues, wizards, tutorial guides, tooltips. Usar al crear o revisar cualquier UI en AL. Triggers: "page", "page extension", "role center", "cue", "wizard", "tooltip", "guided setup", "factbox".'
---

# DevConsultIA — Patrones de UI en AL

Fecha: 2026-07-06. Todo el código de este documento está extraído literalmente de
repos reales de `C:\DevConsultIA-repos` (ruta de origen indicada en cada bloque).
El patrón oro es **AddonSGA / WarehouseTouch (WHT)** — su `CLAUDE.md` define las
7 reglas UX/UI del equipo.

## Cuándo NO usar esta skill

- Estándares generales de AL no-UI (naming, estructura de repo, app.json, CI) →
  usa `devconsultia-al-standard`.
- Lógica de negocio, eventos, APIs, integraciones, jobs, rendimiento →
  usa `devconsultia-al-integrations`.

---

## 1. Reglas duras (no negociables)

Verificadas contra `AddonSGA__AddonSGA\CLAUDE.md` ("Las 7 reglas UX/UI
obligatorias"). Aplícalas a cada page, page extension, campo y acción:

1. **ToolTip explicativo en español en TODOS los campos visibles y acciones.**
   Va en la capa UI (pages), no en tablas. No repitas el caption: explica qué
   hace, qué impacto tiene o cómo se calcula. En DrillDown indica qué se abre;
   en FlowField explica la fórmula. 5-10 palabras en campos triviales, 1-2
   frases en campos complejos.
2. **Caption con prefijo del acrónimo en cada page propia:**
   `Caption = '(WHT) Nombre Descriptivo';`. Aplica a List, Card, Worksheet,
   Document, ListPart, CardPart, NavigatePage, RoleCenter, Wizard y Tutorial
   Guide. NO aplica al caption del objeto pageextension (pero SÍ a los groups
   y actions que la pageextension añade).
3. **PageExtensions — campos solo en groups propios**, con `addlast(content)` y un
   `group` propio con caption `(XXX) ...`, no `addafter`/`addbefore`/
   `addlast(GrupoEstandar)` con campos sueltos: así no dependes del nombre interno de
   un control estándar, que no siempre es el que se ve (el AL0270 de §5.2).
   *Excepción verificada*: en repeaters de listas/subforms no caben groups; ahí
   se ancla a una columna estándar (`addafter(Code)`) — ver §5.3. Nota: esta
   excepción AMPLÍA la regla 7 del CLAUDE.md de AddonSGA (que no contempla
   excepciones) y está pendiente de ratificar en esa fuente canónica.
4. **Todas las acciones de pageextensions van promoted:** `Promoted = true`,
   `PromotedCategory`, `PromotedIsBig = true` (en las principales), caption con
   prefijo `(XXX)` y ToolTip en español.

Reglas complementarias del mismo CLAUDE.md (aplícalas si el módulo lo pide):
Role Center dedicado + profile (§2), wizard de configuración registrado en
Guided Experience (§3), tutorial guide integrada (§4), tabla Cue + CardPart por
módulo (§2.3). Si falta el acrónimo de la app, pregúntalo antes de codificar.

---

## 2. Role Center completo (patrón AddonSGA)

Estructura: page RoleCenter + profile + (tabla Cue + page CardPart) por módulo,
en `src/RoleCenter/` y `src/Cues/`.

### 2.1 Page RoleCenter

Cues en `area(rolecenter)`; un `group` por módulo funcional en `area(sections)`
(pages funcionales primero, Configuración/Tutorial/Wizard al final); accesos
frecuentes duplicados en `area(embedding)`. Cada action lleva Caption `(XXX)`,
`Image`, `RunObject` y ToolTip.

Fuente: `AddonSGA__AddonSGA\src\RoleCenter\WHTWarehouseRoleCenter.Page.al`
— **código completo en [`references/role-center.al.md`](references/role-center.al.md)**. Extracto:

```al
page 50750 "WHT Warehouse Role Center"
{
    PageType = RoleCenter;
    Caption = '(WHT) WarehouseTouch - Centro de Almacén';

    layout
    {
        area(rolecenter)
        {
            part(ReceiveCues; "WHT Receive Cues") { ApplicationArea = All; }
            part(OperatorCues; "WHT Operator Cues") { ApplicationArea = All; }
        }
    }
    // actions: area(sections) con un group por módulo (Caption '(WHT) ...',
    // Image, RunObject, ToolTip) + area(embedding) — ver fichero de referencia.
}
```

### 2.2 Profile

Fuente: `AddonSGA__AddonSGA\src\RoleCenter\WHTWarehouse.Profile.al` (completo):

```al
profile "WHT-WAREHOUSE"
{
    Caption = '(WHT) Operario de Almacén';
    ProfileDescription = 'Rol dedicado a las operaciones del sistema WarehouseTouch: recepción por escaneo, gestión de operarios, KPIs de almacén y asistente de configuración.';
    RoleCenter = "WHT Warehouse Role Center";
    Enabled = true;
    Promoted = true;
}
```

### 2.3 Cues: tabla + CardPart

Por módulo: tabla Cue de registro único con KPIs como FlowField
(`Editable = false`, `DataClassification = SystemMetadata`) + page CardPart con
`RefreshOnActivate = true`, `cuegroup`s de 2-5 fields, cada field con
`DrillDownPageId` obligatorio, `Style` según semáforo y ToolTip.

Fuente: `AddonSGA__AddonSGA\src\Cues\WHTReceiveCue.Table.al` y
`WHTReceiveCues.Page.al` — **tabla y CardPart completas en
[`references/cues.al.md`](references/cues.al.md)**. Extracto de un cue field:

```al
cuegroup(ReceivingWork)
{
    Caption = 'Trabajo Pendiente';

    field("Lines Pending Receipt"; Rec."Lines Pending Receipt")
    {
        ApplicationArea = All;
        Caption = 'Líneas Pendientes';
        Style = Attention;
        DrillDownPageId = "WHT Pending Receipt Lines";
        ToolTip = 'Total de líneas de pedidos de compra con cantidad pendiente de recibir. Es la carga real de trabajo del almacén. Pulsa para ver el detalle línea a línea.';
    }
}
```

El `OnOpenPage` que auto-crea el registro único es obligatorio: sin él la
CardPart revienta en instalaciones nuevas.

---

## 3. Guided setup / wizard de configuración

Patrón real y completo en
`AddonSGA__AddonSGA\src\Wizard\WHTAssistedSetupWizard.Page.al`:

- `PageType = NavigatePage`, `SourceTable` = tabla Setup (singleton),
  `InsertAllowed = false; DeleteAllowed = false;`.
- Variable `Step: Integer` + `TotalSteps` fijada en `OnInit`. Cada paso es un
  `group` con `Visible = (Step = N)` e `InstructionalText`.
- Acciones Back/Next/Finish con `InFooterBar = true` y `Visible` correctos.

**Código completo (wizard + registro en Guided Experience) en
[`references/wizard.al.md`](references/wizard.al.md)**. Extracto de un paso y del cierre:

```al
group(Step2General)
{
    Caption = 'Paso 2: General';
    Visible = (Step = 2);
    InstructionalText = 'Define qué almacén usarán las páginas táctiles...';
    field("Default Location Code"; Rec."Default Location Code") { ApplicationArea = All; ToolTip = '...'; }
}

trigger OnOpenPage()
begin
    Rec.GetSingleton(); // canon (devconsultia-al-standard §4.1). El código real de
    Rec.Get('');        // AddonSGA añade este Get('') REDUNDANTE — no lo copies.
    Step := 1;
end;
```

Registro en Guided Experience + tabla de tracking de completado
(`WHT Tutorial Setup` con `Wizard Completed`, `Wizard Completed DateTime`,
`Wizard Completed By`). Fuente:
`AddonSGA__AddonSGA\src\Tutorial\WHTTutorialMgmt.Codeunit.al`:
subscriber a `Guided Experience.OnRegisterAssistedSetup` que llama a
`GuidedExperience.InsertAssistedSetup(...)` + procedure `MarkWizardCompleted()` —
código completo en [`references/wizard.al.md`](references/wizard.al.md).

El mismo trío (wizard + TutorialMgmt + TutorialSetup) existe en SecurIA
(`SMPTutorialMgmt`), InformIA (`FINTutorialMgmt`), TaxIA (`TIATutorialMgmt`) y
VentIA (`VENTutorialMgmt`): es patrón de plataforma, replícalo con el acrónimo
de la app.

---

## 4. Tutorial guide (guía de usuario integrada)

Page tipo Card, solo lectura, `UsageCategory = Documents`, registrada en el
menú del Role Center. Un grupo colapsable por módulo con `InstructionalText`,
labels `Style = Strong` para pasos y `Style = Subordinate` para tips, más una
sección "Inicio Rápido" con 3-6 pasos.

Fuente: `AddonSGA__AddonSGA\src\Tutorial\WHTTutorialGuide.Page.al` —
**código completo en [`references/tutorial.al.md`](references/tutorial.al.md)**. Extracto:

```al
page 50720 "WHT Tutorial Guide"
{
    Caption = '(WHT) Guía del Sistema';
    PageType = Card;
    Editable = false;
    UsageCategory = Documents;
    // Un group por módulo:
    group(ModReceiving)
    {
        Caption = 'Módulo: Recepción de Compras';
        InstructionalText = 'Permite registrar entradas de mercancía contra pedidos de compra...';
        label(Recv_Step1) { Caption = 'Paso 1: Abre "(WHT) Recepción - Pedidos Abiertos"...'; Style = Strong; ApplicationArea = All; }
        label(Recv_Detail1) { Caption = 'Verás todos los pedidos...'; Style = Subordinate; ApplicationArea = All; }
    }
}
```

Regla de mantenimiento (CLAUDE.md de AddonSGA): si añades un módulo, añádelo a
la Tutorial Guide.

---

## 5. Listas, cards y page extensions

### 5.1 List + Card

Lista con `CardPageId`, `RefreshOnActivate = true`, ToolTip en cada columna,
`Style = Strong` en la clave, columnas secundarias con `Visible = false`, y
acciones promoted. Fuente: `AddonSGA__AddonSGA\src\Operator\WHTOperators.Page.al` —
**código completo en [`references/list-card.al.md`](references/list-card.al.md)**. Extracto:

```al
page 50740 "WHT Operators"
{
    Caption = '(WHT) Operarios';
    PageType = List;
    SourceTable = "WHT Operator";
    CardPageId = "WHT Operator Card";
    RefreshOnActivate = true;
    // repeater: clave con Style = Strong + ToolTip; secundarias Visible = false.
    // actions: Promoted = true, PromotedCategory, PromotedIsBig en las principales,
    // caption '(WHT) ...' y ToolTip — ver fichero de referencia.
}
```

Ejemplos equivalentes: `TaxIA__TaxIA\al\src\Pages\TIAModels.Page.al` +
`TIAModelCard.Page.al`; `SecurIA__SecurIA\src\Pages\SMPSoDRules.Page.al` +
`SMPSoDRuleCard.Page.al`.

### 5.2 PageExtension de card: group propio con `addlast(Content)`

Fuente: `VentIA__VentIAAL\src\PageExtensions\VENItemCardExt.PageExt.al`. El
comentario original documenta el porqué de la regla. (Nota: el caption
`(VentIA)` con el nombre completo es legado de VentIA; el estándar para apps
nuevas es el acrónimo de 3 letras: `(VEN)`.)

```al
pageextension 50955 "VEN Item Card Ext" extends "Item Card"
{
    layout
    {
        // addlast(Content) con group propio (regla 7): no dependemos del nombre
        // de un control estandar (el grupo "General" de Item Card en realidad se
        // llama 'Item', por eso addlast(General) daba AL0270).
        addlast(Content)
        {
            group(VENPortal)
            {
                Caption = '(VentIA) Portal';

                field("VEN Image URL"; Rec."VEN Image URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'URL publica de la imagen del producto. Se replica al cache de catalogo y la pinta el portal en ItemRow / ProductGallery.';
                }
            }
            // Groups propios también sirven para embeber ListParts relacionadas:
            group(VENPortalGallery)
            {
                Caption = '(VentIA) Galería de imágenes (web)';

                part(VENPortalImages; "VEN Portal Item Images")
                {
                    ApplicationArea = All;
                    Caption = 'Imágenes adicionales';
                    SubPageLink = "Item No." = field("No.");
                    UpdatePropagation = Both;
                }
            }
        }
    }
}
```

### 5.3 PageExtension de lista (repeater): la excepción documentada

En repeaters no caben groups. Ancla a la primera columna estándar (siempre
presente) y mantén el resto de reglas (ToolTip, actions promoted con prefijo).
Nota: esta excepción amplía la regla 7 del CLAUDE.md de AddonSGA (que no
contempla excepciones); pendiente de ratificar en esa fuente canónica.
Fuente: `VentIA__VentIAAL\src\PageExtensions\VENItemVariantsExt.PageExt.al`:

```al
// addafter(Code): anclamos a la primera columna estándar (siempre presente).
pageextension 51017 "VEN Item Variants Ext" extends "Item Variants"
{
    layout
    {
        addafter(Code)
        {
            field("VEN Visible On Web"; Rec."VEN Visible On Web")
            {
                ApplicationArea = All;
                ToolTip = 'Si está marcado, esta variante aparece en el portal. Desmárcalo para ocultarla del portal sin bloquearla en BC.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(VENVariantWebImages)
            {
                ApplicationArea = All;
                Caption = '(VentIA) Imágenes web';
                ToolTip = 'Gestiona la galería de imágenes que el portal muestra cuando el cliente selecciona esta variante.';
                Image = Picture;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "VEN Portal Variant Images";
                RunPageLink = "Item No." = field("Item No."), "Variant Code" = field(Code);
            }
        }
    }
}
```

### 5.4 Worksheet con filtros de cabecera + matriz (visor / dashboard)

Para visores tipo matriz usa `PageType = Worksheet`, página no editable
(`Editable = false; Insert/Delete/ModifyAllowed = false;`), un `group` de
parámetros arriba (cada field con `trigger OnValidate()` que recalcula) y un
`repeater` con `StyleExpr`, `BlankZero`, `IndentationColumn` y `OnDrillDown`
por celda. Ejemplos reales completos:

- `InformIA__InformIA\al\src\Pages\FINReportViewer.Page.al` — visor de informes
  financieros: buffer temporal (`SourceTableTemporary = true`), selección de
  informe/layout/periodo/dimensiones, drill-down a movimientos por columna.
- `SecurIA__SecurIA\src\Pages\SMPPermissionMatrix.Page.al` — matriz usuarios ×
  procesos: 12 columnas con `CaptionClass` dinámico (`'SMPMATRIX,1'`),
  `Visible = ColNVisible`, `StyleExpr` por celda, paginación de columnas con
  acciones "Usuarios anteriores/siguientes" y `RefreshOnActivate = true`.

### 5.5 FactBoxes

`area(FactBoxes)` con `part(...)` y `SubPageLink`. Ejemplos reales en
`SupplyChainPlanning__SupplyChainPlanning\src\page\` (p. ej.
`Pag64168.SCPItemRelationshipCard.al`) y
`AprobacionPagos__AprobacionPagos\src\page\Pag75100.ApprovalLinesList.al`.
Las apps *IA nuevas apenas los usan; no son obligatorios, pero si los añades
cada part necesita caption y la page contenedora ToolTips normales.

---

## 6. Decisión: Role Center propio vs extender el estándar

Hoy conviven ambos patrones en producción — elige, no mezcles sin motivo:

**Crea Role Center propio** (patrón AddonSGA §2, también SecurIA `SMPRoleCenter`,
InformIA `FINRoleCenter`, TaxIA `TIARoleCenter`) cuando:
- La app define un rol de trabajo completo (operario de almacén, admin de
  seguridad, analista fiscal) que vive todo el día dentro de la app.
- Las cues contienen datos sensibles o requieren permisos propios. Caso real
  documentado en `SecurIA__SecurIA\src\PageExtensions\SMPBusinessManagerRC.PageExt.al`:

```al
// Nota: las pilas de Cues NO se anaden aqui a proposito. Contienen datos sensibles
// de seguridad (conteos de violaciones SoD con usuarios) y calcular sus FlowFields
// requiere permiso de lectura sobre las tablas SMP: un manager sin permisos SMP veria
// un error en su Role Center. Las Cues viven en el "SMP Role Center" (perfil SMP-ADMIN),
// donde el administrador si tiene permisos. Aqui solo el menu de navegacion (se valida al pulsar).
```

**Extiende el Business Manager Role Center (page estándar)** cuando la app es
transversal y sus usuarios ya viven en el RC genérico:
- Carriers añade solo parts de cues con `addafter("User Tasks Activities")`
  (`Carriers__Carriers\src\pageextension\Pag-Ext50755.BusinessManagerRoleCenterEstWS.al`).
- VentIA añade cues con `addlast(rolecenter)` y un group de navegación completo
  con `addlast(Sections)` (`VentIA__VentIAAL\src\PageExtensions\VENBusMgrRCExt.PageExt.al`):

```al
pageextension 50958 "VEN BusMgr RC Ext" extends "Business Manager Role Center"
{
    layout
    {
        addlast(rolecenter)
        {
            part(VENAtencion; "VEN Main Cues")
            {
                Caption = 'VentIA - Atención';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addlast(Sections)
        {
            group(VENGroup)
            {
                Caption = 'VentIA';
                Image = Sales;

                action(VENGuide)
                {
                    ApplicationArea = All;
                    Caption = '(VentIA) Guía del sistema';
                    Image = Info;
                    RunObject = page "VEN Tutorial Guide";
                    ToolTip = 'Guía completa del sistema con la explicación de cada módulo y los pasos para configurarlo.';
                }
            }
        }
    }
}
```

**Patrón híbrido válido** (SecurIA): Role Center propio con cues + extensión
del Business Manager RC solo con el menú de navegación. Da acceso desde ambos
mundos sin exponer datos sensibles.

En `area(Sections)` del RC estándar el ancla es `addlast(Sections)` (S
mayúscula); en layout es `addlast(rolecenter)`.

---

## 7. Checklist UI para revisar una PR

Deriva del bloque "Auditoría obligatoria" de `AddonSGA__AddonSGA\CLAUDE.md`.
Rechaza la PR si falla cualquiera:

1. ¿Cada campo visible y cada acción nuevos tienen ToolTip en español que
   explica (no repite el caption)?
2. ¿Cada page nueva tiene `Caption = '(XXX) ...'` con el acrónimo de la app?
3. ¿Las pageextensions añaden campos solo dentro de groups propios con caption
   `(XXX)` vía `addlast(Content)`? (Excepción: repeaters de lista, anclados a
   columna estándar — §5.3.)
4. ¿Todas las acciones de pageextensions llevan `Promoted = true` +
   `PromotedCategory` (+ `PromotedIsBig` en las principales) y caption `(XXX)`?
5. Si se añadió un módulo: ¿tiene tabla Cue + CardPart y la CardPart está en
   `area(rolecenter)` del Role Center?
6. Si se añadió una page funcional: ¿está en el group de su módulo en el menú
   del Role Center (y en `area(embedding)` si es de uso frecuente)?
7. Si se añadió un campo de setup: ¿está en el paso correspondiente del wizard?
8. Si se añadió un módulo: ¿está documentado en la Tutorial Guide?
9. ¿Cada cue field tiene `DrillDownPageId` y `Style` coherente
   (Unfavorable/Attention/Favorable)? ¿La CardPart tiene
   `RefreshOnActivate = true` y auto-crea el registro en `OnOpenPage`?
10. ¿Los mensajes de error/UI son `Label` con `Comment` para traducción y no
    literales inline?

---

## Provenance y mantenimiento

Verificado el 2026-07-06 leyendo los ficheros citados en `C:\DevConsultIA-repos`.
Repos estudiados: `AddonSGA__AddonSGA` (patrón oro, CLAUDE.md + Role Center +
cues + wizard + tutorial), `SecurIA__SecurIA` (Permission Matrix, RC híbrido),
`InformIA__InformIA` (visor de informes), `VentIA__VentIAAL` (pageextensions y
RC extendido), `TaxIA__TaxIA` (mismo esqueleto *IA), `Carriers__Carriers`
(extensión mínima del Business Manager RC).

Comandos de re-verificación (PowerShell con ripgrep, desde `C:\DevConsultIA-repos`):

```powershell
# Reglas duras del equipo (fuente canónica)
Get-Content .\AddonSGA__AddonSGA\CLAUDE.md

# ¿Siguen existiendo los ficheros de referencia?
rg --files -g "*.al" .\AddonSGA__AddonSGA\src\RoleCenter .\AddonSGA__AddonSGA\src\Cues .\AddonSGA__AddonSGA\src\Wizard .\AddonSGA__AddonSGA\src\Tutorial

# Quién crea Role Center propio hoy
rg -l "PageType = RoleCenter" -g "*.al"

# Quién extiende el Business Manager RC hoy
rg -l "extends `"Business Manager Role Center`"" -g "*.al"

# Vigencia de la regla de groups propios en pageextensions
rg -l "addlast\(content\)" -i -g "*.al"

# Wizards registrados en Guided Experience
rg -l "OnRegisterAssistedSetup" -g "*.al"
```

Si un comando deja de devolver los ficheros citados, actualiza la sección
afectada con el nuevo código real antes de seguir usando esta skill.
