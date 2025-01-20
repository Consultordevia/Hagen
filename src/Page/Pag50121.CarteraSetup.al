page 50121 CarteraSetup
{
    ApplicationArea = All;
    Caption = 'CarteraSetup';
    PageType = List;
    SourceTable = "Cartera Setup";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Serie agrupacion";Rec."Serie agrupacion") { }
            }
        }
    }
}
