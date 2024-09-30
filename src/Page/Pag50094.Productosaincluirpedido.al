#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50094 "Productos a incluir pedido"
{
    PageType = List;
    SourceTable = "Productos a añaidr a pedido";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Producto;Rec.Producto)
                {
                    ApplicationArea = Basic;
                }
                field(Descripcion;Rec.Descripcion)
                {
                    ApplicationArea = Basic;
                }
                field("Fecha inicio";Rec."Fecha inicio")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha fin";Rec."Fecha fin")
                {
                    ApplicationArea = Basic;
                }
                field(Cantidad;Rec.Cantidad)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

