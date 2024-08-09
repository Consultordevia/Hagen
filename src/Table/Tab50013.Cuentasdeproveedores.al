#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50013 "Cuentas de proveedores"
{

    fields
    {
        field(1; Proveedor; Code[10])
        {
            TableRelation = Vendor;
        }
        field(2; Cuenta; Code[10])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                ///RecCuen.GET(Cuenta);
                ///"Descripcion cuenta":=RecCuen.Name;
            end;
        }
        field(3; "Descripcion cuenta"; Text[100])
        {
            CalcFormula = lookup("G/L Account".Name where("No." = field(Cuenta)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; contador; Integer)
        {
        }
    }

    keys
    {
        key(Key1; Proveedor, Cuenta, contador)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

