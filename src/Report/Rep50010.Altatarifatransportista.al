#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50010 "_Alta tarifa transportista"
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
        Rec1: Record UnknownRecord50022;
        codtra: Code[20];
        codzona: Code[20];
        hastapesoC: Code[20];
        imptarC: Code[20];
        hastapeso: Decimal;
        imptar: Decimal;
        cod: Integer;
        Rec11: Record UnknownRecord50022;

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
                 codtra:=ExcelBuf."Cell Value as Text";
            end;
            if (ExcelBuf."Column No."=2) then begin
                 codzona:=ExcelBuf."Cell Value as Text";
            end;
            if (ExcelBuf."Column No."=3) then begin
                 hastapesoC:=ExcelBuf."Cell Value as Text";
                 Evaluate(hastapeso,hastapesoC);
            end;
            if (ExcelBuf."Column No."=4) then begin
                 imptarC:=ExcelBuf."Cell Value as Text";
                 Evaluate(imptar,imptarC);
                 Graba;
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


    procedure Graba()
    begin
        ///Tabla,Zona,Zona transportistas,Codigo
        Rec1.Reset;
        Rec1.SetRange(Rec1.Tabla,0);
        Rec1.SetRange(Rec1.Zona,codzona);
        if not Rec1.FindFirst then begin
             Rec1.Init;
             Rec1.Tabla:=0;
             Rec1.Zona:=codzona;
             Rec1.Insert;
        end;
        Rec1.Reset;
        Rec1.SetRange(Rec1.Tabla,1);
        Rec1.SetRange(Rec1."Zona transportistas",codzona);
        Rec1.SetRange(Rec1.Transportista,codtra);
        if not Rec1.FindFirst then begin
             Rec1.Init;
             Rec1.Tabla:=1;
             Rec1."Zona transportistas":=codzona;
             Rec1.Transportista:=codtra;
             Rec1.Insert;
        end;
        Rec1.Reset;
        Rec1.SetRange(Rec1.Tabla,3);
        Rec1.SetRange(Rec1."Zona tarifa",codzona);
        Rec1.SetRange(Rec1."Transportista tarifa",codtra);
        Rec1.SetRange(Rec1."Hasta Kilos",hastapeso);
        if Rec1.FindFirst then begin
             Rec1.Precio:=imptar;
             Rec1.Modify;
        end;
        if not Rec1.FindFirst then begin
        cod:=1;
        Rec11.Reset;
        Rec11.SetRange(Rec11.Tabla,3);
        if Rec11.FindLast then begin
             cod:=Rec11.Codigo;
        end;
             Rec1.Init;
             Rec1.Tabla:=3;
             Rec1."Zona tarifa":=codzona;
             Rec1."Transportista tarifa":=codtra;
             Rec1."Hasta Kilos":=hastapeso;
             Rec1.Precio:=imptar;
             cod:=cod+1;
             Rec1.Codigo:=cod;
             Rec1.Insert;
        end;
    end;
}

