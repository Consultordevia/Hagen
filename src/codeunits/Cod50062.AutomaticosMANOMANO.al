#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50062 "Automaticos MANOMANO"
{

    trigger OnRun()
    begin

        MANOMANO;


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
        PRECIO22: Decimal;
        tprecio4: Text;

    local procedure MANOMANO()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        FileName: Text;
        InStream: InStream;
        FicherosHagen: Codeunit FicherosHagen;
    begin
        TempBlob.CreateOutStream(OutStream);



        TextoSalida1 := 'sku;quantity;use_grid;carrier;shipping_time;product_price_vat_inc;shipping_price_vat_inc';


        OutStream.Write(TextoSalida1);







        Item.Reset;
        if Item.FindSet then
            repeat
                SalesPrice.Reset;
                SalesPrice.SetRange("Item No.", Item."No.");
                SalesPrice.SetRange(SalesPrice."Sales Code", 'MANO');
                if SalesPrice.FindFirst then begin
                    precio2 := SalesPrice."Unit Price";
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
                    tprecio4 := '0';
                    if precio2 <= 29.99 then begin
                        tprecio4 := '4,99';
                    end;
                    if (precio2 >= 30) and (precio2 <= 44.99) then begin
                        tprecio4 := '1,99';
                    end;


                    if STOCKWEB > 100 then begin
                        STOCKWEB := 100;
                    end;


                    tSTOCKWEB := '0';
                    tSTOCKWEB := ConvertStr(Format(STOCKWEB * 100, 15, Text1100009), ' ', '0');
                    tSTOCKWEB := CopyStr(tSTOCKWEB, 3, 11);
                    tSTOCKWEB := Format(STOCKWEB);



                    TextoSalida1 := Format(Item."No.") + ';' +     ///// 2
                                  Format(tSTOCKWEB) + ';' +///// 42
                                  '0;' +///// 42
                                  'SENDING;' +///// 42
                                  '1#3;' +///// 42
                                  Format(tprecio2) + ';' +
                                  Format(tprecio4);


                    OutStream.Write(TextoSalida1);


                end;

            until Item.Next = 0;


        SalesReceivablesSetup.Get;


        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero('E:/FICHEROSBC/tmp/manomano', 'MANOMANO-stock.csv', InStream);

    end;
}

