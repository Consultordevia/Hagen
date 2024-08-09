tableextension 50110 CountryRegion extends "Country/Region"
{
    fields
    {
        field(50001; "Controla DC"; Boolean)
        {
        }
        field(50002; "Id Pais PrestaShop"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50003; "Cambiar Por"; Code[10])
        {
            Description = 'WEB';
            TableRelation = "Country/Region".Code;
        }
    }
}
