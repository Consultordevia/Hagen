pageextension 50023 SalesLineDiscount extends "Sales Line Discounts"
{

    layout
    {



        addlast(content)
        {
            group(Hagen)
            {


                //field("Sales Code"; Rec."Sales Code") { ApplicationArea = All; }
                //field("Sales Type"; Rec."Sales Type") { ApplicationArea = All; }
                field("Descripción"; Rec."Descripción") { ApplicationArea = All; }
                field("Oferta de descuento"; Rec."Oferta de descuento") { ApplicationArea = All; }
                field("Vigente"; Rec.Vigente) { ApplicationArea = All; }
                field("Fecha alta"; Rec."Fecha alta") { ApplicationArea = All; }
                field("Producto padre"; Rec."Producto padre") { ApplicationArea = All; }
                field("Promocion"; Rec.Promocion) { ApplicationArea = All; }
                field("Fecha modif"; Rec."Fecha hora modif") { ApplicationArea = All; }
                field("Hora modif"; Rec."Hora modif") { ApplicationArea = All; }
                field("Fecha hora modif"; Rec."Fecha hora modif") { ApplicationArea = All; }
                field("Fecha hora modif web"; Rec."Fecha hora modif web") { ApplicationArea = All; }
                field("Pdte. Enviar a WEB"; Rec."Pdte. Enviar a WEB") { ApplicationArea = All; }




            }
        }

    }


}
