#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50035 "Importacion PEDIDOS catit nue2"
{
    Caption = 'Importacion PEDIDOS catit nue2';
    Direction = Import;
    FieldDelimiter = '<*>';
    FieldSeparator = '&';
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
                    cuantaslin := cuantaslin + 1;
                until RecLV.Next = 0;
            dto := ROUND(impdto / cuantaslin, 0.01);
            RecLV.Reset;
            RecLV.SetRange(RecLV."Document Type", 1);
            RecLV.SetRange(RecLV."Document No.", codacti);
            if RecLV.FindFirst then
                repeat
                    if RecLV."Line Discount %" <> 100 then begin
                        RecLV.Validate(RecLV."Line Discount Amount", dto);
                        RecLV.Modify;
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
        SalesLine22: Record "Sales Line";
        SalesLineDiscount: Record "Sales Line Discount";

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
            CODCLIE := '11010';
            if linea >= 2 then begin
                if NPEDIDO <> D1 then begin
                    if tienedto then begin
                        cuantaslin := 0;
                        RecLV.Reset;
                        RecLV.SetRange(RecLV."Document Type", 1);
                        RecLV.SetRange(RecLV."Document No.", codacti);
                        if RecLV.FindFirst then
                            repeat
                                cuantaslin := cuantaslin + 1;
                            until RecLV.Next = 0;
                        dto := ROUND(impdto / cuantaslin, 0.01);
                        RecLV.Reset;
                        RecLV.SetRange(RecLV."Document Type", 1);
                        RecLV.SetRange(RecLV."Document No.", codacti);
                        if RecLV.FindFirst then
                            repeat
                                RecLV.Validate(RecLV."Line Discount Amount", dto);
                                RecLV.Modify;
                            until RecLV.Next = 0;
                    end;
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
                    RecCV.Validate("Your Reference" , D1);
                    RecCV.Validate(RecCV."Ship-to Code", CODDIRENVIO);
                    RecCV."Shipment Date" := Today;
                    RecCV."Requested Delivery Date" := Today;
                    RecCV.Validate(RecCV.Dropshipping, true);
                    RecCV."Shipping Agent Code" := 'SENDING';
                    RecCV."Respeta agencia transporte" := true;
                    /////- TempBlob.WriteAsText(D2,Textencoding::Windows);
                    /////- RecCV."Work Description":=TempBlob.Blob;
                    if D14 = 'bacs' then begin
                        RecCV."Payment Method Code" := 'TRANSFWEB';
                    end;
                    if D14 = 'redsys' then begin
                        RecCV."Payment Method Code" := 'TPV';
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
                    RecCV."Ship-to City" := D8;
                    RecCV."Ship-to Contact" := D4;
                    if StrLen(D9) = 4 then begin
                        D9 := '0' + D9;
                    end;
                    RecCV."Ship-to Post Code" := D9;
                    if Area.Get(CopyStr(D9, 1, 2)) then begin
                        RecCV."Ship-to County" := Area.Text;
                    end;
                    RecCV."Envio a-Nº Telefono" := D15;
                    RecCV."E-MAIL" := D3;
                    RecCV.Insert(true);
                    AltaRegalos;
                    tienedto := false;
                    impdto := 0;
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
                    LINEAS := LINEAS + 10000;
                    RecLV."Document Type" := 1;
                    RecLV."Document No." := codacti;
                    RecLV."Line No." := LINEAS;
                    RecLV.Type := 2;
                    RecLV.Validate(RecLV."No.", CODPROD);
                    Evaluate(CANTIDE, D11);
                    RecLV.Validate(RecLV.Quantity, CANTIDE);
                    if UpperCase(CopyStr(D16, 1, 1)) = 'Y' then begin
                        RecLV.Validate(RecLV."Line Discount %", 100);
                    end;

                    RecLV.Insert(true);
                end;
                Evaluate(CANTitrans, D12);
                impdto := 0;
                tienedto := false;

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
            end;
        end;

    end;

    local procedure AltaRegalos()
    begin


        lin := 0;
        SalesLineDiscount.Reset;
        SalesLineDiscount.SetRange(SalesLineDiscount."Sales Code", CODCLIE);
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

