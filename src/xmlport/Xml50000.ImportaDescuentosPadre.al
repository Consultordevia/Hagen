#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50000 "Importa Descuentos Padre"
{
    Caption = 'Alta Stock';
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
        RecSP: Record "Sales Price";
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

        if (D1 <> '') then begin
            ref := D1;
            codprod2 := ref;
            x := 0;
            codprod := '';
            repeat
                x := x + 1;
                if CopyStr(codprod2, x, 1) <> '.' then begin
                    codprod := codprod + CopyStr(codprod2, x, 1);
                end;
            until x = StrLen(codprod2);
            D1 := codprod;
        end;
        if (D3 <> '') then begin ///// codigo ventas
            ref := D3;
            codprod2 := ref;
            x := 0;
            codprod := '';
            repeat
                x := x + 1;
                if CopyStr(codprod2, x, 1) <> '.' then begin
                    codprod := codprod + CopyStr(codprod2, x, 1);
                end;
            until x = StrLen(codprod2);
            D3 := codprod;
        end;
        if (D5 <> '') then begin  ////// fecha inicial
            cdd := CopyStr(Format(D5), 1, 2);
            cmm := CopyStr(Format(D5), 4, 2);
            caa := CopyStr(Format(D5), 7, 4);
            Evaluate(dd, cdd);
            Evaluate(mm, cmm);
            Evaluate(aa, caa);
            fechaini := Dmy2date(dd, mm, aa);

        end;
        if (D6 <> '') then begin ///// descuento
            Evaluate(DESCUENTO, D6);
        end;
        if (D7 <> '') then begin   ///// tipo venta
            Evaluate(TIPOVENTA, D7);
        end;
        if (D8 <> '') then begin  /////cantidad minima
            Evaluate(MINIMO, D8);
        end;
        if (D9 <> '') then begin  ///// fecha final
            cdd := CopyStr(Format(D9), 1, 2);
            cmm := CopyStr(Format(D9), 4, 2);
            caa := CopyStr(Format(D9), 7, 4);
            Evaluate(dd, cdd);
            Evaluate(mm, cmm);
            Evaluate(aa, caa);
            fechafin := Dmy2date(dd, mm, aa);

        end;
        if (D10 <> '') then begin ///// tipo
            Evaluate(TIPO, D10);
        end;
        if (D11 <> '') then begin ///// unidad medida
        end;

        SalesLineDiscountPadre.Init;

        SalesLineDiscountPadre.Type := TIPO;


        SalesLineDiscountPadre.Code := D1;
        SalesLineDiscountPadre."Sales Type" := TIPOVENTA;
        SalesLineDiscountPadre."Sales Code" := D3;
        SalesLineDiscountPadre."Starting Date" := fechaini;
        SalesLineDiscountPadre."Currency Code" := D4;
        SalesLineDiscountPadre."Unit of Measure Code" := D11;
        SalesLineDiscountPadre."Minimum Quantity" := MINIMO;
        SalesLineDiscountPadre."Line Discount %" := DESCUENTO;
        SalesLineDiscountPadre."Ending Date" := fechafin;
        if SalesLineDiscountPadre.Insert then;
    end;
}

