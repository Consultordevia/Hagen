pageextension 50012 "Purchase Quote Subform" extends "Purchase Quote Subform"
{
    layout
    {
        addbefore("Qty. Assigned")
        {


            field("Cantidad a pasar"; Rec."Cantidad a pasar") { ApplicationArea = All; }
            field("Pedido compra"; Rec."Pedido compra") { ApplicationArea = All; }
            field("Tariff No.";Rec."Tariff No.") { ApplicationArea = All; }
                        

        }
         addbefore(Quantity)
        {
              field("Fecha Lanzamiento";Rec."Fecha Lanzamiento" ) { ApplicationArea = All; }
        }
    }

}
