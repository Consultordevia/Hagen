#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50103 "ADAIATREXP"
{
    Caption = 'ADAIATREXP';
    Direction = Import;
    FieldSeparator = '|';
    Format = VariableText;
    TextEncoding = UTF16;
    UseRequestPage = false;
    Permissions = tabledata 110 = rmid, tabledata 113 = rmid, tabledata 17 = rmid;

    ///   1   2  3         4       5               6           7     8       9       10      11  12       
    /// CECA|MO|CAT25986|01       |CT02300976   |         |PED      |  |         |20241203 |0824|   |||
    /// CELI|MO|CAT25282|000000001|10           |000000001|000000005|UD|000000000|000000000|    |   |
    /// CELI|MO|CAT25282|000000002|11           |000000001|000000001|UD|000000000|000000000|    |   |
    /// CELI|MO|CAT25282|000020000|44839        |000000002|000000002|UD|000190000|000000000|    |   |
    /// CELI|MO|CAT25282|000000003|15           |000000001|000000001|UD|000000000|000000000|    |   |
    /// CELI|MO|CAT25282|000030000|44146        |000000006|000000006|UD|034584000|000000000|    |   |
    /// CELI|MO|CAT25282|000040000|44081        |000000001|000000001|UD|002575000|000000000|    |   |
    /// CELI|MO|CAT25282|000050000|42140        |000000012|000000012|UD|001200000|000000000|    |   |
    /// CELI|MO|CAT25282|000010000|44144        |000000007|000000007|UD|042700000|000000000|    |   |
    /// CECN|MO|CAT25282|01       |2700006311398|         |10       |  |000000005|UD       |00000001|000000000|000000000|2024/07/10||20241204||||000000001||01CA50011||||
    /// CECN|MO|CAT25282|01       |2700006311398|         |44081    |  |000000001|UD       |00000001|000002575|000000000|2024/09/23||20241204||||000040000||01CA50011||||
    /// CECN|MO|CAT25282|01       |2700006311398|         |15       |  |000000001|UD       |00000001|000000000|000000000|2024/08/27||20241204||||000000003||01CA50011||||
    /// CECN|MO|CAT25282|01       |2700006311398|         |44146    |  |000000006|UD       |00000001|000034584|000000000|2024/11/20||20241204||||000030000||01CA50011||||
    /// CECN|MO|CAT25282|01       |2700006311398|         |44144    |  |000000007|UD       |00000001|000042700|000000000|2024/11/20||20241204||||000010000||01CA50011||||
    /// CECN|MO|CAT25282|01       |2700006311398|         |42140    |  |000000012|UD       |00000001|000001200|000000000|2026/11/24|20261124|20241204||3328T3977||000050000||01CA50011||||
    /// CECN|MO|CAT25282|01       |2700006311398|         |11       |  |000000001|UD       |00000001|000000000|000000000|2024/11/08||20241204||||000000002||01CA50011||||
    /// CECN|MO|CAT25282|01       |2700006311398|         |44839    |  |000000002|UD       |00000001|000000190|000000000|2024/09/23||20241204||||000020000||01CA50011||||


    schema
    {
        textelement(root)
        {
            MinOccurs = Zero;
            tableelement("Payment Terms"; "Payment Terms")
            {
                AutoSave = false;
                XmlName = 'DataExchDocument';
                textelement(D1)
                {
                    Width = 255;
                }
                textelement(D2)
                {
                }
                textelement(D3)
                {
                }
                textelement(D4)
                {
                }
                textelement(D5)
                {
                }
                textelement(D6)
                {
                }
                textelement(D7)
                {
                }
                textelement(D8)
                {
                }
                textelement(D9)
                {
                }
                textelement(D10)
                {
                }
                textelement(D11)
                {
                }
                textelement(D12)
                {


                    trigger OnAfterAssignVariable()
                    begin

                        ValidateHeaderTag;
                    end;
                }

            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPreXmlPort()
    begin

    end;

    trigger OnPostXmlPort()
    begin
        IF (TIPOPEDI <> 'DVPR') AND (TIPOPEDI <> 'NORM') THEN BEGIN
            IF ESPEDIDO THEN BEGIN
                ///RecCV.GET(1,PEDIDONAV);
                ///ReleaseSalesDoc.RUN(RecCV);
                ///CodeCV.REGISTRAEXPE(RecCV);
                RecCV.RESET;
                RecCV.SETCURRENTKEY(RecCV."Document Type", RecCV."Nº expedición");
                RecCV.SETRANGE(RecCV."Document Type", 1);
                RecCV.SETRANGE(RecCV."Nº expedición", NPEDIDO);
                IF RecCV.FINDFIRST THEN
                    REPEAT
                        CLEAR(ReleaseSalesDoc);
                        CLEAR(CodeCV);
                        ReleaseSalesDoc.RUN(RecCV);
                        CodeCV.REGISTRAEXPE(RecCV);
                    UNTIL RecCV.NEXT = 0;
                ///          
                enviar := TRUE;
                EXPEDI := NPEDIDO;
                REC110.SETCURRENTKEY(REC110."Nº expedición");
                REC110.SETFILTER(REC110."Nº expedición", NPEDIDO + '*');
                IF REC110.FINDSET THEN
                    REPEAT
                        IF REC110.Dropshipping = FALSE THEN BEGIN
                            IF REC110."Albaran sin detalle" = TRUE THEN BEGIN
                                IF REC110."No. Printed" = 0 THEN BEGIN
                                    enviar := FALSE;
                                END;
                            END;
                        END;
                    UNTIL REC110.NEXT = 0;




                IF enviar THEN BEGIN
                    EXPEDI := NPEDIDO;
                    REC110.RESET;
                    REC110.SETCURRENTKEY(REC110."Nº expedición");
                    REC110.SETFILTER(REC110."Nº expedición", NPEDIDO + '*');
                    IF REC110.FINDFIRST THEN
                        REPEAT
                            NALBARAN := REC110."No.";
                            Rec1102.RESET;
                            Rec1102.SETRANGE(Rec1102."No.", REC110."No.");
                            IF Rec1102.FINDFIRST THEN
                                REPEAT
                                    IF Rec1102."Nº Palets" = 0 THEN BEGIN
                                        IF RecTra.GET(Rec1102."Shipping Agent Code") THEN BEGIN
                                            IF RecTra."Fichero estandar" = TRUE THEN BEGIN
                                                CUEXP.ETISTD(Rec1102);
                                            END;
                                            IF RecTra."Fichero estandar" = FALSE THEN BEGIN
                                                ///IF Rec1102."Shipping Agent Code"='DHL' THEN BEGIN
                                                ///CUEXP.EtiDHL2NUEVA(Rec1102);
                                                //END;
                                                IF Rec1102."Shipping Agent Code" = 'TIPSA' THEN BEGIN
                                                    CUEXP.Etitipsa2NUEVA(Rec1102);
                                                END;
                                                IF Rec1102."Shipping Agent Code" = 'CORR' THEN BEGIN
                                                    CUEXP.EtiCORRa2NUEVA(Rec1102);
                                                END;
                                                IF Rec1102."Shipping Agent Code" = 'CRON' THEN BEGIN
                                                    CUEXP.EtiCRON2NUEVA(Rec1102);
                                                END;
                                                IF Rec1102."Shipping Agent Code" = 'SEUR' THEN BEGIN
                                                    CUEXP.EtiSEURNUEVA(Rec1102);
                                                END;
                                                IF Rec1102."Shipping Agent Code" = 'TNT' THEN BEGIN
                                                    ///CUEXP.EtiTNT2NUEVA(Rec1102);
                                                    CUEXP.EtiTNT2(Rec1102);
                                                END;
                                            END;
                                            IF Rec1102."Shipping Agent Code" = 'ECI' THEN BEGIN
                                                ///     CUEXP.ETIECI(Rec1102);
                                            END;
                                        END;
                                    END;
                                    IF Rec1102."Bill-to Customer No." = '6445' THEN BEGIN
                                        ///REPORT.RUNMODAL(50035,FALSE,FALSE,Rec1102);
                                        ///REPORT.RUNMODAL(50039,FALSE,FALSE,Rec1102);
                                    END;
                                UNTIL Rec1102.NEXT = 0;
                            IF Rec1102."Bill-to Customer No." = '10925' THEN BEGIN
                                /////-                         ficehrocovaldroper;
                            END;
                            IF Customer.GET(REC110."Sell-to Customer No.") THEN BEGIN
                                IF Customer."Enviar etiqueta grande" THEN BEGIN
                                    REPORT.RUNMODAL(50039, FALSE, FALSE, REC110);
                                END;
                            END;
                        UNTIL REC110.NEXT = 0;






                    ///// etiqueta edi

                    Rec112.RESET;
                    Rec112.SETCURRENTKEY(Rec112."Nº expedición");
                    Rec112.SETFILTER(Rec112."Nº expedición", NPEDIDO + '*');
                    IF Rec112.FINDFIRST THEN BEGIN
                        IF Rec112."Nº bultos" = 1 THEN BEGIN
                            Rec113.RESET;
                            Rec113.SETRANGE("Document No.", Rec112."No.");
                            Rec113.SETRANGE(Type, Rec113.Type::Item);
                            IF Rec113.FINDFIRST THEN
                                REPEAT
                                    CabCompra.INIT;
                                    Cajasporenvio.Nfac := Rec113."Document No.";
                                    Cajasporenvio.nlin := Rec113."Line No.";
                                    Cajasporenvio.Producto := Rec113."No.";
                                    Cajasporenvio."Caja num" := 1;
                                    Cajasporenvio.Cantidad := Rec113.Quantity;
                                    Cajasporenvio."nº expedicion" := NPEDIDO;
                                    IF Cajasporenvio.INSERT THEN;
                                    Rec113."Cantidad caja" := 1;
                                    Rec113.MODIFY;
                                UNTIL Rec113.NEXT = 0;
                            Cajasporenvio.RESET;
                            Cajasporenvio.SETRANGE(Nfac, Rec112."No.");
                            IF Cajasporenvio.FINDFIRST THEN
                                REPEAT
                                    Cajasporenvio.CreaSSCC;
                                    Cajasporenvio.MODIFY;
                                UNTIL Cajasporenvio.NEXT = 0;
                            SalesShipmentHeader.RESET;
                            SalesShipmentHeader.SETRANGE("Nº expedición", Rec112."Nº expedición");
                            IF SalesShipmentHeader.FINDFIRST THEN BEGIN
                                SalesShipmentHeader2.RESET;
                                SalesShipmentHeader2.SETRANGE("No.", SalesShipmentHeader."No.");
                                IF SalesShipmentHeader2.FINDFIRST THEN BEGIN
                                    ///CLEAR(EtiquetaECINUEVAALB);            
                                    ///EtiquetaECINUEVAALB.Pasadatos(Cajasporenvio."Caja num",Rec113."Cantidad caja",Cajasporenvio.SSCC);   
                                    ///EtiquetaECINUEVAALB.SETTABLEVIEW(SalesShipmentHeader2);
                                    ///EtiquetaECINUEVAALB.RUNMODAL;
                                    //// REPORT.RUN(50105,FALSE,FALSE,SalesShipmentHeader2);                                   
                                END;
                            END;




                        END;
                    END;





                    ///
                END;
            END;

        END;

    end;

    var
        LastLineIsHeaderErr: label 'The imported file contains unexpected formatting. One or more lines may be missing in the file.';
        WrongHeaderErr: label 'The imported file contains unexpected formatting. One or more headers are incorrect.';
        WORKDATED: Date;
        KIL: Decimal;
        CAN: Decimal;
        UNO: Code[20];
        DOS: Code[20];
        LON: Decimal;
        REFCONFOR: Code[20];
        LDP: Record "Item Journal Line";
        CANTIDECI: Decimal;
        KILOSDECI: Decimal;
        NL: Decimal;
        TiendaFichero: Code[10];
        FechaFichero: Code[10];
        ExisAlma: Decimal;
        Exis: Decimal;
        Documento: Code[10];
        FechaDoc: Date;
        Dif: Decimal;
        Difmayor: Decimal;
        Fecha: Record Date;
        Dialo: Dialog;
        RecCuenta: Record "G/L Account";
        VentaC: Decimal;
        VentaMP: Decimal;
        MP: Record "Item Ledger Entry";
        ArchSalida: File;
        ArchExt: Text[30];
        Ascii: Boolean;
        CodDFecha: Date;
        CodHFecha: Date;
        TextoSalida: Text[250];
        Recproducto: Record Item;
        "RecAlmacén": Record Location;
        Importe: Decimal;
        RecIVA: Record "VAT Posting Setup";
        Dia1: Decimal;
        Mes1: Decimal;
        Ventana2: Dialog;
        opc: Integer;
        ArchExt1: Text[30];
        ArchExt2: Text[30];
        TextoSalida1: Text[250];
        TextoSalida2: Text[250];
        ArchSalida1: File;
        ArchSalida2: File;
        CodDTienda: Code[10];
        CodHTienda: Code[10];
        RecSDP: Record "Item Journal Batch";
        Rec83: Record "Item Journal Line";
        RecItem: Record Item;
        RecUMP: Record "Item Unit of Measure";
        STOCCAL: Decimal;
        RecItem2: Record Item;
        RecPP: Record "Purchase Price";
        Rec32: Record "Item Ledger Entry";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ACCION: Code[20];
        DCanti: Decimal;
        TIPO2: Integer;
        ITEM: Record Item;
        D: Date;
        "DECIAÑO": Integer;
        "Año": Code[10];
        Mes: Decimal;
        Dia: Decimal;
        DOC1: Code[255];
        SALE: Boolean;
        NPEDIDO: Code[10];
        REF: Code[10];
        POS: Decimal;
        CANTI: Code[10];
        PurchaseLine: Record "Purchase Line";
        DECI: Decimal;
        TIPOUNI: Code[10];
        NALBA: Code[20];
        PurchaseHeader: Record "Purchase Header";
        ImprInfor: Codeunit "Test Report-Print";
        ImprDocu: Codeunit "Document-Print";
        CabCompra: Record "Purchase Header";
        Seleccion: Integer;
        RegCompra: Codeunit "Purch.-Post";
        "PuntLínCompra": Record "Purchase Line";
        "ExistenLíneasPendientes": Boolean;
        Borrado: Boolean;
        LinCompra: Record "Purchase Line";
        Producto: Record Item;
        "<< SSG_DIST_VARS": Boolean;
        tabla_LinCompra: Record "Purchase Line";
        nuevas_unidades: Decimal;
        num_producto: Code[20];
        num_documento: Code[20];
        num_linea: Integer;
        ControlKilos: Decimal;
        Proveedor: Record Vendor;
        "cAlmacén": Code[250];
        Rec2: Record "Purchase Header";
        "tabla_almacén": Record Location;
        ventana: Dialog;
        codigoalmacen: Code[20];
        tabla_conf_exist: Record "Inventory Setup";
        T_InfoEmpresa: Record "Company Information";
        tabla_almacenes: Record Location;
        dFechaCaducidad: Date;
        cExpr1: Code[3];
        ha_ubicado: Boolean;
        P: Record Item;
        KILOSC: Code[10];
        KILOS: Decimal;
        OADAIA: Code[10];
        NOADAIA: Decimal;
        FEC: Code[8];
        CLITIEN: Decimal;
        todocero: Boolean;
        CodeCC: Codeunit "Automaticos Cartas";
        RecCC: Record "Purchase Header";
        Release: Codeunit "Release Purchase Document";
        TIPOPEDI: Code[20];
        CLIENTE: Code[10];
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ndocdv: Code[20];
        lin: Integer;
        CODALMA: Code[10];
        DOCLIQ: Code[20];
        RecTL: Record "Transfer Line";
        RecTC: Record "Transfer Header";
        ESTRANSF: Boolean;
        ESPEDIDO: Boolean;
        CodeCV: Codeunit "Automaticos Cartas";
        Rec832: Record "Item Journal Line";
        ESPEPE: Boolean;
        LIN2: Integer;
        RecCV: Record "Sales Header";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        PEDIDONAV: CODE[20];
        RecCusto: Record Customer;
        LC: Record "Sales Line";
        RecComp: Record "Purchase Header";
        cc: Record "Sales Header";
        CLIN: CODE[20];
        RecCV2: Record "Sales Header";
        decre: Decimal;
        RecTra: Record "Shipping Agent";
        enviar: Boolean;
        EXPEDI: CODE[20];
        REC110: Record "Sales Shipment Header";
        REC1102: Record "Sales Shipment Header";
        Rec112: Record "Sales Invoice Header";
        CUEXP: Codeunit "Automaticos Cartas";
        Customer: Record Customer;
        NALBARAN: code[20];
        Rec113: Record "Sales Invoice Line";
        Cajasporenvio: Record "Cajas por envio";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentHeader2: Record "Sales Shipment Header";
        LLINEA: Integer;
        RecLVSuma: Record "Sales Line";



    local procedure ValidateHeaderTag()
    begin


        ///   1   2  3         4       5               6           7     8       9       10      11  12       
        /// CECA|MO|CAT25986|01       |CT02300976   |         |PED      |  |         |20241203 |0824|   |||
        /// CELI|MO|CAT25282|000000001|10           |000000001|000000005|UD|000000000|000000000|    |   |
        /// CELI|MO|CAT25282|000000002|11           |000000001|000000001|UD|000000000|000000000|    |   |
        /// CELI|MO|CAT25282|000020000|44839        |000000002|000000002|UD|000190000|000000000|    |   |
        /// CELI|MO|CAT25282|000000003|15           |000000001|000000001|UD|000000000|000000000|    |   |


        if CopyStr(D1, 1, 4) = 'CECN' then begin
            NPEDIDO := D3;
            IF CC.GET(1, NPEDIDO) THEN BEGIN
                CC."Etq.Adaia" := D5;
                CC.Modify;
            END;
        end;


        if CopyStr(D1, 1, 4) = 'CECA' then begin
            NPEDIDO := D3;
            CLIENTE := D6;
            TIPOPEDI := D7;
            IF (TIPOPEDI <> 'DVPR') AND (TIPOPEDI <> 'NORM') THEN BEGIN
                IF CC.GET(1, NPEDIDO) THEN BEGIN
                    ESPEDIDO := TRUE;
                    ESTRANSF := FALSE;
                    if cc.Status = cc.Status::Released then
                        ReleaseSalesDoc.Reopen(CC);
                END;
                ESPEDIDO := TRUE;
                RecCV.SETCURRENTKEY(RecCV."Document Type", RecCV."Nº expedición");
                RecCV.SETRANGE(RecCV."Document Type", 1);
                RecCV.SETRANGE(RecCV."Nº expedición", NPEDIDO);
                IF RecCV.FINDSET THEN
                    REPEAT
                        RecCV."Recibido de adaia" := TRUE;
                        PEDIDONAV := RecCV."No.";
                        RecCV."Posting Date" := TODAY;
                        RecCV."Document Date" := TODAY;
                        RecCV.VALIDATE(RecCV."Posting Date");
                        RecCV.VALIDATE(RecCV."Document Date");
                        IF RecCusto.GET(RecCV."Sell-to Customer No.") THEN BEGIN
                            IF RecCusto."Estatus del cliente" = 1 THEN BEGIN
                                RecCusto."Estatus del cliente" := 0;
                                RecCusto.MODIFY;
                            END;
                        END;
                        IF RecCV."Incrementa bultos" <> 0 THEN BEGIN
                            RecCV."Nº bultos" := RecCV."Nº bultos" + RecCV."Incrementa bultos";
                        END;
                        RecCV.MODIFY;
                    UNTIL RecCV.NEXT = 0;
                IF ESPEDIDO THEN BEGIN
                    ///CC.VALIDATE(CC."Posting Date",D);
                    ///CC.VALIDATE(CC."Document Date",D);
                    ///CC.MODIFY;
                    LC.SETCURRENTKEY(LC."Document Type", LC."Nº expedición", LC."Linea Nº expedición");
                    LC.SETRANGE(LC."Document Type", 1);
                    LC.SETRANGE(LC."Nº expedición", NPEDIDO);
                    IF LC.FINDSET THEN
                        REPEAT
                            IF RecItem2.GET(LC."No.") THEN BEGIN
                                IF RecItem2."Enviar siempre" = TRUE THEN BEGIN
                                    if lc."Qty. to Ship" <> LC.Quantity then begin
                                        LC.VALIDATE(LC."Qty. to Ship", LC.Quantity);
                                        lc.Modify();
                                    end;
                                END;
                            end else begin
                                if lc."Qty. to Ship" <> 0 then begin
                                    LC.VALIDATE(LC."Qty. to Ship", 0);
                                    LC.MODIFY;
                                end;
                            end;
                        UNTIL LC.NEXT = 0;
                END;
            END;
            IF TIPOPEDI = 'DVPR' THEN BEGIN
                CODALMA := 'SILLA';
                RecComp.INIT;
                RecComp."Document Type" := 3;
                RecComp."Order Date" := TODAY;
                RecComp."Posting Date" := TODAY;
                RecComp."Document Date" := TODAY;
                RecComp.VALIDATE(RecComp."Buy-from Vendor No.", CLIENTE);
                RecComp.INSERT(TRUE);
                RecComp."Location Code" := CODALMA;
                RecComp.MODIFY(TRUE);
                ndocdv := RecComp."No.";
                lin := 10000;
            END;
            IF TIPOPEDI = 'NORM' THEN BEGIN
                CODALMA := 'SILLA';
            END;

        end;
        if CopyStr(D1, 1, 4) = 'CELI' then begin
            SALE := FALSE;
            REF := D5;
            CANTI := D7;
            CLIN := D4;
            Evaluate(LLINEA, clin);
            ///Message('%1 %2 %3',NPEDIDO,clin,REF);
            IF TIPOPEDI <> 'DVPR' THEN BEGIN
                IF ESPEDIDO THEN BEGIN
                    LC.SETRANGE(LC."Document Type", 1);
                    LC.SETRANGE(LC."Nº expedición", NPEDIDO);
                    LC.SETRANGE(LC."Linea Nº expedición", LLINEA);
                    LC.SETRANGE(LC."No.", REF);
                    IF LC.FINDfirst THEN BEGIN
                        LC.CALCFIELDS(LC."Suma cdad. por envio");
                        IF LC."Suma cdad. por envio" = LC."Outstanding Quantity" THEN BEGIN
                            EVALUATE(DECI, CANTI);
                            IF KILOS = 0 THEN BEGIN
                                DECI := DECI / LC."Qty. per Unit of Measure";
                                LC.VALIDATE(LC."Qty. to Ship", DECI);
                            END;
                            LC.MODIFY;
                            ///Message('1-modif %1 ',lc);2
                        END;
                        IF LC."Suma cdad. por envio" > LC."Outstanding Quantity" THEN BEGIN

                            EVALUATE(DECI, CANTI);
                            DECI := DECI / LC."Qty. per Unit of Measure";
                            RecLVSuma.RESET;
                            RecLVSuma.SETCURRENTKEY(RecLVSuma."Nº expedición", RecLVSuma."No.");
                            RecLVSuma.SETRANGE(RecLVSuma."Nº expedición", NPEDIDO);
                            RecLVSuma.SETRANGE(RecLVSuma."No.", REF);
                            RecLVSuma.SETRANGE(RecLVSuma."Linea Nº expedición", LLINEA);
                            IF RecLVSuma.FindSet() THEN
                                REPEAT
                                    IF RecLVSuma."Outstanding Quantity" <= DECI THEN BEGIN
                                        IF RecLVSuma."Document No." <> LC."Document No." THEN BEGIN
                                            IF CC.GET(1, RecLVSuma."Document No.") THEN BEGIN
                                                ReleaseSalesDoc.Reopen(CC);
                                            END;
                                        END;
                                        RecLVSuma.VALIDATE(RecLVSuma."Qty. to Ship", RecLVSuma."Outstanding Quantity");
                                        RecLVSuma.MODIFY;
                                        DECI := DECI - RecLVSuma."Outstanding Quantity";
                                    END ELSE BEGIN
                                        IF DECI > 0 THEN BEGIN
                                            IF RecLVSuma."Document No." <> LC."Document No." THEN BEGIN
                                                IF CC.GET(1, RecLVSuma."Document No.") THEN BEGIN
                                                    ReleaseSalesDoc.Reopen(CC);
                                                END;
                                            END;
                                            RecLVSuma.VALIDATE(RecLVSuma."Qty. to Ship", DECI);
                                            RecLVSuma.MODIFY;
                                            ///Message('2-modif %1 ', lc);
                                            DECI := 0;
                                        END;

                                    END;
                                UNTIL RecLVSuma.NEXT = 0;
                        END;
                    END;
                end;
                IF REF = '10' THEN BEGIN
                    EVALUATE(DECI, CANTI);
                    RecCV2.RESET;
                    RecCV2.SETCURRENTKEY(RecCV2."Document Type", RecCV2."Nº expedición");
                    RecCV2.SETRANGE(RecCV2."Document Type", 1);
                    RecCV2.SETRANGE(RecCV2."Nº expedición", NPEDIDO);
                    IF RecCV2.FINDSET THEN BEGIN
                        RecCV2.VALIDATE(RecCV2."Nº bultos", DECI);
                        IF RecCV2."Incrementa bultos" <> 0 THEN BEGIN
                            RecCV2.VALIDATE(RecCV2."Nº bultos", RecCV2."Nº bultos" + RecCV."Incrementa bultos");
                        END;
                        RecCV2.MODIFY;
                    END;


                END;
                IF REF = '11' THEN BEGIN
                    EVALUATE(DECI, CANTI);
                    RecCV2.RESET;
                    RecCV2.SETCURRENTKEY(RecCV2."Document Type", RecCV2."Nº expedición");
                    RecCV2.SETRANGE(RecCV2."Document Type", 1);
                    RecCV2.SETRANGE(RecCV2."Nº expedición", NPEDIDO);
                    IF RecCV2.FINDSET THEN BEGIN
                        RecCV2.VALIDATE(RecCV2."Nº Palets", DECI);
                        RecCV2.MODIFY;
                    END;
                END;
                IF REF = '15' THEN BEGIN
                    RecCV2.RESET;
                    RecCV2.SETCURRENTKEY(RecCV2."Document Type", RecCV2."Nº expedición");
                    RecCV2.SETRANGE(RecCV2."Document Type", 1);
                    RecCV2.SETRANGE(RecCV2."Nº expedición", NPEDIDO);
                    IF RecCV2.FINDSET THEN BEGIN
                        RecCV2.Preparador := D7;
                        RecCV2.MODIFY;
                    END;
                END;


                IF REF = '12' THEN BEGIN
                    EVALUATE(DECI, CANTI);
                    RecCV2.RESET;
                    RecCV2.SETCURRENTKEY(RecCV2."Document Type", RecCV2."Nº expedición");
                    RecCV2.SETRANGE(RecCV2."Document Type", 1);
                    RecCV2.SETRANGE(RecCV2."Nº expedición", NPEDIDO);
                    IF RecCV2.FINDSET THEN BEGIN
                        decre := 1;
                        IF RecTra.GET(RecCV2."Shipping Agent Code") THEN BEGIN
                            IF RecTra."Decremento kilo" <> 0 THEN BEGIN
                                decre := (100 - RecTra."Decremento kilo") / 100;
                            END;
                        END;
                        RecCV2."Total peso" := ROUND(DECI * decre, 1);
                        RecCV2.MODIFY;
                    END;
                END;
                IF REF = '13' THEN BEGIN
                    EVALUATE(DECI, CANTI);
                    RecCV2.RESET;
                    RecCV2.SETCURRENTKEY(RecCV2."Document Type", RecCV2."Nº expedición");
                    RecCV2.SETRANGE(RecCV2."Document Type", 1);
                    RecCV2.SETRANGE(RecCV2."Nº expedición", NPEDIDO);
                    IF RecCV2.FINDSET THEN BEGIN
                        IF DECI = 1 THEN BEGIN
                            RecCV2."Shipping Agent Code" := 'DHL';
                            RecCV2.MODIFY;
                        END;
                        IF DECI = 3 THEN BEGIN
                            RecCV2."Shipping Agent Code" := 'TIPSA';
                            RecCV2.MODIFY;
                        END;
                        IF DECI = 2 THEN BEGIN
                            RecCV2."Shipping Agent Code" := 'SEUR';
                            RecCV2.MODIFY;
                        END;
                    END;
                END;
            END;
        END;
    END;



}



