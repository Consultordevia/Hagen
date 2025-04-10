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
        field(50062; "Tipo Factura SII"; Option)
        {
            OptionCaption = 'F1,F2';
            OptionMembers = F1,F2;
        }
        field(50176; "Permite fraccionar unidad de venta"; Boolean)
        {
        }
        field(50005; "No enviar excel"; Boolean)
        {
        }  
        field(50707; "Invoice Type"; Enum "SII Sales Invoice Type")
        {
            Caption = 'Invoice Type';
        }
        field(50708; "Cr. Memo Type"; Enum "SII Sales Credit Memo Type")
        {
            Caption = 'Cr. Memo Type';
        }
         field(50709; "Special Scheme Code"; Enum "SII Sales Special Scheme Code")
        {
            Caption = 'Special Scheme Code';
        }
        field(50711; "Correction Type"; Option)
        {
            Caption = 'Correction Type';
            OptionCaption = ' ,Replacement,Difference,Removal';
            OptionMembers = " ",Replacement,Difference,Removal;
            
        }
        field(50724; "Do Not Send To SII"; Boolean)
        {
            Caption = 'Do Not Send To SII';
        }
 
        
    }
}
