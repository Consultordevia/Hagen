tableextension 50015 GeneralLedgerSetup extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Fecha recalculo ofertas"; Date)
        {
        }
        field(50001; "Margen necesario"; Decimal)
        {
        }
        field(50002; "Tarifa vigente"; Code[20])
        {
            TableRelation = "Customer Price Group";
        }
        field(50003; "Desde fecha SII"; Date)
        {
        }
        field(50004; "Hasta fecha SII"; Date)
        {
        }
        field(50005; "Desde Numero documento SII"; Code[20])
        {
        }
        field(50006; "Serie SII"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50007; "Hasta Numero documento SII"; Code[20])
        {
        }
    }
}
