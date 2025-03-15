reportextension 50001 StandardSalesProFormaInv extends "Standard Sales - Pro Forma Inv"
{
    RDLCLayout = './src/ReportExtension/Layouts/StandardSalesProFormaInv.rdlc';
    dataset
    {

        add(Header)
        {
            column(PostingNo; "Posting No.") { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Name_2; "Ship-to Name 2") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_Post_Code; "Ship-to Post Code"+' '+"Ship-to City") { }             
            column(Ship_to_County; "Ship-to County") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
        }
    }
}
