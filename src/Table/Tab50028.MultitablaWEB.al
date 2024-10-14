#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50028 "Multitabla WEB"
{

    fields
    {
        field(1; Tabla; Option)
        {
            OptionCaption = 'ClasificaCliente,ClasificaProducto';
            OptionMembers = ClasificaCliente,ClasificaProducto;
        }
        field(2; "Codigo 1"; Code[20])
        {
        }
        field(3; "Código 2"; Code[20])
        {
            TableRelation = if (Tabla = const(ClasificaCliente)) Multitabla.Codigo where(Tabla = const("Clasificacion WEB"))
            else if (Tabla = const(ClasificaProducto)) Multitabla.Codigo where(Tabla = const("Clasificacion WEB"));
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
        }
        field(5; "Descripcion 2"; Text[70])
        {
            Editable = false;
        }
        field(10; "Minimum Quantity"; Decimal)
        {
            Caption = 'Minimum Quantity';
            MinValue = 0;
        }
        field(11; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(14; NETO; Boolean)
        {
        }
        field(15; Descuento; Decimal)
        {
        }
        field(50024; "ID WEB"; Integer)
        {
            CalcFormula = lookup(Multitabla."ID WEB" where(Codigo = field("Código 2"),
                                                            Tabla = const("Clasificacion WEB")));
            FieldClass = FlowField;
        }
        field(50025; "Por defecto"; Boolean)
        {
        }
        field(60000; "Actualizar WEB"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Tabla)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

