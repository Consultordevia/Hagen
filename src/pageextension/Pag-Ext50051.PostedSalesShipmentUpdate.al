pageextension 50051 "Posted SalesShipmentUpdate" extends "Posted Sales Shipment - Update"
{

    layout
    {

        addafter("Package Tracking No.")
        {
            field("Numero segumiento"; Rec."Numero segumiento") { ApplicationArea = All; }
            field("Estado Expedicion"; Rec."Estado Expedicion") { ApplicationArea = All; }
            field("Observación para transporte"; Rec."Observación para transporte") { ApplicationArea = All; }
            field("Nº bultos"; Rec."Nº bultos")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    rec."Total bultos" := rec."Nº bultos" + rec."Nº Palets";
                end;
            }
            field("Nº Palets"; Rec."Nº Palets")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    rec."Total bultos" := rec."Nº bultos" + rec."Nº Palets";
                end;
            }
            field("Total bultos"; Rec."Total bultos") { ApplicationArea = All; Editable = False; }
            field("Total peso"; Rec."Total peso") { ApplicationArea = All; }
            field(ASN; Rec.ASN) { ApplicationArea = All; }
        }

    }
    actions
    {
    }


}
