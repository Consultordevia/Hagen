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

        // Cust.Name := WS."Nombre fiscal";
        // Cust."VAT Registration No." := WS.CIF;
        // Cust.Address := WS.Direccion;
        // Cust.City := WS.Poblacion;
        // Cust."Post Code" := WS."Codigo postal";
        // Cust.County := WS.Provincia;
        // Cust."Phone No." := WS.Telefono;
        // Cust."E-Mail" := WS."Email acceso";
        // Cust."Mobile Phone No." := WS."Movil whatsapp";
        // Cust."Name 2" := WS."Nombre comercial";
        // Cust."Search Name" := WS."Nombre comercial";
        // Cust."Email facturacion 1" := WS."Email facturas";
        Cust.Name := CopyStr(WS."Nombre fiscal", 1, MaxStrLen(Cust.Name));                           // Text[100]
        Cust."VAT Registration No." := CopyStr(WS.CIF, 1, MaxStrLen(Cust."VAT Registration No."));   // Text[20]
        Cust.Address := CopyStr(WS.Direccion, 1, MaxStrLen(Cust.Address));                           // Text[100]
        Cust.City := CopyStr(WS.Poblacion, 1, MaxStrLen(Cust.City));                                 // Text[30]
        Cust."Post Code" := CopyStr(WS."Codigo postal", 1, MaxStrLen(Cust."Post Code"));             // Code[20]
        Cust.County := CopyStr(WS.Provincia, 1, MaxStrLen(Cust.County));                             // Text[30]
        Cust."Phone No." := CopyStr(WS.Telefono, 1, MaxStrLen(Cust."Phone No."));                    // Text[30]
        Cust."E-Mail" := CopyStr(WS."Email acceso", 1, MaxStrLen(Cust."E-Mail"));                    // Text[80]
        Cust."Mobile Phone No." := CopyStr(WS."Movil whatsapp", 1, MaxStrLen(Cust."Mobile Phone No.")); // Text[30]
        Cust."Name 2" := CopyStr(WS."Nombre comercial", 1, MaxStrLen(Cust."Name 2"));                // Text[50]
        Cust."Search Name" := CopyStr(WS."Nombre comercial", 1, MaxStrLen(Cust."Search Name"));      // Code[100]
        Cust."Email facturacion 1" := CopyStr(WS."Email facturas", 1, MaxStrLen(Cust."Email facturacion 1")); // Text[60]
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

        ShipTo.Init();
        ShipTo.Validate("Customer No.", Cust."No.");
        ShipTo.Code := '01';

        ShipTo.Name := CopyStr(WS."Nombre comercial", 1, MaxStrLen(ShipTo.Name));
        if ShipTo.Name = '' then
            ShipTo.Name := CopyStr(WS."Nombre comercial", 1, MaxStrLen(ShipTo.Name));
        if ShipTo.Name = '' then
            ShipTo.Name := CopyStr(WS."Nombre fiscal", 1, MaxStrLen(ShipTo.Name));

        // ShipTo.Address := WS."Direccion envio";
        ShipTo.Address := CopyStr(WS."Direccion envio", 1, MaxStrLen(ShipTo.Address));
        if ShipTo.Address = '' then
            // ShipTo.Address := WS.Direccion;
            ShipTo.Address := CopyStr(WS.Direccion, 1, MaxStrLen(ShipTo.Address));

        // ShipTo.City := WS."Poblacion envio";
        ShipTo.City := CopyStr(WS."Poblacion envio", 1, MaxStrLen(ShipTo.City));
        if ShipTo.City = '' then
            ShipTo.City := CopyStr(WS."Poblacion", 1, MaxStrLen(ShipTo.City));
        // ShipTo.City := WS.Poblacion;

        // ShipTo."Post Code" := WS."Codigo postal envio";
        ShipTo."Post Code" := CopyStr(WS."Codigo postal envio", 1, MaxStrLen(ShipTo."Post Code"));
        if ShipTo."Post Code" = '' then
            ShipTo."Post Code" := CopyStr(WS."Codigo postal", 1, MaxStrLen(ShipTo."Post Code"));
        // ShipTo."Post Code" := WS."Codigo postal";

        // ShipTo.County := WS."Provincia envio";
        ShipTo.County := CopyStr(WS."Provincia envio", 1, MaxStrLen(ShipTo.County));
        if ShipTo.County = '' then
            ShipTo.County := CopyStr(WS."Provincia", 1, MaxStrLen(ShipTo.County));
        // ShipTo.County := WS.Provincia;

        // ShipTo."Country/Region Code" := Cust."Country/Region Code";
        ShipTo."Country/Region Code" := CopyStr(Cust."Country/Region Code", 1, MaxStrLen(ShipTo."Country/Region Code"));

        // ShipTo."Phone No." := WS."Telefono envio";
        ShipTo."Phone No." := CopyStr(WS."Telefono envio", 1, MaxStrLen(ShipTo."Phone No."));
        if ShipTo."Phone No." = '' then
            ShipTo."Phone No." := CopyStr(WS.Telefono, 1, MaxStrLen(ShipTo."Phone No."));
        // ShipTo."Phone No." := WS.Telefono;

        // ShipTo."E-Mail" := WS."Email envio";
        ShipTo."E-Mail" := CopyStr(WS."Email envio", 1, MaxStrLen(ShipTo."E-Mail"));
        if ShipTo."E-Mail" = '' then
            ShipTo."E-Mail" := CopyStr(WS."Email facturas", 1, MaxStrLen(ShipTo."E-Mail"));
        // ShipTo."E-Mail" := WS."Email facturas";

        if WS."Direccion habitual" then
            ShipTo."Direccion habitual" := true;

        if WS."Email notificacion envio" <> '' then begin
            // ShipTo.Contact := WS."Email notificacion envio";
            // ShipTo.Contact := WS."Contacto envio";
            ShipTo.Contact := CopyStr(WS."Contacto envio", 1, MaxStrLen(ShipTo.Contact));
            Cust."Email Notificacion Envio EM" := CopyStr(WS."Email notificacion envio", 1, MaxStrLen(Cust."Email Notificacion Envio EM"));
            // Cust."Email Notificacion Envio EM" := WS."Email notificacion envio";
        end;

        ShipTo.Insert();

        // Cust."Ship-to Code" := ShipTo.Code;
        Cust."Ship-to Code" := CopyStr(ShipTo.Code, 1, MaxStrLen(Cust."Ship-to Code"));
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
