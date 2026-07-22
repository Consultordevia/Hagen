#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50017 "ImprimirAlbaranes"
{
    Permissions = tabledata "Sales Shipment Header" = rmi;

    trigger OnRun()
    var
        SHH: Record "Sales Shipment Header";
        SHH2: Record "Sales Shipment Header";
        LogReports: Codeunit "Gestion Log Reports";
    begin
        // Pass 1: albaranes — solo registros con Albaran sin detalle y sin dropshipping
        SHH.Reset();
        SHH.SetCurrentKey(ImpresoporImporesora);
        SHH.SetRange(ImpresoporImporesora, false);
        SHH.SetRange("Albaran sin detalle", true);
        SHH.SetRange(Dropshipping, false);
        IF SHH.FindSet() THEN
            REPEAT
                // Consumir el retorno de la TryFunction para que capture errores (un albarán malo no debe tumbar la cola).
                if ImprimirAlbaran(SHH) then;
            UNTIL SHH.NEXT = 0;

        // Pass 2: etiquetas para todos los no impresos + marcar como impreso
        SHH.Reset();
        SHH.SetCurrentKey(ImpresoporImporesora);
        SHH.SetRange(ImpresoporImporesora, false);
        IF SHH.FindSet() THEN
            REPEAT
                if ImprimirEtiquetas(SHH) then;
                // En modo prueba NO marcar como impreso, para que queden pendientes al pasar a real.
                if not LogReports.ImpresionDesactivada() then begin
                    SHH2.GET(SHH."No.");
                    SHH2.ImpresoporImporesora := TRUE;
                    SHH2.Modify();
                end;
            UNTIL SHH.NEXT = 0;
    end;

    [TryFunction]
    procedure ImprimirAlbaran(SHH: Record "Sales Shipment Header")
    var
        SHH3: Record "Sales Shipment Header";
        LogReports: Codeunit "Gestion Log Reports";
    begin
        SHH3.Reset();
        SHH3.SetRange("No.", SHH."No.");
        IF SHH3.FindFirst() THEN
            if SHH."Shipping Agent Code" <> 'ECI' then begin
                // Guarda de seguridad + log: en la cola no debe imprimir albaranes sin el check marcado.
                if LogReports.ProcesarImpresionAlbaran(SHH3, 1308, 'Sales - Shipment', 'COLA-50017', true) then
                    Report.Run(1308, false, false, SHH3);
            end else
                if LogReports.ProcesarImpresionAlbaran(SHH3, 50905, 'OK Albaran NO valorado ECI', 'COLA-50017', true) then
                    Report.Run(50905, false, false, SHH3);
    end;

    [TryFunction]
    procedure ImprimirEtiquetas(SHH: Record "Sales Shipment Header")
    var
        RecClie: Record Customer;
        StoA: Record "Ship-to Address";
        SHH3: Record "Sales Shipment Header";
        LogReports: Codeunit "Gestion Log Reports";
    begin
        // Modo prueba: tampoco imprimir etiquetas.
        if LogReports.ImpresionDesactivada() then
            exit;
        // Cliente vacío o inexistente: no imprimir etiquetas (evita error que tumbaba la cola).
        if not RecClie.Get(SHH."Sell-to Customer No.") then
            exit;
        StoA.Reset();
        StoA.SetRange("Customer No.", RecClie."No.");
        StoA.SetRange("Imprime Etiqueta envio", true);
        if StoA.FindFirst() then begin
            SHH3.Reset();
            SHH3.SetRange("No.", SHH."No.");
            IF SHH3.FindFirst() THEN
                Report.Run(Report::"Etiqueta grande envio", false, false, SHH3);
        end;
        IF RecClie."Etiqueta Kiwoko" THEN begin
            SHH3.Reset();
            SHH3.SetRange("No.", SHH."No.");
            IF SHH3.FindFirst() THEN
                Report.Run(Report::"Etiqueta Kiwoko", false, false, SHH3);
        end;
    end;
}
