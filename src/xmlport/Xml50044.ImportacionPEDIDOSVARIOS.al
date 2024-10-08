#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50044 "Importacion PEDIDOS VARIOS"
{
    Caption = 'Importacion PEDIDOS VARIOS';
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
                clie := '';
                RecClie.Reset;
                RecClie.SetRange("No.", D4);
                if RecClie.FindFirst then begin
                    clie := RecClie."No.";
                end;
                codacti := IncStr(RecUser."Serie pedidos");
                RecUser."Serie pedidos" := codacti;
                RecUser."Nº cliente" := clie;
                RecUser.Modify;
                RecCV.Init;
                RecCV."Document Type" := 0;
                RecCV."No." := codacti;



                /////RecCV."Super oferta":=SUPRA;
                RecCV.Validate(RecCV."Order Date", Today);
                RecCV.Validate(RecCV."Posting Date", Today);
                RecCV.Validate(RecCV."Shipment Date", Today);
                RecCV."Posting Description" := 'Pedido nº ' + codacti;
                RecCV.Validate(RecCV."Sell-to Customer No.", clie);
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


                RecCV.Insert(true);





            end;
            SALE := false;

            ///// D[10]:=COPYSTR(D[10],2);
            if D2 <> '' then begin
                if RecProd.Get(D2) then begin
                    RecProd.SetRange(RecProd."Location Filter", 'SILLA', 'SILLA');
                    RecProd.CalcFields(RecProd.Inventory);
                    if (RecProd."Estado Producto" <> 0) and (RecProd.Inventory = 0) then begin
                        SALE := true;
                    end;
                    if RecProd."Permite fraccionar venta" = false then begin
                        SALE := true;
                    end;
                    if RecProd."No permite pedido" = true then begin
                        SALE := true;
                    end;
                    if RecProd."Producto con reserva" = true then begin
                        SALE := true;
                    end;
                    if not SALE then begin
                        LINEAS := LINEAS + 10000;
                        RecLV."Document Type" := 0;
                        RecLV."Document No." := RecCV."No.";
                        RecLV."Line No." := LINEAS;
                        RecLV.Type := 2;
                        RecLV.Validate(RecLV."No.", D2);
                        Evaluate(CANTIDE, D3);
                        RecLV.Validate(RecLV.Quantity, CANTIDE);
                        RecLV.Insert(true);
                        RecLV.Validate(RecLV.Quantity, CANTIDE);
                        RecLV.Modify(true);

                    end;
                end;
                if not RecProd.Get(D2) then begin
                    RecRefCruz.Reset;
                    RecRefCruz.SetCurrentkey(RecRefCruz."Reference No.");
                    RecRefCruz.SetRange(RecRefCruz."Reference No.", D2);
                    if RecRefCruz.FindFirst then begin
                        D2 := RecRefCruz."Item No.";
                        if RecProd.Get(D2) then begin
                            RecProd.SetRange(RecProd."Location Filter", 'SILLA', 'SILLA');
                            RecProd.CalcFields(RecProd.Inventory);
                            if (RecProd."Estado Producto" <> 0) and (RecProd.Inventory = 0) then begin
                                SALE := true;
                            end;
                            if RecProd."Permite fraccionar venta" = false then begin
                                SALE := true;
                            end;
                            if RecProd."No permite pedido" = true then begin
                                SALE := true;
                            end;
                            if RecProd."Producto con reserva" = true then begin
                                SALE := true;
                            end;
                            if not SALE then begin
                                LINEAS := LINEAS + 10000;
                                RecLV."Document Type" := 0;
                                RecLV."Document No." := RecCV."No.";
                                RecLV."Line No." := LINEAS;
                                RecLV.Type := 2;
                                RecLV.Validate(RecLV."No.", D2);
                                Evaluate(CANTIDE, D3);
                                RecLV.Validate(RecLV.Quantity, CANTIDE);
                                RecLV.Insert(true);
                                RecLV.Validate(RecLV.Quantity, CANTIDE);
                                RecLV.Modify(true);


                            end;

                        end;
                    end;
                end;
            end;

        end;
    end;

    local procedure Enviaemail()
    begin

        UserSetup.Get(UserId);

        SenderName := 'HAGEN';
        Subject := 'Este relacion no existe en kiwoko: ' + D1;
        Recipient := 'oscarraea@hotmail.com;martinjesus241@gmail.com';
        /////- Clear(smtp);
        /////- smtp.Run;
        /////- smtp.CreateMessage(SenderName,SenderAddress,Recipient,Subject,Body,true);

        /////- smtp.AppendBody('Este relacion no existe en kiwoko: '+D1+' <BR>');
        /////- smtp.AppendBody('<HR>');

        /////- 
        /////-                 smtp.Send;
        /////- Clear(smtp);
    end;
}

