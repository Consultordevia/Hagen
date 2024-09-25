#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50127 "ADAIA_Ajustes adaia"
{
    Caption = 'ADAIA_Ajustes adaia';
    Direction = Import;
    FieldSeparator = '|';
    Format = VariableText;
    TextEncoding = WINDOWS;
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            MinOccurs = Zero;
            tableelement("Payment Terms"; "Payment Terms")
            {
                AutoSave = false;
                XmlName = 'DataExchDocument';
                textelement(D0)
                {
                }
                textelement(D1)
                {
                }
                textelement(PROD)
                {
                }
                textelement(TIPO)
                {
                }
                textelement(CANTI)
                {
                }
                textelement(D5)
                {
                }
                textelement(D6)
                {
                }
                textelement(SUBTIPO)
                {

                    trigger OnAfterAssignVariable()
                    begin

                        ValidateHeaderTag;
                    end;
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


        /*
        RecSDP.RESET;
        RecSDP.SETRANGE(RecSDP."Journal Template Name",'ELEMENTO');
        RecSDP.SETRANGE(RecSDP.Name,'ADAIA');
        IF NOT RecSDP.FINDFIRST THEN BEGIN
             RecSDP."Journal Template Name":='ELEMENTO';
             RecSDP.Name:='ADAIA';
             RecSDP.INSERT;
        END;
        */

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
        CANTIDAD: Decimal;
        Item: Record Item;
        valorpbp: Decimal;
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






        POS := 1;
        REF := '';
        REFCONFOR := '';
        SALE := false;
        repeat
            REF := REF + CopyStr(PROD, POS, 1);
            POS := POS + 1;
            if CopyStr(PROD, POS, 1) = '-' then begin
                SALE := true;
                REFCONFOR := REF + CopyStr(PROD, POS, 3);
            end;
        until SALE or (StrLen(PROD) = StrLen(REF));

        if not RecItem.Get(REF) then begin
            /////     CurrDataport.SKIP;
        end;


        if RecItem.Get(REF) then begin
            if RecItem.Blocked = true then begin
                /////CurrDataport.SKIP;
            end;
        end;


        lin := 10000;
        Rec83.Reset;
        Rec83.SetRange(Rec83."Journal Template Name", 'ELEMENTO');
        Rec83.SetRange(Rec83."Journal Batch Name", 'ADAIA');
        if Rec83.FindLast then begin
            lin := Rec83."Line No." + 10000;
        end;

        if TIPO = '+' then begin
            TIPO2 := 2;
        end;
        if TIPO = '-' then begin
            TIPO2 := 3;
        end;
        RecItem.Get(REF);
        Evaluate(CANTIDECI, CANTI);
        if CANTIDECI <> 0 then begin
            Rec83."Journal Template Name" := 'ELEMENTO';
            Rec83."Journal Batch Name" := 'ADAIA';
            Rec83."Line No." := lin;
            Rec83.Validate(Rec83."Item No.", REF);
            Rec83."Posting Date" := Today;
            Rec83.Validate(Rec83."Entry Type", TIPO2);
            Rec83.Validate(Rec83.Quantity, CANTIDECI);
            Rec83."Document No." := 'AJUSTES';
            Rec83."Location Code" := 'SILLA';
            Rec83.Insert;
        end;
    end;
}

