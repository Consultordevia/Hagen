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

        if WS.FindSet() then
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
        Banco: Record "Customer Bank Account";
        RecLink: Record "Record Link";
        RecLinkMgt: Codeunit "Record Link Management";
        NotaTxt: Text;
        DocAttach: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        InStr: InStream;
        OutStr: OutStream;
        FileName: Text;
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
        //Cust.Contact := WS."Nombre contacto";
        Cust."Salesperson Code" := WS."Cod. vendedor";

        if WS."Forma pago" = WS."Forma pago"::"1" then begin
            Cust."Payment Method Code" := 'P.ANTICIPA';
        end else if WS."Forma pago" = WS."Forma pago"::"2" then begin
            Cust."Payment Method Code" := 'GIRO';
            if WS.IBAN <> '' then begin
                Banco.Init();
                Banco.Validate("Customer No.", Cust."No.");
                Banco.Code := '01';
                Banco.IBAN := WS.IBAN;
                Banco.Insert();

                Cust."Preferred Bank Account Code" := Banco.Code;
            end;
        end;
        Cust.Modify();

        if WS."Nombre contacto" <> '' then begin
            Cont.Init();
            Cont.Validate(Type, Cont.Type::Person);
            Cont.Name := WS."Nombre contacto";
            Cont."E-Mail" := WS."Email acceso";
            Cont."Phone No." := WS.Telefono;
            Cont."Mobile Phone No." := WS."Movil whatsapp";
            Cont.Insert();

            Cust."Primary Contact No." := Cont."No.";
            Cust.Modify();
            NotaTxt := StrSubstNo('IBAN: %1', WS.IBAN);

            RecLink.Init();
            RecLink."Record ID" := Cust.RecordId;
            RecLink.Company := CompanyName;
            RecLink.Type := RecLink.Type::Note;
            RecLink.Created := CurrentDateTime;
            RecLink."User ID" := UserId();
            RecLink.Description := 'IBAN';

            RecLink.Insert();
            RecLinkMgt.WriteNote(RecLink, NotaTxt);
            RecLink.Modify();
        end;


        ShipTo.Init();
        ShipTo.Validate("Customer No.", Cust."No.");
        ShipTo.Code := '01';

        ShipTo.Name := WS."Nombre comercial";
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

        if WS."Direccion habitual" then
            ShipTo."Direccion habitual" := true;

        if WS."Email notificacion envio" <> '' then begin
            // ShipTo.Contact := WS."Email notificacion envio";
            ShipTo.Contact := WS."Contacto envio";
            Cust."Email Notificacion Envio EM" := WS."Email notificacion envio";
        end;

        ShipTo.Insert();

        Cust."Ship-to Code" := ShipTo.Code;
        Cust.Modify();


        WS.CalcFields(Fichero);
        WS.Fichero.CreateInStream(InStr);

        if InStr.Length > 0 then begin
            FileName := WS."Nombre fichero";
            if FileName = '' then
                FileName := 'Adjunto.pdf';

            TempBlob.CreateOutStream(OutStr);
            CopyStream(OutStr, InStr);

            RecRef.GetTable(Cust);
            DocAttach.SaveAttachment(RecRef, FileName, TempBlob);
        end;


        WS."Cliente creado" := true;
        WS.Modify();
    end;
}
