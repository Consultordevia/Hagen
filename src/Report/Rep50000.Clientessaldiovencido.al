#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50000 "Clientes saldio vencido"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Clientes saldio vencido.rdlc';
    Caption = 'Clientes saldio vencido';

    dataset
    {
        dataitem(Customer;Customer)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_6836; 6836)
            {
            }
            column(TodayFormatted;TypeHelper.GetFormattedCurrentDateTimeInUserTimeZone('f'))
            {
            }
            column(CompanyName;CompanyProperty.DisplayName)
            {
            }
            column(AgedASEndingDate;StrSubstNo(Text006,Format(EndingDate,0,4)))
            {
            }
            column(AgingByPostingDate;StrSubstNo(Text007,SelectStr(AgingBy + 1,Text009)))
            {
            }
            column(PrintAmountInLCY;PrintAmountInLCY)
            {
            }
            column(TbCAPTCustFltr;TableCaption + ': ' + CustFilter)
            {
            }
            column(CustFilter;CustFilter)
            {
            }
            column(AgingByDueDate;AgingBy = Agingby::"Due Date")
            {
            }
            column(AgingByDocDate;StrSubstNo(Text004,SelectStr(AgingBy + 1,Text009)))
            {
            }
            column(HeaderText5;HeaderText[5])
            {
            }
            column(HeaderText4;HeaderText[4])
            {
            }
            column(HeaderText3;HeaderText[3])
            {
            }
            column(HeaderText2;HeaderText[2])
            {
            }
            column(HeaderText1;HeaderText[1])
            {
            }
            column(PrintDetails;PrintDetails)
            {
            }
            column(PageGroupNo;PageGroupNo)
            {
            }
            column(OriginalAmount;GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(OriginalAmt1;GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(OriginalAmt2;GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(OriginalAmt3;GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(OriginalAmt4;GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(OriginalAmt5;GrandTotalCustLedgEntry[1]."Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(PctGrandTotalCustLedgEntry11RemAmtLCYAmtLCY;Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)",GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(PctGrandTotalCustLedgEntry21RemAmtLCYAmtLCY;Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)",GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(PctGrandTotalCustLedgEntry31RemAmtLCYAmtLCY;Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)",GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(PctGrandTotalCustLedgEntry41RemAmtLCYAmtLCY;Pct(GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)",GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(PctGrandTotalCustLedgEntry51RemAmtLCYAmtLCY;Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)",GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(No_Cust;"No.")
            {
                IncludeCaption = true;
            }
            column(Name_Cust;Customer.Name)
            {
                IncludeCaption = true;
            }
            column(AgedAccountsReceivableCaption;AgedAccountsReceivableCaptionLbl)
            {
            }
            column(PageCaption;PageCaptionLbl)
            {
            }
            column(AllAmountsinLCYCaption;AllAmountsinLCYCaptionLbl)
            {
            }
            column(AgedOverdueAmountsCaption;AgedOverdueAmountsCaptionLbl)
            {
            }
            column(BalanceCaption;BalanceCaptionLbl)
            {
            }
            column(OriginalAmountCaption;OriginalAmountCaptionLbl)
            {
            }
            column(DueDateCaption;DueDateCaptionLbl)
            {
            }
            column(DocumentNoCaption;DocumentNoCaptionLbl)
            {
            }
            column(PostingDateCaption;PostingDateCaptionLbl)
            {
            }
            column(DocuemtnTypeCaption;DocuemtnTypeCaptionLbl)
            {
            }
            column(CurrencyCodeCaption;CurrencyCodeCaptionLbl)
            {
            }
            column(TotalLCYCaption;TotalLCYCaptionLbl)
            {
            }
            column(TotalCaption;TotalCaptionLbl)
            {
            }
            column(SaldoVencido;Customer."Balance Due (LCY)")
            {
            }
            dataitem("Cust. Ledger Entry";"Cust. Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No.");
                DataItemTableView = sorting("Customer No.","Posting Date","Currency Code");
                column(ReportForNavId_8503; 8503)
                {
                }

                trigger OnAfterGetRecord()
                var
                    CustLedgEntry: Record "Cust. Ledger Entry";
                begin
                    CustLedgEntry.SetCurrentkey("Closed by Entry No.");
                    CustLedgEntry.SetRange("Closed by Entry No.","Entry No.");
                    CustLedgEntry.SetRange("Posting Date",0D,EndingDate);
                    if CustLedgEntry.FindSet(false,false) then
                      repeat
                        InsertTemp(CustLedgEntry);
                      until CustLedgEntry.Next = 0;

                    if "Closed by Entry No." <> 0 then begin
                      CustLedgEntry.SetRange("Closed by Entry No.","Closed by Entry No.");
                      if CustLedgEntry.FindSet(false,false) then
                        repeat
                          InsertTemp(CustLedgEntry);
                        until CustLedgEntry.Next = 0;
                    end;

                    CustLedgEntry.Reset;
                    CustLedgEntry.SetRange("Entry No.","Closed by Entry No.");
                    CustLedgEntry.SetRange("Posting Date",0D,EndingDate);
                    if CustLedgEntry.FindSet(false,false) then
                      repeat
                        InsertTemp(CustLedgEntry);
                      until CustLedgEntry.Next = 0;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Posting Date",EndingDate + 1,Dmy2date(31,12,9999));
                end;
            }
            dataitem(OpenCustLedgEntry;"Cust. Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No.");
                DataItemTableView = sorting("Customer No.",Open,Positive,"Due Date","Currency Code");
                column(ReportForNavId_1473; 1473)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if AgingBy = Agingby::"Posting Date" then begin
                      CalcFields("Remaining Amt. (LCY)");
                      if "Remaining Amt. (LCY)" = 0 then
                        CurrReport.Skip;
                    end;

                    InsertTemp(OpenCustLedgEntry);
                end;

                trigger OnPreDataItem()
                begin
                    if AgingBy = Agingby::"Posting Date" then begin
                      SetRange("Posting Date",0D,EndingDate);
                      SetRange("Date Filter",0D,EndingDate);
                    end;
                end;
            }
            dataitem(CurrencyLoop;"Integer")
            {
                DataItemTableView = sorting(Number) where(Number=filter(1..));
                PrintOnlyIfDetail = true;
                column(ReportForNavId_6523; 6523)
                {
                }
                dataitem(TempCustLedgEntryLoop;"Integer")
                {
                    DataItemTableView = sorting(Number) where(Number=filter(1..));
                    column(ReportForNavId_7725; 7725)
                    {
                    }
                    column(OriginalAmt6;CustLedgEntryEndingDate."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt7;AgedCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt8;AgedCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt9;AgedCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt10;AgedCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt11;AgedCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(CustLedgEntryEndDateAmtLCY;CustLedgEntryEndingDate."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(CustLedgEntryEndDueDate;Format(CustLedgEntryEndingDate."Due Date"))
                    {
                    }
                    column(CustLedgEntryEndDateDocNo;CustLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(CustLedgEntryEndDateDocType;Format(CustLedgEntryEndingDate."Document Type"))
                    {
                    }
                    column(CustLedgEntryEndPostingDate;Format(CustLedgEntryEndingDate."Posting Date"))
                    {
                    }
                    column(OriginalAmt12;AgedCustLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt13;AgedCustLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt14;AgedCustLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt15;AgedCustLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt16;AgedCustLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt17;CustLedgEntryEndingDate."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CustLedgEntryEndDateAmt;CustLedgEntryEndingDate.Amount)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(TotalForCustName;StrSubstNo(Text005,Customer.Name))
                    {
                    }
                    column(OriginalAmt18;TotalCustLedgEntry[1]."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt19;TotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt20;TotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt21;TotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt22;TotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt23;TotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt24;CurrencyCode)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt25;TotalCustLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt26;TotalCustLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt27;TotalCustLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt28;TotalCustLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt29;TotalCustLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(OriginalAmt30;TotalCustLedgEntry[1].Amount)
                    {
                        AutoFormatType = 1;
                    }
                    column(Totalcheck;CustFilterCheck)
                    {
                    }
                    column(OriginalAmt31;GrandTotalCustLedgEntry[1]."Amount (LCY)")
                    {
                    }
                    column(OriginalAmt32;GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                    }
                    column(OriginalAmt33;GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                    }
                    column(OriginalAmt34;GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                    }
                    column(OriginalAmt35;GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                    }
                    column(OriginalAmt36;GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                    }
                    column(PctGrandTotalCustLedgEntry61RemAmtLCYAmtLCY;Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)",GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(PctGrandTotalCustLedgEntry71RemAmtLCYAmtLCY;Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)",GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(PctGrandTotalCustLedgEntry81RemAmtLCYAmtLCY;Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)",GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(PctGrandTotalCustLedgEntry91RemAmtLCYAmtLCY;Pct(GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)",GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(PctGrandTotalCustLedgEntry501RemAmtLCYAmtLCY;Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)",GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        PeriodIndex: Integer;
                    begin
                        if Number = 1 then begin
                          if not TempCustLedgEntry.FindSet(false,false) then
                            CurrReport.Break;
                        end else
                          if TempCustLedgEntry.Next = 0 then
                            CurrReport.Break;

                        CustLedgEntryEndingDate := TempCustLedgEntry;
                        DetailedCustomerLedgerEntry.SetRange("Cust. Ledger Entry No.",CustLedgEntryEndingDate."Entry No.");
                        DetailedCustomerLedgerEntry.SetFilter("Excluded from calculation", '%1', false);
                        if DetailedCustomerLedgerEntry.FindSet(false,false) then
                          repeat
                            if (DetailedCustomerLedgerEntry."Entry Type" =
                                DetailedCustomerLedgerEntry."entry type"::"Initial Entry") and
                               (CustLedgEntryEndingDate."Posting Date" > EndingDate) and
                               (AgingBy <> Agingby::"Posting Date")
                            then begin
                              if CustLedgEntryEndingDate."Document Date" <= EndingDate then
                                DetailedCustomerLedgerEntry."Posting Date" :=
                                  CustLedgEntryEndingDate."Document Date"
                              else
                                if (CustLedgEntryEndingDate."Due Date" <= EndingDate) and
                                   (AgingBy = Agingby::"Due Date")
                                then
                                  DetailedCustomerLedgerEntry."Posting Date" :=
                                    CustLedgEntryEndingDate."Due Date"
                            end;

                            if (DetailedCustomerLedgerEntry."Posting Date" <= EndingDate) or
                               (TempCustLedgEntry.Open and
                                (AgingBy = Agingby::"Due Date") and
                                (CustLedgEntryEndingDate."Due Date" > EndingDate) and
                                (CustLedgEntryEndingDate."Posting Date" <= EndingDate))
                            then begin
                              if DetailedCustomerLedgerEntry."Entry Type" in
                                 [DetailedCustomerLedgerEntry."entry type"::"Initial Entry",
                                  DetailedCustomerLedgerEntry."entry type"::"Unrealized Loss",
                                  DetailedCustomerLedgerEntry."entry type"::"Unrealized Gain",
                                  DetailedCustomerLedgerEntry."entry type"::"Realized Loss",
                                  DetailedCustomerLedgerEntry."entry type"::"Realized Gain",
                                  DetailedCustomerLedgerEntry."entry type"::"Payment Discount",
                                  DetailedCustomerLedgerEntry."entry type"::"Payment Discount (VAT Excl.)",
                                  DetailedCustomerLedgerEntry."entry type"::"Payment Discount (VAT Adjustment)",
                                  DetailedCustomerLedgerEntry."entry type"::"Payment Tolerance",
                                  DetailedCustomerLedgerEntry."entry type"::"Payment Discount Tolerance",
                                  DetailedCustomerLedgerEntry."entry type"::"Payment Tolerance (VAT Excl.)",
                                  DetailedCustomerLedgerEntry."entry type"::"Payment Tolerance (VAT Adjustment)",
                                  DetailedCustomerLedgerEntry."entry type"::"Payment Discount Tolerance (VAT Excl.)",
                                  DetailedCustomerLedgerEntry."entry type"::"Payment Discount Tolerance (VAT Adjustment)"]
                              then begin
                                CustLedgEntryEndingDate.Amount := CustLedgEntryEndingDate.Amount + DetailedCustomerLedgerEntry.Amount;
                                CustLedgEntryEndingDate."Amount (LCY)" :=
                                  CustLedgEntryEndingDate."Amount (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                              end;
                              if DetailedCustomerLedgerEntry."Posting Date" <= EndingDate then begin
                                CustLedgEntryEndingDate."Remaining Amount" :=
                                  CustLedgEntryEndingDate."Remaining Amount" + DetailedCustomerLedgerEntry.Amount;
                                CustLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                  CustLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                              end;
                            end;
                          until DetailedCustomerLedgerEntry.Next = 0;

                        if CustLedgEntryEndingDate."Remaining Amount" = 0 then
                          CurrReport.Skip;

                        case AgingBy of
                          Agingby::"Due Date":
                            PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Due Date");
                          Agingby::"Posting Date":
                            PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Posting Date");
                          Agingby::"Document Date":
                            begin
                              if CustLedgEntryEndingDate."Document Date" > EndingDate then begin
                                CustLedgEntryEndingDate."Remaining Amount" := 0;
                                CustLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                CustLedgEntryEndingDate."Document Date" := CustLedgEntryEndingDate."Posting Date";
                              end;
                              PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Document Date");
                            end;
                        end;
                        Clear(AgedCustLedgEntry);
                        AgedCustLedgEntry[PeriodIndex]."Remaining Amount" := CustLedgEntryEndingDate."Remaining Amount";
                        AgedCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalCustLedgEntry[PeriodIndex]."Remaining Amount" += CustLedgEntryEndingDate."Remaining Amount";
                        TotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalCustLedgEntry[1].Amount += CustLedgEntryEndingDate."Remaining Amount";
                        TotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                    end;

                    trigger OnPostDataItem()
                    begin
                        if not PrintAmountInLCY then
                          UpdateCurrencyTotals;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if not PrintAmountInLCY then begin
                          if (TempCurrency.Code = '') or (TempCurrency.Code = GLSetup."LCY Code") then
                            TempCustLedgEntry.SetFilter("Currency Code",'%1|%2',GLSetup."LCY Code",'')
                          else
                            TempCustLedgEntry.SetRange("Currency Code",TempCurrency.Code);
                        end;

                        PageGroupNo := NextPageGroupNo;
                        if NewPagePercustomer and (NumberOfCurrencies > 0) then
                          NextPageGroupNo := PageGroupNo + 1;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    Clear(TotalCustLedgEntry);

                    if Number = 1 then begin
                      if not TempCurrency.FindSet(false,false) then
                        CurrReport.Break;
                    end else
                      if TempCurrency.Next = 0 then
                        CurrReport.Break;

                    if TempCurrency.Code <> '' then
                      CurrencyCode := TempCurrency.Code
                    else
                      CurrencyCode := GLSetup."LCY Code";

                    NumberOfCurrencies := NumberOfCurrencies + 1;
                end;

                trigger OnPreDataItem()
                begin
                    NumberOfCurrencies := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TempCurrency.Reset;
                TempCurrency.DeleteAll;
                TempCustLedgEntry.Reset;
                TempCustLedgEntry.DeleteAll;
                GroupNo := GroupNo + 1;
            end;
        }
        dataitem(CurrencyTotals;"Integer")
        {
            DataItemTableView = sorting(Number) where(Number=filter(1..));
            column(ReportForNavId_8052; 8052)
            {
            }
            column(Number_CurrencyTotals;Number = 1)
            {
            }
            column(GroupNo;GroupNo)
            {
            }
            column(OriginalAmt37;TempCurrency2.Code)
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(OriginalAmt38;AgedCustLedgEntry[6]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(OriginalAmt39;AgedCustLedgEntry[1]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(OriginalAmt40;AgedCustLedgEntry[2]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(OriginalAmt41;AgedCustLedgEntry[3]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(OriginalAmt42;AgedCustLedgEntry[4]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(OriginalAmt43;AgedCustLedgEntry[5]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(Number1_CurrencyTotals;Number > 1)
            {
            }
            column(CurrencySpecificationCaption;CurrencySpecificationCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Number = 1 then begin
                  if not TempCurrency2.FindSet(false,false) then
                    CurrReport.Break;
                end else
                  if TempCurrency2.Next = 0 then
                    CurrReport.Break;

                Clear(AgedCustLedgEntry);
                TempCurrencyAmount.SetRange("Currency Code",TempCurrency2.Code);
                if TempCurrencyAmount.FindSet(false,false) then
                  repeat
                    if TempCurrencyAmount.Date <> 99991231D then
                      AgedCustLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                        TempCurrencyAmount.Amount
                    else
                      AgedCustLedgEntry[6]."Remaining Amount" := TempCurrencyAmount.Amount;
                  until TempCurrencyAmount.Next = 0;
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
                    field(AgedAsOf;EndingDate)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Aged As Of';
                        ToolTip = 'Specifies the date that you want the aging calculated for.';
                    }
                    field(Agingby;AgingBy)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Aging by';
                        OptionCaption = 'Due Date,Posting Date,Document Date';
                        ToolTip = 'Specifies if the aging will be calculated from the due date, the posting date, or the document date.';
                    }
                    field(PeriodLength;PeriodLength)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Period Length';
                        ToolTip = 'Specifies the period for which data is shown in the report. For example, enter "1M" for one month, "30D" for thirty days, "3Q" for three quarters, or "5Y" for five years.';
                    }
                    field(AmountsinLCY;PrintAmountInLCY)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Print Amounts in LCY';
                        ToolTip = 'Specifies if you want the report to specify the aging per customer ledger entry.';
                    }
                    field(PrintDetails;PrintDetails)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Print Details';
                        ToolTip = 'Specifies if you want the report to show the detailed entries that add up the total balance for each customer.';
                    }
                    field(HeadingType;HeadingType)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Heading Type';
                        OptionCaption = 'Date Interval,Number of Days';
                        ToolTip = 'Specifies if the column heading for the three periods will indicate a date interval or the number of days overdue.';
                    }
                    field(perCustomer;NewPagePercustomer)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'New Page per Customer';
                        ToolTip = 'Specifies if each customer''s information is printed on a new page if you have chosen two or more customers to be included in the report.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if EndingDate = 0D then
              EndingDate := WorkDate;
            if Format(PeriodLength) = '' then
              Evaluate(PeriodLength,'<1M>');
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        CaptionManagement: Codeunit "Caption Class";
    begin
        CustFilter := CaptionManagement.GetRecordFiltersWithCaptions(Customer);

        GLSetup.Get;

        CalcDates;
        CreateHeadings;

        PageGroupNo := 1;
        NextPageGroupNo := 1;
        CustFilterCheck := (CustFilter <> 'No.');
    end;

    var
        GLSetup: Record "General Ledger Setup";
        TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        CustLedgEntryEndingDate: Record "Cust. Ledger Entry";
        TotalCustLedgEntry: array [5] of Record "Cust. Ledger Entry";
        GrandTotalCustLedgEntry: array [5] of Record "Cust. Ledger Entry";
        AgedCustLedgEntry: array [6] of Record "Cust. Ledger Entry";
        TempCurrency: Record Currency temporary;
        TempCurrency2: Record Currency temporary;
        TempCurrencyAmount: Record "Currency Amount" temporary;
        DetailedCustomerLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        TypeHelper: Codeunit "Type Helper";
        CustFilter: Text;
        PrintAmountInLCY: Boolean;
        EndingDate: Date;
        AgingBy: Option "Due Date","Posting Date","Document Date";
        PeriodLength: DateFormula;
        PrintDetails: Boolean;
        HeadingType: Option "Date Interval","Number of Days";
        NewPagePercustomer: Boolean;
        PeriodStartDate: array [5] of Date;
        PeriodEndDate: array [5] of Date;
        HeaderText: array [5] of Text[30];
        Text000: label 'Not Due';
        Text001: label 'Before';
        CurrencyCode: Code[10];
        Text002: label 'days';
        Text003: label 'More than';
        Text004: label 'Aged by %1';
        Text005: label 'Total for %1';
        Text006: label 'Aged as of %1';
        Text007: label 'Aged by %1';
        NumberOfCurrencies: Integer;
        Text009: label 'Due Date,Posting Date,Document Date';
        Text010: label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
        PageGroupNo: Integer;
        NextPageGroupNo: Integer;
        CustFilterCheck: Boolean;
        GroupNo: Integer;
        Text034: label 'Currency Specification';
        Text035: label '-%1', Comment='Negating the period length: %1 is the period length';
        AgedAccountsReceivableCaptionLbl: label 'Aged Accounts Receivable';
        PageCaptionLbl: label 'Page';
        AllAmountsinLCYCaptionLbl: label 'All Amounts in LCY';
        AgedOverdueAmountsCaptionLbl: label 'Aged Overdue Amounts';
        BalanceCaptionLbl: label 'Balance';
        OriginalAmountCaptionLbl: label 'Original Amount';
        DueDateCaptionLbl: label 'Due Date';
        DocumentNoCaptionLbl: label 'Document No.';
        PostingDateCaptionLbl: label 'Posting Date';
        DocuemtnTypeCaptionLbl: label 'Document Type';
        CurrencyCodeCaptionLbl: label 'Balance';
        TotalLCYCaptionLbl: label 'Balance';
        TotalCaptionLbl: label 'Total (LCY)';
        CurrencySpecificationCaptionLbl: label 'Currency Code';
        EnterDateFormulaErr: label 'Enter a date formula in the Period Length field.';

    local procedure CalcDates()
    var
        i: Integer;
        PeriodLength2: DateFormula;
    begin
        if not Evaluate(PeriodLength2,StrSubstNo(Text035,PeriodLength)) then
          Error(EnterDateFormulaErr);
        if AgingBy = Agingby::"Due Date" then begin
          PeriodEndDate[1] := 99991231D;
          PeriodStartDate[1] := EndingDate + 1;
        end else begin
          PeriodEndDate[1] := EndingDate;
          PeriodStartDate[1] := CalcDate(PeriodLength2,EndingDate + 1);
        end;
        for i := 2 to ArrayLen(PeriodEndDate) do begin
          PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
          PeriodStartDate[i] := CalcDate(PeriodLength2,PeriodEndDate[i] + 1);
        end;
        PeriodStartDate[i] := 0D;

        for i := 1 to ArrayLen(PeriodEndDate) do
          if PeriodEndDate[i] < PeriodStartDate[i] then
            Error(Text010,PeriodLength);
    end;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        if AgingBy = Agingby::"Due Date" then begin
          HeaderText[1] := Text000;
          i := 2;
        end else
          i := 1;
        while i < ArrayLen(PeriodEndDate) do begin
          if HeadingType = Headingtype::"Date Interval" then
            HeaderText[i] := StrSubstNo('%1\..%2',PeriodStartDate[i],PeriodEndDate[i])
          else
            HeaderText[i] :=
              StrSubstNo('%1 - %2 %3',EndingDate - PeriodEndDate[i] + 1,EndingDate - PeriodStartDate[i] + 1,Text002);
          i := i + 1;
        end;
        if HeadingType = Headingtype::"Date Interval" then
          HeaderText[i] := StrSubstNo('%1 %2',Text001,PeriodStartDate[i - 1])
        else
          HeaderText[i] := StrSubstNo('%1 \%2 %3',Text003,EndingDate - PeriodStartDate[i - 1] + 1,Text002);
    end;

    local procedure InsertTemp(var CustLedgEntry: Record "Cust. Ledger Entry")
    var
        Currency: Record Currency;
    begin
        with TempCustLedgEntry do begin
          if Get(CustLedgEntry."Entry No.") then
            exit;
          TempCustLedgEntry := CustLedgEntry;
          Insert;
          if PrintAmountInLCY then begin
            Clear(TempCurrency);
            TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            if TempCurrency.Insert then;
            exit;
          end;
          if TempCurrency.Get("Currency Code") then
            exit;
          if TempCurrency.Get('') and ("Currency Code" = GLSetup."LCY Code") then
            exit;
          if TempCurrency.Get(GLSetup."LCY Code") and ("Currency Code" = '') then
            exit;
          if "Currency Code" <> '' then
            Currency.Get("Currency Code")
          else begin
            Clear(Currency);
            Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
          end;
          TempCurrency := Currency;
          TempCurrency.Insert;
        end;
    end;

    local procedure GetPeriodIndex(Date: Date): Integer
    var
        i: Integer;
    begin
        for i := 1 to ArrayLen(PeriodEndDate) do
          if Date in [PeriodStartDate[i]..PeriodEndDate[i]] then
            exit(i);
    end;

    local procedure Pct(a: Decimal;b: Decimal): Text[30]
    begin
        if b <> 0 then
          exit(Format(ROUND(100 * a / b,0.1),0,'<Sign><Integer><Decimals,2>') + '%');
    end;

    local procedure UpdateCurrencyTotals()
    var
        i: Integer;
    begin
        TempCurrency2.Code := CurrencyCode;
        if TempCurrency2.Insert then;
        with TempCurrencyAmount do begin
          for i := 1 to ArrayLen(TotalCustLedgEntry) do begin
            "Currency Code" := CurrencyCode;
            Date := PeriodStartDate[i];
            if Find then begin
              Amount := Amount + TotalCustLedgEntry[i]."Remaining Amount";
              Modify;
            end else begin
              "Currency Code" := CurrencyCode;
              Date := PeriodStartDate[i];
              Amount := TotalCustLedgEntry[i]."Remaining Amount";
              Insert;
            end;
          end;
          "Currency Code" := CurrencyCode;
          Date := 99991231D;
          if Find then begin
            Amount := Amount + TotalCustLedgEntry[1].Amount;
            Modify;
          end else begin
            "Currency Code" := CurrencyCode;
            Date := 99991231D;
            Amount := TotalCustLedgEntry[1].Amount;
            Insert;
          end;
        end;
    end;


    procedure InitializeRequest(NewEndingDate: Date;NewAgingBy: Option;NewPeriodLength: DateFormula;NewPrintAmountInLCY: Boolean;NewPrintDetails: Boolean;NewHeadingType: Option;NewPagePercust: Boolean)
    begin
        EndingDate := NewEndingDate;
        AgingBy := NewAgingBy;
        PeriodLength := NewPeriodLength;
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintDetails := NewPrintDetails;
        HeadingType := NewHeadingType;
        NewPagePercustomer := NewPagePercust;
    end;
}

