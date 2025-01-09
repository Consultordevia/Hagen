#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50080 "Importacion PEDIDOS WEB18"
{


    /*

                            FORMAT(SalesHeader."No.")+';'+1
                            FORMAT(SalesHeader."Posting Date")+';'+2
                            FORMAT(SalesHeader."Sell-to Customer No.")+';'+3
                            FORMAT(SalesHeader."Your Reference")+';'+4
                            FORMAT(SalesHeader."Ship-to Code")+';'+5
                            FORMAT(SalesHeader."Ship-to Name")+';'+6
                            FORMAT(SalesHeader."Ship-to Name 2")+';'+7
                            FORMAT(SalesHeader."Ship-to Address")+';'+8
                            FORMAT(SalesHeader."Ship-to Address 2")+';'+9
                            FORMAT(SalesHeader."Ship-to City")+';'+0
                            FORMAT(SalesHeader."Ship-to Post Code")+';'+1
                            FORMAT(SalesHeader."Ship-to County")+';'+2
                            FORMAT(SalesHeader."Ship-to Country/Region Code")+';'+3
                            FORMAT(SalesLine."No.")+';'+4
                            FORMAT(SalesLine.Quantity)+';'+5
                            FORMAT(SalesLine."Line Discount %")+';'+6
                            FORMAT(SalesLine."Unit Price");7
                            FORMAT(SalesHeader."Envio a-Nº Telefono")+';'+ 18
                        FORMAT(SalesHeader."E-MAIL")+';'+ 19
                        FORMAT(SalesHeader.Dropshipping); 20
                         

    */


    Caption = 'Importacion PEDIDOS WEB18';
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding =  UTF16;

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
                }
                textelement(D13)
                {
                }
                textelement(D14)
                {
                }
                textelement(D15)
                {
                }
                textelement(D16)
                {
                }
                textelement(D17)
                {
                }
                textelement(D18)
                {
                }
                textelement(D19)
                {
                }
                textelement(D20)
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

        /////-RecUser.Get(UserId);
        CompanyInformation.Get;
    end;

    var
        DataExchField: Record "Data Exch. Field";
        DataExchEntryNo: Integer;
        ImportedLineNo: Integer;
        FileLineNo: Integer;
        HeaderLines: Integer;
        HeaderLineCount: Integer;
        ColumnNo: Integer;
        HeaderTag: Text;
        FooterTag: Text;
        SkipLine: Boolean;
        LastLineIsFooter: Boolean;
        HeaderWarning: Boolean;
        LineType: Option Unknown,Header,Footer,Data;
        CurrentLineType: Option;
        FullHeaderLine: Text;
        LastLineIsHeaderErr: label 'The imported file contains unexpected formatting. One or more lines may be missing in the file.';
        WrongHeaderErr: label 'The imported file contains unexpected formatting. One or more headers are incorrect.';
        DataExchLineDefCode: Code[20];
        Contact: Record Contact;
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        CODPROD: Code[10];
        CODENVIO: Code[20];
        Item: Record Item;
        valorpbp: Decimal;

        CANTIDE: Decimal;
        conta: Integer;
        codconta: Code[10];
        XX: Integer;
        POSI: Integer;
        DDD: array[42] of Decimal;
        YY: Integer;
        LATARIFA: Code[10];
        LALAMA: Code[10];
        CUANTA1: Integer;
        ELANCHO: array[70] of Decimal;
        ELALTO: Decimal;
        LINEAS: Integer;
        UNO: Code[255];
        DOS: Code[255];
        UBICA: Code[20];
        POS: Decimal;
        LON: Decimal;
        SALE: Boolean;
        kilos: Code[20];
        fc: Code[10];
        frecp: Code[10];
        RecItem: Record Item;
        REFCONFOR: Code[20];
        LDP: Record "Item Journal Line";
        KILOSDECI: Decimal;
        SUMALINS: Decimal;
        MovProducto2: Record "Item Ledger Entry";
        RegInvFis: Record "Phys. Inventory Ledger Entry";
        NoMov: Decimal;
        Desdemov: Decimal;
        NoMov2IF: Decimal;
        NoMov2: Decimal;
        NoDoc: Code[10];
        RegMovProd: Record "Item Register";
        TIPO2: Integer;
        ImporteT: Decimal;
        Rec83: Record "Item Journal Line";
        lin: Decimal;
        RecSDP: Record "Item Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        DPRECIO: Decimal;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        RecItem2: Record Item;
        STOCCAL: Decimal;
        clie: Code[20];
        ref: Code[20];
        canti: Code[10];
        obser: Code[250];
        RecCV: Record "Sales Header";
        RecLV: Record "Sales Line";
        linea: Integer;
        FormClie: Page "Customer Card";
        RecCVC: Record "Sales & Receivables Setup";
        NoSerie: Code[10];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        codacti: Code[10];
        RecLNS: Record "No. Series Line";
        RecUser: Record "User Setup";
        RecClie: Record Customer;
        RecCV2: Record "Sales Header";
        SalesSetup: Record "Sales & Receivables Setup";
        Rec91: Record "User Setup";
        RecLCV: Record "Sales Comment Line";
        SUPRA: Code[20];
        RecProd: Record Item;
        RecRefCruz: Record "Item Reference";
        RecCus: Record Customer;
        UserSetup: Record "User Setup";
        /////- smtp: Codeunit UnknownCodeunit400;
        RelacionproductogrupoMetros: Record "Relacion producto-grupo Metros";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        RecCust: Record Customer;
        "----": Integer;
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
        VENTANA: Dialog;
        COD: Code[13];
        COD2: Code[14];
        AA: Integer;
        MM: Integer;
        DD: Integer;
        HH: Code[2];
        MI: Code[2];
        SE: Code[2];
        A111: Code[4];
        M111: Code[2];
        D111: Code[2];
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
        CODBAR: Code[10];
        LENCB: Integer;
        VENTANA2: Dialog;
        opcio: Integer;
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
        NPEDIDO: Code[20];
        CONTALIN: Integer;
        UBIPICDIN: Code[1];
        PICCOMPAR: Code[1];
        fragil: Text[30];
        OBS: Text[255];
        FRAG: array[20] of Integer;
        PORTES: Decimal;
        g: Code[20];
        g2: Code[20];
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
        pdte: Decimal;
        codtras: Code[20];
        NTEL: Code[9];
        NTEL2: Text[30];
        TextAmount: Text[35];
        REEMBOLSO: Code[11];
        DREEMBOLSO: Decimal;
        RespetaTrans: Boolean;
        TELEFONO: Text[30];
        contadord: Integer;
        ELTEXTO1: Text[149];
        CONTASMS: Integer;
        Fichero: File;
        nomfich: Text[200];
        nomfich1: Text[200];
        nomfich2: Text[200];
        nomfich3: Text[200];
        TBULTOS: Decimal;
        totalrecor: Decimal;
        fvto: Date;
        elpeso: Decimal;
        decre: Decimal;
        TOTALPALE: Integer;
        expedi: Code[10];
        CArea: Option Tapiceria,"Decoración";
        CMerca: Option Nacional,"Exportación";
        direccionda: Code[80];
        nombreda: Code[80];
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
        codcli: Code[10];
        t: array[99] of Text[255];
        ret: Integer;
        ExecName: Text[30];
        param: Text[30];
        x: Integer;
        VETANA: Dialog;
        NFACT: Code[20];
        NCLIE: Code[20];
        ESREEMBOLSO: Boolean;
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
        contaser: Code[20];
        NOMULTIPEDIDO: Boolean;
        "5DIGITOS": Code[5];
        LENEAN: Integer;
        UBIPIC: Code[16];
        UBIREF: Code[16];
        emailde: Text[100];
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
        ENVIAR: Boolean;
        AGRUPADO: Code[10];
        DESDEA: Date;
        totalbultos: Integer;
        albaranvalido: Boolean;
        NEXPEDICION: Text[30];
        codexpedico: Code[40];
        CODPAIES2: Code[1];
        tienerotura: Boolean;
        NEXPEDI: Code[20];
        Fechalimite: Date;
        totalImpPdte: Decimal;
        v: Dialog;
        ANYO: Integer;
        npedi: Code[20];
        RecClieTemp: Record Customer temporary;

    local procedure InitializeGlobals()
    var
        DataExchDef: Record "Data Exch. Def";
    begin
    end;

    local procedure CheckLineType()
    begin
        ValidateNonDataLine;
        TrackNonDataLines;
        SkipLine := CurrentLineType <> Linetype::Data;

        if not SkipLine then begin
            HeaderLineCount := 0;
            ImportedLineNo += 1;
        end;
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


         




        if codacti<>D1 then begin
            codacti:=D1;
            RecCV.Init;
            RecCV."Document Type" := 1;
            RecCV."No." := D1;
            RecCV.Validate(RecCV."Order Date", Today);
            RecCV.Validate(RecCV."Posting Date", Today);
            RecCV.Validate(RecCV."Shipment Date", Today);
            RecCV."Posting Description" := 'Pedido nº ' + d4;
            RecCV.Validate(RecCV."Sell-to Customer No.", d3);
            RecCV."Estado pedido" := 2;
            RecCV."Usuario alta" := UserId;
            RecCV."Fecha alta" := Today;
            RecCV."Hora alta" := Time;
            SalesSetup.Get;
            RecCV."No. Series" := SalesSetup."Order Nos.";
            RecCV."Posting No. Series" := SalesSetup."Posted Invoice Nos.";
            RecCV."Shipping No. Series" := SalesSetup."Posted Shipment Nos.";
            RecCV."Prepayment No. Series" := SalesSetup."Posted Prepmt. Inv. Nos.";
            RecCV."Prepmt. Cr. Memo No." := SalesSetup."Posted Prepmt. Cr. Memo Nos.";
            RecCV."Customer Price Group" := CompanyInformation."Tarifa WEB";
            RecCV."Your Reference" := D4;

            ///RecCV."Ship-to Code" := D5;
            RecCV."Ship-to Name" := CopyStr(D6,1,100);
            RecCV."Ship-to Name 2" := CopyStr(D7,1,100);
            RecCV."Ship-to Address" := CopyStr(D8,1,100);
            RecCV."Ship-to Address 2" := CopyStr(D9,1,100);
            RecCV."Ship-to City" := CopyStr(D10,1,30);
            RecCV."Ship-to Post Code" := CopyStr(D11,1,20);
            RecCV."Ship-to County" := CopyStr(D12,1,30);
            RecCV."Ship-to Country/Region Code" := CopyStr(D13,1,30);
            RecCV."Envio a-Nº Telefono":=D18;                 
            RecCV."E-MAIL":=D19;                 
            RecCV.Dropshipping:=FALSE;          
            if CopyStr(D20,1,1)='S' THEN begin                
                RecCV.Dropshipping:=TRUE;          
            END;       
                        



            RecCV.Insert(true);

        end;

        SALE := false;
        if D14 <> '' then begin
            if RecProd.Get(D14) then begin
                ///if RecProd."No permite pedido"=false then begin
                    LINEAS := LINEAS + 10000;
                    RecLV."Document Type" := 1;
                    RecLV."Document No." := D1;
                    RecLV."Line No." := LINEAS;
                    RecLV.Type := 2;
                    RecLV.Validate(RecLV."No.", D14);
                    Evaluate(CANTIDE, D15);
                    RecLV.Validate(RecLV.Quantity, CANTIDE);
                    RecLV.Insert(true);
                    Evaluate(DPRECIO, D17);                 
                    RecLV.Validate(RecLV."Unit Price", DPRECIO);
                    RecLV.Validate(RecLV.Quantity, CANTIDE);
                    Evaluate(DPRECIO, D16);
                    RecLV.Validate(RecLV."Line Discount %", DPRECIO);
                    RecLV.Modify(true);                
                ///end;
            end;
        end;

    end;

    local procedure Enviaemail()
    begin
    end;




    local procedure EXTENSION()
    begin
    end;
}

