#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50004 adaia
{

    fields
    {
        field(1; texto; Code[250])
        {
            Caption = 'Proceso';
        }
        field(2; Ruta; Code[250])
        {
            Caption = 'Ruta';
        }
    }

    keys
    {
        key(Key1; texto)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

