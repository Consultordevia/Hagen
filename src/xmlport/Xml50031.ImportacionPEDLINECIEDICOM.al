#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50031 "Importacion PEDLIN ECI EDICOM"
{
    Caption = 'Importacion PEDLIN ECI EDICOM';
    Direction = Import;
    FieldSeparator = '|';
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
                textelement("<d19>")
                {
                    XmlName = 'D19';
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
                textelement("<d23>")
                {
                    XmlName = 'D53';
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
                textelement("<d28>")
                {
                    XmlName = 'D58';
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
                textelement("<d27>")
                {
                    XmlName = 'D67';
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
                textelement("<d29>")
                {
                    XmlName = 'D89';
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
        cd1: Code[10];
        cd2: Code[10];
        cd3: Code[10];
        dd1: Integer;
        dd2: Integer;
        dd3: Integer;

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


        RecCV.Reset;
        RecCV.SetRange("Document Type", RecCV."document type"::Quote);
        RecCV.SetRange("External Document No.", D1);
        if RecCV.FindSet then begin
            if CopyStr(D3, 1, 2) = '00' then begin
                D3 := CopyStr(D3, 2);
            end;
            if D3 <> '' then begin
                RecRefCruz.Reset;
                RecRefCruz.SetCurrentkey(RecRefCruz."Reference No.");
                RecRefCruz.SetRange(RecRefCruz."Reference No.", D3);
                if RecRefCruz.FindFirst then begin
                    ref := RecRefCruz."Item No.";
                    if RecProd.Get(ref) then begin
                        SALE := false;
                        RecProd.CalcFields(RecProd.Inventory);
                        if (RecProd."Estado Producto" <> 0) and (RecProd.Inventory = 0) then begin
                            SALE := true;
                            ///MESSAGE('%1 %2 %3  estado<>0 y no stock ',D1,D3,ref);
                        end;
                        if not SALE then begin
                            LINEAS := LINEAS + 10000;
                            RecLV."Document Type" := RecLV."document type"::Quote;
                            RecLV."Document No." := RecCV."No.";
                            RecLV."Line No." := LINEAS;
                            RecLV.Type := 2;
                            RecLV.Validate(RecLV."No.", ref);
                            Evaluate(CANTIDE, D12);
                            CANTIDE := CANTIDE / 1000;
                            RecLV.Validate(RecLV.Quantity, CANTIDE);
                            RecLV.Insert(true);
                            RecLV.Validate(RecLV.Quantity, CANTIDE);
                            if D18 <> '' then begin
                                Evaluate(CANTIDE, D18);
                                CANTIDE := CANTIDE / 1000;
                                RecLV."Precio importado" := CANTIDE;
                            end;
                            RecLV.Modify(true);
                        end;
                    end;
                end;
            end;
            if not RecRefCruz.FindFirst then begin
                ///  MESSAGE('%1 %2 no existe ',D1,D3);
            end;

        end;
    end;

    local procedure Enviaemail()
    begin
        /*
        UserSetup.GET(USERID);
        
             SenderName := 'HAGEN';
             Subject:='Este relacion no existe en kiwoko: '+D1;
             Recipient:='oscarraea@hotmail.com;martinjesus241@gmail.com';
             CLEAR(smtp);
             smtp.RUN;
             smtp.CreateMessage(SenderName,SenderAddress,Recipient,Subject,Body,TRUE);
        
                  smtp.AppendBody('Este relacion no existe en kiwoko: '+D1+' <BR>');
                  smtp.AppendBody('<HR>');
        
        
                       smtp.Send;
                       CLEAR(smtp);
                       */

    end;
}

