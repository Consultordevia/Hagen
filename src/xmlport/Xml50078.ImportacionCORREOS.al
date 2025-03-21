#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50078 "Importacion CORREOS"
{
    ///12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890 
    ///         10        20        30        40        50        60        70       80        90         100      110       120                                                           
    ///                                         suref               estado          fecha       hora                    nexpe                  
    ///                                        123456789012        123456789012345                                     1234567890123456
    ///1        2        3                      4         5         6              7           8      9            10
    ///C	2010v001	PKAJ580710018430133290V	CAT31223	ES0010	PREREGISTRADO	20250312	09:40	0000000000		PKAJ58071001843P
    ///R	2010v001	PKAJ580710018420133290Q	CAT31223	ES0010	PREREGISTRADO	20250312	09:40	0000000000		PKAJ58071001842F
    ///R	2010v001	PKAJ580710018440128924A	CAT31225	ES0010	PREREGISTRADO	20250312	09:44	0000000000		PKAJ58071001844D
    Caption = 'Importacion correos';
    Direction = Import;
    Format = VariableText;
    FieldSeparator = '<TAB>';
    TextEncoding = UTF16;
    Permissions = TableData "Sales Shipment Header" = rim;

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
                { }
                textelement(D2)
                { }
                textelement(D3)
                { }
                textelement(D4)
                { }
                textelement(D5)
                { }
                textelement(D6)
                { }
                textelement(D7)
                { }
                textelement(D8)
                { }
                textelement(D9)
                { }
                textelement(D10)
                { }
                textelement(D11)
                { }
                
                textelement(D12)
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



        SalesSetup.Get;
    end;

    var
        NSEGUIMIENTO: CODE[16];
        ESTADO: Code[15];
        nexpe: Code[12];
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
        SalesShipmentHeader: Record "Sales Shipment Header";
        CODPROD: Code[20];
        CODENVIO: Code[20];
        valorpbp: Decimal;
        CANTIDE: Decimal;
        conta: Integer;
        ventana: Dialog;
        codconta: Code[20];
        XX: Integer;
        POSI: Integer;
        DDD: array[42] of Decimal;
        YY: Integer;
        LATARIFA: Code[20];
        LALAMA: Code[20];
        CUANTA1: Integer;
        ELANCHO: array[70] of Decimal;
        ELALTO: Decimal;
        LINEAS: Integer;
        UNO: Code[255];
        DOS: Code[255];
        UBICA: Code[20];
        POS: Decimal;
        LON: Decimal;
        SALE: Boolean;
        kilos: Code[20];
        fc: Code[20];
        frecp: Code[20];
        REFCONFOR: Code[20];
        KILOSDECI: Decimal;
        SUMALINS: Decimal;
        NoMov: Decimal;
        Desdemov: Decimal;
        NoMov2IF: Decimal;
        NoMov2: Decimal;
        NoDoc: Code[20];
        TIPO2: Integer;
        ImporteT: Decimal;
        lin: Decimal;
        DPRECIO: Decimal;
        STOCCAL: Decimal;
        clie: Code[20];
        ref: Code[20];
        canti: Code[20];
        obser: Code[250];
        linea: Integer;
        NoSerie: Code[20];
        codacti: Code[20];
        SalesSetup: Record "Sales & Receivables Setup";
        SUPRA: Code[20];
        SenderName: Text[250];
        SenderAddress: Text[250];
        Recipient: Text[250];
        Subject: Text[250];
        Body: Text[1024];
        dir1: Text[250];
        dir2: Text[250];
        dir3: Text[250];
        textocuerpo: Text[250];
        asunto: Text[250];
        codcli: Code[20];
        codcliente: Code[20];
        codpedido: Code[20];
        CANTitrans: Decimal;
        CODDIRENVIO: Code[20];
        ALTA: Boolean;
        totalhoras: Decimal;
        fecha1: Date;
        fecha2: Date;
        x: Integer;
        DDA: Code[20];
        MMA: Code[20];
        AAA: Code[20];
        DD: Decimal;
        AA: Decimal;
        MM: Decimal;
        Date: Record Date;
        CUANTOSDIAS: Integer;
        dhoras: Decimal;
        horas: Code[20];
        dminu: Decimal;
        minu: Code[20];
        DDF: Code[20];
        DDH: Code[20];
        choras: Code[20];

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

        linea := linea + 1;

        IF linea > 1 THEN BEGIN

            nexpe := D4;

            ESTADO := D6;
            NSEGUIMIENTO := D12;

            IF nexpe <> '' THEN BEGIN

                IF nexpe <> '' THEN BEGIN
                    SalesShipmentHeader.RESET;
                    SalesShipmentHeader.SETCURRENTKEY(ASN);
                    SalesShipmentHeader.SETRANGE(ASN, nexpe);
                    IF SalesShipmentHeader.FINDFIRST THEN
                        REPEAT
                            fecha2 := SalesShipmentHeader."Posting Date";
                        UNTIL SalesShipmentHeader.NEXT = 0;

                    SalesShipmentHeader.RESET;
                    SalesShipmentHeader.SETCURRENTKEY("Nº expedición");
                    SalesShipmentHeader.SETRANGE("Nº expedición", nexpe);
                    IF SalesShipmentHeader.FINDFIRST THEN
                        REPEAT
                            fecha2 := SalesShipmentHeader."Posting Date";
                        UNTIL SalesShipmentHeader.NEXT = 0;
                    SalesShipmentHeader.RESET;
                    SalesShipmentHeader.SETCURRENTKEY("Nº expedición dropshp");
                    SalesShipmentHeader.SETRANGE("Nº expedición dropshp", nexpe);
                    IF SalesShipmentHeader.FINDFIRST THEN
                        REPEAT
                            fecha2 := SalesShipmentHeader."Posting Date";
                        UNTIL SalesShipmentHeader.NEXT = 0;
                    COMMIT;
                END;





                DDF := D7;


                IF DDF <> '' THEN BEGIN
                    AAA := COPYSTR(DDF, 1, 4);
                    MMA := COPYSTR(DDF, 5, 2);
                    DDA := COPYSTR(DDF, 7, 2);
                    EVALUATE(DD, DDA);
                    EVALUATE(MM, MMA);
                    EVALUATE(AA, AAA);
                    fecha1 := DMY2DATE(DD, MM, AA);
                END;


                CUANTOSDIAS := 0;
                Date.RESET;
                Date.SETRANGE(Date."Period Type", Date."Period Type"::Date);
                Date.SETFILTER(Date."Period No.", '1|2|3|4|5');
                Date.SETRANGE(Date."Period Start", fecha2, fecha1);
                IF Date.FINDFIRST THEN
                    REPEAT
                        CUANTOSDIAS := CUANTOSDIAS + 1;
                    UNTIL Date.NEXT = 0;
                CUANTOSDIAS := CUANTOSDIAS - 1;


                choras := '';
                totalhoras := 0;
                DDH := D8;

                IF STRLEN(DDH) < 5 THEN BEGIN DDH := '0' + DDH; END;
                IF DDH <> '' THEN BEGIN
                    IF (COPYSTR(DDH, 1, 1) = '0') OR
                       (COPYSTR(DDH, 1, 1) = '1') OR
                       (COPYSTR(DDH, 1, 1) = '2') OR
                       (COPYSTR(DDH, 1, 1) = '3') OR
                       (COPYSTR(DDH, 1, 1) = '4') OR
                       (COPYSTR(DDH, 1, 1) = '5') OR
                       (COPYSTR(DDH, 1, 1) = '6') OR
                       (COPYSTR(DDH, 1, 1) = '7') OR
                       (COPYSTR(DDH, 1, 1) = '8') OR
                       (COPYSTR(DDH, 1, 1) = '9') THEN BEGIN
                        horas := COPYSTR(DDH, 1, 2);
                        EVALUATE(dhoras, horas);
                        minu := COPYSTR(DDH, 4, 2);
                        EVALUATE(dminu, minu);
                        totalhoras := (12 + dhoras) + (CUANTOSDIAS - 1) * 24;
                        choras := DDH;
                    END;

                END;


            END;


            IF nexpe <> '' THEN BEGIN
                SalesShipmentHeader.RESET;
                SalesShipmentHeader.SETCURRENTKEY(ASN);
                SalesShipmentHeader.SETRANGE(ASN, nexpe);
                IF SalesShipmentHeader.FINDFIRST THEN
                    REPEAT
                        SalesShipmentHeader."Estado Expedicion" := COPYSTR(ESTADO, 1, 100);
                        SalesShipmentHeader."Fecha envio" := fecha2;
                        SalesShipmentHeader."Fecha entrega" := fecha1;
                        SalesShipmentHeader."Hora entrega" := choras;
                        SalesShipmentHeader."Total horas" := totalhoras;
                        SalesShipmentHeader."Numero segumiento" := COPYSTR(NSEGUIMIENTO, 1, 20);
                        SalesShipmentHeader.MODIFY;
                    UNTIL SalesShipmentHeader.NEXT = 0;

                SalesShipmentHeader.RESET;
                SalesShipmentHeader.SETCURRENTKEY("Nº expedición");
                SalesShipmentHeader.SETRANGE("Nº expedición", nexpe);
                IF SalesShipmentHeader.FINDFIRST THEN
                    REPEAT
                        SalesShipmentHeader."Estado Expedicion" := COPYSTR(ESTADO, 1, 100);
                        SalesShipmentHeader."Fecha envio" := fecha2;
                        SalesShipmentHeader."Fecha entrega" := fecha1;
                        SalesShipmentHeader."Hora entrega" := choras;
                        SalesShipmentHeader."Total horas" := totalhoras;
                        SalesShipmentHeader."Numero segumiento" := COPYSTR(NSEGUIMIENTO, 1, 20);
                        SalesShipmentHeader.MODIFY;
                    UNTIL SalesShipmentHeader.NEXT = 0;
                SalesShipmentHeader.RESET;
                SalesShipmentHeader.SETCURRENTKEY("Nº expedición dropshp");
                SalesShipmentHeader.SETRANGE("Nº expedición dropshp", nexpe);
                IF SalesShipmentHeader.FINDFIRST THEN
                    REPEAT
                        SalesShipmentHeader."Estado Expedicion" := COPYSTR(ESTADO, 1, 100);
                        SalesShipmentHeader."Fecha envio" := fecha2;
                        SalesShipmentHeader."Fecha entrega" := fecha1;
                        SalesShipmentHeader."Hora entrega" := choras;
                        SalesShipmentHeader."Total horas" := totalhoras;
                        SalesShipmentHeader."Numero segumiento" := COPYSTR(NSEGUIMIENTO, 1, 20);
                        SalesShipmentHeader.MODIFY;
                    UNTIL SalesShipmentHeader.NEXT = 0;
                COMMIT;
            END;






        END;

    end;


}

