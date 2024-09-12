pageextension 50020 "Item List" extends "Item List"
{
    layout
    {
        addafter("Description 2")
        {
            field("Producto web"; Rec."Producto web")
            {
                ApplicationArea = All;
            }

        }
    }
}
