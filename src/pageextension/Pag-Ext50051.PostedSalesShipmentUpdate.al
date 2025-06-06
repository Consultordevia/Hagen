pageextension 50051 "Posted SalesShipmentUpdate" extends "Posted Sales Shipment - Update"
{

    layout
    {

        modify("Shipping Agent Code")
        {
            trigger OnAfterValidate();
            var
                RecPc: Record "Post Code";
                RecArea: Record "Area";
                PAGINAWEB: Text;
                nexpefinal: code[20];
            begin

                nexpefinal := Rec."Nº expedición";
                if Rec."Nº expedición dropshp" <> '' then begin
                    nexpefinal := Rec."Nº expedición dropshp";
                end;
                
                if Rec."Shipping Agent Code" = 'DHL' then begin
                    PAGINAWEB := 'http://www.dhl.es/services_es/seg_3dd/integra/SeguimientoDocumentos.aspx?codigo=' +
                                 Format(nexpefinal) + '&anno=2013&lang=sp&refCli=1 , a partir de hoy a las 22:00.';
                end;
                if Rec."Shipping Agent Code" = 'CRON' then begin
                    PAGINAWEB := 'https://www.correosexpress.com/url/v?s=' +
                                Format(nexpefinal) + '&cp=' + Format(Rec."Ship-to Post Code");
                end;
                if Rec."Shipping Agent Code" = 'CORR' then begin
                    PAGINAWEB := 'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                                Format(nexpefinal);
                end;
                if Rec."Shipping Agent Code" = 'TNT' then begin
                    PAGINAWEB := 'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=' +
                                'REF&respLang=ES&respCountry=ES&sourceID=1&sourceCountry=' +
                                'ES&sourceID=1&sourceCountry=ww&cons=' +
                                Format(nexpefinal);
                end;
                if Rec."Shipping Agent Code" = 'TIPSA' then begin
                    PAGINAWEB := 'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                                Format(nexpefinal) +
                                Format(Rec."Ship-to Post Code");
                end;
                Rec."Enlace transporte" := CopyStr(PAGINAWEB, 1, 250);
                Rec."Enlace transporte 2" := CopyStr(PAGINAWEB, 251, 250);
                Rec."Enlace transporte 3" := CopyStr(PAGINAWEB, 501, 250);
                Rec.Modify;
            end;
        }



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
                                if IsHandled then
                                    exit;

                                case ShipToOptions of
                                    ShipToOptions::"Default (Sell-to Address)":
                                        begin
                                            rec.Validate("Ship-to Code", '');
                                            Customer.Get(rec."Sell-to Customer No.");
                                            rec."Ship-to Code" := Customer."Ship-to Code";
                                            rec."Ship-to Name" := Customer.Name;
                                            rec."Ship-to Name 2" := Customer."Name 2";
                                            rec."Ship-to Address" := Customer.Address;
                                            rec."Ship-to Address 2" := Customer."Address 2";
                                            rec."Ship-to City" := Customer.City;
                                            rec."Ship-to Contact" := Customer.Contact;
                                            rec."Ship-to Country/Region Code" := Customer."Country/Region Code";
                                            rec."Ship-to County" := Customer."County";
                                            rec."Ship-to Post Code" := Customer."Post Code";
                                            rec."Ship-to Phone No." := Customer."Phone No.";
                                            IsShipToCountyVisible := FormatAddress.UseCounty(ShipToAddress."Country/Region Code");

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
    procedure CalculateShipBillToOptions(var ShipToOptions: Enum "Sales Ship-to Options"; var SalesHeader: Record "Sales Shipment Header")
    var
        ShipToNameEqualsSellToName: Boolean;
    begin
        ShipToNameEqualsSellToName :=
            (SalesHeader."Ship-to Name" = SalesHeader."Sell-to Customer Name") and (SalesHeader."Ship-to Name 2" = SalesHeader."Sell-to Customer Name 2");

        case true of
            (SalesHeader."Ship-to Code" = '') and ShipToNameEqualsSellToName and ShipToAddressEqualsSellToAddress():
                ShipToOptions := ShipToOptions::"Default (Sell-to Address)";
            (SalesHeader."Ship-to Code" = '') and (not ShipToNameEqualsSellToName or not ShipToAddressEqualsSellToAddress()):
                ShipToOptions := ShipToOptions::"Custom Address";
            SalesHeader."Ship-to Code" <> '':
                ShipToOptions := ShipToOptions::"Alternate Shipping Address";
        end;

    end;

    procedure ShipToAddressEqualsSellToAddress(): Boolean
    begin
        exit(IsShipToAddressEqualToSellToAddress(Rec, Rec));
    end;

    local procedure IsShipToAddressEqualToSellToAddress(SalesHeaderWithSellTo: Record "Sales Shipment Header"; SalesHeaderWithShipTo: Record "Sales Shipment Header"): Boolean
    var
        Result: Boolean;
    begin
        Result :=
          (SalesHeaderWithSellTo."Sell-to Address" = SalesHeaderWithShipTo."Ship-to Address") and
          (SalesHeaderWithSellTo."Sell-to Address 2" = SalesHeaderWithShipTo."Ship-to Address 2") and
          (SalesHeaderWithSellTo."Sell-to City" = SalesHeaderWithShipTo."Ship-to City") and
          (SalesHeaderWithSellTo."Sell-to County" = SalesHeaderWithShipTo."Ship-to County") and
          (SalesHeaderWithSellTo."Sell-to Post Code" = SalesHeaderWithShipTo."Ship-to Post Code") and
          (SalesHeaderWithSellTo."Sell-to Country/Region Code" = SalesHeaderWithShipTo."Ship-to Country/Region Code") and
          (SalesHeaderWithSellTo."Sell-to Phone No." = SalesHeaderWithShipTo."Ship-to Phone No.") and
          (SalesHeaderWithSellTo."Sell-to Contact" = SalesHeaderWithShipTo."Ship-to Contact");
        exit(Result);
    end;

    trigger OnOpenPage()
    begin
        CalculateShipBillToOptions(ShipToOptions, rec);
    end;

    protected var
        ShipToOptions: Enum "Sales Ship-to Options";
        IsShipToCountyVisible: Boolean;
        FormatAddress: Codeunit "Format Address";
        EmptyShipToCodeErr: Label 'The Code field can only be empty if you select Custom Address in the Ship-to field.';
        Customer: Record Customer;
}
