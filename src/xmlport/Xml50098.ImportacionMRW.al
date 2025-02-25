#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50098 "Importacion MRW"
{
    // 
    // Numero de SeguimientoSu ReferenciaESTADO EXPEDICIONFrcha y HoraFecha de envio
    // 1Columna3            2Columna7    3Columna15      4Columna16      5Columna37

    Caption = 'Importacion GLS';
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF16;
    Permissions = TableData "Sales Shipment Header" = rim;

    schema
    {
        textelement(root)
        {
            MinOccurs = Zero;
            tableelement("Payment Terms";"Payment Terms")
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
        CODPROD: Code[20];
        CODENVIO: Code[20];
        valorpbp: Decimal;
        CANTIDE: Decimal;
        conta: Integer;
        ventana: Dialog;
        codconta: Code[20];
        XX: Integer;
        POSI: Integer;
        DDD: array [42] of Decimal;
        YY: Integer;
        LATARIFA: Code[20];
        LALAMA: Code[20];
        CUANTA1: Integer;
        ELANCHO: array [70] of Decimal;
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

    local procedure GetFieldLength(TableNo: Integer;FieldNo: Integer): Integer
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
    end;

    local procedure InsertColumn(columnNumber: Integer;var columnValue: Text)
    var
        savedColumnValue: Text;
    begin
    end;

    local procedure ValidateHeaderTag()
    begin

        linea:=linea+1;
        if linea>1 then begin


            fecha2:=0D;
            if D4<>'' then begin
                x:=0;
                SALE:=false;
                DDA:='';
                repeat
                    x:=x+1;
                    if CopyStr(D4,x,1)='/' then begin
                        SALE:=true;
                    end;
                    if CopyStr(D4,x,1)<>'/' then begin
                        DDA:=DDA+CopyStr(D4,x,1);
                    end;
                until (x>=StrLen(D4)) or SALE;
                MMA:='';
                SALE:=false;
                repeat
                    x:=x+1;
                    if CopyStr(D4,x,1)='/' then begin
                        SALE:=true;
                    end;
                    if CopyStr(D4,x,1)<>'/' then begin
                        MMA:=MMA+CopyStr(D4,x,1);
                    end;
                until (x>=StrLen(D4)) or SALE;
                AAA:=CopyStr(D4,x+1);
                Evaluate(DD,DDA);
                Evaluate(MM,MMA);
                Evaluate(AA,AAA);
                fecha2:=Dmy2date(DD,MM,AA);
            end;


        CUANTOSDIAS:=0;
        Date.Reset;
        Date.SetRange(Date."Period Type",Date."period type"::Date);
        Date.SetFilter(Date."Period No.",'1|2|3|4|5');
        Date.SetRange(Date."Period Start",fecha2,fecha1);
        if Date.FindFirst then repeat
             CUANTOSDIAS:=CUANTOSDIAS+1;
        until Date.Next=0;
        CUANTOSDIAS:=CUANTOSDIAS-1;


        choras:='';
        totalhoras:=0;
        DDH:=CopyStr(D4,12,5);


        if DDH<>'' then begin
            if (CopyStr(DDH,1,1)='0') or
               (CopyStr(DDH,1,1)='1') or
               (CopyStr(DDH,1,1)='2') or
               (CopyStr(DDH,1,1)='3') or
               (CopyStr(DDH,1,1)='4') or
               (CopyStr(DDH,1,1)='5') or
               (CopyStr(DDH,1,1)='6') or
               (CopyStr(DDH,1,1)='7') or
               (CopyStr(DDH,1,1)='8') or
               (CopyStr(DDH,1,1)='9') then begin
                horas:=CopyStr(DDH,1,2);
                Evaluate(dhoras,horas);
                minu:=CopyStr(DDH,4,2);
                Evaluate(dminu,minu);
                totalhoras:=(12+dhoras)+(CUANTOSDIAS-1)*24;
                choras:=DDH;
            end;

        end;





        D1:=CopyStr(D1,1,20);

        ///MESSAGE('%1',D3);

        if D1<>'' then begin
            SalesShipmentHeader.Reset;
            SalesShipmentHeader.SetCurrentkey(ASN);
            SalesShipmentHeader.SetRange(ASN,D1);
            if SalesShipmentHeader.FindFirst then repeat
                SalesShipmentHeader."Estado Expedicion":=D4;
                SalesShipmentHeader."Fecha envio":=fecha2;
                SalesShipmentHeader."Fecha entrega":=fecha1;
                SalesShipmentHeader."Hora entrega":=choras;
                SalesShipmentHeader."Total horas":=totalhoras;
                SalesShipmentHeader."Numero segumiento":=D2;
                SalesShipmentHeader.Modify;
            until SalesShipmentHeader.Next=0;

            SalesShipmentHeader.Reset;
            SalesShipmentHeader.SetCurrentkey("Nº expedición");
            SalesShipmentHeader.SetRange("Nº expedición",D1);
            if SalesShipmentHeader.FindFirst then repeat
                SalesShipmentHeader."Estado Expedicion":=D4;
                SalesShipmentHeader."Fecha envio":=fecha2;
                SalesShipmentHeader."Fecha entrega":=fecha1;
                SalesShipmentHeader."Hora entrega":=choras;
                SalesShipmentHeader."Total horas":=totalhoras;
                SalesShipmentHeader."Numero segumiento":=D2;
                SalesShipmentHeader.Modify;
            until SalesShipmentHeader.Next=0;
            SalesShipmentHeader.Reset;
            SalesShipmentHeader.SetCurrentkey("Nº expedición dropshp");
            SalesShipmentHeader.SetRange("Nº expedición dropshp",D1);
            if SalesShipmentHeader.FindFirst then repeat
                SalesShipmentHeader."Estado Expedicion":=D4;
                SalesShipmentHeader."Fecha envio":=fecha2;
                SalesShipmentHeader."Fecha entrega":=fecha1;
                SalesShipmentHeader."Hora entrega":=choras;
                SalesShipmentHeader."Total horas":=totalhoras;
                SalesShipmentHeader."Numero segumiento":=D2;
                SalesShipmentHeader.Modify;
            until SalesShipmentHeader.Next=0;
            Commit;
        end;

        end;
    end;
}

