#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50027 "Multitabla DTOS"
{

    fields
    {
        field(1; Tabla; Option)
        {
            OptionCaption = 'Dtos';
            OptionMembers = Dtos;
        }
        field(2; Entero; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Codigo descuento"; Code[20])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const("Clasificacion WEB"));
        }
        field(4; "Descuento cabecera"; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                "Total descuento":="Descuento cabecera"+Descuento;
                "Dtos. cabecera":="Descuento cabecera";
                
                "Dtos. 2":=ROUND(Descuento/(100-"Descuento cabecera")*100,0.01);
                */

            end;
        }
        field(5; Descuento; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                "Total descuento":="Descuento cabecera"+Descuento;
                
                "Dtos. 2":=ROUND(Descuento/(100-"Descuento cabecera")*100,0.01);
                */

            end;
        }
        field(6; "Total descuento"; Decimal)
        {
        }
        field(7; "Dtos. cabecera"; Decimal)
        {
        }
        field(8; "Dtos. 2"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Tabla, Entero)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

