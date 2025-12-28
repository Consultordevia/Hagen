page 50150 BonusMalos
{
    ApplicationArea = All;
    Caption = 'Bonus Malos';
    PageType = List;
    SourceTable = BonusMalos;
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
