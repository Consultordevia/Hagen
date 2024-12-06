#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50055 "Fichero Stock.csv"
{
    // 2021-2


    trigger OnRun()
    begin

        CarriageReturn := 13; // 13 es el valor ASCII para Carriage Return (CR)
        LineFeed := 10;       // 10 es el valor ASCII para Line Feed (LF)

        Clear(TempBlob);
        TempBlob.CreateOutStream(OutStream, TextEncoding::Windows);


        ItemTemp.Reset;
        if ItemTemp.FindFirst then
            repeat
                ItemTemp.Delete;
            until ItemTemp.Next = 0;

        GrabaStock;

        Commit;

        ItemtempR.Reset;
        if ItemtempR.FindFirst then
            repeat
                ItemtempR.Delete;
            until ItemtempR.Next = 0;

        GrabaStock5;

        Commit;

        ItemtempR.Reset;
        if ItemtempR.FindFirst then
            repeat
                ItemtempR.Delete;
            until ItemtempR.Next = 0;

        /////GrabaStock4;

        Message('hecho');
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
        TextoSalida4: Text[250];
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
        ItemTemp: Record Item temporary;
        ItemtempR: Record "Item temp";
        FileDirectoryexcel: Text;
        SalesLineDiscount: Record "Sales Line Discount";
        contadto: Integer;
        contal: Integer;
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        FileName: Text;
        InStream: InStream;
        FicherosHagen: Codeunit FicherosHagen;
        CarriageReturn: Char;
        LineFeed: Char;
        Data: BigText;
        OutTxt: Text;
        ADAIA: Record adaia;
        NOMDIR: Text;
        RepItemTemporal: REPORT ItemTemporal;



    procedure GrabaStock()
    begin









        Item.Reset;
        Item.SetFilter(Item."Estado Producto", '0|1');
        Item.SetRange(Item."Excluir de dropbox", false);
        if Item.FindSet then
            repeat
                if Item."FIJO Excluir de dropbox" = false then begin
                    if RecGP.Get(Item."Gen. Prod. Posting Group") then begin
                        if RecGP."Es producto" then begin
                            IVA := 0;
                            if VATPostingSetup.Get('NACIONAL', Item."VAT Prod. Posting Group") then begin
                                IVA := VATPostingSetup."VAT+EC %";
                            end;
                            Item.CalcFields(Item."Tarifa 2022-2", Item."PVP Recomendado 2022-2");
                            Clear(TextoSalida1);
                            Clear(TextoSalida2);
                            Item.CalcFields(Inventory, "Existencia FOB", Item."Existencia SILLA", Item."Qty. on Sales Order");
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

                                if Item."Stock para Catit" <> 0 then begin
                                    DISPONI := DISPONI - Item."Stock para Catit";
                                end;

                                if (Item."Producto almacenable" = false) and (Item."Tiene productos asociados") then begin
                                    DISPONI := Item."Stock para la web";
                                end;

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
                                end;

                                Rec39.Reset;
                                Rec39.SetCurrentkey(Rec39."Document Type", Rec39."No.");
                                Rec39.SetRange(Rec39."Document Type", 1);
                                Rec39.SetRange(Rec39."No.", Item."No.");
                                Rec39.SetFilter(Rec39."Outstanding Quantity", '<>0');
                                if Rec39.FindSet then begin
                                    Rec38.Get(Rec39."Document Type", Rec39."Document No.");
                                    FECHARECEP := Rec38."E.T.Arrival";
                                end;
                                if FECHARECEP = 0D then begin
                                    Rec39.Reset;
                                    Rec39.SetCurrentkey(Rec39."Document Type", Rec39."No.");
                                    Rec39.SetRange(Rec39."Document Type", 0);
                                    Rec39.SetRange(Rec39."No.", Item."No.");
                                    Rec39.SetFilter(Rec39."Outstanding Quantity", '<>0');
                                    if Rec39.FindSet then begin
                                        Rec38.Get(Rec39."Document Type", Rec39."Document No.");
                                        FECHARECEP := Rec38."Expected Receipt Date";
                                    end;
                                end;
                                ///END;
                                CMARCA := '';
                                RecMt.Reset;
                                RecMt.SetRange(RecMt.Tabla, 24);
                                RecMt.SetRange(RecMt.Codigo, Item.Marca);
                                if RecMt.FindSet then begin
                                    CMARCA := RecMt.Descripcion;
                                end;
                                RecUMP.Init;
                                RecUMP.Reset;
                                RecUMP.SetRange(RecUMP."Item No.", Item."No.");
                                RecUMP.SetRange(RecUMP.Code, 'UDS');
                                if RecUMP.FindSet then begin
                                end;
                                RecMT2.Init;
                                if RecMT2.Get(12, Item."No.", '00000000') then begin
                                end;


                                /*
                                                 dtext1:=CASCII.Ascii2Ansi(Item.Description);
                                                 TextoSalida1:=FORMAT(Item.ean)+';'+
                                                               FORMAT(Item."No.")+';'+
                                                               FORMAT(dtext1)+';'+
                                                               FORMAT(Item."Estado Producto")+';';
                                                 TextoSalida2:=FORMAT(Item."Gen. Prod. Posting Group")+';'+
                                                               FORMAT(Item.Familia)+';'+
                                                               FORMAT(Item."Tarifa 2019")+';'+
                                                               FORMAT(Item."PVP Recomendado 2019")+';'+
                                                               FORMAT(DISPONI)+';'+
                                                               FORMAT(UNIMEDAD)+';'+
                                                               FORMAT(FECHARECEP)+';'+
                                                               FORMAT(RecUMP.Weight)+';'+
                                                               FORMAT(RecUMP.Length)+';'+
                                                               FORMAT(RecUMP.Width)+';'+
                                                               FORMAT(RecUMP.Height)+';'+
                                                               FORMAT(RecUMP.Cubage)+';'+
                                                               FORMAT(CMARCA)+';';
                                                 TextoSalida3:=FORMAT(Item."URL IMAGEN 1")+';'+
                                                               FORMAT(IVA)+'';

                                                ArchSalida4.WRITE(TextoSalida1+TextoSalida2+TextoSalida3);
                                */


                                dtext1 := CASCII.Ascii2Ansi(Item.Description);
                                ItemTemp."No. 2" := Item.ean;
                                ItemTemp."No." := Item."No.";
                                ItemTemp.Description := dtext1;
                                ItemTemp."Description 2" := Format(Item."Estado Producto");
                                dtext1 := CASCII.Ascii2Ansi(Item."Gen. Prod. Posting Group");
                                ItemTemp."Gen. Prod. Posting Group" := dtext1;
                                dtext1 := CASCII.Ascii2Ansi(Item.Familia);
                                ItemTemp.Familia := dtext1;
                                ItemTemp."Unit Price" := Item."Tarifa 2022-2";
                                ItemTemp."Unit Cost" := Item."PVP Recomendado 2022-2";
                                ItemTemp."Maximum Inventory" := DISPONI;
                                ItemTemp."Unidad compra" := UNIMEDAD;
                                ItemTemp."Descripcion web" := Format(FECHARECEP);
                                ItemTemp."Units per Parcel" := RecUMP.Weight;
                                ItemTemp."Gross Weight" := RecUMP.Length;
                                ItemTemp."Minimum Order Quantity" := RecUMP.Width;
                                ItemTemp."Maximum Order Quantity" := RecUMP.Height;
                                ItemTemp."Safety Stock Quantity" := RecUMP.Cubage;
                                ItemTemp."Tariff No." := CMARCA;
                                ItemTemp."URL IMAGEN 1" := Item."URL IMAGEN 1";
                                ItemTemp."Vendor No." := Format(IVA);
                                ItemTemp."Last Date Modified" := Item."Fecha Lanzamiento";
                                ItemTemp.Insert;






                            end;
                        end;
                    end;

                end;
            until Item.Next = 0;

        Commit;



        SalesReceivablesSetup.Get;

        ArchExt4 := SalesReceivablesSetup."Ruta fiche. FTP" + 'stock-CSV.CSV';


        ArchExt4 := 'c:\tmp\stock-CSV.CSV';


        ///if FILE.Exists(ArchExt4) then begin

        ///             FILE.Erase(ArchExt4);

        ///end;



        ArchExt4 := SalesReceivablesSetup."Ruta fiche. FTP" + 'stock-CSV.CSV';
        ArchExt4 := 'c:\tmp\stock-CSV.CSV';



        ///        ArchSalida4.TextMode := true;
        ///ArchSalida4.WriteMode := true;
        ///ArchSalida4.Create(ArchExt4);


        /////TextoSalida1:='ean;ref;descripcion;estado;linea;familia;tarifa 2019;'+
        /////                'pvr2019;disponibilidad;unidad minima venta;fecha recepcion esperada;'+
        /////                'peso;largo;ancho;alto;volumen;marca;URL imagen 1;IVA';

        OutTxt := 'Ean;Referencia;Descripcion;Estado;Línea;Familia;Tarifa;PVPR;Disponibilidad;Und. Mínimo Compra;Fecha Prox.;Pesos;Largo;Alto;Ancho;Volumen;Marca;URL imagen;Iva;Fecha Lanzamiento;' +
        'Cantidad_1;Descuento_1;Cantidad_2;Descuento_2;Cantidad_3;Descuento_3';
        ////        OutTxt += Format(CarriageReturn) + Format(LineFeed);
        ////data.AddText(OutTxt);








        ///             ArchSalida4.Write(TextoSalida1);



        ItemTemp.Reset;
        ItemTemp.SetCurrentkey("No. 2");
        if ItemTemp.FindSet then
            repeat

                TextoSalida4 := ';';
                SalesLineDiscount.Reset;
                SalesLineDiscount.SetRange(Code, ItemTemp."No.");
                SalesLineDiscount.SetRange(SalesLineDiscount."Sales Code", 'DC00');
                if SalesLineDiscount.FindSet then
                    repeat
                        TextoSalida4 := TextoSalida4 + Format(SalesLineDiscount."Minimum Quantity") + ';' + Format(SalesLineDiscount."Line Discount %") + ';';
                    until SalesLineDiscount.Next = 0;


                TextoSalida1 := Format(ItemTemp."No. 2") + ';' +
                              Format(ItemTemp."No.") + ';' +
                              Format(ItemTemp.Description) + ';' +
                              Format(ItemTemp."Description 2") + ';';
                TextoSalida2 := Format(ItemTemp."Gen. Prod. Posting Group") + ';' +
                              Format(ItemTemp.Familia) + ';' +
                              Format(ItemTemp."Unit Price") + ';' +
                              Format(ItemTemp."Unit Cost") + ';' +
                              Format(ItemTemp."Maximum Inventory") + ';' +
                              Format(ItemTemp."Unidad compra") + ';' +
                              Format(ItemTemp."Descripcion web") + ';' +
                              Format(ItemTemp."Units per Parcel") + ';' +
                              Format(ItemTemp."Gross Weight") + ';' +
                              Format(ItemTemp."Minimum Order Quantity") + ';' +
                              Format(ItemTemp."Maximum Order Quantity") + ';' +
                              Format(ItemTemp."Safety Stock Quantity") + ';' +
                              Format(ItemTemp."Tariff No.") + ';';
                TextoSalida3 := Format(ItemTemp."URL IMAGEN 1") + ';' +
                              Format(ItemTemp."Vendor No.") + ';' +
                              Format(ItemTemp."Last Date Modified");

            ///OutTxt:=TextoSalida1+TextoSalida2+TextoSalida3;
            ///OutTxt += Format(CarriageReturn) + Format(LineFeed);
            ////data.AddText(OutTxt);

            ///ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4);


            until ItemTemp.Next = 0;

        ///ArchSalida4.Close;

    end;


    procedure GrabaStock2()
    begin








        Item.Reset;
        Item.SetFilter(Item."Estado Producto", '0|1');
        Item.SetRange(Item."Excluir de dropbox", false);
        if Item.FindSet then
            repeat
                if Item."FIJO Excluir de dropbox" = false then begin
                    if RecGP.Get(Item."Gen. Prod. Posting Group") then begin
                        if RecGP."Es producto" then begin


                            IVA := 0;
                            if VATPostingSetup.Get('NACIONAL', Item."VAT Prod. Posting Group") then begin
                                IVA := VATPostingSetup."VAT+EC %";
                            end;
                            Item.CalcFields(Item."Tarifa 2022-2", Item."PVP Recomendado 2022-2");
                            Clear(TextoSalida1);
                            Clear(TextoSalida2);
                            Item.CalcFields(Inventory, "Existencia FOB", Item."Existencia SILLA", Item."Qty. on Sales Order");
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


                                if Item."Stock para Catit" <> 0 then begin
                                    DISPONI := DISPONI - Item."Stock para Catit";
                                end;
                                if (Item."Producto almacenable" = false) and (Item."Tiene productos asociados") then begin
                                    DISPONI := Item."Stock para la web";
                                end;


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
                                end;

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
                                ///END;
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


                                /*
                                                 dtext1:=CASCII.Ascii2Ansi(Item.Description);
                                                 TextoSalida1:=FORMAT(Item.ean)+';'+
                                                               FORMAT(Item."No.")+';'+
                                                               FORMAT(dtext1)+';'+
                                                               FORMAT(Item."Estado Producto")+';';
                                                 TextoSalida2:=FORMAT(Item."Gen. Prod. Posting Group")+';'+
                                                               FORMAT(Item.Familia)+';'+
                                                               FORMAT(Item."Tarifa 2019")+';'+
                                                               FORMAT(Item."PVP Recomendado 2019")+';'+
                                                               FORMAT(DISPONI)+';'+
                                                               FORMAT(UNIMEDAD)+';'+
                                                               FORMAT(FECHARECEP)+';'+
                                                               FORMAT(RecUMP.Weight)+';'+
                                                               FORMAT(RecUMP.Length)+';'+
                                                               FORMAT(RecUMP.Width)+';'+
                                                               FORMAT(RecUMP.Height)+';'+
                                                               FORMAT(RecUMP.Cubage)+';'+
                                                               FORMAT(CMARCA)+';';
                                                 TextoSalida3:=FORMAT(Item."URL IMAGEN 1")+';'+
                                                               FORMAT(IVA)+'';

                                                ArchSalida4.WRITE(TextoSalida1+TextoSalida2+TextoSalida3);
                                */



                                dtext1 := CASCII.Ascii2Ansi(Item.Description);
                                ItemtempR.Init;
                                ItemtempR."No. 2" := Item.ean;
                                ItemtempR."No." := Item."No.";
                                ItemtempR.Description := dtext1;
                                ItemtempR."Description 2" := Format(Item."Estado Producto");
                                dtext1 := CASCII.Ascii2Ansi(Item."Gen. Prod. Posting Group");
                                ItemtempR."Gen. Prod. Posting Group" := dtext1;
                                dtext1 := CASCII.Ascii2Ansi(Item.Familia);
                                ItemtempR.Familia := dtext1;
                                ItemtempR."Unit Price" := Item."Tarifa 2021";
                                ItemtempR."Unit Cost" := Item."PVP Recomendado 2021";
                                ItemtempR."Maximum Inventory" := DISPONI;
                                ItemtempR."Unidad compra" := UNIMEDAD;
                                ItemtempR."Descripcion web" := Format(FECHARECEP);
                                ItemtempR."Units per Parcel" := RecUMP.Weight;
                                ItemtempR."Gross Weight" := RecUMP.Length;
                                ItemtempR."Minimum Order Quantity" := RecUMP.Width;
                                ItemtempR."Maximum Order Quantity" := RecUMP.Height;
                                ItemtempR."Safety Stock Quantity" := RecUMP.Cubage;
                                ItemtempR."Tariff No." := CMARCA;
                                ItemtempR."URL IMAGEN 1" := Item."URL IMAGEN 1";
                                ItemtempR."Vendor No." := Format(IVA);
                                ItemtempR."Last Date Modified" := Item."Fecha Lanzamiento";
                                ItemtempR."IVA IGIC" := Item."IVA IGIC";
                                contadto := 0;
                                SalesLineDiscount.Reset;
                                SalesLineDiscount.SetRange(Code, ItemTemp."No.");
                                SalesLineDiscount.SetRange(SalesLineDiscount."Sales Code", 'DC00');
                                if SalesLineDiscount.FindFirst then
                                    repeat
                                        contadto := contadto + 1;
                                        if contadto = 1 then begin
                                            ItemtempR.Cantidad_1 := SalesLineDiscount."Minimum Quantity";
                                            ItemtempR.Descuento_1 := SalesLineDiscount."Line Discount %";
                                        end;
                                        if contadto = 2 then begin
                                            ItemtempR.Cantidad_2 := SalesLineDiscount."Minimum Quantity";
                                            ItemtempR.Descuento_2 := SalesLineDiscount."Line Discount %";
                                        end;
                                        if contadto = 3 then begin
                                            ItemtempR.Cantidad_3 := SalesLineDiscount."Minimum Quantity";
                                            ItemtempR.Descuento_3 := SalesLineDiscount."Line Discount %";
                                        end;


                                    until SalesLineDiscount.Next = 0;



                                ItemtempR.Insert;






                            end;
                        end;
                    end;

                end;
            until Item.Next = 0;

        Commit;



        SalesReceivablesSetup.Get;




        /////ArchExt4:='c:\tmp\TarifaStock2021 .CSV';


        /////IF FILE.EXISTS(ArchExt4) THEN BEGIN

        /////     FILE.ERASE(ArchExt4);

        /////END;




        /////ArchExt4:='c:\tmp\TarifaStock2021.CSV';



        /////ArchSalida4.TEXTMODE := TRUE;
        /////ArchSalida4.WRITEMODE := TRUE;
        /////ArchSalida4.CREATE(ArchExt4);


        /////TextoSalida1:='ean;ref;descripcion;estado;linea;familia;tarifa 2019;'+
        /////                'pvr2019;disponibilidad;unidad minima venta;fecha recepcion esperada;'+
        /////                'peso;largo;ancho;alto;volumen;marca;URL imagen 1;IVA';

        /////TextoSalida1:='Ean;Referencia;Descripcion;Estado;Línea;Familia;Tarifa;PVPR;Disponibilidad;Und. Mínimo Compra;Fecha Prox.;Pesos;Largo;Alto;Ancho;Volumen;Marca;URL imagen;Iva;Fecha Lanzamiento';







        /////                ArchSalida4.WRITE(TextoSalida1);

        /*
        
        ItemtempR.RESET;
        ItemtempR.SETCURRENTKEY("No. 2");
        IF ItemtempR.FINDFIRST THEN REPEAT
        
                         TextoSalida1:=FORMAT(ItemtempR."No. 2")+';'+
                                       FORMAT(ItemtempR."No.")+';'+
                                       FORMAT(ItemtempR.Description)+';'+
                                       FORMAT(ItemtempR."Description 2")+';';
                         TextoSalida2:=FORMAT(ItemtempR."Gen. Prod. Posting Group")+';'+
                                       FORMAT(ItemtempR.Familia)+';'+
                                       FORMAT(ItemtempR."Unit Price")+';'+
                                       FORMAT(ItemtempR."Unit Cost")+';'+
                                       FORMAT(ItemtempR."Maximum Inventory")+';'+
                                       FORMAT(ItemtempR."Unidad compra")+';'+
                                       FORMAT(ItemtempR."Descripcion web")+';'+
                                       FORMAT(ItemtempR."Units per Parcel")+';'+
                                       FORMAT(ItemtempR."Gross Weight")+';'+
                                       FORMAT(ItemtempR."Minimum Order Quantity")+';'+
                                       FORMAT(ItemtempR."Maximum Order Quantity")+';'+
                                       FORMAT(ItemtempR."Safety Stock Quantity")+';'+
                                       FORMAT(ItemtempR."Tariff No.")+';';
                         TextoSalida3:=FORMAT(ItemtempR."URL IMAGEN 1")+';'+
                                       FORMAT(ItemtempR."Vendor No.")+';'+
                                       FORMAT(ItemtempR."Last Date Modified");
        
        
             /////           ArchSalida4.WRITE(TextoSalida1+TextoSalida2+TextoSalida3);
        
        
        UNTIL ItemtempR.NEXT=0;
        
        /////ArchSalida4.CLOSE;
        
        
        */




        FileDirectoryexcel := 'c:\tmp\TarifaStock2021.xls';


        ItemtempR.Reset;
        ItemtempR.SetCurrentkey("No. 2");
        if ItemtempR.FindFirst then begin
            /////- Report.SaveAsExcel(50117,FileDirectoryexcel,ItemtempR);
        end;

    end;


    procedure GrabaStock3()
    begin

        Item.Reset;
        Item.SetFilter(Item."Estado Producto", '0|1');
        Item.SetRange(Item."Excluir de dropbox", false);
        if Item.FindSet then
            repeat
                if Item."FIJO Excluir de dropbox" = false then begin
                    if RecGP.Get(Item."Gen. Prod. Posting Group") then begin
                        if RecGP."Es producto" then begin
                            IVA := 0;
                            if VATPostingSetup.Get('NACIONAL', Item."VAT Prod. Posting Group") then begin
                                IVA := VATPostingSetup."VAT+EC %";
                            end;
                            Item.CalcFields(Item."Tarifa 2022-2", Item."PVP Recomendado 2022-2");
                            Clear(TextoSalida1);
                            Clear(TextoSalida2);
                            Item.CalcFields(Inventory, "Existencia FOB", Item."Existencia SILLA", Item."Qty. on Sales Order");
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

                                if Item."Stock para Catit" <> 0 then begin
                                    DISPONI := DISPONI - Item."Stock para Catit";
                                end;
                                if (Item."Producto almacenable" = false) and (Item."Tiene productos asociados") then begin
                                    DISPONI := Item."Stock para la web";
                                end;


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
                                end;

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
                                ///END;
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


                                /*
                                                 dtext1:=CASCII.Ascii2Ansi(Item.Description);
                                                 TextoSalida1:=FORMAT(Item.ean)+';'+
                                                               FORMAT(Item."No.")+';'+
                                                               FORMAT(dtext1)+';'+
                                                               FORMAT(Item."Estado Producto")+';';
                                                 TextoSalida2:=FORMAT(Item."Gen. Prod. Posting Group")+';'+
                                                               FORMAT(Item.Familia)+';'+
                                                               FORMAT(Item."Tarifa 2019")+';'+
                                                               FORMAT(Item."PVP Recomendado 2019")+';'+
                                                               FORMAT(DISPONI)+';'+
                                                               FORMAT(UNIMEDAD)+';'+
                                                               FORMAT(FECHARECEP)+';'+
                                                               FORMAT(RecUMP.Weight)+';'+
                                                               FORMAT(RecUMP.Length)+';'+
                                                               FORMAT(RecUMP.Width)+';'+
                                                               FORMAT(RecUMP.Height)+';'+
                                                               FORMAT(RecUMP.Cubage)+';'+
                                                               FORMAT(CMARCA)+';';
                                                 TextoSalida3:=FORMAT(Item."URL IMAGEN 1")+';'+
                                                               FORMAT(IVA)+'';

                                                ArchSalida4.WRITE(TextoSalida1+TextoSalida2+TextoSalida3);
                                */


                                dtext1 := CASCII.Ascii2Ansi(Item.Description);
                                ItemtempR.Init;
                                ItemtempR."No. 2" := Item.ean;
                                ItemtempR."No." := Item."No.";
                                ItemtempR.Description := dtext1;
                                ItemtempR."Description 2" := Format(Item."Estado Producto");
                                dtext1 := CASCII.Ascii2Ansi(Item."Gen. Prod. Posting Group");
                                ItemtempR."Gen. Prod. Posting Group" := dtext1;
                                dtext1 := CASCII.Ascii2Ansi(Item.Familia);
                                ItemtempR.Familia := dtext1;
                                ItemtempR."Unit Price" := Item."Tarifa 2021-2";
                                ItemtempR."Unit Cost" := Item."PVP Recomendado 2021-2";
                                ItemtempR."Maximum Inventory" := DISPONI;
                                ItemtempR."Unidad compra" := UNIMEDAD;
                                ItemtempR."Descripcion web" := Format(FECHARECEP);
                                ItemtempR."Units per Parcel" := RecUMP.Weight;
                                ItemtempR."Gross Weight" := RecUMP.Length;
                                ItemtempR."Minimum Order Quantity" := RecUMP.Width;
                                ItemtempR."Maximum Order Quantity" := RecUMP.Height;
                                ItemtempR."Safety Stock Quantity" := RecUMP.Cubage;
                                ItemtempR."Tariff No." := CMARCA;
                                ItemtempR."URL IMAGEN 1" := Item."URL IMAGEN 1";
                                ItemtempR."Vendor No." := Format(IVA);
                                ItemtempR."Last Date Modified" := Item."Fecha Lanzamiento";
                                ItemtempR."IVA IGIC" := Item."IVA IGIC";
                                contal := 0;
                                SalesLineDiscount.Reset;
                                SalesLineDiscount.SetRange(Code, Item."No.");
                                SalesLineDiscount.SetRange(SalesLineDiscount."Sales Code", 'DC00');
                                if SalesLineDiscount.FindFirst then
                                    repeat
                                        contal := contal + 1;
                                        if contal = 1 then begin
                                            ItemtempR.Cantidad_1 := SalesLineDiscount."Minimum Quantity";
                                            ItemtempR.Descuento_1 := SalesLineDiscount."Line Discount %";
                                        end;
                                        if contal = 1 then begin
                                            ItemtempR.Cantidad_2 := SalesLineDiscount."Minimum Quantity";
                                            ItemtempR.Descuento_2 := SalesLineDiscount."Line Discount %";
                                        end;
                                        if contal = 1 then begin
                                            ItemtempR.Cantidad_3 := SalesLineDiscount."Minimum Quantity";
                                            ItemtempR.Descuento_3 := SalesLineDiscount."Line Discount %";
                                        end;
                                    until SalesLineDiscount.Next = 0;

                                ItemtempR.Insert;
                            end;
                        end;
                    end;

                end;
            until Item.Next = 0;

        Commit;



        SalesReceivablesSetup.Get;




        /////ArchExt4:='c:\tmp\TarifaStock2021 .CSV';


        /////IF FILE.EXISTS(ArchExt4) THEN BEGIN

        /////     FILE.ERASE(ArchExt4);

        /////END;




        /////ArchExt4:='c:\tmp\TarifaStock2021.CSV';



        /////ArchSalida4.TEXTMODE := TRUE;
        /////ArchSalida4.WRITEMODE := TRUE;
        /////ArchSalida4.CREATE(ArchExt4);


        /////TextoSalida1:='ean;ref;descripcion;estado;linea;familia;tarifa 2019;'+
        /////                'pvr2019;disponibilidad;unidad minima venta;fecha recepcion esperada;'+
        /////                'peso;largo;ancho;alto;volumen;marca;URL imagen 1;IVA';

        /////TextoSalida1:='Ean;Referencia;Descripcion;Estado;Línea;Familia;Tarifa;PVPR;Disponibilidad;Und. Mínimo Compra;Fecha Prox.;Pesos;Largo;Alto;Ancho;Volumen;Marca;URL imagen;Iva;Fecha Lanzamiento';







        /////                ArchSalida4.WRITE(TextoSalida1);

        /*
        
        ItemtempR.RESET;
        ItemtempR.SETCURRENTKEY("No. 2");
        IF ItemtempR.FINDFIRST THEN REPEAT
        
                         TextoSalida1:=FORMAT(ItemtempR."No. 2")+';'+
                                       FORMAT(ItemtempR."No.")+';'+
                                       FORMAT(ItemtempR.Description)+';'+
                                       FORMAT(ItemtempR."Description 2")+';';
                         TextoSalida2:=FORMAT(ItemtempR."Gen. Prod. Posting Group")+';'+
                                       FORMAT(ItemtempR.Familia)+';'+
                                       FORMAT(ItemtempR."Unit Price")+';'+
                                       FORMAT(ItemtempR."Unit Cost")+';'+
                                       FORMAT(ItemtempR."Maximum Inventory")+';'+
                                       FORMAT(ItemtempR."Unidad compra")+';'+
                                       FORMAT(ItemtempR."Descripcion web")+';'+
                                       FORMAT(ItemtempR."Units per Parcel")+';'+
                                       FORMAT(ItemtempR."Gross Weight")+';'+
                                       FORMAT(ItemtempR."Minimum Order Quantity")+';'+
                                       FORMAT(ItemtempR."Maximum Order Quantity")+';'+
                                       FORMAT(ItemtempR."Safety Stock Quantity")+';'+
                                       FORMAT(ItemtempR."Tariff No.")+';';
                         TextoSalida3:=FORMAT(ItemtempR."URL IMAGEN 1")+';'+
                                       FORMAT(ItemtempR."Vendor No.")+';'+
                                       FORMAT(ItemtempR."Last Date Modified");
        
        
             /////           ArchSalida4.WRITE(TextoSalida1+TextoSalida2+TextoSalida3);
        
        
        UNTIL ItemtempR.NEXT=0;
        
        /////ArchSalida4.CLOSE;
        
        
        */




        FileDirectoryexcel := 'c:\tmp\TarifaStock2021-2.xls';


        ItemtempR.Reset;
        ItemtempR.SetCurrentkey("No. 2");
        if ItemtempR.FindFirst then begin
            /////- Report.SaveAsExcel(50117,FileDirectoryexcel,ItemtempR);
        end;

    end;


    procedure GrabaStock4()
    var
        OutStream: OutStream;
        InStream: InStream;
        TempBlob: Codeunit "Temp Blob";
    begin

        Item.Reset;
        Item.SetFilter(Item."Estado Producto", '0|1');
        Item.SetRange(Item."Excluir de dropbox", false);
        if Item.FindSet then
            repeat
                if Item."FIJO Excluir de dropbox" = false then begin
                    if RecGP.Get(Item."Gen. Prod. Posting Group") then begin
                        if RecGP."Es producto" then begin


                            IVA := 0;
                            if VATPostingSetup.Get('NACIONAL', Item."VAT Prod. Posting Group") then begin
                                IVA := VATPostingSetup."VAT+EC %";
                            end;
                            Item.CalcFields(Item."Tarifa 2022-2", Item."PVP Recomendado 2022-2");
                            Clear(TextoSalida1);
                            Clear(TextoSalida2);
                            Item.CalcFields(Inventory, "Existencia FOB", Item."Existencia SILLA", Item."Qty. on Sales Order");
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

                                if Item."Stock para Catit" <> 0 then begin
                                    DISPONI := DISPONI - Item."Stock para Catit";
                                end;
                                if (Item."Producto almacenable" = false) and (Item."Tiene productos asociados") then begin
                                    DISPONI := Item."Stock para la web";
                                end;


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
                                end;

                                Rec39.Reset;
                                Rec39.SetCurrentkey(Rec39."Document Type", Rec39."No.");
                                Rec39.SetRange(Rec39."Document Type", 1);
                                Rec39.SetRange(Rec39."No.", Item."No.");
                                Rec39.SetFilter(Rec39."Outstanding Quantity", '<>0');
                                if Rec39.FindSet then begin
                                    Rec38.Get(Rec39."Document Type", Rec39."Document No.");
                                    FECHARECEP := Rec38."E.T.Arrival";
                                end;
                                if FECHARECEP = 0D then begin
                                    Rec39.Reset;
                                    Rec39.SetCurrentkey(Rec39."Document Type", Rec39."No.");
                                    Rec39.SetRange(Rec39."Document Type", 0);
                                    Rec39.SetRange(Rec39."No.", Item."No.");
                                    Rec39.SetFilter(Rec39."Outstanding Quantity", '<>0');
                                    if Rec39.FindSet then begin
                                        Rec38.Get(Rec39."Document Type", Rec39."Document No.");
                                        FECHARECEP := Rec38."Expected Receipt Date";
                                    end;
                                end;
                                ///END;
                                CMARCA := '';
                                RecMt.Reset;
                                RecMt.SetRange(RecMt.Tabla, 24);
                                RecMt.SetRange(RecMt.Codigo, Item.Marca);
                                if RecMt.FindSet then begin
                                    CMARCA := RecMt.Descripcion;
                                end;
                                RecUMP.Init;
                                RecUMP.Reset;
                                RecUMP.SetRange(RecUMP."Item No.", Item."No.");
                                RecUMP.SetRange(RecUMP.Code, 'UDS');
                                if RecUMP.FindSet then begin
                                end;
                                RecMT2.Init;
                                if RecMT2.Get(12, Item."No.", '00000000') then begin
                                end;


                                /*
                                                 dtext1:=CASCII.Ascii2Ansi(Item.Description);
                                                 TextoSalida1:=FORMAT(Item.ean)+';'+
                                                               FORMAT(Item."No.")+';'+
                                                               FORMAT(dtext1)+';'+
                                                               FORMAT(Item."Estado Producto")+';';
                                                 TextoSalida2:=FORMAT(Item."Gen. Prod. Posting Group")+';'+
                                                               FORMAT(Item.Familia)+';'+
                                                               FORMAT(Item."Tarifa 2019")+';'+
                                                               FORMAT(Item."PVP Recomendado 2019")+';'+
                                                               FORMAT(DISPONI)+';'+
                                                               FORMAT(UNIMEDAD)+';'+
                                                               FORMAT(FECHARECEP)+';'+
                                                               FORMAT(RecUMP.Weight)+';'+
                                                               FORMAT(RecUMP.Length)+';'+
                                                               FORMAT(RecUMP.Width)+';'+
                                                               FORMAT(RecUMP.Height)+';'+
                                                               FORMAT(RecUMP.Cubage)+';'+
                                                               FORMAT(CMARCA)+';';
                                                 TextoSalida3:=FORMAT(Item."URL IMAGEN 1")+';'+
                                                               FORMAT(IVA)+'';

                                                ArchSalida4.WRITE(TextoSalida1+TextoSalida2+TextoSalida3);
                                */


                                dtext1 := CASCII.Ascii2Ansi(Item.Description);
                                ItemtempR.Init;
                                ItemtempR."No. 2" := Item.ean;
                                ItemtempR."No." := Item."No.";
                                ItemtempR.Description := dtext1;
                                ItemtempR."Description 2" := Format(Item."Estado Producto");
                                dtext1 := CASCII.Ascii2Ansi(Item."Gen. Prod. Posting Group");
                                ItemtempR."Gen. Prod. Posting Group" := dtext1;
                                dtext1 := CASCII.Ascii2Ansi(Item.Familia);
                                ItemtempR.Familia := dtext1;
                                ItemtempR."Unit Price" := Item."Tarifa 2022-2";
                                ItemtempR."Unit Cost" := Item."PVP Recomendado 2022-2";
                                ItemtempR."Maximum Inventory" := DISPONI;
                                ItemtempR."Unidad compra" := UNIMEDAD;
                                ItemtempR."Descripcion web" := Format(FECHARECEP);
                                ItemtempR."Units per Parcel" := RecUMP.Weight;
                                ItemtempR."Gross Weight" := RecUMP.Length;
                                ItemtempR."Minimum Order Quantity" := RecUMP.Width;
                                ItemtempR."Maximum Order Quantity" := RecUMP.Height;
                                ItemtempR."Safety Stock Quantity" := RecUMP.Cubage;
                                ItemtempR."Tariff No." := CMARCA;
                                ItemtempR."URL IMAGEN 1" := Item."URL IMAGEN 1";
                                ItemtempR."Vendor No." := Format(IVA);
                                ItemtempR."Last Date Modified" := Item."Fecha Lanzamiento";
                                ItemtempR."IVA IGIC" := Item."IVA IGIC";
                                contal := 0;
                                SalesLineDiscount.Reset;
                                SalesLineDiscount.SetRange(Code, Item."No.");
                                SalesLineDiscount.SetRange(SalesLineDiscount."Sales Code", 'DC00');
                                if SalesLineDiscount.FindSet then
                                    repeat
                                        contal := contal + 1;
                                        if contal = 1 then begin
                                            ItemtempR.Cantidad_1 := SalesLineDiscount."Minimum Quantity";
                                            ItemtempR.Descuento_1 := SalesLineDiscount."Line Discount %";
                                        end;
                                        if contal = 1 then begin
                                            ItemtempR.Cantidad_2 := SalesLineDiscount."Minimum Quantity";
                                            ItemtempR.Descuento_2 := SalesLineDiscount."Line Discount %";
                                        end;
                                        if contal = 1 then begin
                                            ItemtempR.Cantidad_3 := SalesLineDiscount."Minimum Quantity";
                                            ItemtempR.Descuento_3 := SalesLineDiscount."Line Discount %";
                                        end;
                                    until SalesLineDiscount.Next = 0;

                                ItemtempR.Insert;






                            end;
                        end;
                    end;

                end;
            until Item.Next = 0;

        Commit;



        SalesReceivablesSetup.Get;




        /////ArchExt4:='c:\tmp\TarifaStock2021 .CSV';


        /////IF FILE.EXISTS(ArchExt4) THEN BEGIN

        /////     FILE.ERASE(ArchExt4);

        /////END;




        /////ArchExt4:='c:\tmp\TarifaStock2021.CSV';



        /////ArchSalida4.TEXTMODE := TRUE;
        /////ArchSalida4.WRITEMODE := TRUE;
        /////ArchSalida4.CREATE(ArchExt4);


        /////TextoSalida1:='ean;ref;descripcion;estado;linea;familia;tarifa 2019;'+
        /////                'pvr2019;disponibilidad;unidad minima venta;fecha recepcion esperada;'+
        /////                'peso;largo;ancho;alto;volumen;marca;URL imagen 1;IVA';

        /////TextoSalida1:='Ean;Referencia;Descripcion;Estado;Línea;Familia;Tarifa;PVPR;Disponibilidad;Und. Mínimo Compra;Fecha Prox.;Pesos;Largo;Alto;Ancho;Volumen;Marca;URL imagen;Iva;Fecha Lanzamiento';







        /////                ArchSalida4.WRITE(TextoSalida1);

        /*
        
        ItemtempR.RESET;
        ItemtempR.SETCURRENTKEY("No. 2");
        IF ItemtempR.FINDFIRST THEN REPEAT
        
                         TextoSalida1:=FORMAT(ItemtempR."No. 2")+';'+
                                       FORMAT(ItemtempR."No.")+';'+
                                       FORMAT(ItemtempR.Description)+';'+
                                       FORMAT(ItemtempR."Description 2")+';';
                         TextoSalida2:=FORMAT(ItemtempR."Gen. Prod. Posting Group")+';'+
                                       FORMAT(ItemtempR.Familia)+';'+
                                       FORMAT(ItemtempR."Unit Price")+';'+
                                       FORMAT(ItemtempR."Unit Cost")+';'+
                                       FORMAT(ItemtempR."Maximum Inventory")+';'+
                                       FORMAT(ItemtempR."Unidad compra")+';'+
                                       FORMAT(ItemtempR."Descripcion web")+';'+
                                       FORMAT(ItemtempR."Units per Parcel")+';'+
                                       FORMAT(ItemtempR."Gross Weight")+';'+
                                       FORMAT(ItemtempR."Minimum Order Quantity")+';'+
                                       FORMAT(ItemtempR."Maximum Order Quantity")+';'+
                                       FORMAT(ItemtempR."Safety Stock Quantity")+';'+
                                       FORMAT(ItemtempR."Tariff No.")+';';
                         TextoSalida3:=FORMAT(ItemtempR."URL IMAGEN 1")+';'+
                                       FORMAT(ItemtempR."Vendor No.")+';'+
                                       FORMAT(ItemtempR."Last Date Modified");
        
        
             /////           ArchSalida4.WRITE(TextoSalida1+TextoSalida2+TextoSalida3);
        
        
        UNTIL ItemtempR.NEXT=0;
        
        /////ArchSalida4.CLOSE;
        
        
        */




        FileDirectoryexcel := 'c:\tmp\TarifaStock2022.xls';


        ItemtempR.Reset;
        ItemtempR.SetCurrentkey("No. 2");
        if ItemtempR.FindFirst then begin
            /////- Report.SaveAsExcel(50117,FileDirectoryexcel,ItemtempR);
        end;

    end;


    procedure GrabaStock5()
    begin

        Item.Reset;
        Item.SetFilter(Item."Estado Producto", '0|1');
        Item.SetRange(Item."Excluir de dropbox", false);
        if Item.FindSet then
            repeat
                if Item."FIJO Excluir de dropbox" = false then begin
                    if RecGP.Get(Item."Gen. Prod. Posting Group") then begin
                        if RecGP."Es producto" then begin


                            IVA := 0;
                            if VATPostingSetup.Get('NACIONAL', Item."VAT Prod. Posting Group") then begin
                                IVA := VATPostingSetup."VAT+EC %";
                            end;
                            Item.CalcFields(Item."Tarifa 2022-2", Item."PVP Recomendado 2022-2");
                            Clear(TextoSalida1);
                            Clear(TextoSalida2);
                            Item.CalcFields(Inventory, "Existencia FOB", Item."Existencia SILLA", Item."Qty. on Sales Order");
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

                                if Item."Stock para Catit" <> 0 then begin
                                    DISPONI := DISPONI - Item."Stock para Catit";
                                end;
                                if (Item."Producto almacenable" = false) and (Item."Tiene productos asociados") then begin
                                    DISPONI := Item."Stock para la web";
                                end;


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
                                end;

                                Rec39.Reset;
                                Rec39.SetCurrentkey(Rec39."Document Type", Rec39."No.");
                                Rec39.SetRange(Rec39."Document Type", 1);
                                Rec39.SetRange(Rec39."No.", Item."No.");
                                Rec39.SetFilter(Rec39."Outstanding Quantity", '<>0');
                                if Rec39.FindSet then begin
                                    Rec38.Get(Rec39."Document Type", Rec39."Document No.");
                                    FECHARECEP := Rec38."E.T.Arrival";
                                end;
                                if FECHARECEP = 0D then begin
                                    Rec39.Reset;
                                    Rec39.SetCurrentkey(Rec39."Document Type", Rec39."No.");
                                    Rec39.SetRange(Rec39."Document Type", 0);
                                    Rec39.SetRange(Rec39."No.", Item."No.");
                                    Rec39.SetFilter(Rec39."Outstanding Quantity", '<>0');
                                    if Rec39.FindSet then begin
                                        Rec38.Get(Rec39."Document Type", Rec39."Document No.");
                                        FECHARECEP := Rec38."Expected Receipt Date";
                                    end;
                                end;
                                ///END;
                                CMARCA := '';
                                RecMt.Reset;
                                RecMt.SetRange(RecMt.Tabla, 24);
                                RecMt.SetRange(RecMt.Codigo, Item.Marca);
                                if RecMt.FindSet then begin
                                    CMARCA := RecMt.Descripcion;
                                end;
                                RecUMP.Init;
                                RecUMP.Reset;
                                RecUMP.SetRange(RecUMP."Item No.", Item."No.");
                                RecUMP.SetRange(RecUMP.Code, 'UDS');
                                if RecUMP.FindSet then begin
                                end;
                                RecMT2.Init;
                                if RecMT2.Get(12, Item."No.", '00000000') then begin
                                end;


                                /*
                                                 dtext1:=CASCII.Ascii2Ansi(Item.Description);
                                                 TextoSalida1:=FORMAT(Item.ean)+';'+
                                                               FORMAT(Item."No.")+';'+
                                                               FORMAT(dtext1)+';'+
                                                               FORMAT(Item."Estado Producto")+';';
                                                 TextoSalida2:=FORMAT(Item."Gen. Prod. Posting Group")+';'+
                                                               FORMAT(Item.Familia)+';'+
                                                               FORMAT(Item."Tarifa 2019")+';'+
                                                               FORMAT(Item."PVP Recomendado 2019")+';'+
                                                               FORMAT(DISPONI)+';'+
                                                               FORMAT(UNIMEDAD)+';'+
                                                               FORMAT(FECHARECEP)+';'+
                                                               FORMAT(RecUMP.Weight)+';'+
                                                               FORMAT(RecUMP.Length)+';'+
                                                               FORMAT(RecUMP.Width)+';'+
                                                               FORMAT(RecUMP.Height)+';'+
                                                               FORMAT(RecUMP.Cubage)+';'+
                                                               FORMAT(CMARCA)+';';
                                                 TextoSalida3:=FORMAT(Item."URL IMAGEN 1")+';'+
                                                               FORMAT(IVA)+'';

                                                ArchSalida4.WRITE(TextoSalida1+TextoSalida2+TextoSalida3);
                                */


                                dtext1 := CASCII.Ascii2Ansi(Item.Description);
                                ItemtempR.Init;
                                ItemtempR."No. 2" := Item.ean;
                                ItemtempR."No." := Item."No.";
                                ItemtempR.Description := dtext1;
                                ItemtempR."Description 2" := Format(Item."Estado Producto");
                                dtext1 := CASCII.Ascii2Ansi(Item."Gen. Prod. Posting Group");
                                ItemtempR."Gen. Prod. Posting Group" := dtext1;
                                dtext1 := CASCII.Ascii2Ansi(Item.Familia);
                                ItemtempR.Familia := dtext1;
                                ItemtempR."Unit Price" := Item."Tarifa 2022-2";
                                ItemtempR."Unit Cost" := Item."PVP Recomendado 2022-2";
                                ItemtempR."Maximum Inventory" := DISPONI;
                                ItemtempR."Unidad compra" := UNIMEDAD;
                                ItemtempR."Descripcion web" := Format(FECHARECEP);
                                ItemtempR."Units per Parcel" := RecUMP.Weight;
                                ItemtempR."Gross Weight" := RecUMP.Length;
                                ItemtempR."Minimum Order Quantity" := RecUMP.Width;
                                ItemtempR."Maximum Order Quantity" := RecUMP.Height;
                                ItemtempR."Safety Stock Quantity" := RecUMP.Cubage;
                                ItemtempR."Tariff No." := CMARCA;
                                ItemtempR."URL IMAGEN 1" := Item."URL IMAGEN 1";
                                ItemtempR."Vendor No." := Format(IVA);
                                ItemtempR."Last Date Modified" := Item."Fecha Lanzamiento";
                                ItemtempR."IVA IGIC" := Item."IVA IGIC";
                                contal := 0;
                                SalesLineDiscount.Reset;
                                SalesLineDiscount.SetRange(Code, Item."No.");
                                SalesLineDiscount.SetRange(SalesLineDiscount."Sales Code", 'DC00');
                                if SalesLineDiscount.FindSet then
                                    repeat
                                        contal := contal + 1;
                                        if contal = 1 then begin
                                            ItemtempR.Cantidad_1 := SalesLineDiscount."Minimum Quantity";
                                            ItemtempR.Descuento_1 := SalesLineDiscount."Line Discount %";
                                        end;
                                        if contal = 1 then begin
                                            ItemtempR.Cantidad_2 := SalesLineDiscount."Minimum Quantity";
                                            ItemtempR.Descuento_2 := SalesLineDiscount."Line Discount %";
                                        end;
                                        if contal = 1 then begin
                                            ItemtempR.Cantidad_3 := SalesLineDiscount."Minimum Quantity";
                                            ItemtempR.Descuento_3 := SalesLineDiscount."Line Discount %";
                                        end;
                                    until SalesLineDiscount.Next = 0;

                                ItemtempR.Insert;






                            end;
                        end;
                    end;

                end;
            until Item.Next = 0;

        Commit;



        SalesReceivablesSetup.Get;




        /////ArchExt4:='c:\tmp\TarifaStock2021 .CSV';


        /////IF FILE.EXISTS(ArchExt4) THEN BEGIN

        /////     FILE.ERASE(ArchExt4);

        /////END;




        /////ArchExt4:='c:\tmp\TarifaStock2021.CSV';



        /////ArchSalida4.TEXTMODE := TRUE;
        /////ArchSalida4.WRITEMODE := TRUE;
        /////ArchSalida4.CREATE(ArchExt4);


        /////TextoSalida1:='ean;ref;descripcion;estado;linea;familia;tarifa 2019;'+
        /////                'pvr2019;disponibilidad;unidad minima venta;fecha recepcion esperada;'+
        /////                'peso;largo;ancho;alto;volumen;marca;URL imagen 1;IVA';

        /////TextoSalida1:='Ean;Referencia;Descripcion;Estado;Línea;Familia;Tarifa;PVPR;Disponibilidad;Und. Mínimo Compra;Fecha Prox.;Pesos;Largo;Alto;Ancho;Volumen;Marca;URL imagen;Iva;Fecha Lanzamiento';







        /////                ArchSalida4.WRITE(TextoSalida1);

        /*
        
        ItemtempR.RESET;
        ItemtempR.SETCURRENTKEY("No. 2");
        IF ItemtempR.FINDFIRST THEN REPEAT
        
                         TextoSalida1:=FORMAT(ItemtempR."No. 2")+';'+
                                       FORMAT(ItemtempR."No.")+';'+
                                       FORMAT(ItemtempR.Description)+';'+
                                       FORMAT(ItemtempR."Description 2")+';';
                         TextoSalida2:=FORMAT(ItemtempR."Gen. Prod. Posting Group")+';'+
                                       FORMAT(ItemtempR.Familia)+';'+
                                       FORMAT(ItemtempR."Unit Price")+';'+
                                       FORMAT(ItemtempR."Unit Cost")+';'+
                                       FORMAT(ItemtempR."Maximum Inventory")+';'+
                                       FORMAT(ItemtempR."Unidad compra")+';'+
                                       FORMAT(ItemtempR."Descripcion web")+';'+
                                       FORMAT(ItemtempR."Units per Parcel")+';'+
                                       FORMAT(ItemtempR."Gross Weight")+';'+
                                       FORMAT(ItemtempR."Minimum Order Quantity")+';'+
                                       FORMAT(ItemtempR."Maximum Order Quantity")+';'+
                                       FORMAT(ItemtempR."Safety Stock Quantity")+';'+
                                       FORMAT(ItemtempR."Tariff No.")+';';
                         TextoSalida3:=FORMAT(ItemtempR."URL IMAGEN 1")+';'+
                                       FORMAT(ItemtempR."Vendor No.")+';'+
                                       FORMAT(ItemtempR."Last Date Modified");
        
        
             /////           ArchSalida4.WRITE(TextoSalida1+TextoSalida2+TextoSalida3);
        
        
        UNTIL ItemtempR.NEXT=0;
        
        /////ArchSalida4.CLOSE;
        
        
        */


        nomdir := '';
        ADAIA.Reset();
        ADAIA.SetRange(texto, 'AUTOMATICO STOCKCSV-CU-50055');
        IF ADAIA.FindSet() THEN begin
            nomdir := ADAIA.Ruta;
        end;

        Data.Write(OutStream);




        /////FileDirectoryexcel := 'c:\tmp\TarifaStock2022-2.xls';


        Clear(RepItemTemporal);
        RepItemTemporal.UseRequestPage(false);
        TempBlob.CreateOutStream(OutStream);
        if not RepItemTemporal.SaveAs('', ReportFormat::Excel, OutStream) then
            Error('ERROR');

        tempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(nomdir, 'TarifaStock2022-2.xls', InStream);



    end;
}

