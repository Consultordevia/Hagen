<!-- GENERADO — NO EDITAR -->

# devconsultia-secrets-and-config

*Copia generada de `skills/devconsultia-secrets-and-config/SKILL.md` del Manual. GENERADO — NO EDITAR:*
*si algo de aquí está mal o desactualizado, se corrige en el Manual, no aquí.*

---

---
name: devconsultia-secrets-and-config
description: 'Gestión de secretos en DevConsultIA: qué hacer al encontrar uno en código/README/git, runbook de rotación y dónde deben vivir por stack (Isolated Storage, .env, variable groups). Usar ante cualquier secreto expuesto. Triggers: "secreto", "api key", "client_secret", "Key Vault", "rotación".'
---

# Secretos y configuración en DevConsultIA

**Fecha:** 2026-07-06. **Audiencia:** quien trabaje en los repos de `C:\DevConsultIA-repos`.

Esta skill nace de **incidentes reales**: hay secretos commiteados en claro en varios repos. Aquí está el inventario, el runbook de remediación y las reglas para que no vuelva a pasar.

## Cuándo NO usar esta skill

- Configuración funcional de una app (setup tables, parámetros de negocio, feature flags): usa la skill del stack correspondiente (`devconsultia-al-standard`, `devconsultia-al-integrations`, `devconsultia-node-standard`).
- Patrones de llamada HTTP/autenticación desde AL: `devconsultia-al-integrations`.

## 1. Inventario de exposiciones conocidas (verificado a 2026-07-06)

Todos estos secretos están **en el historial de git** (y en cualquier clon), así que borrar el archivo o el valor no remedia nada: **la remediación es rotar la credencial**.

| Repo / archivo | Qué hay expuesto | Estado |
|---|---|---|
| `IABC__IABC/copilot_bc/config.py` | `OPENAI_API_KEY` (formato `sk-proj-...`) en claro, línea 14; además credenciales SQL de demo (`pruebas`/contraseña trivial) en `DB_CONFIG` | En historial de git → rotar la key de OpenAI |
| `IABC__IABC/Navision/database.py` | Connection string SQL Server con `UID=sa` y `PWD=...` en claro (servidor interno 192.168.202.111, BD de cliente), líneas 15-21 | En historial de git → rotar la password de `sa` en ese servidor |
| `Portal Devconsultia__Portal Devconsultia/docs/HANDOFF.md` | 2 client secrets de Entra (líneas ~151 y ~178) marcados en el propio doc como "(quemado, rotar)", más `NEXTAUTH_SECRET` y bloque `.env` completo (líneas ~198-219) | Documentado como quemado desde su creación (se pegaron en chats). Checklist pendiente en líneas ~711-712 → rotar en Azure Portal |
| `Portal Devconsultia__Portal Devconsultia/README.md` | Tenant IDs y client IDs (líneas ~197-199), referencia a los 2 client_secrets quemados (línea ~188) | IDs no son secretos por sí solos, pero el README confirma la deuda de rotación |
| `Factoria/.env.local.example` | `BC_CLIENT_SECRET` real de Entra en claro (más tenant/client/company IDs y nombre de environment Sandbox). El `.gitignore` excluye `.env.local` pero el **example está trackeado y commiteado con valores reales** en vez de placeholders | Detectado 2026-07-07. En historial de git → rotar el client secret en Azure Portal y dejar el example solo con placeholders |

Si al auditar encuentras una exposición nueva, añádela a esta tabla y ejecuta el runbook.

## 2. Runbook de remediación (imperativo, en este orden)

1. **Rota la credencial en el proveedor** (Azure Portal para client secrets, platform.openai.com para keys de OpenAI, SQL Server para logins). Hazlo antes de tocar el código: en cuanto el commit existe, el valor está comprometido.
2. **Sustituye el valor en el código por una variable de entorno** (o Isolated Storage en AL, ver §3). Nunca por otro literal.
3. **Verifica que no queda en el working tree**: ejecuta los greps de auditoría de §6 sobre el repo completo antes de commitear.
4. **Asume el secreto comprometido para siempre**: está en el historial de git y en todos los clones. No intentes reescribir historia (`filter-branch`/BFG) como remediación única — no elimina los clones ni las copias en chats. La rotación es lo único que invalida el valor.
5. **Actualiza el inventario de §1** si el incidente es nuevo, y marca la fila como rotada cuando lo esté.

## 3. Reglas por stack: dónde va cada secreto

### AL (Business Central)

- **Regla:** secretos (API keys, passwords, client secrets, tokens) en **Isolated Storage**, nunca en campos `Text` de tablas de setup. **Canon de DataScope en Isolated Storage: `DataScope::Module`** (aislamiento por app, compartido entre empresas). **Excepción documentada:** secretos intrínsecamente por empresa — p. ej. el certificado AEAT de TaxIA, distinto en cada empresa — usan `DataScope::Company`.
- **Ya lo hacen bien** (usar como referencia): varias apps de producto de la casa —gestión de certificados fiscales, conector CRM, facturación electrónica y proveedor de almacenamiento en la nube— resuelven esto con la misma forma: una **tabla de setup** con el campo del secreto marcado y el valor en Isolated Storage, más un asistente de configuración. Busca ese patrón con `grep -rl "IsolatedStorage" --include=*.al`; las rutas concretas están en el estado interno del portfolio (`devconsultia-portfolio-estado`).
- **Deuda técnica conocida** (campos Text plano con credenciales, verificado): `Carriers__Carriers` (tokens en `Tab50751.ConfigCarrier.al` y "Cliente secreto"/Token en `Tab-Ext50750.ShippingAgent.al`), `EDI__EDI` (`Client_Secret`/`Password`/`Token` en `Tab50900.EDICredenciales.al` y `Tab50907.EDISetup.al`), `PrintNode__PrintNode` ("PrintNode API Key" en `Tab50600.PrintNodeSetup.al`), `B2Chat__B2Chat` (Token en `Tab71800.ConfiguracionB2Chat.al`), `Integraciones Marketplaces__Mirakle` (`ApiKey` en `Tab60100.MiraklSetup.al`).
- Si tocas uno de esos módulos, no repliques el patrón: migra el campo a Isolated Storage o al menos ponlo `ExtendedDatatype = Masked` y déjalo anotado.

### Node / Next.js

- **Local:** `.env` / `.env.local`, siempre en `.gitignore`. Nunca commitear ejemplos con valores reales; usa `.env.example` con placeholders.
- **CI/CD:** variable groups de Azure Pipelines. El patrón de la casa: el `azure-pipelines.yml` declara `variables: - group: <nombre-del-grupo>` y **los secretos viven en la Library de Azure DevOps, nunca en el YAML**. Si ves un valor sensible escrito en el pipeline, está mal por definición: el YAML se lee con solo tener acceso al repositorio.

### Python

- **Patrón:** `.env` + `os.getenv("VAR", "default-mock")`. La referencia de la casa vive en los servicios FastAPI, en `backend/app/integrations/*/config.py`: cada integración (BC, correo transaccional, M365) lee de entorno con **defaults inocuos de modo mock** (`"sim-client"`, `"sim-secret"`), de forma que el repositorio arranca y se prueba **sin un solo secreto real**. Ese es el criterio: si el repo no funciona sin secretos, la configuración está mal hecha.
- Anti-patrón a evitar: `IABC__IABC` (§1) — literales en `config.py` y connection strings hardcodeadas.

## 4. Dónde SÍ viven los secretos hoy

- **Variable groups de Azure DevOps** (Library) para pipelines.
- **App Service configuration** (application settings) para apps desplegadas en Azure.
- **Isolated Storage** dentro de Business Central para extensiones AL.
- **Azure Key Vault `kv-devconsultia`** para las credenciales BC de cada cliente (`devconsultia-credenciales`). Referenciarlo desde variable groups y App Service (en vez de copiar el valor) sigue siendo propuesta.

## 5. Regla para Claude y desarrolladores

- Un secreto no se commitea, ni "temporalmente" ni en una rama: queda en el historial.
- Tampoco va en docs, README, HANDOFF, comentarios de código, chats ni tickets. El HANDOFF del Portal es el contraejemplo: los secrets quedaron quemados por pegarse en chats y luego documentarse.
- Si generas archivos de configuración, usa placeholders (`<YOUR_API_KEY>`) o defaults mock.
- **Si ves un secreto real** en un repo: no lo copies a ningún sitio (ni a tu respuesta), avisa al responsable, añádelo al inventario de §1 y ejecuta el runbook de §2. En respuestas y docs, referencia solo ruta + tipo de secreto, jamás el valor.

## 6. Comandos de auditoría (copy-pasteables)

Ejecutar desde la raíz del repo a auditar (Git Bash / WSL; en PowerShell usar `git grep` igual):

```bash
# API keys de OpenAI y similares
git grep -nE 'sk-(proj-)?[A-Za-z0-9_-]{20,}'

# Passwords y connection strings
git grep -niE '(PWD=|Password=|password["'"'"']?\s*[:=]\s*["'"'"'][^"'"'"']{4,})'

# Client secrets / tokens / claves genéricas
git grep -niE '(client_secret|api[_-]?key|auth[_-]?token|nextauth_secret)\s*[:=]\s*["'"'"']?[A-Za-z0-9~._/+-]{12,}'

# Connection strings completas
git grep -niE '(Server=|Data Source=|SERVER=).*(UID=|User Id=|PWD=)'

# Buscar también en el historial (no solo working tree)
git log -p --all -S 'sk-proj-' --oneline | head -50
git log -p --all -S 'PWD=' --oneline | head -50
```

Cualquier hit sobre un valor real → runbook de §2.

## 7. PAT de Azure DevOps en los remotos (resuelto 2026-08-09)

Un PAT con permisos sobre toda la organización estuvo incrustado en la URL del remoto de
**103 repositorios** (`https://anything:<PAT>@dev.azure.com/...`) y se filtró por la salida
de `git remote -v`. Hoy los remotos están limpios (0 de 150 con credencial incrustada,
comprobado 2026-09-24) y autentica **Git Credential Manager**. La regla: no se clona ni se
configura un remoto con la credencial en la URL.

```bash
git clone https://DevConsultIA@dev.azure.com/DevConsultIA/{Proyecto}/_git/{Repo}
```

Para Azure DevOps, **GCM necesita la organización como usuario en la URL**, sin contraseña;
sin ella falla con *"Cannot determine the organization name for this 'dev.azure.com' remote
URL"*. Para limpiar remotos:

```powershell
C:\DevConsultIA-repos\.claude\limpiar-remotos.ps1 -DryRun     # ver qué haría
C:\DevConsultIA-repos\.claude\limpiar-remotos.ps1 -Verificar  # limpiar y comprobar
```

**Gotcha al verificar.** `git ls-remote --heads` sobre un repositorio **vacío** no devuelve
nada: comprueba `$LASTEXITCODE`, no si hay texto, o los repos vacíos saldrán como fallos.

**De quién es un PAT suelto** (la API de tokens sólo lista los del usuario autenticado; el de
2026-08-09 era de `xavi.gisbert@devconsultia.es` y no aparecía con otra cuenta):

```bash
curl -s -u ":$PAT" "https://dev.azure.com/DevConsultIA/_apis/connectionData?api-version=7.1-preview"
```

Devuelve `authenticatedUser`, que dice de quién es y si sigue vivo. **Revocar** se hace en
`https://dev.azure.com/DevConsultIA/_usersSettings/tokens`; la limpieza de remotos solo
cubrió esta máquina, así que antes de revocar comprueba que el PAT no lo usa otro portátil,
un pipeline o un script fuera del portfolio.

## Provenance y mantenimiento

- Contenido verificado el **2026-07-06** contra los repos de `C:\DevConsultIA-repos` (archivos y líneas citados en §1 y §3 comprobados uno a uno; los valores de los secretos NO se reproducen aquí a propósito).
- Para re-verificar el inventario, ejecuta los greps de §6 sobre `IABC__IABC`, `Portal Devconsultia__Portal Devconsultia` y cualquier repo nuevo, y comprueba los campos Text de setup en AL con:

```bash
grep -rniE 'field\([0-9]+; *"?[^;]*(Password|API ?Key|Secret|Token)[^;]*"?; *Text' --include='*.al' .
```

- Actualiza §1 (inventario) y §3 (deuda AL) cuando se rote una credencial o se migre un módulo a Isolated Storage. Actualiza la fecha de este bloque en cada revisión.
