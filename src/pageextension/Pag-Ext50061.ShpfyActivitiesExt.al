pageextension 50061 ShpfyActivitiesExt extends "Shpfy Activities"
{
    layout
    {
        addafter(ShopInfo)
        {
            cuegroup(CATIT)
            {
                field(TotalPedidosNoServidos; TotalPedidosNoServidos)
                {
                    ApplicationArea = all;
                    Caption = 'Pedidos no servidos';
                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                        pSales: Page "Pantalla almacen Pascual5";
                    begin
                        SalesHeader.SetRange("Grupo clientes", 'G52');
                        SalesHeader.SetFilter("Estado pedido", '%1|%2|%3|%4',
                                SalesHeader."Estado pedido"::"Para preparar",
                                SalesHeader."Estado pedido"::"Pdte. comercial",
                                SalesHeader."Estado pedido"::"Pendiente stock",
                                SalesHeader."Estado pedido"::Retenido);
                        // SalesHeader.SetRange("Estado pedido", SalesHeader."Estado pedido"::"Para preparar", SalesHeader."Estado pedido"::"Pdte. comercial", SalesHeader."Estado pedido"::"Pendiente stock", SalesHeader."Estado pedido"::Retenido);
                        pSales.SetTableView(SalesHeader);
                        pSales.Run();
                    end;
                }
                field(TotalPedidosPtAsignarAdaia; TotalPedidosPtAsignarAdaia)
                {
                    ApplicationArea = all;
                    Caption = 'Pedidos Pte Asignar ADAIA';
                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                        pSales: Page "Pantalla almacen Pascual5";
                    begin
                        SalesHeader.SetRange("Grupo clientes", 'G52');
                        SalesHeader.SetRange("Nº expedición", '');
                        pSales.SetTableView(SalesHeader);
                        pSales.Run();
                    end;
                }
            }

        }
    }
    trigger OnOpenPage()
    var
    begin
        ContarPedidosCatit();
    end;

    trigger OnAfterGetRecord()
    var
    begin
        ContarPedidosCatit();
    end;

    procedure ContarPedidosCatit()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetRange("Grupo clientes", 'G52');
        SalesHeader.SetFilter("Estado pedido", '%1|%2|%3|%4',
            SalesHeader."Estado pedido"::"Para preparar",
            SalesHeader."Estado pedido"::"Pdte. comercial",
            SalesHeader."Estado pedido"::"Pendiente stock",
            SalesHeader."Estado pedido"::Retenido);
        // SalesHeader.SetFilter("Estado pedido", '<>%1', SalesHeader."Estado pedido"::Servido);
        TotalPedidosNoServidos := SalesHeader.Count();

        SalesHeader.Reset();
        SalesHeader.SetRange("Grupo clientes", 'G52');
        SalesHeader.SetRange("Nº expedición", '');
        TotalPedidosPtAsignarAdaia := SalesHeader.Count();
    end;

    var
        TotalPedidosNoServidos, TotalPedidosPtAsignarAdaia : Integer;
}
