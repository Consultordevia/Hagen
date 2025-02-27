#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50086 "Modifica albaran"
{
    PageType = Card;
    Permissions = TableData "Sales Shipment Header"=rim;
    SourceTable = "Sales Shipment Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sell-to Customer No.";Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sell-to Customer Name";Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Nº expedición";Rec."Nº expedición")
                {
                    ApplicationArea = Basic;
                }
                field("Your Reference";Rec."Your Reference")
                {
                    ApplicationArea = Basic;
                }
                field("Shipping Agent Code";Rec."Shipping Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field("Numero segumiento";Rec."Numero segumiento")
                {
                    ApplicationArea = Basic;
                }
                field("Importe transporte";Rec."Importe transporte")
                {
                    ApplicationArea = Basic;
                }
                field(ASN;Rec.ASN)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin

                        Rec.ASN:='ASN:'+Rec.ASN;
                    end;
                }
                field("Nº bultos";Rec."Nº bultos")
                {
                    ApplicationArea = Basic;
                }
                field("Nº Palets";Rec."Nº Palets")
                {
                    ApplicationArea = Basic;
                }
                field("Observación para transporte";Rec."Observación para transporte")
                {
                    ApplicationArea = Basic;
                }
                field("Estado Expedicion";Rec."Estado Expedicion")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha envio";Rec."Fecha envio")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha entrega";Rec."Fecha entrega")
                {
                    ApplicationArea = Basic;
                }
                field("Hora entrega";Rec."Hora entrega")
                {
                    ApplicationArea = Basic;
                }
                field("Total horas";Rec."Total horas")
                {
                    ApplicationArea = Basic;
                }
                
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Shipment")
            {
                Caption = '&Shipment';
                Image = Shipment;
                action("Co&mments")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Co&mments';
                    Ellipsis = true;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type"=const(Shipment),
                                  "No."=field("No.");
                    ToolTip = 'View or add comments for the record.';
                }
            }
        }
    }
}

