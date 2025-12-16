codeunit 50018 "Customer WS Mgt"
{
    trigger OnRun()
    begin
        ProcesarPendientes();
    end;

    procedure ProcesarPendientes()
    var
        WS: Record CustomerWebService;
    begin
        WS.Reset();
        WS.SetRange("Cliente creado", false);

        if WS.FindSet(true) then
            repeat
                ProcesarAlta(WS);
            until WS.Next() = 0;
    end;

    procedure ProcesarAlta(var WS: Record CustomerWebService)
    var
        CustTempl: Record "Customer Templ.";
        Cust: Record Customer;
        ShipTo: Record "Ship-to Address";
        Cont: Record Contact;
        isHandled: Boolean;
        CustTemplMgt: Codeunit "Customer Templ. Mgt.";
    begin
        if WS."Cliente creado" then
            exit;

        if WS."Tipo plantilla" = '' then
            Error('Debe indicar el tipo de plantilla.');

        if not CustTempl.Get(WS."Tipo plantilla") then
            Error('No se ha encontrado la plantilla de cliente %1.', WS."Tipo plantilla");

        CustTemplMgt.CreateCustomerFromTemplate(Cust, isHandled, CustTempl.Code);

        Cust.Name := WS."Nombre fiscal";
        Cust."VAT Registration No." := WS.CIF;
        Cust.Address := WS.Direccion;
        Cust.City := WS.Poblacion;
        Cust."Post Code" := WS."Codigo postal";
        Cust.County := WS.Provincia;
        Cust."Phone No." := WS.Telefono;
        Cust."E-Mail" := WS."Email acceso";
        Cust."Mobile Phone No." := WS."Movil whatsapp";
        Cust."Name 2" := WS."Nombre comercial";
        Cust."Search Name" := WS."Nombre comercial";
        Cust."Email facturacion 1" := WS."Email facturas";
        Cust.Contact := WS."Nombre contacto";
        Cust."Salesperson Code" := WS."Cod. vendedor";
        Cust.Modify(true);

        if WS."Nombre contacto" <> '' then begin
            Cont.Init();
            Cont.Validate(Type, Cont.Type::Person);
            Cont.Name := WS."Nombre contacto";
            Cont."E-Mail" := WS."Email acceso";
            Cont."Phone No." := WS.Telefono;
            Cont."Mobile Phone No." := WS."Movil whatsapp";
            Cont.Insert(true);

            Cust."Primary Contact No." := Cont."No.";
            Cust.Modify(true);
        end;

        ShipTo.Init();
        ShipTo.Validate("Customer No.", Cust."No.");
        ShipTo.Code := '01';

        ShipTo.Name := WS."Contacto envio";
        if ShipTo.Name = '' then
            ShipTo.Name := WS."Nombre comercial";
        if ShipTo.Name = '' then
            ShipTo.Name := WS."Nombre fiscal";

        ShipTo.Address := WS."Direccion envio";
        if ShipTo.Address = '' then
            ShipTo.Address := WS.Direccion;

        ShipTo.City := WS."Poblacion envio";
        if ShipTo.City = '' then
            ShipTo.City := WS.Poblacion;

        ShipTo."Post Code" := WS."Codigo postal envio";
        if ShipTo."Post Code" = '' then
            ShipTo."Post Code" := WS."Codigo postal";

        ShipTo.County := WS."Provincia envio";
        if ShipTo.County = '' then
            ShipTo.County := WS.Provincia;

        ShipTo."Country/Region Code" := Cust."Country/Region Code";

        ShipTo."Phone No." := WS."Telefono envio";
        if ShipTo."Phone No." = '' then
            ShipTo."Phone No." := WS.Telefono;

        ShipTo."E-Mail" := WS."Email envio";
        if ShipTo."E-Mail" = '' then
            ShipTo."E-Mail" := WS."Email facturas";

        ShipTo.Insert(true);

        Cust."Ship-to Code" := ShipTo.Code;
        Cust.Modify(true);

        WS."Cliente creado" := true;
        WS.Modify(true);
    end;
}
