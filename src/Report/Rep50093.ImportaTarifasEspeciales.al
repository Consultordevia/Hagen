#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50093 "_Importa Tarifas Especiales"
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
        prod: Code[20];
        texto: Text[50];
        codprod: Code[20];
        LIN: Integer;
        RecTP: Record "Item Translation";
        CODIGO: Code[10];
        codprod2: Code[20];
        x: Integer;
        RecSP: Record UnknownRecord50021;
        RecSP3: Record UnknownRecord50021;
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
        COLCHONWEB: Decimal;
        ESTADO: Integer;
        RecItem: Record Item;
        ddescuento: Code[10];
        grupo: Code[20];
        desdec: Decimal;
        codgrupo: Code[20];
        RecMt: Record UnknownRecord50028;
        codclie: Code[20];
        RecSP2: Record "Sales Price";
        RecCC: Record "General Ledger Setup";
        pvptarifa: Decimal;
        RecDW: Record UnknownRecord50027;
        RecProd4: Record Item;
        RecPE4: Record UnknownRecord50021;
        RecMT4: Record UnknownRecord50028;
        RecMT5: Record UnknownRecord50028;
        RecPE2: Record UnknownRecord50021;
        RecMT3: Record UnknownRecord50028;
        RecPE44: Record UnknownRecord50021;

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
            if ExcelBuf."Row No.">1 then begin
        ///    MESSAGE('%1 %2 %3 ',ExcelBuf."Row No.",ExcelBuf."Column No.",ExcelBuf."Cell Value as Text");
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
            end;
            if (ExcelBuf."Column No."=2) then begin
                 Evaluate(cantimin,ExcelBuf."Cell Value as Text");
            end;
            if (ExcelBuf."Column No."=3) then begin
        ///         fechaini:=FORMAT(ExcelBuf."Cell Value as Text");
                FECHA1:=Format(ExcelBuf."Cell Value as Text");
                DIA:=CopyStr(FECHA1,1,2);
                MES:=CopyStr(FECHA1,4,2);
                AÑO:=CopyStr(FECHA1,7,2);
                Evaluate(ELDIA,DIA);
                Evaluate(ELMES,MES);
                Evaluate(ELAÑO,AÑO);
                fechaini:=Dmy2date(ELDIA,ELMES,ELAÑO+2000);
            end;
            if (ExcelBuf."Column No."=4) then begin
        ///         fechafin:=ExcelBuf."Cell Value as Text";
                FECHA1:=Format(ExcelBuf."Cell Value as Text");
                DIA:=CopyStr(FECHA1,1,2);
                MES:=CopyStr(FECHA1,4,2);
                AÑO:=CopyStr(FECHA1,7,2);
                Evaluate(ELDIA,DIA);
                Evaluate(ELMES,MES);
                Evaluate(ELAÑO,AÑO);
                fechafin:=Dmy2date(ELDIA,ELMES,ELAÑO+2000);
            end;
            if (ExcelBuf."Column No."=5) then begin
                 Evaluate(precioneto,ExcelBuf."Cell Value as Text");
            end;
            if (ExcelBuf."Column No."=6) then begin
                 elneto:=ExcelBuf."Cell Value as Text";
                          if COMPANYNAME<>'PEPE' then begin
                 Graba;
                 end;
            end;
            if (ExcelBuf."Column No."=7) then begin
                 ddescuento:=ExcelBuf."Cell Value as Text";
                 Evaluate(desdec,ddescuento);
                  Graba;
            end;
            if (ExcelBuf."Column No."=8) then begin
                 grupo:=ExcelBuf."Cell Value as Text";
        Grabamt;
        copiahijos;
            end;
            if COMPANYNAME='PEPE' then begin
                 if (ExcelBuf."Column No."=7) then begin
                      Evaluate(COLCHONWEB,ExcelBuf."Cell Value as Text");
                 end;
                 if (ExcelBuf."Column No."=8) then begin
                      Evaluate(ESTADO,Format(ExcelBuf."Cell Value as Text"));
                      GrabaPEPE;
                 end;
            end;
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
        LIN:=LIN+1;
        if (codprod<>'') then begin
             RecSP.Reset;
             RecSP.SetRange(RecSP."Item No.",codprod);
             RecSP.SetRange(RecSP."Minimum Quantity",cantimin);
             RecSP.SetRange(RecSP."Starting Date",fechaini);
             RecSP.SetRange(RecSP.Descuento,desdec);
             if RecSP.FindFirst then begin
                  RecSP."Unit Price":=precioneto;
                  RecCC.Get;
                  pvptarifa:=0;
                  RecSP2.Reset;
                  RecSP2.SetRange(RecSP2."Item No.",codprod);
                  RecSP2.SetRange(RecSP2."Sales Code",RecCC."Tarifa vigente");
                  if RecSP2.FindFirst then begin
                       pvptarifa:=RecSP2."Unit Price";
                  end;
                  if desdec<>0 then begin
                      RecSP."Unit Price":=pvptarifa-ROUND(pvptarifa*desdec/100,0.01);
                  end;
                  if elneto='S' then begin
                       RecSP.NETO:=true;
                  end;
                  if elneto='N' then begin
                       RecSP.NETO:=false;
                  end;
                  if RecItem.Get(codprod) then begin
                       RecItem."Actualizar WEB":=true;
                       RecItem.Modify;
                  end;
                  RecSP.Modify;
             end;
             if not RecSP.FindFirst then begin
                  RecSP.Init;
                  RecSP."Item No.":=codprod;
                  RecSP."Minimum Quantity":=cantimin;
                  RecSP."Starting Date":=fechaini;
                  RecSP."Ending Date":=fechafin;
                  RecSP."Unit Price":=precioneto;
                  RecSP.Descuento:=desdec;
                  RecCC.Get;
                  pvptarifa:=0;
                  RecSP2.Reset;
                  RecSP2.SetRange(RecSP2."Item No.",codprod);
                  RecSP2.SetRange(RecSP2."Sales Code",RecCC."Tarifa vigente");
                  if RecSP2.FindFirst then begin
                       pvptarifa:=RecSP2."Unit Price";
                  end;
                  if desdec<>0 then begin
                      RecSP."Unit Price":=pvptarifa-ROUND(pvptarifa*desdec/100,0.01);
                  end;
                  if elneto='S' then begin
                       RecSP.NETO:=true;
                  end;
                  if elneto='N' then begin
                       RecSP.NETO:=false;
                  end;
                  if RecSP.Descuento<>0 then begin
                       RecPE44.Reset;
                       RecPE44.SetRange(RecPE44."Item No.",RecSP."Item No.");
                       RecPE44.SetRange(RecPE44."Starting Date",RecSP."Starting Date");
                       RecPE44.SetRange(RecPE44."Ending Date",RecSP."Ending Date");
                       RecPE44.SetRange(RecPE44.Descuento,RecSP.Descuento);
                       if not RecPE44.FindFirst then begin
                       RecSP.Insert;
                       end;
                  end;
                  if RecItem.Get(codprod) then begin
                       RecItem."Actualizar WEB":=true;
                       RecItem.Modify;
                  end;
             end;
        end;
    end;


    procedure GrabaPEPE()
    begin
        LIN:=LIN+1;
        if (codprod<>'') then begin
             RecSP.Reset;
             RecSP.SetRange(RecSP."Item No.",codprod);
             RecSP.SetRange(RecSP."Minimum Quantity",cantimin);
             RecSP.SetRange(RecSP."Starting Date",fechaini);
             RecSP.SetRange(RecSP.Descuento,desdec);
             if RecSP.FindFirst then begin
                  RecSP."Unit Price":=precioneto;
                  RecSP.Validate(RecSP.Descuento,desdec);
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
                  RecSP."Item No.":=codprod;
                  RecSP."Minimum Quantity":=cantimin;
                  RecSP."Starting Date":=fechaini;
                  RecSP."Ending Date":=fechafin;
                  RecSP."Unit Price":=precioneto;
                  RecSP.Validate(RecSP.Descuento,desdec);
                  RecCC.Get;
                  pvptarifa:=0;
                  RecSP2.Reset;
                  RecSP2.SetRange(RecSP2."Item No.",codprod);
                  RecSP2.SetRange(RecSP2."Sales Code",RecCC."Tarifa vigente");
                  if RecSP2.FindFirst then begin
                       pvptarifa:=RecSP2."Unit Price";
                  end;
                  if desdec<>0 then begin
                      RecSP."Unit Price":=pvptarifa-ROUND(pvptarifa*desdec/100,0.01);
                  end;
                  if elneto='S' then begin
                       RecSP.NETO:=true;
                  end;
                  if elneto='N' then begin
                       RecSP.NETO:=false;
                  end;
                  if RecSP.Descuento<>0 then begin
                       RecPE44.Reset;
                       RecPE44.SetRange(RecPE44."Item No.",RecSP."Item No.");
                       RecPE44.SetRange(RecPE44."Starting Date",RecSP."Starting Date");
                       RecPE44.SetRange(RecPE44."Ending Date",RecSP."Ending Date");
                       RecPE44.SetRange(RecPE44.Descuento,RecSP.Descuento);
                       if not RecPE44.FindFirst then begin
                       RecSP.Insert;
                       end;
                  end;
             end;
             if RecItem.Get(codprod) then begin
                  RecItem."Cantidad colchon web":=COLCHONWEB;
                  RecItem."Estado Producto":=ESTADO-1;
                  RecItem.Modify;
             end;
        end;
    end;


    procedure Grabamt()
    begin
        ///Tabla,Código 1,Código 2,Minimum Quantity,Starting Date,NETO
             RecSP.Reset;
             RecSP.SetRange(RecSP."Item No.",codprod);
             RecSP.SetRange(RecSP."Minimum Quantity",cantimin);
             RecSP.SetRange(RecSP."Starting Date",fechaini);
             RecSP.SetRange(RecSP.Descuento,desdec);
             if RecSP.FindFirst then begin
                  RecMt.Reset;
                  RecMt.SetRange(RecMt.Tabla,1);
                  RecMt.SetRange(RecMt."Código 1",RecSP."Item No.");
                  RecMt.SetRange(RecMt."Código 2",grupo);
                  RecMt.SetRange(RecMt."Minimum Quantity",RecSP."Minimum Quantity");
                  RecMt.SetRange(RecMt."Starting Date",RecSP."Starting Date");
                  RecMt.SetRange(RecMt.NETO,RecSP.NETO);
                  RecMt.SetRange(RecMt.Descuento,desdec);
                  if RecMt.FindFirst then begin
                     RecMt."Actualizar WEB":=true;
                     RecMt.Modify;
                  end;
                  if not RecMt.FindFirst then begin
                     RecMt.Init;
                     RecMt.Tabla:=1;
                     RecMt.Validate(RecMt."Código 1",codprod);
                     RecMt.Validate(RecMt."Código 2",grupo);
                     RecMt."Minimum Quantity":=RecSP."Minimum Quantity";
                     RecMt."Starting Date":=RecSP."Starting Date";
                     RecMt.NETO:=RecSP.NETO;
                     RecMt."Actualizar WEB":=true;
                     RecMt.Descuento:=desdec;
                     RecMt.Insert;
                     RecDW.Reset;
                     RecDW.SetRange(RecDW."Total descuento",desdec);
                     if RecDW.FindFirst then repeat
                          RecMt.Init;
                          RecMt.Tabla:=1;
                          RecMt.Validate(RecMt."Código 1",codprod);
                          RecMt.Validate(RecMt."Código 2",RecDW."Codigo descuento");
                          RecMt."Minimum Quantity":=RecSP."Minimum Quantity";
                          RecMt."Starting Date":=RecSP."Starting Date";
                          RecMt.NETO:=RecSP.NETO;
                          RecMt."Actualizar WEB":=true;
                          RecMt.Descuento:=RecDW."Dtos. 2";
                          RecMt.Insert;
                  RecSP3.Init;
                  RecSP3."Item No.":=codprod;
                  RecSP3."Minimum Quantity":=cantimin;
                  RecSP3."Starting Date":=fechaini;
                  RecSP3."Ending Date":=fechafin;
                  RecSP3."Unit Price":=precioneto;
                  RecSP3.Descuento:=RecDW."Dtos. 2";
                  RecCC.Get;
                  pvptarifa:=0;
                  RecSP2.Reset;
                  RecSP2.SetRange(RecSP2."Item No.",codprod);
                  RecSP2.SetRange(RecSP2."Sales Code",RecCC."Tarifa vigente");
                  if RecSP2.FindFirst then begin
                       pvptarifa:=RecSP2."Unit Price";
                  end;
                  if desdec<>0 then begin
                      RecSP3."Unit Price":=pvptarifa-ROUND(pvptarifa*RecDW."Dtos. 2"/100,0.01);
                  end;
                  if elneto='S' then begin
                       RecSP3.NETO:=true;
                  end;
                  if elneto='N' then begin
                       RecSP3.NETO:=false;
                  end;
                       RecPE44.Reset;
                       RecPE44.SetRange(RecPE44."Item No.",RecSP3."Item No.");
                       RecPE44.SetRange(RecPE44."Starting Date",RecSP3."Starting Date");
                       RecPE44.SetRange(RecPE44."Ending Date",RecSP3."Ending Date");
                       RecPE44.SetRange(RecPE44.Descuento,RecSP3.Descuento);
                       if not RecPE44.FindFirst then begin
                  if RecSP3.Insert then ;
                       end;
                     until RecDW.Next=0;
              end;
              end;
    end;


    procedure copiahijos()
    begin
        /*
        RecProd4.RESET;
        RecProd4.SETRANGE(RecProd4."Producto PADRE",codprod);
        IF RecProd4.FINDFIRST THEN REPEAT
             IF RecProd4."No."<>codprod THEN BEGIN
                  RecPE4.RESET;
                  RecPE4.SETRANGE(RecPE4."Item No.",codprod);
                  IF RecPE4.FINDFIRST THEN REPEAT
                       RecMT3.RESET;
                       RecMT3.SETRANGE(RecMT3.Tabla,1);
                       RecMT3.SETRANGE(RecMT3."Código 1",RecPE4."Item No.");
                       RecMT3.SETRANGE(RecMT3."Minimum Quantity",RecPE4."Minimum Quantity");
                       RecMT3.SETRANGE(RecMT3."Starting Date",RecPE4."Starting Date");
                       RecMT3.SETRANGE(RecMT3.NETO,RecPE4.NETO);
                       RecMT3.SETRANGE(RecMT3.Descuento,RecPE4.Descuento);
                       RecMT3.SETRANGE(RecMT3."Código 2",'DC00');
                       IF RecMT3.FINDFIRST THEN BEGIN
                            RecPE2.INIT;
                            RecPE2:=RecPE4;
                            RecPE2."Item No.":=RecProd4."No.";
                            RecPE2.VALIDATE(RecPE2.Descuento);
                            IF RecPE2.Descuento<>0 THEN BEGIN
                                 RecPE2.INSERT;
                            END;
                            RecMT4.RESET;
                            RecMT4.SETRANGE(RecMT4.Tabla,1);
                            RecMT4.SETRANGE(RecMT4."Código 1",RecMT3."Código 1");
                            RecMT4.SETRANGE(RecMT4."Código 2",RecMT3."Código 2");
                            RecMT4.SETRANGE(RecMT4."Minimum Quantity",RecMT3."Minimum Quantity");
                            RecMT4.SETRANGE(RecMT4."Starting Date",RecMT3."Starting Date");
                            RecMT4.SETRANGE(RecMT4.NETO,RecMT3.NETO);
                            RecMT4.SETRANGE(RecMT4.Descuento,RecMT3.Descuento);
                            IF RecMT4.FINDFIRST THEN BEGIN
                                 RecMT5:=RecMT4;
                                 RecMT5."Código 1":=RecProd4."No.";
                                 IF RecMT5.INSERT THEN;
                            END;
                       END;
                  UNTIL RecPE4.NEXT=0;
             END;
        UNTIL RecProd4.NEXT=0;
         */

    end;
}

