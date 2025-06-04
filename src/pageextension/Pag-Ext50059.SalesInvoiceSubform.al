pageextension 50059 SalesInvoiceSubform extends "Sales Invoice Subform"
{
     layout
    {
        addafter("Unit Price")
        {

            field( "Allow Line Disc.";Rec."Allow Line Disc.")
            { ApplicationArea = All; }

        }
        }
}
