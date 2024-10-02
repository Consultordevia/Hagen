#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50555 "Account - Official Acc. Book2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Account - Official Acc. Book2.rdlc';
    Caption = 'Account - Official Acc. Book';

    dataset
    {
        dataitem("Integer";"Integer")
        {
            DataItemTableView = sorting(Number) where(Number=filter(1..));
            column(ReportForNavId_5444; 5444)
            {
            }
            column(COMPANYNAME;CompanyProperty.DisplayName)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(USERID;UserId)
            {
            }
            column(CurrReport_PAGENO___FirstPage;CurrReport.PageNo + FirstPage)
            {
            }
            column(Text1100003___GLDateFilter;Text1100003 + GLDateFilter)
            {
            }
            column(FirstPageNum;FirstPageNum)
            {
            }
            column(G_L_Register__TABLECAPTION___________GLFilter;"G/L Register".TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter;GLFilter)
            {
            }
            column(HeaderText;HeaderText)
            {
            }
            column(LineID;LineID)
            {
            }
            column(IntNumber;Number)
            {
            }
            column(TFTotalDebitAmt;TFTotalDebitAmt)
            {
            }
            column(TFTotalCreditAmt;TFTotalCreditAmt)
            {
            }
            column(TFTotalDebitAmt_Control61;TFTotalDebitAmt)
            {
            }
            column(TFTotalCreditAmt_Control72;TFTotalCreditAmt)
            {
            }
            column(TotalDebitAmt;TotalDebitAmt)
            {
            }
            column(TotalCreditAmt;TotalCreditAmt)
            {
            }
            column(Official_Accounting_BookCaption;Official_Accounting_BookCaptionLbl)
            {
            }
            column(CurrReport_PAGENO___FirstPageCaption;CurrReport_PAGENO___FirstPageCaptionLbl)
            {
            }
            column(G_L_Entry__Document_Type_Caption;"G/L Entry".FieldCaption("Document Type"))
            {
            }
            column(G_L_Entry__G_L_Account_No__Caption;"G/L Entry".FieldCaption("G/L Account No."))
            {
            }
            column(GLAccount_NameCaption;GLAccount_NameCaptionLbl)
            {
            }
            column(G_L_Entry__Debit_Amount_Caption;"G/L Entry".FieldCaption("Debit Amount"))
            {
            }
            column(G_L_Entry__Credit_Amount_Caption;"G/L Entry".FieldCaption("Credit Amount"))
            {
            }
            column(G_L_Entry__Document_No__Caption;"G/L Entry".FieldCaption("Document No."))
            {
            }
            column(G_L_Entry_Description_Control48Caption;"G/L Entry".FieldCaption(Description))
            {
            }
            column(ContinuedCaption;ContinuedCaptionLbl)
            {
            }
            column(ContinuedCaption_Control60;ContinuedCaption_Control60Lbl)
            {
            }
            column(TotalCaption;TotalCaptionLbl)
            {
            }
            dataitem("G/L Account";"G/L Account")
            {
                DataItemTableView = sorting("No.") where("Account Type"=const(Posting));
                column(ReportForNavId_6710; 6710)
                {
                }
                column(V1;1)
                {
                }
                column(NORMALDATE_OpenCloseDate_;Format(NormalDate(OpenCloseDate)))
                {
                }
                column(ShowGLHeader1;(NormalDate(OpenCloseDate) <> FirstPeriodDate) and (AccPeriod."Starting Date" = FromDate) and (OpenCloseDate <= ToDate))
                {
                }
                column(OpenClosePerTransNo;OpenClosePerTransNo)
                {
                }
                column(NORMALDATE_OpenCloseDate__Control29;Format(NormalDate(OpenCloseDate)))
                {
                }
                column(ShowGLHeader2;(NormalDate(OpenCloseDate) < NormalDate(ToDate)) and (TotalDebitAmt <> 0) and (TotalCreditAmt <> 0))
                {
                }
                column(CreditAmt;CreditAmt)
                {
                }
                column(DebitAmt;DebitAmt)
                {
                }
                column(G_L_Account_Name;Name)
                {
                }
                column(G_L_Account__No__;"No.")
                {
                }
                column(OpenTransactDesc;OpenTransactDesc)
                {
                }
                column(ShowGLBody1;((DebitAmt <> 0) or (CreditAmt <> 0)) and not (TempDate <> AccPeriod."Starting Date") and not (TempDate > ToDate) and not (FirstReg) and not (FromPerTransNo > 1))
                {
                }
                column(V1Caption;V1CaptionLbl)
                {
                }
                column(NORMALDATE_OpenCloseDate_Caption;NORMALDATE_OpenCloseDate_CaptionLbl)
                {
                }
                column(OpenClosePerTransNoCaption;OpenClosePerTransNoCaptionLbl)
                {
                }
                column(NORMALDATE_OpenCloseDate__Control29Caption;NORMALDATE_OpenCloseDate__Control29CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SetRange("Date Filter",0D,ClosingDate(AccPeriod."Starting Date" - 1));
                    CalcFields("Balance at Date","Add.-Currency Balance at Date");
                    if not PrintAmountsInAddCurrency then
                      if "Balance at Date" > 0 then begin
                        DebitAmt := "Balance at Date";
                        CreditAmt := 0;
                        TotalDebitAmt := TotalDebitAmt + DebitAmt;
                      end else begin
                        CreditAmt := -"Balance at Date";
                        DebitAmt := 0;
                        TotalCreditAmt := TotalCreditAmt + CreditAmt;
                      end
                    else
                      if "Add.-Currency Balance at Date" > 0 then begin
                        DebitAmt := "Add.-Currency Balance at Date";
                        CreditAmt := 0;
                        TotalDebitAmt := TotalDebitAmt + DebitAmt;
                      end else begin
                        CreditAmt := -"Add.-Currency Balance at Date";
                        DebitAmt := 0;
                        TotalCreditAmt := TotalCreditAmt + CreditAmt;
                      end;

                    FirstPeriodDate := 20990101D;

                    TFTotalCreditAmt := TotalCreditAmt;
                    TFTotalDebitAmt := TotalDebitAmt;

                    LineID := 1;
                end;

                trigger OnPostDataItem()
                begin
                    NextAccPeriod.CopyFilters(AccPeriod);
                    NextAccPeriod := AccPeriod;
                    if NextAccPeriod.Next = 0 then
                      LoopEnd := true;
                end;

                trigger OnPreDataItem()
                begin
                    OpenCloseDate := AccPeriod."Starting Date";
                    OpenClosePerTransNo := 1;
                    CurrTransNo := 1;
                end;
            }
            dataitem("G/L Register";"G/L Register")
            {
                DataItemTableView = sorting("Posting Date","Period Trans. No.");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Period Trans. No.";
                column(ReportForNavId_9922; 9922)
                {
                }
                column(TFTotalDebitAmt_Control47;TFTotalDebitAmt)
                {
                }
                column(TFTotalCreditAmt_Control55;TFTotalCreditAmt)
                {
                }
                column(TFTotalDebitAmt1;TFTotalDebitAmt1)
                {
                }
                column(TFTotalCreditAmt1;TFTotalCreditAmt1)
                {
                }
                column(G_L_Register__Period_Trans__No__;"Period Trans. No.")
                {
                }
                column(G_L_Register__Posting_Date_;"Posting Date")
                {
                }
                column(G_L_Register__Period_Trans__No___Control37;"Period Trans. No.")
                {
                }
                column(G_L_Register__Posting_Date__Control39;Format("Posting Date"))
                {
                }
                column(G_L_Register_No_;"No.")
                {
                }
                column(ContinuedCaption_Control43;ContinuedCaption_Control43Lbl)
                {
                }
                column(G_L_Register__Period_Trans__No__Caption;FieldCaption("Period Trans. No."))
                {
                }
                column(G_L_Register__Posting_Date_Caption;G_L_Register__Posting_Date_CaptionLbl)
                {
                }
                column(ContinuedCaption_Control42;ContinuedCaption_Control42Lbl)
                {
                }
                column(G_L_Register__Period_Trans__No___Control37Caption;FieldCaption("Period Trans. No."))
                {
                }
                column(G_L_Register__Posting_Date__Control39Caption;G_L_Register__Posting_Date__Control39CaptionLbl)
                {
                }
                dataitem("G/L Entry";"G/L Entry")
                {
                    DataItemTableView = sorting("Entry No.");
                    RequestFilterFields = "Posting Date";
                    column(ReportForNavId_7069; 7069)
                    {
                    }
                    column(G_L_Entry__G_L_Account_No__;"G/L Account No.")
                    {
                    }
                    column(GLAccount_Name;GLAccount.Name)
                    {
                    }
                    column(G_L_Entry__Document_Type_;"Document Type")
                    {
                    }
                    column(G_L_Entry__Debit_Amount_;"Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount_;"Credit Amount")
                    {
                    }
                    column(G_L_Entry__Document_No__;"Document No.")
                    {
                    }
                    column(G_L_Entry_Description;Description)
                    {
                    }
                    column(ShowGLEntryBody1;not PrintAmountsInAddCurrency)
                    {
                    }
                    column(G_L_Entry__Add__Currency_Credit_Amount_;"Add.-Currency Credit Amount")
                    {
                    }
                    column(G_L_Entry__Add__Currency_Debit_Amount_;"Add.-Currency Debit Amount")
                    {
                    }
                    column(GLAccount_Name_Control34;GLAccount.Name)
                    {
                    }
                    column(G_L_Entry__G_L_Account_No___Control40;"G/L Account No.")
                    {
                    }
                    column(G_L_Entry__Document_Type__Control41;"Document Type")
                    {
                    }
                    column(G_L_Entry__Document_No___Control74;"Document No.")
                    {
                    }
                    column(G_L_Entry_Description_Control48;Description)
                    {
                    }
                    column(ShowGLEntryBody2;PrintAmountsInAddCurrency)
                    {
                    }
                    column(G_L_Entry_Entry_No_;"Entry No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if not GLAccount.Get("G/L Account No.") then
                          GLAccount.Init;

                        if not PrintAmountsInAddCurrency then begin
                          TotalDebitAmt := TotalDebitAmt + "Debit Amount";
                          TotalCreditAmt := TotalCreditAmt + "Credit Amount";
                        end else begin
                          TotalDebitAmt := TotalDebitAmt + "Add.-Currency Debit Amount";
                          TotalCreditAmt := TotalCreditAmt + "Add.-Currency Credit Amount";
                        end;

                        TFTotalCreditAmt := TotalCreditAmt + CreditAmt;
                        TFTotalDebitAmt := TotalDebitAmt + DebitAmt;

                        LineID := 2;
                    end;

                    trigger OnPreDataItem()
                    begin
                        ///SETCURRENTKEY("Transaction No.");
                        ///SETRANGE("Transaction No.","G/L Register"."No.");
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    GLEntry: Record "G/L Entry";
                begin
                    GLEntry.SetFilter("Posting Date",GLDateFilter);
                    GLEntry.SetRange("Entry No.","From Entry No.","To Entry No.");
                    if GLEntry.IsEmpty then
                      CurrReport.Skip;

                    TestField("Period Trans. No.");
                    FirstRec := false;
                    TempDate := "Posting Date";
                    if TempDate > ClosingDate(NextAccPeriod."Starting Date" - 1) then begin
                      OldDate := "Posting Date";
                      CurrReport.Break;
                    end;

                    CurrTransNo := "Period Trans. No.";
                    if FromPerTransNo <> 0 then
                      if (CurrTransNo < FromPerTransNo) or
                         (CurrTransNo > ToPerTransNo)
                      then
                        CurrReport.Break;

                    TFTotalCreditAmt := TotalCreditAmt + CreditAmt;
                    TFTotalDebitAmt := TotalDebitAmt + DebitAmt;
                    TFTotalCreditAmt1 := TFTotalCreditAmt;
                    TFTotalDebitAmt1 := TFTotalDebitAmt;
                    LineID := 4;
                end;

                trigger OnPreDataItem()
                begin
                    if TableEnd or LoopEnd then
                      CurrReport.Break;

                    if not FirstRec then
                      SetFilter("Posting Date",'>= %1 & <= %2',OldDate,ToDate);
                    if "G/L Register".GetFilter("Period Trans. No.") <> '' then
                      SetRange("Period Trans. No.",FromPerTransNo,ToPerTransNo);
                end;
            }
            dataitem(GLAccount2;"G/L Account")
            {
                DataItemTableView = sorting("No.") where("Account Type"=const(Posting));
                column(ReportForNavId_7619; 7619)
                {
                }
                column(FORMAT_CLOSINGDATE_OpenCloseDate__;Format(ClosingDate(OpenCloseDate)))
                {
                }
                column(OpenClosePerTransNo_Control58;OpenClosePerTransNo)
                {
                }
                column(CloseTransactDesc;CloseTransactDesc)
                {
                }
                column(GLAccount2__No__;"No.")
                {
                }
                column(DebitAmt_Control24;DebitAmt)
                {
                }
                column(CreditAmt_Control25;CreditAmt)
                {
                }
                column(GLAccount2_Name;Name)
                {
                }
                column(ShowGLAcc2Body1;(DebitAmt <> 0) or (CreditAmt <> 0))
                {
                }
                column(OpenClosePerTransNo_Control58Caption;OpenClosePerTransNo_Control58CaptionLbl)
                {
                }
                column(FORMAT_CLOSINGDATE_OpenCloseDate__Caption;FORMAT_CLOSINGDATE_OpenCloseDate__CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SetRange("Date Filter",0D,ClosingDate(NextAccPeriod."Starting Date" - 1));
                    CalcFields("Balance at Date","Add.-Currency Balance at Date");
                    if not PrintAmountsInAddCurrency then
                      if "Balance at Date" < 0 then begin
                        DebitAmt := -"Balance at Date";
                        CreditAmt := 0;
                      end else begin
                        CreditAmt := "Balance at Date";
                        DebitAmt := 0;
                      end
                    else
                      if "Add.-Currency Balance at Date" < 0 then begin
                        DebitAmt := -"Add.-Currency Balance at Date";
                        CreditAmt := 0;
                      end else begin
                        CreditAmt := "Add.-Currency Balance at Date";
                        DebitAmt := 0;
                      end;

                    TFTotalCreditAmt := TFTotalCreditAmt + CreditAmt;
                    TFTotalDebitAmt := TFTotalDebitAmt + DebitAmt;

                    LineID := 3;
                end;

                trigger OnPreDataItem()
                begin
                    if LoopEnd then
                      CurrReport.Break;

                    if TempDate <= ClosingDate(NextAccPeriod."Starting Date" - 1) then
                      TableEnd := true;
                    if TableEnd and
                       (ToDate < ClosingDate(NextAccPeriod."Starting Date" - 1))
                    then begin
                      LoopEnd := true;
                      CurrReport.Break;
                    end;

                    OpenCloseDate := NextAccPeriod."Starting Date" - 1;
                    OpenClosePerTransNo := CurrTransNo + 1;
                    FirstReg := false;

                    if AccPeriod.Next = 0 then begin
                      if TableEnd then
                        LoopEnd := true
                      else
                        Error(Text1100005,"G/L Register"."No.");
                    end else
                      TempDate := AccPeriod."Starting Date";

                    if FromPerTransNo <> 0 then
                      if (OpenClosePerTransNo < FromPerTransNo) or
                         (OpenClosePerTransNo > ToPerTransNo)
                      then
                        CurrReport.Break;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if LoopEnd then
                  CurrReport.Break;

                if PrintAmountsInAddCurrency then
                  HeaderText := Text1100004 + ' ' + GLSetup."Additional Reporting Currency"
                else begin
                  GLSetup.TestField("LCY Code");
                  HeaderText := Text1100004 + ' ' + GLSetup."LCY Code";
                end;

                LineID := 0;
            end;

            trigger OnPreDataItem()
            begin
                GLSetup.Get;
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
                    field(CloseTransactDesc;CloseTransactDesc)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Closing Transaction Description';
                        ToolTip = 'Specifies the closing transaction description that you want to include in the report.';
                    }
                    field(OpenTransactDesc;OpenTransactDesc)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Opening Transaction Description';
                        ToolTip = 'Specifies a description for the initial transaction that you want to include in the report.';
                    }
                    field(FirstPage;FirstPage)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'First Page';
                        ToolTip = 'Specifies the beginning page number to include in the report or view.';
                    }
                    field(PrintAmountsInAddCurrency;PrintAmountsInAddCurrency)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Show Amounts in Add. Currency';
                        ToolTip = 'Specifies if amounts in the additional currency are included.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        FirstRec := true;
        if OpenTransactDesc = '' then
          OpenTransactDesc := Text1100000;
        if CloseTransactDesc = '' then
          CloseTransactDesc := Text1100001;
    end;

    trigger OnPreReport()
    var
        GLEntryTrans: Record "G/L Entry";
        StartTransNo: Integer;
        EndTransNo: Integer;
    begin
        FirstPageNum := FirstPage;
        GLDateFilter := "G/L Entry".GetFilter("Posting Date");
        GLFilter := "G/L Register".GetFilters;
        FromDate := "G/L Entry".GetRangeMin("Posting Date");
        ToDate := "G/L Entry".GetRangemax("Posting Date");
        InitPeriodDate := CalcPeriod(FromDate);
        AccPeriod.Reset;
        if InitPeriodDate <> FromDate then begin
          GLentry.SetRange("Posting Date",InitPeriodDate,CalcDate('<-1D>',FromDate));
          if GLentry.Find('-') then
            repeat
              if not PrintAmountsInAddCurrency then begin
                TotalDebitAmt := TotalDebitAmt + GLentry."Debit Amount";
                TotalCreditAmt := TotalCreditAmt + GLentry."Credit Amount";
              end else begin
                TotalDebitAmt := TotalDebitAmt + GLentry."Add.-Currency Debit Amount";
                TotalCreditAmt := TotalCreditAmt + GLentry."Add.-Currency Credit Amount";
              end;
            until GLentry.Next = 0;
        end;
        GLentry.SetRange("Posting Date");
        if "G/L Register".GetFilter("Period Trans. No.") <> '' then begin
          FromPerTransNo := "G/L Register".GetRangeMin("Period Trans. No.");
          ToPerTransNo := "G/L Register".GetRangemax("Period Trans. No.");
        end;

        TempDate := FromDate;

        GLReg2.Reset;
        GLReg2.SetCurrentkey("Posting Date","Period Trans. No.");
        GLReg2.FindLast;
        if GLReg2."Posting Date" < ToDate then begin
          AccPeriod.SetRange("New Fiscal Year",true);
          AccPeriod.SetFilter("Starting Date",'>%1',GLReg2."Posting Date");
          if not AccPeriod.Find('-') then
            ToDate := GLReg2."Posting Date"
          else
            ToDate := ClosingDate(AccPeriod."Starting Date" - 1);
        end;

        AccPeriod.SetRange("New Fiscal Year",true);
        AccPeriod.SetFilter("Starting Date",'>= %1',FromDate);
        if not AccPeriod.Find('-') then
          AccPeriod."Starting Date" := 99991231D
        else
          if FromDate < AccPeriod."Starting Date" then begin
            AccPeriod.SetRange("Starting Date");
            AccPeriod.Next(-1);
          end;

        if FirstPage <> 0 then
          FirstPage := FirstPage - 1;

        GLEntryTrans.SetCurrentkey("Transaction No.");
        GLEntryTrans.SetFilter("Posting Date",GLDateFilter);
        if GLEntryTrans.FindFirst then
          StartTransNo := GLEntryTrans."Transaction No.";
        if GLEntryTrans.FindLast then
          EndTransNo := GLEntryTrans."Transaction No.";
        "G/L Register".SetRange("No.",StartTransNo,EndTransNo);

        GLentry.SetFilter("Posting Date",'<%1',FromDate);
        if GLentry.IsEmpty then
          FirstReg := true
        else
          FirstReg := false;
    end;

    var
        Text1100000: label 'Period Opening Transaction';
        Text1100001: label 'Period Closing Transaction';
        Text1100003: label 'Period: ';
        Text1100004: label 'All amounts are in ';
        Text1100005: label 'No hay m s AccPeriods y s´┐¢ registros. Trans: %1', Comment='%1=GL register number';
        Text1100006: label 'There is not any period in this range of date';
        GLAccount: Record "G/L Account";
        AccPeriod: Record "Accounting Period";
        NextAccPeriod: Record "Accounting Period";
        GLReg2: Record "G/L Register";
        GLSetup: Record "General Ledger Setup";
        GLentry: Record "G/L Entry";
        GLFilter: Text[250];
        LoopEnd: Boolean;
        FirstRec: Boolean;
        TempDate: Date;
        OldDate: Date;
        FromDate: Date;
        ToDate: Date;
        FromPerTransNo: Integer;
        ToPerTransNo: Integer;
        OpenTransactDesc: Text[30];
        CloseTransactDesc: Text[30];
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        TFTotalCreditAmt: Decimal;
        TFTotalDebitAmt: Decimal;
        TotalDebitAmt: Decimal;
        TotalCreditAmt: Decimal;
        OpenClosePerTransNo: Integer;
        OpenCloseDate: Date;
        TableEnd: Boolean;
        FirstPage: Integer;
        GLDateFilter: Text;
        FirstReg: Boolean;
        CurrTransNo: Integer;
        PrintAmountsInAddCurrency: Boolean;
        HeaderText: Text[50];
        InitPeriodDate: Date;
        FirstPeriodDate: Date;
        LineID: Integer;
        FirstPageNum: Integer;
        TFTotalCreditAmt1: Decimal;
        TFTotalDebitAmt1: Decimal;
        Official_Accounting_BookCaptionLbl: label 'Official Accounting Book';
        CurrReport_PAGENO___FirstPageCaptionLbl: label 'Page';
        GLAccount_NameCaptionLbl: label 'Name';
        ContinuedCaptionLbl: label 'Continued';
        ContinuedCaption_Control60Lbl: label 'Continued';
        TotalCaptionLbl: label 'Total';
        V1CaptionLbl: label 'Period Trans. No.';
        NORMALDATE_OpenCloseDate_CaptionLbl: label 'Posting Date';
        OpenClosePerTransNoCaptionLbl: label 'Period Trans. No.';
        NORMALDATE_OpenCloseDate__Control29CaptionLbl: label 'Posting Date';
        ContinuedCaption_Control43Lbl: label 'Continued';
        G_L_Register__Posting_Date_CaptionLbl: label 'Posting Date';
        ContinuedCaption_Control42Lbl: label 'Continued';
        G_L_Register__Posting_Date__Control39CaptionLbl: label 'Posting Date';
        OpenClosePerTransNo_Control58CaptionLbl: label 'Period Trans. No.';
        FORMAT_CLOSINGDATE_OpenCloseDate__CaptionLbl: label 'Posting Date';


    procedure CalcPeriod(InitialDate: Date): Date
    begin
        AccPeriod.SetRange("New Fiscal Year",true);
        AccPeriod.SetFilter("Starting Date",'<=%1',InitialDate);
        if AccPeriod.Find('+') then
          exit(AccPeriod."Starting Date");

        Error(Text1100006);
    end;
}

