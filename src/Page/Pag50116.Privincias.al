page 50116 Privincias
{
    ApplicationArea = All;
    Caption = 'ProvinciasExcel';
    PageType = List;
    SourceTable = "Area";   
    
    UsageCategory = Lists;        
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies a code for the area.';
                }
                field("Text"; Rec."Text")
                {
                    ToolTip = 'Specifies a description of the area.';
                }
                field("Chequeo control provincia"; Rec."Chequeo control provincia")
                {
                    ToolTip = 'Specifies the value of the Chequeo control provincia field.', Comment = '%';
                }
                field(Comunidad; Rec.Comunidad)
                {
                    ToolTip = 'Specifies the value of the Comunidad field.', Comment = '%';
                }
                field("Id Estado PrestaShop"; Rec."Id Estado PrestaShop")
                {
                    ToolTip = 'Specifies the value of the Id Estado PrestaShop field.', Comment = '%';
                }
                field("Nombre comunidad"; Rec."Nombre comunidad")
                {
                    ToolTip = 'Specifies the value of the Nombre comunidad field.', Comment = '%';
                }
                field("Nombre comunidad G"; Rec."Nombre comunidad G")
                {
                    ToolTip = 'Specifies the value of the Nombre comunidad G field.', Comment = '%';
                }
                field("Pais PrestaShop"; Rec."Pais PrestaShop")
                {
                    ToolTip = 'Specifies the value of the Pais PrestaShop field.', Comment = '%';
                }
                field("Pais shopyfi"; Rec."Pais shopyfi")
                {
                    ToolTip = 'Specifies the value of the Pais shopyfi field.', Comment = '%';
                }
                field("Post Code Prefix"; Rec."Post Code Prefix")
                {
                    ToolTip = 'Specifies the prefix.';
                }
                field("Provincia shopyfi"; Rec."Provincia shopyfi")
                {
                    ToolTip = 'Specifies the value of the Provincia shopyfi field.', Comment = '%';
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
