<!-- GENERADO — NO EDITAR -->

# devconsultia-al-integrations

*Copia generada de `skills/devconsultia-al-integrations/SKILL.md` del Manual. GENERADO — NO EDITAR:*
*si algo de aquí está mal o desactualizado, se corrige en el Manual, no aquí.*

---

---
name: devconsultia-al-integrations
description: 'Patrones de integración externa desde AL: HttpClient, auth (API key, OAuth, mTLS AEAT), transportistas, AEAT/VeriFactu, EDICOM, KSeF, reintentos. Usar al llamar a un servicio externo desde AL. Triggers: "HttpClient", "webhook", "transportista", "AEAT", "EDICOM", "KSeF".'
---

# Integraciones externas desde AL en DevConsultIA

**Fecha:** 2026-07-06. **Audiencia:** desarrollador AL mid-level trabajando en los repos de `C:\DevConsultIA-repos`.

Esta skill documenta cómo SE HACEN hoy las integraciones (verdad verificada en código, con rutas reales) y cómo DEBEN hacerse (patrón canónico propuesto, etiquetado como PROPUESTA). Cuando ambos difieran, sigue el patrón canónico en código nuevo y no "arregles" código existente salvo que la tarea lo pida.

## Cuándo NO usar esta skill

- **UI en AL** (pages, page extensions, role centers, wizards, cues) → `devconsultia-al-ui-patterns`.
- **Convenciones AL generales** (naming, estructura de app, eventos, upgrade) → `devconsultia-al-standard`.
- **Integraciones en Node/Python/Azure Functions** (fuera de AL) → las skills de esa plataforma.
- Lógica de negocio pura sin llamadas externas: no apliques nada de aquí.

## Mapa de referencia: dónde mirar cada cosa

| Necesitas | Referencia real |
|---|---|
| SOAP (anti-patrón concatenación) | `C:\DevConsultIA-repos\Carriers__Carriers\src\codeunit\Cod50750.IntegracionGLS.al` |
| SOAP con logging y parseo XmlDocument correcto | `C:\DevConsultIA-repos\Utilidades__VeriFactu\src\codeunit\Cod70100.VeriFactu.al` |
| REST + OAuth client_credentials con caché de token | `C:\DevConsultIA-repos\Carriers__Carriers\src\codeunit\Cod50766.IntegracionCTT.al` (`ObtenerToken`) |
| OAuth2 Azure AD / Microsoft Graph | `C:\DevConsultIA-repos\Bc to Drive__Bc to Drive\Extension\codeunit\DCNSHPCloudHandler.Codeunit.al` (`GetOAuthTokenBC`) |
| Basic Auth | `C:\DevConsultIA-repos\PrintNode__PrintNode\PrintNode\Codeunits\Cod50600.PrintNodeManagement.al` |
| Bearer + OAuth password grant | `C:\DevConsultIA-repos\EDI__EDI\src\codeunit\Cod50900.GetToken.al` |
| Certificado cliente (mTLS AEAT) + Isolated Storage | `C:\DevConsultIA-repos\TaxIA__TaxIA\al\src\Codeunits\TIACertMgt.Codeunit.al` |
| Log HTTP request/response (mejor ejemplo) | Tabla `*HttpLog` de la app de facturación electrónica de la casa: una fila por llamada con petición, respuesta, código y momento |
| Reintentos con rate-limit (429) | Procedimiento `DoHttpRequest` de esa misma app: reintento con espera creciente al recibir 429 |
| Monitorización/auto-restart de Job Queue | `C:\DevConsultIA-repos\MonitorizaciónJobQueue__MonitorizaciónJobQueue\src\Codeunits\JQMMonitorMgt.Codeunit.al` |

Nota de verdad: en Carriers los transportistas implementados son **GLS, Transaher (Saher), MRW, Correos, CTT Express, eSchenker y NTL**. No hay codeunit de integración SEUR (GLS usa la plataforma ASMRED, `http://www.asmred.com/`).

---

## 1. Patrón HttpClient canónico (PROPUESTA, destilado de lo mejor del código real)

Los mejores ingredientes existentes: `TrySend` de TaxIA (`C:\DevConsultIA-repos\TaxIA__TaxIA\al\src\Codeunits\TIAAEATConnector.Codeunit.al`, [TryFunction] + HttpRequestMessage explícito + HttpStatus para log), el chequeo `IsSuccessStatusCode`+`ReasonPhrase` de CTT, el log en Blob de KSeF y los reintentos de KSeF. Combínalos así en cada integración nueva:

```al
// PROPUESTA canónica DevConsultIA — un codeunit "XXX Http Client" por proveedor
local procedure SendRequest(Method: Text; Url: Text; Body: Text; ContentType: Text; var ResponseBody: Text; var StatusCode: Integer): Boolean
var
    Client: HttpClient;
    Request: HttpRequestMessage;
    Response: HttpResponseMessage;
    Content: HttpContent;
    ContentHeaders: HttpHeaders;
    ReqHeaders: HttpHeaders;
begin
    // 1. Auth ANTES de enviar (elige uno):
    //    API key:   Client.DefaultRequestHeaders.Add('Authorization', Setup.GetApiKey());          // Mirakl
    //    Bearer:    Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + GetToken());     // EDI/B2Chat/HubSpot
    //    Basic:     Client.DefaultRequestHeaders.Add('Authorization', 'Basic ' + Base64UserPass);  // PrintNode
    //    mTLS AEAT: CertMgt.AttachTo(Client);                                                      // TaxIA (Client.AddCertificate)
    Client.Timeout(60000); // explícito; hoy casi nadie lo pone y se hereda el default

    // 2. Request explícito (no Client.Post directo): permite method, headers y log uniformes
    if Body <> '' then begin
        Content.WriteFrom(Body);
        Content.GetHeaders(ContentHeaders);
        if ContentHeaders.Contains('Content-Type') then
            ContentHeaders.Remove('Content-Type'); // BC mete text/plain por defecto: quitar y reponer
        ContentHeaders.Add('Content-Type', ContentType); // 'application/json' | 'text/xml; charset=utf-8'
        Request.Content := Content;
    end;
    Request.SetRequestUri(Url);
    Request.Method := Method;

    // 3. Log del request ANTES de enviar (si falla la red, queda rastro)
    HttpLog.LogRequest(ContextEntryNo, Method, Url, Body);

    // 4. Enviar: Send() devuelve false solo en fallo de transporte (DNS, timeout, TLS)
    if not Client.Send(Request, Response) then begin
        HttpLog.LogResponse(ContextEntryNo, Url, 0, '', GetLastErrorText());
        exit(false);
    end;

    // 5. Leer el body también en error: los proveedores devuelven el motivo ahí
    StatusCode := Response.HttpStatusCode();
    Response.Content().ReadAs(ResponseBody);
    HttpLog.LogResponse(ContextEntryNo, Url, StatusCode, ResponseBody, Response.ReasonPhrase());
    exit(Response.IsSuccessStatusCode());
end;
```

Reglas del patrón (imperativas):

1. **Nunca `Error()` dentro de la capa HTTP.** Devuelve Boolean + StatusCode + ResponseBody y decide arriba. Motivo: en Job Queue un `Error()` mata el job sin log propio.
2. **Mensajes de error accionables**, estilo CTT (`Cod50766.IntegracionCTT.al:113`): `Error('Error en token (%1 %2): %3', Response.HttpStatusCode(), Response.ReasonPhrase(), RespText);` — incluye código HTTP, frase y body. Nunca `Error('Ha ocurrido un error')`.
3. **Distingue fallo de transporte de fallo HTTP**: `if not Client.Post(...)` cubre lo primero; `IsSuccessStatusCode()` lo segundo. EDI valida además `HttpStatusCode() <> 200` (`Cod50900.GetToken.al`). Trata ambos.
4. **Content-Type: quitar y reponer.** Patrón repetido en TODOS los repos (TaxIA, EDI, GLS, CTT). Si no lo quitas, va `text/plain` y muchos WS (AEAT, EDICOM) rechazan.
5. **Log request/response en tabla** para soporte — ver §5-log. Hoy solo KSeF y TaxIA lo hacen bien; Carriers guarda el par XML por envío vía `Utilidades.GuardarDatosEnvio(..., SoapXML, XMLResponse)` (`Cod50750.IntegracionGLS.al:205`).
6. **Secretos desde Isolated Storage o Isolated Certificate**, no interpolados desde campos Text — ver §4.

---

## 2. SOAP: anti-patrón actual y patrón correcto

### 2.1 Cómo se hace HOY en Carriers (ANTI-PATRÓN: concatenación de strings)

Real, en `C:\DevConsultIA-repos\Carriers__Carriers\src\codeunit\Cod50750.IntegracionGLS.al`, procedure `EnviarExpedicion` (líneas 127-171):

```al
SoapXML :=
  '<?xml version="1.0" encoding="utf-8"?>' +
  '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
  ...
  '<Servicios uidcliente="' + ShippingAgent.uidcliente + '" xmlns="http://www.asmred.com/">' +
  '<Envio>' +
    '<Fecha>' + FechaTexto + '</Fecha>' +
    ...
    '<Nombre>' + SalesShipmentHeader."Ship-to Name" + '</Nombre>' +
    '<Direccion>' + SalesShipmentHeader."Ship-to Address" + ', ' + SalesShipmentHeader."Ship-to Address 2" + '</Direccion>' +
    '<Observaciones>' + Observacion + '</Observaciones>' +
  ...
```

Mismo estilo en `Cod50751.IntegracionTransaher.al`, `Cod50753.IntegracionMRW.al`, `Cod50762.RecogidasGLS.al`, `Cod50763.ParcelShopGLS.al`. **Por qué es un anti-patrón:** cualquier `&`, `<`, `>` o comilla en nombre/dirección/observaciones rompe el XML o lo corrompe. Transaher lo parchea a mano — `Cod50751.IntegracionTransaher.al:149`: `DatosEntrada := DatosEntrada.Replace('&', 'Y');` (commit real: `55358d3 [MOD] - Incidencias Correos + Transaher ampersant`). Eso es el síntoma, no la solución. No copies este patrón en código nuevo.

Lo que SÍ está bien de ese código y debes conservar: envío del envelope con `Content.WriteFrom`, `Headers.Remove('Content-Type')` + `Headers.Add('Content-Type', 'text/xml; charset=utf-8')` (SOAP 1.1) o `'application/soap+xml; charset=utf-8'` (SOAP 1.2), header `SOAPAction` leído de setup (`ConfigCarrier.GLSEnvioPedidoHeader`), y parseo de respuesta con `XmlDocument.ReadFrom` + XPath `//*[local-name()="..."]` (líneas 185-202), que ignora prefijos de namespace.

### 2.2 Patrón correcto: construir con XmlDocument/XmlElement

Referencia real interna: VeriFactu construye TODO el envelope AEAT con la API Xml de AL — `C:\DevConsultIA-repos\Utilidades__VeriFactu\src\codeunit\Cod70100.VeriFactu.al`, procedure `ConvertirDocumentoAXml` (fragmento real, encadenamiento, ~línea 482):

```al
Encadenamiento := XmlElement.Create('Encadenamiento', nsSum1);
RegistroAlta.Add(Encadenamiento);
RegistroAnterior := XmlElement.Create('RegistroAnterior', nsSum1);
Encadenamiento.Add(RegistroAnterior);
AddTextElem(RegistroAnterior, 'IDEmisorFactura', nsSum1, EmpresaEmisoraPRev.NIF);
AddTextElem(RegistroAnterior, 'Huella', nsSum1, Prev.Huella);
```

Runbook para un SOAP nuevo:

1. Crea el envelope con `XmlElement.Create(nombre, namespace)` y helpers tipo `AddTextElem` (copia el de VeriFactu). El escaping de `& < > " '` es automático — desaparece la clase entera de bugs del §2.1.
2. Serializa con `XmlDoc.WriteTo(SoapXML)` y envía con el patrón de §1 (`Content-Type: text/xml; charset=utf-8` + `SOAPAction`).
3. Parsea la respuesta como GLS/VeriFactu: `XmlDocument.ReadFrom(XMLResponse, XmlDoc)` + `XmlDoc.SelectSingleNode('//*[local-name()="Etiqueta"]', XmlNode)`; valores con `XmlNode.AsXmlElement().InnerText()` y atributos con `XmlNode.AsXmlAttribute().Value()`.
4. Detecta faults como VeriFactu (`ProcesarRespuestaVerifactu`, ~línea 629): busca `/*[local-name()="Envelope"]/*[local-name()="Body"]/*[local-name()="Fault"]` y extrae `faultstring` antes de buscar la respuesta buena.
5. Fechas y decimales con formato explícito: `Format(Fecha, 0, '<Day,2>/<Month,2>/<Year4>')` y `Format(Peso, 0, '<Precision,2:2><Standard Format,0>')` (real en `Cod50750.IntegracionGLS.al:90,141`). Nunca `Format(Fecha)` a secas: depende de la regional del servidor (commit real de escarmiento: `6a92eb3 [FIX] Fechas MRW`).

## 3. JSON: patrones reales

Usa los tipos nativos `JsonObject/JsonArray/JsonToken`. El codeunit legacy `"JSON Management"` aparece en código viejo (B2Chat contactos, CTT token) — no lo uses en código nuevo.

**Construcción** (real, `Cod60200.SFAutenticacion.al:72`, Shoppingfeed):
```al
JsonBody.Add('grant_type', 'password');
JsonBody.Add('username', Setup.Username);
JsonBody.WriteTo(BodyText);
```
Para estructuras anidadas, CTT es la referencia (`Cod50766.IntegracionCTT.al`, `ConstruirManifestOnlineDesdeAlbaran`): `JsonObject` por bloque (Root, Pickup, Delivery, Item), `JsonArray` para colecciones, `Root.Add('items', ItemsArr)` al final.

**Parseo** (real, `C:\DevConsultIA-repos\B2Chat__B2Chat\src\codeunit\Cod71800.AutenticacionB2Chat.al:56`):
```al
if not JsonObj.ReadFrom(JsonRespuesta) then
    Error('No se ha podido leer el JSON de respuesta de autenticación.');
if JsonObj.Get('access_token', Tok) and Tok.IsValue() then
    Token := Tok.AsValue().AsText();
```
Reglas: valida `ReadFrom` (no asumas JSON válido — un 500 devuelve HTML), comprueba `Get(...)` y `IsValue()` antes de `AsValue()`, y al volcar a campos usa `CopyStr(..., 1, MaxStrLen(Campo))` (real en KSeF: `glbCloudProviderSetup.ExpiresIn := CopyStr(Token.AsValue().AsText(), 1, MaxStrLen(...))`).

## 4. Config de integración y secretos: la verdad

Dos estilos conviven:

- **Tabla singleton de app** — `Tab50751.ConfigCarrier.al`: un registro (PK `ID`) con URLs y SOAPAction por transportista (`GLSPost`, `GLSEnvioPedidoHeader`, `TransaherEnvioPost`, `CttExpress URL Token`, `URL ESchenker Booking`, enlaces de tracking...). Bien: URLs configurables por entorno, nunca hardcodeadas. TaxIA mejora esto con tabla `TIA Endpoint` (modelo+entorno → URL), útil cuando hay pre/producción.
- **Credenciales por proveedor en tableextension** — `Tab-Ext50750.ShippingAgent.al`: `uidcliente`, `PassWS`, `ID Cliente`, `Cliente secreto`, `AccessKey`, `Token` (Text[2048]), `Caducidad token`. Permite N cuentas (una por Shipping Agent).

**Qué app guarda bien o mal sus secretos** es estado del portfolio, no patrón: vive en
`devconsultia-portfolio-estado` (conocimiento interno). El criterio de qué es "bien"
está en `devconsultia-secrets-and-config`. Aquí, solo el patrón de código.

**Canon de DataScope en Isolated Storage: `DataScope::Module`** (aislamiento por app, compartido entre empresas). **Excepción documentada:** secretos intrínsecamente por empresa — p. ej. el certificado AEAT de TaxIA, distinto en cada empresa — usan `DataScope::Company`.

**Regla para código nuevo:** secretos en Isolated Storage con el patrón TaxIA — es el mejor del parque (su `DataScope::Company` es la excepción documentada, no el canon):

```al
// Real: C:\DevConsultIA-repos\TaxIA__TaxIA\al\src\Codeunits\TIACertMgt.Codeunit.al
[NonDebuggable]
procedure SetCertificate(Base64: Text; Password: SecretText)
begin
    IsolatedStorage.Set(CertKeyTok, Base64, DataScope::Company);
    IsolatedStorage.Set(PwdKeyTok, Password, DataScope::Company);
end;
// y para mTLS:  Client.AddCertificate(Base64, Password);
```
En la tabla de setup deja solo un flag (`"API Key Set": Boolean`, estilo HubSpot) y procedures `SetX/HasX/ClearX`. Claves con `Label ... Locked = true`. Usa `SecretText` en firmas.

## 5. Reintentos, Job Queue y background

**Lo que hay (verificado):**

- **Reintentos HTTP:** solo KSeF los implementa — `Cod7149526.KSeFManagement.al`, `DoHttpRequest`: `MaxAttempts := 4`, loop, si `StatusCode = 429` entonces `Sleep(11000)` y `Continue`; además rate-limit preventivo `Sleep(2100)` (30 req/min). El resto de repos: cero reintentos.
- **Job Queue de negocio:** Carriers `Cod50755.ActualizacionSeguimientos.al` — codeunit ejecutable desde Job Queue que recorre albaranes con expedición activa y llama al seguimiento de cada integrador; `Cod50761.EnvioPedidosWSAuto.al` envía automáticamente lo que está en `EstadoWS::PendienteWS` (enum `Enum50751.EstadoWS`).
- **Page Background Task (no confundir con Job Queue):** `Cod50769.StatusEnviosBGTask.al` calcula KPIs de cues en segundo plano para la page `StatusEnviosCarriers`, con timeout 60s vía suscriptor a `OnGetBackgroundTaskTimeout` y `Page.SetBackgroundTaskResult(Result)`. Detalle bueno: `ReadIsolation := IsolationLevel::ReadUncommitted` para no bloquear.
- **Monitorización:** `MonitorizaciónJobQueue` (`JQMMonitorMgt.Codeunit.al`) detecta Job Queue Entries en Error/inactividad, auto-reintenta con `JobQueueEntry.Restart()` hasta `Max Restart Attempts` (`JQMAutoRestart.Codeunit.al`, cuenta fallos en `Job Queue Log Entry`), aplica cooldown de notificaciones y avisa por canal configurable.

**Patrón recomendado (PROPUESTA) para una integración nueva con volumen:**

1. Estado por documento con enum (`Pendiente → Enviado → Error`, estilo `EstadoWS` de Carriers) — idempotencia: antes de enviar, comprueba que no haya expedición en curso (`Utilidades.HayExpedicionEnCurso`).
2. Codeunit de proceso ejecutable por Job Queue que recorre pendientes; cada documento dentro de `if not Codeunit.Run(...)` o TryFunction para que uno fallido no tumbe el lote, guardando `GetLastErrorText()` en el registro.
3. Reintento HTTP solo para 429/5xx/transporte, estilo KSeF (máx. 3-4, con Sleep). Errores 4xx de validación NO se reintentan: se marcan Error con mensaje accionable.
4. Despliega la app `MonitorizaciónJobQueue` en el cliente para el auto-restart y las alertas; no reinventes notificaciones.
5. `Commit()` tras escribir el log HTTP (como hace `KSeFHttpLog`), para que el rastro sobreviva a un rollback posterior.
6. Tabla de log HTTP por app, calcada de `Tab7149543.KSeFHttpLog.al`: `Entry No.` (AutoIncrement), `Date Time`, FK al documento, `Direction` (Request/Response), `HTTP Method`, `URL` Text[250], `Status Code`, `Body` Blob (OutStream UTF8), `Error Message`. TaxIA (`TIAPresentationLog`) añade `Environment`, `CSV` y request+response en el mismo registro — también válido.

## 6. Errores históricos: síntoma → causa → prevención

Fuente: git log de Carriers (`git log --oneline`) y código resultante. El "GLS Error -70" es un código de retorno del WS ASMRED/GLS ante XML o datos inválidos (el conocimiento vive en el equipo; no hay commit con ese literal — el fix visible es el saneado de datos que sigue).

| Síntoma | Causa | Prevención (verificada en código) |
|---|---|---|
| GLS devuelve error (p.ej. -70) y no hay expedición; `CodBarras` vacío | XML inválido por `&`/`<` en nombre, dirección u observaciones concatenados a mano | Construir con XmlElement (§2.2). Parche histórico: `Replace('&','Y')` en `Cod50751.IntegracionTransaher.al:149` (commit `55358d3`). En el flujo GLS, si `CodBarras = ''` se marca `Utilidades.SetEstadoWSError(NumeroAlbaran)` en vez de dar OK falso |
| El WS rechaza o trunca referencias/facturas | Límites de longitud del proveedor (referencia/nº factura 20, dirección 50, nombre 40, ciudad 45, observaciones 70) | `CopyStr` explícito ANTES de enviar: `Cod50751.IntegracionTransaher.al:41-118`, `Cod50753.IntegracionMRW.al:680` (`Referencia := CopyStr(Referencia,1,20)`), `Cod50752.UtilidadesCarriers.al:716,1056`. Documenta cada límite con comentario |
| Fechas interpretadas mal por el WS (envíos en día erróneo) | `Format(Date)` sin máscara depende de la regional | Máscara explícita siempre: `'<Day,2>/<Month,2>/<Year4>'` (`Cod50750.IntegracionGLS.al:90`). Commits: `6a92eb3 [FIX] Fechas MRW`, `b4615af [FIX] Date to y date from de schenker` |
| Decimales rechazados (peso con coma) | Formato regional con coma decimal | `Format(Peso, 0, '<Precision,2:2><Standard Format,0>')` (GLS:141); Schenker convierte `ConvertStr(t, ',', '.')` (`Cod50768.IntegracionESchenker.al:496`) |
| Etiquetas/documentos con caracteres corruptos | Acentos y Ñ fuera del charset del proveedor | Transliterar antes de enviar: `Cod50766.IntegracionCTT.al:1567-1568` (`Replace('Á','A')...Replace('ñ','n')`) |
| CTT rechaza campos | Longitud excedida en manifiesto CTT | Commit `d7f3415 [FIX] - Error length CTT`; aplicar CopyStr por campo como en Transaher |
| Token CTT caduca en mitad de un lote / peticiones de token excesivas | No se respetaba `expires_in` | Caché de token con margen: `Caducidad token` en Shipping Agent y renovación si quedan <3 min (`Cod50766.IntegracionCTT.al:79-133`; commit `e96c9d9 [MOD] - Adaptar token CTT a expires_in`) |
| Teléfono rechazado por el WS | Espacios y prefijo +34 | Normalizar: `TelefonoRemitente.Replace(' ','')` (`Cod50767.RecogidaTransaher.al:57`) y `Utilidades.GetNumTelfono` (commits `4cfe9a5`, `aa39183`) |
| Respuesta con XML embebido escapado no parseable | El WS (Transaher) devuelve `&lt;...&gt;` dentro del body | Des-escapar antes de `XmlDocument.ReadFrom`: `Cod50751.IntegracionTransaher.al:215-217` |

## 7. Checklist: añadir un proveedor/transportista nuevo

1. **Enum**: añade el valor a `Enum50750.Integraciones` (Carriers) o crea el enum de proveedor de tu app.
2. **Setup**: URLs y SOAPAction/endpoints en la tabla de config (nuevos campos en `Tab50751.ConfigCarrier` o tabla propia con entorno pre/prod estilo `TIA Endpoint`). Nada de URLs hardcodeadas — las que veas en código GLS comentado son restos de pruebas.
3. **Credenciales**: campos de identificación no sensibles en tabla/tableextension; secretos en Isolated Storage (§4). Nunca commitees credenciales reales ni en comentarios (hay UIDs reales comentados en `Cod50762.RecogidasGLS.al` — no lo repitas).
4. **Codeunit de integración** `IntegracionXXX` con: envío de expedición, obtención de etiqueta, anulación y seguimiento, siguiendo la capa HTTP de §1. SOAP → §2.2; REST → §3. Token con caché y margen de renovación (§6, patrón CTT).
5. **Saneado de datos salientes**: CopyStr a los límites documentados del proveedor, fechas/decimales con máscara explícita, transliteración de acentos si el proveedor lo exige, teléfono normalizado (§6).
6. **Respuesta**: parsea código/URL de etiqueta/nº seguimiento; si falta el dato clave, marca `EstadoWS::Error` — nunca OK silencioso. Guarda request+response (tabla de log §5 o `GuardarDatosEnvio`).
7. **Etiqueta**: base64 → `ImprimirEtiquetaPDF` (vía PrintNode, dependencia real: commit `52624bd`) y `DescargarEtiquetaPDF` de `Cod50752.UtilidadesCarriers.al`.
8. **Cablea el dispatcher**: alta en `Cod50760.EventosCarriers.al` / `Cod50761.EnvioPedidosWSAuto.al` y en `Cod50755.ActualizacionSeguimientos.al` para el seguimiento por Job Queue.
9. **Enlace de tracking** para el cliente (campo `EnlaceXXX` en ConfigCarrier) y plantilla de email si aplica (`Cod50764.EnviarEmailsSeguimiento.al`).
10. **Prueba en sandbox del proveedor** con: nombre con `&` y `Ñ`, dirección >50 chars, referencia >20 chars, pedido multi-bulto, y anulación. Son exactamente los casos que costaron commits (§6).
11. Si añades UI (page de datos del envío, acción en albarán), aplica `devconsultia-al-ui-patterns`.

## Provenance y mantenimiento

Escrito el 2026-07-06 a partir del código real de doce apps de la casa (transportistas, AEAT, EDI, facturación electrónica, mensajería, CRM, impresión, almacenamiento en la nube, marketplaces y monitorización de Job Queue). Neutralizada el 2026-08-16 bajo REQ-000380: las rutas concretas viven ahora en `devconsultia-portfolio-estado` (interno), porque esta skill se empaqueta en repositorios de cliente. Todo lo no etiquetado como PROPUESTA está verificado en el código. Re-verificación:

```powershell
# ¿Sigue el anti-patrón SOAP por concatenación?
Select-String -Path 'C:\DevConsultIA-repos\Carriers__Carriers\src\codeunit\*.al' -Pattern "'<soap" -List
# ¿Quién usa Isolated Storage hoy?
Get-ChildItem C:\DevConsultIA-repos -Recurse -Filter *.al | Select-String -Pattern 'IsolatedStorage' -List
# ¿Reintentos/rate-limit?
Get-ChildItem C:\DevConsultIA-repos -Recurse -Filter *.al | Select-String -Pattern 'MaxAttempts|Sleep\(' -List
# Historia de fixes de Carriers
git -C 'C:\DevConsultIA-repos\Carriers__Carriers' log --oneline | Select-String 'FIX'
```

Actualiza esta skill cuando: se migre un SOAP a XmlDocument, se muevan secretos de Carriers/EDI a Isolated Storage, o se añada un transportista (refleja sus límites de campo en la tabla del §6).
