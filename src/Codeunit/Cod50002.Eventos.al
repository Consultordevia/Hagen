codeunit 50002 Eventos
{
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
    begin
        EnvioFicheros.MODIFCLIENTES(Rec);
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
        EnvioFicheros.MODIFPROVEE(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterOnInsert', '', true, true)]
    local procedure OnAfterOnInsertProd(var Item: Record Item; xItem: Record Item)
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin
        Item."Fecha modif" := CreateDatetime(Today, Time);
        //EnvioFicheros.ALTAPROD(item);


    end;

    [EventSubscriber(ObjectType::Table, 27, OnBeforeModifyEvent, '', true, true)]
    local procedure OnAfterModifyEventProd(RunTrigger: Boolean; var Rec: Record Item);
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
        /////        EnvioFicheros.MODIFPROD(Rec);
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
        RecDP: Record "Customer Pmt. Address";
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
            RecDP.Reset;
            RecDP.SetRange(RecDP."Customer No.", SalesHeader."Sell-to Customer No.");
            if RecDP.FindFirst then begin
                SalesHeader."Pay-at Code" := RecDP.Code;
                SalesHeader.Validate("Pay-at Code");
                IsHandled := true;
            end;
        end;



        if SalesHeader."Bill-to Customer No." = '6445' then begin
            SalesHeader."Shipping No. Series" := 'V-ALB-CANA';
            SalesHeader."Pay-at Code" := '';
            IsHandled := true;
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
                ///        ERROR('Este producto no se permite en pedido.');
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
        SalesHeader.get(SalesLine."Document Type", SalesLine."Document No.");

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
}
