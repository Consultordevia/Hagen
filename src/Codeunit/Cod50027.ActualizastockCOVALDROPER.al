#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50027 "Actualiza stock COVALDROPER"
{

    trigger OnRun()
    begin


        GrabaStockCOVAL;



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
        CODEXTERNO: Code[4];
        adaia: Record adaia;
        Nomdir: Text;


    procedure GrabaStockCOVAL()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        FileName: Text;
        InStream: InStream;
        FicherosHagen: Codeunit FicherosHagen;
    begin
        TempBlob.CreateOutStream(OutStream);


        /*
        ----Descripción. Descripción breve del artículo (max. 50 caracteres)
        ----EAN artículo. Numeración del código de barras del artículo
        -----EAN Caja. Numeración del código de barras de la caja (en caso de no tener dejar en blanco)
        -----Existencias. Número de unidades en stock para ese artículo.
        -----Precio. Precio al que Covaldroper compra el artículo
        -----Nº de proveedor. Será facilitado por Covaldroper
        -----Unidades por caja. Siempre será 1
        -----Múltiplo de venta. Siempre será 1
        -----Volumen picking. Siempre será 1
        -----Código producto. Referencia interna del producto que le asigna el proveedor
        -----Categoría Nielsen. Numeración que indica la categoría del producto (a concretar con Covaldroper)
        -----Familia Nielsen. Numeración que indica la familia del producto (a concretar con Covaldroper)
        -----Subfamilia Nielsen. Numeración que indica la subcategoría del producto (a concretar con
        
        DISOLVENTE SPB UNIVERSAL;8436032030265;;10;6,40;7,80;70000;1;1;1;156897;70;6;1
        DET WIPP BLANCURA TOTAL 25+6;8410436174145;;250;7,20;8,25;70000;1;1;1;85697;01;1;1
        */


        Customer.Get('10925');
        CODEXTERNO := Customer."Codigo cliente externo";

        SalesReceivablesSetup.Get;







        Item.Reset;
        Item.SetFilter(Item."Estado Producto", '0|1');
        Item.SetRange(Item."Excluir de dropbox", false);
        if Item.FindSet then
            repeat
                if RecGP.Get(Item."Gen. Prod. Posting Group") then begin
                    if RecGP."Es producto" then begin
                        Item.CalcFields(Item."Tarifa 2019", Item."PVP Recomendado 2019");
                        Clear(TextoSalida1);
                        Clear(TextoSalida2);
                        Item.CalcFields(Inventory, "Existencia FOB", Item."Existencia SILLA", Item."Qty. on Sales Order");
                        ///DISPONI:=Item."Existencia SILLA"-Item."Qty. on Sales Order";
                        DISPONI := Item.Inventory - Item."Existencia FOB" - Item."Qty. on Sales Order" - Item."Stock para Catit";
                        ENTRA := true;
                        if (DISPONI <= 0) and (Item."Estado Producto" = 1) then begin
                            ENTRA := false;
                            RecItem221.Get(Item."No.");
                            RecItem221."Excluir de dropbox" := true;
                            RecItem221."Estado WEB Inactivo" := true;
                            RecItem221.Modify;
                        end;
                        if (DISPONI > 0) and (Item."Estado Producto" = 1) then begin
                            ENTRA := true;
                            RecItem221.Get(Item."No.");
                            RecItem221."Excluir de dropbox" := false;
                            RecItem221."Estado WEB Inactivo" := false;
                            RecItem221.Modify;
                        end;
                        if ENTRA then begin

                            if DISPONI > 30 then begin
                                DISPONI := 30;
                            end;
                            if Item."Producto con reserva" then begin
                                DISPONI := 0;
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
                            PRECIO := 0;
                            SalesPrice.Reset;
                            SalesPrice.SetRange("Item No.", Item."No.");
                            SalesPrice.SetRange(SalesPrice."Sales Code", 'COV');
                            if SalesPrice.FindLast then begin
                                PRECIO := SalesPrice."Unit Price";
                                TextoSalida1 := Format(Item.ean) + ';' +
                                              Format(PRECIO) + ';' +
                                              Format(DISPONI);
                                ///ArchSalida4.Write(TextoSalida1);
                                OutStream.Write(TextoSalida1);

                            end;
                        end;
                    end;
                end;

            until Item.Next = 0;

        nomdir := '';
        ADAIA.Reset();
        ADAIA.SetRange(texto, 'AUTOMATICOS COVALDROPER-CU-50027');
        IF ADAIA.FindSet() THEN begin
            nomdir := ADAIA.Ruta;
        end;
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(nomdir, 'actptosexternos_' + CODEXTERNO + '.txt', InStream);


    end;
}

