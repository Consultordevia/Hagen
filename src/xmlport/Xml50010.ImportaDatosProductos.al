#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50010 "Importa Datos Productos"

{
    
    Caption = 'Importa Datos Productos';
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
                }
                textelement(D18)
                {
                }
                textelement(D19)
                {
                }
                textelement(D20)
                {
                }
                textelement(D21)
                {
                }
                textelement(D22)
                {
                }
                textelement(D23)
                {
                }
                textelement(D24)
                {
                }
                textelement(D25)
                {
                }
                textelement(D26)
                {
                }
                textelement(D27)
                {
                }
                textelement(D28)
                {
                }
                textelement(D29)
                {
                }
                textelement(D30)
                {
                }
                textelement(D31)
                {
                }
                textelement(D32)
                {
                }
                textelement(D33)
                {
                }
                textelement(D34)
                {
                }
                textelement(D35)
                {
                }
                textelement(D36)
                {
                }
                textelement(D37)
                {
                }
                textelement(D38)
                {
                }
                textelement(D39)
                {
                }
                textelement(D40)
                {
                }
                textelement(D41)
                {
                }
                textelement(D42)
                {
                }
                textelement(D43)
                {
                }
                textelement(D44)
                {
                }
                textelement(D45)
                {
                }
                textelement(D46)
                {
                }
                textelement(D47)
                {
                }
                textelement(D48)
                {
                }
                textelement(D49)
                {
                }
                textelement(D50)
                {
                }
                textelement(D51)
                {
                }
                textelement(D52)
                {
                }
                textelement(D53)
                {
                }
                textelement(D54)
                {
                }
                textelement(D55)
                {
                }
                textelement(D56)
                {
                }
                textelement(D57)
                {
                }
                textelement(D58)
                {
                }
                textelement(D59)
                {
                }
                textelement(D60)
                {
                }
                textelement(D61)
                {
                }
                textelement(D62)
                {
                }
                textelement(D63)
                {
                }
                textelement(D64)
                {
                }
                textelement(D65)
                {
                }
                textelement(D66)
                {
                }
                textelement(D67)
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
        FileName: Text[250];
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
        D2DESCRIP: Text[100];
        D3DESWEB: Text[100];
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
        Mulatributos: Record "Mul.atributos";
        coded: DateFormula;
        PlazoDateFormula: DateFormula;
        conta: Integer;

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


        conta:=conta+1;

        if conta>1 then begin




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

            if not RecItem.Get(D1) then begin
                RecItem."No." := D1;
                RecItem.Insert;
            end;


        end;
        if (D2 <> '') then begin
            D2DESCRIP := D2;
            if D2DESCRIP <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem.Description := CopyStr(D2DESCRIP, 1, 50);
                    RecItem."Description 2" := CopyStr(D2DESCRIP, 51, 50);
                    RecItem.Modify;
                end;
            end;

        end;

        if (D3 <> '') then begin
            D3DESWEB := D3;
            if D3DESWEB <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem."Descripcion web" := D3DESWEB;
                    /////RecItem."Imagen Articulo WEB" := 'c:\imagenes\' + D1 + '.jpg';
                    /////RecItem."Imagen Articulo WEB 2" := 'c:\imagenes\' + D1 + '-2.jpg';
                    /////RecItem."Imagen Articulo WEB 3" := 'c:\imagenes\' + D1 + '-3.jpg';
                    /////RecItem."Imagen Articulo WEB 4" := 'c:\imagenes\' + D1 + '-4.jpg';
                    RecItem.Modify;
                end;
            end;

        end;
        if (D4 <> '') then begin
            if RecItem.Get(D1) then begin
                RecItem.CodVariante1 := D4;
                RecItem.Modify;
            END;
        end;
        if (D5 <> '') then begin
            if RecItem.Get(D1) then begin
                RecItem."Dato Variante1" := D5;
                RecItem.Modify;
            END;
        end;
        if (D6 <> '') then begin
            if RecItem.Get(D1) then begin
                RecItem.CodVariante2 := D6;
                RecItem.Modify;
            END;
        end;
        if (D7 <> '') then begin
            if RecItem.Get(D1) then begin
                RecItem."Dato Variante2" := D7;
                RecItem.Modify;
            END;
        end;



        if (D8 <> '') then begin
            ref := D8;
            codprod2 := ref;
            x := 0;
            codprod := '';
            repeat
                x := x + 1;
                if CopyStr(codprod2, x, 1) <> '.' then begin
                    codprod := codprod + CopyStr(codprod2, x, 1);
                end;
            until x = StrLen(codprod2);
            D6REFPADRE := codprod;

            if D6REFPADRE <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem."Producto PADRE" := D6REFPADRE;
                    RecItem.Modify;
                end;
            end;
        end;



        if (D9 <> '') then begin
            D7ENVIARAWEB := D9;
            if D7ENVIARAWEB = 'S' then begin
                if RecItem.Get(D1) then begin
                    RecItem."Enviar a web" := true;
                    RecItem."Actualizar WEB" := true;
                    RecItem.Modify;
                end;
            end;
            if D7ENVIARAWEB = 'N' then begin
                if RecItem.Get(D1) then begin
                    RecItem."Enviar a web" := false;
                    RecItem."Actualizar WEB" := false;
                    RecItem.Modify;
                end;
            end;

        end;


        if (D10 <> '') then begin
            if RecItem.Get(D1) then begin
                RecItem.Gama := D10;
                RecItem.Modify;
            end;
        end;


        if (D11 <> '') then begin
            D9PESOUNI := D11;
            if D9PESOUNI <> '' then begin
                if RecItem.Get(D1) then begin
                    Evaluate(peso1, D9PESOUNI);
                    RecItem."Gross Weight" := peso1;
                    RecItem."Net Weight" := peso1;
                    RecItem.Modify;
                end;
                RecUMP.Reset;
                RecUMP.SetRange(RecUMP."Item No.", D1);
                RecUMP.SetRange(RecUMP.Code, 'UDS');
                if RecUMP.FindFirst then begin
                    Evaluate(peso1, D9PESOUNI);
                    RecUMP.Weight := peso1;
                    RecUMP.Modify;
                    /////- RecUMP.CalcCubage;
                    ///RecUMP.CalcWeight;
                    /////                   RecUMP.MODIFY;
                end;
                if not RecUMP.FindFirst then begin
                    RecUMP."Item No." := D1;
                    RecUMP.Code := 'UDS';
                    RecUMP."Qty. per Unit of Measure" := 1;
                    Evaluate(peso1, D9PESOUNI);
                    RecUMP.Weight := peso1;
                    /////- RecUMP.CalcCubage;
                    ///RecUMP.CalcWeight;
                    RecUMP.Insert;
                end;

            end;
        end;

        if (D20 <> '') then begin
            D10LARGOUNI := D12;
            if D10LARGOUNI <> '' then begin
                if RecItem.Get(D1) then begin
                    Evaluate(RecItem.Largo, D10LARGOUNI);
                    RecItem.Modify;
                end;
                RecUMP.Reset;
                RecUMP.SetRange(RecUMP."Item No.", D1);
                RecUMP.SetRange(RecUMP.Code, 'UDS');
                if RecUMP.FindFirst then begin
                    Evaluate(RecUMP.Length, D10LARGOUNI);
                    RecUMP.Validate(RecUMP.Length);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Modify;
                end;
                if not RecUMP.FindFirst then begin
                    RecUMP."Item No." := D1;
                    RecUMP.Code := 'UDS';
                    RecUMP."Qty. per Unit of Measure" := 1;
                    Evaluate(RecUMP.Length, D10LARGOUNI);
                    RecUMP.Validate(RecUMP.Length);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Insert;
                end;

            end;
        end;

        if (D13 <> '') then begin
            D11ANCHOUNI := D13;
            if D11ANCHOUNI <> '' then begin
                if RecItem.Get(D1) then begin
                    Evaluate(RecItem.Ancho, D11ANCHOUNI);
                    RecItem.Modify;
                end;
                RecUMP.Reset;
                RecUMP.SetRange(RecUMP."Item No.", D1);
                RecUMP.SetRange(RecUMP.Code, 'UDS');
                if RecUMP.FindFirst then begin
                    Evaluate(RecUMP.Width, D11ANCHOUNI);
                    RecUMP.Validate(RecUMP.Width);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Modify;
                end;
                if not RecUMP.FindFirst then begin
                    RecUMP."Item No." := D1;
                    RecUMP.Code := 'UDS';
                    RecUMP."Qty. per Unit of Measure" := 1;
                    Evaluate(RecUMP.Width, D11ANCHOUNI);
                    RecUMP.Validate(RecUMP.Width);
                    /////- RecUMP.CalcCubage;
                    //                   RecUMP.CalcWeight;
                    RecUMP.Insert;
                end;

            end;
        end;

        if (D14 <> '') then begin
            D12ALTOUNI := D14;
            if D12ALTOUNI <> '' then begin
                if RecItem.Get(D1) then begin
                    Evaluate(RecItem.Alto, D12ALTOUNI);
                    RecItem.Modify;
                end;
                RecUMP.Reset;
                RecUMP.SetRange(RecUMP."Item No.", D1);
                RecUMP.SetRange(RecUMP.Code, 'UDS');
                if RecUMP.FindFirst then begin
                    Evaluate(RecUMP.Height, D12ALTOUNI);
                    RecUMP.Validate(RecUMP.Height);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Modify;
                end;
                if not RecUMP.FindFirst then begin
                    RecUMP."Item No." := D1;
                    RecUMP.Code := 'UDS';
                    RecUMP."Qty. per Unit of Measure" := 1;
                    Evaluate(RecUMP.Height, D12ALTOUNI);
                    RecUMP.Validate(RecUMP.Height);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Insert;
                end;

            end;
        end;
        if (D15 <> '') then begin
            D13MARCA := D15;
            if D13MARCA <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem.Marca := D13MARCA;
                    RecItem.Modify;
                end;
            end;
        end;
        if (D16 <> '') then begin
            D14CODPROPROVEE := D16;
            if D14CODPROPROVEE <> '' then begin
                if RecItem.Get(D1) then begin
                    codprod2 := D14CODPROPROVEE;
                    x := 0;
                    codprod := '';
                    repeat
                        x := x + 1;
                        if CopyStr(codprod2, x, 1) <> '.' then begin
                            codprod := codprod + CopyStr(codprod2, x, 1);
                        end;
                    until x = StrLen(codprod2);
                    D14CODPROPROVEE := codprod;

                    RecItem."Vendor Item No." := D14CODPROPROVEE;
                    RecItem.Modify;
                end;
            end;
        end;

        if (D17 <> '') then begin
            ref := D17;
            codprod2 := ref;
            x := 0;
            codprod := '';
            repeat
                x := x + 1;
                if CopyStr(codprod2, x, 1) <> '.' then begin
                    codprod := codprod + CopyStr(codprod2, x, 1);
                end;
            until x = StrLen(codprod2);
            D15EAN := codprod;
            if D15EAN <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem.Validate(RecItem.ean, D15EAN);
                    RecItem.Modify;
                end;
            end;
        end;


        if (D18 <> '') then begin
            D16TIPOVENTA := D18;
            if D16TIPOVENTA <> '' then begin
                if RecItem.Get(D1) then begin
                    ///  :=D16TIPOVENTA
                    RecItem.Modify;
                end;
            end;
        end;

        if (D19 <> '') then begin
            ref := D19;
            codprod2 := ref;
            x := 0;
            codprod := '';
            repeat
                x := x + 1;
                if CopyStr(codprod2, x, 1) <> '.' then begin
                    codprod := codprod + CopyStr(codprod2, x, 1);
                end;
            until x = StrLen(codprod2);
            D17CODVENTA := codprod;
            if D17CODVENTA <> '' then begin
                if RecItem.Get(D1) then begin
                    ///     RecItem.MODIFY;
                end;
            end;
        end;
        if (D20 <> '') then begin
            D18PRECIOTAR := D20;
            if D18PRECIOTAR <> '' then begin
                RecSP.Reset;
                RecSP.SetRange(RecSP."Sales Type", 1);
                RecSP.SetRange(RecSP."Sales Code", D17CODVENTA);
                RecSP.SetRange(RecSP."Item No.", D1);
                if RecSP.FindFirst then begin
                    Evaluate(RecSP."Unit Price", D18PRECIOTAR);
                    RecSP.Modify;
                end;
                if not RecSP.FindFirst then begin
                    RecSP."Item No." := D1;
                    RecSP."Sales Type" := 1;
                    RecSP."Sales Code" := D17CODVENTA;
                    Evaluate(RecSP."Unit Price", D18PRECIOTAR);
                    RecSP.Insert;
                end;

            end;
        end;

        if (D21 <> '') then begin
            D19PVPR := D21;
            if D19PVPR <> '' then begin
                RecSP.Reset;
                RecSP.SetRange(RecSP."Sales Type", 1);
                RecSP.SetRange(RecSP."Sales Code", D17CODVENTA);
                RecSP.SetRange(RecSP."Item No.", D1);
                if RecSP.FindFirst then begin
                    Evaluate(RecSP."Precio recomendado", D19PVPR);
                    RecSP.Modify;
                end;
                if not RecSP.FindFirst then begin
                    RecSP."Item No." := D1;
                    RecSP."Sales Type" := 1;
                    RecSP."Sales Code" := D17CODVENTA;
                    Evaluate(RecSP."Precio recomendado", D19PVPR);
                    RecSP.Insert;
                end;

            end;
        end;

        if (D22 <> '') then begin
            D20COLCHONWEB := D22;
            if D20COLCHONWEB <> '' then begin
                if RecItem.Get(D1) then begin
                    Evaluate(RecItem."Umbral stock", D22);
                    RecItem.Modify;
                end;
            end;
        end;

        if (D23 <> '') then begin
            D21ESTADO := UpperCase(D23);

            if D21ESTADO <> '' then begin
                if RecItem.Get(D1) then begin
                    if CopyStr(D21ESTADO, 1, 1) = 'A' then RecItem."Estado Producto" := 0;
                    if CopyStr(D21ESTADO, 1, 1) = 'D' then RecItem."Estado Producto" := 1;
                    if CopyStr(D21ESTADO, 1, 2) = 'AN' then RecItem."Estado Producto" := 2;
                    if CopyStr(D21ESTADO, 1, 1) = 'S' then RecItem."Estado Producto" := 3;
                    RecItem.Modify;
                end;
            end;
        end;



        /*
                if (D20 <> '') then begin
                    D20COLCHONWEB := D20;
                    if D20COLCHONWEB <> '' then begin
                        if RecItem.Get(D1) then begin
                            Evaluate(RecItem."Cantidad colchon web", D20COLCHONWEB);
                            RecItem.Modify;
                        end;
                    end;
                end;

                if (D22 <> '') then begin
                    D22COSTEUNIDIC := D22;
                    if D22COSTEUNIDIC <> '' then begin
                        if RecItem.Get(D1) then begin
                            RecItem.Modify;
                        end;
                    end;
                end;


                if (D23 <> '') then begin
                    D23DTOPROVEE := D23;
                    if D23DTOPROVEE <> '' then begin
                        if RecItem.Get(D1) then begin
                            RecItem.Modify;
                        end;
                    end;
                end;*/

        if (D26 <> '') then begin
            D24GRIVAPROD := D26;
            if D24GRIVAPROD <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem."VAT Prod. Posting Group" := D24GRIVAPROD;
                    RecItem.Modify;
                end;
            end;
        end;

        if (D27 <> '') then begin
            D24GRIVAPROD := D27;
            if D24GRIVAPROD <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem.Level1 := D24GRIVAPROD;
                    RecItem.Modify;
                end;
            end;
        end;
        if (D28 <> '') then begin
            D24GRIVAPROD := D28;
            if D24GRIVAPROD <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem.Level2 := D24GRIVAPROD;
                    RecItem.Modify;
                end;
            end;
        end;
        if (D29 <> '') then begin
            D24GRIVAPROD := D29;
            if D24GRIVAPROD <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem.Level3 := D24GRIVAPROD;
                    RecItem.Modify;
                end;
            end;
        end;





        /*
        if (D25 <> '') then begin
            D25LINEA := D25;
            if D25LINEA <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem."Gen. Prod. Posting Group" := D25LINEA;
                    RecItem.Modify;
                end;
            end;
        end;
        if (D26 <> '') then begin
            D26FAMILIA := D26;
            if D26FAMILIA <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem.Familia := D26FAMILIA;
                    RecItem.Modify;
                end;
            end;
        end;
        if (D27 <> '') then begin
            D27SUBFAMILIA := D27;
            if D27SUBFAMILIA <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem.Subfamilia := D27SUBFAMILIA;
                    RecItem.Modify;
                end;
            end;
        end;*/


        if (D30 <> '') then begin
            D28ROTA := D30;
            if D28ROTA <> '' then begin
                if RecItem.Get(D1) then begin
                    if D28ROTA = 'FC' then RecItem."Criterio rotacion" := 0;
                    if D28ROTA = 'FE' then RecItem."Criterio rotacion" := 1;
                    if D28ROTA = 'FF' then RecItem."Criterio rotacion" := 2;
                    if D28ROTA = 'LO' then RecItem."Criterio rotacion" := 3;
                    RecItem.Modify;
                end;
            end;
        end;

        if (D31 <> '') then begin
            D29TIPOPROD := D31;
            if D29TIPOPROD <> '' then begin
                if RecItem.Get(D1) then begin

                    RecItem.Modify;
                end;
            end;
        end;
        if (D32 <> '') then begin
            D30TIPOPALETS := D32;
            if D30TIPOPALETS <> '' then begin
                if RecItem.Get(D1) then begin
                    /////RecItem."Tipo palet":=D30TIPOPALETS;
                    RecItem.Modify;
                end;
            end;
        end;

        if (D33 <> '') then begin
            D31UMB := D33;
            if D31UMB <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem."Base Unit of Measure" := D31UMB;
                    RecItem.Modify;
                end;
            end;
        end;
        if (D34 <> '') then begin
            D32CDADINNER := D34;
            if D32CDADINNER <> '' then begin
                if RecItem.Get(D1) then begin
                    Evaluate(RecItem."Cantidad inner", D32CDADINNER);
                    RecItem.Modify;
                end;
            end;
        end;
        if (D35 <> '') then begin
            D33PESOIN := D35;
            if D33PESOIN <> '' then begin
                RecUMP.Reset;
                RecUMP.SetRange(RecUMP."Item No.", D1);
                RecUMP.SetRange(RecUMP.Code, 'IN');
                if RecUMP.FindFirst then begin
                    Evaluate(RecUMP.Weight, D33PESOIN);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Modify;
                    RecItem22.Get(D1);
                    ///// CUADAIA.MODIFPROD(RecItem22);

                end;
                if not RecUMP.FindFirst then begin
                    RecUMP."Item No." := D1;
                    RecUMP.Code := 'IN';
                    if D32CDADINNER <> '' then begin
                        Evaluate(RecUMP."Qty. per Unit of Measure", D32CDADINNER);
                    end;
                    Evaluate(RecUMP.Weight, D33PESOIN);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Insert;
                    RecItem22.Get(D1);
                    /////CUADAIA.MODIFPROD(RecItem22);

                end;

            end;
        end;
        if (D36 <> '') then begin
            D34LARGOIN := D36;
            if D34LARGOIN <> '' then begin
                if RecItem.Get(D1) then begin
                    Evaluate(RecItem."Largo INNER", D34LARGOIN);
                    RecItem.Modify;
                end;
                RecUMP.Reset;
                RecUMP.SetRange(RecUMP."Item No.", D1);
                RecUMP.SetRange(RecUMP.Code, 'IN');
                if RecUMP.FindFirst then begin
                    Evaluate(RecUMP.Length, D34LARGOIN);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Modify;
                    RecItem22.Get(D1);
                    ///////CUADAIA.MODIFPROD(RecItem22);

                end;
                if not RecUMP.FindFirst then begin
                    RecUMP."Item No." := D1;
                    RecUMP.Code := 'IN';
                    if D32CDADINNER <> '' then begin
                        Evaluate(RecUMP."Qty. per Unit of Measure", D32CDADINNER);
                    end;
                    Evaluate(RecUMP.Length, D34LARGOIN);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Insert;
                    RecItem22.Get(D1);
                    /////CUADAIA.MODIFPROD(RecItem22);

                end;

            end;
        end;

        if (D37 <> '') then begin
            D35ANCHOIN := D37;
            if D35ANCHOIN <> '' then begin
                if RecItem.Get(D1) then begin
                    Evaluate(RecItem."Ancho INNER", D35ANCHOIN);
                    RecItem.Modify;
                end;
                RecUMP.Reset;
                RecUMP.SetRange(RecUMP."Item No.", D1);
                RecUMP.SetRange(RecUMP.Code, 'IN');
                if RecUMP.FindFirst then begin
                    Evaluate(RecUMP.Width, D35ANCHOIN);
                    /////- RecUMP.CalcCubage;
                    ////                   RecUMP.CalcWeight;
                    RecUMP.Modify;
                    RecItem22.Get(D1);
                    ////CUADAIA.MODIFPROD(RecItem22);

                end;
                if not RecUMP.FindFirst then begin
                    RecUMP."Item No." := D1;
                    RecUMP.Code := 'IN';
                    if D32CDADINNER <> '' then begin
                        Evaluate(RecUMP."Qty. per Unit of Measure", D32CDADINNER);
                    end;
                    Evaluate(RecUMP.Width, D35ANCHOIN);
                    /////- RecUMP.CalcCubage;
                    /////                   RecUMP.CalcWeight;
                    RecUMP.Insert;
                    RecItem22.Get(D1);
                    ////CUADAIA.MODIFPROD(RecItem22);

                end;

            end;
        end;

        if (D38 <> '') then begin
            D36ALTOIN := D38;
            if D36ALTOIN <> '' then begin
                if RecItem.Get(D1) then begin
                    Evaluate(RecItem."Alto INNER", D36ALTOIN);
                    RecItem.Modify;
                end;
                RecUMP.Reset;
                RecUMP.SetRange(RecUMP."Item No.", D1);
                RecUMP.SetRange(RecUMP.Code, 'IN');
                if RecUMP.FindFirst then begin
                    Evaluate(RecUMP.Height, D36ALTOIN);
                    /////- RecUMP.CalcCubage;
                    /////                   RecUMP.CalcWeight;
                    RecUMP.Modify;
                    RecItem22.Get(D1);
                    ////CUADAIA.MODIFPROD(RecItem22);

                end;
                if not RecUMP.FindFirst then begin
                    RecUMP."Item No." := D1;
                    RecUMP.Code := 'IN';
                    if D32CDADINNER <> '' then begin
                        Evaluate(RecUMP."Qty. per Unit of Measure", D32CDADINNER);
                    end;
                    Evaluate(RecUMP.Height, D36ALTOIN);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Insert;
                    RecItem22.Get(D1);
                    ////CUADAIA.MODIFPROD(RecItem22);

                end;

            end;
        end;
        if (D39 <> '') then begin
            D37CDADAMSTER := D39;
            if D37CDADAMSTER <> '' then begin
                if RecItem.Get(D1) then begin
                    Evaluate(RecItem."Cantidad master", D37CDADAMSTER);
                    RecItem.Modify;
                end;
            end;
        end;

        if (D40 <> '') then begin
            D38PESOMAS := D40;
            if D38PESOMAS <> '' then begin
                RecUMP.Reset;
                RecUMP.SetRange(RecUMP."Item No.", D1);
                RecUMP.SetRange(RecUMP.Code, 'MA');
                if RecUMP.FindFirst then begin
                    Evaluate(RecUMP.Weight, D38PESOMAS);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Modify;
                    RecItem22.Get(D1);
                    ///CUADAIA.MODIFPROD(RecItem22);

                end;
                if not RecUMP.FindFirst then begin
                    RecUMP."Item No." := D1;
                    RecUMP.Code := 'MA';
                    if D37CDADAMSTER <> '' then begin
                        Evaluate(RecUMP."Qty. per Unit of Measure", D37CDADAMSTER);
                    end;
                    Evaluate(RecUMP.Weight, D38PESOMAS);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Insert;
                    RecItem22.Get(D1);
                    ////CUADAIA.MODIFPROD(RecItem22);

                end;

            end;
        end;
        if (D41 <> '') then begin
            D39LARGOMAS := D41;
            if D39LARGOMAS <> '' then begin
                if RecItem.Get(D1) then begin
                    Evaluate(RecItem."Largo master", D39LARGOMAS);
                    RecItem.Modify;
                end;
                RecUMP.Reset;
                RecUMP.SetRange(RecUMP."Item No.", D1);
                RecUMP.SetRange(RecUMP.Code, 'MA');
                if RecUMP.FindFirst then begin
                    Evaluate(RecUMP.Length, D39LARGOMAS);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Modify;
                    RecItem22.Get(D1);
                    ////CUADAIA.MODIFPROD(RecItem22);

                end;
                if not RecUMP.FindFirst then begin
                    RecUMP."Item No." := D1;
                    RecUMP.Code := 'MA';
                    if D37CDADAMSTER <> '' then begin
                        Evaluate(RecUMP."Qty. per Unit of Measure", D37CDADAMSTER);
                    end;
                    Evaluate(RecUMP.Length, D39LARGOMAS);
                    /////- RecUMP.CalcCubage;
                    ////                   RecUMP.CalcWeight;
                    RecUMP.Insert;
                    RecItem22.Get(D1);
                    ////CUADAIA.MODIFPROD(RecItem22);

                end;


            end;
        end;
        if (D42 <> '') then begin
            D40ANCHOMAS := D42;
            if D40ANCHOMAS <> '' then begin
                if RecItem.Get(D1) then begin
                    Evaluate(RecItem."Ancho master", D40ANCHOMAS);
                    RecItem.Modify;
                end;
                RecUMP.Reset;
                RecUMP.SetRange(RecUMP."Item No.", D1);
                RecUMP.SetRange(RecUMP.Code, 'MA');
                if RecUMP.FindFirst then begin
                    Evaluate(RecUMP.Width, D40ANCHOMAS);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Modify;
                    RecItem22.Get(D1);
                    ////CUADAIA.MODIFPROD(RecItem22);

                end;
                if not RecUMP.FindFirst then begin
                    RecUMP."Item No." := D1;
                    RecUMP.Code := 'MA';
                    if D37CDADAMSTER <> '' then begin
                        Evaluate(RecUMP."Qty. per Unit of Measure", D37CDADAMSTER);
                    end;
                    Evaluate(RecUMP.Width, D40ANCHOMAS);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Insert;
                    RecItem22.Get(D1);
                    ////CUADAIA.MODIFPROD(RecItem22);

                end;

            end;
        end;
        if (D43 <> '') then begin
            D41ALTOMAS := D43;
            if D41ALTOMAS <> '' then begin
                if RecItem.Get(D1) then begin
                    Evaluate(RecItem."Alto master", D41ALTOMAS);
                    RecItem.Modify;
                end;
                RecUMP.Reset;
                RecUMP.SetRange(RecUMP."Item No.", D1);
                RecUMP.SetRange(RecUMP.Code, 'MA');
                if RecUMP.FindFirst then begin
                    Evaluate(RecUMP.Height, D41ALTOMAS);
                    /////- RecUMP.CalcCubage;

                    ///                   RecUMP.CalcWeight;
                    RecUMP.Modify;
                    RecItem22.Get(D1);
                    ////CUADAIA.MODIFPROD(RecItem22);

                end;
                if not RecUMP.FindFirst then begin
                    RecUMP."Item No." := D1;
                    RecUMP.Code := 'MA';
                    if D37CDADAMSTER <> '' then begin
                        Evaluate(RecUMP."Qty. per Unit of Measure", D37CDADAMSTER);
                    end;
                    Evaluate(RecUMP.Height, D41ALTOMAS);
                    /////- RecUMP.CalcCubage;
                    ///                   RecUMP.CalcWeight;
                    RecUMP.Insert;
                    RecItem22.Get(D1);
                    ////CUADAIA.MODIFPROD(RecItem22);

                end;

            end;
        end;

        if (D44 <> '') then begin
            D42UNIMEDCOMP := D44;
            if D42UNIMEDCOMP <> '' then begin
                if RecItem.Get(D1) then begin
                    Evaluate(RecItem."Unidad compra", D42UNIMEDCOMP);
                    RecItem.Modify;
                end;
            end;
        end;

        if (D45 <> '') then begin
            D43DIMHUEOC := D45;
            if D43DIMHUEOC <> '' then begin
                if RecItem.Get(D1) then begin
                    ///RecItem."Dimensión hueco":=COPYSTR(D43DIMHUEOC,1,10);
                    RecItem.Modify;
                end;
            end;
        end;
        if (D46 <> '') then begin
            D44GRUPOCONTABLE := D46;
            if D44GRUPOCONTABLE <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem."Inventory Posting Group" := D44GRUPOCONTABLE;
                    RecItem.Modify;
                end;
            end;
        end;
        /*IF (D56<>'') THEN BEGIN
             D45UNIMEDVENTA:=D56;
             IF D45UNIMEDVENTA<>'' THEN BEGIN
                  IF RecItem.GET(D1) THEN BEGIN
                       RecItem."Purch. Unit of Measure":=D45UNIMEDVENTA;
                       RecItem.MODIFY;
                  END;
             END;
        END;
        */
        if (D47 <> '') then begin
            D45UNIMEDVENTA := D47;
            if D45UNIMEDVENTA <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem."Sales Unit of Measure" := D45UNIMEDVENTA;
                    RecItem.Modify;
                end;
            end;
        end;
        if (D48 <> '') then begin
            D46UNIDADESNTA := D48;
            if D46UNIDADESNTA <> '' then begin
                if RecItem.Get(D1) then begin
                    Evaluate(RecItem."Unidades venta", D46UNIDADESNTA);
                    RecItem.Modify;
                end;
            end;
        end;
        if (D49 <> '') then begin
            D47PERMITFRAC := D49;
            if D47PERMITFRAC <> '' then begin
                if RecItem.Get(D1) then begin
                    if UpperCase(D47PERMITFRAC) = 'N' then begin
                        RecItem."Permite fraccionar venta" := false;
                        RecItem.Modify;
                    end;
                    if UpperCase(D47PERMITFRAC) = 'S' then begin
                        RecItem."Permite fraccionar venta" := true;
                        RecItem.Modify;
                    end;

                end;
            end;
        end;
        if (D50 <> '') then begin
            D48ZONAALMA := D50;
            if D48ZONAALMA <> '' then begin
                if RecItem.Get(D1) then begin
                    ///IF D48ZONAALMA='GRAL' THEN RecItem."Zona almacenaje":=0;
                    ///IF D48ZONAALMA='CAO' THEN RecItem."Zona almacenaje":=1;
                    ///IF D48ZONAALMA='NCF' THEN RecItem."Zona almacenaje":=2;
                    ///IF D48ZONAALMA='MUR' THEN RecItem."Zona almacenaje":=3;
                    RecItem.Modify;
                end;
            end;
        end;
        if (D51 <> '') then begin
            D49ZONAPICK := D51;
            if D49ZONAPICK <> '' then begin
                if RecItem.Get(D1) then begin
                    ///RecItem."Zona picking":=D49ZONAPICK;
                    ///IF D49ZONAPICK='GRAL' THEN RecItem."Zona picking":=0;
                    ///IF D49ZONAPICK='CAO' THEN RecItem."Zona picking":=1;
                    ///IF D49ZONAPICK='NCF' THEN RecItem."Zona picking":=2;
                    ///IF D49ZONAPICK='MUR' THEN RecItem."Zona picking":=3;

                    RecItem.Modify;
                end;
            end;
        end;
        if (D52 <> '') then begin
            D50PRODALMA := D52;
            if D50PRODALMA <> '' then begin
                if RecItem.Get(D1) then begin
                    if UpperCase(D50PRODALMA) = 'N' then begin
                        RecItem."Producto almacenable" := false;
                        RecItem.Modify;
                    end;
                    if UpperCase(D50PRODALMA) = 'S' then begin
                        RecItem."Producto almacenable" := true;
                        RecItem.Modify;
                    end;
                end;
            end;
        end;

        if (D53 <> '') then begin
            D51ODPROVEE := D53;
            if D51ODPROVEE <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem."Vendor No." := D51ODPROVEE;
                    RecItem.Modify;
                    RecPC.Reset;
                    RecPC.SetRange(RecPC."Item No.", D1);
                    RecPC.SetRange(RecPC."Vendor No.", D51ODPROVEE);
                    if RecPC.FindFirst then begin
                        if D22COSTEUNIDIC <> '' then begin
                            Evaluate(RecPC."Precio Tarifa", D22COSTEUNIDIC);
                            Evaluate(RecPC."Direct Unit Cost", D22COSTEUNIDIC);
                        end;
                        RecPC.Modify;
                    end;
                    if not RecPC.FindFirst then begin
                        RecPC."Item No." := D1;
                        RecPC.Validate(RecPC."Vendor No.", D51ODPROVEE);
                        if D22COSTEUNIDIC <> '' then begin
                            Evaluate(RecPC."Precio Tarifa", D22COSTEUNIDIC);
                            Evaluate(RecPC."Direct Unit Cost", D22COSTEUNIDIC);
                        end;
                        RecPC.Insert;
                    end;
                    RecTCP.Reset;
                    RecTCP.SetRange(RecTCP."Vendor No.", D51ODPROVEE);
                    RecTCP.SetRange(RecTCP."Item No.", D1);
                    if RecTCP.FindFirst then begin
                        RecTCP."Vendor Item No." := D14CODPROPROVEE;
                        RecTCP.Modify;
                    end;
                    if not RecTCP.FindFirst then begin
                        RecTCP."Vendor No." := D51ODPROVEE;
                        RecTCP."Item No." := D1;
                        RecTCP."Vendor Item No." := D14CODPROPROVEE;
                        RecTCP.Insert;
                    end;
                end;
            end;
        end;
        if (D54 <> '') then begin
            ref := D54;
            codprod2 := ref;
            x := 0;
            codprod := '';
            repeat
                x := x + 1;
                if CopyStr(codprod2, x, 1) <> '.' then begin
                    codprod := codprod + CopyStr(codprod2, x, 1);
                end;
            until x = StrLen(codprod2);
            D52EANINNE := codprod;
            if D52EANINNE <> '' then begin
                RecUMP.Reset;
                RecUMP.SetRange(RecUMP."Item No.", D1);
                RecUMP.SetRange(RecUMP.Code, 'IN');
                if RecUMP.FindFirst then begin
                    RecUMP.Validate(ean, D52EANINNE);
                    RecUMP.Modify;
                    RecItem22.Get(D1);
                    ///CUADAIA.MODIFPROD(RecItem22);
                end;
                if not RecUMP.FindFirst then begin
                    RecUMP."Item No." := D1;
                    RecUMP.Code := 'IN';
                    if D32CDADINNER <> '' then begin
                        Evaluate(RecUMP."Qty. per Unit of Measure", D32CDADINNER);
                    end;
                    RecUMP.Validate(ean, D52EANINNE);
                    RecUMP.Insert;
                    RecItem22.Get(D1);
                    ///CUADAIA.MODIFPROD(RecItem22);

                end;

            end;
        end;
        if (D55 <> '') then begin
            ref := D55;
            codprod2 := ref;
            x := 0;
            codprod := '';
            repeat
                x := x + 1;
                if CopyStr(codprod2, x, 1) <> '.' then begin
                    codprod := codprod + CopyStr(codprod2, x, 1);
                end;
            until x = StrLen(codprod2);
            D53EANMAS := codprod;
            if D53EANMAS <> '' then begin
                RecUMP.Reset;
                RecUMP.SetRange(RecUMP."Item No.", D1);
                RecUMP.SetRange(RecUMP.Code, 'MA');
                if RecUMP.FindFirst then begin
                    RecUMP.Validate(ean, D53EANMAS);
                    RecUMP.Modify;
                    RecItem22.Get(D1);
                    ///CUADAIA.MODIFPROD(RecItem22);

                end;
                if not RecUMP.FindFirst then begin
                    RecUMP."Item No." := D1;
                    RecUMP.Code := 'MA';
                    if D37CDADAMSTER <> '' then begin
                        Evaluate(RecUMP."Qty. per Unit of Measure", D37CDADAMSTER);
                    end;
                    RecUMP.Validate(ean, D53EANMAS);
                    RecUMP.Insert;
                    RecItem22.Get(D1);
                    ///CUADAIA.MODIFPROD(RecItem22);

                end;

            end;
        end;

        if (D56 <> '') then begin
            tariff := D56;
            if tariff <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem."Tariff No." := tariff;
                    RecItem.Modify;
                end;
            end;
        end;

        if (D57 <> '') then begin
            igicc := D57;
            if igicc <> '' then begin
                if RecItem.Get(D1) then begin
                    RecItem."IVA IGIC" := igicc;
                    RecItem.Modify;
                end;
            end;
        end;


        if (D58 <> '') then begin
            if RecItem.Get(D1) then begin
                RecItem."Purch. Unit of Measure" := D58;
                RecItem.Modify;
            end;
        end;

        if (D59 <> '') then begin
            if RecItem.Get(D1) then begin
                RecItem."Country/Region Purchased Code" := D59;
                RecItem.Modify;
            end;
        end;


        if (D60 <> '') then begin
            if RecItem.Get(D1) then begin
                if Evaluate(PlazoDateFormula, D60) then begin
                    RecItem.Validate("Lead Time Calculation", PlazoDateFormula);
                    RecItem.Modify;
                end;
            end;
        end;

        if (D61 <> '') then begin
            if RecItem.Get(D1) then begin
                RecItem."Item Category Code" := D61;
                RecItem.Modify;
            end;
        end;
        if (D62 <> '') then begin
            if RecItem.Get(D1) then begin
                RecItem.Etiquetas1 := D62;
                RecItem.Modify;
            end;
        end;
        if (D63 <> '') then begin
            if RecItem.Get(D1) then begin
                RecItem.Etiquetas2 := D63;
                RecItem.Modify;
            end;
        end;
        if (D64 <> '') then begin
            if RecItem.Get(D1) then begin
                RecItem.Etiquetas3 := D64;
                RecItem.Modify;
            end;
        end;
        if (D65 <> '') then begin
            if RecItem.Get(D1) then begin
                RecItem.Etiquetas4 := D65;
                RecItem.Modify;
            end;
        end;
        if (D66 <> '') then begin
            if RecItem.Get(D1) then begin
                RecItem.Etiquetas5 := D66;
                RecItem.Modify;
            end;
        end;
        if (D67 <> '') then begin
            if RecItem.Get(D1) then begin
                RecItem.Etiquetas6 := D67;
                RecItem.Modify;
            end;
        end;


        /*
                if (D59 <> '') then begin
                    if RecItem.Get(D1) then begin
                        Evaluate(RecItem."Largo producto", D59);
                        RecItem.Modify;
                    end;
                end;
                if (D60 <> '') then begin
                    if RecItem.Get(D1) then begin
                        Evaluate(RecItem."Ancho producto", D60);
                        RecItem.Modify;
                    end;
                end;
                if (D61 <> '') then begin
                    if RecItem.Get(D1) then begin
                        Evaluate(RecItem."Alto producto", D61);
                        RecItem.Modify;
                    end;
                end;

                ///// "Mul.atributos".Codigo1 WHERE (Tabla=CONST(Atributos))

                if (D62 <> '0') then begin
                    Mulatributos.Reset;
                    Mulatributos.SetRange(Mulatributos.Tabla, Mulatributos.Tabla::Atributos);
                    Mulatributos.SetRange(Mulatributos.Codigo1, D62);
                    if not Mulatributos.FindFirst then begin
                        Mulatributos.Init;
                        Mulatributos.Tabla := Mulatributos.Tabla::Atributos;
                        Mulatributos.Codigo1 := D62;
                        Mulatributos.Insert;
                    end;
                    if RecItem.Get(D1) then begin
                        RecItem."Atributo 1" := D62;
                        RecItem.Modify;
                    end;
                end;
                if (D64 <> '0') then begin
                    Mulatributos.Reset;
                    Mulatributos.SetRange(Mulatributos.Tabla, Mulatributos.Tabla::Atributos);
                    Mulatributos.SetRange(Mulatributos.Codigo1, D64);
                    if not Mulatributos.FindFirst then begin
                        Mulatributos.Init;
                        Mulatributos.Tabla := Mulatributos.Tabla::Atributos;
                        Mulatributos.Codigo1 := D64;
                        Mulatributos.Insert;
                    end;
                    if RecItem.Get(D1) then begin
                        RecItem."Atributo 1" := D64;
                        RecItem.Modify;
                    end;
                end;
                if (D66 <> '0') then begin
                    Mulatributos.Reset;
                    Mulatributos.SetRange(Mulatributos.Tabla, Mulatributos.Tabla::Atributos);
                    Mulatributos.SetRange(Mulatributos.Codigo1, D66);
                    if not Mulatributos.FindFirst then begin
                        Mulatributos.Init;
                        Mulatributos.Tabla := Mulatributos.Tabla::Atributos;
                        Mulatributos.Codigo1 := D66;
                        Mulatributos.Insert;
                    end;
                    if RecItem.Get(D1) then begin
                        RecItem."Atributo 1" := D66;
                        RecItem.Modify;
                    end;
                end;

                ///// "Mul.atributos".Codigo2 WHERE (Tabla=CONST(Valor Atributo),Codigo1=FIELD(Atributo 1))

                if (D63 <> '0') then begin
                    Mulatributos.Reset;
                    Mulatributos.SetRange(Mulatributos.Tabla, Mulatributos.Tabla::"Valor Atributo");
                    Mulatributos.SetRange(Mulatributos.Codigo1, D62);
                    Mulatributos.SetRange(Mulatributos.Codigo2, D63);
                    if not Mulatributos.FindFirst then begin
                        Mulatributos.Init;
                        Mulatributos.Tabla := Mulatributos.Tabla::"Valor Atributo";
                        Mulatributos.Codigo1 := D62;
                        Mulatributos.Codigo2 := D63;
                        Mulatributos.Insert;
                    end;
                    if RecItem.Get(D1) then begin
                        RecItem."Valor Atributo 1" := D63;
                        RecItem.Modify;
                    end;
                end;
                if (D65 <> '0') then begin
                    Mulatributos.Reset;
                    Mulatributos.SetRange(Mulatributos.Tabla, Mulatributos.Tabla::"Valor Atributo");
                    Mulatributos.SetRange(Mulatributos.Codigo1, D64);
                    Mulatributos.SetRange(Mulatributos.Codigo2, D65);
                    if not Mulatributos.FindFirst then begin
                        Mulatributos.Init;
                        Mulatributos.Tabla := Mulatributos.Tabla::"Valor Atributo";
                        Mulatributos.Codigo1 := D64;
                        Mulatributos.Codigo2 := D65;
                        Mulatributos.Insert;
                    end;
                    if RecItem.Get(D1) then begin
                        RecItem."Valor Atributo 2" := D65;
                        RecItem.Modify;
                    end;
                end;
                if (D67 <> '0') then begin
                    Mulatributos.Reset;
                    Mulatributos.SetRange(Mulatributos.Tabla, Mulatributos.Tabla::"Valor Atributo");
                    Mulatributos.SetRange(Mulatributos.Codigo1, D66);
                    Mulatributos.SetRange(Mulatributos.Codigo2, D67);
                    if not Mulatributos.FindFirst then begin
                        Mulatributos.Init;
                        Mulatributos.Tabla := Mulatributos.Tabla::"Valor Atributo";
                        Mulatributos.Codigo1 := D66;
                        Mulatributos.Codigo2 := D67;
                        Mulatributos.Insert;
                    end;
                    if RecItem.Get(D1) then begin
                        RecItem."Valor Atributo 3" := D67;
                        RecItem.Modify;
                    end;
                end;*/

        end;
    end;
}

