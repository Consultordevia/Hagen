#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50017 "ImprimirAlbaranes"
{
    Permissions = tabledata "Sales Shipment Header" = rmi;

    trigger OnRun()
    var
        SHH: Record "Sales Shipment Header";
        SHH2: Record "Sales Shipment Header";
        V: Dialog;
        RecClie: Record Customer;
    begin

        V.Open('#1###########################');
        SHH.Reset();
        SHH.SetCurrentKey(ImpresoporImporesora);
        SHH.SetRange(ImpresoporImporesora, FALSE);
        IF SHH.FindSet() THEN
            REPEAT
                V.Update(1, SHH."No.");
                SHH2.GET(SHH."No.");
                SHH2.ImpresoporImporesora := TRUE;
                SHH2.Modify();
            UNTIL SHH.NEXT = 0;
        V.Close();

        EXIT;

        SHH.Reset();
        SHH.SetCurrentKey(ImpresoporImporesora);
        SHH.SetRange(ImpresoporImporesora, FALSE);
        IF SHH.FindSet() THEN
            REPEAT
                if SHH."Shipping Agent Code" <> 'ECI' then begin
                    RecClie.Get(SHH."Sell-to Customer No.");
                    if SHH."No Enviar albaran en exp." = false then begin
                        if SHH."No imprimir albaran valorado" = false then begin
                            if RecClie."Albaran valorado" = true then begin
                                if SHH.Dropshipping = true then begin
                                    Report.Run(50901, false, false, SHH);
                                end;
                            end;
                        end;
                    end;
                    if SHH."Albaran sin detalle" = true then begin
                        if SHH.Dropshipping = true then begin
                            Report.Run(50902, false, false, SHH);
                        end;
                    end;
                END;
                If SHH."Shipping Agent Code" = 'ECI' then begin
                    Report.Run(50905, false, false, SHH);
                end;
            UNTIL SHH.NEXT = 0;





    end;









}

