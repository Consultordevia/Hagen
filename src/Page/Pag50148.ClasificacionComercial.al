page 50148 ClasifiacionComercial
{
    ApplicationArea = All;
    Caption = 'Clasifiacion Comercial';
    PageType = List;
    SourceTable = ClasificacionComercial;
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


                field(Verde; Rec.Verde)
                {
                    ToolTip = '', Comment = '';
                }
                field(Azul; Rec.Azul)
                {
                    ToolTip = '', Comment = '';
                }
                field(Rojo; Rec.Rojo)
                {
                    ToolTip = '', Comment = '';
                }

            }
        }
    }
}
