#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50038 "Automaticos EDICOM facturas"



{
    Permissions = tabledata "Sales Invoice Header" = RMID,  tabledata "Sales Cr.Memo Header" = RMID, tabledata "VAT Entry" = RMID;
    

    trigger OnRun()
    begin


        nomdir := '';
        ADAIA.Reset();
        ADAIA.SetRange(texto, 'AUTOMATICOS EDICOM-CU-50038');
        IF ADAIA.FindSet() THEN begin
            nomdir := ADAIA.Ruta;
        end;


        SalesInvoiceHeader3.Reset;
        SalesInvoiceHeader3.SetCurrentkey("EDI factueas enviar", "EDI factueas enviado");
        SalesInvoiceHeader3.SetRange("EDI factueas enviar", true);
        SalesInvoiceHeader3.SetRange("EDI factueas enviado", false);
        SalesInvoiceHeader3.SetRange("Posting Date", 20241206D, TODAY);
        if SalesInvoiceHeader3.FindFirst then
            repeat
                Customer.Get(SalesInvoiceHeader3."Sell-to Customer No.");
                if Customer."No enviar a EDICOM" = false then begin
                    GrabaEDICOM(SalesInvoiceHeader3."No.");
                end;
                SalesInvoiceHeader2.Get(SalesInvoiceHeader3."No.");
                SalesInvoiceHeader2."EDI factueas enviado" := true;
                SalesInvoiceHeader2."EDI Facturas Fecha enviado" := CreateDatetime(Today, Time);
                SalesInvoiceHeader2.Modify;
            until SalesInvoiceHeader3.Next = 0;



        SalesCrMemoHeader3.Reset;
        SalesCrMemoHeader3.SetCurrentkey("EDI factueas enviar", "EDI factueas enviado");
        SalesCrMemoHeader3.SetRange("EDI factueas enviar", true);
        SalesCrMemoHeader3.SetRange("EDI factueas enviado", false);
        SalesCrMemoHeader3.SetRange("Posting Date", 20241206D, TODAY);
        if SalesCrMemoHeader3.FindFirst then
            repeat
                Customer.Get(SalesCrMemoHeader3."Sell-to Customer No.");
                if Customer."No enviar a EDICOM" = false then begin
                    GrabaEDICOMabonos(SalesCrMemoHeader3."No.");
                end;
                SalesCrMemoHeader2.Get(SalesCrMemoHeader3."No.");
                SalesCrMemoHeader2."EDI factueas enviado" := true;
                SalesCrMemoHeader2."EDI Facturas Fecha enviado" := CreateDatetime(Today, Time);
                SalesCrMemoHeader2.Modify;
            until SalesCrMemoHeader3.Next = 0;
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
        NUMFAC: Code[15];
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
        ItemLedgerEntryCOPIA: Record "Item Ledger Entry-COPIA";
        HACERLINEAS: Boolean;
        SalesCrMemoHeader2: Record "Sales Cr.Memo Header";
        SalesCrMemoHeader3: Record "Sales Cr.Memo Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        Customer2: Record Customer;
        RelacionproductogrupoMetros: Record "Relacion producto-grupo Metros";
        FEMBARQUE: Code[20];
        FENTRGA: Code[20];
        CustomerPriceGroup: Record "Customer Discount Group";
        Multitabla: Record Multitabla;
        CAPITALSOCIAL: Code[10];
        ADAIA: Record ADAIA;
        NOMDIR: TEXT;



    procedure GrabaEDICOM(codefac: Code[20])
    var
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        FileName: Text;
        InStream: InStream;
        FicherosHagen: Codeunit FicherosHagen;
        OutTxt: Text;
        CarriageReturn: Char;
        LineFeed: Char;
        Data: BigText;
    begin

        CarriageReturn := 13; // 13 es el valor ASCII para Carriage Return (CR)
        LineFeed := 10;       // 10 es el valor ASCII para Line Feed (LF)

        Clear(TempBlob);
        TempBlob.CreateOutStream(OutStream, TextEncoding::Windows);


        CompanyInformation.Get;
        HACERLINEAS := false;

        SalesReceivablesSetup.Get;

        SalesInvoiceHeader.Reset;
        SalesInvoiceHeader.SetRange("No.", codefac);
        if SalesInvoiceHeader.FindSet then
            repeat
                ////////IF (SalesInvoiceHeader."Sell-to Country/Region Code"='ES') AND
                /////IF (SalesInvoiceHeader."Bill-to Country/Region Code"='ES') AND
                if (SalesInvoiceHeader."No. Series" <> 'V-FAC-DOC')
                  then begin

                    TIPO1 := '';
                    PORCEN1 := '';
                    IMPDTO1 := '';
                    NUMFAC := SalesInvoiceHeader."No.";
                    VENDEDOR := CompanyInformation.GLN;
                    EMISOR := CompanyInformation.GLN;
                    COBRADOR := CompanyInformation.GLN;
                    Customer.Get(SalesInvoiceHeader."Sell-to Customer No.");
                    if Customer."Grupo clientes" <> '' then begin
                        Multitabla.Get(Multitabla.Tabla::"Grupo de clientes", Customer."Grupo clientes");
                    end;
                    COMPRADO := Customer."Quien pide";
                    DEPTO := '';
                    if SalesInvoiceHeader."Customer Price Group" = 'ECI' then begin
                        DEPTO := '219';
                    end;
                    CLIENTE := Customer."A quien se factura";
                    RECEPTOR := Customer."Sucrusal entrega";
                    PAGADOR := Customer."Quien paga";
                    PEDIDO := CopyStr(SalesInvoiceHeader."Your Reference", 1, 17);
                    OutTxt := Format(CopyStr(NUMFAC, 1, 15)) + '|' + ///// ECI 16 ///-1
                             Format(CopyStr(VENDEDOR, 1, 17)) + '|' + ///Código EDI del vendedor o proveedor. ///-2
                           Format(CopyStr(EMISOR, 1, 17)) + '|' +  //-3
                           Format(CopyStr(COBRADOR, 1, 17)) + '|' +// -4
                           Format(CopyStr(COMPRADO, 1, 17)) + '|' + //-5
                           Format(CopyStr(DEPTO, 1, 13)) + '|' + /////  DEPTO X 13 Departamento que hace el pedido. ///-6
                           Format(CopyStr(RECEPTOR, 1, 17)) + '|' + ///X 17 Código EDI del receptor de la mercancía. ///-7
                           Format(CopyStr(CLIENTE, 1, 17)) + '|' + ///X 17 Código EDI del destinatario de la Factura(A ///-8
                           Format(CopyStr(PAGADOR, 1, 17)) + '|' +///X 17 Código EDI de quien paga. ///-9
                           Format(CopyStr(PEDIDO, 1, 17)) + '|';
                    data.AddText(OutTxt);
                    ///X 17 Número de pedido del destinatario de la factura. ///-10

                    FFECHA := SalesInvoiceHeader."Posting Date";
                    CALCULOFECHA;
                    FECHAEFE := FECHA;
                    NODO := '380';
                    RSOCIAL := CopyStr(SalesInvoiceHeader."Bill-to Name", 1, 70);
                    CALLE := CopyStr(SalesInvoiceHeader."Bill-to Address", 1, 35);
                    CIUDAD := CopyStr(SalesInvoiceHeader."Bill-to City", 1, 35);
                    CP := CopyStr(SalesInvoiceHeader."Bill-to Post Code", 1, 5);
                    NIF := SalesInvoiceHeader."VAT Registration No.";
                    ALBARAN := '';
                    fechapediso := SalesInvoiceHeader."Posting Date";
                    SalesInvoiceLine.Reset;
                    SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                    if SalesInvoiceLine.FindFirst then
                        repeat
                            if (SalesInvoiceLine."Shipment No." <> '') and (SalesInvoiceLine.Quantity <> 0) then begin
                                if Customer2.Get(SalesInvoiceLine."Sell-to Customer No.") then begin
                                    RECEPTOR := Customer2."Sucrusal entrega";
                                    CLIENTE := Customer2."A quien se factura";
                                end;
                                ALBARAN := SalesInvoiceLine."Shipment No.";
                                if SalesShipmentHeader.Get(ALBARAN) then begin
                                    fechapediso := SalesInvoiceHeader."Order Date";
                                end;
                            end;
                        until SalesInvoiceLine.Next = 0;
                    ValueEntry.Reset;
                    ValueEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
                    if ValueEntry.FindFirst then begin
                        ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.");
                        ALBARAN := ItemLedgerEntry."Document No.";
                        if SalesShipmentHeader.Get(ALBARAN) then begin
                            fechapediso := SalesInvoiceHeader."Order Date";
                        end;
                    end;
                    //ValueEntrycopia.Reset;
                    //ValueEntrycopia.SetRange("Document No.", SalesInvoiceHeader."No.");
                    //if ValueEntrycopia.FindFirst then begin
                    //ItemLedgerEntryCOPIA.Get(ValueEntrycopia."Item Ledger Entry No.");
                    //ALBARAN := ItemLedgerEntryCOPIA."Document No.";
                    //if SalesShipmentHeader.Get(ALBARAN) then begin
                    //  fechapediso := SalesInvoiceHeader."Order Date";
                    //end;
                    //end;
                    CONTRATO := '';
                    NFACSUS := '';
                    OutTxt := Format(CopyStr(FECHA, 1, 12)) + '|' + // X 12 Fecha de emisión de la factura. ///-11
                            Format(CopyStr(NODO, 1, 3)) + '|' + ///// 32 ///-12
                            '|' + //-13
                             Format(CopyStr(RSOCIAL, 1, 70)) + '|' + ///// 70 ///-14
                          Format(CopyStr(CALLE, 1, 35)) + '|' + ///// 35 ///-15
                          Format(CopyStr(CIUDAD, 1, 35)) + '|' + ///// 35 ///-16
                          Format(CopyStr(CP, 1, 5)) + '|' + ///// X 5 Código postal del cliente ///-17
                          Format(CopyStr(NIF, 1, 17)) + '|' + ///// X 17 NIF del cliente ///-18
                          '|' + ///-19
                           Format(CopyStr(ALBARAN, 1, 17)) + '|' + ///// X 17 Número de albarán previo a la factura del 10 ///-20
                          Format(CopyStr(CONTRATO, 1, 17)) + '|' + ///// X 17 Número de contrato en facturas de servicios. 11  ///-21
                          Format(CopyStr(NFACSUS, 1, 17)) + '|'; ///// X 17 Número de factura sustitutiva 12  ///-22
                    data.AddText(OutTxt);


                    SalesInvoiceHeader.CalcFields(Amount, "Amount Including VAT");

                    DIVISA := 'EUR';
                    SUMBRUTO := '0';
                    SUMBRUTO := ConvertStr(Format(SalesInvoiceHeader.Amount * 100, 15, Text1100009), ' ', '0');
                    SUMBRUTO := CopyStr(SUMBRUTO, 3, 11) + ',' + CopyStr(SUMBRUTO, 14, 2) + '0';
                    SUMNETOS := '0';
                    SUMNETOS := ConvertStr(Format(SalesInvoiceHeader.Amount * 100, 15, Text1100009), ' ', '0');
                    SUMNETOS := CopyStr(SUMNETOS, 3, 11) + ',' + CopyStr(SUMNETOS, 14, 2) + '0';
                    CARGOS := '0';
                    CARGOS := ConvertStr(Format(cero * 100, 15, Text1100009), ' ', '0');
                    CARGOS := CopyStr(CARGOS, 3, 11) + ',' + CopyStr(CARGOS, 14, 2) + '0';
                    DESCUEN := '0';
                    DESCUEN := ConvertStr(Format(cero * 100, 15, Text1100009), ' ', '0');
                    DESCUEN := CopyStr(DESCUEN, 3, 11) + ',' + CopyStr(DESCUEN, 14, 2) + '0';



                    VATEntryTemp.Reset;
                    /////VATEntryTemp.SETRANGE("Document No.",SalesInvoiceHeader."No.");
                    if VATEntryTemp.FindFirst then
                        repeat
                            VATEntryTemp.Delete;
                        until VATEntryTemp.Next = 0;

                    VATEntry.Reset;
                    VATEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
                    if VATEntry.FindFirst then
                        repeat
                            VATEntryTemp.Reset;
                            VATEntryTemp.SetRange(VATEntryTemp."VAT %", VATEntry."VAT %");
                            VATEntryTemp.SetRange(VATEntryTemp."EC %", VATEntry."EC %");
                            if VATEntryTemp.FindFirst then begin
                                VATEntryTemp.Base := VATEntryTemp.Base + VATEntry.Base;
                                VATEntryTemp.Amount := VATEntryTemp.Amount + VATEntry.Amount;
                                VATEntryTemp.Modify;
                            end;
                            if not VATEntryTemp.FindFirst then begin
                                VATEntryTemp := VATEntry;
                                VATEntryTemp.Insert;
                            end;
                        until VATEntry.Next = 0;

                    BASEIMP1 := '';
                    TIPOIMP1 := '';
                    TASAIMP1 := '';
                    BASEIMP2 := '';
                    TIPOIMP2 := '';
                    TASAIMP2 := '';
                    BASEIMP3 := '';
                    TIPOIMP3 := '';
                    TASAIMP3 := '';
                    BASEIMP4 := '';
                    TIPOIMP4 := '';
                    TASAIMP4 := '';
                    BASEIMP5 := '';
                    TIPOIMP5 := '';
                    TASAIMP5 := '';
                    IMPIMP1 := '';
                    IMPIMP2 := '';
                    IMPIMP3 := '';
                    IMPIMP4 := '';
                    IMPIMP5 := '';


                    BASEIMP1 := '00000000000,000';
                    TIPOIMP1 := 'VAT';
                    TASAIMP1 := '0000,000';
                    IMPIMP1 := '00000000000,000';
                    BASEIMP2 := '00000000000,000';
                    TIPOIMP2 := 'VAT';
                    TASAIMP2 := '0000,000';
                    IMPIMP2 := '00000000000,000';
                    BASEIMP3 := '00000000000,000';
                    TIPOIMP3 := 'VAT';
                    TASAIMP3 := '0000,000';
                    IMPIMP3 := '00000000000,000';
                    BASEIMP4 := '00000000000,000';
                    TIPOIMP4 := 'VAT';
                    TASAIMP4 := '0000,000';
                    IMPIMP4 := '00000000000,000';
                    BASEIMP5 := '00000000000,000';
                    TIPOIMP5 := 'VAT';
                    TASAIMP5 := '0000,000';
                    IMPIMP5 := '00000000000,000';
                    BASEIMP6 := '00000000000,000';
                    TIPOIMP6 := 'VAT';
                    TASAIMP6 := '0000,000';
                    IMPIMP6 := '00000000000,000';

                    tipoimp := 0;
                    IMPTOTAL := 0;
                    VATEntryTemp.Reset;
                    VATEntryTemp.SetRange("Document No.", SalesInvoiceHeader."No.");
                    if VATEntryTemp.FindFirst then
                        repeat
                            tipoimp := tipoimp + 1;
                            if tipoimp = 1 then begin
                                BASEIMP1 := ConvertStr(Format(VATEntryTemp.Base * 100, 15, Text1100009), ' ', '0');
                                BASEIMP1 := CopyStr(BASEIMP1, 3, 11) + ',' + CopyStr(BASEIMP1, 14, 2) + '0';
                                TIPOIMP1 := 'VAT';
                                TASAIMP1 := ConvertStr(Format(VATEntryTemp."VAT %" * 100, 8, Text1100009), ' ', '0');
                                TASAIMP1 := CopyStr(TASAIMP1, 3, 4) + ',' + CopyStr(TASAIMP1, 7, 2) + '0';
                                IMPIMP1 := ConvertStr(Format(VATEntryTemp.Amount * 100, 15, Text1100009), ' ', '0');
                                IMPIMP1 := CopyStr(IMPIMP1, 3, 11) + ',' + CopyStr(IMPIMP1, 14, 2) + '0';
                            end;
                            if tipoimp = 2 then begin
                                BASEIMP2 := ConvertStr(Format(VATEntryTemp.Base * 100, 15, Text1100009), ' ', '0');
                                BASEIMP2 := CopyStr(BASEIMP2, 3, 11) + ',' + CopyStr(BASEIMP2, 14, 2) + '0';
                                TIPOIMP2 := 'VAT';
                                TASAIMP2 := ConvertStr(Format(VATEntryTemp."VAT %" * 100, 8, Text1100009), ' ', '0');
                                TASAIMP2 := CopyStr(TASAIMP2, 3, 4) + ',' + CopyStr(TASAIMP2, 7, 2) + '0';
                                IMPIMP2 := ConvertStr(Format(VATEntryTemp.Amount * 100, 15, Text1100009), ' ', '0');
                                IMPIMP2 := CopyStr(IMPIMP2, 3, 11) + ',' + CopyStr(IMPIMP2, 14, 2) + '0';
                            end;
                            if tipoimp = 3 then begin
                                BASEIMP3 := ConvertStr(Format(VATEntryTemp.Base * 100, 15, Text1100009), ' ', '0');
                                BASEIMP3 := CopyStr(BASEIMP3, 3, 11) + ',' + CopyStr(BASEIMP3, 14, 2) + '0';
                                TIPOIMP3 := 'VAT';
                                TASAIMP3 := ConvertStr(Format(VATEntryTemp."VAT %" * 100, 8, Text1100009), ' ', '0');
                                TASAIMP3 := CopyStr(TASAIMP3, 3, 4) + ',' + CopyStr(TASAIMP3, 7, 2) + '0';
                                IMPIMP3 := ConvertStr(Format(VATEntryTemp.Amount * 100, 15, Text1100009), ' ', '0');
                                IMPIMP3 := CopyStr(IMPIMP3, 3, 11) + ',' + CopyStr(IMPIMP3, 14, 2) + '0';
                            end;
                            if tipoimp = 4 then begin
                                BASEIMP4 := ConvertStr(Format(VATEntryTemp.Base * 100, 15, Text1100009), ' ', '0');
                                BASEIMP4 := CopyStr(BASEIMP4, 3, 11) + ',' + CopyStr(BASEIMP4, 14, 2) + '0';
                                TIPOIMP4 := 'VAT';
                                TASAIMP4 := ConvertStr(Format(VATEntryTemp."VAT %" * 100, 8, Text1100009), ' ', '0');
                                TASAIMP4 := CopyStr(TASAIMP4, 3, 4) + ',' + CopyStr(TASAIMP4, 7, 2) + '0';
                                IMPIMP4 := ConvertStr(Format(VATEntryTemp.Amount * 100, 15, Text1100009), ' ', '0');
                                IMPIMP4 := CopyStr(IMPIMP4, 3, 11) + ',' + CopyStr(IMPIMP4, 14, 2) + '0';
                            end;
                            if tipoimp = 5 then begin
                                BASEIMP5 := ConvertStr(Format(VATEntryTemp.Base * 100, 15, Text1100009), ' ', '0');
                                BASEIMP5 := CopyStr(BASEIMP5, 3, 11) + ',' + CopyStr(BASEIMP5, 14, 2) + '0';
                                TIPOIMP5 := 'VAT';
                                TASAIMP5 := ConvertStr(Format(VATEntryTemp."VAT %" * 100, 8, Text1100009), ' ', '0');
                                TASAIMP5 := CopyStr(TASAIMP5, 3, 4) + ',' + CopyStr(TASAIMP5, 7, 2) + '0';
                                IMPIMP5 := ConvertStr(Format(VATEntryTemp.Amount * 100, 15, Text1100009), ' ', '0');
                                IMPIMP5 := CopyStr(IMPIMP5, 3, 11) + ',' + CopyStr(IMPIMP5, 14, 2) + '0';
                            end;
                            if tipoimp = 6 then begin
                                BASEIMP6 := ConvertStr(Format(VATEntryTemp.Base * 100, 15, Text1100009), ' ', '0');
                                BASEIMP6 := CopyStr(BASEIMP6, 3, 11) + ',' + CopyStr(BASEIMP6, 14, 2) + '0';
                                TIPOIMP6 := 'VAT';
                                TASAIMP6 := ConvertStr(Format(VATEntryTemp."VAT %" * 100, 8, Text1100009), ' ', '0');
                                TASAIMP6 := CopyStr(TASAIMP6, 3, 4) + ',' + CopyStr(TASAIMP6, 7, 2) + '0';
                                IMPIMP6 := ConvertStr(Format(VATEntryTemp.Amount * 100, 15, Text1100009), ' ', '0');
                                IMPIMP6 := CopyStr(IMPIMP6, 3, 11) + ',' + CopyStr(IMPIMP6, 14, 2) + '0';
                            end;
                            IMPTOTAL := IMPTOTAL + VATEntry.Amount;
                        until VATEntryTemp.Next = 0;


                    FFECHA := SalesInvoiceHeader."Due Date";
                    CALCULOFECHA;
                    VTO1 := FECHA;
                    contavto := 0;
                    CustLedgerEntry.Reset;
                    CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
                    CustLedgerEntry.SetRange(Open, true);
                    if CustLedgerEntry.FindFirst then
                        repeat
                            contavto := contavto + 1;
                            CustLedgerEntry.CalcFields(CustLedgerEntry."Remaining Amt. (LCY)");
                            if contavto = 1 then begin
                                ///FFECHA:=CustLedgerEntry."Due Date";CALCULOFECHA;
                                ///VTO1:=FECHA;
                                ///IMPIMP1:=CONVERTSTR(FORMAT(CustLedgerEntry."Remaining Amt. (LCY)"*100,15,Text1100009),' ','0');
                                ///IMPIMP1:=COPYSTR(IMPIMP1,3,11)+','+COPYSTR(IMPIMP1,14,2)+'0';
                            end;
                            if contavto = 2 then begin
                                IMPIMP2 := ConvertStr(Format(CustLedgerEntry."Remaining Amt. (LCY)" * 100, 15, Text1100009), ' ', '0');
                                IMPIMP2 := CopyStr(IMPIMP2, 3, 11) + ',' + CopyStr(IMPIMP2, 14, 2) + '0';
                            end;
                            if contavto = 3 then begin
                                IMPIMP3 := ConvertStr(Format(CustLedgerEntry."Remaining Amt. (LCY)" * 100, 15, Text1100009), ' ', '0');
                                IMPIMP3 := CopyStr(IMPIMP3, 3, 11) + ',' + CopyStr(IMPIMP3, 14, 2) + '0';
                            end;
                            if contavto = 4 then begin
                                IMPIMP4 := ConvertStr(Format(CustLedgerEntry."Remaining Amt. (LCY)" * 100, 15, Text1100009), ' ', '0');
                                IMPIMP4 := CopyStr(IMPIMP4, 3, 11) + ',' + CopyStr(IMPIMP4, 14, 2) + '0';
                            end;

                        until CustLedgerEntry.Next = 0;


                    OutTxt := '|' + ///-23
                              Format(CopyStr(DIVISA, 1, 3)) + '|' + ///// X 3 Tipo de divisa utilizada en la factura: EUR = Euros. 14  ///-24
                          Format(CopyStr(SUMBRUTO, 1, 15)) + '|' + ///// N 15.3 Sumatorio brutos 15  ///-25
                          Format(CopyStr(SUMNETOS, 1, 15)) + '|' + ///// N 15.3 Sumatorio de netos 16  ///-26
                          Format(CopyStr(CARGOS, 1, 15)) + '|' + ///// N 15.3 Sumatorio de cargos 17  ///-27
                          Format(CopyStr(DESCUEN, 1, 15)) + '|' + ///// N 15.3 Sumatorio de descuentos 18  ///-28
                          Format(CopyStr(BASEIMP1, 1, 15)) + '|' + ///// N 15.3 Base imponible del impuesto 1 [G47MOA.5004] ([G47MOA.5025] = 125) 19  ///-29
                          Format(CopyStr(TIPOIMP1, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 1 20  ///-30
                          Format(CopyStr(TASAIMP1, 1, 8)) + '|' + ///// N 8.3 Porcentaje del impuesto 1 21 ///-31
                          Format(CopyStr(IMPIMP1, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 1 22  ///-32
                          Format(CopyStr(BASEIMP2, 1, 15)) + '|' + ///// N 15.3 Base imponible del impuesto 2 23 ///-33
                          Format(CopyStr(TIPOIMP2, 1, 3)) + '|'; ///// X 3 Tipo de impuesto 2 24 ///-34
                    data.AddText(OutTxt);
                    OutTxt := Format(CopyStr(TASAIMP2, 1, 8)) + '|' + ///// N 8.3 25 ///-35
                                 Format(CopyStr(IMPIMP2, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 2 26 ///-36
                                 Format(CopyStr(BASEIMP3, 1, 15)) + '|' + ///// N 15.3 Base imponible del impuesto 3 27 ///-37
                                 Format(CopyStr(TIPOIMP3, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 3 28 ///-38
                                 Format(CopyStr(TASAIMP3, 1, 8)) + '|' + ///// N 8.3 Porcentaje del impuesto 3 29 ///-39
                                 Format(CopyStr(IMPIMP3, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 3 30 ///-40
                                 Format(CopyStr(BASEIMP4, 1, 15)) + '|' + ///// N 15.3 Base imponible del impuesto 4 31 ///-41
                                 Format(CopyStr(TIPOIMP4, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 4 32 ///-42
                                 Format(CopyStr(TASAIMP4, 1, 8)) + '|' + ///// N 8.3 Porcentaje del impuesto 4 33 ///-43
                                 Format(CopyStr(IMPIMP4, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 4 34 ///-44
                                 Format(CopyStr(BASEIMP5, 1, 15)) + '|'; ///// N 15.3 Base imponible del impuesto 5 3///-45
                    data.AddText(OutTxt);

                    BASIMPFA := ConvertStr(Format(SalesInvoiceHeader.Amount * 100, 15, Text1100009), ' ', '0');
                    BASIMPFA := CopyStr(BASIMPFA, 3, 11) + ',' + CopyStr(BASIMPFA, 14, 2) + '0';


                    TOTIMP := ConvertStr(Format((SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount) * 100, 15, Text1100009), ' ', '0');
                    TOTIMP := CopyStr(TOTIMP, 3, 11) + ',' + CopyStr(TOTIMP, 14, 2) + '0';

                    TOTAL := ConvertStr(Format(SalesInvoiceHeader."Amount Including VAT" * 100, 15, Text1100009), ' ', '0');
                    TOTAL := CopyStr(TOTAL, 3, 11) + ',' + CopyStr(TOTAL, 14, 2) + '0';


                    OutTxt := Format(CopyStr(TIPOIMP5, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 5 [G47TAX.5153] ([G47TAX.5283] = 7) ///-46
                                 Format(CopyStr(TASAIMP5, 1, 8)) + '|' + ///// N 8.3 Porcentaje del impuesto 5 ///-47
                                 Format(CopyStr(IMPIMP5, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 5 38 ///-48
                                 Format(CopyStr(BASEIMP6, 1, 15)) + '|' + ///// N 15.3 Base imponible del impuesto 6 39  ///-49
                                 Format(CopyStr(TIPOIMP6, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 6 40 ///-50
                                 Format(CopyStr(TASAIMP6, 1, 8)) + '|' + ///// N 8.3 Porcentaje del impuesto 6 41  ///-51
                                 Format(CopyStr(IMPIMP6, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 6 [G47MOA.5004] ([G47MOA.5025] = 176) 42 ///-52
                                 Format(CopyStr(BASIMPFA, 1, 15)) + '|' + ///// N 15.3 Base imponible de la factura 43 ///-53
                                 Format(CopyStr(TOTIMP, 1, 15)) + '|' + ///// N 15.3 Importe total de impuestos 44 ///-54
                                 Format(CopyStr(TOTAL, 1, 15)) + '|' + ///// N 15.3 45  ///-55
                                 Format(CopyStr(VTO1, 1, 8)) + '|'; ///// X 8 Fecha primer vencimiento 46 ///-56
                    data.AddText(OutTxt);
                    OutTxt := Format(CopyStr(IMPVTO1, 1, 15)) + '|' + ///// N 15.3 Importe primer vencimiento 47 ///-57
                                 '|' + ///-58
                           '|' +  ///-59
                           '|' +  ///-60
                           '|' +  ///-61
                           Format(CopyStr(TPVERDE, 1, 15)) + '|' + ///// N 15.3 Total punto verde en factura 52 ///-62
                          Format(CopyStr(CALIF1, 1, 3)) + '|' + ///// X 3 Calificador descuento/cargo 1 [G14ALC.5463] 53 ///-63
                          Format(CopyStr(SECUEN1, 1, 2)) + '|' + ///// N 2 Secuencia calculo descuento/cargo 1 54 ///-64
                          Format(CopyStr(TIPO1, 1, 3)) + '|' + ///// X 3 Tipo descuento/cargo 1 55 ///-65
                          Format(CopyStr(PORCEN1, 1, 8)) + '|' + ///// N 8.3 Porcentaje del descuento o cargo 1. 56 ///-66
                          Format(CopyStr(IMPDES1, 1, 15)) + '|' + ///// N 15.3 Importe del descuento o cargo 1. 57 ///-67
                          Format(CopyStr(CALIF2, 1, 3)) + '|' + ///// X 3 Calificador de cargo o descuento 2. 58 ///-68
                          Format(CopyStr(SECUEN2, 1, 2)) + '|' + ///// N 2 Secuencia calculo descuento/cargo 2 59 ///-69
                          Format(CopyStr(TIPO2, 1, 3)) + '|' + ///// X 3 Tipo de descuento/cargo 2 60 ///-70
                          Format(CopyStr(PORCEN2, 1, 8)) + '|' + ///// N 8.3 Porcentaje del descuento o cargo 2. 61 ///-71
                          Format(CopyStr(IMPDES2, 1, 15)) + '|' + ///// N 15.3 Importe del descuento o cargo 2. 62 ///-72
                          Format(CopyStr(CALIF3, 1, 3)) + '|' + ///// X 3 Calificador de cargo o descuento 3. 63 ///-73
                          Format(CopyStr(SECUEN3, 1, 2)) + '|' + ///// N 2 Secuencia calculo descuento/cargo 3 64 ///-74
                          Format(CopyStr(TIPO3, 1, 3)) + '|' + ///// X 3 Tipo de descuento/cargo 3 65 ///-75
                          Format(CopyStr(PORCEN3, 1, 8)) + '|'; ///// N 8.3 Porcentaje del descuento o cargo 3. 66 ///-76
                    data.AddText(OutTxt);
                    OutTxt := Format(CopyStr(IMPDES3, 1, 15)) + '|' + ///// N 15.3 Importe del descuento o cargo 3. 67 ///-77
                                 Format(CopyStr(CALIF4, 1, 3)) + '|' + ///// X 3 Calificador de cargo o descuento 4. 68 ///-78
                                 Format(CopyStr(SECUEN4, 1, 2)) + '|' + ///// N 2 Secuencia calculo descuento/cargo 4 69 ///-79
                                 Format(CopyStr(TIPO4, 1, 3)) + '|' + ///// X 3 Tipo de descuento/cargo 4 70 ///-80
                                 Format(CopyStr(PORCEN4, 1, 8)) + '|' + ///// N 8.3 Porcentaje del descuento o cargo 4. 71 ///-81
                                 Format(CopyStr(IMPDES4, 1, 15)) + '|' + ///// N 15.3 Importe del descuento o cargo 4. 72 ///-82
                                 Format(CopyStr(CALIF5, 1, 3)) + '|' + ///// X 3 Calificador de cargo o descuento 5. 73 ///-83
                                 Format(CopyStr(SECUEN5, 1, 2)) + '|' + ///// N 2 Secuencia calculo descuento/cargo 5 74 ///-84
                                 Format(CopyStr(TIPO5, 1, 3)) + '|' + ///// X 3 Tipo de descuento/cargo 5 75 ///-85
                                 Format(CopyStr(PORCEN5, 1, 8)) + '|' + ///// N 8.3 76 ///-86
                                 Format(CopyStr(IMPDES5, 1, 15)) + '|'; ///// N 15.3 Importe  del descuento o cargo 5. 77 ///-87
                    data.AddText(OutTxt);
                    ERSOCIAL := CompanyInformation.Name;
                    ECALLE := CompanyInformation.Address;
                    EPOBLAC := CompanyInformation.County;
                    ECP := CompanyInformation."Post Code";
                    ENIF := CompanyInformation."VAT Registration No.";

                    OutTxt := Format(CopyStr(ERSOCIAL, 1, 70)) + '|' + ///// X 70 Razón social del emisor de la factura. 78 ///-88
                                 Format(CopyStr(ECALLE, 1, 35)) + '|' + ///// X 35 Domicilio del emisor de la factura. 79 ///-89
                                 Format(CopyStr(EPOBLAC, 1, 35)) + '|' + ///// X 35 Población del emisor de la factura 80  ///-90
                                 Format(CopyStr(ECP, 1, 5)) + '|' + ///// X 5 Código postal del emisor de la factura. 81 ///-91
                                 Format(CopyStr(ENIF, 1, 17)) + '|'; ///// X 17 NIF del emisor de la factura 82 ///-92
                    data.AddText(OutTxt);
                    FFECHA := SalesInvoiceHeader."Posting Date";
                    CALCULOFECHA;
                    FECHADOC := LAFECHA;
                    ERMERCA := 'Tomo:7.753, Folio:!, Nº hoja registral: v95742.';
                    OutTxt := Format(CopyStr(ERMERCA, 1, 70)) + '|' + ///// X 70 Registro mercantil del emisor de la factura. 83 ///-93
                                 Format(CopyStr(NOTAC, 1, 17)) + '|' + ///// X 17 Nota de cargo que se abona. 84 ///-94
                                 '|' + ///-95
                           '|' + ///-96
                           '|' + ///-96
                           Format(CopyStr(FECHAEFE, 1, 12)) + '|' + ///// X 12 Fecha efectiva del servicio 88 ///-97
                          '|' +  ///-98
                           '|' +  ///-99
                           '|' +  ///-100
                           '|' +  ///-101
                           '|' +  ///-102
                           '|' +  ///-103
                           Format(CopyStr(FECALB, 1, 12)) + '|' + ///// X 12 Fecha de albarán 95 ///-104
                          '|' +  ///-105
                           '|' +  ///-106
                           '|' +  ///-107
                           '|' + /// -108
                           '|' + /// -109
                           '|' +  ///-110
                           Format(CopyStr(FECHADOC, 1, 8)) + '|' + ///// X 8 Fecha del documento 102   ///-111
                          Format(CopyStr(REFPAGO, 1, 35)) + '|' + ///// X 35 Texto de referencia de pago 103  ///-112
                          '|'; ///-113
                    data.AddText(OutTxt);
                    NIFII := CompanyInformation."VAT Registration No.";
                    NIFPE := SalesInvoiceHeader."VAT Registration No.";
                    NIFIV := SalesInvoiceHeader."VAT Registration No.";
                    NIFPR := SalesInvoiceHeader."VAT Registration No.";
                    NIFSU := CompanyInformation."VAT Registration No.";

                    FFECHA := fechapediso;
                    CALCULOFECHA;
                    FPEDIDO := FECHA;

                    FEMBARQUE := '';
                    FENTRGA := '';
                    CAPITALSOCIAL := '';
                    if Multitabla."EDICON Grupo Sonae" then begin
                        FFECHA := SalesInvoiceHeader."Fecha enviado";
                        CALCULOFECHA;
                        FEMBARQUE := FECHA;
                        FENTRGA := FEMBARQUE;
                        CAPITALSOCIAL := '500000';
                    end;


                    OutTxt := Format(CopyStr(NIFII, 1, 17)) + '|' + ///// X 17 NIF de la empresa emisora de la factura  ///-114
                                  Format(CopyStr(NIFPE, 1, 17)) + '|' + ///// X 17 NIF de la empresa a quien se paga ///-115
                                  Format(CopyStr(NIFIV, 1, 17)) + '|' + ///// X 17 NIF de la empresa destinataria de la factura 107 ///-116
                                  Format(CopyStr(NIFPR, 1, 17)) + '|' + ///// X 17 NIF de la empresa que paga la factura 108 ///-117
                                  Format(CopyStr(NIFSU, 1, 17)) + '|' + ///// X 17 NIF de la empresa a quien se pidió la mercancía 109 ///-118
                                  '|' + ///-119
                              Format(CopyStr(NUMINCOR, 1, 17)) + '|' + ///// X 17 Número de documento incorporado 111 ///-120
                          '|' + ///-121
                           '|' + ///-122
                           '|' + ///-123
                           '|' + ///-124
                           '|' + ///-125
                           Format(CopyStr(FPEDIDO, 1, 12)) + '|' + ///// X 12 Fecha del pedido 117 ///-126
                          '|' + ///-127
                           '|' + ///-128
                           '|' + ///-129
                           Format(CopyStr(NOTIFDEVOL, 1, 17)) + '|' + ///// X 17 Número de notificación de devolución 121  ///-130
                          Format(CopyStr(FNOTIFDEVOL, 1, 12)) + '|' + ///// X 12 Fecha número de notificación de devolución 122 ///-131
                          Format(CopyStr(SEDESOC, 1, 17)) + '|' + ///// X 17 Código EDI de la razón/sede social del comprador 123 ///-132
                          '|' + ///-134
                           FEMBARQUE + ///-135
                           '|' + ///-136
                           '|' + ///-137
                           '|' + ///-138
                           '|' + ///-139
                           '|' + ///-140
                           '|' + ///-141
                           '|' + CAPITALSOCIAL + ///-142
                           '|' + ///-143
                           '|' + ///-144
                           '|' + ///-145
                           '|' + ///-146
                           '|' + FENTRGA + ///-147
                           '|' + ///-148
                           '|'; ///-149
                    data.AddText(OutTxt);
                    OutTxt := Format(CopyStr(ECPEXT, 1, 17)) + '|' + ///// X 17 Código postal del emisor de la factura extendido 140  ///-150
                                  Format(CopyStr(FECFACSUS, 1, 12)) + '|' + ///// X 12 Fecha de la factura a la que se sustituye o la que 141  ///-150
                                  Format(CopyStr(EPAIS, 1, 3)) + '|' + ///// X 3 País del emisor de la factura. 142 ///-151
                                  Format(CopyStr(RELVTO, 1, 3)) + '|' + ///// X 3 Relación de tiempo codificado [G08PAT.2009] ([G08PAT.4279] = 1) Y 143 ///-152
                                  Format(CopyStr(DIASVTO, 1, 3)) + '|' + ///// N 3 Número de periodos de pago. Número de días en 144 ///-153
                                  Format(CopyStr(PORCVTO, 1, 8)) + '|' + ///// N 8.3 Porcentaje de descuento aplicado para dicho 145 ///-154
                                  Format(CopyStr(TIPOIMPDES1, 1, 3)) + '|' + ///// X 3 Tipo de impuesto del descuento 1 146 ///-155
                                  Format(CopyStr(TASAIMPDES1, 1, 8)) + '|' + ///// N 8.3 Porcentaje del impuesto del descuento 1 147 ///-156
                                  '|' + '|' + '|' +
                                  '|' + '|' + '|' +
                                  '|' + '|' + '|' +
                                  '|' + '|' + '|' +
                                  '|' + '|' + '|' +
                                  '|' + '|' + '|' +
                                  '|' + '|' + '|' +
                                  '|' + '|' + '|' +
                                  '|' + '|' + '|' +
                                  Format(CopyStr(AUTORIZDEV, 1, 35)) + '|' + ///// X 35 Número autorización devolución (10 posiciones)
                                  '|' +
                                  Format(CopyStr(FECTAX, 1, 12)); ///// X 12 Fecha del cálculo de los impuestos de la factura.
                    data.AddText(OutTxt);



                    OutTxt += Format(CarriageReturn) + Format(LineFeed);

                    data.AddText(OutTxt);
                    HACERLINEAS := true;

                end;

            until SalesInvoiceHeader.Next = 0;



        SalesReceivablesSetup.get;


        Data.Write(OutStream);
        TempBlob.CreateInStream(InStream, TextEncoding::Windows);
        FicherosHagen.CrearFichero(NOMDIR, 'CABFAC' + Format(codefac) + '.TXT', InStream);





        if HACERLINEAS then begin
            Lineas;
        end;
    end;

    local procedure Lineas()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        FileName: Text;
        InStream: InStream;
        FicherosHagen: Codeunit FicherosHagen;
        OutTxt: Text;
        CarriageReturn: Char;
        LineFeed: Char;
        Data: BigText;
    begin



        CarriageReturn := 13; // 13 es el valor ASCII para Carriage Return (CR)
        LineFeed := 10;       // 10 es el valor ASCII para Line Feed (LF)

        Clear(TempBlob);
        TempBlob.CreateOutStream(OutStream, TextEncoding::Windows);







        NUMLINint := 0;






        ///// ,'ISO-8859-1'

        BASEIMP1 := '';
        TIPOIMP1 := '';
        TASAIMP1 := '';
        BASEIMP2 := '';
        TIPOIMP2 := '';
        TASAIMP2 := '';
        BASEIMP3 := '';
        TIPOIMP3 := '';
        TASAIMP3 := '';
        BASEIMP4 := '';
        TIPOIMP4 := '';
        TASAIMP4 := '';
        BASEIMP5 := '';
        TIPOIMP5 := '';
        TASAIMP5 := '';


        SalesInvoiceLine.Reset;
        SalesInvoiceLine.SetRange(SalesInvoiceLine."Document No.", SalesInvoiceHeader."No.");
        if SalesInvoiceLine.FindFirst then
            repeat
                if (SalesInvoiceLine."No." <> '') and (SalesInvoiceLine.Quantity <> 0) then begin

                    dtext1 := SalesInvoiceLine.Description;
                    dtext1 := ConvertStr(Format(dtext1), '"', ' ');
                    dtext1 := CASCII.Ascii2Ansi(dtext1);
                    C13 := 13;
                    C10 := 10;
                    String := dtext1;
                    String2 := '';
                    for I := 1 to StrLen(String) do begin
                        if (String[I] <> C10) and (String[I] <> C13) then begin
                            String2[I] := String[I];
                        end;
                    end;


                    NUMLINint := NUMLINint + 1;
                    NUMLIN := ConvertStr(Format(NUMLINint, 5, Text1100009), ' ', '0');
                    REFEAN := SalesInvoiceLine.Ean;
                    REFCLI := SalesInvoiceLine."No.";
                    REFPRO := SalesInvoiceLine."No.";


                    SalesInvoiceHeader.CalcFields("Grupo clientes");
                    RelacionproductogrupoMetros.Reset;
                    RelacionproductogrupoMetros.SetRange(RelacionproductogrupoMetros.Producto, SalesInvoiceLine."No.");
                    RelacionproductogrupoMetros.SetRange(RelacionproductogrupoMetros."Grupo Cliente", SalesInvoiceHeader."Grupo clientes");
                    if RelacionproductogrupoMetros.FindSet then begin
                        SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity * RelacionproductogrupoMetros.Metros;
                        SalesInvoiceLine."Unit Price" := ROUND(SalesInvoiceLine."Unit Price" / RelacionproductogrupoMetros.Metros, 0.01);
                    end;



                    CFACT := ConvertStr(Format(SalesInvoiceLine.Quantity * 100, 15, Text1100009), ' ', '0');
                    CFACT := CopyStr(CFACT, 3, 11) + ',' + CopyStr(CFACT, 14, 2) + '0';
                    CENT := ConvertStr(Format(SalesInvoiceLine.Quantity * 100, 10, Text1100009), ' ', '0');
                    CENT := CopyStr(CENT, 3, 6) + ',' + CopyStr(CENT, 9, 2) + '0';
                    PRECIOB := ConvertStr(Format(SalesInvoiceLine."Unit Price" * 100, 15, Text1100009), ' ', '0');
                    PRECIOB := CopyStr(PRECIOB, 3, 11) + ',' + CopyStr(PRECIOB, 14, 2) + '0';
                    PRECION := ConvertStr(Format(SalesInvoiceLine."Unit Price" * 100, 15, Text1100009), ' ', '0');
                    PRECION := CopyStr(PRECION, 3, 11) + ',' + CopyStr(PRECION, 14, 2) + '0';
                    TIPO1 := '';
                    PORCEN1 := '';
                    IMPDTO1 := '';
                    if SalesInvoiceLine."Line Discount %" <> 0 then begin
                        TIPO1 := 'TD';
                        PORCEN1 := ConvertStr(Format(SalesInvoiceLine."Line Discount %" * 100, 8, Text1100009), ' ', '0');
                        PORCEN1 := CopyStr(PORCEN1, 3, 4) + ',' + CopyStr(PORCEN1, 7, 2) + '0';
                        IMPDTO1 := ConvertStr(Format(SalesInvoiceLine."Line Discount Amount" * 100, 15, Text1100009), ' ', '0');
                        IMPDTO1 := CopyStr(IMPDTO1, 3, 11) + ',' + CopyStr(IMPDTO1, 14, 2) + '0';
                        if SalesInvoiceLine.Quantity <> 0 then begin
                            PRECION := ConvertStr(Format((SalesInvoiceLine.Amount / SalesInvoiceLine.Quantity) * 100, 15, Text1100009), ' ', '0');
                            PRECION := CopyStr(PRECION, 3, 11) + ',' + CopyStr(PRECION, 14, 2) + '0';
                        end;
                    end;
                    NETO := ConvertStr(Format((SalesInvoiceLine.Amount) * 100, 15, Text1100009), ' ', '0');
                    NETO := CopyStr(NETO, 3, 11) + ',' + CopyStr(NETO, 14, 2) + '0';
                    IMPTASA1 := ConvertStr(Format((SalesInvoiceLine."Amount Including VAT" - SalesInvoiceLine.Amount) * 100, 15, Text1100009), ' ', '0');
                    IMPTASA1 := CopyStr(IMPTASA1, 3, 11) + ',' + CopyStr(IMPTASA1, 14, 2) + '0';

                    DESC := String2; /////SalesInvoiceLine.Description;


                    OutTxt := Format(CopyStr(NUMFAC, 1, 15)) + '|' + /////  X 15 Número de factura
                                  Format(CopyStr(NUMLIN, 1, 5)) + '|' + ///// N 5 Número de linea
                                  Format(CopyStr(REFEAN, 1, 17)) + '|' + ///// X 17 Referencia EAN del artículo
                                  Format(CopyStr(REFCLI, 1, 35)) + '|' + ///// X 35 Referencia del cliente. Código interno del artículo
                                  Format(CopyStr(REFPRO, 1, 35)) + '|' + ///// X 35 Número de referencia del artículo del proveedor.
                                  '|' +
                                  '|' +
                                  Format(CopyStr(DESC, 1, 70)) + '|' + ///// X 70 Descripción del artículo
                                  Format(CopyStr(CFACT, 1, 15)) + '|' + ///// N 15.3 Cantidad facturada
                                  Format(CopyStr(CENT, 1, 10)) + '|' + ///// N 10 Cantidad entregada
                                  Format(CopyStr(UMEDIDA, 1, 3)) + '|'; ///// X 3 Unidad de medida para peso variable
                    data.AddText(OutTxt);

                    TIPOIMP1 := 'VAT';
                    TASAIMP1 := ConvertStr(Format(SalesInvoiceLine."VAT %" * 100, 8, Text1100009), ' ', '0');
                    TASAIMP1 := CopyStr(TASAIMP1, 3, 4) + ',' + CopyStr(TASAIMP1, 7, 2) + '0';
                    IMPIMP1 := ConvertStr(Format((SalesInvoiceLine."Amount Including VAT" - SalesInvoiceLine.Amount) * 100, 15, Text1100009), ' ', '0');
                    IMPIMP1 := CopyStr(IMPIMP1, 3, 11) + ',' + CopyStr(IMPIMP1, 14, 2) + '0';

                    OutTxt := Format(CopyStr(PRECIOB, 1, 15)) + '|' + ///// N 15.3
                                  Format(CopyStr(PRECION, 1, 15)) + '|' + ///// N 15.3 Precio neto Unitario de artículo.
                                  Format(CopyStr(TIPOIMP1, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 1
                                  Format(CopyStr(TASAIMP1, 1, 8)) + '|' + ///// N 8.3 Porcentaje de impuesto 1
                                  Format(CopyStr(IMPTASA1, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 1
                                  Format(CopyStr(TIPOIMP2, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 2
                                  Format(CopyStr(TASAIMP2, 1, 8)) + '|' + ///// N 8.3 Porcentaje del impuesto 2
                                  Format(CopyStr(IMPTASA2, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 2
                                  Format(CopyStr(TIPOIMP3, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 3
                                  Format(CopyStr(TASAIMP3, 1, 8)) + '|'; ///// N 8.3 Porcentaje del impuesto 3
                    data.AddText(OutTxt);

                    OutTxt := Format(CopyStr(IMPTASA3, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 3
                                  Format(CopyStr(CALIF1, 1, 3)) + '|' + ///// X 3 Calificador del dto/cargo 1
                                  Format(CopyStr(SECUEN1, 1, 2)) + '|' + ///// N 2 Secuencia del descuento/cargo 1
                                  Format(CopyStr(TIPO1, 1, 3)) + '|' + ///// X 3 Tipo de descuento/cargo 1
                                  Format(CopyStr(PORCEN1, 1, 8)) + '|' + ///// N 8.3 Porcentaje del descuento/cargo 1 [G37PCD.5482] ([G37PCD.5245] = 2) O
                                  Format(CopyStr(IMPDTO1, 1, 15)) + '|' + ///// N 15.3 Importe del descuento/cargo 1
                                  Format(CopyStr(CALIF2, 1, 3)) + '|' + ///// X 3 Calificador del descuento/cargo 2
                                  Format(CopyStr(SECUEN2, 1, 2)) + '|' + ///// N 2 Secuencia del descuento/cargo 2
                                  Format(CopyStr(TIPO2, 1, 3)) + '|' + ///// X 3 Tipo de descuento/cargo 2
                                  Format(CopyStr(PORCEN2, 1, 8)) + '|'; ///// N 8.3 Porcentaje del descuento/cargo 2
                    data.AddText(OutTxt);

                    OutTxt := Format(CopyStr(IMPDTO2, 1, 15)) + '|' + ///// N 15.3 Importe del descuento/cargo 2
                                  Format(CopyStr(CALIF3, 1, 3)) + '|' + ///// X 3 Calificador del descuento/cargo 3
                                  Format(CopyStr(SECUEN3, 1, 2)) + '|' + ///// N 2 Secuencia del descuento/cargo 3
                                  Format(CopyStr(TIPO3, 1, 3)) + '|' + ///// X 3 Tipo de descuento/cargo 3
                                  Format(CopyStr(PORCEN3, 1, 8)) + '|' + ///// N 8.3 Porcentaje del descuento/cargo 3
                                  Format(CopyStr(IMPDTO3, 1, 15)) + '|' + ///// N 15.3 Importe del descuento/cargo 3
                                  Format(CopyStr(CALIF4, 1, 3)) + '|' + ///// X 3 Calificador del descuento/cargo 4
                                  Format(CopyStr(SECUEN4, 1, 2)) + '|' + ///// N 2 Secuencia del descuento/cargo 4
                                  Format(CopyStr(TIPO4, 1, 1)) + '|' + ///// X 3 Tipo de descuento/cargo 4
                                  Format(CopyStr(PORCEN4, 1, 8)) + '|'; ///// N 8.3 Porcentaje del descuento/cargo 4
                    data.AddText(OutTxt);

                    ///ALBARAN:=SalesInvoiceLine."Shipment No.";
                    OutTxt := Format(CopyStr(IMDTO4, 1, 15)) + '|' + ///// N 15.3 Importe del descuento/cargo 4
                                  Format(CopyStr(CBONI, 1, 15)) + '|' + ///// N 15 Cantidad bonificada o regalada
                                  Format(CopyStr(NETO, 1, 15)) + '|' + ///// N 15.3 Importe neto de la línea.
                                  Format(CopyStr(PVERDE, 1, 15)) + '|' + ///// N 15.3 Importe del punto verde por línea. [G38MOA.5004] ([G38MOA.5025] = 23)
                                  Format(CopyStr(PEDIDO, 1, 17)) + '|' + ///// X 17 Número de pedido
                                  Format(CopyStr(ALBARAN, 1, 17)) + '|' + ///// X 17 Número de albarán
                                  '|' +
                                  '|' +
                                  Format(CopyStr(FENTREGA, 1, 12)) + '|' + ///// X 12 Fecha de entrega
                                  '|' +
                                  '|' +
                                  Format(CopyStr(CANTDEV, 1, 15)) + '|' + ///// N 15.3 Cantidad de unidades de devolución
                                  '|' +
                                  '|' +
                                  '|' +
                                  Format(CopyStr(FECALB, 1, 12)) + '|' + ///// X 12 Fecha del albarán (a nivel de línea).
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  Format(CopyStr(SUBLIN, 1, 3)) + '|' + ///// X 3 Indicación de sublinea
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|';
                    data.AddText(OutTxt);

                    OutTxt := Format(CopyStr(FPEDIDO, 1, 12)) + '|' + ///// X 12 Fecha del pedido
                                  '|' +
                                  '|' +
                                  '|' +
                                  Format(CopyStr(MODELO, 1, 35)) + '|' + ///// X 35 Modelo
                                  Format(CopyStr(COLOR, 1, 35)) + '|' + ///// X 35 Color
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  Format(CopyStr(NUMLINSUBLIN, 1, 5)); ///// N 5 Número de línea de dependencia de la sublínea
                    data.AddText(OutTxt);




                    OutTxt += Format(CarriageReturn) + Format(LineFeed);
                    data.AddText(OutTxt);







                end;
            until SalesInvoiceLine.Next = 0;

        SalesReceivablesSetup.get;



        Data.Write(OutStream);
        TempBlob.CreateInStream(InStream, TextEncoding::Windows);
        FicherosHagen.CrearFichero(NOMDIR, 'LINFAC' + Format(SalesInvoiceHeader."No.") + '.TXT', InStream);



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


    procedure GrabaEDICOMabonos(codefac: Code[20])
    var
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        FileName: Text;
        InStream: InStream;
        FicherosHagen: Codeunit FicherosHagen;
        OutTxt: Text;
        CarriageReturn: Char;
        LineFeed: Char;
        Data: BigText;

    begin
        CarriageReturn := 13; // 13 es el valor ASCII para Carriage Return (CR)
        LineFeed := 10;       // 10 es el valor ASCII para Line Feed (LF)

        Clear(TempBlob);
        TempBlob.CreateOutStream(OutStream, TextEncoding::Windows);






        CompanyInformation.Get;
        HACERLINEAS := false;

        SalesReceivablesSetup.Get;







        SalesCrMemoHeader.Reset;
        SalesCrMemoHeader.SetRange("No.", codefac);
        if SalesCrMemoHeader.FindSet then
            repeat
                if SalesCrMemoHeader."Sell-to Country/Region Code" = 'ES' then begin

                    TIPO1 := '';
                    PORCEN1 := '';
                    IMPDTO1 := '';
                    NUMFAC := SalesCrMemoHeader."No.";
                    VENDEDOR := CompanyInformation.GLN;
                    EMISOR := CompanyInformation.GLN;
                    COBRADOR := CompanyInformation.GLN;
                    Customer.Get(SalesCrMemoHeader."Sell-to Customer No.");
                    COMPRADO := Customer."Quien pide";
                    DEPTO := '';
                    /////     RECEPTOR:=Customer."Central compradora";
                    /////     CLIENTE:=Customer.GLN;
                    CLIENTE := Customer."A quien se factura";
                    RECEPTOR := Customer."Sucrusal entrega";
                    PAGADOR := Customer."Quien paga";
                    PEDIDO := CopyStr(SalesCrMemoHeader."Your Reference", 1, 17);
                    OutTxt := Format(CopyStr(NUMFAC, 1, 15)) + '|' + ///// ECI 16
                             Format(CopyStr(VENDEDOR, 1, 17)) + '|' + ///Código EDI del vendedor o proveedor.
                                  Format(CopyStr(EMISOR, 1, 17)) + '|' +
                           Format(CopyStr(COBRADOR, 1, 17)) + '|' +
                           Format(CopyStr(COMPRADO, 1, 17)) + '|' +
                           Format(CopyStr(DEPTO, 1, 13)) + '|' + /////  DEPTO X 13 Departamento que hace el pedido.
                           Format(CopyStr(RECEPTOR, 1, 17)) + '|' + ///X 17 Código EDI del receptor de la mercancía.
                             Format(CopyStr(CLIENTE, 1, 17)) + '|' + ///X 17 Código EDI del destinatario de la Factura(A
                           Format(CopyStr(PAGADOR, 1, 17)) + '|' +///X 17 Código EDI de quien paga.
                             Format(CopyStr(PEDIDO, 1, 17)) + '|';
                    ///X 17 Número de pedido del destinatario de la factura.

                    FFECHA := SalesCrMemoHeader."Posting Date";
                    CALCULOFECHA;
                    FECHAEFE := FECHA;
                    NODO := '381';
                    RSOCIAL := CopyStr(SalesCrMemoHeader."Bill-to Name", 1, 70);
                    CALLE := CopyStr(SalesCrMemoHeader."Bill-to Address", 1, 35);
                    CIUDAD := CopyStr(SalesCrMemoHeader."Bill-to City", 1, 35);
                    CP := CopyStr(SalesCrMemoHeader."Bill-to Post Code", 1, 5);
                    NIF := SalesCrMemoHeader."VAT Registration No.";
                    ALBARAN := '';
                    fechapediso := SalesCrMemoHeader."Posting Date";
                    SalesCrMemoLine.Reset;
                    SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
                    if SalesCrMemoLine.FindFirst then
                        repeat
                        /////IF SalesCrMemoLine."Shipment No."<>'' THEN BEGIN
                        /////                    ALBARAN:=SalesCrMemoLine."Shipment No.";
                        /////SalesShipmentHeader.GET(ALBARAN);
                        /////fechapediso:=SalesCrMemoHeader."Order Date";
                        ///// END;
                        until SalesCrMemoLine.Next = 0;
                    ValueEntry.Reset;
                    ValueEntry.SetRange("Document No.", SalesCrMemoHeader."No.");
                    if ValueEntry.FindFirst then begin
                        ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.");
                        ALBARAN := ItemLedgerEntry."Document No.";
                        if SalesShipmentHeader.Get(ALBARAN) then begin
                            /////fechapediso:=SalesCrMemoHeader."Order Date";
                        end;
                    end;
                    //ValueEntrycopia.Reset;
                    //ValueEntrycopia.SetRange("Document No.", SalesCrMemoHeader."No.");
                    //if ValueEntrycopia.FindFirst then begin
                    //ItemLedgerEntryCOPIA.Get(ValueEntrycopia."Item Ledger Entry No.");
                    //ALBARAN := ItemLedgerEntryCOPIA."Document No.";
                    //if SalesShipmentHeader.Get(ALBARAN) then begin
                    //                            /////fechapediso:=SalesCrMemoHeader."Order Date";
                    //end;
                    //end;
                    CONTRATO := '';
                    NFACSUS := SalesCrMemoHeader."Corrected Invoice No.";
                    OutTxt := Format(CopyStr(FECHA, 1, 12)) + '|' + // X 12 Fecha de emisión de la factura.
                             Format(CopyStr(NODO, 1, 3)) + '|' + ///// 3
                             '|' +
                             Format(CopyStr(RSOCIAL, 1, 70)) + '|' + ///// 70
                             Format(CopyStr(CALLE, 1, 35)) + '|' + ///// 35
                             Format(CopyStr(CIUDAD, 1, 35)) + '|' + ///// 35
                             Format(CopyStr(CP, 1, 5)) + '|' + ///// X 5 Código postal del cliente
                             Format(CopyStr(NIF, 1, 17)) + '|' + ///// X 17 NIF del cliente
                             '|' +
                             Format(CopyStr(ALBARAN, 1, 17)) + '|' + ///// X 17 Número de albarán previo a la factura del
                             Format(CopyStr(CONTRATO, 1, 17)) + '|' + ///// X 17 Número de contrato en facturas de servicios.
                             Format(CopyStr(NFACSUS, 1, 17)) + '|'; ///// X 17 Número de factura sustitutiva
                    data.AddText(OutTxt);


                    SalesCrMemoHeader.CalcFields(Amount, "Amount Including VAT");

                    DIVISA := 'EUR';
                    SUMBRUTO := '0';
                    SUMBRUTO := ConvertStr(Format(SalesCrMemoHeader.Amount * 100, 15, Text1100009), ' ', '0');
                    SUMBRUTO := CopyStr(SUMBRUTO, 3, 11) + ',' + CopyStr(SUMBRUTO, 14, 2) + '0';
                    SUMNETOS := '0';
                    SUMNETOS := ConvertStr(Format(SalesCrMemoHeader.Amount * 100, 15, Text1100009), ' ', '0');
                    SUMNETOS := CopyStr(SUMNETOS, 3, 11) + ',' + CopyStr(SUMNETOS, 14, 2) + '0';
                    CARGOS := '0';
                    CARGOS := ConvertStr(Format(cero * 100, 15, Text1100009), ' ', '0');
                    CARGOS := CopyStr(CARGOS, 3, 11) + ',' + CopyStr(CARGOS, 14, 2) + '0';
                    DESCUEN := '0';
                    DESCUEN := ConvertStr(Format(cero * 100, 15, Text1100009), ' ', '0');
                    DESCUEN := CopyStr(DESCUEN, 3, 11) + ',' + CopyStr(DESCUEN, 14, 2) + '0';



                    VATEntryTemp.Reset;
                    /////VATEntryTemp.SETRANGE("Document No.",SalesInvoiceHeader."No.");
                    if VATEntryTemp.FindFirst then
                        repeat
                            VATEntryTemp.Delete;
                        until VATEntryTemp.Next = 0;

                    VATEntry.Reset;
                    VATEntry.SetRange("Document No.", SalesCrMemoHeader."No.");
                    if VATEntry.FindFirst then
                        repeat
                            VATEntryTemp.Reset;
                            VATEntryTemp.SetRange(VATEntryTemp."VAT %", VATEntry."VAT %");
                            VATEntryTemp.SetRange(VATEntryTemp."EC %", VATEntry."EC %");
                            if VATEntryTemp.FindFirst then begin
                                VATEntryTemp.Base := VATEntryTemp.Base + VATEntry.Base;
                                VATEntryTemp.Amount := VATEntryTemp.Amount + VATEntry.Amount;
                                VATEntryTemp.Modify;
                            end;
                            if not VATEntryTemp.FindFirst then begin
                                VATEntryTemp := VATEntry;
                                VATEntryTemp.Insert;
                            end;
                        until VATEntry.Next = 0;

                    BASEIMP1 := '';
                    TIPOIMP1 := '';
                    TASAIMP1 := '';
                    BASEIMP2 := '';
                    TIPOIMP2 := '';
                    TASAIMP2 := '';
                    BASEIMP3 := '';
                    TIPOIMP3 := '';
                    TASAIMP3 := '';
                    BASEIMP4 := '';
                    TIPOIMP4 := '';
                    TASAIMP4 := '';
                    BASEIMP5 := '';
                    TIPOIMP5 := '';
                    TASAIMP5 := '';
                    IMPIMP1 := '';
                    IMPIMP2 := '';
                    IMPIMP3 := '';
                    IMPIMP4 := '';
                    IMPIMP5 := '';


                    BASEIMP1 := '00000000000,000';
                    TIPOIMP1 := 'VAT';
                    TASAIMP1 := '0000,000';
                    IMPIMP1 := '00000000000,000';
                    BASEIMP2 := '00000000000,000';
                    TIPOIMP2 := 'VAT';
                    TASAIMP2 := '0000,000';
                    IMPIMP2 := '00000000000,000';
                    BASEIMP3 := '00000000000,000';
                    TIPOIMP3 := 'VAT';
                    TASAIMP3 := '0000,000';
                    IMPIMP3 := '00000000000,000';
                    BASEIMP4 := '00000000000,000';
                    TIPOIMP4 := 'VAT';
                    TASAIMP4 := '0000,000';
                    IMPIMP4 := '00000000000,000';
                    BASEIMP5 := '00000000000,000';
                    TIPOIMP5 := 'VAT';
                    TASAIMP5 := '0000,000';
                    IMPIMP5 := '00000000000,000';
                    BASEIMP6 := '00000000000,000';
                    TIPOIMP6 := 'VAT';
                    TASAIMP6 := '0000,000';
                    IMPIMP6 := '00000000000,000';

                    tipoimp := 0;
                    IMPTOTAL := 0;
                    VATEntryTemp.Reset;
                    VATEntryTemp.SetRange("Document No.", SalesCrMemoHeader."No.");
                    if VATEntryTemp.FindFirst then
                        repeat
                            tipoimp := tipoimp + 1;
                            if tipoimp = 1 then begin
                                BASEIMP1 := ConvertStr(Format(VATEntryTemp.Base * 100, 15, Text1100009), ' ', '0');
                                BASEIMP1 := CopyStr(BASEIMP1, 3, 11) + ',' + CopyStr(BASEIMP1, 14, 2) + '0';
                                TIPOIMP1 := 'VAT';
                                TASAIMP1 := ConvertStr(Format(VATEntryTemp."VAT %" * 100, 8, Text1100009), ' ', '0');
                                TASAIMP1 := CopyStr(TASAIMP1, 3, 4) + ',' + CopyStr(TASAIMP1, 7, 2) + '0';
                                IMPIMP1 := ConvertStr(Format(VATEntryTemp.Amount * 100, 15, Text1100009), ' ', '0');
                                IMPIMP1 := CopyStr(IMPIMP1, 3, 11) + ',' + CopyStr(IMPIMP1, 14, 2) + '0';
                            end;
                            if tipoimp = 2 then begin
                                BASEIMP2 := ConvertStr(Format(VATEntryTemp.Base * 100, 15, Text1100009), ' ', '0');
                                BASEIMP2 := CopyStr(BASEIMP2, 3, 11) + ',' + CopyStr(BASEIMP2, 14, 2) + '0';
                                TIPOIMP2 := 'VAT';
                                TASAIMP2 := ConvertStr(Format(VATEntryTemp."VAT %" * 100, 8, Text1100009), ' ', '0');
                                TASAIMP2 := CopyStr(TASAIMP2, 3, 4) + ',' + CopyStr(TASAIMP2, 7, 2) + '0';
                                IMPIMP2 := ConvertStr(Format(VATEntryTemp.Amount * 100, 15, Text1100009), ' ', '0');
                                IMPIMP2 := CopyStr(IMPIMP2, 3, 11) + ',' + CopyStr(IMPIMP2, 14, 2) + '0';
                            end;
                            if tipoimp = 3 then begin
                                BASEIMP3 := ConvertStr(Format(VATEntryTemp.Base * 100, 15, Text1100009), ' ', '0');
                                BASEIMP3 := CopyStr(BASEIMP3, 3, 11) + ',' + CopyStr(BASEIMP3, 14, 2) + '0';
                                TIPOIMP3 := 'VAT';
                                TASAIMP3 := ConvertStr(Format(VATEntryTemp."VAT %" * 100, 8, Text1100009), ' ', '0');
                                TASAIMP3 := CopyStr(TASAIMP3, 3, 4) + ',' + CopyStr(TASAIMP3, 7, 2) + '0';
                                IMPIMP3 := ConvertStr(Format(VATEntryTemp.Amount * 100, 15, Text1100009), ' ', '0');
                                IMPIMP3 := CopyStr(IMPIMP3, 3, 11) + ',' + CopyStr(IMPIMP3, 14, 2) + '0';
                            end;
                            if tipoimp = 4 then begin
                                BASEIMP4 := ConvertStr(Format(VATEntryTemp.Base * 100, 15, Text1100009), ' ', '0');
                                BASEIMP4 := CopyStr(BASEIMP4, 3, 11) + ',' + CopyStr(BASEIMP4, 14, 2) + '0';
                                TIPOIMP4 := 'VAT';
                                TASAIMP4 := ConvertStr(Format(VATEntryTemp."VAT %" * 100, 8, Text1100009), ' ', '0');
                                TASAIMP4 := CopyStr(TASAIMP4, 3, 4) + ',' + CopyStr(TASAIMP4, 7, 2) + '0';
                                IMPIMP4 := ConvertStr(Format(VATEntryTemp.Amount * 100, 15, Text1100009), ' ', '0');
                                IMPIMP4 := CopyStr(IMPIMP4, 3, 11) + ',' + CopyStr(IMPIMP4, 14, 2) + '0';
                            end;
                            if tipoimp = 5 then begin
                                BASEIMP5 := ConvertStr(Format(VATEntryTemp.Base * 100, 15, Text1100009), ' ', '0');
                                BASEIMP5 := CopyStr(BASEIMP5, 3, 11) + ',' + CopyStr(BASEIMP5, 14, 2) + '0';
                                TIPOIMP5 := 'VAT';
                                TASAIMP5 := ConvertStr(Format(VATEntryTemp."VAT %" * 100, 8, Text1100009), ' ', '0');
                                TASAIMP5 := CopyStr(TASAIMP5, 3, 4) + ',' + CopyStr(TASAIMP5, 7, 2) + '0';
                                IMPIMP5 := ConvertStr(Format(VATEntryTemp.Amount * 100, 15, Text1100009), ' ', '0');
                                IMPIMP5 := CopyStr(IMPIMP5, 3, 11) + ',' + CopyStr(IMPIMP5, 14, 2) + '0';
                            end;
                            if tipoimp = 6 then begin
                                BASEIMP6 := ConvertStr(Format(VATEntryTemp.Base * 100, 15, Text1100009), ' ', '0');
                                BASEIMP6 := CopyStr(BASEIMP6, 3, 11) + ',' + CopyStr(BASEIMP6, 14, 2) + '0';
                                TIPOIMP6 := 'VAT';
                                TASAIMP6 := ConvertStr(Format(VATEntryTemp."VAT %" * 100, 8, Text1100009), ' ', '0');
                                TASAIMP6 := CopyStr(TASAIMP6, 3, 4) + ',' + CopyStr(TASAIMP6, 7, 2) + '0';
                                IMPIMP6 := ConvertStr(Format(VATEntryTemp.Amount * 100, 15, Text1100009), ' ', '0');
                                IMPIMP6 := CopyStr(IMPIMP6, 3, 11) + ',' + CopyStr(IMPIMP6, 14, 2) + '0';
                            end;
                            IMPTOTAL := IMPTOTAL + VATEntry.Amount;
                        until VATEntryTemp.Next = 0;


                    FFECHA := SalesCrMemoHeader."Due Date";
                    CALCULOFECHA;
                    VTO1 := FECHA;
                    contavto := 0;
                    CustLedgerEntry.Reset;
                    CustLedgerEntry.SetRange("Document No.", SalesCrMemoHeader."No.");
                    CustLedgerEntry.SetRange(Open, true);
                    if CustLedgerEntry.FindFirst then
                        repeat
                            contavto := contavto + 1;
                            CustLedgerEntry.CalcFields(CustLedgerEntry."Remaining Amt. (LCY)");
                            if contavto = 1 then begin
                                ///FFECHA:=CustLedgerEntry."Due Date";CALCULOFECHA;
                                ///VTO1:=FECHA;
                                ///IMPIMP1:=CONVERTSTR(FORMAT(CustLedgerEntry."Remaining Amt. (LCY)"*100,15,Text1100009),' ','0');
                                ///IMPIMP1:=COPYSTR(IMPIMP1,3,11)+','+COPYSTR(IMPIMP1,14,2)+'0';
                            end;
                            if contavto = 2 then begin
                                IMPIMP2 := ConvertStr(Format(CustLedgerEntry."Remaining Amt. (LCY)" * 100, 15, Text1100009), ' ', '0');
                                IMPIMP2 := CopyStr(IMPIMP2, 3, 11) + ',' + CopyStr(IMPIMP2, 14, 2) + '0';
                            end;
                            if contavto = 3 then begin
                                IMPIMP3 := ConvertStr(Format(CustLedgerEntry."Remaining Amt. (LCY)" * 100, 15, Text1100009), ' ', '0');
                                IMPIMP3 := CopyStr(IMPIMP3, 3, 11) + ',' + CopyStr(IMPIMP3, 14, 2) + '0';
                            end;
                            if contavto = 4 then begin
                                IMPIMP4 := ConvertStr(Format(CustLedgerEntry."Remaining Amt. (LCY)" * 100, 15, Text1100009), ' ', '0');
                                IMPIMP4 := CopyStr(IMPIMP4, 3, 11) + ',' + CopyStr(IMPIMP4, 14, 2) + '0';
                            end;

                        until CustLedgerEntry.Next = 0;


                    OutTxt := '|' +
                                  Format(CopyStr(DIVISA, 1, 3)) + '|' + ///// X 3 Tipo de divisa utilizada en la factura: EUR = Euros.
                                  Format(CopyStr(SUMBRUTO, 1, 15)) + '|' + ///// N 15.3 Sumatorio brutos
                                  Format(CopyStr(SUMNETOS, 1, 15)) + '|' + ///// N 15.3 Sumatorio de netos
                                  Format(CopyStr(CARGOS, 1, 15)) + '|' + ///// N 15.3 Sumatorio de cargos
                                  Format(CopyStr(DESCUEN, 1, 15)) + '|' + ///// N 15.3 Sumatorio de descuentos
                                  Format(CopyStr(BASEIMP1, 1, 15)) + '|' + ///// N 15.3 Base imponible del impuesto 1 [G47MOA.5004] ([G47MOA.5025] = 125)
                                  Format(CopyStr(TIPOIMP1, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 1
                                  Format(CopyStr(TASAIMP1, 1, 8)) + '|' + ///// N 8.3 Porcentaje del impuesto 1
                                  Format(CopyStr(IMPIMP1, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 1
                                  Format(CopyStr(BASEIMP2, 1, 15)) + '|' + ///// N 15.3 Base imponible del impuesto 2
                                  Format(CopyStr(TIPOIMP2, 1, 3)) + '|'; ///// X 3 Tipo de impuesto 2
                    data.AddText(OutTxt);
                    OutTxt := Format(CopyStr(TASAIMP2, 1, 8)) + '|' + ///// N 8.3
                                  Format(CopyStr(IMPIMP2, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 2
                                  Format(CopyStr(BASEIMP3, 1, 15)) + '|' + ///// N 15.3 Base imponible del impuesto 3
                                  Format(CopyStr(TIPOIMP3, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 3
                                  Format(CopyStr(TASAIMP3, 1, 8)) + '|' + ///// N 8.3 Porcentaje del impuesto 3
                                  Format(CopyStr(IMPIMP3, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 3
                                  Format(CopyStr(BASEIMP4, 1, 15)) + '|' + ///// N 15.3 Base imponible del impuesto 4
                                  Format(CopyStr(TIPOIMP4, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 4
                                  Format(CopyStr(TASAIMP4, 1, 8)) + '|' + ///// N 8.3 Porcentaje del impuesto 4
                                  Format(CopyStr(IMPIMP4, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 4
                                  Format(CopyStr(BASEIMP5, 1, 15)) + '|'; ///// N 15.3 Base imponible del impuesto 5
                    data.AddText(OutTxt);

                    BASIMPFA := ConvertStr(Format(SalesCrMemoHeader.Amount * 100, 15, Text1100009), ' ', '0');
                    BASIMPFA := CopyStr(BASIMPFA, 3, 11) + ',' + CopyStr(BASIMPFA, 14, 2) + '0';


                    TOTIMP := ConvertStr(Format((SalesCrMemoHeader."Amount Including VAT" - SalesCrMemoHeader.Amount) * 100, 15, Text1100009), ' ', '0');
                    TOTIMP := CopyStr(TOTIMP, 3, 11) + ',' + CopyStr(TOTIMP, 14, 2) + '0';

                    TOTAL := ConvertStr(Format(SalesCrMemoHeader."Amount Including VAT" * 100, 15, Text1100009), ' ', '0');
                    TOTAL := CopyStr(TOTAL, 3, 11) + ',' + CopyStr(TOTAL, 14, 2) + '0';


                    OutTxt := Format(CopyStr(TIPOIMP5, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 5 [G47TAX.5153] ([G47TAX.5283] = 7)
                                  Format(CopyStr(TASAIMP5, 1, 8)) + '|' + ///// N 8.3 Porcentaje del impuesto 5
                                  Format(CopyStr(IMPIMP5, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 5
                                  Format(CopyStr(BASEIMP6, 1, 15)) + '|' + ///// N 15.3 Base imponible del impuesto 6
                                  Format(CopyStr(TIPOIMP6, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 6
                                  Format(CopyStr(TASAIMP6, 1, 8)) + '|' + ///// N 8.3 Porcentaje del impuesto 6
                                  Format(CopyStr(IMPIMP6, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 6 [G47MOA.5004] ([G47MOA.5025] = 176)
                                  Format(CopyStr(BASIMPFA, 1, 15)) + '|' + ///// N 15.3 Base imponible de la factura
                                  Format(CopyStr(TOTIMP, 1, 15)) + '|' + ///// N 15.3 Importe total de impuestos
                                  Format(CopyStr(TOTAL, 1, 15)) + '|' + ///// N 15.3
                                  Format(CopyStr(VTO1, 1, 8)) + '|'; ///// X 8 Fecha primer vencimiento
                    data.AddText(OutTxt);
                    OutTxt := Format(CopyStr(IMPVTO1, 1, 15)) + '|' + ///// N 15.3 Importe primer vencimiento
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  Format(CopyStr(TPVERDE, 1, 15)) + '|' + ///// N 15.3 Total punto verde en factura
                                  Format(CopyStr(CALIF1, 1, 3)) + '|' + ///// X 3 Calificador descuento/cargo 1 [G14ALC.5463]
                                  Format(CopyStr(SECUEN1, 1, 2)) + '|' + ///// N 2 Secuencia calculo descuento/cargo 1
                                  Format(CopyStr(TIPO1, 1, 3)) + '|' + ///// X 3 Tipo descuento/cargo 1
                                  Format(CopyStr(PORCEN1, 1, 8)) + '|' + ///// N 8.3 Porcentaje del descuento o cargo 1.
                                  Format(CopyStr(IMPDES1, 1, 15)) + '|' + ///// N 15.3 Importe del descuento o cargo 1.
                                  Format(CopyStr(CALIF2, 1, 3)) + '|' + ///// X 3 Calificador de cargo o descuento 2.
                                  Format(CopyStr(SECUEN2, 1, 2)) + '|' + ///// N 2 Secuencia calculo descuento/cargo 2
                                  Format(CopyStr(TIPO2, 1, 3)) + '|' + ///// X 3 Tipo de descuento/cargo 2
                                  Format(CopyStr(PORCEN2, 1, 8)) + '|' + ///// N 8.3 Porcentaje del descuento o cargo 2.
                                  Format(CopyStr(IMPDES2, 1, 15)) + '|' + ///// N 15.3 Importe del descuento o cargo 2.
                                  Format(CopyStr(CALIF3, 1, 3)) + '|' + ///// X 3 Calificador de cargo o descuento 3.
                                  Format(CopyStr(SECUEN3, 1, 2)) + '|' + ///// N 2 Secuencia calculo descuento/cargo 3
                                  Format(CopyStr(TIPO3, 1, 3)) + '|' + ///// X 3 Tipo de descuento/cargo 3
                                  Format(CopyStr(PORCEN3, 1, 8)) + '|'; ///// N 8.3 Porcentaje del descuento o cargo 3.
                    data.AddText(OutTxt);
                    OutTxt := Format(CopyStr(IMPDES3, 1, 15)) + '|' + ///// N 15.3 Importe del descuento o cargo 3.
                                  Format(CopyStr(CALIF4, 1, 3)) + '|' + ///// X 3 Calificador de cargo o descuento 4.
                                  Format(CopyStr(SECUEN4, 1, 2)) + '|' + ///// N 2 Secuencia calculo descuento/cargo 4
                                  Format(CopyStr(TIPO4, 1, 3)) + '|' + ///// X 3 Tipo de descuento/cargo 4
                                  Format(CopyStr(PORCEN4, 1, 8)) + '|' + ///// N 8.3 Porcentaje del descuento o cargo 4.
                                  Format(CopyStr(IMPDES4, 1, 15)) + '|' + ///// N 15.3 Importe del descuento o cargo 4.
                                  Format(CopyStr(CALIF5, 1, 3)) + '|' + ///// X 3 Calificador de cargo o descuento 5.
                                  Format(CopyStr(SECUEN5, 1, 2)) + '|' + ///// N 2 Secuencia calculo descuento/cargo 5
                                  Format(CopyStr(TIPO5, 1, 3)) + '|' + ///// X 3 Tipo de descuento/cargo 5
                                  Format(CopyStr(PORCEN5, 1, 8)) + '|' + ///// N 8.3
                                  Format(CopyStr(IMPDES5, 1, 15)) + '|'; ///// N 15.3 Importe del descuento o cargo 5.
                    data.AddText(OutTxt);
                    ERSOCIAL := CompanyInformation.Name;
                    ECALLE := CompanyInformation.Address;
                    EPOBLAC := CompanyInformation.County;
                    ECP := CompanyInformation."Post Code";
                    ENIF := CompanyInformation."VAT Registration No.";

                    OutTxt := Format(CopyStr(ERSOCIAL, 1, 70)) + '|' + ///// X 70 Razón social del emisor de la factura.
                                  Format(CopyStr(ECALLE, 1, 35)) + '|' + ///// X 35 Domicilio del emisor de la factura.
                                  Format(CopyStr(EPOBLAC, 1, 35)) + '|' + ///// X 35 Población del emisor de la factura
                                  Format(CopyStr(ECP, 1, 5)) + '|' + ///// X 5 Código postal del emisor de la factura.
                                  Format(CopyStr(ENIF, 1, 17)) + '|'; ///// X 17 NIF del emisor de la factura
                    data.AddText(OutTxt);
                    FFECHA := SalesCrMemoHeader."Posting Date";
                    CALCULOFECHA;
                    FECHADOC := LAFECHA;
                    ERMERCA := 'Tomo:7.753, Folio:!, Nº hoja registral: v95742.';
                    OutTxt := Format(CopyStr(ERMERCA, 1, 70)) + '|' + ///// X 70 Registro mercantil del emisor de la factura.
                                  Format(CopyStr(NOTAC, 1, 17)) + '|' + ///// X 17 Nota de cargo que se abona.
                                  '|' +
                                  '|' +
                                  '|' +
                                  Format(CopyStr(FECHAEFE, 1, 12)) + '|' + ///// X 12 Fecha efectiva del servicio
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  Format(CopyStr(FECALB, 1, 12)) + '|' + ///// X 12 Fecha de albarán
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  Format(CopyStr(FECHADOC, 1, 8)) + '|' + ///// X 8 Fecha del documento
                                  Format(CopyStr(REFPAGO, 1, 35)) + '|' + ///// X 35 Texto de referencia de pago
                                  '|';
                    data.AddText(OutTxt);
                    NIFII := CompanyInformation."VAT Registration No.";
                    NIFPE := SalesCrMemoHeader."VAT Registration No.";
                    NIFIV := SalesCrMemoHeader."VAT Registration No.";
                    NIFPR := SalesCrMemoHeader."VAT Registration No.";
                    NIFSU := CompanyInformation."VAT Registration No.";

                    FFECHA := fechapediso;
                    CALCULOFECHA;
                    FPEDIDO := FECHA;

                    OutTxt := Format(CopyStr(NIFII, 1, 17)) + '|' + ///// X 17 NIF de la empresa emisora de la factura
                                   Format(CopyStr(NIFPE, 1, 17)) + '|' + ///// X 17 NIF de la empresa a quien se paga
                                   Format(CopyStr(NIFIV, 1, 17)) + '|' + ///// X 17 NIF de la empresa destinataria de la factura
                                   Format(CopyStr(NIFPR, 1, 17)) + '|' + ///// X 17 NIF de la empresa que paga la factura
                                   Format(CopyStr(NIFSU, 1, 17)) + '|' + ///// X 17 NIF de la empresa a quien se pidió la mercancía
                                   '|' +
                                   Format(CopyStr(NUMINCOR, 1, 17)) + '|' + ///// X 17 Número de documento incorporado
                                   '|' +
                                   '|' +
                                   '|' +
                                   '|' +
                                   '|' +
                                   Format(CopyStr(FPEDIDO, 1, 12)) + '|' + ///// X 12 Fecha del pedido
                                   '|' +
                                   '|' +
                                   '|' +
                                   Format(CopyStr(NOTIFDEVOL, 1, 17)) + '|' + ///// X 17 Número de notificación de devolución
                                   Format(CopyStr(FNOTIFDEVOL, 1, 12)) + '|' + ///// X 12 Fecha número de notificación de devolución
                                   Format(CopyStr(SEDESOC, 1, 17)) + '|' + ///// X 17 Código EDI de la razón/sede social del comprador
                                   '|' +
                                   '|' +
                                   '|' +
                                   '|' +
                                   '|' +
                                   '|' +
                                   '|' +
                                   '|' +
                                   '|' +
                                   '|' +
                                   '|' +
                                   '|' +
                                   '|' +
                                   '|' +
                                   '|' +
                                   '|';
                    data.AddText(OutTxt);
                    OutTxt := Format(CopyStr(ECPEXT, 1, 17)) + '|' + ///// X 17 Código postal del emisor de la factura extendido
                                   Format(CopyStr(FECFACSUS, 1, 12)) + '|' + ///// X 12 Fecha de la factura a la que se sustituye o la que
                                   Format(CopyStr(EPAIS, 1, 3)) + '|' + ///// X 3 País del emisor de la factura.
                                   Format(CopyStr(RELVTO, 1, 3)) + '|' + ///// X 3 Relación de tiempo codificado [G08PAT.2009] ([G08PAT.4279] = 1) Y
                                   Format(CopyStr(DIASVTO, 1, 3)) + '|' + ///// N 3 Número de periodos de pago. Número de días en
                                   Format(CopyStr(PORCVTO, 1, 8)) + '|' + ///// N 8.3 Porcentaje de descuento aplicado para dicho
                                   Format(CopyStr(TIPOIMPDES1, 1, 3)) + '|' + ///// X 3 Tipo de impuesto del descuento 1
                                   Format(CopyStr(TASAIMPDES1, 1, 8)) + '|' + ///// N 8.3 Porcentaje del impuesto del descuento 1
                                   '|' + '|' + '|' +
                                   '|' + '|' + '|' +
                                   '|' + '|' + '|' +
                                   '|' + '|' + '|' +
                                   '|' + '|' + '|' +
                                   '|' + '|' + '|' +
                                   '|' + '|' + '|' +
                                   '|' + '|' + '|' +
                                   '|' + '|' + '|' +
                                   Format(CopyStr(AUTORIZDEV, 1, 35)) + '|' + ///// X 35 Número autorización devolución (10 posiciones)
                                   '|' +
                                   Format(CopyStr(FECTAX, 1, 12)); ///// X 12 Fecha del cálculo de los impuestos de la factura.
                    data.AddText(OutTxt);

                    OutTxt += Format(CarriageReturn) + Format(LineFeed);
                    data.AddText(OutTxt);



                    HACERLINEAS := true;

                end;

            until SalesCrMemoHeader.Next = 0;


        SalesReceivablesSetup.get;

        Data.Write(OutStream);
        TempBlob.CreateInStream(InStream, TextEncoding::Windows);
        FicherosHagen.CrearFichero(NOMDIR, 'CABFAC' + Format(codefac) + '.TXT', InStream);



        if HACERLINEAS then begin
            Lineasabonos;
        end;
    end;

    local procedure Lineasabonos()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        FileName: Text;
        InStream: InStream;
        FicherosHagen: Codeunit FicherosHagen;
        OutTxt: Text;
        CarriageReturn: Char;
        LineFeed: Char;
        Data: BigText;

    begin
        CarriageReturn := 13; // 13 es el valor ASCII para Carriage Return (CR)
        LineFeed := 10;       // 10 es el valor ASCII para Line Feed (LF)

        Clear(TempBlob);
        TempBlob.CreateOutStream(OutStream, TextEncoding::Windows);



        NUMLINint := 0;






        ///// ,'ISO-8859-1'

        BASEIMP1 := '';
        TIPOIMP1 := '';
        TASAIMP1 := '';
        BASEIMP2 := '';
        TIPOIMP2 := '';
        TASAIMP2 := '';
        BASEIMP3 := '';
        TIPOIMP3 := '';
        TASAIMP3 := '';
        BASEIMP4 := '';
        TIPOIMP4 := '';
        TASAIMP4 := '';
        BASEIMP5 := '';
        TIPOIMP5 := '';
        TASAIMP5 := '';


        SalesCrMemoLine.Reset;
        SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
        if SalesCrMemoLine.FindFirst then
            repeat
                if (SalesCrMemoLine."No." <> '') and (SalesCrMemoLine.Quantity <> 0) then begin

                    dtext1 := SalesCrMemoLine.Description;
                    dtext1 := ConvertStr(Format(dtext1), '"', ' ');
                    dtext1 := CASCII.Ascii2Ansi(dtext1);
                    C13 := 13;
                    C10 := 10;
                    String := dtext1;
                    String2 := '';
                    for I := 1 to StrLen(String) do begin
                        if (String[I] <> C10) and (String[I] <> C13) then begin
                            String2[I] := String[I];
                        end;
                    end;



                    SalesCrMemoHeader.CalcFields("Grupo clientes");
                    RelacionproductogrupoMetros.Reset;
                    RelacionproductogrupoMetros.SetRange(RelacionproductogrupoMetros.Producto, SalesCrMemoLine."No.");
                    RelacionproductogrupoMetros.SetRange(RelacionproductogrupoMetros."Grupo Cliente", SalesCrMemoHeader."Grupo clientes");
                    if RelacionproductogrupoMetros.FindSet then begin
                        SalesCrMemoLine.Quantity := SalesCrMemoLine.Quantity * RelacionproductogrupoMetros.Metros;
                        SalesCrMemoLine."Unit Price" := ROUND(SalesCrMemoLine."Unit Price" / RelacionproductogrupoMetros.Metros, 0.01);
                    end;



                    NUMLINint := NUMLINint + 1;
                    NUMLIN := ConvertStr(Format(NUMLINint, 5, Text1100009), ' ', '0');
                    REFEAN := SalesCrMemoLine."No.";
                    REFCLI := SalesCrMemoLine."No.";
                    REFPRO := SalesCrMemoLine."No.";
                    CFACT := ConvertStr(Format(SalesCrMemoLine.Quantity * 100, 15, Text1100009), ' ', '0');
                    CFACT := CopyStr(CFACT, 3, 11) + ',' + CopyStr(CFACT, 14, 2) + '0';
                    CENT := ConvertStr(Format(SalesCrMemoLine.Quantity * 100, 10, Text1100009), ' ', '0');
                    CENT := CopyStr(CENT, 3, 6) + ',' + CopyStr(CENT, 9, 2) + '0';
                    PRECIOB := ConvertStr(Format(SalesCrMemoLine."Unit Price" * 100, 15, Text1100009), ' ', '0');
                    PRECIOB := CopyStr(PRECIOB, 3, 11) + ',' + CopyStr(PRECIOB, 14, 2) + '0';
                    PRECION := ConvertStr(Format(SalesCrMemoLine."Unit Price" * 100, 15, Text1100009), ' ', '0');
                    PRECION := CopyStr(PRECION, 3, 11) + ',' + CopyStr(PRECION, 14, 2) + '0';
                    TIPO1 := '';
                    PORCEN1 := '';
                    IMPDTO1 := '';
                    if SalesCrMemoLine."Line Discount %" <> 0 then begin
                        TIPO1 := 'TD';
                        PORCEN1 := ConvertStr(Format(SalesCrMemoLine."Line Discount %" * 100, 8, Text1100009), ' ', '0');
                        PORCEN1 := CopyStr(PORCEN1, 3, 4) + ',' + CopyStr(PORCEN1, 7, 2) + '0';
                        IMPDTO1 := ConvertStr(Format(SalesCrMemoLine."Line Discount Amount" * 100, 15, Text1100009), ' ', '0');
                        IMPDTO1 := CopyStr(IMPDTO1, 3, 11) + ',' + CopyStr(IMPDTO1, 14, 2) + '0';
                        if SalesCrMemoLine.Quantity <> 0 then begin
                            PRECION := ConvertStr(Format((SalesCrMemoLine.Amount / SalesCrMemoLine.Quantity) * 100, 15, Text1100009), ' ', '0');
                            PRECION := CopyStr(PRECION, 3, 11) + ',' + CopyStr(PRECION, 14, 2) + '0';
                        end;
                    end;
                    NETO := ConvertStr(Format((SalesCrMemoLine.Amount) * 100, 15, Text1100009), ' ', '0');
                    NETO := CopyStr(NETO, 3, 11) + ',' + CopyStr(NETO, 14, 2) + '0';
                    IMPTASA1 := ConvertStr(Format((SalesCrMemoLine."Amount Including VAT" - SalesCrMemoLine.Amount) * 100, 15, Text1100009), ' ', '0');
                    IMPTASA1 := CopyStr(IMPTASA1, 3, 11) + ',' + CopyStr(IMPTASA1, 14, 2) + '0';

                    DESC := String2; /////SalesInvoiceLine.Description;


                    OutTxt := Format(CopyStr(NUMFAC, 1, 15)) + '|' + /////  X 15 Número de factura
                                  Format(CopyStr(NUMLIN, 1, 5)) + '|' + ///// N 5 Número de linea
                                  Format(CopyStr(REFEAN, 1, 17)) + '|' + ///// X 17 Referencia EAN del artículo
                                  Format(CopyStr(REFCLI, 1, 35)) + '|' + ///// X 35 Referencia del cliente. Código interno del artículo
                                  Format(CopyStr(REFPRO, 1, 35)) + '|' + ///// X 35 Número de referencia del artículo del proveedor.
                                  '|' +
                                  '|' +
                                  Format(CopyStr(DESC, 1, 70)) + '|' + ///// X 70 Descripción del artículo
                                  Format(CopyStr(CFACT, 1, 15)) + '|' + ///// N 15.3 Cantidad facturada
                                  Format(CopyStr(CENT, 1, 10)) + '|' + ///// N 10 Cantidad entregada
                                  Format(CopyStr(UMEDIDA, 1, 3)) + '|'; ///// X 3 Unidad de medida para peso variable
                    data.AddText(OutTxt);

                    TIPOIMP1 := 'VAT';
                    TASAIMP1 := ConvertStr(Format(SalesCrMemoLine."VAT %" * 100, 8, Text1100009), ' ', '0');
                    TASAIMP1 := CopyStr(TASAIMP1, 3, 4) + ',' + CopyStr(TASAIMP1, 7, 2) + '0';
                    IMPIMP1 := ConvertStr(Format((SalesCrMemoLine."Amount Including VAT" - SalesCrMemoLine.Amount) * 100, 15, Text1100009), ' ', '0');
                    IMPIMP1 := CopyStr(IMPIMP1, 3, 11) + ',' + CopyStr(IMPIMP1, 14, 2) + '0';

                    OutTxt := Format(CopyStr(PRECIOB, 1, 15)) + '|' + ///// N 15.3
                                  Format(CopyStr(PRECION, 1, 15)) + '|' + ///// N 15.3 Precio neto Unitario de artículo.
                                  Format(CopyStr(TIPOIMP1, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 1
                                  Format(CopyStr(TASAIMP1, 1, 8)) + '|' + ///// N 8.3 Porcentaje de impuesto 1
                                  Format(CopyStr(IMPTASA1, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 1
                                  Format(CopyStr(TIPOIMP2, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 2
                                  Format(CopyStr(TASAIMP2, 1, 8)) + '|' + ///// N 8.3 Porcentaje del impuesto 2
                                  Format(CopyStr(IMPTASA2, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 2
                                  Format(CopyStr(TIPOIMP3, 1, 3)) + '|' + ///// X 3 Tipo de impuesto 3
                                  Format(CopyStr(TASAIMP3, 1, 8)) + '|'; ///// N 8.3 Porcentaje del impuesto 3
                    data.AddText(OutTxt);

                    OutTxt := Format(CopyStr(IMPTASA3, 1, 15)) + '|' + ///// N 15.3 Importe del impuesto 3
                                  Format(CopyStr(CALIF1, 1, 3)) + '|' + ///// X 3 Calificador del dto/cargo 1
                                  Format(CopyStr(SECUEN1, 1, 2)) + '|' + ///// N 2 Secuencia del descuento/cargo 1
                                  Format(CopyStr(TIPO1, 1, 3)) + '|' + ///// X 3 Tipo de descuento/cargo 1
                                  Format(CopyStr(PORCEN1, 1, 8)) + '|' + ///// N 8.3 Porcentaje del descuento/cargo 1 [G37PCD.5482] ([G37PCD.5245] = 2) O
                                  Format(CopyStr(IMPDTO1, 1, 15)) + '|' + ///// N 15.3 Importe del descuento/cargo 1
                                  Format(CopyStr(CALIF2, 1, 3)) + '|' + ///// X 3 Calificador del descuento/cargo 2
                                  Format(CopyStr(SECUEN2, 1, 2)) + '|' + ///// N 2 Secuencia del descuento/cargo 2
                                  Format(CopyStr(TIPO2, 1, 3)) + '|' + ///// X 3 Tipo de descuento/cargo 2
                                  Format(CopyStr(PORCEN2, 1, 8)) + '|'; ///// N 8.3 Porcentaje del descuento/cargo 2
                    data.AddText(OutTxt);

                    OutTxt := Format(CopyStr(IMPDTO2, 1, 15)) + '|' + ///// N 15.3 Importe del descuento/cargo 2
                                  Format(CopyStr(CALIF3, 1, 3)) + '|' + ///// X 3 Calificador del descuento/cargo 3
                                  Format(CopyStr(SECUEN3, 1, 2)) + '|' + ///// N 2 Secuencia del descuento/cargo 3
                                  Format(CopyStr(TIPO3, 1, 3)) + '|' + ///// X 3 Tipo de descuento/cargo 3
                                  Format(CopyStr(PORCEN3, 1, 8)) + '|' + ///// N 8.3 Porcentaje del descuento/cargo 3
                                  Format(CopyStr(IMPDTO3, 1, 15)) + '|' + ///// N 15.3 Importe del descuento/cargo 3
                                  Format(CopyStr(CALIF4, 1, 3)) + '|' + ///// X 3 Calificador del descuento/cargo 4
                                  Format(CopyStr(SECUEN4, 1, 2)) + '|' + ///// N 2 Secuencia del descuento/cargo 4
                                  Format(CopyStr(TIPO4, 1, 1)) + '|' + ///// X 3 Tipo de descuento/cargo 4
                                  Format(CopyStr(PORCEN4, 1, 8)) + '|'; ///// N 8.3 Porcentaje del descuento/cargo 4
                    data.AddText(OutTxt);

                    ///ALBARAN:=SalesInvoiceLine."Shipment No.";
                    OutTxt := Format(CopyStr(IMDTO4, 1, 15)) + '|' + ///// N 15.3 Importe del descuento/cargo 4
                                  Format(CopyStr(CBONI, 1, 15)) + '|' + ///// N 15 Cantidad bonificada o regalada
                                  Format(CopyStr(NETO, 1, 15)) + '|' + ///// N 15.3 Importe neto de la línea.
                                  Format(CopyStr(PVERDE, 1, 15)) + '|' + ///// N 15.3 Importe del punto verde por línea. [G38MOA.5004] ([G38MOA.5025] = 23)
                                  Format(CopyStr(PEDIDO, 1, 17)) + '|' + ///// X 17 Número de pedido
                                  Format(CopyStr(ALBARAN, 1, 17)) + '|' + ///// X 17 Número de albarán
                                  '|' +
                                  '|' +
                                  Format(CopyStr(FENTREGA, 1, 12)) + '|' + ///// X 12 Fecha de entrega
                                  '|' +
                                  '|' +
                                  Format(CopyStr(CANTDEV, 1, 15)) + '|' + ///// N 15.3 Cantidad de unidades de devolución
                                  '|' +
                                  '|' +
                                  '|' +
                                  Format(CopyStr(FECALB, 1, 12)) + '|' + ///// X 12 Fecha del albarán (a nivel de línea).
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  Format(CopyStr(SUBLIN, 1, 3)) + '|' + ///// X 3 Indicación de sublinea
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|';
                    data.AddText(OutTxt);

                    OutTxt := Format(CopyStr(FPEDIDO, 1, 12)) + '|' + ///// X 12 Fecha del pedido
                                  '|' +
                                  '|' +
                                  '|' +
                                  Format(CopyStr(MODELO, 1, 35)) + '|' + ///// X 35 Modelo
                                  Format(CopyStr(COLOR, 1, 35)) + '|' + ///// X 35 Color
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  '|' +
                                  Format(CopyStr(NUMLINSUBLIN, 1, 5)); ///// N 5 Número de línea de dependencia de la sublínea
                    data.AddText(OutTxt);


                    OutTxt += Format(CarriageReturn) + Format(LineFeed);
                    data.AddText(OutTxt);


                end;
            until SalesCrMemoLine.Next = 0;


        SalesReceivablesSetup.get;



        Data.Write(OutStream);
        TempBlob.CreateInStream(InStream, TextEncoding::Windows);
        FicherosHagen.CrearFichero(NOMDIR, 'LINFAC' + Format(SalesCrMemoHeader."No.") + '.TXT', InStream);


    end;
}

