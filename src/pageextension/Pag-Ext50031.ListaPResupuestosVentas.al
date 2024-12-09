pageextension 50031 ListaAlbVenta extends "Posted Sales Shipments"
{
layout
    {

        addafter("Posting Date")
        {

            
        field("Your Reference";Rec."Your Reference") { ApplicationArea = All; }
        }
    }

}
