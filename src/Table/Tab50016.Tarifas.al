#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50016 Tarifas
{

    fields
    {
        field(1;Tipo;Option)
        {
            OptionMembers = Familia,Producto;
        }
        field(2;"Grupo cliente";Code[10])
        {
            TableRelation = Multitabla.Código where (Tabla=const("Grupo de clientes"));
        }
        field(4;Producto;Code[20])
        {
            TableRelation = Item;
        }
        field(5;"Gurpo precios";Code[10])
        {
            TableRelation = "Customer Price Group";
        }
        field(6;Descuento;Decimal)
        {
        }
        field(7;Precio;Decimal)
        {
        }
        field(9;"Línea";Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(10;Desde;Date)
        {
        }
        field(11;Hasta;Date)
        {
        }
    }

    keys
    {
        key(Key1;Tipo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

