page 50190 "Dialogo Convertir Ticket"
{
    PageType = StandardDialog;
    Caption = 'Convertir Ticket a Factura';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(DatosCliente)
            {
                Caption = 'Datos del cliente para facturar';
                field(CIF; CIF)
                {
                    ApplicationArea = All;
                    Caption = 'CIF / NIF';
                    ToolTip = 'Introduce el CIF o NIF del cliente. Si ya existe en el sistema se recuperarán sus datos.';
                    trigger OnValidate()
                    var
                        Cliente: Record Customer;
                    begin
                        if CIF = '' then
                            exit;
                        Cliente.Reset();
                        Cliente.SetRange("VAT Registration No.", CIF);
                        if Cliente.FindFirst() then begin
                            Nombre := Cliente.Name;
                            Direccion := Cliente.Address;
                            Direccion2 := Cliente."Address 2";
                            CodPaisRegion := Cliente."Country/Region Code";
                            Poblacion := Cliente.City;
                            CodigoPostal := Cliente."Post Code";
                            OnAfterFindClienteByCIF(Cliente, EmailNotificacion);
                        end;
                    end;
                }
                field(Nombre; Nombre)
                {
                    ApplicationArea = All;
                    Caption = 'Nombre';
                    ToolTip = 'Nombre del cliente.';
                }
                field(Direccion; Direccion)
                {
                    ApplicationArea = All;
                    Caption = 'Dirección';
                    ToolTip = 'Dirección del cliente.';
                }
                field(Direccion2; Direccion2)
                {
                    ApplicationArea = All;
                    Caption = 'Dirección 2';
                    ToolTip = 'Segunda línea de dirección del cliente.';
                }
                field(CodPaisRegion; CodPaisRegion)
                {
                    ApplicationArea = All;
                    Caption = 'Cód. País/Región';
                    ToolTip = 'Código de país o región del cliente.';
                    TableRelation = "Country/Region";
                }
                field(Poblacion; Poblacion)
                {
                    ApplicationArea = All;
                    Caption = 'Población';
                    ToolTip = 'Población del cliente.';
                }
                field(CodigoPostal; CodigoPostal)
                {
                    ApplicationArea = All;
                    Caption = 'Código Postal';
                    ToolTip = 'Código postal del cliente.';
                }
                field(EmailNotificacion; EmailNotificacion)
                {
                    ApplicationArea = All;
                    Caption = 'Email Notificación Envío';
                    ToolTip = 'Email al que se enviarán las comunicaciones automáticas para este cliente.';
                }
                field(ClienteCATIT; ClienteCATIT)
                {
                    ApplicationArea = All;
                    Caption = 'Cliente CATIT';
                    ToolTip = 'Marca si es un cliente CATIT (Shopify). Al activarlo, se borrará el email de la ficha de cliente inicial para que los futuros pedidos de Shopify se asignen a la nueva ficha.';
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = Action::OK then begin
            if CIF = '' then begin
                Message('Debe introducir el CIF/NIF del cliente.');
                exit(false);
            end;
            if Nombre = '' then begin
                Message('Debe introducir el nombre del cliente.');
                exit(false);
            end;
        end;
        exit(true);
    end;

    var
        CIF: Text[20];
        Nombre: Text[100];
        Direccion: Text[100];
        Direccion2: Text[50];
        CodPaisRegion: Code[10];
        Poblacion: Text[30];
        CodigoPostal: Code[20];
        EmailNotificacion: Text[250];
        ClienteCATIT: Boolean;

    procedure ObtenerCIF(): Text[20]
    begin
        exit(CIF);
    end;

    procedure ObtenerNombre(): Text[100]
    begin
        exit(Nombre);
    end;

    procedure ObtenerDireccion(): Text[100]
    begin
        exit(Direccion);
    end;

    procedure ObtenerDireccion2(): Text[50]
    begin
        exit(Direccion2);
    end;

    procedure ObtenerCodPaisRegion(): Code[10]
    begin
        exit(CodPaisRegion);
    end;

    procedure ObtenerPoblacion(): Text[30]
    begin
        exit(Poblacion);
    end;

    procedure ObtenerCodigoPostal(): Code[20]
    begin
        exit(CodigoPostal);
    end;

    procedure ObtenerEmailNotificacion(): Text[250]
    begin
        exit(EmailNotificacion);
    end;

    procedure ObtenerClienteCATIT(): Boolean
    begin
        exit(ClienteCATIT);
    end;

    procedure SetDatosShipTo(CabFactura: Record "Sales Invoice Header")
    begin
        Nombre := CopyStr(CabFactura."Ship-to Name", 1, MaxStrLen(Nombre));
        Direccion := CopyStr(CabFactura."Ship-to Address", 1, MaxStrLen(Direccion));
        Direccion2 := CopyStr(CabFactura."Ship-to Address 2", 1, MaxStrLen(Direccion2));
        CodPaisRegion := CabFactura."Ship-to Country/Region Code";
        Poblacion := CopyStr(CabFactura."Ship-to City", 1, MaxStrLen(Poblacion));
        CodigoPostal := CopyStr(CabFactura."Ship-to Post Code", 1, MaxStrLen(CodigoPostal));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFindClienteByCIF(Cliente: Record Customer; var EmailNotificacion: Text[250])
    begin
    end;
}
