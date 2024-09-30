#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50072 "Automaticos MIRAVIA"
{
    // 
    // 
    // Nº    Grupo precio clienteAlias
    //     NAV0315MRFLUMIRAVIA FLUVAL
    //     NAV0316MRAQMIRAVIA AQUACLEAR
    //     NAV0317MRCAITMIRAVIA CATIT
    //     NAV0318MREXOMIRAVIA EXOTERRA
    //     NAV0319MRDGMIRAVIA- DOGIT
    //     NAV0320MRTROMIRAVIA-TROPICAN
    //     NAV0321MRMARMIRAVIA-MARINA
    //     NAV0322MRLAGMIRAVIA-LAGUNA
    //     NAV0323MRHARMIRAVIA-HARI
    // NAV0324MRLIVMIRAVIA-LIVING WORD


    trigger OnRun()
    begin

        nomdir := '';
        ADAIA.Reset();
        ADAIA.SetRange(texto, 'AUTOMATICOS MIRAVIA-CU-50072');
        IF ADAIA.FindSet() THEN begin
            nomdir := ADAIA.Ruta;
        end;

        MIRAVIA_MRAQ;
        MIRAVIA_MRCAIT;
        MIRAVIA_MRDG;
        MIRAVIA_MREXO;
        MIRAVIA_MRFLU;
        MIRAVIA_MRLAG;
        MIRAVIA_MRMAR;
        MIRAVIA_MRHAR;
        MIRAVIA_MRLIV;


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
        TextoSalida1: Text;
        TextoSalida2: Text;
        TextoSalida3: Text;
        TextoSalida4: Text;
        TextoSalida5: Text;
        TextoSalida6: Text;
        TextoSalida7: Text;
        TextoSalida8: Text;
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
        /////- CASCII: Codeunit "ANSI <-> ASCII converter2";
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
        /////- Facturarimprimir: Codeunit "Facturar + imprimir";
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
        /////- ItemCrossReference: Record "Item Cross Reference";
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
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        FileName: Text;
        InStream: InStream;
        FicherosHagen: Codeunit FicherosHagen;
        ADAIA: Record ADAIA;
        NOMDIR: Text;


    local procedure MIRAVIA_MRAQ()
    begin

        SalesReceivablesSetup.Get;

        ArchExt4 := 'c:\tmp\Miravia\UpdatePriceAndStock_Basic_MRAQ.csv';
        TempBlob.CreateOutStream(OutStream);

        TextoSalida1 := 'SellerSku,Price,SpecialPrice,Status,Default Stock Quantity,Multiwarehouse Code 1,' +
                      'Stock Quantity 1,Multiwarehouse Code 2,Stock Quantity 2,Multiwarehouse Code 3,';
        TextoSalida2 := 'Stock Quantity 3,Multiwarehouse Code 4,Stock Quantity 4,Multiwarehouse Code 5,Stock Quantity 5';

        OutStream.Write(TextoSalida1 + TextoSalida2);



        TextoSalida1 := 'Mandatory,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional';

        OutStream.Write(TextoSalida1);


        TextoSalida1 := 'SKU is a unique identifier for each product variation. SKU value cannot be duplicated in a store.,' +
        'This is the price that the customer has to pay for the product. This price includes the taxes.,';
        TextoSalida2 := 'Sales Price for a Product for Promotion.,' +
        'Input Status value to change Sku status ' +
        'Input your product stock quantity.,';
        TextoSalida3 := 'The stock quantity should be equal or greater than order quantity.",' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida4 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida5 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida6 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida7 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida8 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.';


        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);


        TextoSalida1 := 'Please input less than 200 characters.,' +
        'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,';
        TextoSalida2 := 'Special Price has to be lower than "Price" or else its not a sale offer. Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only delete active inactive and empty value are accepted.Empty value will skip this parameter.,';
        TextoSalida3 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida4 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida5 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida6 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida7 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida8 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.';


        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);



        Item.Reset;
        if Item.FindSet then
            repeat
                SalesPrice.Reset;
                SalesPrice.SetRange("Item No.", Item."No.");
                SalesPrice.SetRange(SalesPrice."Sales Code", 'MRAQ');
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
                    SalesPrice2.SetRange("Sales Code", 'NAV0316');
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
                    SalesLineDiscount.SetRange("Sales Code", 'NAV0316');
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
                    tprecio3 := ConvertStr(Format(PRECIO * 100, 15, Text1100009), ' ', ' ');
                    tprecio3 := CopyStr(tprecio3, 3, 11) + '.' + CopyStr(tprecio3, 14, 2);
                    tprecio3 := Format(tprecio3);
                    tprecio3 := ConvertStr(Format(PRECIO), ',', '.');


                    tprecio2 := '0';
                    tprecio2 := ConvertStr(Format(precio2 * 100, 15, Text1100009), ' ', ' ');
                    tprecio2 := CopyStr(tprecio2, 3, 11) + '.' + CopyStr(tprecio2, 14, 2);
                    tprecio2 := Format(precio2);
                    if precio2 = 0 then begin
                        tprecio2 := '';
                    end;




                    if STOCKWEB > 100 then begin
                        STOCKWEB := 100;
                    end;
                    tSTOCKWEB := '0';
                    tSTOCKWEB := ConvertStr(Format(STOCKWEB * 100, 15, Text1100009), ' ', ' ');
                    tSTOCKWEB := CopyStr(tSTOCKWEB, 3, 11);
                    tSTOCKWEB := Format(STOCKWEB);



                    TextoSalida1 := Format(Item."No.") + ',' +     ///// 1
                                  Format(tprecio3) + ',' +///// 2
                                  Format(tprecio2) + ',' +///// 3
                                  Format('') + ',' + ///// 4
                                  Format(tSTOCKWEB) + ',' + ///// 5
                                  Format('dropshipping') + ',' +    ///// 6
                                  Format(tSTOCKWEB) + ',' +/////7
                                  Format('') + ',' +///// 7
                                  Format('') + ',' +///// 8
                                  Format('') + ',' +///// 9
                                  Format('') + ',' +///// 10
                                  Format('') + ',' +///// 11
                                  Format('') + ',' +///// 12
                                  Format('') + ',' +///// 13
                                  Format('');    ///// 14


                    OutStream.Write(TextoSalida1);


                end;

            until Item.Next = 0;


        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(NOMDIR, 'UpdatePriceAndStock_Basic_MRAQ.csv', InStream);


    end;

    local procedure MIRAVIA_MRCAIT()
    begin

        SalesReceivablesSetup.Get;

        ArchExt4 := 'c:\tmp\Miravia\UpdatePriceAndStock_Basic_MRCAIT.csv';
        TempBlob.CreateOutStream(OutStream);



        TextoSalida1 := 'SellerSku,Price,SpecialPrice,Status,Default Stock Quantity,Multiwarehouse Code 1,' +
                      'Stock Quantity 1,Multiwarehouse Code 2,Stock Quantity 2,Multiwarehouse Code 3,';
        TextoSalida2 := 'Stock Quantity 3,Multiwarehouse Code 4,Stock Quantity 4,Multiwarehouse Code 5,Stock Quantity 5';
        OutStream.Write(TextoSalida1 + TextoSalida2);



        TextoSalida1 := 'Mandatory,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional';
        OutStream.Write(TextoSalida1);


        TextoSalida1 := 'SKU is a unique identifier for each product variation. SKU value cannot be duplicated in a store.,' +
        'This is the price that the customer has to pay for the product. This price includes the taxes.,';
        TextoSalida2 := 'Sales Price for a Product for Promotion.,' +
        'Input Status value to change Sku status ' +
        'Input your product stock quantity.,';
        TextoSalida3 := 'The stock quantity should be equal or greater than order quantity.",' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida4 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida5 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida6 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida7 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida8 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.';


        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);


        TextoSalida1 := 'Please input less than 200 characters.,' +
        'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,';
        TextoSalida2 := 'Special Price has to be lower than "Price" or else its not a sale offer. Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only delete active inactive and empty value are accepted.Empty value will skip this parameter.,';
        TextoSalida3 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida4 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida5 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida6 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida7 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida8 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.';


        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);








        Item.Reset;
        if Item.FindSet then
            repeat
                SalesPrice.Reset;
                SalesPrice.SetRange("Item No.", Item."No.");
                SalesPrice.SetRange(SalesPrice."Sales Code", 'MRCAIT');
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
                    SalesPrice2.SetRange("Sales Code", 'NAV0317');
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
                    SalesLineDiscount.SetRange("Sales Code", 'NAV0317');
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
                    ///tprecio3:=FORMAT(PRECIO);
                    tprecio3 := ConvertStr(Format(PRECIO), ',', '.');

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



                    TextoSalida1 := Format(Item."No.") + ',' +     ///// 1
                                  Format(tprecio3) + ',' +///// 2
                                  Format(tprecio2) + ',' +///// 3
                                  Format('') + ',' + ///// 4
                                  Format(tSTOCKWEB) + ',' + ///// 5
                                  Format('dropshipping') + ',' +    ///// 6
                                  Format(tSTOCKWEB) + ',' +/////7
                                  Format('') + ',' +///// 7
                                  Format('') + ',' +///// 8
                                  Format('') + ',' +///// 9
                                  Format('') + ',' +///// 10
                                  Format('') + ',' +///// 11
                                  Format('') + ',' +///// 12
                                  Format('') + ',' +///// 13
                                  Format('');    ///// 14







                    ///ArchSalida4.Write(TextoSalida1);
                    OutStream.Write(TextoSalida1);


                end;

            until Item.Next = 0;


        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(NOMDIR, 'UpdatePriceAndStock_Basic_MRCAIT.csv', InStream);
        ///ArchSalida4.Close;
    end;

    local procedure MIRAVIA_MRDG()
    begin

        SalesReceivablesSetup.Get;

        ArchExt4 := 'c:\tmp\Miravia\UpdatePriceAndStock_Basic_MRDG.csv';
        TempBlob.CreateOutStream(OutStream);



        TextoSalida1 := 'SellerSku,Price,SpecialPrice,Status,Default Stock Quantity,Multiwarehouse Code 1,' +
                      'Stock Quantity 1,Multiwarehouse Code 2,Stock Quantity 2,Multiwarehouse Code 3,';
        TextoSalida2 := 'Stock Quantity 3,Multiwarehouse Code 4,Stock Quantity 4,Multiwarehouse Code 5,Stock Quantity 5';
        //ArchSalida4.Write(TextoSalida1+TextoSalida2);
        OutStream.Write(TextoSalida1 + TextoSalida2);



        TextoSalida1 := 'Mandatory,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional';
        ///ArchSalida4.Write(TextoSalida1);
        OutStream.Write(TextoSalida1);


        TextoSalida1 := 'SKU is a unique identifier for each product variation. SKU value cannot be duplicated in a store.,' +
        'This is the price that the customer has to pay for the product. This price includes the taxes.,';
        TextoSalida2 := 'Sales Price for a Product for Promotion.,' +
        'Input Status value to change Sku status ' +
        'Input your product stock quantity.,';
        TextoSalida3 := 'The stock quantity should be equal or greater than order quantity.",' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida4 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida5 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida6 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida7 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida8 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);


        TextoSalida1 := 'Please input less than 200 characters.,' +
        'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,';
        TextoSalida2 := 'Special Price has to be lower than "Price" or else its not a sale offer. Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only delete active inactive and empty value are accepted.Empty value will skip this parameter.,';
        TextoSalida3 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida4 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida5 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida6 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida7 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida8 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);







        Item.Reset;
        if Item.FindSet then
            repeat
                SalesPrice.Reset;
                SalesPrice.SetRange("Item No.", Item."No.");
                SalesPrice.SetRange(SalesPrice."Sales Code", 'MRDG');
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
                    SalesPrice2.SetRange("Sales Code", 'NAV0319');
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
                    SalesLineDiscount.SetRange("Sales Code", 'NAV0319');
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
                    ///tprecio3:=FORMAT(PRECIO);
                    tprecio3 := ConvertStr(Format(PRECIO), ',', '.');

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



                    TextoSalida1 := Format(Item."No.") + ',' +     ///// 1
                                  Format(tprecio3) + ',' +///// 2
                                  Format(tprecio2) + ',' +///// 3
                                  Format('') + ',' + ///// 4
                                  Format(tSTOCKWEB) + ',' + ///// 5
                                  Format('dropshipping') + ',' +    ///// 6
                                  Format(tSTOCKWEB) + ',' +/////7
                                  Format('') + ',' +///// 7
                                  Format('') + ',' +///// 8
                                  Format('') + ',' +///// 9
                                  Format('') + ',' +///// 10
                                  Format('') + ',' +///// 11
                                  Format('') + ',' +///// 12
                                  Format('') + ',' +///// 13
                                  Format('');    ///// 14







                    //ArchSalida4.Write(TextoSalida1);
                    OutStream.Write(TextoSalida1);


                end;

            until Item.Next = 0;

        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(NOMDIR, 'UpdatePriceAndStock_Basic_MRDG.csv', InStream);

    end;

    local procedure MIRAVIA_MREXO()
    begin

        SalesReceivablesSetup.Get;

        ArchExt4 := 'c:\tmp\Miravia\UpdatePriceAndStock_Basic_MREXO.csv';
        TempBlob.CreateOutStream(OutStream);



        TextoSalida1 := 'SellerSku,Price,SpecialPrice,Status,Default Stock Quantity,Multiwarehouse Code 1,' +
                      'Stock Quantity 1,Multiwarehouse Code 2,Stock Quantity 2,Multiwarehouse Code 3,';
        TextoSalida2 := 'Stock Quantity 3,Multiwarehouse Code 4,Stock Quantity 4,Multiwarehouse Code 5,Stock Quantity 5';
        ///ArchSalida4.Write(TextoSalida1+TextoSalida2);
        OutStream.Write(TextoSalida1 + TextoSalida2);



        TextoSalida1 := 'Mandatory,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional';
        ///ArchSalida4.Write(TextoSalida1);
        OutStream.Write(TextoSalida1);


        TextoSalida1 := 'SKU is a unique identifier for each product variation. SKU value cannot be duplicated in a store.,' +
        'This is the price that the customer has to pay for the product. This price includes the taxes.,';
        TextoSalida2 := 'Sales Price for a Product for Promotion.,' +
        'Input Status value to change Sku status ' +
        'Input your product stock quantity.,';
        TextoSalida3 := 'The stock quantity should be equal or greater than order quantity.",' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida4 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida5 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida6 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida7 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida8 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);


        TextoSalida1 := 'Please input less than 200 characters.,' +
        'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,';
        TextoSalida2 := 'Special Price has to be lower than "Price" or else its not a sale offer. Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only delete active inactive and empty value are accepted.Empty value will skip this parameter.,';
        TextoSalida3 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida4 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida5 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida6 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida7 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida8 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);







        Item.Reset;
        if Item.FindSet then
            repeat
                SalesPrice.Reset;
                SalesPrice.SetRange("Item No.", Item."No.");
                SalesPrice.SetRange(SalesPrice."Sales Code", 'MREXO');
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
                    SalesPrice2.SetRange("Sales Code", 'NAV0318');
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
                    SalesLineDiscount.SetRange("Sales Code", 'NAV0318');
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
                    ///tprecio3:=FORMAT(PRECIO);
                    tprecio3 := ConvertStr(Format(PRECIO), ',', '.');

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



                    TextoSalida1 := Format(Item."No.") + ',' +     ///// 1
                                  Format(tprecio3) + ',' +///// 2
                                  Format(tprecio2) + ',' +///// 3
                                  Format('') + ',' + ///// 4
                                  Format(tSTOCKWEB) + ',' + ///// 5
                                  Format('dropshipping') + ',' +    ///// 6
                                  Format(tSTOCKWEB) + ',' +/////7
                                  Format('') + ',' +///// 7
                                  Format('') + ',' +///// 8
                                  Format('') + ',' +///// 9
                                  Format('') + ',' +///// 10
                                  Format('') + ',' +///// 11
                                  Format('') + ',' +///// 12
                                  Format('') + ',' +///// 13
                                  Format('');    ///// 14







                    ///ArchSalida4.Write(TextoSalida1);
                    OutStream.Write(TextoSalida1);


                end;

            until Item.Next = 0;

        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(NOMDIR, 'UpdatePriceAndStock_Basic_MREXO.csv', InStream);

    end;

    local procedure MIRAVIA_MRFLU()
    begin

        SalesReceivablesSetup.Get;

        ArchExt4 := 'c:\tmp\Miravia\UpdatePriceAndStock_Basic_MRFLU.csv';
        TempBlob.CreateOutStream(OutStream);



        TextoSalida1 := 'SellerSku,Price,SpecialPrice,Status,Default Stock Quantity,Multiwarehouse Code 1,' +
                      'Stock Quantity 1,Multiwarehouse Code 2,Stock Quantity 2,Multiwarehouse Code 3,';
        TextoSalida2 := 'Stock Quantity 3,Multiwarehouse Code 4,Stock Quantity 4,Multiwarehouse Code 5,Stock Quantity 5';
        //ArchSalida4.Write(TextoSalida1+TextoSalida2);
        OutStream.Write(TextoSalida1 + TextoSalida2);



        TextoSalida1 := 'Mandatory,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional';
        ///ArchSalida4.Write(TextoSalida1);
        OutStream.Write(TextoSalida1);


        TextoSalida1 := 'SKU is a unique identifier for each product variation. SKU value cannot be duplicated in a store.,' +
        'This is the price that the customer has to pay for the product. This price includes the taxes.,';
        TextoSalida2 := 'Sales Price for a Product for Promotion.,' +
        'Input Status value to change Sku status ' +
        'Input your product stock quantity.,';
        TextoSalida3 := 'The stock quantity should be equal or greater than order quantity.",' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida4 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida5 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida6 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida7 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida8 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);


        TextoSalida1 := 'Please input less than 200 characters.,' +
        'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,';
        TextoSalida2 := 'Special Price has to be lower than "Price" or else its not a sale offer. Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only delete active inactive and empty value are accepted.Empty value will skip this parameter.,';
        TextoSalida3 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida4 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida5 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida6 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida7 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida8 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);







        Item.Reset;
        if Item.FindSet then
            repeat
                SalesPrice.Reset;
                SalesPrice.SetRange("Item No.", Item."No.");
                SalesPrice.SetRange(SalesPrice."Sales Code", 'MRFLU');
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
                    SalesPrice2.SetRange("Sales Code", 'NAV0315');
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
                    SalesLineDiscount.SetRange("Sales Code", 'NAV0315');
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
                    ///tprecio3:=FORMAT(PRECIO);
                    tprecio3 := ConvertStr(Format(PRECIO), ',', '.');

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


                    TextoSalida1 := Format(Item."No.") + ',' +     ///// 1
                                  Format(tprecio3) + ',' +///// 2
                                  Format(tprecio2) + ',' +///// 3
                                  Format('') + ',' + ///// 4
                                  Format(tSTOCKWEB) + ',' + ///// 5
                                  Format('dropshipping') + ',' +    ///// 6
                                  Format(tSTOCKWEB) + ',' +/////7
                                  Format('') + ',' +///// 7
                                  Format('') + ',' +///// 8
                                  Format('') + ',' +///// 9
                                  Format('') + ',' +///// 10
                                  Format('') + ',' +///// 11
                                  Format('') + ',' +///// 12
                                  Format('') + ',' +///// 13
                                  Format('');    ///// 14







                    ///ArchSalida4.Write(TextoSalida1);
                    OutStream.Write(TextoSalida1);



                end;

            until Item.Next = 0;

        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(NOMDIR, 'UpdatePriceAndStock_Basic_MRFLU.csv', InStream);

    end;

    local procedure MIRAVIA_MRLAG()
    begin

        SalesReceivablesSetup.Get;

        ArchExt4 := 'c:\tmp\Miravia\UpdatePriceAndStock_Basic_MRLAG.csv';
        TempBlob.CreateOutStream(OutStream);



        TextoSalida1 := 'SellerSku,Price,SpecialPrice,Status,Default Stock Quantity,Multiwarehouse Code 1,' +
                      'Stock Quantity 1,Multiwarehouse Code 2,Stock Quantity 2,Multiwarehouse Code 3,';
        TextoSalida2 := 'Stock Quantity 3,Multiwarehouse Code 4,Stock Quantity 4,Multiwarehouse Code 5,Stock Quantity 5';
        ///ArchSalida4.Write(TextoSalida1+TextoSalida2);
        OutStream.Write(TextoSalida1 + TextoSalida2);
        ;



        TextoSalida1 := 'Mandatory,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional';
        ///ArchSalida4.Write(TextoSalida1);
        OutStream.Write(TextoSalida1);


        TextoSalida1 := 'SKU is a unique identifier for each product variation. SKU value cannot be duplicated in a store.,' +
        'This is the price that the customer has to pay for the product. This price includes the taxes.,';
        TextoSalida2 := 'Sales Price for a Product for Promotion.,' +
        'Input Status value to change Sku status ' +
        'Input your product stock quantity.,';
        TextoSalida3 := 'The stock quantity should be equal or greater than order quantity.",' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida4 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida5 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida6 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida7 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida8 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);


        TextoSalida1 := 'Please input less than 200 characters.,' +
        'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,';
        TextoSalida2 := 'Special Price has to be lower than "Price" or else its not a sale offer. Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only delete active inactive and empty value are accepted.Empty value will skip this parameter.,';
        TextoSalida3 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida4 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida5 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida6 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida7 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida8 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);








        Item.Reset;
        if Item.FindSet then
            repeat
                SalesPrice.Reset;
                SalesPrice.SetRange("Item No.", Item."No.");
                SalesPrice.SetRange(SalesPrice."Sales Code", 'MRLAG');
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
                    SalesPrice2.SetRange("Sales Code", 'NAV0322');
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
                    SalesLineDiscount.SetRange("Sales Code", 'NAV0322');
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
                    ///tprecio3:=FORMAT(PRECIO);
                    tprecio3 := ConvertStr(Format(PRECIO), ',', '.');

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


                    TextoSalida1 := Format(Item."No.") + ',' +     ///// 1
                                  Format(tprecio3) + ',' +///// 2
                                  Format(tprecio2) + ',' +///// 3
                                  Format('') + ',' + ///// 4
                                  Format(tSTOCKWEB) + ',' + ///// 5
                                  Format('dropshipping') + ',' +    ///// 6
                                  Format(tSTOCKWEB) + ',' +/////7
                                  Format('') + ',' +///// 7
                                  Format('') + ',' +///// 8
                                  Format('') + ',' +///// 9
                                  Format('') + ',' +///// 10
                                  Format('') + ',' +///// 11
                                  Format('') + ',' +///// 12
                                  Format('') + ',' +///// 13
                                  Format('');    ///// 14






                    ///ArchSalida4.Write(TextoSalida1);
                    OutStream.Write(TextoSalida1);


                end;

            until Item.Next = 0;

        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(NOMDIR, 'UpdatePriceAndStock_Basic_MRLAG.csv', InStream);

    end;

    local procedure MIRAVIA_MRMAR()
    begin

        SalesReceivablesSetup.Get;

        ArchExt4 := 'c:\tmp\Miravia\UpdatePriceAndStock_Basic_MRMAR.csv';
        TempBlob.CreateOutStream(OutStream);



        TextoSalida1 := 'SellerSku,Price,SpecialPrice,Status,Default Stock Quantity,Multiwarehouse Code 1,' +
                      'Stock Quantity 1,Multiwarehouse Code 2,Stock Quantity 2,Multiwarehouse Code 3,';
        TextoSalida2 := 'Stock Quantity 3,Multiwarehouse Code 4,Stock Quantity 4,Multiwarehouse Code 5,Stock Quantity 5';
        ///ArchSalida4.Write(TextoSalida1+TextoSalida2);
        OutStream.Write(TextoSalida1 + TextoSalida2);
        ;



        TextoSalida1 := 'Mandatory,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional';
        ///ArchSalida4.Write(TextoSalida1);
        OutStream.Write(TextoSalida1);


        TextoSalida1 := 'SKU is a unique identifier for each product variation. SKU value cannot be duplicated in a store.,' +
        'This is the price that the customer has to pay for the product. This price includes the taxes.,';
        TextoSalida2 := 'Sales Price for a Product for Promotion.,' +
        'Input Status value to change Sku status ' +
        'Input your product stock quantity.,';
        TextoSalida3 := 'The stock quantity should be equal or greater than order quantity.",' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida4 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida5 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida6 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida7 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida8 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);


        TextoSalida1 := 'Please input less than 200 characters.,' +
        'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,';
        TextoSalida2 := 'Special Price has to be lower than "Price" or else its not a sale offer. Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only delete active inactive and empty value are accepted.Empty value will skip this parameter.,';
        TextoSalida3 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida4 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida5 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida6 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida7 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida8 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);








        Item.Reset;
        if Item.FindSet then
            repeat
                SalesPrice.Reset;
                SalesPrice.SetRange("Item No.", Item."No.");
                SalesPrice.SetRange(SalesPrice."Sales Code", 'MRMAR');
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
                    SalesPrice2.SetRange("Sales Code", 'NAV0321');
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
                    SalesLineDiscount.SetRange("Sales Code", 'NAV0321');
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
                    ///tprecio3:=FORMAT(PRECIO);
                    tprecio3 := ConvertStr(Format(PRECIO), ',', '.');

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



                    TextoSalida1 := Format(Item."No.") + ',' +     ///// 1
                                  Format(tprecio3) + ',' +///// 2
                                  Format(tprecio2) + ',' +///// 3
                                  Format('') + ',' + ///// 4
                                  Format(tSTOCKWEB) + ',' + ///// 5
                                  Format('dropshipping') + ',' +    ///// 6
                                  Format(tSTOCKWEB) + ',' +/////7
                                  Format('') + ',' +///// 7
                                  Format('') + ',' +///// 8
                                  Format('') + ',' +///// 9
                                  Format('') + ',' +///// 10
                                  Format('') + ',' +///// 11
                                  Format('') + ',' +///// 12
                                  Format('') + ',' +///// 13
                                  Format('');    ///// 14







                    //ArchSalida4.Write(TextoSalida1);
                    OutStream.Write(TextoSalida1);


                end;

            until Item.Next = 0;

        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(NOMDIR, 'UpdatePriceAndStock_Basic_MRMAR.csv', InStream);


    end;

    local procedure MIRAVIA_MRTRO()
    begin

        SalesReceivablesSetup.Get;

        ArchExt4 := 'c:\tmp\Miravia\UpdatePriceAndStock_Basic_MRTRO.csv';
        TempBlob.CreateOutStream(OutStream);


        TextoSalida1 := 'SellerSku,Price,SpecialPrice,Status,Default Stock Quantity,Multiwarehouse Code 1,' +
                      'Stock Quantity 1,Multiwarehouse Code 2,Stock Quantity 2,Multiwarehouse Code 3,';
        TextoSalida2 := 'Stock Quantity 3,Multiwarehouse Code 4,Stock Quantity 4,Multiwarehouse Code 5,Stock Quantity 5';
        ///ArchSalida4.Write(TextoSalida1+TextoSalida2);
        OutStream.Write(TextoSalida1 + TextoSalida2);



        TextoSalida1 := 'Mandatory,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional';
        ///ArchSalida4.Write(TextoSalida1);
        OutStream.Write(TextoSalida1);


        TextoSalida1 := 'SKU is a unique identifier for each product variation. SKU value cannot be duplicated in a store.,' +
        'This is the price that the customer has to pay for the product. This price includes the taxes.,';
        TextoSalida2 := 'Sales Price for a Product for Promotion.,' +
        'Input Status value to change Sku status ' +
        'Input your product stock quantity.,';
        TextoSalida3 := 'The stock quantity should be equal or greater than order quantity.",' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida4 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida5 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida6 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida7 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida8 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);



        TextoSalida1 := 'Please input less than 200 characters.,' +
        'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,';
        TextoSalida2 := 'Special Price has to be lower than "Price" or else its not a sale offer. Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only delete active inactive and empty value are accepted.Empty value will skip this parameter.,';
        TextoSalida3 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida4 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida5 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida6 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida7 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida8 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);







        Item.Reset;
        if Item.FindSet then
            repeat
                SalesPrice.Reset;
                SalesPrice.SetRange("Item No.", Item."No.");
                SalesPrice.SetRange(SalesPrice."Sales Code", 'MRTRO');
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
                    SalesPrice2.SetRange("Sales Code", 'NAV0320');
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
                    SalesLineDiscount.SetRange("Sales Code", 'NAV0320');
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
                    ///tprecio3:=FORMAT(PRECIO);
                    tprecio3 := ConvertStr(Format(PRECIO), ',', '.');

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



                    TextoSalida1 := Format(Item."No.") + ',' +     ///// 1
                                  Format(tprecio3) + ',' +///// 2
                                  Format(tprecio2) + ',' +///// 3
                                  Format('') + ',' + ///// 4
                                  Format(tSTOCKWEB) + ',' + ///// 5
                                  Format('dropshipping') + ',' +    ///// 6
                                  Format(tSTOCKWEB) + ',' +/////7
                                  Format('') + ',' +///// 7
                                  Format('') + ',' +///// 8
                                  Format('') + ',' +///// 9
                                  Format('') + ',' +///// 10
                                  Format('') + ',' +///// 11
                                  Format('') + ',' +///// 12
                                  Format('') + ',' +///// 13
                                  Format('');    ///// 14







                    ///ArchSalida4.Write(TextoSalida1);
                    OutStream.Write(TextoSalida1);


                end;

            until Item.Next = 0;

        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(NOMDIR, 'UpdatePriceAndStock_Basic_MRTRO.csv', InStream);

    end;

    local procedure MIRAVIA_MRHAR()
    begin

        SalesReceivablesSetup.Get;

        ArchExt4 := 'c:\tmp\Miravia\UpdatePriceAndStock_Basic_MRHAR.csv';
        TempBlob.CreateOutStream(OutStream);



        TextoSalida1 := 'SellerSku,Price,SpecialPrice,Status,Default Stock Quantity,Multiwarehouse Code 1,' +
                      'Stock Quantity 1,Multiwarehouse Code 2,Stock Quantity 2,Multiwarehouse Code 3,';
        TextoSalida2 := 'Stock Quantity 3,Multiwarehouse Code 4,Stock Quantity 4,Multiwarehouse Code 5,Stock Quantity 5';
        ///ArchSalida4.Write(TextoSalida1+TextoSalida2);
        OutStream.Write(TextoSalida1 + TextoSalida2);



        TextoSalida1 := 'Mandatory,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional';
        ///ArchSalida4.Write(TextoSalida1);
        OutStream.Write(TextoSalida1);


        TextoSalida1 := 'SKU is a unique identifier for each product variation. SKU value cannot be duplicated in a store.,' +
        'This is the price that the customer has to pay for the product. This price includes the taxes.,';
        TextoSalida2 := 'Sales Price for a Product for Promotion.,' +
        'Input Status value to change Sku status ' +
        'Input your product stock quantity.,';
        TextoSalida3 := 'The stock quantity should be equal or greater than order quantity.",' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida4 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida5 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida6 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida7 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida8 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);


        TextoSalida1 := 'Please input less than 200 characters.,' +
        'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,';
        TextoSalida2 := 'Special Price has to be lower than "Price" or else its not a sale offer. Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only delete active inactive and empty value are accepted.Empty value will skip this parameter.,';
        TextoSalida3 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida4 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida5 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida6 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida7 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida8 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);



        Item.Reset;
        if Item.FindSet then
            repeat
                SalesPrice.Reset;
                SalesPrice.SetRange("Item No.", Item."No.");
                SalesPrice.SetRange(SalesPrice."Sales Code", 'MRHAR');
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
                    SalesPrice2.SetRange("Sales Code", 'NAV0323');
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
                    SalesLineDiscount.SetRange("Sales Code", 'NAV0323');
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
                    ///tprecio3:=FORMAT(PRECIO);
                    tprecio3 := ConvertStr(Format(PRECIO), ',', '.');

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



                    TextoSalida1 := Format(Item."No.") + ',' +     ///// 1
                                  Format(tprecio3) + ',' +///// 2
                                  Format(tprecio2) + ',' +///// 3
                                  Format('') + ',' + ///// 4
                                  Format(tSTOCKWEB) + ',' + ///// 5
                                  Format('dropshipping') + ',' +    ///// 6
                                  Format(tSTOCKWEB) + ',' +/////7
                                  Format('') + ',' +///// 7
                                  Format('') + ',' +///// 8
                                  Format('') + ',' +///// 9
                                  Format('') + ',' +///// 10
                                  Format('') + ',' +///// 11
                                  Format('') + ',' +///// 12
                                  Format('') + ',' +///// 13
                                  Format('');    ///// 14







                    ///ArchSalida4.Write(TextoSalida1);
                    OutStream.Write(TextoSalida1);


                end;

            until Item.Next = 0;

        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(NOMDIR, 'UpdatePriceAndStock_Basic_MRHAR.csv', InStream);

    end;

    local procedure MIRAVIA_MRLIV()
    begin
        SalesReceivablesSetup.Get;

        ArchExt4 := 'c:\tmp\Miravia\UpdatePriceAndStock_Basic_MRLIV.csv';
        TempBlob.CreateOutStream(OutStream);

        //ArchSalida4.TextMode := true;
        //ArchSalida4.WriteMode := true;
        //ArchSalida4.Create(ArchExt4);


        TextoSalida1 := 'SellerSku,Price,SpecialPrice,Status,Default Stock Quantity,Multiwarehouse Code 1,' +
                      'Stock Quantity 1,Multiwarehouse Code 2,Stock Quantity 2,Multiwarehouse Code 3,';
        TextoSalida2 := 'Stock Quantity 3,Multiwarehouse Code 4,Stock Quantity 4,Multiwarehouse Code 5,Stock Quantity 5';
        ///ArchSalida4.Write(TextoSalida1+TextoSalida2);
        OutStream.Write(TextoSalida1 + TextoSalida2);



        TextoSalida1 := 'Mandatory,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional,optional';
        ///ArchSalida4.Write(TextoSalida1);
        OutStream.Write(TextoSalida1);


        TextoSalida1 := 'SKU is a unique identifier for each product variation. SKU value cannot be duplicated in a store.,' +
        'This is the price that the customer has to pay for the product. This price includes the taxes.,';
        TextoSalida2 := 'Sales Price for a Product for Promotion.,' +
        'Input Status value to change Sku status ' +
        'Input your product stock quantity.,';
        TextoSalida3 := 'The stock quantity should be equal or greater than order quantity.",' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida4 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida5 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida6 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida7 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.,' +
        'Input your multiwarehouse code. You can get Multiwarehouse code from "Miravia Seller Center-My Account-Setting-Warehouse",';
        TextoSalida8 := 'Input your product stock quantity related to specific multiwarehouse. The stock quantity should be equal or greater than order quantity.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);


        TextoSalida1 := 'Please input less than 200 characters.,' +
        'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,';
        TextoSalida2 := 'Special Price has to be lower than "Price" or else its not a sale offer. Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only delete active inactive and empty value are accepted.Empty value will skip this parameter.,';
        TextoSalida3 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida4 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida5 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida6 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida7 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.,' +
        'Only positive numbers are accepted. Empty value will skip this parameter.,';
        TextoSalida8 := 'Only numbers(>0) and empty value are accepted. Empty value will skip this parameter.';

        ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5+TextoSalida6+TextoSalida7+TextoSalida8);
        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7 + TextoSalida8);







        Item.Reset;
        if Item.FindSet then
            repeat
                SalesPrice.Reset;
                SalesPrice.SetRange("Item No.", Item."No.");
                SalesPrice.SetRange(SalesPrice."Sales Code", 'MRLIV');
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
                    SalesPrice2.SetRange("Sales Code", 'NAV0324');
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
                    SalesLineDiscount.SetRange("Sales Code", 'NAV0324');
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
                    ///tprecio3:=FORMAT(PRECIO);
                    tprecio3 := ConvertStr(Format(PRECIO), ',', '.');

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



                    TextoSalida1 := Format(Item."No.") + ',' +     ///// 1
                                  Format(tprecio3) + ',' +///// 2
                                  Format(tprecio2) + ',' +///// 3
                                  Format('') + ',' + ///// 4
                                  Format(tSTOCKWEB) + ',' + ///// 5
                                  Format('dropshipping') + ',' +    ///// 6
                                  Format(tSTOCKWEB) + ',' +/////7
                                  Format('') + ',' +///// 7
                                  Format('') + ',' +///// 8
                                  Format('') + ',' +///// 9
                                  Format('') + ',' +///// 10
                                  Format('') + ',' +///// 11
                                  Format('') + ',' +///// 12
                                  Format('') + ',' +///// 13
                                  Format('');    ///// 14






                    OutStream.Write(TextoSalida1);


                end;

            until Item.Next = 0;

        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(NOMDIR, 'UpdatePriceAndStock_Basic_MRLIV.csv', InStream);

    end;
}

