#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50008  RellenaFechaPicking
{
    Permissions = tabledata "Sales Shipment Line" = rmi;


    trigger OnRun()
    begin


        FechaDispoWeb;

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


}

