tableextension 50007 SalesCommentLine extends "Sales Comment Line"
{
    fields
    {
        field(50005; "Usuario alta"; Code[30])
        {
        }
        field(50006; "Fecha alta"; Date)
        {
        }
        field(50007; "Hora alta"; Time)
        {
        }
        field(50008; "No se puede eliminar"; Boolean)
        {
        }
        field(50009; "existe 36"; Boolean)
        {
            CalcFormula = exist("Sales Header" where("Document Type" = field("Document Type"),
                                                      "No." = field("No.")));
            FieldClass = FlowField;
        }
    }
}
