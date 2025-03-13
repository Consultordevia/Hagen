reportextension 50001 StandardSalesProFormaInv extends "Standard Sales - Pro Forma Inv"
{
    RDLCLayout = './src/ReportExtension/Layouts/StandardSalesProFormaInv.rdlc';
    dataset
    {

        add(Header)
        {
            column(PostingNo; "Posting No.") { }
        }
    }
}
