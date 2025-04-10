page 50124 LogAdaiaPedidos
{
    ApplicationArea = All;
    Caption = 'LogAdaiaPedidos';
    PageType = ListPart;
    SourceTable = LogAdaiaPedidos;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Pedido; Rec.Pedido)
                {
                    ToolTip = 'Specifies the value of the Pedido field.', Comment = '%';
                }
                field(Linea; Rec.Linea)
                {
                    ToolTip = 'Specifies the value of the Linea field.', Comment = '%';
                }
                field(Producto; Rec.Producto)
                {
                    ToolTip = 'Specifies the value of the Producto field.', Comment = '%';
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ToolTip = 'Specifies the value of the Cantidad field.', Comment = '%';
                }
            }
        }
    }
}
