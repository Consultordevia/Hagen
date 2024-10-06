#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50100 "ADAIA_Alta del TRSTOMOV"
{
    Caption = 'ADAIA_Alta del TRSTOMOV';
    Direction = Import;
    FieldSeparator = '|';
    Format = VariableText;
    TextEncoding = WINDOWS;
    UseRequestPage = false;

    ///   1   2  3   4       5     6      7    8     9   10      11   12   13 14 15 16 17   18
    /// STAJ|MO|44451|-|000000001|UD|00000000|INSI|192946|+|000000000||010D02902||EU|   | |E150|
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
                    Width = 255;
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

    trigger OnPreXmlPort()
    begin




        RecSDP.Reset;
        RecSDP.SetRange(RecSDP."Journal Template Name", 'ELEMENTO');
        RecSDP.SetRange(RecSDP.Name, 'ADAIA');
        if not RecSDP.FindFirst then begin
            RecSDP."Journal Template Name" := 'ELEMENTO';
            RecSDP.Name := 'ADAIA';
            RecSDP.Insert;
        end;





    end;

    var
        LastLineIsHeaderErr: label 'The imported file contains unexpected formatting. One or more lines may be missing in the file.';
        WrongHeaderErr: label 'The imported file contains unexpected formatting. One or more headers are incorrect.';
        WORKDATED: Date;
        KIL: Decimal;
        CAN: Decimal;
        UNO: Code[20];
        DOS: Code[20];
        POS: Decimal;
        LON: Decimal;
        REF: Code[20];
        SALE: Boolean;
        P: Record Item;
        REFCONFOR: Code[20];
        LDP: Record "Item Journal Line";
        CANTIDECI: Decimal;
        KILOSDECI: Decimal;
        NL: Decimal;
        TiendaFichero: Code[10];
        FechaFichero: Code[10];
        ExisAlma: Decimal;
        Exis: Decimal;
        Documento: Code[10];
        FechaDoc: Date;
        Dif: Decimal;
        Difmayor: Decimal;
        Fecha: Record Date;
        Dialo: Dialog;
        RecCuenta: Record "G/L Account";
        VentaC: Decimal;
        VentaMP: Decimal;
        MP: Record "Item Ledger Entry";
        ArchSalida: File;
        ArchExt: Text[30];
        Ascii: Boolean;
        Ventana: Dialog;
        CodDFecha: Date;
        CodHFecha: Date;
        TextoSalida: Text[250];
        Recproducto: Record Item;
        "RecAlmacén": Record Location;
        Importe: Decimal;
        RecIVA: Record "VAT Posting Setup";
        Dia: Code[2];
        Mes: Code[2];
        Dia1: Decimal;
        Mes1: Decimal;
        Ventana2: Dialog;
        opc: Integer;
        ArchExt1: Text[30];
        ArchExt2: Text[30];
        TextoSalida1: Text[250];
        TextoSalida2: Text[250];
        ArchSalida1: File;
        ArchSalida2: File;
        CodDTienda: Code[10];
        CodHTienda: Code[10];
        RecSDP: Record "Item Journal Batch";
        lin: Decimal;
        Rec83: Record "Item Journal Line";
        RecItem: Record Item;
        RecUMP: Record "Item Unit of Measure";
        STOCCAL: Decimal;
        RecItem2: Record Item;
        RecPP: Record "Purchase Price";
        Rec32: Record "Item Ledger Entry";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ACCION: Code[20];
        DCanti: Decimal;
        TIPO2: Integer;
        ITEM: Record Item;


    local procedure InitializeGlobals()
    var
        DataExchDef: Record "Data Exch. Def";
    begin
    end;

    local procedure CheckLineType()
    begin
        ValidateNonDataLine;
        TrackNonDataLines;
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



        REF := D3;

        ACCION := D4;



        Evaluate(DCanti, D5);

        lin := 10000;
        Rec83.Reset;
        Rec83.SetRange(Rec83."Journal Template Name", 'ELEMENTO');
        Rec83.SetRange(Rec83."Journal Batch Name", 'ADAIA');
        if Rec83.FindLast then begin
            lin := Rec83."Line No." + 10000;
        end;
        if ACCION = '+' then begin
            TIPO2 := 2;
        end;
        if ACCION = '-' then begin
            TIPO2 := 3;
        end;
        Item.Get(REF);
        if DCanti <> 0 then begin
            Rec83.Init;
            Rec83."Journal Template Name" := 'ELEMENTO';
            Rec83."Journal Batch Name" := 'ADAIA';
            Rec83."Line No." := lin;
            Rec83.Validate(Rec83."Item No.", REF);
            Rec83."Posting Date" := Today;
            Rec83.Validate(Rec83."Entry Type", TIPO2);
            Rec83.Validate(Rec83.Quantity, DCanti);
            Rec83."Document No." := 'AJUSTES';
            Rec83."Location Code" := 'SILLA';
            Rec83.Insert;
        end;


    end;





}

