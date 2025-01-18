page 50118 CodigosPostalesExcel
{
    ApplicationArea = All;
    Caption = 'CodigosPostalesExcel';
    PageType = List;
    SourceTable = "Post Code";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the postal code that is associated with a city.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the city linked to the postal code in the Code field.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region of the address.';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies a county name.';
                }
                field("County Code"; Rec."County Code")
                {
                    ToolTip = 'Specifies the county code of the customer''s payment address.';
                }
                field("Código provincia shopyfi"; Rec."Código provincia shopyfi")
                {
                    ToolTip = 'Specifies the value of the Código provincia shopyfi field.', Comment = '%';
                }
                field(Pais; Rec.Pais)
                {
                    ToolTip = 'Specifies the value of the Pais field.', Comment = '%';
                }
                field("Provincia shopyfi"; Rec."Provincia shopyfi")
                {
                    ToolTip = 'Specifies the value of the Provincia shopyfi field.', Comment = '%';
                }
                field("Provincia shopyfi CALC"; Rec."Provincia shopyfi CALC")
                {
                    ToolTip = 'Specifies the value of the Provincia shopyfi CALC field.', Comment = '%';
                }
                field("Search City"; Rec."Search City")
                {
                    ToolTip = 'Specifies the value of the Search City field.', Comment = '%';
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
                field("Time Zone"; Rec."Time Zone")
                {
                    ToolTip = 'Specifies the time zone for the selected post code.';
                }
                field("Zona Venta"; Rec."Zona Venta")
                {
                    ToolTip = 'Specifies the value of the Zona Venta field.', Comment = '%';
                }
            }
        }
    }
}
