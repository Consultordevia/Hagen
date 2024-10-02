#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50089 "_Importa PEDIDOS"
{
    // YesNPEDIDO00       1
    // Yesfpago00          2
    // YesDTO00   7
    // YesTOTALAPAGAR00 9
    // YesPORTES00       11
    // Yesclie00           21
    // Yesref00       58
    // Yescanti00       60
    // YesPRECIO00        61
    // YesREFPROD00         63

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
        VENTANA2.Close;
    end;

    trigger OnPreReport()
    begin
        VENTANA2.Open('#1#################################################');
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
        prod: Code[20];
        texto: Text[50];
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
        ELDIA: Integer;
        ELMES: Integer;
        "ELAÑO": Integer;
        FECHA1: Code[8];
        clie: Code[20];
        ref: Integer;
        canti: Code[20];
        REFPROD: Code[20];
        cantide: Decimal;
        obser: Code[250];
        RecCV: Record "Sales Header";
        RecLV: Record "Sales Line";
        linea: Integer;
        RecAct: Record UnknownRecord50006;
        FormAct: Page UnknownPage50020;
        RecAct2: Record UnknownRecord50006;
        FormClie: Page "Customer Card";
        RecCVC: Record "Sales & Receivables Setup";
        NoSerie: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        codacti: Code[20];
        RecLNS: Record "No. Series Line";
        RecUser: Record "User Setup";
        RecClie: Record Customer;
        FormPedi: Page UnknownPage50089;
        RecCV2: Record "Sales Header";
        SalesSetup: Record "Sales & Receivables Setup";
        Rec91: Record "User Setup";
        FormPedidos: Page UnknownPage50052;
        RepRepo: Report "_Estadistica compras reposi.";
        RecLCV: Record "Sales Comment Line";
        lineas: Integer;
        SUPRA: Code[20];
        RecProd: Record Item;
        RecRefCruz: Record "Item Cross Reference";
        sale: Boolean;
        C1: Code[250];
        C2: Code[250];
        C3: Code[250];
        C4: Code[250];
        C5: Code[250];
        C6: Code[250];
        C7: Code[250];
        C8: Code[250];
        C9: Code[250];
        C10: Code[250];
        C11: Code[250];
        C12: Code[250];
        C13: Code[250];
        C14: Code[250];
        C15: Code[250];
        C16: Code[250];
        C17: Code[250];
        C18: Code[250];
        C19: Code[250];
        C20: Code[250];
        C21: Code[250];
        C22: Code[250];
        C23: Code[250];
        C24: Code[250];
        C25: Code[250];
        C26: Code[250];
        C27: Code[250];
        C28: Code[250];
        C29: Code[250];
        C30: Code[250];
        C31: Code[250];
        C32: Code[250];
        C33: Code[250];
        C34: Code[250];
        C35: Code[250];
        C36: Code[250];
        C37: Code[250];
        C38: Code[250];
        C39: Code[250];
        C40: Code[250];
        C41: Code[250];
        C42: Code[250];
        C43: Code[250];
        C44: Code[250];
        C45: Code[250];
        C46: Code[250];
        C47: Code[250];
        C48: Code[250];
        C49: Code[250];
        C50: Code[250];
        C51: Code[250];
        C52: Code[250];
        C53: Code[250];
        C54: Code[250];
        C55: Code[250];
        C56: Code[250];
        C57: Code[250];
        C58: Code[250];
        C59: Code[250];
        C60: Code[250];
        C61: Code[250];
        C62: Code[250];
        C63: Code[250];
        C64: Code[250];
        C65: Code[250];
        C66: Code[250];
        C67: Code[250];
        C68: Code[250];
        CODCLIE: Code[20];
        CODPROD: Code[20];
        DTO: Decimal;
        PRIMERAVEZ: Boolean;
        NPEDIDO: Code[20];
        CODCLIE2: Code[20];
        PRECIO: Decimal;
        fpago: Code[50];
        RecCust: Record Customer;
        PRIMERA2: Boolean;
        RecTCP: Record "Item Vendor";
        TOTALAPAGAR: Decimal;
        VENTANA: Dialog;
        CODPRE: Code[20];
        DIFPED: Decimal;
        cdia: Code[2];
        cmes: Code[2];
        "caño": Code[4];
        dia: Integer;
        mes: Integer;
        "año": Integer;
        fechapedi: Date;
        ArchSalida: File;
        ArchExt: Text[80];
        TextoSalida: Text[250];
        Rec36Temp: Record "Sales Header" temporary;
        PORTES: Decimal;
        IMP10: Decimal;
        IMP21: Decimal;
        TANTO10: Decimal;
        TANTO21: Decimal;
        TOTAL1: Decimal;
        VENTANA2: Dialog;
        NPEDIDO2: Code[10];
        Text1100006: label '<Integer>';
        clie2: Code[10];
        pos: Integer;

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
            if (ExcelBuf."Column No."=1) then begin
                 NPEDIDO2:=ExcelBuf."Cell Value as Text";
            end;
            if (ExcelBuf."Column No."=2) then begin
                  fpago:=ExcelBuf."Cell Value as Text";
            end;
            if (ExcelBuf."Column No."=7) then begin
        /////          DTO:=ExcelBuf."Cell Value as Text";
            end;
            if (ExcelBuf."Column No."=9) then begin
        /////          TOTALAPAGAR:=ExcelBuf."Cell Value as Text";
            end;
            if (ExcelBuf."Column No."=11) then begin
        /////          PORTES:=ExcelBuf."Cell Value as Text";
            end;
            if (ExcelBuf."Column No."=21) then begin
                  clie:=ExcelBuf."Cell Value as Text";
                  clie2:='';
                  pos:=1;
                  sale:=false;
                  repeat
                       pos:=pos+1;
                       if CopyStr(prod,pos,1)<>'.' then begin
                            sale:=true;
                            clie2:=clie2+CopyStr(clie,pos,1);
                       end;
                  until sale or (pos=10);
                  clie:=clie2;
            end;
            if (ExcelBuf."Column No."=58) then begin
        /////          REF:=ExcelBuf."Cell Value as Text";
            end;
            if (ExcelBuf."Column No."=60) then begin
                  canti:=ExcelBuf."Cell Value as Text";
            end;
            if (ExcelBuf."Column No."=61) then begin
        /////          PRECIO:=ExcelBuf."Cell Value as Text";
            end;
            if (ExcelBuf."Column No."=63) then begin
                  REFPROD:=ExcelBuf."Cell Value as Text";
            end;
            if (ExcelBuf."Column No."=24) then begin C24:=ExcelBuf."Cell Value as Text";end;
            if (ExcelBuf."Column No."=25) then begin C25:=ExcelBuf."Cell Value as Text";end;
            if (ExcelBuf."Column No."=26) then begin C26:=ExcelBuf."Cell Value as Text";end;
            if (ExcelBuf."Column No."=32) then begin C32:=ExcelBuf."Cell Value as Text";end;
            if (ExcelBuf."Column No."=34) then begin C34:=ExcelBuf."Cell Value as Text";end;
            if (ExcelBuf."Column No."=35) then begin C35:=ExcelBuf."Cell Value as Text";end;
            if (ExcelBuf."Column No."=36) then begin C36:=ExcelBuf."Cell Value as Text";end;
            if (ExcelBuf."Column No."=37) then begin C37:=ExcelBuf."Cell Value as Text";end;
            if (ExcelBuf."Column No."=67) then begin
                 ALTACLIE;
            end;
            VENTANA2.Update(1,Format(NPEDIDO2)+' '+Format(fpago) +' '+
            Format(DTO) +' '+ Format(TOTALAPAGAR)+' '+
            Format(PORTES) +' '+Format(clie));
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
        LIN:=LIN+1;
        if (CODPROD<>'') then begin
             RecSP.Reset;
             RecSP.SetRange(RecSP."Item No.",CODPROD);
             RecSP.SetRange(RecSP."Minimum Quantity",cantimin);
             RecSP.SetRange(RecSP."Starting Date",fechaini);
             if RecSP.FindFirst then begin
                  RecSP."Unit Price":=precioneto;
                  if elneto='S' then begin
                       RecSP.NETO:=true;
                  end;
                  if elneto='N' then begin
                       RecSP.NETO:=false;
                  end;
                  RecSP.Modify;
             end;
             if not RecSP.FindFirst then begin
                  RecSP.Init;
                  RecSP."Item No.":=CODPROD;
                  RecSP."Minimum Quantity":=cantimin;
                  RecSP."Starting Date":=fechaini;
                  RecSP."Ending Date":=fechafin;
                  RecSP."Unit Price":=precioneto;
                  if elneto='S' then begin
                       RecSP.NETO:=true;
                  end;
                  if elneto='N' then begin
                       RecSP.NETO:=false;
                  end;
                  RecSP.Insert;
             end;
        end;
    end;


    procedure ALTACLIE()
    begin
        CODCLIE:='MN'+clie;
        if CODCLIE='MN4519' then begin
            Error('%1 ',CODCLIE);
        end;
        if RecCust.Get(CODCLIE) then begin
        RecCust.Name:=C24;
        RecCust."Search Name":=C24;
        RecCust."VAT Registration No.":=C26;
        RecCust."E-Mail":=C25;
        RecCust.Address:=CopyStr(C32,1,50);
        RecCust."Address 2":=CopyStr(C32,51);
        RecCust."Post Code":=CopyStr(C34,1,10);
        RecCust.City:=C35;
        RecCust."Phone No.":=C36;
        RecCust."Nº movil":=C37;
        RecCust."Customer Posting Group":='NAC';
        RecCust."Customer Price Group":='2011';
        RecCust."Gen. Bus. Posting Group":='NACIONAL';
        RecCust."VAT Bus. Posting Group":='NACIONAL';
        RecCust."Payment Terms Code":='CON';
        RecCust."Payment Method Code":='BANCO';
        RecCust."Salesperson Code":='OSCAR';
        RecCust."Dias tolerancias fecha vto.":=99999;
        RecCust.Modify;
        end;
        if not RecCust.Get(CODCLIE) then begin
        RecCust."No.":=CODCLIE;
        RecCust.Name:=C24;
        RecCust."Search Name":=C24;
        RecCust."VAT Registration No.":=C26;
        RecCust."E-Mail":=C25;
        RecCust.Address:=CopyStr(C32,1,50);
        RecCust."Address 2":=CopyStr(C32,51);
        RecCust."Post Code":=CopyStr(C34,1,10);
        RecCust.City:=C35;
        RecCust."Phone No.":=C36;
        RecCust."Nº movil":=C37;
        RecCust."Customer Posting Group":='NAC';
        RecCust."Customer Price Group":='2011';
        RecCust."Gen. Bus. Posting Group":='NACIONAL';
        RecCust."VAT Bus. Posting Group":='NACIONAL';
        RecCust."Payment Terms Code":='CON';
        RecCust."Payment Method Code":='BANCO';
        RecCust."Salesperson Code":='OSCAR';
        RecCust."Dias tolerancias fecha vto.":=99999;
        RecCust.Insert;
        end;
    end;
}

