#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50087 "Lineas de pedidos"
{
    PageType = List;
    SourceTable = "Lineas AMAZON Pedidos";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(conta;Rec.conta)
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field("Numero de pedido";Rec."Numero de pedido")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field("Id. externo";Rec."Id. externo")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field(Modelo;Rec.Modelo)
                {
                    ApplicationArea = Basic;
                }
                field(ASIN;Rec.ASIN)
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field(Descripcion;Rec.Descripcion)
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field(Precio;Rec.Precio)
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field(Descuento;Rec.Descuento)
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field(Coste;Rec.Coste)
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field("Cantidad  Pedida";Rec."Cantidad  Pedida")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field("Cantidad Servida";Rec."Cantidad Servida")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Refresca)
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Refresh;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin


                    LineasAMAZONPedidos.Reset;
                    if LineasAMAZONPedidos.FindFirst then repeat
                        SalesHeader.Reset;
                        SalesHeader.SetRange(SalesHeader."Document Type",SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Your Reference",LineasAMAZONPedidos."Numero de pedido");
                        if SalesHeader.FindFirst then begin
                            Item.Reset;
                            Item.SetRange("Ref. AMAZON",LineasAMAZONPedidos.ASIN);
                            if Item.FindFirst then begin
                                SalesLine.Reset;
                                SalesLine.SetRange(SalesLine."Document Type",SalesHeader."Document Type");
                                SalesLine.SetRange(SalesLine."Document No.",SalesHeader."No.");
                                /// SalesLine.SETRANGE(ean,COPYSTR(LineasAMAZONPedidos."Id. externo",2));
                                SalesLine.SetRange("No.",Item."No.");
                                if SalesLine.FindFirst then begin
                                    LineasAMAZONPedidos."Cantidad Servida":=SalesLine.Quantity;
                                    LineasAMAZONPedidos.Modify;
                                end;
                            end;
                        end;
                    until LineasAMAZONPedidos.Next=0;
                    Message('hecho.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        color:='';
        if Rec."Cantidad Servida"=0 then begin
          color:='Unfavorable';
        end;
    end;

    var
        LineasAMAZONPedidos: Record "Lineas AMAZON Pedidos";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        color: Text;
        Item: Record Item;
}

