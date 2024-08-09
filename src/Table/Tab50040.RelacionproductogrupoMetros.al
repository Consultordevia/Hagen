#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50040 "Relacion producto-grupo Metros"
{


    fields
    {
        field(1; Producto; Code[20])
        {
            TableRelation = Item;
        }
        field(2; Metros; Decimal)
        {
        }
        field(3; "Grupo Cliente"; Code[20])
        {
            TableRelation = Multitabla.Código where(Tabla = const("Grupo de clientes"));
        }
    }

    keys
    {
        key(Key1; Producto, "Grupo Cliente")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

