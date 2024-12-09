#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50055 "Importacion PEDIDOS catitt new"
{
    // 
    // 
    // [14:52, 5/8/2023] Hagen Oscar: Q= nombre del codigo descuento "alfanumérico"
    // [14:52, 5/8/2023] Hagen Oscar: R= Importe en euros iva inc del descuento
    // [14:52, 5/8/2023] Hagen Oscar: S=Importe en euros iva inc transporte
    // [14:53, 5/8/2023] Hagen Oscar: T=Agencia transporte


    

    Caption = 'Importacion PEDIDOS catitt new';
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF16;

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

        ////RecUser.Get(UserId);
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
        ventana: Dialog;
        codconta: Code[10];
        XX: Integer;
        POSI: Integer;
        DDD: array[42] of Decimal;
        Productosaañaidrapedido: Record "Productos a añaidr a pedido";
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
        PostCode: Record "Post Code";
        lin2: Integer;
        PaymentMethod: Record "Payment Method";
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentServices: Record "Shipping Agent Services";
        /////- ANSIASCIIconverter2: Codeunit UnknownCodeunit50011;
        OutS: OutStream;
        XXX: Integer;
        YYY: Integer;
        COD: Code[20];
        DTOC: array[99] of Code[20];
        DTOD: array[99] of Decimal;
        SalesPrice: Record "Sales Price";
        univenta: Code[10];

    local procedure InitializeGlobals()
    var
        DataExchDef: Record "Data Exch. Def";
    begin
    end;

    local procedure CheckLineType()
    begin
        ///ValidateNonDataLine;
        ///TrackNonDataLines;
        ///SkipLine := CurrentLineType <> LineType::Data;

        ///IF NOT SkipLine THEN BEGIN
        ///HeaderLineCount := 0;
        ///ImportedLineNo += 1;
        ///END;
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


        lin2 := lin2 + 1;
        if lin2 > 1 then begin

            if NPEDIDO <> D1 then begin
                NPEDIDO := D1;
                AltaClientes;
                SalesSetup.Get;
                codacti := NoSeriesManagement.GetNextNo('CATWEB', Today, true);
                RecCV.Init;
                RecCV."Document Type" := 1;
                RecCV."No." := codacti;
                RecCV.Validate(RecCV."Order Date", Today);
                RecCV.Validate(RecCV."Posting Date", Today);
                RecCV.Validate(RecCV."Shipment Date", Today);
                RecCV."Posting Description" := 'Pedido nº ' + codacti;
                RecCV.Validate(RecCV."Sell-to Customer No.", CODCLIE);
                RecCV."Estado pedido" := RecCV."estado pedido"::"Para preparar";
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
                RecCV.Validate("Your Reference", D1);
                RecCV.Validate(RecCV."Ship-to Code", CODDIRENVIO);
                RecCV."Shipment Date" := CalcDate('+2D', Today);
                RecCV."Requested Delivery Date" := CalcDate('+2D', Today);
                RecCV.Validate(RecCV.Dropshipping, true);
                RecCV."Respeta agencia transporte" := true;
                RecCV.Dropshipping := true;
                ///TempBlob.WriteAsText(D2,TEXTENCODING::Windows);
                ///RecCV."Work Description":=TempBlob.Blob;
                //IF UPPERCASE(COPYSTR(D14,1,2))='BA' THEN BEGIN
                //      RecCV."Payment Method Code":='TRANSFWEB';
                //END;
                //IF UPPERCASE(COPYSTR(D14,1,2))='RE' THEN BEGIN
                //      RecCV."Payment Method Code":='TPV';
                //END;
                //IF// UPPERCASE(COPYSTR(D14,1,15))='REDSYS_BIZUM_GW' THEN BEGIN
                //   RecCV."Payment Method Code":='BIZUM';
                //END;


                RecCV."Ship-to Name" := CopyStr(D4, 1, 50);
                RecCV."Ship-to Name 2" := CopyStr(D4, 1, 50);
                RecCV."Ship-to Address" := CopyStr(D8, 1, 50);
                RecCV."Ship-to Address 2" := CopyStr(D8, 51, 50);
                RecCV."Ship-to City" := CopyStr(D9, 1, 30);
                RecCV."Ship-to Contact" := CopyStr(D4, 1, 30);



                PostCode.Reset;
                PostCode.SetRange(Code, D10);
                if PostCode.FindFirst then
                    repeat
                        PostCode.CalcFields("Provincia shopyfi CALC");
                        if PostCode."Provincia shopyfi CALC" = D17 then begin
                            if Area.Get(PostCode."County Code") then begin
                                RecCV."Ship-to County" := Area.Text;
                                RecCV."Ship-to Country/Region Code" := Area."Pais shopyfi";
                                RecCV."VAT Country/Region Code" := Area."Pais shopyfi";
                                RecCV."Provincia shopyfi" := PostCode."Provincia shopyfi CALC";
                                RecCV."Ship-to City" := CopyStr(D9, 1, 30);
                            end;
                        end;
                    until PostCode.Next = 0;
                RecCV.Validate(RecCV."Ship-to Post Code", D10);
                /*    IF RecCV."Bill-to County"<>PostCode."Provincia shopyfi CALC" THEN BEGIN
                        RecCV."Bill-to County":=D17;
                    END;
                    IF RecCV."Sell-to County"<>PostCode."Provincia shopyfi CALC" THEN BEGIN
                        RecCV."Sell-to County":=D17;
                    END;
                    IF RecCV."Ship-to County"<>PostCode."Provincia shopyfi CALC" THEN BEGIN
                        RecCV."Ship-to County":=D17;
                    END;
                    */

                if RecCV."Bill-to County" <> PostCode."Provincia shopyfi CALC" then begin
                    Area.Reset;
                    Area.SetRange(Area."Provincia shopyfi", D17);
                    if Area.FindFirst then begin
                        RecCV."Bill-to County" := Area.Text;
                        RecCV."Bill-to Country/Region Code" := Area."Pais shopyfi";
                        RecCV."VAT Country/Region Code" := Area."Pais shopyfi";
                        RecCV."Bill-to City" := CopyStr(D9, 1, 30);
                    end;
                end;
                if RecCV."Sell-to County" <> PostCode."Provincia shopyfi CALC" then begin
                    Area.Reset;
                    Area.SetRange(Area."Provincia shopyfi", D17);
                    if Area.FindFirst then begin
                        RecCV."Sell-to County" := Area.Text;
                        RecCV."Sell-to Country/Region Code" := Area."Pais shopyfi";
                        RecCV."VAT Country/Region Code" := Area."Pais shopyfi";
                        RecCV."Sell-to City" := CopyStr(D9, 1, 30);
                    end;
                end;
                if RecCV."Ship-to County" <> PostCode."Provincia shopyfi CALC" then begin
                    Area.Reset;
                    Area.SetRange(Area."Provincia shopyfi", D17);
                    if Area.FindFirst then begin
                        RecCV."Ship-to County" := Area.Text;
                        RecCV."Ship-to Country/Region Code" := Area."Pais shopyfi";
                        RecCV."VAT Country/Region Code" := Area."Pais shopyfi";
                        RecCV."Ship-to City" := CopyStr(D9, 1, 30);
                    end;
                end;



                if D18 <> '' then begin
                    RecCV."Work Description".CreateOutstream(OutS);
                    OutS.WriteText(D18);
                end;




                RecCV."Envio a-Nº Telefono" := D11;
                RecCV."E-MAIL" := D3;
                RecCV."Shipping Agent Code" := 'PRO';
                PaymentMethod.Reset;
                PaymentMethod.SetRange(Shopyfi, D15);
                if PaymentMethod.FindFirst then begin
                    RecCV.Validate("Payment Method Code", PaymentMethod.Code);
                    if PaymentMethod.Code = 'TRANSFWEB' then begin
                        RecCV."Estado pedido" := RecCV."estado pedido"::Retenido;
                    end;
                end;
                /*
                ShippingAgent.RESET;
                ShippingAgent.SETRANGE(Shopyfi,TRUE);
                IF ShippingAgent.FINDFIRST THEN BEGIN
                    RecCV.VALIDATE("Shipping Agent Code",ShippingAgent.Code);
                END;
                */
                ShippingAgentServices.Reset;
                ShippingAgentServices.SetRange(Shopyfi, D16);
                if ShippingAgentServices.FindFirst then begin
                    RecCV.Validate("Shipping Agent Code", ShippingAgentServices."Shipping Agent Code");
                    RecCV.Validate("Shipping Agent Service Code", ShippingAgentServices.Code);
                end;

                RecCV.Insert(true);
                ///    MESSAGE('%1',RecCV."No.");
                AltaRegalos;
                tienedto := false;
                impdto := 0;
                Clear(descuentoaaplicar);
                LINEAS := 10000;



                //
                XXX := 0;
                repeat
                    XXX := XXX + 1;
                    DTOC[XXX] := '';
                until XXX = 99;

                COD := D14;
                YYY := 1;
                XXX := 0;
                Clear(DTOC);
                repeat
                    XXX := XXX + 1;
                    if CopyStr(COD, XXX, 1) <> ',' then begin
                        DTOC[YYY] := DTOC[YYY] + Format(CopyStr(COD, XXX, 1));
                    end;
                    if CopyStr(COD, XXX, 1) = ',' then begin
                        YYY := YYY + 1;
                    end;

                until XXX > StrLen(COD);

                XXX := 0;
                repeat
                    XXX := XXX + 1;
                    if DTOC[XXX] <> '' then begin
                        Evaluate(DTOD[XXX], DTOC[XXX]);
                    end;
                until XXX = 99;

                CANTitrans := DTOD[1] + DTOD[2] + DTOD[3] + DTOD[4] + DTOD[5] + DTOD[6] + DTOD[7] + DTOD[8] + DTOD[9] + DTOD[10] +
                            DTOD[11] + DTOD[12] + DTOD[13] + DTOD[14] + DTOD[15] + DTOD[16] + DTOD[17] + DTOD[18] + DTOD[19] + DTOD[20] +
                            DTOD[21] + DTOD[22] + DTOD[23] + DTOD[24] + DTOD[25] + DTOD[26] + DTOD[27] + DTOD[28] + DTOD[29] + DTOD[30] +
                            DTOD[31] + DTOD[32] + DTOD[33] + DTOD[34] + DTOD[35] + DTOD[36] + DTOD[37] + DTOD[38] + DTOD[39] + DTOD[40] +
                            DTOD[41] + DTOD[42] + DTOD[43] + DTOD[44] + DTOD[45] + DTOD[46] + DTOD[47] + DTOD[48] + DTOD[49] + DTOD[50] +
                            DTOD[51] + DTOD[52] + DTOD[53] + DTOD[54] + DTOD[55] + DTOD[56] + DTOD[57] + DTOD[58] + DTOD[59] + DTOD[60] +
                            DTOD[61] + DTOD[62] + DTOD[63] + DTOD[64] + DTOD[65] + DTOD[66] + DTOD[67] + DTOD[68] + DTOD[69] + DTOD[70] +
                            DTOD[71] + DTOD[72] + DTOD[73] + DTOD[74] + DTOD[75] + DTOD[76] + DTOD[77] + DTOD[78] + DTOD[79] + DTOD[80] +
                            DTOD[81] + DTOD[82] + DTOD[83] + DTOD[84] + DTOD[85] + DTOD[86] + DTOD[87] + DTOD[88] + DTOD[89] + DTOD[90] +
                            DTOD[91] + DTOD[92] + DTOD[93] + DTOD[94] + DTOD[95] + DTOD[96] + DTOD[97] + DTOD[98] + DTOD[99];


                ///           D14:=CONVERTSTR(D14,'.',',');
                ///           EVALUATE(CANTitrans,D14);
                CANTitrans := CANTitrans / 100;
                if CANTitrans <> 0 then begin
                    RecLV."Document Type" := 1;
                    RecLV."Document No." := codacti;
                    LINEAS := LINEAS + 10000;
                    RecLV."Line No." := LINEAS;
                    RecLV.Type := 2;
                    RecLV.Validate(RecLV."No.", 'TRAN');
                    RecLV."Customer Price Group" := '';
                    RecLV.Validate(RecLV.Quantity, 1);
                    CANTitrans := CANTitrans / (1 + (RecLV."VAT %") / 100);
                    CANTitrans := ROUND(CANTitrans, 0.01);
                    RecLV.Validate("Unit Price", CANTitrans);
                    RecLV.Insert(true);
                end;


            end;

            CODPROD := '';
            univenta := 'UDS';
            SalesPrice.Reset;
            SalesPrice.SetRange("Codigo concatenado", D7);
            if SalesPrice.FindFirst then begin
                CODPROD := SalesPrice."Item No.";
                univenta := SalesPrice."Unit of Measure Code";
            end;
            if CODPROD = '' then begin
                RecProd.Reset;
                RecProd.SetRange("Ref. Catit", D7);
                if RecProd.FindFirst then begin
                    CODPROD := RecProd."No.";
                end;
                if not RecProd.FindFirst then begin
                    if RecProd.Get(D7) then begin
                        CODPROD := RecProd."No.";
                    end;
                    if not RecProd.Get(D7) then begin
                        Error('La ref %1 no existe', D7);
                    end;
                end;
            end;




            if RecProd.Get(CODPROD) then begin
                LINEAS := LINEAS + 10000;
                RecLV."Document Type" := 1;
                RecLV."Document No." := codacti;
                RecLV."Line No." := LINEAS;
                RecLV.Type := 2;
                RecLV.Validate(RecLV."No.", CODPROD);
                ///// RecLV.INSERT(TRUE);
                RecLV.Validate(RecLV."Unit of Measure Code", univenta);
                RecLV."Usuario alta" := UserId;
                RecLV."Fecha alta" := Today;
                RecLV."Hora alta" := Time;
                RecLV."Shortcut Dimension 1 Code" := RecCV."Salesperson Code";
                RecLV.Vendedor := RecCV."Salesperson Code";
                RecLV.Insert;
                D13 := ConvertStr(D13, '.', ',');
                Evaluate(CANTIDE, D13);
                RecLV.Validate(RecLV.Quantity, CANTIDE);
                RecLV."Customer Price Group" := '';
                D5 := ConvertStr(D5, '.', ',');
                Evaluate(CANTIDE, D5);
                CANTIDE := CANTIDE / (1 + (RecLV."VAT %") / 100);
                RecLV.Validate(RecLV."Unit Price", CANTIDE);
                D6 := ConvertStr(D6, '.', ',');
                Evaluate(CANTIDE, D6);
                CANTIDE := CANTIDE / (1 + (RecLV."VAT %") / 100);
                RecLV.Validate(RecLV."Line Discount Amount", CANTIDE);
                RecLV.Modify(true);
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
            Customer.Name := CopyStr(D4, 1, 50);
            Customer."Name 2" := CopyStr(D4, 1, 50);
            Customer.Address := CopyStr(D8, 1, 50);
            Customer."Address 2" := CopyStr(D8, 51, 50);
            Customer.City := CopyStr(D9, 1, 30);
            Customer.Contact := CopyStr(D4, 1, 30);
            ////IF STRLEN(D9)=4 THEN BEGIN
            ///     D9:='0'+D9;
            ///    END;
            Customer."Post Code" := D10;
            ///IF Area.GET(COPYSTR(D9,1,2)) THEN BEGIN
            ///Customer.County:=Area.Text;
            ///END;
            PostCode.Reset;
            PostCode.SetRange(Code, D10);
            if PostCode.FindFirst then begin
                if Area.Get(PostCode."County Code") then begin
                    Customer.County := Area.Text;
                end;

            end;

            Customer."Phone No." := D11;
            Customer."E-Mail" := D3;
            Customer."Grupo clientes" := 'G52';
            Customer."Customer Price Group" := 'CATIT';
            Customer."Bill-to Customer No." := '11010';
            Customer."Enviar a Web" := false;
            Customer."Enviar pdfs a WEB" := false;
            Customer."Servicio email" := false;
            Customer.Insert(true);
        end;
    end;
}

