#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50011 "Familias catit"
{


    fields
    {
        field(1; "Familia Catit"; Code[30])
        {
        }
        field(2; "Subfamilia Catit"; Code[30])
        {
        }
        field(4; "ID Web"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Familia Catit", "Subfamilia Catit")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

