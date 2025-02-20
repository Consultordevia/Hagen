pageextension 50042 PostedSalesInvoices extends "Posted Sales Invoices"

{


    layout


    {



        addafter("Posting Date")
        {
            field("Your Reference"; Rec."Your Reference") { ApplicationArea = All; }
            field("Nº expedición"; Rec."Nº expedición") { ApplicationArea = All; }
            field("Nº expedición dropshp"; Rec."Nº expedición dropshp") { ApplicationArea = All; }
            field("EDI factueas enviar"; Rec."EDI factueas enviar") { ApplicationArea = All; }
            field("EDI factueas enviado"; Rec."EDI factueas enviado") { ApplicationArea = All; }
            field("EDI Facturas Fecha enviado"; Rec."EDI Facturas Fecha enviado") { ApplicationArea = All; }
            ///field(COSTEFAC; COSTEFAC) { ApplicationArea = All; }
            ///field(margen; margen) { ApplicationArea = All; }


        }

    }


    actions
    {
        addlast(navigation)
        {

            action(MarcaCanarias)
            {

                ApplicationArea = Suite;
                Caption = 'MarcaCanarias';
                ShortCutKey = 'F9';
                trigger OnAction()
                var

                    CUAC: Codeunit "Automaticos Cartas";


                begin


                    CUAC.ModifCanarias(Rec);


                end;
            }

            action(EDICOMFacturas)
            {

                ApplicationArea = Suite;
                Caption = 'EDICOM Facturas';
                ShortCutKey = 'F9';
                trigger OnAction()
                var
                    AutomaticosEDICOM: Codeunit "Automaticos EDICOM facturas";

                begin

                    AutomaticosEDICOM.GrabaEDICOM(Rec."No.");


                end;
            }
            action(EDICOMAlbaran)
            {

                ApplicationArea = Suite;
                Caption = 'EDICOM Albaran';
                ShortCutKey = 'F9';
                trigger OnAction()
                var
                    AutomaticosEDICOMalb: Codeunit "Automaticos EDICOM albaran";

                begin



                    AutomaticosEDICOMalb.GrabaEDICOM(Rec."No.");


                end;
            }




            ///AutomaticosEDICOMalbaran.GrabaEDICOM("No.");


        }


    }



    trigger OnAfterGetRecord()
    var
        RecPMP: Record "Inventario PMP";
        PMP: Decimal;
        Margen: Decimal;
        COSTEFAC: Decimal;
        margenlin: Decimal;
        CUANTALIN: Decimal;
        imptarifa: Decimal;
        SUMA: Boolean;
        SUMAPB: Decimal;
        SUMAPF: Decimal;
        sumaventas: Decimal;
        sumacostes: Decimal;
        portescobrados: Decimal;
        Rec113: Record "Sales Invoice Line";
        DATOSCOSTE: Decimal;
        esmedia: Decimal;


    begin

        Rec113.Reset;
        Rec113.SetCurrentKey("Document No.", Type);
        Rec113.SetRange(Rec113."Document No.", Rec."No.");
        Rec113.SetRange(Rec113.Type, 2);
        if Rec113.Findset then
            repeat
                if Rec113."No." = 'TRAN' then begin
                    portescobrados := Rec113.Amount;
                end;
                SUMA := true;
                if (Rec113."Line Discount %" = 100) and (Rec113.Regalo = false) then begin
                    SUMA := false;
                end;
                if SUMA then begin
                    if Rec113."Precio base" <> 0 then begin
                        SUMAPB := SUMAPB + Rec113.Quantity * Rec113."Precio base";
                    end;
                    if Rec113."Precio base" = 0 then begin
                        SUMAPB := SUMAPB + Rec113.Quantity * Rec113."Unit Price";
                    end;
                    SUMAPF := SUMAPF + Rec113.Amount;
                end;
                CUANTALIN := CUANTALIN + 1;

                pmp := Rec113."Unit Cost (LCY)";
                PMP := 0;
                RecPMP.RESET;
                RecPMP.SETCURRENTKEY(RecPMP."Item No.", RecPMP."Posting Date");
                RecPMP.SETRANGE(RecPMP."Item No.", rec113."No.");
                RecPMP.SETRANGE(RecPMP."Posting Date", 0D, Rec113."Posting Date");
                IF RecPMP.FINDLAST THEN BEGIN
                    PMP := RecPMP."Unit Cost";
                END;

                if Rec113."VAT Base Amount" <> 0 then begin
                    margenlin := margenlin + (100 - (100 * (PMP * Rec113.Quantity) / (Rec113."VAT Base Amount")));
                end;
                sumaventas := sumaventas + Rec113."VAT Base Amount";
                DATOSCOSTE := pmp;
                sumacostes := sumacostes + DATOSCOSTE * Rec113.Quantity;
                COSTEFAC := COSTEFAC + DATOSCOSTE * Rec113.Quantity;
            until Rec113.Next = 0;
        Rec.CalcFields(Amount);
        if Rec.Amount <> 0 then begin
            Margen := ROUND((Rec.Amount - COSTEFAC) / Rec.Amount * 100, 0.01);
        end;
        Rec113.Reset;
        Rec113.SetCurrentKey("Document No.", Type);
        Rec113.SetRange(Rec113."Document No.", Rec."No.");
        Rec113.SetRange(Rec113.Type, 1);
        if Rec113.Findset then begin
            if Rec113."No." = '62400000' then begin
                portescobrados := Rec113.Amount;
            end;
        end;
    end;

}
