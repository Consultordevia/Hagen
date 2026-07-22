codeunit 50105 "Gestion Log Reports"
{
    // Log genérico de impresión de informes + guarda de seguridad para albaranes.
    //
    // Uso:
    //   - RegistrarImpresion(...)          -> solo registra (auditoría), no bloquea.
    //   - ProcesarImpresionAlbaran(...)    -> registra Y devuelve si se debe imprimir.
    //         AplicarGuardSinDetalle = true  -> en sesión automática (cola / web service)
    //                                           OMITE el albarán si "Albaran sin detalle" = false.
    //         En sesión interactiva (reimpresión manual) SIEMPRE imprime.

    procedure ProcesarImpresionAlbaran(SSH: Record "Sales Shipment Header"; ReportId: Integer; ReportName: Text; Origen: Text; AplicarGuardSinDetalle: Boolean): Boolean
    var
        Omitir: Boolean;
        Motivo: Text;
    begin
        if ImpresionDesactivada() then begin
            Omitir := true;
            Motivo := 'Impresión desactivada (modo prueba)';
        end else
            if AplicarGuardSinDetalle and EsSesionAutomatica() and (not SSH."Albaran sin detalle") then begin
                Omitir := true;
                Motivo := 'Albarán sin el check "Albaran sin detalle"';
            end;

        RegistrarImpresion(
            ReportId, ReportName, SSH."No.", SSH."Sell-to Customer No.",
            SSH."Albaran sin detalle", SSH.Dropshipping, Origen, Omitir, Motivo);

        exit(not Omitir);
    end;

    // Interruptor global de modo prueba: si está activo, no se imprime nada (solo log).
    procedure ImpresionDesactivada(): Boolean
    var
        Setup: Record "Setup Log Reports";
    begin
        if not Setup.Get() then
            exit(false);
        exit(Setup."Desactivar Impresion");
    end;

    procedure RegistrarImpresion(ReportId: Integer; ReportName: Text; DocumentNo: Code[20]; CustomerNo: Code[20]; SinDetalle: Boolean; Dropship: Boolean; Origen: Text; Omitido: Boolean; Motivo: Text)
    var
        Log: Record "Log Impresion Reports";
        ClientTypeMgt: Codeunit "Client Type Management";
    begin
        Log.Init();
        Log."Report ID" := ReportId;
        Log."Report Name" := CopyStr(ReportName, 1, MaxStrLen(Log."Report Name"));
        Log."Document No." := DocumentNo;
        Log."Sell-to Customer No." := CustomerNo;
        Log."Albaran sin detalle" := SinDetalle;
        Log.Dropshipping := Dropship;
        Log."User ID" := CopyStr(UserId, 1, MaxStrLen(Log."User ID"));
        Log."Client Type" := CopyStr(Format(ClientTypeMgt.GetCurrentClientType()), 1, MaxStrLen(Log."Client Type"));
        Log.Origen := CopyStr(Origen, 1, MaxStrLen(Log.Origen));
        Log."Fecha Hora" := CurrentDateTime;
        Log.Omitido := Omitido;
        Log.Motivo := CopyStr(Motivo, 1, MaxStrLen(Log.Motivo));
        Log.Insert(true);
    end;

    // Sesión "automática" = cola de trabajo (Background) o llamada por web service (SOAP / OData).
    // En estos casos aplicamos la guarda; en sesión de usuario (Web/Windows/Phone...) no.
    procedure EsSesionAutomatica(): Boolean
    var
        ClientTypeMgt: Codeunit "Client Type Management";
    begin
        exit(ClientTypeMgt.GetCurrentClientType() in [ClientType::Background, ClientType::OData, ClientType::ODataV4, ClientType::SOAP]);
    end;
}
