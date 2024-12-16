#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50038 "Importacion transaher"
{
    Caption = 'Importacion PEDIDOS tienda ani';
    Direction = Import;
    FieldSeparator = '|';
    Format = VariableText;
    TextEncoding =  UTF16;
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
                }
                textelement(D5)
                {
                }
                textelement(D6)
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

        ventana.Open('#1#########################');

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
        DDD: array [42] of Decimal;
        YY: Integer;
        LATARIFA: Code[10];
        LALAMA: Code[10];
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
        NEXPE: Code[10];

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
        //D1      D2       D3      D4                            D5       D6
        //5959099|08/02/24|B73378V|ORDEN DE SERVIR EN OTRA FECHA|09/02/24|07:33
        
        
        linea:=linea+1;
        
        if D2<>'' then begin
        if linea>=1 then begin
        
            /*x:=0;
            SALE:=FALSE;
            DDA:='';
            REPEAT
                x:=x+1;
                IF COPYSTR(D2,x,1)='/' THEN BEGIN
                    SALE:=TRUE;
                END;
                IF COPYSTR(D2,x,1)<>'/' THEN BEGIN
                    DDA:=DDA+COPYSTR(D2,x,1);
                END;
            UNTIL (x=STRLEN(D2)) OR SALE;
            MMA:='';
            SALE:=FALSE;
            REPEAT
                x:=x+1;
                IF COPYSTR(D1,x,1)='/' THEN BEGIN
                    SALE:=TRUE;
                END;
                IF COPYSTR(D1,x,1)<>'/' THEN BEGIN
                    MMA:=MMA+COPYSTR(D2,x,1);
                END;
            UNTIL (x=STRLEN(D2)) OR SALE;
            AAA:=COPYSTR(D2,x+1);
            */
            DDA:=CopyStr(D2,1,2);
            Evaluate(DD,CopyStr(D2,1,2));
            Evaluate(MM,CopyStr(D2,4,2));
            Evaluate(AA,CopyStr(D2,7,2));
            if AA<2000 then begin AA:=AA+2000;end;
        
            fecha1:=Dmy2date(DD,MM,AA);
        
            fecha2:=0D;
            if D5<>'' then begin
            /*
              x:=0;
              SALE:=FALSE;
              DDA:='';
              REPEAT
                x:=x+1;
                IF COPYSTR(D5,x,1)='/' THEN BEGIN
                    SALE:=TRUE;
                END;
                IF COPYSTR(D5,x,1)<>'/' THEN BEGIN
                    DDA:=DDA+COPYSTR(D5,x,1);
                END;
              UNTIL (x=STRLEN(D5)) OR SALE;
              MMA:='';
              SALE:=FALSE;
              REPEAT
                  x:=x+1;
                  IF COPYSTR(D5,x,1)='/' THEN BEGIN
                      SALE:=TRUE;
                  END;
                  IF COPYSTR(D5,x,1)<>'/' THEN BEGIN
                      MMA:=MMA+COPYSTR(D5,x,1);
                  END;
              UNTIL (x=STRLEN(D5)) OR SALE;
              AAA:=COPYSTR(D5,x+1);
              */
              Evaluate(DD,CopyStr(D5,1,2));
              Evaluate(MM,CopyStr(D5,4,2));
              Evaluate(AA,CopyStr(D5,7,2));
        
              if AA<2000 then begin AA:=AA+2000;end;
              fecha2:=Dmy2date(DD,MM,AA);
            end;
        
        CUANTOSDIAS:=0;
        Date.Reset;
        Date.SetRange(Date."Period Type",Date."period type"::Date);
        Date.SetFilter(Date."Period No.",'1|2|3|4|5');
        Date.SetRange(Date."Period Start",fecha1,fecha2);
        if Date.FindFirst then repeat
             CUANTOSDIAS:=CUANTOSDIAS+1;
        until Date.Next=0;
        CUANTOSDIAS:=CUANTOSDIAS-1;
        
            totalhoras:=0;
            if D6<>'' then begin
                x:=0;
                SALE:=false;
                DDA:='';
                repeat
                    x:=x+1;
                    if CopyStr(D6,x,1)=':' then begin
                        SALE:=true;
                    end;
                    if CopyStr(D6,x,1)<>':' then begin
                        DDA:=DDA+CopyStr(D6,x,1);
                    end;
                until (x=StrLen(D6)) or SALE;
                Evaluate(dhoras,DDA);
        ///horas:=COPYSTR(D14,1,2);
        ///EVALUATE(dhoras,horas);
        ///minu:=COPYSTR(D10,4,2);
        ///EVALUATE(dminu,minu);
        
        totalhoras:=(12+dhoras)+(CUANTOSDIAS-1)*24;
            end;
        
        
        NEXPE:=CopyStr(D3,1,10);
        
        ventana.Update(1,D3);
        if D3<>'' then begin
        
        ///  MESSAGE('%1 %2',D2,STRLEN(D2));
            SalesShipmentHeader.Reset;
            SalesShipmentHeader.SetRange("Nº expedición",NEXPE);
            if SalesShipmentHeader.FindFirst then repeat
                SalesShipmentHeader."Estado Expedicion":=D4;
                SalesShipmentHeader."Fecha envio":=fecha1;
                SalesShipmentHeader."Fecha entrega":=fecha2;
                SalesShipmentHeader."Hora entrega":=D6;
                SalesShipmentHeader."Numero segumiento":=D1;
                SalesShipmentHeader."Total horas":=totalhoras;
                SalesShipmentHeader.Modify;
            until SalesShipmentHeader.Next=0;
            SalesShipmentHeader.Reset;
            SalesShipmentHeader.SetRange("Nº expedición dropshp",NEXPE);
            if SalesShipmentHeader.FindFirst then repeat
                SalesShipmentHeader."Estado Expedicion":=D4;
                SalesShipmentHeader."Fecha envio":=fecha1;
                SalesShipmentHeader."Fecha entrega":=fecha2;
                SalesShipmentHeader."Hora entrega":=D6;
                SalesShipmentHeader."Numero segumiento":=D1;
                SalesShipmentHeader."Total horas":=totalhoras;
                SalesShipmentHeader.Modify;
            until SalesShipmentHeader.Next=0;
        
            SalesShipmentHeader.Reset;
            SalesShipmentHeader.SetRange(ASN,NEXPE);
            if SalesShipmentHeader.FindFirst then repeat
                SalesShipmentHeader."Estado Expedicion":=D4;
                SalesShipmentHeader."Fecha envio":=fecha1;
                SalesShipmentHeader."Fecha entrega":=fecha2;
                SalesShipmentHeader."Hora entrega":=D6;
                SalesShipmentHeader."Numero segumiento":=D1;
                SalesShipmentHeader."Total horas":=totalhoras;
                SalesShipmentHeader.Modify;
            until SalesShipmentHeader.Next=0;
            Commit;
        end;
        
        
        end;
        end;

    end;
}

