#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50103 Promociones
{
    PageType = List;
    SourceTable = Promociones;

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
                field("Sales Code";Rec."Sales Code")
                {
                    ApplicationArea = Basic;
                }
                field("Producto regalo";Rec."Producto regalo")
                {
                    ApplicationArea = Basic;
                }
                field("Starting Date";Rec."Starting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Line Discount %";Rec."Line Discount %")
                {
                    ApplicationArea = Basic;
                }
                field("Grupo clientes";Rec."Grupo clientes")
                {
                    ApplicationArea = Basic;
                }
                field("Sales Type";Rec."Sales Type")
                {
                    ApplicationArea = Basic;
                }
                field(Cliente;Rec.Cliente)
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Quantity";Rec."Minimum Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Cantiada a regalar";Rec."Cantiada a regalar")
                {
                    ApplicationArea = Basic;
                }
                field("Ending Date";Rec."Ending Date")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha alta";Rec."Fecha alta")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha modif";Rec."Fecha modif")
                {
                    ApplicationArea = Basic;
                }
                field("Hora modif";Rec."Hora modif")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha hora modif";Rec."Fecha hora modif")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha hora modif web";Rec."Fecha hora modif web")
                {
                    ApplicationArea = Basic;
                }
                field("Pdte. Enviar a WEB";Rec."Pdte. Enviar a WEB")
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

