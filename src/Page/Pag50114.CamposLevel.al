page 50114 CamposLevel
{
    ApplicationArea = All;
    Caption = 'CamposLevel';
    PageType = List;
    SourceTable = Item;
    UsageCategory = Lists;


    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the item.';
                }
                field(Level1; Rec.Level1)
                {
                    ToolTip = 'Specifies the value of the Level1 field.', Comment = '%';
                }
                field(Level2; Rec.Level2)
                {
                    ToolTip = 'Specifies the value of the Level2 field.', Comment = '%';
                }
                field(Level3; Rec.Level3)
                {
                    ToolTip = 'Specifies the value of the Level3 field.', Comment = '%';
                }
                field(Description;Rec.Description)
                {
                    ToolTip = 'Specifies the number of the item.';
                }
            }
        }
    }
}
