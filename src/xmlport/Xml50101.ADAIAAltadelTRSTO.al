#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50101 "ADAIA_Alta del TRSTO"
{
    Caption = 'ADAIA_Alta del TRSTO';
    Direction = Import;
    FieldSeparator = '|';
    Format = VariableText;
    TextEncoding =  UTF16;
    UseRequestPage = false;

    ///    1   2    3        4        5     6      7    8        9   10     11 12 13      14   15 16 17   18   19   20
    ///  STSI|MO|010A00101|S2510|000000028|UD|00000001|000000000| |20121213|  |  |OK|010A00101|  |EU|   |    |E130|

    schema
    {
        textelement(root)
        {
            MinOccurs = Zero;
            tableelement("Payment Terms"; "Payment Terms")
            {
                AutoSave = false;
                XmlName = 'DataExchDocument';
                textelement(D1)
                {
                    Width = 255;
                }
                textelement(D2)
                {
                }
                textelement(D3)
                {
                }
                textelement(D4)
                {
                }
                textelement(D5)
                {
                }
                textelement(D6)
                {
                }
                textelement(D7)
                {
                }
                textelement(D8)
                {
                }
                textelement(D9)
                {
                }
                textelement(D10)
                {
                }
                textelement(D11)
                {
                }
                textelement(D12)
                {
                }
                textelement(D13)
                {
                }
                textelement(D14)
                {
                }
                textelement(D15)
                {
                }
                textelement(D16)
                {
                }
                textelement(D17) { }
                textelement(D18) { }
                textelement(D19) { }


                textelement(D20)
                {

                    trigger OnAfterAssignVariable()
                    begin

                        ValidateHeaderTag;
                    end;
                }

            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPreXmlPort()
    begin


        RecMT.RESET;
        RecMT.SETRANGE(RecMT.Tabla, 17);
        IF RecMT.FINDFIRST THEN
            REPEAT
                RecMT.DELETE;
            UNTIL RecMT.NEXT = 0;

        WORKDATED := WORKDATE;
        FechaFichero := FORMAT(WORKDATED);
        RecSDP.RESET;
        RecSDP.SETRANGE(RecSDP."Journal Template Name", 'INVENT. FÍ');
        RecSDP.SETRANGE(RecSDP.Name, FechaFichero);
        IF RecSDP.FINDFIRST THEN BEGIN
            Rec83.RESET;
            Rec83.SETRANGE(Rec83."Journal Template Name", RecSDP."Journal Template Name");
            Rec83.SETRANGE(Rec83."Journal Batch Name", RecSDP.Name);
            IF Rec83.FIND('-') THEN BEGIN
                Rec83.DELETEALL;
            END;
        END;

        IF NOT RecSDP.FINDFIRST THEN BEGIN
            RecSDP."Journal Template Name" := 'INVENT. FÍ';
            RecSDP.Name := FechaFichero;
            RecSDP.Description := 'INVENTARIO ' + FechaFichero;
            RecSDP.INSERT;

        END;

        Item.RESET;
        Item.SETRANGE(Blocked, FALSE);
        Item.SETRANGE(Item."Producto almacenable", TRUE);
        IF Item.FINDSET THEN
            REPEAT
                ItemUnitofMeasure.RESET;
                ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure."Item No.", Item."No.");
                ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure.Code, 'UDS');
                IF NOT ItemUnitofMeasure.FINDFIRST THEN BEGIN
                    ItemUnitofMeasure.INIT;
                    ItemUnitofMeasure."Item No." := Item."No.";
                    ItemUnitofMeasure.Code := 'UDS';
                    ItemUnitofMeasure."Qty. per Unit of Measure" := 1;
                    ItemUnitofMeasure.INSERT;
                END;

                RecItem2.GET(Item."No.");
                RecItem2.SETRANGE(RecItem2."Location Filter", 'SILLA', 'SILLA');
                RecItem2.CALCFIELDS(RecItem2.Inventory);
                STOCCAL := RecItem2.Inventory;
                Rec83.INIT;
                Rec83."Journal Template Name" := 'INVENT. FÍ';
                Rec83."Journal Batch Name" := FechaFichero;
                lin := lin + 10000;
                Rec83."Line No." := lin;
                Rec83."Phys. Inventory" := FALSE;
                Rec83.VALIDATE(Rec83."Item No.", Item."No.");
                Rec83."Phys. Inventory" := TRUE;
                Rec83."Location Code" := 'SILLA';
                Rec83."Posting Date" := TODAY;
                Rec83."Unit of Measure Code" := Item."Base Unit of Measure";
                Rec83.VALIDATE(Rec83."Qty. (Calculated)", STOCCAL);
                Rec83."Document No." := 'AJUSTES';
                Rec83.INSERT;

            UNTIL Item.NEXT = 0;










    end;

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
        RecPP: Record "Purchase Price";
        Rec32: Record "Item Ledger Entry";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ACCION: Code[20];
        DCanti: Decimal;
        TIPO2: Integer;
        ITEM: Record Item;
        RecMT: Record Multitabla;
        UBICA: CODE[20];
        FC: CODE[20];
        A2: INTEGER;
        M2: INTEGER;
        DD2: INTEGER;
        A1: CODE[20];
        M1: CODE[20];
        DD1: CODE[20];
        fechacadu: DATE;
        conta: Integer;
        codlote: CODE[20];



    local procedure InitializeGlobals()
    var
        DataExchDef: Record "Data Exch. Def";
    begin
    end;

    local procedure CheckLineType()
    begin
        ValidateNonDataLine;
        TrackNonDataLines;
    end;

    local procedure IdentifyLineType()
    begin
    end;

    local procedure ValidateNonDataLine()
    begin
    end;

    local procedure TrackNonDataLines()
    begin
    end;

    local procedure HeaderTagLength(): Integer
    var
        DataExchDef: Record "Data Exch. Def";
    begin
    end;

    local procedure FooterTagLength(): Integer
    var
        DataExchDef: Record "Data Exch. Def";
    begin
    end;

    local procedure GetFieldLength(TableNo: Integer; FieldNo: Integer): Integer
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
    end;

    local procedure InsertColumn(columnNumber: Integer; var columnValue: Text)
    var
        savedColumnValue: Text;
    begin
    end;

    local procedure ValidateHeaderTag()
    begin


        UBICA := D3;

        REF := D4;

        Evaluate(DCanti, D5);

        FC := D10;
        codlote := D14;

        IF FC <> '' THEN BEGIN
            IF FC <> '|' THEN BEGIN
                a1 := COPYSTR(FC, 1, 4);
                m1 := COPYSTR(FC, 5, 2);
                Dd1 := COPYSTR(FC, 7, 2);
                EVALUATE(a2, a1);
                EVALUATE(m2, m1);
                EVALUATE(Dd2, Dd1);
                fechacadu := DMY2DATE(dD2, m2, a2);
            END;
        END;
        IF RecItem2.GET(REF) THEN BEGIN
            conta := conta + 1;
            RecMT.INIT;
            RecMT.Tabla := 17;
            RecMT.Codigo := FORMAT(conta);
            RecMT.Producto := REF;
            RecMT.Ubicacion := UBICA;
            RecMT.Cantidad := DCanti;
            RecMT."Fecha caducidad" := fechacadu;
            RecMT.Lote := codlote;
            RecMT.INSERT;
        END;
        IF Item.GET(REF) THEN BEGIN
            IF Item.Blocked = FALSE THEN BEGIN
                ItemUnitofMeasure.RESET;
                ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure."Item No.", REF);
                ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure.Code, 'UDS');
                IF NOT ItemUnitofMeasure.FINDFIRST THEN BEGIN
                    ItemUnitofMeasure.INIT;
                    ItemUnitofMeasure."Item No." := REF;
                    ItemUnitofMeasure.Code := 'UDS';
                    ItemUnitofMeasure."Qty. per Unit of Measure" := 1;
                    ItemUnitofMeasure.INSERT;
                END;
                Rec83.RESET;
                Rec83.SETRANGE(Rec83."Journal Template Name", 'INVENT. FÍ');
                Rec83.SETRANGE(Rec83."Journal Batch Name", FechaFichero);
                Rec83.SETRANGE(Rec83."Item No.", REF);
                IF Rec83.FINDFIRST THEN BEGIN
                    Rec83.VALIDATE(Rec83."Qty. (Phys. Inventory)", Rec83."Qty. (Phys. Inventory)" + DCanti);
                    Rec83.MODIFY;
                    COMMIT;
                END;
            END;
        END;
    end;

    /*








    {




    RecSDP.RESET;                                   
    RecSDP.SETRANGE(RecSDP."Journal Template Name",'INVENT. FÍ');
    RecSDP.SETRANGE(RecSDP.Name,FechaFichero);
    IF RecSDP.FINDFIRST THEN BEGIN      
         Rec83.RESET;
         Rec83.SETRANGE(Rec83."Journal Template Name",RecSDP."Journal Template Name");
         Rec83.SETRANGE(Rec83."Journal Batch Name",RecSDP.Name);
         IF Rec83.FIND('-') THEN REPEAT
              IF Rec83.Quantity=0 THEN BEGIN
                   Rec83.DELETE;
              END;
         UNTIL Rec83.NEXT=0;
    END;
    */



}

