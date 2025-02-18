pageextension 50049 BomComponent extends "Assembly BOM"
{
     layout
    {

        addafter(Position)
        {
             field("% descuento";Rec."% descuento") { ApplicationArea = All; }
             field(Desde;Rec.Desde) { ApplicationArea = All; }
             field(Hasta;Rec.Hasta) { ApplicationArea = All; }

        }
    }
}
