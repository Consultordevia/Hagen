#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50045 "Automaticos TIENDA ANIMAL"
{
    // 
    // category;1
    // shopSku;2
    // name [es];3
    // description [es];4
    // summary [es];5
    // ean;6
    // brand;7
    // primary-image;8
    // secondary-image_1;9
    // secondary-image_2;10
    // secondary-image_3;11
    // secondary-image_4;12
    // sales-height;13
    // sales-width;14
    // sales-length;15
    // variant-group-code;16
    // commentary;17
    // 105;18
    // 105_MAG;19
    // 103;20
    // 103_MAG;21
    // 100;22
    // 100_MAG;23
    // 101;24
    // 108;25
    // 106;26
    // 107;27
    // 110;28
    // 113;29
    // 113_MAG;30
    // 104;31
    // 104_MAG;32
    // 109;33
    // 102;34
    // sku;35
    // product-id;36
    // product-id-type;37
    // description;38
    // internal-description;39
    // price;40
    // price-additional-info;41
    // quantity;42
    // min-quantity-alert;43
    // state;44
    // available-start-date;45
    // available-end-date;46
    // logistic-class;47
    // discount-price;48
    // discount-start-date;49
    // discount-end-date;50
    // leadtime-to-ship;51
    // update-delete52


    trigger OnRun()
    begin

        TiendaAnimal;


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
        TextoSalida4: Text[250];
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
        ItemCrossReference: Record "Item Reference";
        STOCKWEB: Decimal;
        SalesPrice2: Record "Sales Price";
        uod: Text;
        fechaini: Date;
        fechafin: Date;
        precio2: Decimal;
        precio3: Decimal;
        tprecio2: Text;
        tprecio3: Text;
        tSTOCKWEB: Text;
        tfechaini: Code[10];
        tfechafin: Code[10];
        SalesLineDiscount: Record "Sales Line Discount";
        dto: Decimal;

    local procedure TiendaAnimal()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        FileName: Text;
        InStream: InStream;
        FicherosHagen: Codeunit FicherosHagen;
    begin
        TempBlob.CreateOutStream(OutStream);









        /*
        TextoSalida1:='SKU de oferta;ID de producto;Tipo de ID de producto;Descripción de la oferta;Descripción interna de la oferta;Precio de la oferta;';
        TextoSalida2:='Información adicional sobre el precio de la oferta;Cantidad de la oferta;Alerta de cantidad mínima;Estado de la oferta;Fecha de inicio de la disponibilidad;';
        TextoSalida3:='Fecha de finalización de la disponibilidad;Clase logística;Precio de descuento;Fecha de inicio del descuento;Fecha de finalización del descuento;Plazo de envío;Actualizar/Eliminar';
        
        TextoSalida1:='sku;product-id;product-id-type;description;internal-description;price;price-additional-info;quantity;min-quantity-alert;state;available-start-date;available-end-date;logistic-class;';
        TextoSalida2:='discount-price;discount-start-date;discount-end-date;leadtime-to-ship;update-delete';
        */




        TextoSalida1 := 'category;shopSku;name [es];description [es];summary [es];ean;brand;primary-image;secondary-image_1;secondary-image_2;secondary-image_3;secondary-image_4;sales-height;';
        TextoSalida2 := 'sales-width;sales-length;variant-group-code;commentary;105;105_MAG;103;103_MAG;100;100_MAG;101;108;106;107;110;113;113_MAG;104;104_MAG;109;102;sku;product-id;product-id-type;';
        TextoSalida3 := 'description;internal-description;price;price-additional-info;quantity;min-quantity-alert;state;available-start-date;available-end-date;logistic-class;discount-price;discount-start-date;';
        TextoSalida4 := 'discount-end-date;leadtime-to-ship;update-delete';


        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4);







        Item.Reset;
        if Item.FindSet then
            repeat
                SalesPrice.Reset;
                SalesPrice.SetRange("Item No.", Item."No.");
                SalesPrice.SetRange(SalesPrice."Sales Code", 'TAMK');
                if SalesPrice.FindFirst then begin
                    //////ItemCrossReference.RESET;
                    /////ItemCrossReference.SETRANGE(ItemCrossReference."Item No.",Item."No.");
                    /////ItemCrossReference.SETRANGE(ItemCrossReference."Cross-Reference Type No.",'12496');
                    /////IF ItemCrossReference.FINDFIRST THEN BEGIN
                    fechaini := 0D;
                    fechafin := 0D;
                    tfechafin := '';
                    tfechaini := '';
                    precio2 := 0;
                    SalesPrice2.Reset;
                    SalesPrice2.SetRange("Item No.", Item."No.");
                    SalesPrice2.SetRange("Sales Code", '12496');
                    ///SalesPrice2.SETFILTER("Ending Date",'%1|<%2',0D,TODAY);
                    if SalesPrice2.FindFirst then begin
                        fechaini := SalesPrice2."Starting Date";

                        tfechaini := Format(Date2dmy(fechaini, 3)) + '-' +
                                   Format(Date2dmy(fechaini, 2)) + '-' +
                                   Format(Date2dmy(fechaini, 1));
                        fechafin := SalesPrice2."Ending Date";
                        tfechaini := Format(Date2dmy(fechaini, 3)) + '-' +
                                   Format(Date2dmy(fechaini, 2)) + '-' +
                                   Format(Date2dmy(fechaini, 1));

                    end;

                    dto := 0;
                    SalesLineDiscount.Reset;
                    SalesLineDiscount.SetRange(Code, Item."No.");
                    SalesLineDiscount.SetRange("Sales Code", '12496');
                    SalesLineDiscount.SetFilter("Ending Date", '%1|>=%2', 0D, Today);
                    if SalesLineDiscount.FindLast then begin
                        dto := SalesLineDiscount."Line Discount %";
                        precio2 := SalesPrice."Unit Price";
                        precio2 := precio2 - ROUND(precio2 * dto / 100, 0.01);
                    end;

                    uod := 'update';
                    if (Item."Estado Producto" <> Item."estado producto"::Activo) and (Item."Stock para la web" <= 0) then begin
                        uod := 'DELETE';
                    end;

                    STOCKWEB := Item."Stock para la web" - Item."Stock para Catit";
                    if STOCKWEB < 0 then begin
                        STOCKWEB := 0;
                    end;
                    PRECIO := SalesPrice."Unit Price";

                    tprecio3 := '0';
                    tprecio3 := ConvertStr(Format(PRECIO * 100, 15, Text1100009), ' ', '0');
                    tprecio3 := CopyStr(tprecio3, 3, 11) + '.' + CopyStr(tprecio3, 14, 2);
                    tprecio3 := Format(PRECIO);

                    tprecio2 := '0';
                    tprecio2 := ConvertStr(Format(precio2 * 100, 15, Text1100009), ' ', '0');
                    tprecio2 := CopyStr(tprecio2, 3, 11) + '.' + CopyStr(tprecio2, 14, 2);
                    tprecio2 := Format(precio2);
                    if precio2 = 0 then begin
                        tprecio2 := '';
                    end;




                    if STOCKWEB > 100 then begin
                        STOCKWEB := 100;
                    end;
                    tSTOCKWEB := '0';
                    tSTOCKWEB := ConvertStr(Format(STOCKWEB * 100, 15, Text1100009), ' ', '0');
                    tSTOCKWEB := CopyStr(tSTOCKWEB, 3, 11);
                    tSTOCKWEB := Format(STOCKWEB);



                    TextoSalida1 := Format('') + ';' +    ///// 1
                                  Format(Item."No.") + ';' +     ///// 2
                                  Format('') + ';' + ///// 3
                                  Format('') + ';' + ///// 4
                                  Format('') + ';' +    ///// 5
                                  Format('') + ';' +/////6
                                  Format('') + ';' +///// 7
                                  Format('') + ';' +///// 8
                                  Format('') + ';' +///// 9
                                  Format('') + ';' +///// 10
                                  Format('') + ';' +///// 11
                                  Format('') + ';' +///// 12
                                  Format('') + ';' +///// 13
                                  Format('') + ';' +///// 14
                                  Format('') + ';' +///// 15
                                  Format('') + ';' +///// 16
                                  Format('') + ';' +///// 17
                                  Format('') + ';' +///// 18
                                  Format('') + ';' +///// 19
                                  Format('') + ';' +///// 20
                                  Format('') + ';' +///// 21
                                  Format('') + ';' +///// 22
                                  Format('') + ';' +///// 23
                                  Format('') + ';' +///// 24
                                  Format('') + ';' +///// 25
                                  Format('') + ';' +///// 26
                                  Format('') + ';' +///// 27
                                  Format('') + ';' +///// 28
                                  Format('') + ';' +///// 29
                                  Format('') + ';' +///// 30
                                  Format('') + ';' +///// 31
                                  Format('') + ';' +///// 32
                                  Format('') + ';';///// 33
                    TextoSalida2 := Format('') + ';' +///// 34
                                  Format(Item."No.") + ';' +///// 35
                                  Format(Item."No.") + ';' +///// 36
                                  Format('SHOP_SKU') + ';' +///// 37
                                  Format('') + ';' +///// 38
                                  Format('') + ';' +///// 39
                                  Format(tprecio3) + ';' +///// 40
                                  Format('') + ';' +///// 41
                                  Format(tSTOCKWEB) + ';' +///// 42
                                  Format('') + ';' +///// 43
                                  Format('11') + ';' +///// 44
                                  Format('') + ';' +///// 45
                                  Format('') + ';' +///// 46
                                  Format('') + ';' +///// 47
                                  Format(tprecio2) + ';' +///// 48
                                  Format(tfechaini) + ';' +///// 49
                                  Format(tfechafin) + ';' +///// 50
                                  Format('') + ';' +///// 51
                                  Format('');///// 52


                    ///// 1;41995-2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30;31;32;33;34;41995-35;41995-36;SHOP_SKU37;38;39;29,99-40;41;100-42;43;Nuevo-44;45;46;47;26,99-48;2020-04-20-49;2020-05-31-50;51;52






                    OutStream.Write(TextoSalida1 + TextoSalida2);
                    /////    END;

                end;

            until Item.Next = 0;


        SalesReceivablesSetup.Get;




        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero('E:/FICHEROSBC/tmp/tiendaminal', 'Tanimal-stock.csv', InStream);

    end;
}

