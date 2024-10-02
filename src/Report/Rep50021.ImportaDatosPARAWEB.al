#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50021 "_Importa Datos PARA WEB"
{
    Caption = 'Importa Datos PARA WEB';
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
        RecSP: Record UnknownRecord50021;
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
                 ref:=codprod;
            end;
            if (ExcelBuf."Column No."=2) then begin
                 DESCRIPWEB:=ExcelBuf."Cell Value as Text";
                 if DESCRIPWEB<>'' then begin
                      if RecItem.Get(ref) then begin
                           RecItem."Descripcion Hijo":=DESCRIPWEB;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=3) then begin
                 DESCRIPWEB:=ExcelBuf."Cell Value as Text";
                 if DESCRIPWEB<>'' then begin
                      if RecItem.Get(ref) then begin
                           RecItem."Descripcion web":=DESCRIPWEB;
                           RecItem.Modify;
                      end;
                 end;
            end;
            if (ExcelBuf."Column No."=4) then begin
                     CODHIJO:=ExcelBuf."Cell Value as Text";
                     codprod2:=CODHIJO;
                     x:=0;
                     codprod:='';
                     repeat
                           x:=x+1;
                           if CopyStr(codprod2,x,1)<>'.' then begin
                                codprod:=codprod+CopyStr(codprod2,x,1);
                           end;
                      until x=StrLen(codprod2);
                      CODHIJO:=codprod;
                     if (CODHIJO<>'') and (ref<>'') then begin
                          if RecItem.Get(ref) then begin
                               RecItem."Producto PADRE":=CODHIJO;
                               RecItem.Modify;
                          end;
                     end;
            end;
            if (ExcelBuf."Column No."=5) then begin
                 CODREPUES:=ExcelBuf."Cell Value as Text";
                     codprod2:=CODREPUES;
                     x:=0;
                     codprod:='';
                     repeat
                           x:=x+1;
                           if CopyStr(codprod2,x,1)<>'.' then begin
                                codprod:=codprod+CopyStr(codprod2,x,1);
                           end;
                      until x=StrLen(codprod2);
                      CODREPUES:=codprod;
                 if CODREPUES<>'' then begin
                      RecMt2.Reset;
                      RecMt2.SetRange(RecMt2.Tabla,4);
                      RecMt2.SetRange(RecMt2."Código 1",ref);
                      RecMt2.SetRange(RecMt2."Código 2",CODREPUES);
                      if not RecMt2.FindFirst then begin
                           RecMt2.Init;
                           RecMt2.Tabla:=4;
                           RecMt2."Código 1":=ref;
                           RecMt2."Código 2":=CODREPUES;
                           if RecItem.Get(CODREPUES) then begin
                                RecMt2."Descripcion tecnica":=RecItem.Description;
                           end;
                           RecMt2.Insert;
                      end;
                 end;
        /////         4
            end;
            if (ExcelBuf."Column No."=6) then begin
                 CODRELACI:=ExcelBuf."Cell Value as Text";
                     codprod2:=CODRELACI;
                     x:=0;
                     codprod:='';
                     repeat
                           x:=x+1;
                           if CopyStr(codprod2,x,1)<>'.' then begin
                                codprod:=codprod+CopyStr(codprod2,x,1);
                           end;
                      until x=StrLen(codprod2);
                      CODRELACI:=codprod;
                 if CODRELACI<>'' then begin
                 RecMt2.Reset;
                 RecMt2.SetRange(RecMt2.Tabla,5);
                 RecMt2.SetRange(RecMt2."Código 1",ref);
                 RecMt2.SetRange(RecMt2."Código 2",CODRELACI);
                 if not RecMt2.FindFirst then begin
                      RecMt2.Init;
                      RecMt2.Tabla:=5;
                      RecMt2."Código 1":=ref;
                      RecMt2."Código 2":=CODRELACI;
                      if RecItem.Get(CODRELACI) then begin
                           RecMt2."Descripcion tecnica":=RecItem.Description;
                      end;
                      RecMt2.Insert;
                      end;
                 end;
        ///         5
            end;
            if (ExcelBuf."Column No."=7) then begin
                 DESTEC:=ExcelBuf."Cell Value as Text";
                 if DESTEC<>'' then begin
                 RecMt2.Reset;
                 RecMt2.SetRange(RecMt2.Tabla,5);
                 RecMt2.SetRange(RecMt2."Código 1",ref);
                 RecMt2.SetRange(RecMt2."Código 2",CopyStr(DESTEC,1,20));
                 if not RecMt2.FindFirst then begin
                      RecMt2.Init;
                      RecMt2.Tabla:=5;
                      RecMt2."Código 1":=ref;
                      RecMt2."Código 2":=CopyStr(DESTEC,1,20);
                      RecMt2."Descripcion tecnica":=DESTEC;
                      RecMt2.Insert;
                 end;
                 end;
            end;
            if (ExcelBuf."Column No."=8) then begin
                 enviaraweb:=ExcelBuf."Cell Value as Text";
                 if enviaraweb='S' then begin
                      if RecItem.Get(ref) then begin
                           RecItem."Enviar a web":=true;
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

