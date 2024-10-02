#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50092 "_Importa Textos adicionales EC"
{
    Caption = 'Importa Excel';
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
                if RecNo > 0 then
                  Message(Text004,GLBudgetEntry.TableCaption,RecNo);
                if (ImportOption = Importoption::"Replace entries") then begin
                  AnalysisView.SetRange("Include Budgets",true);
                  if AnalysisView.FindSet(true,false) then
                    repeat
                      AnalysisView.AnalysisviewBudgetReset;
                      AnalysisView.Modify;
                    until AnalysisView.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                RecNo := 0;
                /*GLBudgetName.SETRANGE(Name,ToGLBudgetName);
                IF NOT GLBudgetName.FIND('-') THEN BEGIN
                  IF NOT CONFIRM(
                    Text001,FALSE,GLBudgetName.TABLECAPTION,ToGLBudgetName)
                  THEN
                    CurrReport.BREAK;
                  GLBudgetName.Name := ToGLBudgetName;
                  GLBudgetName.INSERT;
                END ELSE BEGIN
                  IF GLBudgetName.Blocked THEN BEGIN
                    MESSAGE(Text002,
                      GLBudgetEntry.FIELDCAPTION("Budget Name"),ToGLBudgetName);
                    CurrReport.BREAK;
                  END;
                  IF NOT CONFIRM(Text003,FALSE,
                    LOWERCASE(FORMAT(SELECTSTR(ImportOption + 1,Text027))),
                    GLBudgetEntry.FIELDCAPTION("Budget Name"),ToGLBudgetName) THEN
                    CurrReport.BREAK;
                END;
                IF GLBudgetEntry3.FIND('+') THEN
                  EntryNo := GLBudgetEntry3."Entry No." + 1
                ELSE
                  EntryNo := 1;
                LastEntryNoBeforeImport := GLBudgetEntry3."Entry No.";
                */

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
        BudgetBuf.DeleteAll;
    end;

    trigger OnPreReport()
    begin
        /*
        IF Dim.FIND('-') THEN BEGIN
          REPEAT
            TempDim.INIT;
            TempDim := Dim;
            TempDim."Code Caption" := UPPERCASE(TempDim."Code Caption");
            TempDim.INSERT;
          UNTIL Dim.NEXT = 0;
        END;
        IF DimVal.FIND('-') THEN BEGIN
          REPEAT
            TempDimVal.INIT;
            TempDimVal := DimVal;
            TempDimVal.INSERT;
          UNTIL DimVal.NEXT = 0;
        END;
        IF GLAcc.FIND('-') THEN BEGIN
          REPEAT
            TempGLAcc.INIT;
            TempGLAcc := GLAcc;
            TempGLAcc.INSERT;
          UNTIL GLAcc.NEXT = 0;
        END;
        */
        ExcelBuf.LockTable;
        BudgetBuf.LockTable;
        GLBudgetEntry.SetRange("Budget Name",ToGLBudgetName);
        if not GLBudgetName.Get(ToGLBudgetName) then
          Clear(GLBudgetName);
        GLSetup.Get;
        GlobalDim1Code := GLSetup."Global Dimension 1 Code";
        GlobalDim2Code := GLSetup."Global Dimension 2 Code";
        BudgetDim1Code := GLBudgetName."Budget Dimension 1 Code";
        BudgetDim2Code := GLBudgetName."Budget Dimension 2 Code";
        BudgetDim3Code := GLBudgetName."Budget Dimension 3 Code";
        BudgetDim4Code := GLBudgetName."Budget Dimension 4 Code";
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
        RecLT: Record "Extended Text Line";
        RecCT: Record "Extended Text Header";
        prod: Code[20];
        texto: Text[50];
        codprod: Code[20];
        LIN: Integer;
        RecTP: Record "Item Translation";
        CODIGO: Code[10];
        codprod2: Code[20];
        x: Integer;

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
        BudgetBuf.DeleteAll;
        if ExcelBuf.Find('-') then begin
          repeat
            RecNo := RecNo + 1;
            Window.Update(1,ROUND(RecNo / TotalRecNo * 10000,1));
        ///     TempDim.SETRANGE("Code Caption",UPPERCASE(FormatData(ExcelBuf."Cell Value as Text")));
                 ///MESSAGE('%1 %2 %3 ',ExcelBuf."Row No.",ExcelBuf."Column No.",ExcelBuf."Cell Value as Text");
            if (ExcelBuf."Column No."=1) then begin
                 codprod2:=ExcelBuf."Cell Value as Text";
                 x:=0;
                 codprod:='';
                 repeat
                      x:=x+1;
                      if CopyStr(codprod2,x,1)<>'.' then begin
                           codprod:=codprod+CopyStr(codprod2,x,1);
                      end;
                 until x=StrLen(codprod2);
                  RecLT.Reset;
                  RecLT.SetRange(RecLT."Table Name",5);
                  RecLT.SetRange(RecLT."No.",codprod);
                  if RecLT.FindFirst then repeat
                       RecLT.Delete;
                  until RecLT.Next=0;
            end;
            if (ExcelBuf."Column No."=2) then begin
                 texto:=ExcelBuf."Cell Value as Text";
                 Graba;
            end;
          until ExcelBuf.Next = 0;
        end;
        TempDim.SetRange("Code Caption");
        TempDim.MarkedOnly(true);
        if TempDim.Find('-') then begin
        ///  Dim.GET(TempDim.Code);
        ///  ERROR(Text028,Dim."Code Caption");
        end;
        Window.Close;
        /*
        TempExcelBuf.RESET;
        TempExcelBuf.SETRANGE(Comment,Text010);
        IF NOT TempExcelBuf.FIND('-') THEN
        ///  ERROR(Text025);
        TempExcelBuf.SETRANGE(Comment,Text014);
        IF NOT TempExcelBuf.FIND('-') THEN
          ERROR(Text026);
         */

    end;

    local procedure InsertGLBudgetDim(DimCode2: Code[20];DimValCode2: Code[20];var GLBudgetEntry2: Record "G/L Budget Entry")
    begin
        GLBudgetDim.Init;
        GLBudgetDim."Entry No." := GLBudgetEntry2."Entry No.";
        GLBudgetDim.Validate("Dimension Code",DimCode2);
        GLBudgetDim.Validate("Dimension Value Code",DimValCode2);
        GLBudgetDim.Insert;
        case DimCode2 of
          GlobalDim1Code: GLBudgetEntry2."Global Dimension 1 Code" := DimValCode2;
          GlobalDim2Code: GLBudgetEntry2."Global Dimension 2 Code" := DimValCode2;
          BudgetDim1Code: GLBudgetEntry2."Budget Dimension 1 Code" := DimValCode2;
          BudgetDim2Code: GLBudgetEntry2."Budget Dimension 2 Code" := DimValCode2;
          BudgetDim3Code: GLBudgetEntry2."Budget Dimension 3 Code" := DimValCode2;
          BudgetDim4Code: GLBudgetEntry2."Budget Dimension 4 Code" := DimValCode2;
        end;
    end;

    local procedure FormatData(TextToFormat: Text[250]): Text[250]
    var
        FormatInteger: Integer;
        FormatDecimal: Decimal;
        FormatDate: Date;
    begin
        case true of
          Evaluate(FormatInteger,TextToFormat):
            exit(Format(FormatInteger));
          Evaluate(FormatDecimal,TextToFormat):
            exit(Format(FormatDecimal));
          Evaluate(FormatDate,TextToFormat):
            exit(Format(FormatDate));
          else
            exit(TextToFormat);
        end;
    end;


    procedure SetGLBudgetName(NewToGLBudgetName: Code[10])
    begin
        ToGLBudgetName := NewToGLBudgetName;
    end;


    procedure Graba()
    begin
        ///MESSAGE('%1',codprod);
        if prod<>'' then begin
             codprod:=prod;
        end;
        LIN:=LIN+1;
        if (prod='') then begin
             if not RecCT.Get(5,codprod,'',1) then begin
                  RecCT.Init;
                  RecCT."Table Name":=5;
                  RecCT."No.":=codprod;
                  RecCT."Text No.":=1;
                  RecCT."Language Code":='';
                  RecCT.Insert;
             end;
             RecLT.Init;
             RecLT."Table Name":=5;
             RecLT."Line No.":=LIN;
             RecLT."No.":=codprod;
             RecLT."Language Code":='';
             RecLT.Text:=CopyStr(texto,1,44);
             RecLT."Text No.":=1;
             RecLT.Insert(true);
        end;
        if (prod<>'') then begin
             if not RecCT.Get(5,prod,'',1) then begin
                  RecCT."Table Name":=5;
                  RecCT."No.":=codprod;
                  RecCT."Text No.":=1;
                  RecCT."Language Code":='';
                  RecCT.Insert;
             end;
             if RecTP.Get(prod,'','') then begin
                  RecTP.Description:=CopyStr(texto,1,44);
                  RecTP.Modify(true);
             end;
             if not RecTP.Get(prod,'','') then begin
                  RecTP."Item No.":=prod;
                  RecTP."Variant Code":='';
                  RecTP."Language Code":='';
                  RecTP.Description:=CopyStr(texto,1,44);
                  RecTP.Insert(true);
             end;
        end;
    end;
}

