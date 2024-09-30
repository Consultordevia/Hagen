#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50107 "Permitir pedido"
{
    PageType = List;
    SourceTable = "Multitabla 2";
    SourceTableView = sorting(Tabla)
                      where(Tabla=const("Permitir pedido"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Código 1";Rec."Código 1")
                {
                    ApplicationArea = Basic;
                }
                field("Descripcion 1";Rec."Descripcion 1")
                {
                    ApplicationArea = Basic;
                }
                field("Proveedor ref.";Rec."Proveedor ref.")
                {
                    ApplicationArea = Basic;
                }
                field("Estado Producto";Rec."Estado Producto")
                {
                    ApplicationArea = Basic;
                }
                field("Código 2";Rec."Código 2")
                {
                    ApplicationArea = Basic;
                }
                field("Descripcion 2";Rec."Descripcion 2")
                {
                    ApplicationArea = Basic;
                }
                field("Venta global";Rec."Venta global")
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad en pedido";Rec."Cantidad en pedido")
                {
                    ApplicationArea = Basic;
                }
                field("Venta diaria general";Rec."Venta diaria general")
                {
                    ApplicationArea = Basic;
                }
                field("Venta grupos";Rec."Venta grupos")
                {
                    ApplicationArea = Basic;
                }
                field("Venta diaria grupo";Rec."Venta diaria grupo")
                {
                    ApplicationArea = Basic;
                }
                field("Stock actual";Rec."Stock actual")
                {
                    ApplicationArea = Basic;
                }
                field("Para dias general";Rec."Para dias general")
                {
                    ApplicationArea = Basic;
                }
                field("Para dias grupos";Rec."Para dias grupos")
                {
                    ApplicationArea = Basic;
                }
                field(Reservar;Rec.Reservar)
                {
                    ApplicationArea = Basic;
                }
                field("No permite pedido";Rec."No permite pedido")
                {
                    ApplicationArea = Basic;
                }
                field("Pedido contenedor";Rec."Pedido contenedor")
                {
                    ApplicationArea = Basic;
                }
                field("Venta de contenedor";Rec."Venta de contenedor")
                {
                    ApplicationArea = Basic;
                }
                field("Dias para llegada";Rec."Dias para llegada")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha pedido contenedor";Rec."Fecha pedido contenedor")
                {
                    ApplicationArea = Basic;
                }
                field("Bloquear a dias";Rec."Bloquear a dias")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Recalcula)
            {
                ApplicationArea = Basic;
                Caption = 'Recalcula';
                Ellipsis = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    /////- Automaticos.PermitirPedidos;
                end;
            }
            action(Importacion)
            {
                ApplicationArea = Basic;
                Caption = 'Importacion';
                RunObject = Page "Multitabla 2";
            }
        }
    }

    var
        /////- Automaticos: Codeunit UnknownCodeunit50001;
}

