pageextension 50060 "Sales&RelationshipMgr.RC" extends "Sales & Relationship Mgr. RC"
{
    layout
    {
        addbefore(Control56)
        {
            part("Shpfy Activities"; "Shpfy Activities")
            {
                ApplicationArea = All;
            }
        }
    }
}
