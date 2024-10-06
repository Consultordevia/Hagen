#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50134 "Lineas EDI - ECI"
{

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sales Invoice Line";
    /////- SourceTableView = sorting("Posting Date");
    /////- order(descending)
    /////- where("Nº expedición ECI"=filter(<>""),
    /////- "Posting Date"=filter(01));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Nº expedición ECI"; Rec."Nº expedición ECI")
                {
                    ApplicationArea = Basic;
                }
                /////- field("Num expedicion";Rec."Num expedicion")
                /////-{
                /////-ApplicationArea = Basic;
                /////-Editable = false;
                /////-}
                field("REC112.""Your Reference"""; REC112."Your Reference")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nº pedido ECI';
                    Editable = false;
                }
                field(NALBA; NALBA)
                {
                    ApplicationArea = Basic;
                    Caption = 'Nº ALBARAN';
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Referencia HAGEN';
                    Editable = false;
                }
                field("RecItem.""Ref. hagen"""; RecItem."Ref. hagen")
                {
                    ApplicationArea = Basic;
                    Caption = 'Referencia ECI';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(contador; contador)
                {
                    ApplicationArea = Basic;
                    Caption = 'contador';
                    Editable = false;
                }
                field("REC112.""Order No."""; REC112."Order No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Pedido';
                    Editable = false;
                }
                field(SSCC; CODSSCC2)
                {
                    ApplicationArea = Basic;
                    Caption = 'SSCC';
                    Editable = false;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Etiqueta EDI")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin



                    SalesShipmentHeader.Reset;
                    SalesShipmentHeader.SetCurrentkey("Nº expedición");
                    /////- SalesShipmentHeader.SetFilter("Nº expedición",Rec."Num expedicion"+'*');
                    if SalesShipmentHeader.FindSet then
                        repeat
                            Clear(CU);
                            CU.ETIECI(SalesShipmentHeader);
                        until SalesShipmentHeader.Next = 0;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin



        NALBA := '';
        nalba2 := '';



        if REC112.Get(Rec."Document No.") then begin
            if RecSSH.Get(Rec."Shipment No.") then begin
                NALBA := CopyStr(RecSSH."Order No.", 3, 2) + CopyStr(RecSSH."Order No.", 6, 5);
                if StrLen(NALBA) < 7 then begin
                    NALBA := '0' + NALBA;
                end;
                if Rec."Shipment No." = '' then begin
                    if REC112.Get(Rec."Document No.") then begin
                        NALBA := CopyStr(REC112."Order No.", 3, 2) + CopyStr(REC112."Order No.", 6, 5);
                        if StrLen(NALBA) < 7 then begin
                            NALBA := '0' + NALBA;
                        end;
                    end;
                end;
            end;

        end;


        ValueEntry.Reset;
        ValueEntry.SetRange(ValueEntry."Document No.", Rec."Document No.");
        ValueEntry.SetRange(ValueEntry."Document Line No.", Rec."Line No.");
        if ValueEntry.FindFirst then begin
            NA := ValueEntry."Document No.";
            ValueEntry2.Reset;
            ValueEntry2.SetRange(ValueEntry2."Item Ledger Entry No.", ValueEntry."Item Ledger Entry No.");
            if ValueEntry2.FindFirst then begin
                NALBA := ValueEntry2."Document No.";
                NALNA2 := ValueEntry2."Document No.";
            end;

        end;


        if CopyStr(NALBA, 3, 2) = 'FV' then begin
            ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.");
            NALBA := ItemLedgerEntry."Document No.";
        end;



        ///MESSAGE('%1 %2',Rec."Document No.",NALBA);


        if StrLen(NALBA) < 7 then begin
            NALBA := '0' + NALBA;
        end;



        contador := NALBA + '00';

        RecItem.Init;
        if RecItem.Get(Rec."No.") then begin
        end;

        contador := NALBA + '00';
        Rec113.Reset;
        Rec113.SetRange(Rec113."Document No.", Rec."Document No.");
        Rec113.SetRange(Rec113.Type, 2);
        if Rec113.FindFirst then
            repeat

                if Rec113.Quantity <> 0 then begin

                    contador := IncStr(contador);
                    if Rec113."Line No." = Rec."Line No." then begin
                        NUEVA := '3' + '1973974' + contador;
                        XX := 0;
                        repeat
                            XX := XX + 1;
                            DIG1[XX] := CopyStr(NUEVA, XX, 1);
                            if (DIG1[XX] = '0') or
                               (DIG1[XX] = '1') or
                               (DIG1[XX] = '2') or
                               (DIG1[XX] = '3') or
                               (DIG1[XX] = '4') or
                               (DIG1[XX] = '5') or
                               (DIG1[XX] = '6') or
                               (DIG1[XX] = '7') or
                               (DIG1[XX] = '8') or
                               (DIG1[XX] = '9') then begin
                                Evaluate(DIG2[XX], DIG1[XX]);
                            end;
                        until XX = 17;
                        SUMA1 := DIG2[17] * 3 +
                               DIG2[16] * 1 +
                               DIG2[15] * 3 +
                               DIG2[14] * 1 +
                               DIG2[13] * 3 +
                               DIG2[12] * 1 +
                               DIG2[11] * 3 +
                               DIG2[10] * 1 +
                               DIG2[9] * 3 +
                               DIG2[8] * 1 +
                               DIG2[7] * 3 +
                               DIG2[6] * 1 +
                               DIG2[5] * 3 +
                               DIG2[4] * 1 +
                               DIG2[3] * 3 +
                               DIG2[2] * 1 +
                               DIG2[1] * 3;
                        SUMA2 := ROUND(SUMA1, 10, '>');
                        RESTO := SUMA2 - SUMA1;
                        DC := Format(RESTO);
                        CODSSCC := '003' + '1973974' + contador + DC;



                        CODSSCC2 := CopyStr(CODSSCC, 1, 4) + '-' +
                                  CopyStr(CODSSCC, 5, 4) + '-' +
                                  CopyStr(CODSSCC, 9, 4) + '-' +
                                  CopyStr(CODSSCC, 13, 4) + '-' +
                                  CopyStr(CODSSCC, 17, 4);

                    end;
                end;
            until Rec113.Next = 0;
    end;

    trigger OnClosePage()
    begin

        Rec.Reset;
    end;

    trigger OnOpenPage()
    begin



        ventana.Open('#1#########');
        REC1132.Reset;
        REC1132.SetCurrentkey("Customer Price Group", Quantity, "Document No.", "Nº expedición ECI");
        REC1132.SetFilter("Customer Price Group", 'ECI|BRICO');
        REC1132.SetFilter(Quantity, '<>0');
        REC1132.SetRange("Posting Date", 20181101D, Today);
        /////REC1132.SETRANGE(REC1132."Num expedicion",'A88675');
        REC1132.SetRange("Nº expedición ECI", '');
        if REC1132.FindSet then
            repeat
                ventana.Update(1, REC1132."Document No.");
                /////-REC1132.CalcFields(REC1132."Num expedicion");
                if REC11322.Get(REC1132."Document No.", REC1132."Line No.") then begin
                    /////-REC11322."Nº expedición ECI":=REC1132."Num expedicion";
                    REC11322.Modify;
                end;
            until REC1132.Next = 0;
        ventana.Close;
        Commit;
    end;

    var
        REC112: Record "Sales Invoice Header";
        RecItem: Record Item;
        CODSSCC: Code[23];
        NALBA: Code[20];
        contador: Code[20];
        NUEVA: Code[20];
        XX: Integer;
        DIG1: array[30] of Code[10];
        DIG2: array[30] of Decimal;
        SUMA1: Decimal;
        SUMA2: Decimal;
        RESTO: Decimal;
        DC: Code[10];
        Rec113: Record "Sales Invoice Line";
        CODSSCC2: Code[30];
        SalesShipmentHeader: Record "Sales Shipment Header";
        CU: Codeunit "Automaticos Cartas";
        nalba2: Code[10];
        RecSSH: Record "Sales Shipment Header";
        REC1132: Record "Sales Invoice Line";
        REC11322: Record "Sales Invoice Line";
        ventana: Dialog;
        ValueEntry: Record "Value Entry";
        ValueEntry2: Record "Value Entry";
        NALNA2: Code[20];
        NA: Code[20];
        ItemLedgerEntry: Record "Item Ledger Entry";
}

