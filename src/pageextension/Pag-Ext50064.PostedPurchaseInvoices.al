pageextension 50064 PostedPurchaseInvoices extends "Posted Purchase Invoices"
{

    layout
    {
        addafter("Posting Date")
        {
            field(DUA; Rec.DUA)
            {
                ApplicationArea = all;

            }
            field("Código importación"; Rec."Código importación")
            {
                ApplicationArea = all;

            }
        }
    }
}
