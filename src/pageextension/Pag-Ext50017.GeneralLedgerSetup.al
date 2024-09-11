pageextension 50017 "General Ledger Setup" extends "General Ledger Setup"
{
    layout
    {
        addlast(content)
        {
            group(Hagen)
            {
                field("Fecha recalculo ofertas"; Rec."Fecha recalculo ofertas") { ApplicationArea = All; }
                field("Margen necesario"; Rec."Margen necesario") { ApplicationArea = All; }
                field("Tarifa vigente"; Rec."Tarifa vigente") { ApplicationArea = All; }
                field("Desde fecha SII"; Rec."Desde fecha SII") { ApplicationArea = All; }
                field("Hasta fecha SII"; Rec."Hasta fecha SII") { ApplicationArea = All; }
                field("Desde Numero documento SII"; Rec."Desde Numero documento SII") { ApplicationArea = All; }
                field("Serie SII"; Rec."Serie SII") { ApplicationArea = All; }
                field("Hasta Numero documento SII"; Rec."Hasta Numero documento SII") { ApplicationArea = All; }
            }
        }
    }
}
