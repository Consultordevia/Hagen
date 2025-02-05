tableextension 50055 CustomerTempl extends "Customer Templ."
{
    fields
    {

        field(50000; "Search Name"; Code[50]) { }
        field(50001; "Name 2"; Text[50]) { }
        field(50003; "Tipo facturación"; Option)
        {
            OptionMembers = Diaria,Semanal,Mensual;
        }
        field(50004; "Grupo clientes"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const("Grupo de clientes"));
        }
        field(50005; "Email facturacion 1"; Text[60]) { }
        field(50006; "No incluir portes"; Boolean) { }
        field(50007; "No enviar cartas contables"; Boolean) { }
        field(50008; "Permite seguir adelante"; Boolean) { }
        field(50009; "Servicio email"; Boolean) { }
        field(50010; "Respeta Tipo facturacion"; Boolean) { }
         field(50062; "Tipo Factura SII"; Option)
        {
            OptionCaption = 'F1,F2';
            OptionMembers = F1,F2;
        }
    }
}
