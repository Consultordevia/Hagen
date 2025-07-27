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


        }


        addafter(Description)
        {



            field("Cód. arancelario"; Rec."Cód. arancelario")
            { ApplicationArea = All; }

            field("IVA IGIC"; Rec."IVA IGIC")
            { ApplicationArea = All; }
            field("IVA IGIC2"; Rec."IVA IGIC2")
            { ApplicationArea = All; }


        }
    }
}

