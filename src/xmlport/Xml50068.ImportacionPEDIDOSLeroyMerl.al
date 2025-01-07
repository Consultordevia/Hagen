#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50068 "Importacion PEDIDOS Leroy Merl"
{
    Caption = 'Importacion PEDIDOS Leroy Merl';
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
                textelement(D142)
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
                }
                textelement(D45)
                {
                }
                textelement(D46)
                {
                }
                textelement(D47)
                {
                }
                textelement(D48)
                {
                }
                textelement(D49)
                {
                }
                textelement(D50)
                {
                }
                textelement(D51)
                {
                }
                textelement(D52)
                {
                }
                textelement(D53)
                {
                }
                textelement(D54)
                {
                }
                textelement(D55)
                {
                }
                textelement(D56)
                {
                }
                textelement(D57)
                {
                }
                textelement(D58)
                {
                }
                textelement(D59)
                {
                }
                textelement(D60)
                {
                }
                textelement(D61)
                {
                }
                textelement(D62)
                {
                }
                textelement(D63)
                {
                }
                textelement(D64)
                {
                }
                textelement(D65)
                {
                }
                textelement(D66)
                {
                }
                textelement(D67)
                {
                }
                textelement(D68)
                {
                }
                textelement(D69)
                {
                }
                textelement(D70)
                {
                }
                textelement(D71)
                {
                }
                textelement(D72)
                {
                }
                textelement(D73)
                {
                }
                textelement(D74)
                {
                }
                textelement(D75)
                {
                }
                textelement(D76)
                {
                }
                textelement(D77)
                {
                }
                textelement(D78)
                {
                }
                textelement(D79)
                {
                }
                textelement(D80)
                {
                }
                textelement(D81)
                {
                }
                textelement(D82)
                {
                }
                textelement(D83)
                {
                }
                textelement(D84)
                {
                }
                textelement(D85)
                {
                }
                textelement(D86)
                {
                }
                textelement(D87)
                {
                }
                textelement(D88)
                {
                }
                textelement(D89)
                {
                }
                textelement(D90)
                {
                }
                textelement(D91)
                {
                }
                textelement(D92)
                {
                }
                textelement(D93)
                {
                }
                textelement(D94)
                {
                }
                textelement(D95)
                {
                }
                textelement(D96)
                {
                }
                textelement(D97)
                {
                }
                textelement(D98)
                {
                }
                textelement(D99)
                {
                }
                textelement(D100)
                {
                }
                textelement(D101)
                {
                }
                textelement(D102)
                {
                }
                textelement(D103)
                {
                }
                textelement(D104)
                {
                }
                textelement(D105)
                {
                }
                textelement(D106)
                {
                }
                textelement(D107)
                {
                }
                textelement(D108)
                {
                }
                textelement(D109)
                {
                }
                textelement(D110)
                {
                }
                textelement(D111)
                {
                }
                textelement(D112)
                {
                }
                textelement(D113)
                {
                }
                textelement(D114)
                {
                }
                textelement(D115)
                {
                }
                textelement(D116)
                {
                }
                textelement(D117)
                {
                }
                textelement(D118)
                {
                }
                textelement("<d19>")
                {
                    XmlName = 'D119';
                }
                textelement(D120)
                {
                }
                textelement(D121)
                {
                }
                textelement(D122)
                {
                }
                textelement(D123)
                {
                }
                textelement(D124)
                {
                }
                textelement(D125)
                {
                }
                textelement(D126)
                {
                }
                textelement(D127)
                {
                }
                textelement(D128)
                {
                }
                textelement(D129)
                {
                }
                textelement(D130)
                {
                }
                textelement(D131)
                {
                }
                textelement(D132)
                {
                }
                textelement(D133)
                {
                }
                textelement(D134)
                {
                }
                textelement(D135)
                {
                }
                textelement(D136)
                {
                }
                textelement(D137)
                {
                }
                textelement(D138)
                {
                }
                textelement(D139)
                {
                }
                textelement(D140)
                {
                }
                textelement(D141)
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

        SalesSetup.Get;
        PurchasesPayablesSetup.Get;
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
        UserSetup: Record "User Setup";
        /////- smtp: Codeunit UnknownCodeunit400;
        codcliente: Code[20];
        codpedido: Code[20];
        CANTitrans: Decimal;
        CODDIRENVIO: Code[20];
        ALTA: Boolean;
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        SalesLineDiscount: Record "Sales Line Discount";
        NoSeriesManagement: Codeunit NoSeriesManagement;

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





        clie := 'NAV0225';

        linea := linea + 1;


        if linea > 1 then begin



            if D2 <> codpedido then begin
                ALTA := false;
                RecCV.Reset;
                RecCV.SetRange("Document Type", RecCV."document type"::Order);
                RecCV.SetRange("Your Reference", D2);
                if not RecCV.FindFirst then begin
                    ALTA := true;
                    /////codacti:=INCSTR(RecUser."Serie pedidos");
                    codacti := NoSeriesManagement.GetNextNo('V-PED-LM', Today, true);
                    ///RecUser."Serie pedidos":=codacti;
                    //RecUser."Nº cliente":=clie;
                    //RecUser.MODIFY;
                    RecCV.Init;
                    RecCV."Document Type" := 1;
                    RecCV."No." := codacti;
                    RecCV.Validate(RecCV."Order Date", Today);
                    RecCV.Validate(RecCV."Posting Date", Today);
                    RecCV.Validate(RecCV."Shipment Date", Today);
                    RecCV."Posting Description" := 'Pedido nº ' + D2;
                    RecCV.Validate(RecCV."Sell-to Customer No.", clie);
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
                    RecCV."Shipment Date" := Today;
                    RecCV."Requested Delivery Date" := Today;
                    RecCV.Validate(RecCV."Ship-to Code", CODDIRENVIO);
                    RecCV.Validate(RecCV.Dropshipping, true);
                    RecCV."Shipping Agent Code" := 'SENDING';
                    RecCV."Respeta agencia transporte" := true;
                    RecCV."Super urgente" := true;
                    ///TempBlob.WriteAsText(D2,TEXTENCODING::Windows);
                    ///RecCV."Work Description":=TempBlob.Blob;
                    RecCV.Validate("Your Reference", D2);
                    RecCV."Ship-to Name" := CopyStr(D35 + D36, 1, 50);
                    RecCV."Ship-to Name 2" := CopyStr(D35 + D36, 51, 50);
                    RecCV."Ship-to Address" := CopyStr(D38 + D39, 1, 50);
                    RecCV."Ship-to Address 2" := CopyStr(D38 + D39, 51, 50);
                    RecCV."Ship-to Contact" := D36;
                    RecCV."E-MAIL" := 'ventas@hagen.es';
                    RecCV.Validate(RecCV."Ship-to Post Code", D40);
                    RecCV.Validate(RecCV."Ship-to City", D41);
                    RecCV."Envio a-Nº Telefono" := D44;
                    RecCV."Observación para transporte" := D46;
                    RecCV."Prices Including VAT" := true;
                    RecCV."Prices Including VAT" := false;
                    RecCV.Insert(true);
                    AltaRegalos;
                    codpedido := D2;
                    /////
                    /*PurchaseHeader.INIT;
                    PurchaseHeader."Document Type":=1;
                    PurchaseHeader."No.":=codacti;
                    PurchaseHeader.VALIDATE("Order Date",TODAY);
                    PurchaseHeader.VALIDATE("Posting Date",TODAY);
                    PurchaseHeader."Posting Description":='Pedido nº '+D2;
                    PurchaseHeader.VALIDATE(PurchaseHeader."Buy-from Vendor No.",'P02826');
                    PurchaseHeader."No. Series":=PurchasesPayablesSetup."Order Nos.";
                    PurchaseHeader."Posting No. Series":=PurchasesPayablesSetup."Posted Invoice Nos.";
                    PurchaseHeader."Receiving No. Series":=PurchasesPayablesSetup."Posted Receipt Nos.";
                    PurchaseHeader."Prepayment No. Series":=PurchasesPayablesSetup."Posted Prepmt. Inv. Nos.";
                    PurchaseHeader."Prepmt. Cr. Memo No.":=PurchasesPayablesSetup."Posted Prepmt. Cr. Memo Nos.";
                    PurchaseHeader."Expected Receipt Date":=TODAY;
                    PurchaseHeader."Your Reference":=D2;
                    PurchaseHeader.INSERT(TRUE);*/

                    /////



                end;
            end;
            /*IF obser<>'' THEN BEGIN
            IF NOT RecLCV.GET(1,RecCV."No.",100) THEN BEGIN
                RecLCV."Document Type":=0;
                RecLCV."No.":=RecCV."No." ;
                RecLCV."Line No.":=100;
                RecLCV.Comment:=obser;
                RecLCV.INSERT(TRUE);
            END;
        END;*/
            SALE := false;
            if (D11 <> '') then begin
                RecLV.Reset;
                RecLV.SetRange("id linea externo", D16);
                if not RecLV.FindFirst then begin
                    if RecProd.Get(D11) then begin
                        RecProd.SetRange(RecProd."Location Filter", 'SILLA', 'SILLA');
                        RecProd.CalcFields(RecProd.Inventory);
                        if (RecProd."Estado Producto" <> 0) and (RecProd.Inventory = 0) then begin
                            SALE := true;
                        end;
                        if not SALE then begin
                            LINEAS := LINEAS + 10000;
                            RecLV."Document Type" := 1;
                            RecLV."Document No." := RecCV."No.";
                            RecLV."Line No." := LINEAS;
                            RecLV.Type := 2;
                            RecLV.Validate(RecLV."No.", D11);
                            RecLV."id linea externo" := D16;
                            Evaluate(CANTIDE, D3);
                            RecLV.Validate(RecLV.Quantity, CANTIDE);
                            RecLV.Insert(true);
                            RecLV.Validate(RecLV.Quantity, CANTIDE);
                            RecLV.Modify(true);
                            Evaluate(CANTIDE, D17);
                            ///(CANTIDE:=CANTIDE/(1+(RecLV."VAT %")/100);
                            CANTIDE := ROUND(CANTIDE, 0.01);
                            RecLV.Validate("Unit Price", RecLV.Quantity * CANTIDE);
                            RecLV.Modify(true);

                            Evaluate(CANTitrans, D18);
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
                            /*PurchaseLine.INIT;
                            PurchaseLine."Document Type":=1;
                            PurchaseLine."Document No.":=PurchaseHeader."No.";
                            PurchaseLine."Line No.":=LINEAS;
                            PurchaseLine.Type:=1;
                            PurchaseLine.VALIDATE("No.",'70600001');
                            PurchaseLine.Description:=COPYSTR(D4,1,50);
                            PurchaseLine."Description 2":=COPYSTR(D4,51,50);
                            CANTIDE:=1;
                            PurchaseLine.VALIDATE(Quantity,CANTIDE);
                            PurchaseLine.INSERT(TRUE);
                            PurchaseLine.VALIDATE(Quantity,CANTIDE);
                            EVALUATE(CANTIDE,D21);
                            PurchaseLine.VALIDATE("Direct Unit Cost",CANTIDE);
                            PurchaseLine.MODIFY(TRUE);
                            PurchaseLine.VALIDATE("Direct Unit Cost",CANTIDE);
                            PurchaseLine.MODIFY(TRUE);*/
                        end;
                    end else begin
                        RecRefCruz.Reset;
                        RecRefCruz.SetCurrentkey(RecRefCruz."Reference No.");
                        RecRefCruz.SetRange(RecRefCruz."Reference No.", D11);
                        if RecRefCruz.FindFirst then begin
                            ref := RecRefCruz."Item No.";
                            if RecProd.Get(ref) then begin
                                RecProd.CalcFields(RecProd.Inventory);
                                if (RecProd."Estado Producto" <> 0) and (RecProd.Inventory = 0) then begin
                                    SALE := true;
                                end;
                                if not SALE then begin
                                    if RecProd."No permite pedido"=false then begin
                                        LINEAS := LINEAS + 10000;
                                        RecLV."Document Type" := 1;
                                        RecLV."Document No." := RecCV."No.";
                                        RecLV."Line No." := LINEAS;
                                        RecLV.Type := 2;
                                        RecLV.Validate(RecLV."No.", ref);
                                        RecLV."id linea externo" := D16;
                                        Evaluate(CANTIDE, D3);
                                        RecLV.Validate(RecLV.Quantity, CANTIDE);
                                        RecLV.Insert(true);
                                        RecLV.Validate(RecLV.Quantity, CANTIDE);
                                        RecLV.Modify(true);
                                        Evaluate(CANTIDE, D17);
                                        ///                            CANTIDE:=CANTIDE/(1+(RecLV."VAT %")/100);
                                        CANTIDE := ROUND(CANTIDE, 0.01);
                                        RecLV.Validate("Unit Price", RecLV.Quantity * CANTIDE);
                                        RecLV.Modify(true);
                                    end;
                                        Evaluate(CANTitrans, D18);
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
                                    /*PurchaseLine.INIT;
                                    PurchaseLine."Document Type":=1;
                                    PurchaseLine."Document No.":=PurchaseHeader."No.";
                                    PurchaseLine."Line No.":=LINEAS;
                                    PurchaseLine.Type:=1;
                                    PurchaseLine.VALIDATE("No.",'70600001');
                                    PurchaseLine.Description:=COPYSTR(D4,1,50);
                                    PurchaseLine."Description 2":=COPYSTR(D4,51,50);
                                    CANTIDE:=1;
                                    PurchaseLine.VALIDATE(Quantity,CANTIDE);
                                    PurchaseLine.INSERT(TRUE);
                                    PurchaseLine.VALIDATE(Quantity,CANTIDE);
                                    EVALUATE(CANTIDE,D21);
                                    PurchaseLine.VALIDATE("Direct Unit Cost",CANTIDE);
                                    PurchaseLine.MODIFY(TRUE);
                                    PurchaseLine.VALIDATE("Direct Unit Cost",CANTIDE);
                                    PurchaseLine.MODIFY(TRUE);*/


                                end;
                            end;
                        end;
                    end;

                end;
            end;
        end;

    end;

    local procedure AltaRegalos()
    begin


        lin := 0;
        SalesLineDiscount.Reset;
        SalesLineDiscount.SetRange(SalesLineDiscount."Sales Code", clie);
        /////- SalesLineDiscount.SetRange(SalesLineDiscount."Sales Type",SalesLineDiscount."sales type"::Regalo);
        if SalesLineDiscount.FindFirst then
            repeat
                if (SalesLineDiscount."Starting Date" <> 0D) and (SalesLineDiscount."Ending Date" <> 0D) then begin
                    if (SalesLineDiscount."Starting Date" >= Today) and (SalesLineDiscount."Ending Date" <= Today) then begin
                        lin := lin + 100;
                        RecLV.Init;
                        RecLV."Document Type" := 1;
                        RecLV."Document No." := codacti;
                        RecLV."Line No." := lin;
                        RecLV.Type := 2;
                        RecLV.Validate(RecLV."No.", SalesLineDiscount.Code);
                        RecLV.Validate(RecLV.Quantity, 1);
                        RecLV.Insert(true);
                    end;
                end;
                if (SalesLineDiscount."Starting Date" <> 0D) and (SalesLineDiscount."Ending Date" = 0D) then begin
                    if (SalesLineDiscount."Starting Date" >= Today) then begin
                        lin := lin + 100;
                        RecLV.Init;
                        RecLV."Document Type" := 1;
                        RecLV."Document No." := codacti;
                        RecLV."Line No." := lin;
                        RecLV.Type := 2;
                        RecLV.Validate(RecLV."No.", SalesLineDiscount.Code);
                        RecLV.Validate(RecLV.Quantity, 1);
                        RecLV.Insert(true);
                    end;
                end;
                if (SalesLineDiscount."Starting Date" = 0D) and (SalesLineDiscount."Ending Date" <> 0D) then begin
                    if (SalesLineDiscount."Ending Date" <= Today) then begin
                        lin := lin + 100;
                        RecLV.Init;
                        RecLV."Document Type" := 1;
                        RecLV."Document No." := codacti;
                        RecLV."Line No." := lin;
                        RecLV.Type := 2;
                        RecLV.Validate(RecLV."No.", SalesLineDiscount.Code);
                        RecLV.Validate(RecLV.Quantity, 1);
                        RecLV.Insert(true);
                    end;
                end;
            until SalesLineDiscount.Next = 0;
    end;
}

