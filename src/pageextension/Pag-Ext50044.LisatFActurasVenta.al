pageextension 50044 LisatFActurasVenta extends "Posted Sales Invoices"
{

    layout
    {

        addafter("Posting Date")
        {
            field(GLN; Rec.GLN) { ApplicationArea = All; }
            field(ImporteTarifaFull; ImporteTarifaFull) { ApplicationArea = All; }
            field(Diferencia; Diferencia) { ApplicationArea = All; }
            field(PORCENTAJE; PORCENTAJE) { ApplicationArea = All; }

        }
    }
    trigger OnAfterGetRecord()
    begin
        ImporteTarifaFull := 0;
        PORCENTAJE := 0;
        Rec113.Reset();
        Rec113.SetRange("Document No.", Rec."No.");
        Rec113.SetRange(Type, rec113.Type::Item);
        if Rec113.FindFirst() then
            repeat
                if Rec113."No." <> 'TRAN' THEN BEGIN
                    PriceListLine.reset;
                    PriceListLine.SetRange("Asset No.", Rec113."No.");
                    PriceListLine.SetRange("Source No.", Rec113."Customer Price Group");
                    IF PriceListLine.FindLast() THEN BEGIN
                        ImporteTarifaFull := ImporteTarifaFull + round(Rec113.Quantity * PriceListLine."Unit Price", 0.01);
                    END;
                END;
            until rec113.next = 0;
        Diferencia := Rec.Amount - ImporteTarifaFull;
        if ImporteTarifaFull <> 0 then begin
            PORCENTAJE := round(Diferencia * 100 / ImporteTarifaFull, 0.01);
        end;


    end;

    var

        ImporteTarifaFull: Decimal;
        PriceListLine: Record "Price List Line";
        Rec113: Record "Sales Invoice Line";
        PORCENTAJE: Decimal;
        Diferencia: Decimal;
}

