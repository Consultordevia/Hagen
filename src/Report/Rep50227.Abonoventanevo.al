#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50227 "Abono venta nevo"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Abono venta nevo.rdlc';
    Caption = 'Sales - Credit Memo';
    Permissions = TableData "Sales Shipment Buffer"=rimd;

    dataset
    {
        dataitem("Sales Cr.Memo Header";"Sales Cr.Memo Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.","Sell-to Customer No.","No. Printed";
            RequestFilterHeading = 'Posted Sales Credit Memo';
            column(ReportForNavId_8098; 8098)
            {
            }
            column(No_SalesCrMemoHeader;"No.")
            {
            }
            dataitem(CopyLoop;"Integer")
            {
                DataItemTableView = sorting(Number);
                column(ReportForNavId_5701; 5701)
                {
                }
                dataitem(PageLoop;"Integer")
                {
                    DataItemTableView = sorting(Number) where(Number=const(1));
                    column(ReportForNavId_6455; 6455)
                    {
                    }
                    column(CompanyInfo2Picture;CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture;CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfoPicture;CompanyInfo3.Picture)
                    {
                    }
                    column(SalesCorrectiveInvCopy;StrSubstNo(Text1100001,CopyText))
                    {
                    }
                    column(CustAddr1;CustAddr[1])
                    {
                    }
                    column(CompanyAddr1;CompanyAddr[1])
                    {
                    }
                    column(CustAddr2;CustAddr[2])
                    {
                    }
                    column(CompanyAddr2;CompanyAddr[2])
                    {
                    }
                    column(CustAddr3;CustAddr[3])
                    {
                    }
                    column(CompanyAddr3;CompanyAddr[3])
                    {
                    }
                    column(CustAddr4;CustAddr[4])
                    {
                    }
                    column(CompanyAddr4;CompanyAddr[4])
                    {
                    }
                    column(CustAddr5;CustAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo;CompanyInfo."Phone No.")
                    {
                    }
                    column(CustAddr6;CustAddr[6])
                    {
                    }
                    column(CompanyInfoHomePage;CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEMail;CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoVATRegNo;CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo;CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName;CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo;CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BilltoCustNo_SalesCrMemoHeader;"Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(PostDate_SalesCrMemoHeader;Format("Sales Cr.Memo Header"."Posting Date",0,4))
                    {
                    }
                    column(VATNoText;VATNoText)
                    {
                    }
                    column(VATRegNo_SalesCrMemoHeader;"Sales Cr.Memo Header"."VAT Registration No.")
                    {
                    }
                    column(SalesPersonText;SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName;SalesPurchPerson.Name)
                    {
                    }
                    column(AppliedToText;AppliedToText)
                    {
                    }
                    column(ReferenceText;ReferenceText)
                    {
                    }
                    column(YourRef_SalesCrMemoHeader;"Sales Cr.Memo Header"."Your Reference")
                    {
                    }
                    column(CustAddr7;CustAddr[7])
                    {
                    }
                    column(CustAddr8;CustAddr[8])
                    {
                    }
                    column(CompanyAddr5;CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6;CompanyAddr[6])
                    {
                    }
                    column(DocDate_SalesCrMemoHeader;Format("Sales Cr.Memo Header"."Document Date",0,4))
                    {
                    }
                    column(PricIncVAT_SalesCrMemoHeader;"Sales Cr.Memo Header"."Prices Including VAT")
                    {
                    }
                    column(ReturnOrderNoText;ReturnOrderNoText)
                    {
                    }
                    column(RetOrderNo_SalesCrMemoHeader;"Sales Cr.Memo Header"."Return Order No.")
                    {
                    }
                    column(PageCaption;PageCaptionCap)
                    {
                    }
                    column(OutputNo;OutputNo)
                    {
                    }
                    column(PricInclVAT1_SalesCrMemoHeader;Format("Sales Cr.Memo Header"."Prices Including VAT"))
                    {
                    }
                    column(VATBaseDiscPct_SalesCrMemoHeader;"Sales Cr.Memo Header"."VAT Base Discount %")
                    {
                    }
                    column(CorrInvNo_SalesCrMemoHeader;"Sales Cr.Memo Header"."Corrected Invoice No.")
                    {
                    }
                    column(CompanyInfoPhoneNoCaption;CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoHomePageCaption;CompanyInfoHomePageCaptionLbl)
                    {
                    }
                    column(CompanyInfoEMailCaption;CompanyInfoEMailCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegistrationNoCaption;CompanyInfoVATRegistrationNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption;CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCaption;CompanyInfoBankNameCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankAccountNoCaption;CompanyInfoBankAccountNoCaptionLbl)
                    {
                    }
                    column(SalesCrMemoHeaderNoCaption;SalesCrMemoHeaderNoCaptionLbl)
                    {
                    }
                    column(SalesCrMemoHeaderPostingDateCaption;SalesCrMemoHeaderPostingDateCaptionLbl)
                    {
                    }
                    column(CorrectedInvoiceNoCaption;CorrectedInvoiceNoCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption;DocumentDateCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesCrMemoHeaderCaption;"Sales Cr.Memo Header".FieldCaption("Bill-to Customer No."))
                    {
                    }
                    column(PricIncVAT_SalesCrMemoHeaderCaption;"Sales Cr.Memo Header".FieldCaption("Prices Including VAT"))
                    {
                    }
                    column(CACCaption;CACCaptionLbl)
                    {
                    }
                    dataitem(DimensionLoop1;"Integer")
                    {
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = sorting(Number) where(Number=filter(1..));
                        column(ReportForNavId_7574; 7574)
                        {
                        }
                        column(DimText;DimText)
                        {
                        }
                        column(Number_IntegerLine;Number)
                        {
                        }
                        column(HeaderDimensionsCaption;HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                              if not DimSetEntry1.FindSet then
                                CurrReport.Break;
                            end else
                              if not Continue then
                                CurrReport.Break;

                            Clear(DimText);
                            Continue := false;
                            repeat
                              OldDimText := DimText;
                              if DimText = '' then
                                DimText := StrSubstNo('%1 %2',DimSetEntry1."Dimension Code",DimSetEntry1."Dimension Value Code")
                              else
                                DimText :=
                                  StrSubstNo(
                                    '%1, %2 %3',DimText,
                                    DimSetEntry1."Dimension Code",DimSetEntry1."Dimension Value Code");
                              if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                DimText := OldDimText;
                                Continue := true;
                                exit;
                              end;
                            until DimSetEntry1.Next = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                              CurrReport.Break;
                        end;
                    }
                    dataitem("Sales Cr.Memo Line";"Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No."=field("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = sorting("Document No.","Line No.");
                        column(ReportForNavId_3364; 3364)
                        {
                        }
                        column(LineAmt_SalesCrMemoLine;"Line Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesCrMemoLine;Description)
                        {
                        }
                        column(No_SalesCrMemoLine;"No.")
                        {
                        }
                        column(Qty_SalesCrMemoLine;Quantity)
                        {
                        }
                        column(UOM_SalesCrMemoLine;"Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesCrMemoLine;"Unit Price")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(LineDisc_SalesCrMemoLine;"Line Discount %")
                        {
                        }
                        column(VATIdent_SalesCrMemoLine;"VAT Identifier")
                        {
                        }
                        column(PostedReceiptDate;Format(PostedReceiptDate))
                        {
                        }
                        column(Type_SalesCrMemoLine;Format(Type))
                        {
                        }
                        column(NNCTotalLineAmt;NNC_TotalLineAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(NNCTotalAmtInclVat;NNC_TotalAmountInclVat)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(NNCTotalInvDiscAmt;NNC_TotalInvDiscAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(NNCTotalAmt;NNC_TotalAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(InvDiscAmt_SalesCrMemoLine;-"Inv. Discount Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(PmtDiscAmt_SalesCrMemoLine;-"Pmt. Disc. Given Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText;TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText;TotalInclVATText)
                        {
                        }
                        column(AmtIncVAT_SalesCrMemoLine;"Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmtIncVATAmt_SalesCrMemoLine;"Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText;VATAmountLine.VATAmountText)
                        {
                        }
                        column(Amt_SalesCrMemoLine;Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(DocNo_SalesCrMemoLine;"Document No.")
                        {
                        }
                        column(LineNo_SalesCrMemoLine;"Line No.")
                        {
                        }
                        column(UnitPriceCaption;UnitPriceCaptionLbl)
                        {
                        }
                        column(SalesCrMemoLineLineDiscountCaption;SalesCrMemoLineLineDiscountCaptionLbl)
                        {
                        }
                        column(AmountCaption;AmountCaptionLbl)
                        {
                        }
                        column(PostedReceiptDateCaption;PostedReceiptDateCaptionLbl)
                        {
                        }
                        column(InvDiscountAmountCaption;InvDiscountAmountCaptionLbl)
                        {
                        }
                        column(SubtotalCaption;SubtotalCaptionLbl)
                        {
                        }
                        column(PmtDiscGivenAmountCaption;PmtDiscGivenAmountCaptionLbl)
                        {
                        }
                        column(Desc_SalesCrMemoLineCaption;FieldCaption(Description))
                        {
                        }
                        column(No_SalesCrMemoLineCaption;FieldCaption("No."))
                        {
                        }
                        column(Qty_SalesCrMemoLineCaption;FieldCaption(Quantity))
                        {
                        }
                        column(UOM_SalesCrMemoLineCaption;FieldCaption("Unit of Measure"))
                        {
                        }
                        column(VATIdent_SalesCrMemoLineCaption;FieldCaption("VAT Identifier"))
                        {
                        }
                        dataitem("Sales Shipment Buffer";"Integer")
                        {
                            DataItemTableView = sorting(Number);
                            column(ReportForNavId_1484; 1484)
                            {
                            }
                            column(SalesShptBufferPostDate;Format(SalesShipmentBuffer."Posting Date"))
                            {
                            }
                            column(SalesShptBufferQuantity;SalesShipmentBuffer.Quantity)
                            {
                                DecimalPlaces = 0:5;
                            }
                            column(ReturnReceiptCaption;ReturnReceiptCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then
                                  SalesShipmentBuffer.Find('-')
                                else
                                  SalesShipmentBuffer.Next;
                            end;

                            trigger OnPreDataItem()
                            begin
                                SetRange(Number,1,SalesShipmentBuffer.Count);
                            end;
                        }
                        dataitem(DimensionLoop2;"Integer")
                        {
                            DataItemTableView = sorting(Number) where(Number=filter(1..));
                            column(ReportForNavId_3591; 3591)
                            {
                            }
                            column(DimText1;DimText)
                            {
                            }
                            column(LineDimensionsCaption;LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                  if not DimSetEntry2.Find('-') then
                                    CurrReport.Break;
                                end else
                                  if not Continue then
                                    CurrReport.Break;

                                Clear(DimText);
                                Continue := false;
                                repeat
                                  OldDimText := DimText;
                                  if DimText = '' then
                                    DimText := StrSubstNo('%1 %2',DimSetEntry2."Dimension Code",DimSetEntry2."Dimension Value Code")
                                  else
                                    DimText :=
                                      StrSubstNo(
                                        '%1, %2 %3',DimText,
                                        DimSetEntry2."Dimension Code",DimSetEntry2."Dimension Value Code");
                                  if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                  end;
                                until DimSetEntry2.Next = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                  CurrReport.Break;

                                DimSetEntry2.SetRange("Dimension Set ID","Sales Cr.Memo Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            NNC_TotalLineAmount += "Line Amount";
                            NNC_TotalAmountInclVat += "Amount Including VAT";
                            NNC_TotalInvDiscAmount += "Inv. Discount Amount";
                            NNC_TotalAmount += Amount;

                            SalesShipmentBuffer.DeleteAll;
                            PostedReceiptDate := 0D;
                            if Quantity <> 0 then
                              PostedReceiptDate := FindPostedShipmentDate;

                            if (Type = Type::"G/L Account") and (not ShowInternalInfo) then
                              "No." := '';

                            if VATPostingSetup.Get("Sales Cr.Memo Line"."VAT Bus. Posting Group","Sales Cr.Memo Line"."VAT Prod. Posting Group") then begin
                              VATAmountLine.Init;
                              VATAmountLine."VAT Identifier" := "VAT Identifier";
                              VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                              VATAmountLine."Tax Group Code" := "Tax Group Code";
                              VATAmountLine."VAT %" := VATPostingSetup."VAT %";
                              VATAmountLine."EC %" := VATPostingSetup."EC %";
                              VATAmountLine."VAT Base" := "Sales Cr.Memo Line".Amount;
                              VATAmountLine."Amount Including VAT" := "Sales Cr.Memo Line"."Amount Including VAT";
                              VATAmountLine."Line Amount" := "Line Amount";
                              VATAmountLine."Pmt. Disc. Given Amount" := "Pmt. Disc. Given Amount";
                              VATAmountLine.SetCurrencyCode("Sales Cr.Memo Header"."Currency Code");
                              if "Allow Invoice Disc." then
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                              VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                              VATAmountLine."VAT Difference" := "VAT Difference";
                              VATAmountLine."EC Difference" := "EC Difference";
                              if "Sales Cr.Memo Header"."Prices Including VAT" then
                                VATAmountLine."Prices Including VAT" := true;
                              VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                              VATAmountLine.InsertLine;
                            end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLine.DeleteAll;
                            SalesShipmentBuffer.Reset;
                            SalesShipmentBuffer.DeleteAll;
                            FirstValueEntryNo := 0;
                            MoreLines := Find('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                              MoreLines := Next(-1) <> 0;
                            if not MoreLines then
                              CurrReport.Break;
                            SetRange("Line No.",0,"Line No.");
                            CurrReport.CreateTotals(Amount,"Amount Including VAT","Inv. Discount Amount","Pmt. Disc. Given Amount");
                        end;
                    }
                    dataitem(VATCounter;"Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ReportForNavId_6558; 6558)
                        {
                        }
                        column(VATAmtLineVATECBase;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt;VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmtPmtDiscAmt;VATAmountLine."Invoice Discount Amount" + VATAmountLine."Pmt. Disc. Given Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineECAmt;VATAmountLine."EC Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmtLineVATIdentifier;VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtLineEC;VATAmountLine."EC %")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATCaption;VATAmountLineVATCaptionLbl)
                        {
                        }
                        column(VATAmountLineVATECBaseControl105Caption;VATAmountLineVATECBaseControl105CaptionLbl)
                        {
                        }
                        column(VATAmountLineVATAmountControl106Caption;VATAmountLineVATAmountControl106CaptionLbl)
                        {
                        }
                        column(VATAmountSpecificationCaption;VATAmountSpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLineVATIdentifierCaption;VATAmountLineVATIdentifierCaptionLbl)
                        {
                        }
                        column(VATAmountLineInvDiscBaseAmountControl130Caption;VATAmountLineInvDiscBaseAmountControl130CaptionLbl)
                        {
                        }
                        column(VATAmountLineLineAmountControl135Caption;VATAmountLineLineAmountControl135CaptionLbl)
                        {
                        }
                        column(InvandPmtDiscountsCaption;InvandPmtDiscountsCaptionLbl)
                        {
                        }
                        column(ECCaption;ECCaptionLbl)
                        {
                        }
                        column(ECAmountCaption;ECAmountCaptionLbl)
                        {
                        }
                        column(VATAmountLineVATECBaseControl113Caption;VATAmountLineVATECBaseControl113CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number,1,VATAmountLine.Count);
                            CurrReport.CreateTotals(
                              VATAmountLine."Line Amount",VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount",VATAmountLine."VAT Base",VATAmountLine."VAT Amount",
                              VATAmountLine."EC Amount",VATAmountLine."Pmt. Disc. Given Amount");
                        end;
                    }
                    dataitem(VATClauseEntryCounter;"Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ReportForNavId_250; 250)
                        {
                        }
                        column(VATClauseVATIdentifier;VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATClauseCode;VATAmountLine."VAT Clause Code")
                        {
                        }
                        column(VATClauseDescription;VATClause.Description)
                        {
                        }
                        column(VATClauseDescription2;VATClause."Description 2")
                        {
                        }
                        column(VATClauseAmount;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATClausesCaption;VATClausesCap)
                        {
                        }
                        column(VATClauseVATIdentifierCaption;VATAmountLineVATIdentifierCaptionLbl)
                        {
                        }
                        column(VATClauseVATAmtCaption;VATAmountLineVATAmountControl106CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            if not VATClause.Get(VATAmountLine."VAT Clause Code") then
                              CurrReport.Skip;
                            VATClause.TranslateDescription("Sales Cr.Memo Header"."Language Code");
                        end;

                        trigger OnPreDataItem()
                        begin
                            Clear(VATClause);
                            SetRange(Number,1,VATAmountLine.Count);
                            CurrReport.CreateTotals(VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY;"Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ReportForNavId_2038; 2038)
                        {
                        }
                        column(VALSpecLCYHeader;VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate;VALExchRate)
                        {
                        }
                        column(VALVATAmtLCY;VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY;VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT1;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmtLineVATIdentifier1;VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Sales Cr.Memo Header"."Posting Date","Sales Cr.Memo Header"."Currency Code",
                                "Sales Cr.Memo Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Sales Cr.Memo Header"."Posting Date","Sales Cr.Memo Header"."Currency Code",
                                "Sales Cr.Memo Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Cr.Memo Header"."Currency Code" = '')
                            then
                              CurrReport.Break;

                            SetRange(Number,1,VATAmountLine.Count);
                            CurrReport.CreateTotals(VALVATBaseLCY,VALVATAmountLCY);

                            if GLSetup."LCY Code" = '' then
                              VALSpecLCYHeader := Text008 + Text009
                            else
                              VALSpecLCYHeader := Text008 + Format(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Cr.Memo Header"."Posting Date","Sales Cr.Memo Header"."Currency Code",1);
                            CalculatedExchRate := ROUND(1 / "Sales Cr.Memo Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount",0.00001);
                            VALExchRate := StrSubstNo(Text010,CalculatedExchRate,CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total;"Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number=const(1));
                        column(ReportForNavId_3476; 3476)
                        {
                        }
                    }
                    dataitem(Total2;"Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number=const(1));
                        column(ReportForNavId_3363; 3363)
                        {
                        }
                        column(SelltoCustNo_SalesCrMemoHeader;"Sales Cr.Memo Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1;ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2;ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3;ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4;ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5;ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6;ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7;ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8;ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddressCaption;ShiptoAddressCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesCrMemoHeaderCaption;"Sales Cr.Memo Header".FieldCaption("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not ShowShippingAddr then
                              CurrReport.Break;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    CurrReport.PageNo := 1;
                    if Number > 1 then begin
                      CopyText := FormatDocument.GetCOPYText;
                      OutputNo += 1;
                    end;

                    NNC_TotalLineAmount := 0;
                    NNC_TotalAmountInclVat := 0;
                    NNC_TotalInvDiscAmount := 0;
                    NNC_TotalAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.Preview then
                      Codeunit.Run(Codeunit::"Sales Cr. Memo-Printed","Sales Cr.Memo Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number,1,NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := Language.GetLanguageID("Language Code");

                FormatAddressFields("Sales Cr.Memo Header");
                FormatDocumentFields("Sales Cr.Memo Header");

                DimSetEntry1.SetRange("Dimension Set ID","Dimension Set ID");

                ShowCashAccountingCriteria("Sales Cr.Memo Header");

                if LogInteraction then
                  if not CurrReport.Preview then
                    if "Bill-to Contact No." <> '' then
                      SegManagement.LogDocument(
                        6,"No.",0,0,Database::Contact,"Bill-to Contact No.","Salesperson Code",
                        "Campaign No.","Posting Description",'')
                    else
                      SegManagement.LogDocument(
                        6,"No.",0,0,Database::Customer,"Sell-to Customer No.","Salesperson Code",
                        "Campaign No.","Posting Description",'');
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
                    field(NoOfCopies;NoOfCopies)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field(ShowInternalInfo;ShowInternalInfo)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if you want the printed report to show information that is only for internal use.';
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            LogInteraction := SegManagement.FindInteractTmplCode(6) <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.Get;
        CompanyInfo.Get;
        SalesSetup.Get;
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents",CompanyInfo1,CompanyInfo2,CompanyInfo3);
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then
          InitLogInteraction;
    end;

    var
        Text003: label '(Applies to %1 %2)';
        PageCaptionCap: label 'Page %1 of %2';
        GLSetup: Record "General Ledger Setup";
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        VATAmountLine: Record "VAT Amount Line" temporary;
        VATClause: Record "VAT Clause";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        Language: Record Language;
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        CurrExchRate: Record "Currency Exchange Rate";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        CustAddr: array [8] of Text[50];
        ShipToAddr: array [8] of Text[50];
        CompanyAddr: array [8] of Text[50];
        ReturnOrderNoText: Text[80];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        AppliedToText: Text;
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        FirstValueEntryNo: Integer;
        PostedReceiptDate: Date;
        NextEntryNo: Integer;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        Text008: label 'VAT Amount Specification in ';
        Text009: label 'Local Currency';
        Text010: label 'Exchange rate: %1/%2';
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        CalculatedExchRate: Decimal;
        OutputNo: Integer;
        NNC_TotalLineAmount: Decimal;
        NNC_TotalAmountInclVat: Decimal;
        NNC_TotalInvDiscAmount: Decimal;
        NNC_TotalAmount: Decimal;
        VATPostingSetup: Record "VAT Posting Setup";
        Text1100001: label 'Sales - Corrective invoice %1';
        [InDataSet]
        LogInteractionEnable: Boolean;
        CompanyInfoPhoneNoCaptionLbl: label 'Phone No.';
        CompanyInfoHomePageCaptionLbl: label 'Home Page';
        CompanyInfoEMailCaptionLbl: label 'Email';
        CompanyInfoVATRegistrationNoCaptionLbl: label 'VAT Reg. No.';
        CompanyInfoGiroNoCaptionLbl: label 'Giro No.';
        CompanyInfoBankNameCaptionLbl: label 'Bank';
        CompanyInfoBankAccountNoCaptionLbl: label 'Account No.';
        SalesCrMemoHeaderNoCaptionLbl: label 'Credit Memo No.';
        SalesCrMemoHeaderPostingDateCaptionLbl: label 'Posting Date';
        CorrectedInvoiceNoCaptionLbl: label 'Corrected Invoice No.';
        DocumentDateCaptionLbl: label 'Document Date';
        HeaderDimensionsCaptionLbl: label 'Header Dimensions';
        UnitPriceCaptionLbl: label 'Unit Price';
        SalesCrMemoLineLineDiscountCaptionLbl: label 'Discount %';
        AmountCaptionLbl: label 'Amount';
        PostedReceiptDateCaptionLbl: label 'Posted Return Receipt Date';
        InvDiscountAmountCaptionLbl: label 'Invoice Discount Amount';
        SubtotalCaptionLbl: label 'Subtotal';
        PmtDiscGivenAmountCaptionLbl: label 'Payment Discount Received Amount';
        ReturnReceiptCaptionLbl: label 'Return Receipt';
        VATClausesCap: label 'VAT Clause';
        LineDimensionsCaptionLbl: label 'Line Dimensions';
        VATAmountLineVATCaptionLbl: label 'VAT %';
        VATAmountLineVATECBaseControl105CaptionLbl: label 'VAT Base';
        VATAmountLineVATAmountControl106CaptionLbl: label 'VAT Amount';
        VATAmountSpecificationCaptionLbl: label 'VAT Amount Specification';
        VATAmountLineVATIdentifierCaptionLbl: label 'VAT Identifier';
        VATAmountLineInvDiscBaseAmountControl130CaptionLbl: label 'Invoice Discount Base Amount';
        VATAmountLineLineAmountControl135CaptionLbl: label 'Line Amount';
        InvandPmtDiscountsCaptionLbl: label 'Invoice and Payment Discounts';
        ECCaptionLbl: label 'EC %';
        ECAmountCaptionLbl: label 'EC Amount';
        VATAmountLineVATECBaseControl113CaptionLbl: label 'Total';
        ShiptoAddressCaptionLbl: label 'Ship-to Address';
        CACCaptionLbl: Text;
        CACTxt: label 'RÚgimen especial del criterio de caja';


    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(6) <> '';
    end;

    local procedure FindPostedShipmentDate(): Date
    var
        ReturnReceiptHeader: Record "Return Receipt Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo := 1;
        if "Sales Cr.Memo Line"."Return Receipt No." <> '' then
          if ReturnReceiptHeader.Get("Sales Cr.Memo Line"."Return Receipt No.") then
            exit(ReturnReceiptHeader."Posting Date");
        if "Sales Cr.Memo Header"."Return Order No." = '' then
          exit("Sales Cr.Memo Header"."Posting Date");

        case "Sales Cr.Memo Line".Type of
          "Sales Cr.Memo Line".Type::Item:
            GenerateBufferFromValueEntry("Sales Cr.Memo Line");
          "Sales Cr.Memo Line".Type::"G/L Account","Sales Cr.Memo Line".Type::Resource,
          "Sales Cr.Memo Line".Type::"Charge (Item)","Sales Cr.Memo Line".Type::"Fixed Asset":
            GenerateBufferFromShipment("Sales Cr.Memo Line");
          "Sales Cr.Memo Line".Type::" ":
            exit(0D);
        end;

        SalesShipmentBuffer.Reset;
        SalesShipmentBuffer.SetRange("Document No.","Sales Cr.Memo Line"."Document No.");
        SalesShipmentBuffer.SetRange("Line No." ,"Sales Cr.Memo Line"."Line No.");

        if SalesShipmentBuffer.Find('-') then begin
          SalesShipmentBuffer2 := SalesShipmentBuffer;
          if SalesShipmentBuffer.Next = 0 then begin
            SalesShipmentBuffer.Get(
              SalesShipmentBuffer2."Document No.",SalesShipmentBuffer2."Line No.",SalesShipmentBuffer2."Entry No.");
            SalesShipmentBuffer.Delete;
            exit(SalesShipmentBuffer2."Posting Date");
          end;
          SalesShipmentBuffer.CalcSums(Quantity);
          if SalesShipmentBuffer.Quantity <> "Sales Cr.Memo Line".Quantity then begin
            SalesShipmentBuffer.DeleteAll;
            exit("Sales Cr.Memo Header"."Posting Date");
          end;
        end else
          exit("Sales Cr.Memo Header"."Posting Date");
    end;

    local procedure GenerateBufferFromValueEntry(SalesCrMemoLine2: Record "Sales Cr.Memo Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesCrMemoLine2."Quantity (Base)";
        ValueEntry.SetCurrentkey("Document No.");
        ValueEntry.SetRange("Document No.",SalesCrMemoLine2."Document No.");
        ValueEntry.SetRange("Posting Date","Sales Cr.Memo Header"."Posting Date");
        ValueEntry.SetRange("Item Charge No.",'');
        ValueEntry.SetFilter("Entry No.",'%1..',FirstValueEntryNo);
        if ValueEntry.Find('-') then
          repeat
            if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
              if SalesCrMemoLine2."Qty. per Unit of Measure" <> 0 then
                Quantity := ValueEntry."Invoiced Quantity" / SalesCrMemoLine2."Qty. per Unit of Measure"
              else
                Quantity := ValueEntry."Invoiced Quantity";
              AddBufferEntry(
                SalesCrMemoLine2,
                -Quantity,
                ItemLedgerEntry."Posting Date");
              TotalQuantity := TotalQuantity - ValueEntry."Invoiced Quantity";
            end;
            FirstValueEntryNo := ValueEntry."Entry No." + 1;
          until (ValueEntry.Next = 0) or (TotalQuantity = 0);
    end;

    local procedure GenerateBufferFromShipment(SalesCrMemoLine: Record "Sales Cr.Memo Line")
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine2: Record "Sales Cr.Memo Line";
        ReturnReceiptHeader: Record "Return Receipt Header";
        ReturnReceiptLine: Record "Return Receipt Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesCrMemoHeader.SetCurrentkey("Return Order No.");
        SalesCrMemoHeader.SetFilter("No.",'..%1',"Sales Cr.Memo Header"."No.");
        SalesCrMemoHeader.SetRange("Return Order No.","Sales Cr.Memo Header"."Return Order No.");
        if SalesCrMemoHeader.Find('-') then
          repeat
            SalesCrMemoLine2.SetRange("Document No.",SalesCrMemoHeader."No.");
            SalesCrMemoLine2.SetRange("Line No.",SalesCrMemoLine."Line No.");
            SalesCrMemoLine2.SetRange(Type,SalesCrMemoLine.Type);
            SalesCrMemoLine2.SetRange("No.",SalesCrMemoLine."No.");
            SalesCrMemoLine2.SetRange("Unit of Measure Code",SalesCrMemoLine."Unit of Measure Code");
            if SalesCrMemoLine2.Find('-') then
              repeat
                TotalQuantity := TotalQuantity + SalesCrMemoLine2.Quantity;
              until SalesCrMemoLine2.Next = 0;
          until SalesCrMemoHeader.Next = 0;

        ReturnReceiptLine.SetCurrentkey("Return Order No.","Return Order Line No.");
        ReturnReceiptLine.SetRange("Return Order No.","Sales Cr.Memo Header"."Return Order No.");
        ReturnReceiptLine.SetRange("Return Order Line No.",SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SetRange("Line No.",SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SetRange(Type,SalesCrMemoLine.Type);
        ReturnReceiptLine.SetRange("No.",SalesCrMemoLine."No.");
        ReturnReceiptLine.SetRange("Unit of Measure Code",SalesCrMemoLine."Unit of Measure Code");
        ReturnReceiptLine.SetFilter(Quantity,'<>%1',0);

        if ReturnReceiptLine.Find('-') then
          repeat
            if "Sales Cr.Memo Header"."Get Return Receipt Used" then
              CorrectShipment(ReturnReceiptLine);
            if Abs(ReturnReceiptLine.Quantity) <= Abs(TotalQuantity - SalesCrMemoLine.Quantity) then
              TotalQuantity := TotalQuantity - ReturnReceiptLine.Quantity
            else begin
              if Abs(ReturnReceiptLine.Quantity) > Abs(TotalQuantity) then
                ReturnReceiptLine.Quantity := TotalQuantity;
              Quantity :=
                ReturnReceiptLine.Quantity - (TotalQuantity - SalesCrMemoLine.Quantity);

              SalesCrMemoLine.Quantity := SalesCrMemoLine.Quantity - Quantity;
              TotalQuantity := TotalQuantity - ReturnReceiptLine.Quantity;

              if ReturnReceiptHeader.Get(ReturnReceiptLine."Document No.") then
                AddBufferEntry(
                  SalesCrMemoLine,
                  -Quantity,
                  ReturnReceiptHeader."Posting Date");
            end;
          until (ReturnReceiptLine.Next = 0) or (TotalQuantity = 0);
    end;

    local procedure CorrectShipment(var ReturnReceiptLine: Record "Return Receipt Line")
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        SalesCrMemoLine.SetCurrentkey("Return Receipt No.","Return Receipt Line No.");
        SalesCrMemoLine.SetRange("Return Receipt No.",ReturnReceiptLine."Document No.");
        SalesCrMemoLine.SetRange("Return Receipt Line No.",ReturnReceiptLine."Line No.");
        if SalesCrMemoLine.Find('-') then
          repeat
            ReturnReceiptLine.Quantity := ReturnReceiptLine.Quantity - SalesCrMemoLine.Quantity;
          until SalesCrMemoLine.Next = 0;
    end;

    local procedure AddBufferEntry(SalesCrMemoLine: Record "Sales Cr.Memo Line";QtyOnShipment: Decimal;PostingDate: Date)
    begin
        SalesShipmentBuffer.SetRange("Document No.",SalesCrMemoLine."Document No.");
        SalesShipmentBuffer.SetRange("Line No.",SalesCrMemoLine."Line No.");
        SalesShipmentBuffer.SetRange("Posting Date",PostingDate);
        if SalesShipmentBuffer.Find('-') then begin
          SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity - QtyOnShipment;
          SalesShipmentBuffer.Modify;
          exit;
        end;

        with SalesShipmentBuffer do begin
          Init;
          "Document No." := SalesCrMemoLine."Document No.";
          "Line No." := SalesCrMemoLine."Line No.";
          "Entry No." := NextEntryNo;
          Type := SalesCrMemoLine.Type;
          "No." := SalesCrMemoLine."No.";
          Quantity := -QtyOnShipment;
          "Posting Date" := PostingDate;
          Insert;
          NextEntryNo := NextEntryNo + 1
        end;
    end;


    procedure ShowCashAccountingCriteria(SalesCrMemoHeader: Record "Sales Cr.Memo Header"): Text
    var
        VATEntry: Record "VAT Entry";
    begin
        GLSetup.Get;
        if not GLSetup."Unrealized VAT" then
          exit;
        CACCaptionLbl := '';
        VATEntry.SetRange("Document No.",SalesCrMemoHeader."No.");
        VATEntry.SetRange("Document Type",VATEntry."document type"::"Credit Memo");
        if VATEntry.FindSet then
          repeat
            if VATEntry."VAT Cash Regime" then
              CACCaptionLbl := CACTxt;
          until (VATEntry.Next = 0) or (CACCaptionLbl <> '');
        exit(CACCaptionLbl);
    end;


    procedure InitializeRequest(NewNoOfCopies: Integer;NewShowInternalInfo: Boolean;NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
    end;

    local procedure FormatAddressFields(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        FormatAddr.GetCompanyAddr(SalesCrMemoHeader."Responsibility Center",RespCenter,CompanyInfo,CompanyAddr);
        FormatAddr.SalesCrMemoBillTo(CustAddr,SalesCrMemoHeader);
        ShowShippingAddr := FormatAddr.SalesCrMemoShipTo(ShipToAddr,CustAddr,SalesCrMemoHeader);
    end;

    local procedure FormatDocumentFields(SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        with SalesCrMemoHeader do begin
          FormatDocument.SetTotalLabels("Currency Code",TotalText,TotalInclVATText,TotalExclVATText);
          FormatDocument.SetSalesPerson(SalesPurchPerson,"Salesperson Code",SalesPersonText);

          ReturnOrderNoText := FormatDocument.SetText("Return Order No." <> '',FieldCaption("Return Order No."));
          ReferenceText := FormatDocument.SetText("Your Reference" <> '',FieldCaption("Your Reference"));
          VATNoText := FormatDocument.SetText("VAT Registration No." <> '',FieldCaption("VAT Registration No."));
          AppliedToText :=
            FormatDocument.SetText(
              "Applies-to Doc. No." <> '',Format(StrSubstNo(Text003,Format("Applies-to Doc. Type"),"Applies-to Doc. No.")));
        end;
    end;
}

