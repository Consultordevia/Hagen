pageextension 50009 "Posted Sales Shipment" extends "Posted Sales Shipments"
{

    layout
    {
        addafter("Location Code")
        {
            field("Nº expedición"; Rec."Nº expedición") { ApplicationArea = All; }
            field("Nº expedición agrupada"; Rec."Nº expedición agrupada") { ApplicationArea = All; }
            field("Nº expedición dropshp"; Rec."Nº expedición dropshp") { ApplicationArea = All; }




        }
    }
}
