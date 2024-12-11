pageextension 50032 FactuacCompra extends "Purchase Invoice"
{
     layout
    {
        addafter("Posting Date")
        {
            field("Posting No.";Rec."Posting No." ) { ApplicationArea = All; }
        }}
}
