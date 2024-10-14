#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50036 "Recalcula no permitir pedido"
{
    // 
    // 13349


    trigger OnRun()
    begin


        ClientesHagenCanarias;

        RecalculaNoPermitido;




        exit;


    end;

    var
        ExistenciaHAGEN: Decimal;
        Item2: Record Item;
        ELMIN: Decimal;
        RecBom: Record "BOM Component";
        RecItem4: Record Item;
        InventorySetup: Record "Inventory Setup";
        ArchSalida: File;
        ArchExt: Text[250];
        TextoSalida: Text[250];
        dispo: Decimal;
        dispoc: Code[20];
        Text1100009: label '<Integer>';
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentHeader2: Record "Sales Shipment Header";
        SalesShipmentHeader3: Record "Sales Shipment Header";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        ArchSalida4: File;
        ArchExt4: Text[250];
        Item: Record Item;
        TextoSalida1: Text[250];
        TextoSalida2: Text[250];
        TextoSalida3: Text[250];
        RecGP: Record "Gen. Product Posting Group";
        DISPONI: Decimal;
        ENTRA: Boolean;
        RecItem221: Record Item;
        UNIMEDAD: Decimal;
        FECHARECEP: Date;
        Rec39: Record "Purchase Line";
        Rec38: Record "Purchase Header";
        CMARCA: Text[30];
        RecMt: Record Multitabla;
        RecUMP: Record "Item Unit of Measure";
        RecMT2: Record "Multitabla 2";
        dtext1: Text[200];
        CASCII: Codeunit "ANSI <-> ASCII converter2";
        BOMComponent: Record "BOM Component";
        DESDEA: Date;
        Customer: Record Customer;
        Rec32: Record "Item Ledger Entry";
        DESDE: Date;
        diascompara: Decimal;
        primera: Boolean;
        RecLC: Record "Purchase Line";
        suma: Decimal;
        para1: Decimal;
        para2: Decimal;
        dato1: Decimal;
        dato2: Decimal;
        DIASPARALLEGADA: Decimal;
        RecProve: Record Vendor;
        diablo: Code[20];
        diasprov: Decimal;
        CHA: Integer;
        String: Text[250];
        POS: Integer;
        String1: Text[250];
        String2: Text[250];
        POSICION: Integer;
        CODPROD: Code[20];
        SALE: Boolean;
        VENTANA: Dialog;
        TAcumu: Decimal;
        Tcanti: Decimal;
        Facturarimprimir: Codeunit "Facturar + imprimir";
        SalesHeader: Record "Sales Header";
        RecItem3: Record Item;
        RecItem2: Record Item;
        conta: Integer;
        Item5: Record Item;
        RecBCH: Record "Customer Bank Account";
        RecCli: Record Customer;
        RecClieH: Record Customer;
        codclie: Code[20];
        RecClieC: Record Customer;
        RecClie: Record Customer;
        RecBCC: Record "Customer Bank Account";
        Item44: Record Item;
        SalesLine: Record "Sales Line";
        PurchaseLine: Record "Purchase Line";
        sumapedi: Decimal;
        sumacomp: Decimal;

    local procedure StockHagen()
    begin
    end;

    local procedure ProductoCliente()
    begin


        DESDEA := CalcDate('-3M', Today);

        RecMT2.Reset;
        RecMT2.SetRange(RecMT2.Tabla, 7);
        if RecMT2.FindSet then
            repeat
                RecMT2."Eliminar de WEB" := true;
                RecMT2.Modify;
            until RecMT2.Next = 0;



        Item.Reset;
        Item.SetFilter(Item."Estado Producto", '0|1');
        if Item.FindSet then
            repeat
                if RecGP.Get(Item."Gen. Prod. Posting Group") then begin
                    if RecGP."Es producto" then begin
                        RecMT2.Reset;
                        RecMT2.SetRange(RecMT2.Tabla, 7);
                        RecMT2.SetRange(RecMT2."Codigo 1", Item."No.");
                        RecMT2.SetRange(RecMT2."Codigo 2", '4703');
                        if RecMT2.FindFirst then begin
                            RecMT2."Eliminar de WEB" := false;
                            RecMT2.Modify;
                        end;
                        if not RecMT2.FindFirst then begin
                            Customer.Get('4703');
                            RecMT2.Tabla := 7;
                            RecMT2."Codigo 1" := Item."No.";
                            RecMT2."Codigo 2" := '4703';
                            RecMT2."Actualizar WEB" := true;
                            RecMT2."Eliminar de WEB" := false;
                            RecMT2."Fecha eliminar" := 0D;
                            RecMT2.Insert;
                        end;

                        Rec32.Reset;
                        Rec32.SetCurrentkey(Rec32."Item No.");
                        Rec32.SetRange(Rec32."Item No.", Item."No.");
                        Rec32.SetRange(Rec32."Entry Type", 1);
                        Rec32.SetRange(Rec32."Posting Date", DESDEA, Today);
                        if Rec32.FindSet then
                            repeat
                                RecMT2.Reset;
                                RecMT2.SetRange(RecMT2.Tabla, 7);
                                RecMT2.SetRange(RecMT2."Codigo 1", Item."No.");
                                RecMT2.SetRange(RecMT2."Codigo 2", Rec32."Source No.");
                                if RecMT2.FindFirst then begin
                                    RecMT2."Eliminar de WEB" := false;
                                    RecMT2.Modify;
                                end;
                                if not RecMT2.FindFirst then begin
                                    Customer.Get(Rec32."Source No.");
                                    RecMT2.Tabla := 7;
                                    RecMT2."Codigo 1" := Item."No.";
                                    RecMT2."Codigo 2" := Rec32."Source No.";
                                    RecMT2."Actualizar WEB" := true;
                                    RecMT2."Eliminar de WEB" := false;
                                    RecMT2."Fecha eliminar" := 0D;
                                    RecMT2.Insert;
                                end;
                            until Rec32.Next = 0;
                    end;
                end;
            until Item.Next = 0;


        RecMT2.Reset;
        RecMT2.SetRange(RecMT2.Tabla, 7);
        RecMT2.SetRange(RecMT2."Eliminar de WEB", true);
        if RecMT2.FindSet then
            repeat
                if RecMT2."Fecha eliminar" = 0D then begin
                    RecMT2."Fecha eliminar" := CalcDate('+5D', Today);
                    RecMT2.Modify;
                end;
            until RecMT2.Next = 0;

        RecMT2.Reset;
        RecMT2.SetRange(RecMT2.Tabla, 7);
        RecMT2.SetRange(RecMT2."Eliminar de WEB", true);
        if RecMT2.FindSet then
            repeat
                if RecMT2."Fecha eliminar" <= Today then begin
                    RecMT2.Delete;
                end;
            until RecMT2.Next = 0;
    end;

    local procedure PermitePedidos(CodProd: Code[20])
    var
        Item3: Record Item;
    begin

        DESDE := CalcDate('-6M', Today);
        diascompara := Today - DESDE;

        RecMT2.Reset;
        RecMT2.SetRange(RecMT2.Tabla, 1);
        RecMT2.SetRange("Codigo 1", CodProd);
        if RecMT2.FindSet then
            repeat
                RecMT2."Venta global" := 0;
                RecMT2."Venta grupos" := 0;
                RecMT2."Stock actual" := 0;
                RecMT2."Para dias general" := 0;
                RecMT2."Para dias grupos" := 0;
                RecMT2."Pedido contenedor" := 0;
                RecMT2."Fecha pedido contenedor" := 0D;
                RecMT2."Venta diaria general" := 0;
                RecMT2."Venta diaria grupo" := 0;
                RecMT2.Reservar := false;
                RecMT2."Dias para llegada" := 0;
                RecMT2.Modify;
                if Item2.Get(RecMT2."Codigo 1") then begin
                    Item2."Producto con reserva" := false;
                    Item2.Modify;
                end;
            until RecMT2.Next = 0;

        RecMT2.Reset;
        RecMT2.SetRange(RecMT2.Tabla, 1);
        RecMT2.SetRange("Codigo 1", CodProd);
        if RecMT2.FindSet then
            repeat
                if Item3.Get(CodProd) then begin
                    if not Item3."Producto NO automatico" then begin
                        Item3.CalcFields(Item3.Inventory, "Existencia FOB");
                        Item3.SetRange(Item3."Location Filter", 'SILLA', 'SILLA');
                        Item3.SetRange(Item3."Date Filter", DESDE, Today);
                        Item3.CalcFields(Item3."Sales (Qty.)");
                        RecMT2."Stock actual" := Item3.Inventory - Item3."Existencia FOB";
                        RecMT2."Venta global" := Item3."Sales (Qty.)";
                        primera := true;
                        RecLC.Reset;
                        RecLC.SetCurrentkey(RecLC."Document Type", RecLC.Type, RecLC."No.");
                        RecLC.SetRange(RecLC."Document Type", 1);
                        RecLC.SetRange(RecLC.Type, 2);
                        RecLC.SetRange(RecLC."No.", CodProd);
                        RecLC.SetRange(RecLC."Outstanding Quantity", 1, 9999999999.0);
                        if RecLC.FindSet then
                            repeat
                                if primera then begin
                                    RecMT2."Fecha pedido contenedor" := RecLC."Expected Receipt Date";
                                    RecMT2."Pedido contenedor" := RecLC."Outstanding Quantity";
                                    primera := false;
                                end;
                                if RecMT2."Fecha pedido contenedor" > RecLC."Expected Receipt Date" then begin
                                    RecMT2."Fecha pedido contenedor" := RecLC."Expected Receipt Date";
                                    RecMT2."Pedido contenedor" := RecLC."Outstanding Quantity";
                                end;
                            until RecLC.Next = 0;
                        suma := 0;
                        Customer.Reset;
                        Customer.SetRange("Grupo clientes", RecMT2."Codigo 2");
                        if Customer.FindSet then
                            repeat
                                Rec32.Reset;
                                Rec32.SetCurrentkey(Rec32."Item No.", Rec32."Posting Date", Rec32."Source No.", Rec32."Source Type");
                                Rec32.SetRange(Rec32."Item No.", CodProd);
                                Rec32.SetRange(Rec32."Posting Date", DESDE, Today);
                                Rec32.SetRange(Rec32."Source No.", Customer."No.");
                                Rec32.SetRange(Rec32."Entry Type", 1);
                                if Rec32.FindSet then
                                    repeat
                                        suma := suma + Rec32.Quantity * -1;
                                    until Rec32.Next = 0;
                            until Customer.Next = 0;
                        para1 := 0;
                        para2 := 0;
                        RecMT2."Venta grupos" := RecMT2."Venta grupos" + suma;
                        dato1 := RecMT2."Venta global" / diascompara;
                        dato2 := RecMT2."Venta grupos" / diascompara;
                        if dato1 <> 0 then begin
                            para1 := ROUND(RecMT2."Stock actual" / dato1, 1);
                        end;
                        if dato2 <> 0 then begin
                            para2 := ROUND(RecMT2."Stock actual" / dato2, 1);
                        end;
                        RecMT2."Para dias general" := para1;
                        RecMT2."Para dias grupos" := para2;
                        RecMT2."Venta diaria general" := dato1;
                        RecMT2."Venta diaria grupo" := dato2;
                        RecMT2."Proveedor ref." := Item."Vendor No.";
                        DIASPARALLEGADA := 0;
                        if RecMT2."Fecha pedido contenedor" <> 0D then begin
                            DIASPARALLEGADA := RecMT2."Fecha pedido contenedor" - Today;
                            RecMT2."Dias para llegada" := DIASPARALLEGADA;
                        end;
                        if RecProve.Get(Item."Vendor No.") then begin
                            ///     RecMT2."Bloquear a dias":=RecProve."Lead Time Calculation";
                            //diablo:=FORMAT(RecMT2."Bloquear a dias");
                            ///diablo:=COPYSTR(diablo,1,STRLEN(diablo)-1);
                            //EVALUATE(diasprov,diablo)
                        end;
                        if RecMT2."Para dias grupos" <> 0 then begin
                            if (DIASPARALLEGADA + RecMT2."Para dias grupos") < diasprov then begin
                                RecMT2.Reservar := true;
                                if Item2.Get(RecMT2."Codigo 1") then begin
                                    Item2."Producto con reserva" := true;
                                    Item2.Modify;
                                end;
                            end;
                        end;
                        RecMT2."Venta de contenedor" := RecMT2."Venta diaria general" * DIASPARALLEGADA;
                        if RecMT2."Venta de contenedor" < RecMT2."Pedido contenedor" then begin
                            RecMT2.Reservar := false;
                            if Item2.Get(RecMT2."Codigo 1") then begin
                                Item2."Producto con reserva" := false;
                                Item2.Modify;
                            end;
                        end;
                        RecMT2.Modify;
                    end;
                end;
            until RecMT2.Next = 0;
    end;

    local procedure RecalculaNoPermitido()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ChangeLogEntry: Record "Change Log Entry";
        InventorySetup: Record "Inventory Setup";
        LOGCAMBIOA: Integer;
        Contador: Integer;
        CodProd: Code[20];
        SalesLine: Record "Sales Line";
    begin
        VENTANA.Open('#1###################');


        Item.Reset;
        ///Item.SETRANGE("No.",'43735W');
        if Item.FindFirst then
            repeat
                VENTANA.Update(1, Item."No.");
                /////Item.SETRANGE(Item."Location Filter",'SILLA','SILLA');
                if not Item."Producto NO automatico" then begin
                    Item.CalcFields(Item.Inventory, "Existencia FOB", Item."Qty. on Sales Order");
                    sumacomp := 0;
                    FECHARECEP := 20501231D;
                    PurchaseLine.Reset;
                    PurchaseLine.SetRange("No.", Item."No.");
                    PurchaseLine.SetFilter("Outstanding Quantity", '<>0');
                    if PurchaseLine.FindSet then
                        repeat
                            if PurchaseLine."Expected Receipt Date" < FECHARECEP then begin
                                FECHARECEP := PurchaseLine."Expected Receipt Date";
                            end;
                        /////sumacomp:=sumacomp+PurchaseLine."Outstanding Quantity";
                        until PurchaseLine.Next = 0;
                    sumapedi := 0;
                    SalesLine.Reset;
                    SalesLine.SetCurrentkey("Document Type", "No.");
                    SalesLine.SetRange("Document Type", SalesLine."document type"::Order);
                    SalesLine.SetRange("No.", Item."No.");
                    SalesLine.SetRange("Shipment Date", 0D, FECHARECEP);
                    SalesLine.SetFilter("Outstanding Quantity", '<>0');
                    if SalesLine.FindSet then
                        repeat
                            if SalesLine."Location Code" <> 'FOB' then begin
                                sumapedi := sumapedi + SalesLine."Outstanding Quantity";
                            end;
                        until SalesLine.Next = 0;
                    //// dispo:=Item.Inventory-Item."Qty. on Sales Order"-Item."Stock para Catit";
                    dispo := Item.Inventory - Item."Existencia FOB" - sumapedi + sumacomp - Item."Stock para Catit";
                    //////Item."Prohibido Amazon":=FALSE;
                    if dispo < Item."Stock Bloqueo Amz" then begin
                        Item."Prohibido Amazon" := true;
                        Item."Fecha prohibido Amazon" := CalcDate('+2A', Today);
                    end;
                    ///IF Item."No."='43735W' THEN BEGIN
                    ///                  MESSAGE('%1 %2 %3 %4 %5 %6',FECHARECEP,dispo,Item.Inventory,sumapedi,sumacomp,Item."Stock para Catit");
                    ///END;
                    if dispo <= 0 then begin
                        Item."No permite pedido" := true;
                    end;
                    if dispo > 0 then begin
                        Item."No permite pedido" := false;
                    end;
                    Item."Fecha recalcula no permitir" := CreateDatetime(Today, Time);
                    Item.Modify;
                    PermitePedidos(Item."No.");
                end;
                RecalculaStockCompuesto(Item."No.");
            until Item.Next = 0;


        VENTANA.Close;


    end;

    local procedure ImprimeEtiquetaEnvioPeq()
    begin




        SalesShipmentHeader.Reset;
        SalesShipmentHeader.SetCurrentkey("Imprime eti. envio");
        SalesShipmentHeader.SetRange("Imprime eti. envio", true);
        if SalesShipmentHeader.FindSet then
            repeat
                SalesShipmentHeader2.Reset;
                SalesShipmentHeader2.SetRange("No.", SalesShipmentHeader."No.");
                if SalesShipmentHeader2.FindFirst then begin
                    Report.RunModal(50033, false, false, SalesShipmentHeader2);
                end;
                SalesShipmentHeader3.Get(SalesShipmentHeader2."No.");
                SalesShipmentHeader3."Imprime eti. envio" := false;
                SalesShipmentHeader3.Modify;
            until SalesShipmentHeader.Next = 0;
    end;


    procedure GrabaStock()
    begin





    end;


    local procedure ProductosSustitutivos()
    var
        ItemSubstitution: Record "Item Substitution";
        Item: Record Item;
        Item2: Record Item;
    begin

        Item.Reset;
        if Item.FindFirst then
            repeat
                if Item."Producto PADRE" <> '' then begin
                    Item2.Reset;
                    Item2.SetRange(Item2."Producto PADRE", Item."Producto PADRE");
                    if Item2.FindFirst then
                        repeat
                            if Item."No." <> Item2."No." then begin
                                ItemSubstitution.Reset;
                                ItemSubstitution.SetRange(ItemSubstitution."No.", Item."No.");
                                ItemSubstitution.SetRange(ItemSubstitution."Substitute No.", Item2."No.");
                                if not ItemSubstitution.FindFirst then begin
                                    ItemSubstitution.Init;
                                    ItemSubstitution."No." := Item."No.";
                                    ItemSubstitution.Validate(ItemSubstitution."Substitute No.", Item2."No.");
                                    ItemSubstitution.Insert;
                                end;
                            end;
                        until Item2.Next = 0;
                end;
            until Item.Next = 0;
    end;




    procedure RecalculaStockCompuesto(CodArt: Code[20])
    begin


        Item44.Reset;
        Item44.SetRange("No.", CodArt);
        if Item44.FindSet then
            repeat
                ExistenciaHAGEN := 0;
                if (Item44."Producto almacenable" = false) and (Item44."Estado Producto" <> 2) then begin
                    if Item2.Get(Item44."No.") then begin
                        Item2.CalcFields(Inventory, "Existencia FOB", Item2."Existencia SILLA", Item2."Qty. on Sales Order");
                        ExistenciaHAGEN := Item2.Inventory - Item2."Existencia FOB" - Item2."Qty. on Sales Order";
                    end;
                    if Item44."Stock en HAGEN" <> ExistenciaHAGEN then begin
                        Item44."Actualizar WEB" := true;
                    end;
                end;
                Item44."Stock en HAGEN" := ExistenciaHAGEN;
                Item44.Modify;
            until Item44.Next = 0;



        if RecItem3.Get(CodArt) then begin
            if (RecItem3."Producto almacenable" = false) and (RecItem3."Estado Producto" <> 2) then begin
                ELMIN := 9999;
                RecBom.Reset;
                RecBom.SetRange(RecBom."Parent Item No.", RecItem3."No.");
                if RecBom.FindSet then
                    repeat
                        if RecItem2.Get(RecBom."No.") then begin
                            RecItem2.CalcFields(RecItem2."Existencia SILLA", Inventory, "Existencia FOB");
                            if (RecItem2.Inventory - RecItem2."Existencia FOB") <= ELMIN then begin
                                ELMIN := RecItem2.Inventory - RecItem2."Existencia FOB";
                            end;
                        end;
                    until RecBom.Next = 0;
                if ELMIN = 9999 then begin
                    ELMIN := 0;
                end;
                RecItem3."Stock en HAGEN" := ELMIN;
                RecItem3.Modify;
            end else begin
                RecItem3."Stock en HAGEN" := 0;
                RecItem3.Modify;
            end;
        end;
    end;

    local procedure ClientesHagenCanarias()
    begin





        if COMPANYNAME = 'ROLF C HAGEN ESPAÑA S.A.' then begin
            VENTANA.Open('#1#################');
            RecCli.SetRange(RecCli.Comunidad, '7');
            if RecCli.FindFirst then
                repeat
                    codclie := RecCli."No.";
                    if RecClieH.Get(codclie) then begin
                        VENTANA.Update(1, RecClie."No.");
                        RecClieC.ChangeCompany('HAGEN CANARIAS S.C.');
                        if RecClieC.Get(codclie) then begin
                            RecClieC.Name := RecClieH.Name;
                            RecClieC."Search Name" := RecClieH."Search Name";
                            RecClieC."Name 2" := RecClieH."Name 2";
                            RecClieC.Address := RecClieH.Address;
                            RecClieC."Address 2" := RecClieH."Address 2";
                            RecClieC.City := RecClieH.City;
                            RecClieC.Contact := RecClieH.Contact;
                            RecClieC."Phone No." := RecClieH."Phone No.";
                            RecClieC."Telex No." := RecClieH."Telex No.";
                            RecClieC."Our Account No." := RecClieH."Our Account No.";
                            RecClieC."Territory Code" := RecClieH."Territory Code";
                            RecClieC."Chain Name" := RecClieH."Chain Name";
                            RecClieC."Customer Posting Group" := RecClieH."Customer Posting Group";
                            RecClieC."Currency Code" := RecClieH."Currency Code";
                            RecClieC."Customer Price Group" := RecClieH."Customer Price Group";
                            RecClieC."Language Code" := RecClieH."Language Code";
                            RecClieC."Statistics Group" := RecClieH."Statistics Group";
                            RecClieC."Payment Terms Code" := RecClieH."Payment Terms Code";
                            RecClieC."Fin. Charge Terms Code" := RecClieH."Fin. Charge Terms Code";
                            RecClieC."Salesperson Code" := RecClieH."Salesperson Code";
                            RecClieC."Shipment Method Code" := RecClieH."Shipment Method Code";
                            ;
                            RecClieC."Shipping Agent Code" := RecClieH."Shipping Agent Code";
                            RecClieC."Place of Export" := RecClieH."Place of Export";
                            RecClieC."Invoice Disc. Code" := RecClieH."Invoice Disc. Code";
                            RecClieC."Customer Disc. Group" := RecClieH."Customer Disc. Group";
                            RecClieC."Country/Region Code" := RecClieH."Country/Region Code";
                            RecClieC."Collection Method" := RecClieH."Collection Method";
                            RecClieC.Blocked := RecClieH.Blocked;
                            RecClieC."Invoice Copies" := RecClieH."Invoice Copies";
                            RecClieC."Last Statement No." := RecClieH."Last Statement No.";
                            RecClieC."Print Statements" := RecClieH."Print Statements";
                            RecClieC."Bill-to Customer No." := RecClieH."Bill-to Customer No.";
                            RecClieC.Priority := RecClieH.Priority;
                            RecClieC."Payment Method Code" := RecClieH."Payment Method Code";
                            RecClieC."Last Date Modified" := RecClieH."Last Date Modified";
                            RecClieC."Application Method" := RecClieH."Application Method";
                            RecClieC."Prices Including VAT" := RecClieH."Prices Including VAT";
                            RecClieC."Location Code" := RecClieH."Location Code";
                            RecClieC."Fax No." := RecClieH."Fax No.";
                            RecClieC."Telex Answer Back" := RecClieH."Telex Answer Back";
                            RecClieC."VAT Registration No." := RecClieH."VAT Registration No.";
                            RecClieC."Combine Shipments" := RecClieH."Combine Shipments";
                            RecClieC."Gen. Bus. Posting Group" := RecClieH."Gen. Bus. Posting Group";
                            RecClieC."Post Code" := RecClieH."Post Code";
                            RecClieC.County := RecClieH.County;
                            RecClieC."E-Mail" := RecClieH."E-Mail";
                            RecClieC."Home Page" := RecClieH."Home Page";
                            RecClieC."Reminder Terms Code" := RecClieH."Reminder Terms Code";
                            RecClieC."No. Series" := RecClieH."No. Series";
                            RecClieC."Tax Area Code" := RecClieH."Tax Area Code";
                            RecClieC."Tax Liable" := RecClieH."Tax Liable";
                            RecClieC."VAT Bus. Posting Group" := RecClieH."VAT Bus. Posting Group";
                            RecClieC."Block Payment Tolerance" := RecClieH."Block Payment Tolerance";
                            RecClieC."IC Partner Code" := RecClieH."IC Partner Code";
                            RecClieC."Prepayment %" := RecClieH."Prepayment %";
                            RecClieC."Primary Contact No." := RecClieH."Primary Contact No.";
                            RecClieC."Responsibility Center" := RecClieH."Responsibility Center";
                            RecClieC."Shipping Advice" := RecClieH."Shipping Advice";
                            RecClieC."Shipping Time" := RecClieH."Shipping Time";
                            RecClieC."Shipping Agent Service Code" := RecClieH."Shipping Agent Service Code";
                            RecClieC."Service Zone Code" := RecClieH."Service Zone Code";
                            RecClieC."Allow Line Disc." := RecClieH."Allow Line Disc.";
                            RecClieC."Base Calendar Code" := RecClieH."Base Calendar Code";
                            RecClieC."Copy Sell-to Addr. to Qte From" := RecClieH."Copy Sell-to Addr. to Qte From";
                            RecClieC."Payment Days Code" := RecClieH."Payment Days Code";
                            RecClieC."Non-Paymt. Periods Code" := RecClieH."Non-Paymt. Periods Code";
                            RecClieC."Clasificación A,B,C Hagen" := RecClieH."Clasificación A,B,C Hagen";
                            RecClieC."Fecha alta" := RecClieH."Fecha alta";
                            RecClieC."Modificado por" := RecClieH."Modificado por";
                            RecClieC."Fecha de Modificación" := RecClieH."Fecha de Modificación";
                            RecClieC."Tipo facturación" := RecClieH."Tipo facturación";
                            RecClieC."Aviso Notas" := RecClieH."Aviso Notas";
                            RecClieC."Albaran valorado" := RecClieH."Albaran valorado";
                            RecClieC."Frecuencia visita comercial" := RecClieH."Frecuencia visita comercial";
                            RecClieC.Televendedor := RecClieH.Televendedor;
                            RecClieC."Nº pedido obligatorio" := RecClieH."Nº pedido obligatorio";
                            RecClieC."Servicio email" := RecClieH."Servicio email";
                            RecClieC."Usuario alta" := RecClieH."Usuario alta";
                            RecClieC."Fecha clasificación A,B,C" := RecClieH."Fecha clasificación A,B,C";
                            RecClieC."Grupo clientes" := RecClieH."Grupo clientes";
                            RecClieC."Zona de ventas" := RecClieH."Zona de ventas";
                            RecClieC."Clasificacion CRM" := RecClieH."Clasificacion CRM";
                            RecClieC.Borrado := RecClieH.Borrado;
                            RecClieC."Telefono 2" := RecClieH."Telefono 2";
                            RecClieC."Nº movil" := RecClieH."Nº movil";
                            RecClieC."Observación para transporte" := RecClieH."Observación para transporte";
                            RecClieC."Albaran sin detalle" := RecClieH."Albaran sin detalle";
                            RecClieC."Clasificación A,B,C Vendedor" := RecClieH."Clasificación A,B,C Vendedor";
                            RecClieC."Fecha Clasi. A,B,C Vendedor" := RecClieH."Fecha Clasi. A,B,C Vendedor";
                            RecClieC."Contacto en factura" := RecClieH."Contacto en factura";
                            RecClieC."Correo elect. Comercial" := RecClieH."Correo elect. Comercial";
                            RecClieC."Estatus del cliente" := RecClieH."Estatus del cliente";
                            RecClieC."Incluir en propaganda" := RecClieH."Incluir en propaganda";
                            RecClieC."No incluir portes" := RecClieH."No incluir portes";
                            RecClieC."Respeta agencia transporte" := RecClieH."Respeta agencia transporte";
                            RecClieC."Respeta Tipo facturacion" := RecClieH."Respeta Tipo facturacion";
                            RecClieC."No imprimir facturas" := RecClieH."No imprimir facturas";
                            RecClieC."Email facturacion 1" := RecClieH."Email facturacion 1";
                            RecClieC."Email facturacion 2" := RecClieH."Email facturacion 2";
                            RecClieC."Email facturacion 3" := RecClieH."Email facturacion 3";
                            RecClieC."Dias tolerancias fecha vto." := RecClieH."Dias tolerancias fecha vto.";
                            RecClieC."Mas comerciales" := RecClieH."Mas comerciales";
                            RecClieC."Grupo descuento mensual" := RecClieH."Grupo descuento mensual";
                            RecClieC."No enviar emial de preparacion" := RecClieH."No enviar emial de preparacion";
                            RecClieC."Email albaran sin detalle 1" := RecClieH."Email albaran sin detalle 1";
                            RecClieC."Factura ordenada" := RecClieH."Factura ordenada";
                            RecClieC."Email abono 1" := RecClieH."Email abono 1";
                            RecClieC."Email abono 2" := RecClieH."Email abono 2";
                            RecClieC."Email pedido 1" := RecClieH."Email pedido 1";
                            RecClieC."Email pedido 2" := RecClieH."Email pedido 2";
                            RecClieC."Adjuntar pub. facturacion 1" := RecClieH."Adjuntar pub. facturacion 1";
                            RecClieC."Adjuntar pub. facturacion 2" := RecClieH."Adjuntar pub. facturacion 2";
                            RecClieC."Adjuntar pub. facturacion 3" := RecClieH."Adjuntar pub. facturacion 3";
                            RecClieC."Adjuntar pub. albaran sin det." := RecClieH."Adjuntar pub. albaran sin det.";
                            RecClieC."Adjuntar pub. abono 1" := RecClieH."Adjuntar pub. abono 1";
                            RecClieC."Adjuntar pub. abono 2" := RecClieH."Adjuntar pub. abono 2";
                            RecClieC."Adjuntar pub. pedido 1" := RecClieH."Adjuntar pub. pedido 1";
                            RecClieC."Adjuntar pub. pedido 2" := RecClieH."Adjuntar pub. pedido 2";
                            RecClieC."Adjuntar pub. albaran 1" := RecClieH."Adjuntar pub. albaran 1";
                            RecClieC."Adjuntar pub. albaran 2" := RecClieH."Adjuntar pub. albaran 2";
                            RecClieC."Adjuntar pub. albaran 3" := RecClieH."Adjuntar pub. albaran 3";
                            RecClieC."No imprimir albaran valorado" := RecClieH."No imprimir albaran valorado";
                            RecClieC."Impresion fact. sin dto." := RecClieH."Impresion fact. sin dto.";

                            RecClieC."Centro ECI" := RecClieH."Centro ECI";
                            RecClieC."Factura con PVP" := RecClieH."Factura con PVP";
                            RecClieC.Latitud := RecClieH.Latitud;
                            RecClieC.Longitud := RecClieH.Longitud;
                            RecClieC.Comunidad := RecClieH.Comunidad;
                            RecClieC."Factura CSV" := RecClieH."Factura CSV";
                            RecClieC."Albaran CSV" := RecClieH."Albaran CSV";
                            RecClieC."Codigo cliente externo" := RecClieH."Codigo cliente externo";
                            RecClieC."Ruta envio CSV" := RecClieH."Ruta envio CSV";
                            RecClieC."Grupo ventas" := RecClieH."Grupo ventas";
                            RecClieC.Nombre_Cliente := RecClieH.Nombre_Cliente;
                            RecClieC."Localizacion tienda" := RecClieH."Localizacion tienda";
                            RecClieC."Tipo negocio" := RecClieH."Tipo negocio";
                            RecClieC."Año apertura" := RecClieH."Año apertura";
                            RecClieC."Contraseña WEB" := RecClieH."Contraseña WEB";
                            RecClieC."Nº proveedor" := RecClieH."Nº proveedor";
                            RecClieC."Usuario Web" := RecClieH."Usuario Web";
                            RecClieC."Nombre para email" := RecClieH."Nombre para email";
                            RecClieC."No email chimp" := RecClieH."No email chimp";
                            RecClieC."Actualizar WEB" := RecClieH."Actualizar WEB";
                            RecClieC."Enviar a Web" := RecClieH."Enviar a Web";
                            RecClieC."Enviar a Web Distribuidor" := RecClieH."Enviar a Web Distribuidor";
                            RecClieC."Direccion Envio Habitual Store" := RecClieH."Direccion Envio Habitual Store";
                            RecClieC."Metros Establecimiento" := RecClieH."Metros Establecimiento";
                            RecClieC."VAT Bus. Posting Group" := 'IGIC';
                            RecClieC."Bill-to Customer No." := '';
                            RecClieC."Tipo facturación" := 0;
                            RecClieC.Modify;
                            Commit;

                            RecBCH.Reset;
                            RecBCH.SetRange(RecBCH."Customer No.", codclie);
                            if RecBCH.FindFirst then
                                repeat
                                    RecBCC.Reset;
                                    RecBCC.ChangeCompany('HAGEN CANARIAS S.C.');
                                    if RecBCC.Get(RecBCH."Customer No.", RecBCH.Code) then begin
                                        RecBCC."Bank Branch No." := RecBCH."Bank Branch No.";
                                        RecBCC."Bank Account No." := RecBCH."Bank Account No.";
                                        RecBCC."Transit No." := RecBCH."Transit No.";
                                        RecBCC."Currency Code" := RecBCH."Currency Code";
                                        RecBCC."Country/Region Code" := RecBCH."Country/Region Code";
                                        RecBCC.County := RecBCH.County;
                                        RecBCC.Iban := RecBCH.Iban;
                                        RecBCC."SWIFT Code" := RecBCH."SWIFT Code";
                                        RecBCC."CCC Bank No." := RecBCH."CCC Bank No.";
                                        RecBCC."CCC Bank Branch No." := RecBCH."CCC Bank Branch No.";
                                        RecBCC."CCC Control Digits" := RecBCH."CCC Control Digits";
                                        RecBCC."CCC Bank Account No." := RecBCH."CCC Bank Account No.";
                                        RecBCC."CCC No." := RecBCH."CCC No.";
                                        RecBCC.BIC := RecBCH.BIC;
                                        RecBCC.Modify;
                                        Commit;
                                    end;
                                    if not RecBCC.Get(RecBCH."Customer No.", RecBCH.Code) then begin
                                        RecBCC := RecBCH;
                                        RecBCC.Insert;
                                        Commit;
                                    end;

                                until RecBCH.Next = 0;
                        end;
                        if not RecClieC.Get(codclie) then begin
                            RecClieC.Init;
                            RecClieC := RecClieH;
                            RecClieC."VAT Bus. Posting Group" := 'IGIC';
                            RecClieC."Bill-to Customer No." := '';
                            RecClieC."Tipo facturación" := 0;
                            RecClieC.Insert;
                            Commit;
                            RecBCH.Reset;
                            RecBCH.SetRange(RecBCH."Customer No.", codclie);
                            if RecBCH.FindFirst then
                                repeat
                                    RecBCC.Reset;
                                    RecBCC.ChangeCompany('HAGEN CANARIAS S.C.');
                                    if RecBCC.Get(RecBCH."Customer No.", RecBCH.Code) then begin
                                        RecBCC."Bank Branch No." := RecBCH."Bank Branch No.";
                                        RecBCC."Bank Account No." := RecBCH."Bank Account No.";
                                        RecBCC."Transit No." := RecBCH."Transit No.";
                                        RecBCC."Currency Code" := RecBCH."Currency Code";
                                        RecBCC."Country/Region Code" := RecBCH."Country/Region Code";
                                        RecBCC.County := RecBCH.County;
                                        RecBCC.Iban := RecBCH.Iban;
                                        RecBCC."SWIFT Code" := RecBCH."SWIFT Code";
                                        RecBCC."CCC Bank No." := RecBCH."CCC Bank No.";
                                        RecBCC."CCC Bank Branch No." := RecBCH."CCC Bank Branch No.";
                                        RecBCC."CCC Control Digits" := RecBCH."CCC Control Digits";
                                        RecBCC."CCC Bank Account No." := RecBCH."CCC Bank Account No.";
                                        RecBCC."CCC No." := RecBCH."CCC No.";
                                        RecBCC.BIC := RecBCH.BIC;
                                        RecBCC.Modify;
                                        Commit;
                                    end;
                                    if not RecBCC.Get(RecBCH."Customer No.", RecBCH.Code) then begin
                                        RecBCC := RecBCH;
                                        RecBCC.Insert;
                                        Commit;
                                    end;
                                until RecBCH.Next = 0;
                        end;
                    end;
                until RecCli.Next = 0;
            VENTANA.Close;

        end;
    end;
}

