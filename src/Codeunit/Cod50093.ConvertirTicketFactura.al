codeunit 50093 "Convertir Ticket Factura"
{
    procedure ConvertirTicket(CabFactura: Record "Sales Invoice Header")
    var
        DialogoCliente: Page "Dialogo Convertir Ticket";
        NuevaCabecera: Record "Sales Header";
        NumCliente: Code[20];
        CIFDialog: Text[20];
        NombreDialog: Text[100];
        DireccionDialog: Text[100];
        Direccion2Dialog: Text[50];
        CodPaisDialog: Code[10];
        PoblacionDialog: Text[30];
        CodPostalDialog: Code[20];
        EmailNotifDialog: Text[250];
        ClienteCATITDialog: Boolean;
    begin
        if CabFactura."Invoice Type" <> CabFactura."Invoice Type"::"F2 Simplified Invoice" then
            Error('Solo se pueden convertir facturas simplificadas (tipo F2).');

        if CabFactura.Cancelled then
            Error('Esta factura ya ha sido anulada.');

        // 1. Mostrar diálogo para obtener datos del cliente de facturación
        DialogoCliente.SetDatosShipTo(CabFactura);
        if DialogoCliente.RunModal() <> Action::OK then
            exit;

        CIFDialog := DialogoCliente.ObtenerCIF();
        NombreDialog := DialogoCliente.ObtenerNombre();
        DireccionDialog := DialogoCliente.ObtenerDireccion();
        Direccion2Dialog := DialogoCliente.ObtenerDireccion2();
        CodPaisDialog := DialogoCliente.ObtenerCodPaisRegion();
        PoblacionDialog := DialogoCliente.ObtenerPoblacion();
        CodPostalDialog := DialogoCliente.ObtenerCodigoPostal();
        EmailNotifDialog := DialogoCliente.ObtenerEmailNotificacion();
        ClienteCATITDialog := DialogoCliente.ObtenerClienteCATIT();

        // 2. Buscar o crear el cliente por CIF
        NumCliente := BuscarOCrearCliente(CIFDialog, NombreDialog, DireccionDialog, Direccion2Dialog,
            CodPaisDialog, PoblacionDialog, CodPostalDialog, EmailNotifDialog, CabFactura);

        // Cliente CATIT (Shopify): se borra el email de la ficha de cliente inicial para que no
        // queden dos fichas con el mismo email y los futuros pedidos de Shopify se asignen a la nueva.
        if ClienteCATITDialog then
            BorrarEmailClienteInicial(CabFactura."Sell-to Customer No.", NumCliente);

        // 3. Nota de abono correctiva estándar de BC
        CrearYRegistrarAbono(CabFactura);

        // 4. Crear la nueva factura de venta con sell-to/ship-to del ticket y bill-to del diálogo
        NuevaCabecera := CrearFactura(CabFactura, NumCliente, NombreDialog, DireccionDialog,
            Direccion2Dialog, CodPaisDialog, PoblacionDialog, CodPostalDialog, CIFDialog);

        // 5. Mostrar la factura para que el usuario la revise y registre
        Page.Run(Page::"Sales Invoice", NuevaCabecera);
    end;

    local procedure BuscarOCrearCliente(CIF: Text[20]; Nombre: Text[100]; Direccion: Text[100];
        Direccion2: Text[50]; CodPais: Code[10]; Poblacion: Text[30]; CodPostal: Code[20];
        EmailNotif: Text[250]; CabFactura: Record "Sales Invoice Header"): Code[20]
    var
        Cliente: Record Customer;
        ClientePlantilla: Record Customer;
    begin
        Cliente.Reset();
        Cliente.SetRange("VAT Registration No.", CIF);
        if Cliente.FindFirst() then begin
            Cliente.Validate(Name, CopyStr(Nombre, 1, MaxStrLen(Cliente.Name)));
            Cliente.Validate(Address, CopyStr(Direccion, 1, MaxStrLen(Cliente.Address)));
            Cliente."Address 2" := CopyStr(Direccion2, 1, MaxStrLen(Cliente."Address 2"));
            Cliente."Country/Region Code" := CodPais;
            Cliente.Validate(City, CopyStr(Poblacion, 1, MaxStrLen(Cliente.City)));
            Cliente."Post Code" := CopyStr(CodPostal, 1, MaxStrLen(Cliente."Post Code"));
            OnBeforeModificarCliente(Cliente, EmailNotif);
            Cliente.Modify(true);
            exit(Cliente."No.");
        end;

        // El cliente no existe: se crea con los datos introducidos
        Cliente.Init();
        Cliente.Insert(true);
        Cliente.Validate(Name, CopyStr(Nombre, 1, MaxStrLen(Cliente.Name)));
        Cliente.Validate(Address, CopyStr(Direccion, 1, MaxStrLen(Cliente.Address)));
        Cliente."Address 2" := CopyStr(Direccion2, 1, MaxStrLen(Cliente."Address 2"));
        Cliente."Country/Region Code" := CodPais;
        Cliente.Validate(City, CopyStr(Poblacion, 1, MaxStrLen(Cliente.City)));
        Cliente."Post Code" := CopyStr(CodPostal, 1, MaxStrLen(Cliente."Post Code"));
        Cliente."VAT Registration No." := CopyStr(CIF, 1, MaxStrLen(Cliente."VAT Registration No."));

        // Se copian los grupos de contabilización del cliente del ticket como plantilla
        if ClientePlantilla.Get(CabFactura."Sell-to Customer No.") then begin
            Cliente."Customer Posting Group" := ClientePlantilla."Customer Posting Group";
            Cliente."Gen. Bus. Posting Group" := ClientePlantilla."Gen. Bus. Posting Group";
            Cliente."VAT Bus. Posting Group" := ClientePlantilla."VAT Bus. Posting Group";
            Cliente."Customer Price Group" := ClientePlantilla."Customer Price Group";
            Cliente."Customer Disc. Group" := ClientePlantilla."Customer Disc. Group";
            Cliente."Payment Terms Code" := ClientePlantilla."Payment Terms Code";
            Cliente."Payment Method Code" := ClientePlantilla."Payment Method Code";
            Cliente."Currency Code" := ClientePlantilla."Currency Code";
        end;

        OnBeforeModificarCliente(Cliente, EmailNotif);
        Cliente.Modify(true);
        exit(Cliente."No.");
    end;

    local procedure BorrarEmailClienteInicial(NumClienteInicial: Code[20]; NumClienteNuevo: Code[20])
    var
        ClienteInicial: Record Customer;
    begin
        // Si la nueva ficha es la misma que la inicial no hay nada que limpiar.
        if NumClienteInicial = NumClienteNuevo then
            exit;

        if not ClienteInicial.Get(NumClienteInicial) then
            exit;

        if ClienteInicial."E-Mail" = '' then
            exit;

        ClienteInicial."E-Mail" := '';
        ClienteInicial.Modify(true);
    end;

    local procedure CrearYRegistrarAbono(CabFactura: Record "Sales Invoice Header")
    var
        CabAbono: Record "Sales Header";
        LinAbono: Record "Sales Line";
        LinFactura: Record "Sales Invoice Line";
        RegistrarVenta: Codeunit "Sales-Post";
        NumLinea: Integer;
    begin
        CabAbono.Init();
        CabAbono."Document Type" := CabAbono."Document Type"::"Credit Memo";
        CabAbono.Insert(true);
        CabAbono.Validate("Sell-to Customer No.", CabFactura."Sell-to Customer No.");

        // El ticket lleva precios con IVA incluido: hay que replicar el flag para que el
        // Unit Price copiado se interprete como importe con IVA y no se vuelva a sumar el IVA.
        CabAbono.Validate("Prices Including VAT", CabFactura."Prices Including VAT");

        // Sell-to del ticket
        CabAbono."Sell-to Customer Name" := CabFactura."Sell-to Customer Name";
        CabAbono."Sell-to Address" := CabFactura."Sell-to Address";
        CabAbono."Sell-to Address 2" := CabFactura."Sell-to Address 2";
        CabAbono."Sell-to City" := CabFactura."Sell-to City";
        CabAbono."Sell-to Post Code" := CabFactura."Sell-to Post Code";
        CabAbono."Sell-to Country/Region Code" := CabFactura."Sell-to Country/Region Code";
        CabAbono."Sell-to County" := CabFactura."Sell-to County";

        // Ship-to del ticket
        CabAbono."Ship-to Name" := CabFactura."Ship-to Name";
        CabAbono."Ship-to Address" := CabFactura."Ship-to Address";
        CabAbono."Ship-to Address 2" := CabFactura."Ship-to Address 2";
        CabAbono."Ship-to City" := CabFactura."Ship-to City";
        CabAbono."Ship-to Post Code" := CabFactura."Ship-to Post Code";
        CabAbono."Ship-to Country/Region Code" := CabFactura."Ship-to Country/Region Code";
        CabAbono."Ship-to County" := CabFactura."Ship-to County";
        CabAbono."Ship-to Contact" := CabFactura."Ship-to Contact";

        // Referencia al ticket original
        CabAbono."External Document No." := CabFactura."No.";
        CabAbono."Your Reference" := CabFactura."Your Reference";

        // Sin Applies-to: el módulo Cartera no permite aplicación automática;
        // el abono quedará abierto para conciliación manual desde Cartera.
        CabAbono."Corrected Invoice No." := CabFactura."No.";
        CabAbono.Modify(true);

        // Copiar líneas de la factura registrada al abono
        LinFactura.SetRange("Document No.", CabFactura."No.");
        if LinFactura.FindSet() then begin
            NumLinea := 10000;
            repeat
                LinAbono.Init();
                LinAbono."Document Type" := CabAbono."Document Type";
                LinAbono."Document No." := CabAbono."No.";
                LinAbono."Line No." := NumLinea;
                LinAbono.Insert(true);
                LinAbono.Validate(Type, LinFactura.Type);
                if LinFactura.Type <> LinFactura.Type::" " then begin
                    LinAbono.Validate("No.", LinFactura."No.");
                    LinAbono.Validate("Unit of Measure Code", LinFactura."Unit of Measure Code");
                    LinAbono.Validate(Quantity, LinFactura.Quantity);
                    LinAbono.Validate("Unit Price", LinFactura."Unit Price");
                    LinAbono.Validate("Line Discount %", LinFactura."Line Discount %");
                end;
                LinAbono.Description := LinFactura.Description;
                LinAbono.Modify(true);
                NumLinea += 10000;
            until LinFactura.Next() = 0;
        end;

        RegistrarVenta.Run(CabAbono);
    end;

    local procedure CrearFactura(CabFacturaOrigen: Record "Sales Invoice Header"; NumCliente: Code[20];
        NombreFacturacion: Text[100]; DireccionFacturacion: Text[100]; Direccion2Facturacion: Text[50];
        CodPaisFacturacion: Code[10]; PoblacionFacturacion: Text[30]; CodPostalFacturacion: Code[20];
        CIFFacturacion: Text[20]): Record "Sales Header"
    var
        NuevaCab: Record "Sales Header";
        NuevaLin: Record "Sales Line";
        LinFactura: Record "Sales Invoice Line";
        NumLinea: Integer;
    begin
        NuevaCab.Init();
        NuevaCab."Document Type" := NuevaCab."Document Type"::Invoice;
        NuevaCab.Insert(true);

        // Validar cliente → BC configura grupos de contabilización, condiciones de pago, etc.
        NuevaCab.Validate("Sell-to Customer No.", NumCliente);

        // El ticket lleva precios con IVA incluido: hay que replicar el flag para que el
        // Unit Price copiado se interprete como importe con IVA y no se vuelva a sumar el IVA.
        NuevaCab.Validate("Prices Including VAT", CabFacturaOrigen."Prices Including VAT");

        // Sell-to: datos del diálogo (sobreescriben lo que haya puesto el Validate)
        NuevaCab."Sell-to Customer Name" := CopyStr(NombreFacturacion, 1, MaxStrLen(NuevaCab."Sell-to Customer Name"));
        NuevaCab."Sell-to Address" := CopyStr(DireccionFacturacion, 1, MaxStrLen(NuevaCab."Sell-to Address"));
        NuevaCab."Sell-to Address 2" := CopyStr(Direccion2Facturacion, 1, MaxStrLen(NuevaCab."Sell-to Address 2"));
        NuevaCab."Sell-to Country/Region Code" := CodPaisFacturacion;
        NuevaCab."Sell-to City" := CopyStr(PoblacionFacturacion, 1, MaxStrLen(NuevaCab."Sell-to City"));
        NuevaCab."Sell-to Post Code" := CopyStr(CodPostalFacturacion, 1, MaxStrLen(NuevaCab."Sell-to Post Code"));

        // Bill-to / Fact-to: mismos datos del diálogo
        NuevaCab."Bill-to Customer No." := NumCliente;
        NuevaCab."Bill-to Name" := CopyStr(NombreFacturacion, 1, MaxStrLen(NuevaCab."Bill-to Name"));
        NuevaCab."Bill-to Address" := CopyStr(DireccionFacturacion, 1, MaxStrLen(NuevaCab."Bill-to Address"));
        NuevaCab."Bill-to Address 2" := CopyStr(Direccion2Facturacion, 1, MaxStrLen(NuevaCab."Bill-to Address 2"));
        NuevaCab."Bill-to Country/Region Code" := CodPaisFacturacion;
        NuevaCab."Bill-to City" := CopyStr(PoblacionFacturacion, 1, MaxStrLen(NuevaCab."Bill-to City"));
        NuevaCab."Bill-to Post Code" := CopyStr(CodPostalFacturacion, 1, MaxStrLen(NuevaCab."Bill-to Post Code"));
        NuevaCab."VAT Registration No." := CopyStr(CIFFacturacion, 1, MaxStrLen(NuevaCab."VAT Registration No."));

        // Ship-to: se copia íntegramente del ticket
        NuevaCab."Ship-to Code" := CabFacturaOrigen."Ship-to Code";
        NuevaCab."Ship-to Name" := CabFacturaOrigen."Ship-to Name";
        NuevaCab."Ship-to Name 2" := CabFacturaOrigen."Ship-to Name 2";
        NuevaCab."Ship-to Address" := CabFacturaOrigen."Ship-to Address";
        NuevaCab."Ship-to Address 2" := CabFacturaOrigen."Ship-to Address 2";
        NuevaCab."Ship-to City" := CabFacturaOrigen."Ship-to City";
        NuevaCab."Ship-to Post Code" := CabFacturaOrigen."Ship-to Post Code";
        NuevaCab."Ship-to Country/Region Code" := CabFacturaOrigen."Ship-to Country/Region Code";
        NuevaCab."Ship-to County" := CabFacturaOrigen."Ship-to County";
        NuevaCab."Ship-to Contact" := CabFacturaOrigen."Ship-to Contact";

        // Referencias del ticket; la fecha de registro/documento es la del día en curso
        NuevaCab."External Document No." := CabFacturaOrigen."No.";
        NuevaCab."Your Reference" := CabFacturaOrigen."Your Reference";
        NuevaCab."Posting Date" := WorkDate();
        NuevaCab."Document Date" := WorkDate();
        NuevaCab.Modify(true);

        // Copiar líneas del ticket a la nueva factura
        LinFactura.SetRange("Document No.", CabFacturaOrigen."No.");
        if LinFactura.FindSet() then begin
            NumLinea := 10000;
            repeat
                NuevaLin.Init();
                NuevaLin."Document Type" := NuevaCab."Document Type";
                NuevaLin."Document No." := NuevaCab."No.";
                NuevaLin."Line No." := NumLinea;
                NuevaLin.Insert(true);
                NuevaLin.Validate(Type, LinFactura.Type);
                if LinFactura.Type <> LinFactura.Type::" " then begin
                    NuevaLin.Validate("No.", LinFactura."No.");
                    NuevaLin.Validate("Unit of Measure Code", LinFactura."Unit of Measure Code");
                    NuevaLin.Validate(Quantity, LinFactura.Quantity);
                    NuevaLin.Validate("Unit Price", LinFactura."Unit Price");
                    NuevaLin.Validate("Line Discount %", LinFactura."Line Discount %");
                end;
                NuevaLin.Description := LinFactura.Description;
                NuevaLin.Modify(true);
                NumLinea += 10000;
            until LinFactura.Next() = 0;
        end;

        exit(NuevaCab);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeModificarCliente(var Cliente: Record Customer; EmailNotif: Text[250])
    begin
    end;
}
