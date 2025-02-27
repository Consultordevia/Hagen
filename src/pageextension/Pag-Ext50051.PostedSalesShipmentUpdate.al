pageextension 50051 "Posted SalesShipmentUpdate" extends "Posted Sales Shipment - Update"
{
    
    layout
    {

        addafter("Package Tracking No.")
        {
            field("Numero segumiento";Rec."Numero segumiento") { ApplicationArea = All; }
            field("Estado Expedicion";Rec."Estado Expedicion") { ApplicationArea = All; }



        }
    }
}
