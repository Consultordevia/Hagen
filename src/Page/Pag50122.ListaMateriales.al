page 50122 ListaMateriales
{
    ApplicationArea = All;
    Caption = 'ListaMateriales';
    PageType = List;
    SourceTable = "BOM Component";
    UsageCategory = Lists;
    

 
 
 
 
 
 
 
 



    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Parent Item No."; Rec."Parent Item No.")
                {
                    ToolTip = 'Specifies the number of the assembly item that the assembly BOM component belongs to.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the assembly BOM component.';
                }
                field("Quantity per"; Rec."Quantity per")
                {
                    ToolTip = 'Specifies how many units of the component are required to produce or assemble the parent item.';
                }
                field("% descuento"; Rec."% descuento")
                {
                    ToolTip = 'Specifies the value of the % descuento field.', Comment = '%';
                }
                field(Desde; Rec.Desde)
                {
                    ToolTip = 'Specifies the value of the Desde field.', Comment = '%';
                }
                field(Hasta; Rec.Hasta)
                {
                    ToolTip = 'Specifies the value of the Hasta field.', Comment = '%';
                }
            }
        }
    }
}
