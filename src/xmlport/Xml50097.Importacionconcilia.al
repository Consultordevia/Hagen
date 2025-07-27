#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50097 "Importacionconcilia"
{

    // 113058227510210045212505012506091000000347664609783ROLF C HAGEN ESPAÑA S A      
    // 22    9999250501250501121511000000016984940000000000            22750801389     
    // 2301TARJETA                               ENT:          -    REF:22750801389  86
    // 22    9999250505250505041882000000000220170000000000                            
    // 2301CANISLINK UNIPESSOAL, LDA                                                   
    // 2302NOTPROVIDED                                                                 
    // 2303        pedido canislink portugal                                           
    // 2305         Hagen          12345678901234                                                    
    // 22    9999250505250505036911000000000465370000000000                                    
    // 123456789012345678901234567890123456789012345678901234567890
    //          10        20        30        40       50
    // 1234567890
    // 2301COREMAPFRE VIDA S.A.(NIF A28229599)                                         
    // 2302ES92000A28229599                   000003470656                             
    // 2303        RECIBO:45135009 POLIZA:3470656 DEL 02.05.2025 AL 02.06.2025 COVERVID
    // 2304A TEF:962459667                                                             
    // 230502052500451350090000000000000000000JESUS ALEXIS MARTIN GONZALEZ             
    // 22    9999250505250505041882000000000465920000000000                            
    // 2301BARTOMEU VICENS RAMIS                                                       
    // 2302NOTPROVIDED                                                                 
    // 2303        Tolo rulos mascotas                                                 
    // 2305         hagen                                                              
    // 22    9999250507250507036911000000000546160000000000                            
    // 2301CORENORHGATE ESPANA RENTING FLEXIBLE                                        
    // 2302ES21000A28659423                   A9739743415112022075422752               
    // 2303        SCOR                                   ISO                          
    // 2304      DOC:A2526001962                                                       
    // 2305AENVC002248196-03CLI7795947        ROLF C.HAGEN ESPANA S.A.  

    Caption = 'Importacion Concilia';
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF16;
    Permissions = TableData "Sales Shipment Header" = rim;

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



        SalesSetup.Get;
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
        SalesShipmentHeader: Record "Sales Shipment Header";
        CODPROD: Code[20];
        CODENVIO: Code[20];
        valorpbp: Decimal;
        CANTIDE: Decimal;
        conta: Integer;
        ventana: Dialog;
        codconta: Code[20];
        XX: Integer;
        POSI: Integer;
        DDD: array[42] of Decimal;
        YY: Integer;
        LATARIFA: Code[20];
        LALAMA: Code[20];
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
        fc: Code[20];
        frecp: Code[20];
        REFCONFOR: Code[20];
        KILOSDECI: Decimal;
        SUMALINS: Decimal;
        NoMov: Decimal;
        Desdemov: Decimal;
        NoMov2IF: Decimal;
        NoMov2: Decimal;
        NoDoc: Code[20];
        TIPO2: Integer;
        ImporteT: Decimal;
        lin: Decimal;
        DPRECIO: Decimal;
        STOCCAL: Decimal;
        clie: Code[20];
        ref: Code[20];
        canti: Code[20];
        obser: Code[250];
        linea: Integer;
        NoSerie: Code[20];
        codacti: Code[20];
        SalesSetup: Record "Sales & Receivables Setup";
        SUPRA: Code[20];
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
        codcli: Code[20];
        codcliente: Code[20];
        codpedido: Code[20];
        CANTitrans: Decimal;
        CODDIRENVIO: Code[20];
        ALTA: Boolean;
        totalhoras: Decimal;
        fecha1: Date;
        fecha2: Date;
        x: Integer;
        DDA: Code[20];
        MMA: Code[20];
        AAA: Code[20];
        DD: Decimal;
        AA: Decimal;
        MM: Decimal;
        Date: Record Date;
        CUANTOSDIAS: Integer;
        dhoras: Decimal;
        horas: Code[20];
        dminu: Decimal;
        minu: Code[20];
        DDF: Code[20];
        DDH: Code[20];
        choras: Code[20];
        CASCII: Codeunit "ANSI <-> ASCII converter2";
        SIGNO: Code[1];
        CIMPORTE: CODE[14];
        IMPORTE: Decimal;
        NDOC: Code[20];
        RecConci: Record "Bank Acc. Reconciliation Line";
        des1: Text;
        des2: Text;
        des3: Text;


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


        if CopyStr(D1, 1, 2) = '22' THEN begin
            fecha2 := 0D;
            if D1 <> '' then begin
                DDA := CopyStr(D1, 12, 2);
                MMA := CopyStr(D1, 10, 2);
                AAA := CopyStr(D1, 14, 2);
                message('%1 - %2 %3 %4', d1, dda, mma, aaa);
                Evaluate(DD, DDA);
                Evaluate(MM, MMA);
                Evaluate(AA, AAA);
                fecha2 := Dmy2date(DD, MM, AA + 2000);
            end;


            SIGNO := CopyStr(D1, 25, 1);
            CIMPORTE := CopyStr(D1, 26, 14);
            Evaluate(Importe, CIMPORTE);
            importe := importe / 100;
            if signo = '1' then begin
                importe := importe * -1;
            end;
            NoDoc := CopyStr(D1, 42, 10);


            RecConci.Init();
            RecConci."Bank Account No." := '0049-CTO3';
            RecConci."Statement Type" := RecConci."Statement Type"::"Bank Reconciliation";
            RecConci."Statement No." := '1';
            conta := conta + 1;
            RecConci."Statement Line No." := conta;
            RecConci."Statement Amount" := IMPORTE;
            RecConci."Transaction Date" := fecha2;
            RecConci."Value Date" := fecha2;
            RecConci.Description := ndoc;
            RecConci.Insert();
        end;
        if CopyStr(D1, 1, 4) = '2301' THEN begin
            des1 := CopyStr(d1, 5, 100);
            RecConci.get(RecConci."Statement Type"::"Bank Reconciliation", '0049-CTO3', '1', conta);
            RecConci.Description := CopyStr(ndoc + des1, 1, 100);
            RecConci.Modify();
        end;
        if CopyStr(D1, 1, 4) = '2302' THEN begin
            des2 := CopyStr(d1, 5, 100);
            RecConci.get(RecConci."Statement Type"::"Bank Reconciliation", '0049-CTO3', '1', conta);
            RecConci."Related-Party Name" := des2;
            RecConci.Modify();
        end;
        if CopyStr(D1, 1, 4) = '2303' THEN begin
            des3 := CopyStr(d1, 5, 100);
            RecConci.get(RecConci."Statement Type"::"Bank Reconciliation", '0049-CTO3', '1', conta);
            RecConci."Additional Transaction Info" := des3;
            RecConci.Modify();
        end;





    end;
}

