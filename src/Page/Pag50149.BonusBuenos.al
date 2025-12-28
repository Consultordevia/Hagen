page 50149 BonusBuenos
{
    ApplicationArea = All;
    Caption = 'Bonus Buenos';
    PageType = List;
    SourceTable = BonusBuenos;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Vendedor; Rec.Vendedor)
                {
                    ToolTip = '', Comment = '';
                }
                field(NombreComercial; Rec.NombreComercial)
                {
                    ToolTip = '', Comment = '';
                    Editable = false;
                }


                field(Incremento; Rec.Incremento)
                {
                    ToolTip = '', Comment = '';
                }
                field(Aumento; Rec.Aumento)
                {
                    ToolTip = '', Comment = '';
                }
            }
        }
    }
}
