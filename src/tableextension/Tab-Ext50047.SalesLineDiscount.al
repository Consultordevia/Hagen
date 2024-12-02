tableextension 50047 SalesLineDiscount extends "Sales Line Discount"
{
    fields
    {
        field(50000; "Descripción"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Oferta de descuento"; Boolean)
        {
        }
        field(50002; Vigente; Boolean)
        {
        }
        field(50003; "Fecha alta"; DateTime)
        {
        }
        field(50004; "Producto padre"; Code[20])
        {
            CalcFormula = lookup(Item."Producto PADRE" where("No." = field(Code)));
            FieldClass = FlowField;
        }
        field(50005; Promocion; Boolean)
        {
        }
        field(50101; "Fecha modif"; Date)
        {
        }
        field(50102; "Hora modif"; Time)
        {
        }
        field(50103; "Fecha hora modif"; DateTime)
        {
        }
        field(50104; "Fecha hora modif web"; DateTime)
        {
        }
        field(50105; "Pdte. Enviar a WEB"; Boolean)
        {
        }
    }

    keys
    {
        key(Key50003; "Pdte. Enviar a WEB")
        {
        }
    }

    trigger OnBeforeInsert()
    begin
        "Fecha modif" := Today;
        "Hora modif" := Time;
        "Fecha hora modif" := CreateDatetime(Today, Time);
        "Fecha hora modif web" := CreateDatetime(0D, 0T);
        "Pdte. Enviar a WEB" := true;
    end;

    trigger OnBeforeModify()
    begin
        "Fecha modif" := Today;
        "Hora modif" := Time;
        "Fecha hora modif" := CreateDatetime(Today, Time);
        "Fecha hora modif web" := CreateDatetime(0D, 0T);
        "Pdte. Enviar a WEB" := true;
    end;
}
