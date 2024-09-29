page 50001 "Rutas Procesos"
{
    ApplicationArea = All;
    Caption = 'Rutas Procesos';
    PageType = List;
    SourceTable = adaia;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Proceso; Rec.Proceso)
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
