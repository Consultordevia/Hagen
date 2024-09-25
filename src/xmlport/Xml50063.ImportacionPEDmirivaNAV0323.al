#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50063 "Importacion PED miriva NAV0323"
{
    // 
    // 
    // Con este fichero vamos hacer dos cosas, el pedido de venta y generar pedido de compra y albarán de compra
    // El cliente en Nav2018 es 12496
    // El proveedor es P02826
    // Pedido de ventas:
    // Importamos el pedido al cliente 12496  tal cual lo hacemos con Catit, es decir ponemos los datos de envío en dirección personalizada, sin necesidad de dar de alta la dirección de envío, el mejor ejemplo es igual que Catit, los datos para dar de alt
    // El pedido siempre marcar en el pedido el check de DropShiping
    // Generamos un albarán de compra al Proveedor P02826 , en el fichero en Azul los campos que debes de utilizar
    // En este fichero hay dos pedido uno de 2 líneas y uno de una sola línea, si te fijas el caso del transporte hay dos columnas , para que veas el importe de transporte de cada línea o te lo puedes traer de la columna total como quieras
    // 
    // Fecha de creación1 -
    // Número de pedido2 -
    // Cantidad3 -
    // Detalles4
    // Estado5
    // Importe6
    // Moneda7
    // Método de envío8
    // Fecha de débito al cliente9 - fecha alta
    // Proceso de pago10
    // Canal11
    // SKU de vendedor12 - referencia
    // Motivo13
    // SKU de oferta14
    // Estado de la oferta15
    // N.º de asiento de pedido16
    // Precio por unidad17 - precio
    // Precio de envío18 - Ref. TRAN y pones este importe
    // Importe total del envío19
    // Importe total del pedido20
    // Comisión (sin impuestos)21 - importe
    // Valor de la comisión (impuestos incluidos)22
    // Importe reembolsado a vendedor (impuestos incluidos)23
    // Información adicional sobre precios24
    // Tipo de IVA en la comisión25
    // Fecha de aceptación26
    // Fecha límite de envío27 - fecha recepcion esperada
    // Fecha de envío28
    // Fecha de recepción29
    // Empresa transportista30
    // Número de seguimiento31
    // URL de seguimiento32
    // Dirección de entrega: cortesía33
    // Dirección de entrega: nombre de pila34 - nombre
    // Dirección de entrega: apellido35 - contacto
    // Dirección de entrega: empresa36
    // Dirección de entrega: calle 137
    // Dirección de entrega: calle 238
    // Dirección de entrega: complementaria39
    // Dirección de entrega: código postal40
    // Dirección de entrega: ciudad41
    // Dirección de entrega: provincia42
    // Dirección de entrega: país43
    // Dirección de entrega: teléfono 44
    // Dirección de entrega: teléfono 245
    // Dirección de entrega: información adicional46 - Observacion Transporte
    // Dirección de entrega: información adicional interna47
    // Dirección de facturación: cortesía48
    // Dirección de facturación: nombre de pila49
    // Dirección de facturación: apellido50
    // Dirección de facturación: empresa51
    // Dirección de facturación: calle 152
    // Dirección de facturación: calle 253
    // Dirección de facturación: complementaria54
    // Dirección de facturación: código postal55
    // Dirección de facturación: ciudad56
    // Dirección de facturación: provincia57
    // Dirección de facturación: país58
    // Dirección de facturación: teléfono59
    // Dirección de facturación: teléfono 260
    // Método de pago61
    // Plazo de envío del pedido62
    // Factura requirida63
    // 
    //   EVALUATE(DD,DDA);
    //                EVALUATE(MM,MMA);
    //                EVALUATE(AA,AAA);
    //                FECHAENVIO:=DMY2DATE(DD,MM,AA);
    //                RecCV."Shipment Date":=FECHAENVIO;
    //                RecCV."Requested Delivery Date":=FECHAENVIO;

    Caption = 'Importacion PEDIDOS tienda ani';
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
                textelement(D50)
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
                textelement(D48)
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
                textelement(D49)
                {
                }
                textelement(D43)
                {
                }
                textelement(D51)
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

        RecUser.Get(UserId);

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
        PRECIOLIN: Decimal;

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





        clie := 'NAV0323';

        linea := linea + 1;


        if linea > 1 then begin
            if D1 <> codpedido then begin
                ALTA := false;
                RecCV.Reset;
                RecCV.SetRange("Document Type", RecCV."document type"::Order);
                RecCV.SetRange("Your Reference", D1);
                if not RecCV.FindFirst then begin
                    ALTA := true;
                    /////codacti:=INCSTR(RecUser."Serie pedidos");
                    codacti := NoSeriesManagement.GetNextNo('V-PED-MIRA', Today, true);
                    ///RecUser."Serie pedidos":=codacti;
                    //RecUser."Nº cliente":=clie;
                    //RecUser.MODIFY;
                    RecCV.Init;
                    RecCV."Document Type" := 1;
                    RecCV."No." := codacti;
                    RecCV.Validate(RecCV."Order Date", Today);
                    RecCV.Validate(RecCV."Posting Date", Today);
                    RecCV.Validate(RecCV."Shipment Date", Today);
                    RecCV."Posting Description" := 'Pedido nº ' + D1;
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
                    RecCV."Your Reference" := D1;
                    RecCV."Shipment Date" := Today;
                    RecCV."Requested Delivery Date" := Today;
                    RecCV.Validate(RecCV."Ship-to Code", CODDIRENVIO);
                    RecCV.Validate(RecCV.Dropshipping, true);
                    RecCV.Validate("Shipping Agent Code", 'PRO');
                    RecCV."Respeta agencia transporte" := true;
                    RecCV."Super urgente" := true;
                    ///TempBlob.WriteAsText(D2,TEXTENCODING::Windows);
                    ///RecCV."Work Description":=TempBlob.Blob;
                    RecCV."Your Reference" := D1;
                    RecCV."Ship-to Name" := CopyStr(D16, 1, 50);
                    RecCV."Ship-to Name 2" := CopyStr(D16, 51, 50);
                    RecCV."Ship-to Address" := CopyStr(D17 + D18, 1, 50);
                    RecCV."Ship-to Address 2" := CopyStr(D17 + D18, 51, 50);
                    RecCV."Ship-to Contact" := '';
                    RecCV.Validate(RecCV."Ship-to Post Code", D21);
                    RecCV.Validate(RecCV."Ship-to City", D19);
                    RecCV."Envio a-Nº Telefono" := D27;
                    RecCV."Observación para transporte" := '';
                    RecCV."Prices Including VAT" := true;
                    RecCV."Prices Including VAT" := false;
                    RecCV.Insert(true);
                    AltaRegalos;
                    codpedido := D1;
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
            if (D6 <> '') then begin
                if RecProd.Get(D6) then begin
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
                        RecLV.Validate(RecLV."No.", D6);
                        ///EVALUATE(CANTIDE,D3);
                        CANTIDE := 1;
                        RecLV.Validate(RecLV.Quantity, CANTIDE);
                        RecLV.Insert(true);
                        RecLV.Validate(RecLV.Quantity, CANTIDE);
                        RecLV.Modify(true);
                        Evaluate(PRECIOLIN, D32);
                        PRECIOLIN := PRECIOLIN / 100;
                        PRECIOLIN := PRECIOLIN / (1 + (RecLV."VAT %") / 100);
                        RecLV.Validate("Unit Price", PRECIOLIN);
                        RecLV.Modify(true);
                    end;
                end else begin
                    RecRefCruz.Reset;
                    RecRefCruz.SetCurrentkey(RecRefCruz."Reference No.");
                    RecRefCruz.SetRange(RecRefCruz."Reference No.", D6);
                    if RecRefCruz.FindFirst then begin
                        ref := RecRefCruz."Item No.";
                        if RecProd.Get(ref) then begin
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
                                RecLV.Validate(RecLV."No.", ref);
                                CANTIDE := 1;
                                RecLV.Validate(RecLV.Quantity, CANTIDE);
                                RecLV.Insert(true);
                                RecLV.Validate(RecLV.Quantity, CANTIDE);
                                RecLV.Modify(true);
                                Evaluate(PRECIOLIN, D32);
                                PRECIOLIN := PRECIOLIN / 100;
                                PRECIOLIN := PRECIOLIN / (1 + (RecLV."VAT %") / 100);
                                RecLV.Validate("Unit Price", PRECIOLIN);
                                RecLV.Modify(true);


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

