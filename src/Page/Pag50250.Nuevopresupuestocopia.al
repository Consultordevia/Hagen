#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50250 "Nuevo presupuesto copia"
{
    Caption = 'Nuevo presupuesto';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Quote,View,Approve,Request Approval,History';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = filter(Quote));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the number of the sales document. The field can be filled automatically or manually and can be set up to be invisible.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Customer No.';
                    Importance = Additional;
                    NotBlank = true;
                    ToolTip = 'Specifies the number of the customer who will receive the products and be billed by default.';

                    trigger OnValidate()
                    begin
                        Rec.SelltoCustomerNoOnAfterValidate(Rec, xRec);
                        CurrPage.Update;
                    end;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                    Importance = Promoted;
                    NotBlank = true;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the name of the customer who will receive the products and be billed by default.';

                    trigger OnValidate()
                    var
                        ApplicationAreaSetup: Record "Application Area Setup";
                    begin
                        Rec.SelltoCustomerNoOnAfterValidate(Rec, xRec);
                        CurrPage.Update;

                        /////-if ApplicationAreaSetup.Rec.IsFoundationEnabled then
                        /////-SalesCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sell-to Customer Name 2';
                }
                field("Ampliacion del pedido nº"; Rec."Ampliacion del pedido nº")
                {
                    ApplicationArea = Basic;
                }
                field("Observación para ALMACEN"; Rec."Observación para ALMACEN")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Observación PDA"; Rec."Observación PDA")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("No agrupar en ADAIA"; Rec."No agrupar en ADAIA")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Permite fraccionar uni. venta"; Rec."Permite fraccionar uni. venta")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("No incluir portes"; Rec."No incluir portes")
                {
                    ApplicationArea = Basic;
                }
                group("Sell-to")
                {
                    Caption = 'Sell-to';
                    field("Sell-to Address"; Rec."Sell-to Address")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address';
                        Importance = Additional;
                        ToolTip = 'Specifies the address where the customer is located.';
                    }
                    field("Sell-to Address 2"; Rec."Sell-to Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address 2';
                        Importance = Additional;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Sell-to Post Code"; Rec."Sell-to Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Code';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Sell-to City"; Rec."Sell-to City")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'City';
                        Importance = Additional;
                        ToolTip = 'Specifies the city of the customer on the sales document.';
                    }
                    field("Sell-to County"; Rec."Sell-to County")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'County';
                        Importance = Additional;
                        ToolTip = 'Specifies the county of the address.';
                    }
                    field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact No.';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact that the sales document will be sent to.';

                        trigger OnValidate()
                        begin
                            ClearSellToFilter;
                            ActivateFields;
                            CurrPage.Update
                        end;
                    }
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = Basic;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date when the related order was created.';
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies when the related sales invoice must be paid.';
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date that the customer has asked for the order to be delivered.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the name of the salesperson who is assigned to the customer.';

                    trigger OnValidate()
                    begin
                        CurrPage.SalesLines.Page.UpdateForm(true)
                    end;
                }
                field("Estado presupuesto"; Rec."Estado presupuesto")
                {
                    ApplicationArea = Basic;
                }
                group("Work Description")
                {
                    Caption = 'Work Description';
                    field(WorkDescription; WorkDescription)
                    {
                        ApplicationArea = Advanced;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies the products or service being offered';

                        trigger OnValidate()
                        begin
                            Rec.SetWorkDescription(WorkDescription);
                        end;
                    }
                }
            }
            part(SalesLines; "Lineas presupuesto copia")
            {
                ApplicationArea = Basic, Suite;
                ///Editable = (Rec."Sell-to Customer No." <> '') or ("Sell-to Customer Template Code" <> '');
                ///Enabled = (Rec."Sell-to Customer No." <> '') or ("Sell-to Customer Template Code" <> '');
                ///SubPageLink = "Document No."=field(Rec."No.");
                UpdatePropagation = Both;
            }
            group("Shipping and Billing")
            {
                Caption = 'Shipping and Billing';
                field("No imprimir albaran valorado"; Rec."No imprimir albaran valorado")
                {
                    ApplicationArea = Basic;
                }
                field("No Enviar factura en exp."; Rec."No Enviar factura en exp.")
                {
                    ApplicationArea = Basic;
                }
                field("No Enviar albaran en exp."; Rec."No Enviar albaran en exp.")
                {
                    ApplicationArea = Basic;
                }
                field("Albaran sin detalle"; Rec."Albaran sin detalle")
                {
                    ApplicationArea = Basic;
                }
                field("No imprimir facturas"; Rec."No imprimir facturas")
                {
                    ApplicationArea = Basic;
                }
                group(Control60)
                {
                    group(Control53)
                    {
                        field(ShippingOptions; ShipToOptions)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Ship-to';
                            OptionCaption = 'Default (Sell-to Address),Alternate Shipping Address,Custom Address';
                            ToolTip = 'Specifies the address that the products on the sales document are shipped to. Default (Sell-to Address): The same as the customer''s sell-to address. Alternate Ship-to Address: One of the customer''s alternate ship-to addresses. Custom Address: Any ship-to address that you specify in the fields below.';

                            trigger OnValidate()
                            var
                                ShipToAddress: Record "Ship-to Address";
                                ShipToAddressList: Page "Ship-to Address List";
                            begin
                                case ShipToOptions of
                                    Shiptooptions::"Default (Sell-to Address)":
                                        begin
                                            Rec.Validate(Rec."Ship-to Code", '');
                                            Rec.CopySellToAddressToShipToAddress;
                                        end;
                                    Shiptooptions::"Alternate Shipping Address":
                                        begin
                                            ShipToAddress.SetRange("Customer No.", Rec."Sell-to Customer No.");
                                            ShipToAddressList.LookupMode := true;
                                            ShipToAddressList.SetTableview(ShipToAddress);

                                            if ShipToAddressList.RunModal = Action::LookupOK then begin
                                                ShipToAddressList.GetRecord(ShipToAddress);
                                                Rec.Validate(Rec."Ship-to Code", ShipToAddress.Code);
                                            end else
                                                ShipToOptions := Shiptooptions::"Custom Address";
                                        end;
                                    Shiptooptions::"Custom Address":
                                        Rec.Validate(Rec."Ship-to Code", '');
                                end;
                            end;
                        }
                        group(Control72)
                        {
                            Visible = not (ShipToOptions = ShipToOptions::"Default (Sell-to Address)");
                            field("Ship-to Code"; Rec."Ship-to Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Code';
                                Editable = ShipToOptions = ShipToOptions::"Alternate Shipping Address";
                                Importance = Promoted;
                                ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';

                                trigger OnValidate()
                                begin
                                    if (xRec."Ship-to Code" <> '') and (Rec."Ship-to Code" = '') then
                                        Error(EmptyShipToCodeErr);
                                end;
                            }
                            field("Ship-to Name"; Rec."Ship-to Name")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Name';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                            }
                            field("Ship-to Address"; Rec."Ship-to Address")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Address';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTip = 'Specifies the address that products on the sales document will be shipped to. By default, the field is filled with the value in the Address field on the customer card or with the value in the Address field in the Ship-to Address window.';
                            }
                            field("Ship-to Address 2"; Rec."Ship-to Address 2")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Address 2';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTip = 'Specifies additional address information.';
                            }
                            field("Ship-to Post Code"; Rec."Ship-to Post Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Post Code';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTip = 'Specifies the postal code.';
                            }
                            field("Ship-to City"; Rec."Ship-to City")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'City';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTip = 'Specifies the city of the customer on the sales document.';
                            }
                            field("Ship-to County"; Rec."Ship-to County")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'County';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTip = 'Specifies the county of the address.';
                            }
                            field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Country/Region';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                ToolTip = 'Specifies the customer''s country/region.';
                            }
                        }
                        field("Ship-to Contact"; Rec."Ship-to Contact")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Contact';
                            ToolTip = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.';
                        }
                    }
                    group("Shipment Method")
                    {
                        Caption = 'Shipment Method';
                        field("Shipment Method Code"; Rec."Shipment Method Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Code';
                            Importance = Additional;
                            ToolTip = 'Specifies how items on the sales document are shipped to the customer.';
                        }
                        field("Respeta agencia transporte"; Rec."Respeta agencia transporte")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Shipping Agent Code"; Rec."Shipping Agent Code")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Agent';
                            Importance = Additional;
                            ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
                        }
                        field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Agent service';
                            Importance = Additional;
                            ToolTip = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.';
                        }
                        field("Package Tracking No."; Rec."Package Tracking No.")
                        {
                            ApplicationArea = Suite;
                            Importance = Additional;
                            ToolTip = 'Specifies the shipping agent''s package number.';
                        }
                    }
                }
                group(Control49)
                {
                    Enabled = not EnableSellToCustomerTemplateCode;
                    field(BillToOptions; BillToOptions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bill-to';
                        OptionCaption = 'Default (Customer),Another Customer';
                        ToolTip = 'Specifies the customer that the sales invoice will be sent to. Default (Customer): The same as the customer on the sales invoice. Another Customer: Any customer that you specify in the fields below.';

                        trigger OnValidate()
                        begin
                            if BillToOptions = Billtooptions::"Default (Customer)" then begin
                                Rec.Validate(Rec."Bill-to Customer No.", Rec."Sell-to Customer No.");
                                Rec.RecallModifyAddressNotification(Rec.GetModifyBillToCustomerAddressNotificationId);
                            end;

                            Rec.CopySellToAddressToBillToAddress;
                        end;
                    }
                    group(Control41)
                    {
                        Visible = BillToOptions = BillToOptions::"Another Customer";
                    }
                    field("Bill-to Name"; Rec."Bill-to Name")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Name';
                        Enabled = EnableBillToCustomerNo;
                        Importance = Promoted;
                        ToolTip = 'Specifies the customer to whom you will send the sales invoice, when different from the customer that you are selling to.';

                        trigger OnValidate()
                        var
                            ApplicationAreaSetup: Record "Application Area Setup";
                        begin
                            if Rec.GetFilter(Rec."Bill-to Customer No.") = xRec."Bill-to Customer No." then
                                if Rec."Bill-to Customer No." <> xRec."Bill-to Customer No." then
                                    Rec.SetRange(Rec."Bill-to Customer No.");

                            /////-if ApplicationAreaSetup.IsFoundationEnabled then
                            /////-SalesCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);

                            CurrPage.Update;
                        end;
                    }
                    field("Bill-to Address"; Rec."Bill-to Address")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address';
                        Editable = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
                        Enabled = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
                        Importance = Additional;
                        ToolTip = 'Specifies the address of the customer that you will send the invoice to.';
                    }
                    field("Bill-to Address 2"; Rec."Bill-to Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address 2';
                        Editable = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
                        Enabled = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
                        Importance = Additional;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Bill-to Post Code"; Rec."Bill-to Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Code';
                        Editable = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
                        Enabled = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Bill-to City"; Rec."Bill-to City")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'City';
                        Editable = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
                        Enabled = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
                        Importance = Additional;
                        ToolTip = 'Specifies the city of the customer on the sales document.';
                    }
                    field("Bill-to County"; Rec."Bill-to County")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'County';
                        Importance = Additional;
                        ToolTip = 'Specifies the county of the address.';
                    }
                    field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact No.';
                        Editable = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
                        Enabled = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact the invoice will be sent to.';
                    }
                    field("Bill-to Contact"; Rec."Bill-to Contact")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact';
                        Editable = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
                        Enabled = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
                        ToolTip = 'Specifies the name of the person you should contact at the customer who you are sending the invoice to.';
                    }
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000028; "Item Picture")
            {
                ApplicationArea = Advanced;
                Provider = SalesLines;
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000018; "Sales Line FactBox")
            {
                ApplicationArea = Suite;
                Provider = SalesLines;
                SubPageLink = "Document Type" = field("Document Type"),
                              "Document No." = field("Document No."),
                              "Line No." = field("Line No.");
            }
            /////part(Control1000000004; "Ofertas combinadas")
            /////{
                /////SubPageLink = "Document Type" = const(DetalleProd),
                     /////         "No." = field("No.");
            /////}
            ///part(Control1000000009; SupraOferta)
            ///{
            ///}
            part(Control1000000022; "Sales Hist. Sell-to FactBox")
            {
                ApplicationArea = Advanced;
                SubPageLink = "No." = field("Sell-to Customer No.");
            }
            part(Control1000000023; "Sales Hist. Bill-to FactBox")
            {
                ApplicationArea = Advanced;
                SubPageLink = "No." = field("Bill-to Customer No.");
                Visible = false;
            }
            ///systempart(Control1000000021; Links)
            ///{
                ///Visible = false;
            ///}
            part(Control1903433807; "Cartera Receiv. Statistics FB")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = field("Bill-to Customer No.");
                Visible = true;
            }
            part(Control1903433607; "Cartera Fact. Statistics FB")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = field("Bill-to Customer No.");
                Visible = true;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
                Visible = false;
            }
            part(Control11; "Pending Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(36),
                              "Document Type" = field("Document Type"),
                              "Document No." = field("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(Control1902018507; "Customer Statistics FactBox")
            {
                ApplicationArea = Advanced;
                SubPageLink = "No." = field("Bill-to Customer No.");
                Visible = false;
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                ApplicationArea = Advanced;
                SubPageLink = "No." = field("Sell-to Customer No.");
                Visible = false;
            }
            part(Control1901314507; "Item Invoicing FactBox")
            {
                ApplicationArea = Advanced;
                Provider = SalesLines;
                SubPageLink = "No." = field("No.");
                Visible = false;
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
                Visible = false;
            }
            part(Control1907012907; "Resource Details FactBox")
            {
                ApplicationArea = Advanced;
                Provider = SalesLines;
                SubPageLink = "No." = field("No.");
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control1905767507; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&View")
            {
                Caption = '&View';
                action(Customer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer';
                    Enabled = IsCustomerOrContactNotEmpty;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = field("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the customer on the sales document.';
                }
                action("C&ontact")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'C&ontact';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Contact Card";
                    RunPageLink = "No." = field("Sell-to Contact No.");
                    ToolTip = 'View or edit detailed information about the contact person at the customer.';
                }
            }
            group(History)
            {
                Caption = 'History';
                action(PageInteractionLogEntries)
                {
                    ApplicationArea = Suite;
                    Caption = 'Interaction Log E&ntries';
                    Image = InteractionLog;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category8;
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View a list of interaction log entries related to this document.';

                    trigger OnAction()
                    begin
                        Rec.ShowInteractionLogEntries;
                    end;
                }
            }
        }
        area(processing)
        {
            group("&Quote")
            {
                Caption = '&Quote';
                Image = Quote;
                action("Importar dropshiping")
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = Import;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        /////-ImportacionPEDIDOSMASKOcome.Run;
                    end;
                }
                action("Copiar a PEDIDO")
                {
                    ApplicationArea = Basic;
                    Caption = 'Copiar a PEDIDO';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin


                        ReleaseSalesDoc.PerformManualReopen(Rec);
                        CopiarAPedido;
                    end;
                }
                action("Poner SupraOferta")
                {
                    ApplicationArea = Basic;
                    Caption = 'Poner SupraOferta';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin


                        PonserSupraOferta;
                    end;
                }
                action("Quitar SupraOferta")
                {
                    ApplicationArea = Basic;
                    Caption = 'Poner SupraOferta';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin


                        QuitarSupraOferta;
                    end;
                }
                action("Importar lineas ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Importar lineas ';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin


                        ImportarPedido;
                    end;
                }
                action("Cesta compra")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cesta compra';
                    Ellipsis = true;
                    Image = Purchase;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin


                        Rec91.Get(UserId);
                        Rec91."Nº cliente" := Rec."Sell-to Customer No.";
                        Rec91."Es pedido o oferta" := 0;
                        Rec91."Nº pedido" := Rec."No.";
                        Rec91.Modify;
                        Cestacompra.SetCurrentkey(Tipo, Código, Comprar);
                        Cestacompra.SetRange(Tipo, 0);
                        Cestacompra.SetRange(Código, Rec."Sell-to Customer No.");
                        Cestacompra.SetRange(Comprar, true);
                        if Cestacompra.FindFirst then
                            repeat
                                Cestacompra."Cantidad a Comprar" := 0;
                                Cestacompra.Comprar := false;
                                Cestacompra.Modify;
                            until Cestacompra.Next = 0;

                        Clear(Cestadelacompra);
                        Cestacompra.Reset;
                        Cestacompra.SetCurrentkey(Tipo, Código, Línea, Familia, Subfamilia);
                        Cestacompra.SetRange(Tipo, 0);
                        Cestacompra.SetRange(Código, Rec."Sell-to Customer No.");
                        if Cestacompra.FindFirst then begin
                            Cestadelacompra.SetTableview(Cestacompra);
                            Cestadelacompra.Run;
                        end;
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Statistics';
                    Enabled = Rec."No." <> '';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                    trigger OnAction()
                    var
                        Handled: Boolean;
                    begin
                        OnBeforeStatisticsAction(Rec, Handled);
                        if not Handled then begin
                            Rec.CalcInvDiscForHeader;
                            Commit;
                            Page.RunModal(Page::"Sales Statistics", Rec);
                            SalesCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                        end
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                    ToolTip = 'View or add comments for the record.';
                }
                action(Print)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Print';
                    Ellipsis = true;
                    Enabled = IsCustomerOrContactNotEmpty;
                    Image = Print;
                    ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                    Visible = not IsOfficeAddin;

                    trigger OnAction()
                    begin
                        CheckSalesCheckAllLinesHaveQuantityAssigned;
                        DocPrint.PrintSalesHeader(Rec);
                    end;
                }
                action(Email)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send by &Email';
                    Enabled = IsCustomerOrContactNotEmpty;
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Prepare to mail the document. The Send Email window opens prefilled with the customer''s email address so you can add or edit information.';

                    trigger OnAction()
                    begin
                        CheckSalesCheckAllLinesHaveQuantityAssigned;
                        if not Rec.Find then
                            Rec.Insert(true);
                        DocPrint.EmailSalesHeader(Rec);
                    end;
                }
                action(CopyDocument)
                {
                    ApplicationArea = Suite;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    ToolTip = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.';

                    trigger OnAction()
                    begin
                        if not Rec.Find then begin
                            Rec.Insert(true);
                            Commit;
                        end;
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RunModal;
                        Clear(CopySalesDoc);
                        if Rec.Get(Rec."Document Type", Rec."No.") then;
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ActivateFields;
        CurrPage.IncomingDocAttachFactBox.Page.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.Page.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.Page.SetFilterOnWorkflowRecord(Rec.RecordId);
        UpdatePaymentService;
        SetControlAppearance;
    end;

    trigger OnAfterGetRecord()
    begin
        ActivateFields;
        SetControlAppearance;
        WorkDescription := Rec.GetWorkDescription;
        UpdateShipToBillToGroupVisibility;

        CalculaSupra;
    end;

    trigger OnClosePage()
    begin

        SalesLine.Reset;
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        if not SalesLine.FindFirst then begin
            Rec.Delete;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        EnableBillToCustomerNo := true;
        EnableSellToCustomerTemplateCode := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if DocNoVisible then
            Rec.CheckCreditMaxBeforeInsert;

        if (Rec."Sell-to Customer No." = '') and (Rec.GetFilter(Rec."Sell-to Customer No.") <> '') then
            CurrPage.Update(false);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        xRec.Init;
        Rec."Responsibility Center" := UserMgt.GetSalesFilter;
        if (not DocNoVisible) and (Rec."No." = '') then
            Rec.SetSellToCustomerFromFilter;

        Rec.SetDefaultPaymentServices;
        SetControlAppearance;
        UpdateShipToBillToGroupVisibility;
    end;

    trigger OnOpenPage()
    var
        OfficeMgt: Codeunit "Office Management";
        PermissionManager: Codeunit "Permission Manager";
    begin
        if UserMgt.GetSalesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetSalesFilter);
            Rec.FilterGroup(0);
        end;

        ActivateFields;

        SetDocNoVisible;
        IsOfficeAddin := OfficeMgt.IsAvailable;
        SetControlAppearance;
        ///IsSaaS := PermissionManager.SoftwareAsAService;

        ReleaseSalesDoc.PerformManualReopen(Rec);
    end;

    var
        SalesHeaderArchive: Record "Sales Header Archive";
        CopySalesDoc: Report "Copy Sales Document";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesCalcDiscByType: Codeunit "Sales - Calc Discount By Type";
        CustomerMgt: Codeunit "Customer Mgt.";
        ChangeExchangeRate: Page "Change Exchange Rate";
        [InDataSet]
        EnableBillToCustomerNo: Boolean;
        EnableSellToCustomerTemplateCode: Boolean;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        IsOfficeAddin: Boolean;
        CanCancelApprovalForRecord: Boolean;
        PaymentServiceVisible: Boolean;
        PaymentServiceEnabled: Boolean;
        IsCustomerOrContactNotEmpty: Boolean;
        WorkDescription: Text;
        ShipToOptions: Option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address";
        BillToOptions: Option "Default (Customer)","Another Customer";
        EmptyShipToCodeErr: label 'The Code field can only be empty if you select Custom Address in the Ship-to field.';
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        IsSaaS: Boolean;
        SalesHeader3: Record "Sales Header";
        SEPASA: Boolean;
        UserSetup: Record "User Setup";
        CODACTI: Code[20];
        Rec362: Record "Sales Header";
        Rec372: Record "Sales Line";
        Rec37: Record "Sales Line";
        RecMT2: Record "Multitabla 2";
        RecProd: Record Item;
        Rec367: Record "Sales Header";
        DESDEA: Date;
        RecGP: Record "Gen. Product Posting Group";
        DTOOPTIMO: Decimal;
        DTOOPTIMO3: Decimal;
        RecCfC: Record "General Ledger Setup";
        falta: Boolean;
        RecCVP: Record "Sales & Receivables Setup";
        RecClie: Record Customer;
        fecha2: Date;
        RecLC1: Record "Sales Comment Line";
        RecLC2: Record "Sales Comment Line";
        RecSDLM: Record "Item Journal Batch";
        Rec89: Record "Item Journal Line";
        FormPedido: Page "Sales Order";
        RecCV: Record "Sales Header";
        Cust: Record Customer;
        Rec21: Record "Cust. Ledger Entry";
        Fechavto: Date;
        SalesLine: Record "Sales Line";
        ImporteTarifa: Decimal;
        ImporteAServir: Decimal;
        Item2: Record Item;
        Conseguido: Text;
        Multitabla2: Record "Multitabla 2";
        CustomerDiscountGroup: Record "Customer Discount Group";
        Importenuevodto: Decimal;
        ///// -ImportacionPEDIDOSOTROS2: XmlPort UnknownXmlPort50024;
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        Customer: Record Customer;
        dtoconse: Decimal;
        CustInvoiceDisc: Record "Cust. Invoice Disc.";
        Cestadelacompra: Page "Cesta de la compra";
        Cestacompra: Record "Cesta compra";
        Rec91: Record "User Setup";
        /////-ImportacionPEDIDOSMASKOcome: XmlPort UnknownXmlPort50072;
        NoSeriesManagement: Codeunit NoSeriesManagement;

    local procedure ActivateFields()
    begin
        /////-EnableBillToCustomerNo := Rec."Bill-to Customer Template Code" = '';
        /////-EnableSellToCustomerTemplateCode := Rec."Sell-to Customer No." = '';
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.Page.ApproveCalcInvDisc;
    end;

    local procedure ClearSellToFilter()
    begin
        if Rec.GetFilter(Rec."Sell-to Customer No.") = xRec."Sell-to Customer No." then
            if Rec."Sell-to Customer No." <> xRec."Sell-to Customer No." then
                Rec.SetRange("Sell-to Customer No.");
        if Rec.GetFilter("Sell-to Contact No.") = xRec."Sell-to Contact No." then
            if Rec."Sell-to Contact No." <> xRec."Sell-to Contact No." then
                Rec.SetRange("Sell-to Contact No.");
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(Doctype::Quote, Rec."No.");
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        IsCustomerOrContactNotEmpty := (Rec."Sell-to Customer No." <> '') or (Rec."Sell-to Contact No." <> '');

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

    local procedure CheckSalesCheckAllLinesHaveQuantityAssigned()
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    begin
        /////-if ApplicationAreaSetup.IsFoundationEnabled then
        /////-LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
    end;

    local procedure UpdatePaymentService()
    var
        PaymentServiceSetup: Record "Payment Service Setup";
    begin
        PaymentServiceVisible := PaymentServiceSetup.IsPaymentServiceVisible;
        PaymentServiceEnabled := PaymentServiceSetup.CanChangePaymentService(Rec);
    end;

    local procedure UpdateShipToBillToGroupVisibility()
    begin
        CustomerMgt.CalculateShipToBillToOptions(ShipToOptions, BillToOptions, Rec);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStatisticsAction(var SalesHeader: Record "Sales Header"; var Handled: Boolean)
    begin
    end;

    local procedure CopiarAPedido()
    begin


        RecCV.Get(Rec."Document Type", Rec."No.");



        Customer.Get(Rec."Sell-to Customer No.");

        if Customer."Permite seguir adelante" = false then begin
            Customer.CalcFields("Importe impagado");
            if Customer."Importe impagado" <> 0 then begin
                Message('Este cliente tiene impagos.');
            end;
            Commit;
            if DTOOPTIMO3 - RecCfC."Margen necesario" < 0 then begin
                /////     MESSAGE('Este presupuesto supera el maximo permitido.');
            end;
            SalesHeader3.Get(Rec."Document Type", Rec."No.");
            ChequeoFechaVtosOferta;
            if SEPASA then begin
                Error('El cliente esta bloqueado por exceso falta de pago.');
            end;
        end;




        UserSetup.Get(UserId);
        CODACTI := IncStr(UserSetup."Serie pedidos");
        UserSetup."Serie pedidos" := CODACTI;
        UserSetup."Nº cliente" := Rec."No.";
        UserSetup.Modify;

        CODACTI := NoSeriesManagement.GetNextNo('V-OFPE-1', Today, true);

        Rec362.Init;
        Rec362 := Rec;
        Rec362."No." := CODACTI;
        Rec362."Document Type" := 1;
        Rec362."Estado pedido" := 2;
        Rec362.Insert(true);
        ////CODACTI:=Rec362."No.";
        Rec362."Shipping No. Series" := Rec."Shipping No. Series";
        Rec362."Location Code" := Rec."Location Code";
        Rec362.Modify;


        falta := false;

        if Rec."Fecha envio pendiente stock" = 0D then begin
            Rec372.Reset;
            Rec372.SetRange(Rec372."Document Type", Rec."Document Type");
            Rec372.SetRange(Rec372."Document No.", Rec."No.");
            if Rec372.FindFirst then
                repeat
                    ///IF Rec372."Estado linea"<>2 THEN BEGIN
                    if RecProd.Get(Rec372."No.") then begin
                        if (not RecProd."No permite pedido") and (not RecProd."Producto con reserva") then begin
                            Rec37.Init;
                            Rec37 := Rec372;
                            Rec37."Document Type" := 1;
                            Rec37."Document No." := CODACTI;
                            if Rec372."Cantidad a pasar pedido" <> 0 then begin
                                Rec37.Validate(Rec37.Quantity, Rec372."Cantidad a pasar pedido");
                            end;
                            Rec37.Insert;
                            if Rec372."Cantidad a pasar pedido" = 0 then begin
                                Rec372.Delete;
                            end;
                            if Rec372."Cantidad a pasar pedido" <> 0 then begin
                                Rec372.Validate(Rec372.Quantity, Rec372.Quantity - Rec372."Cantidad a pasar pedido");
                                Rec372."Cantidad a pasar pedido" := 0;
                                Rec372.Modify;
                            end;
                        end;
                        if (not RecProd."No permite pedido") and (RecProd."Producto con reserva") then begin
                            RecClie.Get(Rec."Sell-to Customer No.");
                            if RecClie."No." <> '4703' then begin
                                RecMT2.Reset;
                                RecMT2.SetRange(RecMT2.Tabla, 1);
                                RecMT2.SetRange(RecMT2."Codigo 1", Rec372."No.");
                                RecMT2.SetRange(RecMT2."Codigo 2", RecClie."Grupo clientes");
                                if RecMT2.FindFirst then begin
                                    Rec37.Init;
                                    Rec37 := Rec372;
                                    Rec37."Document Type" := 1;
                                    Rec37."Document No." := CODACTI;
                                    if Rec372."Cantidad a pasar pedido" <> 0 then begin
                                        Rec37.Validate(Rec37.Quantity, Rec372."Cantidad a pasar pedido");
                                    end;
                                    Rec37.Insert;
                                    if Rec372."Cantidad a pasar pedido" = 0 then begin
                                        Rec372.Delete;
                                    end;
                                    if Rec372."Cantidad a pasar pedido" <> 0 then begin
                                        Rec372.Validate(Rec372.Quantity, Rec372.Quantity - Rec372."Cantidad a pasar pedido");
                                        Rec372."Cantidad a pasar pedido" := 0;
                                        Rec372.Modify;
                                    end;
                                end;
                            end;
                            if RecClie."No." = '4703' then begin
                                Rec37.Init;
                                Rec37 := Rec372;
                                Rec37."Document Type" := 1;
                                Rec37."Document No." := CODACTI;
                                if Rec372."Cantidad a pasar pedido" <> 0 then begin
                                    Rec37.Validate(Rec37.Quantity, Rec372."Cantidad a pasar pedido");
                                end;
                                Rec37.Insert;
                                if Rec372."Cantidad a pasar pedido" = 0 then begin
                                    Rec372.Delete;
                                end;
                                if Rec372."Cantidad a pasar pedido" <> 0 then begin
                                    Rec372.Validate(Rec372.Quantity, Rec372.Quantity - Rec372."Cantidad a pasar pedido");
                                    Rec372."Cantidad a pasar pedido" := 0;
                                    Rec372.Modify;
                                end;
                            end;

                        end;
                        if RecProd."No permite pedido" then begin
                            falta := true;
                        end;
                        if RecProd."Producto con reserva" then begin
                            falta := true;
                        end;
                    end;
                ///END;
                until Rec372.Next = 0;
        end;

        if Rec."Fecha envio pendiente stock" <> 0D then begin
            Rec372.Reset;
            Rec372.SetRange(Rec372."Document Type", Rec."Document Type");
            Rec372.SetRange(Rec372."Document No.", Rec."No.");
            if Rec372.FindFirst then
                repeat
                    //IF Rec372."Estado linea"<>2 THEN BEGIN
                    if RecProd.Get(Rec372."No.") then begin
                        fecha2 := 0D;
                        RecProd.CalcFields(RecProd."Fecha proxima recepción conten");
                        fecha2 := RecProd."Fecha proxima recepción conten";
                        if fecha2 = 0D then begin
                            fecha2 := 20151231D;
                        end;
                        if not RecProd."No permite pedido" then begin
                            fecha2 := 0D;
                        end;


                        if (Rec."Fecha envio pendiente stock" > fecha2) and (not RecProd."Producto con reserva") then begin
                            Rec37.Init;
                            Rec37 := Rec372;
                            Rec37."Document Type" := 1;
                            Rec37."Document No." := CODACTI;
                            if Rec372."Cantidad a pasar pedido" <> 0 then begin
                                Rec37.Validate(Rec37.Quantity, Rec372."Cantidad a pasar pedido");
                            end;
                            Rec37.Insert;
                            if Rec372."Cantidad a pasar pedido" = 0 then begin
                                Rec372.Delete;
                            end;
                            if Rec372."Cantidad a pasar pedido" <> 0 then begin
                                Rec372.Validate(Rec372.Quantity, Rec372.Quantity - Rec372."Cantidad a pasar pedido");
                                Rec372."Cantidad a pasar pedido" := 0;
                                Rec372.Modify;
                            end;
                        end;
                        if (Rec."Fecha envio pendiente stock" > fecha2) and (RecProd."Producto con reserva") then begin
                            ///Message('2  %1 ',Rec372);
                            RecClie.Get(Rec."Sell-to Customer No.");
                            RecMT2.Reset;
                            RecMT2.SetRange(RecMT2.Tabla, 1);
                            RecMT2.SetRange(RecMT2."Codigo 1", Rec372."No.");
                            RecMT2.SetRange(RecMT2."Codigo 2", RecClie."Grupo clientes");
                            if RecMT2.FindFirst then begin
                                Rec37.Init;
                                Rec37 := Rec372;
                                Rec37."Document Type" := 1;
                                Rec37."Document No." := CODACTI;
                                if Rec372."Cantidad a pasar pedido" <> 0 then begin
                                    Rec37.Validate(Rec37.Quantity, Rec372."Cantidad a pasar pedido");
                                end;
                                Rec37.Insert;
                                if Rec372."Cantidad a pasar pedido" = 0 then begin
                                    Rec372.Delete;
                                end;
                                if Rec372."Cantidad a pasar pedido" <> 0 then begin
                                    Rec372.Validate(Rec372.Quantity, Rec372.Quantity - Rec372."Cantidad a pasar pedido");
                                    Rec372."Cantidad a pasar pedido" := 0;
                                    Rec372.Modify;
                                end;
                            end;
                        end;

                        if RecProd."No permite pedido" then begin
                            falta := true;
                        end;
                        if RecProd."Producto con reserva" then begin
                            falta := true;
                        end;
                    end;
                //END;
                until Rec372.Next = 0;
        end;

        Rec372.Reset;
        Rec372.SetRange(Rec372."Document Type", Rec."Document Type");
        Rec372.SetRange(Rec372."Document No.", Rec."No.");
        if Rec372.FindFirst then begin
            ///     Rec."Estado presupuesto":=1;
            ///     Rec.MODIFY;
        end;
        Rec372.Reset;
        Rec372.SetRange(Rec372."Document Type", Rec."Document Type");
        Rec372.SetRange(Rec372."Document No.", Rec."No.");
        if not Rec372.FindFirst then begin
            ///Rec."Estado presupuesto":=2;
            ///Rec.MODIFY;
        end;
        RecLC1.Reset;
        RecLC1.SetRange(RecLC1."Document Type", Rec."Document Type");
        RecLC1.SetRange(RecLC1."No.", Rec."No.");
        if RecLC1.FindFirst then
            repeat
                if not RecLC2.Get(1, Rec362."No.", RecLC1."Line No.") then begin
                    RecLC2 := RecLC1;
                    RecLC2."Document Type" := 1;
                    RecLC2."No." := Rec362."No.";
                    RecLC2.Insert;
                end;

            until RecLC1.Next = 0;

        ///MESSAGE('Nuevo pedido el %1',Rec362."No.");



        RecSDLM.Reset;
        RecSDLM.SetRange(RecSDLM."Journal Template Name", 'PRODUCTO');
        RecSDLM.SetRange(RecSDLM.Name, Rec362."No.");
        if not RecSDLM.FindFirst then begin
            RecSDLM.Init;
            RecSDLM."Journal Template Name" := 'PRODUCTO';
            RecSDLM.Name := Rec362."No.";
            RecSDLM.Insert;
            Rec89.Init;
            Rec89."Journal Template Name" := 'PRODUCTO';
            Rec89."Journal Batch Name" := Rec362."No.";
            Rec89."Line No." := 10000;
            Rec89.Insert;
        end;


        Rec367.Get(1, CODACTI);
        Rec367.CalcFields(Rec367.Base);
        Rec367."Importe total pedido WEB" := Rec367.Base;
        Rec367.Modify;
        Commit;

        Clear(FormPedido);
        RecCV.SetRange(RecCV."Document Type", 1);
        RecCV.SetRange(RecCV."No.", Rec362."No.");
        if RecCV.FindFirst then begin
            FormPedido.SetTableview(RecCV);
            FormPedido.RunModal;
        end;
    end;


    procedure ChequeoFechaVtosOferta()
    begin


        RecCVP.Get;
        Cust.Get(SalesHeader3."Sell-to Customer No.");
        Cust.CalcFields(Cust."Balance (LCY)");
        if Cust."Balance (LCY)" <> 0 then begin
            Fechavto := 0D;
            SEPASA := false;
            Rec21.Reset;
            Rec21.SetCurrentkey("Customer No.", Open, Positive, "Due Date", "Currency Code");
            Rec21.SetRange(Rec21."Customer No.", SalesHeader3."Sell-to Customer No.");
            Rec21.SetRange(Rec21.Positive, true);
            Rec21.SetRange(Rec21.Open, true);
            if Rec21.FindFirst then begin
                Fechavto := Rec21."Due Date";
                if Today - Fechavto > (RecCVP."Dias aviso falta pago" + Cust."Dias tolerancias fecha vto.") then begin
                    SEPASA := true;
                end;
            end;
        end;
    end;


    procedure VerDtoaplicado()
    begin


        /*
        
        IMPORTEPORTE:=0;
        IF Rec."Ship-to Post Code"<>'' THEN BEGIN
             RecCP.RESET;
             RecCP.SETRANGE(RecCP.Code,Rec."Ship-to Post Code");
             IF RecCP.FINDFIRST THEN BEGIN
                  CODPROV:=RecCP."County Code";
                  Rectrap.RESET;
                  Rectrap.SETRANGE(Rectrap.Opcion,0);
                  Rectrap.SETRANGE(Rectrap.Transportista,Rec."Shipping Agent Code");
                  Rectrap.SETRANGE(Rectrap."Cod. provincia",CODPROV);
                  IF Rectrap.FINDFIRST THEN BEGIN
                       Rectrap2.RESET;
                       Rectrap2.SETRANGE(Rectrap2.Opcion,1);
                       Rectrap2.SETRANGE(Rectrap2.Transportista,Rec."Shipping Agent Code");
                       Rectrap2.SETRANGE(Rectrap2.Zona,Rectrap.Zona);
                       Rectrap2.SETRANGE(Rectrap2."Hasta Peso",PESO,99999999);
                       IF Rectrap2.FINDFIRST THEN BEGIN
                           IMPORTEPORTE:=Rectrap2.Importe;
                       END;
                  END;
             END;
        END;
        
        
        
        PESO:=0;
        RecLV3.RESET;
        RecLV3.SETRANGE(RecLV3."Document Type","Document Type");
        RecLV3.SETRANGE(RecLV3."Document No.","No.");
        IF RecLV3.FINDFIRST THEN REPEAT
             PESO:=PESO+RecLV3."Gross Weight"*RecLV3.Quantity;
        UNTIL RecLV3.NEXT=0;
        
        SUMA:=FALSE;
        DTOOPTIMO:=0;
        SUMAPCO2:=0;
        SUMAPCO:=0;
        SUMApb:=0;
        SUMApf:=0;
        Rec37.RESET;
        Rec37.SETRANGE(Rec37."Document Type","Document Type");
        Rec37.SETRANGE(Rec37."Document No.","No.");
        Rec37.SETRANGE(Rec37.Type,2);
        IF Rec37.FINDFIRST THEN REPEAT
             SUMA:=TRUE;
             IF (Rec37."Line Discount %"=100) AND (Rec37.Regalo=FALSE) THEN BEGIN
                  SUMA:=FALSE;
             END;
             IF (Rec37."Line Discount %"=100) AND (Rec37.Defectuosos=TRUE) THEN BEGIN
                  SUMA:=TRUE;
             END;
             IF SUMA THEN BEGIN
                  SUMApb:=SUMApb+Rec37.Quantity*Rec37."Precio base";
                  IF NOT Rec37.Defectuosos THEN BEGIN
                       SUMApf:=SUMApf+Rec37.Quantity*Rec37."Precio final";
                  END;
                  IF Rec37.Defectuosos THEN BEGIN
                       ///// SUMApf:=SUMApf+Rec37.Quantity*Rec37."Unit Price";
                  END;
                  IF RecItem.GET(Rec37."No.") THEN BEGIN
                       SUMAPCO:=SUMAPCO+Rec37.Quantity*RecItem."Unit Cost";
                       costeop:=ROUND(RecItem."Unit Cost"/(1-(46)/100),0.01);
                       SUMAPCO2:=SUMAPCO2+Rec37.Quantity*costeop;
                  END;
             END;
        UNTIL Rec37.NEXT=0;
        
        dtoaplicado:=0;
        IF SUMApb<>0 THEN BEGIN
             dtoaplicado:=ROUND(((SUMApb-SUMApf)/SUMApb)*100,0.01);
        END;
        
        
        
        SUMAPCO:=SUMAPCO+ IMPORTEPORTE;
        SUMAPCO2:=SUMAPCO2+ IMPORTEPORTE;
        
        DTOOPTIMO:=0;
        IF SUMApf<>0 THEN BEGIN
             DTOOPTIMO:=(SUMApf-SUMAPCO)/(SUMApf/100);
        END;
        
        DTOOPTIMO3:=0;
        IF SUMApb<>0 THEN BEGIN
             DTOOPTIMO3:=(1-(SUMAPCO2/SUMApb))*100;
        END;
        
        
        
        RecCfC.GET;
        DTOOPTIMO2:=RecCfC."Margen necesario";
        difmargenes:=DTOOPTIMO-DTOOPTIMO2;
        
        DESCUENTOMAS:=DTOOPTIMO3-dtoaplicado-2;
        
        IF DTOOPTIMO3<>0 THEN BEGIN
             IF DESCUENTOMAS<0 THEN BEGIN
        ///          MESSAGE('No se permite mas descuento.');
             END;
        END;
        
        IF DTOOPTIMO3<>0 THEN BEGIN
             IF DTOOPTIMO3-RecCfC."Margen necesario"<0 THEN BEGIN
             ///     MESSAGE('Este presupuesto supera el maximo permitido.');
             END;
        END;
        */

    end;


    procedure ColoresMargen()
    begin
    end;

    local procedure CalculaSupra()
    begin



        ImporteTarifa := 0;
        ImporteAServir := 0;
        SalesLine.Reset;
        SalesLine.SetRange(SalesLine."Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        if SalesLine.FindSet then
            repeat
                if Item2.Get(SalesLine."No.") then begin
                    if (Item2."No permite pedido" = false) and (Item2."Producto con reserva" = false) then begin
                        ImporteAServir := ImporteAServir + SalesLine.Amount;
                        ImporteTarifa := ImporteTarifa + (SalesLine.Quantity * SalesLine."Unit Price");
                    end;
                end;
            until SalesLine.Next = 0;

        Conseguido := '';
        Multitabla2.Reset;
        Multitabla2.SetRange(Multitabla2.Tabla, 15);
        Multitabla2.SetRange(Multitabla2."Codigo 1", Rec."Sell-to Customer No.");
        Multitabla2.SetRange(Multitabla2."Importe minimo para descuento", 0, ImporteTarifa);
        if Multitabla2.FindLast then begin
            CustomerDiscountGroup.Reset;
            if CustomerDiscountGroup.Get(Multitabla2."Codigo 2") then begin
                Conseguido := Multitabla2."Codigo 2" + ' ' + CustomerDiscountGroup.Description + ' supera: ' + Format(Multitabla2."Importe minimo para descuento");
                Importenuevodto := ImporteTarifa - ROUND(ImporteTarifa * Multitabla2."Descuento a aplicar" / 100, 0.01);
            end;

        end;
    end;

    local procedure PonserSupraOferta()
    begin


        ImporteTarifa := 0;
        ImporteAServir := 0;
        SalesLine.Reset;
        SalesLine.SetRange(SalesLine."Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        if SalesLine.FindSet then
            repeat
                if Item2.Get(SalesLine."No.") then begin
                    if (Item2."No permite pedido" = false) and (Item2."Producto con reserva" = false) then begin
                        ImporteAServir := ImporteAServir + SalesLine.Amount;
                    end;
                end;
            until SalesLine.Next = 0;

        dtoconse := 0;
        CustInvoiceDisc.Reset;
        CustInvoiceDisc.SetRange(CustInvoiceDisc.Code, 'SUPRAOFERTA');
        if CustInvoiceDisc.FindSet then
            repeat
                if ImporteAServir > CustInvoiceDisc."Minimum Amount" then begin
                    dtoconse := CustInvoiceDisc."Discount %";
                end;
            until CustInvoiceDisc.Next = 0;

        SalesLine.Reset;
        SalesLine.SetRange(SalesLine."Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        if SalesLine.FindSet then
            repeat
                if Item2.Get(SalesLine."No.") then begin
                    if (Item2."No permite pedido" = false) and (Item2."Producto con reserva" = false) then begin
                        if SalesLine."Producto asociado" = 0 then begin
                            SalesLine.Validate(SalesLine."Line Discount %", 0);
                            SalesLine.Validate("Customer Disc. Group", '');
                            SalesLine.Validate(SalesLine."Line Discount %", dtoconse);
                            SalesLine.Modify;
                        end;
                    end;
                end;
            until SalesLine.Next = 0;


        Rec."Customer Disc. Group" := Multitabla2."Codigo 2";
        Rec.Modify;

        Message('Hecho.');
    end;

    local procedure ImportarPedido()
    begin

        /////-Clear(ImportacionPEDIDOSOTROS2);
        /////-ImportacionPEDIDOSOTROS2.PasoClie("No.");
        /////-ImportacionPEDIDOSOTROS2.Run;
    end;

    local procedure QuitarSupraOferta()
    begin


        RecClie.Get(Rec."Sell-to Customer No.");
        Rec."Customer Disc. Group" := RecClie."Customer Disc. Group";
        Rec.Modify;

        SalesLine.Reset;
        SalesLine.SetRange(SalesLine."Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        if SalesLine.FindSet then
            repeat
                if Item2.Get(SalesLine."No.") then begin
                    if (Item2."No permite pedido" = false) and (Item2."Producto con reserva" = false) then begin
                        if SalesLine."Producto asociado" = 0 then begin
                            SalesLine.Validate("Customer Disc. Group", Rec."Customer Disc. Group");
                            SalesLine.Modify;
                        end;
                    end;
                end;
            until SalesLine.Next = 0;



        Message('Hecho.');
    end;
}

