<!-- GENERADO — NO EDITAR -->

# devconsultia-stack

*Copia generada de `skills/devconsultia-stack/SKILL.md` del Manual. GENERADO — NO EDITAR:*
*si algo de aquí está mal o desactualizado, se corrige en el Manual, no aquí.*

---

---
name: devconsultia-stack
description: 'El estándar técnico de DevConsultIA fuera de AL: stack, versiones y convenciones ya decididas, no propuestas. Cargar SIEMPRE al empezar un proyecto web/servicio nuevo o subir una dependencia mayor. Triggers: "proyecto nuevo", "qué stack", "qué versión uso", "convenciones".'
---

# El estándar de la casa

**Decidido el 2026-08-09.** Lo de aquí es lo que se usa, no una propuesta. Si algo te
parece mal, **cámbialo aquí primero** y luego en el código: apartarse en silencio es como el
portfolio llegó a tener cuatro versiones de Next, cuatro de TypeScript, dos gestores de
paquetes y dos convenciones de variables a la vez.

> Esta skill es de **núcleo**: se empaqueta en todos los repositorios, también en los de
> cliente. Por eso contiene **reglas, no inventario**. Qué proyecto concreto cumple ya cada
> decisión y cuál no es estado del portfolio y se consulta en el registro interno.

## Versiones

| Qué | Versión | Por qué esa |
|---|---|---|
| **Next.js** | **16.2.x** | Probado en producción en 4 portales. No arrancar nada en 14. |
| **React** | **19.2.x** | Va con Next 16. |
| **TypeScript** | **6.0.x** | Estable y ya en producción. **TS 7 (el reescrito en Go) NO todavía**: es demasiado nuevo para meterlo en dependencias compartidas. |
| **Tailwind CSS** | **4.3.x** | Con `@tailwindcss/postcss`. |
| **Node** | **24 LTS** en local y en App Service | Algún proyecto antiguo sigue en 22-lts; se sube cuando se toque. |
| **Gestor de paquetes** | **pnpm 9**, vía corepack | `packageManager` y `engines` **obligatorios** en el `package.json`. |
| **next-auth** | **4.24.x** | Ver abajo: es una decisión con fecha de revisión. |
| **zod** | 4.x | Validación de entrada y de entorno. |
| **SWR** | 2.x | Fetching en cliente cuando haga falta revalidar. |
| **Vitest** | 4.x | Tests. |
| **Astro** | **7.2.x** | Sólo la web corporativa (en 7.2.0 desde oct-2026). |
| **Rust** | **1.98.1**, edición 2024 | Sólo los productos en Rust. Crates y reglas: «Rust», abajo. |

**Fijar versiones, no rangos abiertos** en lo que decide el comportamiento (Next, React,
TypeScript). `engines` y `packageManager` van siempre: sin ellos el proyecto compila con lo
que haya en la máquina, y eso ya nos ha pasado.

### next-auth: por qué v4 y cuándo se revisa

Se queda en **v4**, que es la versión `latest` publicada y soportada.

**Auth.js v5 lleva años sin salir de beta** (`5.0.0-beta.32` a fecha de hoy, con
`@auth/core` en `0.41.3`, también pre-1.0). Migrar siete portales de producción —con 2FA,
multi-cliente y Entra— a una beta cuya API ha cambiado entre betas no compensa.

Esto **no es inercia, es una decisión con disparador**: se revisa cuando `next-auth@5` pase
a `latest`, o cuando Next deje de soportar v4 — lo que ocurra antes. Cuando pase, se migra
en bloque, no portal a portal.

## Business Central: una sola convención

Todo lo que hable con BC usa **`@devconsultia/bc-client`** (ver `devconsultia-bc-client-node`)
y **estos nombres de variable**, en Node y en Python:

```bash
BC_TENANT_ID=…        # GUID del tenant de Entra
BC_CLIENT_ID=…        # Application (client) ID
BC_CLIENT_SECRET=…    # el Value del secret, no su ID
BC_ENVIRONMENT=…      # nombre del entorno (Production, Sandbox…), no un GUID
BC_COMPANY_ID=…       # GUID de la empresa, NO su nombre

# API propia (nunca api/v2.0):
BC_API_PUBLISHER=devconsultia
BC_API_GROUP=…        # ojo: distingue mayúsculas
BC_API_VERSION=v1.0
```

`BC_BASE_URL`, `BC_TOKEN_URL` y `BC_SCOPE` no son configuración: se derivan de las
variables de arriba.

```
BC_BASE_URL  = https://api.businesscentral.dynamics.com/v2.0/{BC_TENANT_ID}/{BC_ENVIRONMENT}/api/{publisher}/{group}/{version}
BC_TOKEN_URL = https://login.microsoftonline.com/{BC_TENANT_ID}/oauth2/v2.0/token
BC_SCOPE     = https://api.businesscentral.dynamics.com/.default   (constante, no es config)
```

Por qué esta y no la otra: con tenant y entorno sueltos se puede construir **cualquier**
URL, mientras que a partir de una `BC_BASE_URL` ya montada no
se puede ir hacia atrás. Además es la que entiende el paquete compartido y la que usa la
bóveda de credenciales (`devconsultia-credenciales`).

### Cómo se retira una convención de configuración (REQ-000317 / REQ-000328, 2026-08-10)

La migración de los backends Python a la convención única está **cerrada del todo desde el
2026-08-10**: todos derivan ya las URL de `BC_TENANT_ID` + `BC_ENVIRONMENT`, `BC_SCOPE` ha
dejado de existir en el código —es una constante, no configuración—, y `BC_BASE_URL`,
`BC_TOKEN_URL` y `BC_SCOPE` no quedan en ningún App Setting. Si alguien las define, no se
leen. Antes de borrarlas se verificó, instancia por instancia, que la URL derivada era byte
a byte la misma que la `BC_BASE_URL` que tenían.

Se hizo en este orden, que es el que conviene repetir en cualquier retirada parecida:

1. Desplegar el código nuevo en todas las instancias, con el apaño todavía puesto.
2. Comprobar en el log de cada una que **no** aparece el aviso de convención antigua.
3. Borrar las variables viejas de los App Settings y **comprobar que todas las instancias
   siguen funcionando sin ellas**. Ese es el paso que da la prueba: si algo tirase del
   apaño en secreto, se cae aquí, con las variables a un comando de volver a poner.
4. Sólo entonces, quitar el código del apaño y volver a publicar.

Lo importante del orden es el punto 3: retirar la configuración antes que el código deja
un paso intermedio reversible en un segundo. Al revés —quitando el código primero— el
fallo aparece cuando ya hay que volver a compilar y desplegar para arreglarlo.

### Antes de publicar: mirar las RAMAS, no sólo el repo

Un repositorio **no** es una instancia. Un mismo repo puede alimentar varias instancias, y
alguna puede correr una **rama propia** en vez de `master`. Publicar `master` encima de una
de ellas el 2026-08-10 la dejó **caída unos 50 minutos**: arrancó contra un esquema que no
era el suyo e intentó dar de alta datos que pertenecían a otro despliegue.

Ni el `azure-pipelines.yml` ni el nombre de la web app lo avisan: hay pipelines que
despliegan **sólo** una de las instancias, y de las demás no hay ni rastro en el repo.

Antes de publicar en una instancia que no hayas publicado tú antes:

```bash
git ls-remote --heads origin        # ¿hay más de una rama?
```

Y si la hay, comprobar **cuál corre esa instancia** antes de subir nada — la vía rápida es
un endpoint que se identifique: un `/api/health` que devuelva el nombre de la instancia,
con un string que no exista en `master`. En un worktree (ADR-AIOS-001 R12),
`herramientas/aislar-worktree.mjs reservar` (del Manual) da puertos y
base propios (`.env.worktree`); `liberar` al quitarlo.

Corolario: el humo de después del deploy **no vale si lo contesta el contenedor viejo**.
Durante el relevo la app antigua sigue respondiendo, así que un 200 inmediato no prueba
nada. Hay que mirar `Application startup complete` en el log, o comprobar que se sirve el
bundle nuevo (su nombre con hash cambia en cada build).

Mientras tanto, la bóveda guarda de cada despliegue lo que ese despliegue usa de verdad.

## Estructura de un proyecto web

```
proyecto/
├── .npmrc                    ← scope @devconsultia al feed (ver más abajo)
├── .env.local.example        ← plantilla SIN valores reales
├── azure-pipelines.yml       ← pool: name: Default (agente macOS ARM de la casa; vmImage falla)
├── next.config.mjs
├── eslint.config.mjs         ← flat config
├── tsconfig.json             ← strict: true
├── middleware.ts             ← protección de rutas privadas
└── src/
    ├── app/
    │   ├── (portal)/         ← route group privado
    │   ├── (public)/
    │   └── api/
    ├── lib/
    │   ├── env.ts            ← validación zod AL ARRANCAR
    │   ├── bc-client.ts      ← envoltorio fino sobre @devconsultia/bc-client
    │   └── auth-options.ts
    ├── components/<dominio>/ ← por dominio funcional, no por tipo
    └── types/
```

`src/lib/bc-client.ts` **no reimplementa nada**: reexporta del paquete y añade sólo lo que
sea propio del proyecto (una caché, un `apiBase` alternativo). Hay ya varios ejemplos
hechos en el portfolio; si trabajas en un repo que lo tenga, cópialo de ahí.

## Reglas que no se discuten

1. **Nada sin git con remoto.** Ni una línea. Ver el CLAUDE.md global.
2. **Ningún secreto en el código, ni en la URL de un remoto, ni en un artefacto de
   despliegue.** Las credenciales de cliente viven en la bóveda (`devconsultia-credenciales`).
3. **El error que ve el usuario no lleva dentro nada de BC.** Ni URL, ni tenant, ni empresa,
   ni el cuerpo de la respuesta. Y para decidir sobre un error se mira `status`, **nunca el
   texto del mensaje** — eso se ha roto en tres portales distintos.
4. **`.gitignore` que funcione.** Si `git status` sale sucio con artefactos, está mal.
5. **Al paginar, orden estable.** Sin `$orderby` salen filas repetidas o perdidas y nada
   falla a la vista.
6. **Nada que valide configuración de ejecución se ejecuta al importar un módulo.** Ver
   abajo: es la regla que más caro sale de aprender.
7. **Toda pantalla, ficha y filtro tiene su dirección (URL).** «Atrás» del navegador,
   recargar y pegar el enlace en otra pestaña tienen que llevar a lo mismo que se veía. Ver
   «Cada pantalla con su dirección», abajo.
8. **Ninguna lista infinita.** Una tabla o lista que puede tener muchas filas tiene un tamaño
   normal y se desplaza dentro, con la cabecera fija. Ver «Tablas de tamaño normal», abajo.
9. **Las 22 reglas de pantalla.** Toda web cumple `devconsultia-pantallas` (2026-10-16, 15 a 22
   del 2026-10-18): el dato con su hora, la empresa y el entorno a la vista, un solo formato,
   errores con salida, escribir en BC sin duplicar, campos sin 0 inventado ni rellenos solos,
   botón gris con motivo, nada solo con el ratón, buscar sin mayúsculas ni tildes, volver sin
   perder el filtro, un robot que mira todas las pantallas… Con sus pruebas en verde y, para lo
   heredado, topes que solo bajan.
10. **Los portales Next despliegan en `standalone`.** El paquete lleva ya su `node_modules` de
   Linux y el App Service arranca con `node server.js`, sin instalar nada al arrancar. Ver
   «Despliegue standalone», abajo.

### Despliegue standalone de un portal Next (REQ-002404, 2026-10-23)

Con `npm install` en el arranque, cada despliegue dejaba la web caída mientras instalaba
(mediana ~500 s, de 400 a 837 s, en 24 despliegues medidos) y la resolución de dependencias
del servidor no era la que pasó los tests. En `standalone`, la web nueva sirvió a los 89 s de
la subida, y la subida tardó 5 s. La receta, probada en producción:

1. `next.config.mjs`: `output: 'standalone'` y `experimental: { isrFlushToDisk: false }`. Con
   `next/image`, además `images: { maximumDiskCacheSize: 0 }`: wwwroot es de solo lectura.
2. El pipeline (`pool: name: Default`), tras `pnpm run build`, arma el paquete: standalone,
   `.next/static`, `public` y un `node_modules` **de linux-x64, sin enlaces simbólicos**, y para
   si encuentra un binario darwin o win32 (sharp, swc…). Los scripts de referencia (preparar
   paquete, `node_modules` de Linux, zip POSIX, manifiesto) se copian del portal que ya lo hace:
   está en el inventario interno. Toda dependencia con binario nativo se revisa para linux-x64.
3. App Service con `WEBSITE_RUN_FROM_PACKAGE=1` y comando de inicio `node server.js`. Deploy con
   `az webapp deploy --type zip --track-status false`, **sin `--clean` y sin parar el sitio**.
   Fuera `arrancar.sh`, `relink-turbopack-externals.js` y el `npm install` del arranque.
4. Humo cada 5 s contra un `/api/salud` que devuelva el número de despliegue (un
   `despliegue.txt` que mete el paquete) y que toque BC: un 200 sin el número nuevo no vale.
5. La primera vez hay ~1 min sin servicio, porque cambiar los dos ajustes reinicia el sitio.
   Vuelta atrás: quitar `WEBSITE_RUN_FROM_PACKAGE`, volver al comando anterior y redesplegar el
   commit previo.

Pendiente conocido de la receta: el `node_modules` de Linux se resuelve con npm a partir de las
versiones de primer nivel de pnpm, así que las transitivas pueden no ser las del lockfile. Se
arregla instalando con pnpm (`node-linker=hoisted`, `pnpm.supportedArchitectures` a
linux/x64/glibc, `pnpm install --prod --frozen-lockfile --ignore-scripts`); probado en local,
aún no en el pipeline.

### Cada pantalla con su dirección (REQ-001271, 2026-10-01)

Si la pantalla que se ve vive en memoria, la URL no cambia: «atrás» saca de la aplicación,
recargar vuelve al principio y no se puede mandar el enlace de un pedido. Se diseña así desde
el primer día, como «cada número lleva a su dato». Pantalla = segmento (`/contratos`); su ficha
o alta, debajo (`/contratos/CTR00001`, `/contratos/nuevo`); lo que se abre **por encima** sin
perder dónde se estaba y los filtros que alguien querría compartir, parámetro
(`?pedido=PC-1`, `?estado=pendiente`). Lo efímero (un diálogo, un desplegable) no va en la URL.

- **Next:** viene solo (`app/(portal)/contratos/[numero]/page.tsx`, `searchParams`); no lo tapes
  eligiendo la ficha con un `useState`.
- **Heredada con Vite + React:** React Router con la URL como única fuente de lo que se ve, y el
  servidor devolviendo `index.html` en toda dirección que no sea API ni fichero (si no, recargar da 404).
- El «‹» de una ficha hace de «atrás» si se llegó desde la app; si se entró por un enlace, va a
  la lista. Los enlaces ya enviados (correos) se traducen a las direcciones nuevas, no se rompen.

Se comprueba antes de dar la web por terminada, y con un test por caso: abrir una ficha, «atrás»
(vuelve), recargar en la ficha (sigue) y pegar su dirección en otra pestaña (la abre).

### Tablas de tamaño normal (REQ-001305, 2026-10-02)

Una tabla que estira la página con cientos de filas no se lee, y al bajar se pierde qué es
cada columna. Toda lista que pueda crecer va en una caja `max-h-[70vh] overflow-auto` con el
`<thead>` en `sticky top-0` y fondo propio. Las clases viven en un sitio común del proyecto,
no copiadas por pantalla; el título dice cuántas filas hay; si pueden ser miles, además se
pagina o filtra en el servidor. Se comprueba con datos reales: la página no crece y la
cabecera se queda arriba al desplazar.

## Organización del código: que no parezca vibe coding (REQ-001039)

Vale para Node y Python. Se escribe así desde el primer día, no se arregla después:
lo comprueba `herramientas/medir-codigo.mjs` (`--todo`: informe).

- **Un módulo, una responsabilidad**, por capas: rutas/controladores → lógica de negocio →
  acceso a datos; y aparte integraciones (BC, correo, IA), tipos/esquemas y utilidades. Las
  rutas no llevan lógica de negocio; la lógica de negocio no conoce el framework web.
- **Tamaño como alarma, no como dogma:** ~300 líneas por fichero y ~50 por función. Pasarse
  pide partir o justificarlo. A no repetir: un `main.py` de 5.000 líneas con rutas,
  negocio y SQL.
- **Por dominio, no por tipo:** `pedidos/` con sus rutas, servicio y tipos juntos, mejor que
  un `services/` con cuarenta ficheros sin relación.
- **Nada de código muerto**: ni comentado, ni `console.log`/`print` de depuración, ni
  «TEMP», «TODO luego» o «prueba esto» que se quedan. Lo que se deja, lleva petición.
- **Sin duplicar:** el segundo copia-pega se extrae a una función; el tercero, obligatorio.
- **Optimizar con medida delante y detrás** (consultas N+1, bucles sobre BC, renders de más,
  bundles pesados). Sin medida es opinión.

**Refactorizar sin romper** — un repo cada vez, nunca «todo de golpe»:
1. Medir primero: ficheros y funciones más grandes, duplicados, dependencias sin uso, qué no
   tiene tests. Plan en pasos pequeños, ordenado por beneficio y riesgo.
2. Tests del comportamiento ACTUAL antes de mover nada; si no los hay, se escriben primero
   y pasan contra el código viejo.
3. Refactor = mover, extraer, renombrar, simplificar. **Nunca mezclado con funcionalidad
   nueva.** Una PR por paso, con el antes y el después en números (líneas, módulos, tiempos).
4. Ni el despliegue, ni la base de producción, ni la API que usan otros sistemas se tocan
   dentro de un refactor.

### El cliente de BC se construye perezosamente, nunca al importar

```ts
let instancia: ReturnType<typeof createBcClient> | null = null;

function bc() {
  instancia ??= createBcClient({ /* … */ });
  return instancia;
}
```

**Por qué.** `createBcClient` valida la configuración al construirse, y durante `next build`
Next **importa los módulos** para recolectar los datos de las páginas. Los pipelines pasan
al build sólo los secretos que hacen falta para compilar; las variables de BC viven como App
Settings y sólo existen en ejecución. Con el cliente creado al importar, el build muere con
*"Falta BC_COMPANY_ID"*.

Lo traicionero es que **en local no se ve**: ahí sí están todas las variables. Typecheck y
lint pasan en verde y el fallo aparece en el pipeline. Le pasó a un portal de producción el
2026-08-09 (REQ-000312), y el cliente que sustituimos no fallaba porque leía `process.env`
**dentro** de la función: subir esa lectura al nivel de módulo convirtió un posible fallo de
ejecución en un fallo de compilación.

**Lo mismo vale para `env.ts`.** Si validas ahí las variables de BC con zod, el módulo
valida al importarse y vuelves a tener el problema. En la plantilla, `env.ts` valida sólo lo
de la aplicación (`NEXTAUTH_*`) y de las de BC se encarga el paquete, que ya da un mensaje
igual de claro. No dupliques esa validación.

Estado a 2026-08-09: parte de los portales ya compila sin ninguna variable de BC; en el
resto, un `env.ts` propio las sigue validando al importar. Eso es **anterior** a la adopción
del paquete y hoy no rompe nada, porque sus pipelines sí les pasan las variables — pero
conviene comprobarlo en el repo que tengas delante antes de registrar un pipeline nuevo o de
quitar un variable group.

## Migrar de Next 14 a 16

Cuatro cosas rompen, y **ninguna se ve venir**. Verificado en una migración real el
2026-08-09 (REQ-000312).

**1. `Metadata` se importa de `next/types`, no de `next`.**

```ts
import type { Metadata } from 'next/types';   // antes: desde 'next'
```

**2. `params` es ahora una `Promise`** en rutas y páginas dinámicas:

```ts
export async function GET(req: Request, { params }: { params: Promise<{ id: string }> }) {
  const id = (await params).id;
}
```

Una página que no fuera `async` tiene que serlo. **Ojo con esto**: `tsc --noEmit` **NO lo
detecta**, porque los tipos de ruta se generan durante `next build`. El typecheck pasa
limpio y el build revienta. Si migras fiándote sólo del typecheck, te enteras en el
pipeline.

Búscalos así — hay dos formas, inline y con tipo con nombre:

```bash
grep -rn "params: { " src/app --include="route.ts" --include="page.tsx"
```

**Dos avisos sobre `params`, aprendidos rompiéndolo:**

*No lo transformes a ciegas.* Una regex sobre `params.X` pilla también cualquier variable
local que se llame `params` — en un portal convirtió un `const params = useSearchParams()`
de un componente de cliente en `(await params)` dentro de una función síncrona. Lo cazó el
typecheck, pero **estas transformaciones necesitan que el compilador las vigile**: no las
des por buenas sin pasar `typecheck` y `build`.

**2 bis. `cookies()` también es asíncrono, y arrastra en cascada.**

```ts
const valor = (await cookies()).get('mi-cookie')?.value;
```

Si lo usa una función auxiliar síncrona —un `getSession()`, por ejemplo— esa función pasa a
`async`, y con ella **todos sus llamantes**. En un portal de tamaño medio fueron 53
ficheros, 74 llamadas y 6 páginas que hubo que convertir en `async`. Mide el alcance antes
de empezar:

```bash
grep -rn "cookies()\." src --include="*.ts" --include="*.tsx"
grep -rc "getSession()\|requireSession()" src --include="*.ts" --include="*.tsx"
```

**3. `next lint` desapareció.** El script pasa a `eslint .`, con ESLint 9 y flat config.
Un `"lint": "next lint"` en Next 16 falla con *"Invalid project directory provided, no such
directory: …/lint"*, que no dice nada de lo que pasa.

**4. La flat config tiene una trampa doble.** Los plugins **sí** se heredan entre objetos
—redeclararlos falla con *"Cannot redefine plugin"*— **pero** cada objeto de
`eslint-config-next` tiene su ámbito de ficheros, y el que trae `@typescript-eslint` sólo
cubre `.ts` y `.tsx`. Una regla de ese plugin en un objeto sin ámbito falla con *"could not
find plugin"* al evaluar un `.js`. Por eso las reglas de TypeScript van con su `files`:

```js
const config = [
  ...next,
  { rules: { 'react/no-unescaped-entities': 'off' } },
  { files: ['**/*.ts', '**/*.tsx'], rules: { '@typescript-eslint/no-unused-vars': 'warn' } },
  { ignores: ['.next/**', 'node_modules/**'] },
];
```

### Y de paso, Tailwind 3 → 4

`@tailwind base/components/utilities` se sustituye por **una** importación, el plugin de
PostCSS pasa a `@tailwindcss/postcss` y **autoprefixer sobra** (va incluido).

Lo que **no** hay que hacer de golpe es reescribir el tema a `@theme`. Con `@config` sigue
valiendo el `tailwind.config.ts` de siempre, y así no se pierde un color de la paleta por el
camino:

```css
@import 'tailwindcss';
@config '../../tailwind.config.ts';
```

### Avisos nuevos que aparecerán

`eslint-config-next` 16 trae reglas que la 14 no tenía. Antes de arreglarlas, mira si son
reales: `const Icon = iconForMime(...)` dispara `react-hooks/static-components` y es un
**falso positivo** —esa función devuelve un icono ya importado, no crea un componente—,
mientras que definir un componente dentro del render sí es un bug de verdad y hace que los
inputs pierdan el foco (ya nos ha pasado en un portal en producción).

## Proyecto nuevo

Clona la plantilla en vez de montarlo a mano:

```bash
git clone https://DevConsultIA@dev.azure.com/DevConsultIA/Utilidades/_git/plantilla-web
```

Trae el stack de arriba ya fijado, el `.npmrc` del feed, el pipeline con los seis pasos de
`devconsultia-release-and-deploy`, `bc-client` conectado y la estructura de carpetas.

Si por lo que sea lo montas a mano, la receta de las dependencias privadas y del despliegue
está en `devconsultia-release-and-deploy` §2.5 — **son seis pasos y hay que hacerlos todos**.

**Dónde corre ese pipeline (decidido 2026-09-22).** En el agente autoalojado de la casa
—macOS sobre ARM, grupo `Default`—, no en los agentes de Microsoft: la organización no tiene
minutos gratuitos. El YAML lleva `pool: name: Default`; un `vmImage` hace fallar el pipeline.
De ahí salen dos reglas de stack: **el artefacto nunca lleva `node_modules` ni venvs
instalados en el agente** (serían binarios darwin-arm64) y **los scripts del pipeline son
POSIX o Node/Python, no GNU/Linux**. Detalle y trampas: `devconsultia-release-and-deploy` §2.00.
La plantilla `plantilla-web` ya trae `pool: name: Default` (comprobado 22-oct-2026). Si copias el
YAML de un repo viejo y lleva `vmImage`, cámbialo antes del primer push.

## Rust (decidido el 2026-09-17, REQ-000748; ampliado el 2026-10-24, REQ-002488)

Para los productos que son sistema de registro (fabricación, contabilidad, fiscalidad), donde
un error es una multa o una parada de planta y no una pantalla mal pintada. Hay dos en Rust y
**los dos usan las mismas piezas y versiones**; un tercero las hereda, no las elige.
**Rust de punta a punta:** Axum, SQLx, PostgreSQL 16 y Leptos (plan B: HTMX servido por Axum).

### Toolchain

`rust-toolchain.toml` en la raíz, con **versión concreta**, nunca `channel = "stable"`:

```toml
[toolchain]
channel = "1.98.1"
profile = "default"
components = ["rustfmt", "clippy"]
targets = ["wasm32-unknown-unknown"]   # Leptos: sin él no compila ni en local
```

- **Edición 2024** y `resolver = "3"` en todos los crates; `rust-version` en el `Cargo.toml`
  del workspace, igual que el canal.
- Se sube **en un commit propio** que solo toca el toolchain, y en todos los productos a la vez.
- `cargo check` y `cargo clippy` **no enlazan**: verde en ellos no prueba que el binario se
  construya. Para eso, `cargo build`.

### Crates (versiones de 2026-09-17, en `[workspace.dependencies]`)

| Crate | Versión | Notas |
|---|---|---|
| axum | 0.8.9 | |
| tokio | 1.53.1 | `macros, rt-multi-thread, signal, time, sync`; `full` no |
| tower-http | 0.7.1 | `trace, compression-gzip, cors, timeout` |
| sqlx | 0.9.0 | `default-features = false`; `postgres, runtime-tokio, tls-rustls-ring, macros, uuid, time, json, rust_decimal, migrate` |
| serde / serde_json | 1.0.229 / 1.0.151 | |
| thiserror / anyhow | 2.0.20 / 1.0.104 | ver «Errores» |
| tracing / tracing-subscriber | 0.1.44 / 0.3.23 | `env-filter, json`: el log lo lee App Service |
| uuid | 1.26.1 | `v4, v7, serde`; **v7 para claves nuevas** (no fragmenta el índice) |
| time | 0.3.55 | `serde, macros, formatting, parsing`; **`chrono` prohibido en código nuestro** |
| rust_decimal | 1.43.0 | `serde-with-str` (+ `macros` donde se usa `dec!` en tests). **Todo importe es `Decimal`, nunca `f64`** |
| leptos / leptos_axum | 0.8.20 / 0.8.10 | se fijan por separado y se suben juntas a mano |
| reqwest | 0.13.5 | `default-features = false`; `json, rustls, http2, gzip` |
| oauth2 | 5.0.0 | `rustls-tls`; `client_credentials` contra BC |
| openidconnect | 4.0.1 | `reqwest, rustls-tls`; login con Entra (valida el ID token) |

Un crate nuevo entra con su versión en esta tabla. `Cargo.lock` **se versiona** (son binarios).

**TLS solo por rustls**, con `default-features = false`: con las de por defecto cada crate
arrastra `native-tls` y la imagen necesita OpenSSL dentro. Los nombres de la feature **no
coinciden** entre crates (`tls-rustls-ring`, `rustls`, `rustls-tls`): cópialos de la tabla.

### Reglas

1. **Una versión por dependencia**, en `[workspace.dependencies]`; los crates ponen
   `{ workspace = true }` sin número. `cargo tree --duplicates` debe salir limpio.
2. **El dominio no tiene I/O.** El crate `core` no depende de `tokio`, `sqlx`, `reqwest` ni
   `std::fs`; las flechas van hacia él y nunca entre hermanos (`db` no habla con `bc`: los
   orquesta `api` o `worker`).
3. **Errores:** `thiserror` en librerías (enum con variantes para que el que llama decida:
   reintentar un 429, no un 400) y `anyhow` solo en binarios. La regla 3 general, en Rust: la
   variante lleva el `StatusCode`; el `Display` que sale al HTTP es un mensaje nuestro y el
   detalle de BC va a `tracing`.
4. **`#![deny(unsafe_code)]`** en todo `lib.rs` y `main.rs`. Solo un crate FFI puede usar
   `unsafe`, con API segura hacia fuera y `// SAFETY:` en cada bloque.
5. **Lints del workspace:** clippy `all` en deny, `unwrap_used = "deny"`, `expect_used =
   "warn"`, `todo = "deny"`; `cargo clippy --workspace --all-targets --all-features -- -D
   warnings` y `cargo fmt --all --check`. `rustfmt.toml` solo con `edition = "2024"`. Todo
   `#[allow]` lleva su motivo al lado.
6. **SQLx con macros verificadas** (`query!`, `query_as!`) en toda consulta nueva, `.sqlx/`
   versionado y `SQLX_OFFLINE=true` en el pipeline. Tras tocar una consulta o migración,
   `cargo sqlx prepare --workspace` **en el mismo commit**; el pipeline lo comprueba con
   `--check`. La compilación no se conecta a ninguna base.
7. **Migraciones** en un solo sitio, `sqlx migrate`; una aplicada no se edita nunca. Las
   ejecuta un paso explícito del despliegue (la CLI), no el arranque de la API: dos instancias
   migrarían a la vez en el relevo. Primero se deja de leer una columna, luego se borra.
   `sqlx-cli` en la versión exacta de la librería (`--locked`).
8. **Variables de BC: la convención única** de arriba. Lo propio del producto va con su
   prefijo (`<PRODUCTO>_DATABASE_URL`), nunca `DATABASE_URL` o `PORT` a secas.
9. **El cliente de BC se construye perezosamente:** `from_env()` devuelve `Result` (sin
   `panic!`), nada lee el entorno en un `static`/`LazyLock` de módulo ni en un `build.rs`.
10. **Al paginar, orden estable:** `$orderby` en OData y `ORDER BY` con clave única en SQL.

### Pipeline

En el agente de la casa (`pool: name: Default`), en este orden: `cargo fmt --check` →
clippy → `cargo test --workspace` → `cargo build --release` → `cargo leptos build --release`
(no `trunk`) → prueba en navegador → imagen → deploy → humo.

- **Imagen multi-stage con base final distroless** (`gcr.io/distroless/cc-debian12:nonroot`).
- **Humo que compara el sello de versión:** `/health` devuelve hash del commit y número de
  build inyectados al compilar, y el paso falla si no coincide con lo desplegado. Un 200 solo
  no prueba nada. `/health` no lleva versiones de dependencias ni nada de BC.
- Postgres 16 de los tests es el **servicio local del Mac**, con ICU `es-ES` (el orden de
  texto cambia los resultados) y un rol con `CREATEDB`: cada test crea y borra su base.
- `~/.cargo` y `target/` sobreviven en el agente; `target/` se topa por tamaño. Los binarios
  salen darwin-arm64: no se publican como artefacto para Linux.
- **El paso de tests no se salta «porque solo cambió el frontend»**: los tipos son compartidos.

Comprobar antes de fiarse de esta sección: `rustc --version`, `cargo tree --duplicates`,
`cargo tree -i chrono` (vacío o solo transitivo) y `cargo update --dry-run`.

## Qué queda por converger (2026-08-09)

El portfolio todavía no cumple esto al cien por cien. Los frentes abiertos, por tipo:

| Pendiente | Estado |
|---|---|
| ~~Next 14 → 16~~ | **hecho** (REQ-000312, 313, 316): no queda ninguna app en Next 14 |
| ~~Variables de BC a la convención única~~ | **hecho** (REQ-000317, 328) |
| `engines` + `packageManager` | falta declararlos en algún proyecto web |
| ~~Astro 6 → 7~~ | **hecho**: la web corporativa va en 7.2.0 (comprobado 24-oct-2026) |
| Despliegue standalone (regla 10) | hecho en un portal (REQ-002404); pendiente en el resto de portales Next |
| Adoptar `bc-client` | pendiente donde todavía haya un cliente de BC propio |
| Deshacer un fork entre dos portales que comparten origen | pendiente |
| Dirección por pantalla y ficha (regla 7) en las webs anteriores al estándar | pendiente donde la pantalla se elige con estado en memoria |
| Las 22 reglas de pantalla (regla 9) | 1 a 14 montadas el 17 y 18-oct-2026 en las webs que las tienen, con sus topes; 15 a 22 y las piezas de la versión 2 pendientes de copiar en todas |

**El inventario nominal —qué repositorio tiene qué pendiente— no vive aquí**: es estado del
portfolio, se consulta en el registro interno y cambia cada semana. Lo que sí aplica en
cualquier repo: antes de dar por bueno un proyecto, comprueba **en ese repo** cuál de estos
frentes le toca.

## Mantenimiento

Este documento tiene **fecha**. Cuando cambies una versión aquí, cambia también la fecha y
di por qué. Si al leerlo la fecha es vieja, comprueba contra el registro antes de fiarte:

```bash
npm view next version && npm view react version && npm view typescript version
```

Y si encuentras una versión mayor nueva, **no la subas por estar al día**: súbela cuando
aporte algo o cuando la actual deje de tener soporte. La divergencia de este portfolio
empezó por actualizar unos repos sí y otros no.

---

*Neutralizada el 2026-08-16 (REQ-000380): esta skill se empaqueta en todos los
repositorios, así que no nombra clientes, repositorios, instancias ni entornos concretos.
Todas las decisiones y sus fechas siguen aquí íntegras; lo que se retiró fue el inventario
de dónde está aplicada cada una, que vive en `conocimiento/extraido/devconsultia-stack.md`.*
