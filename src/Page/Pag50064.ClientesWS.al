page 50064 ClientesWS

{
    ApplicationArea = all;
    Caption = 'ClientesWS';
    Editable = true;
    InsertAllowed = true;
    PageType = API;
    //PageType = List;
    SourceTable = Customer;
    //InsertAllowed = true;
    DelayedInsert = true;
    UsageCategory = Lists;
    APIPublisher = 'HAGENapi';
    APIGroup = 'HAGENapp';
    APIVersion = 'v1.0';
    EntityName = 'apphistlinesHAGEN';
    EntitySetName = 'apphistlineHAGEN';



    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No"; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique number that identifies the customer. The number can be generated automatically from a number series, or you can number each of them manually.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s name that appears on all related documents. For companies, specify the company''s name here, and then add the relevant people as contacts that you link to this customer.';
                }
                field("Name2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies an additional part of the name.';
                    Visible = false;
                }
                field("CatalogoShopify";Rec."Catalogo Shopify")
                {
                    ApplicationArea = Basic;
                }                
                field("ResponsibilityCenter"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code of the responsibility center, such as a distribution hub, that is associated with the involved user, company, customer, or vendor.';
                }
                field("LocationCode"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies from which location sales to this customer will be processed by default.';
                }
                field("PostCode"; Rec."Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the postal code.';
                    Visible = false;
                }
                field("CountryRegionCode"; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region of the address.';
                    Visible = false;
                }
                field("PhoneNo"; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer''s telephone number.';
                }
                field("ICPartnerCode"; Rec."IC Partner Code")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the customer''s intercompany partner code.';
                    Visible = false;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the person you regularly contact when you do business with this customer.';
                }
                field(ContactoAInsertar; Rec.ContactoAInsertar)
                {
                    ApplicationArea = All;
                }

                field("SalespersonCode"; Rec."Salesperson Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a code for the salesperson who normally handles this customer''s account.';
                    Visible = false;
                }
                field("CustomerPostingGroup"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer''s market type to link business transactions to.';
                    Visible = false;
                }
                field("AllowMultiplePostingGroups"; Rec."Allow Multiple Posting Groups")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if multiple posting groups can be used for posting business transactions for this customer.';
                    //Visible = IsAllowMultiplePostingGroupsVisible;
                }
                field("GenBusPostingGroup"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer''s trade type to link transactions made for this customer with the appropriate general ledger account according to the general posting setup.';
                    Visible = false;
                }
                field("VATBusPostingGroup"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                    Visible = false;
                }
                field("CustomerPriceGroup"; Rec."Customer Price Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer price group code, which you can use to set up special sales prices in the Sales Prices window.';
                    Visible = false;
                }
                field("CustomerDiscGroup"; Rec."Customer Disc. Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer discount group code, which you can use as a criterion to set up special discounts in the Sales Line Discounts window.';
                    Visible = false;
                }
                field("PaymentTermsCode"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                    Visible = false;
                }
                field("ReminderTermsCode"; Rec."Reminder Terms Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies how reminders about late payments are handled for this customer.';
                    Visible = false;
                }
                field("FinChargeTermsCode"; Rec."Fin. Charge Terms Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for the involved finance charges in case of late payment.';
                    Visible = false;
                }
                field("CurrencyCode"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the default currency for the customer.';
                    Visible = false;
                }
                field("LanguageCode"; Rec."Language Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the language that is used when translating specified text on documents to foreign business partner, such as an item description on an order confirmation.';
                    Visible = false;
                }
                field("SearchName"; Rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                    Visible = false;
                }
                field("CreditLimitLCY"; Rec."Credit Limit (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.';
                    Visible = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a customer that is declared insolvent or an item that is placed in quarantine.';
                    Visible = false;
                }
                field("PrivacyBlocked"; Rec."Privacy Blocked")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                    Visible = false;
                }
                field("LastDateModified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies when the customer card was last modified.';
                    Visible = false;
                }
                field("ApplicationMethod"; Rec."Application Method")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how to apply payments to entries for this customer.';
                    Visible = false;
                }
                field("CombineShipments"; Rec."Combine Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if several orders delivered to the customer can appear on the same sales invoice.';
                    Visible = false;
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = Reservation;
                    ToolTip = 'Specifies whether items will never, automatically (Always), or optionally be reserved for this customer. Optional means that you must manually reserve items for this customer.';
                    Visible = false;
                }
                field("ShiptoCode"; Rec."Ship-to Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';
                    Visible = false;
                }
                field("ShippingAdvice"; Rec."Shipping Advice")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the customer accepts partial shipment of orders.';
                    Visible = false;
                }
                field("ShippingAgentCode"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for the shipping agent who is transporting the items.';
                    Visible = false;
                }
                field("BaseCalendarCode"; Rec."Base Calendar Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a customizable calendar for shipment planning that holds the customer''s working days and holidays.';
                    Visible = false;
                }
                field("BalanceLCY"; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';

                    trigger OnDrillDown()
                    begin
                        Rec.OpenCustomerLedgerEntries(false);
                    end;
                }
                field("BalanceDueLCY"; Rec."Balance Due (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies payments from the customer that are overdue per today''s date.';

                    trigger OnDrillDown()
                    begin
                        Rec.OpenCustomerLedgerEntries(true);
                    end;
                }
                field("SalesLCY"; Rec."Sales (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total net amount of sales to the customer in LCY.';
                }
                field("PaymentsLCY"; Rec."Payments (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of payments received from the customer.';
                }
                field("CoupledtoCRM"; Rec."Coupled to CRM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the customer is coupled to an account in Dataverse.';
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced by flow field Coupled to Dataverse';
                    ObsoleteTag = '23.0';
                }
                field("CoupledtoDataverse"; Rec."Coupled to Dataverse")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the customer is coupled to an account in Dataverse.';
                    //Visible = CRMIntegrationEnabled or CDSIntegrationEnabled;
                }

                field("PaymentMethodCode"; Rec."Payment Method Code") { ApplicationArea = All; }
                field("VATRegistrationNo"; Rec."VAT Registration No.") { ApplicationArea = All; }
                field(NombreVendedor; NombreVendedor) { ApplicationArea = All; }
                field("Topproduccto1"; Rec."Top produccto 1") { ApplicationArea = All; }
                field("Topproduccto2"; Rec."Top produccto 2") { ApplicationArea = All; }
                field("Topproduccto3"; Rec."Top produccto 3") { ApplicationArea = All; }
                field("Topproduccto4"; Rec."Top produccto 4") { ApplicationArea = All; }
                field("Topproduccto5"; Rec."Top produccto 5") { ApplicationArea = All; }
                field("Topproduccto6"; Rec."Top produccto 6") { ApplicationArea = All; }
                field("Topproduccto7"; Rec."Top produccto 7") { ApplicationArea = All; }
                field("Topproduccto8"; Rec."Top produccto 8") { ApplicationArea = All; }
                field("Topproduccto9"; Rec."Top produccto 9") { ApplicationArea = All; }
                field("Topproduccto10"; Rec."Top produccto 10") { ApplicationArea = All; }
                field("UsuarioWeb"; Rec."Usuario Web") { ApplicationArea = All; }
                field("Grupoclientes"; Rec."Grupo clientes") { ApplicationArea = All; }
                field(Latitud; Rec.Latitud) { ApplicationArea = All; }
                field(Longitud; Rec.Longitud) { ApplicationArea = All; }
                field(City; Rec.city) { ApplicationArea = All; }
                field(County; Rec.County) { ApplicationArea = All; }
                field(Address; Rec.Address) { ApplicationArea = All; }
                field("Address2"; Rec."Address 2") { ApplicationArea = All; }
                field("EnviaraWeb"; Rec."Enviar a Web") { ApplicationArea = All; }
                field("EnviaraWebDistribuidor"; Rec."Enviar a Web Distribuidor") { ApplicationArea = All; }
                field("Estatusdelcliente"; Rec."Estatus del cliente") { ApplicationArea = All; }

            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //if ContactoInsertar <> '' then
        //  rec.Validate(Contact, ContactoInsertar);
    end;

    trigger OnAfterGetRecord()
    begin
        NombreVendedor := '';
        IF RecVendedores.get(Rec."Salesperson Code") then begin
            NombreVendedor := RecVendedores.Name;
        end;
    end;

    var
        RecVendedores: Record "Salesperson/Purchaser";
        NombreVendedor: text;
    //ContactoInsertar: code[100];


}

