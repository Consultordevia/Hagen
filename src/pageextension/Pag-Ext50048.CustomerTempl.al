pageextension 50048 CustomerTempl extends "Customer Templ. Card"
{
    layout
    {


        addafter(Address)
        {


            field("Search Name"; Rec."Search Name") { ApplicationArea = All; }
            field("Name 2"; Rec."Name 2") { ApplicationArea = All; }
            field("Tipo facturación"; Rec."Tipo facturación") { ApplicationArea = All; }
            field("Grupo clientes"; Rec."Grupo clientes") { ApplicationArea = All; }
            field("Email facturacion 1"; Rec."Email facturacion 1") { ApplicationArea = All; }
            field("No incluir portes"; Rec."No incluir portes") { ApplicationArea = All; }
            field("No enviar cartas contables"; Rec."No enviar cartas contables") { ApplicationArea = All; }
            field("Permite seguir adelante"; Rec."Permite seguir adelante") { ApplicationArea = All; }
            field("Servicio email"; Rec."Servicio email") { ApplicationArea = All; }
            field("Respeta Tipo facturacion"; Rec."Respeta Tipo facturacion") { ApplicationArea = All; }
            field("Tipo Factura SII"; Rec."Tipo Factura SII") { ApplicationArea = All; }
            field("Permite fraccionar unidad de venta"; Rec."Permite fraccionar unidad de venta") { ApplicationArea = All; }



        }
    }
}
