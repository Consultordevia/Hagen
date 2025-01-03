Codeunit 50010 "Automaticos Cartas"
{
    // Potyugal

    Permissions = TableData "Purch. Rcpt. Header" = rim, TableData "Sales Invoice Line" = rim,
    TableData "Sales Shipment Header" = rim,
    TableData "Sales Shipment Line" = rim,
    TableData "Sales Invoice Header" = rim;

    trigger OnRun()
    begin


        ENVIARemailCartaPagare;
        ENVIARemailCartaVencidos;
        ENVIARemailCartaTransfer;


        Message('HECHO.');
    end;

    var
        adaia: Record adaia;
        nomdir: text;
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        FileName: Text;
        InStream: InStream;
        FicherosHagen: Codeunit FicherosHagen;

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
        TextoSalida6: Text[250];
        TextoSalida7: Text[250];
        TextoSalida8: Text[250];
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
        NTEL: Code[22];
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
        EtiquetaECINUEVAALB: Report "Etiqueta ECI NUEVA ALB.";
        CODPAIES2: Code[1];
        SalesHeader2: Record "Sales Header";
        SalesLine2: Record "Sales Line";
        SalesLine3: Record "Sales Line";
        tienerotura: Boolean;
        NEXPEDI: Code[20];
        Customer: Record Customer;
        CartaavisotransfarenciasES: Report "Carta aviso transf-ES";
        Customer2: Record Customer;
        Fechalimite: Date;
        totalImpPdte: Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CarteraDoc: Record "Cartera Doc.";
        FileManagement: Codeunit "File Management";
        v: Dialog;
        ANYO: Integer;
        ServiceItem: Record "Service Item";
        ShippingAgentServices: Record "Shipping Agent Services";
        ShippingAgent: Record "Shipping Agent";
        ntel3: Text;
        xx: Integer;


    procedure etiadaia()
    var
        ChangeLogEntry: Record "Change Log Entry";
        InventorySetup: Record "Inventory Setup";
        Contador: Integer;
    begin

        Imprimeetiqueta;

    end;


    procedure TERCEROS()
    begin

        rut := '\\192.168.0.16\a_gestion\a_gestion\ini\';
        ArchExt4 := rut + 'Trter.TXT';

        TempBlob.CreateOutStream(OutStream);



        VENTANA.Update(1, 'TERCEROS');
        Clie.Init;
        Clie.Reset;

        if Clie.FindSet then
            repeat
                if Clie."No." <> '' then begin
                    VENTANA.Update(2, Clie."No.");
                    DESNOM := ConvertStr(CopyStr(Clie.Name, 1, 30), 'ª', '.');
                    DESNOM := ConvertStr(DESNOM, 'º', '.');
                    DESNOM2 := ConvertStr(CopyStr(Clie."Search Name", 1, 30), 'ª', '.');
                    DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
                    DESNOM3 := ConvertStr(CopyStr(Clie.Address, 1, 30), 'ª', '.');
                    DESNOM3 := ConvertStr(DESNOM3, 'º', '.');
                    DESNOM4 := ConvertStr(CopyStr(Clie.City, 1, 30), 'ª', '.');
                    DESNOM4 := ConvertStr(DESNOM4, 'º', '.');
                    DESNOM := CASCII.Ascii2Ansi(DESNOM);
                    DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
                    DESNOM3 := CASCII.Ascii2Ansi(DESNOM3);
                    DESNOM4 := CASCII.Ascii2Ansi(DESNOM4);

                    TIPOPA := '';
                    RC := '';

                    TextoSalida4 := 'TE' + '|' +       //1
                                    'AG' + '|' +       //2
                                    Format(Clie."No.") + '|' +  //3
                                    Format(DESNOM, 40) + '|' +   //4
                                    Format(Clie."No.") + '|' +  //5
                                    Format(DESNOM2, 12) + '|' +   //6
                                    'DES' + '|' +               //7
                                    Format(DESNOM3, 40) + '|' +  //8
                                    Format(DESNOM4, 40) + '|' +  //9
                                     '|' +  //10
                                     '|' +  //11
                                    Format(Clie."Post Code", 6) + '|' + //12
                                    Format(Clie.County, 4) + '|' +  //13
                                    'N|' +                           //14
                                    '|' +                     //15
                                    '|' +                     //16
                                    '|' +                     //17
                                    '|' +                     //18
                                    '|' +                      //19
                                    '|';                   //20
                    OutStream.Writetext(TextoSalida4);


                end;
            until Clie.Next = 0;

    end;


    procedure BUSCAEXTENSION()
    begin


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
        A1 := CopyStr(Format(AA), 3, 2);
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


        TIEMPO := Format(Time);
        ENCONTRADO := false;
        CUANTOS := 0;
        repeat
            CUANTOS := CUANTOS + 1;
            PUNTO := CopyStr(TIEMPO, CUANTOS, 1);
            if PUNTO = ':' then begin
                ENCONTRADO := true;
            end;
        until ENCONTRADO;
        HH := CopyStr(TIEMPO, 1, CUANTOS - 1);

        if HH = '0' then HH := '00';
        if HH = '1' then HH := '01';
        if HH = '2' then HH := '02';
        if HH = '3' then HH := '03';
        if HH = '4' then HH := '04';
        if HH = '5' then HH := '05';
        if HH = '6' then HH := '06';
        if HH = '7' then HH := '07';
        if HH = '8' then HH := '08';
        if HH = '9' then HH := '09';


        ENCONTRADO := false;

        DESDE := CUANTOS + 1;
        CUANTOS := 0;
        repeat
            CUANTOS := CUANTOS + 1;
            PUNTO := CopyStr(TIEMPO, CUANTOS, 1);
            if PUNTO = ':' then begin
                ENCONTRADO := true;
            end;
        until ENCONTRADO;
        MI := CopyStr(TIEMPO, DESDE, CUANTOS - 1);

        if MI = '0' then MI := '00';
        if MI = '1' then MI := '01';
        if MI = '2' then MI := '02';
        if MI = '3' then MI := '03';
        if MI = '4' then MI := '04';
        if MI = '5' then MI := '05';
        if MI = '6' then MI := '06';
        if MI = '7' then MI := '07';
        if MI = '8' then MI := '08';
        if MI = '9' then MI := '09';

        DESDE := DESDE + CUANTOS + 1;
        CUANTOS := 0;
        repeat
            CUANTOS := CUANTOS + 1;
            PUNTO := CopyStr(TIEMPO, CUANTOS, 1);
            if PUNTO = ':' then begin
                ENCONTRADO := true;
            end;
        until ENCONTRADO;
        SE := CopyStr(TIEMPO, DESDE, 2);
        if SE = '0' then SE := '00';
        if SE = '1' then SE := '01';
        if SE = '2' then SE := '02';
        if SE = '3' then SE := '03';
        if SE = '4' then SE := '04';
        if SE = '5' then SE := '05';
        if SE = '6' then SE := '06';
        if SE = '7' then SE := '07';
        if SE = '8' then SE := '08';
        if SE = '9' then SE := '09';




        Evaluate(ALE1, HH);
        Evaluate(ALE2, MI);
        Evaluate(ALE3, SE);
        ALEA := (ALE1 * 5 + ALE2 * 7 + ALE3 * 9 + TIPO);

        EXTEN := CopyStr(Format(AA), 3, 2) + Format(M1) + Format(D1) + Format(HH) + Format(MI) + Format(SE) + Format(ALEA);
        EXTEN := ConvertStr(EXTEN, ' ', '0');
        ALEA := TIPO;
    end;


    procedure ENVIATERCEROS()
    begin

        VENTANA.Open('Exportando: #1####################\' +
                     '            #2####################');



        /// Exportación a ADAIA TODOS LOS TERCEROS

        TERCEROS;
        RecCE.Get;
        RUTA := RecCE."Ruta salida de_gestion";
        TIPO := 3;
        BUSCAEXTENSION;
        DAT2 := 'TRTER.' + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

        VENTANA.Close;
    end;


    procedure ENVIAARTICULOS()
    begin




        /// Exportación a ADAIA TODOS LOS ARTICULOS

        ARTICULOS;
        RecCE.Get;
        RUTA := RecCE."Ruta salida de_gestion";
        TIPO := 3;
        BUSCAEXTENSION;
        DAT2 := 'TRART.' + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

        DAT2 := 'TRARPR.' + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);


        DAT2 := 'TRAREA.' + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure ARTICULOS()
    begin




        VENTANA.Update(1, 'ARTICULOS');
        RecItem.Reset;
        RecItem.SetRange(RecItem."Producto almacenable", true);
        RecItem.SetRange(RecItem."Last Date Modified", Today);
        if RecItem.FindSet then
            repeat
                VENTANA.Update(2, RecItem."No.");
                PESO := 'N';
                UNI1 := 'UD';
                UNI2 := 'UD';
                UNI3 := 'UD';
                DESNOM := ConvertStr(CopyStr(RecItem.Description, 1, 30), 'ª', '.');
                DESNOM := ConvertStr(DESNOM, 'º', '.');
                DESNOM2 := ConvertStr(CopyStr(RecItem."Description 2", 1, 30), 'ª', '.');
                DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
                DESNOM := CASCII.Ascii2Ansi(DESNOM);
                DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
                CODI := Format(RecItem."No.", 16);
                CODI := ConvertStr(CODI, ' ', ' ');
                CONTROLAEA := 'N';
                CRITERIO := RecItem."Criterio rotacion";
                TextoSalida := 'AR' + '|' +
                                  'AG' + '|' +
                                 RecItem."No." + '|' +
                             Format(DESNOM + ' ' + DESNOM2, 40) + '|' +
                             RecItem."No." + '|' +
                             Format(CRITERIO, 4) + '|' +
                             Format(DDD1, 5) + '|' +
                             Format(DDD2, 5) + '|' +
                             Format(DDD3, 5) + '|' +
                             'N' + '|' +
                             PESO + '|' +
                             CONTROLAEA + '|' +
                             'UD' + '|' +
                             Format('MA', 4) + '|' +
                             Format('UD', 4) + '|' +
                             Format('UD', 4) + '|' +
                             'N' + '|' +
                             'HAGEN|' +
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
                             '|' +
                             '|' +
                             '|';



                OutStream.Writetext(TextoSalida);




                UNICAJA := RecItem."Cantidad inner";
                UNIPAL := RecItem."Cantidad palets";
                if UNIPAL = 0 then begin
                    UNIPAL := RecItem."Cantidad master";
                end;
                if UNICAJA = 0 then begin
                    UNICAJA := 1;
                end;
                if UNIPAL = 0 then begin
                    UNIPAL := 1;
                end;

                CAJASPAL := 1;
                if UNICAJA <> 0 then begin
                    CAJASPAL := ROUND(UNIPAL / UNICAJA, 1);
                end;

                CD1 := Format(UNIPAL, 6, '<integer>');

                TextoSalida3 := 'ARPR' + '|' +
                                'DE' + '|' +
                                RecItem."No." + '|' +
                                'UD' + '|' +
                                '1' + '|' +
                                '|' +
                                '|' +
                                '|' +
                                '|' +
                                PESO2 + '|' +
                                PESOINF + '|' +
                                PESOSUP + '|' +
                                Format(CD1) + '|' +
                                Format(CD1) + '|' +
                                '1' + '|' +
                                '|' +
                                'N|';

                OutStream.Writetext(TextoSalida3);

                TextoSalida3 := 'ARPR' + '|' +
                                'AG' + '|' +
                                RecItem."No." + '|' +
                                'UD' + '|' +
                                '1' + '|' +
                                '|' +
                                '|' +
                                '|' +
                                '|' +
                                PESO2 + '|' +
                                PESOINF + '|' +
                                PESOSUP + '|' +
                                Format(CD1) + '|' +
                                Format(CD1) + '|' +
                                '1' + '|' +
                                '|' +
                                'N|';

                OutStream.Writetext(TextoSalida3);

                CD1 := Format(UNICAJA, 6, '<integer>');
                CD2 := Format(CAJASPAL, 6, '<integer>');
                TextoSalida3 := 'ARPR' + '|' +
                                'DE' + '|' +
                                RecItem."No." + '|' +
                                'CJ' + '|' +
                                Format(CD1) + '|' +
                                '|' +
                                '|' +
                                '|' +
                                '|' +
                                PESO2 + '|' +
                                PESOINF + '|' +
                                PESOSUP + '|' +
                                Format(CD2) + '|' +
                                Format(CD2) + '|' +
                                '1' + '|' +
                                '|' +
                                'N|';

                OutStream.Writetext(TextoSalida3);

                CD1 := Format(UNIPAL, 6, '<integer>');

                TextoSalida3 := 'ARPR' + '|' +
                                'AG' + '|' +
                                RecItem."No." + '|' +
                                'UD' + '|' +
                                '1' + '|' +
                                '|' +
                                '|' +
                                '|' +
                                '|' +
                                PESO2 + '|' +
                                PESOINF + '|' +
                                PESOSUP + '|' +
                                Format(CD1) + '|' +
                                Format(CD1) + '|' +
                                '1' + '|' +
                                '|' +
                                'N|';


                CD1 := Format(UNICAJA, 6, '<integer>');
                CD2 := Format(CAJASPAL, 6, '<integer>');
                TextoSalida3 := 'ARPR' + '|' +
                                'AG' + '|' +
                                RecItem."No." + '|' +
                                'CJ' + '|' +
                                Format(CD1) + '|' +
                                '|' +
                                '|' +
                                '|' +
                                '|' +
                                PESO2 + '|' +
                                PESOINF + '|' +
                                PESOSUP + '|' +
                                Format(CD2) + '|' +
                                Format(CD2) + '|' +
                                '1' + '|' +
                                '|' +
                                'N|';

                OutStream.Writetext(TextoSalida3);


                UNICAJA := RecItem."Cantidad inner";
                UNIPAL := RecItem."Cantidad palets";
                UNIMA := RecItem."Cantidad master";
                if UNIPAL = 0 then begin
                    UNIPAL := RecItem."Cantidad master";
                end;
                if UNICAJA = 0 then begin
                    UNICAJA := 1;
                end;
                if UNIPAL = 0 then begin
                    UNIPAL := 1;
                end;
                if UNIMA = 0 then begin
                    UNIMA := 1;
                end;

                CAJASMA := 1;
                if UNIMA <> 0 then begin
                    CAJASMA := ROUND(UNIPAL / UNIMA, 1);
                end;


                CD1 := Format(UNIMA, 6, '<integer>');
                CD2 := Format(CAJASMA, 6, '<integer>');

                TextoSalida3 := 'ARPR' + '|' +
                                'DE' + '|' +
                                RecItem."No." + '|' +
                                'MA' + '|' +
                                Format(CD1) + '|' +
                                '|' +
                                '|' +
                                '|' +
                                '|' +
                                PESO2 + '|' +
                                PESOINF + '|' +
                                PESOSUP + '|' +
                                Format(CD2) + '|' +
                                Format(CD2) + '|' +
                                '1' + '|' +
                                '|' +
                                'N|';

                OutStream.Writetext(TextoSalida3);


                CD1 := Format(UNIMA, 6, '<integer>');
                CD2 := Format(CAJASMA, 6, '<integer>');


                TextoSalida3 := 'ARPR' + '|' +
                                'AG' + '|' +
                                RecItem."No." + '|' +
                                'MA' + '|' +
                                Format(CD1) + '|' +
                                '|' +
                                '|' +
                                '|' +
                                '|' +
                                PESO2 + '|' +
                                PESOINF + '|' +
                                PESOSUP + '|' +
                                Format(CD2) + '|' +
                                Format(CD2) + '|' +
                                '1' + '|' +
                                '|' +
                                'N|';

                OutStream.Writetext(TextoSalida3);






                CODBAR := 'E13';
                LENCB := StrLen(RecItem.ean);
                if LENCB = 14 then begin
                    CODBAR := 'D14';
                end;
                if LENCB = 8 then begin
                    CODBAR := 'E8';
                end;
                if RecItem.ean <> '' then begin

                    TextoSalida4 := 'AREA' + '|' +
                                   'AG' + '|' +
                                   RecItem."No." + '|' +
                                   RecItem.ean + '|' +
                                   CODBAR + '|';
                    OutStream.Writetext(TextoSalida4);
                    if StrLen(RecItem.ean) = 12 then begin
                        TextoSalida4 := 'AREA' + '|' +
                                                  'AG' + '|' +
                                                   RecItem."No." + '|' +
                                                   '0' + RecItem.ean + '|' +
                                                   'E13|';
                        OutStream.Writetext(TextoSalida4);
                    end;
                    if StrLen(RecItem.ean) = 11 then begin
                        TextoSalida4 := 'AREA' + '|' +
                                                 'AG' + '|' +
                                                  RecItem."No." + '|' +
                                                  '00' + RecItem.ean + '|' +
                                                  'E13|';
                        OutStream.Writetext(TextoSalida4);
                    end;

                end;
                TextoSalida4 := 'AREA' + '|' +
                                   'AG' + '|' +
                                   RecItem."No." + '|' +
                                   RecItem."No." + '|' +
                                   'E13|';
                OutStream.Writetext(TextoSalida4);


                RecRefCruz.Reset;
                RecRefCruz.SetRange(RecRefCruz."Item No.", RecItem."No.");
                RecRefCruz.SetRange(RecRefCruz."Reference Type", 3);
                if RecRefCruz.FindSet then
                    repeat
                        CODBAR := 'E13';
                        LENCB := StrLen(RecRefCruz."Reference No.");
                        if LENCB = 14 then begin
                            CODBAR := 'D14';
                        end;
                        if LENCB = 8 then begin
                            CODBAR := 'E8';
                        end;
                        if RecRefCruz."Reference No." <> '' then begin
                            TextoSalida4 := 'AREA' + '|' +
                                            'AG' + '|' +
                                             RecItem."No." + '|' +
                                             RecRefCruz."Reference No." + '|' +
                                             CODBAR + '|';
                            OutStream.Writetext(TextoSalida4);
                        end;
                        if StrLen(RecRefCruz."Reference No.") = 12 then begin
                            TextoSalida4 := 'AREA' + '|' +
                                            'AG' + '|' +
                                             RecItem."No." + '|' +
                                             '0' + RecRefCruz."Reference No." + '|' +
                                             'E13|';
                            OutStream.Writetext(TextoSalida4);
                        end;
                        if StrLen(RecRefCruz."Reference No.") = 11 then begin
                            TextoSalida4 := 'AREA' + '|' +
                                            'AG' + '|' +
                                             RecItem."No." + '|' +
                                             '00' + RecRefCruz."Reference No." + '|' +
                                             'E13|';
                            OutStream.Writetext(TextoSalida4);
                        end;

                    until RecRefCruz.Next = 0;

            ///   END;
            until RecItem.Next = 0;

    end;


    procedure RECEPCIONES()
    begin




        VENTANA.Update(1, 'RECEPCIONES');

        RecCC.Reset;
        RecCC.SetRange(RecCC."Document Type", 1);
        ////RecCC.SetRange(RecCC."No.", '106209');
        if RecCC.FindSet then
            repeat
                VENTANA.Update(2, RecCC."No.");
                if RecCC."Order Date" <> 0D then begin
                    ESDIA1 := Date2dmy(RecCC."Order Date", 1);
                    ESMES1 := Date2dmy(RecCC."Order Date", 2);
                    ESAÑO1 := Date2dmy(RecCC."Order Date", 3);
                    ESMES11 := Format(ESMES1);
                    if ESMES1 = 1 then ESMES11 := '01';
                    if ESMES1 = 2 then ESMES11 := '02';
                    if ESMES1 = 3 then ESMES11 := '03';
                    if ESMES1 = 4 then ESMES11 := '04';
                    if ESMES1 = 5 then ESMES11 := '05';
                    if ESMES1 = 6 then ESMES11 := '06';
                    if ESMES1 = 7 then ESMES11 := '07';
                    if ESMES1 = 8 then ESMES11 := '08';
                    if ESMES1 = 9 then ESMES11 := '09';
                    if ESMES1 = 10 then ESMES11 := '10';
                    if ESMES1 = 11 then ESMES11 := '11';
                    if ESMES1 = 12 then ESMES11 := '12';
                    ESDIA11 := Format(ESDIA1);
                    if ESDIA1 = 1 then ESDIA11 := '01';
                    if ESDIA1 = 2 then ESDIA11 := '02';
                    if ESDIA1 = 3 then ESDIA11 := '03';
                    if ESDIA1 = 4 then ESDIA11 := '04';
                    if ESDIA1 = 5 then ESDIA11 := '05';
                    if ESDIA1 = 6 then ESDIA11 := '06';
                    if ESDIA1 = 7 then ESDIA11 := '07';
                    if ESDIA1 = 8 then ESDIA11 := '08';
                    if ESDIA1 = 9 then ESDIA11 := '09';
                    FECORD1 := Format(ESAÑO1, 4, '<integer>') + ESMES11 + ESDIA11;
                end;

                if RecCC."Expected Receipt Date" <> 0D then begin
                    ESDIA2 := Date2dmy(RecCC."Expected Receipt Date", 1);
                    ESMES2 := Date2dmy(RecCC."Expected Receipt Date", 2);
                    ESAÑO2 := Date2dmy(RecCC."Expected Receipt Date", 3);
                    ///ESMES22:=FORMAT(ESMES2);
                    if ESMES2 = 1 then ESMES22 := '01';
                    if ESMES2 = 2 then ESMES22 := '02';
                    if ESMES2 = 3 then ESMES22 := '03';
                    if ESMES2 = 4 then ESMES22 := '04';
                    if ESMES2 = 5 then ESMES22 := '05';
                    if ESMES2 = 6 then ESMES22 := '06';
                    if ESMES2 = 7 then ESMES22 := '07';
                    if ESMES2 = 8 then ESMES22 := '08';
                    if ESMES2 = 9 then ESMES22 := '09';
                    if ESMES2 = 10 then ESMES22 := '10';
                    if ESMES2 = 11 then ESMES22 := '11';
                    if ESMES2 = 12 then ESMES22 := '12';

                    ESDIA22 := Format(ESDIA2);
                    if ESDIA2 = 1 then ESDIA22 := '01';
                    if ESDIA2 = 2 then ESDIA22 := '02';
                    if ESDIA2 = 3 then ESDIA22 := '03';
                    if ESDIA2 = 4 then ESDIA22 := '04';
                    if ESDIA2 = 5 then ESDIA22 := '05';
                    if ESDIA2 = 6 then ESDIA22 := '06';
                    if ESDIA2 = 7 then ESDIA22 := '07';
                    if ESDIA2 = 8 then ESDIA22 := '08';
                    if ESDIA2 = 9 then ESDIA22 := '09';
                    FECORD2 := Format(ESAÑO2, 4, '<integer>') + ESMES22 + ESDIA22;
                end;

                TENDA := RecCC."Buy-from Vendor No.";
                TextoSalida := 'ORCA' + '|' +                                             //1
                               'AG' + '|' +                                               //2
                               RecCC."No." + '|' +                                 //3
                               '01' + '|' +                                               //4
                               TENDA + '|' +                                               //5
                               '|' +                                                       //6
                               'ENPR|' +                                                  //7
                               FECORD1 + '|' +               //8
                               FECORD2 + '|' +   //9
                               '|' +    //10
                               '|' +    //11
                               '|' +    //12
                               '|' +    //13
                               '|\r\n';    //15                              
                OutStream.Writetext(TextoSalida);

                NLIN := 0;
                RecLC.Reset;
                RecLC.SetRange(RecLC."Document Type", RecCC."Document Type");
                RecLC.SetRange(RecLC."Document No.", RecCC."No.");
                if RecLC.FindSet then
                    repeat

                        ///RecIUM.GET(RecLC."No.",RecLC."Unit of Measure Code");
                        NLIN := NLIN + 1;

                        NLINC := Format(RecLC."Line No.", 9, '<integer>');
                        CANTIPEDI := Format(RecLC.Quantity, 5, '<integer>');
                        if RecItem.Get(RecLC."No.") then begin
                            ///           IF RecItem."Peso variable"=1 THEN BEGIN
                            ///                CANTIKILO:=FORMAT(RecLC."Quantity (Base)",9,'<integer>');
                            ///           END;
                        end;
                        TextoSalida := 'ORLI' + '|' +                 //1
                                       'AG' + '|' +                   //2
                                       RecCC."No." + '|' +                //3
                                       RecLC."No." + '|' +                 //4
                                       CANTIPEDI + '|' +               //5
                                       'UD' + '|' +                   //6
                                       '1' + '|' +                    //7
                                       CANTIKILO + '|' +                           //8
                                       '|' +                          //9
                                       '|' +                          //10
                                       '|' +                          //11
                                       '|N' +                         //12
                                       '|' +                          //13
                                       NLINC + '|' +                          //14
                                       '|' +                          //15
                                       '|\r\n';                          //16

                        OutStream.Writetext(TextoSalida);

                    until RecLC.Next = 0;

            until RecCC.Next = 0;
    end;


    procedure EXPEDICIONES()
    begin





        VENTANA.Update(1, 'RECEPCIONES');

        RecCV.Reset;
        RecCV.SetRange(RecCV."Document Type", 1);
        RecCV.SetRange(RecCV."Estado pedido", 1);
        RecCV.SetRange(RecCV."Order Date", 20080501D, 20081231D);
        if RecCV.FindSet then
            repeat
                VENTANA.Update(2, RecCV."No.");
                if RecCV."Order Date" <> 0D then begin
                    ESDIA1 := Date2dmy(RecCV."Order Date", 1);
                    ESMES1 := Date2dmy(RecCV."Order Date", 2);
                    ESAÑO1 := Date2dmy(RecCV."Order Date", 3);
                    ESMES11 := Format(ESMES1);
                    if ESMES1 = 1 then ESMES11 := '01';
                    if ESMES1 = 2 then ESMES11 := '02';
                    if ESMES1 = 3 then ESMES11 := '03';
                    if ESMES1 = 4 then ESMES11 := '04';
                    if ESMES1 = 5 then ESMES11 := '05';
                    if ESMES1 = 6 then ESMES11 := '06';
                    if ESMES1 = 7 then ESMES11 := '07';
                    if ESMES1 = 8 then ESMES11 := '08';
                    if ESMES1 = 9 then ESMES11 := '09';
                    if ESMES1 = 10 then ESMES11 := '10';
                    if ESMES1 = 11 then ESMES11 := '11';
                    if ESMES1 = 12 then ESMES11 := '12';
                    ESDIA11 := Format(ESDIA1);
                    if ESDIA1 = 1 then ESDIA11 := '01';
                    if ESDIA1 = 2 then ESDIA11 := '02';
                    if ESDIA1 = 3 then ESDIA11 := '03';
                    if ESDIA1 = 4 then ESDIA11 := '04';
                    if ESDIA1 = 5 then ESDIA11 := '05';
                    if ESDIA1 = 6 then ESDIA11 := '06';
                    if ESDIA1 = 7 then ESDIA11 := '07';
                    if ESDIA1 = 8 then ESDIA11 := '08';
                    if ESDIA1 = 9 then ESDIA11 := '09';
                    FECORD1 := Format(ESAÑO1, 4, '<integer>') + ESMES11 + ESDIA11;
                end;

                FECORD2 := FECORD1;

                TextoSalida := 'OECA' + '|' +
                               'AG' + '|' +
                               RecCV."No." + '|' +
                               '01' + '|' +
                               RecCV."Sell-to Customer No." + '|' +
                               '|' +
                               'PED|' +
                               '|' +
                               '|' +
                               FECORD1 + '|' +
                               FECORD1 + '|' +
                               HH + MI + '|' +
                               'N|' +
                               '|||||';
                OutStream.Writetext(TextoSalida);





                NLIN := 0;
                RecLV.Reset;
                RecLV.SetRange(RecLV."Document Type", RecCV."Document Type");
                RecLV.SetRange(RecLV."Document No.", RecCV."No.");
                if RecLV.FindSet then
                    repeat
                        if RecItem2.Get(RecLV."No.") then begin

                            ///RecIUM.GET(RecLV."No.",RecLV."Unit of Measure Code");

                            NLINC := Format(RecLV."Line No.", 6, '<integer>');
                            CANTIDADTRAS := Format(RecLV.Quantity, 6, '<integer>');
                            PRECIO := Format(RecLV."Unit Price", 6, '<integer>');
                            KILOSTRAS := '';

                            TextoSalida := 'OELI' + '|' +
                                           'AG' + '|' +
                                           RecCV."No." + '|' +
                                           NLINC + '|' +
                                           RecLV."No." + '|' +
                                           CANTIDADTRAS + '|' +
                                           'UD' + '|' +
                                           '1' + '|' +
                                           '' + '|' +
                                           '' + '||||';
                            OutStream.Writetext(TextoSalida);

                        end;
                    until RecLV.Next = 0;

            until RecCV.Next = 0;
    end;


    procedure ENVIARRECEP()
    begin





        /// Exportación a ADAIA RECEPCIONES

        RECEPCIONES;
        RecCE.Get;
        RUTA := RecCE."Ruta salida de_gestion";
        TIPO := 3;
        BUSCAEXTENSION;
        DAT2 := 'TRRECORD.' + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure ENVIAREXPE()
    begin




        /// Exportación a ADAIA EXPEDICIONES

        EXPEDICIONES;
        RecCE.Get;
        RUTA := RecCE."Ruta salida de_gestion";
        TIPO := 3;
        BUSCAEXTENSION;

        DAT2 := 'TREXPORD.' + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure ENVIARUTAS()
    begin




        /// Exportación a ADAIA TODOS LAS RUTAS

        RUTAS;
        RecCE.Get;
        RUTA := RecCE."Ruta salida de_gestion";
        TIPO := 3;
        BUSCAEXTENSION;
        DAT2 := 'TRRUTA.' + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure RUTAS()
    begin









        VENTANA.Update(1, 'RUTAS');
        Recterri.Reset;
        if Recterri.FindSet then
            repeat
                if Recterri.Code <> '' then begin
                    VENTANA.Update(2, Recterri.Code);

                    TextoSalida3 := 'RUCA' + '|' +       //1
                                    'AG' + '|' +       //2
                                    Format(Recterri.Code) + '|' +  //3
                                    'RR|';   //4                                    
                    OutStream.Writetext(TextoSalida3);

                    Clie.Init;
                    Clie.Reset;
                    Clie.SetRange(Clie."Territory Code", Recterri.Code);
                    if Clie.FindSet then
                        repeat
                            if Clie."No." <> '' then begin
                                VENTANA.Update(2, Clie."No.");
                                TextoSalida3 := 'RULI' + '|' +       //1
                                                'AG' + '|' +       //2
                                                Format(Clie."Territory Code") + '|' +  //3
                                                Format(Clie."No.") + '|' +   //4
                                                'CLI||';  //5                                    
                                OutStream.Writetext(TextoSalida3);

                            end;
                        until Clie.Next = 0;


                end;

            until Recterri.Next = 0;
    end;


    procedure ENVIATERCEROSMODIF()
    begin



        /// Exportación a ADAIA TODOS LOS TERCEROS

        TERCEROSMODIF;
        RecCE.Get;
        RUTA := RecCE."Ruta salida de_gestion";
        TIPO := 3;
        BUSCAEXTENSION;
        DAT2 := 'TRTER.' + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure ENVIAARTICULOSMODIF()
    begin



        /// Exportación a ADAIA TODOS LOS ARTICULOS

        ARTICULOSMODIF;
        RecCE.Get;
        TIPO := 3;
        BUSCAEXTENSION;
        DAT2 := 'TRART.' + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);


        DAT2 := 'TRARPR.' + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);



        DAT2 := 'TRAREA.' + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure TERCEROSMODIF()
    begin




        VENTANA.Update(1, 'TERCEROS');
        Clie.Init;
        Clie.Reset;
        if Clie.FindSet then
            repeat
                VENTANA.Update(2, Clie."No.");
                DESNOM := ConvertStr(CopyStr(Clie.Name, 1, 30), 'ª', '.');
                DESNOM := ConvertStr(DESNOM, 'º', '.');
                DESNOM2 := ConvertStr(CopyStr(Clie."Search Name", 1, 30), 'ª', '.');
                DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
                DESNOM3 := ConvertStr(CopyStr(Clie.Address, 1, 30), 'ª', '.');
                DESNOM3 := ConvertStr(DESNOM3, 'º', '.');
                DESNOM4 := ConvertStr(CopyStr(Clie.City, 1, 30), 'ª', '.');
                DESNOM4 := ConvertStr(DESNOM4, 'º', '.');
                TIPOPA := '';
                RC := '';

                TextoSalida4 := 'TE' + '|' +       //1
                                'AG' + '|' +       //2
                                Format(Clie."No.") + '|' +  //3
                                Format(DESNOM, 40) + '|' +   //4
                                Format(Clie."No.") + '|' +  //5
                                Format(DESNOM2, 12) + '|' +   //6
                                'CLI' + '|' +               //7
                                Format(DESNOM3, 40) + '|' +  //8
                                Format(DESNOM4, 40) + '|' +  //9
                                 '|' +  //10
                                 '|' +  //11
                                Format(Clie."Post Code", 6) + '|' + //12
                                Format(Clie.County, 4) + '|' +  //13
                                'N|' +                           //14
                                '|' +                     //15
                                '|' +                     //16
                                '|' +                     //17
                                '|' +                     //18
                                '|' +                      //19
                                '|';                   //20                                    
                OutStream.Writetext(TextoSalida4);
                Clie.Modify;

            until Clie.Next = 0;

        Clie.Init;
        Clie.Reset;
        if Clie.FindSet then
            repeat
                VENTANA.Update(2, Clie."No.");
                DESNOM := ConvertStr(CopyStr(Clie.Name, 1, 30), 'ª', '.');
                DESNOM := ConvertStr(DESNOM, 'º', '.');
                DESNOM2 := ConvertStr(CopyStr(Clie."Search Name", 1, 30), 'ª', '.');
                DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
                DESNOM3 := ConvertStr(CopyStr(Clie.Address, 1, 30), 'ª', '.');
                DESNOM3 := ConvertStr(DESNOM3, 'º', '.');
                DESNOM4 := ConvertStr(CopyStr(Clie.City, 1, 30), 'ª', '.');
                DESNOM4 := ConvertStr(DESNOM4, 'º', '.');
                TIPOPA := '';
                RC := '';

                TextoSalida4 := 'TE' + '|' +       //1
                                'MO' + '|' +       //2
                                Format(Clie."No.") + '|' +  //3
                                Format(DESNOM, 40) + '|' +   //4
                                Format(Clie."No.") + '|' +  //5
                                Format(DESNOM2, 12) + '|' +   //6
                                'CLI' + '|' +               //7
                                Format(DESNOM3, 40) + '|' +  //8
                                Format(DESNOM4, 40) + '|' +  //9
                                 '|' +  //10
                                 '|' +  //11
                                Format(Clie."Post Code", 6) + '|' + //12
                                Format(Clie.County, 4) + '|' +  //13
                                'N|' +                           //14
                                '|' +                     //15
                                '|' +                     //16
                                '|' +                     //17
                                '|' +                     //18
                                '|' +                      //19
                                '|';                   //20                                    
                OutStream.Writetext(TextoSalida4);
                Clie.Modify;

            until Clie.Next = 0;



        Prov.Init;
        Prov.Reset;
        if Prov.FindSet then
            repeat
                VENTANA.Update(2, Prov."No.");
                DESNOM := ConvertStr(CopyStr(Prov.Name, 1, 30), 'ª', '.');
                DESNOM := ConvertStr(DESNOM, 'º', '.');
                DESNOM2 := ConvertStr(CopyStr(Prov."Search Name", 1, 30), 'ª', '.');
                DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
                DESNOM3 := ConvertStr(CopyStr(Prov.Address, 1, 30), 'ª', '.');
                DESNOM3 := ConvertStr(DESNOM3, 'º', '.');
                DESNOM4 := ConvertStr(CopyStr(Prov.City, 1, 30), 'ª', '.');
                DESNOM4 := ConvertStr(DESNOM4, 'º', '.');
                TextoSalida4 := 'TE' + '|' +       //1
                                'AG' + '|' +       //2
                                Format(Prov."No.") + '|' +  //3
                                Format(DESNOM, 40) + '|' +   //4
                                Format(Prov."No.") + '|' +  //5
                                Format(DESNOM2, 12) + '|' +   //6
                                'PRO' + '|' +               //7
                                Format(DESNOM3, 40) + '|' +  //8
                                Format(DESNOM4, 40) + '|' +  //9
                                 '|' +  //10
                                 '|' +  //11
                                Format(Prov."Post Code", 6) + '|' + //12
                                Format(Prov.County, 4) + '|' +  //13
                                'N|' +                           //14
                                '|' +                     //15
                                '|' +                     //16
                                '|' +                     //17
                                '|' +                     //18
                                '|' +                      //19
                                '|';                   //20                                    
                OutStream.Writetext(TextoSalida4);
                Prov.Modify;

            until Prov.Next = 0;

        Prov.Init;
        Prov.Reset;
        if Prov.FindSet then
            repeat
                VENTANA.Update(2, Prov."No.");
                DESNOM := ConvertStr(CopyStr(Prov.Name, 1, 30), 'ª', '.');
                DESNOM := ConvertStr(DESNOM, 'º', '.');
                DESNOM2 := ConvertStr(CopyStr(Prov."Search Name", 1, 30), 'ª', '.');
                DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
                DESNOM3 := ConvertStr(CopyStr(Prov.Address, 1, 30), 'ª', '.');
                DESNOM3 := ConvertStr(DESNOM3, 'º', '.');
                DESNOM4 := ConvertStr(CopyStr(Prov.City, 1, 30), 'ª', '.');
                DESNOM4 := ConvertStr(DESNOM4, 'º', '.');
                TextoSalida4 := 'TE' + '|' +       //1
                                'MO' + '|' +       //2
                                Format(Prov."No.") + '|' +  //3
                                Format(DESNOM, 40) + '|' +   //4
                                Format(Prov."No.") + '|' +  //5
                                Format(DESNOM2, 12) + '|' +   //6
                                'PRO' + '|' +               //7
                                Format(DESNOM3, 40) + '|' +  //8
                                Format(DESNOM4, 40) + '|' +  //9
                                 '|' +  //10
                                 '|' +  //11
                                Format(Prov."Post Code", 6) + '|' + //12
                                Format(Prov.County, 4) + '|' +  //13
                                'N|' +                           //14
                                '|' +                     //15
                                '|' +                     //16
                                '|' +                     //17
                                '|' +                     //18
                                '|' +                      //19
                                '|';                   //20


                OutStream.Writetext(TextoSalida4);
                Prov.Modify;
            until Prov.Next = 0;


        Recterri.Reset;
        if Recterri.FindSet then
            repeat
                VENTANA.Update(2, Recterri.Code);
                TextoSalida4 := 'TE' + '|' +       //1
                                'AG' + '|' +       //2
                                Format(Recterri.Code) + '|' +  //3
                                Format(Recterri.Name, 40) + '|' +   //4
                                '|' +  //5
                                '|' +   //6
                                'RR' + '|' +               //7
                                '|' +  //8
                                '|' +  //9
                                 '|' +  //10
                                 '|' +  //11
                                 '|' + //12
                                 '|' +  //13
                                'N|' +                           //14
                                '|' +                     //15
                                '|' +                     //16
                                '|' +                     //17
                                '|' +                     //18
                                '|' +                      //19
                                '|';                   //20


                OutStream.Writetext(TextoSalida4);
                Recterri.Modify;
            until Recterri.Next = 0;
    end;


    procedure ARTICULOSMODIF()
    begin






        VENTANA.Update(1, 'ARTICULOS');
        RecItem.Reset;
        if RecItem.FindSet then
            repeat
                VENTANA.Update(2, RecItem."No.");
                PESO := 'N';
                UNI1 := 'CJA';
                UNI2 := 'CJA';
                UNI3 := 'CJA';
                DESNOM1 := CopyStr(RecItem.Description, 1, 40);
                CODI := Format(RecItem."No.", 16);
                CODI := ConvertStr(CODI, ' ', ' ');
                CONTROLAEA := 'S';
                TextoSalida := 'AR' + '|' +
                                  'AG' + '|' +
                                 RecItem."No." + '|' +
                             Format(DESNOM1, 40) + '|' +
                             RecItem."No." + '|' +
                             Format(CRITERIO, 4) + '|' +
                             Format('     ', 5) + '|' +
                             '|' +
                             Format('', 5) + '|' +
                             'N' + '|' +
                             PESO + '|' +
                             CONTROLAEA + '|' +
                             'UD' + '|' +
                             Format(UNI1, 4) + '|' +
                             Format(UNI2, 4) + '|' +
                             Format(UNI3, 4) + '|' +
                             'N' + '|' +
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
                             '|' +
                             '|' +
                             '|' +
                             '|';


                OutStream.Writetext(TextoSalida);



            until RecItem.Next = 0;


        RecItem.Reset;
        if RecItem.FindSet then
            repeat
                VENTANA.Update(2, RecItem."No.");
                PESO := 'N';
                UNI1 := 'CJA';
                UNI2 := 'CJA';
                UNI3 := 'CJA';
                DESNOM1 := ConvertStr(RecItem.Description, 'ª', '.');
                DESNOM1 := ConvertStr(DESNOM1, 'º', '.');
                DESNOM2 := ConvertStr(RecItem."Search Description", 'ª', '.');
                DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
                CODI := Format(RecItem."No.", 16);
                CODI := ConvertStr(CODI, ' ', ' ');
                CONTROLAEA := 'S';
                TextoSalida := 'AR' + '|' +
                                  'MO' + '|' +
                                 RecItem."No." + '|' +
                                 Format(DESNOM1 + ' ' + DESNOM2 + ' ' + DESNOM3, 40) + '|' +
                             RecItem."No." + '|' +
                             Format(CRITERIO, 4) + '|' +
                             Format('     ', 5) + '|' +
                             '|' +
                             Format('', 5) + '|' +
                             'N' + '|' +
                             PESO + '|' +
                             CONTROLAEA + '|' +
                             'UD' + '|' +
                             Format(UNI1, 4) + '|' +
                             Format(UNI2, 4) + '|' +
                             Format(UNI3, 4) + '|' +
                             'N' + '|' +
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
                             '|' +
                             '|' +
                             '|' +
                             '|';



                OutStream.Writetext(TextoSalida);






                PESO2 := '';
                PESOINF := '';
                PESOSUP := '';
                if RecItem2."Base Unit of Measure" = 'KGM' then begin
                    PESO2 := Format(RecIUM."Qty. per Unit of Measure" * 1000, 5, '<integer>');
                    PESOINF := Format((RecIUM."Qty. per Unit of Measure" * 1000) -
                    (RecIUM."Qty. per Unit of Measure" * 1000 * 50 / 100), 5, '<integer>');
                    PESOSUP := Format((RecIUM."Qty. per Unit of Measure" * 1000) + -
                    (RecIUM."Qty. per Unit of Measure" * 1000 * 50 / 100), 5, '<integer>');
                end;


            until RecItem.Next = 0;
    end;


    procedure ALTACLIENTES(var RecCust: Record Customer)
    begin



        TempBlob.CreateOutStream(OutStream);





        DESNOM := ConvertStr(CopyStr(RecCust.Name, 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM2 := ConvertStr(CopyStr(RecCust."Search Name", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM3 := ConvertStr(CopyStr(RecCust.Address, 1, 30), 'ª', '.');
        DESNOM3 := ConvertStr(DESNOM3, 'º', '.');
        DESNOM4 := ConvertStr(CopyStr(RecCust.City, 1, 30), 'ª', '.');
        DESNOM4 := ConvertStr(DESNOM4, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
        DESNOM3 := CASCII.Ascii2Ansi(DESNOM3);
        DESNOM4 := CASCII.Ascii2Ansi(DESNOM4);

        TIPOPA := '';
        RC := '';

        TextoSalida4 := 'TE' + '|' +       //1
                        'AG' + '|' +       //2
                        Format(RecCust."No.") + '|' +  //3
                        Format(DESNOM, 40) + '|' +   //4
                        Format(RecCust."No.") + '|' +  //5
                        Format(DESNOM2, 12) + '|' +   //6
                        'CLI' + '|' +               //7
                        Format(DESNOM3, 40) + '|' +  //8
                        Format(DESNOM4, 40) + '|' +  //9
                         '|' +  //10
                         '|' +  //11
                        Format(RecCust."Post Code", 6) + '|' + //12
                        Format(RecCust.County, 4) + '|' +  //13
                        'N|' +                           //14
                        '|' +                     //15
                        '|' +                     //16
                        '|' +                     //17
                        '|' +                     //18
                        '|' +                      //19
                        '|';                   //20

        OutStream.Writetext(TextoSalida4);


        RecCE.Get;
        RUTA := RecCE."Ruta salida de_gestion";
        TIPO := 3;
        BUSCAEXTENSION;
        DAT2 := 'TRTER.' + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure MODIFCLIENTES(var RecCust: Record Customer)
    begin

        RecCE.Get;
        TempBlob.CreateOutStream(OutStream);

        DESNOM := ConvertStr(CopyStr(RecCust.Name, 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM2 := ConvertStr(CopyStr(RecCust."Search Name", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM3 := ConvertStr(CopyStr(RecCust.Address, 1, 30), 'ª', '.');
        DESNOM3 := ConvertStr(DESNOM3, 'º', '.');
        DESNOM4 := ConvertStr(CopyStr(RecCust.City, 1, 30), 'ª', '.');
        DESNOM4 := ConvertStr(DESNOM4, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
        DESNOM3 := CASCII.Ascii2Ansi(DESNOM3);
        DESNOM4 := CASCII.Ascii2Ansi(DESNOM4);

        TIPOPA := '';
        RC := '';

        TextoSalida4 := 'TE' + '|' +       //1
                        'AG' + '|' +       //2
                        Format(RecCust."No.") + '|' +  //3
                        Format(DESNOM, 40) + '|' +   //4
                        Format(RecCust."No.") + '|' +  //5
                        Format(DESNOM2, 12) + '|' +   //6
                        'CLI' + '|' +               //7
                        Format(DESNOM3, 40) + '|' +  //8
                        Format(DESNOM4, 40) + '|' +  //9
                         '|' +  //10
                         '|' +  //11
                        Format(RecCust."Post Code", 6) + '|' + //12
                        Format(RecCust.County, 4) + '|' +  //13
                        'N|' +                           //14
                        '|' +                     //15
                        '|' +                     //16
                        '|' +                     //17
                        '|' +                     //18
                        '|' +                      //19
                        '|';                   //20                                    
        OutStream.Writetext(TextoSalida4);


        TextoSalida4 := 'TE' + '|' +       //1
                        'MO' + '|' +       //2
                        Format(RecCust."No.") + '|' +  //3
                        Format(DESNOM, 40) + '|' +   //4
                        Format(RecCust."No.") + '|' +  //5
                        Format(DESNOM2, 12) + '|' +   //6
                        'CLI' + '|' +               //7
                        Format(DESNOM3, 40) + '|' +  //8
                        Format(DESNOM4, 40) + '|' +  //9
                         '|' +  //10
                         '|' +  //11
                        Format(RecCust."Post Code", 6) + '|' + //12
                        Format(RecCust.County, 4) + '|' +  //13
                        'N|' +                           //14
                        '|' +                     //15
                        '|' +                     //16
                        '|' +                     //17
                        '|' +                     //18
                        '|' +                      //19
                        '|';                   //20                                    
        OutStream.Writetext(TextoSalida4);




        TIPO := 3;

        RUTA := '';
        ADAIA.Reset();
        ADAIA.SetRange(texto, 'ADAIA-RUTA SALIDA DE_GESTION');
        IF ADAIA.FindSet() THEN begin
            RUTA := ADAIA.Ruta;
        end;
        BUSCAEXTENSION;
        DAT2 := 'TRTER.' + EXTEN + Format(ALEA) + Format(RecCust."No.") + Format(LOGCAMBIOA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure TRARUB()
    begin







        ///RecI.SETRANGE(RecI."No.",'AC01070');
        if RecI.FindSet then
            repeat

                if RecI."Vendor No." <> 'P00020' then begin

                    if RecI."Producto almacenable" then begin



                        UBIPICDIN := 'N';
                        PICCOMPAR := 'S';
                        //IF RecI."Tipo de Picking"=1 THEN BEGIN
                        UBIPICDIN := 'S';
                        PICCOMPAR := 'N';
                        ///END;

                        if COMPANYNAME = 'PEPE' then begin
                            ///IF RecI."Zona picking"=1 THEN BEGIN
                            UBIPICDIN := 'S';
                            ///END;
                        end;


                        UBIPIC := '';
                        ///IF RecI."Ubicacion picking."<>'' THEN BEGIN
                        ///UBIPIC:=RecI."Ubicacion picking.";
                        ///END;
                        UBIREF := '';
                        ///IF RecI."Ubicacion ref."<>'' THEN BEGIN
                        //  UBIREF:=RecI."Ubicacion ref.";
                        ///END;


                        TextoSalida5 := 'ARUB' + '|' +
                                  'MO' + '|' +
                                 RecI."No." + '|' +
                             '01|' +
                             'GRAL||GRAL|' +
                             UBIPICDIN + '||' +
                             'E130' +
                             '|1|9|S||||||' +
                             PICCOMPAR + '|||GRAL|100|C|||||||||||';
                        if COMPANYNAME = 'PEPE' then begin
                            TextoSalida5 := 'ARUB' + '|' +
                                  'AG' + '|' +
                                 RecI."No." + '|' +
                             '01|' +
                             ///FORMAT(RecI."Zona almacenaje")+'|'+
                             //UBIREF+'|'+FORMAT(RecI."Zona picking")+'|'+
                             UBIPICDIN + '|' +
                             UBIPIC + '|' +
                             'E130' +
                             '|1|9|S||||||' +
                             PICCOMPAR + '|||' + Format(4) + '|100|C|||||||||||';



                        end;
                        OutStream.Writetext(TextoSalida5);




                    end;
                end;
            until RecI.Next = 0;


        contaser := CUNext.GetNextNo('DEGESTION', Today, true);


        RecCE.Get;
        RUTA := RecCE."Ruta salida de_gestion";
        TIPO := 3;
        BUSCAEXTENSION;
        DAT2 := 'TRARUB.' + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure ALTAPROVEE(var Rec1: Record Vendor)
    begin

        TempBlob.CreateOutStream(OutStream);

        DESNOM := ConvertStr(CopyStr(Rec1.Name, 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM2 := ConvertStr(CopyStr(Rec1."Search Name", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM3 := ConvertStr(CopyStr(Rec1.Address, 1, 30), 'ª', '.');
        DESNOM3 := ConvertStr(DESNOM3, 'º', '.');
        DESNOM4 := ConvertStr(CopyStr(Rec1.City, 1, 30), 'ª', '.');
        DESNOM4 := ConvertStr(DESNOM4, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
        DESNOM3 := CASCII.Ascii2Ansi(DESNOM3);
        DESNOM4 := CASCII.Ascii2Ansi(DESNOM4);

        TIPOPA := '';
        RC := '';

        TextoSalida4 := 'TE' + '|' +       //1
                        'AG' + '|' +       //2
                        Format(Rec1."No.") + '|' +  //3
                        Format(DESNOM, 40) + '|' +   //4
                        Format(Rec1."No.") + '|' +  //5
                        Format(DESNOM2, 12) + '|' +   //6
                        'PRO' + '|' +               //7
                        Format(DESNOM3, 40) + '|' +  //8
                        Format(DESNOM4, 40) + '|' +  //9
                         '|' +  //10
                         '|' +  //11
                        Format(Rec1."Post Code", 6) + '|' + //12
                        Format(Rec1.County, 4) + '|' +  //13
                        'N|' +                           //14
                        '|' +                     //15
                        '|' +                     //16
                        '|' +                     //17
                        '|' +                     //18
                        '|' +                      //19
                        '|';                   //20
        OutStream.Writetext(TextoSalida4);


        RecCE.Get;
        RUTA := RecCE."Ruta salida de_gestion";
        TIPO := 3;
        BUSCAEXTENSION;
        DAT2 := 'TRTER.' + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure MODIFPROVEE(var Rec1: Record Vendor)
    begin


        RecCE.Get;
        TempBlob.CreateOutStream(OutStream);



        DESNOM := ConvertStr(CopyStr(Rec1.Name, 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM2 := ConvertStr(CopyStr(Rec1."Search Name", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM3 := ConvertStr(CopyStr(Rec1.Address, 1, 30), 'ª', '.');
        DESNOM3 := ConvertStr(DESNOM3, 'º', '.');
        DESNOM4 := ConvertStr(CopyStr(Rec1.City, 1, 30), 'ª', '.');
        DESNOM4 := ConvertStr(DESNOM4, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
        DESNOM3 := CASCII.Ascii2Ansi(DESNOM3);
        DESNOM4 := CASCII.Ascii2Ansi(DESNOM4);

        TIPOPA := '';
        RC := '';
        TextoSalida4 := 'TE' + '|' +       //1
                        'AG' + '|' +       //2
                        Format(Rec1."No.") + '|' +  //3
                        Format(DESNOM, 40) + '|' +   //4
                        Format(Rec1."No.") + '|' +  //5
                        Format(DESNOM2, 12) + '|' +   //6
                        'PRO' + '|' +               //7
                        Format(DESNOM3, 40) + '|' +  //8
                        Format(DESNOM4, 40) + '|' +  //9
                         '|' +  //10
                         '|' +  //11
                        Format(Rec1."Post Code", 6) + '|' + //12
                        Format(Rec1.County, 4) + '|' +  //13
                        'N|' +                           //14
                        '|' +                     //15
                        '|' +                     //16
                        '|' +                     //17
                        '|' +                     //18
                        '|' +                      //19
                        '|';                   //20

        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := 'TE' + '|' +       //1
                        'MO' + '|' +       //2
                        Format(Rec1."No.") + '|' +  //3
                        Format(DESNOM, 40) + '|' +   //4
                        Format(Rec1."No.") + '|' +  //5
                        Format(DESNOM2, 12) + '|' +   //6
                        'PRO' + '|' +               //7
                        Format(DESNOM3, 40) + '|' +  //8
                        Format(DESNOM4, 40) + '|' +  //9
                         '|' +  //10
                         '|' +  //11
                        Format(Rec1."Post Code", 6) + '|' + //12
                        Format(Rec1.County, 4) + '|' +  //13
                        'N|' +                           //14
                        '|' +                     //15
                        '|' +                     //16
                        '|' +                     //17
                        '|' +                     //18
                        '|' +                      //19
                        '|';                   //20

        OutStream.Writetext(TextoSalida4);



        ADAIA.Reset();
        ADAIA.SetRange(texto, 'ADAIA-RUTA SALIDA DE_GESTION');
        IF ADAIA.FindSet() THEN begin
            RUTA := ADAIA.Ruta;
        end;
        BUSCAEXTENSION;
        DAT2 := 'TRTER.' + EXTEN + Format(ALEA) + Format(Rec1."No.") + Format(LOGCAMBIOA);

        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);




    end;


    procedure ALTAPROD(var RecI: Record Item)
    begin








        if RecI."Producto almacenable" then begin
            PESO := 'N';
            UNI1 := 'UD';
            UNI2 := 'UD';
            UNI3 := 'UD';
            DESNOM := ConvertStr(CopyStr(RecI.Description, 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM2 := ConvertStr(CopyStr(RecI."Description 2", 1, 30), 'ª', '.');
            DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
            DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
            CODI := Format(RecI."No.", 16);
            CODI := ConvertStr(CODI, ' ', ' ');
            CONTROLAEA := 'N';
            CRITERIO := RecI."Criterio rotacion";
            TextoSalida := 'AR' + '|' +
                           'AG' + '|' +
                          RecI."No." + '|' +
                      Format(DESNOM + ' ' + DESNOM2, 40) + '|' +
                      RecI."No." + '|' +
                      Format(CRITERIO, 4) + '|' +
                      Format(DDD1, 5) + '|' +
                      Format(DDD2, 5) + '|' +
                      Format(DDD3, 5) + '|' +
                      'N' + '|' +
                      PESO + '|' +
                      CONTROLAEA + '|' +
                      'UD' + '|' +
                      Format('MA', 4) + '|' +
                      Format('UD', 4) + '|' +
                      Format('UD', 4) + '|' +
                      'N' + '|' +
                      'HAGEN|' +
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
                      '|' +
                      '|' +
                      '|';

            OutStream.Writetext(TextoSalida);




            UNICAJA := RecI."Cantidad inner";
            UNIPAL := RecI."Cantidad palets";
            if UNIPAL = 0 then begin
                UNIPAL := RecI."Cantidad master";
            end;
            if UNICAJA = 0 then begin
                UNICAJA := 1;
            end;
            if UNIPAL = 0 then begin
                UNIPAL := 1;
            end;

            CAJASPAL := 1;
            if UNICAJA <> 0 then begin
                CAJASPAL := ROUND(UNIPAL / UNICAJA, 1);
            end;

            CD1 := Format(UNIPAL, 6, '<integer>');

            TextoSalida3 := 'ARPR' + '|' +
                            'DE' + '|' +
                            RecI."No." + '|' +
                            'UD' + '|' +
                            '1' + '|' +
                            '|' +
                            '|' +
                            '|' +
                            '|' +
                            PESO2 + '|' +
                            PESOINF + '|' +
                            PESOSUP + '|' +
                            Format(CD1) + '|' +
                            Format(CD1) + '|' +
                            '1' + '|' +
                            '|' +
                            'N|';
            OutStream.Writetext(TextoSalida3);

            TextoSalida3 := 'ARPR' + '|' +
                            'AG' + '|' +
                            RecI."No." + '|' +
                            'UD' + '|' +
                            '1' + '|' +
                            '|' +
                            '|' +
                            '|' +
                            '|' +
                            PESO2 + '|' +
                            PESOINF + '|' +
                            PESOSUP + '|' +
                            Format(CD1) + '|' +
                            Format(CD1) + '|' +
                            '1' + '|' +
                            '|' +
                            'N|';
            OutStream.Writetext(TextoSalida3);

            CD1 := Format(UNICAJA, 6, '<integer>');
            CD2 := Format(CAJASPAL, 6, '<integer>');
            TextoSalida3 := 'ARPR' + '|' +
                            'DE' + '|' +
                            RecI."No." + '|' +
                            'CJ' + '|' +
                            Format(CD1) + '|' +
                            '|' +
                            '|' +
                            '|' +
                            '|' +
                            PESO2 + '|' +
                            PESOINF + '|' +
                            PESOSUP + '|' +
                            Format(CD2) + '|' +
                            Format(CD2) + '|' +
                            '1' + '|' +
                            '|' +
                            'N|';
            OutStream.Writetext(TextoSalida3);

            CD1 := Format(UNIPAL, 6, '<integer>');

            TextoSalida3 := 'ARPR' + '|' +
                            'AG' + '|' +
                            RecI."No." + '|' +
                            'UD' + '|' +
                            '1' + '|' +
                            '|' +
                            '|' +
                            '|' +
                            '|' +
                            PESO2 + '|' +
                            PESOINF + '|' +
                            PESOSUP + '|' +
                            Format(CD1) + '|' +
                            Format(CD1) + '|' +
                            '1' + '|' +
                            '|' +
                            'N|';

            CD1 := Format(UNICAJA, 6, '<integer>');
            CD2 := Format(CAJASPAL, 6, '<integer>');
            TextoSalida3 := 'ARPR' + '|' +
                            'AG' + '|' +
                            RecI."No." + '|' +
                            'CJ' + '|' +
                            Format(CD1) + '|' +
                            '|' +
                            '|' +
                            '|' +
                            '|' +
                            PESO2 + '|' +
                            PESOINF + '|' +
                            PESOSUP + '|' +
                            Format(CD2) + '|' +
                            Format(CD2) + '|' +
                            '1' + '|' +
                            '|' +
                            'N|';
            OutStream.Writetext(TextoSalida3);


            UNICAJA := RecI."Cantidad inner";
            UNIPAL := RecI."Cantidad palets";
            UNIMA := RecI."Cantidad master";
            if UNIPAL = 0 then begin
                UNIPAL := RecI."Cantidad master";
            end;
            if UNICAJA = 0 then begin
                UNICAJA := 1;
            end;
            if UNIPAL = 0 then begin
                UNIPAL := 1;
            end;
            if UNIMA = 0 then begin
                UNIMA := 1;
            end;

            CAJASMA := 1;
            if UNIMA <> 0 then begin
                CAJASMA := ROUND(UNIPAL / UNIMA, 1);
            end;


            CD1 := Format(UNIMA, 6, '<integer>');
            CD2 := Format(CAJASMA, 6, '<integer>');

            TextoSalida3 := 'ARPR' + '|' +
                            'DE' + '|' +
                            RecI."No." + '|' +
                            'MA' + '|' +
                            Format(CD1) + '|' +
                            '|' +
                            '|' +
                            '|' +
                            '|' +
                            PESO2 + '|' +
                            PESOINF + '|' +
                            PESOSUP + '|' +
                            Format(CD2) + '|' +
                            Format(CD2) + '|' +
                            '1' + '|' +
                            '|' +
                            'N|';
            OutStream.Writetext(TextoSalida3);


            CD1 := Format(UNIMA, 6, '<integer>');
            CD2 := Format(CAJASMA, 6, '<integer>');


            TextoSalida3 := 'ARPR' + '|' +
                            'AG' + '|' +
                            RecI."No." + '|' +
                            'MA' + '|' +
                            Format(CD1) + '|' +
                            '|' +
                            '|' +
                            '|' +
                            '|' +
                            PESO2 + '|' +
                            PESOINF + '|' +
                            PESOSUP + '|' +
                            Format(CD2) + '|' +
                            Format(CD2) + '|' +
                            '1' + '|' +
                            '|' +
                            'N|';
            OutStream.Writetext(TextoSalida3);






            CODBAR := 'E13';
            LENCB := StrLen(RecI.ean);
            if LENCB = 14 then begin
                CODBAR := 'D14';
            end;
            if LENCB = 8 then begin
                CODBAR := 'E8';
            end;
            if RecI.ean <> '' then begin

                TextoSalida4 := 'AREA' + '|' +
                           'AG' + '|' +
                           RecI."No." + '|' +
                           RecI.ean + '|' +
                           CODBAR + '|';

                OutStream.Writetext(TextoSalida4);
            end;

            if StrLen(RecItem.ean) = 12 then begin
                TextoSalida4 := 'AREA' + '|' +
                               'AG' + '|' +
                                RecI."No." + '|' +
                                '0' + RecI.ean + '|' +
                                'E13|';
                OutStream.Writetext(TextoSalida4);
            end;
            if StrLen(RecItem.ean) = 11 then begin
                TextoSalida4 := 'AREA' + '|' +
                              'AG' + '|' +
                               RecI."No." + '|' +
                               '00' + RecI.ean + '|' +
                               'E13|';
                OutStream.Writetext(TextoSalida4);
            end;

            TextoSalida4 := 'AREA' + '|' +
                       'AG' + '|' +
                       RecI."No." + '|' +
                       RecI."No." + '|' +
                       'E13|';

            OutStream.Writetext(TextoSalida4);

            RecRefCruz.Reset;
            RecRefCruz.SetRange(RecRefCruz."Item No.", RecI."No.");
            RecRefCruz.SetRange(RecRefCruz."Reference Type", 3);
            if RecRefCruz.FindSet then
                repeat
                    CODBAR := 'E13';
                    LENCB := StrLen(RecRefCruz."Reference No.");
                    if LENCB = 14 then begin
                        CODBAR := 'D14';
                    end;
                    if LENCB = 8 then begin
                        CODBAR := 'E8';
                    end;
                    if RecRefCruz."Reference No." <> '' then begin
                        TextoSalida4 := 'AREA' + '|' +
                                        'AG' + '|' +
                                         RecI."No." + '|' +
                                         RecRefCruz."Reference No." + '|' +
                                         CODBAR + '|';
                        OutStream.Writetext(TextoSalida4);
                        if StrLen(RecRefCruz."Reference No.") = 12 then begin
                            TextoSalida4 := 'AREA' + '|' +
                                            'AG' + '|' +
                                             RecI."No." + '|' +
                                             '0' + RecRefCruz."Reference No." + '|' +
                                             'E13|';
                            OutStream.Writetext(TextoSalida4);
                        end;
                        if StrLen(RecRefCruz."Reference No.") = 11 then begin
                            TextoSalida4 := 'AREA' + '|' +
                                            'AG' + '|' +
                                             RecI."No." + '|' +
                                             '00' + RecRefCruz."Reference No." + '|' +
                                             'E13|';
                            OutStream.Writetext(TextoSalida4);
                        end;

                    end;
                until RecRefCruz.Next = 0;

            UBIPICDIN := 'N';
            PICCOMPAR := 'S';
            ///IF RecI."Tipo de Picking"=1 THEN BEGIN
            UBIPICDIN := 'S';
            PICCOMPAR := 'N';
            ///END;
            if COMPANYNAME = 'PEPE' then begin
                ////IF RecI."Zona picking"=1 THEN BEGIN
                UBIPICDIN := 'S';
                ///END;

            end;



            UBIPIC := '';
            ///IF RecI."Ubicacion picking."<>'' THEN BEGIN
            ///UBIPIC:=RecI."Ubicacion picking.";
            ///END;
            UBIREF := '';
            ///IF RecI."Ubicacion ref."<>'' THEN BEGIN
            ///UBIREF:=RecI."Ubicacion ref.";
            ///END;



            ///      ARUB|AG|62600|01|||N||E150|||||||||
            TextoSalida5 := 'ARUB' + '|' +
                                  'AG' + '|' +
                                 RecI."No." + '|' +
                             '01|' +
                             'GRAL||GRAL|' +
                             UBIPICDIN + '||' +
                             ///FORMAT(RecI."Dimensión hueco")+
                             '|1|9|S||||||' +
                             PICCOMPAR + '||||100|C|||||||||||';


        end;





        contaser := CUNext.GetNextNo('DEGESTION', Today, true);
        RecCE.Get;
        RUTA := RecCE."Ruta salida de_gestion";
        TIPO := 3;
        BUSCAEXTENSION;
        DAT2 := 'TRART.' + contaser + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);



        DAT2 := 'TRARPR.' + contaser + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

        DAT2 := 'TRAREA.' + contaser + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);



        DAT2 := 'TRARUB.' + contaser + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);


    end;


    procedure MODIFPROD(var RecI: Record Item)
    begin


        RecCE.Get;
        TempBlob.CreateOutStream(OutStream);





        if RecI."Producto almacenable" then begin
            PESO := 'N';
            UNI1 := 'UD';
            UNI2 := 'UD';
            UNI3 := 'UD';
            DESNOM := ConvertStr(CopyStr(RecI.Description, 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM2 := ConvertStr(CopyStr(RecI."Description 2", 1, 30), 'ª', '.');
            DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
            DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
            if COMPANYNAME = 'PEPE' then begin
                if RecI.ean <> '' then begin
                    LENEAN := StrLen(RecI.ean) - 4;
                    DESNOM := CopyStr(RecI.ean, LENEAN, 5) + '-' + DESNOM;
                end;
            end;
            CODI := Format(RecI."No.", 16);
            CODI := ConvertStr(CODI, ' ', ' ');
            CONTROLAEA := 'N';
            CRITERIO := RecI."Criterio rotacion";
            TextoSalida := 'AR' + '|' +
                           'AG' + '|' +
                          RecI."No." + '|' +
                      Format(DESNOM + ' ' + DESNOM2, 40) + '|' +
                      RecI."No." + '|' +
                      Format(CRITERIO, 4) + '|' +
                      Format(DDD1, 5) + '|' +
                      Format(DDD2, 5) + '|' +
                      Format(DDD3, 5) + '|' +
                      'N' + '|' +
                      PESO + '|' +
                      CONTROLAEA + '|' +
                      'UD' + '|' +
                      Format('MA', 4) + '|' +
                      Format('UD', 4) + '|' +
                      Format('UD', 4) + '|' +
                      'N' + '|' +
                      'HAGEN|' +
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
                      '|' +
                      '|' +
                      '|';



            OutStream.Writetext(TextoSalida);


            TextoSalida := 'AR' + '|' +
                           'MO' + '|' +
                          RecI."No." + '|' +
                      Format(DESNOM + ' ' + DESNOM2, 40) + '|' +
                      RecI."No." + '|' +
                      Format(CRITERIO, 4) + '|' +
                      Format(DDD1, 5) + '|' +
                      Format(DDD2, 5) + '|' +
                      Format(DDD3, 5) + '|' +
                      'N' + '|' +
                      PESO + '|' +
                      CONTROLAEA + '|' +
                      'UD' + '|' +
                      Format('MA', 4) + '|' +
                      Format('UD', 4) + '|' +
                      Format('UD', 4) + '|' +
                      'N' + '|' +
                      'HAGEN|' +
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
                      '|' +
                      '|' +
                      '|';


            OutStream.Writetext(TextoSalida);



            if RecIUM.Get(RecI."No.", 'UDS') then begin
            end;
            if RecIUMMA.Get(RecI."No.", 'MA') then begin
            end;
            if RecIUMIN.Get(RecI."No.", 'IN') then begin
            end;



            UNICAJA := RecIUMIN."Qty. per Unit of Measure";
            UNIPAL := RecI."Cantidad palets";
            if UNIPAL = 0 then begin
                UNIPAL := RecIUMMA."Qty. per Unit of Measure";
            end;
            if UNICAJA = 0 then begin
                UNICAJA := 1;
            end;
            if UNIPAL = 0 then begin
                UNIPAL := 1;
            end;

            CAJASPAL := 1;
            if UNICAJA <> 0 then begin
                CAJASPAL := ROUND(UNIPAL / UNICAJA, 1);
            end;

            CD1 := Format(UNIPAL, 6, '<integer>');

            TextoSalida3 := 'ARPR' + '|' +
                            'DE' + '|' +
                            RecI."No." + '|' +
                            'UD' + '|' +
                            '1' + '|' +
                            '|' +
                            '|' +
                            '|' +
                            '|' +
                            PESO2 + '|' +
                            PESOINF + '|' +
                            PESOSUP + '|' +
                            Format(CD1) + '|' +
                            Format(CD1) + '|' +
                            '1' + '|' +
                            '|' +
                            'N|';
            OutStream.Writetext(TextoSalida3);

            dc1 := ConvertStr(Format(RecIUM.Cubage * 1000, 9, Text1100007), ' ', '0');
            dc1 := '000000000';
            dc3 := ConvertStr(Format((RecIUM.Length / 100) * 1000, 9, Text1100007), ' ', '0');
            dc2 := ConvertStr(Format((RecIUM.Width / 100) * 1000, 9, Text1100007), ' ', '0');
            dc4 := ConvertStr(Format((RecIUM.Height / 100) * 1000, 9, Text1100007), ' ', '0');
            PESO2 := ConvertStr(Format(RecIUM.Weight * 1000, 9, Text1100007), ' ', '0');

            TextoSalida3 := 'ARPR' + '|' +
                            'AG' + '|' +
                            RecI."No." + '|' +
                            'UD' + '|' +
                            '1' + '|' +
                            Format(dc1) + '|' +
                            Format(dc3) + '|' +
                            Format(dc2) + '|' +
                            Format(dc4) + '|' +
                            PESO2 + '|' +
                            PESOINF + '|' +
                            PESOSUP + '|' +
                            Format(CD1) + '|' +
                            Format(CD1) + '|' +
                            '1' + '|' +
                            '|' +
                            'N|';
            OutStream.Writetext(TextoSalida3);

            CD1 := Format(UNICAJA, 6, '<integer>');
            CD2 := Format(CAJASPAL, 6, '<integer>');

            dc1 := ConvertStr(Format(RecIUMMA.Cubage * 1000, 9, Text1100007), ' ', '0');
            dc1 := '000000000';
            dc3 := ConvertStr(Format((RecIUMMA.Length / 100) * 1000, 9, Text1100007), ' ', '0');
            dc2 := ConvertStr(Format((RecIUMMA.Width / 100) * 1000, 9, Text1100007), ' ', '0');
            dc4 := ConvertStr(Format((RecIUMMA.Height / 100) * 1000, 9, Text1100007), ' ', '0');
            PESO2 := ConvertStr(Format(RecIUMMA.Weight * 1000, 9, Text1100007), ' ', '0');

            TextoSalida3 := 'ARPR' + '|' +
                            'DE' + '|' +
                            RecI."No." + '|' +
                            'CJ' + '|' +
                            Format(CD1) + '|' +
                            Format(dc1) + '|' +
                            Format(dc3) + '|' +
                            Format(dc2) + '|' +
                            Format(dc4) + '|' +
                            PESO2 + '|' +
                            PESOINF + '|' +
                            PESOSUP + '|' +
                            Format(CD2) + '|' +
                            Format(CD2) + '|' +
                            '1' + '|' +
                            '|' +
                            'N|';
            OutStream.Writetext(TextoSalida3);

            CD1 := Format(UNIPAL, 6, '<integer>');

            dc1 := ConvertStr(Format(RecIUM.Cubage * 1000, 9, Text1100007), ' ', '0');
            dc1 := '000000000';
            dc3 := ConvertStr(Format((RecIUM.Length / 100) * 1000, 9, Text1100007), ' ', '0');
            dc2 := ConvertStr(Format((RecIUM.Width / 100) * 1000, 9, Text1100007), ' ', '0');
            dc4 := ConvertStr(Format((RecIUM.Height / 100) * 1000, 9, Text1100007), ' ', '0');
            PESO2 := ConvertStr(Format(RecIUM.Weight * 1000, 9, Text1100007), ' ', '0');


            TextoSalida3 := 'ARPR' + '|' +
                            'AG' + '|' +
                            RecI."No." + '|' +
                            'UD' + '|' +
                            '1' + '|' +
                            Format(dc1) + '|' +
                            Format(dc3) + '|' +
                            Format(dc2) + '|' +
                            Format(dc4) + '|' +

                            PESO2 + '|' +
                            PESOINF + '|' +
                            PESOSUP + '|' +
                            Format(CD1) + '|' +
                            Format(CD1) + '|' +
                            '1' + '|' +
                            '|' +
                            'N|';


            CD1 := Format(UNICAJA, 6, '<integer>');
            CD2 := Format(CAJASPAL, 6, '<integer>');

            dc1 := ConvertStr(Format(RecIUMMA.Cubage * 1000, 9, Text1100007), ' ', '0');
            dc1 := '000000000';
            dc3 := ConvertStr(Format((RecIUMMA.Length / 100) * 1000, 9, Text1100007), ' ', '0');
            dc2 := ConvertStr(Format((RecIUMMA.Width / 100) * 1000, 9, Text1100007), ' ', '0');
            dc4 := ConvertStr(Format((RecIUMMA.Height / 100) * 1000, 9, Text1100007), ' ', '0');
            PESO2 := ConvertStr(Format(RecIUMMA.Weight * 1000, 9, Text1100007), ' ', '0');


            TextoSalida3 := 'ARPR' + '|' +
                            'AG' + '|' +
                            RecI."No." + '|' +
                            'CJ' + '|' +
                            Format(CD1) + '|' +
                            Format(dc1) + '|' +
                            Format(dc3) + '|' +
                            Format(dc2) + '|' +
                            Format(dc4) + '|' +
                            PESO2 + '|' +
                            PESOINF + '|' +
                            PESOSUP + '|' +
                            Format(CD2) + '|' +
                            Format(CD2) + '|' +
                            '1' + '|' +
                            '|' +
                            'N|';
            OutStream.Writetext(TextoSalida3);


            UNICAJA := RecIUMIN."Qty. per Unit of Measure";
            UNIPAL := RecI."Cantidad palets";
            UNIMA := RecIUMMA."Qty. per Unit of Measure";
            if UNIPAL = 0 then begin
                UNIPAL := RecIUMMA."Qty. per Unit of Measure";
            end;
            if UNICAJA = 0 then begin
                UNICAJA := 1;
            end;
            if UNIPAL = 0 then begin
                UNIPAL := 1;
            end;
            if UNIMA = 0 then begin
                UNIMA := 1;
            end;

            CAJASMA := 1;
            if UNIMA <> 0 then begin
                CAJASMA := ROUND(UNIPAL / UNIMA, 1);
            end;


            CD1 := Format(UNIMA, 6, '<integer>');
            CD2 := Format(CAJASMA, 6, '<integer>');

            dc1 := ConvertStr(Format(RecIUMMA.Cubage * 1000, 9, Text1100007), ' ', '0');
            dc1 := '000000000';
            dc3 := ConvertStr(Format((RecIUMMA.Length / 100) * 1000, 9, Text1100007), ' ', '0');
            dc2 := ConvertStr(Format((RecIUMMA.Width / 100) * 1000, 9, Text1100007), ' ', '0');
            dc4 := ConvertStr(Format((RecIUMMA.Height / 100) * 1000, 9, Text1100007), ' ', '0');
            PESO2 := ConvertStr(Format(RecIUMMA.Weight * 1000, 9, Text1100007), ' ', '0');


            TextoSalida3 := 'ARPR' + '|' +
                            'DE' + '|' +
                            RecI."No." + '|' +
                            'MA' + '|' +
                            Format(CD1) + '|' +
                            Format(dc1) + '|' +
                            Format(dc3) + '|' +
                            Format(dc2) + '|' +
                            Format(dc4) + '|' +

                            PESO2 + '|' +
                            PESOINF + '|' +
                            PESOSUP + '|' +
                            Format(CD2) + '|' +
                            Format(CD2) + '|' +
                            '1' + '|' +
                            '|' +
                            'N|';
            OutStream.Writetext(TextoSalida3);


            CD1 := Format(UNIMA, 6, '<integer>');
            CD2 := Format(CAJASMA, 6, '<integer>');

            dc1 := ConvertStr(Format(RecIUMMA.Cubage * 1000, 9, Text1100007), ' ', '0');
            dc1 := '000000000';
            dc3 := ConvertStr(Format((RecIUMMA.Length / 100) * 1000, 9, Text1100007), ' ', '0');
            dc2 := ConvertStr(Format((RecIUMMA.Width / 100) * 1000, 9, Text1100007), ' ', '0');
            dc4 := ConvertStr(Format((RecIUMMA.Height / 100) * 1000, 9, Text1100007), ' ', '0');
            PESO2 := ConvertStr(Format(RecIUMMA.Weight * 1000, 9, Text1100007), ' ', '0');



            TextoSalida3 := 'ARPR' + '|' +
                            'AG' + '|' +
                            RecI."No." + '|' +
                            'MA' + '|' +
                            Format(CD1) + '|' +
                            Format(dc1) + '|' +
                            Format(dc3) + '|' +
                            Format(dc2) + '|' +
                            Format(dc4) + '|' +

                            PESO2 + '|' +
                            PESOINF + '|' +
                            PESOSUP + '|' +
                            Format(CD2) + '|' +
                            Format(CD2) + '|' +
                            '1' + '|' +
                            '|' +
                            'N|';
            OutStream.Writetext(TextoSalida3);






            CODBAR := 'E13';
            LENCB := StrLen(RecI.ean);
            if LENCB = 14 then begin
                CODBAR := 'D14';
            end;
            if LENCB = 8 then begin
                CODBAR := 'E8';
            end;
            if RecI.ean <> '' then begin

                TextoSalida4 := 'AREA' + '|' +
                           'AG' + '|' +
                           RecI."No." + '|' +
                           RecI.ean + '|' +
                           CODBAR + '|';
                OutStream.Writetext(TextoSalida4);
            end;
            if StrLen(RecItem.ean) = 12 then begin
                TextoSalida4 := 'AREA' + '|' +
                               'AG' + '|' +
                                RecI."No." + '|' +
                                '0' + RecI.ean + '|' +
                                'E13|';
                OutStream.Writetext(TextoSalida4);
            end;
            if StrLen(RecItem.ean) = 11 then begin
                TextoSalida4 := 'AREA' + '|' +
                              'AG' + '|' +
                               RecI."No." + '|' +
                               '00' + RecI.ean + '|' +
                               'E13|';
                OutStream.Writetext(TextoSalida4);
            end;

            TextoSalida4 := 'AREA' + '|' +
                       'AG' + '|' +
                       RecI."No." + '|' +
                       RecI."No." + '|' +
                       'E13|';
            OutStream.Writetext(TextoSalida4);

            RecRefCruz.Reset;
            RecRefCruz.SetRange(RecRefCruz."Item No.", RecI."No.");
            RecRefCruz.SetRange(RecRefCruz."Reference Type", 3);
            if RecRefCruz.FindSet then
                repeat
                    CODBAR := 'E13';
                    LENCB := StrLen(RecRefCruz."Reference No.");
                    if LENCB = 14 then begin
                        CODBAR := 'D14';
                    end;
                    if LENCB = 8 then begin
                        CODBAR := 'E8';
                    end;
                    if RecRefCruz."Reference No." <> '' then begin
                        TextoSalida4 := 'AREA' + '|' +
                                        'AG' + '|' +
                                         RecI."No." + '|' +
                                         RecRefCruz."Reference No." + '|' +
                                         CODBAR + '|';
                        OutStream.Writetext(TextoSalida4);

                    end;
                    if StrLen(RecRefCruz."Reference No.") = 12 then begin
                        TextoSalida4 := 'AREA' + '|' +
                                        'AG' + '|' +
                                         RecI."No." + '|' +
                                         '0' + RecRefCruz."Reference No." + '|' +
                                         'E13|';
                        OutStream.Writetext(TextoSalida4);
                    end;
                    if StrLen(RecRefCruz."Reference No.") = 11 then begin
                        TextoSalida4 := 'AREA' + '|' +
                                        'AG' + '|' +
                                         RecI."No." + '|' +
                                         '00' + RecRefCruz."Reference No." + '|' +
                                         'E13|';
                        OutStream.Writetext(TextoSalida4);
                    end;


                until RecRefCruz.Next = 0;

            UBIPICDIN := 'N';
            PICCOMPAR := 'S';
            ///IF RecI."Tipo de Picking"=1 THEN BEGIN
            UBIPICDIN := 'S';
            PICCOMPAR := 'N';
            ///END;

            if COMPANYNAME = 'PEPE' then begin
                //IF RecI."Zona picking"=1 THEN BEGIN
                ///  UBIPICDIN:='S';
                ///END;
            end;


            UBIPIC := '';
            ///IF RecI."Ubicacion picking."<>'' THEN BEGIN
            ///UBIPIC:=RecI."Ubicacion picking.";
            ////END;
            UBIREF := '';
            ////IF RecI."Ubicacion ref."<>'' THEN BEGIN
            ///UBIREF:=RecI."Ubicacion ref.";
            ///END;


            ///      ARUB|AG|62600|01|||N||E150|||||||||
            TextoSalida5 := 'ARUB' + '|' +
                                  'AG' + '|' +
                                 RecI."No." + '|' +
                             '01|' +
                             'GRAL||GRAL|' +
                             UBIPICDIN + '||' +
                             ///FORMAT(RecI."Dimensión hueco")+
                             '|1|9|S||||||' +
                             PICCOMPAR + '||||100|C|||||||||||';
            if COMPANYNAME = 'PEPE' then begin
                TextoSalida5 := 'ARUB' + '|' +
                                  'AG' + '|' +
                                 RecI."No." + '|' +
                             '01|' +
                             ///FORMAT(RecI."Zona almacenaje")+'|'+
                             ///UBIREF+'|'+FORMAT(RecI."Zona picking")+'|'+
                             UBIPICDIN + '|' +
                             UBIPIC + '|' +
                             //FORMAT(RecI."Dimensión hueco")+
                             '|1|9|S||||||' +
                             PICCOMPAR + '||||100|C|||||||||||';
                ///PICCOMPAR+'|||'+FORMAT(RecI."Zona almacenaje")+'|100|C|||||||||||';
            end;
            OutStream.Writetext(TextoSalida5);



        end;

        contaser := CUNext.GetNextNo('DEGESTION', Today, true);
        RecCE.Get;
        RUTA := RecCE."Ruta salida de_gestion";
        TIPO := 3;
        BUSCAEXTENSION;
        DAT2 := 'TRART.' + contaser + EXTEN + Format(ALEA) + Format(RecI."No.") + Format(LOGCAMBIOA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);


        DAT2 := 'TRARPR.' + contaser + EXTEN + Format(ALEA) + Format(RecI."No.") + Format(LOGCAMBIOA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);


        DAT2 := 'TRAREA.' + contaser + EXTEN + Format(ALEA) + Format(RecI."No.") + Format(LOGCAMBIOA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);


        DAT2 := 'TRARUB.' + contaser + EXTEN + Format(ALEA) + Format(RecI."No.") + Format(LOGCAMBIOA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);


    end;


    procedure ENVIARECEPCIONES(var RecCC: Record "Purchase Header")
    var
        CarriageReturn: Char;
        LineFeed: Char;
        Data: BigText;
        OutTxt: Text;
    /*
    var


// Escribimos en el archivo utilizando ambos caracteres para un salto de línea estilo Windows
OutStream.Write('Primera línea' + Format(CarriageReturn) + Format(LineFeed));
OutStream.Write('Segunda línea después del salto' + Format(CarriageReturn) + Format(LineFeed));
OutStream.Write('Tercera línea después del salto');
    */

    begin

        CarriageReturn := 13; // 13 es el valor ASCII para Carriage Return (CR)
        LineFeed := 10;       // 10 es el valor ASCII para Line Feed (LF)

        Clear(TempBlob);
        TempBlob.CreateOutStream(OutStream, TextEncoding::Windows);


        if RecCC."Order Date" <> 0D then begin
            ESDIA1 := Date2dmy(RecCC."Order Date", 1);
            ESMES1 := Date2dmy(RecCC."Order Date", 2);
            ESAÑO1 := Date2dmy(RecCC."Order Date", 3);
            ESMES11 := Format(ESMES1);
            if ESMES1 = 1 then ESMES11 := '01';
            if ESMES1 = 2 then ESMES11 := '02';
            if ESMES1 = 3 then ESMES11 := '03';
            if ESMES1 = 4 then ESMES11 := '04';
            if ESMES1 = 5 then ESMES11 := '05';
            if ESMES1 = 6 then ESMES11 := '06';
            if ESMES1 = 7 then ESMES11 := '07';
            if ESMES1 = 8 then ESMES11 := '08';
            if ESMES1 = 9 then ESMES11 := '09';
            if ESMES1 = 10 then ESMES11 := '10';
            if ESMES1 = 11 then ESMES11 := '11';
            if ESMES1 = 12 then ESMES11 := '12';

            ESDIA11 := Format(ESDIA1);
            if ESDIA1 = 1 then ESDIA11 := '01';
            if ESDIA1 = 2 then ESDIA11 := '02';
            if ESDIA1 = 3 then ESDIA11 := '03';
            if ESDIA1 = 4 then ESDIA11 := '04';
            if ESDIA1 = 5 then ESDIA11 := '05';
            if ESDIA1 = 6 then ESDIA11 := '06';
            if ESDIA1 = 7 then ESDIA11 := '07';
            if ESDIA1 = 8 then ESDIA11 := '08';
            if ESDIA1 = 9 then ESDIA11 := '09';
            FECORD1 := Format(ESAÑO1, 4, '<integer>') + ESMES11 + ESDIA11;
        end;

        if RecCC."Expected Receipt Date" <> 0D then begin
            ESDIA2 := Date2dmy(RecCC."Expected Receipt Date", 1);
            ESMES2 := Date2dmy(RecCC."Expected Receipt Date", 2);
            ESAÑO2 := Date2dmy(RecCC."Expected Receipt Date", 3);
            ///ESMES22:=FORMAT(ESMES2);
            if ESMES2 = 1 then ESMES22 := '01';
            if ESMES2 = 2 then ESMES22 := '02';
            if ESMES2 = 3 then ESMES22 := '03';
            if ESMES2 = 4 then ESMES22 := '04';
            if ESMES2 = 5 then ESMES22 := '05';
            if ESMES2 = 6 then ESMES22 := '06';
            if ESMES2 = 7 then ESMES22 := '07';
            if ESMES2 = 8 then ESMES22 := '08';
            if ESMES2 = 9 then ESMES22 := '09';
            if ESMES2 = 10 then ESMES22 := '10';
            if ESMES2 = 11 then ESMES22 := '11';
            if ESMES2 = 12 then ESMES22 := '12';

            ESDIA22 := Format(ESDIA2);
            if ESDIA2 = 1 then ESDIA22 := '01';
            if ESDIA2 = 2 then ESDIA22 := '02';
            if ESDIA2 = 3 then ESDIA22 := '03';
            if ESDIA2 = 4 then ESDIA22 := '04';
            if ESDIA2 = 5 then ESDIA22 := '05';
            if ESDIA2 = 6 then ESDIA22 := '06';
            if ESDIA2 = 7 then ESDIA22 := '07';
            if ESDIA2 = 8 then ESDIA22 := '08';
            if ESDIA2 = 9 then ESDIA22 := '09';
            FECORD2 := Format(ESAÑO2, 4, '<integer>') + ESMES22 + ESDIA22;
        end;

        TENDA := RecCC."Buy-from Vendor No.";
        OutTxt := 'ORCA' + '|' +                                             //1
                       'AG' + '|' +                                               //2
                       RecCC."No." + '|' +                                 //3
                       '01' + '|' +                                               //4
                       TENDA + '|' +                                               //5
                       '|' +                                                       //6
                       'ENPR|' +                                                  //7
                       FECORD1 + '|' +               //8
                       FECORD2 + '|' +   //9
                       '|' +    //10
                       '|' +    //11
                       '|' +    //12
                       '|' +    //13
                       '|';    //15                          
        /////OutStream.Writetext(TextoSalida);
        OutTxt += Format(CarriageReturn) + Format(LineFeed);
        data.AddText(OutTxt);
        ///OutStream.Write(TextoSalida + Format(CarriageReturn) + Format(LineFeed));
        //OutStream.Write(TextoSalida + Format(LineFeed));


        NLIN := 0;
        RecLC.Reset;
        RecLC.SetRange(RecLC."Document Type", RecCC."Document Type");
        RecLC.SetRange(RecLC."Document No.", RecCC."No.");
        if RecLC.FindSet then
            repeat

                NLIN := NLIN + 1;

                NLINC := Format(RecLC."Line No.", 9, '<integer>');
                CANTIPEDI := Format(RecLC.Quantity, 5, '<integer>');
                if RecItem.Get(RecLC."No.") then begin
                end;
                OutTxt := 'ORLI' + '|' +                 //1
                               'AG' + '|' +                   //2
                               RecCC."No." + '|' +                //3
                               RecLC."No." + '|' +                 //4

                               CANTIPEDI + '|' +               //5
                               'UD' + '|' +                   //6
                               '1' + '|' +                    //7
                               CANTIKILO + '|' +                           //8
                               '|' +                          //9
                               '|' +                          //10
                               '|' +                          //11
                               '|N' +                         //12
                               '|' +                          //13
                               NLINC + '|' +                          //14
                               '|' +                          //15
                               '|';                          //16
                                                             ///OutStream.Writetext(TextoSalida);
                /////OutStream.Write(TextoSalida + Format(CarriageReturn) + Format(LineFeed));
                //OutStream.Write(TextoSalida + Format(LineFeed));
                OutTxt += Format(CarriageReturn) + Format(LineFeed);
                data.AddText(OutTxt);

            until RecLC.Next = 0;



        /// Exportación a ADAIA RECEPCIONES

        RecCE.Get;
        RUTA := RecCE."Ruta salida de_gestion";
        TIPO := 3;
        BUSCAEXTENSION;
        DAT2 := 'TRRECORD.' + contaser + EXTEN + Format(ALEA) + Format(RecI."No.") + Format(LOGCAMBIOA);
        Data.Write(OutStream);
        TempBlob.CreateInStream(InStream, TextEncoding::Windows);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);
    end;


    procedure ENVIAEXPEDICIONES(var RecCV: Record "Sales Header")
    var
        CarriageReturn: Char;
        LineFeed: Char;
        Data: BigText;
        OutTxt: Text;

    begin


        CarriageReturn := 13; // 13 es el valor ASCII para Carriage Return (CR)
        LineFeed := 10;       // 10 es el valor ASCII para Line Feed (LF)

        Clear(TempBlob);
        TempBlob.CreateOutStream(OutStream, TextEncoding::Windows);



        NPEDIDO := RecCV."Nº expedición";
        RecCVE.Reset;
        RecCVE.SetCurrentkey("Document Type", "Nº expedición");
        RecCVE.SetRange(RecCVE."Document Type", 1);
        RecCVE.SetRange(RecCVE."Nº expedición", RecCV."Nº expedición");
        if RecCVE.Find('-') then begin
            if Today <> 0D then begin
                ESDIA1 := Date2dmy(Today, 1);
                ESMES1 := Date2dmy(Today, 2);
                ESAÑO1 := Date2dmy(Today, 3);
                ESMES11 := Format(ESMES1);
                if ESMES1 = 1 then ESMES11 := '01';
                if ESMES1 = 2 then ESMES11 := '02';
                if ESMES1 = 3 then ESMES11 := '03';
                if ESMES1 = 4 then ESMES11 := '04';
                if ESMES1 = 5 then ESMES11 := '05';
                if ESMES1 = 6 then ESMES11 := '06';
                if ESMES1 = 7 then ESMES11 := '07';
                if ESMES1 = 8 then ESMES11 := '08';
                if ESMES1 = 9 then ESMES11 := '09';
                if ESMES1 = 10 then ESMES11 := '10';
                if ESMES1 = 11 then ESMES11 := '11';
                if ESMES1 = 12 then ESMES11 := '12';

                ESDIA11 := Format(ESDIA1);
                if ESDIA1 = 1 then ESDIA11 := '01';
                if ESDIA1 = 2 then ESDIA11 := '02';
                if ESDIA1 = 3 then ESDIA11 := '03';
                if ESDIA1 = 4 then ESDIA11 := '04';
                if ESDIA1 = 5 then ESDIA11 := '05';
                if ESDIA1 = 6 then ESDIA11 := '06';
                if ESDIA1 = 7 then ESDIA11 := '07';
                if ESDIA1 = 8 then ESDIA11 := '08';
                if ESDIA1 = 9 then ESDIA11 := '09';
                FECORD1 := Format(ESAÑO1, 4, '<integer>') + ESMES11 + ESDIA11;
            end;

            FECORD2 := FECORD1;

            OBS := '';
            NOMULTIPEDIDO := false;
            RecCVE.Reset;
            RecCVE.SetCurrentkey("Document Type", "Nº expedición");
            RecCVE.SetRange(RecCVE."Document Type", 1);
            RecCVE.SetRange(RecCVE."Nº expedición", RecCV."Nº expedición");
            if RecCVE.FindSet then
                repeat
                    RecLV.Reset;
                    RecLV.SetRange(RecLV."Document Type", RecCVE."Document Type");
                    RecLV.SetRange(RecLV."Document No.", RecCVE."No.");
                    if RecLV.FindSet then
                        repeat
                            if RecItem2.Get(RecLV."No.") then begin
                                if RecLV."Outstanding Quantity" <> 0 then begin
                                    if RecLV."Enviar a ADAIA" then begin
                                        RecItem2."No permite pedido" := false;
                                    end;
                                    /////IF (RecItem2."Producto almacenable") AND (NOT RecItem2."No permite pedido") THEN BEGIN
                                    if (RecItem2."Producto almacenable") then begin
                                        if RecItem2."NO MULTIPEDIDO" then begin
                                            NOMULTIPEDIDO := true;
                                        end;
                                    end;
                                end;
                            end;
                        until RecLV.Next = 0;
                until RecCVE.Next = 0;

            OBS := RecCVE."Observación PDA";
            if (RecCVE."NO MULTIPEDIDO") or (NOMULTIPEDIDO) then begin
                OBS := 'NO MULTIPEDIDO' + ' ' + RecCVE."Observación PDA";
            end;

            if CopyStr(Reccve."Nº expedición", 1, 3) = 'CAT' then begin
                RecCVE."Sell-to Customer No." := '11010';
            end;



            OutTxt := 'OECA' + '|' +
                           'AG' + '|' +
                           NPEDIDO + '|' +
                           '01' + '|' +
                           RecCVE."Sell-to Customer No." + '|' +
                           '|' +
                           'PED|' +
                           '|' +
                           '|' +
                           FECORD1 + '|' +
                           FECORD1 + '|' +
                           HH + MI + '|' +
                           'N|' +
                           Format(OBS, 40) + '|||||';
            OutTxt += Format(CarriageReturn) + Format(LineFeed);
            data.AddText(OutTxt);

        end;

        codtras := '';
        CONTALIN := 0;
        RecCVE.Reset;
        RecCVE.SetCurrentkey("Document Type", "Nº expedición");
        RecCVE.SetRange(RecCVE."Document Type", 1);
        RecCVE.SetRange(RecCVE."Nº expedición", RecCV."Nº expedición");
        if RecCVE.FindSet then
            repeat

                RespetaTrans := RecCVE."Respeta agencia transporte";
                if RecCVE."Shipping Agent Code" = 'DHL' then begin
                    codtras := 'DHL';
                end;
                if RecCVE."Shipping Agent Code" = 'SEUR' then begin
                    codtras := 'SEUR';
                end;
                if RecCVE."Shipping Agent Code" = 'TNT' then begin
                    codtras := 'TNT';
                end;

                if RecCVE."Shipping Agent Code" = 'TIPSA' then begin
                    codtras := 'TIPSA';
                end;
                if RecCVE."Shipping Agent Code" = 'CORR' then begin
                    codtras := 'CORR';
                end;





                NLIN := 0;
                RecLV.Reset;
                RecLV.SetRange(RecLV."Document Type", RecCVE."Document Type");
                RecLV.SetRange(RecLV."Document No.", RecCVE."No.");
                if RecLV.FindSet then
                    repeat
                        if RecItem2.Get(RecLV."No.") then begin
                            if (RecLV."Outstanding Quantity" <> 0) and (RecLV."Linea Nº expedición" = 0) then begin
                                if RecLV."Enviar a ADAIA" then begin
                                    RecItem2."No permite pedido" := false;
                                end;
                                /////IF (RecItem2."Producto almacenable") AND (NOT RecItem2."No permite pedido") THEN BEGIN
                                if (RecItem2."Producto almacenable") then begin
                                    CONTALIN := CONTALIN + 10000;
                                    NLINC := Format(CONTALIN, 9, '<integer>');
                                    CANTIDADTRAS := Format(RecLV."Quantity (Base)", 6, '<integer>');


                                    RecLV.CalcFields(RecLV."Suma cdad. por envio");
                                    if RecLV."Suma cdad. por envio" <> RecLV."Outstanding Quantity" then begin
                                        CANTIDADTRAS := Format(RecLV."Suma cdad. por envio", 6, '<integer>');
                                        RecLVSuma.Reset;
                                        RecLVSuma.SetCurrentkey(RecLVSuma."Nº expedición", RecLVSuma."No.");
                                        RecLVSuma.SetRange(RecLVSuma."Nº expedición", RecCV."Nº expedición");
                                        RecLVSuma.SetRange(RecLVSuma."No.", RecLV."No.");
                                        if RecLVSuma.FindSet then
                                            repeat
                                                RecLVSuma."Linea Nº expedición" := CONTALIN;
                                                RecLVSuma.Validate(RecLVSuma."Qty. to Ship", 0);
                                                RecLVSuma.Modify;
                                            until RecLVSuma.Next = 0;
                                    end;


                                    PRECIO := Format(RecLV."Unit Price", 6, '<integer>');
                                    KILOSTRAS := '';

                                    OutTxt := 'OELI' + '|' +
                                               'AG' + '|' +
                                               NPEDIDO + '|' +
                                               NLINC + '|' +
                                               RecLV."No." + '|' +
                                               CANTIDADTRAS + '|' +
                                               'UD' + '|' +
                                               '1' + '|' +
                                               '' + '|' +
                                               '' + '||||';
                                    OutTxt += Format(CarriageReturn) + Format(LineFeed);
                                    data.AddText(OutTxt);

                                    RecLV."Nº expedición" := RecCV."Nº expedición";
                                    RecLV."Linea Nº expedición" := CONTALIN;
                                end;
                                RecLV.Validate(RecLV."Qty. to Ship", 0);
                                RecLV.Modify;

                                if RecItem2."Enviar siempre" then begin
                                    RecLV.Validate(RecLV."Qty. to Ship", RecLV.Quantity);
                                    RecLV.Modify;
                                end;
                            end;
                        end;
                    until RecLV.Next = 0;

            until RecCVE.Next = 0;

        ENVIAR := true;
        if (RecCVE."Marcar para agrupar" = true) and (RecCVE."Multi-picking") then begin
            ENVIAR := false;
        end;



        OutTxt := 'OELI' + '|' +
                       'AG' + '|' +
                       NPEDIDO + '|' +
                       '000000001|' +
                       '10|' +
                       '000001|' +
                       'UD' + '|' +
                       '1' + '|' +
                       '' + '|' +
                       '' + '||||';
        If ENVIAR then begin
            OutTxt += Format(CarriageReturn) + Format(LineFeed);
            data.AddText(OutTxt);

        end;

        OutTxt := 'OELI' + '|' +
                       'AG' + '|' +
                       NPEDIDO + '|' +
                       '000000002|' +
                       '11|' +
                       '000001|' +
                       'UD' + '|' +
                       '1' + '|' +
                       '' + '|' +
                       '' + '||||';
        if ENVIAR then begin
            OutTxt += Format(CarriageReturn) + Format(LineFeed);
            data.AddText(OutTxt);

        end;

        OutTxt := 'OELI' + '|' +
                       'AG' + '|' +
                       NPEDIDO + '|' +
                       '000000003|' +
                       '15|' +
                       '000001|' +
                       'UD' + '|' +
                       '1' + '|' +
                       '' + '|' +
                       '' + '||||';
        OutTxt += Format(CarriageReturn) + Format(LineFeed);
        data.AddText(OutTxt);



        OutTxt := 'OELI' + '|' +
                       'AG' + '|' +
                       NPEDIDO + '|' +
                       '000000003|' +
                       '12|' +
                       '000001|' +
                       'UD' + '|' +
                       '1' + '|' +
                       '' + '|' +
                       '' + '||||';
        OutTxt += Format(CarriageReturn) + Format(LineFeed);
        data.AddText(OutTxt);



        RecCE.Get;
        RUTA := RecCE."Ruta salida de_gestion";
        TIPO := 3;
        BUSCAEXTENSION;
        DAT2 := 'TREXPORD.' + contaser + EXTEN + Format(ALEA) + Format(RecI."No.") + Format(LOGCAMBIOA);
        Data.Write(OutStream);
        TempBlob.CreateInStream(InStream, TextEncoding::Windows);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure REGISTRATSTMOV(var Rec83: Record "Item Journal Line")
    begin


        Rec83.Reset;
        Rec83.SetRange(Rec83."Journal Template Name", 'ELEMENTO');
        Rec83.SetRange(Rec83."Journal Batch Name", 'ADAIA');
        if Rec83.FindFirst then begin
            CURegMov.Run(Rec83);
        end;
    end;


    procedure REGISTRAEXPE(var Rec36: Record "Sales Header")
    var
        Rec362: Record "Sales Header";
        RecBom: Record "BOM Component";
    begin




        RecCV.Get(Rec36."Document Type", Rec36."No.");
        PORTES := 0;

        if Rec36."No incluir portes" = false then begin
            Rec36.CalcFields(Rec36.Base);
            Rec91.Get(Rec36."Usuario alta");
            if Rec91.Comercial <> '' then begin
                if Rec36.Base >= 190 then begin
                    PORTES := 0;
                end;
                if Rec36.Base < 190 then begin
                    PORTES := ROUND(Rec36.Base * 12 / 100, 0.01);
                end;
            end;
            if Rec91.Comercial = '' then begin
                if Rec36.Base >= 190 then begin
                    PORTES := 0;
                end;
                if Rec36.Base < 190 then begin
                    PORTES := ROUND(Rec36.Base * 12 / 100, 0.01);
                end;
            end;
            RecCVC.Get;
            if PORTES <> 0 then begin
                if PORTES < RecCVC."Porte minimo" then begin
                    PORTES := RecCVC."Porte minimo";
                end;
            end;
            if Rec91."Es el cliente nº" <> '' then begin
                if Rec36.Base >= Rec91."Porte minimo" then begin
                    PORTES := 0;
                end;
                if Rec36.Base < Rec91."Porte minimo" then begin
                    PORTES := Rec91."Porte por usuario";
                end;
            end;


            RecBom.Reset;
            RecBom.SetRange(RecBom."Parent Item No.", Rec36."No.");
            RecBom.SetRange(RecBom.Optimo, true);
            if RecBom.FindFirst then begin
                PORTES := RecBom.Euros;
            end;
            if Rec36.Base > RecCVC."Importe para cobrar porte" then begin
                PORTES := 0;
            end;


            if PORTES <> 0 then begin
                ReleaseSalesDoc.Reopen(RecCV);
                RecLV.Reset;
                RecLV.SetRange(RecLV."Document Type", Rec36."Document Type");
                RecLV.SetRange(RecLV."Document No.", Rec36."No.");
                RecLV.SetRange(RecLV."No.", '62400000');
                if not RecLV.FindFirst then begin
                    RecLV.Reset;
                    RecLV.SetRange(RecLV."Document Type", Rec36."Document Type");
                    RecLV.SetRange(RecLV."Document No.", Rec36."No.");
                    if RecLV.FindLast then begin
                        g := RecLV."VAT Prod. Posting Group";
                        g2 := RecLV."Gen. Prod. Posting Group";
                        RecLV2 := RecLV;
                        RecLV2."Line No." := RecLV."Line No." + 10000;
                        RecLV2.Type := 1;
                        RecLV2.Validate(RecLV2."No.", '62400000');
                        RecLV2.Validate(RecLV2.Quantity, 1);
                        RecLV2.Validate(RecLV2."Unit Price", PORTES);
                        RecLV2.Validate(RecLV2."VAT Prod. Posting Group", g);
                        RecLV2."VAT Identifier" := g;
                        RecLV2."Gen. Prod. Posting Group" := g2;
                        RecLV2.Insert;
                    end;
                end;
            end;

        end;




        RecCusto.Get(Rec36."Sell-to Customer No.");


        ENVIAR := true;
        if Rec36.Dropshipping = false then begin
            if Rec36."Albaran sin detalle" = true then begin
                ENVIAR := false;
            end;
        end;





        if RecCusto."Tipo facturación" = 0 then begin
            Codeunit.Run(Codeunit::"Albaranar + imprimir", Rec36);
            if not RecCusto."No imprimir facturas" then begin
                Codeunit.Run(Codeunit::"Facturar sin imprimir", Rec36);
            end;
            if RecCusto."No imprimir facturas" then begin
                Codeunit.Run(Codeunit::"Facturar sin imprimir", Rec36);
            end;
            NCLIE := Rec36."Sell-to Customer No.";
            NFACT := Rec36."Last Posting No.";
            IMPRIMEFAC;
        end;
        if RecCusto."Tipo facturación" <> 0 then begin
            Codeunit.Run(Codeunit::"Albaranar + imprimir", Rec36);
        end;



        pendi := 0;
        RecLV.Reset;
        RecLV.SetRange(RecLV."Document Type", Rec36."Document Type");
        RecLV.SetRange(RecLV."Document No.", Rec36."No.");
        if RecLV.FindSet then
            repeat
                if RecItem2.Get(RecLV."No.") then begin
                    if (RecLV."Outstanding Quantity" <> 0) then begin
                        if (not RecItem2."No permite pedido") then begin
                            pendi := pendi + RecLV."Outstanding Quantity";
                        end;
                    end;
                end;
            until RecLV.Next = 0;

        if pendi <> 0 then begin
            ///Rec36."Anula restos":=TRUE;
            ///Rec36.MODIFY;
        end;
        if RecCV.Get(Rec36."Document Type", Rec36."No.") then begin


        end;

        if RecCV.Get(Rec36."Document Type", Rec36."No.") then begin
            Clear(ReleaseSalesDoc);
            ReleaseSalesDoc.Run(RecCV);

            pdte := 0;
            Rec37.Reset;
            Rec37.SetRange(Rec37."Document Type", RecCV."Document Type");
            Rec37.SetRange(Rec37."Document No.", RecCV."No.");
            if Rec37.FindSet then
                repeat
                    if (Rec37."Nº expedición" = '') and (RecCV."Fecha envio pendiente stock" <> 0D) then begin
                        pdte := pdte + Rec37."Outstanding Quantity";
                        stock := 0;
                    end;
                until Rec37.Next = 0;
            if pdte = 0 then begin
                RecCV."Estado pedido" := 3;
                RecCV.Modify;
            end;
            if pdte <> 0 then begin
                RecCV."Estado pedido" := 4;
                RecCV."Nº expedición" := '';
                RecCV.Modify;
            end;


        end;

    end;


    procedure REGISTRAEXPETRANF(var RecTC: Record "Transfer Header")
    begin

        ///RecTH2.GET(RecTC."No.");
        ///TransferPostShipment.RUN(RecTH2);
    end;


    procedure REGISTRAEXPEDEV(var Rec36: Record "Sales Header")
    begin


        RecCV.Get(3, Rec36."No.");
        ///SalesPost.RUN(RecCV);
    end;


    procedure REGISTRARECEP(var Rec38: Record "Purchase Header")
    begin


        RecCC.Get(1, Rec38."No.");
        PurchPost.Run(RecCC);
    end;


    procedure REGISTRARECEPDEV(var Rec38: Record "Purchase Header")
    begin


        RecCC.Get(3, Rec38."No.");
        PurchPost.Run(RecCC);
    end;


    procedure enviaeans()
    begin


        RecItem.Reset;
        RecItem.SetRange(RecItem."Producto almacenable", true);
        if RecItem.FindSet then
            repeat


                CODBAR := 'E13';
                LENCB := StrLen(RecItem.ean);
                if LENCB = 14 then begin
                    CODBAR := 'D14';
                end;
                if LENCB = 8 then begin
                    CODBAR := 'E8';
                end;

                if RecItem.ean <> '' then begin

                    TextoSalida4 := 'AREA' + '|' +
                               'AG' + '|' +
                               RecItem."No." + '|' +
                               RecItem.ean + '|' +
                               CODBAR + '|';
                    OutStream.Writetext(TextoSalida4);
                end;
                if StrLen(RecItem.ean) = 12 then begin
                    TextoSalida4 := 'AREA' + '|' +
                                   'AG' + '|' +
                                    RecItem."No." + '|' +
                                    '0' + RecItem.ean + '|' +
                                    'E13|';
                    OutStream.Writetext(TextoSalida4);
                end;
                if StrLen(RecItem.ean) = 11 then begin
                    TextoSalida4 := 'AREA' + '|' +
                                  'AG' + '|' +
                                   RecItem."No." + '|' +
                                   '00' + RecItem.ean + '|' +
                                   'E13|';
                    OutStream.Writetext(TextoSalida4);
                end;

                TextoSalida4 := 'AREA' + '|' +
                                   'AG' + '|' +
                                   RecItem."No." + '|' +
                                   RecItem."No." + '|' +
                                   'E13|';
                OutStream.Writetext(TextoSalida4);


                RecRefCruz.Reset;
                RecRefCruz.SetRange(RecRefCruz."Item No.", RecItem."No.");
                RecRefCruz.SetRange(RecRefCruz."Reference Type", 3);
                if RecRefCruz.FindSet then
                    repeat
                        CODBAR := 'E13';
                        LENCB := StrLen(RecRefCruz."Reference No.");
                        if LENCB = 14 then begin
                            CODBAR := 'D14';
                        end;
                        if LENCB = 8 then begin
                            CODBAR := 'E8';
                        end;
                        if RecRefCruz."Reference No." <> '' then begin
                            TextoSalida4 := 'AREA' + '|' +
                                            'AG' + '|' +
                                             RecItem."No." + '|' +
                                             RecRefCruz."Reference No." + '|' +
                                             CODBAR + '|';
                            OutStream.Writetext(TextoSalida4);
                        end;
                        if StrLen(RecRefCruz."Reference No.") = 12 then begin
                            TextoSalida4 := 'AREA' + '|' +
                                            'AG' + '|' +
                                             RecI."No." + '|' +
                                             '0' + RecRefCruz."Reference No." + '|' +
                                             'E13|';
                            OutStream.Writetext(TextoSalida4);
                        end;
                        if StrLen(RecRefCruz."Reference No.") = 11 then begin
                            TextoSalida4 := 'AREA' + '|' +
                                            'AG' + '|' +
                                             RecI."No." + '|' +
                                             '00' + RecRefCruz."Reference No." + '|' +
                                             'E13|';
                            OutStream.Writetext(TextoSalida4);
                        end;


                    until RecRefCruz.Next = 0;

            ///   END;
            until RecItem.Next = 0;




        /// Exportación a ADAIA TODOS LOS ARTICULOS

        RecCE.Get;
        RUTA := RecCE."Ruta salida de_gestion";
        TIPO := 3;
        BUSCAEXTENSION;

        DAT2 := 'TRAREA.' + contaser + EXTEN + Format(ALEA) + Format(RecI."No.") + Format(LOGCAMBIOA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure EtiDHL(var Rec: Record "Sales Shipment Header")
    begin


        Rec110.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);



        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);


        DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;
        TELEFONO := RecCusto."Phone No.";
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            TELEFONO := Rec110."Envio a-Nº Telefono";
        end;

        NEXPE := '4612345670';
        TextoSalida4 := '';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := 'FR"DHL"';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '?';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := DESNOM;
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := TELEFONO;
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := DESNOM2;
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Rec110."Ship-to City";
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Rec110."Ship-to Post Code";
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Rec110."Ship-to County";
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := NEXPE;
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '8';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Format(Rec110."Total bultos");
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '46';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '1234567';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '0';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := RecIE.Name;
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := CopyStr(Rec110."Ship-to Post Code", 1, 2);
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '+02';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '00';
        OutStream.Writetext(TextoSalida4);

        TextoSalida4 := '0';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '000';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '006';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := 'ES';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Rec110."Ship-to Post Code";
        OutStream.Writetext(TextoSalida4);

        TextoSalida4 := 'TOTAL BULTOS: ' + Format(Rec110."Total bultos");
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Rec110."Nº expedición";
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '1';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '001';
        OutStream.Writetext(TextoSalida4);

        TextoSalida4 := 'P' + Format(Rec110."Total bultos");
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '';
        OutStream.Writetext(TextoSalida4);

        /*
01.INTRO
2.FR"DHL"  .................................. LITERAL.
3.? ......................................... LITERAL.
4.SUM INDUSTRIALES CLEMENTE ................. DESTINATARIO DE 40 POSICIONES.
5.943123456 ................................. TELEFONO DESTINATARIO DE 9 POSICIONES.
6.POLIGONO INDUSTRIAL BELARTZA C/3 .......... DIRECCION DE DESTINATARIO 40 POSICIONES.
7.LISBOA .................................... POBLACION DE DESTINO 20 POSICIONES.
8.71001 ..................................... CODIGO POSTAL DE DESTINO DE 5 POSICIONES.
9.LISBOA .................................... TABLA3.
0.7112345670 ................................ TABLA4.
1.5 ......................................... ULTIMO DIGITO DEL AÑO.
2.2 ......................................... BULTOS TOTAL.
3..46 ........................................ ORIGEN.(tabla4)
4.01234567 .................................. NUMERO DE EXPEDICION DE 8 DIGITOS.
5.0 ......................................... LITERAL.
6.LUANVI   .................................. REMITENTE.40 POSICIONES.
7.C.O.D. .................................... EN CASO DE REEMBOLSO PONER C.O.D. , SINO INTRO.
8.71   ...................................... TABLA5.
9.+02 ....................................... TABLA2.
0.00 ........................................ FECHA DE REPARTO. DE MOMENTO 00.
1.0 ......................................... HORA DE REPARTO. DE MOMENTO 0.
2.000 ....................................... TABLA1.
3.006 ....................................... PAIS ISO ORIGEN.006 ESPAÑA.
4.PT ........................................ PAIS DESTINO ES ESPAÑA. PT PORTUGAL. VER PAISESF.
5001 ...................................... CODIGO POSTAL DESTINO DE 5 POSICIONES.EN CASO DE PORTUGAL QUITAR EL 7 Y CONVERTIR A 4 DI
6.OBSERVACIONES1 ............................ OBSERVACIONES1. 40 POSICIONES.
7.OBSERVACIONES2 ............................ OBSERVACIONES2. 40 POSICIONES.
8.12345678901234567 ......................... REFERENCIA 35 POSICIONES.
9.1 ......................................... LITERAL. BULTO RELATIVO.
0.001 ....................................... LITERAL. BULTO RELATIVO.
1.P2 ........................................ LITERAL+BULTOS TOTALES.
2.INTRO.
         */



        /// Exportación a dhl

        RecCE.Get;
        RUTA := 'C:\';
        TIPO := 3;
        BUSCAEXTENSION;

        if Rec110."Total bultos" <> 0 then begin
            DAT2 := 'ETIDHL' + EXTEN + Format(ALEA) + '.TXT';
            TempBlob.CreateInStream(InStream);
            FicherosHagen.CrearFichero(RUTA, DAT2, InStream);
        end;
        /////- VER DHL


    end;


    procedure ETISTD(var Rec: Record "Sales Shipment Header")
    begin


        TempBlob.CreateOutStream(OutStream);

        /// STD

        Rec110.Get(Rec."No.");



        TIPO := 3;
        BUSCAEXTENSION;
        if Rec110."Nº expedición dropshp" = '' then begin
            EXTEN := EXTEN + Format(Rec110."Nº expedición");
        end;
        if Rec110."Nº expedición dropshp" <> '' then begin
            EXTEN := EXTEN + Format(Rec110."Nº expedición dropshp");
        end;


        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOMa1 := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOMa1 := ConvertStr(DESNOMa1, 'º', '.');
        DESNOMa1 := CASCII.Ascii2Ansi(DESNOMa1);
        if Rec110."Ship-to Name" <> '' then begin
            DESNOMa1 := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 50), 'ª', '.');
            DESNOMa1 := ConvertStr(DESNOMa1, 'º', '.');
            DESNOMa1 := CASCII.Ascii2Ansi(DESNOMa1);
        end;
        if Rec110."Ship-to Name 2" <> '' then begin
            DESNOMa2 := ConvertStr(CopyStr(Rec110."Ship-to Name 2", 1, 50), 'ª', '.');
            DESNOMa2 := ConvertStr(DESNOMa2, 'º', '.');
            DESNOMa2 := CASCII.Ascii2Ansi(DESNOMa2);
        end;

        DESNOMa3 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 50), 'ª', '.');
        DESNOMa3 := ConvertStr(DESNOMa3, 'º', '.');
        DESNOMa3 := CASCII.Ascii2Ansi(DESNOMa3);
        DESNOMa4 := ConvertStr(CopyStr(Rec110."Ship-to Address 2", 1, 50), 'ª', '.');
        DESNOMa4 := ConvertStr(DESNOMa4, 'º', '.');
        DESNOMa4 := CASCII.Ascii2Ansi(DESNOMa4);


        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec110."Ship-to Country/Region Code";
        if Rec110."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec110."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;

        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec110."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec110."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec110."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL2 := Format(RecCusto."Phone No.");
        if RecCusto."Nº movil" <> '' then begin
            NTEL2 := Format(RecCusto."Nº movil");
        end;
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            NTEL2 := Format(Rec110."Envio a-Nº Telefono");
        end;




        REEMBOLSO := '';




        TEMAIL := RecCusto."E-Mail";
        if Rec110."E-MAIL" <> '' then begin
            TEMAIL := Rec110."E-MAIL";
        end;
        SERVIRDABADO := 'N';
        if Rec110."Servir sabado" then begin
            SERVIRDABADO := 'S';
        end;

        RecTra.Get(Rec110."Shipping Agent Code");


        if RecTra.Potyugal then begin
            NTEL2 := ConvertStr(NTEL2, '+', ' ');
        end;


        xx := 0;

        ntel3 := '';
        repeat
            xx := xx + 1;
            if (CopyStr(NTEL2, xx, 1) = '0') or
               (CopyStr(NTEL2, xx, 1) = '1') or
               (CopyStr(NTEL2, xx, 1) = '2') or
               (CopyStr(NTEL2, xx, 1) = '3') or
               (CopyStr(NTEL2, xx, 1) = '4') or
               (CopyStr(NTEL2, xx, 1) = '5') or
               (CopyStr(NTEL2, xx, 1) = '6') or
               (CopyStr(NTEL2, xx, 1) = '7') or
               (CopyStr(NTEL2, xx, 1) = '8') or
               (CopyStr(NTEL2, xx, 1) = '9') then begin
                ntel3 := ntel3 + (CopyStr(NTEL2, xx, 1));
            end;

        until xx > StrLen(NTEL2);

        NTEL2 := ntel3;



        elpeso := Rec110."Total peso";

        if Rec110."Total peso" = 0 then begin
            elpeso := 0;
            TOTALPALE := 0;
            Rec1102.Reset;
            Rec1102.SetCurrentkey(Rec1102."Nº expedición");
            Rec1102.SetRange(Rec1102."Nº expedición", Rec110."Nº expedición");
            if Rec1102.FindSet then
                repeat
                    TOTALPALE := TOTALPALE + Rec1102."Nº Palets";
                    REC1112.Reset;
                    REC1112.SetRange(REC1112."Document No.", Rec1102."No.");
                    if REC1112.FindSet then
                        repeat
                            elpeso := elpeso + REC1112.Quantity * REC1112."Gross Weight";
                        until REC1112.Next = 0;
                until Rec1102.Next = 0;
            if TOTALPALE <> 0 then begin
                elpeso := elpeso + 10 * TOTALPALE;
            end;
        end;


        elpeso := BuscaPesoEtiquetaEnvio(elpeso, Rec110."Shipping Agent Code", Rec110."Ship-to Post Code");


        decre := 1;
        if RecTra.Get(Rec110."Shipping Agent Code") then begin
            if RecTra."Decremento kilo" <> 0 then begin
                decre := (100 - RecTra."Decremento kilo") / 100;
            end;
        end;
        elpeso := ROUND(elpeso * decre, 1);

        if elpeso < 1 then begin
            elpeso := 1;
        end;

        CODPAIES2 := '';
        codpais := '';
        cospostat := '';
        /////IF Rec110."Ship-to Country/Region Code"<>'ES' THEN BEGIN
        codpais := Rec110."Ship-to Country/Region Code";
        CODPAIES2 := '0';
        cospostat := Rec110."Ship-to Post Code";
        /////END;
        if Rec110."Ship-to Country/Region Code" = 'PT' then begin
            codpais := 'PT';
            ///// Rec110."Ship-to Country/Region Code";
            CODPAIES2 := '6';
            cospostat := CopyStr(Rec110."Ship-to Post Code", 1, 4) + CopyStr(Rec110."Ship-to Post Code", 6, 3);
            cospostat := CopyStr(Rec110."Ship-to Post Code", 1, 4) + '-' + CopyStr(Rec110."Ship-to Post Code", 6, 3);
        end;

        RecTra.Get(Rec110."Shipping Agent Code");

        totalbultos := Rec110."Nº bultos" + Rec110."Nº Palets";
        ///MESSAGE('%1',totalbultos);


        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;
        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;


        TextoSalida1 := Format(DESNOMa1, 50) +
                      Format(DESNOMa2, 50) +
                      Format(DESNOMa3, 50) +
                      Format(DESNOMa4, 50);
        TextoSalida2 := Format(Rec110."Ship-to Post Code", 5) +
                      Format(Rec110."Ship-to City", 30) +
                      Format(Rec110."Ship-to County", 30) +
                      Format(Rec110."Ship-to Contact", 50);
        TextoSalida3 := Format(NTEL2, 30) +
                      Format(NEXPEDICION + ' ' + Rec110."Your Reference", 60) +
                      Format(NEXPEDICION, 30) +
                      Format(Rec110."Your Reference", 30) +
                      Format(totalbultos, 10) +
                      Format(elpeso, 10) +
                      Format(Rec110.Reembolso, 10);
        if not RecTra.Potyugal then begin
            TextoSalida4 := Format(OBSERV1, 40) +
                          Format(OBSERV2, 40) +
                          Format(DD1 + MM1 + AA1, 8) +
                          Format(TEMAIL, 80) +
                          Format(SERVIRDABADO, 1) +
                          Format(Rec110."Importe seguro envio", 10) +
                          Format(RecTra."Texto final fichero", 30) +
                          Format(codpais, 2) +
                          Format(CODPAIES2, 2) +
                          Format(cospostat, 6);
            TextoSalida5 := '';
            if ShippingAgentServices.Get(Rec110."Shipping Agent Code", Rec110."Shipping Agent Service Code") then begin

                TextoSalida5 := Format(ShippingAgentServices."Codigo Servicio", 10) +
                          Format(ShippingAgentServices.Horario, 10);

            end;

        end;
        if RecTra.Potyugal then begin
            TextoSalida4 := Format(OBSERV1, 40) +
                          Format(OBSERV2, 40) +
                          Format(DD1 + MM1 + AA1, 8) +
                          Format(TEMAIL, 80) +
                          Format(SERVIRDABADO, 1) +
                          Format(Rec110."Importe seguro envio", 10) +
                          Format(RecTra."Texto final fichero", 30) +
                          Format(codpais, 2) +
                          Format(cospostat, 8);
            TextoSalida5 := '';
            if ShippingAgentServices.Get(Rec110."Shipping Agent Code", Rec110."Shipping Agent Service Code") then begin

                TextoSalida5 := Format(' ', 1) + Format(ShippingAgentServices."Codigo Servicio", 9) +
                          Format(ShippingAgentServices.Horario, 10);
            end;

        end;





        /// 46000135-01 -> ROILF C HAGEN ESPAÑA S.A.
        /// 46000135-02 -> CATIT.ES


        TextoSalida6 := '';
        TextoSalida7 := '';
        if RecTra."Grupo clientes" <> '' then begin
            Rec110.CalcFields("Grupo clientes");
            if RecTra."Grupo clientes" = Rec110."Grupo clientes" then begin
                TextoSalida6 := Format('CATIT.ES Av Beniparrel 11 Silla 46460 Valencia España');
            end;
        end;
        if Rec110."Shipping Agent Code" = 'SENDING' then begin
            if RecTra."Grupo clientes" <> '' then begin
                TextoSalida6 := Format('46000135-01');
                Rec110.CalcFields("Grupo clientes");
                if RecTra."Grupo clientes" = Rec110."Grupo clientes" then begin
                    TextoSalida6 := Format('46000135-02');
                end;
            end;

        end;
        /*
        
        Posición
        
        pais destino=2
        2
        715
        postal destino=7
        7
        717
        
        Los codigos postales como los de Portugal hay que quitarles el espacio que tienen deben de ser numero seguidos
        
        */


        OutStream.Writetext(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5 + TextoSalida6 + TextoSalida7);

        Sleep(3000);


        /// Exportación a dhl

        RecCE.Get;
        /////RUTA:='\\192.168.0.225\agencias\TIPSA\';


        RecTra.Get(Rec110."Shipping Agent Code");
        RUTA := RecTra."Ruta fichero";


        /////IF RecCusto."No."='4703' THEN BEGIN
        /////                    RUTA:='\\192.168.0.225\agencias\m\';
        /////END;
        if COMPANYNAME = 'PEPE' then begin
            RecTra.Get(Rec110."Shipping Agent Code");
            RUTA := RecTra."Ruta fichero";
        end;


        DAT2 := 'ETISTD' + EXTEN + Format(ALEA) + '.TXT';
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);



    end;


    procedure EtiTIPSA(var Rec: Record "Sales Shipment Header")
    begin


        Rec110.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);


        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);


        DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;
        TELEFONO := RecCusto."Phone No.";
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            TELEFONO := Rec110."Envio a-Nº Telefono";
        end;



        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;
        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;

        NEXPE := '4612345670';
        TextoSalida4 := '';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := 'FR"DHL"';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '?';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := DESNOM;
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := TELEFONO;
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := DESNOM2;
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Rec110."Ship-to City";
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Rec110."Ship-to Post Code";
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Rec110."Ship-to County";
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := NEXPE;
        OutStream.Writetext(TextoSalida4);

        TextoSalida4 := '8';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Format(Rec110."Total bultos");
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '46';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '1234567';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '0';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := RecIE.Name;
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := CopyStr(Rec110."Ship-to Post Code", 1, 2);
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '+02';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '00';
        OutStream.Writetext(TextoSalida4);

        TextoSalida4 := '0';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '000';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '006';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := 'ES';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Rec110."Ship-to Post Code";
        OutStream.Writetext(TextoSalida4);

        TextoSalida4 := 'TOTAL BULTOS: ' + Format(Rec110."Total bultos");
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := NEXPEDICION;
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '1';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '001';
        OutStream.Writetext(TextoSalida4);

        TextoSalida4 := 'P' + Format(Rec110."Total bultos");
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '';
        OutStream.Writetext(TextoSalida4);
        TEMAIL := RecCusto."E-Mail";
        if Rec110."E-MAIL" <> '' then begin
            TEMAIL := Rec110."E-MAIL";
        end;
        TextoSalida4 := TEMAIL;
        OutStream.Writetext(TextoSalida4);

        /*
1.INTRO
2.FR"DHL"  .................................. LITERAL.
3.? ......................................... LITERAL.
4.SUM INDUSTRIALES CLEMENTE ................. DESTINATARIO DE 40 POSICIONES.
5.943123456 ................................. TELEFONO DESTINATARIO DE 9 POSICIONES.
6.POLIGONO INDUSTRIAL BELARTZA C/3 .......... DIRECCION DE DESTINATARIO 40 POSICIONES.
7.LISBOA .................................... POBLACION DE DESTINO 20 POSICIONES.
8.71001 ..................................... CODIGO POSTAL DE DESTINO DE 5 POSICIONES.
9.LISBOA .................................... TABLA3.
0.7112345670 ................................ TABLA4.
1.5 ......................................... ULTIMO DIGITO DEL AÑO.
2.2 ......................................... BULTOS TOTAL.
3..46 ........................................ ORIGEN.(tabla4)
4.01234567 .................................. NUMERO DE EXPEDICION DE 8 DIGITOS.
5.0 ......................................... LITERAL.
6.LUANVI   .................................. REMITENTE.40 POSICIONES.
7.C.O.D. .................................... EN CASO DE REEMBOLSO PONER C.O.D. , SINO INTRO.
8.71   ...................................... TABLA5.
9.+02 ....................................... TABLA2.
0.00 ........................................ FECHA DE REPARTO. DE MOMENTO 00.
1.0 ......................................... HORA DE REPARTO. DE MOMENTO 0.
2.000 ....................................... TABLA1.
3.006 ....................................... PAIS ISO ORIGEN.006 ESPAÑA.
4.PT ........................................ PAIS DESTINO ES ESPAÑA. PT PORTUGAL. VER PAISESF.
5001 ...................................... CODIGO POSTAL DESTINO DE 5 POSICIONES.EN CASO DE PORTUGAL QUITAR EL 7 Y CONVERTIR A 4 DI
6.OBSERVACIONES1 ............................ OBSERVACIONES1. 40 POSICIONES.
7.OBSERVACIONES2 ............................ OBSERVACIONES2. 40 POSICIONES.
8.12345678901234567 ......................... REFERENCIA 35 POSICIONES.
9.1 ......................................... LITERAL. BULTO RELATIVO.
0.001 ....................................... LITERAL. BULTO RELATIVO.
1.P2 ........................................ LITERAL+BULTOS TOTALES.
2.INTRO.
         */



        /// Exportación a dhl

        RecCE.Get;
        RUTA := 'C:\';
        rut := '\\192.168.0.16\a_gestion\a_gestion\ini\';
        TIPO := 3;
        BUSCAEXTENSION;

        DAT2 := 'ETITIPSA' + EXTEN + Format(ALEA) + '.TXT';
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);


    end;


    procedure EtiCORR(var Rec: Record "Sales Shipment Header")
    begin




        Rec110.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);


        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);


        DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;
        TELEFONO := RecCusto."Phone No.";
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            TELEFONO := Rec110."Envio a-Nº Telefono";
        end;


        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;
        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;

        NEXPE := '4612345670';
        TextoSalida4 := '';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := 'FR"CORR"';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '?';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := DESNOM;
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := TELEFONO;
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := DESNOM2;
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Rec110."Ship-to City";
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Rec110."Ship-to Post Code";
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Rec110."Ship-to County";
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := NEXPE;
        OutStream.Writetext(TextoSalida4);

        TextoSalida4 := '8';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Format(Rec110."Total bultos");
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '46';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '1234567';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '0';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := RecIE.Name;
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := CopyStr(Rec110."Ship-to Post Code", 1, 2);
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '+02';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '00';
        OutStream.Writetext(TextoSalida4);

        TextoSalida4 := '0';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '000';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '006';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := 'ES';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := Rec110."Ship-to Post Code";
        OutStream.Writetext(TextoSalida4);

        TextoSalida4 := 'TOTAL BULTOS: ' + Format(Rec110."Total bultos");
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := NEXPEDICION;
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '1';
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '001';
        OutStream.Writetext(TextoSalida4);

        TextoSalida4 := 'P' + Format(Rec110."Total bultos");
        OutStream.Writetext(TextoSalida4);
        TextoSalida4 := '';
        OutStream.Writetext(TextoSalida4);
        TEMAIL := RecCusto."E-Mail";
        if Rec110."E-MAIL" <> '' then begin
            TEMAIL := Rec110."E-MAIL";
        end;
        TextoSalida4 := TEMAIL;
        OutStream.Writetext(TextoSalida4);

        /*
1.INTRO
2.FR"DHL"  .................................. LITERAL.
3.? ......................................... LITERAL.
4.SUM INDUSTRIALES CLEMENTE ................. DESTINATARIO DE 40 POSICIONES.
5.943123456 ................................. TELEFONO DESTINATARIO DE 9 POSICIONES.
6.POLIGONO INDUSTRIAL BELARTZA C/3 .......... DIRECCION DE DESTINATARIO 40 POSICIONES.
7.LISBOA .................................... POBLACION DE DESTINO 20 POSICIONES.
8.71001 ..................................... CODIGO POSTAL DE DESTINO DE 5 POSICIONES.
9.LISBOA .................................... TABLA3.
0.7112345670 ................................ TABLA4.
1.5 ......................................... ULTIMO DIGITO DEL AÑO.
2.2 ......................................... BULTOS TOTAL.
3..46 ........................................ ORIGEN.(tabla4)
4.01234567 .................................. NUMERO DE EXPEDICION DE 8 DIGITOS.
5.0 ......................................... LITERAL.
6.LUANVI   .................................. REMITENTE.40 POSICIONES.
7.C.O.D. .................................... EN CASO DE REEMBOLSO PONER C.O.D. , SINO INTRO.
8.71   ...................................... TABLA5.
9.+02 ....................................... TABLA2.
0.00 ........................................ FECHA DE REPARTO. DE MOMENTO 00.
1.0 ......................................... HORA DE REPARTO. DE MOMENTO 0.
2.000 ....................................... TABLA1.
3.006 ....................................... PAIS ISO ORIGEN.006 ESPAÑA.
4.PT ........................................ PAIS DESTINO ES ESPAÑA. PT PORTUGAL. VER PAISESF.
5001 ...................................... CODIGO POSTAL DESTINO DE 5 POSICIONES.EN CASO DE PORTUGAL QUITAR EL 7 Y CONVERTIR A 4 DI
6.OBSERVACIONES1 ............................ OBSERVACIONES1. 40 POSICIONES.
7.OBSERVACIONES2 ............................ OBSERVACIONES2. 40 POSICIONES.
8.12345678901234567 ......................... REFERENCIA 35 POSICIONES.
9.1 ......................................... LITERAL. BULTO RELATIVO.
0.001 ....................................... LITERAL. BULTO RELATIVO.
1.P2 ........................................ LITERAL+BULTOS TOTALES.
2.INTRO.
         */



        /// Exportación a dhl

        RecCE.Get;
        TIPO := 3;
        BUSCAEXTENSION;

        DAT2 := 'ETICORR' + EXTEN + Format(ALEA) + '.TXT';
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);


    end;


    procedure REGISTRAkits(var Rec83: Record "Item Journal Line")
    begin







        Rec83.Reset;
        Rec83.SetRange(Rec83."Journal Template Name", 'ELEMENTO');
        Rec83.SetRange(Rec83."Journal Batch Name", 'KITS');
        if Rec83.FindFirst then begin
            CURegMov.Run(Rec83);
        end;
    end;


    procedure EtiDHL2(var Rec: Record "Sales Shipment Header")
    begin

        /// dhl2

        Rec110.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);




        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec110."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;


        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;

        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;

        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec110."Ship-to Country/Region Code";
        if Rec110."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec110."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;

        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec110."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL := RecCusto."Phone No.";
        if RecCusto."Nº movil" <> '' then begin
            NTEL := RecCusto."Nº movil";
        end;
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            NTEL := Rec110."Envio a-Nº Telefono";
        end;

        REEMBOLSO := '';

        totapeso := ROUND(Rec."Total peso", 0.01);
        /*

        TextoSalida4 := FORMAT('004855',6)+
                         ANO2+
                         PAISDES+
                         NEXPE+
                         '0'+
                         '  '+
                         FORMAT(DESNOM,40)+
                         FORMAT(DESNOM2,40)+
                         FORMAT(Rec110."Ship-to City",20);
TextoSalida5 :=           FORMAT(Rec110."Ship-to Post Code",5)+
                         FORMAT('',4)+
                         FORMAT(NTEL,9)+
                         ' '+
                         FORMAT(NEXPEDICION,35)+
                         '  '+
                         FORMAT(Rec."Total bultos",3)+
                         FORMAT(totapeso,5)+
                         '     '+
                         '           '+
                         'EUR'+
                         'P'+
                         '         '+
                         'EUR'+
                         'P'+
                         ' '+
                         ' '+
                         FORMAT(OBSERV1,40)+
                         FORMAT(OBSERV2,40)+
                         ' '+
                         DD1+MM1+AA1;
  TextoSalida3 :=        FORMAT('',125)+
                         'CPT'+
                         '102'+
                         FORMAT(Rec110."Ship-to Post Code",5);
        ArchSalida4.WRITE(TextoSalida4+TextoSalida5+TextoSalida3);

*/
        cospostat := Rec110."Ship-to Post Code";
        if Rec110."Ship-to Country/Region Code" = 'PT' then begin
            ///     codpais:='PT';
            ///CODPAIES2:='6';
            cospostat := CopyStr(Rec110."Ship-to Post Code", 1, 4) + '-' + CopyStr(Rec110."Ship-to Post Code", 6, 3);
        end;

        TextoSalida4 := Format(DESNOM) + ';' +
                                  Format(DESNOM2) + ';' +
                                  Format(Rec110."Ship-to City") + ';';
        TextoSalida5 := Format(cospostat) + ';' +
                                  Format(Rec110."Ship-to Country/Region Code") + ';' +
                                  Format(NTEL) + ';' +
                                  Format(RecCusto."E-Mail") + ';' +
                                  Format(Rec."Total bultos") + ';' +
                                  Format(totapeso) + ';' +
                                  Format(NEXPEDICION) + ';' +
                                  Format(OBSERV1 + OBSERV2) + ';' +
                                  '' + ';' +
                                  '' + ';' +
                                  '0';


        OutStream.Writetext(TextoSalida4 + TextoSalida5);


        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\DHL\';

        TIPO := 3;
        BUSCAEXTENSION;


        DAT2 := 'ETIDHL' + EXTEN + Format(ALEA) + '.txt';
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);


    end;


    procedure EtiTIPSA2(var Rec: Record "Sales Shipment Header")
    begin


        Rec110.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);



        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec110."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec110."Ship-to Country/Region Code";
        if Rec110."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec110."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;

        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec110."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            NTEL := Format(Rec110."Envio a-Nº Telefono", 9);
        end;

        REEMBOLSO := '';


        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;

        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;

        totapeso := ROUND(Rec."Total peso" / 2, 0.01);

        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(Rec110."Ship-to City", 20);
        TextoSalida5 := Format(Rec110."Ship-to Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(NEXPEDICION, 35) +
                                  '  ' +
                                  Format(Rec."Total bultos", 3) +
                                  Format(totapeso, 5) +
                                  '     ' +
                                  '           ' +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;

        TEMAIL := RecCusto."E-Mail";
        if Rec110."E-MAIL" <> '' then begin
            TEMAIL := Rec110."E-MAIL";
        end;

        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(Rec110."Ship-to Post Code", 5) +
                               TEMAIL;

        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);


        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\TIPSA\';

        if RecCusto."No." = '4703' then begin
            RUTA := '\\192.168.0.225\agencias\m\';
        end;
        if COMPANYNAME = 'PEPE' then begin
            RecTra.Get(Rec110."Shipping Agent Code");
            RUTA := RecTra."Ruta fichero";
        end;




        TIPO := 3;
        BUSCAEXTENSION;

        if Rec."Total bultos" <> 0 then begin
            DAT2 := 'ETITIPSA' + EXTEN + Format(ALEA) + '.txt';
            TempBlob.CreateInStream(InStream);
            FicherosHagen.CrearFichero(RUTA, DAT2, InStream);
        END;


    end;


    procedure EtiTCORR2(var Rec: Record "Sales Shipment Header")
    begin
        /// oscar

        Rec110.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);



        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec110."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec110."Ship-to Country/Region Code";
        if Rec110."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec110."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;

        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec110."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            NTEL := Format(Rec110."Envio a-Nº Telefono", 9);
        end;

        REEMBOLSO := '';

        DREEMBOLSO := (Rec110.Reembolso - Rec110."Importe a descontar reembolso") * 100;

        REEMBOLSO := ConvertStr(Format(DREEMBOLSO, 11, Text1100007), ' ', '0');



        pesoini := (Rec."Total peso" / 2) * 1000;
        if pesoini > 99999 then begin
            pesoini := 99999;
        end;



        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;

        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;

        celpeso := ConvertStr(Format(pesoini, 5, Text1100007), ' ', '0');

        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(Rec110."Ship-to City", 20);
        TextoSalida5 := Format(Rec110."Ship-to Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(NEXPEDICION, 35) +
                                  '  ' +
                                  Format(Rec."Total bultos", 3) +
                                  Format(celpeso, 5) +
                                  '     ' +
                                  REEMBOLSO +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;

        TEMAIL := RecCusto."E-Mail";
        if Rec110."E-MAIL" <> '' then begin
            TEMAIL := Rec110."E-MAIL";
        end;

        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(Rec110."Ship-to Post Code", 5) +
                               Format('', 5) +
                               Format(TEMAIL);

        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);


        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\Correos\';

        if RecCusto."No." = '4703' then begin
            RUTA := '\\192.168.0.225\agencias\m\';
        end;
        if COMPANYNAME = 'PEPE' then begin
            RecTra.Get(Rec110."Shipping Agent Code");
            RUTA := RecTra."Ruta fichero";
        end;




        TIPO := 3;
        BUSCAEXTENSION;

        DAT2 := 'ETICORR' + EXTEN + Format(ALEA) + '.txt';
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure Eticrono2(var Rec: Record "Sales Shipment Header")
    begin



        Rec110.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);

        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 40), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec110."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 40), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 40), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec110."Ship-to Country/Region Code";
        if Rec110."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec110."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec110."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            NTEL := Format(Rec110."Envio a-Nº Telefono", 9);
        end;

        REEMBOLSO := '';


        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;

        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;

        totapeso := ROUND(Rec."Total peso" / 2, 0.01);

        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(Rec110."Ship-to City", 20);
        TextoSalida5 := Format(Rec110."Ship-to Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(NEXPEDICION, 35) +
                                  '  ' +
                                  Format(Rec."Total bultos", 3) +
                                  Format(totapeso, 5) +
                                  '     ' +
                                  '           ' +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;
        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(Rec110."Ship-to Post Code", 5);

        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);

        /// Exportación a dhl

        RecCE.Get;

        RUTA := '\\192.168.0.225\agencias\Crono\';
        if RecCusto."No." = '4703' then begin
            RUTA := '\\192.168.0.225\agencias\m\';
        end;
        if COMPANYNAME = 'PEPE' then begin
            RecTra.Get(Rec110."Shipping Agent Code");
            RUTA := RecTra."Ruta fichero";
        end;

        TIPO := 3;
        BUSCAEXTENSION;


        if Rec."Total bultos" <> 0 then begin
            DAT2 := 'ETIDHL' + EXTEN + Format(ALEA) + '.txt';
            TempBlob.CreateInStream(InStream);
            FicherosHagen.CrearFichero(RUTA, DAT2, InStream);
        END;


    end;


    procedure EtiBUYTRAGO(var Rec: Record "Sales Shipment Header")
    begin

        Rec110.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);




        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 40), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec110."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 40), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 40), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec110."Ship-to Country/Region Code";
        if Rec110."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec110."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec110."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            NTEL := Format(Rec110."Envio a-Nº Telefono", 9);
        end;

        REEMBOLSO := '';


        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;

        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;

        totapeso := ROUND(Rec."Total peso" / 2, 0.01);

        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(Rec110."Ship-to City", 20);
        TextoSalida5 := Format(Rec110."Ship-to Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(NEXPEDICION, 35) +
                                  '  ' +
                                  Format(Rec."Total bultos", 3) +
                                  Format(totapeso, 5) +
                                  '     ' +
                                  '           ' +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;
        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(Rec110."Ship-to Post Code", 5);
        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);


        /// Exportación a dhl

        RecCE.Get;

        RUTA := '\\192.168.0.225\agencias\Crono\';
        if RecCusto."No." = '4703' then begin
            RUTA := '\\192.168.0.225\agencias\m\';
        end;
        TIPO := 3;
        BUSCAEXTENSION;

        if Rec."Total bultos" <> 0 then begin
            DAT2 := 'ETIDHL' + EXTEN + Format(ALEA) + '.txt';
            TempBlob.CreateInStream(InStream);
            FicherosHagen.CrearFichero(RUTA, DAT2, InStream);
        END;

    end;


    procedure EtiSEUR(var Rec: Record "Sales Shipment Header")
    begin


        Rec110.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);




        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := ConvertStr(DESNOM, ',', ' ');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec110."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := ConvertStr(DESNOM, ',', ' ');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
        DESNOM2 := ConvertStr(DESNOM2, ',', ' ');

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec110."Ship-to Country/Region Code";
        if Rec110."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec110."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';


        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;

        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;

        OBSERV1 := CopyStr(Rec110."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;
        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(Rec110."Ship-to City", 20);

        DESNOM2 := ConvertStr(CopyStr(RecCusto.Address, 1, 40), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM, 'º', '.');
        DESNOM2 := ConvertStr(DESNOM, ',', ' ');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
        DESNOM3 := ConvertStr(CopyStr(RecCusto."Address 2", 1, 40), 'ª', '.');
        DESNOM3 := ConvertStr(DESNOM, 'º', '.');
        DESNOM3 := ConvertStr(DESNOM, ',', ' ');
        DESNOM3 := CASCII.Ascii2Ansi(DESNOM3);
        if Rec110."Ship-to Address" <> '' then begin
            DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 40), 'ª', '.');
            DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
            DESNOM2 := ConvertStr(DESNOM2, ',', ' ');
            DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
            DESNOM3 := ConvertStr(CopyStr(Rec110."Ship-to Address 2", 1, 40), 'ª', '.');
            DESNOM3 := ConvertStr(DESNOM3, 'º', '.');
            DESNOM3 := ConvertStr(DESNOM3, ',', ' ');
            DESNOM3 := CASCII.Ascii2Ansi(DESNOM3);
        end;


        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            NTEL := Format(Rec110."Envio a-Nº Telefono", 9);
        end;




        totapeso := ROUND(Rec."Total peso" / 2, 0.01);

        TextoSalida5 := Format(Rec110."Ship-to Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(NEXPEDICION, 35) +
                                  '  ' +
                                  Format(Rec."Total bultos", 3) +
                                  Format(totapeso, 5) +
                                  '     ' +
                                  '           ' +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;
        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(Format(DESNOM2) + ' ' + Format(DESNOM3), 50);

        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);


        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\SEUR\';


        TIPO := 3;
        BUSCAEXTENSION;

        DAT2 := 'hagenseur.txt';
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure ENVIOSMS(var Rec: Record "Sales Shipment Header")
    begin


        Rec110.Get(Rec."No.");


        RecCusto.Get(Rec110."Sell-to Customer No.");

        ///IF RecCusto."Servicio SMS" THEN BEGIN

        ///ecIE.GET;
        ///
        ///NTEL:=FORMAT(RecCusto."Phone No.",9);
        ///IF RecCusto."Nº movil"<>'' THEN BEGIN
        ///NTEL:=FORMAT(RecCusto."Nº movil",9);
        ///END;



        ///END;
        /// MOVIL + Nº PEDIDO ADAIA + TRASNPORTE + SU REF. + NUESTRO PEDIDO.
    end;


    procedure EtiDHLDESDEFAC(var Rec: Record "Sales Invoice Header")
    begin



        Rec112.Get(Rec."No.");

        TempBlob.CreateOutStream(OutStream);


        RecCusto.Get(Rec112."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec112."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec112."Ship-to Name", 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec112."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec112."Ship-to Country/Region Code";
        if Rec112."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec112."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec112."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;
        if Rec112."Envio a-Nº Telefono" <> '' then begin
            NTEL := Format(Rec112."Envio a-Nº Telefono", 9);
        end;


        DREEMBOLSO := 0;
        REEMBOLSO := '';
        RecFP.Get(Rec112."Payment Method Code");
        if RecFP.Reembolso then begin
            Rec112.CalcFields(Rec112."Amount Including VAT");
            DREEMBOLSO := (Rec112."Amount Including VAT" - Rec112."Importe a descontar reembolso") * 100;
        end;

        REEMBOLSO := ConvertStr(Format(DREEMBOLSO, 11, Text1100007), ' ', '0');


        elpeso := 0;
        TOTALPALE := 0;
        Rec1102.Reset;
        Rec1102.SetCurrentkey(Rec1102."Nº expedición");
        Rec1102.SetRange(Rec1102."Nº expedición", Rec."Nº expedición");
        if Rec1102.FindSet then
            repeat
                TOTALPALE := TOTALPALE + Rec1102."Nº Palets";
                REC1112.Reset;
                REC1112.SetRange(REC1112."Document No.", Rec1102."No.");
                if REC1112.FindSet then
                    repeat
                        elpeso := elpeso + REC1112.Quantity * REC1112."Gross Weight";
                    until REC1112.Next = 0;
            until Rec1102.Next = 0;
        if TOTALPALE <> 0 then begin
            elpeso := elpeso + 10 * TOTALPALE;
        end;


        elpeso := BuscaPesoEtiquetaEnvio(elpeso, Rec110."Shipping Agent Code", Rec110."Ship-to Post Code");

        decre := 1;
        if RecTra.Get(Rec110."Shipping Agent Code") then begin
            if RecTra."Decremento kilo" <> 0 then begin
                decre := (100 - RecTra."Decremento kilo") / 100;
            end;
        end;
        elpeso := ROUND(elpeso * decre, 1);

        if elpeso < 1 then begin
            elpeso := 1;
        end;


        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;

        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;



        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(Rec112."Ship-to City", 20);

        TextoSalida5 := Format(Rec112."Ship-to Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(NEXPEDICION, 35) +
                                  '  ' +
                                  Format(Rec."Total bultos", 3) +
                                  Format(elpeso, 5) +
                                  '     ' +
                                  REEMBOLSO +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;
        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(Rec112."Ship-to Post Code", 5);

        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);


        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\DHL\';

        TIPO := 3;
        BUSCAEXTENSION;

        DAT2 := 'ETIDHL' + EXTEN + Format(ALEA) + '.TXT';
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure EtitipsaDESDEFAC(var Rec: Record "Sales Invoice Header")
    begin

        Rec112.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);




        RecCusto.Get(Rec112."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec112."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec112."Ship-to Name", 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec112."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec112."Ship-to Country/Region Code";
        if Rec112."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec112."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec112."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;
        if Rec112."Envio a-Nº Telefono" <> '' then begin
            NTEL := Format(Rec112."Envio a-Nº Telefono", 9);
        end;


        DREEMBOLSO := 0;
        REEMBOLSO := '';
        RecFP.Get(Rec112."Payment Method Code");
        if RecFP.Reembolso then begin
            Rec112.CalcFields(Rec112."Amount Including VAT");
            DREEMBOLSO := (Rec112."Amount Including VAT" - Rec112."Importe a descontar reembolso") * 100;
        end;

        REEMBOLSO := ConvertStr(Format(DREEMBOLSO, 11, Text1100007), ' ', '0');


        elpeso := 0;
        TOTALPALE := 0;
        Rec1102.Reset;
        Rec1102.SetCurrentkey(Rec1102."Nº expedición");
        Rec1102.SetRange(Rec1102."Nº expedición", Rec."Nº expedición");
        if Rec1102.FindSet then
            repeat
                TOTALPALE := TOTALPALE + Rec1102."Nº Palets";
                REC1112.Reset;
                REC1112.SetRange(REC1112."Document No.", Rec1102."No.");
                if REC1112.FindSet then
                    repeat
                        elpeso := elpeso + REC1112.Quantity * REC1112."Gross Weight";
                    until REC1112.Next = 0;
            until Rec1102.Next = 0;
        if TOTALPALE <> 0 then begin
            elpeso := elpeso + 10 * TOTALPALE;
        end;


        elpeso := BuscaPesoEtiquetaEnvio(elpeso, Rec110."Shipping Agent Code", Rec110."Ship-to Post Code");

        decre := 1;
        if RecTra.Get(Rec110."Shipping Agent Code") then begin
            if RecTra."Decremento kilo" <> 0 then begin
                decre := (100 - RecTra."Decremento kilo") / 100;
            end;
        end;
        elpeso := ROUND(elpeso * decre, 1);

        if elpeso < 1 then begin
            elpeso := 1;
        end;



        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;

        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;


        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(Rec112."Ship-to City", 20);

        TextoSalida5 := Format(Rec112."Ship-to Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(NEXPEDICION, 35) +
                                  '  ' +
                                  Format(Rec."Total bultos", 3) +
                                  Format(elpeso, 5) +
                                  '     ' +
                                  REEMBOLSO +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;
        TEMAIL := RecCusto."E-Mail";
        if Rec112."E-MAIL" <> '' then begin
            TEMAIL := Rec112."E-MAIL";
        end;


        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(Rec112."Ship-to Post Code", 5) +
                               TEMAIL;


        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);


        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\TIPSA\';

        if RecCusto."No." = '4703' then begin
            RUTA := '\\192.168.0.225\agencias\m\';
        end;

        if COMPANYNAME = 'PEPE' then begin
            RecTra.Get(Rec112."Shipping Agent Code");
            RUTA := RecTra."Ruta fichero";
        end;


        TIPO := 3;
        BUSCAEXTENSION;

        if Rec."Total bultos" <> 0 then begin
            DAT2 := 'ETITIPSA.' + EXTEN + Format(ALEA) + '.TXT';
            TempBlob.CreateInStream(InStream);
            FicherosHagen.CrearFichero(RUTA, DAT2, InStream);
        END;

    end;


    procedure EtiCORRDESDEFAC(var Rec: Record "Sales Invoice Header")
    begin

        Rec112.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);




        RecCusto.Get(Rec112."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec112."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec112."Ship-to Name", 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec112."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec112."Ship-to Country/Region Code";
        if Rec112."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec112."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec112."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;
        if Rec112."Envio a-Nº Telefono" <> '' then begin
            NTEL := Format(Rec112."Envio a-Nº Telefono", 9);
        end;


        DREEMBOLSO := 0;
        REEMBOLSO := '';
        RecFP.Get(Rec112."Payment Method Code");
        if RecFP.Reembolso then begin
            Rec112.CalcFields(Rec112."Amount Including VAT");
            DREEMBOLSO := (Rec112."Amount Including VAT" - Rec112."Importe a descontar reembolso") * 100;
        end;

        REEMBOLSO := ConvertStr(Format(DREEMBOLSO, 11, Text1100007), ' ', '0');


        elpeso := 0;
        TOTALPALE := 0;
        Rec1102.Reset;
        Rec1102.SetCurrentkey(Rec1102."Nº expedición");
        Rec1102.SetRange(Rec1102."Nº expedición", Rec."Nº expedición");
        if Rec1102.FindSet then
            repeat
                TOTALPALE := TOTALPALE + Rec1102."Nº Palets";
                REC1112.Reset;
                REC1112.SetRange(REC1112."Document No.", Rec1102."No.");
                if REC1112.FindSet then
                    repeat
                        elpeso := elpeso + REC1112.Quantity * REC1112."Gross Weight";
                    until REC1112.Next = 0;
            until Rec1102.Next = 0;
        if TOTALPALE <> 0 then begin
            elpeso := elpeso + 10 * TOTALPALE;
        end;


        elpeso := BuscaPesoEtiquetaEnvio(elpeso, Rec110."Shipping Agent Code", Rec110."Ship-to Post Code");

        decre := 1;
        if RecTra.Get(Rec110."Shipping Agent Code") then begin
            if RecTra."Decremento kilo" <> 0 then begin
                decre := (100 - RecTra."Decremento kilo") / 100;
            end;
        end;
        elpeso := ROUND(elpeso * decre, 1);

        if elpeso < 1 then begin
            elpeso := 1;
        end;



        pesoini := elpeso * 1000;
        if pesoini > 99999 then begin
            pesoini := 99999;
        end;

        celpeso := ConvertStr(Format(pesoini, 5, Text1100007), ' ', '0');



        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(Rec112."Ship-to City", 20);

        TextoSalida5 := Format(Rec112."Ship-to Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(Rec."Nº expedición", 35) +
                                  '  ' +
                                  Format(Rec."Total bultos", 3) +
                                  Format(celpeso, 5) +
                                  '     ' +
                                  REEMBOLSO +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;
        TEMAIL := RecCusto."E-Mail";
        if Rec112."E-MAIL" <> '' then begin
            TEMAIL := Rec112."E-MAIL";
        end;


        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(Rec112."Ship-to Post Code", 5) +
                               Format('', 5) +
                               Format(TEMAIL);


        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);


        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\Correos\';

        if RecCusto."No." = '4703' then begin
            RUTA := '\\192.168.0.225\agencias\m\';
        end;


        TIPO := 3;
        BUSCAEXTENSION;

        if Rec."Total bultos" <> 0 then begin
            DAT2 := 'ETICORR.' + EXTEN + Format(ALEA) + '.TXT';
            TempBlob.CreateInStream(InStream);
            FicherosHagen.CrearFichero(RUTA, DAT2, InStream);
        END;

    end;


    procedure EtiSEURDESDEFAC(var Rec: Record "Sales Invoice Header")
    begin



        Rec112.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);



        RecCusto.Get(Rec112."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec112."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec112."Ship-to Name", 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec112."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec112."Ship-to Country/Region Code";
        if Rec112."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec112."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec112."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;

        if Rec112."Envio a-Nº Telefono" <> '' then begin
            NTEL := Format(Rec112."Envio a-Nº Telefono", 9);
        end;


        DREEMBOLSO := 0;
        REEMBOLSO := '';
        RecFP.Get(Rec112."Payment Method Code");
        if RecFP.Reembolso then begin
            Rec112.CalcFields(Rec112."Amount Including VAT");
            DREEMBOLSO := (Rec112."Amount Including VAT" - Rec112."Importe a descontar reembolso") * 100;
        end;

        REEMBOLSO := ConvertStr(Format(DREEMBOLSO, 11, Text1100007), ' ', '0');



        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(Rec112."Ship-to City", 20);


        DESNOM2 := ConvertStr(CopyStr(RecCusto.Address, 1, 40), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
        DESNOM3 := ConvertStr(CopyStr(RecCusto."Address 2", 1, 40), 'ª', '.');
        DESNOM3 := ConvertStr(DESNOM, 'º', '.');
        DESNOM3 := CASCII.Ascii2Ansi(DESNOM3);
        if Rec110."Ship-to Address" <> '' then begin
            DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 40), 'ª', '.');
            DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
            DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
            DESNOM3 := ConvertStr(CopyStr(Rec110."Ship-to Address 2", 1, 40), 'ª', '.');
            DESNOM3 := ConvertStr(DESNOM3, 'º', '.');
            DESNOM3 := CASCII.Ascii2Ansi(DESNOM3);
        end;


        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;



        totapeso := ROUND(Rec."Total peso" / 2, 0.01);


        TextoSalida5 := Format(Rec110."Ship-to Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(Rec."Nº expedición", 35) +
                                  '  ' +
                                  Format(Rec."Total bultos", 3) +
                                  Format(totapeso, 5) +
                                  '     ' +
                                  '           ' +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;
        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(Format(DESNOM2) + ' ' + Format(DESNOM3), 50);

        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);




        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\SEUR\';


        TIPO := 3;
        BUSCAEXTENSION;

        if Rec."Total bultos" <> 0 then begin
            DAT2 := 'hagenseur.txt';
            TempBlob.CreateInStream(InStream);
            FicherosHagen.CrearFichero(RUTA, DAT2, InStream);
        END;

    end;


    procedure ENVIOSMSimpagados(var RecRecor: Record "Reminder Header")
    begin


        RecCusto.Get(RecRecor."Customer No.");



    end;


    procedure ENVIOSMSagrupacion(var RecLD: Record "Gen. Journal Line")
    begin

    end;


    procedure ENVIOSMSrecibo(var RecRecor: Record "Reminder Header")
    begin

    end;


    procedure LANZARSMS()
    begin
        /*
                nomfich1 := '\\192.168.0.225\agencias\SMS\expediciones\expediciones.txt';
                ///nomfich2:='\\192.168.0.225\agencias\SMS\impagados\impagados.txt';
                ///nomfich3:='\\192.168.0.225\agencias\SMS\agrupacion\agrupacion.txt';




                Fichero.WriteMode(true);
                Fichero.TextMode(true);
                Fichero.QUERYREPLACE(true);
                if Fichero.Open(nomfich1) then begin   //existe el fichero, añado lineas
                    Fichero.SEEK(Fichero.LEN);
                end;

                CONTASMS := 0;
                Fichero.Close;




                Fichero.WriteMode(true);
                Fichero.TextMode(true);
                Fichero.QUERYREPLACE(true);
                if Fichero.Open(nomfich1) then begin   //existe el fichero, añado lineas
                    Fichero.SEEK(Fichero.LEN);
                end;

                CONTASMS := 0;

                Fichero.Close;




                Fichero.WriteMode(true);
                Fichero.TextMode(true);
                Fichero.QUERYREPLACE(true);
                if Fichero.Open(nomfich1) then begin   //existe el fichero, añado lineas
                    Fichero.SEEK(Fichero.LEN);
                end;

                CONTASMS := 0;


                if CONTASMS <> 0 then begin
                    Message('Sms enviados %1', CONTASMS);
                end;
                */
    end;


    procedure EtiSEURNUEVA(var Rec: Record "Sales Shipment Header")
    begin


        Rec110.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);

        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := ConvertStr(DESNOM, ',', ' ');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec110."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := ConvertStr(DESNOM, ',', ' ');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
        DESNOM2 := ConvertStr(DESNOM2, ',', ' ');

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec110."Ship-to Country/Region Code";
        if Rec110."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec110."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';



        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;

        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;

        OBSERV1 := CopyStr(Rec110."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;
        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(Rec110."Ship-to City", 20);

        DESNOM2 := ConvertStr(CopyStr(RecCusto.Address, 1, 40), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM, 'º', '.');
        DESNOM2 := ConvertStr(DESNOM, ',', ' ');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
        DESNOM3 := ConvertStr(CopyStr(RecCusto."Address 2", 1, 40), 'ª', '.');
        DESNOM3 := ConvertStr(DESNOM, 'º', '.');
        DESNOM3 := ConvertStr(DESNOM, ',', ' ');
        DESNOM3 := CASCII.Ascii2Ansi(DESNOM3);
        if Rec110."Ship-to Address" <> '' then begin
            DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 40), 'ª', '.');
            DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
            DESNOM2 := ConvertStr(DESNOM2, ',', ' ');
            DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
            DESNOM3 := ConvertStr(CopyStr(Rec110."Ship-to Address 2", 1, 40), 'ª', '.');
            DESNOM3 := ConvertStr(DESNOM3, 'º', '.');
            DESNOM3 := ConvertStr(DESNOM3, ',', ' ');
            DESNOM3 := CASCII.Ascii2Ansi(DESNOM3);
        end;


        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            NTEL := Format(Rec110."Envio a-Nº Telefono", 9);
        end;



        elpeso := 0;
        TOTALPALE := 0;
        Rec1102.Reset;
        Rec1102.SetCurrentkey(Rec1102."Nº expedición");
        Rec1102.SetRange(Rec1102."Nº expedición", Rec."Nº expedición");
        if Rec1102.FindSet then
            repeat
                TOTALPALE := TOTALPALE + Rec1102."Nº Palets";
                REC1112.Reset;
                REC1112.SetRange(REC1112."Document No.", Rec1102."No.");
                if REC1112.FindSet then
                    repeat
                        elpeso := elpeso + REC1112.Quantity * REC1112."Gross Weight";
                    until REC1112.Next = 0;
            until Rec1102.Next = 0;
        if TOTALPALE <> 0 then begin
            elpeso := elpeso + 10 * TOTALPALE;
        end;



        elpeso := BuscaPesoEtiquetaEnvio(elpeso, Rec110."Shipping Agent Code", Rec110."Ship-to Post Code");

        decre := 1;
        if RecTra.Get(Rec110."Shipping Agent Code") then begin
            if RecTra."Decremento kilo" <> 0 then begin
                decre := (100 - RecTra."Decremento kilo") / 100;
            end;
        end;
        elpeso := ROUND(elpeso * decre, 1);

        if elpeso < 1 then begin
            elpeso := 1;
        end;



        TextoSalida5 := Format(Rec110."Ship-to Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(NEXPEDICION, 35) +
                                  '  ' +
                                  Format(Rec."Total bultos", 3) +
                                  Format(elpeso, 5) +
                                  '     ' +
                                  '           ' +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;
        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(Format(DESNOM2) + ' ' + Format(DESNOM3), 50);

        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);


        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\SEUR\';


        TIPO := 3;
        BUSCAEXTENSION;

        DAT2 := 'hagenseur.txt';
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure EtiDHL2NUEVA(var Rec: Record "Sales Shipment Header")
    begin


        Rec110.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);

        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec110."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec110."Ship-to Country/Region Code";
        if Rec110."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec110."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec110."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            NTEL := Format(Rec110."Envio a-Nº Telefono", 9);
        end;

        REEMBOLSO := '';


        elpeso := 0;
        TOTALPALE := 0;
        Rec1102.Reset;
        Rec1102.SetCurrentkey(Rec1102."Nº expedición");
        Rec1102.SetRange(Rec1102."Nº expedición", Rec."Nº expedición");
        if Rec1102.FindSet then
            repeat
                TOTALPALE := TOTALPALE + Rec1102."Nº Palets";
                REC1112.Reset;
                REC1112.SetRange(REC1112."Document No.", Rec1102."No.");
                if REC1112.FindSet then
                    repeat
                        elpeso := elpeso + REC1112.Quantity * REC1112."Gross Weight";
                    until REC1112.Next = 0;
            until Rec1102.Next = 0;
        if TOTALPALE <> 0 then begin
            elpeso := elpeso + 10 * TOTALPALE;
        end;


        elpeso := BuscaPesoEtiquetaEnvio(elpeso, Rec110."Shipping Agent Code", Rec110."Ship-to Post Code");

        decre := 1;
        if RecTra.Get(Rec110."Shipping Agent Code") then begin
            if RecTra."Decremento kilo" <> 0 then begin
                decre := (100 - RecTra."Decremento kilo") / 100;
            end;
        end;
        elpeso := ROUND(elpeso * decre, 1);

        if elpeso < 1 then begin
            elpeso := 1;
        end;



        ESREEMBOLSO := false;
        RecFP.Get(Rec110."Payment Method Code");
        if RecFP.Reembolso then begin
            ESREEMBOLSO := true;
        end;


        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;
        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;

        TextoSalida4 := Format(DESNOM) + ';' +
                                         Format(DESNOM2) + ';' +
                                         Format(Rec110."Ship-to City") + ';';
        TextoSalida5 := Format(Rec110."Ship-to Post Code") + ';' +
                                  Format(Rec110."Ship-to Country/Region Code") + ';' +
                                  Format(NTEL) + ';' +
                                  Format(RecCusto."E-Mail") + ';' +
                                  Format(Rec."Total bultos") + ';' +
                                  Format(elpeso) + ';' +
                                  Format(NEXPE) + ';' +
                                  Format(OBSERV1 + OBSERV2) + ';' +
                                  '' + ';' +
                                  '' + ';' +
                                  '0';


        OutStream.Writetext(TextoSalida4 + TextoSalida5);

        /*
                        TextoSalida4 := FORMAT('004855',6)+
                                         ANO2+
                                         PAISDES+
                                         NEXPE+
                                         '0'+
                                         '  '+
                                         FORMAT(DESNOM,40)+
                                         FORMAT(DESNOM2,40)+
                                         FORMAT(Rec110."Ship-to City",20);
               TextoSalida5 :=           FORMAT(Rec110."Ship-to Post Code",5)+
                                         FORMAT('',4)+
                                         FORMAT(NTEL,9)+
                                         ' '+
                                         FORMAT(NEXPEDICION,35)+
                                         '  '+
                                         FORMAT(Rec."Total bultos",3)+
                                         FORMAT(elpeso,5)+
                                         '     '+
                                         '           '+
                                         'EUR'+
                                         'P'+
                                         '         '+
                                         'EUR'+
                                         'P'+
                                         ' '+
                                         ' '+
                                         FORMAT(OBSERV1,40)+
                                         FORMAT(OBSERV2,40)+
                                         ' '+
                                         DD1+MM1+AA1;
                  TextoSalida3 :=        FORMAT('',125)+
                                         'CPT'+
                                         '102'+
                                         FORMAT(Rec110."Ship-to Post Code",5);
                        ArchSalida4.WRITE(TextoSalida4+TextoSalida5+TextoSalida3);
                        */

        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\DHL\';

        TIPO := 3;
        BUSCAEXTENSION;

        if (Rec."Total bultos" <> 0) and (ESREEMBOLSO = false) then begin

            DAT2 := 'ETIDHL' + EXTEN + Format(ALEA) + '.txt';
            TempBlob.CreateInStream(InStream);
            FicherosHagen.CrearFichero(RUTA, DAT2, InStream);
        END;


    end;


    procedure Etitipsa2NUEVA(var Rec: Record "Sales Shipment Header")
    begin

        Rec110.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);




        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec110."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec110."Ship-to Country/Region Code";
        if Rec110."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec110."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec110."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            NTEL := Format(Rec110."Envio a-Nº Telefono", 9);
        end;

        REEMBOLSO := '';


        elpeso := 0;
        TOTALPALE := 0;
        Rec1102.Reset;
        Rec1102.SetCurrentkey(Rec1102."Nº expedición");
        Rec1102.SetRange(Rec1102."Nº expedición", Rec."Nº expedición");
        if Rec1102.FindSet then
            repeat
                TOTALPALE := TOTALPALE + Rec1102."Nº Palets";
                REC1112.Reset;
                REC1112.SetRange(REC1112."Document No.", Rec1102."No.");
                if REC1112.FindSet then
                    repeat
                        elpeso := elpeso + REC1112.Quantity * REC1112."Gross Weight";
                    until REC1112.Next = 0;
            until Rec1102.Next = 0;
        if TOTALPALE <> 0 then begin
            elpeso := elpeso + 10 * TOTALPALE;
        end;


        elpeso := BuscaPesoEtiquetaEnvio(elpeso, Rec110."Shipping Agent Code", Rec110."Ship-to Post Code");

        decre := 1;
        if RecTra.Get(Rec110."Shipping Agent Code") then begin
            if RecTra."Decremento kilo" <> 0 then begin
                decre := (100 - RecTra."Decremento kilo") / 100;
            end;
        end;
        elpeso := ROUND(elpeso * decre, 1);

        if elpeso < 1 then begin
            elpeso := 1;
        end;



        ESREEMBOLSO := false;
        RecFP.Get(Rec110."Payment Method Code");
        if RecFP.Reembolso then begin
            ESREEMBOLSO := true;
        end;


        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;

        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;


        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(Rec110."Ship-to City", 20);
        TextoSalida5 := Format(Rec110."Ship-to Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(NEXPEDICION, 35) +
                                  '  ' +
                                  Format(Rec."Total bultos", 3) +
                                  Format(elpeso, 5) +
                                  '     ' +
                                  '           ' +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;
        TEMAIL := RecCusto."E-Mail";
        if Rec110."E-MAIL" <> '' then begin
            TEMAIL := Rec110."E-MAIL";
        end;


        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(Rec110."Ship-to Post Code", 5) +
                               TEMAIL;
        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);


        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\TIPSA\';
        if RecCusto."No." = '4703' then begin
            RUTA := '\\192.168.0.225\agencias\m\';
        end;
        if COMPANYNAME = 'PEPE' then begin
            RecTra.Get(Rec110."Shipping Agent Code");
            RUTA := RecTra."Ruta fichero";
        end;



        TIPO := 3;
        BUSCAEXTENSION;

        if (Rec."Total bultos" <> 0) and (ESREEMBOLSO = false) then begin
            DAT2 := 'ETITIPSA' + EXTEN + Format(ALEA) + '.TXT';
            TempBlob.CreateInStream(InStream);
            FicherosHagen.CrearFichero(RUTA, DAT2, InStream);
        END;

    end;


    procedure EtiCORRa2NUEVA(var Rec: Record "Sales Shipment Header")
    begin

        Rec110.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);


        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec110."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec110."Ship-to Country/Region Code";
        if Rec110."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec110."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec110."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            NTEL := Format(Rec110."Envio a-Nº Telefono", 9);
        end;

        REEMBOLSO := '';


        elpeso := 0;
        TOTALPALE := 0;
        Rec1102.Reset;
        Rec1102.SetCurrentkey(Rec1102."Nº expedición");
        Rec1102.SetRange(Rec1102."Nº expedición", Rec."Nº expedición");
        if Rec1102.FindSet then
            repeat
                TOTALPALE := TOTALPALE + Rec1102."Nº Palets";
                REC1112.Reset;
                REC1112.SetRange(REC1112."Document No.", Rec1102."No.");
                if REC1112.FindSet then
                    repeat
                        elpeso := elpeso + REC1112.Quantity * REC1112."Gross Weight";
                    until REC1112.Next = 0;
            until Rec1102.Next = 0;
        if TOTALPALE <> 0 then begin
            elpeso := elpeso + 10 * TOTALPALE;
        end;


        elpeso := BuscaPesoEtiquetaEnvio(elpeso, Rec110."Shipping Agent Code", Rec110."Ship-to Post Code");

        decre := 1;
        if RecTra.Get(Rec110."Shipping Agent Code") then begin
            if RecTra."Decremento kilo" <> 0 then begin
                decre := (100 - RecTra."Decremento kilo") / 100;
            end;
        end;
        elpeso := ROUND(elpeso * decre, 1);

        if elpeso < 1 then begin
            elpeso := 1;
        end;



        ESREEMBOLSO := false;
        RecFP.Get(Rec110."Payment Method Code");
        if RecFP.Reembolso then begin
            ESREEMBOLSO := true;
        end;



        pesoini := elpeso * 1000;
        if pesoini > 99999 then begin
            pesoini := 99999;
        end;

        celpeso := ConvertStr(Format(pesoini, 5, Text1100007), ' ', '0');



        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;

        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;


        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(Rec110."Ship-to City", 20);
        TextoSalida5 := Format(Rec110."Ship-to Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(NEXPEDICION, 35) +
                                  '  ' +
                                  Format(Rec."Total bultos", 3) +
                                  Format(celpeso, 5) +
                                  '     ' +
                                  '           ' +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;
        TEMAIL := RecCusto."E-Mail";
        if Rec110."E-MAIL" <> '' then begin
            TEMAIL := Rec110."E-MAIL";
        end;


        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(Rec110."Ship-to Post Code", 5) +
                               Format('', 5) +
                               Format(TEMAIL);
        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);


        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\Correos\';
        if RecCusto."No." = '4703' then begin
            RUTA := '\\192.168.0.225\agencias\m\';
        end;


        TIPO := 3;
        BUSCAEXTENSION;

        if (Rec."Total bultos" <> 0) and (ESREEMBOLSO = false) then begin
            DAT2 := 'ETICORR' + EXTEN + Format(ALEA) + '.TXT';
            TempBlob.CreateInStream(InStream);
            FicherosHagen.CrearFichero(RUTA, DAT2, InStream);
        END;

    end;


    procedure EtiCRON2NUEVA(var Rec: Record "Sales Shipment Header")
    begin



        Rec110.Get(Rec."No.");
        TempBlob.CreateOutStream(OutStream);





        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 40), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec110."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 40), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 40), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec110."Ship-to Country/Region Code";
        if Rec110."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec110."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec110."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            NTEL := Format(Rec110."Envio a-Nº Telefono", 9);
        end;

        REEMBOLSO := '';


        elpeso := 0;
        TOTALPALE := 0;
        Rec1102.Reset;
        Rec1102.SetCurrentkey(Rec1102."Nº expedición");
        Rec1102.SetRange(Rec1102."Nº expedición", Rec."Nº expedición");
        if Rec1102.FindSet then
            repeat
                TOTALPALE := TOTALPALE + Rec1102."Nº Palets";
                REC1112.Reset;
                REC1112.SetRange(REC1112."Document No.", Rec1102."No.");
                if REC1112.FindSet then
                    repeat
                        elpeso := elpeso + REC1112.Quantity * REC1112."Gross Weight";
                    until REC1112.Next = 0;
            until Rec1102.Next = 0;
        if TOTALPALE <> 0 then begin
            elpeso := elpeso + 10 * TOTALPALE;
        end;


        elpeso := BuscaPesoEtiquetaEnvio(elpeso, Rec110."Shipping Agent Code", Rec110."Ship-to Post Code");

        decre := 1;
        if RecTra.Get(Rec110."Shipping Agent Code") then begin
            if RecTra."Decremento kilo" <> 0 then begin
                decre := (100 - RecTra."Decremento kilo") / 100;
            end;
        end;
        elpeso := ROUND(elpeso * decre, 1);

        if elpeso < 1 then begin
            elpeso := 1;
        end;



        ESREEMBOLSO := false;
        RecFP.Get(Rec110."Payment Method Code");
        if RecFP.Reembolso then begin
            ESREEMBOLSO := true;
        end;



        NEXPEDICION := Rec110."Nº expedición";
        if Rec110."Nº expedición dropshp" <> '' then begin
            NEXPEDICION := Rec110."Nº expedición dropshp";
        end;

        if Rec110.ASN <> '' then begin
            NEXPEDICION := Rec110.ASN;
        end;

        /*
                        TextoSalida4 := FORMAT('004855',6)+
                                         ANO2+
                                         PAISDES+
                                         NEXPE+
                                         '0'+
                                         '  '+
                                         FORMAT(DESNOM,40)+
                                         FORMAT(DESNOM2,40)+
                                         FORMAT(Rec110."Ship-to City",20);
               TextoSalida5 :=           FORMAT(Rec110."Ship-to Post Code",5)+
                                         FORMAT('',4)+
                                         FORMAT(NTEL,9)+
                                         ' '+
                                         FORMAT(NEXPEDICION,35)+
                                         '  '+
                                         FORMAT(Rec."Total bultos",3)+
                                         FORMAT(elpeso,5)+
                                         '     '+
                                         '           '+
                                         'EUR'+
                                         'P'+
                                         '         '+
                                         'EUR'+
                                         'P'+
                                         ' '+
                                         ' '+
                                         FORMAT(OBSERV1,40)+
                                         FORMAT(OBSERV2,40)+
                                         ' '+
                                         DD1+MM1+AA1;
                  TextoSalida3 :=        FORMAT('',125)+
                                         'CPT'+
                                         '102'+
                                         FORMAT(Rec110."Ship-to Post Code",5);
                        ArchSalida4.WRITE(TextoSalida4+TextoSalida5+TextoSalida3);
        
        */


        TextoSalida4 := Format(DESNOM) + ';' +
                                         Format(DESNOM2) + ';' +
                                         Format(Rec110."Ship-to City") + ';';
        TextoSalida5 := Format(Rec110."Ship-to Post Code") + ';' +
                                  Format(Rec110."Ship-to Country/Region Code") + ';' +
                                  Format(NTEL) + ';' +
                                  Format(RecCusto."E-Mail") + ';' +
                                  Format(Rec."Total bultos") + ';' +
                                  Format(elpeso) + ';' +
                                  Format(NEXPE) + ';' +
                                  Format(OBSERV1 + OBSERV2) + ';' +
                                  '' + ';' +
                                  '' + ';' +
                                  '0';



        OutStream.Writetext(TextoSalida4 + TextoSalida5);



        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\Crono\';
        if RecCusto."No." = '4703' then begin
            RUTA := '\\192.168.0.225\agencias\m\';
        end;


        TIPO := 3;
        BUSCAEXTENSION;


        if (Rec."Total bultos" <> 0) and (ESREEMBOLSO = false) then begin
            DAT2 := 'ETIDHL' + EXTEN + Format(ALEA) + '.txt';
            TempBlob.CreateInStream(InStream);
            FicherosHagen.CrearFichero(RUTA, DAT2, InStream);
        END;


    end;


    procedure EtiSEURCLIENTE(var RecCusto: Record Customer)
    begin




        TempBlob.CreateOutStream(OutStream);



        RecDEC.Init;
        RecDEC.Reset;
        RecDEC.SetRange(RecDEC."Customer No.", RecCusto."No.");
        RecDEC.SetRange(RecDEC."Direccion habitual", true);
        if RecDEC.FindFirst then begin
        end;

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := ConvertStr(DESNOM, ',', ' ');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if RecDEC.Name <> '' then begin
            DESNOM := ConvertStr(CopyStr(RecDEC.Name, 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := ConvertStr(DESNOM, ',', ' ');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(RecDEC.Address, 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
        DESNOM2 := ConvertStr(DESNOM2, ',', ' ');

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := RecDEC."Country/Region Code";
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        ///OBSERV1:=COPYSTR(RecCusto."Observaciones expedicion",1,40);
        OBSERV2 := '';
        ///IF RecCusto."Nº palets"<>0 THEN BEGIN
        ///OBSERV2:='Palets:'+FORMAT(RecCusto."Nº palets")+'. NO DESPALETIZAR';
        //END;

        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(RecDEC.City, 20);

        DESNOM2 := ConvertStr(CopyStr(RecDEC.Address, 1, 40), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM, 'º', '.');
        DESNOM2 := ConvertStr(DESNOM, ',', ' ');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
        DESNOM3 := ConvertStr(CopyStr(RecDEC."Address 2", 1, 40), 'ª', '.');
        DESNOM3 := ConvertStr(DESNOM, 'º', '.');
        DESNOM3 := ConvertStr(DESNOM, ',', ' ');
        DESNOM3 := CASCII.Ascii2Ansi(DESNOM3);
        if RecDEC.Address <> '' then begin
            DESNOM2 := ConvertStr(CopyStr(RecDEC.Address, 1, 40), 'ª', '.');
            DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
            DESNOM2 := ConvertStr(DESNOM2, ',', ' ');
            DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
            DESNOM3 := ConvertStr(CopyStr(RecDEC."Address 2", 1, 40), 'ª', '.');
            DESNOM3 := ConvertStr(DESNOM3, 'º', '.');
            DESNOM3 := ConvertStr(DESNOM3, ',', ' ');
            DESNOM3 := CASCII.Ascii2Ansi(DESNOM3);
        end;


        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;
        if RecDEC."Phone No." <> '' then begin
            NTEL := Format(RecDEC."Phone No.", 9);
        end;


        expedi := GetSig.GetNextNo('EXPEDI', Today, true);



        TextoSalida5 := Format(RecDEC."Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(expedi, 35) +
                                  '  ' +
                                         ///FORMAT(RecCusto."Nº bultos",3)+
                                         ///FORMAT(RecCusto.Peso,5)+
                                         '     ' +
                                  '           ' +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;
        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(Format(DESNOM2) + ' ' + Format(DESNOM3), 50);
        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);


        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\SEUR\';


        TIPO := 3;
        BUSCAEXTENSION;

        DAT2 := 'hagenseur.txt';
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure EtiDHLCLIENTE(var RecCUSTO: Record Customer)
    begin

        TempBlob.CreateOutStream(OutStream);
        RecDEC.Init;
        RecDEC.Reset;
        RecDEC.SetRange(RecDEC."Customer No.", RecCUSTO."No.");
        RecDEC.SetRange(RecDEC."Direccion habitual", true);
        if RecDEC.FindFirst then begin
        end;



        DESNOM := ConvertStr(CopyStr(RecCUSTO."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := ConvertStr(DESNOM, ',', ' ');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if RecDEC.Name <> '' then begin
            DESNOM := ConvertStr(CopyStr(RecDEC.Name, 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := ConvertStr(DESNOM, ',', ' ');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(RecDEC.Address, 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
        DESNOM2 := ConvertStr(DESNOM2, ',', ' ');


        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := RecDEC."Country/Region Code";
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';



        ///OBSERV1:=COPYSTR(RecCUSTO."Observaciones expedicion",1,40);
        OBSERV2 := '';
        ///IF RecCUSTO."Nº palets"<>0 THEN BEGIN
        ///  OBSERV2:='Palets:'+FORMAT(RecCUSTO."Nº palets")+'. NO DESPALETIZAR';
        ///END;

        NTEL := Format(RecCUSTO."Phone No.", 9);
        if RecCUSTO."Nº movil" <> '' then begin
            NTEL := Format(RecCUSTO."Nº movil", 9);
        end;
        if RecDEC."Phone No." <> '' then begin
            NTEL := Format(RecDEC."Phone No.", 9);
        end;

        REEMBOLSO := '';


        expedi := GetSig.GetNextNo('EXPEDI', Today, true);

        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(RecDEC.City, 20);
        TextoSalida5 := Format(RecDEC."Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(expedi, 35) +
                                  '  ' +
                                         ///FORMAT(RecCUSTO."Nº bultos",3)+
                                         ///FORMAT(RecCUSTO.Peso,5)+
                                         '     ' +
                                  '           ' +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;
        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(RecDEC."Post Code");
        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);


        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\DHL\';

        TIPO := 3;
        BUSCAEXTENSION;

        ///DAT2 := 'ETIDHL' + EXTEN + Format(ALEA) + '.TXT';
        ///TempBlob.CreateInStream(InStream);
        ///FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure EtitipsaCLIENTE(var RecCUSTO: Record Customer)
    begin

        TempBlob.CreateOutStream(OutStream);
        RecDEC.Init;
        RecDEC.Reset;
        RecDEC.SetRange(RecDEC."Customer No.", RecCUSTO."No.");
        RecDEC.SetRange(RecDEC."Direccion habitual", true);
        if RecDEC.FindFirst then begin
        end;



        DESNOM := ConvertStr(CopyStr(RecCUSTO."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := ConvertStr(DESNOM, ',', ' ');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if RecDEC.Name <> '' then begin
            DESNOM := ConvertStr(CopyStr(RecDEC.Name, 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := ConvertStr(DESNOM, ',', ' ');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(RecDEC.Address, 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
        DESNOM2 := ConvertStr(DESNOM2, ',', ' ');


        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := RecDEC."Country/Region Code";
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';



        ///OBSERV1:=COPYSTR(RecCUSTO."Observaciones expedicion",1,40);
        OBSERV2 := '';
        ///IF RecCUSTO."Nº palets"<>0 THEN BEGIN
        ///OBSERV2:='Palets:'+FORMAT(RecCUSTO."Nº palets")+'. NO DESPALETIZAR';
        ////END;

        NTEL := Format(RecCUSTO."Phone No.", 9);
        if RecCUSTO."Nº movil" <> '' then begin
            NTEL := Format(RecCUSTO."Nº movil", 9);
        end;
        if RecDEC."Phone No." <> '' then begin
            NTEL := Format(RecDEC."Phone No.", 9);
        end;

        REEMBOLSO := '';


        expedi := GetSig.GetNextNo('EXPEDI', Today, true);

        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(RecDEC.City, 20);
        TextoSalida5 := Format(RecDEC."Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(expedi, 35) +
                                  '  ' +
                                  //FORMAT(RecCUSTO."Nº bultos",3)+
                                  //FORMAT(RecCUSTO.Peso,5)+
                                  '     ' +
                                  '           ' +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;
        TEMAIL := RecCUSTO."E-Mail";

        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(RecDEC."Post Code", 9) +
                               TEMAIL;
        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);


        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\TIPSA\';
        if RecCUSTO."No." = '4703' then begin
            RUTA := '\\192.168.0.225\agencias\m\';
        end;


        TIPO := 3;
        BUSCAEXTENSION;

        DAT2 := 'ETITIPSA' + EXTEN + Format(ALEA) + '.TXT';
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure EtitCORRCLIENTE(var RecCUSTO: Record Customer)
    begin

        TempBlob.CreateOutStream(OutStream);
        RecDEC.Init;
        RecDEC.Reset;

        RecDEC.SetRange(RecDEC."Customer No.", RecCUSTO."No.");
        RecDEC.SetRange(RecDEC."Direccion habitual", true);
        if RecDEC.FindFirst then begin
        end;



        DESNOM := ConvertStr(CopyStr(RecCUSTO."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := ConvertStr(DESNOM, ',', ' ');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if RecDEC.Name <> '' then begin
            DESNOM := ConvertStr(CopyStr(RecDEC.Name, 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := ConvertStr(DESNOM, ',', ' ');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(RecDEC.Address, 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
        DESNOM2 := ConvertStr(DESNOM2, ',', ' ');


        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := RecDEC."Country/Region Code";
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';



        ///OBSERV1:=COPYSTR(RecCUSTO."Observaciones expedicion",1,40);
        OBSERV2 := '';
        ///IF RecCUSTO."Nº palets"<>0 THEN BEGIN
        ///OBSERV2:='Palets:'+FORMAT(RecCUSTO."Nº palets")+'. NO DESPALETIZAR';
        ///END;

        NTEL := Format(RecCUSTO."Phone No.", 9);
        if RecCUSTO."Nº movil" <> '' then begin
            NTEL := Format(RecCUSTO."Nº movil", 9);
        end;
        if RecDEC."Phone No." <> '' then begin
            NTEL := Format(RecDEC."Phone No.", 9);
        end;

        REEMBOLSO := '';


        expedi := GetSig.GetNextNo('EXPEDI', Today, true);


        ///pesoini:=RecCUSTO.Peso*1000/2;
        if pesoini > 99999 then begin
            pesoini := 99999;
        end;

        celpeso := ConvertStr(Format(pesoini, 5, Text1100007), ' ', '0');


        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(RecDEC.City, 20);
        TextoSalida5 := Format(RecDEC."Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(expedi, 35) +
                                  '  ' +
                                         ///FORMAT(RecCUSTO."Nº bultos",3)+
                                         Format(celpeso, 5) +
                                  '     ' +
                                  '           ' +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;
        TEMAIL := RecCUSTO."E-Mail";

        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(RecDEC."Post Code", 5) +
                               Format('', 5) +
                               Format(TEMAIL);
        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);


        /// Exportación a dhl

        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\Correos\';
        if RecCUSTO."No." = '4703' then begin
            RUTA := '\\192.168.0.225\agencias\m\';
        end;


        TIPO := 3;
        BUSCAEXTENSION;

        DAT2 := 'ETICORR' + EXTEN + Format(ALEA) + '.TXT';
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure IMPRIMEFAC()
    begin


        /*
        IF RecCus.GET(NCLIE) THEN BEGIN
        
        IF RecCus."E-Mail"<>'' THEN BEGIN
        
        
        
        CLEAR(RecpFL);
        Rec112.RESET;
        Rec112.SETRANGE(Rec112."No.",NFACT);
        IF Rec112.FINDFIRST THEN BEGIN
            RecpFL.SETTABLEVIEW(Rec112);
            RecpFL.RUNMODAL;
        END;
        
        VENTANA.OPEN('#1################');
        x:=0;
        REPEAT
        x:=x+1;
        VENTANA.UPDATE(1,x);
        UNTIL x=10000;
        
        VENTANA.CLOSE;
        
        
        Rec91.GET(USERID);
        
                  SenderName := 'HAGEN ESPAÑA - DPTO. FACTURACION';
                  Body:='Factura';
                  RecCus.GET(NCLIE);
                  Subject:=RecCus."Search Name"+' - 'Factura nº '+FORMAT(NFACT);
                  Body:='Muy señores nuestros, adjunto le remitimos la factura nº '+FORMAT(NFACT);
        
                  SenderAddress :=Rec91."E-Mail";
        
                  Recipient:= RecCus."E-Mail";
        
        
        
                  direccionda:=Rec91."Directorio compartido para doc"+'Facturas.pdf';
                  CLEAR(SMTP);
                  SMTP.RUN;
                  SMTP.CreateMessage(SenderName,SenderAddress,Recipient,Subject,Body,TRUE);
                  SMTP.AddAttachment(direccionda);
                  SMTP.Send;
                  CLEAR(SMTP);
        
        END;
        END;
         */

    end;


    procedure Imprimefactura(Rec112: Record "Sales Invoice Header")
    var
        RecFac: Record "Sales Invoice Header";
    begin
    end;


    procedure EnviarEmail(Rec112: Record "Sales Invoice Header")
    var
        direccionda: Code[80];
        nombreda: Code[80];
        SenderName: Text[250];
        SenderAddress: Text[250];
        Recipient: Text[250];
        Subject: Text[250];
        Body: Text[250];
        RecCus: Record Customer;
        dir1: Text[250];
        dir2: Text[250];
        dir3: Text[250];
        textocuerpo: Text[250];
        asunto: Text[250];
        REC91: Record "User Setup";
        VENTANA: Dialog;
        codcli: Code[10];
        RecFac: Record "Sales Invoice Header";
    begin
    end;


    procedure ENVIAREMIALFACTURAS()
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
        /////- SMTP: Codeunit UnknownCodeunit400;
        /////- ImpBull: Automation PDFPrinterSettings;

        cuMail: Codeunit Mail;
        txtOrigen: Text;
        txtDestinatario: List of [Text]; //BC20
        txtCC: Text;
        txtSubject: Text;
        txtBody: Text;
        xmlParameters: Text;
        currentUser: Code[100];
        ReportParameters: Record "Report Selections";
        PdfDocPath: Text;
        Path: Text;
        txtOrigenJM: Text;
        txtDestinatarioJM: Text;
        txtCCJM: Text;
        txtSubjectJM: Text;
        txtFecha: Text;
        intIDreport: Integer;
        recCompanyInformation: Record "Company Information";
        dia: Integer;
        FechasDate: Record Date;
        DiaCorrecto: Boolean;
        AttachmentTempBlob: Codeunit "Temp Blob";
        BOMComponent: Record "BOM Component";
        OutStream: OutStream;
        repInforme: Report "OK Nueva Factura Venta";
        FicheroHagen: Codeunit FicherosHagen;



    begin

        SalesInvHeader.Reset;
        SalesInvHeader.SetCurrentkey(SalesInvHeader."Enviar email", SalesInvHeader."Email enviado");
        /////SalesInvHeader.SetRange(SalesInvHeader."Enviar email", true);
        /////SalesInvHeader.SETRANGE("Posting Date",TODAY,TODAY);
        /////SalesInvHeader.SetRange(SalesInvHeader."Email enviado", false);
        SalesInvHeader.SetRange("No.", '24FV122053');
        if SalesInvHeader.FindSet then begin
            message('%1', SalesInvHeader."No.");
            /////repeat
            RecCust.Get(SalesInvHeader."Sell-to Customer No.");


            if SalesInvHeader."Nº expedición dropshp" = '' then begin
                NEXPEDI := Format(SalesInvHeader."Nº expedición");
            end;
            if SalesInvHeader."Nº expedición dropshp" <> '' then begin
                NEXPEDI := Format(SalesInvHeader."Nº expedición dropshp");
            end;
            if RecCust."Country/Region Code" <> 'PT' then begin
                Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                ' con Nº expedicion: ' + Format(NEXPEDI) +
                ' el cual debe de recibir en el trascurso de 24 a 48 horas.';
                if SalesInvHeader."Shipping Agent Code" = 'DHL' then begin
                    Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                    ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                    ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                    ' con Nº expedicion: ' + Format(NEXPEDI) +
                    ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                    '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                    'http://www.dhl.es/services_es/seg_3dd/integra/SeguimientoDocumentos.aspx?codigo=' +
                    Format(NEXPEDI) + '&anno=2013&lang=sp&refCli=1 , a partir de hoy a las 22:00.';
                end;
                if SalesInvHeader."Shipping Agent Code" = 'CRON' then begin
                    RecTra.Get(SalesInvHeader."Shipping Agent Code");
                    Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                    ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                    ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                    ' con Nº expedicion: ' + Format(NEXPEDI) +
                    ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                    '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                    'https://www.correosexpress.com/url/v?s=' +
                    Format(NEXPEDI) + '&cp=' + Format(SalesInvHeader."Ship-to Post Code") +
                    ///                    'http://www.chronoexpres.com/chronoExtraNET/env/verEnvio.seam?usuario=f4429f061740b2a5528f4aa361d36dac'+
                    //                    '&tipo=referencia&valor='+FORMAT(SalesInvHeader."Nº expedición")+
                    //                    '&cp='+FORMAT(SalesInvHeader."Ship-to Post Code")+
                    ', a partir de hoy a las 22:00.';

                    //paginaweb:='https://www.correosexpress.com/url/v?s='+FORMAT("Nº expedición")+'&cp='+FORMAT("Ship-to Post Code");
                    //HYPERLINK(paginaweb);

                end;
                if SalesInvHeader."Shipping Agent Code" = 'CORR' then begin
                    RecTra.Get(SalesInvHeader."Shipping Agent Code");
                    Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                    ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                    ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                    ' con Nº expedicion: ' + Format(NEXPEDI) +
                    ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                    '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                    'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                    Format(NEXPEDI) +
                    ', a partir de hoy a las 22:00.';
                end;
                if SalesInvHeader."Shipping Agent Code" = 'TNT' then begin
                    Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                    ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                    ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                    ' con Nº expedicion: ' + Format(NEXPEDI) +
                    ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                    '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                    'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=' +
                    'REF&respLang=ES&respCountry=ES&sourceID=1&sourceCountry=' +
                    'ES&sourceID=1&sourceCountry=ww&cons=' +
                    Format(NEXPEDI) + ', a partir de hoy a las 22:00.' +
                    ' A fin de mes recibira una factura de todos sus albaranes.';
                end;
                if SalesInvHeader."Shipping Agent Code" = 'TIPSA' then begin
                    if COMPANYNAME = 'PEPE' then begin
                        Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                        ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                        Format(NEXPEDI) + ' - ' +
                        Format(SalesInvHeader."Your Reference") + ' - ' +
                        Format(SalesInvHeader."Order No.") +
                        Format(SalesInvHeader."Ship-to Post Code") +
                        ', a partir de hoy a las 22:00.' +
                        ' A fin de mes recibira una factura de todos sus albaranes.';
                    end;
                    if COMPANYNAME <> 'PEPE' then begin
                        Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                        ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                        Format(NEXPEDI) +
                        Format(SalesInvHeader."Ship-to Post Code") +
                        ', a partir de hoy a las 22:00.' +
                        ' A fin de mes recibira una factura de todos sus albaranes.';
                    end;

                end;

                if RecTra.Get(SalesInvHeader."Shipping Agent Code") then begin
                    if RecTra."Link transporte" <> '' then begin
                        if RecTra.Code = 'TXT' then begin
                            ANYO := Date2dmy(SalesInvHeader."Posting Date", 3);
                            RecTra."Link transporte" := 'http://tracking.txt.es/?EXPED=@68381@fcyd0y4ui2n6emo@R@' + Format(NEXPEDI) + '@' + Format(ANYO) + '@';
                        end;
                        Body := 'Muy señores nuestros, adjunto remitimos enlace transporte' +
                        ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        Format(RecTra."Link transporte");
                        /////                         IF RecTra.Añadir=0 THEN Body:=Body+FORMAT(SalesInvHeader."Nº expedición");
                        if RecTra.Añadir = 0 then Body := Body + Format(NEXPEDI);
                        if RecTra.Añadir = 2 then
                            Body := Body + Format(NEXPEDI) + '/' +
    Format(SalesInvHeader."Ship-to Post Code");
                        /////                         FORMAT(SalesInvHeader."Ship-to Post Code");
                        Body := Body + ', a partir de hoy a las 22:00.';

                    end;
                end;




            end;

            if RecCust."Country/Region Code" = 'PT' then begin

                Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                ' com Nº expedição: ' + Format(NEXPEDI) +
                ' o qual deve de receber no trascurso de 24 a 48 horas. ';
                if SalesInvHeader."Shipping Agent Code" = 'DHL' then begin
                    Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                    ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                    ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                    ' com Nº expedição: ' + Format(NEXPEDI) +
                    ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                    ' Pode fazer o seguimento do seu envío desde este site web. ' +
                    'http://www.dhl.es/services_es/seg_3dd/integra/SeguimientoDocumentos.aspx?codigo=' +
                    Format(NEXPEDI) + '&anno=2013&lang=sp&refCli=1 , a partir de hoje as 22:00.';
                end;
                if SalesInvHeader."Shipping Agent Code" = 'CRON' then begin
                    RecTra.Get(SalesInvHeader."Shipping Agent Code");
                    Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                    ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                    ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                    ' com Nº expedição: ' + Format(NEXPEDI) +
                    ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                    ' Pode fazer o seguimento do seu envío desde este site web. ' +
                    'https://www.correosexpress.com/url/v?s=' +
                    Format(NEXPEDI) + '&cp=' + Format(SalesInvHeader."Ship-to Post Code") +
                            ///                    'http://www.chronoexpres.com/chronoExtraNET/env/verEnvio.seam?usuario=f4429f061740b2a5528f4aa361d36dac'+
                            ///                    '&tipo=referencia&valor='+FORMAT(SalesInvHeader."Nº expedición")+
                            ///                    '&cp='+FORMAT(SalesInvHeader."Ship-to Post Code")+
                            ', a partir de hoje as 22:00.';
                    //paginaweb:='https://www.correosexpress.com/url/v?s='+FORMAT("Nº expedición")+'&cp='+FORMAT("Ship-to Post Code");
                end;
                if SalesInvHeader."Shipping Agent Code" = 'CORR' then begin
                    RecTra.Get(SalesInvHeader."Shipping Agent Code");
                    Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                    ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                    ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                    ' com Nº expedição: ' + Format(NEXPEDI) +
                    ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                    ' Pode fazer o seguimento do seu envío desde este site web. ' +
                    'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                    Format(NEXPEDI) +
                    ', a partir de hoje as 22:00.';
                end;



                if SalesInvHeader."Shipping Agent Code" = 'TNT' then begin
                    Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                    ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                    ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                    ' com Nº expedição: ' + Format(NEXPEDI) +
                    ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                    ' Pode fazer o seguimento do seu envío desde este site web. ' +
                    'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=' +
                    'REF&respLang=ES&respCountry=ES&sourceID=1&sourceCountry=' +
                    'ES&sourceID=1&sourceCountry=ww&cons=' +
                    Format(NEXPEDI) + ', a partir de hoje as 22:00.';
                    /////                    ' A fin de mes recibira una factura de todos sus albaranes.';
                end;
                if SalesInvHeader."Shipping Agent Code" = 'TIPSA' then begin
                    if COMPANYNAME = 'PEPE' then begin
                        Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                        ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                        ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                        ' com Nº expedição: ' + Format(NEXPEDI) +
                        ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                        ' Pode fazer o seguimento do seu envío desde este site web. ' +
                        'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                        Format(NEXPEDI) + ' - ' +
                        Format(SalesInvHeader."Your Reference") + ' - ' +
                        Format(SalesInvHeader."Order No.") +
                        Format(SalesInvHeader."Ship-to Post Code") +
                        ', a partir de hoje as 22:00.';
                    end;
                    if COMPANYNAME <> 'PEPE' then begin
                        Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                        ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                        ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                        ' com Nº expedição: ' + Format(NEXPEDI) +
                        ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                        ' Pode fazer o seguimento do seu envío desde este site web. ' +
                        'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                        Format(NEXPEDI) +
                        Format(SalesInvHeader."Ship-to Post Code") +
                        ', a partir de hoje as 22:00.';
                    end;
                end;
                if RecTra.Get(SalesInvHeader."Shipping Agent Code") then begin
                    if RecTra."Link transporte" <> '' then begin
                        if RecTra.Code = 'TXT' then begin
                            ANYO := Date2dmy(SalesInvHeader."Posting Date", 3);
                            RecTra."Link transporte" := 'http://tracking.txt.es/?EXPED=@68381@fcyd0y4ui2n6emo@R@' + Format(NEXPEDI) + '@' + Format(ANYO) + '@';
                        end;

                        Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                        ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                        ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                        ' com Nº expedição: ' + Format(NEXPEDI) +
                        ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                        ' Pode fazer o seguimento do seu envío desde este site web. ' +
                        Format(RecTra."Link transporte");
                        if RecTra.Añadir = 0 then Body := Body + Format(NEXPEDI);
                        if RecTra.Añadir = 2 then
                            Body := Body + Format(NEXPEDI) + '/' +
    Format(SalesInvHeader."Ship-to Post Code");
                        Body := Body + ', a partir de hoje as 22:00.';

                    end;
                end;



            end;


            if SalesInvHeader."Shipping Agent Code" = 'CLI' then begin
                Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                ' estando a su disposición en nuestro almacén para su recogida,' +
                ' con Nº expedicion: ' + Format(NEXPEDI);

            end;


            FileDirectory := 'F:\NavisionPdfs\' + SalesInvHeader."No." + '.pdf';


            SalesInvHeader2.Reset;
            SalesInvHeader2.SetRange("No.", SalesInvHeader."No.");
            if SalesInvHeader2.FindFirst then begin
                txtOrigen := 'facturacion@hagen.es';
                txtDestinatario.Add('oscarraea@hotmail.com');
                txtSubject := 'envio factura ' + format(SalesInvHeader."No.");
                recCompanyInformation.Get;
                Body := '*** Este email se envía de forma automática por nuestro sistema. ***' +
                    '<br><br>' +
                    'Adjunto le remitimos el informe ' + txtSubject +
                    '<br><br>' +
                    'Cualquier consulta no dude en ponerse en contacto con nosotros.' +
                    '<br><br>' +
                    'Un saludo.' +
                    '<br>';
                TempBlob.CreateOutStream(OutStream);
                TempBlob.CreateInStream(InStream);
                repInforme.SetTableView(SalesInvHeader2);
                repInforme.SaveAs('', ReportFormat::Pdf, OutStream);
                fileName := SalesInvHeader2."No." + '.PDF';
                FicheroHagen.CrearFicheroFTP('', fileName, InStream);
                BCEnviarEmailSinC(txtDestinatario, txtSubject, Body, true, Path, fileName, 'PDF', Enum::"Email Scenario"::Albaran, txtCC, '', InStream);


                /*
            XmlParameters := '';
            // Crear el OutStream para el TempBlob
            AttachmentTempBlob.CreateOutStream(OutStream);
            // Guardar el reporte en el OutStream
            clear(repInforme);
            repInforme.SetTableView(SalesInvHeader2);
            repInforme.SaveAs('', ReportFormat::Pdf, OutStream);
            // Convertir el OutStream a un InStream
            AttachmentTempBlob.CreateInStream(IStream);
            BCEnviarEmailSinC(txtDestinatario, txtSubject, Body, true, Path, PdfDocPath, 'PDF', Enum::"Email Scenario"::Albaran, txtCC, '', IStream);
            */



            end;

            FileDirectoryexcel := 'F:\NavisionPdfs\' + SalesInvHeader."No." + '.xls';


            SalesInvHeader2.Reset;
            SalesInvHeader2.SetRange("No.", SalesInvHeader."No.");
            if SalesInvHeader2.FindFirst then begin
                /////-Report.SaveAsExcel(50900, FileDirectoryexcel, SalesInvHeader2);
            end;


            Sleep(5000);

            if REC91.Get(UserId) then;
            RecCust.Get(SalesInvHeader."Sell-to Customer No.");

            SenderName := 'HAGEN';

            Subject := RecCust."Search Name" + ' - FACTURA Nº ' + Format(SalesInvHeader."No.");
            SenderAddress := REC91."E-Mail";
            if RecCust."Email facturacion 1" <> '' then begin
                Recipient := RecCust."Email facturacion 1";
                /////Recipient:='oscarraea@hotmail.com;martinjesus241@gmail.com';
                /////-Clear(SMTP);
                /////-SMTP.Run;
                /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                /////-SMTP.AddAttachment(FileDirectory, '');
                /////-if RecCust."No enviar excel" = false then begin
                /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                /////-end;
                ////// SMTP.AddBCC('facturacion@hagen.es');




                if RecCust."Adjuntar pub. facturacion 1" then begin
                    RecCVC.Get;
                    /*IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                         verificapubli1;
                         IF ENVIARPUBLI THEN BEGIN
                              SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                         END;
                    END;
                    IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                         verificapubli2;
                         IF ENVIARPUBLI THEN BEGIN
                              SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                         END;
                    END;
                    IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                         verificapubli3;
                         IF ENVIARPUBLI THEN BEGIN
                              SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                         END;
                    END;
                    */

                    DESDEA := CalcDate('-6M', Today);
                    RecGPG.Reset;
                    RecGPG.SetRange(RecGPG."Es producto", true);
                    RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                    RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                    if RecGPG.FindFirst then
                        repeat
                            RecGPG.CalcFields(RecGPG.Importe);
                            if RecGPG.Importe <> 0 then begin
                                if RecGPG."Id. publicidad" = 1 then begin
                                    if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                        verificapubli1;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 2 then begin
                                    if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                        verificapubli2;
                                        if ENVIARPUBLI then begin
                                            /////-                                                SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 3 then begin
                                    if RecCVC."Ruta doc. GATOS" <> '' then begin
                                        verificapubli3;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 4 then begin
                                    if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                        verificapubli4;
                                        if ENVIARPUBLI then begin
                                            /////- SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 5 then begin
                                    if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                        verificapubli5;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 6 then begin
                                    if RecCVC."Ruta doc. PERROS" <> '' then begin
                                        verificapubli6;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 7 then begin
                                    if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                        verificapubli7;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                        end;
                                    end;
                                end;
                            end;
                        until RecGPG.Next = 0;



                end;
                /////-SMTP.Send;
                /////-Clear(SMTP);

            end;
            if RecCust."Email facturacion 2" <> '' then begin
                Recipient := RecCust."Email facturacion 2";
                /////-Clear(SMTP);
                /////-SMTP.Run;
                /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                /////-SMTP.AddAttachment(FileDirectory, '');
                /////-if RecCust."No enviar excel" = false then begin
                /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                /////-end;
                ///SMTP.AddBCC('oscarraea@hotmail.com');
                if RecCust."Adjuntar pub. facturacion 2" then begin
                    RecCVC.Get;
                    /*
                    IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                         SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                    END;
                    IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                         SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                    END;
                    IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                         SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                    END;
                    */

                    DESDEA := CalcDate('-6M', Today);
                    RecGPG.Reset;
                    RecGPG.SetRange(RecGPG."Es producto", true);
                    RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                    RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                    if RecGPG.FindFirst then
                        repeat
                            RecGPG.CalcFields(RecGPG.Importe);
                            if RecGPG.Importe <> 0 then begin
                                if RecGPG."Id. publicidad" = 1 then begin
                                    if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                        verificapubli1;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 2 then begin
                                    if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                        verificapubli2;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 3 then begin
                                    if RecCVC."Ruta doc. GATOS" <> '' then begin
                                        verificapubli3;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 4 then begin
                                    if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                        verificapubli4;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 5 then begin
                                    if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                        verificapubli5;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 6 then begin
                                    if RecCVC."Ruta doc. PERROS" <> '' then begin
                                        verificapubli6;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 7 then begin
                                    if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                        verificapubli7;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                        end;
                                    end;
                                end;
                            end;
                        until RecGPG.Next = 0;

                end;

                /////-SMTP.Send;
                /////-Clear(SMTP);
            end;
            if RecCust."Email facturacion 3" <> '' then begin
                Recipient := RecCust."Email facturacion 3";
                /////-Clear(SMTP);
                /////-SMTP.Run;
                /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                /////-SMTP.AddAttachment(FileDirectory, '');
                /////-if RecCust."No enviar excel" = false then begin
                /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                /////-end;
                ///SMTP.AddBCC('oscarraea@hotmail.com');
                if RecCust."Adjuntar pub. facturacion 1" then begin
                    RecCVC.Get;
                    /*
                    IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                         verificapubli1;
                         IF ENVIARPUBLI THEN BEGIN
                              SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                         END;
                    END;
                    IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                         verificapubli2;
                         IF ENVIARPUBLI THEN BEGIN
                              SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                         END;
                    END;
                    IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                         verificapubli3;
                         IF ENVIARPUBLI THEN BEGIN
                              SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                         END;
                    END;
                    */
                    DESDEA := CalcDate('-6M', Today);
                    RecGPG.Reset;
                    RecGPG.SetRange(RecGPG."Es producto", true);
                    RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                    RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                    if RecGPG.FindFirst then
                        repeat
                            RecGPG.CalcFields(RecGPG.Importe);
                            if RecGPG.Importe <> 0 then begin
                                if RecGPG."Id. publicidad" = 1 then begin
                                    if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                        verificapubli1;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 2 then begin
                                    if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                        verificapubli2;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 3 then begin
                                    if RecCVC."Ruta doc. GATOS" <> '' then begin
                                        verificapubli3;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 4 then begin
                                    if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                        verificapubli4;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 5 then begin
                                    if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                        verificapubli5;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 6 then begin
                                    if RecCVC."Ruta doc. PERROS" <> '' then begin
                                        verificapubli6;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 7 then begin
                                    if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                        verificapubli7;
                                        if ENVIARPUBLI then begin
                                            /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                        end;
                                    end;
                                end;
                            end;
                        until RecGPG.Next = 0;




                end;
                /////-SMTP.Send;
                /////-Clear(SMTP);
            end;

            if RecVende.Get(SalesInvHeader."Salesperson Code") then begin
                if RecVende."E-Mail" <> '' then begin
                    Recipient := RecVende."E-Mail";
                    /////-Clear(SMTP);
                    /////-SMTP.Run;
                    /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                    /////-SMTP.AddAttachment(FileDirectory, '');
                    /////-if RecCust."No enviar excel" = false then begin
                    /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                    /////-end;
                    ///SMTP.AddBCC('oscarraea@hotmail.com');
                    /////-SMTP.Send;
                    /////-Clear(SMTP);
                end;
            end;



            SalesInvHeader3.Get(SalesInvHeader."No.");
            ///SalesInvHeader3."Email enviado" := true;
            ///SalesInvHeader3."Fecha enviado" := Today;
            ///SalesInvHeader3."Hora enviado" := Time;
            ///SalesInvHeader3.Modify;

            /////            until SalesInvHeader.Next = 0;
        end;

    end;


    procedure ENVIAREMAILPARAPREPARAR(var Rec: Record "Sales Header")
    var
        SenderName: Text[250];
        SenderAddress: Text[250];
        Recipient: Text[250];
        Subject: Text[250];
        Body: Text[1024];
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
        FileDirectory: Code[250];
        FileName: Code[250];
        RunOnceFile: Text[250];
        TimeOut: Integer;
        SalesInvHeader: Record "Sales Header";
        RecVende: Record "Salesperson/Purchaser";
        SalesInvHeader2: Record "Sales Header";
        /////- SMTP: Codeunit UnknownCodeunit400;
        FileNameB: Text[250];
        "-----": Integer;
        /////- SMTPSetup: Record "SMTP Mail Setup";
        /////- SmtpMail: Codeunit UnknownCodeunit400;
        CompanyInfo: Record "Company Information";
        FileManagment: Codeunit "File Management";
    /////- TempBlob: Record TempBlob temporary;
    begin



        /////IF Rec."Enviado email preparación"=FALSE THEN BEGIN

        RecCus.Get(Rec."Sell-to Customer No.");
        if RecCus."No enviar emial de preparacion" = false then begin
            if RecCus."Email pedido 1" = '' then begin
                Error('Este cliente no tiene email.');
            end;

            FileDirectory := 'F:\NavisionPdfs\' + Rec."No." + '.pdf';

            SalesInvHeader.Reset;
            SalesInvHeader.SetRange(SalesInvHeader."Document Type", Rec."Document Type");
            SalesInvHeader.SetRange(SalesInvHeader."No.", Rec."No.");
            if SalesInvHeader.FindFirst then begin
                /////     IF SalesInvHeader."Bill-to Customer No."<>'6445' THEN BEGIN
                /////REPORT.RUNMODAL(50047,FALSE,FALSE,SalesInvHeader);
                /////-Report.SaveAsPdf(205, FileDirectory, SalesInvHeader);
            end;



            Sleep(5000);



            if REC91.Get(UserId) then;

            SenderName := COMPANYNAME;
            Subject := RecCus."Search Name" + ' - PEDIDO Nº ' + Format(Rec."No.") + ' EN PREPARACIÓN';
            SenderAddress := REC91."E-Mail";
            Recipient := RecCus."Email pedido 1";
            /////Recipient:='aseydesa@gmail.com;martinjesus241@gmail.com';
            /////-Clear(SMTP);
            /////-SMTP.Run;
            /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);

            /////-SMTP.AppendBody('Muy señores nuestros, adjunto le remitimos el pedido nº ' + Rec."No." + ',<BR>');
            /////-SMTP.AppendBody(' que está en proceso de PREPARACIÓN. Si necesita alguna modificación comuníquelo urgentemente. <BR>');
            /////-SMTP.AppendBody('Gracias por su compra. En breve recibirá la factura e información del transporte.<BR>');
            /////-SMTP.AppendBody('<HR>');
            /////-SMTP.AppendBody('<BR>');
            /////-SMTP.AppendBody('Atentamente,<BR>');
            /////-SMTP.AppendBody('Pascual Duarte<BR>');
            /////-SMTP.AppendBody('<a href="http://www.hagen.es"/a> <BR>');
            /////-SMTP.AppendBody('ROLF C HAGEN ESPAÑA S.A.');
            /////-SMTP.AppendBody('<BR>');
            /////-SMTP.AppendBody('<BR>');
            /////-SMTP.AppendBody('<BR>');
            /////-SMTP.AppendBody('<BR>');
            CompanyInfo.Get;
            CompanyInfo.CalcFields(Picture);
            if CompanyInfo.Picture.Hasvalue then begin
                /////-TempBlob.Init;
                /////-TempBlob.Blob := CompanyInfo.Picture;
                /////-TempBlob.Insert;
                /////-FileName := FileManagment.BLOBExport(TempBlob, 'Signature.jpg', false);
            end;
            /////MESSAGE('%1',FileName);
            /////-SMTP.AppendBody('<IMG style="HEIGHT: 153px; WIDTH: 445px" src="file:///' + FileName + '"' + 'width=100 height=100>');
            /////-SMTP.AddAttachment(FileDirectory, '');
            if RecCus."Adjuntar pub. pedido 1" then begin
                RecCVC.Get;
                /*
                IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                     verificapubli1;
                     IF ENVIARPUBLI THEN BEGIN
                          SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                     END;
                END;
                IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                     verificapubli2;
                     IF ENVIARPUBLI THEN BEGIN
                          SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                     END;
                END;
                IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                     verificapubli3;
                     IF ENVIARPUBLI THEN BEGIN
                          SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                     END;
                END;
                */
                DESDEA := CalcDate('-6M', Today);
                RecGPG.Reset;
                RecGPG.SetRange(RecGPG."Es producto", true);
                RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                if RecGPG.FindFirst then
                    repeat
                        RecGPG.CalcFields(RecGPG.Importe);
                        if RecGPG.Importe <> 0 then begin
                            if RecGPG."Id. publicidad" = 1 then begin
                                if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                    verificapubli1;
                                    if ENVIARPUBLI then begin
                                        /////            SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                                    end;
                                end;
                            end;
                            if RecGPG."Id. publicidad" = 2 then begin
                                if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                    verificapubli2;
                                    if ENVIARPUBLI then begin
                                        /////       SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                                    end;
                                end;
                            end;
                            if RecGPG."Id. publicidad" = 3 then begin
                                if RecCVC."Ruta doc. GATOS" <> '' then begin
                                    verificapubli3;
                                    if ENVIARPUBLI then begin
                                        /////  SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                                    end;
                                end;
                            end;
                            if RecGPG."Id. publicidad" = 4 then begin
                                if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                    verificapubli4;
                                    if ENVIARPUBLI then begin
                                        /////SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS");
                                    end;
                                end;
                            end;
                            if RecGPG."Id. publicidad" = 5 then begin
                                if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                    verificapubli5;
                                    if ENVIARPUBLI then begin
                                        /////SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES");
                                    end;
                                end;
                            end;
                            if RecGPG."Id. publicidad" = 6 then begin
                                if RecCVC."Ruta doc. PERROS" <> '' then begin
                                    verificapubli6;
                                    if ENVIARPUBLI then begin
                                        /////  SMTP.AddAttachment(RecCVC."Ruta doc. PERROS");
                                    end;
                                end;
                            end;
                            if RecGPG."Id. publicidad" = 7 then begin
                                if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                    verificapubli7;
                                    if ENVIARPUBLI then begin
                                        /////SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES");
                                    end;
                                end;
                            end;
                        end;
                    until RecGPG.Next = 0;

            end;
            /////-SMTP.Send;
            /////-Clear(SMTP);
            if RecCus."Email pedido 2" <> '' then begin
                Recipient := RecCus."Email pedido 2";
                /////-Clear(SMTP);
                /////-SMTP.Run;
                /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                /////SMTP.AddAttachment(FileDirectory+FileName);
                if RecCus."Adjuntar pub. pedido 2" then begin
                    RecCVC.Get;
                    /*
                    IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                         verificapubli1;
                         IF ENVIARPUBLI THEN BEGIN
                              SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                         END;
                    END;
                    IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                         verificapubli2;
                         IF ENVIARPUBLI THEN BEGIN
                              SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                         END;
                    END;
                    IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                         verificapubli3;
                         IF ENVIARPUBLI THEN BEGIN
                              SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                         END;
                    END;
                    */
                    DESDEA := CalcDate('-6M', Today);
                    RecGPG.Reset;
                    RecGPG.SetRange(RecGPG."Es producto", true);
                    RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                    RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                    if RecGPG.FindFirst then
                        repeat
                            RecGPG.CalcFields(RecGPG.Importe);
                            if RecGPG.Importe <> 0 then begin
                                if RecGPG."Id. publicidad" = 1 then begin
                                    if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                        verificapubli1;
                                        if ENVIARPUBLI then begin
                                            /////   SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 2 then begin
                                    if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                        verificapubli2;
                                        if ENVIARPUBLI then begin
                                            /////     SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 3 then begin
                                    if RecCVC."Ruta doc. GATOS" <> '' then begin
                                        verificapubli3;
                                        if ENVIARPUBLI then begin
                                            /////SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 4 then begin
                                    if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                        verificapubli4;
                                        if ENVIARPUBLI then begin
                                            /////SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS");
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 5 then begin
                                    if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                        verificapubli5;
                                        if ENVIARPUBLI then begin
                                            /////SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES");
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 6 then begin
                                    if RecCVC."Ruta doc. PERROS" <> '' then begin
                                        verificapubli6;
                                        if ENVIARPUBLI then begin
                                            /////SMTP.AddAttachment(RecCVC."Ruta doc. PERROS");
                                        end;
                                    end;
                                end;
                                if RecGPG."Id. publicidad" = 7 then begin
                                    if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                        verificapubli7;
                                        if ENVIARPUBLI then begin
                                            /////SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES");
                                        end;
                                    end;
                                end;
                            end;
                        until RecGPG.Next = 0;

                end;
                /////-SMTP.Send;
                /////-Clear(SMTP);
            end;

            SalesInvHeader2.Get(Rec."Document Type", Rec."No.");
            SalesInvHeader2."Enviado email preparación" := true;
            SalesInvHeader2.Modify;
            ///     COMMIT;




            /// VENTANA.CLOSE;

            /////END;


        end;

    end;


    procedure ENVIARALBARANES()
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
        FileName: Code[250];
        RunOnceFile: Text[250];
        TimeOut: Integer;
        SalesShipmentHeader: Record "Sales Shipment Header";
        RecVende: Record "Salesperson/Purchaser";
        FormFac: Page "Posted Sales Invoice";
        rut: Text[1000];
        ArchExt22: Text[1000];
        /////- SMTP: Codeunit UnknownCodeunit400;
        /////- ImpBull: Automation PDFPrinterSettings;
        SalesShipmentHeader2: Record "Sales Shipment Header";
        Rec110: Record "Sales Shipment Header";
        Rec1102: Record "Sales Shipment Header";
    begin


        Rec110.Reset;
        Rec110.SetCurrentkey(Rec110."Enviar email sin detalle", Rec110."Email enviado sin detalle");
        Rec110.SetRange(Rec110."Enviar email sin detalle", true);
        Rec110.SetRange(Rec110."Email enviado sin detalle", false);
        if Rec110.FindSet then
            repeat

                if Rec110."Nº expedición dropshp" = '' then begin
                    NEXPEDI := Format(Rec110."Nº expedición");
                end;
                if Rec110."Nº expedición dropshp" <> '' then begin
                    NEXPEDI := Format(Rec110."Nº expedición dropshp");
                end;
                Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                ' de su pedido ' + Format(Rec110."Your Reference") +
                ' que fue entregado a la agencia de transporte ' + Rec110."Shipping Agent Code" +
                ' con Nº expedicion: ' + Format(NEXPEDI) +
                ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                ' Adicionalmente en la caja ó palet le ira anexado un packing' +
                ' list con información detallada de donde se encuentra cada producto ya' +
                ' que se puede dar el caso que un articuló pueda estar en diferentes cajas.';

                if Rec110."Shipping Agent Code" = 'DHL' then begin
                    Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                    ' de su pedido ' + Format(Rec110."Your Reference") +
                    ' que fue entregado a la agencia de transporte ' + Rec110."Shipping Agent Code" +
                    ' con Nº expedicion: ' + Format(NEXPEDI) +
                    ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                    '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                    'http://www.dhl.es/services_es/seg_3dd/integra/SeguimientoDocumentos.aspx?codigo=' +
                    Format(NEXPEDI) + '&anno=2013&lang=sp&refCli=1 , a partir de hoy a las 22:00.' +
                   ' Adicionalmente en la caja ó palet le ira anexado un packing' +
                   ' list con información detallada de donde se encuentra cada producto ya' +
                   ' que se puede dar el caso que un articuló pueda estar en diferentes cajas.';
                end;
                if Rec110."Shipping Agent Code" = 'CRON' then begin
                    RecTra.Get(Rec110."Shipping Agent Code");
                    Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                    ' de su pedido ' + Format(Rec110."Your Reference") +
                    ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                    ' con Nº expedicion: ' + Format(NEXPEDI) +
                    ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                    '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                    'https://www.correosexpress.com/url/v?s=' +
                    Format(NEXPEDI) + '&cp=' + Format(Rec110."Ship-to Post Code") +
                       ///               'http://www.chronoexpres.com/chronoExtraNET/env/verEnvio.seam?usuario=f4429f061740b2a5528f4aa361d36dac'+
                       ///               '&tipo=referencia&valor='+FORMAT(Rec110."Nº expedición")+
                       ///               '&cp='+FORMAT(Rec110."Ship-to Post Code")+
                       ', a partir de hoy a las 22:00.' +
                    ' Adicionalmente en la caja ó palet le ira anexado un packing' +
                   ' list con información detallada de donde se encuentra cada producto ya' +
                   ' que se puede dar el caso que un articuló pueda estar en diferentes cajas.';

                    //paginaweb:='https://www.correosexpress.com/url/v?s='+FORMAT("Nº expedición")+'&cp='+FORMAT("Ship-to Post Code");
                end;
                if Rec110."Shipping Agent Code" = 'CRON' then begin
                    RecTra.Get(Rec110."Shipping Agent Code");
                    Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                    ' de su pedido ' + Format(Rec110."Your Reference") +
                    ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                    ' con Nº expedicion: ' + Format(NEXPEDI) +
                    ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                    '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                    'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                    Format(NEXPEDI) +
                    ', a partir de hoy a las 22:00.' +
                    ' Adicionalmente en la caja ó palet le ira anexado un packing' +
                   ' list con información detallada de donde se encuentra cada producto ya' +
                   ' que se puede dar el caso que un articuló pueda estar en diferentes cajas.';
                end;




                if Rec110."Shipping Agent Code" = 'TNT' then begin
                    Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                    ' de su pedido ' + Format(Rec110."Your Reference") +
                    ' que fue entregado a la agencia de transporte ' + Rec110."Shipping Agent Code" +
                    ' con Nº expedicion: ' + Format(NEXPEDI) +
                    ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                    '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                    'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=' +
                    'REF&respLang=ES&respCountry=ES&sourceID=1&sourceCountry=' +
                    'ES&sourceID=1&sourceCountry=ww&cons=' +
                    Format(NEXPEDI) + ', a partir de hoy a las 22:00.' +
                    ' A fin de mes recibira una factura de todos sus albaranes.';
                end;

                if Rec110."Shipping Agent Code" = 'TIPSA' then begin
                    if COMPANYNAME = 'PEPE' then begin
                        RecTra.Get(Rec110."Shipping Agent Code");
                        Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                        ' de su pedido ' + Format(Rec110."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                        Format(NEXPEDI) + ' - ' +
                        Format(Rec110."Your Reference") + ' - ' +
                        Format(Rec110."Order No.") +
                        Format(Rec110."Ship-to Post Code") +
                        ', a partir de hoy a las 22:00.' +
                        ' A fin de mes recibira una factura de todos sus albaranes.';
                    end;
                    if COMPANYNAME <> 'PEPE' then begin
                        RecTra.Get(Rec110."Shipping Agent Code");
                        Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                        ' de su pedido ' + Format(Rec110."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                        Format(NEXPEDI) +
                        Format(Rec110."Ship-to Post Code") +
                        ', a partir de hoy a las 22:00.' +
                        ' A fin de mes recibira una factura de todos sus albaranes.';
                    end;


                end;



                if Rec110."Shipping Agent Code" = 'CLI' then begin
                    Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                    ' de su pedido ' + Format(Rec110."Your Reference") +
                    ' estando a su disposición en nuestro almacén para su recogida,' +
                    ' con Nº expedicion: ' + Format(NEXPEDI) +
                    ' Adicionalmente en la caja ó palet le ira anexado un packing' +
                    ' list con información detallada de donde se encuentra cada producto ya' +
                    ' que se puede dar el caso que un articuló pueda estar en diferentes cajas.';

                end;

                FileDirectory := 'F:\NavisionPdfs\' + SalesShipmentHeader."No." + '.pdf';

                SalesShipmentHeader2.Reset;
                SalesShipmentHeader2.SetRange("No.", SalesShipmentHeader."No.");
                if SalesShipmentHeader2.FindFirst then begin
                    RecCust.Get(SalesShipmentHeader2."Sell-to Customer No.");
                    if RecCust."Factura ordenada" then begin
                        /////-Report.SaveAsPdf(50063, FileDirectory + FileName, SalesShipmentHeader2);
                    end;
                    if not RecCust."Factura ordenada" then begin
                        /////-Report.SaveAsPdf(50063, FileDirectory + FileName, SalesShipmentHeader2);
                    end;

                    Sleep(3000);


                    if REC91.Get(UserId) then;
                    RecCust.Get(Rec110."Sell-to Customer No.");

                    SenderName := COMPANYNAME;
                    Subject := RecCust."Search Name" + ' - ALBARAN Nº ' + Format(Rec110."No.");
                    SenderAddress := REC91."E-Mail";
                    if RecCust."Email albaran sin detalle 1" <> '' then begin
                        Recipient := RecCust."Email albaran sin detalle 1";
                        ///// Recipient:='aseydesa@gmail.com;martinjesus241@gmail.com';
                        /////-Clear(SMTP);
                        /////-SMTP.Run;
                        /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                        /////-SMTP.AddAttachment(FileDirectory, '');
                        if RecCust."Adjuntar pub. albaran sin det." then begin
                            RecCVC.Get;
                            /*
                            IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                                 verificapubli1;
                                 IF ENVIARPUBLI THEN BEGIN
                                      SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                                 END;
                            END;
                            IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                                 verificapubli2;
                                 IF ENVIARPUBLI THEN BEGIN
                                      SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                                 END;
                            END;
                            IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                                 verificapubli3;
                                 IF ENVIARPUBLI THEN BEGIN
                                      SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                                 END;
                            END;
                            */
                            DESDEA := CalcDate('-6M', Today);
                            RecGPG.Reset;
                            RecGPG.SetRange(RecGPG."Es producto", true);
                            RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                            RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                            if RecGPG.FindFirst then
                                repeat
                                    RecGPG.CalcFields(RecGPG.Importe);
                                    if RecGPG.Importe <> 0 then begin
                                        if RecGPG."Id. publicidad" = 1 then begin
                                            if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                                verificapubli1;
                                                if ENVIARPUBLI then begin
                                                    /////-SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                                end;
                                            end;
                                        end;
                                        if RecGPG."Id. publicidad" = 2 then begin
                                            if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                                verificapubli2;
                                                if ENVIARPUBLI then begin
                                                    /////-SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                                end;
                                            end;
                                        end;
                                        if RecGPG."Id. publicidad" = 3 then begin
                                            if RecCVC."Ruta doc. GATOS" <> '' then begin
                                                verificapubli3;
                                                if ENVIARPUBLI then begin
                                                    /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                                end;
                                            end;
                                        end;
                                        if RecGPG."Id. publicidad" = 4 then begin
                                            if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                                verificapubli4;
                                                if ENVIARPUBLI then begin
                                                    /////-SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                                end;
                                            end;
                                        end;
                                        if RecGPG."Id. publicidad" = 5 then begin
                                            if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                                verificapubli5;
                                                if ENVIARPUBLI then begin
                                                    /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                                end;
                                            end;
                                        end;
                                        if RecGPG."Id. publicidad" = 6 then begin
                                            if RecCVC."Ruta doc. PERROS" <> '' then begin
                                                verificapubli6;
                                                if ENVIARPUBLI then begin
                                                    /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                                end;
                                            end;
                                        end;
                                        if RecGPG."Id. publicidad" = 7 then begin
                                            if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                                verificapubli7;
                                                if ENVIARPUBLI then begin
                                                    /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                                end;
                                            end;
                                        end;
                                    end;
                                until RecGPG.Next = 0;

                        end;

                        /////-SMTP.Send;
                        /////-Clear(SMTP);
                    end;
                    if RecCust."Email albaran sin detalle 2" <> '' then begin
                        Recipient := RecCust."Email albaran sin detalle 2";
                        ///// Recipient:='aseydesa@gmail.com;martinjesus241@gmail.com';
                        /////-Clear(SMTP);
                        /////-SMTP.Run;
                        /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                        /////-SMTP.AddAttachment(FileDirectory, '');
                        if RecCust."Adjuntar pub. albaran sin det." then begin
                            RecCVC.Get;
                            /*
                            IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                                 verificapubli1;
                                 IF ENVIARPUBLI THEN BEGIN
                                      SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                                 END;
                            END;
                            IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                                 verificapubli2;
                                 IF ENVIARPUBLI THEN BEGIN
                                      SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                                 END;
                            END;
                            IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                                 verificapubli3;
                                 IF ENVIARPUBLI THEN BEGIN
                                      SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                                 END;
                            END;
                            */
                            DESDEA := CalcDate('-6M', Today);
                            RecGPG.Reset;
                            RecGPG.SetRange(RecGPG."Es producto", true);
                            RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                            RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                            if RecGPG.FindFirst then
                                repeat
                                    RecGPG.CalcFields(RecGPG.Importe);
                                    if RecGPG.Importe <> 0 then begin
                                        if RecGPG."Id. publicidad" = 1 then begin
                                            if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                                verificapubli1;
                                                if ENVIARPUBLI then begin
                                                    /////-SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                                end;
                                            end;
                                        end;
                                        if RecGPG."Id. publicidad" = 2 then begin
                                            if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                                verificapubli2;
                                                if ENVIARPUBLI then begin
                                                    /////-SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                                end;
                                            end;
                                        end;
                                        if RecGPG."Id. publicidad" = 3 then begin
                                            if RecCVC."Ruta doc. GATOS" <> '' then begin
                                                verificapubli3;
                                                if ENVIARPUBLI then begin
                                                    /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                                end;
                                            end;
                                        end;
                                        if RecGPG."Id. publicidad" = 4 then begin
                                            if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                                verificapubli4;
                                                if ENVIARPUBLI then begin
                                                    /////-SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                                end;
                                            end;
                                        end;
                                        if RecGPG."Id. publicidad" = 5 then begin
                                            if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                                verificapubli5;
                                                if ENVIARPUBLI then begin
                                                    /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                                end;
                                            end;
                                        end;
                                        if RecGPG."Id. publicidad" = 6 then begin
                                            if RecCVC."Ruta doc. PERROS" <> '' then begin
                                                verificapubli6;
                                                if ENVIARPUBLI then begin
                                                    /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                                end;
                                            end;
                                        end;
                                        if RecGPG."Id. publicidad" = 7 then begin
                                            if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                                verificapubli7;
                                                if ENVIARPUBLI then begin
                                                    /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                                end;
                                            end;
                                        end;
                                    end;
                                until RecGPG.Next = 0;

                        end;

                        /////-SMTP.Send;
                        /////-Clear(SMTP);
                    end;

                end;
                Rec1103.Get(Rec110."No.");
                ///Rec1103."Email enviado sin detalle":=TRUE;
                ///     Rec1103."Fecha enviado sin detalle":=TODAY;
                ///Rec1103."Hora enviado sin detalle":=TIME;
                Rec1103.Modify;


            until Rec110.Next = 0;

    end;


    procedure ENVIAREMIALALBARANESME()
    var
        SenderName: Text[250];
        SenderAddress: Text[250];
        Recipient: Text[250];
        Subject: Text[250];
        Body: Text[1024];
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
        FileDirectory: Code[250];
        FileDirectoryexcel: Code[250];
        FileName: Code[250];
        RunOnceFile: Text[250];
        TimeOut: Integer;
        SalesInvHeader: Record "Sales Header";
        RecVende: Record "Salesperson/Purchaser";
        SalesInvHeader2: Record "Sales Header";
        RecCust: Record Customer;
    /////- SMTP: Codeunit UnknownCodeunit400;
    begin

        ///// 3
        Rec110.Reset;
        Rec110.SetCurrentkey(Rec110."Enviar email", Rec110."Email enviado");
        Rec110.SetRange(Rec110."Enviar email", true);
        Rec110.SetRange(Rec110."Email enviado", false);
        if Rec110.FindSet then
            repeat
                if Rec110."Bill-to Customer No." <> '6445' then begin

                    if Rec110."Nº expedición dropshp" = '' then begin
                        NEXPEDI := Format(Rec110."Nº expedición");
                    end;
                    if Rec110."Nº expedición dropshp" <> '' then begin
                        NEXPEDI := Format(Rec110."Nº expedición dropshp");
                    end;
                    Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                    ' de su pedido ' + Format(Rec110."Your Reference") +
                    ' que fue entregado a la agencia de transporte ' + Rec110."Shipping Agent Code" +
                    ' con Nº expedicion: ' + Format(NEXPEDI) +
                    ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                    ' A fin de mes recibira una factura de todos sus albaranes.';

                    if Rec110."Shipping Agent Code" = 'DHL' then begin
                        Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                        ' de su pedido ' + Format(Rec110."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + Rec110."Shipping Agent Code" +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://www.dhl.es/services_es/seg_3dd/integra/SeguimientoDocumentos.aspx?codigo=' +
                        Format(NEXPEDI) + '&anno=2013&lang=sp&refCli=1 , a partir de hoy a las 22:00.' +
                        ' A fin de mes recibira una factura de todos sus albaranes.';
                    end;
                    if Rec110."Shipping Agent Code" = 'CRON' then begin
                        RecTra.Get(Rec110."Shipping Agent Code");

                        Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                        ' de su pedido ' + Format(Rec110."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'https://www.correosexpress.com/url/v?s=' +
                        Format(NEXPEDI) + '&cp=' + Format(Rec110."Ship-to Post Code") +
                       ///               'http://www.chronoexpres.com/chronoExtraNET/env/verEnvio.seam?usuario=f4429f061740b2a5528f4aa361d36dac'+
                       ///               '&tipo=referencia&valor='+FORMAT(+FORMAT("Nº expedición")+'&cp='+FORMAT("Ship-to Post Code");)+
                       ///               '&cp='+FORMAT(Rec110."Ship-to Post Code")+
                       ', a partir de hoy a las 22:00.' +
                        ' A fin de mes recibira una factura de todos sus albaranes.';

                        //paginaweb:='https://www.correosexpress.com/url/v?s='+FORMAT("Nº expedición")+'&cp='+FORMAT("Ship-to Post Code");

                    end;
                    if Rec110."Shipping Agent Code" = 'CORR' then begin
                        RecTra.Get(Rec110."Shipping Agent Code");

                        Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                        ' de su pedido ' + Format(Rec110."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                        Format(Rec110."Nº expedición") +
                        ', a partir de hoy a las 22:00.' +
                        ' A fin de mes recibira una factura de todos sus albaranes.';

                    end;



                    if Rec110."Shipping Agent Code" = 'TIPSA' then begin
                        if COMPANYNAME = 'PEPE' then begin
                            RecTra.Get(Rec110."Shipping Agent Code");
                            Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                            ' de su pedido ' + Format(Rec110."Your Reference") +
                            ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                            ' con Nº expedicion: ' + Format(NEXPEDI) +
                            ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                            '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                            'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                            Format(NEXPEDI) + ' - ' +
                            Format(Rec110."Your Reference") + ' - ' +
                            Format(Rec110."Order No.") +
                            Format(Rec110."Ship-to Post Code") +
                            ', a partir de hoy a las 22:00.' +
                            ' A fin de mes recibira una factura de todos sus albaranes.';
                        end;
                        if COMPANYNAME <> 'PEPE' then begin
                            RecTra.Get(Rec110."Shipping Agent Code");
                            Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                            ' de su pedido ' + Format(Rec110."Your Reference") +
                            ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                            ' con Nº expedicion: ' + Format(NEXPEDI) +
                            ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                            '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                            'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                            Format(NEXPEDI) +
                            Format(Rec110."Ship-to Post Code") +
                            ', a partir de hoy a las 22:00.' +
                            ' A fin de mes recibira una factura de todos sus albaranes.';
                        end;


                    end;










                    if Rec110."Shipping Agent Code" = 'TNT' then begin
                        Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                        ' de su pedido ' + Format(Rec110."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + Rec110."Shipping Agent Code" +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=' +
                        'REF&respLang=ES&respCountry=ES&sourceID=1&sourceCountry=' +
                        'ES&sourceID=1&sourceCountry=ww&cons=' +
                        Format(NEXPEDI) + ', a partir de hoy a las 22:00.' +
                        ' A fin de mes recibira una factura de todos sus albaranes.';
                    end;








                    if Rec110."Shipping Agent Code" = 'CLI' then begin
                        Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                        ' de su pedido ' + Format(Rec110."Your Reference") +
                        ' estando a su disposición en nuestro almacén para su recogida,' +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' A fin de mes recibira una factura de todos sus albaranes.';

                    end;

                    if RecTra.Get(Rec110."Shipping Agent Code") then begin
                        if RecTra."Link transporte" <> '' then begin
                            if RecTra.Code = 'TXT' then begin
                                ANYO := Date2dmy(Rec110."Posting Date", 3);
                                RecTra."Link transporte" := 'http://tracking.txt.es/?EXPED=@68381@fcyd0y4ui2n6emo@R@' + Format(NEXPEDI) + '@' + Format(ANYO) + '@';
                            end;

                            Body := 'Muy señores nuestros, adjunto remitimos enlace transporte' +
                            ' de su pedido ' + Format(Rec110."Your Reference") +
                            ' que fue entregado a la agencia de transporte ' + Rec110."Shipping Agent Code" +
                            ' con Nº expedicion: ' + Format(NEXPEDI) +
                            ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                            '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                            Format(RecTra."Link transporte");
                            /////                         IF RecTra.Añadir=0 THEN Body:=Body+FORMAT(Rec110."Nº expedición");
                            if RecTra.Añadir = 0 then Body := Body + Format(NEXPEDI);
                            if RecTra.Añadir = 2 then
                                Body := Body + Format(NEXPEDI) + '/' +
        Format(Rec110."Ship-to Post Code");
                            /////                         FORMAT(Rec110."Ship-to Post Code");
                            Body := Body + ', a partir de hoy a las 22:00.';

                        end;
                    end;



                    FileDirectory := 'F:\NavisionPdfs\' + Rec110."No." + '.pdf';

                    Rec1102.Reset;
                    Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                    if Rec1102.FindFirst then begin
                        if Rec1102."Bill-to Customer No." <> '6445' then begin
                            /////-Report.SaveAsPdf(50903, FileDirectory, Rec1102);
                        end;
                        if Rec1102."Bill-to Customer No." = '6445' then begin
                            /////                   REPORT.RUNMODAL(50035,FALSE,FALSE,Rec1102);
                        end;
                        FileDirectoryexcel := 'F:\NavisionPdfs\' + Rec110."No." + '.xls';

                        Rec1102.Reset;
                        Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                        if Rec1102.FindFirst then begin
                            if Rec1102."Bill-to Customer No." <> '6445' then begin
                                /////-Report.SaveAsExcel(50903, FileDirectoryexcel, Rec1102);
                            end;
                        end;

                        Sleep(5000);
                        REC91.Get(UserId);
                        RecCust.Get(Rec110."Sell-to Customer No.");

                        SenderName := 'HAGEN';
                        Subject := RecCust."Search Name" + ' - ALBARAN Nº ' + Format(Rec110."No.");
                        SenderAddress := REC91."E-Mail";
                        if RecCust."Email facturacion 1" <> '' then begin
                            Recipient := RecCust."Email facturacion 1";
                            /////-Clear(SMTP);
                            /////-SMTP.Run;
                            /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                            /////-SMTP.AddAttachment(FileDirectory, '');
                            /////-if RecCust."No enviar excel" = false then begin
                            /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                            /////-end;
                            /////SMTP.AddBCC('oscarraea@hotmail.com');
                            if RecCust."Adjuntar pub. albaran 1" then begin
                                RecCVC.Get;
                                /*
                                IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                                     verificapubli1;
                                     IF ENVIARPUBLI THEN BEGIN
                                          SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                                     END;
                                END;
                                IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                                     verificapubli2;
                                     IF ENVIARPUBLI THEN BEGIN
                                          SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                                     END;
                                END;
                                IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                                     verificapubli3;
                                     IF ENVIARPUBLI THEN BEGIN
                                          SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                                     END;
                                END;
                                */
                                DESDEA := CalcDate('-6M', Today);
                                RecGPG.Reset;
                                RecGPG.SetRange(RecGPG."Es producto", true);
                                RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                                RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                                if RecGPG.FindFirst then
                                    repeat
                                        RecGPG.CalcFields(RecGPG.Importe);
                                        if RecGPG.Importe <> 0 then begin
                                            if RecGPG."Id. publicidad" = 1 then begin
                                                if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                                    verificapubli1;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 2 then begin
                                                if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                                    verificapubli2;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 3 then begin
                                                if RecCVC."Ruta doc. GATOS" <> '' then begin
                                                    verificapubli3;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 4 then begin
                                                if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                                    verificapubli4;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 5 then begin
                                                if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                                    verificapubli5;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 6 then begin
                                                if RecCVC."Ruta doc. PERROS" <> '' then begin
                                                    verificapubli6;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 7 then begin
                                                if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                                    verificapubli7;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                                    end;
                                                end;
                                            end;
                                        end;
                                    until RecGPG.Next = 0;

                            end;

                            /////-SMTP.Send;
                            /////-Clear(SMTP);
                        end;

                        if RecCust."Email facturacion 2" <> '' then begin
                            Recipient := RecCust."Email facturacion 2";
                            /////-Clear(SMTP);
                            /////-SMTP.Run;
                            /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                            /////-SMTP.AddAttachment(FileDirectory, '');
                            /////-if RecCust."No enviar excel" = false then begin
                            /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                            /////-end;
                            ///SMTP.AddBCC('oscarraea@hotmail.com');
                            if RecCust."Adjuntar pub. albaran 2" then begin
                                RecCVC.Get;
                                /*
                                IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                                     verificapubli1;
                                     IF ENVIARPUBLI THEN BEGIN
                                          SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                                     END;
                                END;
                                IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                                     verificapubli2;
                                     IF ENVIARPUBLI THEN BEGIN
                                          SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                                     END;
                                END;
                                IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                                     verificapubli3;
                                     IF ENVIARPUBLI THEN BEGIN
                                          SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                                     END;
                                END;
                                */
                                DESDEA := CalcDate('-6M', Today);
                                RecGPG.Reset;
                                RecGPG.SetRange(RecGPG."Es producto", true);
                                RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                                RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                                if RecGPG.FindFirst then
                                    repeat
                                        RecGPG.CalcFields(RecGPG.Importe);
                                        if RecGPG.Importe <> 0 then begin
                                            if RecGPG."Id. publicidad" = 1 then begin
                                                if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                                    verificapubli1;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 2 then begin
                                                if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                                    verificapubli2;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 3 then begin
                                                if RecCVC."Ruta doc. GATOS" <> '' then begin
                                                    verificapubli3;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 4 then begin
                                                if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                                    verificapubli4;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 5 then begin
                                                if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                                    verificapubli5;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 6 then begin
                                                if RecCVC."Ruta doc. PERROS" <> '' then begin
                                                    verificapubli6;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 7 then begin
                                                if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                                    verificapubli7;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                                    end;
                                                end;
                                            end;
                                        end;
                                    until RecGPG.Next = 0;

                            end;
                            /////-                            SMTP.Send;
                            /////-Clear(SMTP);
                        end;
                        if RecCust."Email facturacion 3" <> '' then begin
                            Recipient := RecCust."Email facturacion 3";
                            /////-Clear(SMTP);
                            /////-SMTP.Run;
                            /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                            /////-SMTP.AddAttachment(FileDirectory, '');
                            /////-if RecCust."No enviar excel" = false then begin
                            /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                            /////-end;
                            ///SMTP.AddBCC('oscarraea@hotmail.com');
                            if RecCust."Adjuntar pub. albaran 3" then begin
                                RecCVC.Get;
                                /*
                                IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                                     verificapubli1;
                                     IF ENVIARPUBLI THEN BEGIN
                                          SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                                     END;
                                END;
                                IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                                     verificapubli2;
                                     IF ENVIARPUBLI THEN BEGIN
                                          SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                                     END;
                                END;
                                IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                                     verificapubli3;
                                     IF ENVIARPUBLI THEN BEGIN
                                          SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                                     END;
                                END;
                                */
                                DESDEA := CalcDate('-6M', Today);
                                RecGPG.Reset;
                                RecGPG.SetRange(RecGPG."Es producto", true);
                                RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                                RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                                if RecGPG.FindFirst then
                                    repeat
                                        RecGPG.CalcFields(RecGPG.Importe);
                                        if RecGPG.Importe <> 0 then begin
                                            if RecGPG."Id. publicidad" = 1 then begin
                                                if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                                    verificapubli1;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 2 then begin
                                                if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                                    verificapubli2;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 3 then begin
                                                if RecCVC."Ruta doc. GATOS" <> '' then begin
                                                    verificapubli3;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 4 then begin
                                                if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                                    verificapubli4;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 5 then begin
                                                if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                                    verificapubli5;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 6 then begin
                                                if RecCVC."Ruta doc. PERROS" <> '' then begin
                                                    verificapubli6;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 7 then begin
                                                if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                                    verificapubli7;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                                    end;
                                                end;
                                            end;
                                        end;
                                    until RecGPG.Next = 0;

                            end;

                            /////-SMTP.Send;
                            /////-Clear(SMTP);
                        end;
                        if RecVende.Get(Rec110."Shortcut Dimension 1 Code") then begin
                            if RecVende."E-Mail" <> '' then begin
                                Recipient := RecVende."E-Mail";
                                /////-Clear(SMTP);
                                /////-SMTP.Run;
                                /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                                /////-SMTP.AddAttachment(FileDirectory, '');
                                /////-if RecCust."No enviar excel" = false then begin
                                /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                                /////-end;
                                ///SMTP.AddBCC('oscarraea@hotmail.com');
                                /////-SMTP.Send;
                                /////-Clear(SMTP);
                            end;
                        end;

                    end;
                    Rec1103.Get(Rec110."No.");
                    Rec1103."Email enviado" := true;
                    Rec1103."Fecha enviado" := Today;
                    Rec1103."Hora enviado" := Time;
                    Rec1103.Modify;

                end;
            until Rec110.Next = 0;

    end;


    procedure ENVIAREMIALALBARSINDETALLE()
    var
        SenderName: Text[250];
        SenderAddress: Text[250];
        Recipient: Text[250];
        Subject: Text[250];
        Body: Text[1024];
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
        FileDirectory: Code[250];
        FileDirectoryexcel: Code[250];
        FileName: Code[250];
        RunOnceFile: Text[250];
        TimeOut: Integer;
        SalesInvHeader: Record "Sales Header";
        RecVende: Record "Salesperson/Purchaser";
        SalesInvHeader2: Record "Sales Header";
        RecCust: Record Customer;
    ///// SMTP: Codeunit smtp UnknownCodeunit400;
    begin


        ///// 2


        Rec110.Reset;
        Rec110.SetCurrentkey(Rec110."Enviar email sin detalle", Rec110."Email enviado sin detalle");
        Rec110.SetRange(Rec110."Enviar email sin detalle", true);
        Rec110.SetRange(Rec110."Email enviado sin detalle", false);
        if Rec110.FindSet then
            repeat
                if Rec110."Bill-to Customer No." <> '6445' then begin
                    if Rec110."Nº expedición dropshp" = '' then begin
                        NEXPEDI := Format(Rec110."Nº expedición");
                    end;
                    if Rec110."Nº expedición dropshp" <> '' then begin
                        NEXPEDI := Format(Rec110."Nº expedición dropshp");
                    end;
                    Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                    ' de su pedido ' + Format(Rec110."Your Reference") +
                    ' que fue entregado a la agencia de transporte ' + Rec110."Shipping Agent Code" +
                    ' con Nº expedicion: ' + Format(NEXPEDI) +
                    ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                    ' Adicionalmente en la caja ó palet le ira anexado un packing' +
                    ' list con información detallada de donde se encuentra cada producto ya' +
                    ' que se puede dar el caso que un articuló pueda estar en diferentes cajas.';

                    if Rec110."Shipping Agent Code" = 'DHL' then begin
                        Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                        ' de su pedido ' + Format(Rec110."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + Rec110."Shipping Agent Code" +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://www.dhl.es/services_es/seg_3dd/integra/SeguimientoDocumentos.aspx?codigo=' +
                        Format(Rec110."Nº expedición") + '&anno=2013&lang=sp&refCli=1 , a partir de hoy a las 22:00.' +
                       ' Adicionalmente en la caja ó palet le ira anexado un packing' +
                       ' list con información detallada de donde se encuentra cada producto ya' +
                       ' que se puede dar el caso que un articuló pueda estar en diferentes cajas.';
                    end;
                    if Rec110."Shipping Agent Code" = 'CRON' then begin
                        RecTra.Get(Rec110."Shipping Agent Code");
                        Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                        ' de su pedido ' + Format(Rec110."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'https://www.correosexpress.com/url/v?s=' +
                        Format(NEXPEDI) + '&cp=' + Format(Rec110."Ship-to Post Code") +
                       ///               'http://www.chronoexpres.com/chronoExtraNET/env/verEnvio.seam?usuario=f4429f061740b2a5528f4aa361d36dac'+
                       ///               '&tipo=referencia&valor='+FORMAT(Rec110."Nº expedición")+
                       ///               '&cp='+FORMAT(Rec110."Ship-to Post Code")+
                       ', a partir de hoy a las 22:00.' +
                        ' Adicionalmente en la caja ó palet le ira anexado un packing' +
                       ' list con información detallada de donde se encuentra cada producto ya' +
                       ' que se puede dar el caso que un articuló pueda estar en diferentes cajas.';

                        //paginaweb:='https://www.correosexpress.com/url/v?s='+FORMAT("Nº expedición")+'&cp='+FORMAT("Ship-to Post Code");
                    end;
                    if Rec110."Shipping Agent Code" = 'CRON' then begin
                        RecTra.Get(Rec110."Shipping Agent Code");
                        Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                        ' de su pedido ' + Format(Rec110."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                        Format(NEXPEDI) +
                        ', a partir de hoy a las 22:00.' +
                        ' Adicionalmente en la caja ó palet le ira anexado un packing' +
                       ' list con información detallada de donde se encuentra cada producto ya' +
                       ' que se puede dar el caso que un articuló pueda estar en diferentes cajas.';
                    end;




                    if Rec110."Shipping Agent Code" = 'TNT' then begin
                        Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                        ' de su pedido ' + Format(Rec110."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + Rec110."Shipping Agent Code" +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=' +
                        'REF&respLang=ES&respCountry=ES&sourceID=1&sourceCountry=' +
                        'ES&sourceID=1&sourceCountry=ww&cons=' +
                        Format(NEXPEDI) + ', a partir de hoy a las 22:00.' +
                        ' A fin de mes recibira una factura de todos sus albaranes.';
                    end;

                    if Rec110."Shipping Agent Code" = 'TIPSA' then begin
                        if COMPANYNAME = 'PEPE' then begin
                            RecTra.Get(Rec110."Shipping Agent Code");
                            Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                            ' de su pedido ' + Format(Rec110."Your Reference") +
                            ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                            ' con Nº expedicion: ' + Format(NEXPEDI) +
                            ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                            '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                            'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                            Format(NEXPEDI) + ' - ' +
                            Format(Rec110."Your Reference") + ' - ' +
                            Format(Rec110."Order No.") +
                            Format(Rec110."Ship-to Post Code") +
                            ', a partir de hoy a las 22:00.' +
                            ' A fin de mes recibira una factura de todos sus albaranes.';
                        end;
                        if COMPANYNAME <> 'PEPE' then begin
                            RecTra.Get(Rec110."Shipping Agent Code");
                            Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                            ' de su pedido ' + Format(Rec110."Your Reference") +
                            ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                            ' con Nº expedicion: ' + Format(NEXPEDI) +
                            ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                            '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                            'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                            Format(NEXPEDI) +
                            Format(Rec110."Ship-to Post Code") +
                            ', a partir de hoy a las 22:00.' +
                            ' A fin de mes recibira una factura de todos sus albaranes.';
                        end;


                    end;



                    if Rec110."Shipping Agent Code" = 'CLI' then begin
                        Body := 'Muy señores nuestros, adjunto remitimos albaran nº: ' + Rec110."No." +
                        ' de su pedido ' + Format(Rec110."Your Reference") +
                        ' estando a su disposición en nuestro almacén para su recogida,' +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' Adicionalmente en la caja ó palet le ira anexado un packing' +
                        ' list con información detallada de donde se encuentra cada producto ya' +
                        ' que se puede dar el caso que un articuló pueda estar en diferentes cajas.';

                    end;


                    /*

                    body2:='.-----  Este mensaje se dirige exclusivamente a su destinatario y puede contener información privilegiada o confidencial.'+
                    ' Si no es vd. el destinatario indicado, queda notificado de que la lectura, utilización, divulgación y/o copia sin autorización'+
                    ' prohibida en virtud de la legislación vigente.';
                    IF COMPANYNAME<>'PEPE' THEN BEGIN
                    body3:=' Si ha recibido este mensaje por error, le rogamos que nos lo comunique inmediatamente por esta misma vía y proceda a su'+
                    ' destrucción.'+
                    ' El correo electrónico vía Internet no permite asegurar la confidencialidad de los mensajes que se transmiten ni su'+
                    ' integridad o correcta recepción.'+
                    ' Hagen España no asume ninguna responsabilidad por estas circunstancias. ///// '+
                     'Esta mensagem vai dirigido exclusivamente ao seu destinatário e pode conter'+
                    'informação privilegiada ou confidencial. Se voçe não for o destinatário indicado, fica'+
                    'notificado do que á leitura, utilização, divulgação e/ou cópia sem autorização proibida'+
                    'pela legislação vigente. Se tem recibido esta mensagem por erro, lhe rogamos que possa'+
                    'em conhecemento de forma inmediata mediante esta vía e proceda a sua destrução. O'+
                    'correio electrónico vía Internet não permite asegurar a confidencialidade das mensagens'+
                    'que sejam transmitidos, nem a sua integridade ou correta recepção. Hagen España não'+
                    'assume nehuma responsabilidade por estas circunstâncias.';

                    */


                    FileDirectory := 'F:\NavisionPdfs\' + Rec110."No." + '.pdf';

                    Rec1102.Reset;
                    Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                    if Rec1102.FindFirst then begin
                        if Rec1102."Bill-to Customer No." <> '6445' then begin
                            /////-Report.SaveAsPdf(50904, FileDirectory, Rec1102);
                        end;
                        if Rec1102."Bill-to Customer No." = '6445' then begin
                            /////                   REPORT.RUNMODAL(50035,FALSE,FALSE,Rec1102);
                        end;

                        FileDirectoryexcel := 'F:\NavisionPdfs\' + Rec110."No." + '.xls';
                        Rec1102.Reset;
                        Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                        if Rec1102.FindFirst then begin
                            if Rec1102."Bill-to Customer No." <> '6445' then begin
                                /////-Report.SaveAsExcel(50904, FileDirectoryexcel, Rec1102);
                            end;
                        end;


                        Sleep(5000);
                        REC91.Get(UserId);
                        RecCust.Get(Rec110."Sell-to Customer No.");

                        SenderName := 'HAGEN';
                        Subject := RecCust."Search Name" + ' - ALBARAN Nº ' + Format(Rec110."No.");
                        SenderAddress := REC91."E-Mail";
                        if RecCust."Email albaran sin detalle 1" <> '' then begin
                            Recipient := RecCust."Email albaran sin detalle 1";
                            /////-Clear(SMTP);
                            /////-SMTP.Run;
                            /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                            /////-SMTP.AddAttachment(FileDirectory, '');
                            /////-if RecCust."No enviar excel" = false then begin
                            /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                            /////-end;
                            /////SMTP.AddBCC('oscarraea@hotmail.com');
                            if RecCust."Adjuntar pub. albaran sin det." then begin
                                RecCVC.Get;
                                /*
                                IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                                     verificapubli1;
                                     IF ENVIARPUBLI THEN BEGIN
                                          SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                                     END;
                                END;
                                IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                                     verificapubli2;
                                     IF ENVIARPUBLI THEN BEGIN
                                          SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                                     END;
                                END;
                                IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                                     verificapubli3;
                                     IF ENVIARPUBLI THEN BEGIN
                                          SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                                     END;
                                END;
                                */
                                DESDEA := CalcDate('-6M', Today);
                                RecGPG.Reset;
                                RecGPG.SetRange(RecGPG."Es producto", true);
                                RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                                RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                                if RecGPG.FindFirst then
                                    repeat
                                        RecGPG.CalcFields(RecGPG.Importe);
                                        if RecGPG.Importe <> 0 then begin
                                            if RecGPG."Id. publicidad" = 1 then begin
                                                if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                                    verificapubli1;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 2 then begin
                                                if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                                    verificapubli2;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 3 then begin
                                                if RecCVC."Ruta doc. GATOS" <> '' then begin
                                                    verificapubli3;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 4 then begin
                                                if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                                    verificapubli4;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 5 then begin
                                                if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                                    verificapubli5;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 6 then begin
                                                if RecCVC."Ruta doc. PERROS" <> '' then begin
                                                    verificapubli6;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 7 then begin
                                                if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                                    verificapubli7;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                                    end;
                                                end;
                                            end;
                                        end;
                                    until RecGPG.Next = 0;

                            end;

                            /////-SMTP.Send;
                            /////-Clear(SMTP);
                        end;

                        if RecCust."Email albaran sin detalle 2" <> '' then begin
                            Recipient := RecCust."Email albaran sin detalle 2";
                            /////-Clear(SMTP);
                            /////-SMTP.Run;
                            /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                            /////-SMTP.AddAttachment(FileDirectory, '');
                            /////-if RecCust."No enviar excel" = false then begin
                            /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                            /////-end;
                            ///SMTP.AddBCC('oscarraea@hotmail.com');
                            if RecCust."Adjuntar pub. albaran sin det." then begin
                                RecCVC.Get;
                                /*
                                IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                                     verificapubli1;
                                     IF ENVIARPUBLI THEN BEGIN
                                          SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                                     END;
                                END;
                                IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                                     verificapubli2;
                                     IF ENVIARPUBLI THEN BEGIN
                                          SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                                     END;
                                END;
                                IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                                     verificapubli3;
                                     IF ENVIARPUBLI THEN BEGIN
                                          SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                                     END;
                                END;
                                */
                                DESDEA := CalcDate('-6M', Today);
                                RecGPG.Reset;
                                RecGPG.SetRange(RecGPG."Es producto", true);
                                RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                                RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                                if RecGPG.FindFirst then
                                    repeat
                                        RecGPG.CalcFields(RecGPG.Importe);
                                        if RecGPG.Importe <> 0 then begin
                                            if RecGPG."Id. publicidad" = 1 then begin
                                                if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                                    verificapubli1;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 2 then begin
                                                if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                                    verificapubli2;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 3 then begin
                                                if RecCVC."Ruta doc. GATOS" <> '' then begin
                                                    verificapubli3;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 4 then begin
                                                if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                                    verificapubli4;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 5 then begin
                                                if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                                    verificapubli5;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 6 then begin
                                                if RecCVC."Ruta doc. PERROS" <> '' then begin
                                                    verificapubli6;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                                    end;
                                                end;
                                            end;
                                            if RecGPG."Id. publicidad" = 7 then begin
                                                if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                                    verificapubli7;
                                                    if ENVIARPUBLI then begin
                                                        /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                                    end;
                                                end;
                                            end;
                                        end;
                                    until RecGPG.Next = 0;

                            end;

                            /////-SMTP.Send;
                            /////-Clear(SMTP);
                        end;

                    end;
                end;
                Rec1103.Get(Rec110."No.");
                Rec1103."Email enviado sin detalle" := true;
                Rec1103."Fecha enviado sin detalle" := Today;
                Rec1103."Hora enviado sin detalle" := Time;
                Rec1103.Modify;


            until Rec110.Next = 0;

    end;


    procedure Imprimeetiqueta()
    var
        SenderName: Text[250];
        SenderAddress: Text[250];
        Recipient: Text[250];
        Subject: Text[250];
        Body: Text[1024];
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
        FileDirectory: Code[250];
        FileName: Code[250];
        RunOnceFile: Text[250];
        TimeOut: Integer;
        SalesInvHeader: Record "Sales Header";
        RecVende: Record "Salesperson/Purchaser";
        SalesInvHeader2: Record "Sales Header";
        RecCust: Record Customer;
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentHeader2: Record "Sales Shipment Header";
    begin

        SalesShipmentHeader.Reset;
        SalesShipmentHeader.SetCurrentkey("Imprime eti. envio");
        SalesShipmentHeader.SetRange("Imprime eti. envio", true);
        if SalesShipmentHeader.FindSet then
            repeat
                if RecTransp.Get(SalesShipmentHeader."Shipping Agent Code") then begin
                    if RecTransp."Sacar etiqueta envio PEQ" then begin
                        Rec1102.Reset;
                        Rec1102.SetRange(Rec1102."No.", SalesShipmentHeader."No.");
                        if Rec1102.FindFirst then begin
                            Report.RunModal(50033, false, false, Rec1102);
                        end;
                    end;
                    if RecTransp."Sacar etiqueta envio GRA" then begin
                        Rec1102.Reset;
                        Rec1102.SetRange(Rec1102."No.", SalesShipmentHeader."No.");
                        if Rec1102.FindFirst then begin
                            Report.RunModal(50039, false, false, Rec1102);
                        end;
                    end;
                end;
                Rec1103.Get(SalesShipmentHeader."No.");
                Rec1103."Imprime eti. envio" := false;
                Rec1103.Modify;
            until SalesShipmentHeader.Next = 0;
    end;


    procedure verificapubli1()
    begin
    end;


    procedure verificapubli2()
    begin
    end;


    procedure verificapubli3()
    begin
    end;


    procedure EtiTNT2(var Rec: Record "Sales Shipment Header")
    begin

        TempBlob.CreateOutStream(OutStream);
        Rec110.Get(Rec."No.");




        RecCusto.Get(Rec110."Sell-to Customer No.");

        DESNOM := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM := CASCII.Ascii2Ansi(DESNOM);
        if Rec110."Ship-to Name" <> '' then begin
            DESNOM := ConvertStr(CopyStr(Rec110."Ship-to Name", 1, 30), 'ª', '.');
            DESNOM := ConvertStr(DESNOM, 'º', '.');
            DESNOM := CASCII.Ascii2Ansi(DESNOM);
        end;

        DESNOM2 := ConvertStr(CopyStr(Rec110."Ship-to Address", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);

        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := Rec110."Ship-to Country/Region Code";
        if Rec110."Ship-to Country/Region Code" = '' then begin
            PAISDES := Rec110."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;


        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec110."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL := Format(RecCusto."Phone No.", 9);
        if RecCusto."Nº movil" <> '' then begin
            NTEL := Format(RecCusto."Nº movil", 9);
        end;
        if Rec110."Envio a-Nº Telefono" <> '' then begin
            NTEL := Format(Rec110."Envio a-Nº Telefono", 9);
        end;

        REEMBOLSO := '';


        elpeso := 0;
        TOTALPALE := 0;
        Rec1102.Reset;
        Rec1102.SetCurrentkey(Rec1102."Nº expedición");
        Rec1102.SetRange(Rec1102."Nº expedición", Rec."Nº expedición");
        if Rec1102.FindSet then
            repeat
                TOTALPALE := TOTALPALE + Rec1102."Nº Palets";
                REC1112.Reset;
                REC1112.SetRange(REC1112."Document No.", Rec1102."No.");
                if REC1112.FindSet then
                    repeat
                        elpeso := elpeso + REC1112.Quantity * REC1112."Gross Weight";
                    until REC1112.Next = 0;
            until Rec1102.Next = 0;
        if TOTALPALE <> 0 then begin
            elpeso := elpeso + 10 * TOTALPALE;
        end;


        elpeso := BuscaPesoEtiquetaEnvio(elpeso, Rec110."Shipping Agent Code", Rec110."Ship-to Post Code");

        decre := 1;
        if RecTra.Get(Rec110."Shipping Agent Code") then begin
            if RecTra."Decremento kilo" <> 0 then begin
                decre := (100 - RecTra."Decremento kilo") / 100;
            end;
        end;
        elpeso := ROUND(elpeso * decre, 1);

        if elpeso < 1 then begin
            elpeso := 1;
        end;



        ESREEMBOLSO := false;
        RecFP.Get(Rec110."Payment Method Code");
        if RecFP.Reembolso then begin
            ESREEMBOLSO := true;
        end;

        DREEMBOLSO := (Rec110.Reembolso - Rec110."Importe a descontar reembolso") * 100;

        REEMBOLSO := ConvertStr(Format(DREEMBOLSO, 11, Text1100007), ' ', '0');




        emailde := Rec110."E-MAIL";

        TextoSalida4 := Format('004855', 6) +
                         ANO2 +
                         PAISDES +
                         NEXPE +
                         '0' +
                         '  ' +
                         Format(DESNOM, 40) +
                         Format(DESNOM2, 40) +
                         Format(Rec110."Ship-to City", 20);
        TextoSalida5 := Format(Rec110."Ship-to Post Code", 5) +
                                  Format('', 4) +
                                  Format(NTEL, 9) +
                                  ' ' +
                                  Format(Rec."Nº expedición", 35) +
                                  '  ' +
                                  Format(Rec."Total bultos", 3) +
                                  Format(elpeso, 5) +
                                  '     ' +
                                  REEMBOLSO +
                                  'EUR' +
                                  'P' +
                                  '         ' +
                                  'EUR' +
                                  'P' +
                                  ' ' +
                                  ' ' +
                                  Format(OBSERV1, 40) +
                                  Format(OBSERV2, 40) +
                                  ' ' +
                                  DD1 + MM1 + AA1;
        TextoSalida3 := Format('', 125) +
                               'CPT' +
                               '102' +
                               Format(Rec110."Ship-to Post Code", 9) +
                               emailde;
        OutStream.Writetext(TextoSalida4 + TextoSalida5 + TextoSalida3);

        /////////////////////////////////////////////////////////////////////////////////////////////////
        /// Exportación a dhl
        /////////////////////////////////////////////////////////////////////////////////////////////////
        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\TNT\';
        RUTA := '\\192.168.0.16\TMP\EMERGENCIA\AGENCIA\TNT\';
        TIPO := 3;
        BUSCAEXTENSION;

        if (Rec."Total bultos" <> 0) and (ESREEMBOLSO = false) then begin
            DAT2 := 'ETIDHL' + EXTEN + Format(ALEA) + '.TXT';
            TempBlob.CreateInStream(InStream);
            FicherosHagen.CrearFichero(RUTA, DAT2, InStream);
        END;

    end;


    procedure EtiTNTCLIENTE(var RecCUSTO: Record Customer)
    begin
    end;


    procedure EtTNTLDESDEFAC(var Rec: Record "Sales Invoice Header")
    begin
    end;


    procedure EtiTNT2NUEVA(var Rec: Record "Sales Shipment Header")
    begin
    end;


    procedure EtCRONDESDEFAC(var Rec: Record "Sales Invoice Header")
    begin
    end;


    procedure ETIECI(var Rec: Record "Sales Shipment Header")
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
    /////- RepETIECI: Report UnknownReport50061;
    begin

        Commit;
        /////-Clear(RepETIECI);
        SalesShipmentHeader.Reset;
        SalesShipmentHeader.SetRange("No.", Rec."No.");
        if SalesShipmentHeader.FindFirst then begin
            /////-Clear(RepETIECI);
            /////-RepETIECI.SetTableview(SalesShipmentHeader);
            /////-RepETIECI.RunModal;
        end;
    end;


    procedure ETIECIedicom(var Rec: Record "Sales Shipment Header")
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
    /////- RepETIECI: Report UnknownReport50061;
    begin

        Commit;
        /////-Clear(RepETIECI);
        SalesShipmentHeader.Reset;
        SalesShipmentHeader.SetRange("No.", Rec."No.");
        if SalesShipmentHeader.FindFirst then begin
            /////-Clear(EtiquetaECINUEVAALB);
            /////-EtiquetaECINUEVAALB.RunModal;
            /////-EtiquetaECINUEVAALB.SetTableview(SalesShipmentHeader);
        end;
    end;


    procedure EtitipsaMN(NEXPE: Code[10])
    begin
    end;


    procedure emailcompras()
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
        FileName: Code[250];
        RunOnceFile: Text[250];
        TimeOut: Integer;
        SalesInvHeader2: Record "Sales Invoice Header";
        RecVende: Record "Salesperson/Purchaser";
    begin
    end;


    procedure enviaremailsegui()
    var
        SalesInvHeaderA: Record "Sales Shipment Header";
        SalesInvHeaderA3: Record "Sales Shipment Header";
    begin
    end;


    procedure creabody(codalbar: Code[20])
    var
        Rec110: Record "Sales Shipment Header";
    begin
    end;


    procedure BuscaPesoEtiquetaEnvio(elpeso: Decimal; costransp: Code[20]; codpost: Code[20]) PESODEVOL: Decimal
    var
        RecTrans: Record "Shipping Agent";
        RecCP: Record "Post Code";
        CODPROV: Code[10];
        RecMT3: Record "Multitabla 3";
        RecMT4: Record "Multitabla 3";
    begin



        PESODEVOL := 0;
        RecTrans.Reset;
        RecTrans.SetRange(RecTrans.Code, costransp);
        if RecTrans.FindSet then
            repeat
                RecCP.Reset;
                RecCP.SetRange(RecCP.Code, codpost);
                if RecCP.FindFirst then begin
                    CODPROV := RecCP."County Code";
                    RecMT3.Reset;
                    RecMT3.SetRange(RecMT3.Tabla, 2);
                    RecMT3.SetRange(RecMT3."Transportista-Cliente", RecTrans.Code);
                    RecMT3.SetRange(RecMT3.Provincia, CODPROV);
                    if RecMT3.FindFirst then begin
                        RecMT4.Reset;
                        RecMT4.SetRange(RecMT4.Tabla, 3);
                        RecMT4.SetRange(RecMT4."Transportista tarifa", RecTrans.Code);
                        RecMT4.SetRange(RecMT4."Zona tarifa", RecMT3."Zona transportistas-Cliente");
                        RecMT4.SetRange(RecMT4."Hasta Kilos", elpeso, 99999999);
                        if RecMT4.FindFirst then begin
                            PESODEVOL := RecMT4."Hasta Kilos";
                        end;
                    end;
                end;
            until RecTrans.Next = 0;
    end;


    procedure verificapubli4()
    begin
    end;


    procedure verificapubli5()
    begin
    end;


    procedure verificapubli6()
    begin
    end;


    procedure verificapubli7()
    begin
    end;

    local procedure EnvioCartaDtoAbono()
    begin

        /*
        
        
        
        
        VENTANA.OPEN('Espere un momento...');
        
        clie:='';
        
        
        Recipient1:='ramon.yago@hagen.es';
        Recipient2:='alexis.martin@hagen.es';
        Recipient3:='nadia.climent@hagen.es';
        
        conta:=0;
        CLEAR(RepNC);
        Rec81.RESET;
        Rec81.SETRANGE(Rec81."Journal Template Name","Journal Template Name");
        Rec81.SETRANGE(Rec81."Journal Batch Name","Journal Batch Name");
        IF Rec81.FINDFIRST THEN REPEAT
             IF clie<>Rec81."Account No." THEN BEGIN
                  RecCust.GET(Rec81."Account No.");
                  IF RecCust."E-Mail"<>'' THEN BEGIN
                       Body:='Muy señores nuestros, adjunto documento NOTIFICACION CONTABLE';
                       IF ISCLEAR(ImpBull) THEN
                       CREATE(ImpBull);
        
                       FileDirectory := 'C:\NavisionPdfs\';
                       FileName := Rec81."Document No."+'.pdf';
                       ImpBull.Init;
                       ImpBull.LoadSettings;
                       RunOnceFile := ImpBull.GetSettingsFileName(TRUE);
                       ImpBull.SetValue('Output',FileDirectory+FileName);
                       ImpBull.SetValue('Showsettings', 'never');
                       ImpBull.SetValue('ShowPDF', 'no');
                       ImpBull.SetValue('ShowProgress', 'no');
                       ImpBull.SetValue('ShowProgressFinished', 'no');
                       ImpBull.SetValue('SuppressErrors', 'yes');
                       ImpBull.SetValue('ConfirmOverwrite', 'no');
                       ImpBull.WriteSettings(TRUE);
        
                       REC812.RESET;
                       REC812.SETRANGE(REC812."Journal Template Name",Rec81."Journal Template Name");
                       REC812.SETRANGE(REC812."Journal Batch Name",Rec81."Journal Batch Name");
                       REC812.SETRANGE(REC812."Account No.",Rec81."Account No.");
                       IF REC812.FINDFIRST THEN BEGIN
                            REPORT.RUNMODAL(50090,FALSE,FALSE,REC812);
                       END;
                       ////// REPORT.RUNMODAL(50090,FALSE,FALSE,Rec81);
                       TimeOut := 0;
                       WHILE EXISTS(RunOnceFile) AND (TimeOut < 10) DO BEGIN
                       SLEEP(4000);
                       TimeOut := TimeOut + 1;
                       REC91.GET(USERID);
                       SenderName := COMPANYNAME;
                       Subject:='NOTIFICACION CONTABLE Nº '+FORMAT(Rec81."Document No.");
                       SenderAddress :=REC91."E-Mail";
                       Recipient:=RecCust."E-Mail";
        
                       CLEAR(SMTP);
                       SMTP.RUN;
                       SMTP.CreateMessage(SenderName,SenderAddress,Recipient,Subject,Body,TRUE);
                       SMTP.AddAttachment(FileDirectory+FileName);
                       SMTP.Send;
                       CLEAR(SMTP);
        
                  END;
                  END;
                  clie:=Rec81."Account No.";
             END;
        UNTIL Rec81.NEXT=0;
        
        VENTANA.CLOSE;
        
        */

    end;

    local procedure EnioNotificacion()
    begin



        /*
        
        
        CLEAR(RepNC);
        Rec81.RESET;
        Rec81.SETRANGE(Rec81."Journal Template Name","Journal Template Name");
        Rec81.SETRANGE(Rec81."Journal Batch Name","Journal Batch Name");
        Rec81.SETRANGE(Rec81."Account No.","Account No.");
        IF Rec81.FINDFIRST THEN BEGIN
             RepNC.SETTABLEVIEW(Rec81);
             RepNC.RUNMODAL;
        END;
        50098
        Notificación contable
        */

    end;

    local procedure EnvioNotiAgrupado()
    begin

        /*
        
        CLEAR(RepAF);
        Rec81.RESET;
        Rec81.SETRANGE(Rec81."Journal Template Name","Journal Template Name");
        Rec81.SETRANGE(Rec81."Journal Batch Name","Journal Batch Name");
        Rec81.SETRANGE(Rec81."Account No.","Account No.");
        IF Rec81.FINDFIRST THEN BEGIN
             RepAF.SETTABLEVIEW(Rec81);
             RepAF.RUNMODAL;
        END;
        50096
        Agrupación facturas
        */

    end;


    procedure ENVIAREMIALFACTURASCANARIAS()
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
    /////- SMTP: Codeunit UnknownCodeunit400;
    /////- ImpBull: Automation PDFPrinterSettings;
    begin

        SalesInvHeader.Reset;
        SalesInvHeader.SetCurrentkey(SalesInvHeader."Enviar email", SalesInvHeader."Email enviado");
        SalesInvHeader.SetRange(SalesInvHeader."Enviar email", true);
        /////SalesInvHeader.SETRANGE("Posting Date",TODAY,TODAY);
        SalesInvHeader.SetRange(SalesInvHeader."Email enviado", false);
        if SalesInvHeader.FindSet then
            repeat
                RecCust.Get(SalesInvHeader."Sell-to Customer No.");
                codexpedico := SalesInvHeader."Nº expedición";
                if SalesInvHeader."Nº expedición dropshp" <> '' then begin
                    codexpedico := Rec110."Nº expedición dropshp";
                end;
                if SalesInvHeader.ASN <> '' then begin
                    codexpedico := SalesInvHeader.ASN;
                end;
                if RecCust."Country/Region Code" <> 'PT' then begin
                    Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                    ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                    ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                    ' con Nº expedicion: ' + Format(codexpedico) +
                    ' el cual debe de recibir en el trascurso de 24 a 48 horas.';
                    if SalesInvHeader."Shipping Agent Code" = 'DHL' then begin
                        Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                        ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                        ' con Nº expedicion: ' + Format(codexpedico) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://www.dhl.es/services_es/seg_3dd/integra/SeguimientoDocumentos.aspx?codigo=' +
                        Format(codexpedico) + '&anno=2013&lang=sp&refCli=1 , a partir de hoy a las 22:00.';
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'CRON' then begin
                        RecTra.Get(SalesInvHeader."Shipping Agent Code");
                        Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                        ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                        ' con Nº expedicion: ' + Format(SalesInvHeader."Nº expedición") +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'https://www.correosexpress.com/url/v?s=' +
                        Format(codexpedico) + '&cp=' + Format(SalesInvHeader."Ship-to Post Code") +
                        ///                    'http://www.chronoexpres.com/chronoExtraNET/env/verEnvio.seam?usuario=f4429f061740b2a5528f4aa361d36dac'+
                        //                    '&tipo=referencia&valor='+FORMAT(SalesInvHeader."Nº expedición")+
                        //                    '&cp='+FORMAT(SalesInvHeader."Ship-to Post Code")+
                        ', a partir de hoy a las 22:00.';

                        //paginaweb:='https://www.correosexpress.com/url/v?s='+FORMAT("Nº expedición")+'&cp='+FORMAT("Ship-to Post Code");
                        //HYPERLINK(paginaweb);

                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'CORR' then begin
                        RecTra.Get(SalesInvHeader."Shipping Agent Code");
                        Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                        ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                        ' con Nº expedicion: ' + Format(codexpedico) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                        Format(codexpedico) +
                        ', a partir de hoy a las 22:00.';
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'TNT' then begin
                        Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                        ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                        ' con Nº expedicion: ' + Format(codexpedico) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=' +
                        'REF&respLang=ES&respCountry=ES&sourceID=1&sourceCountry=' +
                        'ES&sourceID=1&sourceCountry=ww&cons=' +
                        Format(codexpedico) + ', a partir de hoy a las 22:00.' +
                        ' A fin de mes recibira una factura de todos sus albaranes.';
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'TIPSA' then begin
                        if COMPANYNAME = 'PEPE' then begin
                            Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                            ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                            ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                            ' con Nº expedicion: ' + Format(codexpedico) +
                            ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                            '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                            'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                            Format(codexpedico) + ' - ' +
                            Format(SalesInvHeader."Your Reference") + ' - ' +
                            Format(SalesInvHeader."Order No.") +
                            Format(SalesInvHeader."Ship-to Post Code") +
                            ', a partir de hoy a las 22:00.' +
                            ' A fin de mes recibira una factura de todos sus albaranes.';
                        end;
                        if COMPANYNAME <> 'PEPE' then begin
                            Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                            ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                            ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                            ' con Nº expedicion: ' + Format(codexpedico) +
                            ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                            '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                            'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                            Format(codexpedico) +
                            Format(SalesInvHeader."Ship-to Post Code") +
                            ', a partir de hoy a las 22:00.' +
                            ' A fin de mes recibira una factura de todos sus albaranes.';
                        end;

                    end;

                    if RecTra.Get(SalesInvHeader."Shipping Agent Code") then begin
                        if RecTra."Link transporte" <> '' then begin
                            if RecTra.Code = 'TXT' then begin
                                ANYO := Date2dmy(SalesInvHeader."Posting Date", 3);
                                RecTra."Link transporte" := 'http://tracking.txt.es/?EXPED=@68381@fcyd0y4ui2n6emo@R@' + Format(NEXPEDI) + '@' + Format(ANYO) + '@';
                            end;

                            Body := 'Muy señores nuestros, adjunto remitimos enlace transporte' +
                            ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                            ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                            ' con Nº expedicion: ' + Format(codexpedico) +
                            ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                            '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                            Format(RecTra."Link transporte");
                            /////                         IF RecTra.Añadir=0 THEN Body:=Body+FORMAT(SalesInvHeader."Nº expedición");
                            if SalesInvHeader."Nº expedición dropshp" = '' then begin
                                if RecTra.Añadir = 0 then Body := Body + Format(SalesInvHeader."Nº expedición");
                                if RecTra.Añadir = 2 then
                                    Body := Body + Format(SalesInvHeader."Nº expedición") + '/' +
            Format(SalesInvHeader."Ship-to Post Code");
                            end;
                            if SalesInvHeader."Nº expedición dropshp" <> '' then begin
                                if RecTra.Añadir = 0 then Body := Body + Format(SalesInvHeader."Nº expedición dropshp");
                                if RecTra.Añadir = 2 then
                                    Body := Body + Format(SalesInvHeader."Nº expedición dropshp") + '/' +
            Format(SalesInvHeader."Ship-to Post Code");
                            end;
                            /////                         FORMAT(SalesInvHeader."Ship-to Post Code");
                            Body := Body + ', a partir de hoy a las 22:00.';

                        end;
                    end;




                end;

                if RecCust."Country/Region Code" = 'PT' then begin

                    Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                    ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                    ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                    ' com Nº expedição: ' + Format(codexpedico) +
                    ' o qual deve de receber no trascurso de 24 a 48 horas. ';
                    if SalesInvHeader."Shipping Agent Code" = 'DHL' then begin
                        Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                        ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                        ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                        ' com Nº expedição: ' + Format(codexpedico) +
                        ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                        ' Pode fazer o seguimento do seu envío desde este site web. ' +
                        'http://www.dhl.es/services_es/seg_3dd/integra/SeguimientoDocumentos.aspx?codigo=' +
                        Format(codexpedico) + '&anno=2013&lang=sp&refCli=1 , a partir de hoje as 22:00.';
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'CRON' then begin
                        RecTra.Get(SalesInvHeader."Shipping Agent Code");
                        Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                        ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                        ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                        ' com Nº expedição: ' + Format(codexpedico) +
                        ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                        ' Pode fazer o seguimento do seu envío desde este site web. ' +
                        'https://www.correosexpress.com/url/v?s=' +
                        Format(SalesInvHeader."Nº expedición") + '&cp=' + Format(SalesInvHeader."Ship-to Post Code") +
                            ///                    'http://www.chronoexpres.com/chronoExtraNET/env/verEnvio.seam?usuario=f4429f061740b2a5528f4aa361d36dac'+
                            ///                    '&tipo=referencia&valor='+FORMAT(SalesInvHeader."Nº expedición")+
                            ///                    '&cp='+FORMAT(SalesInvHeader."Ship-to Post Code")+
                            ', a partir de hoje as 22:00.';
                        //paginaweb:='https://www.correosexpress.com/url/v?s='+FORMAT("Nº expedición")+'&cp='+FORMAT("Ship-to Post Code");
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'CORR' then begin
                        RecTra.Get(SalesInvHeader."Shipping Agent Code");
                        Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                        ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                        ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                        ' com Nº expedição: ' + Format(codexpedico) +
                        ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                        ' Pode fazer o seguimento do seu envío desde este site web. ' +
                        'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                        Format(codexpedico) +
                        ', a partir de hoje as 22:00.';
                    end;



                    if SalesInvHeader."Shipping Agent Code" = 'TNT' then begin
                        Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                        ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                        ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                        ' com Nº expedição: ' + Format(codexpedico) +
                        ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                        ' Pode fazer o seguimento do seu envío desde este site web. ' +
                        'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=' +
                        'REF&respLang=ES&respCountry=ES&sourceID=1&sourceCountry=' +
                        'ES&sourceID=1&sourceCountry=ww&cons=' +
                        Format(codexpedico) + ', a partir de hoje as 22:00.';
                        /////                    ' A fin de mes recibira una factura de todos sus albaranes.';
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'TIPSA' then begin
                        if COMPANYNAME = 'PEPE' then begin
                            Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                            ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                            ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                            ' com Nº expedição: ' + Format(codexpedico) +
                            ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                            ' Pode fazer o seguimento do seu envío desde este site web. ' +
                            'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                            Format(codexpedico) + ' - ' +
                            Format(SalesInvHeader."Your Reference") + ' - ' +
                            Format(SalesInvHeader."Order No.") +
                            Format(SalesInvHeader."Ship-to Post Code") +
                            ', a partir de hoje as 22:00.';
                        end;
                        if COMPANYNAME <> 'PEPE' then begin
                            Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                            ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                            ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                            ' com Nº expedição: ' + Format(codexpedico) +
                            ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                            ' Pode fazer o seguimento do seu envío desde este site web. ' +
                            'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                            Format(codexpedico) +
                            Format(SalesInvHeader."Ship-to Post Code") +
                            ', a partir de hoje as 22:00.';
                        end;


                    end;


                end;


                if SalesInvHeader."Shipping Agent Code" = 'CLI' then begin
                    Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                    ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                    ' estando a su disposición en nuestro almacén para su recogida,' +
                    ' con Nº expedicion: ' + Format(codexpedico);

                end;


                FileDirectory := 'F:\NavisionPdfs\' + SalesInvHeader."No." + '.pdf';


                SalesInvHeader2.Reset;
                SalesInvHeader2.SetRange("No.", SalesInvHeader."No.");
                if SalesInvHeader2.FindFirst then begin
                    /////-Report.SaveAsPdf(50914, FileDirectory, SalesInvHeader2);
                end;

                FileDirectoryexcel := 'F:\NavisionPdfs\' + SalesInvHeader."No." + '.xls';


                SalesInvHeader2.Reset;
                SalesInvHeader2.SetRange("No.", SalesInvHeader."No.");
                if SalesInvHeader2.FindFirst then begin
                    /////-Report.SaveAsExcel(50914, FileDirectoryexcel, SalesInvHeader2);
                end;


                Sleep(5000);

                if REC91.Get(UserId) then;
                RecCust.Get(SalesInvHeader."Sell-to Customer No.");

                SenderName := 'HAGEN';

                Subject := RecCust."Search Name" + ' - FACTURA Nº ' + Format(SalesInvHeader."No.");
                SenderAddress := REC91."E-Mail";
                if RecCust."Email facturacion 1" <> '' then begin
                    Recipient := RecCust."Email facturacion 1";
                    /////Recipient:='oscarraea@hotmail.com;martinjesus241@gmail.com';
                    /////-Clear(SMTP);
                    /////-SMTP.Run;
                    /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                    /////-SMTP.AddAttachment(FileDirectory, '');
                    /////-if RecCust."No enviar excel" = false then begin
                    /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                    /////-end;
                    ///// SMTP.AddBCC('oscarraea@hotmail.com');




                    if RecCust."Adjuntar pub. facturacion 1" then begin
                        RecCVC.Get;
                        /*IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                             verificapubli1;
                             IF ENVIARPUBLI THEN BEGIN
                                  SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                             END;
                        END;
                        IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                             verificapubli2;
                             IF ENVIARPUBLI THEN BEGIN
                                  SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                             END;
                        END;
                        IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                             verificapubli3;
                             IF ENVIARPUBLI THEN BEGIN
                                  SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                             END;
                        END;
                        */

                        DESDEA := CalcDate('-6M', Today);
                        RecGPG.Reset;
                        RecGPG.SetRange(RecGPG."Es producto", true);
                        RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                        RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                        if RecGPG.FindFirst then
                            repeat
                                RecGPG.CalcFields(RecGPG.Importe);
                                if RecGPG.Importe <> 0 then begin
                                    if RecGPG."Id. publicidad" = 1 then begin
                                        if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                            verificapubli1;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 2 then begin
                                        if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                            verificapubli2;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 3 then begin
                                        if RecCVC."Ruta doc. GATOS" <> '' then begin
                                            verificapubli3;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 4 then begin
                                        if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                            verificapubli4;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 5 then begin
                                        if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                            verificapubli5;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 6 then begin
                                        if RecCVC."Ruta doc. PERROS" <> '' then begin
                                            verificapubli6;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 7 then begin
                                        if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                            verificapubli7;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                            end;
                                        end;
                                    end;
                                end;
                            until RecGPG.Next = 0;



                    end;
                    /////-SMTP.Send;
                    /////-Clear(SMTP);

                end;
                if RecCust."Email facturacion 2" <> '' then begin
                    Recipient := RecCust."Email facturacion 2";
                    /////-Clear(SMTP);
                    /////-SMTP.Run;
                    /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                    /////-SMTP.AddAttachment(FileDirectory, '');
                    /////-if RecCust."No enviar excel" = false then begin
                    /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                    /////-end;
                    ///SMTP.AddBCC('oscarraea@hotmail.com');
                    if RecCust."Adjuntar pub. facturacion 2" then begin
                        RecCVC.Get;
                        /*
                        IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                             SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                        END;
                        IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                             SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                        END;
                        IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                             SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                        END;
                        */

                        DESDEA := CalcDate('-6M', Today);
                        RecGPG.Reset;
                        RecGPG.SetRange(RecGPG."Es producto", true);
                        RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                        RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                        if RecGPG.FindFirst then
                            repeat
                                RecGPG.CalcFields(RecGPG.Importe);
                                if RecGPG.Importe <> 0 then begin
                                    if RecGPG."Id. publicidad" = 1 then begin
                                        if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                            verificapubli1;
                                            if ENVIARPUBLI then begin
                                                /////- SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 2 then begin
                                        if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                            verificapubli2;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 3 then begin
                                        if RecCVC."Ruta doc. GATOS" <> '' then begin
                                            verificapubli3;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 4 then begin
                                        if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                            verificapubli4;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 5 then begin
                                        if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                            verificapubli5;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 6 then begin
                                        if RecCVC."Ruta doc. PERROS" <> '' then begin
                                            verificapubli6;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 7 then begin
                                        if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                            verificapubli7;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                            end;
                                        end;
                                    end;
                                end;
                            until RecGPG.Next = 0;

                    end;

                    /////-SMTP.Send;
                    /////-Clear(SMTP);
                end;
                if RecCust."Email facturacion 3" <> '' then begin
                    Recipient := RecCust."Email facturacion 3";
                    /////-Clear(SMTP);
                    /////-SMTP.Run;
                    /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                    /////-SMTP.AddAttachment(FileDirectory, '');
                    /////-if RecCust."No enviar excel" = false then begin
                    /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                    /////-end;
                    ///SMTP.AddBCC('oscarraea@hotmail.com');
                    if RecCust."Adjuntar pub. facturacion 1" then begin
                        RecCVC.Get;
                        /*
                        IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                             verificapubli1;
                             IF ENVIARPUBLI THEN BEGIN
                                  SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                             END;
                        END;
                        IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                             verificapubli2;
                             IF ENVIARPUBLI THEN BEGIN
                                  SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                             END;
                        END;
                        IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                             verificapubli3;
                             IF ENVIARPUBLI THEN BEGIN
                                  SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                             END;
                        END;
                        */
                        DESDEA := CalcDate('-6M', Today);
                        RecGPG.Reset;
                        RecGPG.SetRange(RecGPG."Es producto", true);
                        RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                        RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                        if RecGPG.FindFirst then
                            repeat
                                RecGPG.CalcFields(RecGPG.Importe);
                                if RecGPG.Importe <> 0 then begin
                                    if RecGPG."Id. publicidad" = 1 then begin
                                        if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                            verificapubli1;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 2 then begin
                                        if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                            verificapubli2;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 3 then begin
                                        if RecCVC."Ruta doc. GATOS" <> '' then begin
                                            verificapubli3;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 4 then begin
                                        if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                            verificapubli4;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 5 then begin
                                        if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                            verificapubli5;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 6 then begin
                                        if RecCVC."Ruta doc. PERROS" <> '' then begin
                                            verificapubli6;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 7 then begin
                                        if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                            verificapubli7;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                            end;
                                        end;
                                    end;
                                end;
                            until RecGPG.Next = 0;




                    end;
                    /////-SMTP.Send;
                    /////-Clear(SMTP);
                end;

                if RecVende.Get(SalesInvHeader."Salesperson Code") then begin
                    if RecVende."E-Mail" <> '' then begin
                        Recipient := RecVende."E-Mail";
                        /////-Clear(SMTP);
                        /////-SMTP.Run;
                        /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                        /////-SMTP.AddAttachment(FileDirectory, '');
                        /////-if RecCust."No enviar excel" = false then begin
                        /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                        /////-end;
                        ///SMTP.AddBCC('oscarraea@hotmail.com');
                        /////-SMTP.Send;
                        /////-Clear(SMTP);
                    end;
                end;



                SalesInvHeader3.Get(SalesInvHeader."No.");
                SalesInvHeader3."Email enviado" := true;
                SalesInvHeader3."Fecha enviado" := Today;
                SalesInvHeader3."Hora enviado" := Time;
                SalesInvHeader3.Modify;

            until SalesInvHeader.Next = 0;

    end;


    procedure ENVIAREMIALALBARANCOMPRA()
    var
        SenderName: Text[250];
        SenderAddress: Text[250];
        Recipient: Text[250];
        Subject: Text[250];
        Body: Text[1024];
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
        FileDirectory: Code[250];
        FileDirectoryexcel: Code[250];
        FileName: Code[250];
        RunOnceFile: Text[250];
        TimeOut: Integer;
        SalesInvHeader: Record "Sales Header";
        RecVende: Record "Salesperson/Purchaser";
        SalesInvHeader2: Record "Sales Header";
        RecCust: Record Customer;
        /////- SMTP: Codeunit UnknownCodeunit400;
        FileDirectory3: Code[250];
    begin


        ///// 2


        PurchRcptHeader.Reset;
        PurchRcptHeader.SetCurrentkey(PurchRcptHeader."Enviar email");
        PurchRcptHeader.SetRange(PurchRcptHeader."Enviar email", true);
        PurchRcptHeader.SetRange(PurchRcptHeader."Email enviado", false);
        if PurchRcptHeader.FindSet then
            repeat
                if Vendor.Get(PurchRcptHeader."Buy-from Vendor No.") then begin

                    if Vendor."Proveedor de almacen" = true then begin

                        Body := 'Muy señores nuestros, adjunto recepcion de compra nº: ' + PurchRcptHeader."No.";

                        FileDirectory := 'F:\NavisionPdfs\' + PurchRcptHeader."No." + '.pdf';
                        FileDirectory3 := 'F:\NavisionPdfs\Roturas_' + PurchRcptHeader."No." + '.xls';
                        albaranvalido := false;
                        PurchRcptHeader2.Reset;
                        PurchRcptHeader2.SetRange("No.", PurchRcptHeader."No.");
                        if PurchRcptHeader2.FindFirst then begin
                            PurchRcptLine.Reset;
                            PurchRcptLine.SetRange("Document No.", PurchRcptHeader2."No.");
                            if PurchRcptLine.FindSet then
                                repeat
                                    if RecI.Get(PurchRcptLine."No.") then begin
                                        if RecI."Producto almacenable" then begin
                                            albaranvalido := true;
                                        end;
                                    end;
                                until PurchRcptLine.Next = 0;
                            if albaranvalido then begin
                                PurchRcptHeader2.Reset;
                                PurchRcptHeader2.SetRange("No.", PurchRcptHeader."No.");
                                if PurchRcptHeader2.FindFirst then begin
                                    /////-Report.SaveAsPdf(408, FileDirectory, PurchRcptHeader2);
                                end;
                            end;
                        end;

                        Sleep(5000);
                        if albaranvalido then begin
                            REC91.Get(UserId);
                            UserSetup.Reset;
                            UserSetup.SetRange("Enviar email recep. compra", true);
                            if UserSetup.FindSet then
                                repeat
                                    VerSiRoturas;
                                    if tienerotura then begin
                                        PurchRcptHeader2.Reset;
                                        PurchRcptHeader2.SetRange("No.", PurchRcptHeader."No.");
                                        if PurchRcptHeader2.FindFirst then begin
                                            PurchRcptHeader2."Vendedor temp" := UserSetup."Salespers./Purch. Code";
                                            PurchRcptHeader2.Modify;
                                            Commit;
                                            /////-Report.SaveAsExcel(50066, FileDirectory3, PurchRcptHeader2);
                                        end;
                                    end;

                                    SenderName := 'HAGEN';
                                    Subject := 'Recepcion compra  Nº ' + Format(PurchRcptHeader."No.") + ' ' + Format(UserSetup."E-Mail");
                                    SenderAddress := REC91."E-Mail";
                                    Recipient := UserSetup."E-Mail";
                                    ///// Recipient:='oscarraea@hotmail.com;alexis.martin@hagen.es';
                                    /////-Clear(SMTP);
                                    /////-SMTP.Run;
                                    /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                                    /////-SMTP.AddAttachment(FileDirectory, '');
                                    /////SMTP.AddBCC('oscarraea@hotmail.com');
                                    /////-SMTP.Send;

                                    if tienerotura then begin
                                        SenderName := 'HAGEN';
                                        Subject := 'Rotura compra  Nº ' + Format(PurchRcptHeader."No.") + ' ' + Format(UserSetup."E-Mail");
                                        SenderAddress := REC91."E-Mail";
                                        Recipient := UserSetup."E-Mail";
                                        /////Recipient:='oscarraea@hotmail.com;alexis.martin@hagen.es';
                                        /////-Clear(SMTP);
                                        /////-SMTP.Run;
                                        /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                                        /////-SMTP.AddAttachment(FileDirectory3, '');
                                        /////SMTP.AddBCC('oscarraea@hotmail.com');
                                        /////-SMTP.Send;

                                    end;
                                until UserSetup.Next = 0;
                        end;
                    end;
                end;

                PurchRcptHeader2.Get(PurchRcptHeader."No.");
                PurchRcptHeader2."Email enviado" := true;
                PurchRcptHeader2."Enviar email" := false;
                PurchRcptHeader2."Fecha enviado" := Today;
                PurchRcptHeader2."Hora enviado" := Time;
                PurchRcptHeader2.Modify;
                Commit;


            until PurchRcptHeader.Next = 0;
    end;


    procedure ETISTDpedido(var Rec: Record "Sales Header")
    begin

        SalesHeader.Get(Rec."No.");

        TIPO := 3;
        BUSCAEXTENSION;
        if SalesHeader."Nº expedición dropshp" = '' then begin
            EXTEN := EXTEN + Format(SalesHeader."Nº expedición");
        end;
        if SalesHeader."Nº expedición dropshp" <> '' then begin
            EXTEN := EXTEN + Format(SalesHeader."Nº expedición dropshp");
        end;





        RecCusto.Get(SalesHeader."Sell-to Customer No.");

        DESNOMa1 := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOMa1 := ConvertStr(DESNOMa1, 'º', '.');
        DESNOMa1 := CASCII.Ascii2Ansi(DESNOMa1);
        if SalesHeader."Ship-to Name" <> '' then begin
            DESNOMa1 := ConvertStr(CopyStr(SalesHeader."Ship-to Name", 1, 50), 'ª', '.');
            DESNOMa1 := ConvertStr(DESNOMa1, 'º', '.');
            DESNOMa1 := CASCII.Ascii2Ansi(DESNOMa1);
        end;
        if SalesHeader."Ship-to Name 2" <> '' then begin
            DESNOMa2 := ConvertStr(CopyStr(SalesHeader."Ship-to Name 2", 1, 50), 'ª', '.');
            DESNOMa2 := ConvertStr(DESNOMa2, 'º', '.');
            DESNOMa2 := CASCII.Ascii2Ansi(DESNOMa2);
        end;

        DESNOMa3 := ConvertStr(CopyStr(SalesHeader."Ship-to Address", 1, 50), 'ª', '.');
        DESNOMa3 := ConvertStr(DESNOMa3, 'º', '.');
        DESNOMa3 := CASCII.Ascii2Ansi(DESNOMa3);
        DESNOMa4 := ConvertStr(CopyStr(SalesHeader."Ship-to Address 2", 1, 50), 'ª', '.');
        DESNOMa4 := ConvertStr(DESNOMa4, 'º', '.');
        DESNOMa4 := CASCII.Ascii2Ansi(DESNOMa4);


        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := SalesHeader."Ship-to Country/Region Code";
        if SalesHeader."Ship-to Country/Region Code" = '' then begin
            PAISDES := SalesHeader."Sell-to Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;

        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        OBSERV1 := CopyStr(Rec110."Observación para transporte", 1, 40);
        OBSERV2 := '';
        if Rec."Nº Palets" <> 0 then begin
            OBSERV2 := 'Palets:' + Format(Rec."Nº Palets") + '. NO DESPALETIZAR';
        end;

        NTEL2 := Format(RecCusto."Phone No.");
        if RecCusto."Nº movil" <> '' then begin
            NTEL2 := Format(RecCusto."Nº movil");
        end;
        if SalesHeader."Envio a-Nº Telefono" <> '' then begin
            NTEL2 := Format(SalesHeader."Envio a-Nº Telefono");
        end;

        REEMBOLSO := '';



        TEMAIL := RecCusto."E-Mail";
        if SalesHeader."E-MAIL" <> '' then begin
            TEMAIL := SalesHeader."E-MAIL";
        end;
        SERVIRDABADO := 'N';
        /////IF SalesHeader."Servir sabado" THEN BEGIN
        /////SERVIRDABADO:='S';
        /////END;

        RecTra.Get(SalesHeader."Shipping Agent Code");


        elpeso := SalesHeader."Total peso";

        if SalesHeader."Total peso" = 0 then begin
            elpeso := 0;
            TOTALPALE := 0;
            SalesHeader2.Reset;
            SalesHeader2.SetCurrentkey("Nº expedición");
            SalesHeader2.SetRange("Nº expedición", SalesHeader."Nº expedición");
            if SalesHeader2.FindSet then
                repeat
                    TOTALPALE := TOTALPALE + SalesHeader2."Nº Palets";
                    SalesLine2.Reset;
                    SalesLine2.SetRange("Document No.", SalesHeader2."No.");
                    if SalesLine2.FindSet then
                        repeat
                            elpeso := elpeso + SalesLine2.Quantity * SalesLine2."Gross Weight";
                        until SalesLine2.Next = 0;
                until SalesHeader2.Next = 0;
            if TOTALPALE <> 0 then begin
                elpeso := elpeso + 10 * TOTALPALE;
            end;
        end;


        elpeso := BuscaPesoEtiquetaEnvio(elpeso, SalesHeader."Shipping Agent Code", SalesHeader."Ship-to Post Code");


        decre := 1;
        if RecTra.Get(SalesHeader."Shipping Agent Code") then begin
            if RecTra."Decremento kilo" <> 0 then begin
                decre := (100 - RecTra."Decremento kilo") / 100;
            end;
        end;
        elpeso := ROUND(elpeso * decre, 1);

        if elpeso < 1 then begin
            elpeso := 1;
        end;

        CODPAIES2 := '';
        codpais := '';
        cospostat := '';
        codpais := SalesHeader."Ship-to Country/Region Code";
        CODPAIES2 := '0';
        cospostat := SalesHeader."Ship-to Post Code";
        if SalesHeader."Ship-to Country/Region Code" = 'PT' then begin
            codpais := 'PT';
            CODPAIES2 := '6';
            cospostat := CopyStr(SalesHeader."Ship-to Post Code", 1, 4) + CopyStr(SalesHeader."Ship-to Post Code", 6, 3);
        end;

        RecTra.Get(SalesHeader."Shipping Agent Code");

        totalbultos := SalesHeader."Nº bultos" + SalesHeader."Nº Palets";



        NEXPEDICION := SalesHeader."Nº expedición";
        if Rec110.ASN <> '' then begin
            NEXPEDICION := SalesHeader.ASN;
        end;


        TextoSalida1 := Format(DESNOMa1, 50) +
                      Format(DESNOMa2, 50) +
                      Format(DESNOMa3, 50) +
                      Format(DESNOMa4, 50);
        TextoSalida2 := Format(SalesHeader."Ship-to Post Code", 5) +
                      Format(SalesHeader."Ship-to City", 30) +
                      Format(SalesHeader."Ship-to County", 30) +
                      Format(SalesHeader."Ship-to Contact", 50);
        TextoSalida3 := Format(NTEL2, 30) +
                      Format(NEXPEDICION + ' ' + SalesHeader."Your Reference", 60) +
                      Format(NEXPEDICION, 30) +
                      Format(SalesHeader."Your Reference", 30) +
                      Format(totalbultos, 10) +
                      Format(elpeso, 10) +
                      Format(SalesHeader.Reembolso, 10);
        TextoSalida4 := Format(OBSERV1, 40) +
                      Format(OBSERV2, 40) +
                      Format(DD1 + MM1 + AA1, 8) +
                      Format(TEMAIL, 80) +
                      Format(SERVIRDABADO, 1) +
                      Format('0', 10) +
                      Format(RecTra."Texto final fichero", 30) +
                      Format(codpais, 2) +
                      Format(CODPAIES2, 2) +
                      Format(cospostat, 6);


        OutStream.Writetext(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4);

        Sleep(3000);



        RecCE.Get;
        RUTA := '\\192.168.0.225\agencias\TIPSA\';


        RecTra.Get(SalesHeader."Shipping Agent Code");
        RUTA := RecTra."Ruta fichero";


        if RecCusto."No." = '4703' then begin
            RUTA := '\\192.168.0.225\agencias\m\';
        end;


        DAT2 := 'ETISTD' + EXTEN + Format(ALEA) + '.TXT';
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;

    local procedure VerSiRoturas()
    begin

        tienerotura := false;
        if UserSetup."Salespers./Purch. Code" <> '' then begin
            PurchRcptHeader3.Reset;
            PurchRcptHeader3.SetRange("No.", PurchRcptHeader."No.");
            if PurchRcptHeader3.FindFirst then begin
                PurchRcptLine3.Reset;
                PurchRcptLine3.SetRange("Document No.", PurchRcptHeader3."No.");
                if PurchRcptLine3.FindSet then
                    repeat
                        SalesLine3.Reset;
                        SalesLine3.SetRange("Document Type", SalesLine3."document type"::Order);
                        SalesLine3.SetRange("No.", PurchRcptLine3."No.");
                        SalesLine3.SetRange(SalesLine3.Vendedor, UserSetup."Salespers./Purch. Code");
                        SalesLine3.SetFilter("Outstanding Quantity", '<>0');
                        if SalesLine3.FindFirst then begin
                            tienerotura := true;
                        end;
                    until PurchRcptLine3.Next = 0;
            end;
        end;
    end;


    procedure ENVIAREMIALFACTURAScanarias2()
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
    /////- SMTP: Codeunit UnknownCodeunit400;
    /////- ImpBull: Automation PDFPrinterSettings;
    begin

        SalesInvHeader.Reset;
        SalesInvHeader.SetCurrentkey(SalesInvHeader."Enviar email", SalesInvHeader."Email enviado");
        SalesInvHeader.SetRange(SalesInvHeader."Enviar email", true);
        /////SalesInvHeader.SETRANGE("Posting Date",TODAY,TODAY);
        SalesInvHeader.SetRange(SalesInvHeader."Email enviado", false);
        if SalesInvHeader.FindSet then
            repeat
                RecCust.Get(SalesInvHeader."Sell-to Customer No.");

                if SalesInvHeader."Nº expedición dropshp" = '' then begin
                    NEXPEDI := Format(SalesInvHeader."Nº expedición");
                end;
                if SalesInvHeader."Nº expedición dropshp" <> '' then begin
                    NEXPEDI := Format(SalesInvHeader."Nº expedición dropshp");
                end;



                if RecCust."Country/Region Code" <> 'PT' then begin
                    Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                    ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                    ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                    ' con Nº expedicion: ' + Format(SalesInvHeader."Nº expedición") +
                    ' el cual debe de recibir en el trascurso de 24 a 48 horas.';
                    if SalesInvHeader."Shipping Agent Code" = 'DHL' then begin
                        Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                        ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://www.dhl.es/services_es/seg_3dd/integra/SeguimientoDocumentos.aspx?codigo=' +
                        Format(NEXPEDI) + '&anno=2013&lang=sp&refCli=1 , a partir de hoy a las 22:00.';
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'CRON' then begin
                        RecTra.Get(SalesInvHeader."Shipping Agent Code");
                        Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                        ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'https://www.correosexpress.com/url/v?s=' +
                        Format(NEXPEDI) + '&cp=' + Format(SalesInvHeader."Ship-to Post Code") +
                        ///                    'http://www.chronoexpres.com/chronoExtraNET/env/verEnvio.seam?usuario=f4429f061740b2a5528f4aa361d36dac'+
                        //                    '&tipo=referencia&valor='+FORMAT(SalesInvHeader."Nº expedición")+
                        //                    '&cp='+FORMAT(SalesInvHeader."Ship-to Post Code")+
                        ', a partir de hoy a las 22:00.';

                        //paginaweb:='https://www.correosexpress.com/url/v?s='+FORMAT("Nº expedición")+'&cp='+FORMAT("Ship-to Post Code");
                        //HYPERLINK(paginaweb);

                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'CORR' then begin
                        RecTra.Get(SalesInvHeader."Shipping Agent Code");
                        Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                        ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + RecTra.Name +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                        Format(SalesInvHeader."Nº expedición") +
                        ', a partir de hoy a las 22:00.';
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'TNT' then begin
                        Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                        ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                        ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                        ' con Nº expedicion: ' + Format(NEXPEDI) +
                        ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                        '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                        'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=' +
                        'REF&respLang=ES&respCountry=ES&sourceID=1&sourceCountry=' +
                        'ES&sourceID=1&sourceCountry=ww&cons=' +
                        Format(NEXPEDI) + ', a partir de hoy a las 22:00.' +
                        ' A fin de mes recibira una factura de todos sus albaranes.';
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'TIPSA' then begin
                        if COMPANYNAME = 'PEPE' then begin
                            Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                            ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                            ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                            ' con Nº expedicion: ' + Format(NEXPEDI) +
                            ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                            '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                            'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                            Format(NEXPEDI) + ' - ' +
                            Format(SalesInvHeader."Your Reference") + ' - ' +
                            Format(SalesInvHeader."Order No.") +
                            Format(SalesInvHeader."Ship-to Post Code") +
                            ', a partir de hoy a las 22:00.' +
                            ' A fin de mes recibira una factura de todos sus albaranes.';
                        end;
                        if COMPANYNAME <> 'PEPE' then begin
                            Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                            ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                            ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                            ' con Nº expedicion: ' + Format(NEXPEDI) +
                            ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                            '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                            'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                            Format(NEXPEDI) +
                            Format(SalesInvHeader."Ship-to Post Code") +
                            ', a partir de hoy a las 22:00.' +
                            ' A fin de mes recibira una factura de todos sus albaranes.';
                        end;

                    end;

                    if RecTra.Get(SalesInvHeader."Shipping Agent Code") then begin
                        if RecTra."Link transporte" <> '' then begin
                            if RecTra.Code = 'TXT' then begin
                                ANYO := Date2dmy(SalesInvHeader."Posting Date", 3);
                                RecTra."Link transporte" := 'http://tracking.txt.es/?EXPED=@68381@fcyd0y4ui2n6emo@R@' + Format(NEXPEDI) + '@' + Format(ANYO) + '@';
                            end;

                            Body := 'Muy señores nuestros, adjunto remitimos enlace transporte' +
                            ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                            ' que fue entregado a la agencia de transporte ' + SalesInvHeader."Shipping Agent Code" +
                            ' con Nº expedicion: ' + Format(NEXPEDI) +
                            ' el cual debe de recibir en el trascurso de 24 a 48 horas.' +
                            '  Puede hacerle el seguimiento a su envio desde este enlace web ' +
                            Format(RecTra."Link transporte");
                            /////                         IF RecTra.Añadir=0 THEN Body:=Body+FORMAT(SalesInvHeader."Nº expedición");
                            if RecTra.Añadir = 0 then Body := Body + Format(NEXPEDI);
                            if RecTra.Añadir = 2 then
                                Body := Body + Format(NEXPEDI) + '/' +
        Format(SalesInvHeader."Ship-to Post Code");
                            /////                         FORMAT(SalesInvHeader."Ship-to Post Code");
                            Body := Body + ', a partir de hoy a las 22:00.';

                        end;
                    end;




                end;

                if RecCust."Country/Region Code" = 'PT' then begin

                    Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                    ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                    ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                    ' com Nº expedição: ' + Format(NEXPEDI) +
                    ' o qual deve de receber no trascurso de 24 a 48 horas. ';
                    if SalesInvHeader."Shipping Agent Code" = 'DHL' then begin
                        Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                        ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                        ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                        ' com Nº expedição: ' + Format(NEXPEDI) +
                        ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                        ' Pode fazer o seguimento do seu envío desde este site web. ' +
                        'http://www.dhl.es/services_es/seg_3dd/integra/SeguimientoDocumentos.aspx?codigo=' +
                        Format(NEXPEDI) + '&anno=2013&lang=sp&refCli=1 , a partir de hoje as 22:00.';
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'CRON' then begin
                        RecTra.Get(SalesInvHeader."Shipping Agent Code");
                        Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                        ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                        ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                        ' com Nº expedição: ' + Format(NEXPEDI) +
                        ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                        ' Pode fazer o seguimento do seu envío desde este site web. ' +
                        'https://www.correosexpress.com/url/v?s=' +
                        Format(NEXPEDI) + '&cp=' + Format(SalesInvHeader."Ship-to Post Code") +
                            ///                    'http://www.chronoexpres.com/chronoExtraNET/env/verEnvio.seam?usuario=f4429f061740b2a5528f4aa361d36dac'+
                            ///                    '&tipo=referencia&valor='+FORMAT(SalesInvHeader."Nº expedición")+
                            ///                    '&cp='+FORMAT(SalesInvHeader."Ship-to Post Code")+
                            ', a partir de hoje as 22:00.';
                        //paginaweb:='https://www.correosexpress.com/url/v?s='+FORMAT("Nº expedición")+'&cp='+FORMAT("Ship-to Post Code");
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'CORR' then begin
                        RecTra.Get(SalesInvHeader."Shipping Agent Code");
                        Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                        ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                        ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                        ' com Nº expedição: ' + Format(NEXPEDI) +
                        ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                        ' Pode fazer o seguimento do seu envío desde este site web. ' +
                        'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                        Format(NEXPEDI) +
                        ', a partir de hoje as 22:00.';
                    end;



                    if SalesInvHeader."Shipping Agent Code" = 'TNT' then begin
                        Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                        ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                        ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                        ' com Nº expedição: ' + Format(NEXPEDI) +
                        ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                        ' Pode fazer o seguimento do seu envío desde este site web. ' +
                        'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=' +
                        'REF&respLang=ES&respCountry=ES&sourceID=1&sourceCountry=' +
                        'ES&sourceID=1&sourceCountry=ww&cons=' +
                        Format(NEXPEDI) + ', a partir de hoje as 22:00.';
                        /////                    ' A fin de mes recibira una factura de todos sus albaranes.';
                    end;
                    if SalesInvHeader."Shipping Agent Code" = 'TIPSA' then begin
                        if COMPANYNAME = 'PEPE' then begin
                            Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                            ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                            ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                            ' com Nº expedição: ' + Format(NEXPEDI) +
                            ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                            ' Pode fazer o seguimento do seu envío desde este site web. ' +
                            'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                            Format(NEXPEDI) + ' - ' +
                            Format(SalesInvHeader."Your Reference") + ' - ' +
                            Format(SalesInvHeader."Order No.") +
                            Format(SalesInvHeader."Ship-to Post Code") +
                            ', a partir de hoje as 22:00.';
                        end;
                        if COMPANYNAME <> 'PEPE' then begin
                            Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                            ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                            ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                            ' com Nº expedição: ' + Format(NEXPEDI) +
                            ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                            ' Pode fazer o seguimento do seu envío desde este site web. ' +
                            'http://www.tip-sa.com/cliente/datos.php?id=04600400393' +
                            Format(NEXPEDI) +
                            Format(SalesInvHeader."Ship-to Post Code") +
                            ', a partir de hoje as 22:00.';
                        end;
                    end;
                    if RecTra.Get(SalesInvHeader."Shipping Agent Code") then begin
                        if RecTra."Link transporte" <> '' then begin
                            if RecTra.Code = 'TXT' then begin
                                ANYO := Date2dmy(SalesInvHeader."Posting Date", 3);
                                RecTra."Link transporte" := 'http://tracking.txt.es/?EXPED=@68381@fcyd0y4ui2n6emo@R@' + Format(NEXPEDI) + '@' + Format(ANYO) + '@';
                            end;

                            Body := 'V. Sas.: Adjunto remitimos a fatura nº: ' + SalesInvHeader."No." +
                            ' da sua encomenda ' + Format(SalesInvHeader."Your Reference") +
                            ' que foi entregada  á agência de transporte   ' + SalesInvHeader."Shipping Agent Code" +
                            ' com Nº expedição: ' + Format(NEXPEDI) +
                            ' o qual deve de receber no trascurso de 24 a 48 horas. ' +
                            ' Pode fazer o seguimento do seu envío desde este site web. ' +
                            Format(RecTra."Link transporte");
                            if RecTra.Añadir = 0 then Body := Body + Format(NEXPEDI);
                            if RecTra.Añadir = 2 then
                                Body := Body + Format(NEXPEDI) + '/' +
        Format(SalesInvHeader."Ship-to Post Code");
                            Body := Body + ', a partir de hoje as 22:00.';

                        end;
                    end;



                end;


                if SalesInvHeader."Shipping Agent Code" = 'CLI' then begin
                    Body := 'Muy señores nuestros, adjunto remitimos factura nº: ' + SalesInvHeader."No." +
                    ' de su pedido ' + Format(SalesInvHeader."Your Reference") +
                    ' estando a su disposición en nuestro almacén para su recogida,' +
                    ' con Nº expedicion: ' + Format(NEXPEDI);

                end;


                FileDirectory := 'F:\NavisionPdfs\' + SalesInvHeader."No." + '.pdf';


                SalesInvHeader2.Reset;
                SalesInvHeader2.SetRange("No.", SalesInvHeader."No.");
                if SalesInvHeader2.FindFirst then begin
                    /////-Report.SaveAsPdf(50900, FileDirectory, SalesInvHeader2);
                end;

                FileDirectoryexcel := 'F:\NavisionPdfs\' + SalesInvHeader."No." + '.xls';


                SalesInvHeader2.Reset;
                SalesInvHeader2.SetRange("No.", SalesInvHeader."No.");
                if SalesInvHeader2.FindFirst then begin
                    /////-Report.SaveAsExcel(50900, FileDirectoryexcel, SalesInvHeader2);
                end;


                Sleep(5000);

                if REC91.Get(UserId) then;
                RecCust.Get(SalesInvHeader."Sell-to Customer No.");

                SenderName := 'HAGEN';

                Subject := RecCust."Search Name" + ' - FACTURA Nº ' + Format(SalesInvHeader."No.");
                SenderAddress := REC91."E-Mail";
                if RecCust."Email facturacion 1" <> '' then begin
                    Recipient := RecCust."Email facturacion 1";
                    /////Recipient:='oscarraea@hotmail.com;martinjesus241@gmail.com';
                    /////-Clear(SMTP);
                    /////-SMTP.Run;
                    /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                    /////-SMTP.AddAttachment(FileDirectory, '');
                    /////-if RecCust."No enviar excel" = false then begin
                    /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                    /////-end;
                    /////SMTP.AddBCC('oscarraea@hotmail.com');




                    if RecCust."Adjuntar pub. facturacion 1" then begin
                        RecCVC.Get;
                        /*IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                             verificapubli1;
                             IF ENVIARPUBLI THEN BEGIN
                                  SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                             END;
                        END;
                        IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                             verificapubli2;
                             IF ENVIARPUBLI THEN BEGIN
                                  SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                             END;
                        END;
                        IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                             verificapubli3;
                             IF ENVIARPUBLI THEN BEGIN
                                  SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                             END;
                        END;
                        */

                        DESDEA := CalcDate('-6M', Today);
                        RecGPG.Reset;
                        RecGPG.SetRange(RecGPG."Es producto", true);
                        RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                        RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                        if RecGPG.FindFirst then
                            repeat
                                RecGPG.CalcFields(RecGPG.Importe);
                                if RecGPG.Importe <> 0 then begin
                                    if RecGPG."Id. publicidad" = 1 then begin
                                        if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                            verificapubli1;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 2 then begin
                                        if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                            verificapubli2;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 3 then begin
                                        if RecCVC."Ruta doc. GATOS" <> '' then begin
                                            verificapubli3;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 4 then begin
                                        if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                            verificapubli4;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 5 then begin
                                        if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                            verificapubli5;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 6 then begin
                                        if RecCVC."Ruta doc. PERROS" <> '' then begin
                                            verificapubli6;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 7 then begin
                                        if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                            verificapubli7;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                            end;
                                        end;
                                    end;
                                end;
                            until RecGPG.Next = 0;



                    end;
                    /////-SMTP.Send;
                    /////-Clear(SMTP);

                end;
                if RecCust."Email facturacion 2" <> '' then begin
                    Recipient := RecCust."Email facturacion 2";
                    /////-Clear(SMTP);
                    /////-SMTP.Run;
                    /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                    /////-SMTP.AddAttachment(FileDirectory, '');
                    /////-if RecCust."No enviar excel" = false then begin
                    /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                    /////-end;
                    ///SMTP.AddBCC('oscarraea@hotmail.com');
                    if RecCust."Adjuntar pub. facturacion 2" then begin
                        RecCVC.Get;
                        /*
                        IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                             SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                        END;
                        IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                             SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                        END;
                        IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                             SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                        END;
                        */

                        DESDEA := CalcDate('-6M', Today);
                        RecGPG.Reset;
                        RecGPG.SetRange(RecGPG."Es producto", true);
                        RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                        RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                        if RecGPG.FindFirst then
                            repeat
                                RecGPG.CalcFields(RecGPG.Importe);
                                if RecGPG.Importe <> 0 then begin
                                    if RecGPG."Id. publicidad" = 1 then begin
                                        if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                            verificapubli1;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 2 then begin
                                        if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                            verificapubli2;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 3 then begin
                                        if RecCVC."Ruta doc. GATOS" <> '' then begin
                                            verificapubli3;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 4 then begin
                                        if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                            verificapubli4;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 5 then begin
                                        if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                            verificapubli5;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 6 then begin
                                        if RecCVC."Ruta doc. PERROS" <> '' then begin
                                            verificapubli6;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 7 then begin
                                        if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                            verificapubli7;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                            end;
                                        end;
                                    end;
                                end;
                            until RecGPG.Next = 0;

                    end;

                    /////-SMTP.Send;
                    /////-Clear(SMTP);
                end;
                if RecCust."Email facturacion 3" <> '' then begin
                    Recipient := RecCust."Email facturacion 3";
                    /////-Clear(SMTP);
                    /////-SMTP.Run;
                    /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                    /////-SMTP.AddAttachment(FileDirectory, '');
                    /////-if RecCust."No enviar excel" = false then begin
                    /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                    /////-end;
                    ///SMTP.AddBCC('oscarraea@hotmail.com');
                    if RecCust."Adjuntar pub. facturacion 1" then begin
                        RecCVC.Get;
                        /*
                        IF RecCVC."Ruta doc. AQUAROFILA"<>'' THEN BEGIN
                             verificapubli1;
                             IF ENVIARPUBLI THEN BEGIN
                                  SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA");
                             END;
                        END;
                        IF RecCVC."Ruta doc. REPTILES"<>'' THEN BEGIN
                             verificapubli2;
                             IF ENVIARPUBLI THEN BEGIN
                                  SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES");
                             END;
                        END;
                        IF RecCVC."Ruta doc. GATOS"<>'' THEN BEGIN
                             verificapubli3;
                             IF ENVIARPUBLI THEN BEGIN
                                  SMTP.AddAttachment(RecCVC."Ruta doc. GATOS");
                             END;
                        END;
                        */
                        DESDEA := CalcDate('-6M', Today);
                        RecGPG.Reset;
                        RecGPG.SetRange(RecGPG."Es producto", true);
                        RecGPG.SetRange(RecGPG."Filtro fecha", DESDEA, Today);
                        RecGPG.SetFilter(RecGPG."Filtro Cliente", RecCust."No.");
                        if RecGPG.FindFirst then
                            repeat
                                RecGPG.CalcFields(RecGPG.Importe);
                                if RecGPG.Importe <> 0 then begin
                                    if RecGPG."Id. publicidad" = 1 then begin
                                        if RecCVC."Ruta doc. AQUAROFILA" <> '' then begin
                                            verificapubli1;
                                            if ENVIARPUBLI then begin
                                                /////- SMTP.AddAttachment(RecCVC."Ruta doc. AQUAROFILA", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 2 then begin
                                        if RecCVC."Ruta doc. REPTILES" <> '' then begin
                                            verificapubli2;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. REPTILES", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 3 then begin
                                        if RecCVC."Ruta doc. GATOS" <> '' then begin
                                            verificapubli3;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. GATOS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 4 then begin
                                        if RecCVC."Ruta doc. PAJAROS" <> '' then begin
                                            verificapubli4;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PAJAROS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 5 then begin
                                        if RecCVC."Ruta doc. PEQ.ANIMALES" <> '' then begin
                                            verificapubli5;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PEQ.ANIMALES", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 6 then begin
                                        if RecCVC."Ruta doc. PERROS" <> '' then begin
                                            verificapubli6;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. PERROS", '');
                                            end;
                                        end;
                                    end;
                                    if RecGPG."Id. publicidad" = 7 then begin
                                        if RecCVC."Ruta doc. ESTANQUES" <> '' then begin
                                            verificapubli7;
                                            if ENVIARPUBLI then begin
                                                /////-SMTP.AddAttachment(RecCVC."Ruta doc. ESTANQUES", '');
                                            end;
                                        end;
                                    end;
                                end;
                            until RecGPG.Next = 0;




                    end;
                    /////-SMTP.Send;
                    /////-Clear(SMTP);
                end;

                if RecVende.Get(SalesInvHeader."Salesperson Code") then begin
                    if RecVende."E-Mail" <> '' then begin
                        Recipient := RecVende."E-Mail";
                        /////-Clear(SMTP);
                        /////-SMTP.Run;
                        /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                        /////-/////-SMTP.AddAttachment(FileDirectory, '');
                        /////-if RecCust."No enviar excel" = false then begin
                        /////-SMTP.AddAttachment(FileDirectoryexcel, '');
                        /////-end;
                        ///SMTP.AddBCC('oscarraea@hotmail.com');
                        /////-SMTP.Send;
                        /////-Clear(SMTP);
                    end;
                end;



                SalesInvHeader3.Get(SalesInvHeader."No.");
                SalesInvHeader3."Email enviado" := true;
                SalesInvHeader3."Fecha enviado" := Today;
                SalesInvHeader3."Hora enviado" := Time;
                SalesInvHeader3.Modify;

            until SalesInvHeader.Next = 0;

    end;


    procedure ENVIARemailCartaTransfer()
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
    /////-SMTP: Codeunit UnknownCodeunit400;
    /////-ImpBull: Automation PDFPrinterSettings;
    begin

        VENTANA.Open('#1####################################');

        Customer.Reset;
        Customer.SetRange("No enviar cartas contables", false);
        if Customer.FindFirst then
            repeat
                VENTANA.Update(1, Customer."No.");
                Customer.CalcFields(Customer."Balance (LCY)");
                if Customer."Balance (LCY)" <> 0 then begin
                    Fechalimite := CalcDate('+7D', Today);
                    totalImpPdte := 0;
                    CustLedgerEntry.Reset;
                    CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", Customer."No.");
                    CustLedgerEntry.SetRange(CustLedgerEntry.Open, true);
                    CustLedgerEntry.SetRange(CustLedgerEntry."Payment Method Code", 'TRANSFEREN');
                    if CustLedgerEntry.FindFirst then
                        repeat
                            if CustLedgerEntry."Due Date" < Fechalimite then begin
                                CustLedgerEntry.CalcFields(CustLedgerEntry."Remaining Amount");
                                totalImpPdte := totalImpPdte + CustLedgerEntry."Remaining Amount";
                            end;
                        until CustLedgerEntry.Next = 0;
                    if totalImpPdte <> 0 then begin
                        FileDirectory := 'C:\kk\' + Customer."No." + '.pdf';
                        if Customer."Country/Region Code" <> 'PT' then begin
                            Customer2.Reset;
                            Customer2.SetRange("No.", Customer."No.");
                            if Customer2.FindFirst then begin
                                /////-Report.SaveAsPdf(50113, FileDirectory, Customer2);
                            end;
                        end;
                        if Customer."Country/Region Code" = 'PT' then begin
                            Customer2.Reset;
                            Customer2.SetRange("No.", Customer."No.");
                            if Customer2.FindFirst then begin
                                /////-Report.SaveAsPdf(50112, FileDirectory, Customer2);
                            end;
                        end;

                        Sleep(5000);
                        if REC91.Get(UserId) then;
                        SenderName := 'HAGEN';
                        Subject := 'NOTIFICACIONES CONTABLES';
                        Body := '';
                        SenderAddress := REC91."E-Mail";
                        if Customer."Email facturacion 1" <> '' then begin
                            Recipient := Customer."Email facturacion 1";
                            /////Recipient:='oscarraea@hotmail.com';   /////;ramon.yago@hagen.es;alexis.martin@hagen.es';
                            SalespersonPurchaser.Get(Customer."Salesperson Code");
                            if SalespersonPurchaser."E-Mail" <> '' then begin
                                Recipient := Customer."Email facturacion 1" + ';' + SalespersonPurchaser."E-Mail";
                            end;



                            /////-Clear(SMTP);
                            /////-SMTP.Run;
                            /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                            /////-SMTP.AddAttachment(FileDirectory, '');
                            /////-SMTP.AppendBody(Customer."No." + ' ' + Customer.Name + ' <BR>');
                            /////-SMTP.AppendBody('Muy señores nuestros, adjunto le remitimos la relación de facturas <BR>');
                            /////-SMTP.AppendBody('cuyo vencimiento esta proximo. <BR>');
                            /////-SMTP.AppendBody('<HR>');
                            /////-SMTP.AppendBody('<BR>');
                            /////-SMTP.AppendBody('Atentamente,<BR>');
                            /////-SMTP.AppendBody('ROLF C HAGEN ESPAÑA S.A.');
                            /////-SMTP.AppendBody('<BR>');
                            /////-SMTP.AppendBody('<BR>');
                            /////-SMTP.AppendBody('<BR>');
                            /////-SMTP.AppendBody('<BR>');
                            /////-SMTP.AppendBody(Customer."Email facturacion 1");
                            /////SMTP.AddBCC('facturacion@hagen.es');
                            /////SMTP.AddBCC('facturacion@hagen.es;oscarraea@hotmail.com');

                            /////-SMTP.Send;
                            /////-Clear(SMTP);
                        end;
                    end;
                end;
            until Customer.Next = 0;
    end;


    procedure ENVIARemailCartaVencidos()
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
    /////-SMTP: Codeunit UnknownCodeunit400;
    /////-ImpBull: Automation PDFPrinterSettings;
    begin

        VENTANA.Open('#1####################################');

        Customer.Reset;
        Customer.SetRange("No enviar cartas contables", false);
        if Customer.FindFirst then
            repeat
                Customer.CalcFields(Customer."Balance (LCY)");
                if Customer."Balance (LCY)" <> 0 then begin
                    Fechalimite := Today;
                    totalImpPdte := 0;
                    CustLedgerEntry.Reset;
                    CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", Customer."No.");
                    CustLedgerEntry.SetRange(CustLedgerEntry.Open, true);
                    CustLedgerEntry.SetFilter(CustLedgerEntry."Payment Method Code", 'PAGARE|TRANSFEREN');
                    if CustLedgerEntry.FindFirst then
                        repeat
                            if CustLedgerEntry."Due Date" < Fechalimite then begin
                                CarteraDoc.Reset;
                                CarteraDoc.SetRange(CarteraDoc."Document No.", CustLedgerEntry."Document No.");
                                if CarteraDoc.FindFirst then begin
                                    if CarteraDoc.Accepted <> 1 then begin
                                        CustLedgerEntry.CalcFields(CustLedgerEntry."Remaining Amount");
                                        totalImpPdte := totalImpPdte + CustLedgerEntry."Remaining Amount";
                                    end;
                                end;
                            end;
                        until CustLedgerEntry.Next = 0;
                    if totalImpPdte <> 0 then begin
                        VENTANA.Update(1, Customer."No.");

                        ///FileDirectory := 'C:\NavisionPdfs\'+Customer."No."+'.pdf';
                        FileDirectory := 'C:\kk\' + Customer."No." + '.pdf';
                        if Customer."Country/Region Code" <> 'PT' then begin
                            Customer2.Reset;
                            Customer2.SetRange("No.", Customer."No.");
                            if Customer2.FindFirst then begin
                                /////-Report.SaveAsPdf(50114, FileDirectory, Customer2);
                            end;
                        end;
                        if Customer."Country/Region Code" = 'PT' then begin
                            Customer2.Reset;
                            Customer2.SetRange("No.", Customer."No.");
                            if Customer2.FindFirst then begin
                                /////-Report.SaveAsPdf(50115, FileDirectory, Customer2);
                            end;
                        end;

                        Sleep(5000);
                        if REC91.Get(UserId) then;
                        SenderName := 'HAGEN';
                        Subject := 'NOTIFICACIONES CONTABLES';
                        Body := '';
                        SenderAddress := REC91."E-Mail";
                        if Customer."Email facturacion 1" <> '' then begin
                            Recipient := Customer."Email facturacion 1";
                            ///Recipient:='oscarraea@hotmail.com';
                            SalespersonPurchaser.Get(Customer."Salesperson Code");
                            if SalespersonPurchaser."E-Mail" <> '' then begin
                                Recipient := Customer."Email facturacion 1" + ';' + SalespersonPurchaser."E-Mail";
                            end;



                            /////-Clear(SMTP);
                            /////-SMTP.Run;
                            /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                            /////-SMTP.AddAttachment(FileDirectory, '');
                            /////-SMTP.AppendBody(Customer."No." + ' ' + Customer.Name + ' <BR>');
                            /////-SMTP.AppendBody('Muy señores nuestros, adjunto le remitimos la relación de facturas <BR>');
                            /////-SMTP.AppendBody('ya vencidas. <BR>');
                            /////-SMTP.AppendBody('<HR>');
                            /////-SMTP.AppendBody('<BR>');
                            /////-SMTP.AppendBody('Atentamente,<BR>');
                            /////-SMTP.AppendBody('ROLF C HAGEN ESPAÑA S.A.');
                            /////-SMTP.AppendBody('<BR>');
                            /////-SMTP.AppendBody('<BR>');
                            /////-SMTP.AppendBody('<BR>');
                            /////-SMTP.AppendBody('<BR>');
                            /////-SMTP.AppendBody(Customer."Email facturacion 1");
                            /////SMTP.AddBCC('facturacion@hagen.es;oscarraea@hotmail.com');


                            /////-SMTP.Send;
                            /////-Clear(SMTP);
                        end;
                    end;
                end;
            until Customer.Next = 0;
    end;


    procedure ENVIARemailCartaPagare()
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
    /////-SMTP: Codeunit UnknownCodeunit400;
    /////-ImpBull: Automation PDFPrinterSettings;
    begin

        VENTANA.Open('#1####################################');

        Customer.Reset;
        /////Customer.SETRANGE("No enviar cartas contables",FALSE);
        if Customer.FindFirst then
            repeat
                VENTANA.Update(1, Customer."No.");
                Customer.CalcFields(Customer."Balance (LCY)");
                if Customer."Balance (LCY)" <> 0 then begin
                    Fechalimite := CalcDate('+27D', Today);
                    totalImpPdte := 0;
                    CustLedgerEntry.Reset;
                    CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", Customer."No.");
                    CustLedgerEntry.SetRange(CustLedgerEntry.Open, true);
                    CustLedgerEntry.SetRange(CustLedgerEntry."Payment Method Code", 'PAGARE');
                    if CustLedgerEntry.FindFirst then
                        repeat
                            if CustLedgerEntry."Due Date" < Fechalimite then begin
                                CarteraDoc.Reset;
                                CarteraDoc.SetRange(CarteraDoc."Document No.", CustLedgerEntry."Document No.");
                                if CarteraDoc.FindFirst then begin
                                    if CarteraDoc.Accepted <> 1 then begin
                                        CustLedgerEntry.CalcFields(CustLedgerEntry."Remaining Amount");
                                        totalImpPdte := totalImpPdte + CustLedgerEntry."Remaining Amount";
                                    end;
                                end;

                            end;
                        until CustLedgerEntry.Next = 0;
                    if totalImpPdte <> 0 then begin
                        FileDirectory := 'C:\kk\' + Customer."No." + '.pdf';
                        if Customer."Country/Region Code" <> 'PT' then begin
                            Customer2.Reset;
                            Customer2.SetRange("No.", Customer."No.");
                            if Customer2.FindFirst then begin
                                /////-Report.SaveAsPdf(50116, FileDirectory, Customer2);
                            end;
                        end;
                        if Customer."Country/Region Code" = 'PT' then begin
                            Customer2.Reset;
                            Customer2.SetRange("No.", Customer."No.");
                            if Customer2.FindFirst then begin
                                /////-Report.SaveAsPdf(50118, FileDirectory, Customer2);
                            end;
                        end;

                        Sleep(5000);
                        if REC91.Get(UserId) then;
                        SenderName := 'HAGEN';
                        Subject := 'NOTIFICACIONES CONTABLES';
                        Body := '';
                        SenderAddress := REC91."E-Mail";
                        if Customer."Email facturacion 1" <> '' then begin
                            Recipient := Customer."Email facturacion 1";
                            SalespersonPurchaser.Get(Customer."Salesperson Code");
                            if SalespersonPurchaser."E-Mail" <> '' then begin
                                Recipient := Customer."Email facturacion 1" + ';' + SalespersonPurchaser."E-Mail";
                            end;
                            ///Recipient:='oscarraea@hotmail.com';


                            /////-Clear(SMTP);
                            /////-SMTP.Run;
                            /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                            /////-SMTP.AddAttachment(FileDirectory, '');
                            /////-SMTP.AppendBody(Customer."No." + ' ' + Customer.Name + ' <BR>');
                            /////-SMTP.AppendBody('Muy señores nuestros, adjunto le remitimos la relación de facturas <BR>');
                            /////-SMTP.AppendBody('cuyo vencimiento esta proximo. <BR>');
                            /////-SMTP.AppendBody('<HR>');
                            /////-SMTP.AppendBody('<BR>');
                            /////-SMTP.AppendBody('Atentamente,<BR>');
                            /////-SMTP.AppendBody('ROLF C HAGEN ESPAÑA S.A.');
                            /////-SMTP.AppendBody('<BR>');
                            /////-SMTP.AppendBody('<BR>');
                            /////-SMTP.AppendBody('<BR>');
                            /////-SMTP.AppendBody('<BR>');
                            /////-SMTP.AppendBody(Customer."Email facturacion 1");
                            //// SMTP.AddBCC('facturacion@hagen.es');
                            /////SMTP.AddBCC('facturacion@hagen.es;oscarraea@hotmail.com');


                            /////-SMTP.Send;
                            /////-Clear(SMTP);
                        end;
                    end;
                end;
            until Customer.Next = 0;
    end;


    procedure ReENVIAEXPEDICIONES(var RecCV: Record "Sales Header")
    var
        retorno: Char;

    begin

        retorno := 13;


        NPEDIDO := RecCV."Nº expedición";
        RecCVE.Reset;
        RecCVE.SetCurrentkey("Document Type", "Nº expedición");
        RecCVE.SetRange(RecCVE."Document Type", 1);
        RecCVE.SetRange(RecCVE."Nº expedición", RecCV."Nº expedición");
        if RecCVE.Find('-') then begin
            if Today <> 0D then begin
                ESDIA1 := Date2dmy(Today, 1);
                ESMES1 := Date2dmy(Today, 2);
                ESAÑO1 := Date2dmy(Today, 3);
                ESMES11 := Format(ESMES1);
                if ESMES1 = 1 then ESMES11 := '01';
                if ESMES1 = 2 then ESMES11 := '02';
                if ESMES1 = 3 then ESMES11 := '03';
                if ESMES1 = 4 then ESMES11 := '04';
                if ESMES1 = 5 then ESMES11 := '05';
                if ESMES1 = 6 then ESMES11 := '06';
                if ESMES1 = 7 then ESMES11 := '07';
                if ESMES1 = 8 then ESMES11 := '08';
                if ESMES1 = 9 then ESMES11 := '09';
                if ESMES1 = 10 then ESMES11 := '10';
                if ESMES1 = 11 then ESMES11 := '11';
                if ESMES1 = 12 then ESMES11 := '12';

                ESDIA11 := Format(ESDIA1);
                if ESDIA1 = 1 then ESDIA11 := '01';
                if ESDIA1 = 2 then ESDIA11 := '02';
                if ESDIA1 = 3 then ESDIA11 := '03';
                if ESDIA1 = 4 then ESDIA11 := '04';
                if ESDIA1 = 5 then ESDIA11 := '05';
                if ESDIA1 = 6 then ESDIA11 := '06';
                if ESDIA1 = 7 then ESDIA11 := '07';
                if ESDIA1 = 8 then ESDIA11 := '08';
                if ESDIA1 = 9 then ESDIA11 := '09';
                FECORD1 := Format(ESAÑO1, 4, '<integer>') + ESMES11 + ESDIA11;
            end;

            FECORD2 := FECORD1;

            OBS := '';
            NOMULTIPEDIDO := false;
            RecCVE.Reset;
            RecCVE.SetCurrentkey("Document Type", "Nº expedición");
            RecCVE.SetRange(RecCVE."Document Type", 1);
            RecCVE.SetRange(RecCVE."Nº expedición", RecCV."Nº expedición");
            if RecCVE.FindSet then
                repeat
                    RecLV.Reset;
                    RecLV.SetRange(RecLV."Document Type", RecCVE."Document Type");
                    RecLV.SetRange(RecLV."Document No.", RecCVE."No.");
                    if RecLV.FindSet then
                        repeat
                            if RecItem2.Get(RecLV."No.") then begin
                                if RecLV."Outstanding Quantity" <> 0 then begin
                                    if RecLV."Enviar a ADAIA" then begin
                                        RecItem2."No permite pedido" := false;
                                    end;
                                    /////IF (RecItem2."Producto almacenable") AND (NOT RecItem2."No permite pedido") THEN BEGIN
                                    if (RecItem2."Producto almacenable") then begin
                                        if RecItem2."NO MULTIPEDIDO" then begin
                                            NOMULTIPEDIDO := true;
                                        end;
                                    end;
                                end;
                            end;
                        until RecLV.Next = 0;
                until RecCVE.Next = 0;

            OBS := RecCVE."Observación PDA";
            if (RecCVE."NO MULTIPEDIDO") or (NOMULTIPEDIDO) then begin
                OBS := 'NO MULTIPEDIDO' + ' ' + RecCVE."Observación PDA";
            end;




            TextoSalida := 'OECA' + '|' +
                           'AG' + '|' +
                           NPEDIDO + '|' +
                           '01' + '|' +
                           RecCVE."Sell-to Customer No." + '|' +
                           '|' +
                           'PED|' +
                           '|' +
                           '|' +
                           FECORD1 + '|' +
                           FECORD1 + '|' +
                           HH + MI + '|' +
                           'N|' +
                           Format(OBS, 40) + '|||||' + retorno;
            OutStream.Writetext(TextoSalida);
        end;

        codtras := '';
        CONTALIN := 0;
        RecCVE.Reset;
        RecCVE.SetCurrentkey("Document Type", "Nº expedición");
        RecCVE.SetRange(RecCVE."Document Type", 1);
        RecCVE.SetRange(RecCVE."Nº expedición", RecCV."Nº expedición");
        if RecCVE.FindSet then
            repeat

                RespetaTrans := RecCVE."Respeta agencia transporte";
                if RecCVE."Shipping Agent Code" = 'DHL' then begin
                    codtras := 'DHL';
                end;
                if RecCVE."Shipping Agent Code" = 'SEUR' then begin
                    codtras := 'SEUR';
                end;
                if RecCVE."Shipping Agent Code" = 'TNT' then begin
                    codtras := 'TNT';
                end;

                if RecCVE."Shipping Agent Code" = 'TIPSA' then begin
                    codtras := 'TIPSA';
                end;
                if RecCVE."Shipping Agent Code" = 'CORR' then begin
                    codtras := 'CORR';
                end;





                NLIN := 0;
                RecLV.Reset;
                RecLV.SetRange(RecLV."Document Type", RecCVE."Document Type");
                RecLV.SetRange(RecLV."Document No.", RecCVE."No.");
                RecLV.SetRange(RecLV."Nº expedición", RecCVE."Nº expedición");
                if RecLV.FindSet then
                    repeat
                        if RecItem2.Get(RecLV."No.") then begin
                            if (RecLV."Outstanding Quantity" <> 0) then begin
                                if RecLV."Enviar a ADAIA" then begin
                                    RecItem2."No permite pedido" := false;
                                end;
                                /////IF (RecItem2."Producto almacenable") AND (NOT RecItem2."No permite pedido") THEN BEGIN
                                if (RecItem2."Producto almacenable") then begin
                                    CONTALIN := CONTALIN + 10000;
                                    NLINC := Format(CONTALIN, 9, '<integer>');
                                    CANTIDADTRAS := Format(RecLV.Quantity, 6, '<integer>');


                                    RecLV.CalcFields(RecLV."Suma cdad. por envio");
                                    if RecLV."Suma cdad. por envio" <> RecLV."Outstanding Quantity" then begin
                                        CANTIDADTRAS := Format(RecLV."Suma cdad. por envio", 6, '<integer>');
                                        RecLVSuma.Reset;
                                        RecLVSuma.SetCurrentkey(RecLVSuma."Nº expedición", RecLVSuma."No.");
                                        RecLVSuma.SetRange(RecLVSuma."Nº expedición", RecCV."Nº expedición");
                                        RecLVSuma.SetRange(RecLVSuma."No.", RecLV."No.");
                                        if RecLVSuma.FindSet then
                                            repeat
                                                RecLVSuma."Linea Nº expedición" := CONTALIN;
                                                RecLVSuma.Validate(RecLVSuma."Qty. to Ship", 0);
                                                RecLVSuma.Modify;
                                            until RecLVSuma.Next = 0;
                                    end;


                                    PRECIO := Format(RecLV."Unit Price", 6, '<integer>');
                                    KILOSTRAS := '';

                                    TextoSalida := 'OELI' + '|' +
                                               'AG' + '|' +
                                               NPEDIDO + '|' +
                                               NLINC + '|' +
                                               RecLV."No." + '|' +
                                               CANTIDADTRAS + '|' +
                                               'UD' + '|' +
                                               '1' + '|' +
                                               '' + '|' +
                                               '' + '||||' + retorno;
                                    OutStream.Writetext(TextoSalida);
                                    /////RecLV."Nº expedición":=RecCV."Nº expedición";
                                    /////RecLV."Linea Nº expedición":=CONTALIN;
                                end;
                                RecLV.Validate(RecLV."Qty. to Ship", 0);
                                RecLV.Modify;

                                if RecItem2."Enviar siempre" then begin
                                    RecLV.Validate(RecLV."Qty. to Ship", RecLV.Quantity);
                                    RecLV.Modify;
                                end;
                            end;
                        end;
                    until RecLV.Next = 0;

            until RecCVE.Next = 0;

        ENVIAR := true;
        if (RecCVE."Marcar para agrupar" = true) and (RecCVE."Multi-picking") then begin
            ENVIAR := false;
        end;



        TextoSalida := 'OELI' + '|' +
                       'AG' + '|' +
                       NPEDIDO + '|' +
                       '000000001|' +
                       '10|' +
                       '000001|' +
                       'UD' + '|' +
                       '1' + '|' +
                       '' + '|' +
                       '' + '||||' + retorno;
        if ENVIAR then begin
            OutStream.Writetext(TextoSalida);
        end;

        TextoSalida := 'OELI' + '|' +
                       'AG' + '|' +
                       NPEDIDO + '|' +
                       '000000002|' +
                       '11|' +
                       '000001|' +
                       'UD' + '|' +
                       '1' + '|' +
                       '' + '|' +
                       '' + '||||' + retorno;
        if ENVIAR then begin
            OutStream.Writetext(TextoSalida);
        end;

        TextoSalida := 'OELI' + '|' +
                       'AG' + '|' +
                       NPEDIDO + '|' +
                       '000000003|' +
                       '15|' +
                       '000001|' +
                       'UD' + '|' +
                       '1' + '|' +
                       '' + '|' +
                       '' + '||||' + retorno;
        OutStream.Writetext(TextoSalida);


        TextoSalida := 'OELI' + '|' +
                       'AG' + '|' +
                       NPEDIDO + '|' +
                       '000000003|' +
                       '12|' +
                       '000001|' +
                       'UD' + '|' +
                       '1' + '|' +
                       '' + '|' +
                       '' + '||||' + retorno;
        ///           ArchSalida.WRITE(TextoSalida);


        RecCE.Get;
        RUTA := RecCE."Ruta salida de_gestion";
        TIPO := 3;
        BUSCAEXTENSION;
        DAT2 := 'TREXPORD.' + EXTEN + Format(ALEA);
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);

    end;


    procedure ENVIAREMIALFACTURASweb()
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
    /////-SMTP: Codeunit UnknownCodeunit400;
    /////-ImpBull: Automation PDFPrinterSettings;
    begin

        SalesInvHeader.Reset;
        SalesInvHeader.SetCurrentkey(SalesInvHeader."Enviar email", SalesInvHeader."Email enviado");
        SalesInvHeader.SetRange("Posting Date", 20210101D, Today);
        SalesInvHeader.SetRange(SalesInvHeader."Enviar email", true);
        if SalesInvHeader.FindSet then
            repeat
                RecCust.Get(SalesInvHeader."Sell-to Customer No.");
                /////-FileManagement.CreateClientDirectory('F:\documentosweb\facturasweb\' + Format(SalesInvHeader."Sell-to Customer No."));

                FileDirectory := 'F:\documentosweb\facturasweb\' + Format(SalesInvHeader."Sell-to Customer No.") + '\' + SalesInvHeader."No." + '.pdf';

                SalesInvHeader2.Reset;
                SalesInvHeader2.SetRange("No.", SalesInvHeader."No.");
                if SalesInvHeader2.FindFirst then begin
                    /////-Report.SaveAsPdf(50900, FileDirectory, SalesInvHeader2);
                end;


            until SalesInvHeader.Next = 0;
    end;


    procedure ENVIAREMIALABONOSweb()
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
    /////-SMTP: Codeunit UnknownCodeunit400;
    /////-ImpBull: Automation PDFPrinterSettings;
    begin

        SalesInvHeader.Reset;
        SalesInvHeader.SetCurrentkey(SalesInvHeader."Enviar email", SalesInvHeader."Email enviado");
        SalesInvHeader.SetRange("Posting Date", 20210101D, Today);
        SalesInvHeader.SetRange(SalesInvHeader."Enviar email", true);
        if SalesInvHeader.FindSet then
            repeat
                RecCust.Get(SalesInvHeader."Sell-to Customer No.");
                /////-FileManagement.CreateClientDirectory('F:\documentosweb\facturasweb\' + Format(SalesInvHeader."Sell-to Customer No."));

                FileDirectory := 'F:\documentosweb\facturasweb\' + Format(SalesInvHeader."Sell-to Customer No.") + '\' + SalesInvHeader."No." + '.pdf';

                SalesInvHeader2.Reset;
                SalesInvHeader2.SetRange("No.", SalesInvHeader."No.");
                if SalesInvHeader2.FindFirst then begin
                    /////-Report.SaveAsPdf(207, FileDirectory, SalesInvHeader2);
                end;


            until SalesInvHeader.Next = 0;
    end;


    procedure ENVIAREMIALALBARANESweb()
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
    /////-SMTP: Codeunit UnknownCodeunit400;
    /////-ImpBull: Automation PDFPrinterSettings;
    begin

        SalesInvHeader.Reset;
        SalesInvHeader.SetCurrentkey(SalesInvHeader."Enviar email", SalesInvHeader."Email enviado");
        SalesInvHeader.SetRange("Posting Date", 20210101D, Today);
        SalesInvHeader.SetRange(SalesInvHeader."Enviar email", true);
        if SalesInvHeader.FindSet then
            repeat
                RecCust.Get(SalesInvHeader."Sell-to Customer No.");
                /////-FileManagement.CreateClientDirectory('F:\documentosweb\facturasweb\' + Format(SalesInvHeader."Sell-to Customer No."));

                FileDirectory := 'F:\documentosweb\facturasweb\' + Format(SalesInvHeader."Sell-to Customer No.") + '\' + SalesInvHeader."No." + '.pdf';

                SalesInvHeader2.Reset;
                SalesInvHeader2.SetRange("No.", SalesInvHeader."No.");
                if SalesInvHeader2.FindFirst then begin
                    /////-Report.SaveAsPdf(50900, FileDirectory, SalesInvHeader2);
                end;


            until SalesInvHeader.Next = 0;
    end;


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
        /////-SMTP: Codeunit UnknownCodeunit400;
        /////-ImpBull: Automation PDFPrinterSettings;
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentHeader2: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        aviso: Boolean;
    begin

        v.Open('#1###########################');

        SalesShipmentHeader.Reset;
        SalesShipmentHeader.SetCurrentkey("Aviso falta stock");
        ///SalesShipmentHeader.SETRANGE("Aviso falta stock",FALSE);
        /////SalesShipmentHeader.SETRANGE("Posting Date",20220107D,TODAY);
        SalesShipmentHeader.SetRange("No.", '22ALB08-0885');
        if SalesShipmentHeader.FindSet then
            repeat
                v.Update(1, SalesShipmentHeader."No.");
                ///    IF SalesShipmentHeader."Grupo clientes"='G52' THEN BEGIN
                /////MESSAGE('%1',SalesShipmentHeader."Payment Method Code");
                /*
                        IF (SalesShipmentHeader."Payment Method Code"='CARGO0030') OR

                (SalesShipmentHeader."Payment Method Code"='CARGO0049') OR
                (SalesShipmentHeader."Payment Method Code"='CARGO0049C') OR
                (SalesShipmentHeader."Payment Method Code"='CARGO0081') OR
                (SalesShipmentHeader."Payment Method Code"='CARGO0182') OR
                (SalesShipmentHeader."Payment Method Code"='CARGO0182C') OR
                (SalesShipmentHeader."Payment Method Code"='CARGO2077') OR
                (SalesShipmentHeader."Payment Method Code"='CARGO2077C') OR
                (SalesShipmentHeader."Payment Method Code"='CARGO2100') OR
                (SalesShipmentHeader."Payment Method Code"='CARGO2100B') OR
                (SalesShipmentHeader."Payment Method Code"='CARGO2100C') OR
                (SalesShipmentHeader."Payment Method Code"='CARGO3058') OR
                (SalesShipmentHeader."Payment Method Code"='CARGO3058C') THEN BEGIN


                */

                SalesShipmentLine.Reset;
                SalesShipmentLine.SetRange("Document No.", SalesShipmentHeader."No.");
                if SalesShipmentLine.FindSet then
                    repeat
                        if SalesShipmentLine."Quantity (Base)" = 0 then begin
                            REC91.Get(UserId);
                            SenderName := COMPANYNAME;
                            Subject := RecCus."Search Name" + ' - PEDIDO Nº ' + Format(SalesShipmentHeader."Your Reference");
                            SenderAddress := REC91."E-Mail";
                            Recipient := RecCus."Email pedido 1";
                            Recipient := 'aseydesa@gmail.com'; /////;martinjesus241@gmail.com';
                                                               /////-Clear(SMTP);
                                                               /////-SMTP.Run;
                                                               /////-SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, true);
                                                               /////-SMTP.AppendBody('Muy señores nuestros. <BR>');
                                                               /////-SMTP.AppendBody('Le informamos que la ref ' + SalesShipmentLine."No." + ' ' + SalesShipmentLine.Description + ' Cantidad:' + Format(SalesShipmentLine.Quantity) + '.<BR>');
                                                               /////-SMTP.AppendBody('Esta en rorura de stock.<BR>');
                                                               /////-SMTP.AppendBody('<HR>');
                                                               /////-SMTP.AppendBody('<BR>');
                                                               /////-SMTP.AppendBody('Atentamente,<BR>');
                                                               /////-SMTP.AppendBody('Pascual Duarte<BR>');
                                                               /////-                            SMTP.AppendBody('ROLF C HAGEN ESPAÑA S.A.');
                                                               /////-SMTP.AppendBody('<BR>');
                                                               /////-SMTP.AppendBody('<BR>');
                                                               /////-SMTP.AppendBody('<BR>');
                                                               /////-SMTP.AppendBody('<BR>');
                                                               /////-SMTP.Send;
                                                               /////-Clear(SMTP);
                        end;
                    until SalesShipmentLine.Next = 0;
                ////        END;
                ///    END;
                SalesShipmentHeader2.Get(SalesShipmentHeader."No.");
                SalesShipmentHeader2."Aviso falta stock" := true;
                SalesShipmentHeader2.Modify;

            until SalesShipmentHeader.Next = 0;

        v.Close;


        Message('HECHO');

    end;


    procedure ETISTDServiceItem(var Rec: Record "Service Item")
    begin


        /// STD

        ServiceItem.Get(Rec."No.");



        TIPO := 3;
        BUSCAEXTENSION;

        ///IF ServiceItem."Nº expedición dropshp"='' THEN BEGIN
        EXTEN := EXTEN + Format(Rec."No.");
        ///END;
        ///IF ServiceItem."Nº expedición dropshp"<>'' THEN BEGIN
        ///EXTEN:=EXTEN+FORMAT(Rec110."Nº expedición dropshp");
        ///END;




        RecCusto.Get(ServiceItem."Customer No.");

        DESNOMa1 := ConvertStr(CopyStr(RecCusto."Search Name", 1, 30), 'ª', '.');
        DESNOMa1 := ConvertStr(DESNOMa1, 'º', '.');
        DESNOMa1 := CASCII.Ascii2Ansi(DESNOMa1);
        if ServiceItem."Ship-to Name" <> '' then begin
            DESNOMa1 := ConvertStr(CopyStr(ServiceItem."Ship-to Name", 1, 50), 'ª', '.');
            DESNOMa1 := ConvertStr(DESNOMa1, 'º', '.');
            DESNOMa1 := CASCII.Ascii2Ansi(DESNOMa1);
        end;
        if ServiceItem."Ship-to Name 2" <> '' then begin
            DESNOMa2 := ConvertStr(CopyStr(ServiceItem."Ship-to Name 2", 1, 50), 'ª', '.');
            DESNOMa2 := ConvertStr(DESNOMa2, 'º', '.');
            DESNOMa2 := CASCII.Ascii2Ansi(DESNOMa2);
        end;

        DESNOMa3 := ConvertStr(CopyStr(ServiceItem."Ship-to Address", 1, 50), 'ª', '.');
        DESNOMa3 := ConvertStr(DESNOMa3, 'º', '.');
        DESNOMa3 := CASCII.Ascii2Ansi(DESNOMa3);
        DESNOMa4 := ConvertStr(CopyStr(ServiceItem."Ship-to Address 2", 1, 50), 'ª', '.');
        DESNOMa4 := ConvertStr(DESNOMa4, 'º', '.');
        DESNOMa4 := CASCII.Ascii2Ansi(DESNOMa4);


        RecIE.Get;


        NEXPE := '00000000';
        ANO2 := '8';
        PAISDES := 'ES';
        PAISDES := ServiceItem."Ship-to Country/Region Code";
        if ServiceItem."Ship-to Country/Region Code" = '' then begin
            PAISDES := ServiceItem."Country/Region Code";
        end;
        if PAISDES = '' then begin
            PAISDES := 'ES';
        end;

        AA := Date2dmy(WorkDate, 3);
        MM := Date2dmy(WorkDate, 2);
        DD := Date2dmy(WorkDate, 1);
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

        TIPOSER := ' ';

        /*
        OBSERV1:=COPYSTR(Rec110."Observación para transporte",1,40);
        OBSERV2:='';
        IF Rec110."Nº Palets"<>0 THEN BEGIN
             OBSERV2:='Palets:'+FORMAT(Rec110."Nº Palets")+'. NO DESPALETIZAR';
        END;
        */
        NTEL2 := Format(ServiceItem."Ship-to Phone No.");
        if ServiceItem."Ship-to Phone No." <> '' then begin
            NTEL2 := Format(RecCusto."Nº movil");
        end;
        ///IF Rec110."Envio a-Nº Telefono"<>'' THEN BEGIN
        ///     NTEL2:=FORMAT(Rec110."Envio a-Nº Telefono");
        ///END;




        REEMBOLSO := '';




        TEMAIL := ServiceItem."Ship-to Email";
        SERVIRDABADO := 'N';
        RecTra.Get(ServiceItem."Shipping Agent Code");


        if RecTra.Potyugal then begin
            NTEL2 := ConvertStr(NTEL2, '+', ' ');
        end;


        xx := 0;

        ntel3 := '';
        repeat
            xx := xx + 1;
            if (CopyStr(NTEL2, xx, 1) = '0') or
               (CopyStr(NTEL2, xx, 1) = '1') or
               (CopyStr(NTEL2, xx, 1) = '2') or
               (CopyStr(NTEL2, xx, 1) = '3') or
               (CopyStr(NTEL2, xx, 1) = '4') or
               (CopyStr(NTEL2, xx, 1) = '5') or
               (CopyStr(NTEL2, xx, 1) = '6') or
               (CopyStr(NTEL2, xx, 1) = '7') or
               (CopyStr(NTEL2, xx, 1) = '8') or
               (CopyStr(NTEL2, xx, 1) = '9') then begin
                ntel3 := ntel3 + (CopyStr(NTEL2, xx, 1));
            end;

        until xx > StrLen(NTEL2);

        NTEL2 := ntel3;



        elpeso := BuscaPesoEtiquetaEnvio(elpeso, Rec110."Shipping Agent Code", Rec110."Ship-to Post Code");


        decre := 1;
        if RecTra.Get(ServiceItem."Shipping Agent Code") then begin
            if RecTra."Decremento kilo" <> 0 then begin
                decre := (100 - RecTra."Decremento kilo") / 100;
            end;
        end;
        elpeso := ROUND(elpeso * decre, 1);

        if elpeso < 1 then begin
            elpeso := 1;
        end;

        CODPAIES2 := '';
        codpais := '';
        cospostat := '';
        /////IF Rec110."Ship-to Country/Region Code"<>'ES' THEN BEGIN
        codpais := ServiceItem."Ship-to Country/Region Code";
        CODPAIES2 := '0';
        cospostat := ServiceItem."Ship-to Post Code";
        /////END;
        if ServiceItem."Ship-to Country/Region Code" = 'PT' then begin
            codpais := 'PT';
            ///// Rec110."Ship-to Country/Region Code";
            CODPAIES2 := '6';
            cospostat := CopyStr(ServiceItem."Ship-to Post Code", 1, 4) + CopyStr(ServiceItem."Ship-to Post Code", 6, 3);
        end;

        RecTra.Get(ServiceItem."Shipping Agent Code");

        ///totalbultos:=Rec110."Nº bultos"+Rec110."Nº Palets";
        totalbultos := ServiceItem."Nº bultos";
        ///MESSAGE('%1',totalbultos);


        NEXPEDICION := 'SAT-' + ServiceItem."No.";


        TextoSalida1 := Format(DESNOMa1, 50) +
                      Format(DESNOMa2, 50) +
                      Format(DESNOMa3, 50) +
                      Format(DESNOMa4, 50);
        TextoSalida2 := Format(ServiceItem."Ship-to Post Code", 5) +
                      Format(ServiceItem."Ship-to City", 30) +
                      Format(ServiceItem."Ship-to County", 30) +
                      Format(ServiceItem."Ship-to Contact", 50);
        TextoSalida3 := Format(NTEL2, 30) +
                      Format(NEXPEDICION, 60) +
                      Format(NEXPEDICION, 30) +
                      Format(NEXPEDICION, 30) +
                      Format(totalbultos, 10) +
                      Format(elpeso, 10) +
                      Format('0', 10);
        if not RecTra.Potyugal then begin
            TextoSalida4 := Format(OBSERV1, 40) +
                          Format(OBSERV2, 40) +
                          Format(DD1 + MM1 + AA1, 8) +
                          Format(TEMAIL, 80) +
                          Format(SERVIRDABADO, 1) +
                          Format('0', 10) +
                          Format(RecTra."Texto final fichero", 30) +
                          Format(codpais, 2) +
                          Format(CODPAIES2, 2) +
                          Format(cospostat, 6);
        end;
        if RecTra.Potyugal then begin
            TextoSalida4 := Format(OBSERV1, 40) +
                          Format(OBSERV2, 40) +
                          Format(DD1 + MM1 + AA1, 8) +
                          Format(TEMAIL, 80) +
                          Format(SERVIRDABADO, 1) +
                          Format('0', 10) +
                          Format(RecTra."Texto final fichero", 30) +
                          Format(codpais, 2) +
                          Format(cospostat, 8);
        end;

        TextoSalida5 := '';
        if ShippingAgentServices.Get(ServiceItem."Shipping Agent Code", ServiceItem."Shipping Agent Service Code") then begin

            TextoSalida5 := Format(ShippingAgentServices."Codigo Servicio", 10) +
                      Format(ShippingAgentServices.Horario, 10);
        end;

        /*
        
        Posición
        
        pais destino=2
        2
        715
        postal destino=7
        7
        717
        
        Los codigos postales como los de Portugal hay que quitarles el espacio que tienen deben de ser numero seguidos
        
        */


        OutStream.Writetext(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4 + TextoSalida5);

        Sleep(3000);


        /// Exportación a dhl

        RecCE.Get;
        /////RUTA:='\\192.168.0.225\agencias\TIPSA\';


        RecTra.Get(ServiceItem."Shipping Agent Code");
        RUTA := RecTra."Ruta fichero";


        /////IF RecCusto."No."='4703' THEN BEGIN
        /////                    RUTA:='\\192.168.0.225\agencias\m\';
        /////END;
        if COMPANYNAME = 'PEPE' then begin
            RecTra.Get(ServiceItem."Shipping Agent Code");
            RUTA := RecTra."Ruta fichero";
        end;

        DAT2 := 'ETISTD' + EXTEN + Format(ALEA) + '.TXT';
        TempBlob.CreateInStream(InStream);
        FicherosHagen.CrearFichero(RUTA, DAT2, InStream);


    end;

    procedure BCEnviarEmailSinC(parDestinatarios: List of [Text]; parSubject: Text; parBody: Text; parHtmlFormatted: Boolean; parPath: Text;
       parAttachmentName: Text[250]; parContentType: Text[250]; parEmailScenario: Enum "Email Scenario"; parCC: Text; parBCC: Text; AttachmentInStream: InStream)



    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        cduFileManagement: Codeunit "File Management";
        AttachmentTempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
    begin
        EmailMessage.Create(parDestinatarios, parSubject, parBody, parHtmlFormatted, parCC.Split(';'), parBCC.Split(';'));


        EmailMessage.AddAttachment(parAttachmentName, parContentType, AttachmentInStream);

        Email.Send(EmailMessage, parEmailScenario);
    end;

    procedure ModifCanarias(var Rec: Record "Sales Invoice Header");
    var
        RecHFV: Record "Sales Invoice Header";

    begin

        RecHFV.get(Rec."No.");
        RecHFV."Pasada a Canarias" := true;
        RecHFV.Modify;



    end;


}

