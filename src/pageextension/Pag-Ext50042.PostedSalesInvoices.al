pageextension 50042 PostedSalesInvoices extends "Posted Sales Invoices"
{
        layout
    {
        
        addafter("Posting Date")   
    {
        field("Your Reference";Rec."Your Reference") {ApplicationArea = All; }
        
    }
    }
}
