#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50026 "Tipo caja"
{

    fields
    {
        field(1; "Tipo caja"; Code[10])
        {
        }
        field(2; "Maxino Tipo 1"; Decimal)
        {
        }
        field(3; "Maxino Tipo 2"; Decimal)
        {
        }
        field(4; "Maxino Tipo 3"; Decimal)
        {
        }
        field(5; "Maxino Tipo 4"; Decimal)
        {
        }
        field(6; "Maxino Tipo 5"; Decimal)
        {
        }
        field(7; "Maxino Tipo 6"; Decimal)
        {
        }
        field(8; "Maxino Tipo 0"; Decimal)
        {
        }
        field(9; Combinable; Boolean)
        {
        }
        field(10; "Maximo kilos"; Decimal)
        {
        }
        field(11; cabtidad; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Tipo caja")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

