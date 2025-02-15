#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50032 "Envio emails Facturas"
{

    trigger OnRun()
    var
        SalesInvHeader: Record "Sales Invoice Header";
        RecClie: Record Customer;
    begin


        SalesInvHeader.Reset;
        SalesInvHeader.SetCurrentkey(SalesInvHeader."Enviar email", SalesInvHeader."Email enviado");
        SalesInvHeader.SetRange(SalesInvHeader."Enviar email", true);
        SalesInvHeader.SETRANGE("Posting Date", 20250128D, TODAY);
        SalesInvHeader.SetRange(SalesInvHeader."Email enviado", false);
        if SalesInvHeader.FindFirst() then
            repeat
                if RecClie.geT(SalesInvHeader."Bill-to Customer No.") then begin
                    if RecClie."Servicio email" then begin
                        Clear(Codeunit50010);
                        Codeunit50010.ENVIAREMIALFACTURAS(SalesInvHeader);
                    end;
                end;
            until SalesInvHeader.next = 0;

    end;

    var
        Codeunit50010: Codeunit "Automaticos Cartas";

}

