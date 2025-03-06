codeunit 50014 EnviaClienteAdaia
{


    trigger OnRun()
    var
        RecSH: Record "Sales Header";
        RecSH2: Record "Sales Header";
        CU_Auto: Codeunit "Automaticos Cartas";


    begin


        RecSH.Reset;
        RecSH.SetCurrentKey(ClienteEnviadoAdaia);        
        RecSH.SetRange("Document Type", RecSH."Document Type"::Order);
        RecSH.SetRange("Order Date",20250101D,TODAY);
        RecSH.SetRange(ClienteEnviadoAdaia, false);
        if RecSH.FindFirst then
            repeat
                IF RecSH2.get(RecSH."Document Type", RecSH."No.") THEN begin
                    RecSH2.ClienteEnviadoAdaia := TRUE;
                    RecSH2.Modify;
                    CU_Auto.TERCEROSMODIFcliente(RecSH."Sell-to Customer No.");
                END;
            until RecSH.next = 0;



    end;
}