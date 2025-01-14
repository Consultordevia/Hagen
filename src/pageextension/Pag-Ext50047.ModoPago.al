pageextension 50047 ModoPago extends "Payment Methods"
{
 layout
    {

        addafter(Description)
        {
            field("Pago anticipado";Rec."Pago anticipado") { ApplicationArea = All; }
            }
    }

}
