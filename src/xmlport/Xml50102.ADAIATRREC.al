#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50102 "ADAIATRREC"
{
    Caption = 'ADAIATRREC';
    Direction = Import;
    FieldSeparator = '|';
    Format = VariableText;
    TextEncoding =  UTF16;
    UseRequestPage = false;

    ///   1   2  3         4       5         6       7         8         9         10     11  12       
    /// CRCA|MO|000013253|01   |110132   |HAG002|         |ENPR     |110105   |20241108 |1127|  |
    /// CRLI|MO|110132   |A600 |000000001|UD    |000000000|000000000|000000000|000020000|    |  |
    /// CRLI|MO|110132   |A65  |000000001|UD    |000000000|000000000|000000000|000030000|    |  |
    /// CRLI|MO|110132   |A6002|000000002|UD    |000000000|000000000|000000000|000040000|    |  |
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
        if TIPOPEDI = 'ENPR' then begin
            if ESPEDIDO and (not ESPEPE) then begin
                Message('2-%1 ', NPEDIDO);
                PurchaseHeader.Get(1, NPEDIDO);
                PurchaseHeader.Receive := true;
                PurchaseHeader.Invoice := false;
                PurchaseHeader.Modify;
                Release.Reopen(PurchaseHeader);
                CodeCC.REGISTRARECEP(PurchaseHeader);
            end;
            if ESTRANSF then begin
                RecTC.Get(NPEDIDO);
                CodeCV.REGISTRAEXPETRANF(RecTC);
            end;
        end;
        if TIPOPEDI = 'DVCL' then begin
            RecCV.Get(3, ndocdv);
            CodeCC.REGISTRAEXPEDEV(RecCV);
        end;
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


    local procedure InitializeGlobals()
    var
        DataExchDef: Record "Data Exch. Def";
    begin
    end;

    local procedure CheckLineType()
    begin
        ValidateNonDataLine;
        TrackNonDataLines;
    end;

    local procedure IdentifyLineType()
    begin
    end;

    local procedure ValidateNonDataLine()
    begin
    end;

    local procedure TrackNonDataLines()
    begin
    end;

    local procedure HeaderTagLength(): Integer
    var
        DataExchDef: Record "Data Exch. Def";
    begin
    end;

    local procedure FooterTagLength(): Integer
    var
        DataExchDef: Record "Data Exch. Def";
    begin
    end;

    local procedure GetFieldLength(TableNo: Integer; FieldNo: Integer): Integer
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
    end;

    local procedure InsertColumn(columnNumber: Integer; var columnValue: Text)
    var
        savedColumnValue: Text;
    begin
    end;

    local procedure ValidateHeaderTag()
    begin


        ///   1   2  3         4       5         6       7         8         9         10     11  12       
        /// CRCA|MO|000013253|01   |110132   |HAG002|         |ENPR     |110105   |20241108 |1127|  |
        /// CRLI|MO|110132   |A600 |000000001|UD    |000000000|000000000|000000000|000020000|    |  |


        if CopyStr(D1, 1, 4) = 'CRCA' then begin
            NPEDIDO := D5;
            CLIENTE := D6;
            TIPOPEDI := D8;
            Message('%1 ', NPEDIDO);
            DOCLIQ := D9;
            D := Today;
            if TIPOPEDI = 'ENPR' then begin
                ESPEDIDO := false;
                ESTRANSF := true;
                if PurchaseHeader.Get(1, NPEDIDO) then begin
                    ///OADAIA:=CopyStr(Linea,9,9);
                    ///Evaluate(NOADAIA,OADAIA);
                    ESPEDIDO := true;
                    ESTRANSF := false;
                    ESPEPE := false;
                end;
                if not PurchaseHeader.Get(1, NPEDIDO) then begin
                    ///OADAIA:=CopyStr(Linea,9,9);
                    ///Evaluate(NOADAIA,OADAIA);
                    ESPEDIDO := true;
                    ESTRANSF := false;
                    ESPEPE := true;
                end;
                if ESPEDIDO and (not ESPEPE) then begin
                    PurchaseHeader.Validate("Posting Date", D);
                    PurchaseHeader.Validate("Document Date", D);
                    PurchaseHeader.Ship := true;
                    PurchaseHeader.Invoice := false;
                    PurchaseHeader.Modify;
                    PurchaseLine.Reset;
                    PurchaseLine.SetRange("Document Type", 1);
                    PurchaseLine.SetRange("Document No.", NPEDIDO);
                    if PurchaseLine.FindFirst then
                        repeat
                            PurchaseLine.Validate("Qty. to Receive", 0);
                            PurchaseLine.Modify;
                        until PurchaseLine.Next = 0;
                end;
                if ESTRANSF then begin
                    RecTL.SetRange(RecTL."Document No.", NPEDIDO);
                    if RecTL.Find('-') then
                        repeat
                            RecTL.Validate(RecTL."Qty. to Ship", 0);
                            RecTL.Modify;
                        until RecTL.Next = 0;
                end;
            end;
            if TIPOPEDI = 'DVCL' then begin
                SalesHeader.Init;
                SalesHeader."Document Type" := 3;
                SalesHeader."Order Date" := Today;
                SalesHeader."Posting Date" := Today;
                SalesHeader."Shipment Date" := Today;
                SalesHeader."Document Date" := Today;
                SalesHeader.Validate("Sell-to Customer No.", CLIENTE);
                SalesHeader."Applies-to Doc. Type" := 2;
                SalesHeader."Applies-to Doc. No." := DOCLIQ;
                SalesHeader.Insert(true);
                ndocdv := SalesHeader."No.";
            end;
        end;
        if CopyStr(D1, 1, 4) = 'CRLI' then begin
            SALE := false;
            REF := '';
            CANTI := '';
            KILOSC := '';
            TIPOUNI := '';
            REF := D4;
            CANTI := D5;
            ///TIPOUNI:=TIPOUNI+CopyStr(Linea,POS,1);
            ///KILOSC:=KILOSC+CopyStr(Linea,POS,1);               
            if TIPOPEDI = 'ENPR' then begin
                if ESPEDIDO and (not ESPEPE) then begin
                    PurchaseLine.Reset;
                    PurchaseLine.SetRange("Document Type", 1);
                    PurchaseLine.SetRange("Document No.", NPEDIDO);
                    PurchaseLine.SetRange("No.", REF);
                    if PurchaseLine.FindFirst then begin
                        Evaluate(DECI, CANTI);
                        DECI := ROUND(DECI / PurchaseLine."Qty. per Unit of Measure", 0.01);
                        PurchaseLine.Validate("Qty. to Receive", DECI);
                        if KILOS <> 0 then begin
                            P.Get(PurchaseLine."No.");
                            PurchaseLine."Unit of Measure" := P."Base Unit of Measure";
                            PurchaseLine.Validate(Quantity, KILOS);
                        end;
                        PurchaseLine.Modify;
                    end;
                end;
                if ESPEDIDO and (ESPEPE) then begin
                    Evaluate(DECI, CANTI);
                    DECI := ROUND(DECI / PurchaseLine."Qty. per Unit of Measure", 0.01);
                    if DECI <> 0 then begin
                    end;
                end;
                if ESTRANSF then begin
                    RecTL.SetRange(RecTL."Document No.", NPEDIDO);
                    RecTL.SetRange(RecTL."Item No.", REF);
                    if RecTL.Find('-') then begin
                        Evaluate(DECI, CANTI);
                        DECI := ROUND(DECI / RecTL."Qty. per Unit of Measure", 0.01);
                        RecTL.Validate(RecTL."Qty. to Ship", DECI);
                        RecTL.Modify;
                        if KILOS <> 0 then begin
                            P.Get(RecTL."Item No.");
                            RecTL."Unit of Measure" := P."Base Unit of Measure";
                            RecTL.Validate(RecTL.Quantity, KILOS);
                            RecTL.Modify;
                        end;
                        PurchaseLine.Modify;
                    end;
                end;
            end;
            if TIPOPEDI = 'DVCL' then begin
                SalesLine.Init;
                SalesLine."Document Type" := 3;
                SalesLine."Document No." := ndocdv;
                lin := lin + 10000;
                SalesLine."Line No." := lin;
                SalesLine.Type := 2;
                SalesLine.Validate("No.", REF);
                Evaluate(DECI, CANTI);
                SalesLine.Validate(Quantity, DECI);
                if KILOS <> 0 then begin
                    P.Get(PurchaseLine."No.");
                    SalesLine."Unit of Measure" := P."Base Unit of Measure";
                    SalesLine.Validate(SalesLine.Quantity, KILOS);
                end;
                SalesLine.Insert(true);
            end;
        end;
    end;



}

