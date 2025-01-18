#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50042 "Automaticos EDICOM albaran"
{


    // 
    // 
    // 2.1.Cabecera y Pie del Albarán (Datos Globales al Albarán)
    // 1 IDCAB X 10 Clave del registro de cabeceras
    // 2 NUMDES X 35 Número de aviso de expedición [BGM.1004]
    // #3 .. #4 No aplicable
    // 5 FECDES X 12 Fecha/hora de aviso de expedición
    // #6 .. #10 No aplicable
    // 11 NUMALB X 35 Número de albarán (papel)
    // #12 No aplicable
    // 13 NUMPED X 35 Número de pedido (comprador) [G01RFF.1154] ([G01RFF.1153] = ON)
    // #14 .. #16 No aplicable
    // 17 ORIGEN X 17 Código EAN-13 del origen del mensaje [G02NAD.3039] ([G02NAD.3035] = MS)
    // 18 DESTINO X 17 Código EAN-13 del destino del mensaje [G02NAD.3039] ([G02NAD.3035] = MR)
    // 19 PROVEEDO X 17 Código EAN-13 del proveedor de las mercancías.
    // 20 COMPRADO X 17 Código EAN-13 del comprador (quien pide) [G02NAD.3039] ([G02NAD.3035] = BY)
    // 21 DPTO X 17 Código del departamento que pide la mercancía
    // 22 RECEPTOR X 17 Código EAN-13 del receptor de la entrega (dónde
    // #23 .. #33 No aplicable
    // 34 TOTQTY N 15.3 Sumatorio de las cantidades CENVFAC
    // 35 IDENTIF X 3 Tipo de identificación de palet
    // #36 .. #112 No aplicable
    // 
    // 2.2.Embalajes del envío del Albarán
    // 1 IDCAB X 10 Campo de enlace con la tabla de cabeceras
    // 2 IDEMB X 10 Identificador de embalajes
    // 3 CPS X 12 Número de jerarquía de niveles
    // 4 CPSPADRE X 12 Nivel jerárquico del que depende el nivel actual
    // 5 CANTEMB N 15.3 Número de paquetes dentro de esta unidad de
    // #6 .. #7 No aplicable
    // 8 TIPEMB X 3 Tipo de embalaje
    // #9 .. #10 No aplicable
    // 11 PESON N 15.3 Peso neto total
    // 12 PESOB N 15.3 Peso bruto total
    // #13 .. #22 No aplicable
    // 23 SSCC1 X 35 SSCC de la unidad de expedición descrita 1
    // #24 .. #28 No aplicable
    // 29 TIPO2 X 3 Tipo de embalaje 2 contenido
    // 30 TCAJAS N 15 Número total de cajas contenidas
    // #31 .. #43 No aplicable
    // 
    // 2.3.Marcas de embalaje, tanto de los embalaje como de las unidades de consumo del Albarán
    // 
    // 1 IDCAB X 10 Campo de enlace con la tabla de cabeceras
    // 2 IDEMB X 10 Campo de enlace con la tabla de embalajes
    // 3 IDLIN X 10 Identificación de línea. Debe ser 0 para marcas
    // 4 IDMARCA X 10 Identificación de línea de marca de embalaje
    // #5 .. #9 No aplicable
    // 10 SSCC X 35 Código seriado de envío de la unidad de expedición
    // #11 .. #27 No aplicable
    // 
    // 2.4.Detalle del Albarán
    // 1 IDCAB X 10 Campo de enlace con la tabla de cabeceras
    // 2 IDEMB X 10 Campo de enlace con la tabla de embalajes
    // 3 IDLIN X 10 Identificación de línea de albarán
    // 4 EAN X 35 Código EAN-13 del artículo [G15LIN.7140]
    // #5 .. #10 No aplicable
    // 11 TIPART X 3 Descripción codificada del artículo
    // 12 CENVFAC N 15.3 Cantidad enviada facturada total
    // #13 .. #106 No aplicable
    // 
    // 2.5.Marcas de embalaje, tanto de los embalaje como de las unidades de consumo del Albarán
    // 1 IDCAB X 10 Campo de enlace con la tabla de cabeceras
    // 2 IDEMB X 10 Campo de enlace con la tabla de embalajes
    // 3 IDLIN X 10 Identificación de línea. Debe ser 0 para marcas
    // 4 IDMARCA X 10 Identificación de línea de marca de embalaje
    // #5 .. #9 No aplicable
    // 10 SSCC X 35 Código seriado de envío de la unidad de expedición
    // #11 .. #27 No aplicable
    // 
    // 2.6.Lugares de entrega del detalle del Albarán
    // 1 IDCAB X 10 Campo de enlace con la tabla de cabeceras
    // 2 IDEMB X 10 Campo de enlace con la tabla de embalajes
    // 3 IDLIN X 10 Identificación de línea de albarán
    // 4 IDLOC X 10 Identificación de lugar de entrega
    // #5 .. #12 No aplicable
    // 
    // 
    // 
    // 
    // 
    // 
    // IDCAB 10 Campo de enlace con la tabla de cabeceras
    // IDEMB 10 Campo de enlace con la tabla de embalajes
    // IDLIN 10 Identificación de línea de albarán
    //       ECI Gran Consumo: Obligatorio
    //       AMAZON: Obligatorio
    // EAN 35 Código EAN-13 del artículo
    //       ECI Gran Consumo: Obligatorio
    //       AMAZON: Obligatorio
    // #5 No aplicable
    // REFPROV 35 Número de artículo del proveedor
    //       AMAZON: Condicional
    // REFCLI 35 Número de artículo del comprador
    //       AMAZON: Condicional
    // #8 No aplicable
    // NUMEXP 35 Número de unidad de expedición
    //       ECI Gran Consumo: Condicional
    // DESCRIP 70 Descripción en formato libre del artículo
    //       ECI Gran Consumo: Condicional
    // TIPART 3 Descripción codificada del artículo
    //       Lista de valores permitidos:
    //       CU: Unidad de consumo
    //       DU: Unidad de expedición
    //       TU: Unidad Comerciada
    //       VQ: Producto de medida variable
    //       ECI Gran Consumo: Obligatorio
    //       Lista de valores permitidos:
    //       CU: Unidad de consumo
    //       DU: Unidad de expedición
    // CENVFAC 15.3 Cantidad enviada facturada total
    //       En caso de productos de PESO VARIABLE, indicar el total de KGS servidos.
    //       ECI Gran Consumo: Obligatorio
    //       AMAZON: Obligatorio
    // CENVGRA 15.3 Cantidad enviada gratuita
    //       ECI Gran Consumo: Condicional
    // #14 No aplicable
    // CUEXP 15.3 Número de unidades de consumo en unidad de expedición
    //       ECI Gran Consumo: Obligatorio
    // #16 .. #21 No aplicable
    // NUMPED 35 Número de pedido (a nivel de artículo)
    //       AMAZON: Condicional
    //       NO se indica el número de pedido a nivel de linea si se ha indicado previamente a nivel de cabecera.
    // #23 .. #29 No aplicable
    // FECCON 12 Fecha de consumo preferente
    //       Fecha inferior a la caducidad en la que se recomienda que el articulo entregado haya sido consumido.
    //       AMAZON: Condicional
    // LOTE 35 Número de lote
    //       ECI Gran Consumo: Condicional
    //       AMAZON: Condicional
    // #32 No aplicable
    // LUGAR1  17 Lugar de entrega final de mercancía 1
    //       ECI Gran Consumo: Condicional
    // #34 .. #46 No aplicable
    // PESTOTLIN 15.3 Peso total neto de la línea (en Kilos)
    //       ECI Gran Consumo: Condicional
    //       Proveedores de peso variable.
    // #48 .. #52 No aplicable
    // FECCAD 12 Fecha de caducidad (si no está en la etiqueta)
    //       AMAZON: Condicional
    // #54 .. #64 No aplicable
    // FECFABET 12 Fecha de fabricación (en la etiqueta)
    //       AMAZON: Condicional
    // FECCADET 12 Fecha de caducidad (en la etiqueta)
    //       ECI Gran Consumo: Condicional
    // #67 .. #86 No aplicable
    // EANCONT 35 Código EAN contenido
    //       ECI Gran Consumo: Condicional
    // #88 .. #95 No aplicable
    // PESTOTBRULIN 15.3 Peso total bruto de la línea
    //       ECI Gran Consumo: Condicional
    //       Proveedores de peso variable.
    // #97 .. #100 No aplicable
    // ISBN 35 International Standard Book Number (ISBN)
    //       AMAZON: Condicional
    // #102 .. #134 No aplicable


    trigger OnRun()
    begin



        SalesInvoiceHeader3.Reset;
        SalesInvoiceHeader3.SetCurrentkey("EDI Albaran enviar", "EDI Albaran enviado");
        ////SalesInvoiceHeader3.SETRANGE("EDI Albaran enviar",TRUE);
        SalesInvoiceHeader3.SetRange("No.", '20FV111662');
        ///// SalesInvoiceHeader3.SETRANGE("EDI Albaran enviado",FALSE);
        if SalesInvoiceHeader3.FindFirst then
            repeat
                GrabaEDICOM(SalesInvoiceHeader3."No.");
                SalesInvoiceHeader2.Get(SalesInvoiceHeader3."No.");
                SalesInvoiceHeader2."EDI Albaran enviado" := true;
                SalesInvoiceHeader2."EDI Albaran Fecha enviado" := CreateDatetime(Today, Time);
                SalesInvoiceHeader2.Modify;
            until SalesInvoiceHeader3.Next = 0;


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
        ArchSalida5: File;
        ArchExt5: Text[250];
        ArchSalida6: File;
        ArchExt6: Text[250];
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
        VATPostingSetup: Record "VAT Posting Setup";
        IVA: Decimal;
        Familiascatit1: Record "Familias catit";
        Familiascatit2: Record "Familias catit";
        id1: Integer;
        id2: Integer;
        refcattit: Code[20];
        SalesInvoiceHeader: Record "Sales Invoice Header";
        VENDEDOR: Code[17];
        EMISOR: Code[17];
        COBRADOR: Code[17];
        COMPRADO: Code[17];
        DEPTO: Code[17];
        RECEPTOR: Code[17];
        CLIENTE: Code[17];
        PAGADOR: Code[17];
        PEDIDO: Code[17];
        FECHA: Code[17];
        NODO: Code[17];
        RSOCIAL: Code[70];
        CALLE: Code[35];
        CIUDAD: Code[35];
        CP: Code[5];
        NIF: Code[17];
        ALBARAN: Code[17];
        CONTRATO: Code[17];
        NFACSUS: Code[17];
        DIVISA: Code[17];
        SUMBRUTO: Code[17];
        SUMNETOS: Code[17];
        CARGOS: Code[17];
        DESCUEN: Code[17];
        BASEIMP1: Code[17];
        TIPOIMP1: Code[17];
        TASAIMP1: Code[17];
        IMPIMP1: Code[17];
        BASEIMP2: Code[17];
        TIPOIMP2: Code[17];
        TASAIMP2: Code[17];
        IMPIMP2: Code[17];
        BASEIMP3: Code[17];
        TIPOIMP3: Code[17];
        IMPIMP3: Code[17];
        BASEIMP4: Code[17];
        TIPOIMP4: Code[17];
        TASAIMP4: Code[17];
        IMPIMP4: Code[17];
        BASEIMP5: Code[17];
        TIPOIMP5: Code[17];
        TASAIMP5: Code[17];
        IMPIMP5: Code[17];
        BASEIMP6: Code[17];
        TIPOIMP6: Code[17];
        IMPIMP6: Code[17];
        BASIMPFA: Code[17];
        TOTIMP: Code[17];
        TOTAL: Code[17];
        VTO1: Code[17];
        IMPVTO1: Code[17];
        TPVERDE: Code[17];
        CALIF1: Code[17];
        SECUEN1: Code[17];
        TIPO1: Code[17];
        PORCEN1: Code[17];
        IMPDES1: Code[17];
        CALIF2: Code[17];
        SECUEN2: Code[17];
        TIPO2: Code[17];
        PORCEN2: Code[17];
        IMPDES2: Code[17];
        CALIF3: Code[17];
        SECUEN3: Code[17];
        TIPO3: Code[17];
        PORCEN3: Code[17];
        IMPDES3: Code[17];
        CALIF4: Code[17];
        SECUEN4: Code[17];
        TIPO4: Code[17];
        PORCEN4: Code[17];
        IMPDES4: Code[17];
        CALIF5: Code[17];
        SECUEN5: Code[17];
        TIPO5: Code[17];
        PORCEN5: Code[17];
        IMPDES5: Code[17];
        ERSOCIAL: Code[70];
        ECALLE: Code[35];
        EPOBLAC: Code[35];
        ECP: Code[5];
        ENIF: Code[17];
        ERMERCA: Code[70];
        NOTAC: Code[17];
        FECHAEFE: Code[12];
        FECALB: Code[12];
        FECHADOC: Code[12];
        REFPAGO: Code[35];
        NIFII: Code[17];
        NIFPE: Code[17];
        NIFPR: Code[17];
        NIFSU: Code[17];
        NUMINCOR: Code[17];
        FPEDIDO: Code[12];
        NOTIFDEVOL: Code[17];
        FNOTIFDEVOL: Code[12];
        SEDESOC: Code[17];
        ECPEXT: Code[17];
        FECFACSUS: Code[12];
        EPAIS: Code[3];
        RELVTO: Code[3];
        DIASVTO: Code[8];
        PORCVTO: Code[3];
        TIPOIMPDES1: Code[8];
        TASAIMPDES1: Code[10];
        AUTORIZDEV: Code[35];
        FECTAX: Code[12];
        IDCAB: Code[15];
        TASAIMP3: Code[10];
        TASAIMP6: Code[10];
        NIFIV: Code[17];
        LAFECHA: Code[20];
        DD: Integer;
        MM: Integer;
        AA: Integer;
        M1: Code[10];
        D1: Code[10];
        FFECHA: Date;
        cero: Decimal;
        VATEntry: Record "VAT Entry";
        tipoimp: Integer;
        CompanyInformation: Record "Company Information";
        SalesInvoiceLine: Record "Sales Invoice Line";
        NUMLIN: Code[5];
        NUMLINint: Integer;
        REFEAN: Code[17];
        REFCLI: Code[30];
        DESC: Code[70];
        REFPRO: Code[35];
        CFACT: Code[15];
        CENT: Code[10];
        UMEDIDA: Code[3];
        PRECIOB: Code[15];
        PRECION: Code[15];
        IMPTASA1: Code[15];
        IMPTASA2: Code[15];
        IMPTASA3: Code[15];
        IMPDTO1: Code[15];
        IMPDTO2: Code[15];
        IMPDTO3: Code[15];
        IMDTO4: Code[15];
        CBONI: Code[15];
        NETO: Code[15];
        PVERDE: Code[15];
        FENTREGA: Code[12];
        CANTDEV: Code[15];
        SUBLIN: Code[3];
        MODELO: Code[35];
        COLOR: Code[35];
        NUMLINSUBLIN: Code[5];
        VATEntryTemp: Record "VAT Entry" temporary;
        fechapediso: Date;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        contavto: Integer;
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        IMPTOTAL: Decimal;
        C13: Integer;
        C10: Integer;
        I: Integer;
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        SalesInvoiceHeader3: Record "Sales Invoice Header";
        HACERLINEAS: Boolean;
        SalesCrMemoHeader2: Record "Sales Cr.Memo Header";
        SalesCrMemoHeader3: Record "Sales Cr.Memo Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        NUMALB: Code[35];
        IDECAB: Code[35];
        NUMDES: Code[35];
        TOTQTY: Code[20];
        TOTQTYD: Decimal;
        NUMPED: Code[35];
        ORIGEN: Code[35];
        DESTINO: Code[35];
        PROVEEDO: Code[17];
        DPTO: Code[17];
        IDENTIF: Code[17];
        NUMFAC: Code[17];
        IDEMB: Code[17];
        IDLIN: Code[17];
        EAN: Code[35];
        Cajasporenvio: Record "Cajas por envio";
        CPS: Code[17];
        CPSPADRE: Code[17];
        CANTEMB: Code[17];
        TIPOEMB: Code[17];
        TIPO: Code[17];
        TCAJAS: Code[17];
        NCAJAS: Decimal;
        X: Integer;
        CONTA: Integer;
        Cajasporenvio2: Record "Cajas por envio";
        CANTEMBD: Decimal;
        puntoenv: Code[20];
        ShippingAgent: Record "Shipping Agent";
        FECHAENVIO: Code[20];
        CPPTOEMISION: Code[10];
        CONEMB: Code[20];
        PAISPROVEEDOR: Code[10];
        PAISPTOENTREGA: Code[20];
        ETAPATRANS: Code[20];
        PAISPUNTENV: Code[20];
        FECENT: Date;
        SALE2: Boolean;
        COD1: Code[30];
        REF1: Code[30];
        COD2: Code[30];
        REF2: Code[30];
        COD3: Code[30];
        REF3: Code[30];
        CODTRANSP: Code[20];
        COD4: Code[30];
        REF4: Code[30];
        COD5: Code[30];
        REF5: Code[30];
        COD6: Code[30];
        REF6: Code[30];
        pesoneto: Code[20];
        pesobruto: Code[20];
        dpesoneto: Decimal;
        dpesobruto: Decimal;
        NCAJAST: Code[20];
        Customer2: Record Customer;
        contalin: Integer;
        FECENTtext: Text;


    procedure GrabaEDICOM(codefac: Code[20])
    begin



        CompanyInformation.Get;
        HACERLINEAS := false;

        SalesReceivablesSetup.Get;


        ArchExt4 := SalesReceivablesSetup."Ruta fiche. ENVIO A EDICOM" + 'CABALB' + Format(codefac) + '.TXT';
        ArchExt4 := 'C:\edicom\CABALB' + Format(codefac) + '.TXT';





        SalesInvoiceHeader.Reset;
        SalesInvoiceHeader.SetRange("No.", codefac);
        if SalesInvoiceHeader.FindSet then
            repeat
                if (SalesInvoiceHeader."Sell-to Country/Region Code" = 'ES') and
                  (SalesInvoiceHeader."No. Series" <> 'V-FAC-DOC')
                  then begin
                    CODTRANSP := '';
                    TIPO1 := '';
                    PORCEN1 := '';
                    IMPDTO1 := '';
                    IDECAB := SalesInvoiceHeader."No.";
                    NUMDES := SalesInvoiceHeader."Nº expedición";
                    NUMALB := SalesInvoiceHeader."No.";
                    VENDEDOR := CompanyInformation.GLN;
                    EMISOR := CompanyInformation.GLN;

                    Customer.Get(SalesInvoiceHeader."Sell-to Customer No.");
                    ORIGEN := Customer."Quien pide";
                    DESTINO := Customer."Central compradora";
                    DPTO := SalesInvoiceHeader."Dpto.ECI";
                    if SalesInvoiceHeader."Customer Price Group" = 'ECI' then begin
                        DPTO := '219';
                    end;
                    CLIENTE := Customer."A quien se factura";
                    PROVEEDO := Customer."Sucrusal entrega";
                    PROVEEDO := CompanyInformation.GLN;
                    RECEPTOR := Customer."Sucrusal entrega";
                    COMPRADO := Customer."Quien pide";
                    PAGADOR := Customer."Quien paga";
                    NUMPED := CopyStr(SalesInvoiceHeader."Your Reference", 1, 17);
                    FFECHA := SalesInvoiceHeader."Posting Date";
                    CALCULOFECHA;
                    FECHAEFE := FECHA;
                    TOTQTYD := 0;
                    SalesInvoiceLine.Reset;
                    SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                    if SalesInvoiceLine.FindFirst then
                        repeat
                            if SalesInvoiceLine.Type = SalesInvoiceLine.Type::Item then begin
                                TOTQTYD := TOTQTYD + SalesInvoiceLine.Quantity;
                                if Customer2.Get(SalesInvoiceLine."Sell-to Customer No.") then begin
                                    RECEPTOR := Customer2."Sucrusal entrega";
                                end;
                            end;
                        until SalesInvoiceLine.Next = 0;
                    TOTQTY := '0';
                    TOTQTY := ConvertStr(Format(TOTQTYD * 100, 15, Text1100009), ' ', '0');
                    TOTQTY := CopyStr(TOTQTY, 3, 11) + ',' + CopyStr(TOTQTY, 14, 2) + '0';

                    FECENT := 0D;
                    PAISPTOENTREGA := SalesInvoiceHeader."Sell-to Country/Region Code";
                    PAISPUNTENV := CompanyInformation."Country/Region Code";
                    PAISPROVEEDOR := CompanyInformation."Country/Region Code";
                    CPPTOEMISION := CompanyInformation."Post Code";
                    CONEMB := NUMALB;
                    puntoenv := CompanyInformation.GLN;
                    SALE2 := false;
                    FECENT := SalesInvoiceHeader."Posting Date";
                    CALCULOFECHA;
                    FECENTtext := Format(FECHA) + '0000';
                    SalesInvoiceLine.Reset;
                    SalesInvoiceLine.SetRange(SalesInvoiceLine."Document No.", SalesInvoiceHeader."No.");
                    if SalesInvoiceLine.FindFirst then
                        repeat
                            if (SalesInvoiceLine."Shipment No." <> '') and (SalesInvoiceLine.Quantity <> 0) then begin
                                if SalesShipmentHeader3.Get(SalesInvoiceLine."Shipment No.") then begin
                                    FECENT := SalesShipmentHeader3."Requested Delivery Date";
                                    NUMALB := SalesShipmentHeader3."No.";
                                    CODTRANSP := SalesShipmentHeader3."Shipping Agent Code";
                                    SALE2 := true;
                                end;
                            end;
                        until (SalesInvoiceLine.Next = 0) or SALE2;
                    ShippingAgent.Init;
                    if ShippingAgent.Get(CODTRANSP) then begin
                    end;

                    FFECHA := FECENT;
                    CALCULOFECHA;
                    FECENTtext := Format(FECHA) + '0000';



                    POS := 1;
                    REF1 := '';
                    COD1 := Format(Customer."Tipo de documento EDICOM");
                    SALE := false;
                    repeat
                        POS := POS + 1;
                        if CopyStr(COD1, POS, 1) = '-' then begin
                            SALE := true;
                            REF1 := CopyStr(COD1, 1, POS - 1);
                        end;
                    until SALE or (POS > StrLen(COD1));

                    POS := 1;
                    REF2 := '';
                    COD2 := Format(Customer."Funcion del mensaje EDICOM");
                    SALE := false;
                    repeat
                        POS := POS + 1;
                        if CopyStr(COD2, POS, 1) = '-' then begin
                            SALE := true;
                            REF2 := CopyStr(COD2, 1, POS - 1);
                        end;
                    until SALE or (POS > StrLen(COD2));

                    POS := 1;
                    REF3 := '';
                    COD3 := Format(Customer."Tipo transporte EDICOM");
                    SALE := false;
                    repeat
                        POS := POS + 1;
                        if CopyStr(COD3, POS, 1) = '-' then begin
                            SALE := true;
                            REF3 := CopyStr(COD3, 1, POS - 1);
                        end;
                    until SALE or (POS > StrLen(COD3));


                    POS := 1;
                    REF4 := '';
                    COD4 := Format(ShippingAgent."ETAPATRANS EDICON");
                    SALE := false;
                    repeat
                        POS := POS + 1;
                        if CopyStr(COD4, POS, 1) = '-' then begin
                            SALE := true;
                            REF4 := CopyStr(COD4, 1, POS - 1);
                        end;
                    until SALE or (POS > StrLen(COD4));


                    POS := 1;
                    REF5 := '';
                    COD5 := Format(ShippingAgent."MEDIOTRANS EDICOM");
                    SALE := false;
                    repeat
                        POS := POS + 1;
                        if CopyStr(COD5, POS, 1) = '-' then begin
                            SALE := true;
                            REF5 := CopyStr(COD5, 1, POS - 1);
                        end;
                    until SALE or (POS > StrLen(COD5));



                    POS := 1;
                    REF6 := '';
                    COD6 := Format(Customer."IDENTIF EDICOM");
                    REF6 := Format('X6');
                    SALE := false;
                    repeat
                        POS := POS + 1;
                        if CopyStr(COD6, POS, 1) = '-' then begin
                            SALE := true;
                            REF6 := CopyStr(COD6, 1, POS - 1);
                        end;
                    until SALE or (POS > StrLen(COD6));

                    REF6 := Format('X6');


                    TextoSalida1 := Format(IDECAB) + '|' + ///// -1
                                  Format(NUMDES) + '|' + ///// ECI 16 -2
                                  Format(REF1) + '|' + ///// -3
                                  Format(REF2) + '|' + ///// -4
                                  Format(CopyStr(FECHAEFE, 1, 12)) + '|' + // X 12 Fecha de emisión de la factura. ///// -5
                                  Format(CopyStr(FECENTtext, 1, 12)) + '|' + ///// -6
                                  '|' + ///// -7
                                  '|' + ///// -8
                                  '|' + ///// -9
                                  Format(REF6) + '|' + ///// -10
                                  Format(CopyStr(NUMALB, 1, 35)) + '|' + ///Código EDI del vendedor o proveedor. ///// -11
                                '|' + ///// -12
                                  Format(CopyStr(NUMPED, 1, 35)) + '|'; ///Código EDI del vendedor o proveedor. ///// -13
                    TextoSalida2 := '|' + ///// -14
                                  '|' + ///// -15
                                  '|' + ///// -16
                             Format(CopyStr(ORIGEN, 1, 17)) + '|' + ///// -17
                             Format(CopyStr(DESTINO, 1, 17)) + '|' + ///// -18
                             Format(PROVEEDO) + '|' + ///// -19
                             Format(COMPRADO) + '|' + ///// -20
                             Format(DPTO) + '|' + ///// -21
                             Format(RECEPTOR) + '|' + ///// -22
                             '|' + ///// -23
                             Format(puntoenv) + '|' + ///// -24
                             '|' + ///// -25
                             '|' + ///// -26
                             '|' + ///// -27
                             '|' + ///// -28
                             '|' + ///// -29
                             '|' + ///// -30
                             Format(REF3) + '|' + ///// -31
                             Format(ShippingAgent."IDTRANS SCAC. EDICOM") + '|' + ///// -32
                             '|' + ///// -33
                             Format(CopyStr(TOTQTY, 1, 15)) + '|' + ///// N 15.3 - 34
                             Format(CopyStr(REF6, 1, 3)) + '|'; ///// - 35
                    TextoSalida3 := '|' + ///// -36
                                  '|' + ///// -37
                                  Format(FECENTtext) + '|' + ///// -38
                                  '|' + ///// -39
                                  '|' + ///// -40
                                  '|' + ///// -41
                                  '|' + ///// -42
                                  '|' + ///// -43
                                  '|' + ///// -44
                                  '|' + ///// -45
                                  '|' + ///// -46
                                  '|' + ///// -47
                                  '|' + ///// -48
                                  '|' + ///// -49
                                  '|' + ///// -50
                                  '|' + ///// -51
                                  '|' + ///// -52
                                  '|' + ///// -53
                                  '|' + ///// -54
                                  '|' + ///// -55
                                  '|' + ///// -56
                                  '|' + ///// -57
                                  '|' + ///// -58
                                  '|' + ///// -59
                                  '|' + ///// -60
                                  '|' + ///// -61
                                  '|' + ///// -62
                                  '|' + ///// -63
                                  '|' + ///// -64
                                  '|' + ///// -65
                                  '|' + ///// -66
                                  Format(CPPTOEMISION) + '|' + ///// -67 OK
                                  '|' + ///// -68
                                  '|' + ///// -69
                                  '|' + ///// -70
                                  '|' + ///// -71
                                  '|' + ///// -72
                                  '|' + ///// -73
                                  '|' + ///// -74
                                  '|' + ///// -75
                                  '|' + ///// -76
                                  '|' + ///// -77
                                  '|' + ///// -78
                                  '|' + ///// -79
                                  '|' + ///// -80
                                  '|' + ///// -81
                                  '|' + ///// -82
                                  '|' + ///// -83
                                  '|' + ///// -84
                                  '|' + ///// -85
                                  '|' + ///// -86
                                  '|' + ///// -87
                                  Format(CONEMB) + '|' + ///// -88 OK
                                  '|' + ///// -89
                                  '|' + ///// -90
                                  '|' + ///// -91
                                  Format(PAISPROVEEDOR) + '|' + ///// -92 OK
                                  '|' + ///// -93
                                  Format(PAISPTOENTREGA) + '|' + ///// -94 OK
                                  Format(REF4) + '|' + ///// -95 OK
                                  Format(REF5) + '|' + ///// -96 OK
                                  '|' + ///// -97
                                  Format(PAISPUNTENV) + '|' + ///// -98 OK
                                  '|' + ///// -99
                                  '|' + ///// -100
                                  '|' + ///// -101
                                  '|' + ///// -102
                                  '|' + ///// -103
                                  '|' + ///// -104
                                  '|' + ///// -105
                                  '|' + ///// -106
                                  '|' + ///// -107
                                  '|' + ///// -108
                                  '|' + ///// -109
                                  '|' + ///// -110
                                  '|' + ///// -111
                                  '|'; ///// -112



                    ///        ArchSalida4.Write(TextoSalida1+TextoSalida2+TextoSalida3);

                    Lineas;
                    LinCajasporenvio;
                end;

            until SalesInvoiceHeader.Next = 0;

        ///     ArchSalida4.Close;
    end;

    local procedure Lineas()
    begin


        /*
        2.4.Detalle del Albarán
        1 IDCAB X 10 Campo de enlace con la tabla de cabeceras
        2 IDEMB X 10 Campo de enlace con la tabla de embalajes
        3 IDLIN X 10 Identificación de línea de albarán
        4 EAN X 35 Código EAN-13 del artículo [G15LIN.7140]
        #5 .. #10 No aplicable
        11 TIPART X 3 Descripción codificada del artículo
        12 CENVFAC N 15.3 Cantidad enviada facturada total
        #13 .. #106 No aplicable
        */


        NUMLINint := 0;
        ArchExt5 := SalesReceivablesSetup."Ruta fiche. ENVIO A EDICOM" + 'LINALB' + Format(SalesInvoiceHeader."No.") + '.TXT';
        ArchExt5 := 'C:\edicom\LINALB' + Format(SalesInvoiceHeader."No.") + '.TXT';


        //  ArchSalida5.TextMode := true;
        //        ArchSalida5.WriteMode := true;
        //      ArchSalida5.Create(ArchExt5);



        SalesInvoiceLine.Reset;
        SalesInvoiceLine.SetRange(SalesInvoiceLine."Document No.", SalesInvoiceHeader."No.");
        ///// IF SalesInvoiceLine.FINDFIRST THEN REPEAT
        if SalesInvoiceLine.FindFirst then begin
            ///// IF (SalesInvoiceLine."No."<>'') AND (SalesInvoiceLine.Quantity<>0) THEN BEGIN
            NUMLIN := ConvertStr(Format(NUMLINint, 5, Text1100009), ' ', '0');
            REFEAN := SalesInvoiceLine.Ean;
            REFCLI := SalesInvoiceLine."No.";
            REFPRO := SalesInvoiceLine."No.";
            EAN := REFEAN;
            Cajasporenvio2.Reset;
            Cajasporenvio2.SetCurrentkey(Nfac, "Caja num");
            Cajasporenvio2.SetRange(Nfac, SalesInvoiceHeader."No.");
            ///// Cajasporenvio2.SETRANGE(nlin,SalesInvoiceLine."Line No.");
            if Cajasporenvio2.FindFirst then
                repeat
                    if Cajasporenvio2.Cantidad <> 0 then begin
                        CFACT := ConvertStr(Format(Cajasporenvio2.Cantidad * 100, 15, Text1100009), ' ', '0');
                        CFACT := CopyStr(CFACT, 3, 11) + ',' + CopyStr(CFACT, 14, 2) + '0';
                        IDEMB := Format(Cajasporenvio2."Caja num" + 2);
                        Cajasporenvio2.CalcFields(Ean);
                        EAN := Cajasporenvio2.Ean;


                        TextoSalida1 := Format(CopyStr(IDECAB, 1, 10)) + '|' + /////
                            Format(CopyStr(IDEMB, 1, 10)) + '|' + /////
                                                                  ///// FORMAT(COPYSTR(IDLIN,1,10))
                            '|' + /////
                            Format(CopyStr(EAN, 1, 35)) + '|' + /////
                            '|' + ///// -5
                            '|' + ///// -6
                            '|' + ///// -7
                            '|' + ///// -8
                            '|' + ///// -9
                            '|' + ///// -10
                            'CU|' + ///// -11
                            Format(CopyStr(CFACT, 1, 15)) + '|' + ///// N 15.3 Cantidad facturada ///// -12
                            '|' + ///// -13
                            '|' + ///// -14
                                  ///// FORMAT(COPYSTR(CFACT,1,15))
                            '|' + ///// -15
                            '|' + ///// -16
                            '|' + ///// -17
                            '|' + ///// -18
                            '|' + ///// -19
                            '|' + ///// -20
                            '|' + ///// -21
                            '|' + ///// -22
                            '|' + ///// -23
                            '|' + ///// -24
                            '|' + ///// -25
                            '|' + ///// -26
                            '|' + ///// -27
                            '|' + ///// -28
                            '|' + ///// -29
                            '|' + ///// -30
                            '|' + ///// -31
                            '|' + ///// -32
                            '|' + ///// -33
                            '|' + ///// -34
                            '|' + ///// -35
                            '|' + ///// -36
                            '|' + ///// -37
                            '|' + ///// -38
                            '|' + ///// -39
                            '|' + ///// -40
                            '|' + ///// -41
                            '|' + ///// -42
                            '|' + ///// -43
                            '|' + ///// -44
                            '|' + ///// -45
                            '|' + ///// -46
                            '|' + ///// -47
                            '|' + ///// -48
                            '|' + ///// -49
                            '|' + ///// -50
                            '|' + ///// -51
                            '|' + ///// -52
                            '|' + ///// -53
                            '|' + ///// -54
                            '|' + ///// -55
                            '|' + ///// -56
                            '|' + ///// -57
                            '|' + ///// -58
                            '|' + ///// -59
                            '|' + ///// -60
                            '|' + ///// -61
                            '|' + ///// -62
                            '|' + ///// -63
                            '|' + ///// -64
                            '|' + ///// -65
                            '|' + ///// -66
                            '|' + ///// -67
                            '|' + ///// -68
                            '|' + ///// -69
                            '|' + ///// -70
                            '|' + ///// -71
                            '|' + ///// -72
                            '|' + ///// -73
                            '|' + ///// -74
                            '|' + ///// -75
                            '|' + ///// -76
                            '|' + ///// -77
                            '|' + ///// -78
                            '|' + ///// -79
                            '|' + ///// -80
                            '|' + ///// -81
                            '|' + ///// -82
                            '|' + ///// -83
                            '|' + ///// -84
                            '|' + ///// -85
                            '|' + ///// -86
                            '|' + ///// -87
                            '|' + ///// -88
                            '|' + ///// -89
                            '|' + ///// -90
                            '|' + ///// -91
                            '|' + ///// -92
                            '|' + ///// -93
                            '|' + ///// -94
                            '|' + ///// -95
                            '|' + ///// -96
                            '|' + ///// -97
                            '|' + ///// -98
                            '|' + ///// -99
                            '|' + ///// -100
                            '|' + ///// -101
                            '|' + ///// -102
                            '|' + ///// -103
                            '|' + ///// -104
                            '|' + ///// -105
                            '|'; ///// -106
                                 //                        ArchSalida5.Write(TextoSalida1);
                    end;
                until Cajasporenvio2.Next = 0;
            /////    END;
        end;
        /////UNTIL SalesInvoiceLine.NEXT=0;

        ///        ArchSalida5.Close;

    end;

    local procedure CALCULOFECHA()
    begin

        AA := Date2dmy(FFECHA, 3);
        MM := Date2dmy(FFECHA, 2);
        DD := Date2dmy(FFECHA, 1);
        M1 := Format(MM);
        D1 := Format(DD);

        if D1 = '0' then D1 := '00';
        if D1 = '1' then D1 := '01';
        if D1 = '2' then D1 := '02';
        if D1 = '3' then D1 := '03';
        if D1 = '4' then D1 := '04';
        if D1 = '5' then D1 := '05';
        if D1 = '6' then D1 := '06';
        if D1 = '7' then D1 := '07';
        if D1 = '8' then D1 := '08';
        if D1 = '9' then D1 := '09';

        if M1 = '0' then M1 := '00';
        if M1 = '1' then M1 := '01';
        if M1 = '2' then M1 := '02';
        if M1 = '3' then M1 := '03';
        if M1 = '4' then M1 := '04';
        if M1 = '5' then M1 := '05';
        if M1 = '6' then M1 := '06';
        if M1 = '7' then M1 := '07';
        if M1 = '8' then M1 := '08';
        if M1 = '9' then M1 := '09';

        FECHA := Format(AA) + M1 + D1;
    end;

    local procedure LinCajasporenvio()
    begin


        contalin := 0;

        NUMLINint := 0;


        ArchExt6 := SalesReceivablesSetup."Ruta fiche. ENVIO A EDICOM" + 'EMBALB' + Format(SalesInvoiceHeader."No.") + '.TXT';
        ArchExt6 := 'C:\edicom\EMBALB' + Format(SalesInvoiceHeader."No.") + '.TXT';


        //  ArchSalida6.TextMode := true;
        //  ArchSalida6.WriteMode := true;
        //   ArchSalida6.Create(ArchExt6);


        dpesobruto := 0;
        dpesoneto := 0;

        NCAJAS := 0;
        SalesInvoiceLine.Reset;
        SalesInvoiceLine.SetRange(SalesInvoiceLine."Document No.", SalesInvoiceHeader."No.");
        if SalesInvoiceLine.FindSet then
            repeat
                if SalesInvoiceLine.Quantity <> 0 then begin
                    if SalesInvoiceLine."Cantidad caja" <> 0 then begin
                        NCAJAS := SalesInvoiceLine."Cantidad caja";
                    end;
                    dpesobruto := dpesobruto + SalesInvoiceLine."Gross Weight" * SalesInvoiceLine."Quantity (Base)";
                    dpesoneto := dpesoneto + SalesInvoiceLine."Net Weight" * SalesInvoiceLine."Quantity (Base)";
                end;
            until SalesInvoiceLine.Next = 0;


        IDEMB := '1';
        CPS := '1';
        CPSPADRE := '';
        CANTEMB := '1';
        TIPOEMB := '201';
        TextoSalida1 := Format(CopyStr(IDECAB, 1, 10)) + '|' + /////
              Format(CopyStr(IDEMB, 1, 10)) + '|' + /////
              Format(CopyStr(CPS, 1, 10)) + '|' + /////
              Format(CopyStr(CPSPADRE, 1, 35)) + '|' + /////
              Format(CopyStr(CANTEMB, 1, 15)) + '|' + /////
              '|' + ///// -6
              '|' + ///// -7
              Format(CopyStr(TIPOEMB, 1, 3)) + '|' + ///// -8
              '|' + ///// -9
              '|' + ///// -10
              '|' + ///// -11
              '|' + ///// -12
              '|' + ///// -13
              '|' + ///// -14
              '|' + ///// -25
              '|' + ///// -26
              '|' + ///// -27
              '|' + ///// -28
              '|' + ///// -29
              '|' + ///// -20
              '|' + ///// -21
              '|' + ///// -22
              '|' + ///// -23
              '|' + ///// -24
              '|' + ///// -25
              '|' + ///// -26
              '|' + ///// -27
              '|' + ///// -28
              '|' + ///// -29
              '|' + ///// -30
              '|' + ///// -31
              '|' + ///// -32
              '|' + ///// -33
              '|' + ///// -34
              '|' + ///// -35
              '|' + ///// -36
              '|' + ///// -37
              '|' + ///// -38
              '|' + ///// -39
              '|' + ///// -40
              '|' + ///// -41
              '|' + ///// -42
              '|'; ///// -43
                   //             ArchSalida6.Write(TextoSalida1);

        IDEMB := '2';
        CPS := '2';
        CPSPADRE := '1';
        CANTEMB := '1';
        TIPOEMB := '201';
        Cajasporenvio.Reset;
        Cajasporenvio.SetRange(Cajasporenvio.Nfac, SalesInvoiceHeader."No.");
        if Cajasporenvio.FindFirst then begin
            TextoSalida1 := Format(CopyStr(IDECAB, 1, 10)) + '|' + /////
                  Format(CopyStr(IDEMB, 1, 10)) + '|' + /////
                  Format(CopyStr(CPS, 1, 10)) + '|' + /////
                  Format(CopyStr(CPSPADRE, 1, 35)) + '|' + /////
                  Format(CopyStr(CANTEMB, 1, 15)) + '|' + /////
                  '|' + ///// -6
                  '|' + ///// -7
                  Format(CopyStr(TIPOEMB, 1, 3)) + '|' + ///// -8
                  '|' + ///// -9
                  '|' + ///// -10
                  '|' + ///// -11
                  '|' + ///// -12
                  '|' + ///// -13
                  '|' + ///// -14
                  '|' + ///// -25
                  '|' + ///// -26
                  '|' + ///// -27
                  '|' + ///// -28
                  '|' + ///// -29
                  '|' + ///// -20
                  '|' + ///// -21
                  '|' + ///// -22
                  Format(Cajasporenvio."SSCC palet") + '|' + ///// -23
                  '|' + ///// -24
                  '|' + ///// -25
                  '|' + ///// -26
                  '|' + ///// -27
                  '|' + ///// -28
                  '|' + ///// -29
                  '|' + ///// -30
                  '|' + ///// -31
                  '|' + ///// -32
                  '|' + ///// -33
                  '|' + ///// -34
                  '|' + ///// -35
                  '|' + ///// -36
                  '|' + ///// -37
                  '|' + ///// -38
                  '|' + ///// -39
                  '|' + ///// -40
                  '|' + ///// -41
                  '|' + ///// -42
                  '|'; ///// -43
                       //           ArchSalida6.Write(TextoSalida1);
        end;


        X := 1;
        CONTA := 0;
        Cajasporenvio.Reset;
        Cajasporenvio.SetRange(Cajasporenvio.Nfac, SalesInvoiceHeader."No.");
        Cajasporenvio.SetRange("Caja num", X);
        if Cajasporenvio.FindFirst then begin
            CANTEMBD := 0;
            Cajasporenvio2.Reset;
            Cajasporenvio2.SetRange(Nfac, SalesInvoiceHeader."No.");
            Cajasporenvio2.SetRange("Caja num", Cajasporenvio."Caja num");
            if Cajasporenvio2.FindFirst then
                repeat
                    CANTEMBD := CANTEMBD + Cajasporenvio2.Cantidad;
                until Cajasporenvio2.Next = 0;
            CANTEMB := '0';
            CANTEMB := ConvertStr(Format(CANTEMBD * 100, 15, Text1100009), ' ', '0');
            CANTEMB := CopyStr(CANTEMB, 3, 11) + ',' + CopyStr(CANTEMB, 14, 2) + '0';
            NCAJAST := '0';
            NCAJAST := ConvertStr(Format(NCAJAS * 100, 15, Text1100009), ' ', '0');
            NCAJAST := CopyStr(NCAJAST, 3, 11) + ',' + CopyStr(NCAJAST, 14, 2) + '0';


            /////IDEMB:=FORMAT(Cajasporenvio."Caja num");
            /////CPS:=FORMAT(Cajasporenvio."Caja num");
            contalin := contalin + 1;
            CPSPADRE := '2';
            TIPOEMB := 'CT';
            TIPO := 'CT';
            /////       IDEMB:=INCSTR(IDEMB);
            /////CPS:=INCSTR(CPS);

            pesoneto := '0';
            pesoneto := ConvertStr(Format(dpesoneto * 100, 15, Text1100009), ' ', '0');
            pesoneto := CopyStr(pesoneto, 3, 11) + ',' + CopyStr(pesoneto, 14, 2) + '0';
            pesobruto := '0';
            pesobruto := ConvertStr(Format(dpesobruto * 100, 15, Text1100009), ' ', '0');
            pesobruto := CopyStr(pesobruto, 3, 11) + ',' + CopyStr(pesobruto, 14, 2) + '0';
            TextoSalida1 := Format(CopyStr(IDECAB, 1, 10)) + '|' + /////
                  Format(CopyStr(IDEMB, 1, 10)) + '|' + /////
                  Format(CopyStr(CPS, 1, 10)) + '|' + /////
                  Format(CopyStr(CPSPADRE, 1, 35)) + '|' + /////
                  Format(CopyStr(CANTEMB, 1, 15)) + '|' + /////
                  '|' + ///// -6
                  '|' + ///// -7
                  Format(CopyStr(TIPOEMB, 1, 3)) + '|' + ///// -8
                  '|' + ///// -9
                  '|' + ///// -10
                  Format(pesobruto) + '|' + ///// -11
                  Format(pesoneto) + '|' + ///// -12
                  '|' + ///// -13
                  '|' + ///// -14
                  '|' + ///// -25
                  '|' + ///// -26
                  '|' + ///// -27
                  '|' + ///// -28
                  '|' + ///// -29
                  '|' + ///// -20
                  '|' + ///// -21
                  '|' + ///// -22
                  Format(Cajasporenvio."SSCC sin guiones") + '|' + ///// -23
                  '|' + ///// -24
                  '|' + ///// -25
                  '|' + ///// -26
                  '|' + ///// -27
                  '|' + ///// -28
                  '|' + ///// -29
                  Format(NCAJAST) + '|' + ///// -30
                  '|' + ///// -31
                  '|' + ///// -32
                  '|' + ///// -33
                  '|' + ///// -34
                  '|' + ///// -35
                  '|' + ///// -36
                  '|' + ///// -37
                  '|' + ///// -38
                  '|' + ///// -39
                  '|' + ///// -40
                  '|' + ///// -41
                  '|' + ///// -42
                  '|'; ///// -43
                       /////            ArchSalida6.WRITE(TextoSalida1);
        end;
        if NCAJAS <> 0 then begin
            X := 0;
            repeat
                X := X + 1;
                CONTA := 0;
                Cajasporenvio.Reset;
                Cajasporenvio.SetRange(Cajasporenvio.Nfac, SalesInvoiceHeader."No.");
                Cajasporenvio.SetRange("Caja num", X);
                if Cajasporenvio.FindFirst then begin
                    CANTEMBD := 0;
                    Cajasporenvio2.Reset;
                    Cajasporenvio2.SetRange(Nfac, SalesInvoiceHeader."No.");
                    Cajasporenvio2.SetRange("Caja num", Cajasporenvio."Caja num");
                    if Cajasporenvio2.FindFirst then
                        repeat
                            CANTEMBD := CANTEMBD + Cajasporenvio2.Cantidad;
                        until Cajasporenvio2.Next = 0;
                    CANTEMB := '0';
                    CANTEMB := ConvertStr(Format(CANTEMBD * 100, 15, Text1100009), ' ', '0');
                    CANTEMB := CopyStr(CANTEMB, 3, 11) + ',' + CopyStr(CANTEMB, 14, 2) + '0';
                    NCAJAST := '0';
                    NCAJAST := ConvertStr(Format(NCAJAS * 100, 15, Text1100009), ' ', '0');
                    NCAJAST := CopyStr(NCAJAST, 3, 11) + ',' + CopyStr(NCAJAST, 14, 2) + '0';

                    ///// aqui2
                    /*
                    1 IDCAB X 10 Campo de enlace con la tabla de cabeceras
                    2 IDEMB X 10 Identificador de embalajes
                    3 CPS X 12 Número de jerarquía de niveles
                    4 CPSPADRE X 12 Nivel jerárquico del que depende el nivel actual
                    5 CANTEMB N 15.3 Número de paquetes dentro de esta unidad de
                    #6 .. #7 No aplicable
                    8 TIPEMB X 3 Tipo de embalaje
                    #9 .. #10 No aplicable
                    11 PESON N 15.3 Peso neto total
                    12 PESOB N 15.3 Peso bruto total
                    #13 .. #22 No aplicable
                    23 SSCC1 X 35 SSCC de la unidad de expedición descrita 1
                    #24 .. #28 No aplicable
                    29 TIPO2 X 3 Tipo de embalaje 2 contenido
                    30 TCAJAS N 15 Número total de cajas contenidas
                    #31 .. #43 No aplicable

                    IDCAB IDEMB CPS CPSPADRE 00000000009,12352 2 SL DESCEMB 1
                    00000000010,12300000000011,12300000000012,12300000000013,123KGM00000000014,12300000000015,12300000000016,123CMT00000000017,123CRUDESCMANI
                    SSCC1 SSCC2 SSCC3 SSCC4 SSCC5
                    LOTE CT 000000000000018DDEFECMAT FECCAD FECCON
                    00000000019,123000000000000020000000000000021FOR000000000000022000000000000023GRAI REFTRANS
                    FECREFTRANS
                    IDCAB IDEMB CPS CPSPADRE 00000000118,12350 2 200DESCEMB 3
                    00000000119,12300000000120,12300000000121,12300000000122,123GRM00000000123,12300000000124,12300000000125,123CMT00000000126,123PSCDESCMANI
                    SSCC1 SSCC2 SSCC3 SSCC4 SSCC5
                    LOTE SW 000000000000127DDEFECMAT FECCAD FECCON
                    00000000128,123000000000000129000000000000130FOR000000000000131000000000000132GRAI REFTRANS
                    FECREFTRANS
                    */

                    /////IDEMB:=FORMAT(Cajasporenvio."Caja num"+1);
                    /////CPS:=FORMAT(Cajasporenvio."Caja num"+1);
                    contalin := contalin + 1;
                    CPSPADRE := '1';
                    /////IF contalin=1 THEN BEGIN
                    /////CPSPADRE:='';
                    /////END;
                    TIPOEMB := '201';
                    TIPO := 'CT';

                    CPSPADRE := '2';
                    TIPOEMB := 'CT';
                    TIPO := 'CT';
                    IDEMB := IncStr(IDEMB);
                    CPS := IncStr(CPS);


                    pesoneto := '0';
                    pesoneto := ConvertStr(Format(dpesoneto * 100, 15, Text1100009), ' ', '0');
                    pesoneto := CopyStr(pesoneto, 3, 11) + ',' + CopyStr(pesoneto, 14, 2) + '0';
                    pesobruto := '0';
                    pesobruto := ConvertStr(Format(dpesobruto * 100, 15, Text1100009), ' ', '0');
                    pesobruto := CopyStr(pesobruto, 3, 11) + ',' + CopyStr(pesobruto, 14, 2) + '0';
                    TextoSalida1 := Format(CopyStr(IDECAB, 1, 10)) + '|' + /////
                          Format(CopyStr(IDEMB, 1, 10)) + '|' + /////
                          Format(CopyStr(CPS, 1, 10)) + '|' + /////
                          Format(CopyStr(CPSPADRE, 1, 35)) + '|' + /////
                          Format(CopyStr(CANTEMB, 1, 15)) + '|' + /////
                          '|' + ///// -6
                          '|' + ///// -7
                          Format(CopyStr(TIPOEMB, 1, 3)) + '|' + ///// -8
                          '|' + ///// -9
                          '|' + ///// -10
                          Format(pesobruto) + '|' + ///// -11
                          Format(pesoneto) + '|' + ///// -12
                          '|' + ///// -13
                          '|' + ///// -14
                          '|' + ///// -25
                          '|' + ///// -26
                          '|' + ///// -27
                          '|' + ///// -28
                          '|' + ///// -29
                          '|' + ///// -20
                          '|' + ///// -21
                          '|' + ///// -22
                          Format(Cajasporenvio."SSCC sin guiones") + '|' + ///// -23
                          '|' + ///// -24
                          '|' + ///// -25
                          '|' + ///// -26
                          '|' + ///// -27
                          '|' + ///// -28
                          '|' + ///// -29
                          Format(NCAJAST) + '|' + ///// -30
                          '|' + ///// -31
                          '|' + ///// -32
                          '|' + ///// -33
                          '|' + ///// -34
                          '|' + ///// -35
                          '|' + ///// -36
                          '|' + ///// -37
                          '|' + ///// -38
                          '|' + ///// -39
                          '|' + ///// -40
                          '|' + ///// -41
                          '|' + ///// -42
                          '|'; ///// -43
                               ///         ArchSalida6.Write(TextoSalida1);
                end;
            until X = NCAJAS + 1;
        end;

        ///ArchSalida6.Close;

    end;

}

