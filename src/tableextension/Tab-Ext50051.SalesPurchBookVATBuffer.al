tableextension 50051 SalesPurchBookVATBuffer extends "Sales/Purch. Book VAT Buffer"
{
    fields
    {
        field(50000; "Base Aduanas"; Decimal)
        {
        }
        field(50001; "Pais Importador"; Code[10])
        {
        }
        field(50002; DUA; Code[30])
        {
        }
        field(50003; "Fecha DUA"; Date)
        {
        }
        field(50004; "% IVA importación"; Decimal)
        {
        }
    }
}
