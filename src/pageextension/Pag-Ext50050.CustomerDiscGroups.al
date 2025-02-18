pageextension 50050 CustomerDiscGroups extends "Customer Disc. Groups"
{
    layout
    {

        addafter(Description)
        {
            field("Descuento %"; Rec."Descuento %") { ApplicationArea = All; }



        }
    }

}
