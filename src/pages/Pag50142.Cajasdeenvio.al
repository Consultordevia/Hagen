#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50142 "Cajas de envio"
{
    PageType = List;
    SourceTable = "Cajas por envio";

    layout
    {
        area(content)
        {
            field(Producto;Rec.Producto)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field(Descripcion;Rec.Descripcion)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Cantidad incial";Rec."Cantidad incial")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            repeater(Group)
            {
                field("Caja num";Rec."Caja num")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cantidad;Rec.Cantidad)
                {
                    ApplicationArea = Basic;
                }
                field(SSCC;Rec.SSCC)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

