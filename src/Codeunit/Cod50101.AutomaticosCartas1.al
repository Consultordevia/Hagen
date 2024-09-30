#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50101 "Automaticos Cartas1"
{


    procedure MODIFCLIENTES(var RecCust: Record Customer)
    var
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        FileName: Text;
        InStream: InStream;
        FicherosHagen: Codeunit FicherosHagen;
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
        CODPAIES2: Code[1];
        SalesHeader2: Record "Sales Header";
        SalesLine2: Record "Sales Line";
        SalesLine3: Record "Sales Line";
        tienerotura: Boolean;
        NEXPEDI: Code[20];
        Customer: Record Customer;
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


    begin

        RecCE.Get;
        rut := RecCE."Ruta salida incial adaia";

        ArchExt4 := rut + 'Trter.TXT';
        ///ArchSalida4.TextMode := true;
        ///ArchSalida4.WriteMode := true;
        ///ArchSalida4.Create(ArchExt4);
        TempBlob.CreateOutStream(OutStream);

        DESNOM := ConvertStr(CopyStr(RecCust.Name, 1, 30), 'ª', '.');
        DESNOM := ConvertStr(DESNOM, 'º', '.');
        DESNOM2 := ConvertStr(CopyStr(RecCust."Search Name", 1, 30), 'ª', '.');
        DESNOM2 := ConvertStr(DESNOM2, 'º', '.');
        DESNOM3 := ConvertStr(CopyStr(RecCust.Address, 1, 30), 'ª', '.');
        DESNOM3 := ConvertStr(DESNOM3, 'º', '.');
        DESNOM4 := ConvertStr(CopyStr(RecCust.City, 1, 30), 'ª', '.');
        DESNOM4 := ConvertStr(DESNOM4, 'º', '.');
        ///DESNOM := CASCII.Ascii2Ansi(DESNOM);
        ///DESNOM2 := CASCII.Ascii2Ansi(DESNOM2);
        ///DESNOM3 := CASCII.Ascii2Ansi(DESNOM3);
        ///DESNOM4 := CASCII.Ascii2Ansi(DESNOM4);

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
                                               //ArchSalida4.Write(TextoSalida4);
        OutStream.Write(TextoSalida4);


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
                                               ///ArchSalida4.Write(TextoSalida4);
        OutStream.Write(TextoSalida4);


        ///                       ArchSalida4.Close;

        TIPO := 3;
        RUTA := RecCE."Ruta salida de_gestion";
        BUSCAEXTENSION;
        ///if Exists(rut+'Trter.txt') then begin
        ///DAT1:=rut+'Trter.txt';
        //DAT2:='TRTER.'+EXTEN+Format(ALEA)+Format(RecCust."No.")+Format(LOGCAMBIOA);
        DAT2 := 'TRTER.' + Format(RecCust."No.");
        ///FILE.Rename(DAT1,DAT2);

        TempBlob.CreateInStream(InStream);
        //Message('%1 %2', RecCE."Ruta salida de_gestion", DAT2);        
        FicherosHagen.CrearFichero(RecCE."Ruta salida de_gestion", DAT2, InStream);



    end;

    procedure BUSCAEXTENSION()
    var
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
        CODPAIES2: Code[1];
        SalesHeader2: Record "Sales Header";
        SalesLine2: Record "Sales Line";
        SalesLine3: Record "Sales Line";
        tienerotura: Boolean;
        NEXPEDI: Code[20];
        Customer: Record Customer;
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


}

