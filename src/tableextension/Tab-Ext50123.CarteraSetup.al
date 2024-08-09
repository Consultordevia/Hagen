tableextension 50123 CarteraSetup extends "Cartera Setup"
{
    fields
    {
        field(50000; "Serie agrupacion"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50001; "Contador descuento abonos"; Code[10])
        {
            TableRelation = "No. Series";
        }
    }
}
