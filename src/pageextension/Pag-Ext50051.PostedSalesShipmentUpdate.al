pageextension 50051 "Posted SalesShipmentUpdate" extends "Posted Sales Shipment - Update"
{

    layout
    {

        addafter("Package Tracking No.")
        {
            field("Numero segumiento"; Rec."Numero segumiento") { ApplicationArea = All; }
            field("Nº expedición"; Rec."Nº expedición") { ApplicationArea = All; }
            field("Estado Expedicion"; Rec."Estado Expedicion") { ApplicationArea = All; }
            field("Observación para transporte"; Rec."Observación para transporte") { ApplicationArea = All; }
            field("Nº bultos"; Rec."Nº bultos")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    rec."Total bultos" := rec."Nº bultos" + rec."Nº Palets";
                end;
            }
            field("Nº Palets"; Rec."Nº Palets")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    rec."Total bultos" := rec."Nº bultos" + rec."Nº Palets";
                end;
            }
            field("Total bultos"; Rec."Total bultos") { ApplicationArea = All; Editable = False; }
            field("Total peso"; Rec."Total peso") { ApplicationArea = All; }
            field(ASN; Rec.ASN) { ApplicationArea = All; }
        }
        addafter(Shipping)
        {
            group(Direccion)
            {
                Caption = 'Dirección de envío';
                group(Control91)
                {
                    ShowCaption = false;
                    group(Control90)
                    {
                        ShowCaption = false;
                        field(ShippingOptions; ShipToOptions)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Ship-to';
                            ToolTip = 'Specifies the address that the products on the sales document are shipped to. Default (Sell-to Address): The same as the customer''s sell-to address. Alternate Ship-to Address: One of the customer''s alternate ship-to addresses. Custom Address: Any ship-to address that you specify in the fields below.';

                            trigger OnValidate()
                            var
                                ShipToAddress: Record "Ship-to Address";
                                ShipToAddressList: Page "Ship-to Address List";
                                IsHandled: Boolean;
                                Order: Record "Sales Header";

                            begin
                                IsHandled := false;
                                // OnBeforeValidateShipToOptions(Rec, ShipToOptions.AsInteger(), IsHandled);
                                if IsHandled then
                                    exit;

                                case ShipToOptions of
                                    ShipToOptions::"Default (Sell-to Address)":
                                        begin
                                            // Order.SetRange("No.", rec."Order No.");
                                            // Order.FindFirst();       // TODOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
                                            // Order.Validate("Ship-to Code", '');
                                            // Rec.CopySellToAddressToShipToAddress();
                                            //TODO Ir a customer y coger los campos de la tabla ship to.
                                            //                                             "Ship-to Address" := "Sell-to Address";
                                            // "Ship-to Address 2" := "Sell-to Address 2";
                                            // "Ship-to City" := "Sell-to City";
                                            // "Ship-to Contact" := "Sell-to Contact";
                                            // "Ship-to Country/Region Code" := "Sell-to Country/Region Code";
                                            // "Ship-to County" := "Sell-to County";
                                            // "Ship-to Post Code" := "Sell-to Post Code";
                                            // "Ship-to Phone No." := "Sell-to Phone No.";

                                        end;
                                    ShipToOptions::"Alternate Shipping Address":
                                        begin
                                            ShipToAddress.SetRange("Customer No.", Rec."Sell-to Customer No.");
                                            ShipToAddressList.LookupMode := true;
                                            ShipToAddressList.SetTableView(ShipToAddress);

                                            if ShipToAddressList.RunModal() = ACTION::LookupOK then begin
                                                ShipToAddressList.GetRecord(ShipToAddress);
                                                rec."Ship-to Address" := ShipToAddress.Address;
                                                rec."Ship-to Address 2" := ShipToAddress."Address 2";
                                                rec."Ship-to Name" := ShipToAddress.Name;
                                                rec."Ship-to Name 2" := ShipToAddress."Name 2";
                                                rec."Ship-to City" := ShipToAddress.City;
                                                rec."Ship-to County" := ShipToAddress.County;
                                                rec."Ship-to Post Code" := ShipToAddress."Post Code";
                                                rec."Ship-to Country/Region Code" := ShipToAddress."Country/Region Code";
                                                rec."Ship-to Phone No." := ShipToAddress."Phone No.";
                                                rec."Ship-to Contact" := ShipToAddress.Contact;


                                                Rec.Validate("Ship-to Code", ShipToAddress.Code);
                                                IsShipToCountyVisible := FormatAddress.UseCounty(ShipToAddress."Country/Region Code");
                                            end else
                                                ShipToOptions := ShipToOptions::"Custom Address";
                                        end;
                                    ShipToOptions::"Custom Address":
                                        begin
                                            Rec.Validate("Ship-to Code", '');
                                            IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
                                        end;
                                end;

                                // OnAfterValidateShippingOptions(Rec, ShipToOptions.AsInteger());
                            end;
                        }
                        group(Control4)
                        {
                            ShowCaption = false;
                            Visible = not (ShipToOptions = ShipToOptions::"Default (Sell-to Address)");
                            field("Ship-to Code"; Rec."Ship-to Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Code';
                                Editable = ShipToOptions = ShipToOptions::"Alternate Shipping Address";
                                Importance = Promoted;
                                ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';

                                trigger OnValidate()
                                var
                                    ShipToAddress: Record "Ship-to Address";
                                begin
                                    if (xRec."Ship-to Code" <> '') and (Rec."Ship-to Code" = '') then
                                        Error(EmptyShipToCodeErr);
                                    if Rec."Ship-to Code" <> '' then begin
                                        ShipToAddress.Get(Rec."Sell-to Customer No.", Rec."Ship-to Code");
                                        IsShipToCountyVisible := FormatAddress.UseCounty(ShipToAddress."Country/Region Code");
                                    end else
                                        IsShipToCountyVisible := false;
                                end;
                            }
                            field("Ship-to Name"; Rec."Ship-to Name")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Name';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                            }
                            field("Ship-to Name 2"; Rec."Ship-to Name 2")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Name 2';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                ToolTip = 'Specifies an additional part of the name that products on the sales document will be shipped to.';
                                QuickEntry = false;
                                Visible = false;
                            }
                            field("Ship-to Address"; Rec."Ship-to Address")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Address';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Specifies the address that products on the sales document will be shipped to.';
                            }
                            field("Ship-to Address 2"; Rec."Ship-to Address 2")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Address 2';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Specifies additional address information.';
                            }
                            field("Ship-to City"; Rec."Ship-to City")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'City';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Specifies the city of the customer on the sales document.';
                            }
                            group(Control297)
                            {
                                ShowCaption = false;
                                Visible = IsShipToCountyVisible;
                                field("Ship-to County"; Rec."Ship-to County")
                                {
                                    ApplicationArea = Basic, Suite;
                                    Caption = 'County';
                                    Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                    QuickEntry = false;
                                    ToolTip = 'Specifies the state, province or county of the address.';
                                }
                            }
                            field("Ship-to Post Code"; Rec."Ship-to Post Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Post Code';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Specifies the postal code.';
                            }
                            field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Country/Region';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the customer''s country/region.';

                                trigger OnValidate()
                                begin
                                    IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
                                end;
                            }
                        }
                        field("Ship-to Phone No."; Rec."Ship-to Phone No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Phone No.';
                            ToolTip = 'Specifies the telephone number of the company''s shipping address.';
                        }
                        field("Ship-to Contact"; Rec."Ship-to Contact")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Contact';
                            ToolTip = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.';
                        }
                    }

                }
            }
        }

    }
    actions
    {
    }



    protected var
        ShipToOptions: Enum "Sales Ship-to Options";
        IsShipToCountyVisible: Boolean;
        FormatAddress: Codeunit "Format Address";
        EmptyShipToCodeErr: Label 'The Code field can only be empty if you select Custom Address in the Ship-to field.';
        Customer: Record Customer;
}
