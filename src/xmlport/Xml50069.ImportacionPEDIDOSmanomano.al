#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50069 "Importacion PEDIDOS mano mano"
{
    // 
    // [14:52, 5/8/2023] Hagen Oscar: Q= nombre del codigo descuento "alfanumérico"
    // [14:52, 5/8/2023] Hagen Oscar: R= Importe en euros iva inc del descuento
    // [14:52, 5/8/2023] Hagen Oscar: S=Importe en euros iva inc transporte
    // [14:53, 5/8/2023] Hagen Oscar: T=Agencia transporte

    Caption = 'Importacion PEDIDOS mano mano';
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

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
                }
                textelement(D21)
                {
                }
                textelement(D22)
                {
                }
                textelement(D23)
                {
                }
                textelement(D24)
                {
                }
                textelement(D25)
                {
                }
                textelement(D26)
                {
                }
                textelement(D27)
                {
                }
                textelement(D28)
                {
                }
                textelement(D29)
                {
                }
                textelement(D30)
                {
                }
                textelement(D31)
                {
                }
                textelement(D32)
                {
                }
                textelement(D33)
                {
                }
                textelement(D34)
                {
                }
                textelement(D35)
                {
                }
                textelement(D36)
                {
                }
                textelement(D37)
                {
                }
                textelement(D38)
                {
                }
                textelement(D39)
                {
                }
                textelement(D40)
                {
                }
                textelement(D41)
                {
                }
                textelement(D42)
                {
                }
                textelement(D43)
                {
                }
                textelement(D44)
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
        lin2: Integer;
        PaymentMethod: Record "Payment Method";
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentServices: Record "Shipping Agent Services";
    /////- ANSIASCIIconverter2: Codeunit UnknownCodeunit50011;

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

            if NPEDIDO <> D2 then begin
                NPEDIDO := D2;

                SalesSetup.Get;
                codacti := NoSeriesManagement.GetNextNo('V-PED-MM', Today, true);
                Message('%1', codacti);
                RecCV.Init;
                RecCV."Document Type" := 1;
                RecCV."No." := codacti;
                RecCV.Validate(RecCV."Order Date", Today);
                RecCV.Validate(RecCV."Posting Date", Today);
                RecCV.Validate(RecCV."Shipment Date", Today);
                RecCV."Posting Description" := 'Pedido nº ' + codacti;

                RecCV.Validate(RecCV."Sell-to Customer No.", 'NAV0127');

                ///IF COPYSTR(D16,1,1)<>'N' THEN BEGIN
                ///    AltaClientes;
                ///RecCV.VALIDATE(RecCV."Sell-to Customer No.",CODCLIE);
                ///END;

                RecCV."Estado pedido" := RecCV."estado pedido"::Retenido;
                RecCV."Super urgente" := true;
                RecCV."No incluir portes" := true;
                RecCV."No agrupar en ADAIA" := false;
                /////RecCV."Usuario alta" := UserId;
                RecCV."Fecha alta" := Today;
                RecCV."Hora alta" := Time;
                RecCV."No. Series" := SalesSetup."Order Nos.";
                RecCV."Posting No. Series" := SalesSetup."Posted Invoice Nos.";
                RecCV."Shipping No. Series" := SalesSetup."Posted Shipment Nos.";
                RecCV."Prepayment No. Series" := SalesSetup."Posted Prepmt. Inv. Nos.";
                RecCV."Prepmt. Cr. Memo No." := SalesSetup."Posted Prepmt. Cr. Memo Nos.";
                RecCV."Permite fraccionar uni. venta" := true;
                RecCV."Your Reference" := D2;
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


                RecCV."Ship-to Name" := CopyStr(D5 + ' ' + D6, 1, 50);
                RecCV."Ship-to Name 2" := CopyStr(D5 + ' ' + D6, 1, 50);
                RecCV."Ship-to Address" := CopyStr(D7 + ' ' + D8, 1, 50);
                RecCV."Ship-to Address 2" := CopyStr(D7 + ' ' + D8, 51, 50);
                RecCV."Ship-to City" := CopyStr(D11, 1, 30);
                RecCV."Ship-to Contact" := CopyStr(D5 + ' ' + D6, 1, 30);




                PostCode.Reset;
                PostCode.SetRange(Code, D10);
                if PostCode.FindFirst then
                    repeat
                        if Area.Get(PostCode."County Code") then begin
                            RecCV."Ship-to County" := Area.Text;
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





                RecCV."Envio a-Nº Telefono" := D14;
                RecCV."E-MAIL" := D3;
                RecCV."E-MAIL" := 'ventas@hagen.es';
                RecCV."Shipping Agent Code" := D15;

                /*PaymentMethod.RESET;
                PaymentMethod.SETRANGE(Shopyfi,D15);
                IF PaymentMethod.FINDFIRST THEN BEGIN
                      RecCV.VALIDATE("Payment Method Code",PaymentMethod.Code);
                      IF PaymentMethod.Code='TRANSFWEB' THEN BEGIN
                          RecCV."Estado pedido":=RecCV."Estado pedido"::Retenido;
                      END;
                END;
                */
                /*
                ShippingAgent.RESET;
                ShippingAgent.SETRANGE(Shopyfi,TRUE);
                IF ShippingAgent.FINDFIRST THEN BEGIN
                    RecCV.VALIDATE("Shipping Agent Code",ShippingAgent.Code);
                END;
                ShippingAgentServices.RESET;
                ShippingAgentServices.SETRANGE(Shopyfi,D16);
                IF ShippingAgentServices.FINDFIRST THEN BEGIN
                    RecCV.VALIDATE("Shipping Agent Code",ShippingAgentServices."Shipping Agent Code");
                    RecCV.VALIDATE("Shipping Agent Service Code",ShippingAgentServices.Code);
                END;
                */
                RecCV.Insert(true);
                ///    MESSAGE('%1',RecCV."No.");
                ///    AltaRegalos;
                tienedto := false;
                impdto := 0;
                Clear(descuentoaaplicar);
                LINEAS := 10000;



                D40 := ConvertStr(D40, '.', ',');
                Evaluate(CANTitrans, D40);
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
            RecProd.Reset;
            RecProd.SetRange("No.", D36);
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




            if RecProd.Get(CODPROD) then begin
                LINEAS := LINEAS + 10000;
                RecLV."Document Type" := 1;
                RecLV."Document No." := codacti;
                RecLV."Line No." := LINEAS;
                RecLV.Type := 2;
                RecLV.Validate(RecLV."No.", CODPROD);
                ///// RecLV.INSERT(TRUE);
                /////RecLV."Usuario alta" := UserId;
                RecLV."Fecha alta" := Today;
                RecLV."Hora alta" := Time;
                RecLV."Shortcut Dimension 1 Code" := RecCV."Salesperson Code";
                RecLV.Vendedor := RecCV."Salesperson Code";
                RecLV.Insert;
                D37 := ConvertStr(D37, '.', ',');
                Evaluate(CANTIDE, D37);
                RecLV.Validate(RecLV.Quantity, CANTIDE);
                RecLV."Customer Price Group" := '';
                D40 := ConvertStr(D40, '.', ',');
                Evaluate(CANTIDE, D40);
                CANTIDE := CANTIDE / (1 + (RecLV."VAT %") / 100);
                RecLV.Validate(RecLV."Unit Price", CANTIDE);
                ///D6:=CONVERTSTR(D6,'.',',');
                //////EVALUATE(CANTIDE,D6);
                /////7CANTIDE:=CANTIDE/(1+(RecLV."VAT %")/100);
                ///RecLV.VALIDATE(RecLV."Line Discount Amount",CANTIDE);
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
            Customer2.Get('NAV0127');
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

            Customer."Phone No." := D14;
            Customer."E-Mail" := D3;
            Customer."Grupo clientes" := 'G75';
            Customer."Customer Disc. Group" := 'CARR';
            Customer."Bill-to Customer No." := 'NAV0127';
            Customer."Enviar a Web" := false;
            Customer."Enviar pdfs a WEB" := false;
            Customer.Insert(true);
        end;
    end;
}

