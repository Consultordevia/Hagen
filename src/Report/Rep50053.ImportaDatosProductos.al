#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50053 "_Importa Datos Productos"
{
    Caption = 'Importa Datos Productos';
    ProcessingOnly = true;

    dataset
    {
        dataitem(BudgetBuf;"Budget Buffer")
        {
            DataItemTableView = sorting("G/L Account No.","Dimension Value Code 1","Dimension Value Code 2","Dimension Value Code 3","Dimension Value Code 4","Dimension Value Code 5","Dimension Value Code 6","Dimension Value Code 7","Dimension Value Code 8",Date);
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                RecNo := RecNo + 1;
            end;

            trigger OnPostDataItem()
            begin
                ////7IF RecNo > 0 THEN
                /////  MESSAGE(Text004,GLBudgetEntry.TABLECAPTION,RecNo);
            end;

            trigger OnPreDataItem()
            begin
                RecNo := 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(FileName;FileName)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Workbook File Name';

                        trigger OnAssistEdit()
                        var
                            CommonDialogMgt: Codeunit UnknownCodeunit412;
                        begin
                            FileName := CommonDialogMgt.OpenFile(Text006,'',2,'',0);
                        end;
                    }
                    field(SheetName;SheetName)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Worksheet Name';

                        trigger OnAssistEdit()
                        var
                            ExcelBuf: Record "Excel Buffer";
                        begin
                            SheetName := ExcelBuf.SelectSheetsName(FileName);
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            Description := Text005 + Format(WorkDate);
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        ExcelBuf.DeleteAll;
    end;

    trigger OnPreReport()
    begin
        ExcelBuf.LockTable;
        ReadExcelSheet;
        AnalyzeData;
    end;

    var
        Text000: label 'You must specify a budget name to import to.';
        Text001: label 'Do you want to create %1 %2.';
        Text002: label '%1 %2 is blocked. You cannot import entries.';
        Text003: label 'Are you sure you want to %1 for %2 %3.';
        Text004: label '%1 table has been successfully updated with %2 entries.';
        Text005: label 'Imported from Excel ';
        Text006: label 'Import Excel File';
        Text007: label 'Analyzing Data...\\';
        Text008: label 'You cannot specify more than 8 dimensions in your Excel worksheet.';
        Text009: label 'G/L ACCOUNT NO';
        Text010: label 'G/L Account No.';
        Text011: label 'The text G/L Account No. can only be specified once in the Excel worksheet.';
        Text012: label 'The dimensions specified by worksheet must be placed in the lines before the table.';
        Text013: label 'Dimension ';
        Text014: label 'Date';
        Text015: label 'Dimension 1';
        Text016: label 'Dimension 2';
        Text017: label 'Dimension 3';
        Text018: label 'Dimension 4';
        Text019: label 'Dimension 5';
        Text020: label 'Dimension 6';
        Text021: label 'Dimension 7';
        Text022: label 'Dimension 8';
        Text023: label 'You cannot import the same information twice.\';
        Text024: label 'The combination G/L Account No. - Dimensions - Date must be unique.';
        Text025: label 'G/L Accounts have not been found in the Excel worksheet.';
        Text026: label 'Dates have not been recognized in the Excel worksheet.';
        ExcelBuf: Record "Excel Buffer";
        Dim: Record Dimension;
        DimVal: Record "Dimension Value";
        TempDim: Record Dimension temporary;
        TempDimVal: Record "Dimension Value" temporary;
        GLBudgetEntry: Record "G/L Budget Entry";
        GLBudgetDim: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        TempGLAcc: Record "G/L Account" temporary;
        GLBudgetName: Record "G/L Budget Name";
        GLBudgetEntry3: Record "G/L Budget Entry";
        AnalysisView: Record "Analysis View";
        FileName: Text[250];
        SheetName: Text[250];
        ToGLBudgetName: Code[10];
        DimCode: array [8] of Code[20];
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
        Text027: label 'Replace entries,Add entries';
        Text028: label 'A filter has been used on the %1 when the budget was exported. When a filter on a dimension has been used, a column with the same dimension must be present in the worksheet imported. The column in the worksheet must specify the dimension value codes the program should use when importing the budget.';
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
        RecAct: Record UnknownRecord50006;
        FormAct: Page UnknownPage50020;
        RecAct2: Record UnknownRecord50006;
        FormClie: Page "Customer Card";
        RecCVC: Record "Sales & Receivables Setup";
        NoSerie: Code[10];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        codacti: Code[10];
        RecLNS: Record "No. Series Line";
        RecUser: Record "User Setup";
        RecClie: Record Customer;
        FormPedi: Page UnknownPage50089;
        RecCV2: Record "Purchase Header";
        SalesSetup: Record "Sales & Receivables Setup";
        Rec91: Record "User Setup";
        FormPedidos: Page UnknownPage50052;
        RepRepo: Report "_Estadistica compras reposi.";
        RecLCV: Record "Sales Comment Line";
        lineas: Integer;
        RecProd: Record Item;
        RecRefCruz: Record "Item Cross Reference";
        sale: Boolean;
        numpedi: Code[10];
        PRECIOCOM: Decimal;
        TYPO: Integer;
        CODTIPO: Code[1];
        DESCRIPWEB: Text[100];
        CODREPUES: Text[250];
        CODRELACI: Text[250];
        DESTEC: Text[250];
        RecMt2: Record UnknownRecord50020;
        CODHIJO: Code[20];
        enviaraweb: Code[1];
        D1: Code[20];
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
        CUADAIA: Codeunit UnknownCodeunit50010;
        RecItem22: Record Item;

    local procedure ReadExcelSheet()
    begin
        ExcelBuf.OpenBook(FileName,SheetName);
        ExcelBuf.ReadSheet;
    end;

    local procedure AnalyzeData()
    var
        TempExcelBuf: Record "Excel Buffer" temporary;
        BudgetBuf: Record "Budget Buffer";
        TempBudgetBuf: Record "Budget Buffer" temporary;
        HeaderRowNo: Integer;
        CountDim: Integer;
        TestDate: Date;
        OldRowNo: Integer;
        DimRowNo: Integer;
        DimCode3: Code[20];
    begin
        Window.Open(
          Text007 +
          '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.Update(1,0);
        TotalRecNo := ExcelBuf.Count;
        RecNo := 0;
        if ExcelBuf.Find('-') then begin
          repeat
            RecNo := RecNo + 1;
            Window.Update(1,ROUND(RecNo / TotalRecNo * 10000,1));
        ///     TempDim.SETRANGE("Code Caption",UPPERCASE(FormatData(ExcelBuf."Cell Value as Text")));
            if ExcelBuf."Row No.">1 then begin
        ///    MESSAGE('%1 %2 %3 ',ExcelBuf."Row No.",ExcelBuf."Column No.",ExcelBuf."Cell Value as Text");
            if (ExcelBuf."Column No."=1) then begin
                 ref:=ExcelBuf."Cell Value as Text";
                 codprod2:=ref;
                 x:=0;
                 codprod:='';
                 repeat
                      x:=x+1;
                      if CopyStr(codprod2,x,1)<>'.' then begin
                           codprod:=codprod+CopyStr(codprod2,x,1);
                      end;
                 until x=StrLen(codprod2);
                 D1:=codprod;
                      if not RecItem.Get(D1) then begin
                           RecItem."No.":=D1;
                           RecItem.Insert;
                      end;
            end;
            if (ExcelBuf."Column No."=2) then begin
                 D2DESCRIP:=ExcelBuf."Cell Value as Text";
                 if D2DESCRIP<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem.Description:=D2DESCRIP;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=3) then begin
                 D3DESWEB:=ExcelBuf."Cell Value as Text";
                 if D3DESWEB<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem."Descripcion web":=D3DESWEB;
                           RecItem."Imagen Articulo WEB":='c:\imagenes\'+D1+'.jpg';
                           RecItem."Imagen Articulo WEB 2":='c:\imagenes\'+D1+'-2.jpg';
                           RecItem."Imagen Articulo WEB 3":='c:\imagenes\'+D1+'-3.jpg';
                           RecItem."Imagen Articulo WEB 4":='c:\imagenes\'+D1+'-4.jpg';
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=4) then begin
                 D4PROOPCOMINA:=ExcelBuf."Cell Value as Text";
                 if D4PROOPCOMINA<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem."Producto Opcion Combinacion":=D4PROOPCOMINA;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=5) then begin
                 D56DESHIJO:=ExcelBuf."Cell Value as Text";
                 if D56DESHIJO<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem."Descripcion Hijo":=D56DESHIJO;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=6) then begin
                 ref:=ExcelBuf."Cell Value as Text";
                 codprod2:=ref;
                 x:=0;
                 codprod:='';
                 repeat
                      x:=x+1;
                      if CopyStr(codprod2,x,1)<>'.' then begin
                           codprod:=codprod+CopyStr(codprod2,x,1);
                      end;
                 until x=StrLen(codprod2);
                 D6REFPADRE:=codprod;
                 if D6REFPADRE<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem."Producto PADRE":=D6REFPADRE;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=7) then begin
                 D7ENVIARAWEB:=ExcelBuf."Cell Value as Text";
                 if D7ENVIARAWEB='S' then begin
                      if RecItem.Get(D1) then begin
                           RecItem."Enviar a web":=true;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=8) then begin
                 D8ACTUALIZAWE:=ExcelBuf."Cell Value as Text";
                 if D8ACTUALIZAWE='S' then begin
                      if RecItem.Get(D1) then begin
                           RecItem."Actualizar WEB":=true;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=9) then begin
                 D9PESOUNI:=ExcelBuf."Cell Value as Text";
                 if D9PESOUNI<>'' then begin
                      if RecItem.Get(D1) then begin
                           Evaluate(peso1,D9PESOUNI);
                           RecItem."Gross Weight":=peso1;
                           RecItem."Net Weight":=peso1;
                           RecItem.Modify;
                      end;
                      RecUMP.Reset;
                      RecUMP.SetRange(RecUMP."Item No.",D1);
                      RecUMP.SetRange(RecUMP.Code,'UDS');
                      if RecUMP.FindFirst then begin
                           Evaluate(peso1,D9PESOUNI);
                           RecUMP.Weight:=peso1;
                           RecUMP.Modify;
        /////                   RecUMP.CalcCubage;
                           ///RecUMP.CalcWeight;
        /////                   RecUMP.MODIFY;
                      end;
                      if not RecUMP.FindFirst then begin
                           RecUMP."Item No.":=D1;
                           RecUMP.Code:='UDS';
                           RecUMP."Qty. per Unit of Measure":=1;
                           Evaluate(peso1,D9PESOUNI);
                           RecUMP.Weight:=peso1;
        /////                   RecUMP.CalcCubage;
                           ///RecUMP.CalcWeight;
                           RecUMP.Insert;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=10) then begin
                 D10LARGOUNI:=ExcelBuf."Cell Value as Text";
                 if D10LARGOUNI<>'' then begin
                      if RecItem.Get(D1) then begin
                           Evaluate(RecItem.Largo,D10LARGOUNI);
                           RecItem.Modify;
                      end;
                      RecUMP.Reset;
                      RecUMP.SetRange(RecUMP."Item No.",D1);
                      RecUMP.SetRange(RecUMP.Code,'UDS');
                      if RecUMP.FindFirst then begin
                           Evaluate(RecUMP.Length,D10LARGOUNI);
                           RecUMP.Validate(RecUMP.Length);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Modify;
                      end;
                      if not RecUMP.FindFirst then begin
                           RecUMP."Item No.":=D1;
                           RecUMP.Code:='UDS';
                           RecUMP."Qty. per Unit of Measure":=1;
                           Evaluate(RecUMP.Length,D10LARGOUNI);
                           RecUMP.Validate(RecUMP.Length);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Insert;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=11) then begin
                 D11ANCHOUNI:=ExcelBuf."Cell Value as Text";
                 if D11ANCHOUNI<>'' then begin
                      if RecItem.Get(D1) then begin
                           Evaluate(RecItem.Ancho,D11ANCHOUNI);
                           RecItem.Modify;
                      end;
                      RecUMP.Reset;
                      RecUMP.SetRange(RecUMP."Item No.",D1);
                      RecUMP.SetRange(RecUMP.Code,'UDS');
                      if RecUMP.FindFirst then begin
                           Evaluate(RecUMP.Width,D11ANCHOUNI);
                           RecUMP.Validate(RecUMP.Width);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Modify;
                      end;
                      if not RecUMP.FindFirst then begin
                           RecUMP."Item No.":=D1;
                           RecUMP.Code:='UDS';
                           RecUMP."Qty. per Unit of Measure":=1;
                           Evaluate(RecUMP.Width,D11ANCHOUNI);
                           RecUMP.Validate(RecUMP.Width);
                           RecUMP.CalcCubage;
        //                   RecUMP.CalcWeight;
                           RecUMP.Insert;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=12) then begin
                 D12ALTOUNI:=ExcelBuf."Cell Value as Text";
                 if D12ALTOUNI<>'' then begin
                      if RecItem.Get(D1) then begin
                           Evaluate(RecItem.Alto,D12ALTOUNI);
                           RecItem.Modify;
                      end;
                      RecUMP.Reset;
                      RecUMP.SetRange(RecUMP."Item No.",D1);
                      RecUMP.SetRange(RecUMP.Code,'UDS');
                      if RecUMP.FindFirst then begin
                           Evaluate(RecUMP.Height,D12ALTOUNI);
                           RecUMP.Validate(RecUMP.Height);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Modify;
                      end;
                      if not RecUMP.FindFirst then begin
                           RecUMP."Item No.":=D1;
                           RecUMP.Code:='UDS';
                           RecUMP."Qty. per Unit of Measure":=1;
                           Evaluate(RecUMP.Height,D12ALTOUNI);
                           RecUMP.Validate(RecUMP.Height);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Insert;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=13) then begin
                 D13MARCA:=ExcelBuf."Cell Value as Text";
                 if D13MARCA<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem.Marca:=D13MARCA;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=14) then begin
                 D14CODPROPROVEE:=ExcelBuf."Cell Value as Text";
                 if D14CODPROPROVEE<>'' then begin
                      if RecItem.Get(D1) then begin
                      codprod2:=D14CODPROPROVEE;
                      x:=0;
                      codprod:='';
                      repeat
                           x:=x+1;
                           if CopyStr(codprod2,x,1)<>'.' then begin
                                codprod:=codprod+CopyStr(codprod2,x,1);
                           end;
                      until x=StrLen(codprod2);
                      D14CODPROPROVEE:=codprod;
                           RecItem."Vendor Item No.":=D14CODPROPROVEE;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=15) then begin
                 ref:=ExcelBuf."Cell Value as Text";
                 codprod2:=ref;
                 x:=0;
                 codprod:='';
                 repeat
                      x:=x+1;
                      if CopyStr(codprod2,x,1)<>'.' then begin
                           codprod:=codprod+CopyStr(codprod2,x,1);
                      end;
                 until x=StrLen(codprod2);
                 D15EAN:=codprod;
                 if D15EAN<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem.Validate(RecItem.ean,D15EAN);
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=16) then begin
                 D16TIPOVENTA:=ExcelBuf."Cell Value as Text";
                 if D16TIPOVENTA<>'' then begin
                      if RecItem.Get(D1) then begin
                         ///  :=D16TIPOVENTA
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=17) then begin
                 ref:=ExcelBuf."Cell Value as Text";
                 codprod2:=ref;
                 x:=0;
                 codprod:='';
                 repeat
                      x:=x+1;
                      if CopyStr(codprod2,x,1)<>'.' then begin
                           codprod:=codprod+CopyStr(codprod2,x,1);
                      end;
                 until x=StrLen(codprod2);
                 D17CODVENTA:=codprod;
                 if D17CODVENTA<>'' then begin
                      if RecItem.Get(D1) then begin
                      ///     RecItem.MODIFY;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=18) then begin
                 D18PRECIOTAR:=ExcelBuf."Cell Value as Text";
                 if D18PRECIOTAR<>'' then begin
                      RecSP.Reset;
                      RecSP.SetRange(RecSP."Sales Type",1);
                      RecSP.SetRange(RecSP."Sales Code",D17CODVENTA);
                      RecSP.SetRange(RecSP."Item No.",D1);
                      if RecSP.FindFirst then begin
                           Evaluate(RecSP."Unit Price",D18PRECIOTAR);
                           RecSP.Modify;
                      end;
                      if not RecSP.FindFirst then begin
                           RecSP."Item No.":=D1;
                           RecSP."Sales Type":=1;
                           RecSP."Sales Code":=D17CODVENTA;
                           Evaluate(RecSP."Unit Price",D18PRECIOTAR);
                           RecSP.Insert;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=19) then begin
                 D19PVPR:=ExcelBuf."Cell Value as Text";
                 if D19PVPR<>'' then begin
                      RecSP.Reset;
                      RecSP.SetRange(RecSP."Sales Type",1);
                      RecSP.SetRange(RecSP."Sales Code",D17CODVENTA);
                      RecSP.SetRange(RecSP."Item No.",D1);
                      if RecSP.FindFirst then begin
                           Evaluate(RecSP."Precio recomendado",D19PVPR);
                           RecSP.Modify;
                      end;
                      if not RecSP.FindFirst then begin
                           RecSP."Item No.":=D1;
                           RecSP."Sales Type":=1;
                           RecSP."Sales Code":=D17CODVENTA;
                           Evaluate(RecSP."Precio recomendado",D19PVPR);
                           RecSP.Insert;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=20) then begin
                 D20COLCHONWEB:=ExcelBuf."Cell Value as Text";
                 if D20COLCHONWEB<>'' then begin
                      if RecItem.Get(D1) then begin
                           Evaluate(RecItem."Cantidad colchon web",D20COLCHONWEB);
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=21) then begin
                 D21ESTADO:=UpperCase(ExcelBuf."Cell Value as Text");
                 if D21ESTADO<>'' then begin
                      if RecItem.Get(D1) then begin
                           if CopyStr(D21ESTADO,1,1)='A' then RecItem."Estado Producto":=0;
                           if CopyStr(D21ESTADO,1,1)='D' then RecItem."Estado Producto":=1;
                           if CopyStr(D21ESTADO,1,2)='AN' then RecItem."Estado Producto":=2;
                           if CopyStr(D21ESTADO,1,1)='S' then RecItem."Estado Producto":=3;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=22) then begin
                 D22COSTEUNIDIC:=ExcelBuf."Cell Value as Text";
                 if D22COSTEUNIDIC<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=23) then begin
                 D23DTOPROVEE:=ExcelBuf."Cell Value as Text";
                 if D23DTOPROVEE<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=24) then begin
                 D24GRIVAPROD:=ExcelBuf."Cell Value as Text";
                 if D24GRIVAPROD<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem."VAT Prod. Posting Group":=D24GRIVAPROD;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=25) then begin
                 D25LINEA:=ExcelBuf."Cell Value as Text";
                 if D25LINEA<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem."Gen. Prod. Posting Group":=D25LINEA;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=26) then begin
                 D26FAMILIA:=ExcelBuf."Cell Value as Text";
                 if D26FAMILIA<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem.Familia:=D26FAMILIA;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=27) then begin
                 D27SUBFAMILIA:=ExcelBuf."Cell Value as Text";
                 if D27SUBFAMILIA<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem.Subfamilia:=D27SUBFAMILIA;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=28) then begin
                 D28ROTA:=ExcelBuf."Cell Value as Text";
                 if D28ROTA<>'' then begin
                      if RecItem.Get(D1) then begin
                           if D28ROTA='FC' then RecItem."Criterio rotación":=0;
                           if D28ROTA='FE' then RecItem."Criterio rotación":=1;
                           if D28ROTA='FF' then RecItem."Criterio rotación":=2;
                           if D28ROTA='LO' then RecItem."Criterio rotación":=3;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=29) then begin
                 D29TIPOPROD:=ExcelBuf."Cell Value as Text";
                 if D29TIPOPROD<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=30) then begin
                 D30TIPOPALETS:=ExcelBuf."Cell Value as Text";
                 if D30TIPOPALETS<>'' then begin
                      if RecItem.Get(D1) then begin
                           /////RecItem."Tipo palet":=D30TIPOPALETS;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=31) then begin
                 D31UMB:=ExcelBuf."Cell Value as Text";
                 if D31UMB<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem."Base Unit of Measure":=D31UMB;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=32) then begin
                 D32CDADINNER:=ExcelBuf."Cell Value as Text";
                 if D32CDADINNER<>'' then begin
                      if RecItem.Get(D1) then begin
                           Evaluate(RecItem."Cantidad inner",D32CDADINNER);
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=33) then begin
                 D33PESOIN:=ExcelBuf."Cell Value as Text";
                 if D33PESOIN<>'' then begin
                      RecUMP.Reset;
                      RecUMP.SetRange(RecUMP."Item No.",D1);
                      RecUMP.SetRange(RecUMP.Code,'IN');
                      if RecUMP.FindFirst then begin
                           Evaluate(RecUMP.Weight,D33PESOIN);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Modify;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                      if not RecUMP.FindFirst then begin
                           RecUMP."Item No.":=D1;
                           RecUMP.Code:='IN';
                           if D32CDADINNER<>'' then begin
                                Evaluate(RecUMP."Qty. per Unit of Measure",D32CDADINNER);
                           end;
                           Evaluate(RecUMP.Weight,D33PESOIN);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Insert;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=34) then begin
                 D34LARGOIN:=ExcelBuf."Cell Value as Text";
                 if D34LARGOIN<>'' then begin
                      if RecItem.Get(D1) then begin
                           Evaluate(RecItem."Largo INNER",D34LARGOIN);
                           RecItem.Modify;
                      end;
                      RecUMP.Reset;
                      RecUMP.SetRange(RecUMP."Item No.",D1);
                      RecUMP.SetRange(RecUMP.Code,'IN');
                      if RecUMP.FindFirst then begin
                           Evaluate(RecUMP.Length,D34LARGOIN);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Modify;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                      if not RecUMP.FindFirst then begin
                           RecUMP."Item No.":=D1;
                           RecUMP.Code:='IN';
                           if D32CDADINNER<>'' then begin
                                Evaluate(RecUMP."Qty. per Unit of Measure",D32CDADINNER);
                           end;
                           Evaluate(RecUMP.Length,D34LARGOIN);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Insert;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=35) then begin
                 D35ANCHOIN:=ExcelBuf."Cell Value as Text";
                 if D35ANCHOIN<>'' then begin
                      if RecItem.Get(D1) then begin
                           Evaluate(RecItem."Ancho INNER",D35ANCHOIN);
                           RecItem.Modify;
                      end;
                      RecUMP.Reset;
                      RecUMP.SetRange(RecUMP."Item No.",D1);
                      RecUMP.SetRange(RecUMP.Code,'IN');
                      if RecUMP.FindFirst then begin
                           Evaluate(RecUMP.Width,D35ANCHOIN);
                           RecUMP.CalcCubage;
        ////                   RecUMP.CalcWeight;
                           RecUMP.Modify;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                      if not RecUMP.FindFirst then begin
                           RecUMP."Item No.":=D1;
                           RecUMP.Code:='IN';
                           if D32CDADINNER<>'' then begin
                                Evaluate(RecUMP."Qty. per Unit of Measure",D32CDADINNER);
                           end;
                           Evaluate(RecUMP.Width,D35ANCHOIN);
                           RecUMP.CalcCubage;
        /////                   RecUMP.CalcWeight;
                           RecUMP.Insert;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=36) then begin
                 D36ALTOIN:=ExcelBuf."Cell Value as Text";
                 if D36ALTOIN<>'' then begin
                      if RecItem.Get(D1) then begin
                           Evaluate(RecItem."Alto INNER",D36ALTOIN);
                           RecItem.Modify;
                      end;
                      RecUMP.Reset;
                      RecUMP.SetRange(RecUMP."Item No.",D1);
                      RecUMP.SetRange(RecUMP.Code,'IN');
                      if RecUMP.FindFirst then begin
                           Evaluate(RecUMP.Height,D36ALTOIN);
                           RecUMP.CalcCubage;
        /////                   RecUMP.CalcWeight;
                           RecUMP.Modify;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                      if not RecUMP.FindFirst then begin
                           RecUMP."Item No.":=D1;
                           RecUMP.Code:='IN';
                           if D32CDADINNER<>'' then begin
                                Evaluate(RecUMP."Qty. per Unit of Measure",D32CDADINNER);
                           end;
                           Evaluate(RecUMP.Height,D36ALTOIN);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Insert;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=37) then begin
                 D37CDADAMSTER:=ExcelBuf."Cell Value as Text";
                 if D37CDADAMSTER<>'' then begin
                      if RecItem.Get(D1) then begin
                           Evaluate(RecItem."Cantidad master",D37CDADAMSTER);
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=38) then begin
                 D38PESOMAS:=ExcelBuf."Cell Value as Text";
                 if D38PESOMAS<>'' then begin
                      RecUMP.Reset;
                      RecUMP.SetRange(RecUMP."Item No.",D1);
                      RecUMP.SetRange(RecUMP.Code,'MA');
                      if RecUMP.FindFirst then begin
                           Evaluate(RecUMP.Weight,D38PESOMAS);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Modify;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                      if not RecUMP.FindFirst then begin
                           RecUMP."Item No.":=D1;
                           RecUMP.Code:='MA';
                           if D37CDADAMSTER<>'' then begin
                                Evaluate(RecUMP."Qty. per Unit of Measure",D37CDADAMSTER);
                           end;
                           Evaluate(RecUMP.Weight,D38PESOMAS);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Insert;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=39) then begin
                 D39LARGOMAS:=ExcelBuf."Cell Value as Text";
                 if D39LARGOMAS<>'' then begin
                      if RecItem.Get(D1) then begin
                           Evaluate(RecItem."Largo master",D39LARGOMAS);
                           RecItem.Modify;
                      end;
                      RecUMP.Reset;
                      RecUMP.SetRange(RecUMP."Item No.",D1);
                      RecUMP.SetRange(RecUMP.Code,'MA');
                      if RecUMP.FindFirst then begin
                           Evaluate(RecUMP.Length,D39LARGOMAS);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Modify;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                      if not RecUMP.FindFirst then begin
                           RecUMP."Item No.":=D1;
                           RecUMP.Code:='MA';
                           if D37CDADAMSTER<>'' then begin
                                Evaluate(RecUMP."Qty. per Unit of Measure",D37CDADAMSTER);
                           end;
                           Evaluate(RecUMP.Length,D39LARGOMAS);
                           RecUMP.CalcCubage;
        ////                   RecUMP.CalcWeight;
                           RecUMP.Insert;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=40) then begin
                 D40ANCHOMAS:=ExcelBuf."Cell Value as Text";
                 if D40ANCHOMAS<>'' then begin
                      if RecItem.Get(D1) then begin
                           Evaluate(RecItem."Ancho master",D40ANCHOMAS);
                           RecItem.Modify;
                      end;
                      RecUMP.Reset;
                      RecUMP.SetRange(RecUMP."Item No.",D1);
                      RecUMP.SetRange(RecUMP.Code,'MA');
                      if RecUMP.FindFirst then begin
                           Evaluate(RecUMP.Width,D40ANCHOMAS);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Modify;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                      if not RecUMP.FindFirst then begin
                           RecUMP."Item No.":=D1;
                           RecUMP.Code:='MA';
                           if D37CDADAMSTER<>'' then begin
                                Evaluate(RecUMP."Qty. per Unit of Measure",D37CDADAMSTER);
                           end;
                           Evaluate(RecUMP.Width,D40ANCHOMAS);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Insert;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=41) then begin
                 D41ALTOMAS:=ExcelBuf."Cell Value as Text";
                 if D41ALTOMAS<>'' then begin
                      if RecItem.Get(D1) then begin
                           Evaluate(RecItem."Alto master",D41ALTOMAS);
                           RecItem.Modify;
                      end;
                      RecUMP.Reset;
                      RecUMP.SetRange(RecUMP."Item No.",D1);
                      RecUMP.SetRange(RecUMP.Code,'MA');
                      if RecUMP.FindFirst then begin
                           Evaluate(RecUMP.Height,D41ALTOMAS);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Modify;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                      if not RecUMP.FindFirst then begin
                           RecUMP."Item No.":=D1;
                           RecUMP.Code:='MA';
                           if D37CDADAMSTER<>'' then begin
                                Evaluate(RecUMP."Qty. per Unit of Measure",D37CDADAMSTER);
                           end;
                           Evaluate(RecUMP.Height,D41ALTOMAS);
                           RecUMP.CalcCubage;
        ///                   RecUMP.CalcWeight;
                           RecUMP.Insert;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=42) then begin
                 D42UNIMEDCOMP:=ExcelBuf."Cell Value as Text";
                 if D42UNIMEDCOMP<>'' then begin
                      if RecItem.Get(D1) then begin
                           Evaluate(RecItem."Unidad compra",D42UNIMEDCOMP);
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=43) then begin
                 D43DIMHUEOC:=ExcelBuf."Cell Value as Text";
                 if D43DIMHUEOC<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem."Dimensión hueco":=CopyStr(D43DIMHUEOC,1,10);
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=44) then begin
                 D44GRUPOCONTABLE:=ExcelBuf."Cell Value as Text";
                 if D44GRUPOCONTABLE<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem."Inventory Posting Group":=D44GRUPOCONTABLE;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=45) then begin
                 D45UNIMEDVENTA:=ExcelBuf."Cell Value as Text";
                 if D45UNIMEDVENTA<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem."Sales Unit of Measure":=D45UNIMEDVENTA;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=46) then begin
                 D46UNIDADESNTA:=ExcelBuf."Cell Value as Text";
                 if D46UNIDADESNTA<>'' then begin
                      if RecItem.Get(D1) then begin
                           Evaluate(RecItem."Unidades venta",D46UNIDADESNTA);
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=47) then begin
                 D47PERMITFRAC:=ExcelBuf."Cell Value as Text";
                 if D47PERMITFRAC<>'' then begin
                      if RecItem.Get(D1) then begin
                           if UpperCase(D47PERMITFRAC)='N' then begin
                                RecItem."Permite fraccionar venta":=false;
                                RecItem.Modify;
                           end;
                           if UpperCase(D47PERMITFRAC)='S' then begin
                                RecItem."Permite fraccionar venta":=true;
                                RecItem.Modify;
                           end;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=48) then begin
                 D48ZONAALMA:=ExcelBuf."Cell Value as Text";
                 if D48ZONAALMA<>'' then begin
                      if RecItem.Get(D1) then begin
                           if D48ZONAALMA='GRAL' then RecItem."Zona almacenaje":=0;
                           if D48ZONAALMA='CAO' then RecItem."Zona almacenaje":=1;
                           if D48ZONAALMA='NCF' then RecItem."Zona almacenaje":=2;
                           if D48ZONAALMA='MUR' then RecItem."Zona almacenaje":=3;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=49) then begin
                 D49ZONAPICK:=ExcelBuf."Cell Value as Text";
                 if D49ZONAPICK<>'' then begin
                      if RecItem.Get(D1) then begin
                           ///RecItem."Zona picking":=D49ZONAPICK;
                           if D49ZONAPICK='GRAL' then RecItem."Zona picking":=0;
                           if D49ZONAPICK='CAO' then RecItem."Zona picking":=1;
                           if D49ZONAPICK='NCF' then RecItem."Zona picking":=2;
                           if D49ZONAPICK='MUR' then RecItem."Zona picking":=3;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=50) then begin
                 D50PRODALMA:=ExcelBuf."Cell Value as Text";
                 if D50PRODALMA<>'' then begin
                      if RecItem.Get(D1) then begin
                           if UpperCase(D50PRODALMA)='N' then begin
                                RecItem."Producto almacenable":=false;
                                RecItem.Modify;
                           end;
                           if UpperCase(D50PRODALMA)='S' then begin
                                RecItem."Producto almacenable":=true;
                                RecItem.Modify;
                           end;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=51) then begin
                 D51ODPROVEE:=ExcelBuf."Cell Value as Text";
                 if D51ODPROVEE<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem."Vendor No.":=D51ODPROVEE;
                           RecItem.Modify;
                           RecPC.Reset;
                           RecPC.SetRange(RecPC."Item No.",D1);
                           RecPC.SetRange(RecPC."Vendor No.",D51ODPROVEE);
                           if RecPC.FindFirst then begin
                                if D22COSTEUNIDIC<>'' then begin
                                     Evaluate(RecPC."Precio Tarifa",D22COSTEUNIDIC);
                                     Evaluate(RecPC."Direct Unit Cost",D22COSTEUNIDIC);
                                end;
                                RecPC.Modify;
                           end;
                           if not RecPC.FindFirst then begin
                                RecPC."Item No.":=D1;
                                RecPC.Validate(RecPC."Vendor No.",D51ODPROVEE);
                                if D22COSTEUNIDIC<>'' then begin
                                     Evaluate(RecPC."Precio Tarifa",D22COSTEUNIDIC);
                                     Evaluate(RecPC."Direct Unit Cost",D22COSTEUNIDIC);
                                end;
                                RecPC.Insert;
                           end;
                           RecTCP.Reset;
                           RecTCP.SetRange(RecTCP."Vendor No.",D51ODPROVEE);
                           RecTCP.SetRange(RecTCP."Item No.",D1);
                           if RecTCP.FindFirst then begin
                                RecTCP."Vendor Item No.":=D14CODPROPROVEE;
                                RecTCP.Modify;
                           end;
                           if not RecTCP.FindFirst then begin
                                RecTCP."Vendor No.":=D51ODPROVEE;
                                RecTCP."Item No.":=D1;
                                RecTCP."Vendor Item No.":=D14CODPROPROVEE;
                                RecTCP.Insert;
                           end;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=52) then begin
                 ref:=ExcelBuf."Cell Value as Text";
                 codprod2:=ref;
                 x:=0;
                 codprod:='';
                 repeat
                      x:=x+1;
                      if CopyStr(codprod2,x,1)<>'.' then begin
                           codprod:=codprod+CopyStr(codprod2,x,1);
                      end;
                 until x=StrLen(codprod2);
                 D52EANINNE:=codprod;
                 if D52EANINNE<>'' then begin
                      RecUMP.Reset;
                      RecUMP.SetRange(RecUMP."Item No.",D1);
                      RecUMP.SetRange(RecUMP.Code,'IN');
                      if RecUMP.FindFirst then begin
                           RecUMP.Validate(ean,D52EANINNE);
                           RecUMP.Modify;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                      if not RecUMP.FindFirst then begin
                           RecUMP."Item No.":=D1;
                           RecUMP.Code:='IN';
                           if D32CDADINNER<>'' then begin
                                Evaluate(RecUMP."Qty. per Unit of Measure",D32CDADINNER);
                           end;
                           RecUMP.Validate(ean,D52EANINNE);
                           RecUMP.Insert;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=53) then begin
                 ref:=ExcelBuf."Cell Value as Text";
                 codprod2:=ref;
                 x:=0;
                 codprod:='';
                 repeat
                      x:=x+1;
                      if CopyStr(codprod2,x,1)<>'.' then begin
                           codprod:=codprod+CopyStr(codprod2,x,1);
                      end;
                 until x=StrLen(codprod2);
                 D53EANMAS:=codprod;
                 if D53EANMAS<>'' then begin
                      RecUMP.Reset;
                      RecUMP.SetRange(RecUMP."Item No.",D1);
                      RecUMP.SetRange(RecUMP.Code,'MA');
                      if RecUMP.FindFirst then begin
                           RecUMP.Validate(ean,D53EANMAS);
                           RecUMP.Modify;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                      if not RecUMP.FindFirst then begin
                           RecUMP."Item No.":=D1;
                           RecUMP.Code:='MA';
                           if D37CDADAMSTER<>'' then begin
                                Evaluate(RecUMP."Qty. per Unit of Measure",D37CDADAMSTER);
                           end;
                           RecUMP.Validate(ean,D53EANMAS);
                           RecUMP.Insert;
                           RecItem22.Get(D1);
                           CUADAIA.MODIFPROD(RecItem22);
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=54) then begin
                 tariff:=ExcelBuf."Cell Value as Text";
                 if tariff<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem."Tariff No.":=tariff;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=55) then begin
                 igicc:=ExcelBuf."Cell Value as Text";
                 if igicc<>'' then begin
                      if RecItem.Get(D1) then begin
                           RecItem."IVA IGIC":=igicc;
                           RecItem.Modify;
                      end;
                 end;
            end;
        end;
          until ExcelBuf.Next = 0;
        end;
        TempDim.SetRange("Code Caption");
        TempDim.MarkedOnly(true);
        if TempDim.Find('-') then begin
        end;
        Window.Close;
    end;


    procedure GrabaArti()
    begin
        if RecItem.Get(ref) then begin
             RecItem."Descripcion web":=DESCRIPWEB;
             RecItem.Modify;
        end;
    end;
}

