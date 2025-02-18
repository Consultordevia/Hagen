#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50037 "ColaStockTenerife"
{

    trigger OnRun()
    begin

        StockTenerife;



        exit;
    end;

    var
        VENTANA: Dialog;
        RecItemE: Record Item;
        RecItemC: Record Item;
        Rec83: Record "Item Journal Line";
        atraspasar: Decimal;
        CURegMov: Codeunit "Item Jnl.-Post Batch";
        RecItem1E: Record item;
        RecItem2C: Record item;
        ExistenciaE: Decimal;
        ExistenciaC: Decimal;
        lin: Decimal;
        RecSDP: Record "Item Journal Batch";






    local procedure StockTenerife()
    begin


        RecSDP.Reset;
        RecSDP.SetRange(RecSDP."Journal Template Name", 'PRODUCTO');
        RecSDP.SetRange(RecSDP.Name, 'TENERIFE');
        if not RecSDP.FindFirst then begin
            RecSDP."Journal Template Name" := 'PRODUCTO';
            RecSDP.Name := 'TENERIFE';
            RecSDP.Insert;
        end;
        lin := 10000;
        Rec83.Reset;
        Rec83.SetRange(Rec83."Journal Template Name", 'PRODUCTO');
        Rec83.SetRange(Rec83."Journal Batch Name", 'TENERIFE');
        if Rec83.FindFirst THEN
            repeat
                Rec83.DELETE;
            UNTIL Rec83.Next = 0;





        RecItem2C.RESET;
        RecItem2C.ChangeCompany('HAGEN CANARIAS S.C.');
        RecItem2C.SetFilter("Location Filter", 'CANA', 'CANA');
        if RecItem2C.FindSet then
            repeat
                RecItem2C.CalcFields(Inventory);
                ExistenciaC := RecItem2C.Inventory;

                ExistenciaE := 0;
                RecItem1E.RESET;
                RecItem1E.ChangeCompany('ROLF C HAGEN ESPAÑA S.A.');
                RecItem1E.SetFilter("Location Filter", 'TENERIFE', 'TENERIFE');
                RecItem1E.SetFilter("No.", RecItem2C."No.");
                if RecItem1E.FindSet then BEGIN
                    RecItem1E.CalcFields(Inventory);
                    ExistenciaE := RecItem1E.Inventory
                END;


                atraspasar := ExistenciaC - ExistenciaE;
                if atraspasar > 0 then begin
                    Rec83.ChangeCompany('ROLF C HAGEN ESPAÑA S.A.');
                    Rec83.Init;
                    Rec83."Journal Template Name" := 'PRODUCTO';
                    Rec83."Journal Batch Name" := 'TENERIFE';
                    lin := lin + 10000;
                    Rec83."Line No." := lin;
                    Rec83.Validate(Rec83."Item No.", RecItem2C."No.");
                    Rec83."Posting Date" := Today;
                    Rec83.Validate(Rec83."Entry Type", Rec83."Entry Type"::"Positive Adjmt.");
                    Rec83.Validate(Rec83.Quantity, atraspasar);
                    Rec83."Document No." := 'AJUSTES TENERIFE';
                    Rec83."Location Code" := 'TENERIFE';
                    Rec83.Insert;

                end;


            until RecItem2C.next = 0;


        Rec83.Reset;
        Rec83.SetRange(Rec83."Journal Template Name", 'PRODUCTO');
        Rec83.SetRange(Rec83."Journal Batch Name", 'TENERIFE');
        if Rec83.FindFirst then begin
            CURegMov.Run(Rec83);
        end;

    END;


}

