page 50147 EscaladoComercial
{
    ApplicationArea = All;
    Caption = 'Escalado Comercial';
    PageType = List;
    SourceTable = EscaladoComercial;
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


                field(Desde; Rec.Desde)
                {
                    ToolTip = '', Comment = '';
                }
                field(Hasta; Rec.Hasta)
                {
                    ToolTip = '', Comment = '';
                }
                field(Comision; Rec.Comision)
                {
                    ToolTip = '', Comment = '';
                }
            }
        }
    }
}
