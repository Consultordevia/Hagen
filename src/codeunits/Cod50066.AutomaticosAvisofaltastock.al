#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50066 "Automaticos Aviso falta stock"
{
    Permissions = TableData "Purch. Rcpt. Header" = rim;

    trigger OnRun()
    begin


        ENVIARemailfaltastock;
        exit;



    end;

    var
        CASCII: Codeunit "ANSI <-> ASCII converter2";
        LOGCAMBIOA: Integer;
        ArchSalida: File;
        ArchSalida2: File;
        ArchSalida3: File;
        ArchSalida4: File;
        ArchSalida5: File;
        ArchExt: Text[80];
        ArchExt2: Text[80];
        ArchExt3: Text[80];
        ArchExt4: Text[80];
        ArchExt5: Text[80];
        TextoSalida: Text[250];
        TextoSalida1: Text[250];
        TextoSalida2: Text[250];
        TextoSalida3: Text[250];
        TextoSalida4: Text[250];
        TextoSalida5: Text[250];
        RecItem: Record Item;
        VENTANA: Dialog;
        COD: Code[13];
        COD2: Code[14];
        AA: Integer;
        MM: Integer;
        DD: Integer;
        HH: Code[2];
        MI: Code[2];
        SE: Code[2];
        A1: Code[4];
        M1: Code[2];
        D1: Code[2];
        CRITERIO: Option FC,FE,FF,LO;
        PESO: Code[1];
        TIEMPO: Code[20];
        LONG: Code[4];
        PESO2: Code[10];
        ENCONTRADO: Boolean;
        PUNTO: Code[10];
        CUANTOS: Decimal;
        DESDE: Decimal;
        UNI1: Code[3];
        UNI2: Code[3];
        UNI3: Code[3];
        UNIPAL: Decimal;
        BASE: Code[10];
        ALTURA: Code[10];
        Clie: Record Customer;
        Prov: Record Vendor;
        PESO3: Code[10];
        UNICAJA: Decimal;
        UNIRET: Code[10];
        PICKING: Code[10];
        DIMENSION: Code[10];
        PALET: Code[10];
        UNI: Code[1];
        P1: Code[2];
        P2: Code[2];
        P3: Code[2];
        DESNOM: Text[40];
        DESNOM2: Text[40];
        DESNOM3: Text[40];
        DESNOM4: Text[40];
        TIPOPA: Code[2];
        RC: Code[1];
        MODIFICA1: Boolean;
        MODIFICA2: Boolean;
        MODIFICA3: Boolean;
        ALE1: Decimal;
        ALE2: Decimal;
        ALE3: Decimal;
        ALEA: Decimal;
        TIPO: Decimal;
        EXTEN: Code[255];
        DAT1: Code[255];
        DAT2: Code[255];
        RecCE: Record "Inventory Setup";
        Recterri: Record Territory;
        DESNOM1: Text[30];
        CODI: Code[16];
        CONTROLAEA: Code[1];
        CAJASPAL: Decimal;
        BASEUNIDAD: Code[10];
        ALTURAUNIDAD: Code[10];
        PESOINF: Code[10];
        PESOSUP: Code[10];
        VOLUMEN: Code[10];
        LARGO: Code[10];
        ANCHO: Code[10];
        ALTO: Code[10];
        PESOUNI: Code[10];
        PESOTARA: Code[10];
        UNIANI: Code[10];
        RecIUM: Record "Item Unit of Measure";
        RecIUMIN: Record "Item Unit of Measure";
        RecIUMMA: Record "Item Unit of Measure";
        RecIUM2: Record "Item Unit of Measure";
        RecCC: Record "Purchase Header";
        RecLC: Record "Purchase Line";
        ESDIA1: Decimal;
        ESMES1: Decimal;
        "ESAÑO1": Decimal;
        ESMES11: Code[10];
        ESDIA11: Code[10];
        FECORD1: Text[30];
        FECORD2: Text[30];
        ESDIA2: Decimal;
        ESMES2: Decimal;
        "ESAÑO2": Decimal;
        ESMES22: Code[10];
        ESDIA22: Code[10];
        TENDA: Code[10];
        NLIN: Integer;
        CANTIPEDI: Code[10];
        CANTIKILO: Code[10];
        RecItem2: Record Item;
        CODBAR: Code[10];
        LENCB: Integer;
        VENTANA2: Dialog;
        opcio: Integer;
        RecCV: Record "Sales Header";
        RecLV: Record "Sales Line";
        PEDIDOTENDA: Code[20];
        NLINC: Code[10];
        CODPRODT: Code[20];
        CANTIDADTRAS: Code[10];
        KILOSTRAS: Code[10];
        PRECIO: Code[10];
        UNIDADESCAJA: Decimal;
        DDD1: Code[10];
        DDD2: Code[10];
        DDD3: Code[10];
        LONGI: Decimal;
        coddias: Code[10];
        CAJASMA: Decimal;
        UNIMA: Decimal;
        CD1: Code[10];
        CD2: Code[10];
        RecRefCruz: Record "Item Reference";
        RUTA: Code[250];
        SalesPost: Codeunit "Sales-Post";
        PurchPost: Codeunit "Purch.-Post";
        RecCVE: Record "Sales Header";
        CONTA: Decimal;
        NPEDIDO: Code[20];
        CURegMov: Codeunit "Item Jnl.-Post Batch";
        CONTALIN: Integer;
        UBIPICDIN: Code[1];
        PICCOMPAR: Code[1];
        fragil: Text[30];
        RecLVF: Record "Sales Line";
        RecITemF: Record Item;
        OBS: Text[255];
        FRAG: array[20] of Integer;
        PORTES: Decimal;
        RecLV2: Record "Sales Line";
        RecCusto: Record Customer;
        Rec91: Record "User Setup";
        g: Code[20];
        g2: Code[20];
        RecIE: Record "Company Information";
        Rec36: Record "Sales Header";
        Rec110: Record "Sales Shipment Header";
        NEXPE: Code[10];
        ANO2: Code[10];
        PAISDES: Code[2];
        TIPOSER: Code[1];
        DD1: Code[10];
        MM1: Code[10];
        AA1: Code[10];
        OBSERV1: Code[40];
        OBSERV2: Code[40];
        pendi: Decimal;
        Rec37: Record "Sales Line";
        pdte: Decimal;
        stock: Decimal;
        codtras: Code[20];
        NTEL: Code[9];
        NTEL2: Text[30];
        TextAmount: Text[35];
        REEMBOLSO: Code[11];
        DREEMBOLSO: Decimal;
        Rec111: Record "Sales Shipment Line";
        RecFP: Record "Payment Method";
        Rec112: Record "Sales Invoice Header";
        Rec113: Record "Sales Invoice Line";
        RespetaTrans: Boolean;
        TELEFONO: Text[30];
        RecRecor2: Record "Reminder Header";
        contadord: Integer;
        RecLDR: Record "Reminder Line";
        ELTEXTO1: Text[149];
        CONTASMS: Integer;
        Fichero: File;
        nomfich: Text[200];
        nomfich1: Text[200];
        nomfich2: Text[200];
        nomfich3: Text[200];
        Rec1102: Record "Sales Shipment Header";
        TBULTOS: Decimal;
        totalrecor: Decimal;
        RecLD2: Record "Gen. Journal Line";
        fvto: Date;
        RecCVC: Record "Sales & Receivables Setup";
        REC1112: Record "Sales Shipment Line";
        elpeso: Decimal;
        decre: Decimal;
        RecTra: Record "Shipping Agent";
        TOTALPALE: Integer;
        RecDEC: Record "Ship-to Address";
        GetSig: Codeunit NoSeriesManagement;
        expedi: Code[10];
        SalesInvHeader: Record "Sales Invoice Header";
        ChangeExchangeRate: Page "Change Exchange Rate";
        CU50001: Codeunit "Automaticos Cartas";
        CArea: Option Tapiceria,"Decoración";
        CMerca: Option Nacional,"Exportación";
        direccionda: Code[80];
        nombreda: Code[80];
        SenderName: Text[250];
        SenderAddress: Text[250];
        Recipient: Text[250];
        Subject: Text[250];
        Body: Text[1024];
        RecCus: Record Customer;
        dir1: Text[250];
        dir2: Text[250];
        dir3: Text[250];
        textocuerpo: Text[250];
        asunto: Text[250];
        codcli: Code[10];
        t: array[99] of Text[255];
        ret: Integer;
        ExecName: Text[30];
        param: Text[30];
        x: Integer;
        VETANA: Dialog;
        NFACT: Code[20];
        NCLIE: Code[20];
        SalesInvHeader3: Record "Sales Invoice Header";
        ESREEMBOLSO: Boolean;
        Rec1103: Record "Sales Shipment Header";
        RecCust: Record Customer;
        ENVIARPUBLI: Boolean;
        rut: Code[255];
        TEMAIL: Text[80];
        dc1: Code[9];
        dc2: Code[9];
        dc3: Code[9];
        dc4: Code[9];
        dc5: Code[9];
        celpeso: Code[10];
        pesoini: Decimal;
        importeree: Decimal;
        nprod: Integer;
        CUNext: Codeunit NoSeriesManagement;
        contaser: Code[20];
        NOMULTIPEDIDO: Boolean;
        "5DIGITOS": Code[5];
        LENEAN: Integer;
        UBIPIC: Code[16];
        UBIREF: Code[16];
        Rec120: Record "Purch. Rcpt. Header";
        Rec121: Record "Purch. Rcpt. Line";
        RecVendor: Record Vendor;
        Rec1202: Record "Purch. Rcpt. Header";
        RecI: Record Item;
        emailde: Text[100];
        RecTransp: Record "Shipping Agent";
        msg: Text[1024];
        ventana4: Dialog;
        SERVIRDABADO: Code[1];
        DESNOMa1: Text[50];
        DESNOMa2: Text[50];
        DESNOMa3: Text[50];
        DESNOMa4: Text[50];
        totapeso: Decimal;
        codpais: Code[2];
        cospostat: Code[8];
        RecLVSuma: Record "Sales Line";
        ENVIAR: Boolean;
        AGRUPADO: Code[10];
        RecGPG: Record "Gen. Product Posting Group";
        DESDEA: Date;
        Text1100007: label '<Integer>';
        SalesHeader: Record "Sales Header";
        ItemJournalLine: Record "Item Journal Line";
        totalbultos: Integer;
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptHeader2: Record "Purch. Rcpt. Header";
        PurchRcptHeader3: Record "Purch. Rcpt. Header";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchRcptLine3: Record "Purch. Rcpt. Line";
        albaranvalido: Boolean;
        UserSetup: Record "User Setup";
        Vendor: Record Vendor;
        NEXPEDICION: Text[30];
        codexpedico: Code[40];
        /////- EtiquetaECINUEVAALB: Report UnknownReport50105;
        CODPAIES2: Code[1];
        SalesHeader2: Record "Sales Header";
        SalesLine2: Record "Sales Line";
        SalesLine3: Record "Sales Line";
        tienerotura: Boolean;
        NEXPEDI: Code[20];
        Customer: Record Customer;
        /////- CartaavisotransfarenciasES: Report UnknownReport50106;
        Customer2: Record Customer;
        Fechalimite: Date;
        totalImpPdte: Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CarteraDoc: Record "Cartera Doc.";
        FileManagement: Codeunit "File Management";
        v: Dialog;
    /////- smtp: Codeunit smtp

    procedure ENVIARemailfaltastock()
    var
        SenderName: Text[250];
        SenderAddress: Text[250];
        Recipient: Text[250];
        Subject: Text[250];
        Body: Text[1024];
        RecCus: Record Customer;
        dir1: Text[250];
        dir2: Text[250];
        dir3: Text[250];
        textocuerpo: Text[250];
        asunto: Text[250];
        REC91: Record "User Setup";
        VENTANA2: Dialog;
        codcli: Code[10];
        t: array[99] of Text[255];
        ret: Integer;
        ExecName: Text[30];
        param: Text[30];
        x: Integer;
        VETANA: Dialog;
        CU: Codeunit "Automaticos Cartas";
        RecCust: Record Customer;
        FileDirectory: Code[250];
        FileDirectoryexcel: Code[250];
        FileName: Code[250];
        RunOnceFile: Text[250];
        TimeOut: Integer;
        SalesInvHeader2: Record "Sales Invoice Header";
        RecVende: Record "Salesperson/Purchaser";
        FormFac: Page "Posted Sales Invoice";
        rut: Text[1000];
        ArchExt22: Text[1000];
        ///SMTP: Codeunit UnknownCodeunit400;
        ///ImpBull: Automation PDFPrinterSettings;
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentHeader2: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        aviso: Boolean;
        SalesLine: Record "Sales Line";
    begin

        v.Open('#1###########################');

        SalesShipmentHeader.Reset;
        SalesShipmentHeader.SetCurrentkey("Aviso falta stock");
        SalesShipmentHeader.SetRange("Aviso falta stock", false);
        SalesShipmentHeader.SetRange("Posting Date", 20220801D, Today);
        if SalesShipmentHeader.FindSet then
            repeat
                v.Update(1, SalesShipmentHeader."No.");
                if SalesShipmentHeader."Grupo clientes" = 'G52' then begin
                    if (SalesShipmentHeader."Payment Method Code" = 'CARGO0030') or
            (SalesShipmentHeader."Payment Method Code" = 'CARGO0049') or
            (SalesShipmentHeader."Payment Method Code" = 'CARGO0049C') or
            (SalesShipmentHeader."Payment Method Code" = 'CARGO0081') or
            (SalesShipmentHeader."Payment Method Code" = 'CARGO0182') or
            (SalesShipmentHeader."Payment Method Code" = 'CARGO0182C') or
            (SalesShipmentHeader."Payment Method Code" = 'CARGO2077') or
            (SalesShipmentHeader."Payment Method Code" = 'CARGO2077C') or
            (SalesShipmentHeader."Payment Method Code" = 'CARGO2100') or
            (SalesShipmentHeader."Payment Method Code" = 'CARGO2100B') or
            (SalesShipmentHeader."Payment Method Code" = 'CARGO2100C') or
            (SalesShipmentHeader."Payment Method Code" = 'CARGO3058') or
            (SalesShipmentHeader."Payment Method Code" = 'CARGO3058C') then begin




                        SalesShipmentLine.Reset;
                        SalesShipmentLine.SetRange("Document No.", SalesShipmentHeader."No.");
                        if SalesShipmentLine.FindSet then
                            repeat
                                if SalesShipmentLine."Quantity (Base)" = 0 then begin
                                    SalesLine.Init;
                                    if SalesLine.Get(1, SalesShipmentLine."Order No.", SalesShipmentLine."Order Line No.") then begin
                                    end;
                                    REC91.Get(UserId);
                                    SenderName := COMPANYNAME;
                                    Subject := RecCus."Search Name" + ' - PEDIDO Nº ' + Format(SalesShipmentHeader."Your Reference");
                                    SenderAddress := REC91."E-Mail";
                                    Recipient := RecCus."Email pedido 1";
                                    Recipient := 'PascuAl.Dugarte@hagen.es;ventas@hagen.es;oscarraea@hotmail.com';
                                    /////-
                                    /*Clear(SMTP);
                                    SMTP.Run;
                                    SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                                    SMTP.AppendBody('Muy señores nuestros. <BR>');
                                    SMTP.AppendBody('Le informamos que la ref ' + SalesShipmentLine."No." + ' ' + SalesShipmentLine.Description + ' Cantidad:' + Format(SalesLine."Cantidad anulada") + '.<BR>');
                                    SMTP.AppendBody('Esta en rotura de stock.<BR>');
                                    SMTP.AppendBody('<HR>');
                                    SMTP.AppendBody('<BR>');
                                    SMTP.AppendBody('Atentamente,<BR>');
                                    SMTP.AppendBody('Pascual Duarte<BR>');
                                    SMTP.AppendBody('ROLF C HAGEN ESPAÑA S.A.');
                                    SMTP.AppendBody('<BR>');
                                    SMTP.AppendBody('<BR>');
                                    SMTP.AppendBody('<BR>');
                                    SMTP.AppendBody('<BR>');
                                    SMTP.Send;
                                    Clear(SMTP);*/
                                end;
                            until SalesShipmentLine.Next = 0;
                    end;
                end;
                SalesShipmentHeader2.Get(SalesShipmentHeader."No.");
                SalesShipmentHeader2."Aviso falta stock" := true;
                SalesShipmentHeader2.Modify;

            until SalesShipmentHeader.Next = 0;

        v.Close;


        Message('HECHO');
    end;
}

