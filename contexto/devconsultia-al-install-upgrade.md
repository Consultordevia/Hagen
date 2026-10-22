<!-- GENERADO — NO EDITAR -->

# devconsultia-al-install-upgrade

*Copia generada de `skills/devconsultia-al-install-upgrade/SKILL.md` del Manual. GENERADO — NO EDITAR:*
*si algo de aquí está mal o desactualizado, se corrige en el Manual, no aquí.*

---

---
name: devconsultia-al-install-upgrade
description: 'Ciclo de vida de datos de una app AL: install/upgrade codeunit, seed de datos, numeradores y puesta en marcha en cliente. Usar al instalar, migrar datos o dar de alta una app AL. Triggers: "install codeunit", "upgrade", "seed", "ObsoleteState", "migración de datos", "numeradores".'
---

# Install, upgrade y ciclo de vida de datos (DevConsultIA)

**Fecha:** 2026-07-06 · **Audiencia:** desarrollador AL mid-level.
Runbook basado en el código real del portfolio: TaxIA, SecurIA, VentIA (VentIAAL),
MasterDataIA, SupplyChainPlanning y MonitorizaciónJobQueue.

## Cuándo NO usar esta skill

- Estándares generales de codificación AL (naming, ToolTips, page extensions,
  estructura de objetos) → usa `devconsultia-al-standard`.
- Lógica de negocio, integraciones o UI que no toquen instalación/migración de datos.

---

## 1. Install codeunit canónica

Toda app con tablas propias lleva install codeunit desde la v1.0 (qué pasa sin ella:
sección 4). Reglas:

1. `Subtype = Install`. Un solo objeto por app, nombre `<PREFIJO> Install`.
2. **Idempotente siempre**: el trigger corre en cada instalación *y en cada
   reinstalación/actualización de la app*. Guard con `IsEmpty()` / `Get()` antes
   de insertar; nunca insertar a ciegas.
3. La lógica de seed va en un `procedure` público (`Seed()` / `SeedTemplates()`),
   no dentro del trigger: así se puede relanzar desde una acción de la página de
   setup o desde el retrofit (sección 4).
4. `Access = Internal` y `Permissions = tabledata ... = RIM` cuando la app tiene
   permission sets restrictivos (patrón real de SecurIA `SMP Install`).

### PerCompany vs PerDatabase — criterio

| Trigger | Cuándo | Ejemplos reales |
|---|---|---|
| `OnInstallAppPerCompany()` | Los datos son por empresa: setup singleton por empresa, plantillas, numeradores, job queues. **Es el caso por defecto.** Corre una vez por cada empresa (incluidas las creadas después). | `TIA Install` (TaxIA), `VEN Install` (VentIA), `JQM Install`, `Virtual Followup Install` (SupplyChainPlanning) |
| `OnInstallAppPerDatabase()` | Los datos son de ámbito BD: la app trabaja **cruzando empresas** o con tablas `DataPerCompany = false`. Corre una sola vez por tenant. | `MDIA Install` (MasterDataIA: recorre `Record Company` y da de alta cada empresa en `MDIA Company`), `SMP Install` (SecurIA: procesos de negocio y reglas SoD sobre permisos, que son de BD) |

La divergencia SecurIA/TaxIA no es una inconsistencia: SecurIA modela permisos
(objetos a nivel de base de datos) y MasterDataIA sincroniza entre empresas.
Si dudas, usa PerCompany: PerDatabase corre en un contexto sin empresa activa y
un `Record` normal (DataPerCompany=true) tocado ahí falla o toca la empresa equivocada.

### Plantilla canónica (copiar y adaptar prefijo/IDs)

```al
codeunit 50100 "APP Install"
{
    Subtype = Install;
    Access = Internal;
    Permissions = tabledata "APP Setup" = RIM,
                  tabledata "APP Template" = RIM;

    trigger OnInstallAppPerCompany()
    var
        Template: Record "APP Template";
    begin
        // Guard de idempotencia: solo sembrar si no hay datos.
        // Corre también al ACTUALIZAR la app: sin guard, duplicarías datos.
        if Template.IsEmpty() then
            Seed();
        EnsureSetup();
        EnsureNoSeries('APP-DOC', 'APP Documentos', 'DOC0000001'); // ver sección 3
    end;

    /// <summary>Crea setup y datos semilla (idempotente). Relanzable desde la página de setup.</summary>
    procedure Seed()
    begin
        AddTemplate('PLANTILLA1', 'Descripción plantilla 1', 10);
        AddTemplate('PLANTILLA2', 'Descripción plantilla 2', 20);
    end;

    local procedure EnsureSetup()
    var
        Setup: Record "APP Setup";
    begin
        // GetSingleton() es el método CANÓNICO del setup singleton (ver
        // devconsultia-al-standard §4.1): crea el registro si no existe y deja
        // Rec posicionado. OJO: AddonSGA añade un Setup.Get('') extra tras
        // GetSingleton() — es redundante, no lo copies.
        Setup.GetSingleton();
    end;

    local procedure AddTemplate(TemplCode: Code[20]; Desc: Text[100]; Sort: Integer)
    var
        Template: Record "APP Template";
    begin
        if Template.Get(TemplCode) then
            exit; // no pisar cambios del cliente
        Template.Init();
        Template.Code := TemplCode;
        Template.Description := Desc;
        Template."Sort Order" := Sort;
        Template.Insert();
    end;
}
```

Dos estilos de guard vistos en el portfolio, elige según el dato:

- **No pisar al cliente** (`if Get() then exit;`): datos que el cliente edita
  (procesos SecurIA, plantillas). Es el estilo por defecto.
- **Delete + reinsert** (`TIA Install.InsModel`): catálogos que la app posee por
  completo (casillas del 303) y quieres poder recargar con `SeedTemplates()`.
  Solo válido si machacar la personalización es aceptable y está documentado.

### Job queue en install (patrón SupplyChainPlanning)

Si la app necesita un proceso planificado, créalo en install **en `On Hold`**
para que el admin lo active conscientemente:

```al
JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
JobQueueEntry.SetRange("Object ID to Run", Codeunit::"APP Nightly Process");
if not JobQueueEntry.IsEmpty() then
    exit; // guard: no duplicar en reinstalaciones
JobQueueEntry.Init();
JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
JobQueueEntry."Object ID to Run" := Codeunit::"APP Nightly Process";
JobQueueEntry."Recurring Job" := true;
// ... días y ventana horaria ...
JobQueueEntry.Status := JobQueueEntry.Status::"On Hold"; // el admin lo activa
JobQueueEntry.Insert(true);
```

(`JQM Install.SchedulePollingJob` muestra la variante que sí arranca el job con
`Codeunit.Run(Codeunit::"Job Queue - Enqueue", ...)` — úsala solo cuando el
polling es la razón de ser de la app.)

---

## 2. Upgrade codeunit canónica

Crea la upgrade codeunit **en la v1.0, vacía**, aunque aún no migre nada.
Motivos verificados en VentIA (`VEN Portal Upgrade`, cod. 51009, el upgrade con tags
que sirve de canon):

- El día que añadas un campo con `InitValue`, descubrirás que **InitValue solo
  aplica a registros NUEVOS**: las filas existentes quedan en `false`/`0` y el
  comportamiento cambia en silencio (en VentIA, las variantes existentes
  desaparecían del portal y el umbral de stock del setup quedaba a 0).
- Si la codeunit ya existe con su gemela de tags, añadir una migración es añadir
  un bloque de 4 líneas, no diseñar infraestructura bajo presión de un deploy roto.

### Patrón de upgrade tags (dos objetos, siempre en pareja)

```al
codeunit 50101 "APP Upgrade"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        UpgradeTag: Codeunit "Upgrade Tag";
    begin
        // Un bloque por migración. Cada bloque corre UNA vez por empresa.
        if not UpgradeTag.HasUpgradeTag(MyFieldInitTag()) then begin
            InitMyField();
            UpgradeTag.SetUpgradeTag(MyFieldInitTag());
        end;
    end;

    local procedure InitMyField()
    var
        Rec: Record "APP Header";
    begin
        // Ejemplo real (VentIA InitVariantVisibleOnWeb): campo nuevo opt-out con
        // InitValue=true -> las filas EXISTENTES quedaron en false; las marcamos.
        Rec.SetRange("New Boolean Field", false);
        if not Rec.IsEmpty() then
            Rec.ModifyAll("New Boolean Field", true); // sin triggers: volcado de campo
    end;

    local procedure MyFieldInitTag(): Code[250]
    begin
        exit('APP-MyField-Init-1.1'); // literal único: nombre + versión que lo introduce
    end;
}
```

```al
codeunit 50102 "APP Upgrade Tags"
{
    Access = Public;

    // Registra aquí cada tag que se sella con SetUpgradeTag.
    // Sin este registro, BC no "conoce" el tag: en empresas nuevas no queda
    // sellado automáticamente y el bloque de upgrade vuelve a evaluarse.
    // Misma cadena literal que en "APP Upgrade": si divergen, el tag no se reconoce.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Upgrade Tag", 'OnGetPerCompanyUpgradeTags', '', false, false)]
    local procedure RegisterPerCompanyUpgradeTags(var PerCompanyUpgradeTags: List of [Code[250]])
    begin
        PerCompanyUpgradeTags.Add('APP-MyField-Init-1.1');
    end;
}
```

Reglas extraídas de `VENPortalUpgrade.Codeunit.al` / `VENPortalUpgradeTags.Codeunit.al`:

1. Un tag = una migración = un bloque `HasUpgradeTag → Init → SetUpgradeTag`.
   Nunca reutilices un tag para una segunda migración.
2. El literal del tag incluye app, qué inicializa y versión
   (`'VEN-Portal-VentIAEnabled-Init-0.50'`).
3. `Modify(false)` / `ModifyAll(..., false)` en migraciones: es volcado de datos,
   no dispares subscribers ni validaciones.
4. Si la migración hace `Modify` dentro del bucle, usa `FindSet(true)`.
5. Migraciones de singleton de setup: comprueba el valor antes de pisarlo
   (`if Setup."Stock Display Threshold" = 0 then ...`) — no machaques un valor
   intencionado.
6. Condiciona la migración al uso real cuando activa comportamiento: VentIA solo
   activa `"VentIA Enabled"` en empresas que ya tienen credenciales de portal
   (`if Credential.IsEmpty() then exit;`), para no encender la app en empresas
   que no la usan.

A 2026-09-24 hay upgrade codeunits en más de diez apps del portfolio, sin revisar
contra este canon. Una de ellas diverge de forma documentada (verificado 2026-07-07; el
caso concreto está en la skill de su ámbito): un upgrade codeunit PerCompany, con su pareja
de install, que gatea cada migración por `ModuleInfo.DataVersion` en vez de upgrade tags (cero usos de
`Upgrade Tag`). Funciona, pero para apps nuevas usa el patrón de tags de esta
sección: los tags sobreviven a saltos de versión y quedan sellados en empresas
nuevas; con DataVersion hay que razonar rangos de versión en cada release.

---

## 3. Numeradores (No. Series) — patrón EnsureNoSeries

Patrón real de `VEN Install` (VentIA, cod. 50921). Crea el numerador en install
para que el primer uso no falle por configuración manual pendiente, pero
**respeta la línea si el cliente ya configuró una**:

```al
local procedure EnsureNoSeries(SeriesCode: Code[20]; Description: Text[100]; StartingNo: Code[20])
var
    NoSeries: Record "No. Series";
    NoSeriesLine: Record "No. Series Line";
begin
    if not NoSeries.Get(SeriesCode) then begin
        NoSeries.Init();
        NoSeries.Code := SeriesCode;
        NoSeries.Description := Description;
        NoSeries."Default Nos." := true;
        NoSeries."Manual Nos." := false;
        NoSeries."Date Order" := false;
        NoSeries.Insert(true);
    end;

    NoSeriesLine.SetRange("Series Code", SeriesCode);
    if NoSeriesLine.IsEmpty() then begin
        NoSeriesLine.Init();
        NoSeriesLine."Series Code" := SeriesCode;
        NoSeriesLine."Line No." := 10000;
        NoSeriesLine."Starting Date" := Today;
        NoSeriesLine."Starting No." := StartingNo;
        NoSeriesLine."Increment-by No." := 1;
        NoSeriesLine.Insert(true);
    end;
end;
```

Llamada desde `OnInstallAppPerCompany()`:
`EnsureNoSeries('VEN-CART', 'VentIA Carts', 'CART000001');`
Código de serie con prefijo de la app; Starting No. con prefijo alfabético + relleno de ceros.
Guarda el código de la serie en el campo correspondiente de la setup table si la
app lo referencia por configuración.

---

## 4. El hueco del portfolio: apps sin install codeunit

Verificado a fecha 2026-07-06 y de nuevo el 2026-09-24 (ver comandos en Provenance): estas apps tienen
código AL propio y **cero codeunits `Subtype = Install` o `Upgrade`**:

| App | .al | App | .al |
|---|---|---|---|
| Carriers | 89 | AprobacionPagos | 49 |
| EDI | 64 | Bc to Drive | 118 |
| ImportadorAvanzado | 35 | GestionEmails | 34 |
| Confirming | 8 | PrintNode | 8 |

**Riesgo real:** setup tables que dependen de que alguien entre a la página y
provoque el `insert` del singleton; numeradores/jobs creados a mano (distintos
en cada cliente, indocumentados); primer uso que falla en empresa nueva; y —el
peor— cuando haya que añadir un campo con InitValue o migrar datos, no existe
infraestructura de upgrade y la migración se improvisa (exactamente el escenario
que VentIA tuvo que resolver a posteriori en el pack 0.43.0).

**Cómo retrofitear sin romper clientes existentes:**

1. Añade `<PFX> Install` con la plantilla de la sección 1. Al desplegar la nueva
   versión en un cliente existente, **`OnInstallAppPerCompany` SÍ se ejecuta**
   (corre en cada instalación de versión nueva): los guards de idempotencia no
   son opcionales — `IsEmpty()` sobre datos que el cliente ya tiene poblados,
   `Get()` antes de cada insert, `GetSingleton()` para el setup.
2. No incluyas en el seed nada que el cliente pueda haber creado a mano con otro
   código (numeradores, jobs): usa exactamente los patrones Ensure de las
   secciones 1 y 3, que se retiran si ya existe algo.
3. Añade en el mismo PR la pareja `<PFX> Upgrade` + `<PFX> Upgrade Tags`, aunque
   queden vacías (sección 2).
4. Prueba las tres rutas antes de publicar: instalación limpia, actualización
   sobre datos existentes, y creación de empresa nueva con la app ya instalada.

---

## 5. Setup en cliente: checklist de puesta en marcha

Tras instalar la app en el tenant del cliente, en orden:

1. **Instalación**: sube la .app (admin center / VS Code `Publish` en on-prem) y
   verifica en *Extension Management* que la versión es la esperada. Revisa
   *Extension Installation Status* si hubo error de install/upgrade codeunit.
2. **Permisos**: asigna el permission set de la app a los usuarios (o al grupo).
   Si la install codeunit tiene `Permissions = tabledata...`, el seed no depende
   de los permisos del usuario instalador, pero el uso diario sí de los del usuario.
3. **Setup table**: abre la página de setup de la app y completa los campos que
   el install deja vacíos a propósito (URLs de servicios externos, credenciales,
   cuentas contables reales — p. ej. TaxIA siembra endpoints con URL vacía y
   descripción "Configurar la URL...", y el 111 con cuentas 475x placeholder que
   hay que adaptar al plan contable del cliente).
4. **Numeradores**: verifica que las series creadas por install no chocan con la
   numeración del cliente; ajusta Starting No. si conviene ANTES del primer uso.
5. **Job queues**: localiza las entradas creadas por la app (quedan `On Hold`),
   revisa ventana horaria y ponlas en `Ready`. Confirma que hay una sesión de
   Job Queue activa en el entorno.
6. **Suscripciones de eventos**: los EventSubscribers estáticos se activan solos
   con la extensión; lo que hay que verificar es su efecto — ejecuta el flujo de
   negocio disparador (registrar un pedido, validar un campo) y confirma el
   resultado. Si la app usa suscripción manual (`EventSubscriberInstance = Manual`)
   o registros de integración/webhooks, actívalos explícitamente desde su setup.
7. **Seed opcional**: si el cliente quiere recargar plantillas de fábrica, usa la
   acción de la página de setup que llama al `Seed()` público (patrón
   `SeedTemplates()` de TaxIA). Documenta que puede pisar personalizaciones si el
   seed es delete+reinsert.
8. **Prueba de humo por empresa**: repite 3–6 en cada empresa del tenant que use
   la app (el install PerCompany ya corrió en todas, la configuración manual no).

---

## 6. Cambios que destruyen datos en producción

Todas estas operaciones pierden o corrompen datos del cliente de forma irreversible;
cada una tiene su alternativa segura.

- **No renumeres objetos ni campos con datos en producción.** El ID es la
  identidad física: renumerar una tabla o un campo destruye/huérfana los datos en
  el sync de esquema. Si un ID nació mal, se obsoleta y se crea uno nuevo con
  migración en la upgrade codeunit.
- **No borres un campo o tabla directamente.** Mecánica correcta en dos releases:

  ```al
  // Release N: dejar de usarlo, pero mantener el esquema.
  field(10; "Old Field"; Boolean)
  {
      ObsoleteState = Pending;
      ObsoleteReason = 'Sustituido por "New Field". Se elimina en la versión X+2.';
      ObsoleteTag = '1.5';
  }
  // + migración en la upgrade codeunit que copia Old Field -> New Field (con tag).

  // Release N+1 (cuando TODOS los clientes han pasado por N y su upgrade):
  ObsoleteState = Removed;  // el campo desaparece del esquema; el código que lo use ya no compila
  ```

  No saltes de campo activo a `Removed` (o a borrado físico) en un solo
  release: los clientes que se salten la versión intermedia pierden los datos sin
  migración posible.
- **No cambies el tipo de un campo** (ni reduzcas la longitud de un
  `Text`/`Code`). Es cambio destructivo: el sync falla o trunca. Alternativa: campo
  nuevo con el tipo correcto + migración con upgrade tag + obsoletar el viejo
  (Pending → Removed como arriba).
- **No insertes seed sin guard** (`IsEmpty`/`Get`): la install corre en cada
  actualización y duplicarías o pisarías datos del cliente.
- **No dispares validaciones/subscribers en migraciones masivas**: usa
  `Modify(false)` / `ModifyAll(..., false)` salvo que necesites la lógica de
  validación conscientemente (VentIA documenta cada elección).
- **No selles un upgrade tag sin registrarlo** en `OnGetPerCompanyUpgradeTags`
  (ver sección 2: en empresas nuevas el bloque se re-evaluaría).

---

## Provenance y mantenimiento

Fuentes verificadas el 2026-07-06 en `C:\DevConsultIA-repos`:

- `TaxIA__TaxIA\al\src\Codeunits\TIAInstall.Codeunit.al` (PerCompany + IsEmpty + SeedTemplates, delete+reinsert de catálogo).
- `SecurIA__SecurIA\src\Codeunits\SMPInstall.Codeunit.al` (PerDatabase, Access=Internal, Permissions, guard Get→exit).
- `MasterDataIA__MasterDataIA\src\Codeunits\MDIAInstall.Codeunit.al` (PerDatabase, recorre Company).
- `VentIA__VentIAAL\src\Codeunits\VENInstall.Codeunit.al` (EnsureNoSeries), `VENPortalUpgrade.Codeunit.al` y `VENPortalUpgradeTags.Codeunit.al` (upgrade tags).
- `MonitorizaciónJobQueue\...\JQMInstall.Codeunit.al` y `SupplyChainPlanning\...\Cod64103.VirtualFollowupInstall.al` (setup singleton y job queue con guard).

Re-verificación (PowerShell, desde `C:\DevConsultIA-repos`):

```powershell
# Apps CON install/upgrade codeunit
Get-ChildItem -Recurse -Filter *.al | Select-String -Pattern 'Subtype\s*=\s*(Install|Upgrade)' -List | Select-Object Path

# Apps SIN install codeunit (el hueco de la sección 4): listar carpetas de app y cruzar
Get-ChildItem -Directory | ForEach-Object {
    $hits = Get-ChildItem $_.FullName -Recurse -Filter *.al -ErrorAction SilentlyContinue |
        Select-String -Pattern 'Subtype\s*=\s*(Install|Upgrade)' -List
    if (-not $hits) { $_.Name }
}

# Tags sellados vs registrados en VentIA (deben coincidir)
Select-String -Path 'VentIA__VentIAAL\src\Codeunits\VENPortalUpgrade*.al' -Pattern "'VEN-"
```

Si alguna app del hueco gana install codeunit, actualiza la sección 4 y la fecha de
cabecera.
