page 50119 SeccionDiarioGeneral
{
    ApplicationArea = All;
    Caption = 'SeccionDiarioGeneral';
    PageType = List;
    SourceTable = "Gen. Journal Batch";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Journal Template Name"; Rec."Journal Template Name") { }
                field(Name; Rec.Name) { }
            }
        }
    }
}
