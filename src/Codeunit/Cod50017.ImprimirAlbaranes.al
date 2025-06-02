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
        StoA: Record "Ship-to Address";
        RepEtiquetaEnvio: Report "Etiqueta grande envio";
        RepEtiquetaKiwoko: Report "Etiqueta Kiwoko";
    begin

        /*V.Open('#1###########################');
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

        
        */

        SHH.Reset();
        SHH.SetCurrentKey(ImpresoporImporesora);
        SHH.SetRange(ImpresoporImporesora, false);
        IF SHH.FindSet() THEN
            REPEAT
                RecClie.Get(SHH."Sell-to Customer No.");
                if SHH."Shipping Agent Code" <> 'ECI' then begin
                    if SHH."No Enviar albaran en exp." = false then begin
                        if SHH."No imprimir albaran valorado" = false then begin
                            if RecClie."Albaran valorado" = true then begin
                                if SHH.Dropshipping = true then begin
                                    ///Error('1- %1 ', SHH."No.");
                                    Report.Run(50901, false, false, SHH);
                                end;
                            end;
                        end;
                    end;
                    if SHH."Albaran sin detalle" = true then begin
                        if SHH.Dropshipping = true then begin
                            ///Error('2- %1 ', SHH."No.");
                            Report.Run(50902, false, false, SHH);
                        end;
                    end;
                END;
                If SHH."Shipping Agent Code" = 'ECI' then begin
                    Report.Run(50905, false, false, SHH);
                end;
                StoA.Reset();
                StoA.SetRange("Customer No.", RecClie."No.");
                StoA.SetRange("Imprime Etiqueta envio", true);
                if StoA.FindFirst() then begin
                    SHH2.reset;
                    SHH2.SetRange("No.", SHH."No.");
                    ;
                    IF SHH2.FindFirst() THEN begin
                        Clear(RepEtiquetaEnvio);
                        RepEtiquetaEnvio.SetTableView(SHH2);
                        RepEtiquetaEnvio.RunModal();
                    END;

                end;
                IF RecClie."Etiqueta Kiwoko" THEN begin
                    Clear(RepEtiquetaKiwoko);
                    RepEtiquetaKiwoko.SetTableView(SHH2);
                    RepEtiquetaKiwoko.RunModal();
                end;
            UNTIL SHH.NEXT = 0;





    end;









}

