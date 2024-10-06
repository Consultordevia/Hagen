#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50025 "Cajas por envio"
{

    fields
    {
        field(1; Nfac; Code[20])
        {
        }
        field(2; nlin; Integer)
        {
        }
        field(3; Producto; Code[20])
        {
        }
        field(4; "Caja num"; Integer)
        {
        }
        field(5; Cantidad; Integer)
        {

            trigger OnValidate()
            begin


                suma := 0;
                Cajasporenvio.Reset;
                Cajasporenvio.SetRange(Nfac, Rec.Nfac);
                Cajasporenvio.SetRange(nlin, Rec.nlin);
                if Cajasporenvio.FindSet then
                    repeat
                        suma := suma + Cajasporenvio.Cantidad;
                    until Cajasporenvio.Next = 0;

                Rec.CalcFields("Cantidad incial");
                if suma + Rec.Cantidad > Rec."Cantidad incial" then begin
                    Error('Esta superando la cantidad enviada, enviada %1 y ya puestos %2', Rec."Cantidad incial", suma);
                end;
            end;
        }
        field(6; Descripcion; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field(Producto)));
            FieldClass = FlowField;
        }
        field(7; "Cantidad incial"; Decimal)
        {
            CalcFormula = lookup("Sales Invoice Line".Quantity where("Document No." = field(Nfac),
                                                                      "Line No." = field(nlin)));
            FieldClass = FlowField;
        }
        field(8; Envio; Code[20])
        {
        }
        field(9; SSCC; Code[30])
        {
        }
        field(10; "nº expedicion"; Code[20])
        {
        }
        field(11; "SSCC sin guiones"; Code[30])
        {
        }
        field(50020; Ean; Code[20])
        {
            CalcFormula = lookup("Sales Invoice Line".Ean where("Document No." = field(Nfac),
                                                                 "Line No." = field(nlin)));
            FieldClass = FlowField;
        }
        field(50021; "SSCC palet"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; Nfac, nlin, Producto, "Caja num")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        CreaSSCC;
        CreaSSCCpalet;
    end;

    trigger OnModify()
    begin

        CreaSSCCpalet;
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
        SalesInvoiceLine: Record "Sales Invoice Line";
        Cajasporenvio: Record "Cajas por envio";
        suma: Decimal;


    procedure CreaSSCC()
    begin




        NALBA := '';
        nalba2 := '';

        if SalesInvoiceLine.Get(Rec.Nfac, Rec.nlin) then begin
            if RecSSH.Get(SalesInvoiceLine."Shipment No.") then begin
                NALBA := CopyStr(RecSSH."Order No.", 3, 2) + CopyStr(RecSSH."Order No.", 6, 5);
                if StrLen(NALBA) < 7 then begin
                    NALBA := '0' + NALBA;
                end;
                if SalesInvoiceLine."Shipment No." = '' then begin
                    if REC112.Get(Rec.Nfac) then begin
                        NALBA := CopyStr(REC112."Order No.", 3, 2) + CopyStr(REC112."Order No.", 6, 5);
                        if StrLen(NALBA) < 7 then begin
                            NALBA := '0' + NALBA;
                        end;
                    end;
                end;
            end;

        end;


        ValueEntry.Reset;
        ValueEntry.SetRange(ValueEntry."Document No.", Rec.Nfac);
        ValueEntry.SetRange(ValueEntry."Document Line No.", Rec.nlin);
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

        if CopyStr(NALBA, 3, 2) = 'FV' then begin
            NALBA := CopyStr(NALBA, 1, 2) + CopyStr(NALBA, 6, 5);
        end;


        if CopyStr(NALBA, 3, 3) = 'ALB' then begin
            NALBA := CopyStr(NALBA, 1, 2) + CopyStr(NALBA, 9, 4) + '0';
        end;


        ///MESSAGE('%1 %2',Rec."Document No.",NALBA);
        NALBA := ConvertStr(NALBA, 'A', '0');
        NALBA := ConvertStr(NALBA, 'B', '0');
        NALBA := ConvertStr(NALBA, 'C', '0');
        NALBA := ConvertStr(NALBA, 'D', '0');
        NALBA := ConvertStr(NALBA, 'E', '0');
        NALBA := ConvertStr(NALBA, 'F', '0');
        NALBA := ConvertStr(NALBA, 'G', '0');
        NALBA := ConvertStr(NALBA, 'H', '0');
        NALBA := ConvertStr(NALBA, 'I', '0');
        NALBA := ConvertStr(NALBA, 'J', '0');
        NALBA := ConvertStr(NALBA, 'K', '0');
        NALBA := ConvertStr(NALBA, 'L', '0');
        NALBA := ConvertStr(NALBA, 'M', '0');
        NALBA := ConvertStr(NALBA, 'N', '0');
        NALBA := ConvertStr(NALBA, 'O', '0');
        NALBA := ConvertStr(NALBA, 'P', '0');
        NALBA := ConvertStr(NALBA, 'Q', '0');
        NALBA := ConvertStr(NALBA, 'R', '0');
        NALBA := ConvertStr(NALBA, 'S', '0');
        NALBA := ConvertStr(NALBA, 'T', '0');
        NALBA := ConvertStr(NALBA, 'U', '0');
        NALBA := ConvertStr(NALBA, 'V', '0');
        NALBA := ConvertStr(NALBA, 'W', '0');
        NALBA := ConvertStr(NALBA, 'X', '0');
        NALBA := ConvertStr(NALBA, 'Y', '0');
        NALBA := ConvertStr(NALBA, 'Z', '0');





        if StrLen(NALBA) < 7 then begin
            NALBA := '0' + NALBA;
        end;



        contador := NALBA + '00';


        if Rec."Caja num" < 10 then begin
            contador := NALBA + '0' + Format(Rec."Caja num");
        end;

        if Rec."Caja num" > 9 then begin
            contador := NALBA + Format(Rec."Caja num");
        end;

        contador := IncStr(contador);
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

        Rec.SSCC := CODSSCC2;
        Rec."SSCC sin guiones" := CopyStr(CODSSCC, 1, 4) + CopyStr(CODSSCC, 5, 4) + CopyStr(CODSSCC, 9, 4) + CopyStr(CODSSCC, 13, 4) + CopyStr(CODSSCC, 17, 4);
    end;


    procedure CreaSSCCpalet()
    begin




        NALBA := '';
        nalba2 := '';

        if SalesInvoiceLine.Get(Rec.Nfac, Rec.nlin) then begin
            if RecSSH.Get(SalesInvoiceLine."Shipment No.") then begin
                NALBA := CopyStr(RecSSH."Order No.", 3, 2) + CopyStr(RecSSH."Order No.", 6, 5);
                if StrLen(NALBA) < 7 then begin
                    NALBA := '0' + NALBA;
                end;
                if SalesInvoiceLine."Shipment No." = '' then begin
                    if REC112.Get(Rec.Nfac) then begin
                        NALBA := CopyStr(REC112."Order No.", 3, 2) + CopyStr(REC112."Order No.", 6, 5);
                        if StrLen(NALBA) < 7 then begin
                            NALBA := '0' + NALBA;
                        end;
                    end;
                end;
            end;

        end;


        ValueEntry.Reset;
        ValueEntry.SetRange(ValueEntry."Document No.", Rec.Nfac);
        ValueEntry.SetRange(ValueEntry."Document Line No.", Rec.nlin);
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

        if CopyStr(NALBA, 3, 2) = 'FV' then begin
            NALBA := CopyStr(NALBA, 1, 2) + CopyStr(NALBA, 6, 5);
        end;


        if CopyStr(NALBA, 3, 3) = 'ALB' then begin
            NALBA := CopyStr(NALBA, 1, 2) + CopyStr(NALBA, 9, 4) + '0';
        end;


        ///MESSAGE('%1 %2',Rec."Document No.",NALBA);
        NALBA := ConvertStr(NALBA, 'A', '0');
        NALBA := ConvertStr(NALBA, 'B', '0');
        NALBA := ConvertStr(NALBA, 'C', '0');
        NALBA := ConvertStr(NALBA, 'D', '0');
        NALBA := ConvertStr(NALBA, 'E', '0');
        NALBA := ConvertStr(NALBA, 'F', '0');
        NALBA := ConvertStr(NALBA, 'G', '0');
        NALBA := ConvertStr(NALBA, 'H', '0');
        NALBA := ConvertStr(NALBA, 'I', '0');
        NALBA := ConvertStr(NALBA, 'J', '0');
        NALBA := ConvertStr(NALBA, 'K', '0');
        NALBA := ConvertStr(NALBA, 'L', '0');
        NALBA := ConvertStr(NALBA, 'M', '0');
        NALBA := ConvertStr(NALBA, 'N', '0');
        NALBA := ConvertStr(NALBA, 'O', '0');
        NALBA := ConvertStr(NALBA, 'P', '0');
        NALBA := ConvertStr(NALBA, 'Q', '0');
        NALBA := ConvertStr(NALBA, 'R', '0');
        NALBA := ConvertStr(NALBA, 'S', '0');
        NALBA := ConvertStr(NALBA, 'T', '0');
        NALBA := ConvertStr(NALBA, 'U', '0');
        NALBA := ConvertStr(NALBA, 'V', '0');
        NALBA := ConvertStr(NALBA, 'W', '0');
        NALBA := ConvertStr(NALBA, 'X', '0');
        NALBA := ConvertStr(NALBA, 'Y', '0');
        NALBA := ConvertStr(NALBA, 'Z', '0');





        if StrLen(NALBA) < 7 then begin
            NALBA := '0' + NALBA;
        end;



        contador := NALBA + '00';


        if Rec."Caja num" < 10 then begin
            contador := NALBA + '0' + Format('0');
        end;

        if Rec."Caja num" > 9 then begin
            contador := NALBA + Format('0');
        end;

        contador := IncStr(contador);
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


        Rec."SSCC palet" := CopyStr(CODSSCC, 1, 4) + CopyStr(CODSSCC, 5, 4) + CopyStr(CODSSCC, 9, 4) + CopyStr(CODSSCC, 13, 4) + CopyStr(CODSSCC, 17, 4);
    end;
}

