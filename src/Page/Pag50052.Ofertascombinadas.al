#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50052 "Ofertas combinadas"
{
    AutoSplitKey = true;
    Caption = 'Ofertas combinadas';
    DataCaptionFields = "Document Type", "No.";
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Sales Comment Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the comment itself.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine;
    end;
}

