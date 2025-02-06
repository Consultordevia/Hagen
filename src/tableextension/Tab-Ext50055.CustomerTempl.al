tableextension 50055 CustomerTempl extends "Customer Templ."
{
    fields
    {

        field(50999; "Search Name"; Code[50]) { }
        field(50998; "Name 2"; Text[50]) { }
        field(50006; "Tipo facturación"; Option)
        {
            OptionMembers = Diaria,Semanal,Mensual;
        }
        field(50029; "Grupo clientes"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const("Grupo de clientes"));
        }
        field(50100; "Email facturacion 1"; Text[60])
        {
        }
        field(50056; "No incluir portes"; Boolean)
        {
        }
        field(50015; "No enviar cartas contables"; Boolean)
        {
            Caption = 'No enviar cartas contables';
        }
        field(50000; "Permite seguir adelante"; Boolean)
        {
        }
        field(50022; "Servicio email"; Boolean)
        {
        }
        field(50064; "Respeta Tipo facturacion"; Boolean)
        {
        }
    }
}
