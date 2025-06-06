#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50001 Automaticos
{
    // 
    // 
    // FechaDispoWeb:=0D;
    // PurchaseLine.RESET;
    // PurchaseLine.SETRANGE("Document Type",PurchaseLine."Document Type"::Quote);
    // PurchaseLine.SETRANGE("No.",Rec."No.");
    // PurchaseLine.SETFILTER("Outstanding Quantity",'<>0');
    // IF PurchaseLine.FINDFIRST THEN BEGIN
    //      FechaDispoWeb:=PurchaseLine."Expected Receipt Date";
    // END;
    Permissions = tabledata "Sales Shipment Line" = rmi;


    trigger OnRun()
    begin


        PermitirPedidos;
        Commit;
        AnulaRestos;
        Commit;
        ClasificacionABCProductos;
        Commit;
        ClasificacionABCCliente;
        Commit;
        ClasificacionABCVendedor;
        Commit;
        FechaDispoWeb;
        Commit;
        EliminaMarcaFechaProhibidoAmazon;
        Commit;


        exit;



        RecalculaNoPermitido;
        ProductosSustitutivos;
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
        SalesHeader: Record "Sales Header";
        RecCV2: Record "Sales Header";
        pendi: Decimal;
        RecLV: Record "Sales Line";
        Rec37: Record "Sales Line";
        PRECIO: Decimal;
        SalesPrice: Record "Sales Price";
        codprovee: Code[20];
        codcategoriacov: Code[10];
        codfamiliacov: Code[10];
        codsubfamiliacov: Code[10];
        VATPostingSetup: Record "VAT Posting Setup";
        IVA: Decimal;
        Familiascatit1: Record "Familias catit";
        Familiascatit2: Record "Familias catit";
        eprecio: Decimal;
        edto: Decimal;
        ReleaseSalesDocument: Codeunit "Release Sales Document";
        VENTANA2: Dialog;
        RecItem2: Record Item;
        RecItem: Record Item;
        RecClie: Record Customer;
        cantidadPVta: Decimal;
        SalesLine: Record "Sales Line";
        ItemAmount: Record "Item Amount";
        i: Integer;
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ItemTMP: Record Item temporary;
        GenProductPostingGroupTMP: Record "Gen. Product Posting Group" temporary;
        sumatodo: Decimal;
        TANTO: Decimal;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Multitabla: Record Multitabla;
        SALE2: Boolean;
        L1: Integer;
        D1: Integer;
        D2: Integer;
        D3: Integer;
        D4: Integer;
        D5: Integer;

    local procedure StockHagen()
    begin

        Item.Reset;
        if Item.FindSet then
            repeat
                ExistenciaHAGEN := 0;
                if (Item."Producto almacenable" = false) and (Item."Estado Producto" <> 2) then begin
                    if Item2.Get(Item."No.") then begin
                        Item2.CalcFields(Item2."Existencia SILLA", Item2."Qty. on Sales Order");
                        ExistenciaHAGEN := Item2."Existencia SILLA" - Item2."Qty. on Sales Order";
                    end;
                    if Item."Stock en HAGEN" <> ExistenciaHAGEN then begin
                        Item."Actualizar WEB" := true;
                    end;
                end;
                Item."Stock en HAGEN" := ExistenciaHAGEN;
                Item.Modify;
                Commit;
            until Item.Next = 0;

        Commit;


        Item.Reset;
        if Item.FindSet then
            repeat
                ExistenciaHAGEN := 0;
                if (Item."Producto almacenable" = false) and (Item."Estado Producto" <> 2) then begin
                    ELMIN := 9999;
                    BOMComponent.Reset;
                    BOMComponent.SetRange(BOMComponent."Parent Item No.", Item."No.");
                    if BOMComponent.FindSet then
                        repeat
                            if Item2.Get(BOMComponent."No.") then begin
                                Item2.CalcFields(Item2."Existencia SILLA");
                                if Item2."Existencia SILLA" <= ELMIN then begin
                                    ELMIN := Item2."Existencia SILLA";
                                end;
                            end;
                        until BOMComponent.Next = 0;
                    if ELMIN = 9999 then begin
                        ELMIN := 0;
                    end;
                    Item."Stock en HAGEN" := ELMIN;
                    Item.Modify;
                    Commit;
                end;
            until Item.Next = 0;
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
                            if Customer.Get('4703') then begin
                                RecMT2.Tabla := 7;
                                RecMT2."Codigo 1" := Item."No.";
                                RecMT2."Codigo 2" := '4703';
                                RecMT2."Actualizar WEB" := true;
                                RecMT2."Eliminar de WEB" := false;
                                RecMT2."Fecha eliminar" := 0D;
                                RecMT2.Insert;
                            end;
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
                                    if Customer.Get(Rec32."Source No.") then begin
                                        RecMT2.Tabla := 7;
                                        RecMT2."Codigo 1" := Item."No.";
                                        RecMT2."Codigo 2" := Rec32."Source No.";
                                        RecMT2."Actualizar WEB" := true;
                                        RecMT2."Eliminar de WEB" := false;
                                        RecMT2."Fecha eliminar" := 0D;
                                        RecMT2.Insert;
                                    end;
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
                        Item3.SetRange(Item3."Location Filter", 'SILLA', 'SILLA');
                        Item3.CalcFields(Item3.Inventory);
                        Item3.SetRange(Item3."Date Filter", DESDE, Today);
                        Item3.CalcFields(Item3."Sales (Qty.)");
                        RecMT2."Stock actual" := Item3.Inventory;
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
                            RecMT2."Bloquear a dias" := RecProve."Lead Time Calculation";
                            diablo := Format(RecMT2."Bloquear a dias");
                            diablo := CopyStr(diablo, 1, StrLen(diablo) - 1);
                            Evaluate(diasprov, diablo)
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



        LOGCAMBIOA := 0;
        InventorySetup.Get;
        Contador := InventorySetup."Log. cambios adaia" + 1;
        LOGCAMBIOA := InventorySetup."Log. cambios adaia" + 1;
        ChangeLogEntry.SetRange("Entry No.", Contador, 999999999999.0);
        ChangeLogEntry.SetFilter("Table No.", '32|37');
        if ChangeLogEntry.FindFirst then
            repeat
                LOGCAMBIOA := ChangeLogEntry."Entry No.";
                if ChangeLogEntry."Table No." = 32 then begin
                    ItemLedgerEntry.Get(ChangeLogEntry."Record ID");
                    CodProd := ItemLedgerEntry."Item No.";
                end;
                if ChangeLogEntry."Table No." = 37 then begin
                    if SalesLine.Get(ChangeLogEntry."Primary Key Field 1 Value", ChangeLogEntry."Primary Key Field 2 Value", ChangeLogEntry."Primary Key Field 3 Value") then begin
                        CodProd := SalesLine."No.";
                    end;
                end;
                Item.Reset;
                if Item.Get(CodProd) then begin
                    Item.SetRange(Item."Location Filter", 'SILLA', 'SILLA');
                    if not Item."Producto NO automatico" then begin
                        Item.CalcFields(Item.Inventory, Item."Qty. on Sales Order");
                        dispo := Item.Inventory - Item."Qty. on Sales Order";
                        if dispo <= 0 then begin
                            Item."No permite pedido" := true;
                        end;
                        if dispo > 0 then begin
                            Item."No permite pedido" := false;
                        end;
                        Item.Modify;
                        PermitePedidos(Item."No.");
                    end;
                end;
            until ChangeLogEntry.Next = 0;

        InventorySetup."Log. cambios adaia" := LOGCAMBIOA;
        InventorySetup.Modify;

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



    local procedure ClasificacionABCProductos()
    var
        ItemAmountTemp: Record "Item Amount" temporary;
        ItemAmount: Record "Item Amount";
        ItemAmount2: Record "Item Amount";
        ItemFilter: Text[250];
        ItemDateFilter: Text[30];
        Sequence: Text[30];
        Heading: Text[30];
        ShowSorting: Option Largest,Smallest;
        ShowType: Option "Sales (LCY)";
        NoOfRecordsToPrint: Integer;
        PrintAlsoIfZero: Boolean;
        ItemSales: Decimal;
        QtyOnHand: Decimal;
        SalesAmountPct: Decimal;
        QtyOnHandPct: Decimal;
        MaxAmount: Decimal;
        BarText: Text[50];
        i: Integer;
        Acumu: Decimal;
        TAcumu: Decimal;
        Tanto: Decimal;
        Clasi: Option A,B,C;
        RecCE: Record "Sales & Receivables Setup";
        TA: Decimal;
        TB: Decimal;
        TC: Decimal;
        Tipo: Option Propuesta,"Guardar datos";
        Rec1: Record "Sales Price";
        pvp: Decimal;
        dato1: Decimal;
        dato2: Decimal;
        CONTA: Integer;
        RecItem: Record Item;
        Tcanti: Decimal;
        tantoa: Decimal;
        tantob: Decimal;
        autXLSerie: Integer;
        intFila: Integer;
        PVMEDIO: Decimal;
        RecSP: Record "Sales Price";
        ROTACION: Decimal;
        DESDEFECHA: Date;
        HASTAFECHA: Date;
        DIAS: Integer;
        XX: Integer;
        CODLETRA: array[60] of Code[10];
        CODMES: array[60] of Date;
        NMES: Integer;
        "NAÑO": Integer;
        FECHAINI: Date;
        RecItem2: Record Item;
        canti: Decimal;
        desdeini: Date;
        hastafin: Date;
        mesescompra: Integer;
        sumatot: Decimal;
        mediamensual: Decimal;
        condetalle: Boolean;
    begin




        RecCE.Get;
        TA := RecCE."% Venta Clasificación A";
        TB := RecCE."% Venta Clasificación B";
        TC := RecCE."% Venta Clasificación C";


        VENTANA.Open('#1##########################################################################################');
        DESDEFECHA := CalcDate('-1A', Today);
        HASTAFECHA := Today;

        TAcumu := 0;

        Item.Reset;
        Item.SetRange("Date Filter", DESDEFECHA, HASTAFECHA);
        if Item.FindFirst then
            repeat
                Item.CalcFields("Cantidad facturada", "Cantidad abonada", "Importe facturado", "Importe abonado", "Cantidad fabricada");
                if (Item."Cantidad fabricada" <> 0) or
                   (Item."Cantidad facturada" <> 0) or
                   (Item."Cantidad abonada" <> 0) or
                   (Item."Importe facturado" <> 0) or
                   (Item."Importe abonado" <> 0) then begin
                    ItemAmountTemp.Init;
                    ItemAmountTemp."Item No." := Item."No.";
                    ItemAmountTemp.Amount := (Item."Importe facturado" + Item."Importe abonado");
                    ItemAmountTemp."Amount 2" := (Item."Cantidad facturada" + Item."Cantidad abonada");
                    ItemAmountTemp.Insert;
                    TAcumu := TAcumu + ItemAmountTemp.Amount;
                    Tcanti := Tcanti + ItemAmountTemp."Amount 2";
                end;
            until Item.Next = 0;


        Acumu := 0;
        tantoa := 0;
        ItemAmountTemp.Reset;
        ItemAmountTemp.SetCurrentkey(Amount, "Amount 2", "Item No.");
        ItemAmountTemp.Ascending(false);
        if ItemAmountTemp.FindFirst then
            repeat
                Tanto := 0;
                RecItem.Get(ItemAmountTemp."Item No.");
                Acumu := Acumu + ItemAmountTemp.Amount;
                if TAcumu <> 0 then begin
                    Tanto := (Acumu * 100) / TAcumu;
                    tantoa := (ItemAmountTemp.Amount * 100) / TAcumu;
                end;

                if Tanto < (TA + TB + TA) then begin
                    Clasi := 2;
                end;
                if (Tanto < TB + TA) then begin
                    Clasi := 1;
                end;
                if (Tanto < TA) then begin
                    Clasi := 0;
                end;

                RecItem."% clasi A,B,C" := tantoa;
                RecItem."Acumu. A,B,C" := Tanto;
                RecItem."Clasificación A,B,C" := Clasi;
                RecItem."Fecha asignada clasificación" := Today;
                RecItem."Importe ABC" := ItemAmountTemp.Amount;
                RecItem."Importe total ABC" := TAcumu;
                RecItem.Modify;
            until ItemAmountTemp.Next = 0;


        VENTANA.Close;
    end;

    local procedure ClasificacionABCCliente()
    var
        ItemAmountTemp: Record "Item Amount" temporary;
        ItemAmount: Record "Item Amount";
        ItemAmount2: Record "Item Amount";
        ItemFilter: Text[250];
        ItemDateFilter: Text[30];
        Sequence: Text[30];
        Heading: Text[30];
        ShowSorting: Option Largest,Smallest;
        ShowType: Option "Sales (LCY)";
        NoOfRecordsToPrint: Integer;
        PrintAlsoIfZero: Boolean;
        ItemSales: Decimal;
        QtyOnHand: Decimal;
        SalesAmountPct: Decimal;
        QtyOnHandPct: Decimal;
        MaxAmount: Decimal;
        BarText: Text[50];
        i: Integer;
        Acumu: Decimal;
        TAcumu: Decimal;
        Tanto: Decimal;
        Clasi: Option A,B,C;
        RecCE: Record "Sales & Receivables Setup";
        TA: Decimal;
        TB: Decimal;
        TC: Decimal;
        Tipo: Option Propuesta,"Guardar datos";
        Rec1: Record "Sales Price";
        pvp: Decimal;
        dato1: Decimal;
        dato2: Decimal;
        CONTA: Integer;
        RecItem: Record Item;
        Tcanti: Decimal;
        tantoa: Decimal;
        tantob: Decimal;
        autXLSerie: Integer;
        intFila: Integer;
        PVMEDIO: Decimal;
        RecSP: Record "Sales Price";
        ROTACION: Decimal;
        DESDEFECHA: Date;
        HASTAFECHA: Date;
        DIAS: Integer;
        XX: Integer;
        CODLETRA: array[60] of Code[10];
        CODMES: array[60] of Date;
        NMES: Integer;
        "NAÑO": Integer;
        FECHAINI: Date;
        RecItem2: Record Item;
        canti: Decimal;
        desdeini: Date;
        hastafin: Date;
        mesescompra: Integer;
        sumatot: Decimal;
        mediamensual: Decimal;
        condetalle: Boolean;
    begin




        RecCE.Get;
        TA := RecCE."% Venta Clasificación A";
        TB := RecCE."% Venta Clasificación B";
        TC := RecCE."% Venta Clasificación C";


        VENTANA.Open('#1##########################################################################################');
        DESDEFECHA := CalcDate('-1A', Today);
        HASTAFECHA := Today;
        Customer.Reset;
        Customer.SetRange("Date Filter", DESDEFECHA, HASTAFECHA);
        if Customer.FindFirst then
            repeat
                Customer.CalcFields(Customer."Inv. Amounts (LCY)", Customer."Cr. Memo Amounts (LCY)");
                ItemAmountTemp.Init;
                ItemAmountTemp."Item No." := Customer."No.";
                ItemAmountTemp.Amount := (Customer."Inv. Amounts (LCY)" - Customer."Cr. Memo Amounts (LCY)");
                ItemAmountTemp.Insert;
                TAcumu := TAcumu + (Customer."Inv. Amounts (LCY)" - Customer."Cr. Memo Amounts (LCY)");
            until Customer.Next = 0;


        Acumu := 0;
        tantoa := 0;
        ItemAmountTemp.Reset;
        ItemAmountTemp.SetCurrentkey(Amount, "Amount 2", "Item No.");
        ItemAmountTemp.Ascending(false);
        if ItemAmountTemp.FindFirst then
            repeat
                Tanto := 0;
                if Customer.Get(ItemAmountTemp."Item No.") then begin
                    Acumu := Acumu + ItemAmountTemp.Amount;
                    if TAcumu <> 0 then begin
                        Tanto := (Acumu * 100) / TAcumu;
                        tantoa := (ItemAmountTemp.Amount * 100) / TAcumu;
                    end;
                end;
                if Tanto < (TA + TB + TA) then begin
                    Clasi := 2;
                end;
                if (Tanto < TB + TA) then begin
                    Clasi := 1;
                end;
                if (Tanto < TA) then begin
                    Clasi := 0;
                end;







                Customer."% clasi A,B,C" := tantoa;
                Customer."Acumu. A,B,C" := Tanto;
                Customer."Clasificación A,B,C Hagen" := Clasi;
                Customer."Fecha clasificación A,B,C" := Today;
                Customer."Importe ABC" := ItemAmountTemp.Amount;
                Customer."Importe total ABC" := TAcumu;
                Customer.Modify;
            until ItemAmountTemp.Next = 0;


        VENTANA.Close;




        /////////77
        /*
        {
             ///// DC00
             SalesLineDiscount2.RESET;
             SalesLineDiscount2.SETRANGE(Type,SalesLineDiscount.Type);
             SalesLineDiscount2.SETRANGE(Code,SalesLineDiscount.Code);
             SalesLineDiscount2.SETRANGE("Sales Type",SalesLineDiscount."Sales Type");
             SalesLineDiscount2.SETRANGE("Sales Code",SalesLineDiscount."Sales Code");
             SalesLineDiscount2.SETRANGE("Starting Date",SalesLineDiscount."Starting Date");
             SalesLineDiscount2.SETRANGE("Currency Code",SalesLineDiscount."Currency Code");
             SalesLineDiscount2.SETRANGE("Variant Code",SalesLineDiscount."Variant Code");
             SalesLineDiscount2.SETRANGE("Unit of Measure Code",SalesLineDiscount."Unit of Measure Code");
             SalesLineDiscount2.SETRANGE("Minimum Quantity",SalesLineDiscount."Minimum Quantity");
             /////Type,Code,Sales Type,Sales Code,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity
             IF NOT SalesLineDiscount2.FINDFIRST THEN BEGIN
                  SalesLineDiscount2.INIT;
                  SalesLineDiscount2.Code:=SalesLineDiscount.Code;
                  SalesLineDiscount2."Sales Type":=SalesLineDiscount."Sales Type";
                  SalesLineDiscount2."Sales Code":=SalesLineDiscount."Sales Code";
                  SalesLineDiscount2."Starting Date":=SalesLineDiscount."Starting Date";
                  SalesLineDiscount2."Currency Code":=SalesLineDiscount."Currency Code";
                  SalesLineDiscount2."Variant Code":=SalesLineDiscount."Variant Code";
                  SalesLineDiscount2."Unit of Measure Code":=SalesLineDiscount."Unit of Measure Code";
                  SalesLineDiscount2."Minimum Quantity":=SalesLineDiscount."Minimum Quantity";
                  SalesLineDiscount2."Ending Date":=SalesLineDiscount."Ending Date";
                  SalesLineDiscount2."Line Discount %":=SalesLineDiscount."Line Discount %";
                  SalesLineDiscount2.INSERT;
             END;
             }
        */

    end;



    local procedure AnulaRestos()
    begin


        DESDE := CalcDate('-3M', Today);
        RecCV2.Reset;
        RecCV2.SetCurrentkey(RecCV2."Document Type", RecCV2."Estado pedido", RecCV2."Fecha alta");
        RecCV2.SetRange(RecCV2."Document Type", 1);
        RecCV2.SetRange(RecCV2."Estado pedido", 3);
        RecCV2.SetRange(RecCV2."Fecha alta", DESDE, Today);
        if RecCV2.FindFirst then
            repeat
                ReleaseSalesDocument.Reopen(RecCV2);
                pendi := 0;
                RecLV.Reset;
                RecLV.SetRange(RecLV."Document Type", RecCV2."Document Type");
                RecLV.SetRange(RecLV."Document No.", RecCV2."No.");
                if RecLV.FindFirst then
                    repeat
                        if (RecLV."Outstanding Quantity" <> 0) then begin
                            pendi := pendi + RecLV."Outstanding Amount";
                        end;
                    until RecLV.Next = 0;
                if pendi > 0 then begin
                    RecCV2."Anula restos" := true;
                    RecCV2.Modify;
                    Rec37.Reset;
                    Rec37.SetRange(Rec37."Document Type", RecCV2."Document Type");
                    Rec37.SetRange(Rec37."Document No.", RecCV2."No.");
                    if Rec37.FindFirst then
                        repeat
                            if Rec37."Outstanding Quantity" <> 0 then begin
                                eprecio := Rec37."Unit Price";
                                edto := Rec37."Line Discount %";
                                Rec37."Cantidad anulada" := Rec37."Outstanding Quantity";
                                Rec37.Validate(Rec37.Quantity, Rec37."Quantity Shipped");
                                Rec37.Validate(Rec37."Unit Price", eprecio);
                                Rec37.Validate(Rec37."Line Discount %", edto);

                                /*

                                   Rec37."Outstanding Quantity":=0;
                                   Rec37."Outstanding Qty. (Base)":=0;
                                   Rec37."Qty. to Ship (Base)":=0;
                                   Rec37."Qty. to Ship":=0;
                                   Rec37."Qty. to Invoice":=0;
                                   Rec37."Qty. to Invoice (Base)":=0;
                                   Rec37."Qty. to Invoice":=0;
                                   Rec37."Qty. Shipped Not Invoiced":=0;
                                   Rec37."Shipped Not Invoiced":=0;
                                   Rec37."Quantity Invoiced":=Rec37."Quantity Shipped";
                                   Rec37."Shipped Not Invoiced (LCY)":=0;
                                   Rec37."Qty. to Invoice (Base)":=0;
                                   Rec37."Qty. Shipped Not Invd. (Base)":=0;
                                   Rec37."Qty. Invoiced (Base)":=Rec37."Qty. Shipped (Base)";
                                   Rec37."Outstanding Amount":=0;
                                   Rec37."Outstanding Amount (LCY)":=0;
                                   */

                                Rec37.Modify;
                            end;
                        until Rec37.Next = 0;
                end;
            until RecCV2.Next = 0;

    end;



    procedure PermitirPedidos()
    begin




        VENTANA2.Open('Permitir pedido #1#######################################');

        DESDE := CalcDate('-6M', Today);
        diascompara := Today - DESDE;

        RecMT2.Reset;
        RecMT2.SetRange(RecMT2.Tabla, 1);
        if RecMT2.FindSet then
            repeat
                VENTANA2.Update(1, RecMT2."Codigo 1");
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
                if RecItem2.Get(RecMT2."Codigo 1") then begin
                    RecItem2."Producto con reserva" := false;
                    RecItem2.Modify;
                end;

            until RecMT2.Next = 0;

        RecMT2.Reset;
        RecMT2.SetRange(RecMT2.Tabla, 1);
        if RecMT2.FindSet then
            repeat
                VENTANA2.Update(1, RecMT2."Codigo 1");
                if RecItem.Get(RecMT2."Codigo 1") then begin
                    if not RecItem."Producto NO automatico" then begin
                        cantidadPVta := 0;
                        ///RecItem.SETRANGE(RecItem."Location Filter",'SILLA','SILLA');
                        RecItem.CalcFields(Inventory, "Existencia FOB", "Qty. on Sales Order");
                        RecItem.SetRange(RecItem."Date Filter", DESDE, Today);
                        RecItem.CalcFields(RecItem."Sales (Qty.)");
                        RecMT2."Stock actual" := RecItem.Inventory - RecItem."Stock para Catit" - RecItem."Existencia FOB";
                        RecLV.Reset;
                        RecLV.SetRange(RecLV."Document Type", 1);
                        RecLV.SetRange(RecLV."No.", RecMT2."Codigo 1");
                        if RecLV.FindFirst then
                            repeat
                                cantidadPVta := cantidadPVta + RecLV."Outstanding Quantity";
                            until RecLV.Next = 0;
                        RecMT2."Venta global" := RecItem."Sales (Qty.)" + cantidadPVta;
                        primera := true;
                        RecLC.Reset;
                        RecLC.SetCurrentkey(RecLC."Document Type", RecLC.Type, RecLC."No.");
                        RecLC.SetRange(RecLC."Document Type", 1);
                        RecLC.SetRange(RecLC.Type, 2);
                        RecLC.SetRange(RecLC."No.", RecItem."No.");
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
                        if not RecLC.FindSet then begin
                            RecLC.Reset;
                            RecLC.SetCurrentkey(RecLC."Document Type", RecLC.Type, RecLC."No.");
                            RecLC.SetRange(RecLC."Document Type", 0);
                            RecLC.SetRange(RecLC.Type, 2);
                            RecLC.SetRange(RecLC."No.", RecItem."No.");
                            RecLC.SetRange(RecLC."Outstanding Quantity", 1, 9999999999.0);
                            RecLC.SetRange(RecLC."Oferta para permite pedido", true);
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

                        end;
                        suma := 0;
                        RecClie.Reset;
                        RecClie.SetRange(RecClie."Grupo clientes", RecMT2."Codigo 2");
                        if RecClie.FindSet then
                            repeat
                                Rec32.Reset;
                                Rec32.SetCurrentkey(Rec32."Item No.", Rec32."Posting Date", Rec32."Source No.", Rec32."Source Type");
                                Rec32.SetRange(Rec32."Item No.", RecMT2."Codigo 1");
                                Rec32.SetRange(Rec32."Posting Date", DESDE, Today);
                                Rec32.SetRange(Rec32."Source No.", RecClie."No.");
                                Rec32.SetRange(Rec32."Entry Type", 1);
                                if Rec32.FindSet then
                                    repeat
                                        suma := suma + Rec32.Quantity * -1;
                                    until Rec32.Next = 0;
                                RecLV.Reset;
                                RecLV.SetRange(RecLV."Document Type", 1);
                                RecLV.SetRange(RecLV."No.", RecMT2."Codigo 1");
                                RecLV.SetRange(RecLV."Sell-to Customer No.", RecClie."No.");
                                if RecLV.FindFirst then
                                    repeat
                                        suma := suma + RecLV."Outstanding Quantity";
                                    until RecLV.Next = 0;
                            until RecClie.Next = 0;





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
                        RecMT2."Proveedor ref." := RecItem."Vendor No.";
                        RecMT2."Cantidad en pedido" := cantidadPVta;
                        DIASPARALLEGADA := 0;
                        if RecMT2."Fecha pedido contenedor" <> 0D then begin
                            DIASPARALLEGADA := RecMT2."Fecha pedido contenedor" - Today;
                            RecMT2."Dias para llegada" := DIASPARALLEGADA;
                        end;
                        if RecProve.Get(RecItem."Vendor No.") then begin
                            RecMT2."Bloquear a dias" := RecProve."Lead Time Calculation";
                            diablo := Format(RecMT2."Bloquear a dias");
                            diablo := CopyStr(diablo, 1, StrLen(diablo) - 1);
                            Evaluate(diasprov, diablo)
                        end;
                        if RecMT2."Para dias grupos" <> 0 then begin
                            if (DIASPARALLEGADA + RecMT2."Para dias grupos") < diasprov then begin
                                RecMT2.Reservar := true;
                                if RecItem2.Get(RecMT2."Codigo 1") then begin
                                    RecItem2."Producto con reserva" := true;
                                    RecItem2.Modify;
                                end;
                            end;
                        end;
                        RecMT2."Venta de contenedor" := RecMT2."Venta diaria general" * DIASPARALLEGADA;
                        if RecMT2."Venta de contenedor" < RecMT2."Pedido contenedor" then begin
                            RecMT2.Reservar := false;
                            if RecItem2.Get(RecMT2."Codigo 1") then begin
                                RecItem2."Producto con reserva" := false;
                                RecItem2.Modify;
                            end;
                        end;
                        RecMT2.Modify;
                    end;
                end;
            until RecMT2.Next = 0;

        VENTANA2.Close;
    end;

    local procedure RecalculaTopCliente()
    begin

        VENTANA.Open('#1##################################');

        DESDE := CalcDate('-1A', Today);


        RecClie.Reset;
        if RecClie.FindSet then
            repeat
                VENTANA.Update(1, RecClie."No.");
                ItemAmount.Reset;
                if ItemAmount.FindFirst then
                    repeat
                        ItemAmount.Delete;
                    until ItemAmount.Next = 0;
                SalesInvoiceLine.Reset;
                SalesInvoiceLine.SetRange("Sell-to Customer No.", RecClie."No.");
                SalesInvoiceLine.SetRange("Posting Date", DESDE, Today);
                if SalesInvoiceLine.FindFirst then
                    repeat
                        if ItemTMP.Get(SalesInvoiceLine."No.") then begin
                            ItemTMP."Unit Price" := ItemTMP."Unit Price" + SalesInvoiceLine.Amount;
                            ItemTMP.Modify;
                        end;
                        if not ItemTMP.Get(SalesInvoiceLine."No.") then begin
                            ItemTMP.Init;
                            ItemTMP."No." := SalesInvoiceLine."No.";
                            ItemTMP."Unit Price" := SalesInvoiceLine.Amount;
                            ItemTMP.Insert;
                        end;
                    until SalesInvoiceLine.Next = 0;

                SalesCrMemoLine.Reset;
                SalesCrMemoLine.SetRange("Sell-to Customer No.", RecClie."No.");
                SalesCrMemoLine.SetRange("Posting Date", DESDE, Today);
                if SalesCrMemoLine.FindFirst then
                    repeat
                        if ItemTMP.Get(SalesCrMemoLine."No.") then begin
                            ItemTMP."Unit Price" := ItemTMP."Unit Price" + SalesCrMemoLine.Amount * -1;
                            ItemTMP.Modify;
                        end;
                        if not ItemTMP.Get(SalesCrMemoLine."No.") then begin
                            ItemTMP.Init;
                            ItemTMP."No." := SalesCrMemoLine."No.";
                            ItemTMP."Unit Price" := SalesCrMemoLine.Amount * -1;
                            ItemTMP.Insert;
                        end;
                    until SalesCrMemoLine.Next = 0;
                ItemTMP.Reset;
                if ItemTMP.FindSet then
                    repeat
                        ItemAmount.Init;
                        ItemAmount."Item No." := ItemTMP."No.";
                        ItemAmount.Amount := ItemTMP."Unit Price";
                        ItemAmount.Insert;

                    until ItemTMP.Next = 0;

                i := 0;
                ItemAmount.Reset;
                ItemAmount.Ascending(false);
                if ItemAmount.FindFirst then
                    repeat
                        i := i + 1;
                        if i = 1 then RecClie."Top produccto 1" := ItemAmount."Item No.";
                        if i = 2 then RecClie."Top produccto 2" := ItemAmount."Item No.";
                        if i = 3 then RecClie."Top produccto 3" := ItemAmount."Item No.";
                        if i = 4 then RecClie."Top produccto 4" := ItemAmount."Item No.";
                        if i = 5 then RecClie."Top produccto 5" := ItemAmount."Item No.";
                        if i = 6 then RecClie."Top produccto 6" := ItemAmount."Item No.";
                        if i = 7 then RecClie."Top produccto 7" := ItemAmount."Item No.";
                        if i = 8 then RecClie."Top produccto 8" := ItemAmount."Item No.";
                        if i = 9 then RecClie."Top produccto 9" := ItemAmount."Item No.";
                        if i = 10 then RecClie."Top produccto 10" := ItemAmount."Item No.";
                        RecClie.Modify;
                    until (ItemAmount.Next = 0) or (i = 10);


            until RecClie.Next = 0;


        VENTANA.Close;
    end;

    local procedure RecalculaTopFamilia()
    begin

        VENTANA.Open('#1##################################');

        DESDE := CalcDate('-1A', Today);


        RecClie.Reset;
        //////RecClie.SETRANGE("No.",'6000');
        if RecClie.FindSet then
            repeat
                VENTANA.Update(1, RecClie."No.");
                ItemAmount.Reset;
                if ItemAmount.FindFirst then
                    repeat
                        ItemAmount.Delete;
                    until ItemAmount.Next = 0;
                SalesInvoiceLine.Reset;
                SalesInvoiceLine.SetRange("Sell-to Customer No.", RecClie."No.");
                SalesInvoiceLine.SetRange("Posting Date", DESDE, Today);
                if SalesInvoiceLine.FindFirst then
                    repeat
                        if SalesInvoiceLine."Gen. Prod. Posting Group" = 'ESTANQUES' then begin
                            SalesInvoiceLine."Gen. Prod. Posting Group" := 'ACUARIOFIL'
                        end;
                        if GenProductPostingGroupTMP.Get(SalesInvoiceLine."Gen. Prod. Posting Group") then begin
                            GenProductPostingGroupTMP.Importe := GenProductPostingGroupTMP.Importe + SalesInvoiceLine.Amount;
                            GenProductPostingGroupTMP.Modify;
                        end;
                        if not GenProductPostingGroupTMP.Get(SalesInvoiceLine."Gen. Prod. Posting Group") then begin
                            GenProductPostingGroupTMP.Init;
                            GenProductPostingGroupTMP.Code := SalesInvoiceLine."Gen. Prod. Posting Group";
                            GenProductPostingGroupTMP.Importe := SalesInvoiceLine.Amount;
                            GenProductPostingGroupTMP.Insert;
                        end;
                    until SalesInvoiceLine.Next = 0;

                SalesCrMemoLine.Reset;
                SalesCrMemoLine.SetRange("Sell-to Customer No.", RecClie."No.");
                SalesCrMemoLine.SetRange("Posting Date", DESDE, Today);
                if SalesCrMemoLine.FindFirst then
                    repeat
                        if SalesCrMemoLine."Gen. Prod. Posting Group" = 'ESTANQUES' then begin
                            SalesCrMemoLine."Gen. Prod. Posting Group" := 'ACUARIOFIL'
                        end;
                        if GenProductPostingGroupTMP.Get(SalesCrMemoLine."No.") then begin
                            GenProductPostingGroupTMP.Importe := GenProductPostingGroupTMP.Importe + SalesCrMemoLine.Amount * -1;
                            GenProductPostingGroupTMP.Modify;
                        end;
                        if not GenProductPostingGroupTMP.Get(SalesCrMemoLine."Gen. Prod. Posting Group") then begin
                            GenProductPostingGroupTMP.Init;
                            GenProductPostingGroupTMP.Code := SalesCrMemoLine."Gen. Prod. Posting Group";
                            GenProductPostingGroupTMP.Importe := SalesCrMemoLine.Amount * -1;
                            GenProductPostingGroupTMP.Insert;
                        end;
                    until SalesCrMemoLine.Next = 0;
                sumatodo := 0;
                GenProductPostingGroupTMP.Reset;
                if GenProductPostingGroupTMP.FindSet then
                    repeat
                        ItemAmount.Init;
                        ItemAmount."Item No." := GenProductPostingGroupTMP.Code;
                        ItemAmount.Amount := GenProductPostingGroupTMP.Importe;
                        sumatodo := sumatodo + GenProductPostingGroupTMP.Importe;
                        ItemAmount.Insert;
                    until GenProductPostingGroupTMP.Next = 0;


                ItemAmount.Reset;
                ItemAmount.Ascending(false);
                if ItemAmount.FindFirst then
                    repeat
                        if ItemAmount."Item No." = 'ACUARIOFIL' then begin
                            TANTO := ROUND((ItemAmount.Amount * 100 / sumatodo), 0.01);
                            RecClie."Vta. Acuariofilia" := TANTO;
                        end;
                        if ItemAmount."Item No." = 'GATOS' then begin
                            TANTO := ROUND((ItemAmount.Amount * 100 / sumatodo), 0.01);
                            RecClie."Vta.Gatos" := TANTO;
                        end;
                        if ItemAmount."Item No." = 'PAJAROS' then begin
                            TANTO := ROUND((ItemAmount.Amount * 100 / sumatodo), 0.01);
                            RecClie."Vta.Pajaros" := TANTO;
                        end;
                        if ItemAmount."Item No." = 'PERROS' then begin
                            TANTO := ROUND((ItemAmount.Amount * 100 / sumatodo), 0.01);
                            RecClie."Vta.Perro" := TANTO;
                        end;
                        if ItemAmount."Item No." = 'REPTILES' then begin
                            TANTO := ROUND((ItemAmount.Amount * 100 / sumatodo), 0.01);
                            RecClie."Vta.Reptiles" := TANTO;
                        end;
                        if ItemAmount."Item No." = 'ROEDORES' then begin
                            TANTO := ROUND((ItemAmount.Amount * 100 / sumatodo), 0.01);
                            RecClie."Vta.Roedores" := TANTO;
                        end;
                        RecClie.Modify;
                    until (ItemAmount.Next = 0);


            until RecClie.Next = 0;


        VENTANA.Close;
    end;

    local procedure ClasificacionABCVendedor()
    var
        ItemAmountTemp: Record "Item Amount" temporary;
        ItemAmount: Record "Item Amount";
        ItemAmount2: Record "Item Amount";
        ItemFilter: Text[250];
        ItemDateFilter: Text[30];
        Sequence: Text[30];
        Heading: Text[30];
        ShowSorting: Option Largest,Smallest;
        ShowType: Option "Sales (LCY)";
        NoOfRecordsToPrint: Integer;
        PrintAlsoIfZero: Boolean;
        ItemSales: Decimal;
        QtyOnHand: Decimal;
        SalesAmountPct: Decimal;
        QtyOnHandPct: Decimal;
        MaxAmount: Decimal;
        BarText: Text[50];
        i: Integer;
        Acumu: Decimal;
        TAcumu: Decimal;
        Tanto: Decimal;
        Clasi: Option A,B,C;
        RecCE: Record "Sales & Receivables Setup";
        TA: Decimal;
        TB: Decimal;
        TC: Decimal;
        Tipo: Option Propuesta,"Guardar datos";
        Rec1: Record "Sales Price";
        pvp: Decimal;
        dato1: Decimal;
        dato2: Decimal;
        CONTA: Integer;
        RecItem: Record Item;
        Tcanti: Decimal;
        tantoa: Decimal;
        tantob: Decimal;
        autXLSerie: Integer;
        intFila: Integer;
        PVMEDIO: Decimal;
        RecSP: Record "Sales Price";
        ROTACION: Decimal;
        DESDEFECHA: Date;
        HASTAFECHA: Date;
        DIAS: Integer;
        XX: Integer;
        CODLETRA: array[60] of Code[10];
        CODMES: array[60] of Date;
        NMES: Integer;
        "NAÑO": Integer;
        FECHAINI: Date;
        RecItem2: Record Item;
        canti: Decimal;
        desdeini: Date;
        hastafin: Date;
        mesescompra: Integer;
        sumatot: Decimal;
        mediamensual: Decimal;
        condetalle: Boolean;
    begin




        RecCE.Get;
        TA := RecCE."% Venta Clasificación A";
        TB := RecCE."% Venta Clasificación B";
        TC := RecCE."% Venta Clasificación C";


        VENTANA.Open('#1##########################################################################################');
        DESDEFECHA := CalcDate('-1A', Today);
        HASTAFECHA := Today;

        SalespersonPurchaser.Reset;
        if SalespersonPurchaser.FindSet then
            repeat
                TAcumu := 0;
                ItemAmountTemp.Reset;
                if ItemAmountTemp.FindFirst then
                    repeat
                        ItemAmountTemp.Delete;
                    until ItemAmountTemp.Next = 0;

                Customer.Reset;
                Customer.SetRange("Date Filter", DESDEFECHA, HASTAFECHA);
                Customer.SetRange("Salesperson Code", SalespersonPurchaser.Code);
                if Customer.FindFirst then
                    repeat
                        Customer.CalcFields(Customer."Inv. Amounts (LCY)", Customer."Cr. Memo Amounts (LCY)");
                        ItemAmountTemp.Init;
                        ItemAmountTemp."Item No." := Customer."No.";
                        ItemAmountTemp.Amount := (Customer."Inv. Amounts (LCY)" - Customer."Cr. Memo Amounts (LCY)");
                        ItemAmountTemp.Insert;
                        TAcumu := TAcumu + (Customer."Inv. Amounts (LCY)" - Customer."Cr. Memo Amounts (LCY)");
                    until Customer.Next = 0;
                Acumu := 0;
                tantoa := 0;
                ItemAmountTemp.Reset;
                ItemAmountTemp.SetCurrentkey(Amount, "Amount 2", "Item No.");
                ItemAmountTemp.Ascending(false);
                if ItemAmountTemp.FindFirst then
                    repeat
                        Tanto := 0;
                        if Customer.Get(ItemAmountTemp."Item No.") then begin
                            Acumu := Acumu + ItemAmountTemp.Amount;
                            if TAcumu <> 0 then begin
                                Tanto := (Acumu * 100) / TAcumu;
                                tantoa := (ItemAmountTemp.Amount * 100) / TAcumu;
                            end;
                        end;

                        if Tanto < (TA + TB + TA) then begin
                            Clasi := 2;
                        end;
                        if (Tanto < TB + TA) then begin
                            Clasi := 1;
                        end;
                        if (Tanto < TA) then begin
                            Clasi := 0;
                        end;





                        Customer."% clasi A,B,C vendedor" := tantoa;
                        Customer."Acumu. A,B,C vendedor" := Tanto;
                        Customer."Clasificación A,B,C Vendedor" := Clasi;
                        Customer."Fecha Clasi. A,B,C Vendedor" := Today;
                        Customer."Importe ABC vendedor" := ItemAmountTemp.Amount;
                        Customer."Importe total ABC vendedor" := TAcumu;
                        Customer.Modify;
                    until ItemAmountTemp.Next = 0;

            until SalespersonPurchaser.Next = 0;


        VENTANA.Close;




        /////////77
        /*
        {
             ///// DC00
             SalesLineDiscount2.RESET;
             SalesLineDiscount2.SETRANGE(Type,SalesLineDiscount.Type);
             SalesLineDiscount2.SETRANGE(Code,SalesLineDiscount.Code);
             SalesLineDiscount2.SETRANGE("Sales Type",SalesLineDiscount."Sales Type");
             SalesLineDiscount2.SETRANGE("Sales Code",SalesLineDiscount."Sales Code");
             SalesLineDiscount2.SETRANGE("Starting Date",SalesLineDiscount."Starting Date");
             SalesLineDiscount2.SETRANGE("Currency Code",SalesLineDiscount."Currency Code");
             SalesLineDiscount2.SETRANGE("Variant Code",SalesLineDiscount."Variant Code");
             SalesLineDiscount2.SETRANGE("Unit of Measure Code",SalesLineDiscount."Unit of Measure Code");
             SalesLineDiscount2.SETRANGE("Minimum Quantity",SalesLineDiscount."Minimum Quantity");
             /////Type,Code,Sales Type,Sales Code,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity
             IF NOT SalesLineDiscount2.FINDFIRST THEN BEGIN
                  SalesLineDiscount2.INIT;
                  SalesLineDiscount2.Code:=SalesLineDiscount.Code;
                  SalesLineDiscount2."Sales Type":=SalesLineDiscount."Sales Type";
                  SalesLineDiscount2."Sales Code":=SalesLineDiscount."Sales Code";
                  SalesLineDiscount2."Starting Date":=SalesLineDiscount."Starting Date";
                  SalesLineDiscount2."Currency Code":=SalesLineDiscount."Currency Code";
                  SalesLineDiscount2."Variant Code":=SalesLineDiscount."Variant Code";
                  SalesLineDiscount2."Unit of Measure Code":=SalesLineDiscount."Unit of Measure Code";
                  SalesLineDiscount2."Minimum Quantity":=SalesLineDiscount."Minimum Quantity";
                  SalesLineDiscount2."Ending Date":=SalesLineDiscount."Ending Date";
                  SalesLineDiscount2."Line Discount %":=SalesLineDiscount."Line Discount %";
                  SalesLineDiscount2.INSERT;
             END;
             }
        */

    end;

    local procedure FechaDispoWeb()
    begin






        Item.Reset;
        if Item.FindSet then
            repeat
                FECHARECEP := 0D;
                if (Item."No permite pedido") or (Item."Producto con reserva") then begin
                    Rec39.Reset;
                    Rec39.SetCurrentkey(Rec39."Document Type", Rec39."No.");
                    Rec39.SetRange(Rec39."Document Type", 1);
                    Rec39.SetRange(Rec39."No.", Item."No.");
                    Rec39.SetFilter(Rec39."Outstanding Quantity", '<>0');
                    if Rec39.FindFirst then begin
                        Rec38.Get(Rec39."Document Type", Rec39."Document No.");
                        FECHARECEP := Rec38."E.T.Arrival";
                        FECHARECEP := Rec39."Expected Receipt Date";
                    end;
                    if FECHARECEP = 0D then begin
                        Rec39.Reset;
                        Rec39.SetCurrentkey(Rec39."Document Type", Rec39."No.");
                        Rec39.SetRange(Rec39."Document Type", 0);
                        Rec39.SetRange(Rec39."No.", Item."No.");
                        Rec39.SetFilter(Rec39."Outstanding Quantity", '<>0');
                        if Rec39.FindFirst then begin
                            Rec38.Get(Rec39."Document Type", Rec39."Document No.");
                            FECHARECEP := Rec38."Expected Receipt Date";
                            FECHARECEP := Rec39."Expected Receipt Date";
                        end;
                    end;
                    Item."Stock para la web" := 0;
                end;
                if (Item."No permite pedido" = false) and (Item."Producto con reserva" = false) then begin
                    Item.CalcFields("Existencia SILLA", Item."Qty. on Sales Order");
                    Item."Stock para la web" := Item."Existencia SILLA" - Item."Qty. on Sales Order" + Item."Cantidad colchon web";
                end;
                Item.CalcFields("Assembly BOM");
                if (Item."Producto almacenable" = false) and (Item."Assembly BOM") then begin
                    ELMIN := 9999;
                    BOMComponent.Reset;
                    BOMComponent.SetRange(BOMComponent."Parent Item No.", Item."No.");
                    if BOMComponent.FindSet then
                        repeat
                            if Item2.Get(BOMComponent."No.") then begin
                                Item2.CalcFields(Item2."Existencia SILLA");
                                if Item2."Existencia SILLA" <= ELMIN then begin
                                    ELMIN := Item2."Existencia SILLA";
                                end;
                            end;
                        until BOMComponent.Next = 0;
                    if ELMIN = 9999 then begin
                        ELMIN := 0;
                    end;
                    Item."Stock para la web" := ELMIN;
                end;

                Item."Fecha disponible Web" := FECHARECEP;
                Item."Fecha en picking" := 0D;
                Multitabla.Reset;
                Multitabla.SetRange(Tabla, Multitabla.Tabla::Ubicaciones);
                Multitabla.SetRange(Multitabla.Producto, Item."No.");
                if Multitabla.FindFirst then
                    repeat
                        L1 := StrLen(Multitabla.Ubicacion);
                        if (CopyStr(Multitabla.Ubicacion, 1, 3) = '010') and
                           ((CopyStr(Multitabla.Ubicacion, L1 - 1, 2) = '01') or
                            (CopyStr(Multitabla.Ubicacion, L1 - 1, 2) = '02')) then begin
                            Item."Fecha en picking" := Multitabla."Fecha caducidad";
                        end;
                    until Multitabla.Next = 0;




                Item.Modify;
            until Item.Next = 0;
    end;

    local procedure ActualizaEstadoWeb()
    begin
    end;

    local procedure EliminaMarcaFechaProhibidoAmazon()
    begin

        Item.Reset;
        Item.SetRange("Prohibido Amazon", true);
        if Item.FindSet then
            repeat
                if (Item."Fecha prohibido Amazon" < Today) then begin
                    Item."Prohibido Amazon" := false;
                    Item.Modify;
                end;
            until Item.Next = 0;

        Commit;
    end;

    procedure MarcarcomonoexcelAMAZON(var Rec111: Record "Sales Shipment Line");

    var
        SalesShipmentLine: Record "Sales Shipment Line";

    begin

        SalesShipmentLine.get(rec111."Document No.", rec111."Line No.");
        SalesShipmentLine."Excluir del exel amazon" := TRUE;
        SalesShipmentLine.MODIFY;
        Message('Hecho.');

    end;

    procedure DesmarcarcomonoexcelAMAZON(var Rec111: Record "Sales Shipment Line");

    var
        SalesShipmentLine: Record "Sales Shipment Line";

    begin

        SalesShipmentLine.get(rec111."Document No.", rec111."Line No.");
        SalesShipmentLine."Excluir del exel amazon" := false;
        SalesShipmentLine.MODIFY;
        Message('Hecho.');

    end;

    procedure MarcarcomonoexcelAMAZONSINMENSAJE(var Rec111: Record "Sales Shipment Line");

    var
        SalesShipmentLine: Record "Sales Shipment Line";

    begin

        SalesShipmentLine.get(rec111."Document No.", rec111."Line No.");
        SalesShipmentLine."Excluir del exel amazon" := TRUE;
        SalesShipmentLine.MODIFY;

    end;

    procedure DesmarcarcomonoexcelAMAZONSINMENSAJE(var Rec111: Record "Sales Shipment Line");

    var
        SalesShipmentLine: Record "Sales Shipment Line";

    begin

        SalesShipmentLine.get(rec111."Document No.", rec111."Line No.");
        SalesShipmentLine."Excluir del exel amazon" := false;
        SalesShipmentLine.MODIFY;


    end;


    /*
    
VENTANA.OPEN('#1###################');


SalesLineDiscountPadre.RESET;
SalesLineDiscountPadre.SETRANGE("Sales Code",'DC00');
IF SalesLineDiscountPadre.FINDSET THEN REPEAT
   SalesLineDiscount2.RESET;
   SalesLineDiscount2.SETRANGE(Type,SalesLineDiscountPadre.Type);
   SalesLineDiscount2.SETRANGE(Code,SalesLineDiscountPadre.Code);
   SalesLineDiscount2.SETRANGE("Sales Type",SalesLineDiscountPadre."Sales Type");
   SalesLineDiscount2.SETRANGE("Sales Code",SalesLineDiscountPadre."Sales Code");
   IF SalesLineDiscount2.FINDFIRST THEN REPEAT
        IF SalesLineDiscount2.Promocion=FALSE THEN BEGIN
             SalesLineDiscount2.DELETE;
        END;
        VENTANA.UPDATE(1,'B1-'+SalesLineDiscount2.Code);
   UNTIL SalesLineDiscount2.NEXT=0;   
     CustomerDiscountGroup.RESET;
     CustomerDiscountGroup.SETRANGE(CustomerDiscountGroup."Descuento %",1,SalesLineDiscountPadre."Line Discount %");
     IF CustomerDiscountGroup.FINDSET THEN REPEAT
          IF CustomerDiscountGroup."Descuento %"<>0 THEN BEGIN
               SalesLineDiscount2.RESET;
               SalesLineDiscount2.SETRANGE(Type,SalesLineDiscountPadre.Type);
               SalesLineDiscount2.SETRANGE(Code,SalesLineDiscountPadre.Code);
               SalesLineDiscount2.SETRANGE("Sales Type",SalesLineDiscountPadre."Sales Type");
               SalesLineDiscount2.SETRANGE("Sales Code",CustomerDiscountGroup.Code);
               IF SalesLineDiscount2.FINDFIRST THEN REPEAT
                    IF SalesLineDiscount2.Promocion=FALSE THEN BEGIN
                         SalesLineDiscount2.DELETE;
                    END;
                    VENTANA.UPDATE(1,'B1-'+SalesLineDiscount2.Code);
               UNTIL SalesLineDiscount2.NEXT=0;                           
          END;
     UNTIL CustomerDiscountGroup.NEXT=0;
     CustomerDiscountGroup.RESET;
     CustomerDiscountGroup.SETFILTER(CustomerDiscountGroup."Descuento % especial",'<>0');
     IF CustomerDiscountGroup.FINDSET THEN REPEAT
          SalesLineDiscount2.RESET;
          SalesLineDiscount2.SETRANGE(Type,SalesLineDiscountPadre.Type);
          SalesLineDiscount2.SETRANGE(Code,SalesLineDiscountPadre.Code);
          SalesLineDiscount2.SETRANGE("Sales Type",SalesLineDiscountPadre."Sales Type");
          SalesLineDiscount2.SETRANGE("Sales Code",CustomerDiscountGroup.Code);
          IF SalesLineDiscount2.FINDFIRST THEN REPEAT
               IF SalesLineDiscount2.Promocion=FALSE THEN BEGIN
                    SalesLineDiscount2.DELETE;
               END;
               VENTANA.UPDATE(1,'B2-'+SalesLineDiscount2.Code);
          UNTIL SalesLineDiscount2.NEXT=0;                                                            
     UNTIL CustomerDiscountGroup.NEXT=0;
UNTIL SalesLineDiscountPadre.NEXT=0;





SalesLineDiscountPadre.RESET;
SalesLineDiscountPadre.SETRANGE("Sales Code",'DC00');
IF SalesLineDiscountPadre.FINDSET THEN REPEAT
     CustomerDiscountGroup.RESET;
     CustomerDiscountGroup.SETRANGE(CustomerDiscountGroup."Descuento %",1,SalesLineDiscountPadre."Line Discount %");
     IF CustomerDiscountGroup.FINDSET THEN REPEAT
          IF CustomerDiscountGroup."Descuento %"<>0 THEN BEGIN
               SalesLineDiscount2.RESET;
               SalesLineDiscount2.SETRANGE(Type,SalesLineDiscountPadre.Type);
               SalesLineDiscount2.SETRANGE(Code,SalesLineDiscountPadre.Code);
               SalesLineDiscount2.SETRANGE("Sales Type",SalesLineDiscountPadre."Sales Type");
               SalesLineDiscount2.SETRANGE("Sales Code",CustomerDiscountGroup.Code);
               SalesLineDiscount2.SETRANGE("Starting Date",SalesLineDiscountPadre."Starting Date");
               SalesLineDiscount2.SETRANGE("Currency Code",SalesLineDiscountPadre."Currency Code");
               SalesLineDiscount2.SETRANGE("Variant Code",SalesLineDiscountPadre."Variant Code");
               SalesLineDiscount2.SETRANGE("Unit of Measure Code",SalesLineDiscountPadre."Unit of Measure Code");
               SalesLineDiscount2.SETRANGE("Minimum Quantity",SalesLineDiscountPadre."Minimum Quantity");      
               IF NOT SalesLineDiscount2.FINDFIRST THEN BEGIN
                    SalesLineDiscount2.INIT;
                    SalesLineDiscount2.Code:=SalesLineDiscountPadre.Code;
                    SalesLineDiscount2."Sales Type":=SalesLineDiscountPadre."Sales Type";
                    SalesLineDiscount2."Sales Code":=CustomerDiscountGroup.Code;
                    SalesLineDiscount2."Starting Date":=SalesLineDiscountPadre."Starting Date";
                    SalesLineDiscount2."Currency Code":=SalesLineDiscountPadre."Currency Code";
                    SalesLineDiscount2."Variant Code":=SalesLineDiscountPadre."Variant Code";
                    SalesLineDiscount2."Unit of Measure Code":=SalesLineDiscountPadre."Unit of Measure Code";
                    SalesLineDiscount2."Minimum Quantity":=SalesLineDiscountPadre."Minimum Quantity";
                    SalesLineDiscount2."Ending Date":=SalesLineDiscountPadre."Ending Date";
                    SalesLineDiscount2."Line Discount %":=SalesLineDiscountPadre."Line Discount %";
                    SalesLineDiscount2."Fecha alta":=CREATEDATETIME(TODAY,TIME);
                    SalesLineDiscount2.INSERT;
                    VENTANA.UPDATE(1,'A1'+SalesLineDiscount2.Code);
               END;                           
               SalesLineDiscount2.RESET;
               SalesLineDiscount2.SETRANGE(Type,SalesLineDiscountPadre.Type);
               SalesLineDiscount2.SETRANGE(Code,SalesLineDiscountPadre.Code);
               SalesLineDiscount2.SETRANGE("Sales Type",SalesLineDiscountPadre."Sales Type");
               SalesLineDiscount2.SETRANGE("Sales Code",CustomerDiscountGroup.Code);
               SalesLineDiscount2.SETRANGE("Starting Date",SalesLineDiscountPadre."Starting Date");
               SalesLineDiscount2.SETRANGE("Currency Code",SalesLineDiscountPadre."Currency Code");
               SalesLineDiscount2.SETRANGE("Variant Code",SalesLineDiscountPadre."Variant Code");
               SalesLineDiscount2.SETRANGE("Unit of Measure Code",SalesLineDiscountPadre."Unit of Measure Code");
               SalesLineDiscount2.SETRANGE("Minimum Quantity",1);      
               IF NOT SalesLineDiscount2.FINDFIRST THEN BEGIN
                    SalesLineDiscount2.INIT;
                    SalesLineDiscount2.Code:=SalesLineDiscountPadre.Code;
                    SalesLineDiscount2."Sales Type":=SalesLineDiscountPadre."Sales Type";
                    SalesLineDiscount2."Sales Code":=CustomerDiscountGroup.Code;
                    SalesLineDiscount2."Starting Date":=SalesLineDiscountPadre."Starting Date";
                    SalesLineDiscount2."Currency Code":=SalesLineDiscountPadre."Currency Code";
                    SalesLineDiscount2."Variant Code":=SalesLineDiscountPadre."Variant Code";
                    SalesLineDiscount2."Unit of Measure Code":=SalesLineDiscountPadre."Unit of Measure Code";
                    SalesLineDiscount2."Minimum Quantity":=1;
                    SalesLineDiscount2."Ending Date":=SalesLineDiscountPadre."Ending Date";
                    SalesLineDiscount2."Line Discount %":=SalesLineDiscountPadre."Line Discount %";
                    SalesLineDiscount2."Fecha alta":=CREATEDATETIME(TODAY,TIME);
                    SalesLineDiscount2.INSERT;
                    VENTANA.UPDATE(1,'A2-'+SalesLineDiscount2.Code);
               END;                                               
               SalesLineDiscount2.RESET;
               SalesLineDiscount2.SETRANGE(Type,SalesLineDiscountPadre.Type);
               SalesLineDiscount2.SETRANGE(Code,SalesLineDiscountPadre.Code);
               SalesLineDiscount2.SETRANGE("Sales Type",SalesLineDiscountPadre."Sales Type");
               SalesLineDiscount2.SETRANGE("Sales Code",SalesLineDiscountPadre."Sales Code");
               SalesLineDiscount2.SETRANGE("Starting Date",SalesLineDiscountPadre."Starting Date");
               SalesLineDiscount2.SETRANGE("Currency Code",SalesLineDiscountPadre."Currency Code");
               SalesLineDiscount2.SETRANGE("Variant Code",SalesLineDiscountPadre."Variant Code");
               SalesLineDiscount2.SETRANGE("Unit of Measure Code",SalesLineDiscountPadre."Unit of Measure Code");
               SalesLineDiscount2.SETRANGE("Minimum Quantity",SalesLineDiscountPadre."Minimum Quantity");      
               IF NOT SalesLineDiscount2.FINDFIRST THEN BEGIN
                    SalesLineDiscount2.INIT;
                    SalesLineDiscount2.Code:=SalesLineDiscountPadre.Code;
                    SalesLineDiscount2."Sales Type":=SalesLineDiscountPadre."Sales Type";
                    SalesLineDiscount2."Sales Code":=SalesLineDiscountPadre."Sales Code";
                    SalesLineDiscount2."Starting Date":=SalesLineDiscountPadre."Starting Date";
                    SalesLineDiscount2."Currency Code":=SalesLineDiscountPadre."Currency Code";
                    SalesLineDiscount2."Variant Code":=SalesLineDiscountPadre."Variant Code";
                    SalesLineDiscount2."Unit of Measure Code":=SalesLineDiscountPadre."Unit of Measure Code";
                    SalesLineDiscount2."Minimum Quantity":=SalesLineDiscountPadre."Minimum Quantity";
                    SalesLineDiscount2."Ending Date":=SalesLineDiscountPadre."Ending Date";
                    SalesLineDiscount2."Line Discount %":=SalesLineDiscountPadre."Line Discount %";           
                    SalesLineDiscount2."Fecha alta":=CREATEDATETIME(TODAY,TIME);
                    SalesLineDiscount2.INSERT;
                    VENTANA.UPDATE(1,'A2-'+SalesLineDiscount2.Code);
               END;                                               
          END;
     UNTIL CustomerDiscountGroup.NEXT=0;
     CustomerDiscountGroup.RESET;
     CustomerDiscountGroup.SETFILTER(CustomerDiscountGroup."Descuento % especial",'<>0');
     IF CustomerDiscountGroup.FINDSET THEN REPEAT
          SalesLineDiscount2.RESET;
          SalesLineDiscount2.SETRANGE(Type,SalesLineDiscountPadre.Type);
          SalesLineDiscount2.SETRANGE(Code,SalesLineDiscountPadre.Code);
          SalesLineDiscount2.SETRANGE("Sales Type",SalesLineDiscountPadre."Sales Type");
          SalesLineDiscount2.SETRANGE("Sales Code",CustomerDiscountGroup.Code);
          SalesLineDiscount2.SETRANGE("Starting Date",SalesLineDiscountPadre."Starting Date");
          SalesLineDiscount2.SETRANGE("Currency Code",SalesLineDiscountPadre."Currency Code");
          SalesLineDiscount2.SETRANGE("Variant Code",SalesLineDiscountPadre."Variant Code");
          SalesLineDiscount2.SETRANGE("Unit of Measure Code",SalesLineDiscountPadre."Unit of Measure Code");
          SalesLineDiscount2.SETRANGE("Minimum Quantity",1);      
          IF NOT SalesLineDiscount2.FINDFIRST THEN BEGIN
               SalesLineDiscount2.INIT;
               SalesLineDiscount2.Code:=SalesLineDiscountPadre.Code;
               SalesLineDiscount2."Sales Type":=SalesLineDiscountPadre."Sales Type";
               SalesLineDiscount2."Sales Code":=CustomerDiscountGroup.Code;
               SalesLineDiscount2."Starting Date":=SalesLineDiscountPadre."Starting Date";
               SalesLineDiscount2."Currency Code":=SalesLineDiscountPadre."Currency Code";
               SalesLineDiscount2."Variant Code":=SalesLineDiscountPadre."Variant Code";
               SalesLineDiscount2."Unit of Measure Code":=SalesLineDiscountPadre."Unit of Measure Code";
               SalesLineDiscount2."Minimum Quantity":=1;
               SalesLineDiscount2."Ending Date":=SalesLineDiscountPadre."Ending Date";
               SalesLineDiscount2."Line Discount %":=CustomerDiscountGroup."Descuento % especial";
               SalesLineDiscount2."Fecha alta":=CREATEDATETIME(TODAY,TIME);
               SalesLineDiscount2.INSERT;
               VENTANA.UPDATE(1,'A3-'+SalesLineDiscount2.Code);
          END;                                               
     UNTIL CustomerDiscountGroup.NEXT=0;
     CustomerDiscountGroup.RESET;
     CustomerDiscountGroup.SETFILTER(CustomerDiscountGroup."Descuento %",'<>0');
     IF CustomerDiscountGroup.FINDSET THEN REPEAT       
          SalesLineDiscount2.RESET;
          SalesLineDiscount2.SETRANGE(Type,SalesLineDiscountPadre.Type);
          SalesLineDiscount2.SETRANGE(Code,SalesLineDiscountPadre.Code);
          SalesLineDiscount2.SETRANGE("Sales Type",SalesLineDiscountPadre."Sales Type");
          SalesLineDiscount2.SETRANGE("Sales Code",CustomerDiscountGroup.Code);
          SalesLineDiscount2.SETRANGE("Starting Date",SalesLineDiscountPadre."Starting Date");
          SalesLineDiscount2.SETRANGE("Currency Code",SalesLineDiscountPadre."Currency Code");
          SalesLineDiscount2.SETRANGE("Variant Code",SalesLineDiscountPadre."Variant Code");
          SalesLineDiscount2.SETRANGE("Unit of Measure Code",SalesLineDiscountPadre."Unit of Measure Code");
          SalesLineDiscount2.SETRANGE("Minimum Quantity",0);      
          IF NOT SalesLineDiscount2.FINDFIRST THEN BEGIN
               SalesLineDiscount2.INIT;
               SalesLineDiscount2.Code:=SalesLineDiscountPadre.Code;
               SalesLineDiscount2."Sales Type":=SalesLineDiscountPadre."Sales Type";
               SalesLineDiscount2."Sales Code":=CustomerDiscountGroup.Code;
               SalesLineDiscount2."Starting Date":=SalesLineDiscountPadre."Starting Date";
               SalesLineDiscount2."Currency Code":=SalesLineDiscountPadre."Currency Code";
               SalesLineDiscount2."Variant Code":=SalesLineDiscountPadre."Variant Code";
               SalesLineDiscount2."Unit of Measure Code":=SalesLineDiscountPadre."Unit of Measure Code";
               SalesLineDiscount2."Minimum Quantity":=0;
               SalesLineDiscount2."Ending Date":=SalesLineDiscountPadre."Ending Date";
               SalesLineDiscount2."Line Discount %":=CustomerDiscountGroup."Descuento %";
               SalesLineDiscount2."Fecha alta":=CREATEDATETIME(TODAY,TIME);
               SalesLineDiscount2.INSERT;
               VENTANA.UPDATE(1,'A3-'+SalesLineDiscount2.Code);
          END;                                               
     UNTIL CustomerDiscountGroup.NEXT=0;

UNTIL SalesLineDiscountPadre.NEXT=0;



Item.RESET;
IF Item.FINDFIRST THEN REPEAT
///     IF (Item."Producto PADRE"='') OR (Item."No."=Item."Producto PADRE") THEN BEGIN
     VENTANA.UPDATE(1,'A3-'+Item.Description);
          SalesLineDiscountPadre.RESET;
          SalesLineDiscountPadre.SETRANGE(Code,Item."No.");
          IF NOT SalesLineDiscountPadre.FINDSET THEN BEGIN
             CustomerDiscountGroup.RESET;
             CustomerDiscountGroup.SETFILTER(CustomerDiscountGroup."Descuento %",'<>0');
             IF CustomerDiscountGroup.FINDSET THEN REPEAT       
                  SalesLineDiscount2.RESET;
                  SalesLineDiscount2.SETRANGE(Type,SalesLineDiscount2.Type::"Item Disc. Group");
                  SalesLineDiscount2.SETRANGE(Code,Item."No.");
                  SalesLineDiscount2.SETRANGE("Sales Type",SalesLineDiscountPadre."Sales Type");
                  SalesLineDiscount2.SETRANGE("Sales Code",CustomerDiscountGroup.Code);
                  SalesLineDiscount2.SETRANGE("Starting Date",011118D);
                  SalesLineDiscount2.SETRANGE("Unit of Measure Code",Item."Base Unit of Measure");
                  SalesLineDiscount2.SETRANGE("Minimum Quantity",0);      
                  IF NOT SalesLineDiscount2.FINDFIRST THEN BEGIN
                       SalesLineDiscount2.INIT;
                       SalesLineDiscount2.Code:=Item."No.";
                       SalesLineDiscount2."Sales Type":=SalesLineDiscount2.Type::"Item Disc. Group";
                       SalesLineDiscount2."Sales Code":=CustomerDiscountGroup.Code;
                       SalesLineDiscount2."Starting Date":=011118D;
                       SalesLineDiscount2."Unit of Measure Code":=Item."Base Unit of Measure";
                       SalesLineDiscount2."Minimum Quantity":=0;
                       SalesLineDiscount2."Line Discount %":=CustomerDiscountGroup."Descuento %";
                       SalesLineDiscount2."Fecha alta":=CREATEDATETIME(TODAY,TIME);
                       IF SalesLineDiscount2.INSERT THEN;
                       VENTANA.UPDATE(1,'A3-'+SalesLineDiscount2.Code);
                  END;                                               
             UNTIL CustomerDiscountGroup.NEXT=0;

          END;

     ///END;
UNTIL Item.NEXT=0;



VENTANA.CLOSE;

    */

}

