reportextension 50104 StandardSalesQuote extends "Standard Sales - Quote"
{
    dataset
    {
    }

    trigger OnPreReport()
    begin
        Header.FilterGroup(4);
        Header.SetRange("Document Type");
        Header.FilterGroup(0);
    end;
}
