#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50037 "Importacion SENDING"
{
    Caption = 'Importacion SENDING';
    Direction = Import;
    FieldSeparator = '|';
    Format = VariableText;
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
                {
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
        CODPROD: Code[10];
        CODENVIO: Code[20];
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
        SALE: Boolean;
        kilos: Code[20];
        fc: Code[10];
        frecp: Code[10];
        REFCONFOR: Code[20];
        KILOSDECI: Decimal;
        SUMALINS: Decimal;
        NoMov: Decimal;
        Desdemov: Decimal;
        NoMov2IF: Decimal;
        NoMov2: Decimal;
        NoDoc: Code[10];
        TIPO2: Integer;
        ImporteT: Decimal;
        lin: Decimal;
        DPRECIO: Decimal;
        STOCCAL: Decimal;
        clie: Code[20];
        ref: Code[20];
        canti: Code[10];
        obser: Code[250];
        linea: Integer;
        NoSerie: Code[10];
        codacti: Code[10];
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
        codcli: Code[10];
        codcliente: Code[20];
        codpedido: Code[20];
        CANTitrans: Decimal;
        CODDIRENVIO: Code[20];
        ALTA: Boolean;
        totalhoras: Decimal;
        fecha1: Date;
        fecha2: Date;
        x: Integer;
        DDA: Code[10];
        MMA: Code[10];
        AAA: Code[10];
        DD: Decimal;
        AA: Decimal;
        MM: Decimal;
        Date: Record Date;
        CUANTOSDIAS: Integer;
        dhoras: Decimal;
        horas: Code[10];
        dminu: Decimal;
        minu: Code[10];

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

        if linea > 1 then begin
            /*
            x := 0;
            SALE := false;
            DDA := '';
            repeat
                x := x + 1;
                if CopyStr(D2, x, 1) = '/' then begin
                    SALE := true;
                end;
                if CopyStr(D2, x, 1) <> '/' then begin
                    DDA := DDA + CopyStr(D2, x, 1);
                end;
            until (x = StrLen(D2)) or SALE;
            MMA := '';
            SALE := false;
            repeat
                x := x + 1;
                if CopyStr(D2, x, 1) = '/' then begin
                    SALE := true;
                end;
                if CopyStr(D2, x, 1) <> '/' then begin
                    MMA := MMA + CopyStr(D2, x, 1);
                end;
            until (x = StrLen(D2)) or SALE;
            AAA := CopyStr(D2, x + 1);
            Evaluate(DD, DDA);
            Evaluate(MM, MMA);
            Evaluate(AA, AAA);
            fecha1 := Dmy2date(DD, MM, AA);            
            */
            DDA:=CopyStr(D2,1,2);
            MMA:=CopyStr(D2,4,2);
            AAA:=CopyStr(D2,7,4);
            Evaluate(DD, DDA);
            Evaluate(MM, MMA);
            Evaluate(AA, AAA);
            fecha1 := Dmy2date(DD, MM, AA);            
            

/*
            x := 0;
            SALE := false;
            DDA := '';
            repeat
                x := x + 1;
                if CopyStr(D9, x, 1) = '/' then begin
                    SALE := true;
                end;
                if CopyStr(D9, x, 1) <> '/' then begin
                    DDA := DDA + CopyStr(D9, x, 1);
                end;
            until (x = StrLen(D9)) or SALE;
            MMA := '';
            SALE := false;
            repeat
                x := x + 1;
                if CopyStr(D9, x, 1) = '/' then begin
                    SALE := true;
                end;
                if CopyStr(D9, x, 1) <> '/' then begin
                    MMA := MMA + CopyStr(D9, x, 1);
                end;
            until (x = StrLen(D9)) or SALE;
            AAA := CopyStr(D9, x + 1);
            Evaluate(DD, DDA);
            Evaluate(MM, MMA);
            Evaluate(AA, AAA);
            fecha2 := Dmy2date(DD, MM, AA);
            */
            IF D14<>'' THEN begin
                DDA:=CopyStr(D14,1,2);
                MMA:=CopyStr(D14,4,2);
                AAA:=CopyStr(D14,7,4);
                Evaluate(DD, DDA);
                Evaluate(MM, MMA);
                Evaluate(AA, AAA);
                fecha2 := Dmy2date(DD, MM, AA);            
            END;
            


            CUANTOSDIAS := 0;
            Date.Reset;
            Date.SetRange(Date."Period Type", Date."period type"::Date);
            Date.SetFilter(Date."Period No.", '1|2|3|4|5');
            Date.SetRange(Date."Period Start", fecha1, fecha2);
            if Date.FindFirst then
                repeat
                    CUANTOSDIAS := CUANTOSDIAS + 1;
                until Date.Next = 0;
            CUANTOSDIAS := CUANTOSDIAS - 1;

            horas := CopyStr(D15, 1, 2);
            Evaluate(dhoras, horas);
            minu := CopyStr(D15, 4, 2);
            Evaluate(dminu, minu);

            totalhoras := (12 + dhoras) + (CUANTOSDIAS - 1) * 24;



            D3 := CopyStr(D3, 1, 10);

            if D3 <> '' then begin
                SalesShipmentHeader.Reset;
                SalesShipmentHeader.SetRange("Nº expedición", D3);
                if SalesShipmentHeader.FindFirst then
                    repeat
                        SalesShipmentHeader."Estado Expedicion" := D12;
                        SalesShipmentHeader."Fecha envio" := fecha1;
                        SalesShipmentHeader."Fecha entrega" := fecha2;
                        SalesShipmentHeader."Hora entrega" := D15;
                        SalesShipmentHeader."Numero segumiento" := D1;
                        SalesShipmentHeader."Total horas" := totalhoras;
                        SalesShipmentHeader.Modify;
                    until SalesShipmentHeader.Next = 0;
                SalesShipmentHeader.Reset;
                SalesShipmentHeader.SetRange("Nº expedición dropshp", D3);
                if SalesShipmentHeader.FindFirst then
                    repeat
                        SalesShipmentHeader."Estado Expedicion" := D12;
                        SalesShipmentHeader."Fecha envio" := fecha1;
                        SalesShipmentHeader."Fecha entrega" := fecha2;
                        SalesShipmentHeader."Hora entrega" := D15;
                        SalesShipmentHeader."Numero segumiento" := D1;
                        SalesShipmentHeader."Total horas" := totalhoras;
                        SalesShipmentHeader.Modify;
                    until SalesShipmentHeader.Next = 0;
                Commit;
            end;


        end;
    end;
}

