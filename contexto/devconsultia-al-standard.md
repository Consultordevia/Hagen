<!-- GENERADO — NO EDITAR -->

# devconsultia-al-standard

*Copia generada de `skills/devconsultia-al-standard/SKILL.md` del Manual. GENERADO — NO EDITAR:*
*si algo de aquí está mal o desactualizado, se corrige en el Manual, no aquí.*

---

---
name: devconsultia-al-standard
description: 'Estándar AL de DevConsultIA: estructura de proyecto, app.json, prefijos, setup singleton, install/upgrade, permission sets. Usar al crear una app AL nueva; carga también devconsultia-id-registry. Triggers: "crear app AL", "estándar AL", "app.json", "app nueva Business Central".'
---

# Estándar AL DevConsultIA

Estándar para toda app AL nueva de DevConsultIA: lo mejor del código AL de la
casa (UX, install+seed, upgrade), sin los anti-patrones de las apps antiguas.

**Antes de reimplementar algo, mira si BC ya lo trae**: novedades 2026 wave 2 para agentes
(no oficial, de waldo): https://waldo1001.github.io/msdyn365-2026-release-wave-2/llms.txt

> **Esta skill es neutral y se empaqueta en cualquier repositorio AL, incluidos los de
> cliente.** Las reglas y los ejemplos se describen por su forma, no por el repo, la app
> o el cliente donde se observaron. La atribución concreta (qué repo, qué app, qué
> fichero, qué cliente) vive en el material interno de portfolio y **no se añade aquí**.
> Si vas a documentar una regla nueva, descríbela sin nombrar repos ni clientes.

**Cuándo NO usar esta skill (deriva a la especializada):**
- Detalle de UI (Role Center, wizard, cues, tutorial guide, page extensions a fondo) → `devconsultia-al-ui-patterns`
- Integraciones HTTP/SOAP/REST, autenticación, webhooks → `devconsultia-al-integrations`
- Install/Upgrade en profundidad → `devconsultia-al-install-upgrade`
- Asignación de rangos de IDs entre apps → `devconsultia-id-registry`

---

## 0. Plan escrito antes de programar (app nueva o cambio grande)

**Cuándo:** app nueva, cinco o más objetos nuevos, tabla nueva o campo en una tabla que ya
tiene datos, cambio que necesita upgrade o integración externa. Para el resto basta la frase
de `devconsultia-testing-and-qa` §7.

**Dónde:** `docs/diseno/REQ-nnnnnn.md` en el repo de la app. Quien lleva el proyecto lo
aprueba en el chat antes de la primera línea de AL, y va en el mismo commit que el primer
código. Si el plan cambia por el camino, el fichero se corrige en el commit que lo cambia.

**Qué lleva** (una línea por punto, si basta):
1. Qué problema resuelve y qué se queda fuera.
2. Objetos: tipo, ID reservado en `devconsultia-id-registry`, nombre con prefijo y para qué.
3. Datos: tablas y campos; si tocan datos existentes, qué hace el upgrade (`-al-install-upgrade`).
4. Eventos: a cuáles se suscribe, cuáles publica y qué del estándar extiende.
5. Permisos: qué permission set cubre cada objeto.
6. Fuera de BC: qué llama y con qué credencial (`-al-integrations`).
7. Idiomas: cuáles lleva además del de origen (español siempre, en `es-ES_tradnl`) y quién revisa los textos.
8. Prueba en sandbox: el camino del usuario y el resultado que se espera.

No sustituye la propuesta al cliente. Es el plan técnico que leerá la próxima sesión.

---

## 1. Estructura de repo canónica: por feature

```
<AppName>/
├── app.json
├── AppSourceCop.json
├── README.md
├── CLAUDE.md              ← reglas del proyecto (acrónimo, ID range, módulos)
├── .gitignore             ← DEBE excluir *.app y .alpackages/
├── .vscode/
│   ├── launch.json
│   └── settings.json
├── Translations/          ← <AppName>.g.xlf generado + es-ES.xlf
└── src/
    ├── Setup/             ← tabla singleton + page de configuración + Install/Upgrade
    ├── <Feature1>/        ← p. ej. Receiving/: tablas, pages, codeunits del módulo juntos
    ├── <Feature2>/
    ├── RoleCenter/        ← Role Center propio + Profile (o pageextension de RC estándar)
    └── Permissions/       ← permission sets
```

**Por qué por feature y no por tipo.** Es el modelo de la app de referencia UX de la
casa, cuyo `src/` agrupa por módulo funcional (Setup, recepción, movimientos, operario,
cues, Role Center, permisos): al tocar un módulo, todo su código (tabla + page +
codeunit + enum) está en una carpeta; añadir o retirar un módulo es mover una carpeta;
y el diff de un PR cuenta la historia de un feature, no de "todas las tablas". Varias
apps propias usan carpetas por tipo (`Tables/`, `Pages/`, `Codeunits/`...) — funciona en
apps pequeñas, pero no escala: en una de ellas conviven ya 30+ codeunits de features
distintos en un solo `src/Codeunits/`, sin agrupación posible. **El estándar es por
feature.** Excepción tolerada: apps de <15 objetos pueden usar por tipo, pero migran a
por feature al crecer.

Reglas de archivo:
- Un objeto por archivo: `<PFX><Nombre>.<Tipo>.al` (ej. `PFXReceiveMgt.Codeunit.al`,
  `PFXSetup.Table.al`). Nunca el formato antiguo `Cod50000.NombreObjeto.al`.
- Carpetas con nombre en PascalCase (`src/Setup`), nunca minúsculas (`src/codeunit`).
- No se commitean binarios `.app` ni `.alpackages/`: engordan el repo y dejan de haber
  una fuente de verdad (hay apps antiguas de la casa que arrastran decenas de `.app`
  commiteados; el detalle está en `devconsultia-release-and-deploy`).

## 2. app.json canónico

Plantilla verificada, adaptada del `app.json` más completo del código propio:

```json
{
  "id": "<GUID nuevo: AL: Generate manifest GUID>",
  "name": "<NombreApp>",
  "publisher": "DevConsultIA",
  "version": "1.0.0.0",
  "brief": "<una frase, obligatorio no vacío>",
  "description": "<párrafo funcional, obligatorio no vacío>",
  "privacyStatement": "https://www.devconsultia.com/privacy",
  "EULA": "https://www.devconsultia.com/eula",
  "help": "https://devconsultia.es",
  "url": "https://devconsultia.es",
  "logo": "",
  "dependencies": [],
  "screenshots": [],
  "platform": "1.0.0.0",
  "application": "26.0.0.0",
  "idRanges": [ { "from": "<ASIGNAR EN devconsultia-id-registry>", "to": "<ASIGNAR EN devconsultia-id-registry>" } ],
  "resourceExposurePolicy": {
    "allowDebugging": false,
    "allowDownloadingSource": false,
    "includeSourceInSymbolFile": false
  },
  "runtime": "13.0",
  "features": [ "TranslationFile", "NoImplicitWith" ],
  "target": "Cloud"
}
```

Reglas:
- **publisher**: exactamente `DevConsultIA`. Hoy conviven en el código propio la grafía
  correcta y la variante `Devconsultia`. **Regla de gating (de
  `devconsultia-id-registry`): unificar a `DevConsultIA` solo en apps aún no
  desplegadas.** En apps desplegadas el publisher es identidad de la app: cambiarlo
  equivale a instalar una app nueva (pérdida de datos), así que no se toca sin plan de
  migración. `Default Publisher` (o `Default publisher`) no vale en ninguna app nueva:
  es un manifiesto sin identidad (hay varias apps que todavía lo arrastran).
- **idRanges**: rango asignado en `devconsultia-id-registry`; nunca inventar uno ni
  reutilizar. Existe una colisión real entre dos apps propias (el rango de una está
  contenido dentro del de la otra) — detalle y tratamiento en `devconsultia-id-registry`.
- **target Cloud** siempre; `runtime` mínimo 13.0 (las apps recientes usan 16.1-17.0;
  elegir el runtime de la versión mínima de BC soportada).
- **features**: `NoImplicitWith` y `TranslationFile` obligatorios los dos. Hay una app
  propia que omite `NoImplicitWith` — no repetirlo.
- **brief/description** nunca vacíos (hay apps antiguas que los tienen vacíos).
- **dependencies**: la clave es `id`. `appId` es la antigua: con runtime 4.1 o superior el
  compilador da `warning AL0667: 'dependencies.appId' is being deprecated` (comprobado con
  AL 18 el 2026-09-24).
- **Versionado [PROPUESTA]**: `Major.Minor.Patch.Build` (Major = rotura de
  esquema/API; Minor = feature; Patch = fix; Build = recompilación). No es práctica
  vigente: la fuente única de la política de versiones (estado real y propuesta) es
  `devconsultia-release-and-deploy` §3.

### 2.1 Dos reglas duras del manifiesto (no negociables)

**a) `resourceExposurePolicy` cerrado en TODA app propia.** Los tres flags a `false`:

```json
"resourceExposurePolicy": {
  "allowDebugging": false,
  "allowDownloadingSource": false,
  "includeSourceInSymbolFile": false
}
```

Con `allowDownloadingSource: true` cualquier cliente que tenga la app instalada puede
descargarse el código fuente; con `allowDebugging: true` puede leerlo depurando; con
`includeSourceInSymbolFile: true` viaja dentro del fichero de símbolos. Vendemos
producto en un mercado con competencia directa: dejar esto abierto es regalarlo.
Se pone así al **crear** la app, y se comprueba de paso cada vez que se **toca** un
`app.json`. Si hace falta abrirlo para depurar en casa de un cliente, se abre, se
depura y **se vuelve a cerrar antes de publicar**: nunca se queda abierto.
No aplica a repositorios de cliente ni a apps de terceros: ahí no se toca nada.

**b) Una app de PRODUCTO no puede depender de una app de CLIENTE.** Si el `app.json` de
un producto nuestro declara en `dependencies` la app específica de un cliente concreto,
ese producto **deja de ser vendible**: no se puede instalar en ningún otro cliente sin
arrastrar la app ajena, y ningún otro cliente la va a instalar. Es un anti-patrón real,
no teórico, y además **contamina en cadena**: si un segundo producto depende del primero,
hereda la dependencia y queda igual de invendible sin que nadie lo haya decidido.

Qué hacer:
- **Producto → producto → cliente, nunca producto → cliente.** Extraer lo común a una
  app base genérica y dejar fuera lo específico.
- Cuando el producto necesite comportamiento particular de un cliente, **invertir la
  dependencia vía eventos**: el producto publica eventos, y una **app puente** propia
  del cliente (`Dep_<Producto>_<Cliente>`) depende del producto y de la app del cliente
  y se suscribe. Este es el patrón correcto y ya está en uso en la casa.
- Antes de vender como producto una app existente, comprobar la cadena completa de
  dependencias, no solo el primer nivel (ver el comando genérico al final de esta skill).

## 3. Nomenclatura y reglas de UI (solo títulos — el detalle vive en devconsultia-al-ui-patterns)

Preferencias de equipo NO negociables. Aquí solo la lista; redacción completa,
ejemplos y excepciones en `devconsultia-al-ui-patterns` §1:

1. Prefijo de 3 letras del acrónimo de la app en TODOS los objetos y campos
   (si no lo conoces, pregúntalo antes de generar código).
2. Caption con prefijo `(PFX) ...` en español en toda page propia.
3. ToolTip explicativo en español en todo campo visible y toda acción.
4. PageExtensions: campos SIEMPRE dentro de un group propio (`addlast(Content)`).
5. Acciones de pageextension siempre promoted (`PromotedIsBig = true` en las principales).
6. `ApplicationArea = All` en cada control; errores como `Label` con `Comment`.

## 4. Patrones obligatorios en toda app nueva

### 4.1 Tabla Setup singleton + GetSingleton (canon de API)

**El método canónico se llama `GetSingleton()`** — es el nombre mayoritario en el
código real de la casa; `GetSetup` solo sobrevive en apps legacy. Plantilla (el ID sale
del rango asignado en `devconsultia-id-registry`; aquí se usa 50000 solo como ejemplo):

```al
table 50000 "PFX Setup"
{
    Caption = '(PFX) Configuración';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Clave primaria';
            DataClassification = SystemMetadata;
        }
        field(10; Enabled; Boolean)
        {
            Caption = 'Habilitado';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }

    procedure GetSingleton()
    begin
        if not Get('') then begin
            Init();
            Insert();
        end;
    end;
}
```

Uso: `Setup.GetSingleton();` — nunca `Setup.Get()` a pelo (revienta si el registro no
existe; es un patrón roto real: hay codeunits de integración antiguas que hacen
`ConfigX.Get();` sin guard y fallan en el primer uso). Nota: hay apps propias que añaden
en sus llamadores un `Setup.Get('')` justo después de `GetSingleton()` — es
**redundante** (GetSingleton ya deja Rec posicionado): no lo copies.

### 4.2-4.3 Install y Upgrade (resumen — plantillas completas en devconsultia-al-install-upgrade)

Las tres reglas duras, sin excepción:

1. **Install codeunit idempotente desde la v1** (`Subtype = Install`): guard
   `IsEmpty()`/`Get()` antes de sembrar (el install corre también al actualizar),
   `Setup.GetSingleton()` para asegurar el singleton, y seed en procedure público
   para poder recargarlo desde la page de setup.
2. **Upgrade codeunit desde la v1, aunque vacía** (`Subtype = Upgrade`): cada
   migración es un bloque `HasUpgradeTag → Init → SetUpgradeTag`. Lección aprendida en
   código propio: **`InitValue` NO rellena las filas ya existentes**, solo afecta a las
   nuevas; si añades un campo con valor por defecto a una tabla con datos, hay que
   rellenarlo explícitamente en el upgrade.
3. **Cada tag sellado se registra también** en el subscriber
   `OnGetPerCompanyUpgradeTags` de la codeunit gemela `PFX Upgrade Tags`.

Plantillas canónicas completas, criterio PerCompany/PerDatabase, EnsureNoSeries y
retrofit en apps sin install: `devconsultia-al-install-upgrade`.

### 4.4 Permission sets en AL

Nada de `extensionsPermissionSet.xml` (legado presente en varias apps antiguas de la
casa). Objeto `permissionset` en `src/Permissions/`:

```al
permissionset 50000 "PFX All"
{
    Assignable = true;
    Caption = '<NombreApp> - All';

    Permissions =
        tabledata "PFX Setup" = RIMD,
        table "PFX Setup" = X,
        page "PFX Setup" = X,
        codeunit "PFX Install" = X;
}
```

Mínimo un set `PFX All`; en apps con roles diferenciados, añadir `PFX Read` /
`PFX Admin` (hay apps propias que ya separan un set de administración y otro de solo
lectura). Todo objeto nuevo se añade al set en el mismo commit.

### 4.5 Traducciones (.xlf — ficheros XLIFF de traducción que genera el compilador AL)

`"features": ["TranslationFile"]` genera `Translations/<AppName>.g.xlf` al compilar.
Commitear el `.g.xlf` y mantener al menos `<AppName>.es-ES.xlf` con las traducciones.
Ojo: lo que BC mira es el atributo `target-language` de dentro, no el nombre del fichero, y
el «Español (España)» de BC es **`es-ES_tradnl`** (LCID 1034, idioma ESP). Microsoft lo hace así en su
Base Application desde al menos BC21: fichero `Base Application.es-ES.xlf` con
`target-language="es-ES_tradnl"` (comprobado 2026-09-24 en los `.app` de BC21, 27 y 28).
`es-ES` solo lo aplica a ESN (3082), que casi nadie usa, y `es` a nadie: con ESP el usuario
ve el texto original. `es-ES_tradnl` vale para los dos (probado en sandbox el 2026-10-05,
`demostraciones/al-idioma-es` del Manual).
Todo texto de usuario va en Caption/ToolTip/Label (nunca strings literales en `Error()`
sin Label).

## 5. Cops y ruleset

("Cops" = analizadores estáticos del compilador AL: CodeCop, UICop, AppSourceCop,
PerTenantExtensionCop; el ruleset ajusta la severidad de sus reglas.)

### 5.1 AppSourceCop.json — el error real a no repetir

Patrón defectuoso observado en código propio (verificado 2026-07-06): declarar el afijo
correcto pero dejar además `mandatoryPrefix` y `mandatorySuffix` declarados y VACÍOS:

```json
{
    "mandatoryAffixes": [ "PFX" ],
    "mandatorySuffix": "",
    "mandatoryPrefix": ""
}
```

Claves vacías no aportan nada y confunden (parece que "no hay prefijo obligatorio").
El canónico es declarar solo lo que se usa:

```json
{
    "mandatoryAffixes": [ "PFX" ]
}
```

(`mandatoryAffixes` cubre prefijo O sufijo; si quieres forzar prefijo estricto,
usa `"mandatoryPrefix": "PFX"` — pero entonces relleno, nunca `""`.)

### 5.2 Ruleset recomendado — PROPUESTA

Hoy **ningún repo tiene ruleset** (verificado 2026-07-06: no existe ningún
`*.ruleset.json` en el código clonado). Propuesta mínima, no probada aún en pipeline —
validar en la primera app que lo adopte:

`.vscode/settings.json`:
```json
{
    "al.codeAnalyzers": [ "${CodeCop}", "${UICop}", "${AppSourceCop}" ],
    "al.ruleSetPath": "./devconsultia.ruleset.json",
    "al.enableCodeAnalysis": true
}
```

`devconsultia.ruleset.json` (propuesta):
```json
{
    "name": "DevConsultIA",
    "description": "Ruleset base DevConsultIA - errores duros sobre lo que el estándar exige",
    "rules": [
        { "id": "AA0218", "action": "Error", "justification": "ToolTip obligatorio en campos y acciones" },
        { "id": "AA0219", "action": "Error", "justification": "ToolTip debe empezar por verbo/explicación, no repetir caption" },
        { "id": "AA0072", "action": "Warning", "justification": "Nombres de variables según tipo" },
        { "id": "AA0470", "action": "Warning", "justification": "Placeholders de labels con Comment" }
    ]
}
```

Nota per-tenant vs AppSource: en modo per-tenant puede desactivarse `${AppSourceCop}`
—es práctica aceptada y documentada en apps propias per-tenant—; al pasar a AppSource
se reactiva y se corrigen los warnings.

### 5.3 Servidor MCP oficial de AL (`al launchmcpserver`)

Si la sesión lo tiene (AL Development Tools 30 beta; probado el 2026-10-08 en nube, BC21 y BC13):

- **Nombres, de los símbolos.** Confirma campo, tabla o método con `al_symbolsearch`
  (`filters.objectName` + `memberKinds`, `limit` ≤ 50); sin filtros pasa de 10.000 tokens.
- **Compila tras cada cambio**: `al_compile` con `onlyErrors: true`. Para avisos,
  `onlyErrors: false`, `codeAnalyzers` explícitos y `maxDiagnosticsPerCompilation` ≤ 100.
- **No lee `.vscode/settings.json`**: ni analizadores ni ruleset (`--ruleset` al arrancar).
  El veredicto antes de publicar sigue siendo `compilar-al.mjs`.
- **IDs, del registro** (`devconsultia-id-registry`): `al_getnextobjectid` solo mira el proyecto.
- `al_publish`, `al_run_tests`, `al_downloadsymbols` y `al_auth_*` van a un entorno real:
  se publica con `publicar-app-al.mjs`.

## 6. Checklist de "app nueva" (copy-pasteable)

```
[ ] Acrónimo de 3 letras decidido y anotado en CLAUDE.md del proyecto
[ ] Rango de IDs reservado en devconsultia-id-registry (sin colisiones)
[ ] app.json: publisher DevConsultIA, GUID nuevo, brief/description rellenos,
    target Cloud, features TranslationFile + NoImplicitWith, idRanges del registro
[ ] app.json: resourceExposurePolicy con los TRES flags a false (§2.1a)
[ ] app.json: dependencies sin ninguna app de cliente (§2.1b) y con clave id (no appId)
[ ] AppSourceCop.json con mandatoryAffixes: ["PFX"] (sin claves vacías)
[ ] .gitignore excluye *.app y .alpackages/
[ ] Estructura src/ por feature: Setup/, RoleCenter/, Permissions/ + carpetas de módulo
[ ] Tabla "PFX Setup" singleton con GetSingleton()
[ ] Codeunit "PFX Install" (Subtype = Install) idempotente con guard IsEmpty
[ ] Codeunit "PFX Upgrade" (Subtype = Upgrade) + "PFX Upgrade Tags" (aunque vacíos)
[ ] Permission set "PFX All" en AL (no XML) con todos los objetos
[ ] Translations/ con .g.xlf commiteado y es-ES.xlf
[ ] CLAUDE.md del proyecto con: acrónimo, ID range, reglas UX
[ ] README.md con tabla de objetos (ID | Tipo | Propósito) y cómo probar
[ ] Toda page propia: Caption '(PFX) ...'; todo campo/acción: ToolTip en español
[ ] PageExtensions: groups propios + acciones promoted
[ ] Si tiene UI de módulo: Role Center / wizard / cues según devconsultia-al-ui-patterns
```

## 7. Anti-patrones (vistos en código propio — no repetir)

| Anti-patrón | Cómo se ve | Por qué está mal / qué hacer |
|---|---|---|
| SOAP por concatenación de strings sin sanitizar | Una codeunit de integración con un transportista construye el XML de la petición con `'<codigo>' + CodExpedicion + '</codigo>'` | Un `&`, `<` o comilla en el dato rompe el XML o lo inyecta. Construir con `XmlDocument`/`XmlElement` o al menos escapar. Detalle en `devconsultia-al-integrations`. |
| Carpetas por tipo en minúscula + nombres legacy | `src/codeunit/Cod50000.NombreObjeto.al`, `src/table/Tab50010.Credenciales.al` | Ilegible y sin prefijo. `src/<Feature>/PFXNombre.Tipo.al`. |
| Objetos sin prefijo | Codeunits y pages con nombre genérico tipo `UtilidadesX`, `ConfigX` | Riesgo de colisión de nombres entre extensiones. Prefijo de 3 letras siempre. |
| Sin install codeunit (setup manual post-deploy) | La app no tiene ningún objeto con `Subtype = Install` | El primer uso falla por configuración ausente. Install idempotente (§4.2). |
| Binarios `.app` commiteados | Decenas de `.app` en la raíz del repo (cifras en `devconsultia-release-and-deploy`) | Repo pesado y sin fuente de verdad. `.gitignore` + releases fuera del repo. |
| Archivo suelto duplicado fuera de estructura | El mismo objeto en `src/Pag50000.XSetup.al` y en `src/page/Pag50000.XSetup.al` | Compila el que no esperas. Un objeto, un archivo, una ruta. |
| `brief`/`description` vacíos + versionado solo por Build | Apps que llevan decenas de builds sin subir Minor ni Patch | Nadie sabe qué hace la app ni qué cambió. §2. |

Publisher, `resourceExposurePolicy`, dependencias de cliente y `appId`: §2 y §2.1.

## Provenance y mantenimiento

Basado en lectura directa del código AL real de DevConsultIA a **2026-07-06**.
La atribución concreta de cada regla y cada anti-patrón (qué repo, qué app, qué fichero,
qué cliente) se extrajo de esta skill el **2026-08-16** bajo **REQ-000380** y vive en el
material interno de portfolio: esta skill se empaqueta en repositorios de cliente y debe
quedarse neutral. **No vuelvas a añadir aquí nombres de repos, apps ni clientes.**

Etiquetado como **PROPUESTA** (no verificado en pipeline): el ruleset del §5.2.
Todo lo demás está extraído de código existente.

Re-verificación genérica (PowerShell, desde la carpeta raíz donde estén clonados los
repos — funciona en cualquier repo, no cita ninguno):
```powershell
# ¿Algún AppSourceCop.json declara afijos vacíos?
Get-ChildItem -Recurse -Filter AppSourceCop.json -Depth 3 |
    Select-String -Pattern '"mandatory(Prefix|Suffix)"\s*:\s*""'

# ¿Aparecen publishers sin identidad? (insensible a mayúsculas)
Get-ChildItem -Recurse -Filter app.json -Depth 3 |
    Select-String -Pattern '"publisher"\s*:\s*"Default Publisher"' -CaseSensitive:$false

# Publisher inconsistente (DevConsultIA vs Devconsultia)
Get-ChildItem -Recurse -Filter app.json -Depth 3 |
    Select-String '"publisher"' | Sort-Object -Unique Line

# ¿resourceExposurePolicy abierto en alguna app propia?
Get-ChildItem -Recurse -Filter app.json -Depth 3 |
    Select-String -Pattern '"(allowDebugging|allowDownloadingSource|includeSourceInSymbolFile)"\s*:\s*true'

# Mapa de dependencias declaradas: revisar cuáles apuntan a una app de CLIENTE (§2.1b)
Get-ChildItem -Recurse -Filter app.json -Depth 3 | ForEach-Object {
    try { $m = Get-Content $_.FullName -Raw | ConvertFrom-Json } catch { return }
    foreach ($d in $m.dependencies) {
        [pscustomobject]@{ App = $m.name; Publisher = $m.publisher; DependeDe = $d.name; PublisherDep = $d.publisher }
    }
} | Sort-Object App, DependeDe | Format-Table -AutoSize

# Clave `appId` (obsoleta, AL0667) en vez de `id` dentro de dependencies
Get-ChildItem -Recurse -Filter app.json -Depth 3 | ForEach-Object {
    if ((Get-Content $_.FullName -Raw) -match '"dependencies"\s*:\s*\[[^\]]*"appId"\s*:') { $_.FullName }
}

# ¿Sigue sin existir ruleset alguno?
Get-ChildItem -Recurse -Filter *.ruleset.json -Depth 3
```
Actualizar esta skill cuando: se cree el ruleset real (quitar etiqueta PROPUESTA),
se corrija el AppSourceCop con claves vacías, o `devconsultia-id-registry` reasigne
rangos. **Al actualizarla, mantener la neutralidad**: describe el hallazgo, no el repo.
