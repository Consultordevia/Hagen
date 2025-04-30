#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50067 "Automaticos Carrefour"

{

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
        mm: Integer;
        dd: Integer;
        mm1: Code[10];
        dd1: Code[10];
        fechainiDTO: Text;
        fechafinDTO: Text;
        adaia: Record adaia;
        nomdir: text;

    local procedure TiendaAnimal()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        FileName: Text;
        InStream: InStream;
        FicherosHagen: Codeunit FicherosHagen;
        CarriageReturn: Char;
        LineFeed: Char;
        Data: BigText;
        OutTxt: Text;

    begin
        
        CarriageReturn := 13; // 13 es el valor ASCII para Carriage Return (CR)
        LineFeed := 10;       // 10 es el valor ASCII para Line Feed (LF)

        Clear(TempBlob);
        TempBlob.CreateOutStream(OutStream, TextEncoding::Windows);


///        TempBlob.CreateOutStream(OutStream);






        SalesReceivablesSetup.Get;





        /*
        TextoSalida1:='SKU de oferta;ID de producto;Tipo de ID de producto;Descripción de la oferta;Descripción interna de la oferta;Precio de la oferta;';
        TextoSalida2:='Información adicional sobre el precio de la oferta;Cantidad de la oferta;Alerta de cantidad mínima;Estado de la oferta;Fecha de inicio de la disponibilidad;';
        TextoSalida3:='Fecha de finalización de la disponibilidad;Clase logística;Precio de descuento;Fecha de inicio del descuento;Fecha de finalización del descuento;Plazo de envío;Actualizar/Eliminar';
        
        TextoSalida1:='sku;product-id;product-id-type;description;internal-description;price;price-additional-info;quantity;min-quantity-alert;state;available-start-date;available-end-date;logistic-class;';
        TextoSalida2:='discount-price;discount-start-date;discount-end-date;leadtime-to-ship;update-delete';
        */




        OutTxt := 'sku;product-id;product-id-type;description;internal-description;price;price-additional-info;quantity;min-quantity-alert;state;available-start-date;';
        data.AddText(OutTxt);
        OutTxt := 'available-end-date;logistic-class;favorite-rank;discount-start-date;discount-end-date;discount-price;update-delete';
        OutTxt += Format(CarriageReturn) + Format(LineFeed);
        data.AddText(OutTxt);



        ///OutStream.Write(TextoSalida1 + TextoSalida2);






        Item.Reset;
        if Item.FindSet then
            repeat
                SalesPrice.Reset;
                SalesPrice.SetRange("Item No.", Item."No.");
                SalesPrice.SetRange(SalesPrice."Sales Code", 'CARRE');
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
                    SalesPrice2.SetRange("Sales Code", 'CARRE');                     
                    if SalesPrice2.FindFirst then begin
                        fechaini := SalesPrice2."Starting Date";
                        precio2 := SalesPrice2."Unit Price";

                        tfechaini := Format(Date2dmy(fechaini, 3)) + '-' +
                                   Format(Date2dmy(fechaini, 2)) + '-' +
                                   Format(Date2dmy(fechaini, 1));
                        fechafin := SalesPrice2."Ending Date";
                        tfechaini := Format(Date2dmy(fechaini, 3)) + '-' +
                                   Format(Date2dmy(fechaini, 2)) + '-' +
                                   Format(Date2dmy(fechaini, 1));

                    end;

                    dto := 0;
                    tprecio3 := '';
                    precio3 := 0;
                    fechafinDTO := '';
                    fechainiDTO := '';

                    SalesLineDiscount.Reset;
                    SalesLineDiscount.SetRange(Code, Item."No.");
                    SalesLineDiscount.SetRange("Sales Code", 'CARR');
                    SalesLineDiscount.SetFilter("Ending Date", '%1|>=%2', 0D, Today);
                    if SalesLineDiscount.FindLast then begin
                        dto := SalesLineDiscount."Line Discount %";


                        precio3 := precio2;
                        precio3 := precio3 - ROUND(precio3 * dto / 100, 0.01);

                        tprecio3 := '';
                        tprecio3 := ConvertStr(Format(precio3 * 100, 15, Text1100009), ' ', '0');
                        tprecio3 := CopyStr(tprecio3, 3, 11) + '.' + CopyStr(tprecio3, 14, 2);
                        tprecio3 := Format(precio3);
                        if precio3 = 0 then begin
                            tprecio3 := '';
                        end;


                        mm := Date2dmy(SalesLineDiscount."Starting Date", 2);
                        dd := Date2dmy(SalesLineDiscount."Starting Date", 1);
                        mm1 := Format(mm);
                        dd1 := Format(dd);

                        if dd1 = '0' then dd1 := '00';
                        if dd1 = '1' then dd1 := '01';
                        if dd1 = '2' then dd1 := '02';
                        if dd1 = '3' then dd1 := '03';
                        if dd1 = '4' then dd1 := '04';
                        if dd1 = '5' then dd1 := '05';
                        if dd1 = '6' then dd1 := '06';
                        if dd1 = '7' then dd1 := '07';
                        if dd1 = '8' then dd1 := '08';
                        if dd1 = '9' then dd1 := '09';

                        if mm1 = '0' then mm1 := '00';
                        if mm1 = '1' then mm1 := '01';
                        if mm1 = '2' then mm1 := '02';
                        if mm1 = '3' then mm1 := '03';
                        if mm1 = '4' then mm1 := '04';
                        if mm1 = '5' then mm1 := '05';
                        if mm1 = '6' then mm1 := '06';
                        if mm1 = '7' then mm1 := '07';
                        if mm1 = '8' then mm1 := '08';
                        if mm1 = '9' then mm1 := '09';
                        if mm1 = '10' then mm1 := '10';
                        if mm1 = '11' then mm1 := '11';
                        if mm1 = '12' then mm1 := '12';


                        fechainiDTO := Format(Date2dmy(SalesLineDiscount."Starting Date", 3)) + '-' + mm1 + '-' + dd1;



                        mm := Date2dmy(SalesLineDiscount."Ending Date", 2);
                        dd := Date2dmy(SalesLineDiscount."Ending Date", 1);
                        mm1 := Format(mm);
                        dd1 := Format(dd);

                        if dd1 = '0' then dd1 := '00';
                        if dd1 = '1' then dd1 := '01';
                        if dd1 = '2' then dd1 := '02';
                        if dd1 = '3' then dd1 := '03';
                        if dd1 = '4' then dd1 := '04';
                        if dd1 = '5' then dd1 := '05';
                        if dd1 = '6' then dd1 := '06';
                        if dd1 = '7' then dd1 := '07';
                        if dd1 = '8' then dd1 := '08';
                        if dd1 = '9' then dd1 := '09';

                        if mm1 = '0' then mm1 := '00';
                        if mm1 = '1' then mm1 := '01';
                        if mm1 = '2' then mm1 := '02';
                        if mm1 = '3' then mm1 := '03';
                        if mm1 = '4' then mm1 := '04';
                        if mm1 = '5' then mm1 := '05';
                        if mm1 = '6' then mm1 := '06';
                        if mm1 = '7' then mm1 := '07';
                        if mm1 = '8' then mm1 := '08';
                        if mm1 = '9' then mm1 := '09';
                        if mm1 = '10' then mm1 := '10';
                        if mm1 = '11' then mm1 := '11';
                        if mm1 = '12' then mm1 := '12';

                        fechafinDTO := Format(Date2dmy(SalesLineDiscount."Ending Date", 3)) + '-' + mm1 + '-' + dd1;



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

                    ///tprecio3:='0';
                    ///tprecio3:=CONVERTSTR(FORMAT(PRECIO*100,15,Text1100009),' ','0');
                    ///tprecio3:=COPYSTR(tprecio3,3,11)+'.'+COPYSTR(tprecio3,14,2);
                    ///tprecio3:=FORMAT(PRECIO);

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



                    OutTxt := Format(Item."No.") + ';' +     ///// 1
                                  Format('0' + Item.ean) + ';' +///// 2
                                  Format('SKU') + ';' +///// 3
                                  Format('') + ';' +///// 4
                                  Format('') + ';' +///// 5
                                  Format(tprecio2) + ';' +///// 6
                                  Format('') + ';' +///// 7
                                  Format(STOCKWEB) + ';' +///// 8
                                  Format('') + ';' +///// 9
                                  Format('11') + ';' +///// 10
                                  Format('') + ';' +///// 11
                                  Format('') + ';' +///// 12
                                  Format('') + ';' +///// 13
                                  Format('') + ';' +///// 14
                                  Format(fechainiDTO) + ';' +///// 15
                                  Format(fechafinDTO) + ';' +///// 16
                                  Format(tprecio3) + ';' +///// 17
                                  Format('update'); ///// 18




                    ///OutStream.Write(TextoSalida1);
                    OutTxt += Format(CarriageReturn) + Format(LineFeed);
                    data.AddText(OutTxt);


                end;

            until Item.Next = 0;


        nomdir := '';
        ADAIA.Reset();
        ADAIA.SetRange(texto, 'AUTOMATICOS CARREFOUR-CU-50067');
        IF ADAIA.FindSet() THEN begin
            nomdir := ADAIA.Ruta;
        end;
        ///TempBlob.CreateInStream(InStream);
        ///FicherosHagen.CrearFichero(nomdir, 'carrefour.csv', InStream);

        Data.Write(OutStream);
        TempBlob.CreateInStream(InStream, TextEncoding::Windows);
        FicherosHagen.CrearFichero(nomdir, 'carrefour.csv', InStream);



    end;
}

