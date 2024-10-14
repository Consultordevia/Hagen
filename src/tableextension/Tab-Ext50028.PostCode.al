tableextension 50028 "Post Code" extends "Post Code"
{
    fields
    {
        field(50000; "Zona Venta"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const("Zona de ventas"));

            trigger OnValidate()
            begin
                /*
                
                VENTANA.OPEN('#1####################');
                RecClie.RESET;
                RecClie.SETRANGE(RecClie."Post Code",Code);
                IF RecClie.FINDSET THEN REPEAT
                     VENTANA.UPDATE(1,RecClie."No.");
                     RecClie."Zona de ventas":="Zona Venta";
                     RecClie.MODIFY;
                UNTIL RecClie.NEXT=0;
                VENTANA.CLOSE;
                */

            end;
        }
        field(50001; Pais; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(50002; "Provincia shopyfi"; Code[20])
        {
        }
        field(50006; "Provincia shopyfi CALC"; Code[20])
        {
            CalcFormula = lookup(Area."Provincia shopyfi" where(Code = field("County Code")));
            FieldClass = FlowField;
        }
        field(50007; "Código provincia shopyfi"; Code[20])
        {
        }
    }
}
