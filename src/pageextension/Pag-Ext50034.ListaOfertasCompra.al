pageextension 50034 ListaOfertasCompra extends "Purchase Quotes"
{
     layout
    {
        addafter("Posting Date")
        {
            field("Requested Receipt Date";Rec."Requested Receipt Date") { ApplicationArea = All; }
            field(Amount;Rec.Amount) { ApplicationArea = All; }
            field("Amount Including VAT";Rec."Amount Including VAT") { ApplicationArea = All; }
            field("Vendor Order No.";Rec."Vendor Order No.") { ApplicationArea = All; }

        }
    }
}
