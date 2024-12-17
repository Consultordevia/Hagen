#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50075 "Automaticos Catit estados NEW"
{

    Permissions = TableData "Sales Shipment Header" = rim;
    
    trigger OnRun()
    begin

        EstadoPreparadoNuevo;
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
        TextoSalida5: Text[250];
        TextoSalida6: Text[250];
        TextoSalida7: Text[250];
        TextoSalida8: Text[250];
        TextoSalida9: Text[250];
        TextoSalida10: Text[250];
        TextoSalida11: Text[250];
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
        DESDE1: Date;
        urltex: Text[250];
        nexpe: Code[50];
        ANSIASCIIconverter2: Codeunit "ANSI <-> ASCII converter2";
        PostCode: Record "Post Code";
        in_transit: Code[20];
        ADAIA: RECORD ADAIA;
        NOMDIR: TEXT;
        CarriageReturn: Char;
        LineFeed: Char;
        Data: BigText;
        OutTxt: Text;



    local procedure EstadoPreparadoNuevo()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        FileName: Text;
        InStream: InStream;
        FicherosHagen: Codeunit FicherosHagen;
    begin
        TempBlob.CreateOutStream(OutStream);



        SalesReceivablesSetup.Get;

        ArchExt4 := SalesReceivablesSetup."Ruta fiche. FTP" + 'catit\seguimiento\estadopedidos.csv';



        ArchExt4 := 'C:\tmp\json\catit\transporte\Orderscsv.csv';


        OutTxt :=
      'Name,' +
      'Command,' +
      'Send Receipt,' +
      'Inventory Behaviour,' +
      'Number,' +
      'Phone,' +
      'Email,' +
      'Note,' +
      'Tags,' +
      'Tags Command,' +
      'Cancelled At,' +
      'Cancel: Reason,' +
      'Cancel: Send Receipt,' +
      'Cancel: Refund,' +
      'Processed At,' +
      'Closed At,';
       data.AddText(OutTxt);
        OutTxt := 'Currency,' +
        'Source,' +
        'Source Identifier,' +
        'Source URL,' +
        'Weight Total,' +
        'Tax 1: Title,' +
        'Tax 1: Rate,' +
        'Tax 1: Price,' +
        'Tax 2: Title,' +
        'Tax 2: Rate,' +
        'Tax 2: Price,';
         data.AddText(OutTxt);
        OutTxt := 'Tax 3: Title,' +
        'Tax 3: Rate,' +
        'Tax 3: Price,' +
        'Tax: Included,' +
        'Tax: Total,' +
        'Payment: Status,' +
        'Additional Details,' +
        'Customer: ID,' +
        'Customer: Email,' +
        'Customer: Phone,' +
        'Customer: First Name,' +
        'Customer: Last Name,' +
        'Customer: Note,' +
        'Customer: State,' +
        'Customer: Tags,';
         data.AddText(OutTxt);
        OutTxt := 'Customer: Accepts Marketing,' +
        'Billing: First Name,' +
        'Billing: Last Name,' +
        'Billing: Name,' +
        'Billing: Company,' +
        'Billing: Phone,' +
        'Billing: Address 1,' +
        'Billing: Address 2,' +
        'Billing: Zip,' +
        'Billing: City,' +
        'Billing: Province,' +
        'Billing: Province Code,' +
        'Billing: Country,';
         data.AddText(OutTxt);
        OutTxt := 'Billing: Country Code,' +
        'Shipping: First Name,' +
        'Shipping: Last Name,' +
        'Shipping: Name,' +
        'Shipping: Company,' +
        'Shipping: Phone,' +
        'Shipping: Address 1,';
         data.AddText(OutTxt);
        OutTxt := 'Shipping: Address 2,' +
        'Shipping: Zip,' +
        'Shipping: City,' +
        'Shipping: Province,' +
        'Shipping: Province Code,' +
        'Shipping: Country,' +
        'Shipping: Country Code,' +
        'Line: Type,' +
        'Line: Command,' +
        'Line: Product ID,' +
        'Line: Product Handle,' +
        'Line: Title,';
         data.AddText(OutTxt);
        OutTxt := 'Line: Name,' +
       'Line: Variant ID,' +
       'Line: Variant Title,' +
       'Line: SKU,' +
       'Line: Quantity,' +
       'Line: Price,' +
       'Line: Discount,' +
       'Line: Grams,' +
       'Line: Requires Shipping,';
        data.AddText(OutTxt);
        OutTxt := 'Line: Vendor,' +
        'Line: Properties,' +
        'Line: Gift Card,' +
        'Line: Force Gift Card,' +
        'Line: Taxable,' +
        'Line: Tax 1 Title,' +
        'Line: Tax 1 Rate,' +
        'Line: Tax 1 Price,' +
        'Line: Tax 2 Title,' +
        'Line: Tax 2 Rate,' +
        'Line: Tax 2 Price,' +
        'Line: Tax 3 Title,' +
        'Line: Tax 3 Rate,';
         data.AddText(OutTxt);
        OutTxt := 'Line: Tax 3 Price,' +
        'Line: Fulfillment Service,' +
        'Line: Variant Barcode,' +
        'Refund: ID,' +
        'Refund: Created At,' +
        'Refund: Note,' +
        'Refund: Restock,' +
        'Refund: Restock Type,' +
        'Refund: Restock Location,' +
        'Refund: Send Receipt,' +
        'Refund: Generate Transaction,';
         data.AddText(OutTxt);
        OutTxt := 'Transaction: Kind,' +
        'Transaction: Processed At,' +
        'Transaction: Amount,' +
        'Transaction: Currency,' +
        'Transaction: Status,' +
        'Transaction: Gateway,' +
        'Transaction: Force Gateway,' +
        'Transaction: Test,' +
        'Transaction: Authorization,' +
        'Transaction: Parent ID,';
         data.AddText(OutTxt);
        OutTxt := 'Fulfillment: ID,' +
        'Fulfillment: Status,' +
        'Fulfillment: Processed At,' +
        'Fulfillment: Tracking Company,' +
        'Fulfillment: Location,' +
        'Fulfillment: Shipment Status,' +
        'Fulfillment: Tracking Number,' +
        'Fulfillment: Tracking URL,' +
        'Fulfillment: Send Receipt';        
        OutTxt += Format(CarriageReturn) + Format(LineFeed);
        data.AddText(OutTxt);


        DESDE1 := CalcDate('-1S', Today);

        SalesShipmentHeader.Reset;
        ///SalesShipmentHeader.SETRANGE("Posting Date",TODAY,TODAY);
        SalesShipmentHeader.SetRange("CSV enviado catit", false);
        SalesShipmentHeader.SetRange("Posting Date", 20240201D, Today);
        SalesShipmentHeader.SetFilter(SalesShipmentHeader."Grupo clientes", 'G52');
        if SalesShipmentHeader.FindSet then
            repeat
                if (CopyStr(SalesShipmentHeader."Your Reference", 1, 1) = 'C') or
                  (CopyStr(SalesShipmentHeader."Your Reference", 1, 1) = '0') or
                    (CopyStr(SalesShipmentHeader."Your Reference", 1, 1) = '1') or
                    (CopyStr(SalesShipmentHeader."Your Reference", 1, 1) = '2') or
                    (CopyStr(SalesShipmentHeader."Your Reference", 1, 1) = '3') or
                    (CopyStr(SalesShipmentHeader."Your Reference", 1, 1) = '4') or
                    (CopyStr(SalesShipmentHeader."Your Reference", 1, 1) = '5') or
                    (CopyStr(SalesShipmentHeader."Your Reference", 1, 1) = '6') or
                    (CopyStr(SalesShipmentHeader."Your Reference", 1, 1) = '7') or
                    (CopyStr(SalesShipmentHeader."Your Reference", 1, 1) = '8') or
                    (CopyStr(SalesShipmentHeader."Your Reference", 1, 1) = '9') then begin
                    ShippingAgent.Init;
                    if ShippingAgent.Get(SalesShipmentHeader."Shipping Agent Code") then begin
                        Clear(TextoSalida1);
                        Clear(TextoSalida2);
                        Clear(TextoSalida3);
                        Clear(TextoSalida4);
                        Clear(TextoSalida5);
                        ////Oscar te pongo el separador de ; a ,   porque en este fichero tiene que ir así

                        AA := Date2dmy(SalesShipmentHeader."Posting Date", 3);
                        MM := Date2dmy(SalesShipmentHeader."Posting Date", 2);
                        DD := Date2dmy(SalesShipmentHeader."Posting Date", 1);
                        AA1 := CopyStr(Format(AA), 1, 4);
                        MM1 := Format(MM);
                        DD1 := Format(DD);
                        if DD1 = '0' then DD1 := '00';
                        if DD1 = '1' then DD1 := '01';
                        if DD1 = '2' then DD1 := '02';
                        if DD1 = '3' then DD1 := '03';
                        if DD1 = '4' then DD1 := '04';
                        if DD1 = '5' then DD1 := '05';
                        if DD1 = '6' then DD1 := '06';
                        if DD1 = '7' then DD1 := '07';
                        if DD1 = '8' then DD1 := '08';
                        if DD1 = '9' then DD1 := '09';

                        if MM1 = '0' then MM1 := '00';
                        if MM1 = '1' then MM1 := '01';
                        if MM1 = '2' then MM1 := '02';
                        if MM1 = '3' then MM1 := '03';
                        if MM1 = '4' then MM1 := '04';
                        if MM1 = '5' then MM1 := '05';
                        if MM1 = '6' then MM1 := '06';
                        if MM1 = '7' then MM1 := '07';
                        if MM1 = '8' then MM1 := '08';
                        if MM1 = '9' then MM1 := '09';
                        if MM1 = '10' then MM1 := '10';
                        if MM1 = '11' then MM1 := '11';
                        if MM1 = '12' then MM1 := '12';

                        TextoSalida1 := Format(SalesShipmentHeader."Your Reference") + ',';
                        TextoSalida2 := Format(ShippingAgent.Name) + ',"';
                        if SalesShipmentHeader."Nº expedición dropshp" = '' then begin
                            TextoSalida3 := Format(SalesShipmentHeader."Nº expedición") + '",';
                        end;
                        if SalesShipmentHeader."Nº expedición dropshp" <> '' then begin
                            TextoSalida3 := Format(SalesShipmentHeader."Nº expedición dropshp") + '",';
                        end;
                        TextoSalida4 := AA1 + '-' + MM1 + '-' + DD1 + ',Completed';
                        Customer.Get(SalesShipmentHeader."Sell-to Customer No.");



                        PostCode.Init;
                        PostCode.Reset;
                        PostCode.SetRange(PostCode.Code, SalesShipmentHeader."Ship-to Post Code");
                        PostCode.SetRange(PostCode.City, UpperCase(SalesShipmentHeader."Ship-to City"));
                        if PostCode.FindFirst then begin
                            PostCode.CalcFields("Provincia shopyfi CALC");
                            if SalesShipmentHeader."Ship-to Post Code" = '2790-128' then begin
                                ///    ERROR('%1',PostCode."Provincia shopyfi CALC");
                            end;

                        end;







                        OutTxt :=
                                    Format(SalesShipmentHeader."Your Reference") + ',' +
                      'UPDATE,' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      '"' + SalesShipmentHeader."E-MAIL" + '",' +
                      ',' +
                      ',' +
                      'REPLACE,' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      '"' + SalesShipmentHeader."E-MAIL" + '",' +
                      '"' + Customer."Phone No." + '",' +
                      '"' + ANSIASCIIconverter2.Ascii2Ansi(SalesShipmentHeader."Sell-to Customer Name") + '",' +
                      ',' +
                      ',' +
                      ',' +
                      ',' +
                      ',';
                      data.AddText(OutTxt);



                        OutTxt :=
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        '"' + ANSIASCIIconverter2.Ascii2Ansi(SalesShipmentHeader."Sell-to Customer Name") + '",' +
                        ',' +
                        ',' +
                        Customer."Phone No." + ',' +
                        '"' + ANSIASCIIconverter2.Ascii2Ansi(SalesShipmentHeader."Ship-to Address" + SalesShipmentHeader."Ship-to Address 2") + '",' +
                        ',' +
                        '"' + SalesShipmentHeader."Ship-to Post Code" + '",' +
                        '"' + ANSIASCIIconverter2.Ascii2Ansi(SalesShipmentHeader."Ship-to City") + '",' +
                        '"' + ANSIASCIIconverter2.Ascii2Ansi(SalesShipmentHeader."Ship-to County") +
        ///'","'+FORMAT(PostCode."Provincia shopyfi CALC")+'"'+
        '","' + Format(SalesShipmentHeader."Provincia shopyfi") + '"' +
                        ',' +
                        '"' + ANSIASCIIconverter2.Ascii2Ansi(SalesShipmentHeader."Ship-to Country/Region Code") + '",' +
                        ',' +
                        'Fulfillment Line,' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',';
                        data.AddText(OutTxt);
                        OutTxt :=
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',';
                        data.AddText(OutTxt);
                        nexpe := SalesShipmentHeader."Shipping Agent Code";
                        nexpe := SalesShipmentHeader."Nº expedición";
                        if SalesShipmentHeader."Nº expedición dropshp" <> '' then begin
                            nexpe := SalesShipmentHeader."Nº expedición dropshp";
                        end;

                        //IF nexpe='' THEN BEGIN
                        //nexpe:=SalesShipmentHeader."Nº expedición";
                        //END;
                        urltex := '';
                        ShippingAgent.Get(SalesShipmentHeader."Shipping Agent Code");
                        urltex := ShippingAgent."Link transporte";
                        if ShippingAgent.Añadir = ShippingAgent.Añadir::"Nº expedicion" then begin
                            urltex := urltex + nexpe;
                        end;
                        if ShippingAgent.Añadir = ShippingAgent.Añadir::"Nº expedicion/Cod. postal" then begin
                            urltex := urltex + nexpe + '/' + SalesShipmentHeader."Sell-to Post Code";
                        end;
                        if ShippingAgent.Añadir = ShippingAgent.Añadir::"Nº expedicion+Cod. postal " then begin
                            urltex := urltex + nexpe + SalesShipmentHeader."Sell-to Post Code";
                        end;

                        if ShippingAgent.Añadir = 3 then begin
                            urltex := 'https://clientesparcel.dhl.es/seguimientoenvios/integra/SeguimientoDocumentos.aspx?codigo=' +
                                    Format(SalesShipmentHeader."Nº expedición") + '&anno=' + Format(Date2dmy(WorkDate, 3)) + '&lang=sp&refCli=1&cuenta=4855&agencia=46';
                            if SalesShipmentHeader."Nº expedición dropshp" <> '' then begin
                                urltex := 'https://clientesparcel.dhl.es/seguimientoenvios/integra/SeguimientoDocumentos.aspx?codigo=' +
                                         Format(SalesShipmentHeader."Nº expedición dropshp") + '&anno=' + Format(Date2dmy(WorkDate, 3)) + '&lang=sp&refCli=1&cuenta=4855&agencia=46';
                            end;
                        end;


                        in_transit := 'in_transit';


                        if (UpperCase(CopyStr(SalesShipmentHeader."Estado Expedicion", 1, 9)) = 'ENTREGADO') or (UpperCase(CopyStr(SalesShipmentHeader."Estado Expedicion", 1, 9)) = 'ENTREGADA') then begin
                            in_transit := 'delivered';
                        end;


                        OutTxt :=
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        ',' +
                        in_transit + ',' +
                        nexpe + ',' +
                        urltex + ',' +
                        ''; 
                        OutTxt += Format(CarriageReturn) + Format(LineFeed);
                        data.AddText(OutTxt);




                        OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4);

                        if (UpperCase(CopyStr(SalesShipmentHeader."Estado Expedicion", 1, 9)) = 'ENTREGADO') or (UpperCase(CopyStr(SalesShipmentHeader."Estado Expedicion", 1, 9)) = 'ENTREGADA') then begin
                            SalesShipmentHeader."CSV enviado catit" := true;
                            SalesShipmentHeader.Modify;
                        end;
                    end;
                end;
            until SalesShipmentHeader.Next = 0;

        SalesReceivablesSetup.Get;


        nomdir := '';
        ADAIA.Reset();
        ADAIA.SetRange(texto, 'AUTOMATICOS CATIT-ESTADOS-CU-50075');
        IF ADAIA.FindSet() THEN begin
            nomdir := ADAIA.Ruta;
        end;


        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(NOMDIR, 'Orderscsv.csv', InStream);


    end;
}

