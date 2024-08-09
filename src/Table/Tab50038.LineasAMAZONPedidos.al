#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50038 "Lineas AMAZON Pedidos"
{

    fields
    {
        field(1;conta;Integer)
        {
            AutoIncrement = true;
        }
        field(2;"Numero de pedido";Text[30])
        {
        }
        field(3;"Id. externo";Text[30])
        {
        }
        field(4;ASIN;Text[30])
        {
        }
        field(5;Descripcion;Text[250])
        {
        }
        field(6;Precio;Text[30])
        {
        }
        field(7;Descuento;Text[30])
        {
        }
        field(8;Coste;Text[30])
        {
        }
        field(9;"Cantidad  Pedida";Decimal)
        {
        }
        field(10;"Cantidad Servida";Decimal)
        {
        }
        field(11;Modelo;Text[30])
        {
        }
    }

    keys
    {
        key(Key1;conta,"Numero de pedido","Id. externo")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

