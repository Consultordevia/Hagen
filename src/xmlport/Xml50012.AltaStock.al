#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50012 "Alta Stock"
{
    Caption = 'Alta Stock';
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding =  UTF16;

    schema
    {
        textelement(root)
        {
            MinOccurs = Zero;
            tableelement("Payment Terms"; "Payment Terms")
            {
                AutoSave = false;
                XmlName = 'DataExchDocument';
                textelement(codigo)
                {
                }
                textelement(cantidad)
                {
                }
                textelement(precio)
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

    trigger OnInitXmlPort()
    begin

        ventana.Open('#1#######################');

        Rec83.Reset;
        Rec83.SetRange(Rec83."Journal Template Name", 'INVENT. FÍ');
        Rec83.SetRange(Rec83."Journal Batch Name", 'STOCK');
        if Rec83.Find('-') then begin
            Rec83.DeleteAll;
        end;


        Item.SetRange(Blocked, false);
        //////RecItem.SETRANGE(RecItem."Producto almacenable",TRUE);
        if Item.FindSet then
            repeat
                ventana.Update(1, Item."No.");
                ItemUnitofMeasure.Reset;
                ItemUnitofMeasure.SetRange(ItemUnitofMeasure."Item No.", Item."No.");
                ItemUnitofMeasure.SetRange(ItemUnitofMeasure.Code, 'UDS');
                if not ItemUnitofMeasure.FindFirst then begin
                    ItemUnitofMeasure.Init;
                    ItemUnitofMeasure."Item No." := Item."No.";
                    ItemUnitofMeasure.Code := 'UDS';
                    ItemUnitofMeasure."Qty. per Unit of Measure" := 1;
                    ItemUnitofMeasure.Insert;
                end;

                RecItem2.Get(Item."No.");
                RecItem2.SetRange(RecItem2."Location Filter", 'SILLA', 'SILLA');
                RecItem2.CalcFields(RecItem2.Inventory);
                STOCCAL := RecItem2.Inventory;
                Rec83.Init;
                Rec83."Journal Template Name" := 'INVENT. FÍ';
                Rec83."Journal Batch Name" := 'STOCK';
                lin := lin + 10000;
                Rec83."Line No." := lin;
                Rec83."Phys. Inventory" := false;
                Rec83.Validate(Rec83."Item No.", Item."No.");
                Rec83."Phys. Inventory" := true;
                Rec83."Location Code" := 'SILLA';
                Rec83."Posting Date" := 20190930D;
                /////     Rec83."Unit of Measure Code":=Item."Base Unit of Measure";
                Rec83.Validate(Rec83."Qty. (Calculated)", STOCCAL);
                Rec83."Document No." := 'AJUSTES';
                Rec83.Insert;
            until Item.Next = 0;
        ventana.Close;


        Commit;
    end;

    var
        DataExchField: Record "Data Exch. Field";
        DataExchEntryNo: Integer;
        ImportedLineNo: Integer;
        FileLineNo: Integer;
        HeaderLines: Integer;
        HeaderLineCount: Integer;
        ColumnNo: Integer;
        HeaderTag: Text;
        FooterTag: Text;
        SkipLine: Boolean;
        LastLineIsFooter: Boolean;
        HeaderWarning: Boolean;
        LineType: Option Unknown,Header,Footer,Data;
        CurrentLineType: Option;
        FullHeaderLine: Text;
        LastLineIsHeaderErr: label 'The imported file contains unexpected formatting. One or more lines may be missing in the file.';
        WrongHeaderErr: label 'The imported file contains unexpected formatting. One or more headers are incorrect.';
        DataExchLineDefCode: Code[20];
        Contact: Record Contact;
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        CODPROD: Code[10];
        CODENVIO: Code[20];
        Item: Record Item;
        valorpbp: Decimal;
        stock: Record "Cesta compra";
        CANTIDE: Decimal;
        conta: Integer;
        ventana: Dialog;
        codconta: Code[10];
        XX: Integer;
        POSI: Integer;
        DDD: array[42] of Decimal;
        YY: Integer;
        LATARIFA: Code[10];
        LALAMA: Code[10];
        CUANTA1: Integer;
        ELANCHO: array[70] of Decimal;
        ELALTO: Decimal;
        LINEAS: Integer;
        UNO: Code[255];
        DOS: Code[255];
        UBICA: Code[20];
        POS: Decimal;
        LON: Decimal;
        REF: Code[20];
        SALE: Boolean;
        kilos: Code[20];
        fc: Code[10];
        frecp: Code[10];
        RecItem: Record Item;
        REFCONFOR: Code[20];
        LDP: Record "Item Journal Line";
        CANTIDECI: Decimal;
        KILOSDECI: Decimal;
        SUMALINS: Decimal;
        MovProducto2: Record "Item Ledger Entry";
        RegInvFis: Record "Phys. Inventory Ledger Entry";
        NoMov: Decimal;
        Desdemov: Decimal;
        NoMov2IF: Decimal;
        NoMov2: Decimal;
        NoDoc: Code[10];
        RegMovProd: Record "Item Register";
        TIPO2: Integer;
        ImporteT: Decimal;
        Rec83: Record "Item Journal Line";
        lin: Decimal;
        RecSDP: Record "Item Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        DPRECIO: Decimal;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        RecItem2: Record Item;
        STOCCAL: Decimal;

    local procedure InitializeGlobals()
    var
        DataExchDef: Record "Data Exch. Def";
    begin
    end;

    local procedure CheckLineType()
    begin
        ValidateNonDataLine;
        TrackNonDataLines;
        SkipLine := CurrentLineType <> Linetype::Data;

        if not SkipLine then begin
            HeaderLineCount := 0;
            ImportedLineNo += 1;
        end;
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







        if RecItem.Get(codigo) then begin
            if RecItem.Blocked = true then begin
                RecItem.Blocked := false;
                RecItem.Modify;
            end;

        end;


        lin := 10000;
        Rec83.Reset;
        Rec83.SetRange(Rec83."Journal Template Name", 'INVENT. FÍ');
        Rec83.SetRange(Rec83."Journal Batch Name", 'STOCK');
        Rec83.SetRange("Item No.", codigo);
        if Rec83.FindLast then begin
            Evaluate(CANTIDECI, cantidad);
            Evaluate(DPRECIO, precio);
            if CANTIDECI <> 0 then begin
                Item.Get(codigo);
                if Item."Base Unit of Measure" = '' then begin
                    Item."Base Unit of Measure" := 'UDS';
                    Item."Unit Cost" := DPRECIO;
                    Item."Standard Cost" := DPRECIO;
                    Item."Last Direct Cost" := DPRECIO;
                    Item.Modify;
                end;
                Rec83.Validate(Rec83."Qty. (Phys. Inventory)", CANTIDECI);
                Rec83.Validate("Unit Cost", DPRECIO);
                Rec83.Validate("Unit Amount", DPRECIO);
                Rec83."Posting Date" := 20190930D;
                Rec83.Modify;

            end;
        end;
    end;
}

