#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50083 "AutomaticosBC"
{

    trigger OnRun()
    begin
        /*
        dato1:=11123.99;
        
        d1:=ROUND(dato1,1,'<');
        
        //MESSAGE('%1',(dato1-d1)*100);
        resto:=ABS((dato1-d1)*100);
        cresto:=FORMAT(resto);
        IF resto=1 THEN BEGIN cresto:='01';END;
        IF resto=2 THEN BEGIN cresto:='02';END;
        IF resto=3 THEN BEGIN cresto:='03';END;
        IF resto=4 THEN BEGIN cresto:='04';END;
        IF resto=5 THEN BEGIN cresto:='05';END;
        IF resto=6 THEN BEGIN cresto:='06';END;
        IF resto=7 THEN BEGIN cresto:='07';END;
        IF resto=8 THEN BEGIN cresto:='08';END;
        IF resto=9 THEN BEGIN cresto:='09';END;
        
        
        imp:=FORMAT(d1)+'.'+FORMAT(cresto);
        MESSAGE('%1',imp);
        EXIT;
        
        */

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
        DESCUENTO: Decimal;
        d1: Integer;
        imp: Code[20];
        resto: Decimal;
        cresto: Code[2];
        ADAIA: Record adaia;
        NOMDIR: TEXT;


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


        SalesReceivablesSetup.Get;



        TextoSalida4 := 'PRODUCTO;PRODUCTOPADRE;DESCRIPCIONWEB';

        OutStream.Write(TextoSalida4);



        Item.Reset;
        ///Item.SetFilter(Item."Estado Producto", '0|1');
        ///// Item.SETRANGE(Item."Excluir de dropbox",FALSE);
        if Item.FindSet then
            repeat


                TextoSalida1 := Format(Item."No.") + ';' +
                              Format(Item."Producto PADRE") + ';' +
                              Format(DISPONI) + ';' +
                              Format(ITEM."Descripcion web");

                OutStream.Write(TextoSalida4);


            until Item.Next = 0;


        nomdir := '';
        ADAIA.Reset();
        ADAIA.SetRange(texto, 'AUTOMATICOS TRADEINN-CU-50082');
        IF ADAIA.FindSet() THEN begin
            nomdir := ADAIA.Ruta;
        end;
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(NOMDIR, 'INN.csv', InStream);

    end;



    local procedure DedimalCode(dato1: Decimal) imp: Code[20]
    begin


        d1 := ROUND(dato1, 1, '<');

        //MESSAGE('%1',(dato1-d1)*100);
        resto := Abs((dato1 - d1) * 100);
        cresto := Format(resto);
        if resto = 1 then begin cresto := '01'; end;
        if resto = 2 then begin cresto := '02'; end;
        if resto = 3 then begin cresto := '03'; end;
        if resto = 4 then begin cresto := '04'; end;
        if resto = 5 then begin cresto := '05'; end;
        if resto = 6 then begin cresto := '06'; end;
        if resto = 7 then begin cresto := '07'; end;
        if resto = 8 then begin cresto := '08'; end;
        if resto = 9 then begin cresto := '09'; end;


        imp := Format(d1) + '.' + Format(cresto);
    end;
}

