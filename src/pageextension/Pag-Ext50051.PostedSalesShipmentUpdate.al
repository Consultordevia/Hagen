pageextension 50051 "Posted SalesShipmentUpdate" extends "Posted Sales Shipment - Update"
{

    layout
    {

        addafter("Package Tracking No.")
        {
            field("Numero segumiento"; Rec."Numero segumiento") { ApplicationArea = All; }
            field("Estado Expedicion"; Rec."Estado Expedicion") { ApplicationArea = All; }
            field("Total bultos"; Rec."Total bultos") { ApplicationArea = All; }
            field("Nº Palets"; Rec."Nº Palets") { ApplicationArea = All; }
            field("Total peso"; Rec."Total peso") { ApplicationArea = All; }
            field(ASN; Rec.ASN) { ApplicationArea = All; }
            field("Observación para transporte"; Rec."Observación para transporte") { ApplicationArea = All; }
        }

    }
    actions
    {
    }


}
