#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50017 "Tarifas Transportistas"
{

    fields
    {
        field(1; Opcion; Option)
        {
            OptionMembers = Cabecera,Linea;
        }
        field(3; Transportista; Code[10])
        {
            TableRelation = "Shipping Agent";
        }
        field(4; Provincia; Text[50])
        {
            CalcFormula = lookup(Area.Text where(Code = field("Cod. provincia")));
            FieldClass = FlowField;
        }
        field(5; Poblacion; Text[30])
        {
        }
        field(6; Zona; Code[10])
        {
        }
        field(7; "Hasta Peso"; Decimal)
        {
        }
        field(8; Importe; Decimal)
        {
        }
        field(9; "Cod. provincia"; Code[10])
        {
            TableRelation = Area;
        }
    }

    keys
    {
        key(Key1; Opcion, Transportista, "Cod. provincia", Poblacion, Zona, "Hasta Peso")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

