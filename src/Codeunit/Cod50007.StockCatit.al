codeunit 50007 StockCatit
{
    Permissions = tabledata "Sales Invoice Header" = RMID, tabledata "Sales Shipment Header" = RMID, tabledata "Sales Cr.Memo Header" = RMID;

    trigger OnRun()
    var
        LastLineIsHeaderErr: label 'The imported file contains unexpected formatting. One or more lines may be missing in the file.';
        WrongHeaderErr: label 'The imported file contains unexpected formatting. One or more headers are incorrect.';
        WORKDATED: Date;
        KIL: Decimal;
        CAN: Decimal;
        UNO: Code[20];
        DOS: Code[20];
        POS: Decimal;
        LON: Decimal;
        REF: Code[20];
        SALE: Boolean;
        P: Record Item;
        REFCONFOR: Code[20];
        LDP: Record "Item Journal Line";
        CANTIDECI: Decimal;
        KILOSDECI: Decimal;
        NL: Decimal;
        TiendaFichero: Code[10];
        FechaFichero: Code[10];
        ExisAlma: Decimal;
        Exis: Decimal;
        Documento: Code[10];
        FechaDoc: Date;
        Dif: Decimal;
        Difmayor: Decimal;
        Fecha: Record Date;
        Dialo: Dialog;
        RecCuenta: Record "G/L Account";
        VentaC: Decimal;
        VentaMP: Decimal;
        MP: Record "Item Ledger Entry";
        ArchSalida: File;
        ArchExt: Text[30];
        Ascii: Boolean;
        Ventana: Dialog;
        CodDFecha: Date;
        CodHFecha: Date;
        TextoSalida: Text[250];
        Recproducto: Record Item;
        "RecAlmacén": Record Location;
        Importe: Decimal;
        RecIVA: Record "VAT Posting Setup";
        Dia: Code[2];
        Mes: Code[2];
        Dia1: Decimal;
        Mes1: Decimal;
        Ventana2: Dialog;
        opc: Integer;
        ArchExt1: Text[30];
        ArchExt2: Text[30];
        TextoSalida1: Text[250];
        TextoSalida2: Text[250];
        ArchSalida1: File;
        ArchSalida2: File;
        CodDTienda: Code[10];
        CodHTienda: Code[10];
        RecSDP: Record "Item Journal Batch";
        lin: Decimal;
        Rec83: Record "Item Journal Line";
        RecItem: Record Item;
        RecUMP: Record "Item Unit of Measure";
        STOCCAL: Decimal;
        RecItem2: Record Item;
        Rec32: Record "Item Ledger Entry";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ACCION: Code[20];
        DCanti: Decimal;
        TIPO2: Integer;
        ITEM: Record Item;
        Existencia: Decimal;
        atraspasar: Decimal;
        CURegMov: Codeunit "Item Jnl.-Post Batch";


    begin


        RecSDP.Reset;
        RecSDP.SetRange(RecSDP."Journal Template Name", 'PRODUCTO');
        RecSDP.SetRange(RecSDP.Name, 'CATIT');
        if not RecSDP.FindFirst then begin
            RecSDP."Journal Template Name" := 'PRODUCTO';
            RecSDP.Name := 'CATIT';
            RecSDP.Insert;
        end;
        lin := 10000;
        Rec83.Reset;
        Rec83.SetRange(Rec83."Journal Template Name", 'PRODUCTO');
        Rec83.SetRange(Rec83."Journal Batch Name", 'CATIT');
        if Rec83.FindFirst THEN
            repeat
                Rec83.DELETE;
            UNTIL Rec83.Next = 0;





        RecItem.RESET;
        if RecItem.FindSet then
            repeat

                RecItem.CalcFields("Existencia SILLA", "Existencia FOB", "Qty. on Sales Order", "Existencia CATIT");
                Existencia := RecItem."Existencia SILLA" - RecItem."Existencia FOB" - RecItem."Qty. on Sales Order" - RecItem."Existencia CATIT";
                if RecItem."Stock para Catit" <> 0 then begin
                    atraspasar := RecItem."Stock para Catit" - RecItem."Existencia CATIT";
                    ///// 
                    if (RecItem."Existencia SILLA" = 0) then begin
                        Rec83.Init;
                        Rec83."Journal Template Name" := 'PRODUCTO';
                        Rec83."Journal Batch Name" := 'CATIT';
                        lin := lin + 10000;
                        Rec83."Line No." := lin;
                        Rec83.Validate(Rec83."Item No.", RecItem."No.");
                        Rec83."Posting Date" := Today;
                        Rec83.Validate(Rec83."Entry Type", Rec83."Entry Type"::"Positive Adjmt.");
                        Rec83.Validate(Rec83.Quantity, RecItem."Existencia CATIT" * -1);
                        Rec83."Document No." := 'AJUSTES CATIT';
                        Rec83."Location Code" := 'CATIT';
                        IF RecItem."Existencia CATIT"<>0 THEN BEGIN
                            Rec83.Insert;
                        END;

                    end;
                    if atraspasar >= 0 then begin
                        if RecItem."Existencia SILLA" <= 0 then begin
                            atraspasar := 0;
                        end;
                        if RecItem."Existencia SILLA" < atraspasar then begin
                            atraspasar := RecItem."Existencia SILLA" - RecItem."Existencia CATIT";
                        end;
                        if RecItem."Stock para Catit" > RecItem."Existencia SILLA" then begin
                            atraspasar := RecItem."Existencia SILLA";
                        end;
                        if atraspasar = 0 then begin
                            atraspasar := RecItem."Existencia CATIT"*-1;
                        end;                        
                        if atraspasar > 0 then begin
                            RecUMP.Reset();
                            RecUMP.SetRange("Item No.", RecItem."No.");
                            RecUMP.SetRange(CODE, 'UDS');
                            if not RecUMP.FindFirst() then begin
                                RecUMP.Init();
                                RecUMP."Item No." := RecItem."No.";
                                RecUMP.Code := 'UDS';
                                RecUMP.INSERT;
                            end;


                            if atraspasar > 0 then begin
                                Rec83.Init;
                                Rec83."Journal Template Name" := 'PRODUCTO';
                                Rec83."Journal Batch Name" := 'CATIT';
                                lin := lin + 10000;
                                Rec83."Line No." := lin;
                                Rec83.Validate(Rec83."Item No.", RecItem."No.");
                                Rec83."Posting Date" := Today;
                                Rec83.Validate(Rec83."Entry Type", Rec83."Entry Type"::"Positive Adjmt.");
                                Rec83.Validate(Rec83.Quantity, atraspasar);
                                Rec83."Document No." := 'AJUSTES CATIT';
                                Rec83."Location Code" := 'CATIT';
                                Rec83.Insert;
                                Rec83.Init;
                                Rec83."Journal Template Name" := 'PRODUCTO';
                                Rec83."Journal Batch Name" := 'CATIT';
                                lin := lin + 10000;
                                Rec83."Line No." := lin;
                                Rec83.Validate(Rec83."Item No.", RecItem."No.");
                                Rec83."Posting Date" := Today;
                                Rec83.Validate(Rec83."Entry Type", Rec83."Entry Type"::"Negative Adjmt.");
                                Rec83.Validate(Rec83.Quantity, atraspasar);
                                Rec83."Document No." := 'AJUSTES CATIT';
                                Rec83."Location Code" := 'SILLA';
                                Rec83.Insert;
                            end;
                        end;
                    end;
                end;
            until RecItem.next = 0;


        Rec83.Reset;
        Rec83.SetRange(Rec83."Journal Template Name", 'PRODUCTO');
        Rec83.SetRange(Rec83."Journal Batch Name", 'CATIT');
        if Rec83.FindFirst then begin
            /////CURegMov.Run(Rec83);
        end;




    end;
}