#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50034 "Envio emails Albaran sin detal"
{

    trigger OnRun()
    var
        SalesShipment: Record "Sales Shipment Header";
        Codeunit50010: Codeunit "Automaticos Cartas";
        RecClie: Record Customer;

    begin
        SalesShipment.Reset;
        SalesShipment.SetCurrentkey("Enviar email sin detalle", "Email enviado sin detalle");
        SalesShipment.SetRange("Enviar email sin detalle", true);
        ///SalesShipment.SetRange("Email enviado sin detalle", false);
        SalesShipment.SETRANGE("Posting Date", 20250215D, TODAY);
        if SalesShipment.FindFirst() then
            repeat
                if RecClie.geT(SalesShipment."Sell-to Customer No.") then begin
                    if RecClie."Servicio email" then begin
                        Clear(Codeunit50010);
                        Codeunit50010.ENVIAREMIALALBARSINDETALLE(SalesShipment);
                    end;
                end;
            until SalesShipment.next = 0;

    end;
}

