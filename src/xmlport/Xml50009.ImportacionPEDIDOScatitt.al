#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50009 "Importacion PEDIDOS catitt"
{
    // C-CAT

    Caption = 'Importacion PEDIDOS catitt';
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

    trigger OnPostXmlPort()
    begin

        ///7 MESSAGE('SALE');


        if tienedto then begin
            cuantaslin := 0;
            RecLV.Reset;
            RecLV.SetRange(RecLV."Document Type", 1);
            RecLV.SetRange(RecLV."Document No.", codacti);
            if RecLV.FindFirst then
                repeat
                    if RecLV.Amount <> 0 then begin
                        if RecLV."No." <> 'TRAN' then begin
                            cuantaslin := cuantaslin + 1;
                        end;
                    end;
                until RecLV.Next = 0;
            dto := ROUND(impdto / cuantaslin, 0.01);
            Clear(descuentoaaplicar);
            if cuantaslin > 1 then begin
                y := 0;
                repeat
                    y := y + 1;
                    descuentoaaplicar[y] := dto;
                until y = cuantaslin - 1;
                ultimo := impdto - dto * (cuantaslin - 1);
                descuentoaaplicar[cuantaslin] := ultimo;
            end;
            if cuantaslin = 1 then begin
                descuentoaaplicar[cuantaslin] := dto;
            end;
            y := 0;
            RecLV.Reset;
            RecLV.SetRange(RecLV."Document Type", 1);
            RecLV.SetRange(RecLV."Document No.", codacti);
            if RecLV.FindFirst then
                repeat
                    if RecLV.Amount <> 0 then begin
                        if RecLV."No." <> 'TRAN' then begin
                            y := y + 1;
                            RecLV.Validate(RecLV."Line Discount Amount", descuentoaaplicar[y]);
                            RecLV.Modify;
                        end;
                    end;
                until RecLV.Next = 0;
        end;
    end;

    trigger OnPreXmlPort()
    begin

        /////-RecUser.Get(UserId);
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
        stock: Record "Cesta compra";
        CANTIDE: Decimal;
        conta: Integer;
        ventana: Dialog;
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
        RecAct: Record "Comisiones por grupo";
        RecAct2: Record "Comisiones por grupo";
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
        NPEDIDO: Code[20];
        X: Integer;
        FECHAENVIO: Date;
        DD: Integer;
        MM: Integer;
        AA: Integer;
        DDA: Code[10];
        MMA: Code[10];
        AAA: Code[10];
        RecEAD: Record "Ship-to Address";
        Customer: Record Customer;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        NUMCLIE: Code[10];
        NoSeriesManagement: Codeunit NoSeriesManagement;
        CODCLIE: Code[10];
        PPRECIO: Decimal;
        ShiptoAddress: Record "Ship-to Address";
        CODDIRENVIO: Code[10];
        /////- TempBlob: Record TempBlob temporary;
        CANTitrans: Decimal;
        impdto: Decimal;
        tienedto: Boolean;
        dto: Decimal;
        cuantaslin: Integer;
        "Area": Record "Area";
        SalesLineDiscount: Record "Sales Line Discount";
        descuentoaaplicar: array[99999] of Decimal;
        y: Integer;
        ultimo: Decimal;
        Customer2: Record Customer;
        "Productosaañaidrapedido": Record "Productos a añaidr a pedido";
        PostCode: Record "Post Code";

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





        linea := linea + 1;
        if linea > 1 then begin
            /////CODCLIE:='11010';
            if linea >= 2 then begin
                if NPEDIDO <> D1 then begin
                    /////RecCV.RESET;
                    /////RecCV.SETRANGE("Document Type",RecCV."Document Type"::Order);
                    /////RecCV.SETRANGE("Your Reference",D1);
                    /////IF NOT RecCV.FINDFIRST THEN BEGIN
                    if tienedto then begin
                        cuantaslin := 0;
                        RecLV.Reset;
                        RecLV.SetRange(RecLV."Document Type", 1);
                        RecLV.SetRange(RecLV."Document No.", codacti);
                        if RecLV.FindFirst then
                            repeat
                                if RecLV.Amount <> 0 then begin
                                    if RecLV."No." <> 'TRAN' then begin
                                        cuantaslin := cuantaslin + 1;
                                    end;
                                end;
                            until RecLV.Next = 0;
                        dto := ROUND(impdto / cuantaslin, 0.01);
                        Clear(descuentoaaplicar);
                        if cuantaslin > 1 then begin
                            y := 0;
                            repeat
                                y := y + 1;
                                descuentoaaplicar[y] := dto;
                            until y = cuantaslin - 1;
                            ultimo := impdto - dto * (cuantaslin - 1);
                            descuentoaaplicar[cuantaslin] := ultimo;
                        end;
                        if cuantaslin = 1 then begin
                            descuentoaaplicar[cuantaslin] := dto;
                        end;
                        y := 0;
                        RecLV.Reset;
                        RecLV.SetRange(RecLV."Document Type", 1);
                        RecLV.SetRange(RecLV."Document No.", codacti);
                        if RecLV.FindFirst then
                            repeat
                                if RecLV.Amount <> 0 then begin
                                    if RecLV."No." <> 'TRAN' then begin
                                        y := y + 1;
                                        RecLV.Validate(RecLV."Line Discount Amount", descuentoaaplicar[y]);
                                        RecLV.Modify;
                                    end;
                                end;
                            until RecLV.Next = 0;
                    end;
                    /*RecCV.RESET;
                    RecCV.SETRANGE("Document Type",1);
                    RecCV.SETRANGE("Sell-to Customer No.",CODCLIE);
                    RecCV.SETRANGE("Your Reference",D1);
                    IF RecCV.FINDFIRST THEN BEGIN
                         tienedto:=FALSE;
                         impdto:=0;
                         CLEAR(descuentoaaplicar);
                         LINEAS:=10000;
                         currXMLport.SKIP;
                    END;
                    IF NOT RecCV.FINDFIRST THEN BEGIN
                    */
                    AltaClientes;
                    SalesSetup.Get;
                    codacti := NoSeriesManagement.GetNextNo(SalesSetup."Order Nos.", Today, true);
                    NPEDIDO := D1;
                    RecCV.Init;
                    RecCV."Document Type" := 1;
                    RecCV."No." := codacti;
                    RecCV.Validate(RecCV."Order Date", Today);
                    RecCV.Validate(RecCV."Posting Date", Today);
                    RecCV.Validate(RecCV."Shipment Date", Today);
                    RecCV."Posting Description" := 'Pedido nº ' + codacti;
                    RecCV.Validate(RecCV."Sell-to Customer No.", CODCLIE);
                    RecCV."Estado pedido" := RecCV."estado pedido"::Retenido;
                    RecCV."Super urgente" := true;
                    RecCV."No incluir portes" := true;
                    RecCV."No agrupar en ADAIA" := false;
                    RecCV."Usuario alta" := UserId;
                    RecCV."Fecha alta" := Today;
                    RecCV."Hora alta" := Time;
                    RecCV."No. Series" := SalesSetup."Order Nos.";
                    RecCV."Posting No. Series" := SalesSetup."Posted Invoice Nos.";
                    RecCV."Shipping No. Series" := SalesSetup."Posted Shipment Nos.";
                    RecCV."Prepayment No. Series" := SalesSetup."Posted Prepmt. Inv. Nos.";
                    RecCV."Prepmt. Cr. Memo No." := SalesSetup."Posted Prepmt. Cr. Memo Nos.";
                    RecCV."Permite fraccionar uni. venta" := true;
                    RecCV.Validate("Your Reference",D1);
                    RecCV.Validate(RecCV."Ship-to Code", CODDIRENVIO);
                    RecCV."Shipment Date" := CalcDate('+2D', Today);
                    RecCV."Requested Delivery Date" := CalcDate('+2D', Today);
                    RecCV.Validate(RecCV.Dropshipping, true);
                    RecCV."Shipping Agent Code" := 'SENDING';
                    RecCV."Respeta agencia transporte" := true;
                    /////- TempBlob.WriteAsText(D2,Textencoding::Windows);
                    /////- RecCV."Work Description":=TempBlob.Blob;
                    if UpperCase(CopyStr(D14, 1, 2)) = 'BA' then begin
                        RecCV."Payment Method Code" := 'TRANSFWEB';
                    end;
                    if UpperCase(CopyStr(D14, 1, 2)) = 'RE' then begin
                        RecCV."Payment Method Code" := 'TPV';
                    end;
                    if UpperCase(CopyStr(D14, 1, 15)) = 'REDSYS_BIZUM_GW' then begin
                        RecCV."Payment Method Code" := 'BIZUM';
                    end;


                    /*
                    CALCFIELDS("Work Description");
                    IF NOT "Work Description".HASVALUE THEN
                    EXIT('');
                    CR[1] := 10;
                    TempBlob.Blob := "Work Description";
                    EXIT(TempBlob.ReadAsText(CR,TEXTENCODING::Windows));
                    */
                    RecCV."Ship-to Name" := CopyStr(D4 + ' ' + D5, 1, 50);
                    RecCV."Ship-to Name 2" := CopyStr(D6, 1, 50);
                    RecCV."Ship-to Address" := CopyStr(D7, 1, 50);
                    RecCV."Ship-to Address 2" := CopyStr(D7, 51, 50);
                    RecCV."Ship-to City" := CopyStr(D8, 1, 30);
                    RecCV."Ship-to Contact" := CopyStr(D4, 1, 30);
                    PostCode.Reset;
                    PostCode.SetRange(Code, D9);
                    if PostCode.FindFirst then begin
                        if Area.Get(PostCode."County Code") then begin
                            RecCV."Ship-to County" := Area.Text;
                        end;

                    end;

                    ///IF STRLEN(D9)=4 THEN BEGIN
                    ///D9:='0'+D9;
                    ////END;
                    RecCV."Ship-to Post Code" := D9;
                    ////IF Area.GET(COPYSTR(D9,1,2)) THEN BEGIN
                    ///RecCV."Ship-to County":=Area.Text;
                    ///END;

                    RecCV."Envio a-Nº Telefono" := D15;
                    RecCV."E-MAIL" := D3;
                    RecCV.Insert(true);
                    AltaRegalos;
                    tienedto := false;
                    impdto := 0;
                    Clear(descuentoaaplicar);
                    LINEAS := 10000;

                end;
                CODPROD := '';
                RecProd.Reset;
                RecProd.SetRange("Ref. Catit", D10);
                if RecProd.FindFirst then begin
                    CODPROD := RecProd."No.";
                end;
                if not RecProd.FindFirst then begin
                    if RecProd.Get(D10) then begin
                        CODPROD := RecProd."No.";
                    end;
                    if not RecProd.Get(D10) then begin
                        Error('La ref %1 no existe', D10);
                    end;
                end;
                if RecProd.Get(CODPROD) then begin
                    if RecProd."No permite pedido"=false then begin
                        LINEAS := LINEAS + 10000;
                        RecLV."Document Type" := 1;
                        RecLV."Document No." := codacti;
                        RecLV."Line No." := LINEAS;
                        RecLV.Type := 2;
                        RecLV.Validate(RecLV."No.", CODPROD);
                        ///// RecLV.INSERT(TRUE);
                        RecLV."Usuario alta" := UserId;
                        RecLV."Fecha alta" := Today;
                        RecLV."Hora alta" := Time;
                        RecLV."Shortcut Dimension 1 Code" := RecCV."Salesperson Code";
                        RecLV.Vendedor := RecCV."Salesperson Code";
                        RecLV.Insert;
                        Evaluate(CANTIDE, D11);
                        RecLV.Validate(RecLV.Quantity, CANTIDE);
                        if UpperCase(CopyStr(D16, 1, 1)) = 'Y' then begin
                            RecLV.Validate(RecLV."Line Discount %", 100);
                        end;    
                        RecLV."Customer Price Group" := '';
                        D17 := ConvertStr(D17, '.', ',');
                        Evaluate(CANTIDE, D17);
                        RecLV.Validate(RecLV."Unit Price", CANTIDE);
                        RecLV.Modify(true);
                    end;


                end;

                Evaluate(CANTitrans, D12);
                /////impdto:=0;
                /////tienedto:=FALSE;
                if D13 <> '' then begin
                    Evaluate(impdto, D13);
                    if impdto <> 0 then begin
                        tienedto := true;
                        impdto := ROUND(impdto / 100, 0.01);
                    end;
                end;


                if CANTitrans <> 0 then begin
                    RecLV."Document Type" := 1;
                    RecLV."Document No." := codacti;
                    RecLV."Line No." := 9999999;
                    RecLV.Type := 2;
                    RecLV.Validate(RecLV."No.", 'TRAN');
                    RecLV.Validate(RecLV.Quantity, 1);
                    RecLV.Validate(RecLV."Unit Price", CANTitrans / 100);
                    if UpperCase(CopyStr(D16, 1, 1)) = 'Y' then begin
                        RecLV.Validate(RecLV."Line Discount %", 100);
                    end;
                    if RecLV.Insert(true) then;
                end;
                /////END;
            end;
        end;

    end;

    local procedure AltaRegalos()
    begin

        lin := 0;
        Productosaañaidrapedido.Reset;
        if Productosaañaidrapedido.FindFirst then
            repeat
                if (Productosaañaidrapedido."Fecha inicio" <> 0D) and (Productosaañaidrapedido."Fecha fin" <> 0D) then begin
                    if (Productosaañaidrapedido."Fecha inicio" <= Today) and (Productosaañaidrapedido."Fecha fin" >= Today) then begin
                        lin := lin + 100;
                        RecLV.Init;
                        RecLV."Document Type" := 1;
                        RecLV."Document No." := codacti;
                        RecLV."Line No." := lin;
                        RecLV.Type := 2;
                        RecLV.Validate(RecLV."No.", Productosaañaidrapedido.Producto);
                        RecLV.Validate(RecLV.Quantity, Productosaañaidrapedido.Cantidad);
                        RecLV.Validate(RecLV."Line Discount %", 100);
                        RecLV.Insert(true);
                    end;
                end;
            until Productosaañaidrapedido.Next = 0;



        /*
        
            lin:=0;
            SalesLineDiscount.RESET;
            SalesLineDiscount.SETRANGE(SalesLineDiscount."Sales Code",CODCLIE);
            SalesLineDiscount.SETRANGE(SalesLineDiscount."Sales Type",SalesLineDiscount."Sales Type"::Regalo);
            IF SalesLineDiscount.FINDFIRST THEN REPEAT
                IF (SalesLineDiscount."Starting Date"<>0D) AND (SalesLineDiscount."Ending Date"<>0D) THEN BEGIN
                    IF (SalesLineDiscount."Starting Date"<=TODAY) AND (SalesLineDiscount."Ending Date">=TODAY) THEN BEGIN
                        lin:=lin+100;
                        RecLV.INIT;
                        RecLV."Document Type":=1;
                        RecLV."Document No.":=codacti;
                        RecLV."Line No.":=lin;
                        RecLV.Type:=2;
                        RecLV.VALIDATE(RecLV."No.",SalesLineDiscount.Code);
                        RecLV.VALIDATE(RecLV.Quantity,1);
                        RecLV.INSERT(TRUE);
                    END;
                END;
                IF (SalesLineDiscount."Starting Date"<>0D) AND (SalesLineDiscount."Ending Date"=0D) THEN BEGIN
                    IF (SalesLineDiscount."Starting Date"<=TODAY) THEN BEGIN
                        lin:=lin+100;
                        RecLV.INIT;
                        RecLV."Document Type":=1;
                        RecLV."Document No.":=codacti;
                        RecLV."Line No.":=lin;
                        RecLV.Type:=2;
                        RecLV.VALIDATE(RecLV."No.",SalesLineDiscount.Code);
                        RecLV.VALIDATE(RecLV.Quantity,1);
                        RecLV.INSERT(TRUE);
                    END;
                END;
                IF (SalesLineDiscount."Starting Date"=0D) AND (SalesLineDiscount."Ending Date"<>0D) THEN BEGIN
                    IF (SalesLineDiscount."Ending Date">=TODAY) THEN BEGIN
                        lin:=lin+100;
                        RecLV.INIT;
                        RecLV."Document Type":=1;
                        RecLV."Document No.":=codacti;
                        RecLV."Line No.":=lin;
                        RecLV.Type:=2;
                        RecLV.VALIDATE(RecLV."No.",SalesLineDiscount.Code);
                        RecLV.VALIDATE(RecLV.Quantity,1);
                        RecLV.INSERT(TRUE);
                    END;
                END;
            UNTIL SalesLineDiscount.NEXT=0;
            */

    end;

    local procedure AltaClientes()
    begin


        Customer.Reset;
        Customer.SetRange("E-Mail", D3);
        if Customer.FindFirst then begin
            CODCLIE := Customer."No.";
        end;
        if not Customer.FindFirst then begin
            CODCLIE := NoSeriesManagement.GetNextNo('C-CAT', Today, true);
            Customer.Init;
            Customer2.Get('11010');
            Customer := Customer2;
            Customer."No." := CODCLIE;
            Customer.Name := CopyStr(D4 + ' ' + D5, 1, 50);
            Customer."Name 2" := CopyStr(D6, 1, 50);
            Customer.Address := CopyStr(D7, 1, 50);
            Customer."Address 2" := CopyStr(D7, 51, 50);
            Customer.City := CopyStr(D8, 1, 30);
            Customer.Contact := CopyStr(D4, 1, 30);
            ////IF STRLEN(D9)=4 THEN BEGIN
            ///     D9:='0'+D9;
            ///    END;
            Customer."Post Code" := D9;
            ///IF Area.GET(COPYSTR(D9,1,2)) THEN BEGIN
            ///Customer.County:=Area.Text;
            ///END;
            PostCode.Reset;
            PostCode.SetRange(Code, D9);
            if PostCode.FindFirst then begin
                if Area.Get(PostCode."County Code") then begin
                    Customer.County := Area.Text;
                end;

            end;

            Customer."Phone No." := D15;
            Customer."E-Mail" := D3;
            Customer."Grupo clientes" := 'G52';
            Customer."Customer Price Group" := 'CATIT';
            Customer."Bill-to Customer No." := '11010';
            Customer."Enviar a Web" := false;
            Customer."Enviar pdfs a WEB" := false;
            Customer.Insert(true);
        end;
    end;
}

