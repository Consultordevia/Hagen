page 50112 CustomerDiscountGroup
{
    ApplicationArea = All;
    Caption = 'Grupos descuentos';
    PageType = List;
    SourceTable = "Customer Discount Group";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies a code for the customer discount group.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description for the customer discount group.';
                }
                field("Descuento %"; Rec."Descuento %")
                {
                    ToolTip = 'Specifies the value of the Descuento % field.', Comment = '%';
                }
                field("Descuento % especial"; Rec."Descuento % especial")
                {
                    ToolTip = 'Specifies the value of the Descuento % especial field.', Comment = '%';
                }
                field("Codigo Shopify"; Rec."Codigo Shopify")
                {
                    ToolTip = 'Specifies the value of the Codigo Shopify field.', Comment = '%';
                }
            }
        }
    }
}
