#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50045 "Productos a añaidr a pedido"
{

    fields
    {
        field(1; Producto; Code[20])
        {
            TableRelation = Item;
        }
        field(2; Descripcion; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field(Producto)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Fecha inicio"; Date)
        {
        }
        field(4; "Fecha fin"; Date)
        {
        }
        field(5; Cantidad; Integer)
        {
        }
    }

    keys
    {
        key(Key1; Producto, "Fecha inicio", "Fecha fin")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

