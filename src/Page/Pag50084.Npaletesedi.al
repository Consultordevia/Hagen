#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50084 "Nº paletes edi"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = CardPart;
    Permissions = TableData "Sales Invoice Header"=rm;
    SourceTable = "Sales Invoice Header";

    layout
    {
        area(content)
        {
            field("No.";Rec."No.")
            {
                ApplicationArea = Basic;
                Enabled = false;
            }
            field("EDI Palets";Rec."EDI Palets")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }
}

