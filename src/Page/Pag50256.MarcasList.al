page 50256 "Marcas List"
{
    ApplicationArea = All;
    Caption = 'Marcas';
    CardPageId = "Marcas Card";
    PageType = List;
    SourceTable = Multitabla;
    SourceTableView = where(Tabla = const(Marcas));
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Codigo"; Rec."Codigo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Código de la marca.';
                }
                field("Descripcion"; Rec."Descripcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripción de la marca.';
                }
                field(Orden; Rec.Orden)
                {
                    ApplicationArea = All;
                    ToolTip = 'Orden de visualización.';
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                    ToolTip = 'Logo de la marca.';
                }
            }
        }
    }
}
