pageextension 50033 LineasFacturas extends "Purch. Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Analisis margenes"; Rec."Analisis margenes") { ApplicationArea = All; }
        }
    }
}
