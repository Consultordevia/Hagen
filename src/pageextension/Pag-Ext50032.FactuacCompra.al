pageextension 50032 FactuacCompra extends "Purchase Invoice"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Posting No."; Rec."Posting No.") { ApplicationArea = All; }
            field("Posting No. Series"; Rec."Posting No. Series") { ApplicationArea = All; }
        }
        addafter("Area")
        {

            field(DUA; Rec.DUA) { ApplicationArea = All; }
            field("Fecha dua"; Rec."Fecha dua") { ApplicationArea = All; }
            field("Código importación";Rec."Código importación") { ApplicationArea = All; }

        }
    }
}
