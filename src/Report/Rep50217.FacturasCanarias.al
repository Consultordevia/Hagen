#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50217 "Facturas Canarias"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Facturas Canarias.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header";"Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.","Sell-to Customer No.","No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(ReportForNavId_5581; 5581)
            {
            }
            column(No_SalesInvHdr;"No.")
            {
            }
            column(PaymentTermsDescription;PaymentTerms.Description)
            {
            }
            column(ShipmentMethodDescription;ShipmentMethod.Description)
            {
            }
            column(PaymentMethodDescription;PaymentMethod.Description)
            {
            }
            column(PmtTermsDescCaption;PmtTermsDescCaptionLbl)
            {
            }
            column(ShpMethodDescCaption;ShpMethodDescCaptionLbl)
            {
            }
            column(PmtMethodDescCaption;PmtMethodDescCaptionLbl)
            {
            }
            column(DocDateCaption;DocDateCaptionLbl)
            {
            }
            column(HomePageCaption;HomePageCaptionLbl)
            {
            }
            column(EmailCaption;EmailCaptionLbl)
            {
            }
            column(DisplayAdditionalFeeNote;DisplayAdditionalFeeNote)
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
                    column(CompanyInfo3Picture;CompanyInfo3.Picture)
                    {
                    }
                    column(DocumentCaption;StrSubstNo(DocumentCaption,CopyText))
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
                    column(CompanyInfoVATRegistrationNo;CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoHomePage;CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail;CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoGiroNo;CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName;CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccountNo;CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BilltoCustNo_SalesInvHdr;"Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(PostingDate_SalesInvHdr;Format("Sales Invoice Header"."Posting Date",0,4))
                    {
                    }
                    column(VATNoText;VATNoText)
                    {
                    }
                    column(VATRegNo_SalesInvHeader;"Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_SalesInvHeader;Format("Sales Invoice Header"."Due Date",0,4))
                    {
                    }
                    column(SalesPersonText;SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName;SalesPurchPerson.Name)
                    {
                    }
                    column(No_SalesInvoiceHeader1;"Sales Invoice Header"."No.")
                    {
                    }
                    column(ReferenceText;ReferenceText)
                    {
                    }
                    column(YourReference_SalesInvHdr;"Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(OrderNoText;OrderNoText)
                    {
                    }
                    column(OrderNo_SalesInvHeader;"Sales Invoice Header"."Order No.")
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
                    column(DocDate_SalesInvoiceHdr;Format("Sales Invoice Header"."Document Date",0,4))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdr;"Sales Invoice Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo;OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo;Format("Sales Invoice Header"."Prices Including VAT"))
                    {
                    }
                    column(PageCaption;PageCaptionCap)
                    {
                    }
                    column(PhoneNoCaption;PhoneNoCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption;VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption;GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption;BankNameCaptionLbl)
                    {
                    }
                    column(BankAccNoCaption;BankAccNoCaptionLbl)
                    {
                    }
                    column(DueDateCaption;DueDateCaptionLbl)
                    {
                    }
                    column(InvoiceNoCaption;InvoiceNoCaptionLbl)
                    {
                    }
                    column(PostingDateCaption;PostingDateCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesInvHdrCaption;"Sales Invoice Header".FieldCaption("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdrCaption;"Sales Invoice Header".FieldCaption("Prices Including VAT"))
                    {
                    }
                    column(CACCaption;CACCaptionLbl)
                    {
                    }
                    dataitem(DimensionLoop1;"Integer")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting(Number) where(Number=filter(1..));
                        column(ReportForNavId_7574; 7574)
                        {
                        }
                        column(DimText;DimText)
                        {
                        }
                        column(Number_DimensionLoop1;Number)
                        {
                        }
                        column(HdrDimsCaption;HdrDimsCaptionLbl)
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
                    dataitem("Sales Invoice Line";"Sales Invoice Line")
                    {
                        DataItemLink = "Document No."=field("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting("Document No.","Line No.");
                        column(ReportForNavId_1570; 1570)
                        {
                        }
                        column(GetCarteraInvoice;GetCarteraInvoice)
                        {
                        }
                        column(LineAmt_SalesInvoiceLine;"Line Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Description_SalesInvLine;Description)
                        {
                        }
                        column(No_SalesInvoiceLine;"No.")
                        {
                        }
                        column(Quantity_SalesInvoiceLine;Quantity)
                        {
                        }
                        column(UOM_SalesInvoiceLine;"Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesInvLine;"Unit Price")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(LineDisc_SalesInvoiceLine;"Line Discount %")
                        {
                        }
                        column(VATIdent_SalesInvLine;"VAT Identifier")
                        {
                        }
                        column(PostedShipmentDate;Format(PostedShipmentDate))
                        {
                        }
                        column(Type_SalesInvoiceLine;Format(Type))
                        {
                        }
                        column(InvDiscountAmount;-"Inv. Discount Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal;TotalSubTotal)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount;TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmount;TotalAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalGivenAmount;TotalGivenAmount)
                        {
                        }
                        column(SalesInvoiceLineAmount;Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmountIncludingVATAmount;"Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Amount_SalesInvoiceLineIncludingVAT;"Amount Including VAT")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText;VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText;TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText;TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT;TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountVAT;TotalAmountVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseDisc_SalesInvHdr;"Sales Invoice Header"."VAT Base Discount %")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscountOnVAT;TotalPaymentDiscountOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATCalcType;VATAmountLine."VAT Calculation Type")
                        {
                        }
                        column(LineNo_SalesInvoiceLine;"Line No.")
                        {
                        }
                        column(PmtinvfromdebtpaidtoFactCompCaption;PmtinvfromdebtpaidtoFactCompCaptionLbl)
                        {
                        }
                        column(UnitPriceCaption;UnitPriceCaptionLbl)
                        {
                        }
                        column(DiscountCaption;DiscountCaptionLbl)
                        {
                        }
                        column(AmtCaption;AmtCaptionLbl)
                        {
                        }
                        column(PostedShpDateCaption;PostedShpDateCaptionLbl)
                        {
                        }
                        column(InvDiscAmtCaption;InvDiscAmtCaptionLbl)
                        {
                        }
                        column(SubtotalCaption;SubtotalCaptionLbl)
                        {
                        }
                        column(PmtDiscGivenAmtCaption;PmtDiscGivenAmtCaptionLbl)
                        {
                        }
                        column(PmtDiscVATCaption;PmtDiscVATCaptionLbl)
                        {
                        }
                        column(Description_SalesInvLineCaption;FieldCaption(Description))
                        {
                        }
                        column(No_SalesInvoiceLineCaption;FieldCaption("No."))
                        {
                        }
                        column(Quantity_SalesInvoiceLineCaption;FieldCaption(Quantity))
                        {
                        }
                        column(UOM_SalesInvoiceLineCaption;FieldCaption("Unit of Measure"))
                        {
                        }
                        column(VATIdent_SalesInvLineCaption;FieldCaption("VAT Identifier"))
                        {
                        }
                        column(IsLineWithTotals;LineNoWithTotal = "Line No.")
                        {
                        }
                        column(dto;dto)
                        {
                        }
                        dataitem("Sales Shipment Buffer";"Integer")
                        {
                            DataItemTableView = sorting(Number);
                            column(ReportForNavId_1484; 1484)
                            {
                            }
                            column(PostingDate_SalesShipmentBuffer;Format(SalesShipmentBuffer."Posting Date"))
                            {
                            }
                            column(Quantity_SalesShipmentBuffer;SalesShipmentBuffer.Quantity)
                            {
                                DecimalPlaces = 0:5;
                            }
                            column(ShpCaption;ShpCaptionLbl)
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
                                SalesShipmentBuffer.SetRange("Document No.","Sales Invoice Line"."Document No.");
                                SalesShipmentBuffer.SetRange("Line No.","Sales Invoice Line"."Line No.");

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
                            column(LineDimsCaption;LineDimsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                  if not DimSetEntry2.FindSet then
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

                                DimSetEntry2.SetRange("Dimension Set ID","Sales Invoice Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop;"Integer")
                        {
                            DataItemTableView = sorting(Number);
                            column(ReportForNavId_9462; 9462)
                            {
                            }
                            column(TempPostedAsmLineUOMCode;GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                                DecimalPlaces = 0:5;
                            }
                            column(TempPostedAsmLineQuantity;TempPostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0:5;
                            }
                            column(TempPostedAsmLineVariantCode;BlanksForIndent + TempPostedAsmLine."Variant Code")
                            {
                                DecimalPlaces = 0:5;
                            }
                            column(TempPostedAsmLineDescrip;BlanksForIndent + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostedAsmLineNo;BlanksForIndent + TempPostedAsmLine."No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                ItemTranslation: Record "Item Translation";
                            begin
                                if Number = 1 then
                                  TempPostedAsmLine.FindSet
                                else
                                  TempPostedAsmLine.Next;

                                if ItemTranslation.Get(TempPostedAsmLine."No.",
                                     TempPostedAsmLine."Variant Code",
                                     "Sales Invoice Header"."Language Code")
                                then
                                  TempPostedAsmLine.Description := ItemTranslation.Description;
                            end;

                            trigger OnPreDataItem()
                            begin
                                Clear(TempPostedAsmLine);
                                if not DisplayAssemblyInformation then
                                  CurrReport.Break;
                                CollectAsmInformation;
                                Clear(TempPostedAsmLine);
                                SetRange(Number,1,TempPostedAsmLine.Count);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PostedShipmentDate := 0D;
                            if Quantity <> 0 then
                              PostedShipmentDate := FindPostedShipmentDate;

                            if (Type = Type::"G/L Account") and (not ShowInternalInfo) then
                              "No." := '';

                            if VATPostingSetup.Get("Sales Invoice Line"."VAT Bus. Posting Group","Sales Invoice Line"."VAT Prod. Posting Group") then begin
                              VATAmountLine.Init;
                              VATAmountLine."VAT Identifier" := "VAT Identifier";
                              VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                              VATAmountLine."Tax Group Code" := "Tax Group Code";
                              VATAmountLine."VAT %" := VATPostingSetup."VAT %";
                              VATAmountLine."EC %" := VATPostingSetup."EC %";
                              VATAmountLine."VAT Base" := "Sales Invoice Line".Amount;
                              VATAmountLine."Amount Including VAT" := "Sales Invoice Line"."Amount Including VAT";
                              VATAmountLine."Line Amount" := "Line Amount";
                              VATAmountLine."Pmt. Disc. Given Amount" := "Pmt. Disc. Given Amount";
                              if "Allow Invoice Disc." then
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                              VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                              VATAmountLine.SetCurrencyCode("Sales Invoice Header"."Currency Code");
                              VATAmountLine."VAT Difference" := "VAT Difference";
                              VATAmountLine."EC Difference" := "EC Difference";
                              if "Sales Invoice Header"."Prices Including VAT" then
                                VATAmountLine."Prices Including VAT" := true;
                              VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                              VATAmountLine.InsertLine;

                              TotalSubTotal += "Line Amount";
                              TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                              TotalAmount += Amount;
                              TotalAmountVAT += "Amount Including VAT" - Amount;
                              TotalAmountInclVAT += "Amount Including VAT";
                              TotalGivenAmount -= "Pmt. Disc. Given Amount";
                              TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Pmt. Disc. Given Amount" - "Amount Including VAT");
                            end;


                            dto:='';
                            if ("Sales Invoice Line"."Dto% cabecera/oferta"<>0) and
                               ("Sales Invoice Line"."% Dto. vendedor"<>0) and
                               ("Sales Invoice Line"."Line Discount %"<>0)then begin
                                 dto:=Format("Sales Invoice Line"."% Dto. vendedor")+'+'+
                                      Format("Sales Invoice Line"."Dto% cabecera/oferta")+'+'+
                                      Format("Sales Invoice Line"."Line Discount %");
                            end;
                            if ("Sales Invoice Line"."Dto% cabecera/oferta"<>0) and
                               ("Sales Invoice Line"."% Dto. vendedor"=0) and
                               ("Sales Invoice Line"."Line Discount %"=0)then begin
                                 dto:=Format("Sales Invoice Line"."Dto% cabecera/oferta");
                            end;
                            if ("Sales Invoice Line"."Dto% cabecera/oferta"=0) and
                               ("Sales Invoice Line"."% Dto. vendedor"<>0) and
                               ("Sales Invoice Line"."Line Discount %"=0)then begin
                                 dto:=Format("Sales Invoice Line"."% Dto. vendedor");
                            end;
                            if ("Sales Invoice Line"."Dto% cabecera/oferta"=0) and
                               ("Sales Invoice Line"."% Dto. vendedor"=0) and
                               ("Sales Invoice Line"."Line Discount %"<>0)then begin
                                 dto:=Format("Sales Invoice Line"."Line Discount %");
                            end;
                            if ("Sales Invoice Line"."Dto% cabecera/oferta"<>0) and
                               ("Sales Invoice Line"."% Dto. vendedor"<>0) and
                               ("Sales Invoice Line"."Line Discount %"=0)then begin
                                 dto:=Format("Sales Invoice Line"."% Dto. vendedor")+'+'+
                                      Format("Sales Invoice Line"."Dto% cabecera/oferta");
                            end;
                            if ("Sales Invoice Line"."Dto% cabecera/oferta"<>0) and
                               ("Sales Invoice Line"."% Dto. vendedor"=0) and
                               ("Sales Invoice Line"."Line Discount %"<>0)then begin
                                 dto:=Format("Sales Invoice Line"."Dto% cabecera/oferta")+'+'+
                                      Format("Sales Invoice Line"."Line Discount %");
                            end;
                            if ("Sales Invoice Line"."Dto% cabecera/oferta"=0) and
                               ("Sales Invoice Line"."% Dto. vendedor"<>0) and
                               ("Sales Invoice Line"."Line Discount %"<>0)then begin
                                 dto:=Format("Sales Invoice Line"."% Dto. vendedor")+'+'+
                                      Format("Sales Invoice Line"."Line Discount %");
                            end;
                            if "Sales Invoice Line"."Customer Price Group"='' then begin
                                 if dto<>'' then begin
                                      dto:=dto+'+P.especial';
                                 end;
                                 if dto='' then begin
                                      dto:='P.especial';
                                 end;
                            end;
                            dto:='valor dto';
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
                            LineNoWithTotal := "Line No.";
                            SetRange("Line No.",0,"Line No.");
                            CurrReport.CreateTotals("Line Amount",Amount,"Amount Including VAT","Inv. Discount Amount","Pmt. Disc. Given Amount");
                        end;
                    }
                    dataitem(VATCounter;"Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ReportForNavId_6558; 6558)
                        {
                        }
                        column(VATAmountLineVATBase;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATAmount;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineLineAmount;VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscountAmt;VATAmountLine."Invoice Discount Amount" + VATAmountLine."Pmt. Disc. Given Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineECAmount;VATAmountLine."EC Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVAT;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmtLineVATIdentifier;VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLineEC;VATAmountLine."EC %")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATCaption;VATAmtLineVATCaptionLbl)
                        {
                        }
                        column(VATECBaseCaption;VATECBaseCaptionLbl)
                        {
                        }
                        column(VATAmountCaption;VATAmountCaptionLbl)
                        {
                        }
                        column(VATAmtSpecCaption;VATAmtSpecCaptionLbl)
                        {
                        }
                        column(VATIdentCaption;VATIdentCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption;InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption1;LineAmtCaption1Lbl)
                        {
                        }
                        column(InvPmtDiscCaption;InvPmtDiscCaptionLbl)
                        {
                        }
                        column(ECAmtCaption;ECAmtCaptionLbl)
                        {
                        }
                        column(ECCaption;ECCaptionLbl)
                        {
                        }
                        column(TotalCaption;TotalCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            if VATAmountLine."VAT Amount" = 0 then
                              VATAmountLine."VAT %" := 0;
                            if VATAmountLine."EC Amount" = 0 then
                              VATAmountLine."EC %" := 0;
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
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATClausesCaption;VATClausesCap)
                        {
                        }
                        column(VATClauseVATIdentifierCaption;VATIdentifierCaptionLbl)
                        {
                        }
                        column(VATClauseVATAmtCaption;VATAmtCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            if not VATClause.Get(VATAmountLine."VAT Clause Code") then
                              CurrReport.Skip;
                            VATClause.TranslateDescription("Sales Invoice Header"."Language Code");
                        end;

                        trigger OnPreDataItem()
                        begin
                            Clear(VATClause);
                            SetRange(Number,1,VATAmountLine.Count);
                            CurrReport.CreateTotals(VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VatCounterLCY;"Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ReportForNavId_9347; 9347)
                        {
                        }
                        column(VALSpecLCYHeader;VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate;VALExchRate)
                        {
                        }
                        column(VALVATBaseLCY;VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY;VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVAT1;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmtLineVATIdentifier1;VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VALVATBaseLCYCaption1;VALVATBaseLCYCaption1Lbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                                "Sales Invoice Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                                "Sales Invoice Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Invoice Header"."Currency Code" = '')
                            then
                              CurrReport.Break;

                            SetRange(Number,1,VATAmountLine.Count);
                            CurrReport.CreateTotals(VALVATBaseLCY,VALVATAmountLCY);

                            if GLSetup."LCY Code" = '' then
                              VALSpecLCYHeader := Text007 + Text008
                            else
                              VALSpecLCYHeader := Text007 + Format(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",1);
                            CalculatedExchRate := ROUND(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount",0.00001);
                            VALExchRate := StrSubstNo(Text009,CalculatedExchRate,CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(PaymentReportingArgument;"Payment Reporting Argument")
                    {
                        DataItemTableView = sorting("Key");
                        UseTemporary = true;
                        column(ReportForNavId_197; 197)
                        {
                        }
                        column(PaymentServiceLogo;Logo)
                        {
                        }
                        column(PaymentServiceURLText;"URL Caption")
                        {
                        }
                        column(PaymentServiceURL;GetTargetURL)
                        {
                        }

                        trigger OnPreDataItem()
                        var
                            PaymentServiceSetup: Record "Payment Service Setup";
                        begin
                            PaymentServiceSetup.CreateReportingArgs(PaymentReportingArgument,"Sales Invoice Header");
                            if IsEmpty then
                              CurrReport.Break;
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
                        column(SelltoCustNo_SalesInvHdr;"Sales Invoice Header"."Sell-to Customer No.")
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
                        column(SelltoCustNo_SalesInvHdrCaption;"Sales Invoice Header".FieldCaption("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not ShowShippingAddr then
                              CurrReport.Break;
                        end;
                    }
                    dataitem(LineFee;"Integer")
                    {
                        DataItemTableView = sorting(Number) order(ascending) where(Number=filter(1..));
                        column(ReportForNavId_300; 300)
                        {
                        }
                        column(LineFeeCaptionLbl;TempLineFeeNoteOnReportHist.ReportText)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if not DisplayAdditionalFeeNote then
                              CurrReport.Break;

                            if Number = 1 then begin
                              if not TempLineFeeNoteOnReportHist.FindSet then
                                CurrReport.Break
                            end else
                              if TempLineFeeNoteOnReportHist.Next = 0 then
                                CurrReport.Break;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                      CopyText := FormatDocument.GetCOPYText;
                      OutputNo += 1;
                    end;
                    CurrReport.PageNo := 1;

                    TotalSubTotal := 0;
                    TotalInvoiceDiscountAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalGivenAmount := 0;
                    TotalPaymentDiscountOnVAT := 0;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.Preview then
                      Codeunit.Run(Codeunit::"Sales Inv.-Printed","Sales Invoice Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + Cust."Invoice Copies" + 1;
                    if NoOfLoops <= 0 then
                      NoOfLoops := 1;
                    CopyText := '';
                    SetRange(Number,1,NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if GlobalLanguage = Language.GetLanguageID("Language Code") then
                  CurrReport.Language := Language.GetLanguageID("Language Code")
                else
                  CurrReport.Language := Language.GetLanguageID('ENU');

                FormatAddressFields("Sales Invoice Header");
                FormatDocumentFields("Sales Invoice Header");

                if not Cust.Get("Bill-to Customer No.") then
                  Clear(Cust);

                DimSetEntry1.SetRange("Dimension Set ID","Dimension Set ID");

                GetLineFeeNoteOnReportHist("No.");

                if LogInteraction then
                  if not CurrReport.Preview then begin
                    if "Bill-to Contact No." <> '' then
                      SegManagement.LogDocument(
                        SegManagement.SalesInvoiceInterDocType,"No.",0,0,Database::Contact,"Bill-to Contact No.","Salesperson Code",
                        "Campaign No.","Posting Description",'')
                    else
                      SegManagement.LogDocument(
                        SegManagement.SalesInvoiceInterDocType,"No.",0,0,Database::Customer,"Bill-to Customer No.","Salesperson Code",
                        "Campaign No.","Posting Description",'');
                  end;

                OnAfterGetRecordSalesInvoiceHeader("Sales Invoice Header");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

