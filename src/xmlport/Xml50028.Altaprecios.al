#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50028 "Alta precios"
{
    Caption = 'Alta precios';
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

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
                textelement(tarifa)
                {
                }
                textelement(UNIDADM)
                {
                }
                textelement(codconca)
                {
                }

                textelement(precio)
                {
                }
                textelement(precioreco)
                {
                }
                textelement(desde)
                {
                }
                textelement(hasta)
                {
                }
                textelement(minimo)
                {
                }
                textelement(opcion)
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
        preu: Decimal;
        SalesPrice: Record "Sales Price";
        preureco: Decimal;
        cdd: Code[10];
        cmm: Code[10];
        caa: Code[10];
        dd: Integer;
        mm: Integer;
        aa: Integer;
        fechaini: Date;
        fechafin: Date;
        cantiminima: Decimal;

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


        cdd := CopyStr(Format(desde), 1, 2);
        cmm := CopyStr(Format(desde), 4, 2);
        caa := CopyStr(Format(desde), 7, 4);
        Evaluate(dd, cdd);
        Evaluate(mm, cmm);
        Evaluate(aa, caa);
        fechaini := Dmy2date(dd, mm, aa);

        cdd := CopyStr(Format(hasta), 1, 2);
        cmm := CopyStr(Format(hasta), 4, 2);
        caa := CopyStr(Format(hasta), 7, 4);
        Evaluate(dd, cdd);
        Evaluate(mm, cmm);
        Evaluate(aa, caa);
        fechafin := Dmy2date(dd, mm, aa);

        Evaluate(cantiminima, minimo);


        if RecItem.Get(codigo) then begin


            ///// Item No.,Sales Type,Sales Code,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity

            SalesPrice.Reset;
            SalesPrice.SetRange(SalesPrice."Item No.", codigo);
            salesPrice.SetRange(SalesPrice."Sales Code", tarifa);
            SalesPrice.SetRange("Unit of Measure Code", UNIDADM);
            if UpperCase(opcion) = 'C' then begin
                SalesPrice.SetRange(SalesPrice."Sales Type", SalesPrice."sales type"::Customer);
            end;
            if UpperCase(opcion) = 'T' then begin
                SalesPrice.SetRange(SalesPrice."Sales Type", SalesPrice."sales type"::"Customer Price Group");
            end;
            SalesPrice.SetRange("Starting Date", fechaini);
            SalesPrice.SetRange("Minimum Quantity", cantiminima);
            if SalesPrice.FindFirst then begin
                Evaluate(preu, precio);
                Evaluate(preureco, precioreco);
                SalesPrice."Unit of Measure Code" := RecItem."Base Unit of Measure";
                SalesPrice."Unit Price" := preu;
                SalesPrice."Precio recomendado" := preureco;
                SalesPrice."Ending Date" := fechafin;
                SalesPrice."Codigo INNER o MASTET" := codconca;
                SalesPrice."Codigo concatenado" := '';
                if SalesPrice."Codigo INNER o MASTET" <> '' then begin
                    SalesPrice."Codigo concatenado" := SalesPrice."Item No." + SalesPrice."Codigo INNER o MASTET";
                end;

                SalesPrice.Modify;
            end;
            if not SalesPrice.FindFirst then begin

                Evaluate(preu, precio);
                Evaluate(preureco, precioreco);

                SalesPrice.Init;
                SalesPrice."Item No." := codigo;
                if UpperCase(opcion) = 'C' then begin
                    SalesPrice."Sales Type" := SalesPrice."sales type"::Customer
                end;
                if UpperCase(opcion) = 'T' then begin
                    SalesPrice."Sales Type" := SalesPrice."sales type"::"Customer Price Group";
                end;
                SalesPrice."Sales Code" := tarifa;
                SalesPrice."Starting Date" := Today;
                SalesPrice."Unit of Measure Code" := UNIDADM;
                SalesPrice."Unit Price" := preu;
                SalesPrice."Precio recomendado" := preureco;
                SalesPrice."Minimum Quantity" := cantiminima;
                SalesPrice."Starting Date" := fechaini;
                SalesPrice."Ending Date" := fechafin;
                SalesPrice."Codigo INNER o MASTET" := codconca;
                SalesPrice."Codigo concatenado" := '';
                if SalesPrice."Codigo INNER o MASTET" <> '' then begin
                    SalesPrice."Codigo concatenado" := SalesPrice."Item No." + SalesPrice."Codigo INNER o MASTET";
                end;
                SalesPrice.Insert;



            end;



        end;
    end;
}

