#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50003 "Importacion PEDIDOS catit nulo"
{
    Caption = 'Importacion PEDIDOS catit';
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

        Message('SALE');
    end;

    trigger OnPreXmlPort()
    begin

        RecUser.Get(UserId);
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

            if linea = 2 then begin
                Customer.Reset;
                Customer.SetRange("E-Mail", D1);
                if Customer.FindFirst then begin
                    CODCLIE := Customer."No.";
                end;
                if not Customer.FindFirst then begin
                    SalesReceivablesSetup.Get;
                    NUMCLIE := NoSeriesManagement.GetNextNo('CC', Today, true);
                    Customer.Init;
                    Customer."No." := NUMCLIE;
                    Customer.Name := CopyStr(D4 + ' ' + D5 + ', ' + D3, 1, 50);
                    Customer."Search Name" := CopyStr(D4 + ' ' + D5 + ', ' + D3, 1, 50);
                    Customer."Name 2" := CopyStr(D4 + ' ' + D5 + ', ' + D3, 51, 50);
                    Customer.Address := CopyStr(D7 + ' ' + D8 + ' ' + D9, 1, 50);
                    Customer."Address 2" := CopyStr(D7 + ' ' + D8 + ', ' + D9, 51, 50);
                    Customer."VAT Registration No." := D6;
                    Customer.City := D11;
                    Customer.Contact := D3;
                    Customer."Phone No." := D15;
                    Customer."Nº movil" := D14;
                    Customer."Customer Posting Group" := 'NAC';
                    Customer."Customer Price Group" := 'CATIT';
                    Customer."Payment Terms Code" := '0D';
                    Customer."Salesperson Code" := '100';
                    Customer."Country/Region Code" := D13;
                    Customer."Payment Method Code" := D28;
                    Customer."Gen. Bus. Posting Group" := 'NACIONAL';
                    Customer."Post Code" := D10;
                    Customer.County := D12;
                    Customer."E-Mail" := D1;
                    Customer."VAT Bus. Posting Group" := 'NACIONAL';
                    Customer."Grupo clientes" := 'G52';
                    Customer."Customer Disc. Group" := 'DCCA';
                    Customer."Location Code" := 'SILLA';
                    Customer."Grupo ventas" := 'CATIT';
                    Customer."No imprimir albaran valorado" := true;
                    Customer."No imprimir facturas" := true;
                    Customer."No enviar excel" := true;
                    Customer."Incluir en propaganda" := false;
                    Customer."Frecuencia visita comercial" := 'TRIMESTRAL';
                    Customer.Insert;
                    CODCLIE := NUMCLIE;
                    ShiptoAddress."Customer No." := CODCLIE;
                    ShiptoAddress.Code := CODCLIE;
                    ShiptoAddress.Name := CopyStr(D4 + ' ' + D5 + ', ' + D3, 1, 50);
                    ShiptoAddress."Name 2" := CopyStr(D4 + ' ' + D5 + ', ' + D3, 51, 50);
                    ShiptoAddress.Address := CopyStr(D16 + ' ' + D17 + ' ' + D18, 1, 50);
                    ShiptoAddress."Address 2" := CopyStr(D16 + ' ' + D17 + ' ' + D18, 51, 50);
                    ShiptoAddress.City := D20;
                    ShiptoAddress.Contact := D3;
                    ShiptoAddress."Phone No." := D25;
                    ShiptoAddress."Country/Region Code" := D22;
                    ShiptoAddress."Post Code" := D19;
                    ShiptoAddress.County := D21;
                    ShiptoAddress."E-Mail" := D1;
                    ShiptoAddress."Nº Movil" := D23;
                    ShiptoAddress.Insert;
                    CODDIRENVIO := CODCLIE;
                end;
            end;
            if linea >= 2 then begin
                if linea = 2 then begin
                    SalesSetup.Get;
                    codacti := NoSeriesManagement.GetNextNo(SalesSetup."Order Nos.", Today, true);
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
                    RecCV."Your Reference" := D2;
                    RecCV.Validate(RecCV."Ship-to Code", CODDIRENVIO);
                    RecCV."Shipment Date" := Today;
                    RecCV."Requested Delivery Date" := Today;
                    RecCV.Validate(RecCV.Dropshipping, true);
                    RecCV."Shipping Agent Code" := 'SENDING';
                    RecCV."Respeta agencia transporte" := true;
                    /////- TempBlob.WriteAsText(D29,Textencoding::Windows);
                    /////- RecCV."Work Description":=TempBlob.Blob;


                    /*
                    CALCFIELDS("Work Description");
                    IF NOT "Work Description".HASVALUE THEN
                      EXIT('');
                    CR[1] := 10;
                    TempBlob.Blob := "Work Description";
                    EXIT(TempBlob.ReadAsText(CR,TEXTENCODING::Windows));

                    */


                    RecCV.Insert(true);
                end;
                CODPROD := '';
                RecProd.Reset;
                RecProd.SetRange("Ref. Catit", D25);
                if RecProd.FindFirst then begin
                    CODPROD := RecProd."No.";
                end;
                if not RecProd.FindFirst then begin
                    if RecProd.Get(D25) then begin
                        CODPROD := RecProd."No.";
                    end;
                    if not RecProd.Get(D25) then begin
                        Error('La ref %1 no existe', D25);
                    end;
                end;
                if RecProd.Get(CODPROD) then begin
                    LINEAS := LINEAS + 10000;
                    RecLV."Document Type" := 1;
                    RecLV."Document No." := RecCV."No.";
                    RecLV."Line No." := LINEAS;
                    RecLV.Type := 2;
                    RecLV.Validate(RecLV."No.", CODPROD);
                    Evaluate(CANTIDE, D26);
                    RecLV.Validate(RecLV.Quantity, CANTIDE);
                    RecLV.Insert(true);
                    RecLV.Validate(RecLV.Quantity, CANTIDE);
                    RecLV.Validate(RecLV."Customer Price Group", '');
                    Evaluate(PPRECIO, D27);
                    RecLV.Validate(RecLV."Unit Price", PPRECIO);
                    RecLV.Modify(true);
                end;
            end;
        end;

    end;
}

