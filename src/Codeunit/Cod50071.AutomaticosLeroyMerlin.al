#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50071 "Automaticos Leroy Merlin"
{

    trigger OnRun()
    begin

        TiendaAnimal;

        Message('hecho');
        exit;
    end;

    var

        Item2: Record Item;
        Text1100009: label '<Integer>';
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        //ArchSalida4: File;
        ArchExt4: Text[250];
        Item: Record Item;
        TextoSalida1: Text[250];
        TextoSalida2: Text[250];
        TextoSalida3: Text[250];
        TextoSalida4: Text[250];
        TextoSalida5: Text[250];
        PRECIO: Decimal;
        SalesPrice: Record "Sales Price";
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
        fechainiDTO: Text;
        fechafinDTO: Text;
        mm1: Code[10];
        dd1: Code[10];
        mm: Integer;
        dd: Integer;
        adaia: Record adaia;
        nomdir: Text;

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

        ///TempBlob.CreateOutStream(OutStream);
        //ArchSalida4.TextMode := true;
        //ArchSalida4.WriteMode := true;
        //ArchSalida4.Create(ArchExt4);





        OutTxt := 'SKU de oferta;ID de producto;Tipo de ID de producto;Descripción de la oferta;Descripción interna de la oferta;Precio de la oferta;Información adicional sobre el precio de la oferta;Cantidad de la oferta;Alerta de cantidad mínima;';
        data.AddText(OutTxt);
        OutTxt := 'Estado de la oferta;Fecha de inicio de la disponibilidad;Fecha de finalización de la disponibilidad;Clase logística;Precio de descuento;Fecha de inicio del descuento;Fecha de finalización del descuento;';
        data.AddText(OutTxt);
        OutTxt := 'Plazo de envío (en días);Actualizar/Eliminar;Precio de oferta por canal 002;Precio de descuento por canal 002;Fecha de inicio del descuento para el canal 002;Fecha de fin del descuento para el canal 002;';
        data.AddText(OutTxt);
        OutTxt := 'Importe DEE;Importe DEE Italia;Importe DEE Bricoman Francia;Importe DEE LMES;Importe DEA;Precio sin IVA Bricoman FR;Precio con descuento sin IVA Bricoman FR;IVA LMFR;IVA BMFR;IVA LMIT;IVA LMES;País de almacenaje;';
        data.AddText(OutTxt);
        OutTxt := 'Oferta exclusiva para;Porcentaje de descuento LMFR;Porcentaje de descuento LMIT;Porcentaje de descuento BMFR;Porcentaje de descuento LMES';
        OutTxt += Format(CarriageReturn) + Format(LineFeed);
        data.AddText(OutTxt);


        //////ArchSalida4.WRITE(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4+TextoSalida5);

        OutTxt := 'sku;product-id;product-id-type;description;internal-description;price;price-additional-info;quantity;min-quantity-alert;state;available-start-date;available-end-date;logistic-class;';
        data.AddText(OutTxt);
        OutTxt := 'discount-price;discount-start-date;discount-end-date;leadtime-to-ship;update-delete;price[channel=002];discount-price[channel=002];discount-start-date[channel=002];discount-end-date[channel=002];';
        data.AddText(OutTxt);
        OutTxt := 'ecopart-amount;ecopart-amount-lmit;ecopart-amount-bmfr;ecopart-amount-lmes;dea-amount;no-tax-price-bmfr;no-tax-discount-price-bmfr;vat-lmfr;vat-bmfr;vat-lmit;vat-lmes;shipment-origin;exclusive-channels;';
        data.AddText(OutTxt);
        OutTxt := 'discount-percentage-lmfr;discount-percentage-lmit;discount-percentage-bmfr;discount-percentage-lmes';
        OutTxt += Format(CarriageReturn) + Format(LineFeed);
        data.AddText(OutTxt);


        ///OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4);



        Item.Reset;
        if Item.FindSet then
            repeat
                SalesPrice.Reset;
                SalesPrice.SetRange("Item No.", Item."No.");
                SalesPrice.SetRange(SalesPrice."Sales Code", 'LER');
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
                    SalesPrice2.SetRange("Sales Code", 'LER');
                    if SalesPrice2.FindFirst then begin
                        fechaini := SalesPrice2."Starting Date";
                        if fechaini = 0D THEN begin
                            fechaini := 20000101D;
                        end;
                        precio2 := SalesPrice2."Unit Price";

                        mm := Date2dmy(fechaini, 2);
                        dd := Date2dmy(fechaini, 1);
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

                        tfechaini := Format(Date2dmy(fechaini, 3)) + '-' + mm1 + '-' + dd1;


                        fechafin := SalesPrice2."Ending Date";
                        if fechafin = 0D THEN begin
                            fechafin := 20501231D;
                        end;

                        mm := Date2dmy(fechafin, 2);
                        dd := Date2dmy(fechafin, 1);
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

                        tfechafin := Format(Date2dmy(fechafin, 3)) + '-' + mm1 + '-' + dd1;

                    end;

                    dto := 0;
                    tprecio3 := '';
                    precio3 := 0;
                    fechafinDTO := '';
                    fechainiDTO := '';
                    SalesLineDiscount.Init;
                    SalesLineDiscount.Reset;
                    SalesLineDiscount.SetRange(Code, Item."No.");
                    SalesLineDiscount.SetRange("Sales Code", 'LM');
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

                        fechaini := SalesLineDiscount."Starting Date";
                        if fechaini = 0D THEN begin
                            fechaini := 20000101D;
                        end;


                        mm := Date2dmy(fechaini, 2);
                        dd := Date2dmy(fechaini, 1);
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


                        fechainiDTO := Format(Date2dmy(fechaini, 3)) + '-' + mm1 + '-' + dd1;



                        fechafin := SalesLineDiscount."Starting Date";
                        if fechafin = 0D THEN begin
                            fechafin := 20501231D;
                        end;


                        mm := Date2dmy(fechafin, 2);
                        dd := Date2dmy(fechafin, 1);
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

                        fechafinDTO := Format(Date2dmy(fechafin, 3)) + '-' + mm1 + '-' + dd1;





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
                                  Format('EAN') + ';' +///// 3
                                  Format('') + ';' +///// 4
                                  Format('') + ';' +///// 5
                                  Format(tprecio2) + ';' +///// 6
                                  Format('') + ';' +///// 7
                                  Format(STOCKWEB) + ';' +///// 9
                                  Format('') + ';' +///// 8
                                  Format('11') + ';' +///// 10
                                  Format('') + ';' +///// 11
                                  Format('') + ';' +///// 12
                                  Format('XXXS') + ';' +///// 13
                                  Format(tprecio3) + ';' +///// 14
                                  Format(fechainiDTO) + ';' +///// 15
                                  Format(fechafinDTO) + ';' +///// 16
                                  Format('2') + ';' +///// 17
                                  Format('') + ';' + ///// 18
                                  Format(tprecio2) + ';' +///// 19
                                  Format(tprecio3) + ';' +///// 20
                                  Format(fechainiDTO) + ';' +///// 21
                                  Format(fechafinDTO) + ';' +///// 22
                                  Format('') + ';' +   ///// 23
                                  Format('') + ';' +   ///// 24
                                  Format('') + ';' +   ///// 25
                                  Format('') + ';' +   ///// 26
                                  Format('') + ';' +   ///// 27
                                  Format('') + ';' +   ///// 28
                                  Format('') + ';' +   ///// 29
                                  Format('') + ';' +   ///// 30
                                  Format('') + ';' +   ///// 31
                                  Format('') + ';' +   ///// 32
                                  Format('Standard') + ';' +   ///// 33
                                  Format('ES') + ';' +   ///// 34
                                  Format('') + ';' +   ///// 35
                                  Format('') + ';' +   ///// 36
                                  Format('') + ';' +   ///// 37
                                  Format('') + ';' +   ///// 38
                                  Format('') + ';' +   ///// 39
                                  Format('');       ///// 40





                    ///OutStream.Write(TextoSalida1);
                    OutTxt += Format(CarriageReturn) + Format(LineFeed);
                    data.AddText(OutTxt);



                end;

            until Item.Next = 0;



        nomdir := '';
        ADAIA.Reset();
        ADAIA.SetRange(texto, 'AUTOMATICOS LEROY MERLIN-CU-50071');
        IF ADAIA.FindSet() THEN begin
            nomdir := ADAIA.Ruta;
        end;

        ///        TempBlob.CreateInStream(InStream);
        ///        FicherosHagen.CrearFichero(nomdir, 'LeroyMerlin.csv', InStream);

        Data.Write(OutStream);
        TempBlob.CreateInStream(InStream, TextEncoding::Windows);
        FicherosHagen.CrearFichero(nomdir, 'LeroyMerlin.csv', InStream, '50071 - TiendaAnimal');





    end;


}

