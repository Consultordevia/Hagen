#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50000 "Relación comisiones"
{

    fields
    {
        field(1; Vendedor; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin

                /////CALCFIELDS("Nombre vendedor");
            end;
        }
        field(2; "Desde Fecha"; Date)
        {
        }
        field(3; "Hasta Fecha"; Date)
        {
        }
        field(7; Producto; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                /////CALCFIELDS("Nombre producto");
                /////RecItem.GET(Producto);
            end;
        }
        field(8; "Comisión %"; Decimal)
        {
        }
        field(9; "Nombre vendedor"; Text[50])
        {
            CalcFormula = lookup("Salesperson/Purchaser".Name where(Code = field(Vendedor)));
            FieldClass = FlowField;
        }
        field(11; "Nombre producto"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field(Producto)));
            FieldClass = FlowField;
        }
        field(12; "Línea"; Code[10])
        {
            Enabled = false;
            TableRelation = "Gen. Product Posting Group";
        }
        field(16; Cliente; Code[10])
        {
            TableRelation = Customer;
        }
        field(18; "Tiene comision colores"; Boolean)
        {
        }
        field(20; "Comisión % HAGEN"; Decimal)
        {
        }
        field(21; "Comisión % NO HAGEN"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Vendedor)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

