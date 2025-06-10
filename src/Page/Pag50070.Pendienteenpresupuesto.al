#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50070 "Pendiente en presupuesto"
{
    Caption = 'Pendiente en presupuesto';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    MultipleNewLines = true;
    PageType = Worksheet;
    SourceTable = "Sales Line";
    SourceTableView = where("Document Type" = filter(Quote));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Presupuesto; SalesHeader."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Presupuesto';
                    Editable = false;
                }
                field(Cliente; SalesHeader."Sell-to Customer No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cliente';
                    Editable = false;
                }
                field(Nombre; SalesHeader."Sell-to Customer Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nombre';
                    Editable = false;
                }
                field("Estado presupuesto"; SalesHeader."Estado presupuesto")
                {
                    ApplicationArea = Basic;
                    Caption = 'Estado presupuesto';
                    Editable = false;
                }
                field("SalesHeader.""Your Reference"""; SalesHeader."Your Reference")
                {
                    ApplicationArea = Basic;
                    Caption = 'Su referencia';
                    Editable = false;
                }
                field("Fecha alta"; Rec."Fecha cabecera ofer/ped")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fecha alta';
                    Editable = false;
                }
                field("Grupo cliente"; Rec."Grupo clientes")
                {
                    ApplicationArea = Basic;
                    Caption = 'Grupo cliente';
                    Editable = false;
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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    Editable = not IsCommentLine;
                    Enabled = not IsCommentLine;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies the inventory location from which the items sold should be picked and where the inventory decrease is registered.';

                    trigger OnValidate()
                    begin
                        LocationCodeOnAfterValidate;
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
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = UnitofMeasureCodeIsChangeable;
                    Enabled = UnitofMeasureCodeIsChangeable;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';

                    trigger OnValidate()
                    begin
                        UnitofMeasureCodeOnAfterValida;
                        RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Advanced;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies the unit of measure for the item or resource on the sales line.';
                    Visible = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies the unit cost of the item on the line.';
                    Visible = false;
                }
                field(PriceExists; Rec.PriceExists)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Sales Price Exists';
                    Editable = false;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies that there is a specific price for this customer.';
                    Visible = false;
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
                field(LineDiscExists; Rec.LineDiscExists)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Sales Line Disc. Exists';
                    Editable = false;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies that there is a specific discount for this customer.';
                    Visible = false;
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
                field("Precio importado"; Rec."Precio importado")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = COLORPRECIO;
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
                        /////-if TempOptionLookupBuffer.AutoCompleteOption(TypeAsText,TempOptionLookupBuffer."lookup type"::Sales) then
                        /////-  Rec.Validate(Type,TempOptionLookupBuffer.ID);
                        TempOptionLookupBuffer.ValidateOption(TypeAsText);
                        UpdateEditableOnRow;
                        UpdateTypeText;
                    end;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = Advanced;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies if the invoice line is included when the invoice discount is calculated.';
                    Visible = false;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies the invoice discount amount for the line.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        UpdatePage;
                    end;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = ItemCharges;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies that you can assign item charges to this line.';
                    Visible = false;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ApplicationArea = ItemCharges;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies how many units of the item charge will be assigned to the line.';

                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord;
                        Rec.ShowItemChargeAssgnt;
                        UpdateForm(false);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ApplicationArea = ItemCharges;
                    BlankZero = true;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies how much of the item charge has been assigned.';

                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord;
                        Rec.ShowItemChargeAssgnt;
                        UpdateForm(false);
                    end;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Suite;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies the code for the shipping agent who is transporting the items.';
                    Visible = false;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = Suite;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies the code for the service, such as a one-day delivery, that is offered by the shipping agent.';
                    Visible = false;
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = Manufacturing;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies which work type the resource applies to when the sale is related to a job.';
                    Visible = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = Advanced;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies the number of the blanket order that the record originates from.';
                    Visible = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = Advanced;
                    QuickEntry = false;
                    StyleExpr = Color;
                    ToolTip = 'Specifies the number of the blanket order line that the record originates from.';
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = Basic, Suite;
                    QuickEntry = false;
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied -to.';
                    Visible = false;
                }
                field("Item.""Existencia SILLA"""; Item."Existencia SILLA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Existencia SILLA';
                    Editable = false;
                }
                field("Clasificación A,B,C"; Item."Clasificación A,B,C")
                {
                    ApplicationArea = Basic;
                    Caption = 'Clasificación A,B,C';
                    Editable = false;
                }
                field("Estado Producto"; Item."Estado Producto")
                {
                    ApplicationArea = Basic;
                    Caption = 'Estado Producto';
                    Editable = false;
                }
                field("Producto con reserva"; Item."Producto con reserva")
                {
                    ApplicationArea = Basic;
                    Caption = 'Producto con reserva';
                    Editable = false;
                }
                field("Item.""Vendor No."""; Item."Vendor No.")
                {
                    ApplicationArea = Basic;
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
            action(Dimensions)
            {
                AccessByPermission = TableData Dimension = R;
                ApplicationArea = Suite;
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';
                ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                trigger OnAction()
                begin
                    Rec.ShowDimensions;
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
                action("Item Charge &Assignment")
                {
                    AccessByPermission = TableData "Item Charge" = R;
                    ApplicationArea = ItemCharges;
                    Caption = 'Item Charge &Assignment';
                    Image = ItemCosts;
                    ToolTip = 'Assign additional direct costs, for example for freight, to the item on the line.';

                    trigger OnAction()
                    begin
                        ItemChargeAssgnt;
                        SetItemChargeFieldsStyle;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.';

                    trigger OnAction()
                    var
                        Item: Record Item;
                    begin
                        Item.Get(Rec."No.");
                        Item.TestField("Assembly Policy", Item."assembly policy"::"Assemble-to-Stock");
                        Rec.TestField(Rec."Qty. to Asm. to Order (Base)", 0);
                        Rec.OpenItemTrackingLines;
                    end;
                }
                action("Select Nonstoc&k Items")
                {
                    AccessByPermission = TableData "Nonstock Item" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Select Nonstoc&k Items';
                    Image = NonStockItem;
                    ToolTip = 'View the list of nonstock items that exist in the system. ';

                    trigger OnAction()
                    begin
                        ShowNonstockItems;
                    end;
                }
                group("Assemble to Order")
                {
                    Caption = 'Assemble to Order';
                    Image = AssemblyBOM;
                    action("Assemble-to-Order Lines")
                    {
                        AccessByPermission = TableData "BOM Component" = R;
                        ApplicationArea = Assembly;
                        Caption = 'Assemble-to-Order Lines';
                        ToolTip = 'View any linked assembly order lines if the documents represents an assemble-to-order sale.';

                        trigger OnAction()
                        begin
                            Rec.ShowAsmToOrderLines;
                        end;
                    }
                    action("Roll Up &Price")
                    {
                        AccessByPermission = TableData "BOM Component" = R;
                        ApplicationArea = Assembly;
                        Caption = 'Roll Up &Price';
                        Ellipsis = true;
                        ToolTip = 'Update the unit price of the assembly item according to any changes that you have made to the assembly components.';

                        trigger OnAction()
                        begin
                            Rec.RollupAsmPrice;
                        end;
                    }
                    action("Roll Up &Cost")
                    {
                        AccessByPermission = TableData "BOM Component" = R;
                        ApplicationArea = Assembly;
                        Caption = 'Roll Up &Cost';
                        Ellipsis = true;
                        ToolTip = 'Update the unit cost of the assembly item according to any changes that you have made to the assembly components.';

                        trigger OnAction()
                        begin
                            Rec.RollUpAsmCost;
                        end;
                    }
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Get &Price")
                {
                    AccessByPermission = TableData "Sales Price" = R;
                    ApplicationArea = Advanced;
                    Caption = 'Get &Price';
                    Ellipsis = true;
                    Image = Price;
                    ToolTip = 'Insert the lowest possible price in the Unit Price field according to any special price that you have set up.';

                    trigger OnAction()
                    begin
                        ShowPrices
                    end;
                }
                action("Get Li&ne Discount")
                {
                    AccessByPermission = TableData "Sales Line Discount" = R;
                    ApplicationArea = Advanced;
                    Caption = 'Get Li&ne Discount';
                    Ellipsis = true;
                    Image = LineDiscount;
                    ToolTip = 'Insert the best possible discount in the Line Discount field according to any special discounts that you have set up.';

                    trigger OnAction()
                    begin
                        ShowLineDisc
                    end;
                }
                action("E&xplode BOM")
                {
                    AccessByPermission = TableData "BOM Component" = R;
                    ApplicationArea = Suite;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    ToolTip = 'Insert new lines for the components on the bill of materials, for example to sell the parent item as a kit. CAUTION: The line for the parent item will be deleted and represented by a description only. To undo, you must delete the component lines and add a line the parent item again.';

                    trigger OnAction()
                    begin
                        ExplodeBOM;
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

        SalesHeader.Init;
        if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then begin
        end;
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        UpdateTypeText;
        SetItemChargeFieldsStyle;

        COLORPRECIO := '';
        if Rec."Precio importado" <> Rec."Unit Price" then begin
            COLORPRECIO := 'Unfavorable';
        end;

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


        Customer.Init;
        if Customer.Get(Rec."Sell-to Customer No.") then begin
        end;



        if Item.Get(Rec."No.") then begin
            Item.CalcFields("Existencia SILLA");
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
        if xRec."Document No." = '' then
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
        COLORPRECIO: Text;
        Customer: Record Customer;

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

