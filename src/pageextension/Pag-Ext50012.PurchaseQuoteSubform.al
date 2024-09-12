pageextension 50012 "Purchase Quote Subform" extends "Purchase Quote Subform"
{
    layout
    {
        addbefore("Qty. Assigned")
        {


            field("Cantidad a pasar"; Rec."Cantidad a pasar") { ApplicationArea = All; }
            field("Pedido compra"; Rec."Pedido compra") { ApplicationArea = All; }

        }
    }

}
