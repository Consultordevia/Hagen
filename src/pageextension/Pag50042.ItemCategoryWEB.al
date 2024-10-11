page 50042 ItemCategoryWEB
{
    ApplicationArea = All;
    Caption = 'ItemCategoryWEB';
    PageType = List;
    SourceTable = "Item Category";
    UsageCategory = Lists;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the code for the item category.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item category.';
                }
                field("Has Children"; Rec."Has Children")
                {
                    ToolTip = 'Specifies the value of the Has Children field.', Comment = '%';
                }
                field(Indentation; Rec.Indentation)
                {
                    ToolTip = 'Specifies the value of the Indentation field.', Comment = '%';
                }
                field("Last Modified Date Time"; Rec."Last Modified Date Time")
                {
                    ToolTip = 'Specifies the value of the Last Modified Date Time field.', Comment = '%';
                }
                field("Parent Category"; Rec."Parent Category")
                {
                    ToolTip = 'Specifies the item category that this item category belongs to. Item attributes that are assigned to a parent item category also apply to the child item category.';
                }
                field("Presentation Order"; Rec."Presentation Order")
                {
                    ToolTip = 'Specifies the value of the Presentation Order field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
            }
        }
    }
}
