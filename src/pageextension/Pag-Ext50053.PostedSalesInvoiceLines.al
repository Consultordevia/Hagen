pageextension 50053 "Posted Sales Invoice Lines" extends "Posted Sales Invoice Lines"
{
    layout
    {
        addafter("Unit Cost (LCY)")
        {
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = All;
            }
            field("Cód. arancelario"; Rec."Cód. arancelario")
            {
                ApplicationArea = All;
            }

        }
    }
}
