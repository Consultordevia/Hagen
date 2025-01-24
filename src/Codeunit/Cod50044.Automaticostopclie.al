#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50044 "Automaticos top clie"
{

    Permissions = tabledata 110 = rmid, tabledata 113 = rmid, tabledata 17 = rmid;

    trigger OnRun()
    begin


        RecalculaTopClienteNuevo;




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
        ItemAmount: Record "Item Amount" temporary;
        i: Integer;
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ItemTMP: Record Item temporary;
        GenProductPostingGroupTMP: Record "Gen. Product Posting Group" temporary;
        sumatodo: Decimal;
        TANTO: Decimal;
        SalesShipmentLine: Record "Sales Shipment Line";
        Estadisticaclienteproducto: Record "Estadistica cliente producto";

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
        if ItemAmountTemp.FindFirst then
            repeat
                Tanto := 0;
                RecItem.Get(ItemAmountTemp."Item No.");
                Acumu := Acumu + ItemAmountTemp.Amount;
                if TAcumu <> 0 then begin
                    Tanto := (Acumu * 100) / TAcumu;
                    tantoa := (ItemAmountTemp.Amount * 100) / TAcumu;
                end;
                Clasi := 2;
                if (Tanto >= TB + TC) then begin
                    Clasi := 1;
                end;
                if (Tanto >= TA) then begin
                    Clasi := 0;
                end;
                RecItem."% clasi A,B,C" := tantoa;
                RecItem."Acumu. A,B,C" := Tanto;
                RecItem."Clasificación A,B,C" := Clasi;
                RecItem."Fecha asignada clasificación" := Today;
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
        if ItemAmountTemp.FindFirst then
            repeat
                Tanto := 0;
                Customer.Get(ItemAmountTemp."Item No.");
                Acumu := Acumu + ItemAmountTemp.Amount;
                if TAcumu <> 0 then begin
                    Tanto := (Acumu * 100) / TAcumu;
                    tantoa := (ItemAmountTemp.Amount * 100) / TAcumu;
                end;
                Clasi := 2;
                if (Tanto >= TB + TC) then begin
                    Clasi := 1;
                end;
                if (Tanto >= TA) then begin
                    Clasi := 0;
                end;
                Customer."% clasi A,B,C" := tantoa;
                Customer."Acumu. A,B,C" := Tanto;
                Customer."Clasificación A,B,C Hagen" := Clasi;
                Customer."Fecha clasificación A,B,C" := Today;
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
                        RecItem.SetRange(RecItem."Location Filter", 'SILLA', 'SILLA');
                        RecItem.CalcFields(RecItem.Inventory);
                        RecItem.SetRange(RecItem."Date Filter", DESDE, Today);
                        RecItem.CalcFields(RecItem."Sales (Qty.)");
                        RecMT2."Stock actual" := RecItem.Inventory;
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


        RecClie.Reset;
        if RecClie.FindSet then
            repeat
                VENTANA.Update(1, RecClie."No.");
                i := 0;
                Estadisticaclienteproducto.Reset;
                Estadisticaclienteproducto.SetCurrentkey(Cliente, Amount);
                Estadisticaclienteproducto.Ascending(false);
                Estadisticaclienteproducto.SetRange(Cliente, RecClie."No.");
                if Estadisticaclienteproducto.FindFirst then
                    repeat
                        i := i + 1;
                        if i = 1 then RecClie."Top produccto 1" := Estadisticaclienteproducto."Item No.";
                        if i = 2 then RecClie."Top produccto 2" := Estadisticaclienteproducto."Item No.";
                        if i = 3 then RecClie."Top produccto 3" := Estadisticaclienteproducto."Item No.";
                        if i = 4 then RecClie."Top produccto 4" := Estadisticaclienteproducto."Item No.";
                        if i = 5 then RecClie."Top produccto 5" := Estadisticaclienteproducto."Item No.";
                        if i = 6 then RecClie."Top produccto 6" := Estadisticaclienteproducto."Item No.";
                        if i = 7 then RecClie."Top produccto 7" := Estadisticaclienteproducto."Item No.";
                        if i = 8 then RecClie."Top produccto 8" := Estadisticaclienteproducto."Item No.";
                        if i = 9 then RecClie."Top produccto 9" := Estadisticaclienteproducto."Item No.";
                        if i = 10 then RecClie."Top produccto 10" := Estadisticaclienteproducto."Item No.";
                        RecClie.Modify;
                    until (Estadisticaclienteproducto.Next = 0) or (i = 10);


            until RecClie.Next = 0;


        VENTANA.Close;
    end;

    local procedure RecalculaTopFamilia()
    begin
    end;

    local procedure RecalculaTopClienteNuevo()
    begin

        VENTANA.Open('#1##################################');

        DESDE := CalcDate('-1A', Today);


        RecClie.Reset;
        if RecClie.FindSet then
            repeat
                VENTANA.Update(1, RecClie."No.");
                SalesShipmentHeader.Reset;
                SalesShipmentHeader.SetRange("Sell-to Customer No.", RecClie."No.");
                SalesShipmentHeader.SetRange("Posting Date", DESDE, Today);
                SalesShipmentHeader.SetRange(Historificado, false);
                if SalesShipmentHeader.FindFirst then
                    repeat
                        SalesShipmentLine.Reset;
                        SalesShipmentLine.SetRange("Document No.", SalesShipmentHeader."No.");
                        SalesShipmentLine.SetRange(Type, SalesShipmentLine.Type::Item);
                        if SalesShipmentLine.FindFirst then
                            repeat
                                if SalesShipmentLine."No." <> 'TRAN' then begin
                                    Estadisticaclienteproducto.Reset;
                                    Estadisticaclienteproducto.SetRange("Item No.", SalesShipmentLine."No.");
                                    Estadisticaclienteproducto.SetRange(Cliente, SalesShipmentLine."Sell-to Customer No.");
                                    if Estadisticaclienteproducto.FindFirst then begin
                                        Estadisticaclienteproducto.Amount := Estadisticaclienteproducto.Amount + SalesShipmentLine.Quantity;
                                        Estadisticaclienteproducto."Amount 2" := Estadisticaclienteproducto."Amount 2" + SalesShipmentLine."VAT Base Amount";
                                        Estadisticaclienteproducto.Modify;
                                    end;
                                    if not Estadisticaclienteproducto.FindFirst then begin
                                        Estadisticaclienteproducto.Init;
                                        Estadisticaclienteproducto.Amount := SalesShipmentLine.Quantity;
                                        Estadisticaclienteproducto."Amount 2" := SalesShipmentLine."VAT Base Amount";
                                        Estadisticaclienteproducto."Item No." := SalesShipmentLine."No.";
                                        Estadisticaclienteproducto.Cliente := SalesShipmentLine."Sell-to Customer No.";
                                        Estadisticaclienteproducto.Insert;
                                    end;
                                end;
                            until SalesShipmentLine.Next = 0;
                        SalesShipmentHeader2.Get(SalesShipmentHeader."No.");
                        SalesShipmentHeader2.Historificado := true;
                        SalesShipmentHeader2.Modify;
                    until SalesShipmentHeader.Next = 0;
                Commit;
            until RecClie.Next = 0;



        RecClie.Reset;
        if RecClie.FindSet then
            repeat
                VENTANA.Update(1, RecClie."No.");
                i := 0;
                Estadisticaclienteproducto.Reset;
                Estadisticaclienteproducto.SetCurrentkey(Cliente, Amount);
                Estadisticaclienteproducto.Ascending(false);
                Estadisticaclienteproducto.SetRange(Cliente, RecClie."No.");
                if Estadisticaclienteproducto.FindFirst then
                    repeat
                        i := i + 1;
                        if i = 1 then RecClie."Top produccto 1" := Estadisticaclienteproducto."Item No.";
                        if i = 2 then RecClie."Top produccto 2" := Estadisticaclienteproducto."Item No.";
                        if i = 3 then RecClie."Top produccto 3" := Estadisticaclienteproducto."Item No.";
                        if i = 4 then RecClie."Top produccto 4" := Estadisticaclienteproducto."Item No.";
                        if i = 5 then RecClie."Top produccto 5" := Estadisticaclienteproducto."Item No.";
                        if i = 6 then RecClie."Top produccto 6" := Estadisticaclienteproducto."Item No.";
                        if i = 7 then RecClie."Top produccto 7" := Estadisticaclienteproducto."Item No.";
                        if i = 8 then RecClie."Top produccto 8" := Estadisticaclienteproducto."Item No.";
                        if i = 9 then RecClie."Top produccto 9" := Estadisticaclienteproducto."Item No.";
                        if i = 10 then RecClie."Top produccto 10" := Estadisticaclienteproducto."Item No.";
                        RecClie.Modify;
                    until (Estadisticaclienteproducto.Next = 0) or (i = 10);


            until RecClie.Next = 0;

    end;
}

