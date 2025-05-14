#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50130 "ImportaDescuentos"
{
    Caption = 'Importa Descuentos';
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF16;

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
                }
                textelement(D16)
                {
                }
                textelement(D17)
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
        ExcelBuf: Record "Excel Buffer";
        Dim: Record Dimension;
        DimVal: Record "Dimension Value";
        TempDim: Record Dimension temporary;
        TempDimVal: Record "Dimension Value" temporary;
        GLBudgetEntry: Record "G/L Budget Entry";
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        TempGLAcc: Record "G/L Account" temporary;
        GLBudgetName: Record "G/L Budget Name";
        GLBudgetEntry3: Record "G/L Budget Entry";
        AnalysisView: Record "Analysis View";

        SheetName: Text[250];
        ToGLBudgetName: Code[10];
        DimCode: array[8] of Code[20];
        EntryNo: Integer;
        LastEntryNoBeforeImport: Integer;
        GlobalDim1Code: Code[20];
        GlobalDim2Code: Code[20];
        TotalRecNo: Integer;
        RecNo: Integer;
        Window: Dialog;
        Description: Text[50];
        BudgetDim1Code: Code[20];
        BudgetDim2Code: Code[20];
        BudgetDim3Code: Code[20];
        BudgetDim4Code: Code[20];
        ImportOption: Option "Replace entries","Add entries";
        gpu: Code[20];
        prod: Code[20];
        texto: Text[50];
        codprod: Code[20];
        LIN: Integer;
        RecTP: Record "Item Translation";
        CODIGO: Code[10];
        codprod2: Code[20];
        x: Integer;
        cantimin: Decimal;
        fechaini: Date;
        fechafin: Date;
        precioneto: Decimal;
        elneto: Code[10];
        DIA: Code[2];
        MES: Code[2];
        "AÑO": Code[2];
        ELDIA: Integer;
        ELMES: Integer;
        "ELAÑO": Integer;
        FECHA1: Code[8];
        CANTIMASTER: Decimal;
        ALTOMAS: Decimal;
        ANCHOMAS: Decimal;
        LARGOMAS: Decimal;
        PESOMAS: Decimal;
        VOLMAS: Decimal;
        UNIVENTA: Decimal;
        ALTOP: Decimal;
        ANCHOP: Decimal;
        LARGOP: Decimal;
        VOLP: Decimal;
        PESOP: Decimal;
        RecItem: Record Item;
        cantidadpedida: Decimal;
        supra: Code[10];
        observa: Text[1000];
        primera: Boolean;
        clie: Code[20];
        ref: Code[20];
        canti: Code[10];
        cantide: Decimal;
        obser: Code[250];
        RecCV: Record "Purchase Header";
        RecLV: Record "Purchase Line";
        linea: Integer;
        FormClie: Page "Customer Card";
        RecCVC: Record "Sales & Receivables Setup";
        NoSerie: Code[10];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        codacti: Code[10];
        RecLNS: Record "No. Series Line";
        RecUser: Record "User Setup";
        RecClie: Record Customer;
        RecCV2: Record "Purchase Header";
        SalesSetup: Record "Sales & Receivables Setup";
        Rec91: Record "User Setup";
        RecLCV: Record "Sales Comment Line";
        lineas: Integer;
        RecProd: Record Item;
        RecRefCruz: Record "Item Reference";
        sale: Boolean;
        numpedi: Code[10];
        PRECIOCOM: Decimal;
        TYPO: Integer;
        CODTIPO: Code[1];
        DESCRIPWEB: Text[100];
        CODREPUES: Text[250];
        CODRELACI: Text[250];
        DESTEC: Text[250];
        RecMt2: Record "Multitabla 2";
        CODHIJO: Code[20];
        enviaraweb: Code[1];
        D2DESCRIP: Text[70];
        D3DESWEB: Text[70];
        D4PROOPCOMINA: Code[50];
        D56DESHIJO: Text[70];
        D6REFPADRE: Code[20];
        D7ENVIARAWEB: Code[1];
        D8ACTUALIZAWE: Code[1];
        D9PESOUNI: Code[20];
        D10LARGOUNI: Code[20];
        D11ANCHOUNI: Code[20];
        D12ALTOUNI: Code[20];
        D13MARCA: Code[20];
        D14CODPROPROVEE: Code[20];
        D15EAN: Code[20];
        D16TIPOVENTA: Code[20];
        D17CODVENTA: Code[20];
        D18PRECIOTAR: Code[20];
        D19PVPR: Code[20];
        D20COLCHONWEB: Code[20];
        D21ESTADO: Code[20];
        D22COSTEUNIDIC: Code[20];
        D23DTOPROVEE: Code[20];
        D24GRIVAPROD: Code[20];
        D25LINEA: Code[20];
        D26FAMILIA: Code[20];
        D27SUBFAMILIA: Code[20];
        D28ROTA: Code[20];
        D29TIPOPROD: Code[20];
        D30TIPOPALETS: Code[20];
        D31UMB: Code[20];
        D32CDADINNER: Code[20];
        D33PESOIN: Code[20];
        D34LARGOIN: Code[20];
        D35ANCHOIN: Code[20];
        D36ALTOIN: Code[20];
        D37CDADAMSTER: Code[20];
        D38PESOMAS: Code[20];
        D39LARGOMAS: Code[20];
        D40ANCHOMAS: Code[20];
        D41ALTOMAS: Code[20];
        D42UNIMEDCOMP: Code[20];
        D43DIMHUEOC: Code[20];
        D44GRUPOCONTABLE: Code[20];
        D45UNIMEDVENTA: Code[20];
        D46UNIDADESNTA: Code[20];
        D47PERMITFRAC: Code[20];
        D48ZONAALMA: Code[20];
        D49ZONAPICK: Code[20];
        D50PRODALMA: Code[20];
        RecUMP: Record "Item Unit of Measure";
        D51ODPROVEE: Code[20];
        RecPC: Record "Purchase Price";
        D52EANINNE: Code[20];
        D53EANMAS: Code[20];
        RecTCP: Record "Item Vendor";
        peso1: Decimal;
        tariff: Code[20];
        igicc: Code[20];
        CUADAIA: Codeunit "Automaticos Cartas";
        RecItem22: Record Item;
        SalesLineDiscountPadre: Record "Sales Line Discount";
        MINIMO: Decimal;
        DESCUENTO: Decimal;
        TIPO: Integer;
        TIPOVENTA: Integer;
        cdd: Code[10];
        cmm: Code[10];
        caa: Code[10];
        dd: Integer;
        mm: Integer;
        aa: Integer;
        PrecioVenta: Decimal;
        Cantidad1: Decimal;
        Cantidad2: Decimal;
        Cantidad3: Decimal;
        Cantidad4: Decimal;
        Cantidad5: Decimal;
        Descuento1: Decimal;
        Descuento2: Decimal;
        Descuento3: Decimal;
        Descuento4: Decimal;
        Descuento5: Decimal;
        Descuento6: Decimal;
        CodTarifa: code[20];
        GrpoDesc: code[20];
        Incremento: Decimal;
        RecSP: Record "Sales Price";
        RecSLD: Record "Sales Line Discount";


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


            if (D1 <> '') then begin ///// producto
                ref := D1;
            end;
            if (D2 <> '') then begin ///// precio venta
                Evaluate(PrecioVenta, D2);
            end;
            if (D3 <> '') then begin ///// cantidad 1
                Evaluate(Cantidad1, D3);
            end;
            if (D4 <> '') then begin ///// Descuento 1 
                Evaluate(Descuento1, D4);
            end;
            if (D5 <> '') then begin ///// cantidad 2
                Evaluate(Cantidad2, D5);
            end;
            if (D6 <> '') then begin ///// Descuento 2 
                Evaluate(Descuento2, D6);
            end;
            if (D7 <> '') then begin ///// cantidad 3
                Evaluate(Cantidad3, D7);
            end;
            if (D8 <> '') then begin ///// Descuento 3 
                Evaluate(Descuento3, D8);
            end;
            if (D9 <> '') then begin ///// cantidad 4
                Evaluate(Cantidad4, D9);
            end;
            if (D10 <> '') then begin ///// Descuento 4 
                Evaluate(Descuento4, D10);
            end;
            if (D11 <> '') then begin ///// cantidad 5
                Evaluate(Cantidad5, D11);
            end;
            if (D12 <> '') then begin ///// Descuento 5 
                Evaluate(Descuento5, D12);
            end;
            if (D13 <> '') then begin ///// tarifa
                CodTarifa := D13;
            end;
            if (D14 <> '') then begin ///// GrpoDesc
                GrpoDesc := D14;
            end;
            if (D15 <> '') then begin ///// Incremento
                Evaluate(Incremento, D15);
            end;
            if (D16 <> '') then begin  ////// fecha inicial
                cdd := CopyStr(Format(D16), 1, 2);
                cmm := CopyStr(Format(D16), 4, 2);
                caa := CopyStr(Format(D16), 7, 4);
                Evaluate(dd, cdd);
                Evaluate(mm, cmm);
                Evaluate(aa, caa);
                fechaini := Dmy2date(dd, mm, aa);

            end;
            if (D17 <> '') then begin  ///// fecha final
                cdd := CopyStr(Format(D17), 1, 2);
                cmm := CopyStr(Format(D17), 4, 2);
                caa := CopyStr(Format(D17), 7, 4);
                Evaluate(dd, cdd);
                Evaluate(mm, cmm);
                Evaluate(aa, caa);
                fechafin := Dmy2date(dd, mm, aa);

            end;

            IF RecProd.get(ref) THEN BEGIN
                RecProd."Unit Price" := PrecioVenta;
                RecProd.Modify;

                RecSP.Init;
                RecSP."Item No." := ref;
                RecSP."Sales Code" := CodTarifa;
                RecSP."Starting Date" := fechaini;
                RecSP."Unit Price" := PrecioVenta;
                RecSP."Sales Type" := RecSP."Sales Type"::"Customer Price Group";
                RecSP."Unit of Measure Code" := 'UDS';
                RecSP."Minimum Quantity" := 1;
                RecSP.INCREMENTO := 1;
                RecSP."Unidades Venta" := 1;
                RecSP."Ending Date" := fechafin;
                IF RecSP.insert THEN;

                RecSP."Item No." := ref;
                RecSP."Sales Code" := CodTarifa + 'DC00';
                RecSP."Minimum Quantity" := Cantidad1;
                RecSP."Starting Date" := fechaini;
                RecSP."Unit Price" := PrecioVenta;
                RecSP."Sales Type" := RecSP."Sales Type"::"Customer Price Group";
                RecSP."Ending Date" := fechafin;
                RecSP.INCREMENTO := 1;
                RecSP."Unidades Venta" := 1;
                RecSP."Unit of Measure Code" := 'UDS';
                IF RecSP.insert THEN;

                RecSP."Item No." := ref;
                RecSP."Sales Code" := CodTarifa + 'DC00';
                RecSP."Minimum Quantity" := Cantidad2;
                RecSP."Starting Date" := fechaini;
                RecSP."Unit Price" := PrecioVenta - ROUND((PrecioVenta * Descuento2 / 100));
                RecSP."Sales Type" := RecSP."Sales Type"::"Customer Price Group";
                RecSP."Ending Date" := fechafin;
                RecSP.INCREMENTO := 1;
                RecSP."Unidades Venta" := 1;
                RecSP."Unit of Measure Code" := 'UDS';
                IF RecSP.insert THEN;


                RecSP."Item No." := ref;
                RecSP."Sales Code" := CodTarifa + 'DC00';
                RecSP."Minimum Quantity" := Cantidad3;
                RecSP."Starting Date" := fechaini;
                RecSP."Unit Price" := PrecioVenta - ROUND((PrecioVenta * Descuento3 / 100));
                RecSP."Sales Type" := RecSP."Sales Type"::"Customer Price Group";
                RecSP."Ending Date" := fechafin;
                RecSP.INCREMENTO := 1;
                RecSP."Unidades Venta" := 1;
                RecSP."Unit of Measure Code" := 'UDS';
                IF RecSP.insert THEN;


                RecSP."Item No." := ref;
                RecSP."Sales Code" := CodTarifa + 'DC20';
                RecSP."Minimum Quantity" := Cantidad1;
                RecSP."Starting Date" := fechaini;
                RecSP."Unit Price" := PrecioVenta - ROUND((PrecioVenta * Descuento1 / 100));
                RecSP."Sales Type" := RecSP."Sales Type"::"Customer Price Group";
                RecSP."Ending Date" := fechafin;
                RecSP.INCREMENTO := 1;
                RecSP."Unidades Venta" := 1;
                RecSP."Unit of Measure Code" := 'UDS';
                IF RecSP.insert THEN;

                RecSP."Item No." := ref;
                RecSP."Sales Code" := CodTarifa + 'DC20';
                RecSP."Minimum Quantity" := Cantidad2;
                RecSP."Starting Date" := fechaini;
                RecSP."Unit Price" := PrecioVenta - ROUND((PrecioVenta * Descuento2 / 100));
                RecSP."Sales Type" := RecSP."Sales Type"::"Customer Price Group";
                RecSP."Ending Date" := fechafin;
                RecSP.INCREMENTO := 1;
                RecSP."Unidades Venta" := 1;
                RecSP."Unit of Measure Code" := 'UDS';
                IF RecSP.insert THEN;


                RecSP."Item No." := ref;
                RecSP."Sales Code" := CodTarifa + 'DC20';
                RecSP."Minimum Quantity" := Cantidad3;
                RecSP."Starting Date" := fechaini;
                RecSP."Unit Price" := PrecioVenta - ROUND((PrecioVenta * Descuento3 / 100));
                RecSP."Sales Type" := RecSP."Sales Type"::"Customer Price Group";
                RecSP."Ending Date" := fechafin;
                RecSP.INCREMENTO := 1;
                RecSP."Unidades Venta" := 1;
                RecSP."Unit of Measure Code" := 'UDS';
                IF RecSP.insert THEN;



                RecSP."Item No." := ref;
                RecSP."Sales Code" := CodTarifa + 'DC25';
                RecSP."Minimum Quantity" := Cantidad1;
                RecSP."Starting Date" := fechaini;
                RecSP."Unit Price" := PrecioVenta - ROUND((PrecioVenta * Descuento2 / 100));
                RecSP."Sales Type" := RecSP."Sales Type"::"Customer Price Group";
                RecSP."Ending Date" := fechafin;
                RecSP.INCREMENTO := 1;
                RecSP."Unidades Venta" := 1;
                RecSP."Unit of Measure Code" := 'UDS';
                IF RecSP.insert THEN;

                RecSP."Item No." := ref;
                RecSP."Sales Code" := CodTarifa + 'DC25';
                RecSP."Minimum Quantity" := Cantidad3;
                RecSP."Starting Date" := fechaini;
                RecSP."Unit Price" := PrecioVenta - ROUND((PrecioVenta * Descuento3 / 100));
                RecSP."Sales Type" := RecSP."Sales Type"::"Customer Price Group";
                RecSP."Ending Date" := fechafin;
                RecSP.INCREMENTO := 1;
                RecSP."Unidades Venta" := 1;
                RecSP."Unit of Measure Code" := 'UDS';
                IF RecSP.insert THEN;


                RecSP."Item No." := ref;
                RecSP."Sales Code" := CodTarifa + 'DC30';
                RecSP."Minimum Quantity" := Cantidad1;
                RecSP."Starting Date" := fechaini;
                RecSP."Unit Price" := PrecioVenta - ROUND((PrecioVenta * Descuento3 / 100));
                RecSP."Sales Type" := RecSP."Sales Type"::"Customer Price Group";
                RecSP."Ending Date" := fechafin;
                RecSP.INCREMENTO := 1;
                RecSP."Unidades Venta" := 1;
                RecSP."Unit of Measure Code" := 'UDS';
                IF RecSP.insert THEN;



                RecSLD.Code := ref;
                RecSLD."Sales Code" := GrpoDesc;
                RecSLD."Line Discount %" := Descuento1;
                RecSLD."Sales Type" := RecSLD."Sales Type"::"Customer Disc. Group";
                RecSLD."Starting Date" := fechaini;
                RecSLD."Ending Date" := fechafin;
                RecSLD."Minimum Quantity" := Cantidad1;
                RecSLD."Unit of Measure Code" := 'UDS';
                IF RecSLD.insert THEN;

                RecSLD.Code := ref;
                RecSLD."Sales Code" := GrpoDesc;
                RecSLD."Line Discount %" := Descuento2;
                RecSLD."Sales Type" := RecSLD."Sales Type"::"Customer Disc. Group";
                RecSLD."Starting Date" := fechaini;
                RecSLD."Ending Date" := fechafin;
                RecSLD."Minimum Quantity" := Cantidad2;
                RecSLD."Unit of Measure Code" := 'UDS';
                IF RecSLD.insert THEN;

                RecSLD.Code := ref;
                RecSLD."Sales Code" := GrpoDesc;
                RecSLD."Line Discount %" := Descuento3;
                RecSLD."Sales Type" := RecSLD."Sales Type"::"Customer Disc. Group";
                RecSLD."Starting Date" := fechaini;
                RecSLD."Ending Date" := fechafin;
                RecSLD."Minimum Quantity" := Cantidad3;
                RecSLD."Unit of Measure Code" := 'UDS';
                IF RecSLD.insert THEN;


                RecSLD.Code := ref;
                RecSLD."Sales Code" := CopyStr(GrpoDesc, 1, 4) + '20';
                RecSLD."Line Discount %" := Descuento1;
                RecSLD."Sales Type" := RecSLD."Sales Type"::"Customer Disc. Group";
                RecSLD."Starting Date" := fechaini;
                RecSLD."Ending Date" := fechafin;
                RecSLD."Minimum Quantity" := Cantidad1;
                RecSLD."Unit of Measure Code" := 'UDS';
                IF RecSLD.insert THEN;

                RecSLD.Code := ref;
                RecSLD."Sales Code" := CopyStr(GrpoDesc, 1, 4) + '20';
                RecSLD."Line Discount %" := Descuento2;
                RecSLD."Sales Type" := RecSLD."Sales Type"::"Customer Disc. Group";
                RecSLD."Starting Date" := fechaini;
                RecSLD."Ending Date" := fechafin;
                RecSLD."Minimum Quantity" := Cantidad2;
                RecSLD."Unit of Measure Code" := 'UDS';
                IF RecSLD.insert THEN;

                RecSLD.Code := ref;
                RecSLD."Sales Code" := CopyStr(GrpoDesc, 1, 4) + '20';
                RecSLD."Line Discount %" := Descuento3;
                RecSLD."Sales Type" := RecSLD."Sales Type"::"Customer Disc. Group";
                RecSLD."Starting Date" := fechaini;
                RecSLD."Ending Date" := fechafin;
                RecSLD."Minimum Quantity" := Cantidad3;
                RecSLD."Unit of Measure Code" := 'UDS';
                IF RecSLD.insert THEN;



                RecSLD.Code := ref;
                RecSLD."Sales Code" := CopyStr(GrpoDesc, 1, 4) + '25';
                RecSLD."Line Discount %" := Descuento2;
                RecSLD."Sales Type" := RecSLD."Sales Type"::"Customer Disc. Group";
                RecSLD."Starting Date" := fechaini;
                RecSLD."Ending Date" := fechafin;
                RecSLD."Minimum Quantity" := Cantidad1;
                RecSLD."Unit of Measure Code" := 'UDS';
                IF RecSLD.insert THEN;



                RecSLD.Code := ref;
                RecSLD."Sales Code" := CopyStr(GrpoDesc, 1, 4) + '25';
                RecSLD."Line Discount %" := Descuento3;
                RecSLD."Sales Type" := RecSLD."Sales Type"::"Customer Disc. Group";
                RecSLD."Starting Date" := fechaini;
                RecSLD."Ending Date" := fechafin;
                RecSLD."Minimum Quantity" := Cantidad3;
                RecSLD."Unit of Measure Code" := 'UDS';
                IF RecSLD.insert THEN;


                RecSLD.Code := ref;
                RecSLD."Sales Code" := CopyStr(GrpoDesc, 1, 4) + '30';
                RecSLD."Line Discount %" := Descuento3;
                RecSLD."Sales Type" := RecSLD."Sales Type"::"Customer Disc. Group";
                RecSLD."Starting Date" := fechaini;
                RecSLD."Ending Date" := fechafin;
                RecSLD."Minimum Quantity" := Cantidad1;
                RecSLD."Unit of Measure Code" := 'UDS';
                IF RecSLD.insert THEN;




            end;
        END;
    end;
}

