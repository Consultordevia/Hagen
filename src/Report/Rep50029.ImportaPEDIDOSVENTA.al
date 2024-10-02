#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50029 "_Importa PEDIDOS VENTA"
{
    Caption = 'Importa PEDIDOS VENTA';
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
        PostCode: Record "Post Code";
        CODPOST: Code[20];
        NOMBREPOB: Text[50];
        CODPPROV: Code[10];
        CODCLIE: Code[20];
        CODCLIE2: Code[20];
        CODTRANSP: Code[20];
        CODCANTI: Code[10];
        CANTIDAD: Decimal;
        linea: Integer;
        RecCV: Record "Sales Header";
        RecLV: Record "Sales Line";
        codacti: Code[20];
        RecUser: Record "User Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        RecProd: Record Item;
        CODPROD2: Code[20];
        X: Integer;
        CODPROD: Code[20];

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
            if ExcelBuf."Row No.">1 then begin
            if (ExcelBuf."Column No."=1) then begin
                 CODCLIE2:=ExcelBuf."Cell Value as Text";
                 X:=0;
                 CODCLIE:='';
                 repeat
                      X:=X+1;
                      if CopyStr(CODCLIE2,X,1)<>'.' then begin
                           CODCLIE:=CODCLIE+CopyStr(CODCLIE2,X,1);
                      end;
                 until X=StrLen(CODCLIE2);
            end;
            if (ExcelBuf."Column No."=2) then begin
                 CODPROD2:=ExcelBuf."Cell Value as Text";
                 X:=0;
                 CODPROD:='';
                 repeat
                      X:=X+1;
                      if CopyStr(CODPROD2,X,1)<>'.' then begin
                           CODPROD:=CODPROD+CopyStr(CODPROD2,X,1);
                      end;
                 until X=StrLen(CODPROD2);
            end;
            if (ExcelBuf."Column No."=3) then begin
                 CODCANTI:=ExcelBuf."Cell Value as Text";
                 Evaluate(CANTIDAD,CODCANTI);
            end;
            if (ExcelBuf."Column No."=4) then begin
                 CODTRANSP:=ExcelBuf."Cell Value as Text";
                 GrabaArti;
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
        RecUser.Get(UserId);
                  codacti:=IncStr(RecUser."Serie pedidos");
                  RecUser."Serie pedidos":=codacti;
                  RecUser."Nº cliente":=CODCLIE;
                  RecUser.Modify;
                  RecCV.Init;
                  RecCV."Document Type":=1;
                  RecCV."No.":=codacti;
        RecCV.Validate(RecCV."Order Date",Today);
        RecCV.Validate(RecCV."Posting Date",Today);
        RecCV.Validate(RecCV."Shipment Date",Today);
        RecCV.Validate(RecCV."Sell-to Customer No.",CODCLIE);
        RecCV."Estado pedido":=2;
        RecCV."Usuario alta":=UserId;
        RecCV."Fecha alta":=Today;
        RecCV."Hora alta":=Time;
        SalesSetup.Get;
        RecCV."No. Series":=SalesSetup."Order Nos.";
        RecCV."Posting No. Series":=SalesSetup."Posted Invoice Nos.";
        RecCV."Shipping No. Series":=SalesSetup."Posted Shipment Nos.";
        RecCV."Prepayment No. Series":=SalesSetup."Posted Prepmt. Inv. Nos.";
        RecCV."Prepmt. Cr. Memo No.":=SalesSetup."Posted Prepmt. Cr. Memo Nos.";
        RecCV."Shipping Agent Code":=CODTRANSP;
        RecCV.Insert(true);
             if RecProd.Get(CODPROD) then begin
                       RecLV."Document Type":=1;
                       RecLV."Document No.":=RecCV."No.";
                       RecLV."Line No.":=10000;
                       RecLV.Type:=2;
                       RecLV.Validate(RecLV."No.",CODPROD);
                       RecLV.Validate(RecLV.Quantity,CANTIDAD);
                       RecLV.Insert(true);
                   end;
        RecCV."Estado pedido":=1;
        RecCV.Modify;
    end;
}

