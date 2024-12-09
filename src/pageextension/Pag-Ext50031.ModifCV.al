pageextension 50031 ModifCV extends "Sales Orders"
{
 layout
    {

        addafter("No.")
        {

            
field( "Usuario alta";Rec."Usuario alta") { ApplicationArea = All; } 
        }
}
}