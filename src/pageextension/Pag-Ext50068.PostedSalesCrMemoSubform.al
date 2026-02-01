pageextension 50068 PostedSalesCrMemoSubform extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Clasificación Comercial"; Rec."Clasificación Comercial")
            {
                ApplicationArea = all;
            }
        }
    }
}
