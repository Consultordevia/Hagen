pageextension 50062 LineasdeFactura extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter(Description)
        {

            field("Allow Line Disc."; Rec."Allow Line Disc.")
            { ApplicationArea = All; }
            field("Cód. arancelario"; Rec."Cód. arancelario")
            { ApplicationArea = All; }

        }
    }
}
