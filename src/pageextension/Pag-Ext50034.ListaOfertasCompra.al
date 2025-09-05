pageextension 50034 ListaOfertasCompra extends "Purchase Quotes"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Requested Receipt Date"; Rec."Requested Receipt Date") { ApplicationArea = All; }
            // field(Amount; Rec.Amount) { ApplicationArea = All; } // V27: is already defined in Page 'Purchase Quotes' by the extension 'Base Application by Microsoft 
            // field("Amount Including VAT"; Rec."Amount Including VAT") { ApplicationArea = All; } // v27: is already defined in Page 'Purchase Quotes' by the extension 'Base Application by Microsoft 
            field("Vendor Order No."; Rec."Vendor Order No.") { ApplicationArea = All; }

        }
    }
}
