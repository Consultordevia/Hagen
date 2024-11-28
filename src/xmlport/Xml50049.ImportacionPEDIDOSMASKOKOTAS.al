#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50049 "Importacion PEDIDOS MASKOKOTAS"
{
    // 
    // 
    // Numero de pedido
    // 
    // Código Dirección de envío (Tal cual lo hacemos con amazon)
    // Ean Articulo
    // Cantidad
    // 

    Caption = 'Importacion PEDIDOS AMAZON2';
    Direction = Import;
    FieldDelimiter = '<>';
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
        SalesReceivablesSetup.Get;
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
        NPEDIDO: Text;
        X: Integer;
        FECHAENVIO: Date;
        DD: Integer;
        MM: Integer;
        AA: Integer;
        DDA: Code[10];
        MMA: Code[10];
        AAA: Code[10];
        RecEAD: Record "Ship-to Address";
        DD7: Code[20];
        SALTA: Boolean;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
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

        linea := linea + 1;
        if linea > 1 then begin
            if linea >= 1 then begin
                clie := '11056';
                if NPEDIDO <> D1 then begin
                    NPEDIDO := D1;

                    codacti := IncStr(RecUser."Serie pedidos");
                    codacti := NoSeriesManagement.GetNextNo('V-PRESU-2', Today, true);
                    RecUser."Serie pedidos" := codacti;
                    RecUser."Nº cliente" := clie;
                    RecUser.Modify;
                    RecCV.Init;
                    RecCV."Document Type" := 1;
                    RecCV."No." := codacti;
                    RecCV.Validate(RecCV."Order Date", Today);
                    RecCV.Validate(RecCV."Posting Date", Today);
                    RecCV.Validate(RecCV."Shipment Date", Today);
                    RecCV."Posting Description" := 'Pedido nº ' + codacti;
                    RecCV.Validate(RecCV."Sell-to Customer No.", clie);
                    RecCV."Estado pedido" := RecCV."estado pedido"::Retenido;
                    RecCV."Usuario alta" := UserId;
                    RecCV."Fecha alta" := Today;
                    RecCV."Hora alta" := Time;
                    SalesSetup.Get;
                    RecCV."No. Series" := SalesSetup."Order Nos.";
                    RecCV."Posting No. Series" := SalesSetup."Posted Invoice Nos.";
                    RecCV."Shipping No. Series" := SalesSetup."Posted Shipment Nos.";
                    RecCV."Prepayment No. Series" := SalesSetup."Posted Prepmt. Inv. Nos.";
                    RecCV."Prepmt. Cr. Memo No." := SalesSetup."Posted Prepmt. Cr. Memo Nos.";
                    RecCV."Permite fraccionar uni. venta" := true;
                    RecCV."Your Reference" := D1;
                    X := 0;
                    SALE := false;
                    FECHAENVIO := Today;
                    RecCV."Shipment Date" := FECHAENVIO;
                    RecCV."Requested Delivery Date" := FECHAENVIO;
                    RecCV.Insert(true);
                    X := 0;
                    SALE := false;
                    CODENVIO := '';
                    repeat
                        X := X + 1;
                        if CopyStr(D2, X, 1) = '-' then begin
                            SALE := true;
                        end;
                        if CopyStr(D2, X, 1) <> '-' then begin
                            CODENVIO := CODENVIO + CopyStr(D2, X, 1);
                        end;
                    until (X = StrLen(D2)) or SALE;
                    RecEAD.Reset;
                    RecEAD.SetRange(RecEAD."Customer No.", '11056');
                    RecEAD.SetRange(RecEAD.Code, CODENVIO);
                    if RecEAD.FindFirst then begin
                        RecCV.Validate(RecCV."Ship-to Code", RecEAD.Code);
                        RecCV.Modify;
                    end;
                end;
                DD7 := '';
                SALTA := false;
                RecProd.Reset;
                RecProd.SetFilter(ean, '*' + CopyStr(D3, 2) + '*');
                if RecProd.FindFirst then begin
                    DD7 := RecProd."No.";
                    if SALTA = false then begin
                        LINEAS := LINEAS + 10000;
                        RecLV."Document Type" := 1;
                        RecLV."Document No." := RecCV."No.";
                        RecLV."Line No." := LINEAS;
                        RecLV.Type := 2;
                        RecLV.Validate(RecLV."No.", DD7);
                        Evaluate(CANTIDE, D4);
                        RecLV.Validate(RecLV.Quantity, CANTIDE);
                        RecLV.Insert(true);
                        RecLV.Validate(RecLV.Quantity, CANTIDE);
                        RecLV.Modify(true);
                    end;
                end;
            end;
        end;
    end;
}

