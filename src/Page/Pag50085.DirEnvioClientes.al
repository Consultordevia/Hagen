page 50085 DirEnvioClientes
{
    ApplicationArea = All;
    Caption = 'DirEnvioClientes';
    PageType = List;
    SourceTable = "Ship-to Address";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the customer number.';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies a ship-to address code.';
                }

                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the ship-to address.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the city the items are being shipped to.';
                }
                field("Cod. entrega ECI"; Rec."Cod. entrega ECI")
                {
                    ToolTip = 'Specifies the value of the Cod. entrega ECI field.', Comment = '%';
                }
                field("Cod. forma de pago"; Rec."Cod. forma de pago")
                {
                    ToolTip = 'Specifies the value of the Cod. forma de pago field.', Comment = '%';
                }

                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the name of the person you contact about orders shipped to this address.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region of the address.';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the state, province, or county as a part of the address.';
                }

                field("Direccion Ruta"; Rec."Direccion Ruta")
                {
                    ToolTip = 'Specifies the value of the Direccion Ruta field.', Comment = '%';
                }
                field("Direccion habitual"; Rec."Direccion habitual")
                {
                    ToolTip = 'Specifies the value of the Direccion habitual field.', Comment = '%';
                }
                field("Direccion postal"; Rec."Direccion postal")
                {
                    ToolTip = 'Specifies the value of the Direccion postal field.', Comment = '%';
                }
                field(Dni; Rec.Dni)
                {
                    ToolTip = 'Specifies the value of the Dni field.', Comment = '%';
                }
                field(Dropshipping; Rec.Dropshipping)
                {
                    ToolTip = 'Specifies the value of the Dropshipping field.', Comment = '%';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the recipient''s email address.';
                }
                field("Estatus del cliente"; Rec."Estatus del cliente")
                {
                    ToolTip = 'Specifies the value of the Estatus del cliente field.', Comment = '%';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ToolTip = 'Specifies the recipient''s fax number.';
                }
                field("Filtro ECI"; Rec."Filtro ECI")
                {
                    ToolTip = 'Specifies the value of the Filtro ECI field.', Comment = '%';
                }
                field(GLN; Rec.GLN)
                {
                    ToolTip = 'Specifies the recipient''s GLN code.';
                }
                field("Home Page"; Rec."Home Page")
                {
                    ToolTip = 'Specifies the recipient''s web site.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies when the ship-to address was last modified.';
                }
                field(Latitud; Rec.Latitud)
                {
                    ToolTip = 'Specifies the value of the Latitud field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location code to be used for the recipient.';
                }
                field(Longitud; Rec.Longitud)
                {
                    ToolTip = 'Specifies the value of the Longitud field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name associated with the ship-to address.';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies the value of the Name 2 field.', Comment = '%';
                }
                field("Nº Movil"; Rec."Nº Movil")
                {
                    ToolTip = 'Specifies the value of the Nº Movil field.', Comment = '%';
                }

                field("Place of Export"; Rec."Place of Export")
                {
                    ToolTip = 'Specifies the value of the Place of Export field.', Comment = '%';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies a code for the salesperson who normally handles this customer''s recipient address.';
                }
                field("Salesperson Code2"; Rec."Salesperson Code2")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code field.', Comment = '%';
                }
                field("Service Zone Code"; Rec."Service Zone Code")
                {
                    ToolTip = 'Specifies the code for the service zone in which the ship-to address is located.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies a code for the shipment method to be used for the recipient.';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the code for the shipping agent who is transporting the items.';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ToolTip = 'Specifies the code for the service, such as a one-day delivery, that is offered by the shipping agent.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ToolTip = 'Specifies the value of the Tax Area Code field.', Comment = '%';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ToolTip = 'Specifies the value of the Tax Liable field.', Comment = '%';
                }
                field("Telex Answer Back"; Rec."Telex Answer Back")
                {
                    ToolTip = 'Specifies the value of the Telex Answer Back field.', Comment = '%';
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ToolTip = 'Specifies the value of the Telex No. field.', Comment = '%';
                }
                field("Transportista ficha cliente"; Rec."Transportista ficha cliente")
                {
                    ToolTip = 'Specifies the value of the Transportista ficha cliente field.', Comment = '%';
                }
                field("Enviar a Web Distribuidor"; Rec."Enviar a Web Distribuidor")
                {
                    ToolTip = 'Enviar a Web Distribuidor';
                }
                field(Dir_Shopyfi; Rec.Dir_Shopyfi)
                {
                    ToolTip = 'Dir_Shopyfi';
                }
                field(FechaHoraModificacionWeb; Rec.FechaHoraModificacionWeb)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the recipient''s telephone number.';
                }

            }
        }
    }
}
