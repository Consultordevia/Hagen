#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50034 "Relacion Analisis_Cliente"
{

    fields
    {
        field(1;Codigo;Code[20])
        {
            TableRelation = "Grupos analisis";
        }
        field(2;Cliente;Code[20])
        {
        }
    }

    keys
    {
        key(Key1;Codigo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

