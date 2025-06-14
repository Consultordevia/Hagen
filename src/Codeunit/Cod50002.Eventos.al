codeunit 50002 Eventos
{
    Permissions = tabledata "Sales Invoice Header" = rmid, tabledata "G/L Entry" = RMID;


    [EventSubscriber(ObjectType::Table, 18, 'OnAfterOnInsert', '', true, true)]
    local procedure OnAfterOnInsert(var Customer: Record Customer; xCustomer: Record Customer)
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
        RMSetup: Record "Marketing Setup";
        UpdateContFromCust: Codeunit "CustCont-Update";
    begin

        EnvioFicheros.ALTACLIENTES(Customer);

        //Commit;
        if Customer.ContactoAInsertar <> '' then begin
            Customer.Contact := Customer.ContactoAInsertar;
            if RMSetup.Get() then
                if RMSetup."Bus. Rel. Code for Customers" <> '' then
                    if (xCustomer.Contact = '') and (xCustomer."Primary Contact No." = '') and (Customer.Contact <> '') then begin
                        //Modify();
                        OnModify(Customer);
                        UpdateContFromCust.InsertNewContactPerson(Customer, false);
                        //Customer.Modify();
                    end
        end;


    end;

    [EventSubscriber(ObjectType::Table, 18, OnAfterModifyEvent, '', true, true)]
    local procedure OnAfterModifyEvent(RunTrigger: Boolean; var Rec: Record Customer);
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
        RecUS: Record "User Setup";
    begin
        RecUS.get(UserId);
        IF RecUS."Editar tabla Clientes/Comercia" = FALSE THEN begin
            Error('No tiene permiso para modificar clientes.');
        end;

        ///EnvioFicheros.MODIFCLIENTES(Rec);

    end;

    [EventSubscriber(ObjectType::Table, 23, 'OnAfterOnInsert', '', true, true)]
    local procedure OnAfterOnInsertV(var Vendor: Record Vendor)
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin
        EnvioFicheros.ALTAPROVEE(Vendor);
    end;

    [EventSubscriber(ObjectType::Table, 23, OnAfterModifyEvent, '', true, true)]
    local procedure OnAfterModifyEventV(RunTrigger: Boolean; var Rec: Record Vendor);
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin
        /////-EnvioFicheros.MODIFPROVEE(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnBeforeOnInsert', '', true, true)]
    local procedure OnAfterOnInsertProd(var Item: Record Item)
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin
        Item."Fecha modif" := CreateDatetime(Today, Time);
        //EnvioFicheros.ALTAPROD(item);
        item.FechaHoraModificacionWeb := CurrentDateTime;

    end;

    [EventSubscriber(ObjectType::Table, 27, OnBeforeModifyEvent, '', true, true)]
    local procedure OnAfterModifyEventProd(RunTrigger: Boolean; var Rec: Record Item; var xRec: Record Item);
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
        recA: Record item;
    begin
        if RunTrigger then begin
            Rec."Fecha modif" := CreateDatetime(Today, Time);
            if GuiAllowed then begin
                if CopyStr(COMPANYNAME, 1, 4) = 'ROLF' then begin
                    RecA.Reset;
                    RecA.ChangeCompany('HAGEN CANARIAS S.C.');
                    if RecA.Get(Rec."No.") then begin
                        RecA := Rec;
                        RecA."VAT Prod. Posting Group" := Rec."IVA IGIC";
                        RecA.Modify(false);
                    end;
                    if not RecA.Get(Rec."No.") then begin
                        RecA := Rec;
                        RecA."VAT Prod. Posting Group" := Rec."IVA IGIC";
                        RecA.Insert(false);
                    end;
                end;
            end;
        end;
        if rec."Fecha en picking" <> xRec."Fecha en picking" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Fecha disponible Web" <> xrec."Fecha disponible Web" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Producto web" <> xrec."Producto web" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Estado WEB Inactivo" <> xrec."Estado WEB Inactivo" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Umbral stock" <> xrec."Umbral stock" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Unit Price" <> xrec."Unit Price" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        //if rec."PVP-Web" <> xrec. then
        //rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.CodVariante1 <> xrec.CodVariante1 then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Dato Variante1" <> xrec."Dato Variante1" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.CodVariante2 <> xrec.CodVariante2 then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Dato Variante2" <> xrec."Dato Variante2" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.Level1 <> xrec.Level1 then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.Level2 <> xrec.Level2 then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.Level3 <> xrec.Level3 then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.Etiquetas1 <> xrec.Etiquetas1 then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.Etiquetas2 <> xrec.Etiquetas2 then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.Etiquetas3 <> xrec.Etiquetas3 then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.Etiquetas4 <> xrec.Etiquetas4 then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.Etiquetas5 <> xrec.Etiquetas5 then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.Etiquetas6 <> xrec.Etiquetas6 then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.Gama <> xrec.Gama then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Stock para Catit" <> xrec."Stock para Catit" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;

        /////        EnvioFicheros.MODIFPROD(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", OnBeforeInsertEvent, '', false, false)]
    local procedure OnBeforeInsertEventItemLedgerEntry(var Rec: Record "Item Ledger Entry")
    var
        Item: Record Item;
    begin
        if (rec."Location Code" <> 'SILLA') AND (REC."Location Code" <> 'TENERIFE') THEN
            EXIT;
        if item.get(rec."Item No.") then begin
            item.FechaHoraModificacionWeb := CurrentDateTime;
            item.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Price", 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyEventSalesPrice(var Rec: Record "Sales Price"; var xRec: Record "Sales Price")
    var
        Item: Record Item;
    begin
        if rec."Sales Code" = '2022-2' then begin
            if rec."Precio recomendado" <> xRec."Precio recomendado" then
                if item.get(rec."Item No.") then begin
                    item.FechaHoraModificacionWeb := CurrentDateTime;
                    item.Modify();
                end;
        end;
        if rec."Sales Code" <> xrec."Sales Code" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;

        if rec."Unit of Measure Code" <> xrec."Unit of Measure Code" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Minimum Quantity" <> xrec."Minimum Quantity" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Unit Price" <> xrec."Unit Price" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.INCREMENTO <> xrec.INCREMENTO then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Starting Date" <> xrec."Starting Date" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Ending Date" <> xrec."Ending Date" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnBeforeModifyEvent, '', false, false)]
    local procedure OnBeforeModifyEventSalesLine(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    var
        Item: Record Item;
    begin
        if rec."Document Type" <> rec."Document Type"::Order then
            exit;
        if rec.Type <> rec.Type::Item then
            exit;
        if Rec."Outstanding Quantity" <> xrec."Outstanding Quantity" then begin
            if item.get(rec."No.") then begin
                item.FechaHoraModificacionWeb := CurrentDateTime;
                item.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeInsert', '', false, false)]
    local procedure OnBeforeInsertCustomer(var Customer: Record Customer)
    begin
        Customer.FechaHoraModificacionWeb := CurrentDateTime;
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, OnBeforeModifyEvent, '', false, false)]
    local procedure OnBeforeModifyEventCustomer(var Rec: Record Customer; var xRec: Record Customer)
    begin
        /*if rec."Payment Terms Code" <> xrec."Payment Terms Code" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Payment Method Code" <> xrec."Payment Method Code" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Salesperson Code" <> xrec."Salesperson Code" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.Address <> xrec.Address then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.County <> xrec.County then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.City <> xrec.City then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Usuario Web" <> xrec."Usuario Web" then*/
        rec.FechaHoraModificacionWeb := CurrentDateTime;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Ship-to Address", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertEventShiptoAddress(var Rec: Record "Ship-to Address")
    begin
        rec.FechaHoraModificacionWeb := CurrentDateTime;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Customer Templ. Mgt.", 'OnCreateTemplateFromCustomerOnAfterInsertTemplateFromCustomer', '', false, false)]
    local procedure OnCreateTemplateFromCustomerOnAfterInsertTemplateFromCustomer(Customer: Record Customer; var CustomerTempl: Record "Customer Templ.")
    begin
        if (CustomerTempl."Country/Region Code" <> '') and (Customer."Country/Region Code" = '') then begin
            Customer."Country/Region Code" := CustomerTempl."Country/Region Code";
            Customer.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::Customer, 'OnAfterValidatePostCode', '', false, false)]
    local procedure OnAfterValidatePostCodeCustomer(var Customer: Record Customer; xCustomer: Record Customer)
    begin
        if (xCustomer."Country/Region Code" <> '') and (Customer."Country/Region Code" = '') then
            Customer."Country/Region Code" := xCustomer."Country/Region Code";
    end;


    [EventSubscriber(ObjectType::Table, Database::"Ship-to Address", 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyEventShiptoAddress(var Rec: Record "Ship-to Address"; var xRec: Record "Ship-to Address")
    begin
        if rec.Code <> xrec.Code then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.Address <> xrec.Address then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Address 2" <> xrec."Address 2" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.City <> xrec.City then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Country/Region Code" <> xrec."Country/Region Code" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.County <> xrec.County then
            rec.FechaHoraModificacionWeb := CurrentDateTime;

        if rec."E-Mail" <> xrec."E-Mail" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;

        if rec."Phone No." <> xrec."Phone No." then
            rec.FechaHoraModificacionWeb := CurrentDateTime;

        if rec.Name <> xrec.Name then
            rec.FechaHoraModificacionWeb := CurrentDateTime;

        if rec.Dir_Shopyfi <> xrec.Dir_Shopyfi then
            rec.FechaHoraModificacionWeb := CurrentDateTime;

        if rec."Enviar a Web Distribuidor" <> xrec."Enviar a Web Distribuidor" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;

    end;

    [EventSubscriber(ObjectType::Table, Database::TablaCajas, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertEventTablaCajas(var Rec: Record TablaCajas)
    begin
        rec.FechaHoraModificacionWeb := CurrentDateTime;
    end;

    [EventSubscriber(ObjectType::Table, Database::TablaCajas, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyEventTablaCajas(var Rec: Record TablaCajas; var xRec: Record TablaCajas)
    begin
        if rec."Atributo Variante1" <> xrec."Atributo Variante1" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Atributo Variante2" <> xrec."Atributo Variante2" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Cantidad x caja" <> xrec."Cantidad x caja" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec."Precio unitario" <> xrec."Precio unitario" then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
        if rec.Stock <> xrec.Stock then
            rec.FechaHoraModificacionWeb := CurrentDateTime;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Customer Discount Group", 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyEventCustomerDiscountGroup(var Rec: Record "Customer Discount Group"; var xRec: Record "Customer Discount Group")
    var
        customer: record Customer;
    begin
        if rec."Catalogo Shopify" = xrec."Catalogo Shopify" then
            exit;

        customer.reset;
        customer.SetRange("Customer Disc. Group", rec.Code);
        customer.ModifyAll(FechaHoraModificacionWeb, CurrentDateTime);
    end;


    [EventSubscriber(ObjectType::Table, 27, 'OnAfterValidateEvent', 'Item Category Code', false, false)]

    procedure OnAfterValidateEventItemCategoryCode(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    var
        ItemCategory: Record "Item Category";
        ItemCategory1: Record "Item Category";
        ItemCategory2: Record "Item Category";
        ItemCategory3: Record "Item Category";
        ItemCategory4: Record "Item Category";
        ItemCategory5: Record "Item Category";
        ItemCategory6: Record "Item Category";
        ItemCategory7: Record "Item Category";
        ItemCategory8: Record "Item Category";
        ItemCategory9: Record "Item Category";
        ItemCategory10: Record "Item Category";
        Recitem: Record item;
        RecPMTemp: Record "Payment Method" temporary;
        conta: integer;
        v: Dialog;

    begin

        /*
                commit;
                RecItem.Reset();
                Recitem.SetRange("No.", Rec."No.");
                if RecItem.FindSet() then begin
                    ///Message('%1 %2', Rec."No.", Rec."Item Category Code");
                    ///     v.Update(1, RecItem."No.");
                    RecPMTemp.Reset();
                    if RecPMTemp.FindFirst() then
                        repeat
                            RecPMTemp.Delete;
                        until RecPMTemp.next = 0;
                    ///Message('item categori %1', Recitem."Item Category Code");
                    if Recitem."Item Category Code" <> '' then begin
                        IF ItemCategory.get(Recitem."Item Category Code") THEN begin
                            ///Recitem.Level1 := ItemCategory.Description;
                            RecPMTemp.Code := '10';
                            RecPMTemp.Description := ItemCategory.Description;
                            RecPMTemp.Insert;
                            IF ItemCategory1.get(ItemCategory."Parent Category") THEN begin
                                ///Recitem.Level2 := ItemCategory1.Description;
                                RecPMTemp.Code := '09';
                                RecPMTemp.Description := ItemCategory1.Description;
                                RecPMTemp.Insert;
                                IF ItemCategory2.get(ItemCategory1."Parent Category") THEN begin
                                    ///Recitem.Level3 := ItemCategory2.Description;
                                    RecPMTemp.Code := '08';
                                    RecPMTemp.Description := ItemCategory2.Description;
                                    RecPMTemp.Insert;
                                    IF ItemCategory3.get(ItemCategory2."Parent Category") THEN begin
                                        ///Recitem.Level4 := ItemCategory3.Description;
                                        RecPMTemp.Code := '07';
                                        RecPMTemp.Description := ItemCategory3.Description;
                                        RecPMTemp.Insert;
                                        IF ItemCategory4.get(ItemCategory3."Parent Category") THEN begin
                                            ///Recitem.Level5 := ItemCategory4.Description;
                                            RecPMTemp.Code := '06';
                                            RecPMTemp.Description := ItemCategory4.Description;
                                            RecPMTemp.Insert;
                                            IF ItemCategory5.get(ItemCategory4."Parent Category") THEN begin
                                                ///Recitem.Level6 := ItemCategory5.Description;
                                                RecPMTemp.Code := '05';
                                                RecPMTemp.Description := ItemCategory5.Description;
                                                RecPMTemp.Insert;
                                                IF ItemCategory6.get(ItemCategory5."Parent Category") THEN begin
                                                    ///Recitem.Level7 := ItemCategory6.Description;
                                                    RecPMTemp.Code := '04';
                                                    RecPMTemp.Description := ItemCategory7.Description;
                                                    RecPMTemp.Insert;
                                                    IF ItemCategory7.get(ItemCategory6."Parent Category") THEN begin
                                                        ///Recitem.Level8 := ItemCategory7.Description;
                                                        RecPMTemp.Code := '03';
                                                        RecPMTemp.Description := ItemCategory7.Description;
                                                        RecPMTemp.Insert;
                                                        IF ItemCategory8.get(ItemCategory7."Parent Category") THEN begin
                                                            ///Recitem.Level9 := ItemCategory8.Description;
                                                            RecPMTemp.Code := '02';
                                                            RecPMTemp.Description := ItemCategory8.Description;
                                                            RecPMTemp.Insert;
                                                            IF ItemCategory9.get(ItemCategory8."Parent Category") THEN begin
                                                                ///Recitem.Level10 := ItemCategory9.Description;
                                                                RecPMTemp.Code := '01';
                                                                RecPMTemp.Description := ItemCategory9.Description;
                                                                RecPMTemp.Insert;

                                                            end;
                                                        end;

                                                    end;

                                                end;

                                            end;

                                        end;

                                    end;

                                end;

                            end;
                        end;
                    end;
                    RecItem.Level1 := '';
                    RecItem.Level2 := '';
                    RecItem.Level3 := '';
                    RecItem.Modify;
                    conta := 0;
                    RecPMTemp.Reset();
                    if RecPMTemp.FindFirst() then
                        repeat
                            conta := conta + 1;
                            if conta = 1 then begin RecItem.Level1 := RecPMTemp.Description; RecItem.Modify; end;
                            if conta = 2 then begin RecItem.Level2 := RecPMTemp.Description; RecItem.Modify; end;
                            if conta = 3 then begin RecItem.Level3 := RecPMTemp.Description; RecItem.Modify; end;
                        until RecPMTemp.next = 0;
                end;
                Commit();
                */
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterSetFieldsBilltoCustomer', '', false, false)]
    local procedure OnAfterSetFieldsBilltoCustomer(var SalesHeader: Record "Sales Header"; Customer: Record Customer; xSalesHeader: Record "Sales Header"; SkipBillToContact: Boolean; CUrrentFieldNo: Integer)
    var
        Customer2: Record Customer;
    begin
        Customer2.get(SalesHeader."Sell-to Customer No.");

        ///// customer
        SalesHeader."Observación para transporte" := Customer2."Observación para transporte";
        SalesHeader."No agrupar en ADAIA" := Customer2."No agrupar en ADAIA";

        SalesHeader."Shipment Method Code" := Customer2."Shipment Method Code";
        SalesHeader."Transaction Type" := Customer2."Transaction Type";
        SalesHeader."Transport Method" := Customer2."Transport Method";
        SalesHeader."Exit Point" := Customer2."Exit Point";
        SalesHeader.Area := Customer2.Area;
        SalesHeader."Transaction Specification" := Customer2."Transaction Specification";

        SalesHeader."Tipo facturación" := Customer2."Tipo facturación";
        SalesHeader."No Enviar factura en exp." := Customer2."No Enviar factura en exp.";
        SalesHeader."No Enviar albaran en exp." := Customer2."No Enviar albaran en exp.";
        SalesHeader."No imprimir albaran valorado" := Customer2."No imprimir albaran valorado";
        SalesHeader."Albaran sin detalle" := Customer2."Albaran sin detalle";
        SalesHeader."No incluir portes" := Customer2."No incluir portes";
        SalesHeader."Respeta Tipo facturacion" := Customer2."Respeta Tipo facturacion";
        SalesHeader."No imprimir facturas" := Customer2."No imprimir facturas";
        SalesHeader."Respeta agencia transporte" := Customer2."Respeta agencia transporte";
        SalesHeader."Tipo de documento EDICOM" := Customer2."Tipo de documento EDICOM";
        SalesHeader."Funcion del mensaje EDICOM" := Customer2."Funcion del mensaje EDICOM";
        SalesHeader."Tipo transporte EDICOM" := Customer2."Tipo transporte EDICOM";
        SalesHeader."IDENTIF EDICOM" := Customer2."IDENTIF EDICOM";


        SalesHeader."Observación para ALMACEN" := Customer2."Observación para ALMACEN";
        SalesHeader."Observación PDA" := Customer2."Observación PDA";

        SalesHeader."Customer Disc. Group" := Customer2."Customer Disc. Group";



        if (SalesHeader."Document Type" = 1) then begin
            SalesHeader.ChequeoFechaVtos;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeUpdateShipToCodeFromCust', '', false, false)]
    local procedure OnBeforeUpdateShipToCodeFromCust(var SalesHeader: Record "Sales Header"; var Customer: Record Customer; var IsHandled: Boolean)
    var
        RecEAD: record "Ship-to Address";
    //RecDP: Record "Customer Pmt. Address";
    begin
        RecEAD.Reset;
        RecEAD.SetRange(RecEAD."Customer No.", SalesHeader."Sell-to Customer No.");
        RecEAD.SetRange(RecEAD."Direccion habitual", true);
        if RecEAD.FindFirst then begin
            SalesHeader."Ship-to Code" := RecEAD.Code;
            SalesHeader.Validate(SalesHeader."Ship-to Code");
            IsHandled := true;
        end;

        if SalesHeader."Bill-to Customer No." <> '6445' then begin

        end;



        if SalesHeader."Bill-to Customer No." = '6445' then begin
            SalesHeader."Shipping No. Series" := 'V-ALB-CANA';
            //SalesHeader."Pay-at Code" := '';
            //IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnValidateSellToCustomerNoOnBeforeRecallModifyAddressNotification', '', false, false)]
    local procedure OnValidateSellToCustomerNoOnBeforeRecallModifyAddressNotification(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    var
        RecMulti: Record Multitabla;
        Cust: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        Cust.get(SalesHeader."Sell-to Customer No.");
        if RecMulti.Get(5, Cust."Grupo clientes") then begin
            if RecMulti."Factura EDI" then begin
                SalesHeader."EDI factueas enviar" := true;
                SalesHeader."Factura EDI" := RecMulti."Factura EDI";
                SalesHeader."Albarán EDI" := RecMulti."Albarán EDI";
            end;
        end;

        SalesSetup.Get;
        if COMPANYNAME = 'HAGEN CANARIAS S.C.' then begin
            SalesHeader."Posting No. Series" := SalesSetup."Posted Invoice Nos.";
        end;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnSetShipToCustomerAddressFieldsFromShipToAddrOnBeforeValidateShippingAgentFields', '', false, false)]
    local procedure OnSetShipToCustomerAddressFieldsFromShipToAddrOnBeforeValidateShippingAgentFields(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; ShipToAddr: Record "Ship-to Address"; var IsHandled: Boolean)
    begin
        SalesHeader."Filtro ECI" := ShipToAddr."Filtro ECI";
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeMessageIfSalesLinesExist', '', false, false)]
    local procedure OnBeforeMessageIfSalesLinesExist(var SalesHeader: Record "Sales Header"; ChangedFieldCaption: Text; var IsHandled: Boolean)
    begin
        if SalesHeader.FIELDCAPTION("Customer Disc. Group") = ChangedFieldCaption then begin
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnCopyFromItemOnAfterCheck', '', false, false)]
    local procedure OnCopyFromItemOnAfterCheck(var SalesLine: Record "Sales Line"; Item: Record Item)
    var
        CestaCompra: Record "Cesta compra";
        UserSetup: Record "User Setup";
    begin
        SalesLine."Producto Padre" := Item."Producto PADRE";
        SalesLine."Exit Point" := Item."Exit Point";
        if (SalesLine."Document Type" = 1) or (SalesLine."Document Type" = 0) then begin
            if not Cestacompra.Get(0, SalesLine."Sell-to Customer No.", SalesLine."No.") then begin
                Cestacompra.Código := SalesLine."Sell-to Customer No.";
                Cestacompra.Tipo := 0;
                Cestacompra.Referencia := SalesLine."No.";
                Cestacompra.Insert(true);
            end;
        end;


        if SalesLine."Document Type" = SalesLine."document type"::Order then begin
            if Item."Prohibido Amazon" then begin
                SalesLine.CalcFields("Grupo clientes");
                if SalesLine."Grupo clientes" = 'G10' then begin
                    Error('Este producto no se permite la venta de este producto para este grupo.');
                end;
            end;
            if Item."No permite pedido" then begin
                if UserSetup.get(UserId) then begin
                    if UserSetup."No Permite NO PERMITE PEDIDO" = true then begin
                        ERROR('Este producto no se permite en pedido.');
                    end;
                end;
            end;

        end;
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnUpdateUnitPriceByFieldOnBeforeValidateUnitPrice', '', false, false)]
    local procedure OnUpdateUnitPriceByFieldOnBeforeValidateUnitPrice(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CalledByFieldNo: Integer; CurrFieldNo: Integer; var Handled: Boolean)
    var
        SalesLineDiscount2: Record "Sales Line Discount";
        SalesLineDiscount: Record "Sales Line Discount";
        SalesHeader: Record "Sales Header";
        SalesLine3: Record "Sales Line";
    begin
        SalesLine.CalcFields("Cantidad padre");
        if SalesLine.IsTemporary then
            exit;

        if not SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then
            exit;


        SalesLineDiscount2.Reset;
        SalesLineDiscount2.SetRange(Code, SalesLine."No.");
        SalesLineDiscount2.SetRange(SalesLineDiscount2."Sales Code", SalesLine."Sell-to Customer No.");
        SalesLineDiscount2.SetRange(SalesLineDiscount2."Sales Type", SalesLineDiscount2."sales type"::Customer);
        if not SalesLineDiscount2.FindFirst then begin
            SalesLineDiscount.Reset;
            SalesLineDiscount.SetRange(Code, SalesLine."Producto Padre");
            SalesLineDiscount.SetRange("Sales Code", SalesLine."Customer Disc. Group");
            SalesLineDiscount.SetFilter("Ending Date", '%1|>=%2', 0D, SalesHeader."Order Date");
            SalesLineDiscount.SetRange("Starting Date", 0D, SalesHeader."Order Date");
            if SalesLineDiscount.FindFirst then
                repeat
                    if (SalesLine."Cantidad padre" + SalesLine.Quantity - xSalesLine.Quantity) >= SalesLineDiscount."Minimum Quantity" then begin
                        SalesLine.Validate("Line Discount %", SalesLineDiscount."Line Discount %");
                        SalesLine.Validate("Allow Invoice Disc.", false);
                        SalesLine3.Reset;
                        SalesLine3.SetRange("Document Type", SalesLine."Document Type");
                        SalesLine3.SetRange("Document No.", SalesLine."Document No.");
                        SalesLine3.SetRange("Producto Padre", SalesLine."Producto Padre");
                        if SalesLine3.FindFirst then
                            repeat
                                if SalesLine3."Line No." <> SalesLine."Line No." then begin
                                    if SalesLine3."Producto asociado" = 0 then begin
                                        SalesLine3.Validate("Line Discount %", SalesLineDiscount."Line Discount %");
                                        SalesLine3.Validate(SalesLine3."Allow Invoice Disc.", false);
                                        SalesLine3."Descuento sin vendedor" := 0;
                                        SalesLine3."Importe sin dto vendedor" := 0;
                                        SalesLine3."% Dto. vendedor" := 0;
                                        SalesLine3.Modify;
                                    end;
                                end;
                            until SalesLine3.Next = 0;
                    end;
                until SalesLineDiscount.Next = 0;
        end;

    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnUpdateUnitPriceOnBeforeFindPrice', '', false, false)]
    local procedure OnUpdateUnitPriceOnBeforeFindPrice(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; CalledByFieldNo: Integer; CallingFieldNo: Integer; var IsHandled: Boolean; xSalesLine: Record "Sales Line")
    begin
        if xSalesLine.Quantity <> SalesLine.Quantity then begin
            SalesLine.Validate("Line Discount %", 0);
        end;
    end;

    [EventSubscriber(ObjectType::table, 38, 'OnAfterCheckBuyFromVendor', '', false, false)]
    local procedure OnAfterCheckBuyFromVendor(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor)
    begin
        PurchaseHeader."No cuenta gasto" := Vendor."Cuenta de gasto";
        PurchaseHeader."Shipment Method Code" := Vendor."Shipment Method Code";
        PurchaseHeader."Transaction Type" := Vendor."Transaction Type";
        PurchaseHeader."Transport Method" := Vendor."Transport Method";
        ///// "Exit Point":=PurchSetup."Exit Point";
        PurchaseHeader.Area := Vendor.Area;
        PurchaseHeader."Transaction Specification" := Vendor."Transaction Specification";
    end;

    [EventSubscriber(ObjectType::Table, 91, 'OnBeforeEnsureUniqueSalesPersonPurchCode', '', false, false)]
    local procedure OnBeforeEnsureUniqueSalesPersonPurchCode(var UserSetup: Record "User Setup"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, 111, 'OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine', '', false, false)]
    local procedure OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine(var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line"; var NextLineNo: Integer; var Handled: Boolean; TempSalesLine: Record "Sales Line" temporary; SalesInvHeader: Record "Sales Header")
    var
        nexpe: code[20];
        SalesShptHeader: Record "Sales Shipment Header";
        SalesLine2: Record "Sales Line";
    begin
        if nexpe = '' then begin
            if SalesLine."Nº expedición" <> '' then begin
                nexpe := SalesLine."Nº expedición";
            end;
        end;



        if SalesLine."Shipment No." <> SalesShptLine."Document No." then begin
            NextLineNo := NextLineNo + 10000;
            SalesShptHeader.Get(SalesShptLine."Document No.");
            SalesInvHeader."Your Reference" := SalesShptHeader."Your Reference";
            if SalesShptHeader."Nº expedición" <> '' then begin
                SalesInvHeader."Nº expedición" := SalesShptHeader."Nº expedición";
            end;
            SalesInvHeader.Modify;
            SalesLine2.Init;
            SalesLine2."Line No." := NextLineNo;
            SalesLine2."Document Type" := TempSalesLine."Document Type";
            SalesLine2."Document No." := TempSalesLine."Document No.";
            SalesLine2.Description := 'de fecha:' + Format(SalesShptHeader."Posting Date") + '  Nº expedición:' + SalesShptHeader."Nº expedición";
            SalesLine2."Shipment No." := SalesShptLine."Document No.";
            SalesLine2.Insert;
            if SalesShptHeader."Your Reference" <> '' then begin
                SalesLine2.Init;
                NextLineNo := NextLineNo + 10000;
                SalesLine2."Line No." := NextLineNo;
                SalesLine2."Document Type" := TempSalesLine."Document Type";
                SalesLine2."Document No." := TempSalesLine."Document No.";
                SalesLine2.Description := 'Su referencia:' + Format(SalesShptHeader."Your Reference");
                SalesLine2."Shipment No." := SalesShptLine."Document No.";
                SalesLine2.Insert;
            end;
            NextLineNo := NextLineNo + 10000;
            SalesLine2.Init;
            SalesLine2."Line No." := NextLineNo;
            SalesLine2."Document Type" := TempSalesLine."Document Type";
            SalesLine2."Document No." := TempSalesLine."Document No.";
            SalesLine2.Description := CopyStr('Envio a:' + SalesShptHeader."Ship-to Name", 1, 50);
            SalesLine2."Shipment No." := SalesShptLine."Document No.";
            SalesLine2.Insert;
            NextLineNo := NextLineNo + 10000;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 111, 'OnBeforeInsertInvLineFromShptLine', '', false, false)]
    local procedure OnBeforeInsertInvLineFromShptLine(var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line"; SalesOrderLine: Record "Sales Line"; var IsHandled: Boolean; var TransferOldExtTextLines: Codeunit "Transfer Old Ext. Text Lines")
    var
        SalesShptHeader: Record "Sales Shipment Header";
    begin
        SalesShptHeader.Get(SalesShptLine."Document No.");
        SalesLine."Nº expedición" := SalesShptHeader."Nº expedición";
    end;

    [EventSubscriber(ObjectType::Table, 112, 'OnBeforePrintRecords', '', false, false)]
    local procedure OnBeforePrintRecords(var ReportSelections: Record "Report Selections"; var SalesInvoiceHeader: Record "Sales Invoice Header"; ShowRequestPage: Boolean; var IsHandled: Boolean)
    var
        //SalesInvoiceHeader: Record "Sales Invoice Header";
        RecClie: Record Customer;
    begin
        /*RecClie.Get(SalesInvoiceHeader."Sell-to Customer No.");
        if RecClie."No Enviar factura en exp." = true then begin
            Report.Run(50907, false, false, SalesInvoiceHeader);
        end;
        if RecClie."No Enviar factura en exp." = false then begin
            Report.Run(50063, false, false, SalesInvoiceHeader);
        end;*/
    end;

    [EventSubscriber(ObjectType::Table, 5404, 'OnAfterCalcCubage', '', false, false)]
    local procedure OnAfterCalcCubage(var ItemUnitOfMeasure: Record "Item Unit of Measure")
    var
        Item: Record item;
        RecCE: Record "Inventory Setup";
    begin
        if ItemUnitOfMeasure.Code = 'UDS' then begin
            if Item.Get(ItemUnitOfMeasure."Item No.") then begin
                Item."Unit Volume" := ItemUnitOfMeasure.Cubage;
                Item.Modify;
                if Item."Voluminoso web" then begin
                    RecCE.Get;
                    ItemUnitOfMeasure."Kgs/Volumen WEB" := ItemUnitOfMeasure.Cubage * RecCE."Volumen WEB";
                    ItemUnitOfMeasure.Modify;
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean; var CalledBy: Integer)
    var
        sumna1: decimal;
        rec37: Record "Sales Line";
    begin
        if SalesHeader.Invoice then begin
            sumna1 := 0;
            rec37.Reset;
            rec37.SetRange(rec37."Document Type", SalesHeader."Document Type");
            rec37.SetRange(rec37."Document No.", SalesHeader."No.");
            if rec37.FindSet then
                repeat
                    sumna1 := sumna1 + rec37."Line Amount";
                until rec37.Next = 0;


            if sumna1 = 0 then begin
                SalesHeader."Posting No. Series" := 'V-FAC-DOC';
                SalesHeader.Modify;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    var
        GLEntry2: Record "G/L Entry";
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        SalesCrMemoHeader2: Record "Sales Cr.Memo Header";
    begin
        GLEntry2.Reset;
        GLEntry2.SetCurrentkey("Document No.");
        GLEntry2.SetRange("Document No.", SalesHeader."Last Posting No.");
        if GLEntry2.FindFirst then
            repeat
                if GLEntry2."Global Dimension 1 Code" = '' then begin
                    if SalesInvoiceHeader2.Get(SalesInvHdrNo) then begin
                        GLEntry2."Global Dimension 1 Code" := SalesInvoiceHeader2."Salesperson Code";
                        GLEntry2.Modify;
                    end;
                    if SalesCrMemoHeader2.Get(SalesCrMemoHdrNo) then begin
                        GLEntry2."Global Dimension 1 Code" := SalesCrMemoHeader2."Salesperson Code";
                        GLEntry2.Modify;
                    end;
                end;
            until GLEntry2.Next = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure OnBeforeSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; PostingSalesLine: Record "Sales Line"; SalesShipmentHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; var ReturnReceiptHeader: Record "Return Receipt Header")
    begin
        SalesLine.CalcFields(ean);
        SalesInvLine.Ean := SalesLine.ean;
        if SalesLine."ean canarias" <> '' then begin
            SalesInvLine.Ean := SalesLine."ean canarias";
        end;
        SalesInvLine."Precio base" := SalesLine."Precio base";
        SalesInvLine."Num expedicion grabado" := SalesHeader."Nº expedición";
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesShptHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesShptHeaderInsert(var SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; WhseShip: Boolean; InvtPickPutaway: Boolean)
    var
        RecClie: Record Customer;
        RecTransp: Record "Shipping Agent";
        PAGINAWEB: Text[1000];
        CODDOC: Code[20];
        RecItem: Record Item;
        //GLEntry2: Record "G/L Entry";
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        SalesCrMemoHeader2: Record "Sales Cr.Memo Header";
        nexpefinal: code[20];
    begin
        if RecClie.Get(SalesShptHeader."Sell-to Customer No.") then begin
            if ((RecClie."Tipo facturación" = 2) or (RecClie."Tipo facturación" = 1)) and
               (RecClie."Email facturacion 1" <> '') and
               (RecClie."Servicio email" = true) then begin
                SalesShptHeader."Enviar email" := true;
                SalesShptHeader."Email enviado" := false;
            end;
            if RecClie."Albaran sin detalle" = true then begin
                if (RecClie."Email albaran sin detalle 1" <> '') then begin
                    SalesShptHeader."Enviar email sin detalle" := true;
                    SalesShptHeader."Email enviado sin detalle" := false;
                end;
            end;
            SalesShptHeader."CSV Enviar" := RecClie."Albaran CSV";
        end;
        if RecTransp.Get(SalesHeader."Shipping Agent Code") then begin
            if RecTransp."Sacar etiqueta envio PEQ" then begin
                SalesShptHeader."Imprime eti. envio" := true;
            end;
            if RecTransp."Sacar etiqueta envio GRA" then begin
                SalesShptHeader."Imprime eti. envio" := true;
            end;
            nexpefinal := SalesShptHeader."Nº expedición";
            if SalesShptHeader."Nº expedición dropshp" <> '' then begin
                nexpefinal := SalesShptHeader."Nº expedición dropshp";
            end;


            if RecTransp."Link transporte" = '' then begin
                if COMPANYNAME = 'PEPE' then begin
                    if SalesShptHeader."Shipping Agent Code" = 'TIPSA' then begin
                        PAGINAWEB := 'http://www.tip-sa.com/cliente/datos.php?id=04601100112' + Format(nexpefinal) + ' - ' +
                                   Format(SalesShptHeader."Your Reference") + ' - ' +
                                   Format(SalesShptHeader."Order No.") +
                                   Format(SalesShptHeader."Ship-to Post Code");
                    end;
                    if SalesShptHeader."Shipping Agent Code" = 'CORR' then begin
                        PAGINAWEB := 'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                                   Format(nexpefinal);
                    end;
                    if SalesShptHeader."Shipping Agent Code" = 'TNT' then begin
                        PAGINAWEB := 'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=REF&respLang=' +
                                   'ES&respCountry=ES&sourceID=1&sourceCountry=' +
                                   'ES&sourceID=1&sourceCountry=ww&cons=' + Format(nexpefinal);
                    end;
                    SalesShptHeader."Enlace transporte" := CopyStr(PAGINAWEB, 1, 250);
                    SalesShptHeader."Enlace transporte 2" := CopyStr(PAGINAWEB, 251, 250);
                    SalesShptHeader."Enlace transporte 3" := CopyStr(PAGINAWEB, 501, 250);
                end;
                if COMPANYNAME <> 'PEPE' then begin
                    if SalesShptHeader."Shipping Agent Code" = 'DHL' then begin
                        PAGINAWEB := 'http://www.dhl.es/services_es/seg_3dd/integra/SeguimientoDocumentos.aspx?codigo=' +
                                   Format(nexpefinal) + '&anno=2013&lang=sp&refCli=1 , a partir de hoy a las 22:00.';
                    end;
                    if SalesShptHeader."Shipping Agent Code" = 'CRON' then begin
                        PAGINAWEB := 'https://www.correosexpress.com/url/v?s=' +
                                   Format(nexpefinal) + '&cp=' + Format(SalesShptHeader."Ship-to Post Code");
                    end;
                    if SalesShptHeader."Shipping Agent Code" = 'CORR' then begin
                        PAGINAWEB := 'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                                   Format(nexpefinal);
                    end;
                    if SalesShptHeader."Shipping Agent Code" = 'TNT' then begin
                        PAGINAWEB := 'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=' +
                                   'REF&respLang=ES&respCountry=ES&sourceID=1&sourceCountry=' +
                                   'ES&sourceID=1&sourceCountry=ww&cons=' +
                                    Format(nexpefinal);
                    end;
                    if SalesShptHeader."Shipping Agent Code" = 'TIPSA' then begin
                        PAGINAWEB := 'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                                    Format(nexpefinal) +
                                    Format(SalesShptHeader."Ship-to Post Code");
                    end;
                    SalesShptHeader."Enlace transporte" := CopyStr(PAGINAWEB, 1, 250);
                    SalesShptHeader."Enlace transporte 2" := CopyStr(PAGINAWEB, 251, 250);
                    SalesShptHeader."Enlace transporte 3" := CopyStr(PAGINAWEB, 501, 250);
                end;
            end;
            if RecTransp."Link transporte" <> '' then begin
                PAGINAWEB := RecTransp."Link transporte";
                if RecTransp.Añadir = 0 then PAGINAWEB := PAGINAWEB + Format(nexpefinal);
                if RecTransp.Añadir = 1 then
                    PAGINAWEB := PAGINAWEB + Format(nexpefinal) +
                        Format(SalesShptHeader."Ship-to Post Code");
                if RecTransp.Añadir = 2 then
                    PAGINAWEB := PAGINAWEB + Format(nexpefinal) + '/' +
                        Format(SalesShptHeader."Ship-to Post Code");
                if RecTransp.Añadir = 3 then
                    PAGINAWEB := PAGINAWEB + Format(nexpefinal) +
                        Format(Date2DMY(SalesShptHeader."Posting Date", 3));

                SalesShptHeader."Enlace transporte" := CopyStr(PAGINAWEB, 1, 250);
                SalesShptHeader."Enlace transporte 2" := CopyStr(PAGINAWEB, 251, 250);
                SalesShptHeader."Enlace transporte 3" := CopyStr(PAGINAWEB, 501, 250);



            end;
        end;

        if SalesShptHeader."Bill-to Customer No." = '6445' then begin
            SalesShptHeader."Pasar a Canarias" := true;
            SalesShptHeader."Pasada a Canarias" := false;
        end;
        if SalesHeader."Nº expedición agrupada" <> '' then begin
            SalesShptHeader."Nº expedición" := SalesHeader."Nº expedición" + '-' + SalesHeader."Nº expedición agrupada";
            SalesShptHeader."Nº bultos" := 1;
            SalesShptHeader."Total bultos" := 1;
            if SalesShptHeader."Incrementa bultos" <> 0 then begin
                SalesShptHeader."Nº bultos" := SalesShptHeader."Nº bultos" + SalesShptHeader."Incrementa bultos";
                SalesShptHeader."Total bultos" := SalesShptHeader."Total bultos" + SalesShptHeader."Incrementa bultos";
            end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; WhseShip: Boolean; WhseShptHeader: Record "Warehouse Shipment Header"; InvtPickPutaway: Boolean)
    var
        RecClie: Record Customer;
        RecTransp: Record "Shipping Agent";
        PAGINAWEB: Text[1000];
        CODDOC: Code[20];
        RecItem: Record Item;
        //GLEntry2: Record "G/L Entry";
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        SalesCrMemoHeader2: Record "Sales Cr.Memo Header";
        nexpefinal: code[20];
    begin
        if RecClie.Get(SalesInvHeader."Sell-to Customer No.") then begin
            if (RecClie."Email facturacion 1" <> '') and (RecClie."Servicio email" = true) then begin
                SalesInvHeader."Enviar email" := true;
                SalesInvHeader."Email enviado" := false;
            end;
            SalesInvHeader."CSV Enviar" := RecClie."Factura CSV";

        end;
        nexpefinal := SalesInvHeader."Nº expedición dropshp";
        if SalesInvHeader."Nº expedición dropshp" <> '' then begin
            nexpefinal := SalesInvHeader."Nº expedición dropshp";
        end;

        if RecTransp.Get(SalesInvHeader."Shipping Agent Code") then begin
            if RecTransp."Link transporte" = '' then begin
                if COMPANYNAME = 'PEPE' then begin
                    if SalesInvHeader."Shipping Agent Code" = 'TIPSA' then begin
                        PAGINAWEB := 'http://www.tip-sa.com/cliente/datos.php?id=04601100112' + Format(nexpefinal) + ' - ' +
                                   Format(SalesInvHeader."Your Reference") + ' - ' +
                                   Format(SalesInvHeader."Order No.") +
                                   Format(SalesInvHeader."Ship-to Post Code");
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'CORR' then begin
                        PAGINAWEB := 'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                                   Format(nexpefinal);
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'TNT' then begin
                        PAGINAWEB := 'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=REF&respLang=' +
                                   'ES&respCountry=ES&sourceID=1&sourceCountry=' +
                                   'ES&sourceID=1&sourceCountry=ww&cons=' + Format(nexpefinal);
                    end;
                    SalesInvHeader."Enlace transporte" := CopyStr(PAGINAWEB, 1, 250);
                    SalesInvHeader."Enlace transporte 2" := CopyStr(PAGINAWEB, 251, 250);
                    SalesInvHeader."Enlace transporte 3" := CopyStr(PAGINAWEB, 501, 250);
                end;
                if COMPANYNAME <> 'PEPE' then begin
                    if SalesInvHeader."Shipping Agent Code" = 'DHL' then begin
                        PAGINAWEB := 'http://www.dhl.es/services_es/seg_3dd/integra/SeguimientoDocumentos.aspx?codigo=' +
                                   Format(nexpefinal) + '&anno=2013&lang=sp&refCli=1 , a partir de hoy a las 22:00.';
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'CRON' then begin
                        PAGINAWEB := 'https://www.correosexpress.com/url/v?s=' +
                                   Format(nexpefinal) + '&cp=' + Format(SalesInvHeader."Ship-to Post Code");
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'CORR' then begin
                        PAGINAWEB := 'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                                   Format(nexpefinal);
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'TNT' then begin
                        PAGINAWEB := 'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=' +
                                   'REF&respLang=ES&respCountry=ES&sourceID=1&sourceCountry=' +
                                   'ES&sourceID=1&sourceCountry=ww&cons=' +
                                    Format(nexpefinal);
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'TIPSA' then begin
                        PAGINAWEB := 'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                                    Format(nexpefinal) +
                                    Format(SalesInvHeader."Ship-to Post Code");
                    end;
                    SalesInvHeader."Enlace transporte" := CopyStr(PAGINAWEB, 1, 250);
                    SalesInvHeader."Enlace transporte 2" := CopyStr(PAGINAWEB, 251, 250);
                    SalesInvHeader."Enlace transporte 3" := CopyStr(PAGINAWEB, 501, 250);
                end;
            end;
            if RecTransp."Link transporte" <> '' then begin
                PAGINAWEB := RecTransp."Link transporte";
                if RecTransp.Añadir = 0 then PAGINAWEB := PAGINAWEB + Format(nexpefinal);
                if RecTransp.Añadir = 1 then
                    PAGINAWEB := PAGINAWEB + Format(nexpefinal) +
                    Format(SalesInvHeader."Ship-to Post Code");
                SalesInvHeader."Enlace transporte" := CopyStr(PAGINAWEB, 1, 250);
                SalesInvHeader."Enlace transporte 2" := CopyStr(PAGINAWEB, 251, 250);
                SalesInvHeader."Enlace transporte 3" := CopyStr(PAGINAWEB, 501, 250);



            end;


        end;

        if SalesInvHeader."Bill-to Customer No." = '6445' then begin
            SalesInvHeader."Pasar a Canarias" := true;
            SalesInvHeader."Pasada a Canarias" := false;
        end;

        CODDOC := SalesInvHeader."No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesShptLineInsert', '', false, false)]
    local procedure OnBeforeSalesShptLineInsert(var SalesShptLine: Record "Sales Shipment Line"; SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; PostedWhseShipmentLine: Record "Posted Whse. Shipment Line"; SalesHeader: Record "Sales Header"; WhseShip: Boolean; WhseReceive: Boolean; ItemLedgShptEntryNo: Integer; xSalesLine: record "Sales Line"; var TempSalesLineGlobal: record "Sales Line" temporary; var IsHandled: Boolean)
    begin
        SalesShptLine."Your Reference" := SalesShptHeader."Your Reference";
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePurchRcptHeaderInsert', '', false, false)]
    local procedure OnBeforePurchRcptHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WhseReceive: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean)
    begin
        PurchRcptHeader."Enviar email" := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePurchRcptLineInsert', '', false, false)]
    local procedure OnBeforePurchRcptLineInsert(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean; PostedWhseRcptLine: Record "Posted Whse. Receipt Line"; var IsHandled: Boolean)
    var
        RecItem: Record Item;
    begin
        ///// GRABA LA FECHA DE LANZAMIENTO.
        if PurchRcptLine.Type = 2 then begin
            if RecItem.Get(PurchRcptLine."No.") then begin
                if RecItem."Fecha Lanzamiento" = 0D then begin
                    RecItem."Fecha Lanzamiento" := WorkDate;
                end;
                RecItem."Actualizar WEB" := true;
                RecItem.Modify;
            end;

        end;
    end;

    procedure OnModify(var Cust: Record Customer)
    var
        ContactBusinessRelation: Record "Contact Business Relation";
        Contact: Record Contact;
        OldContact: Record Contact;
        ContactNo: Code[20];
        NoSeries: Code[20];
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeOnModify(Cust, ContactBusinessRelation, IsHandled);
        if not IsHandled then begin
            ContactBusinessRelation.SetCurrentKey("Link to Table", "No.");
            ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
            ContactBusinessRelation.SetRange("No.", Cust."No.");
            if not ContactBusinessRelation.FindFirst() then
                exit;
            if not Contact.Get(ContactBusinessRelation."Contact No.") then begin
                ContactBusinessRelation.Delete();
                //Session.LogMessage('0000B37', CustContactUpdateTelemetryMsg, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', CustContactUpdateCategoryTxt);
                exit;
            end;
            OldContact := Contact;

            ContactNo := Contact."No.";
            NoSeries := Contact."No. Series";
            Contact.Validate("E-Mail", Cust."E-Mail");

            //OnModifyOnBeforeTransferFieldsFromCustToContact(Contact, Cust);
            Contact.TransferFields(Cust);
            Contact."No." := ContactNo;
            Contact."No. Series" := NoSeries;
            //OnAfterTransferFieldsFromCustToCont(Contact, Cust);

            Contact.Type := OldContact.Type;
            Contact.Validate(Name);
            Contact.DoModify(OldContact);
            Contact.Modify(true);

            //Cust.Get(Cust."No.");
        end;

        //OnAfterOnModify(Contact, OldContact, Cust);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1303, 'OnBeforeSalesHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesHeaderInsert(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"); ///; var CancellingOnly: Boolean);
    var
    begin
        /////SalesHeader.Validate("Posting Date",WorkDate());         
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Shipment - Update", 'OnAfterRecordChanged', '', false, false)]
    local procedure OnAfterRecordChangedPostedSalesShipmentUpdate(var IsChanged: Boolean; var SalesShipmentHeader: Record "Sales Shipment Header"; xSalesShipmentHeader: Record "Sales Shipment Header")
    begin
        if Not IsChanged then begin
            IsChanged :=
                (SalesShipmentHeader."Numero segumiento" <> xSalesShipmentHeader."Numero segumiento") or
                (SalesShipmentHeader."Estado Expedicion" <> xSalesShipmentHeader."Estado Expedicion") or
                (SalesShipmentHeader."Total bultos" <> xSalesShipmentHeader."Total bultos") or
                (SalesShipmentHeader."Nº bultos" <> xSalesShipmentHeader."Nº bultos") or
                (SalesShipmentHeader."Nº Palets" <> xSalesShipmentHeader."Nº Palets") or
                (SalesShipmentHeader."Total peso" <> xSalesShipmentHeader."Total peso") or
                (SalesShipmentHeader.ASN <> xSalesShipmentHeader.ASN) or
                (SalesShipmentHeader."Nº expedición" <> xSalesShipmentHeader."Nº expedición") or
                (SalesShipmentHeader."Ship-to Address" <> xSalesShipmentHeader."Ship-to Address") or
                (SalesShipmentHeader."Ship-to Address 2" <> xSalesShipmentHeader."Ship-to Address 2") or
                (SalesShipmentHeader."Ship-to Name" <> xSalesShipmentHeader."Ship-to Name") or
                (SalesShipmentHeader."Ship-to Name 2" <> xSalesShipmentHeader."Ship-to Name 2") or
                (SalesShipmentHeader."Ship-to City" <> xSalesShipmentHeader."Ship-to City") or
                (SalesShipmentHeader."Ship-to County" <> xSalesShipmentHeader."Ship-to County") or
                (SalesShipmentHeader."Ship-to Post Code" <> xSalesShipmentHeader."Ship-to Post Code") or
                (SalesShipmentHeader."Ship-to Country/Region Code" <> xSalesShipmentHeader."Ship-to Country/Region Code") or
                (SalesShipmentHeader."Ship-to Phone No." <> xSalesShipmentHeader."Ship-to Phone No.") or
                (SalesShipmentHeader."Ship-to Code" <> xSalesShipmentHeader."Ship-to Code") or
                (SalesShipmentHeader."Ship-to Contact" <> xSalesShipmentHeader."Ship-to Contact");
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shipment Header - Edit", 'OnBeforeSalesShptHeaderModify', '', false, false)]
    local procedure OnBeforeSalesShptHeaderModify(var SalesShptHeader: Record "Sales Shipment Header"; FromSalesShptHeader: Record "Sales Shipment Header")
    begin
        SalesShptHeader."Numero segumiento" := FromSalesShptHeader."Numero segumiento";
        // SalesShptHeader."Nº expedición" := FromSalesShptHeader."Package Tracking No.";
        SalesShptHeader."Estado Expedicion" := FromSalesShptHeader."Estado Expedicion";
        SalesShptHeader."Nº bultos" := FromSalesShptHeader."Nº bultos";
        SalesShptHeader."Total bultos" := FromSalesShptHeader."Total bultos";
        SalesShptHeader."Nº Palets" := FromSalesShptHeader."Nº Palets";
        SalesShptHeader."Total peso" := FromSalesShptHeader."Total peso";
        SalesShptHeader.ASN := FromSalesShptHeader.ASN;
        SalesShptHeader."Observación para transporte" := FromSalesShptHeader."Observación para transporte";
        SalesShptHeader."Nº expedición" := FromSalesShptHeader."Nº expedición";
        SalesShptHeader."Ship-to Address" := FromSalesShptHeader."Ship-to Address";
        SalesShptHeader."Ship-to Address 2" := FromSalesShptHeader."Ship-to Address 2";
        SalesShptHeader."Ship-to Name" := FromSalesShptHeader."Ship-to Name";
        SalesShptHeader."Ship-to Name 2" := FromSalesShptHeader."Ship-to Name 2";
        SalesShptHeader."Ship-to City" := FromSalesShptHeader."Ship-to City";
        SalesShptHeader."Ship-to County" := FromSalesShptHeader."Ship-to County";
        SalesShptHeader."Ship-to Post Code" := FromSalesShptHeader."Ship-to Post Code";
        SalesShptHeader."Ship-to Country/Region Code" := FromSalesShptHeader."Ship-to Country/Region Code";
        SalesShptHeader."Ship-to Phone No." := FromSalesShptHeader."Ship-to Phone No.";
        SalesShptHeader."Ship-to Contact" := FromSalesShptHeader."Ship-to Contact";
        SalesShptHeader."Ship-to Code" := FromSalesShptHeader."Ship-to Code";
    end;

    [EventSubscriber(ObjectType::report, report::"Standard Sales - Invoice", 'OnBeforeLineOnAfterGetRecord', '', false, false)]
    local procedure OnBeforeLineOnAfterGetRecordStandardSalesInvoice(var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesInvoiceLine: Record "Sales Invoice Line")
    begin
        SalesInvoiceLine."Line Amount" := 0;
        SalesInvoiceLine."Inv. Discount Amount" := 0;
    end;
}
