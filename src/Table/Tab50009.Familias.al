#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50009 Familias
{

    fields
    {
        field(1; "Línea"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(2; Familia; Code[30])
        {
        }
        field(3; Subfamilia; Code[30])
        {
        }
        field(4; Cod; Code[10])
        {
        }
        field(5; "Cod. web"; Integer)
        {
        }
        field(60000; "Actualizar WEB"; Boolean)
        {
        }
        field(60001; "Id PS Familia"; BigInteger)
        {
        }
        field(60002; "Id PS Subfamilia"; BigInteger)
        {
        }
    }

    keys
    {
        key(Key1; "Línea", Familia, Subfamilia)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

