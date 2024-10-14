#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50028 "Automaticos Catit"
{

    trigger OnRun()
    begin

        GrabaStockCatit;
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
        ArchSalida5: File;
        ArchExt4: Text[250];
        ArchExt5: Text[250];
        Item: Record Item;
        TextoSalida1: Text[250];
        TextoSalida2: Text[250];
        TextoSalida3: Text[250];
        TextoSalida4: Text[250];
        TextoSalida5: Text[250];
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
        id1: Integer;
        id2: Integer;
        refcattit: Code[20];
        ShippingAgent: Record "Shipping Agent";
        TIVA: Text;
        AA: Integer;
        MM: Integer;
        DD: Integer;
        AA1: Code[10];
        MM1: Code[10];
        DD1: Code[10];
        invmanestoc: Text;
        estatus: Text;
        pvpr: Decimal;
        SalesLineDiscount: Record "Sales Line Discount";
        codinner: Code[10];
        ADAIA: RECORD adaia;
        NOMDIR: Text;

    var
        InventarioPMP: Record "Inventario PMP";
        pmp: Decimal;



    procedure GrabaStockCatit()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        FileName: Text;
        InStream: InStream;
        FicherosHagen: Codeunit FicherosHagen;
    begin
        TempBlob.CreateOutStream(OutStream);






        OutStream.Write(TextoSalida1);




        TextoSalida4 := 'sku;price;Stock;status;pvpr;coste';

        OutStream.Write(TextoSalida4);



        Item.Reset;
        Item.SetFilter(Item."Estado Producto", '0|1');
        ///// Item.SETRANGE(Item."Excluir de dropbox",FALSE);
        ///Item.SETRANGE("No.",'44144');
        if Item.FindSet then
            repeat
                if RecGP.Get(Item."Gen. Prod. Posting Group") then begin
                    if RecGP."Es producto" then begin
                        Item.CalcFields(Item."Tarifa 2019", Item."PVP Recomendado 2019");
                        Clear(TextoSalida1);
                        Clear(TextoSalida2);
                        Item.CalcFields(Inventory, "Existencia FOB", Item."Existencia SILLA", Item."Qty. on Sales Order", Item."Existencia OPER", "Existencia TENERIFE");



                        ///DISPONI:=Item."Existencia OPER"+Item."Existencia SILLA"-Item."Qty. on Sales Order";
                        DISPONI := Item."Existencia SILLA" - Item."Qty. on Sales Order" - Item."Stock para Catit" - Item."Existencia TENERIFE";
                        if Item."Stock para la web" > Item."Stock para Catit" then begin
                            DISPONI := Item."Stock para la web" + Item."Stock para Catit";
                        end;
                        if DISPONI < Item."Stock para Catit" then begin
                            DISPONI := Item."Existencia SILLA";
                        end;
                        /*IF Item."No."='44146' THEN BEGIN
                        ERROR('%1 %2 %3 %4 %5 %6 %7 %8 %9',
                        DISPONI, -28
                        Item."Stock para la web", 0
                        Item."Stock para Catit", 200
                        Item.Inventory, 186
                        Item."Existencia FOB", 0
                        Item."Existencia SILLA", 186
                        Item."Qty. on Sales Order", 14
                        Item."Existencia OPER",
                        Item."Existencia TENERIFE");
                        END;
                        */
                        /////IF (DISPONI<0) AND ((Item."Existencia OPER"+Item."Existencia SILLA"<=0)) THEN BEGIN
                        if (DISPONI < 0) then begin
                            DISPONI := 0;
                        end;
                        /*IF DISPONI<=0 THEN BEGIN
                            IF (Item."Existencia SILLA"- FOB"-Item."Existencia TENERIFE")<>0 THEN BEGIN
                                IF Item."Stock para Catit"<>0 THEN BEGIN
                                    DISPONI:=Item."Stock para Catit"
                                END;
                            END;
                        END;
                        */
                        ////ERROR('%1',DISPONI);
                        ENTRA := true;
                        if (DISPONI <= 0) and (Item."Estado Producto" = 1) then begin
                            ENTRA := true;
                            DISPONI := 0;
                            /*RecItem221.GET(Item."No.");
                            RecItem221."Excluir de dropbox":=TRUE;
                            RecItem221."Estado WEB Inactivo":=TRUE;
                            RecItem221.MODIFY;*/
                        end;
                        if (DISPONI > 0) and (Item."Estado Producto" = 1) then begin
                            ENTRA := true;
                            /*RecItem221.GET(Item."No.");
                            RecItem221."Excluir de dropbox":=FALSE;
                            RecItem221."Estado WEB Inactivo":=FALSE;
                            RecItem221.MODIFY;                   */
                        end;
                        RecItem221.Get(Item."No.");
                        if RecItem221."FIJO Excluir de dropbox" = true then begin
                            ENTRA := false;
                        end;
                        if ENTRA then begin
                            if DISPONI > 90 then begin
                                DISPONI := 90;
                            end;
                            if Item."Producto con reserva" then begin
                                /////DISPONI:=0;
                            end;
                            UNIMEDAD := Item."Unidades venta";
                            if Item."Permite fraccionar venta" then begin
                                UNIMEDAD := 1;
                            end;
                            FECHARECEP := 0D;
                            if DISPONI <= 0 then begin
                                DISPONI := 0;
                                Rec39.Reset;
                                Rec39.SetCurrentkey(Rec39."Document Type", Rec39."No.");
                                Rec39.SetRange(Rec39."Document Type", 1);
                                Rec39.SetRange(Rec39."No.", Item."No.");
                                Rec39.SetFilter(Rec39."Outstanding Quantity", '<>0');
                                if Rec39.FindFirst then begin
                                    Rec38.Get(Rec39."Document Type", Rec39."Document No.");
                                    FECHARECEP := Rec38."E.T.Arrival";
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
                                    end;
                                end;
                            end;
                            CMARCA := '';
                            RecMt.Reset;
                            RecMt.SetRange(RecMt.Tabla, 24);
                            RecMt.SetRange(RecMt.Codigo, Item.Marca);
                            if RecMt.FindFirst then begin
                                CMARCA := RecMt.Descripcion;
                            end;
                            RecUMP.Init;
                            RecUMP.Reset;
                            RecUMP.SetRange(RecUMP."Item No.", Item."No.");
                            RecUMP.SetRange(RecUMP.Code, 'UDS');
                            if RecUMP.FindFirst then begin
                            end;
                            RecMT2.Init;
                            if RecMT2.Get(12, Item."No.", '00000000') then begin
                            end;

                            codinner := '';
                            PRECIO := 0;
                            SalesPrice.Reset;
                            SalesPrice.SetRange("Item No.", Item."No.");
                            SalesPrice.SetRange(SalesPrice."Sales Code", 'CATIT-SHP');
                            if SalesPrice.FindFirst then
                                repeat
                                    codinner := SalesPrice."Codigo INNER o MASTET";
                                    PRECIO := SalesPrice."Unit Price";
                                    pvpr := SalesPrice."Precio recomendado";

                                    SalesLineDiscount.Reset;
                                    SalesLineDiscount.SetRange(Code, Item."No.");
                                    SalesLineDiscount.SetRange("Sales Code", 'DCCA');
                                    SalesLineDiscount.SetRange("Starting Date", 0D, Today);
                                    SalesLineDiscount.SetRange("Ending Date", Today, 20501231D);
                                    if SalesLineDiscount.FindLast then begin
                                        PRECIO := PRECIO - ROUND(PRECIO * SalesLineDiscount."Line Discount %" / 100, 0.001);
                                    end;

                                    IVA := 0;
                                    if VATPostingSetup.Get('NACIONAL', Item."VAT Prod. Posting Group") then begin
                                        IVA := VATPostingSetup."VAT+EC %";
                                    end;
                                    id2 := 0;
                                    Familiascatit2.Init;
                                    Familiascatit2.Reset;
                                    Familiascatit2.SetRange("Familia Catit", Item."Familia Catit");
                                    Familiascatit2.SetRange("Subfamilia Catit", Item."Subfamilia Catit");
                                    if Familiascatit2.FindFirst then begin
                                        id2 := Familiascatit2."ID Web";
                                    end;
                                    id1 := 0;
                                    Familiascatit1.Init;
                                    Familiascatit1.Reset;
                                    Familiascatit1.SetRange("Familia Catit", Item."Familia Catit");
                                    if Familiascatit1.FindFirst then begin
                                        id1 := Familiascatit1."ID Web";
                                    end;

                                    refcattit := Item."Ref. Catit";
                                    if refcattit = '' then begin
                                        refcattit := Item."No.";
                                    end;
                                    TIVA := Format(IVA);
                                    if IVA = 10 then begin
                                        TIVA := 'Reducido';
                                    end;
                                    invmanestoc := 'no';
                                    if DISPONI > 0 then begin
                                        invmanestoc := 'yes';
                                    end;
                                    invmanestoc := 'yes';

                                    ///PRECIO:=PRECIO+ROUND(SalesPrice."Unit Price"*IVA/100,0.01);
                                    ///PRECIO:=PRECIO+ROUND(SalesPrice."Unit Price",0.01);
                                    PRECIO := ROUND(PRECIO, 0.01);

                                    if Item."Estatus Web" = Item."estatus web"::Activo then begin estatus := 'Active'; end;
                                    if Item."Estatus Web" = Item."estatus web"::Inactivo then begin estatus := 'Draft'; end;



                                    pmp := 0;
                                    InventarioPMP.RESET;
                                    InventarioPMP.SETRANGE(InventarioPMP."Item No.", Item."No.");
                                    IF InventarioPMP.FINDLAST THEN BEGIN
                                        pmp := InventarioPMP."Unit Cost";
                                    END;




                                    if codinner = '' then begin
                                        TextoSalida1 := Format(refcattit) + ';' +
                                               Format(PRECIO) + ';' +
                                               Format(DISPONI) + ';' +
                                               Format(estatus) + ';' +
                                               Format(pvpr) + ';' +
                                               Format(pmp);
                                        OutStream.Write(TextoSalida1);
                                    end;


                                    if codinner <> '' then begin

                                        refcattit := refcattit + codinner;

                                        RecUMP.Init;
                                        RecUMP.Reset;
                                        RecUMP.SetRange(RecUMP."Item No.", Item."No.");
                                        RecUMP.SetRange(RecUMP.Code, SalesPrice."Unit of Measure Code");
                                        if RecUMP.FindFirst then begin
                                        end;
                                        TextoSalida1 := Format(refcattit) + ';' +
                                        Format(PRECIO) + ';' +
                                        Format(ROUND(DISPONI / RecUMP."Qty. per Unit of Measure", 1)) + ';' +
                                        Format(estatus) + ';' +
                                        Format(pvpr) + ';' +
                                        Format(pmp);
                                        OutStream.Write(TextoSalida1);

                                    end;
                                until SalesPrice.Next = 0;


                        end;
                    end;
                end;

            until Item.Next = 0;


        nomdir := '';
        ADAIA.Reset();
        ADAIA.SetRange(texto, 'AUTOMATICOS CATIT-CU-50028');
        IF ADAIA.FindSet() THEN begin
            nomdir := ADAIA.Ruta;
        end;

        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(NOMDIR, 'catit.csv', InStream);

    end;


}

