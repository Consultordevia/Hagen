<!-- GENERADO — NO EDITAR -->

# devconsultia-release-and-deploy

*Copia generada de `skills/devconsultia-release-and-deploy/SKILL.md` del Manual. GENERADO — NO EDITAR:*
*si algo de aquí está mal o desactualizado, se corrige en el Manual, no aquí.*

---

---
name: devconsultia-release-and-deploy
description: 'Cómo se construye, versiona y entrega software en DevConsultIA: procedimiento único de release AL (publicar-app-al.mjs, Sandbox antes que Production) y pipelines web de Azure DevOps. Usar al publicar, versionar o desplegar. Triggers: "publicar", "release", "deploy", "pipeline", "generar .app".'
---

# DevConsultIA — Release y Deploy

**Verificada el 2026-07-06**; §2.5 el 2026-08-08, §2.0 entre el 2026-08-11 y el 2026-08-25 (INT-2026-0002, REQ-000485), §2.00 y §1.0 el 2026-09-22; neutralizada el 2026-08-16 (REQ-000380). Lo marcado *(verificado)* se comprobó en los repos de `C:\DevConsultIA-repos`; lo marcado **PROPUESTA** no existe todavía y no se describe como práctica vigente.

**Esta skill es de núcleo: se empaqueta en CUALQUIER repositorio, incluidos los de cliente.** Por eso no nombra clientes, repos, App Services ni entornos concretos: las reglas están enteras, los ejemplos son genéricos. El inventario nominal (qué repo, qué app, qué suscripción, qué cliente) vive en el conocimiento interno y **no se cita aquí**. Si necesitas el nombre concreto, búscalo en el inventario interno o en la skill del cliente correspondiente — no lo añadas a este documento.

## Cuándo NO usar esta skill

- Para escribir código AL (naming, estructura de objetos, UI): usa las skills de estándar de desarrollo AL.
- Para lógica de negocio, eventos o debugging de una app concreta.
- Para administración de tenants BC ajena a publicar extensiones.

---

## 1.0 Cómo se publica una app AL — EL procedimiento (vigente desde 2026-09-22)

**Uno solo para todos los proyectos.** Si en un repo no sabes cómo se publica, es este. Lo que
cambia de un repo a otro (cliente, entorno, nombre de la app) son parámetros, no el método.

**Por dónde sube (REQ-000939).** Microsoft retira en la versión 30 (abril de 2027) la subida
de PTEs por Extension Management **y por la Automation API**. `publicar-app-al.mjs` usa la
**Admin Center API** (`apps/pteInstall`) cuando la identidad que publica tiene
`AdminCenter.ReadWrite.All`, y si no, la Automation API mientras exista; la salida dice cuál
usó. Nuestro BC ya va por el Admin Center, con la app de integración (certificado) solo para
publicar. Cada cliente necesita en su tenant el permiso, con consentimiento del
administrador, **y** la app en «Authorized Microsoft Entra apps» del Admin Center: sin eso da
401/403 (REQ-000976); el script avisa y sigue por la Automation API. Autorizarla lo decide
la persona del puesto. Con esa vía existen `--programar inmediato|ventana|proxima-menor|proxima-mayor` y
`--con-dependencias`. Instalar por API acepta el EULA del proveedor (`acceptIsvEula`): Xavier
lo aceptó para lo nuestro el 2026-09-25.

**Compilar:** `node C:/DevConsultIA-repos/.claude/herramientas/compilar-al.mjs --proyecto <carpeta>`
(REQ-000861). Encuentra el `alc` (extensión AL más nueva, `AL_COMPILER`, `--alc` o el paquete
NuGet en el Mac), usa los símbolos, ensamblados y analizadores del `.vscode/settings.json` y
comprueba los dos primeros puntos de abajo antes de compilar: para si `resourceExposurePolicy`
está abierto (salvo las apps de `herramientas/excepciones-exposicion.json`) o si la versión
va por detrás de un `.app` ya compilado (`--instalada x.y.z.w` para comparar además con el
entorno). Las apps on-prem antiguas (BC13/14) compilan con el mismo `alc`: si la carpeta de
símbolos mezcla versiones mayores de Microsoft, se compila con una copia que solo lleva las
de la `application` del `app.json`, y se añaden las carpetas del .NET Framework de Windows.

**ALCops** (sucesor de LinterCop): `--alcops` o `"devconsultia.alcops": true` en el settings.json; baja solo, versión y SHA-512 fijados, modo aviso. `docs/alcops.md`.

### Antes de compilar

1. **`app.json`**:
   - Si `publisher` es DevConsultIA, `resourceExposurePolicy` con `allowDebugging`,
     `allowDownloadingSource` e `includeSourceInSymbolFile` **a `false`**. Si no, el cliente
     puede descargarse el código. Se comprueba en cada publicación, no solo al crear la app,
     porque se abre para depurar y se olvida cerrar.
   - `target` declarado (`Cloud` u `OnPrem`), no por defecto.
   - **Sube la versión ANTES de compilar**: el `.app` lleva la versión dentro. Una versión ya
     instalada no se vuelve a publicar.
   - `application` al día con el entorno: si el entorno sube de versión mayor, una extensión
     compilada contra una `application` vieja **desaparece del entorno sin aviso**.
2. **`.gitignore` con `*.app` y `.alpackages/`.** El `.app` no se commitea, tampoco los
   nuestros (sin excepciones `!DevConsultIA_*.app`; decisión de Xavier del 2026-09-24,
   REQ-000869). El binario exacto de cada versión instalada lo guarda `publicar-app-al.mjs`
   en `C:DevConsultIA-archivoapps-publicadas<cliente><app>`, con una línea por
   publicación en `publicaciones.jsonl`. Excepción: `.alpackages/` se queda en git si el
   pipeline del repo compila con esos símbolos.
3. **`.vscode/launch.json` sin entornos de producción.** Solo sandbox, y nunca
   `schemaUpdateMode: ForceSync` contra nada que tenga datos reales.

### Compilar

Con `compilar-al.mjs` (arriba), o con la extensión AL de VS Code (`Ctrl+Shift+B`).
Compila **limpio**: sin errores y sin warnings nuevos. `alc` no falla con una ruta de
`RDLCLayout` mal puesta: genera un layout vacío y el informe sale en blanco. Si tocaste
layouts, abre el informe en el sandbox.

### Publicar (SaaS): la herramienta del Manual, siempre

```bash
node C:/DevConsultIA-repos/.claude/herramientas/publicar-app-al.mjs \
  --cliente <cliente> --app "<Nombre>" --version <x.y.z.w> \
  --entorno <Sandbox|Production> --fichero <ruta al .app>        # Production exige además --si-production
```

**Con la ruta completa, desde el repo en el que estés**: el script vive en el Manual y no en
cada repo. Vale para **cualquier cliente con credenciales en la bóveda**: si `--cliente` no está
en el mapa del script, lee tenant, app y empresa del secreto `bc-<cliente>`. Si el secreto se
llama de otra forma, `--secreto <nombre>`; si la app va a otra empresa, `--empresa-id <guid>`
(la Automation API es por empresa). Formato de los secretos: `devconsultia-credenciales`. Si la
Automation API da 401/403, a la app le falta permiso en ese BC: se concede, no se busca otra vía.
Sube el binario por la Automation API, **pide el despliegue** (`Microsoft.NAV.upload`) y
**espera a ver la versión instalada**. Si no la ve, sale con código 1: eso es un fallo, no un
«ya aparecerá». Detalle y salidas en `docs/publicar-app-al.md` del Manual.

- **Primero Sandbox, luego Production**, con el MISMO `.app`, sin recompilar.
- **Trampa Dev vs PTE:** si la app se publicó antes desde VS Code (F5), vive en ámbito **Dev**, y
  la Automation API la sube como **PTE** → `Failed` sin motivo visible. Míralo antes en
  `GET .../extensions` (`publishedAs` vale `" Dev"` o `" PTE"`, con espacio delante). Si es Dev,
  desinstala la copia Dev o publica por el endpoint de desarrollo con
  `SchemaUpdateMode=Synchronize`, nunca `ForceSync`.
- **`Schema Sync Mode: Add`**, nunca `Force`: `Force` borra los datos de los campos eliminados.
- **`Failed` sin motivo** (REQ-000877, publicación de CheckSII en Boya): la Automation API no
  da el porqué. Antes de culpar al entorno, mira en el repo: el diff de esquema contra la
  versión instalada (campos quitados o con otro tipo, claves cambiadas: `Add` no lo admite;
  un script de diff tiene que ignorar los `// field(...)` comentados), `RoleID` de más de 20
  caracteres en permission sets XML, y textos sembrados en install/upgrade que no quepan en
  su campo. Si no es nada de eso, el motivo está en BC: Gestión de extensiones → Estado de
  implementación → la línea.
- **404 `NoEnvironment` ≠ 401 `Authentication_InvalidCredentials`**: el primero es que el
  entorno no existe con ese nombre; el segundo, que la app no está dada de alta en «Aplicaciones
  de Microsoft Entra» DE ESE entorno (el registro es por entorno). Las herramientas lo dicen.

### Después de publicar

- **Confirma la versión instalada** en el entorno. Un 200 de la API no es una instalación.
- **Colas de proyectos (Job Queue Entries):** publicar puede dejarlas paradas sin error.
  Relánzalas y mira que vuelven a correr.
- Si hay permission sets XML heredados, un `RoleID` de más de 20 caracteres tumba la
  instalación sin decir por qué.
- Deja constancia en la petición (REQ) de la versión publicada y del entorno.

### OnPrem

Mismo `app.json` y mismo compilado. La Automation API no existe en OnPrem: se publica contra el
servidor del cliente (`Publish-NAVApp` / `Sync-NAVApp` / `Start-NAVAppDataUpgrade`, o su
equivalente de BcContainerHelper) con las credenciales de ese servidor. Lo concreto de cada
cliente OnPrem va en su skill de cliente.

### Qué debe tener cada repo AL

Una sección **«Publicar»** en su README, de 5 líneas: cliente, entornos (Sandbox/Production,
Cloud/OnPrem), nombre de la app, y un enlace a este procedimiento. Nada más: el método no se
copia en cada repo, porque las copias se quedan viejas.

## 1. AL: cómo se venía entregando (verificado 2026-07-06)

> Esto es el diagnóstico de partida, no la norma. **Lo vigente es §1.0.** Si un repo sigue así
> (publicar a mano desde VS Code, `.app` commiteados), se lleva a §1.0 la próxima vez que se toque.

**No había CI/CD para AL** (2026-07-06): ningún repo AL tenía `AL-Go-Settings.json` ni `.github/workflows`, y los 4 `azure-pipelines.yml` de entonces eran de apps web. Desde el 2026-09-22 al menos un repo AL compila en CI en el agente de la casa (§5); publicar sigue siendo §1.0.

**Flujo real de release AL** (reconstruido de los repos):

1. El desarrollador abre el repo en VS Code con la extensión AL.
2. Descarga symbols contra un sandbox cloud del cliente (el `.vscode/launch.json` del repo apunta a `environmentType: Sandbox` con el tenant del cliente).
3. Sube la versión en `app.json` a mano (normalmente +1 en el cuarto dígito).
4. Compila con `Ctrl+Shift+B` → genera `Publisher_Nombre_x.y.z.w.app` en la raíz del repo.
5. Publica al sandbox con F5/RAD (Rapid Application Development, publish incremental de VS Code) para probar.
6. Sube a producción **manualmente**: Business Central → **Extension Management** → *Upload Extension* con el `.app` generado (o publish directo desde VS Code contra el environment de producción).
7. Commitea el código **y el `.app`** al repo.

**Los `.app` van commiteados al repo** *(verificado)*: el peor caso medido es un repo de producto AL muy iterado con **94** `.app` de la propia app en la raíz (uno por release, de `1.0.0.0` a `1.0.0.93`) y **176** binarios trackeados en git contando `.alpackages/`. No es un caso aislado: hay al menos otros cinco repos entre **23 y 62** `.app` commiteados, tanto de producto como de cliente.

**Dependencias entre apps** *(verificado)*: no hay feed de artefactos. Se resuelven con:
- Repos **wrapper de dependencias** (patrón `Dep_*` / `<Cliente>_Dependencias`) que contienen los `.app` compilados de la dependencia. El patrón habitual es: producto genérico + app puente que depende a la vez del producto y de la app base del cliente. Varios clientes tienen el suyo.
- Carpetas `.alpackages/` con symbols commiteadas.
- Ejemplo real de cómo queda: una app de producto declara en su `app.json` dependencias fijadas a versiones concretas de la app base de un cliente (`1.0.0.1277`) y de dos productos internos (`1.0.0.0`, `1.0.0.12`). Es decir: **el producto no es instalable en otro cliente sin la app base de aquel** — mira siempre el bloque `dependencies` antes de prometer que algo es reutilizable.

**Riesgos del método actual** — dilos tal cual cuando propongas mejoras:
- No hay build reproducible: el `.app` que llega a producción sale de la máquina de un desarrollador.
- El repo engorda con binarios (git no está hecho para 94 `.app`); clones lentos y sin LFS.
- Dependencias congeladas a mano en los repos wrapper: nada garantiza que el `.app` commiteado corresponda al código commiteado.
- Sin gates: nada impide publicar sin compilar limpio, sin tests, sin revisar el diff.
- `schemaUpdateMode: ForceSync` en launch.json de sandbox: aceptable en sandbox, letal si se apunta por error a producción.
- Bus factor: el procedimiento vive en la cabeza de quien publica.

---

## 2. Web: los 4 pipelines reales (verificado, leídos línea a línea)

### 2.00 Dónde se EJECUTAN los pipelines: el agente autoalojado (verificado 2026-09-22)

Los pipelines de Azure DevOps corren en un **agente autoalojado**: un Mac mini de la casa,
encendido 24/7, **macOS sobre ARM (Apple Silicon)**, registrado en el grupo de agentes
**`Default`** (con D mayúscula) de la organización. El motivo: la organización no tiene
minutos gratuitos en los agentes de Microsoft (*"Your organization has no free minutes
remaining"*, desde el 2026-09-22).

**En el YAML, el pool es siempre este:**

```yaml
pool:
  name: Default
```

en lugar de `vmImage: 'ubuntu-latest'` (o cualquier otro `vmImage`, a nivel de pipeline,
stage o job). **Un `vmImage` = el pipeline falla por falta de minutos.** Un pipeline sin
`pool:` también va a los agentes de Microsoft y falla igual.

**Cuántos a la vez.** La organización tiene contratados N trabajos en paralelo autoalojados
(el primero gratis; cada uno más, 15 $/mes en *Organization settings > Parallel jobs*). Con uno,
los trabajos van **de uno en uno** y un CI largo (Rust, ~16 min) retiene los despliegues de
3 min que vienen detrás. Si hay varios, esperan en cola: un `notStarted` con otros trabajos
por delante es cola, no fallo. Añadir agentes sin contratar paralelos NO acelera nada. Los
agentes extra del Mac (`macmini-2`, `macmini-3`) se crean con
`herramientas/mac-agentes-extra.sh` (REQ-000900); cada uno tiene su `_work`, y lo que se
comparte (Postgres, `~/.cargo`, `az`) ya aguanta ejecuciones simultáneas.

#### Trampas ya pagadas

1. **La primera vez que un pipeline usa `Default` se queda parado en `notStarted`, sin
   error**, con la *timeline* en `Checkpoint.Authorization`. Hay que autorizar ese pipeline
   sobre la **cola `Default` del proyecto**. El id de la cola **cambia por proyecto**: no
   copies el de otro.

   ```bash
   # 1. Id de la cola Default en ESE proyecto
   az devops invoke --org https://dev.azure.com/DevConsultIA --area distributedtask \
     --resource queues --route-parameters project=<Proyecto> --api-version 7.1-preview \
     --query "value[?name=='Default'].id"

   # 2. Autorizar el pipeline sobre esa cola
   #    perm.json = {"pipelines":[{"id":<idPipeline>,"authorized":true}]}
   az devops invoke --org https://dev.azure.com/DevConsultIA --area pipelinePermissions \
     --resource pipelinePermissions --route-parameters project=<Proyecto> resourceType=queue \
     resourceId=<idColaDefault> --api-version 7.1-preview --http-method PATCH --in-file perm.json
   ```

   Las ejecuciones ya encoladas no reintentan solas: lanza una nueva. Es la misma familia de
   bloqueo que la de un repositorio sin autorizar (ver `docs/pipeline-cross-project.md` del
   Manual), pero aquí la cola es del propio proyecto y **sí se autoriza por API**.
2. **Si el Checkout falla con `Value cannot be null. (Parameter 'gitVersion')`**, el git del
   Mac no arranca: falta aceptar la licencia de Xcode (`sudo xcodebuild -license accept` en
   el Mac). Está resuelto, pero vuelve si se reinstala Xcode o las Command Line Tools.
3. **Es macOS/BSD y ARM, no Linux.** En los `script:`/`bash:`:
   - `sed -i` exige sufijo (`sed -i '' ...`), `readlink -f`, `sha256sum` (usa
     `shasum -a 256`), `date -d`, `grep -P`, `stat -c`, `xargs -r`, `base64 -w`, `timeout`,
     `nproc` no existen o se comportan distinto. Escribe POSIX o hazlo en Node/Python.
   - **`cp -r` en macOS sigue los enlaces simbólicos (equivale a `cp -RL`); usar siempre
     `cp -R`.** Con los symlinks de pnpm, un `cp -r` copia de más o duplica árboles enteros.
   - **Nada de `apt-get`, `sudo`, ni Docker de Linux** (`Docker@2`, `container:`, service
     containers).
   - Tareas **solo Windows** (`powershell:` de Windows PowerShell, `VSBuild`, `MSBuild`,
     `AzureFileCopy`, BcContainerHelper) no corren. `pwsh:` sirve si PowerShell 7 está
     instalado en el agente.
   - **`UsePythonVersion@0` falla** en el agente autoalojado: busca en el *tool cache* y el
     Python del Mac viene de python.org (framework), que esa tarea no ve, **aunque esté
     instalado**. Quítala y usa el `python3` del `PATH`, comprobando la versión en un paso.
     `NodeTool@0`/`UseNode@1` sí descargan Node darwin-arm64 al tool cache y funcionan (el
     primer pipeline migrado pasó en verde con `NodeTool@0`); aun así, `corepack enable` y
     `npm install -g` modifican la instalación del Mac, que es compartida por todos los runs.
   - **`/bin/bash` de macOS es la 3.2**: con `set -u`, expandir un array vacío
     (`"${arr[@]}"`) da *unbound variable*. Protégelo (`${arr[@]+"${arr[@]}"}`) o hazlo en Node.
   - **`python3`, no `python`**: el instalador de python.org no crea `python`.
   - **La máquina no se destruye entre ejecuciones**: `/tmp` y lo que dejes fuera del
     directorio de trabajo sobreviven al siguiente run. Crea venvs y temporales dentro de
     `$(Agent.TempDirectory)`, no en rutas fijas.
   - Lo que el pipeline necesite tiene que estar instalado en la máquina. Desde el
     2026-09-22 hay: `az`, `python3` (3.14) y `python3.12`, PostgreSQL 16 como servicio
     local, Rust (rustup) con rustfmt y clippy, `pwsh`, `gh`, node, `zip`/`unzip`/`rsync`,
     dotnet. **No hay contenedores**: Docker Desktop está instalado pero su demonio no
     arranca solo, y los contenedores de servicio (`services:`) no existen en agentes macOS;
     una base de datos para tests se usa del servicio local. `sudo` pide contraseña: un paso
     con `sudo` se queda colgado o falla. Si falta algo, se instala en el Mac (no desde el
     pipeline) y se reinicia el agente para que publique sus capacidades.
4. **Binarios nativos: no se empaqueta en el Mac lo que se compila para el servidor.**
   Lo que `npm`/`pnpm`/`pip` instalan en el agente es **darwin-arm64** (sharp, swc,
   bcrypt, wheels de Python…). Si el artefacto lleva `node_modules` o un venv instalado en
   el Mac, al App Service Linux/Windows le llegan binarios que no puede cargar. Por eso el
   **arquetipo A** (sin `node_modules`, instala en destino) es el bueno; el **arquetipo B**
   (`pnpm install --prod` dentro del artefacto) **se rompe en el Mac** y hay que pasarlo a
   instalar en destino antes de migrarlo. Los arquetipos C/D ya instalan en destino (Oryx).
5. **La política de build de una PR a veces se queda `queued` sin crear ejecución.** Se
   relanza a mano:

   ```bash
   az repos pr policy list --id <PR> --org https://dev.azure.com/DevConsultIA   # saca el evaluationId
   az repos pr policy queue --id <PR> --evaluation-id <evaluationId> --org https://dev.azure.com/DevConsultIA
   ```
6. **Tras fusionar, el CI tarda unos minutos en encolarse.** No es un trigger roto: espera
   la ejecución `individualCI` del commit (`az pipelines runs list ... --query
   "[].{motivo:reason,commit:sourceVersion}"`) y no lances otra a mano, o despliegas dos veces.

El inventario de qué pipeline está ya migrado y cuál no vive en el conocimiento interno
(`conocimiento/extraido/devconsultia-release-and-deploy.md`), no aquí.

### 2.0 Dónde se despliega AHORA: la suscripción de patrocinio (verificado 2026-08-11)

**Léelo antes de tocar cualquier despliegue web.** El 2026-08-11 (REQ-000345) las App Services se repartieron entre **dos suscripciones de Azure** del mismo tenant: casi todas se movieron a una suscripción de **patrocinio**, y una sola se quedó en la de pago de siempre (su certificado gestionado no es movible y bloquea el grupo entero). Los nombres de app y de grupo de recursos son **los mismos** en las dos, así que un comando escrito antes de esa fecha parece correcto y apunta al sitio equivocado.

**Consecuencias prácticas:**

- **Todo comando `az` necesita `--subscription`.** Sin él, la CLI usa la suscripción por defecto (la de pago) y dirá que la app no existe, o peor: hay grupos de recursos con **el mismo nombre en las dos suscripciones y contenido distinto dentro**, así que puede operar sobre el equivocado sin avisar.
  ```
  az webapp start -n <app> -g <rg> --subscription <ID-de-suscripcion>
  ```
  Los IDs concretos están en el inventario interno de infraestructura; `az account list -o table` los lista.
- **Las service connections de los pipelines apuntaban a la suscripción vieja** *(verificado y resuelto 2026-08-25, REQ-000485)*. El síntoma engaña: `Resource '<app>' doesn't exist. Resource should exist before deployment`, con la app existiendo — la SC mira en la otra suscripción. Arreglo, sin secretos porque son Workload Identity Federation: rol **acotado al grupo de recursos** de la app para el service principal de la SC, cambiar `subscriptionId`/`subscriptionName` del endpoint por REST (el `az devops service-endpoint update` no sabe), y nombrar `resourceGroupName` en `AzureWebApp@1`. **Al migrar una SC, mira a qué app apunta cada rama**: una rama con el nombre de app copiado de otra se arma y despliega encima de producción ajena.

  **Cómo dejar un pipeline desplegando a la sub de patrocinio (patrón verificado 2026-08-18; es el estándar para toda web nueva o que se migre):**
  1. **Service connection Workload Identity Federation (WIF), sin secreto.** Se crea entera por API: App Registration propia → credencial federada (emisor Azure DevOps, `subject` que devuelve el propio endpoint al crearlo) → el service endpoint `azurerm` en modo `WorkloadIdentityFederation`/`Manual`. Cero contraseñas, cero PAT. (El portal de Azure DevOps lo hace en 5 clics con WIF "automatic"; por CLI es el flujo manual de tres objetos.)
  2. **RBAC de mínimo privilegio: rol Contributor SOLO en el grupo de recursos de esa app**, no en toda la suscripción (las SC viejas eran de ámbito suscripción; no lo copies). El `az role assignment create` de esta org falla con `MissingSubscription`: se asigna por REST (mismo patrón que el Key Vault en `devconsultia-credenciales`).
  3. **Deploy con `AzureCLI@2` + `az webapp deploy --clean true` (OneDeploy), NO `AzureWebApp@1`.** Es el MISMO mecanismo que ya se usa a mano, y `--clean` reemplaza wwwroot por completo. **Imprescindible:** `AzureWebApp@1` hace MERGE y deja restos de builds anteriores (`node_modules` viejo, `src/`, `node_modules.tar.gz` de un Oryx previo, chunks `.next` obsoletos) que rompen el arranque del contenedor con **exit 243**. Añade `--track-status false` o el paso se cuelga sondeando la salud del runtime mucho después de que el OneDeploy ya terminó (la salud la valida el smoke test).
  4. **Feed privado: prueba antes de pedir permisos.** Si el pipeline corre con `jobAuthorizationScope: projectCollection`, la identidad del `npmAuthenticate@0` es el **Project Collection Build Service**, que en la casa ya tiene acceso de lectura al feed de organización **sin conceder nada** (verificado: el `pnpm install` del paquete privado pasó a la primera). Sólo si da 401 aplica el gotcha `reader` por proyecto de §2.5.

  Los nombres concretos (qué SC, qué app, qué identidad, qué pipeline de ejemplo) están en el inventario interno.
- **Recursos que NO se movieron** y siguen en la de pago: el Key Vault de la casa, los dos componentes de Application Insights, la cuenta de almacenamiento de copias y un Cognitive Services. Las apps los siguen consumiendo por cadena de conexión, que no cambia.

**Esto es temporal y tiene fecha de caducidad: el 28-11-2026.** El patrocinio son 5.000 USD de crédito con ventana 10-jul-2026 → 28-nov-2026; al vencer, una suscripción patrocinada se deshabilita si no se convierte a Pay-As-You-Go. Antes de esa fecha hay que decidir el destino definitivo. No escribas automatismos que den por permanente esta suscripción.

### Los pipelines

Los cuatro despliegan a Azure App Service Linux con `AzureWebApp@1` (una web nueva o migrada usa OneDeploy con `--clean`, §2.0), `pr: none`, y terminan con smoke test HTTP con reintentos (`continueOnError: true`, o sea: el smoke test avisa pero no revierte). Se escribieron con `vmImage: ubuntu-latest`; el pool tiene que ser `name: Default` (§2.00), y un pipeline que siga con `vmImage` falla.

**Fusionar a la rama principal NO despliega siempre.** Hay productos con `trigger: none` que se lanzan a mano eligiendo instancias, pipelines que solo compilan y webs sin pipeline que se despliegan con una receta escrita. Antes de decir que algo «ya está desplegado», o de fusionar algo que no quieres en producción, mira el `trigger` del `azure-pipelines.yml` de tu repo en `origin` y la tabla repo a repo del Manual: `C:/DevConsultIA-repos/.claude/docs/pipelines-que-despliegan.md`.

Van descritos por **arquetipo**, no por nombre: cuando toques un `azure-pipelines.yml` concreto reconocerás cuál de los cuatro es y sabrás qué esperar. Lo que cambia entre uno y otro es dónde viven los secretos y qué runtime arranca; el esqueleto es el mismo.

### 2.1 Arquetipo A — portal Next.js con secretos en variable group
> Desde el 2026-10-24 un portal Next nuevo, o uno que se toca, se despliega como el arquetipo F (§2.6): el `npm install` del arranque de abajo es lo que se quita.
- Trigger: el del `yml` de cada repo; muchos son `none` (`.claude/docs/pipelines-que-despliegan.md`). Node **24.x**, pnpm vía corepack.
- Gates: `pnpm run typecheck` + `pnpm run lint` (si fallan, no se publica).
- **Variable group** en la biblioteca de Azure DevOps con los secretos de build (secreto de cliente de BC, secreto de NextAuth, clave pública VAPID…). Ojo: una clave `NEXT_PUBLIC_*` se **incrusta en el bundle** durante el build — sólo valores públicos ahí.
- Artefacto: `.next` + `public` + `package.json` + `next.config.mjs`, **sin node_modules**; genera un `package-lock.json` en un directorio limpio para que el `npm install --omit=dev` del arranque sea reproducible.
- Destino: App Service `NODE|24-lts`, startup `npm install --omit=dev && npm start`. Smoke test contra la URL `*.azurewebsites.net` del App Service.

### 2.2 Arquetipo B — portal Next.js con la configuración en Application Settings
> Desde el 2026-10-24 lo que se migra a `Default` se hace como el arquetipo F (§2.6), no «cámbialo al artefacto del arquetipo A» como dice abajo.
- Trigger: el del `yml` de cada repo; muchos son `none` (`.claude/docs/pipelines-que-despliegan.md`). Node **22.x**, pnpm vía corepack.
- Gates: `typecheck` + `lint`. **Sin variable group**: la docena de env vars (NEXTAUTH_*, AZURE_AD_*, BC_*) viven como **Application Settings del App Service**; en build sólo se fija el flag de mock de auth a `false`.
- Artefacto: `.next` + public + configs, con `pnpm install --prod --frozen-lockfile --shamefully-hoist` **dentro** del artefacto (a diferencia del arquetipo A, aquí las dependencias viajan resueltas). **Incompatible con el agente macOS ARM** (§2.00, trampa 4): los binarios nativos saldrían darwin-arm64. Antes de pasarlo a `Default`, cámbialo al artefacto del arquetipo A.
- Destino: App Service `NODE|22-lts`, startup `npm start`.
- Ojo: alguno de estos repos arrastra además un **GitHub workflow legado** (Node 20, publish profile) que ya no es el vigente. Si ves dos mecanismos de deploy, el bueno es el de Azure DevOps.

### 2.3 Arquetipo C — SPA + backend FastAPI sobre Oryx
- Trigger: el del `yml` de cada repo; muchos son `none` (`.claude/docs/pipelines-que-despliegan.md`). Node **24.x** (frontend Vite/React, `npm ci` + build) + Python **3.14** (backend FastAPI).
- Gates: build del frontend + "backend import" (`pip install -r requirements.txt` y `import app.main`: barato, y caza la mitad de los errores de despliegue).
- Artefacto: `backend/` (sin venv/db/pycache) + `frontend/dist` + `requirements.txt` **en la raíz** (Oryx instala deps; requiere `SCM_DO_BUILD_DURING_DEPLOYMENT=true` en App Settings, y el flag propio de la app si embebe simuladores).
- Destino: App Service `PYTHON|3.14`, startup gunicorn+uvicorn `--chdir backend app.main:app`. Si la app va detrás de Easy Auth (Entra), el smoke test debe aceptar **200/302/401**: un 401 ahí significa que la app vive, no que falle.

### 2.4 Arquetipo D — igual que C, con tests de dominio como gate
- Misma arquitectura que el arquetipo C (Node 24 + Python 3.14).
- Gates: build frontend + import backend + **una suite de tests reales de dominio** (en el caso vivo, coherencia contable: cuadres, intercompañía a cero, cashflow). Es el único pipeline con tests que comprueban resultados, no sólo que el código arranca.
- Artefacto: igual que C, excluyendo el directorio de datos: la base embebida (DuckDB) persiste en `/home/data` entre deploys y **no debe viajar en el artefacto** o la machacas en cada release.
- Destino: App Service `PYTHON|3.14`, mismo startup gunicorn. Smoke test contra un endpoint de salud propio.

### 2.5 Arquetipo E — publicar un paquete npm privado (añadido 2026-08-08)

El primero que **publica un paquete** en vez de desplegar un sitio. Node 24 + pnpm, gates
`typecheck` + `test` + `build`, y `npmAuthenticate@0` + `npm publish` sólo en la rama
principal (en PR se compila y se testea, pero no se publica: así una PR valida sin quemar
versión).

Feed de destino: el feed **`DevConsultIA`** de Azure Artifacts, con ámbito de organización
(no de proyecto). Registro:
`https://pkgs.dev.azure.com/DevConsultIA/_packaging/DevConsultIA/npm/registry/`.

#### Gotcha: `403 ... You need to have 'AddPackage'`

**Es el fallo con el que arranca todo pipeline de publicación nuevo.** Compila bien, pasa
los tests, `npmAuthenticate` dice que todo correcto, y revienta en el `npm publish`:

```
npm error 403 Forbidden - User '...' lacks permission to complete this action.
You need to have 'AddPackage'.
```

Causa: el **build service del proyecto** no tiene permiso de escritura sobre el feed. Ojo
al detalle que despista — puede haber ya un build service listado en los permisos del feed
con rol **`collaborator`**, y parece que está resuelto. No lo está: `collaborator` guarda
paquetes de upstream y lee, pero **no publica**. Hace falta **`contributor`**. Y el permiso
es **por proyecto**: publicar desde un repo de otro proyecto vuelve a dar el mismo 403.

Arreglo. `az devops invoke` **no sirve** aquí (falla con
`could not convert string to float: '7.1.1'` al parsear la api-version), así que se va a la
API REST con un token:

```bash
# 1. Token para el recurso Azure DevOps (ese GUID es fijo, es el App ID de ADO)
TOKEN=$(az account get-access-token --resource 499b84ac-1321-427f-aa17-267ca6975798 --query accessToken -o tsv)

# 2. ID del feed
az devops invoke --area packaging --resource feeds --organization https://dev.azure.com/DevConsultIA \
  --api-version 7.1-preview --query "value[?name=='DevConsultIA'].id" -o tsv

# 3. Ver quién tiene qué (para confirmar el diagnóstico antes de tocar nada)
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://feeds.dev.azure.com/DevConsultIA/_apis/packaging/Feeds/<FEED_ID>/permissions?api-version=7.1-preview.1"

# 4. Conceder contributor al build service del proyecto que publica.
#    Descriptor: Microsoft.TeamFoundation.ServiceIdentity;<ORG_ID>:Build:<PROJECT_ID>
#    El ORG_ID sale de cualquier descriptor ya presente en el paso 3; el PROJECT_ID, de la
#    URL de cualquier build de ese proyecto.
DESC="Microsoft.TeamFoundation.ServiceIdentity;<ORG_ID>:Build:<PROJECT_ID>"
curl -s -X PATCH -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" \
  -d "[{\"identityDescriptor\":\"$DESC\",\"role\":\"contributor\"}]" \
  "https://feeds.dev.azure.com/DevConsultIA/_apis/packaging/Feeds/<FEED_ID>/permissions?api-version=7.1-preview.1"
```

Los pasos 2 y 3 resuelven `<FEED_ID>` y `<ORG_ID>` sin que tengas que conocerlos de antemano;
el `<PROJECT_ID>` sale de la URL de cualquier build del proyecto. Los valores ya resueltos
para los proyectos que publican están en el inventario interno.

#### Otras dos cosas de este pipeline

- **`NodeTool@0` está deprecada** y lo avisa en cada ejecución. Usa **`UseNode@1`**, que
  toma la versión en el input `version` (no `versionSpec`).
- **npm no republica una versión existente.** Sube `version` en `package.json` en el mismo
  commit que cambie el código, o el run falla en el último paso con *"cannot publish over
  previously published version"*.

#### Receta: añadir una dependencia privada a un portal que ya despliega

**Hazlo entero o rompes el deploy.** Se comprobó a base de romperlo dos veces seguidas en un
portal el 2026-08-09. Producción no se cayó —el pipeline falla antes de publicar y sigue
sirviendo la versión anterior— pero el despliegue queda bloqueado hasta arreglarlo.

**1. `.npmrc` en el repo**, sólo con el scope (nunca `registry=` a secas):

```
@devconsultia:registry=https://pkgs.dev.azure.com/DevConsultIA/_packaging/DevConsultIA/npm/registry/
always-auth=true
```

**2. `npmAuthenticate@0` ANTES del install**, en el pipeline:

```yaml
- task: npmAuthenticate@0
  displayName: 'Autenticar contra Artifacts'
  inputs:
    workingFile: .npmrc

- script: pnpm install --frozen-lockfile
```

Sin esto: `ERR_PNPM_FETCH_401 ... Unauthorized`.

**3. Permiso de lectura del feed para el build service DE ESE PROYECTO.** Es el mismo
gotcha de §2.5 pero desde el lado del consumidor: el permiso es **por proyecto**, y que
otro proyecto ya lo tenga no sirve de nada. Rol `reader`, descriptor
`Microsoft.TeamFoundation.ServiceIdentity;<ORG_ID>:Build:<PROJECT_ID>`, por la API REST
(ver §2.5).

**4. La dependencia va en `devDependencies`, NO en `dependencies`.**

Ésta es la que no se ve venir. Los portales del arquetipo A despliegan el artefacto **sin
`node_modules`** y App Service los instala al arrancar con `npm install --omit=dev`. **Ahí
no hay credenciales del feed privado**, así que un paquete de scope privado no se puede
resolver nunca: `E404 Not Found - GET https://registry.npmjs.org/@devconsultia%2f<paquete>`.

La salida fácil sería poner un PAT en los App Settings. **No lo hagas**: es exactamente lo
que costó una limpieza de 103 repositorios (ver `devconsultia-secrets-and-config`, sección
del PAT en los remotos).

La salida correcta: **Next empaqueta el paquete dentro de `.next` durante el build**, así
que en ejecución no hace falta. Verificado en un portal real — el código aparece inlineado
en `.next/server` y sólo los `.map` lo referencian por nombre. Comprobar así antes de
fiarse:

```bash
grep -rl "una cadena distintiva del paquete" .next/server   # debe encontrarlo
```

Deja un comentario en el `package.json` explicando por qué está en `devDependencies`, o
alguien lo "arreglará" moviéndolo y romperá el deploy otra vez.

**5. Si el pipeline genera el `package-lock.json` en un directorio limpio** (patrón del
arquetipo A, para que el `npm install` del arranque sea reproducible), **cópiale el
`.npmrc`** o fallará al resolver el scope privado. Y bórralo después, para que no viaje al
artefacto con credenciales dentro.

**6. Si el artefacto lleva un `.npmrc`, ESCRÍBELO de cero — no lo copies.**

El más peligroso, y no salta a la vista. Algunos portales copian su `.npmrc` al artefacto
porque el arranque lo necesita por otros motivos (caso real: `legacy-peer-deps=true`, porque
`lucide-react` declara peer React ^16/17/18 y el proyecto usa 19, y npm es estricto donde
pnpm no lo era).

El problema: **`npmAuthenticate@0` escribe las credenciales del feed DENTRO de ese
`.npmrc`**. Copiarlo al artefacto despliega el token al App Service en texto plano.

Escribe en el artefacto un `.npmrc` mínimo, sólo con lo que el arranque necesita:

```bash
printf '%s\n' \
  '# lucide-react declara peer React ^16/17/18 y aqui hay 19: npm es' \
  '# estricto y fallaria con ERESOLVE en el arranque sin esto.' \
  'legacy-peer-deps=true' > "$DEPLOY_DIR/.npmrc"
```

El `.npmrc` del repo —con credenciales— sólo debe ir al directorio temporal donde se genera
el `package-lock.json`, que se borra al terminar.

**Antes de dar por buena la adopción, comprueba a dónde va el `.npmrc`:**

```bash
grep -n "npmrc" azure-pipelines.yml
```

**Quién tropieza con esto:** todo portal que despliegue **sin `node_modules`** dejando que
App Service instale al arrancar (arquetipo A) o que copie su `.npmrc` al artefacto. El
estado de adopción portal a portal se lleva en el inventario interno, no aquí; la receta es
la misma para todos.

**Ojo con lo que BC mete en sus propios mensajes.** Que el paquete no ponga la URL en
`detail` no basta: ante un 404, BC responde *"No HTTP resource was found that matches the
request URI 'https://…/companies(GUID)…'"* con la URL entera dentro del cuerpo. Si un
portal enseña al usuario el mensaje que viene en `detail`, tiene que **limpiarlo antes**.
Hay implementación de referencia (`describeBCError` y `sanear`) en el `src/lib/api.ts` de
los portales que ya lo resolvieron: cópiala en vez de reinventarla.

#### Consumir el paquete desde un portal

En el repo consumidor, un `.npmrc` que mande **sólo el scope** al feed. Si se pone
`registry=` a secas, toda dependencia pública pasa por el feed y exige autenticación:

```
@devconsultia:registry=https://pkgs.dev.azure.com/DevConsultIA/_packaging/DevConsultIA/npm/registry/
always-auth=true
```

Y en su pipeline, `npmAuthenticate@0` sobre ese fichero **antes** del `pnpm install`.

**Runbook deploy web:** la checklist web (§6).

### 2.6 Arquetipo F — portal Next.js con el paquete montado: standalone, node_modules de Linux y RUN_FROM_PACKAGE (añadido 2026-10-24, REQ-002465)

**Es el que se usa en un portal Next nuevo o al tocar el pipeline de uno de A o B** (el `npm install` del arranque de §2.1 y §2.2 es lo que se quita).

- **Zip:** el `standalone` de Next (`output: 'standalone'`) + `.next/static` + `public` + un `node_modules` instalado **para Linux x64** (`npm ci --omit=dev --ignore-scripts --os=linux --cpu=x64 --libc=glibc`): el agente es macOS ARM y el PC win32, su `node_modules` no vale en el servidor.
- **Arranque:** `WEBSITE_RUN_FROM_PACKAGE=1` y comando de inicio `node server.js`. Se despliega sin `--clean` ni parar el sitio. Medido en el Mac mini: humo de 9-14 min a 83 s en un B1; en portales que ya iban en 3-4 min, 0 a 2 min: no migres por migrar.
- **Humo:** un 200 de `/login` lo da también el contenedor viejo. Sondea cada 5 s `/_next/static/<BUILD_ID>/_buildManifest.js` o un `/api/salud` con el commit.
- **Trampas:** `node_modules/.bin` son enlaces en macOS y el zip no los guarda (se borran); los externalizados de Turbopack (`sharp-<hash>`, `pg-<hash>`) pasan a carpetas reales; `@devconsultia/bc-client` sigue en `devDependencies` y el paquete no lleva el `.npmrc`; dependencia nueva con binario nativo, se revisa para linux-x64.
- **Plantilla con scripts, pipeline, primera ejecución y vuelta atrás:** `C:/DevConsultIA-repos/.claude/plantillas/web-standalone/README.md`. Variante Python (C y D): ver README.
---

## 3. Versionado

### Estado real (verificado)
- `app.json` versions inconsistentes entre repos: desde `0.1.0.0` en apps recién arrancadas y `0.7.0.0` en alguna en desarrollo, hasta `1.0.0.93` en la más iterada, con ~20 repos parados en `1.0.0.0`. El patrón dominante de facto es `1.0.0.N` con N = contador de releases; **no hay semver**: cambios funcionales grandes solo suben el cuarto dígito.
- Commits: la convención vigente de la casa es `REQ-nnnnnn: qué y por qué` (CLAUDE.md de `C:\DevConsultIA-repos`). En el historial antiguo verás prefijos `[FIX]`, `[ADD]`, `[MOD]`, `[OPT]`, `[REQ-000xxx]` o ninguno.

### Estándar propuesto (PROPUESTA — no vigente)
- **app.json**: semver real en los tres primeros dígitos + build en el cuarto: `MAJOR.MINOR.PATCH.BUILD`. MAJOR = breaking (schema, permisos, API), MINOR = funcionalidad nueva, PATCH = fix, BUILD = autoincremento. Migración: congela la versión actual y a partir de ahí aplica la regla (una app en `1.0.0.93` → siguiente fix `1.0.1.94`).

---

## 4. Ramas

- Rama principal: **`master`** en la mayoría de repos (AL y web); **`main`** en unos pocos, casi siempre los más recientes; y en algunos la rama por defecto del remoto es otra (`Fix`, `Independiente`, `V13`…). Míralo antes de hacer push: no lo des por hecho.
- El trabajo va en una rama de la petición (`REQ-nnnnnn-…`) y entra por PR en Azure DevOps; en web, fusionar despliega solo donde lo dice el `trigger` del `yml` (tabla en `.claude/docs/pipelines-que-despliegan.md`). Algunos repos tienen política de rama que lo exige.
- Hay ramas muertas sin merge en varios repos (experimentos de fix, pruebas de parámetros, intentos de quitar una dependencia). Antes de dar una rama por la buena, mira cuál es la de por defecto y de cuál salió lo instalado.

---

## 5. PROPUESTA: CI/CD para AL

El CD de AL (publicar desde un pipeline) no existe: se publica con §1.0. Lo que sí existe es compilar AL en CI en el agente de la casa (al final de esta sección); el resto es propuesta.

**Opción A — AL-Go for GitHub** (recomendada si se migra a GitHub): plantilla oficial de Microsoft (`microsoft/AL-Go-PTE`). Da build en contenedores/compilerfolder, versionado automático, dependencias entre repos vía `useProjectDependencies`/artefactos de GitHub, releases firmadas y entrega a environments.
Primeros pasos concretos:
1. Piloto con UN repo pequeño y **sin dependencias** — los hay: apps de utilidad con el bloque `dependencies` vacío. Empezar por una app con dependencias es garantía de abandonar el piloto.
2. Crea el repo GitHub desde la plantilla AL-Go-PTE, copia `src/` y `app.json`, ajusta `.AL-Go/settings.json` (país `es`, versión BC objetivo).
3. Verifica que el workflow *CI/CD* compila y genera el `.app` como artefacto.
4. Elimina los `.app` y `.alpackages` del control de versiones (añádelos a `.gitignore`); los symbols los trae el build.
5. Extiende a un repo con dependencias reales usando AppSourceContext/artefactos en vez de los repos wrapper de dependencias.

**Opción B — pipeline AL en Azure DevOps** (si se quiere seguir en Azure DevOps, reutilizando lo que ya se sabe de los 4 pipelines web): pipeline con BcContainerHelper (`Run-AlPipeline`) o compilación con `alc.exe` + `Assemble/publish` del `.app` como artefacto de build, y publicación a sandbox vía Admin API / PowerShell como stage manual aprobado.
Primeros pasos: variable group con credenciales del sandbox y el mismo patrón de gates que los pipelines web (compilar = gate, CodeCop/AppSourceCop = gate).

**Compilar AL en el agente de la casa (macOS ARM), verificado 2026-09-22.** BcContainerHelper no corre allí, pero no hace falta: el compilador es .NET gestionado y corre nativo con el `dotnet` del agente. Un repo AL ya compila así en CI, en unos 40 s:

```yaml
pool:
  name: Default
steps:
  - pwsh: |
      $v = '18.0.41.62505'   # Microsoft.Dynamics.BusinessCentral.Development.Tools (el paquete base, NO el .Osx)
      $d = "$(Agent.TempDirectory)/altool"
      Invoke-WebRequest "https://api.nuget.org/v3-flatcontainer/microsoft.dynamics.businesscentral.development.tools/$v/microsoft.dynamics.businesscentral.development.tools.$v.nupkg" -OutFile "$d.zip"
      Expand-Archive "$d.zip" $d -Force
      $alc = Get-ChildItem $d -Recurse -Filter alc.dll | Where-Object FullName -match 'net10\.0|net8\.0' | Select-Object -First 1
      dotnet $alc.FullName /project:. /packagecachepath:.alpackages /generatecode+ /outfolder:$(Build.ArtifactStagingDirectory)
    displayName: Compilar AL
```

- Todo bajo `$(Agent.TempDirectory)`: nada de `dotnet tool install --global` en una máquina compartida.
- Los **símbolos** (`.alpackages`) tienen que llegar de algún sitio (descarga desde almacenamiento, o desde el sandbox con credenciales de la bóveda): sin ellos no compila en ningún sistema.
- La herramienta `al` que instala el paquete sirve para utilidades, no para compilar: el compilador es `alc.dll`.
- Con ALCops: plantilla `plantillas/azure-pipelines/compilar-al.yml` del Manual.

En ambas opciones el criterio de éxito es el mismo: **el `.app` de producción sale de un build de CI, no de la máquina de nadie, y deja de commitearse al repo.**

---

## 6. Checklist de release

### AL (flujo actual, hasta que exista CI) — el detalle de cada paso está en §1.0
1. [ ] Rama al día con `master`/`main`; sin cambios sin commitear ajenos al release.
2. [ ] Sube la versión en `app.json` antes de compilar (hoy: +1 al cuarto dígito; con la propuesta: semver).
3. [ ] Symbols actualizados contra el sandbox del cliente (descarga symbols si la dependencia cambió; si usa un repo wrapper de dependencias, confirma que tiene la versión que declara `app.json`).
4. [ ] Compila sin errores ni warnings nuevos (`Ctrl+Shift+B`).
5. [ ] Traducciones: regenera/revisa el `.xlf` si hubo labels nuevos y tradúcelos antes de compilar el `.app` final.
6. [ ] Publica en **Sandbox** con `publicar-app-al.mjs` y prueba el caso de uso del cambio (no solo que instala).
7. [ ] Production: el mismo `.app`, sin recompilar, con `publicar-app-al.mjs --entorno Production --si-production`. Confirma la versión instalada y relanza las colas.
8. [ ] Commit `REQ-nnnnnn: qué y por qué` y push. Si otra app consume ésta como dependencia, actualiza el repo wrapper correspondiente.
9. [ ] **El `.app` NO se commitea** (`.gitignore` con `*.app` y `.alpackages/`); el binario publicado queda en `C:DevConsultIA-archivoapps-publicadas`.

### Web
0. [ ] **¿En qué suscripción está la app?** Hay dos y los nombres se repiten en ambas (sección 2.0). Cualquier `az webapp` sin `--subscription` puede apuntar al sitio equivocado, y la service connection del pipeline puede estar aún atada a la suscripción vieja.
0b. [ ] **¿El pipeline usa `pool: name: Default`?** Con `vmImage` falla por falta de minutos. Si es su primera vez en `Default`, autorízalo sobre la cola (§2.00, trampa 1).
1. [ ] `typecheck`/`lint`/tests en local antes del push (los gates del pipeline fallarán igual, pero en local es más barato).
2. [ ] Si añades una env var: créala en el variable group (arquetipo A) o en Application Settings del App Service (arquetipo B) ANTES de mergear; las `NEXT_PUBLIC_*` se incrustan en build.
3. [ ] Fusiona a la rama principal → el pipeline dispara solo. No lances otra a mano (§2.00, trampa 6).
4. [ ] Run verde: todos los gates OK.
5. [ ] Smoke test OK en el log — si falló (es `continueOnError`), abre la URL del App Service y revisa Log stream antes de dar por bueno el deploy.
6. [ ] Prueba manual del flujo crítico en la URL de producción (login + una operación).

---

## Provenance y mantenimiento

- **Fuente**: repos clonados, **2026-07-06**: los 4 `azure-pipelines.yml` completos, los `.app`, los `app.json`, `git log` y ramas.
- **Sección 2.0** (cambio de suscripción): verificada el **2026-08-11** con `az resource/appservice plan/webapp list` en ambas suscripciones, tras el movimiento de REQ-000345; service connections resueltas el 2026-08-25 (REQ-000485).
- **Sección 2.00** (agente autoalojado): verificada el **2026-09-22** con el agente en el grupo `Default` y el primer pipeline migrado en verde (~2 min). El estado de migración pipeline a pipeline está en el conocimiento interno.
- **Neutralización (2026-08-16, REQ-000380)**: esta skill es de núcleo y se empaqueta también en repositorios de cliente, así que se le quitaron todos los nombres de cliente, repo, App Service, endpoint, entorno y tenant. Las reglas están completas; sólo cambiaron los ejemplos, que ahora son genéricos. **El material nominal retirado está íntegro en `conocimiento/extraido/devconsultia-release-and-deploy.md`** — si necesitas el dato concreto, va ahí, y no vuelve a este fichero.
- **Mantenimiento**: revisa esta skill cuando (a) se cree cualquier pipeline AL o se adopte AL-Go — la sección 5 pasa de PROPUESTA a real; (b) se añada un pipeline web que no encaje en ninguno de los arquetipos de la sección 2; (c) se formalice la convención de versionado/commits — mueve la sección 3 de propuesta a verificado con fecha nueva; (d) **llegue noviembre de 2026**: al caducar el patrocinio el 28-11-2026 la sección 2.0 queda obsoleta de golpe y hay que reescribirla con el destino definitivo.
- **Al cambiar una skill**, antes de la PR: `node herramientas/generar-executor-mobile.mjs`, `node herramientas/generar-contexto.mjs` **sin argumentos** (`--todos` o `--destino` generan de más) y `node herramientas/topes-contexto.mjs` (va justo: recorta y cierra con `--ajustar`).
- Al actualizarla, **no vuelvas a meter nombres propios**: si el dato sólo se entiende nombrando un cliente o un repo, es que pertenece al conocimiento interno o a la skill de ese cliente, no aquí.
- Cifras (94 `.app` en el repo peor, versión `1.0.0.93`, etc.) son instantáneas de la fecha de verificación: re-verifícalas antes de citarlas como actuales.
