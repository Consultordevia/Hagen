page 50001 "Rutas Procesos"
{
    ApplicationArea = All;
    Caption = 'Rutas Procesos';
    PageType = List;
    SourceTable = adaia;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Proceso; Rec.texto)
                {
                    ToolTip = 'Specifies the value of the Proceso field.', Comment = '%';
                }
                field(Ruta; Rec.Ruta)
                {
                    ToolTip = 'Specifies the value of the Ruta field.', Comment = '%';
                }
            }
        }
    }
}
