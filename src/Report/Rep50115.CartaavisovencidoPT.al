#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50115 "Carta aviso vencido-PT"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Carta aviso vencido-PT.rdlc';
    Caption = 'Carta aviso vencido-PT';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.") where("No enviar cartas contables" = const(false));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Date Filter";
            column(ReportForNavId_6836; 6836)
            {
            }
            column(CompanyInfo1Picture; CompanyInfo1.Picture)
            {
            }
            column(CompanyInfo3Picture; CompanyInfo1.Picture)
            {
            }
            column(CustomerName; Customer.Name + ' ' + Customer."Name 2")
            {
            }
            column(CustomerAddress; Customer.Address + ' ' + Customer."Address 2")
            {
            }
            column(CustomerPostCode; Customer."Post Code" + ' ' + Customer.City)
            {
            }
            column(CustomerCounty; Customer.County)
            {
            }
            column(CustomerCountryRegionCode; Customer."Country/Region Code")
            {
            }
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(DateFilter_Cust; StrSubstNo(Text000, CustDateFilter))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(PrintAmountsInLCY; PrintAmountsInLCY)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(TableFilter_Cust; Customer.TableCaption + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(RemainingAmtCaption; RemainingAmtCaption)
            {
            }
            column(No_Customer; "No.")
            {
            }
            column(Name_Cust; Name)
            {
            }
            column(PhoneNo_Customer; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(StartBalanceLCY; StartBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(StartCustCreditAmountAdj; StartCustCreditAmountAdj)
            {
                AutoFormatType = 1;
            }
            column(StartCustDebitAmountAdj; StartCustDebitAmountAdj)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceLCY; CustBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(StartBalAdjLCYCustBody; StartBalAdjLCY)
            {
            }
            column(StartCustDAmtDCorrDebitApp; StartCustDebitAmount + DebitCorrection + DebitApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(StartCustCAmtCCorrCreditApp; StartCustCreditAmount + CreditCorrection + CreditApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCYBalAdjLCY; StartBalanceLCY + StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(CreditTotal; StartCustCreditAmountTotal + CreditCorrection + CreditApplicationRounding)
            {
            }
            column(DebitCrrctn; DebitCorrectionTotal)
            {
            }
            column(DebitAppRundCtrl1; DebitApplicationRounding)
            {
            }
            column(CreditAppRundCtrl1; CreditApplicationRounding)
            {
            }
            column(StartCustDebitAmtTotal; StartCustDebitAmountTotal)
            {
            }
            column(StartCustCreditAmtTotal; StartCustCreditAmountTotal)
            {
            }
            column(CreditCorrectionCtrl1; CreditCorrectionTotal)
            {
            }
            column(SBalLCYCLEAmtLCYCorrApp; StartBalanceLCY + "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(GlobalDim2Filter_Cust; "Global Dimension 2 Filter")
            {
            }
            column(CustomerDetailTrialBalCaption; CustomerDetailTrialBalCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(AllamountsareinLCYCaption; AllamountsareinLCYCaptionLbl)
            {
            }
            column(Notes; NotesLbl)
            {
            }
            column(CustLedgerEntryPostingDateCaption; CustLedgerEntryPostingDateCaptionLbl)
            {
            }
            column(CustLedgerEntryDocumentTypeCaption; CustLedgerEntryDocumentTypeCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(CustBalanceLCYCaption; CustBalanceLCYCaptionLbl)
            {
            }
            column(AdjofOpeningBalanceCaption; AdjofOpeningBalanceCaptionLbl)
            {
            }
            column(TotalLCYBeforePeriodCaption; TotalLCYBeforePeriodCaptionLbl)
            {
            }
            column(TotalLCYCaption; TotalLCYCaptionLbl)
            {
            }
            column(TotalAdjofOpeningBalanceCaption; TotalAdjofOpeningBalanceCaptionLbl)
            {
            }
            column(texto1; texto1)
            {
            }
            column(texto2; texto2)
            {
            }
            column(texto3; texto3)
            {
            }
            column(texto4; texto4)
            {
            }
            column(texto5; texto5)
            {
            }
            column(texto6; texto6)
            {
            }
            column(texto7; texto7)
            {
            }
            column(texto8; texto8)
            {
            }
            column(texto9; texto9)
            {
            }
            column(texto10; texto10)
            {
            }
            column(texto11; texto11)
            {
            }
            column(texto12; texto12)
            {
            }
            column(texto13; texto13)
            {
            }
            column(texto14; texto14)
            {
            }
            column(texto15; texto15)
            {
            }
            column(texto16; texto16)
            {
            }
            column(texto17; texto17)
            {
            }
            column(texto18; texto18)
            {
            }
            column(texto19; texto19)
            {
            }
            column(texto20; texto20)
            {
            }
            column(texto21; texto21)
            {
            }
            column(texto22; texto22)
            {
            }
            column(texto23; texto23)
            {
            }
            column(texto24; texto24)
            {
            }
            column(texto25; texto25)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Date Filter" = field("Date Filter");
                DataItemTableView = sorting("Customer No.", "Posting Date") where("Payment Method Code" = filter('PAGARE' | 'TRANSFEREN'), Open = const(true));
                column(ReportForNavId_8503; 8503)
                {
                }
                column(StartBalLCYBalAdjLCYAmtLCY; StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)")
                {
                    AutoFormatType = 1;
                }
                column(PostDate_CustLedgEntry; Format("Posting Date"))
                {
                }
                column(DocType_CustLedgEntry; "Document Type")
                {
                }
                column(DocNo_CustLedgEntry; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_CustLedgEntry; Description)
                {
                    IncludeCaption = true;
                }
                column(CustCredit; CustCredit)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustDebit; CustDebit)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustRemainAmt; CustRemainAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(EntryNo_CustLedgEntry; "Entry No.")
                {
                    IncludeCaption = true;
                }
                column(CustCurrencyCode; CustCurrencyCode)
                {
                }
                column(CustBalanceLCYCtrl56; CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(GlblDim1Code_CustLedgEntry; "Global Dimension 1 Code")
                {
                }
                column(FechaVto; "Cust. Ledger Entry"."Due Date")
                {
                }
                column(Ndoc; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(FechaFac; "Cust. Ledger Entry"."Posting Date")
                {
                }
                column(ImpPdte; "Cust. Ledger Entry"."Remaining Amt. (LCY)")
                {
                }
                column(totalImpPdte; totalImpPdte)
                {
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = field("Entry No.");
                    DataItemTableView = sorting("Cust. Ledger Entry No.", "Entry Type", "Posting Date") where("Entry Type" = const("Correction of Remaining Amount"));
                    column(ReportForNavId_6942; 6942)
                    {
                    }
                    column(DocType1_CustLedgEntry; "Cust. Ledger Entry"."Document Type")
                    {
                    }
                    column(EntryType_DtdCustLedgEntry; "Entry Type")
                    {
                    }
                    column(DebitCorrection; DebitCorrection)
                    {
                        AutoFormatType = 1;
                    }
                    column(CreditCorrection; CreditCorrection)
                    {
                        AutoFormatType = 1;
                    }
                    column(CustBalanceLCYCtrl61; CustBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(EntryNo_DtdCustLedgEntry; "Entry No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                    begin
                        Correction := Correction + "Amount (LCY)";
                        if Correction > 0 then begin
                            DebitCorrection := Correction;
                            DebitCorrectionTotal := DebitCorrectionTotal + "Amount (LCY)";
                        end else begin
                            CreditCorrection := Correction;
                            CreditCorrectionTotal := CreditCorrectionTotal + "Amount (LCY)";
                        end;
                        CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                        CustBalanceLCYTotal := CustBalanceLCYTotal + "Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetFilter("Posting Date", CustDateFilter);
                        Correction := 0;
                    end;
                }
                dataitem("Detailed Cust. Ledg. Entry2"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = field("Entry No.");
                    DataItemTableView = sorting("Cust. Ledger Entry No.", "Entry Type", "Posting Date") where("Entry Type" = const("Appln. Rounding"));
                    column(ReportForNavId_7757; 7757)
                    {
                    }
                    column(DocNoCtrl31_CustLedgEntry; "Cust. Ledger Entry"."Document No.")
                    {
                    }
                    column(EntryType_DtdCustLedgEntry2; "Entry Type")
                    {
                    }
                    column(DebitApplicationRounding; DebitApplicationRounding)
                    {
                        AutoFormatType = 1;
                    }
                    column(CreditApplicationRounding; CreditApplicationRounding)
                    {
                        AutoFormatType = 1;
                    }
                    column(CustBalanceLCYCtrl73; CustBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(CustLedgENo_DtdCustLedgEntry2; "Cust. Ledger Entry No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        ApplicationRounding := ApplicationRounding + "Amount (LCY)";
                        if ApplicationRounding > 0 then begin
                            DebitApplicationRounding := ApplicationRounding;
                            DebitApplicationRoundingTotal := DebitApplicationRoundingTotal + DebitApplicationRounding;
                        end
                        else begin
                            CreditApplicationRounding := ApplicationRounding;
                            CreditApplicationRoundingTotal := CreditApplicationRoundingTotal + CreditApplicationRounding;
                        end;
                        CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                        CustBalanceLCYTotal := CustBalanceLCYTotal + "Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetFilter("Posting Date", CustDateFilter);
                    end;
                }

                trigger OnAfterGetRecord()
                begin



                    Fechalimite := Today;

                    if "Cust. Ledger Entry"."Due Date" > Fechalimite then begin
                        CurrReport.Skip;
                    end;

                    CarteraDoc.Reset;
                    CarteraDoc.SetRange(CarteraDoc."Document No.", "Cust. Ledger Entry"."Document No.");
                    if CarteraDoc.FindFirst then begin
                        if CarteraDoc.Accepted = 1 then begin
                            CurrReport.Skip;
                        end;
                    end;


                    CalcFields(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)",
                      "Debit Amount", "Credit Amount");
                    CustLedgEntryExists := true;
                    if PrintAmountsInLCY then begin
                        CustAmount := "Amount (LCY)";
                        CustDebit := "Debit Amount (LCY)";
                        CustCredit := "Credit Amount (LCY)";
                        CustRemainAmount := "Remaining Amt. (LCY)";
                        CustCurrencyCode := '';
                    end else begin
                        CustAmount := Amount;
                        CustDebit := "Debit Amount";
                        CustCredit := "Credit Amount";
                        CustRemainAmount := "Remaining Amount";
                        CustCurrencyCode := "Currency Code";
                    end;
                    CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                    StartCustCreditAmount := StartCustCreditAmount + "Credit Amount (LCY)";
                    StartCustDebitAmount := StartCustDebitAmount + "Debit Amount (LCY)";
                    if ("Document Type" = "document type"::Payment) or ("Document Type" = "document type"::Refund) then
                        CustEntryDueDate := 0D
                    else
                        CustEntryDueDate := "Due Date";

                    StartCustCreditAmountTotal := StartCustCreditAmountTotal + "Credit Amount (LCY)";
                    StartCustDebitAmountTotal := StartCustDebitAmountTotal + "Debit Amount (LCY)";

                    CustBalanceLCYTotal := CustBalanceLCYTotal + "Amount (LCY)";
                end;

                trigger OnPreDataItem()
                begin
                    CustLedgEntryExists := false;
                    CurrReport.CreateTotals(CustAmount, CustDebit, CustCredit, "Amount (LCY)");
                    StartCustDebitAmount := 0;
                    StartCustCreditAmount := 0;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(ReportForNavId_5444; 5444)
                {
                }
                column(CustomerNameCtrl48; Customer.Name)
                {
                }
                column(CustBalanceLCYCtrl62; CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(StartBalAdjLCYCtrl81; StartBalAdjLCY)
                {
                }
                column(CustBalLCYDAmtDAmtAdj; CustBalanceLCY - StartCustDebitAmount - StartCustDebitAmountAdj)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustBalLCYCAmtCAmtAdj; CustBalanceLCY - StartCustCreditAmount - StartCustCreditAmountAdj)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(VStartBalanceLCYTotalDataset; StartBalanceLCYTotal)
                {
                }
                column(VStartBalAdjLCYTotalDataset; StartBalAdjLCYTotal)
                {
                }
                column(VCustBalanceLCYTotalDataset; CustBalanceLCYTotal)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not CustLedgEntryExists and ((StartBalanceLCY = 0) or ExcludeBalanceOnly) then begin
                        StartBalanceLCY := 0;
                        CurrReport.Skip;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ///IF PrintOnlyOnePerPage THEN
                ///PageGroupNo := PageGroupNo + 1;

                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                if CustDateFilter <> '' then begin
                    if GetRangeMin("Date Filter") <> 0D then begin
                        SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
                        CalcFields("Net Change (LCY)");
                        StartBalanceLCY := "Net Change (LCY)";
                        StartCustDebitAmount := "Cust. Ledger Entry"."Debit Amount (LCY)";
                        StartCustCreditAmount := "Cust. Ledger Entry"."Credit Amount (LCY)";
                    end;
                    SetFilter("Date Filter", CustDateFilter);
                    CalcFields("Net Change (LCY)");
                    StartBalAdjLCY := "Net Change (LCY)";
                    CustLedgEntry.SetCurrentkey("Customer No.", "Posting Date");
                    CustLedgEntry.SetRange("Customer No.", Customer."No.");
                    CustLedgEntry.SetFilter("Posting Date", CustDateFilter);
                    if CustLedgEntry.Find('-') then
                        repeat
                            CustLedgEntry.SetFilter("Date Filter", CustDateFilter);
                            CustLedgEntry.CalcFields("Amount (LCY)");
                            StartBalAdjLCY := StartBalAdjLCY - CustLedgEntry."Amount (LCY)";
                            "Detailed Cust. Ledg. Entry".SetCurrentkey("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                            "Detailed Cust. Ledg. Entry".SetRange("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                            "Detailed Cust. Ledg. Entry".SetFilter("Entry Type", '%1|%2',
                              "Detailed Cust. Ledg. Entry"."entry type"::"Correction of Remaining Amount",
                              "Detailed Cust. Ledg. Entry"."entry type"::"Appln. Rounding");
                            "Detailed Cust. Ledg. Entry".SetFilter("Posting Date", CustDateFilter);
                            if "Detailed Cust. Ledg. Entry".Find('-') then
                                repeat
                                    StartBalAdjLCY := StartBalAdjLCY - "Detailed Cust. Ledg. Entry"."Amount (LCY)";
                                until "Detailed Cust. Ledg. Entry".Next = 0;
                            "Detailed Cust. Ledg. Entry".Reset;
                        until CustLedgEntry.Next = 0;
                end;
                CurrReport.PrintonlyIfDetail := ExcludeBalanceOnly or (StartBalanceLCY = 0);
                CustBalanceLCY := StartBalanceLCY + StartBalAdjLCY;
                if StartBalAdjLCY > 0 then begin
                    StartCustDebitAmountAdj := StartBalAdjLCY;
                    StartCustCreditAmountAdj := 0;
                end else begin
                    StartCustDebitAmountAdj := 0;
                    StartCustCreditAmountAdj := StartBalAdjLCY;
                end;
                StartBalanceLCYTotal := StartBalanceLCYTotal + StartBalanceLCY;
                StartBalAdjLCYTotal := StartBalAdjLCYTotal + StartBalAdjLCY;
                CustBalanceLCYTotal := CustBalanceLCYTotal + CustBalanceLCY;


                Fechalimite := Today;
                totalImpPdte := 0;

                CustLedgerEntry.Reset;
                CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", Customer."No.");
                CustLedgerEntry.SetRange(CustLedgerEntry.Open, true);
                CustLedgerEntry.SetFilter(CustLedgerEntry."Payment Method Code", 'PAGARE|TRANSFEREN');
                if CustLedgerEntry.FindFirst then
                    repeat
                        if CustLedgerEntry."Due Date" < Fechalimite then begin
                            CarteraDoc.Reset;
                            CarteraDoc.SetRange(CarteraDoc."Document No.", CustLedgerEntry."Document No.");
                            if CarteraDoc.FindFirst then begin
                                if CarteraDoc.Accepted <> 1 then begin
                                    CustLedgerEntry.CalcFields(CustLedgerEntry."Remaining Amount", "Remaining Amt. (LCY)");
                                    totalImpPdte := totalImpPdte + CustLedgerEntry."Remaining Amt. (LCY)";
                                end;
                            end;
                        end;
                    until CustLedgerEntry.Next = 0;


                if totalImpPdte = 0 then begin
                    CurrReport.Skip;
                end;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;

                ///CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;

                CurrReport.CreateTotals("Cust. Ledger Entry"."Amount (LCY)", StartBalanceLCY, StartBalAdjLCY, Correction, ApplicationRounding,
                                         "Cust. Ledger Entry"."Debit Amount (LCY)", "Cust. Ledger Entry"."Credit Amount (LCY)",
                                         StartCustDebitAmount, StartCustCreditAmount);
                StartBalanceLCYTotal := 0;
                StartBalAdjLCYTotal := 0;
                CustBalanceLCYTotal := 0;
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
                    field(ShowAmountsInLCY; PrintAmountsInLCY)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Amounts in LCY';
                    }
                    field(NewPageperCustomer; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic;
                        Caption = 'New Page per Customer';
                    }
                    field(ExcludeCustHaveaBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Exclude Customers That Have a Balance Only';
                        MultiLine = true;
                    }
                    field("Dias que falta para vencer"; Dias)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Dias que falta para vencer';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            PrintOnlyOnePerPage := true;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin





        CustFilter := Customer.GetFilters;
        CustDateFilter := Customer.GetFilter("Date Filter");
        with "Cust. Ledger Entry" do
            if PrintAmountsInLCY then begin
                AmountCaption := FieldCaption("Amount (LCY)");
                RemainingAmtCaption := FieldCaption("Remaining Amt. (LCY)");
            end else begin
                AmountCaption := FieldCaption(Amount);
                RemainingAmtCaption := FieldCaption("Remaining Amount");
            end;

        CompanyInfo1.Get;
        CompanyInfo1.CalcFields(Picture);


        texto1 := 'Estimado cliente,';
        texto2 := 'A presente serve para detalhar as próximas faturas que estão prestes a expirar';
        texto3 := 'Por favor, reveja as informações abaixo e faça as transferências bancárias';
        texto4 := 'correspondentes no vencimento. Facilitamos-lhe as nossas contas de débito';
        texto5 := 'para que possa escolher para que entidade pretende transferir:';
        texto6 := '';
        texto7 := 'Santander: ES5200491021192110275678';
        texto8 := 'BBVA: ES5001820529200201575004';
        texto9 := 'Cajamar: ES4430582275911021004521';
        texto10 := 'Também gostaríamos de informar que, por comodidade, pode alterar o seu';
        texto12 := 'método de pagamento para débito em conta. É totalmente gratuito e não terá';

        texto13 := 'que se preocupar com a emissão de transferências ou notas promissórias';
        texto14 := 'Apenas o IBAN da sua conta é necessário, informação que está totalmente';
        texto15 := 'protegida pela nossa política de proteção de dados.';
        texto16 := 'Se deseja modificar o seu método de pagamento, contate-nos por e-mail a:';
        texto17 := 'administracion1@hagen.es, ou ligando para os nosso escritório onde o';
        texto18 := 'ajudaremos no departamento de administração.';
        texto19 := 'Se, após a receção desta comunicação, já tiverem emitido a transferência';
        texto20 := 'bancária, Pedimos desculpa pelo inconveniente .Caso tenha alguma dúvida ou';
        texto21 := 'sugestão, não hesite em contactar-nos.';
        texto22 := 'Agradecemos a sua cooperação antecipadamente.';



        texto23 := 'Com os nossos melhores cumprimentos.';
        texto24 := CompanyInfo1.Name;
        texto25 := 'Dpto. Administración.';
    end;

    var
        Text000: label 'Period: %1';
        CustLedgEntry: Record "Cust. Ledger Entry";
        PrintAmountsInLCY: Boolean;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        CustFilter: Text;
        CustDateFilter: Text[30];
        AmountCaption: Text[80];
        RemainingAmtCaption: Text[30];
        CustAmount: Decimal;
        CustRemainAmount: Decimal;
        CustBalanceLCY: Decimal;
        CustCurrencyCode: Code[10];
        CustEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        StartBalAdjLCY: Decimal;
        Correction: Decimal;
        ApplicationRounding: Decimal;
        CustLedgEntryExists: Boolean;
        PageGroupNo: Integer;
        StartCustDebitAmount: Decimal;
        StartCustCreditAmount: Decimal;
        CustCredit: Decimal;
        CustDebit: Decimal;
        StartCustDebitAmountAdj: Decimal;
        StartCustCreditAmountAdj: Decimal;
        DebitCorrection: Decimal;
        CreditCorrection: Decimal;
        DebitApplicationRounding: Decimal;
        CreditApplicationRounding: Decimal;
        StartCustCreditAmountTotal: Decimal;
        StartCustDebitAmountTotal: Decimal;
        DebitCorrectionTotal: Decimal;
        CreditCorrectionTotal: Decimal;
        DebitApplicationRoundingTotal: Decimal;
        CreditApplicationRoundingTotal: Decimal;
        StartBalanceLCYTotal: Decimal;
        StartBalAdjLCYTotal: Decimal;
        CustBalanceLCYTotal: Decimal;
        CustomerDetailTrialBalCaptionLbl: label 'Customer - Detail Trial Bal.';
        CurrReportPageNoCaptionLbl: label 'Page';
        AllamountsareinLCYCaptionLbl: label 'All amounts are in LCY';
        NotesLbl: label 'This report also includes customers that only have balances.';
        CustLedgerEntryPostingDateCaptionLbl: label 'Posting Date';
        CustLedgerEntryDocumentTypeCaptionLbl: label 'Document Type';
        DebitCaptionLbl: label 'Debit';
        CreditCaptionLbl: label 'Credit';
        CustBalanceLCYCaptionLbl: label 'Balance (LCY)';
        AdjofOpeningBalanceCaptionLbl: label 'Adj. of Opening Balance';
        TotalLCYBeforePeriodCaptionLbl: label 'Total (LCY) Before Period';
        TotalLCYCaptionLbl: label 'Total (LCY)';
        TotalAdjofOpeningBalanceCaptionLbl: label 'Total Adj. of Opening Balance';
        Dias: DateFormula;
        Fechalimite: Date;
        texto1: Text;
        texto2: Text;
        texto3: Text;
        texto4: Text;
        texto5: Text;
        texto6: Text;
        texto7: Text;
        texto8: Text;
        texto9: Text;
        texto10: Text;
        texto11: Text;
        texto12: Text;
        texto13: Text;
        texto14: Text;
        texto15: Text;
        CarteraDoc: Record "Cartera Doc.";
        totalImpPdte: Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CompanyInfo1: Record "Company Information";
        texto16: Text;
        texto17: Text;
        texto18: Text;
        texto19: Text;
        texto20: Text;
        texto21: Text;
        texto22: Text;
        texto23: Text;
        texto24: Text;
        texto25: Text;


    procedure InitializeRequest(ShowAmountInLCY: Boolean; SetPrintOnlyOnePerPage: Boolean; SetExcludeBalanceOnly: Boolean)
    begin
        PrintOnlyOnePerPage := SetPrintOnlyOnePerPage;
        PrintAmountsInLCY := ShowAmountInLCY;
        ExcludeBalanceOnly := SetExcludeBalanceOnly;
    end;
}

