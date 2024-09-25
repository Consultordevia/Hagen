#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50005 "ADAIA_Alta del TRSTOART22"
{
    Caption = 'ADAIA_Ajustes adaia';
    Direction = Import;
    FieldSeparator = '|';
    Format = VariableText;
    TextEncoding = WINDOWS;
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            MinOccurs = Zero;
            tableelement("Payment Terms"; "Payment Terms")
            {
                AutoSave = false;
                XmlName = 'DataExchDocument';
                textelement(UNO1)
                {
                    Width = 255;
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

        WORKDATED := WorkDate;
        FechaFichero := Format(WORKDATED);
        RecSDP.Reset;
        RecSDP.SetRange(RecSDP."Journal Template Name", 'INVENT. FÍ');
        RecSDP.SetRange(RecSDP.Name, FechaFichero);
        if RecSDP.FindFirst then begin
            Rec83.Reset;
            Rec83.SetRange(Rec83."Journal Template Name", RecSDP."Journal Template Name");
            Rec83.SetRange(Rec83."Journal Batch Name", RecSDP.Name);
            if Rec83.Find('-') then begin
                Rec83.DeleteAll;
            end;
        end;

        if not RecSDP.FindFirst then begin
            RecSDP."Journal Template Name" := 'INVENT. FÍ';
            RecSDP.Name := FechaFichero;
            RecSDP.Description := 'INVENTARIO ' + FechaFichero;
            RecSDP.Insert;

        end;


        /*
        
        RecItem.RESET;
        RecItem.SETRANGE(RecItem.Blocked,FALSE);
        IF RecItem.FINDFIRST THEN REPEAT
             ItemUnitofMeasure.RESET;
             ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure."Item No.",RecItem."No.");
             ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure.Code,'UDS');
             IF NOT ItemUnitofMeasure.FINDFIRST THEN BEGIN
                  ItemUnitofMeasure.INIT;
                  ItemUnitofMeasure."Item No.":=RecItem."No.";
                  ItemUnitofMeasure.Code:='UDS';
                  ItemUnitofMeasure."Qty. per Unit of Measure":=1;
                  ItemUnitofMeasure.INSERT;
             END;
        
              RecItem2.GET(RecItem."No.");
              RecItem2.SETRANGE(RecItem2."Location Filter",'SILLA','SILLA');
              RecItem2.CALCFIELDS(RecItem2.Inventory);
              STOCCAL:=RecItem2.Inventory;
              Rec83.INIT;
              Rec83."Journal Template Name":='INVENT. FÍ';
              Rec83."Journal Batch Name":=FechaFichero;
              lin:=lin+10000;
              Rec83."Line No.":=lin;
              Rec83."Phys. Inventory":=FALSE;
              Rec83.VALIDATE(Rec83."Item No.",RecItem."No.");
              Rec83."Phys. Inventory":=TRUE;
        
              Rec83."Location Code":='SILLA';
              Rec83."Posting Date":=TODAY;
              Rec83."Unit of Measure Code":=RecItem."Base Unit of Measure";
              Rec83.VALIDATE(Rec83."Qty. (Calculated)",STOCCAL);
              Rec83."Document No.":='AJUSTES';
              Rec83.INSERT;
              COMMIT;
        
        
        
        UNTIL RecItem.NEXT=0;
        */

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
        /*
        
        EVALUATE(CAN,CANTI);
        REF:=PROD;
        IF RecItem2.GET(REF) THEN BEGIN
             ItemUnitofMeasure.RESET;
             ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure."Item No.",REF);
             ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure.Code,'UDS');
             IF NOT ItemUnitofMeasure.FINDFIRST THEN BEGIN
                  ItemUnitofMeasure.INIT;
                  ItemUnitofMeasure."Item No.":=REF;
                  ItemUnitofMeasure.Code:='UDS';
                  ItemUnitofMeasure."Qty. per Unit of Measure":=1;
                  ItemUnitofMeasure.INSERT;
             END;
             Rec83.RESET;
             Rec83.SETRANGE(Rec83."Journal Template Name",'INVENT. FÍ');
             Rec83.SETRANGE(Rec83."Journal Batch Name",FechaFichero);
             Rec83.SETRANGE(Rec83."Item No.",REF);
             IF Rec83.FINDLAST THEN BEGIN
                  EVALUATE(CANTIDECI,CANTI);
                  Rec83.VALIDATE(Rec83."Qty. (Phys. Inventory)",Rec83."Qty. (Phys. Inventory)"+CAN);
                  Rec83.MODIFY;
                  COMMIT;
             END;
        END;
        */

    end;


    procedure ModifFecha()
    begin
    end;


    procedure grabapepe()
    begin
    end;
}

