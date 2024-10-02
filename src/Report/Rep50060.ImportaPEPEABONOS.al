#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50060 "_Importa PEPE ABONOS"
{
    // YesNPEDIDO00
    // Yesfpago00
    // YesC300
    // YesC400
    // YesC500
    // YesC600
    // YesDTO00
    // YesC800
    // YesTOTALAPAGAR00
    // YesC1000
    // YesPORTES00
    // YesC1200
    // YesC1300
    // YesC1400
    // YesC1500
    // YesC1600
    // YesC1700
    // YesC1800
    // YesC1900
    // YesC2000
    // Yesclie00
    // YesC2200
    // YesC2300
    // YesC2400
    // YesC2500
    // YesC2600
    // YesC2700
    // YesC2800
    // YesC2900
    // YesC3000
    // YesC3100
    // YesC3200
    // YesC3300
    // YesC3400
    // YesC3500
    // YesC3600
    // YesC3700
    // YesC3800
    // YesC3900
    // YesC4000
    // YesC4100
    // YesC4200
    // YesC4300
    // YesC4400
    // YesC4500
    // YesC4600
    // YesC4700
    // YesC4800
    // YesC4900
    // YesC5000
    // YesC5100
    // YesC5200
    // YesC5300
    // YesC5400
    // YesC5500
    // YesC5700
    // Yesref00
    // YesC5900
    // Yescanti00
    // YesPRECIO00
    // YesC6200
    // YesREFPROD00
    // YesC6400
    // YesC6500
    // YesC6600
    // YesC6700

    Caption = 'Importa PEPE ABONOS';
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
        RecCV.SetRange(RecCV."Document Type",3);
        if RecCV.FindFirst then repeat
             RecCV.CalcFields(RecCV."imp. pdte");
             if RecCV."imp. pdte"<>RecCV."Importe a cuenta" then begin
                 DIFPED:=(RecCV."imp. pdte"-RecCV."Importe a cuenta")*-1;
        ////         DIFPED:=ROUND((DIFPED/1.18),0.01);
                 lineas:=9999999;
                            RecLV."Document Type":=3;
                            RecLV."Document No.":=RecCV."No.";
                            RecLV."Line No.":=lineas;
                            RecLV.Type:=1;
                            RecLV.Validate(RecLV."No.",'70000007');
                            RecLV.Validate(RecLV."VAT Prod. Posting Group",'NO IVA');
                            RecLV.Validate(RecLV.Quantity,1);
                            RecLV.Validate(RecLV."Unit Price",DIFPED);
                            RecLV.Insert(true);
             end;
        until RecCV.Next=0;
    end;

    trigger OnPreReport()
    begin
        RecUser.Get(UserId);
        CODCLIE2:='';
        Clear(FILE);
        ArchExt:='C:\PENDIENTE2.TXT';
        ArchSalida.TextMode := true;
        ArchSalida.WriteMode := true;
        ArchSalida.Create(ArchExt);
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
        RecSLD: Record "Sales Line Discount";
        CODIGO: Code[10];
        codprod2: Code[20];
        x: Integer;
        codgrupo: Code[20];
        producto: Code[20];
        fini: Code[10];
        finif: Date;
        ffin: Code[10];
        ffinf: Date;
        dto: Code[10];
        cantidamin: Code[10];
        dtod: Decimal;
        cantidamind: Decimal;
        D1: Code[10];
        DD: Integer;
        M1: Code[10];
        MM: Integer;
        A1: Code[10];
        AA: Integer;
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
        RecULI: Record "Inventory Setup";
        DTO2: Decimal;
        CTOTALAPAGAR: Code[250];
        CPORTES: Code[250];
        CREF: Code[250];
        CPRECIO: Code[250];
        REFPROD2: Code[20];
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
        ///     TempDim.SETRANGE("Code Caption",UPPERCASE(FormatData(ExcelBuf."Cell Value as Text")));
                 ///MESSAGE('%1 %2 %3 ',ExcelBuf."Row No.",ExcelBuf."Column No.",ExcelBuf."Cell Value as Text");
             if (ExcelBuf."Column No."=1) then begin NPEDIDO:='A'+ExcelBuf."Cell Value as Text";
                  REFPROD2:=NPEDIDO;
                  pos:=0;
                  sale:=false;
                  REFPROD:='';
                  repeat
                       pos:=pos+1;
                       if CopyStr(REFPROD2,pos,1)<>'.' then begin
                            REFPROD:=REFPROD+CopyStr(REFPROD2,pos,1);
                       end;
                  until sale or (pos>StrLen(REFPROD2));
                  NPEDIDO:=REFPROD;
             end;
             if (ExcelBuf."Column No."=2) then begin fpago:=ExcelBuf."Cell Value as Text";end;
             //YesC300              3
             //YesC400              4
             //YesC500              5
             //YesC600              6
             if (ExcelBuf."Column No."=7) then begin dto:=ExcelBuf."Cell Value as Text";end;
             //YesC800              8
             if (ExcelBuf."Column No."=9) then begin CTOTALAPAGAR:=ExcelBuf."Cell Value as Text";end;
             //YesC1000             10
             if (ExcelBuf."Column No."=11) then begin CPORTES:=ExcelBuf."Cell Value as Text";end;
             //YesC1200             12
             //YesC1300             13
             //YesC1400             14
             //YesC1500             15
             //YesC1600             16
             if (ExcelBuf."Column No."=17) then begin C17:=ExcelBuf."Cell Value as Text";end;
             //YesC1800             18
             //YesC1900             19
             //YesC2000             20
             if (ExcelBuf."Column No."=21) then begin clie:=ExcelBuf."Cell Value as Text";
                  REFPROD2:=clie;
                  pos:=0;
                  sale:=false;
                  REFPROD:='';
                  repeat
                       pos:=pos+1;
                       if CopyStr(REFPROD2,pos,1)<>'.' then begin
                            REFPROD:=REFPROD+CopyStr(REFPROD2,pos,1);
                       end;
                  until sale or (pos>StrLen(REFPROD2));
                  clie:=REFPROD;
             end;
             //YesC2200             22
             //YesC2300             23
             if (ExcelBuf."Column No."=24) then begin C24:=ExcelBuf."Cell Value as Text";end;
             if (ExcelBuf."Column No."=25) then begin C25:=ExcelBuf."Cell Value as Text";end;
             if (ExcelBuf."Column No."=26) then begin C26:=ExcelBuf."Cell Value as Text";end;
             //YesC2700             27
             //YesC2800             28
             //YesC2900             29
             //YesC3000             30
             //YesC3100             31
             if (ExcelBuf."Column No."=32) then begin C32:=ExcelBuf."Cell Value as Text";end;
             //YesC3300             33
             if (ExcelBuf."Column No."=34) then begin C34:=ExcelBuf."Cell Value as Text";end;
             if (ExcelBuf."Column No."=35) then begin C35:=ExcelBuf."Cell Value as Text";end;
             if (ExcelBuf."Column No."=36) then begin C36:=ExcelBuf."Cell Value as Text";end;
             if (ExcelBuf."Column No."=37) then begin C37:=ExcelBuf."Cell Value as Text";end;
             //YesC3800             38
             //YesC3900             39
             //YesC4000             40
             //YesC4100             41
             //YesC4200             42
             //YesC4300             43
             //YesC4400             44
             //YesC4500             45
             //YesC4600             46
             //YesC4700             47
             //YesC4800             48
             //YesC4900             49
             //YesC5000             50
             //YesC5100             51
             //YesC5200             52
             //YesC5300             53
             //YesC5400             54
             //YesC5500             55
             //YesC5700             56
             //YesC5700             57
             if (ExcelBuf."Column No."=58) then begin CREF:=ExcelBuf."Cell Value as Text";end;
             //YesC5900             59
             if (ExcelBuf."Column No."=60) then begin canti:=ExcelBuf."Cell Value as Text";end;
             if (ExcelBuf."Column No."=61) then begin CPRECIO:=ExcelBuf."Cell Value as Text";end;
             //YesC6200             62
             if (ExcelBuf."Column No."=63) then begin
                  REFPROD2:=Format(ExcelBuf."Cell Value as Text");
                  pos:=0;
                  sale:=false;
                  REFPROD:='';
                  repeat
                       pos:=pos+1;
                       if CopyStr(REFPROD2,pos,1)<>'.' then begin
                            REFPROD:=REFPROD+CopyStr(REFPROD2,pos,1);
                       end;
                  until sale or (pos>StrLen(REFPROD2));
             end;
             //YesC6400             64
             //YesC6500             65
             //YesC6600             66
             //YesC6700             67
            if (ExcelBuf."Column No."=67) then begin
                 ALTACLIENTE;
                 ALTA;
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
             Evaluate(dtod,dto);
             Evaluate(cantidamind,cantidamin);
        /// 1234567890
        /// 12-12-1234
        D1:=CopyStr(fini,1,2);
        M1:=CopyStr(fini,4,2);
        A1:=CopyStr(fini,7,4);
        Evaluate(DD,D1);
        Evaluate(MM,M1);
        Evaluate(AA,A1);
        AA:=2000+AA;
        finif:=Dmy2date(DD,MM,AA);
        D1:=CopyStr(ffin,1,2);
        M1:=CopyStr(ffin,4,2);
        A1:=CopyStr(ffin,7,4);
        Evaluate(DD,D1);
        Evaluate(MM,M1);
        Evaluate(AA,A1);
        AA:=2000+AA;
        ffinf:=Dmy2date(DD,MM,AA);
        RecSLD.Reset;
        RecSLD.SetRange(Type,0);
        RecSLD.SetRange(Code,producto);
        RecSLD.SetRange("Sales Type",1);
        RecSLD.SetRange("Sales Code",codgrupo);
        RecSLD.SetRange("Starting Date",finif);
        RecSLD.SetRange("Minimum Quantity",cantidamind);
        if not RecSLD.FindFirst then begin
             RecSLD.Init;
             RecSLD.Type:=0;
             RecSLD.Code:=producto;
             RecSLD."Sales Type":=1;
             RecSLD."Sales Code":=codgrupo;
             RecSLD."Starting Date":=finif;
             RecSLD."Minimum Quantity":=cantidamind;
             RecSLD."Line Discount %":=dtod;
             RecSLD."Ending Date":=ffinf;
             RecSLD.Insert;
        end;
    end;


    procedure ALTA()
    begin
        RecULI.Get;
        RecULI."Ultimo pedido importado":=NPEDIDO;
        RecULI.Modify;
        ///COMMIT;
        /// VENTANA.UPDATE(1,FORMAT(NPEDIDO)+' '+FORMAT(clie)+' '+FORMAT(ref)+' '+FORMAT(canti));
        if not RecCV.Get(3,NPEDIDO) then begin
             Rec36Temp."Document Type":=3;
             Rec36Temp."No.":=NPEDIDO;
             Rec36Temp.Insert;
        end;
        CODCLIE:='MN'+clie;
        if not RecClie.Get(CODCLIE) then begin
             ALTACLIENTE;
        end;
        if CODCLIE2<>NPEDIDO then begin
             if RecClie.Get(CODCLIE) then begin
                  if not RecCV.Get(3,NPEDIDO) then begin
                       CODCLIE2:=NPEDIDO;
                       codacti:=IncStr(RecUser."Serie pedidos");
                       RecUser."Serie pedidos":=codacti;
                       RecUser."Nº cliente":=clie;
                       RecUser.Modify;
                       Clear(FormAct);
                       RecCV.Init;
                       RecCV."Document Type":=3;
                       RecCV."No.":=NPEDIDO;
                       cdia:=CopyStr(C17,1,2);
                       cmes:=CopyStr(C17,4,2);
                       caño:=CopyStr(C17,7,4);
                       Evaluate(dia,cdia);
                       Evaluate(mes,cmes);
                       Evaluate(año,caño);
                       año:=año+2000;
                       fechapedi:=Dmy2date(dia,mes,año);
                       RecCV.Validate(RecCV."Order Date",fechapedi);
                       RecCV.Validate(RecCV."Posting Date",fechapedi);
                       RecCV.Validate(RecCV."Shipment Date",fechapedi);
                       RecCV."Posting Description":='Pedido nº '+NPEDIDO;
                       RecCV.Validate(RecCV."Sell-to Customer No.",CODCLIE);
                       RecCV."Estado pedido":=2;
                       RecCV."Usuario alta":=UserId;
                       RecCV."Fecha alta":=Today;
                       RecCV."Hora alta":=Time;
                       SalesSetup.Get;
                       RecCV."No. Series":=SalesSetup."Order Nos.";
                       RecCV."Shipping No. Series":=SalesSetup."Posted Shipment Nos.";
                       PRIMERAVEZ:=true;
                       PRIMERA2:=true;
                       if fpago='PAGO CONTRA REEMBOLSO' then begin
                            RecCV.Validate(RecCV."Payment Method Code",'REEMBOLSO');
                       end;
                       if fpago='PAYPAL' then begin
                            RecCV.Validate(RecCV."Payment Method Code",'PAYPAL');
                       end;
                       if fpago='TRASFERENCIA BANCARIA' then begin
                            RecCV.Validate(RecCV."Payment Method Code",'TRANSFEREN');
                       end;
                       if fpago='SERVIRED' then begin
                            RecCV.Validate(RecCV."Payment Method Code",'SERVIRED');
                       end;
                       Evaluate(TOTALAPAGAR,CTOTALAPAGAR);
                       RecCV."Importe a cuenta":=TOTALAPAGAR/100;
                       RecCV."Posting No.":=RecCV."No.";
                       RecCV."Total peso":=DTO2/100;
                       RecCV.Insert(true);
                       RecCV."Order Date":=fechapedi;
                       RecCV."Posting Date":=fechapedi;
                       RecCV."Shipment Date":=fechapedi;
                       RecCV."Document Date":=fechapedi;
                       RecCV.Modify;
                  end;
             end;
        end;
        CODCLIE:='MN'+clie;
        if Rec36Temp.Get(3,NPEDIDO) then begin
             if RecClie.Get(CODCLIE) then begin
                  Evaluate(ref,CREF);
                  if ref<>0 then begin
                       codprod:='';
                       RecProd.Reset;
                       RecProd.SetCurrentkey(RecProd."Id. web");
                       RecProd.SetRange(RecProd."Id. web",ref);
                       if RecProd.FindFirst then begin
                            codprod:=RecProd."No.";
                       end;
                       if REFPROD<>'' then begin
                            RecTCP.Reset;
                            RecTCP.SetRange(RecTCP."Vendor Item No.",REFPROD);
                            if RecTCP.FindFirst then begin
                                 codprod:=RecTCP."Item No.";
                            end;
                       end;
                  if codprod='' then begin
                       codprod:='NO-'+Format(ref);
                       if not RecProd.Get(codprod) then begin
                            TextoSalida := Format(ref);
                            ArchSalida.Write(TextoSalida);
                       end;
                  end;
                  codprod:=REFPROD;
                  if RecProd.Get(codprod) then begin
                       lineas:=lineas+10;
                       RecLV."Document Type":=3;
                       RecLV."Document No.":=NPEDIDO;
                       RecLV."Line No.":=lineas;
                       RecLV.Type:=2;
                       RecLV.Validate(RecLV."No.",codprod);
                       if RecLV."VAT Prod. Posting Group"='VAT10' then begin
                            RecLV.Validate(RecLV."VAT Prod. Posting Group",'VAT10');
                       end;
                       if RecLV."VAT Prod. Posting Group"='VAT21' then begin
                            RecLV.Validate(RecLV."VAT Prod. Posting Group",'VAT21');
                       end;
                       Evaluate(cantide,canti);
                       RecLV.Validate(RecLV.Quantity,cantide);
                       Evaluate(PRECIO,CPRECIO);
                       PRECIO:=ROUND((PRECIO/1000000),0.01);;
                       RecLV.Validate(RecLV."Unit Price",PRECIO);
                       RecLV."Location Code":='SILLA2';
                       if RecLV."VAT Prod. Posting Group"='VAT10' then begin
                            IMP10:=IMP10+PRECIO*cantide;
                       end;
                       if RecLV."VAT Prod. Posting Group"='VAT21' then begin
                            IMP21:=IMP21+PRECIO*cantide;
                       end;
                       RecLV.Insert(true);
                       /*
                       IF PRIMERAVEZ THEN BEGIN
                            IF DTO<>0 THEN BEGIN
                                 DTO:=(DTO/100);
                                 DTO:=(DTO/1.21);
                                 RecLV."Pmt. Disc. Given Amount":=DTO;
                                 PRIMERAVEZ:=FALSE;
                                 lineas:=lineas+10000;
                                 RecLV."Document Type":=1;
                                 RecLV."Document No.":=NPEDIDO;
                                 RecLV."Line No.":=lineas;
                                 RecLV.Type:=1;
                                 RecLV.VALIDATE(RecLV."No.",'70000006');
                                 EVALUATE(cantide,canti);
                                 IF RecLV."VAT Prod. Posting Group"='VAT10' THEN BEGIN
                                      RecLV.VALIDATE(RecLV."VAT Prod. Posting Group",'VAT10');
                                 END;
                                 IF RecLV."VAT Prod. Posting Group"='VAT21' THEN BEGIN
                                      RecLV.VALIDATE(RecLV."VAT Prod. Posting Group",'VAT21');
                                 END;
                                 RecLV.VALIDATE(RecLV.Quantity,1);
                                 RecLV.VALIDATE(RecLV."Unit Price",DTO*-1);
                                 RecLV.INSERT(TRUE);
                            END;
                       END;
                       */
                       if PORTES<>0 then begin
                            PORTES:=PORTES/100;
                            PORTES:=(PORTES/1.21);
                            lineas:=lineas+10000;
                            RecLV."Document Type":=3;
                            RecLV."Document No.":=NPEDIDO;
                            RecLV."Line No.":=lineas;
                            RecLV.Type:=1;
                            RecLV.Validate(RecLV."No.",'70000008');
                            Evaluate(cantide,canti);
                            RecLV.Validate(RecLV.Quantity,1);
                            RecLV.Validate(RecLV."Unit Price",PORTES);
                            RecLV.Insert(true);
                       end;
                       if PRIMERA2 then begin
                            if fpago='PAGO CONTRA REEMBOLSO' then begin
                                 lineas:=lineas+10000;
                                 RecLV."Document Type":=3;
                                 RecLV."Document No.":=NPEDIDO;
                                 RecLV."Line No.":=lineas;
                                 RecLV.Type:=1;
                                 RecLV.Validate(RecLV."No.",'70000005');
                                 if RecLV."VAT Prod. Posting Group"='VAT10' then begin
                                      RecLV.Validate(RecLV."VAT Prod. Posting Group",'VAT10');
                                 end;
                                 if RecLV."VAT Prod. Posting Group"='VAT21' then begin
                                      RecLV.Validate(RecLV."VAT Prod. Posting Group",'VAT21');
                                 end;
                                 Evaluate(cantide,canti);
                                 RecLV.Validate(RecLV.Quantity,1);
                                 PRECIO:=3.2;
                                 PRECIO:=(PRECIO/1.21);
                                 RecLV.Validate(RecLV."Unit Price",PRECIO);
                                 RecLV.Insert(true);
                                 PRIMERA2:=false;
                            end;
                       end;
                  end;
             end;
        end;
        end;

    end;


    procedure ALTACLIENTE()
    begin
        CODCLIE:='MN'+clie;
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
             RecCust.Init;
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

