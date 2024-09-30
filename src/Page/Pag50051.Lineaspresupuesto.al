#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50051 "Lineas presupuesto"
{
    AutoSplitKey = true;
    Caption = 'Lineas presupuesto';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = where("Document Type" = filter(Quote));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Referencia; Rec.Referencia)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin



                        if Rec.Type = 2 then begin
                            PEDIDO := '';
                            FECHAPED := 0D;
                            CANTIDAD := 0;
                            PRECIO := 0;
                            DTO := 0;
                            REC111.SetCurrentkey(REC111."Sell-to Customer No.", REC111."No.");
                            REC111.SetRange(REC111."Sell-to Customer No.", Rec."Sell-to Customer No.");
                            REC111.SetRange(REC111."No.", Rec."No.");
                            if REC111.FindLast then begin
                                PEDIDO := REC111."Order No.";
                                FECHAPED := REC111."Posting Date";
                                CANTIDAD := REC111.Quantity;
                                PRECIO := REC111."Unit Price";
                                DTO := REC111."Line Discount %";
                            end;



                        end;
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = not IsCommentLine;
                    Enabled = not IsCommentLine;
                    ShowMandatory = (not IsCommentLine) and (Rec."No." <> '');
                    StyleExpr = Color;
                    ToolTip = 'Specifies how many units are being sold.';

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate;
                        RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    QuickEntry = false;
                    ShowMandatory = not IsCommentLine;
                    StyleExpr = Color;
                    ToolTip = 'Specifies the number of a general ledger account, item, resource, additional cost, or fixed asset, depending on the contents of the Type field.';

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate;

                        UpdateEditableOnRow;
                        UpdateTypeText;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    QuickEntry = false;
                    ShowMandatory = not IsCommentLine;
                    StyleExpr = Color;
                    ToolTip = 'Specifies a description of the entry of the product to be sold. To add a non-transactional text line, fill in the Description field only.';

                    trigger OnValidate()
                    begin
                        UpdateEditableOnRow;

                        if Rec."No." = xRec."No." then
                            exit;

                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate;

                        UpdateTypeText;
                    end;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = not IsCommentLine;
                    Enabled = not IsCommentLine;
                    QuickEntry = false;
                    ShowMandatory = (not IsCommentLine) and (Rec."No." <> '');
                    StyleExpr = Color;
                    ToolTip = 'Specifies the price for one unit on the sales line.';

                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = not IsCommentLine;
                    Enabled = not IsCommentLine;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies the discount percentage that is granted for the item on the line.';

                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("% Dto. vendedor"; Rec."% Dto. vendedor")
                {
                    ApplicationArea = Basic;
                    QuickEntry = false;
                    StyleExpr = COLORDTOVENDE;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = not IsCommentLine;
                    Enabled = not IsCommentLine;
                    QuickEntry = false;
                    ShowMandatory = (not IsCommentLine) and (Rec."No." <> '');
                    StyleExpr = Color;
                    ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';

                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate;
                    end;
                }
                field(FECHA1; FECHA1)
                {
                    ApplicationArea = Basic;
                    Caption = 'Contenedor 95%';
                    Editable = false;
                    QuickEntry = false;
                    StyleExpr = Color1;
                }
                field(FECHA2; FECHA2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Fecha prox.';
                    Editable = false;
                    QuickEntry = false;
                    StyleExpr = Color2;
                }
                field(ean; Rec.ean)
                {
                    ApplicationArea = Basic;
                    QuickEntry = false;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = Basic, Suite;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate;
                    end;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Advanced;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies the type of entity that will be posted for this sales line, such as Item, Resource, or G/L Account.';

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate;
                        UpdateEditableOnRow;
                        UpdateTypeText;
                    end;
                }
                field(FilteredTypeField; TypeAsText)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Type';
                    LookupPageID = "Option Lookup List";
                    StyleExpr = Color;
                    TableRelation = "Option Lookup Buffer"."Option Caption" where("Lookup Type" = const(Sales));
                    ToolTip = 'Specifies the type of entity that will be posted for this sales line, such as Item,, or G/L Account.';
                    Visible = IsFoundation;

                    trigger OnValidate()
                    begin
                        /////- if TempOptionLookupBuffer.AutoCompleteOption(TypeAsText,TempOptionLookupBuffer."lookup type"::Sales) then
                        /////- Rec.Validate(Type,TempOptionLookupBuffer.ID);
                        TempOptionLookupBuffer.ValidateOption(TypeAsText);
                        UpdateEditableOnRow;
                        UpdateTypeText;
                    end;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    QuickEntry = false;
                }
                field("Cantidad master"; Rec."Cantidad master")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    QuickEntry = false;
                }
            }
            group(Control53)
            {
                group(Control49)
                {
                    field("Subtotal Excl. VAT"; TotalSalesLine."Line Amount")
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = Currency.Code;
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalLineAmountWithVATAndCurrencyCaption(Currency.Code, TotalSalesHeader."Prices Including VAT");
                        Caption = 'Subtotal Excl. VAT';
                        Editable = false;
                        ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document.';
                        Visible = false;
                    }
                    field("Invoice Discount Amount"; InvoiceDiscountAmount)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = Currency.Code;
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FIELDCAPTION(Rec."Inv. Discount Amount"), Currency.Code);
                        Caption = 'Invoice Discount Amount';
                        Editable = InvDiscAmountEditable;
                        ToolTip = 'Specifies a discount amount that is deducted from the value in the Total Incl. VAT field. You can enter or change the amount manually.';
                        Visible = false;

                        trigger OnValidate()
                        begin
                            ValidateInvoiceDiscountAmount;
                        end;
                    }
                    field("Invoice Disc. Pct."; InvoiceDiscountPct)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Invoice Discount %';
                        DecimalPlaces = 0 : 2;
                        Editable = InvDiscAmountEditable;
                        ToolTip = 'Specifies a discount percentage that is granted if criteria that you have set up for the customer are met.';
                        Visible = false;

                        trigger OnValidate()
                        begin
                            InvoiceDiscountAmount := ROUND(TotalSalesLine."Line Amount" * InvoiceDiscountPct / 100, Currency."Amount Rounding Precision");
                            ValidateInvoiceDiscountAmount;
                        end;
                    }
                    field(Conseguido; Conseguido)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Conseguido Supraoferta';
                    }
                    field("Importe sin descuentos"; ImpBase)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Importe sin descuentos';
                    }
                    field(ImporteAServir; ImporteAServir)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Importe con decuentos';
                        Editable = false;
                    }
                    field(Importenuevodto; ImporteSupraOferta)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Importe SupraOferta';
                    }
                    field(Diferencia; ImporteAServir - ImporteSupraOferta)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Diferencia';
                        StyleExpr = COLORDIF;
                    }
                }
                group("Vendido antes")
                {
                    field(PEDIDO; PEDIDO)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatType = 1;
                        Caption = 'PEDIDO';
                        Editable = false;
                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';
                    }
                    field(FECHAPED; FECHAPED)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatType = 1;
                        Caption = 'Fecha';
                        Editable = false;
                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';

                        trigger OnValidate()
                        begin
                            ValidateInvoiceDiscountAmount;
                        end;
                    }
                    field(CANTIDAD; CANTIDAD)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cantidad';
                        DecimalPlaces = 0 : 2;
                        Editable = false;
                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';

                        trigger OnValidate()
                        begin
                            InvoiceDiscountAmount := ROUND(TotalSalesLine."Line Amount" * InvoiceDiscountPct / 100, Currency."Amount Rounding Precision");
                            ValidateInvoiceDiscountAmount;
                        end;
                    }
                    field(PRECIO; PRECIO)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Precio';
                        Editable = false;
                    }
                    field(DTO; DTO)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Dto%';
                        Editable = false;
                    }
                }
                group(Control35)
                {
                    field("Total Amount Excl. VAT"; TotalSalesLine.Amount)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = Currency.Code;
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(Currency.Code);
                        Caption = 'Total Amount Excl. VAT';
                        DrillDown = false;
                        Editable = false;
                        ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
                    }
                    field("Total VAT Amount"; VATAmount)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = Currency.Code;
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(Currency.Code);
                        Caption = 'Total VAT';
                        Editable = false;
                        ToolTip = 'Specifies the sum of VAT amounts on all lines in the document.';
                    }
                    field("Total Amount Incl. VAT"; TotalSalesLine."Amount Including VAT")
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = Currency.Code;
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(Currency.Code);
                        Caption = 'Total Amount Incl. VAT';
                        Editable = false;
                        ToolTip = 'Specifies the sum of the value in the Line Amount Incl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(InsertExtTexts)
            {
                AccessByPermission = TableData "Extended Text Header" = R;
                ApplicationArea = Suite;
                Caption = 'Insert &Ext. Texts';
                Image = Text;
                ToolTip = 'Insert the extended item description that is set up for the item that is being processed on the line.';

                trigger OnAction()
                begin
                    InsertExtendedText(true);
                end;
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Event';
                        Image = "Event";
                        ToolTip = 'View how the actual and the projected available balance of an item will develop over time according to supply and demand events.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period';
                        Image = Period;
                        ToolTip = 'Show the projected quantity of the item over time according to time periods, such as day, week, or month.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ToolTip = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData Location = R;
                        ApplicationArea = Location;
                        Caption = 'Location';
                        Image = Warehouse;
                        ToolTip = 'View the actual and projected quantity of the item per location.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        AccessByPermission = TableData "BOM Buffer" = R;
                        ApplicationArea = Assembly;
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ToolTip = 'View availability figures for items on bills of materials that show how many units of a parent item you can make based on the availability of child items.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByBOM)
                        end;
                    }
                }
                action("Select Item Substitution")
                {
                    ApplicationArea = Suite;
                    Caption = 'Select Item Substitution';
                    Image = SelectItemSubstitution;
                    ToolTip = 'Select another item that has been set up to be sold instead of the original item if it is unavailable.';

                    trigger OnAction()
                    begin
                        ShowItemSub;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';

                    trigger OnAction()
                    begin
                        ShowLineComments;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalculateTotals;
        UpdateEditableOnRow;
        UpdateTypeText;
        SetItemChargeFieldsStyle;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        UpdateTypeText;
        SetItemChargeFieldsStyle;


        Color := '';
        if Item.Get(Rec."No.") then begin
            if (Item."No permite pedido") then begin
                Color := 'Unfavorable';
            end;
            if (Item."Producto con reserva") then begin
                Color := 'Attention';
            end;
            if Item."Estado Producto" <> Item."estado producto"::Activo then begin
                Color := 'Ambiguous';
            end;

        end;




        FECHA1 := 0D;
        FECHA2 := 0D;

        if (Rec."Document Type" = 0) and (Rec.Type = 2) then begin
            if RecItem.Get(Rec."No.") then begin
                /////EstadoPRod:=RecItem."Estado Producto";
                RecItem.CalcFields(RecItem."Qty. on Sales Order", RecItem."Fecha proxima recepción conten",
                RecItem."Fecha proxima recepción pedido");
                FECHA1 := RecItem."Fecha proxima recepción conten";
                FECHA2 := RecItem."Fecha proxima recepción pedido";
                Rec39.Reset;
                Rec39.SetCurrentkey(Type, "No.", "Expected Receipt Date");
                Rec39.SetRange(Rec39."Document Type", 0);
                Rec39.SetRange(Rec39."No.", Rec."No.");
                Rec39.SetFilter(Rec39."Outstanding Quantity", '<>0');
                if Rec39.FindFirst then begin
                    FECHA2 := Rec39."Expected Receipt Date";
                end;
                Rec39.Reset;
                Rec39.SetCurrentkey(Type, "No.", "Expected Receipt Date");
                Rec39.SetRange(Rec39."Document Type", 1);
                Rec39.SetRange(Rec39."No.", Rec."No.");
                Rec39.SetFilter(Rec39."Outstanding Quantity", '<>0');
                if Rec39.FindFirst then begin
                    FECHA1 := Rec39."Expected Receipt Date";
                end;

            end;
        end;


        Color1 := '';
        Color2 := '';

        if FECHA1 <> 0D then begin
            Color1 := 'Unfavorable';
        end;
        if FECHA2 <> 0D then begin
            Color2 := 'StrongAccent';
        end;


        ImporteTarifa := 0;
        ImporteAServir := 0;
        SalesLine.Reset;
        SalesLine.SetRange(SalesLine."Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."Document No.");
        if SalesLine.FindSet then
            repeat
                if Item2.Get(SalesLine."No.") then begin
                    if (Item2."No permite pedido" = false) and (Item2."Producto con reserva" = false) then begin
                        ImporteAServir := ImporteAServir + SalesLine.Amount;
                        if SalesLine."Producto asociado" = 0 then begin
                            ImporteTarifa := ImporteTarifa + (SalesLine.Quantity * SalesLine."Unit Price");
                        end;
                    end;
                end;
            until SalesLine.Next = 0;


        ImporteSupraOferta := 0;
        ImpBase := ImporteTarifa;
        CustInvoiceDisc.Reset;
        CustInvoiceDisc.SetRange(CustInvoiceDisc.Code, 'SUPRAOFERTA');
        if CustInvoiceDisc.FindSet then
            repeat
                if ImpBase > CustInvoiceDisc."Minimum Amount" then begin
                    Conseguido := Format(CustInvoiceDisc."Discount %") + '%';
                    ImporteSupraOferta := ImporteTarifa - ROUND(ImporteTarifa * CustInvoiceDisc."Discount %" / 100, 0.01);
                end;
            until CustInvoiceDisc.Next = 0;

        COLORDIF := 'Unfavorable';
        if ImporteSupraOferta > 0 then begin
            if (ImporteAServir - ImporteSupraOferta) > 0 then begin
                COLORDIF := 'Favorable';
            end;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
    begin
        if (Rec.Quantity <> 0) and Rec.ItemExists(Rec."No.") then begin
            Commit;
            if not ReserveSalesLine.DeleteLineConfirm(Rec) then
                exit(false);
            ReserveSalesLine.DeleteLine(Rec);
        end;
    end;

    trigger OnInit()
    var
        ApplicationAreaSetup: Record "Application Area Setup";
    begin
        SalesSetup.Get;
        Currency.InitRoundingPrecision;
        /////- TempOptionLookupBuffer.FillBuffer(TempOptionLookupBuffer."lookup type"::Sales);
        /////- IsFoundation := ApplicationAreaSetup.IsFoundationEnabled;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        ApplicationAreaSetup: Record "Application Area Setup";
    begin
        Rec.InitType;
        /////- if ApplicationAreaSetup.IsFoundationEnabled then
        /////- if xRec."Document No." = '' then
        Rec.Type := Rec.Type::Item;

        Rec.Type := Rec.Type::Item;

        Clear(ShortcutDimCode);
        UpdateTypeText;
    end;

    trigger OnOpenPage()
    begin


        COLORDTOVENDE := 'StandardAccent';
    end;

    var
        TotalSalesHeader: Record "Sales Header";
        TotalSalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        Currency: Record Currency;
        SalesSetup: Record "Sales & Receivables Setup";
        TempOptionLookupBuffer: Record "Option Lookup Buffer" temporary;
        TransferExtendedText: Codeunit "Transfer Extended Text";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        SalesCalcDiscByType: Codeunit "Sales - Calc Discount By Type";
        DocumentTotals: Codeunit "Document Totals";
        VATAmount: Decimal;
        ShortcutDimCode: array[8] of Code[20];
        IsCommentLine: Boolean;
        UnitofMeasureCodeIsChangeable: Boolean;
        IsFoundation: Boolean;
        InvoiceDiscountAmount: Decimal;
        InvoiceDiscountPct: Decimal;
        InvDiscAmountEditable: Boolean;
        ItemChargeStyleExpression: Text;
        TypeAsText: Text[30];
        Color: Text;
        Item: Record Item;
        FECHA1: Date;
        FECHA2: Date;
        RecItem: Record Item;
        Rec39: Record "Purchase Line";
        Color2: Text;
        Color1: Text;
        ImporteAServir: Decimal;
        SalesLine: Record "Sales Line";
        Item2: Record Item;
        Multitabla2: Record "Multitabla 2";
        ImportePedido: Decimal;
        Conseguido: Text;
        ImporteTarifa: Decimal;
        CustomerDiscountGroup: Record "Customer Discount Group";
        SalesLineTmp: Record "Sales Line" temporary;
        Importenuevodto: Decimal;
        SalesLine3: Record "Sales Line";
        CustInvoiceDisc: Record "Cust. Invoice Disc.";
        ImpBase: Decimal;
        Diferencia: Decimal;
        TotalBase: Decimal;
        ImporteSupraOferta: Decimal;
        COLORDTOVENDE: Text;
        COLORDIF: Text;
        REC111: Record "Sales Shipment Line";
        PEDIDO: Code[20];
        FECHAPED: Date;
        CANTIDAD: Decimal;
        PRECIO: Decimal;
        DTO: Decimal;

    procedure ApproveCalcInvDisc()
    begin
        Codeunit.Run(Codeunit::"Sales-Disc. (Yes/No)", Rec);
    end;

    local procedure ValidateInvoiceDiscountAmount()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
        SalesCalcDiscByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount, SalesHeader);
        CurrPage.Update(false);
    end;

    procedure CalcInvDisc()
    begin
        Codeunit.Run(Codeunit::"Sales-Calc. Discount", Rec);
    end;

    local procedure ExplodeBOM()
    begin
        Codeunit.Run(Codeunit::"Sales-Explode BOM", Rec);
    end;

    local procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SaveRecord;
            Commit;
            TransferExtendedText.InsertSalesExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then
            UpdateForm(true);
    end;

    local procedure ShowItemSub()
    begin
        ShowItemSub;
    end;

    local procedure ShowNonstockItems()
    begin
        Rec.ShowNonstock;
    end;

    local procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);
    end;

    local procedure ShowPrices()
    begin
        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
        Clear(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;

    local procedure ShowLineDisc()
    begin
        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
        Clear(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;

    local procedure ShowLineComments()
    begin
        ShowLineComments;
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
        if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SaveRecord;

        SaveAndAutoAsmToOrder;
    end;

    local procedure LocationCodeOnAfterValidate()
    begin
        SaveAndAutoAsmToOrder;
    end;

    local procedure VariantCodeOnAfterValidate()
    begin
        SaveAndAutoAsmToOrder;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(false);
    end;

    local procedure QuantityOnAfterValidate()
    begin
        if Rec.Reserve = Rec.Reserve::Always then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
        end;

        if (Rec.Type = Rec.Type::Item) and
           (Rec.Quantity <> xRec.Quantity)
        then
            CurrPage.Update(true);
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        if Rec.Reserve = Rec.Reserve::Always then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
        end;
    end;

    local procedure SaveAndAutoAsmToOrder()
    begin
        if (Rec.Type = Rec.Type::Item) and Rec.IsAsmToOrderRequired then begin
            CurrPage.SaveRecord;
            Rec.AutoAsmToOrder;
            CurrPage.Update(false);
        end;
    end;

    local procedure RedistributeTotalsOnAfterValidate()
    begin
        CurrPage.SaveRecord;

        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
        DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalSalesLine);
        CurrPage.Update;
    end;

    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SaveRecord;
    end;

    local procedure UpdateEditableOnRow()
    var
        SalesLine: Record "Sales Line";
    begin
        IsCommentLine := not Rec.HasTypeToFillMandatoryFields;
        if not IsCommentLine then
            UnitofMeasureCodeIsChangeable := Rec.CanEditUnitOfMeasureCode
        else
            UnitofMeasureCodeIsChangeable := false;

        if TotalSalesHeader."No." <> '' then begin
            SalesLine.SetRange("Document No.", TotalSalesHeader."No.");
            SalesLine.SetRange("Document Type", TotalSalesHeader."Document Type");
            if not SalesLine.IsEmpty then
                InvDiscAmountEditable :=
                  SalesCalcDiscByType.InvoiceDiscIsAllowed(TotalSalesHeader."Invoice Disc. Code") and CurrPage.Editable;
        end;
    end;

    local procedure UpdatePage()
    var
        SalesHeader: Record "Sales Header";
    begin
        CurrPage.Update;
        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
        SalesCalcDiscByType.ApplyDefaultInvoiceDiscount(TotalSalesHeader."Invoice Discount Amount", SalesHeader);
    end;

    local procedure GetTotalSalesHeader()
    begin
        if not TotalSalesHeader.Get(Rec."Document Type", Rec."Document No.") then
            Clear(TotalSalesHeader);
        if Currency.Code <> TotalSalesHeader."Currency Code" then
            if not Currency.Get(TotalSalesHeader."Currency Code") then begin
                Clear(Currency);
                Currency.InitRoundingPrecision;
            end
    end;

    local procedure CalculateTotals()
    begin
        GetTotalSalesHeader;
        TotalSalesHeader.CalcFields("Recalculate Invoice Disc.");

        if SalesSetup."Calc. Inv. Discount" and (Rec."Document No." <> '') and (TotalSalesHeader."Customer Posting Group" <> '') and
           TotalSalesHeader."Recalculate Invoice Disc."
        then
            if Rec.Find then
                CalcInvDisc;

        DocumentTotals.CalculateSalesTotals(TotalSalesLine, VATAmount, Rec);
        InvoiceDiscountAmount := TotalSalesLine."Inv. Discount Amount";
        InvoiceDiscountPct := SalesCalcDiscByType.GetCustInvoiceDiscountPct(Rec);
    end;

    local procedure UpdateTypeText()
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Rec);
        TypeAsText := TempOptionLookupBuffer.FormatOption(RecRef.Field(Rec.FieldNo(Rec.Type)));
    end;

    local procedure SetItemChargeFieldsStyle()
    begin
        ItemChargeStyleExpression := '';
        if Rec.AssignedItemCharge then
            ItemChargeStyleExpression := 'Unfavorable';
    end;
}

