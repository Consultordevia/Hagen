reportextension 50103 StandardSalesOrderConf extends "Standard Sales - Order Conf."
{
    WordLayout = './Layouts/StandardSalesOrderConf.docx';

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
