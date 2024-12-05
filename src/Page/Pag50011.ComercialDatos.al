#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50011 "Comercial Datos"
{
    Caption = 'Comercial Datos';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Sales Cue";

    layout
    {
        area(content)
        {
            cuegroup("For Release")
            {
                Caption = 'For Release';
                field("Mis Clientes"; MisClientes)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mis Clientes';

                    trigger OnDrillDown()
                    begin
                        /////-Clear(PageMisClientes);
                        /////-PageMisClientes.RunModal;
                    end;
                }
                field("Mis Posibles Clientes"; MisPosibles)
                {
                    ApplicationArea = Basic;
                    Caption = 'Mis Posibles Clientes';

                    trigger OnDrillDown()
                    begin
                        /////_Clear(PageMisPosiblesClientes);
                        /////-PageMisPosiblesClientes.RunModal;
                    end;
                }
                field("Mis Posibles Clientes WEB"; MisPosiblesWEB)
                {
                    ApplicationArea = Basic;
                    Caption = 'Mis Posibles Clientes WEB';

                    trigger OnDrillDown()
                    begin
                        /////-Clear(PageMisPosiblesClientesWEB);
                        /////-PageMisPosiblesClientesWEB.RunModal;
                    end;
                }
            }
            cuegroup(Control1)
            {
                Caption = 'For Release';
                field(Num_presupu; Num_presupu)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Presupuestos';
                    DrillDownPageID = "Sales Quotes";
                    ToolTip = 'Especifica el número de Presupuestos de venta que aún no se han convertido en pedidos.';

                    trigger OnDrillDown()
                    begin


                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Quote);
                        SalesHeader.SetRange(SalesHeader."Salesperson Code", UserSetup."Salespers./Purch. Code");
                        SalesHeader.SetRange("Estado presupuesto", SalesHeader."estado presupuesto"::Activo);
                        if SalesHeader.FindFirst then begin
                            Clear(ComercialPresupuestos);
                            /// ComercialPresupuestos.Def(0);
                            ComercialPresupuestos.SetTableview(SalesHeader);
                            ComercialPresupuestos.RunModal;
                        end;
                    end;
                }

                field(Nuevop; Nuevop)
                {
                    ApplicationArea = Basic;
                    Caption = 'Nuevo presupuesto';

                    trigger OnDrillDown()
                    begin

                        SalesReceivablesSetup.Get();

                        SalesHeader.Init;
                        SalesHeader."Document Type" := 0;
                        SalesHeader."No." := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Quote Nos.", Today, true);
                        codpedido := SalesHeader."No.";
                        SalesHeader.Insert;
                        Commit;
                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", 0);
                        SalesHeader.SetRange("No.", codpedido);
                        if SalesHeader.FindFirst then begin
                            Clear(NuevoPresu);
                            NuevoPresu.SetTableview(SalesHeader);
                            NuevoPresu.RunModal;
                        end;
                    end;
                }
            }
            cuegroup(Control7141752)
            {
                Caption = 'For Release';
                Visible = false;
                field("Pedidos Mes Actual"; MesActual)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pedidos Mes Actual';
                    ToolTip = 'Especifica el número de pedidos de venta del Mes Actual';
                    Visible = false;

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange(SalesHeader."Salesperson Code", UserSetup."Salespers./Purch. Code");
                        if SalesHeader.FindFirst then begin
                            Clear(ComercialPedidosMesActual);
                            ComercialPedidosMesActual.Def(0);
                            ComercialPedidosMesActual.SetTableview(SalesHeader);
                            ComercialPedidosMesActual.RunModal;
                        end;
                    end;
                }
                field("Pedidos Meses Anteriores"; Resto)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pedidos Meses Anteriores';
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Especifica el número de pedidos de venta Pedidos Meses Anteriores';
                    Visible = false;

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange(SalesHeader."Salesperson Code", UserSetup."Salespers./Purch. Code");
                        if SalesHeader.FindFirst then begin
                            Clear(ComercialPedidosMesActual);
                            ComercialPedidosMesActual.Def(1);
                            ComercialPedidosMesActual.SetTableview(SalesHeader);
                            ComercialPedidosMesActual.RunModal;
                        end;
                    end;
                }
            }
            cuegroup(Control7141751)
            {
                Caption = 'For Release';
                field("Pedidos - Retenidos"; PedidosRetenidos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pedidos - Retenidos';
                    ToolTip = 'Especifica el número de pedidos de venta Retenidos.';

                    trigger OnDrillDown()
                    begin
                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::Retenido);
                        if SalesHeader.FindFirst then begin
                            Clear(ComercialPedidosMesActual);
                            ComercialPedidosMesActual.Def(0);
                            ComercialPedidosMesActual.SetTableview(SalesHeader);
                            ComercialPedidosMesActual.RunModal;
                        end;
                    end;
                }
                field("Pedidos Pendiente Comercial"; PedidosPendieteComercial)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pedidos Pendiente Comercial';
                    ToolTip = 'Especifica el número de pedidos de venta Pendiente Comercial.';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Pdte. comercial");
                        if SalesHeader.FindFirst then begin
                            Clear(ComercialPedidosMesActual);
                            ComercialPedidosMesActual.Def(0);
                            ComercialPedidosMesActual.SetTableview(SalesHeader);
                            ComercialPedidosMesActual.RunModal;
                        end;
                    end;
                }
                field("Pedidos Para Preparar"; PedidosParaPreparar)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pedidos Para Preparar';
                    ToolTip = 'Especifica el número de pedidos de venta Para Preparar';

                    trigger OnDrillDown()
                    begin


                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        if SalesHeader.FindFirst then begin
                            Clear(ComercialPedidosMesActual);
                            ComercialPedidosMesActual.Def(0);
                            ComercialPedidosMesActual.SetTableview(SalesHeader);
                            ComercialPedidosMesActual.RunModal;
                        end;
                    end;
                }
                field(HistoricoAlbaranes; HiatoricoAlbaranes)
                {
                    ApplicationArea = Basic;
                    Caption = 'Historico Albaranes';
                    DrillDownPageID = "Posted Sales Shipments";
                    TableRelation = "Sales Shipment Header";

                    trigger OnDrillDown()
                    begin

                        SalesShipmentHeader.Reset;
                        SalesShipmentHeader.SetCurrentkey("Salesperson Code", "Posting Date");
                        SalesShipmentHeader.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
                        SalesShipmentHeader.SetRange(SalesShipmentHeader."Posting Date", desde, hasta);
                        if SalesShipmentHeader.FindFirst then begin
                            Clear(PostedSalesShipments);
                            PostedSalesShipments.SetTableview(SalesShipmentHeader);
                            PostedSalesShipments.RunModal;
                        end;
                    end;
                }
                field(PDTETRANF; PDTETRANF)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pendiente Transferencia';
                    DrillDownPageID = "Pantalla Almacen";
                    ToolTip = 'Especifica el número de Pedidos pendiente transferencia.';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::Retenido);
                        SalesHeader.SetFilter(SalesHeader."Payment Method Code", 'P.ANTICIPA|TRANSFWEB');
                        if SalesHeader.FindFirst then begin
                            Clear(ComercialPedidosMesActual);
                            ComercialPedidosMesActual.Def(0);
                            ComercialPedidosMesActual.SetTableview(SalesHeader);
                            ComercialPedidosMesActual.RunModal;
                        end;
                    end;
                }
            }
            cuegroup(Control7141749)
            {
                Caption = 'For Release';
                field(Impagados; ImpImpagados)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Impagados';

                    trigger OnDrillDown()
                    begin


                        CustLedgerEntry.Reset;
                        CustLedgerEntry.SetCurrentkey("Salesperson Code", Open, CustLedgerEntry."Category Code");
                        CustLedgerEntry.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
                        CustLedgerEntry.SetRange(Open, true);
                        CustLedgerEntry.SetRange("Category Code", 'IMPAGADO');
                        if CustLedgerEntry.FindSet then begin
                            Clear(MisImpagados);
                            MisImpagados.SetTableview(CustLedgerEntry);
                            MisImpagados.RunModal;
                        end;
                    end;
                }
                field("Saldo vencido"; SALDOVENCIDO)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Saldo vencido';

                    trigger OnDrillDown()
                    begin

                        CustLedgerEntry.Reset;
                        CustLedgerEntry.SetCurrentkey("Salesperson Code", Open, CustLedgerEntry."Category Code");
                        CustLedgerEntry.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
                        CustLedgerEntry.SetRange(Open, true);
                        CustLedgerEntry.SetFilter("Category Code", '<>IMPAGADO');
                        ///desde:=CALCDATE('-60D',TODAY);
                        ///desde:=20000101D;
                        ///hasta:=CALCDATE('-30D',TODAY);
                        CustLedgerEntry.SetRange(CustLedgerEntry."Due Date", 20000101D, diamenosuno);
                        if CustLedgerEntry.FindSet then begin
                            Clear(MisCobrosVencidos);
                            MisCobrosVencidos.SetTableview(CustLedgerEntry);
                            MisCobrosVencidos.RunModal;
                        end;
                    end;
                }
                field("Vencido -30 dias"; Hasta30)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vencido -30 dias';

                    trigger OnDrillDown()
                    begin


                        CustLedgerEntry.Reset;
                        CustLedgerEntry.SetCurrentkey("Salesperson Code", Open, CustLedgerEntry."Category Code");
                        CustLedgerEntry.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
                        CustLedgerEntry.SetRange(Open, true);
                        CustLedgerEntry.SetFilter("Category Code", '<>IMPAGADO');
                        desde := CalcDate('-60D', Today);
                        hasta := CalcDate('-30D', Today);
                        CustLedgerEntry.SetRange(CustLedgerEntry."Due Date", desde, hasta);
                        if CustLedgerEntry.FindSet then begin
                            Clear(MisCobrosVencidos);
                            MisCobrosVencidos.SetTableview(CustLedgerEntry);
                            MisCobrosVencidos.RunModal;
                        end;
                    end;
                }
                field("Vencido +30 dias"; Masde30)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vencido +30 dias';

                    trigger OnDrillDown()
                    begin


                        CustLedgerEntry.Reset;
                        CustLedgerEntry.SetCurrentkey("Salesperson Code", Open, CustLedgerEntry."Category Code");
                        CustLedgerEntry.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
                        CustLedgerEntry.SetRange(Open, true);
                        CustLedgerEntry.SetFilter("Category Code", '<>IMPAGADO');
                        desde := CalcDate('-60D', Today);
                        hasta := CalcDate('-30D', Today);
                        CustLedgerEntry.SetRange(CustLedgerEntry."Due Date", desde, hasta);
                        if CustLedgerEntry.FindSet then begin
                            Clear(MisCobrosVencidos);
                            MisCobrosVencidos.SetTableview(CustLedgerEntry);
                            MisCobrosVencidos.RunModal;
                        end;
                    end;
                }
                field("Vencido +60 dias"; Masde60)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vencido +60 dias';

                    trigger OnDrillDown()
                    begin


                        CustLedgerEntry.Reset;
                        CustLedgerEntry.SetCurrentkey("Salesperson Code", Open, CustLedgerEntry."Category Code");
                        CustLedgerEntry.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
                        CustLedgerEntry.SetRange(Open, true);
                        CustLedgerEntry.SetFilter("Category Code", '<>IMPAGADO');
                        desde := CalcDate('-90D', Today);
                        hasta := CalcDate('-61D', Today);
                        CustLedgerEntry.SetRange(CustLedgerEntry."Due Date", desde, hasta);
                        if CustLedgerEntry.FindSet then begin
                            Clear(MisCobrosVencidos);
                            MisCobrosVencidos.SetTableview(CustLedgerEntry);
                            MisCobrosVencidos.RunModal;
                        end;
                    end;
                }
                field("Vencido +90 dias"; Masde90)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vencido +90 dias';

                    trigger OnDrillDown()
                    begin


                        CustLedgerEntry.Reset;
                        CustLedgerEntry.SetCurrentkey("Salesperson Code", Open, CustLedgerEntry."Category Code");
                        CustLedgerEntry.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
                        CustLedgerEntry.SetRange(Open, true);
                        CustLedgerEntry.SetFilter("Category Code", '<>IMPAGADO');
                        desde := CalcDate('-5A', Today);
                        hasta := CalcDate('-91D', Today);
                        CustLedgerEntry.SetRange(CustLedgerEntry."Due Date", desde, hasta);
                        if CustLedgerEntry.FindSet then begin
                            Clear(MisCobrosVencidos);
                            MisCobrosVencidos.SetTableview(CustLedgerEntry);
                            MisCobrosVencidos.RunModal;
                        end;
                    end;
                }
            }
            cuegroup(Control7141754)
            {
                Caption = 'For Release';
                field(Productos; CuantosProductos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Productos';

                    trigger OnDrillDown()
                    begin

                        Clear(PagProductos);
                        PagProductos.RunModal;
                    end;
                }
            }
            cuegroup("Como voy?")
            {
                Caption = 'Como voy?';
                field(FacturadoMesAct; FacturadoMesAct)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Facturado Mes Actual';
                    DecimalPlaces = 0 : 0;
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Facturado Mes Actual';
                }
                field(FacturadoMesAnt; FacturadoMesAnt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Facturado Mes Anterior';
                    DecimalPlaces = 0 : 0;
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Facturado Mes Anterior';
                }
                field(Albaranado; Albaranado)
                {
                    ApplicationArea = Basic;
                    Caption = 'Albaranado pdt. facturar';
                    DecimalPlaces = 0 : 0;
                }
                field(Pedidos; pedidos)
                {
                    ApplicationArea = Basic;
                    Caption = 'Pedidos sin servir';
                    DecimalPlaces = 0 : 0;
                }
                field("Como voy"; ComoVoy)
                {
                    ApplicationArea = Basic;
                    Caption = 'Objetivo alcanzado aprox. %';
                }
                field("Objetivo mes actual"; Objetivoeuros)
                {
                    ApplicationArea = Basic;
                    Caption = 'Objetivo mes actual';
                    DecimalPlaces = 0 : 0;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        DocExchServiceSetup: Record "Doc. Exch. Service Setup";
    begin

        ///CalculateCueFieldValues;

        ///ShowDocumentsPendingDodExchService := FALSE;
        ///IF DocExchServiceSetup.GET THEN
        ///ShowDocumentsPendingDodExchService := DocExchServiceSetup.Enabled;




        if UserSetup.Get(UpperCase(UserId)) then begin

        end;

        ///// UserSetup."Salespers./Purch. Code":='15';

        mes := Date2dmy(Today, 2);
        año := Date2dmy(Today, 3);
        desde := Dmy2date(1, mes, año);
        date.Reset;
        date.SetRange("Period Type", 2);
        date.SetRange("Period Start", desde);
        if date.FindLast then begin
            hasta := date."Period End";
        end;

        desde := 20180101D;
        SalesCue2.Get;
        SalesCue2.SetRange("Vendedor Filtro", UserSetup."Salespers./Purch. Code");

        SalesCue2.CalcFields("Pedidos Transferencia");
        PDTETRANF := SalesCue2."Pedidos Transferencia";

        SalesCue2.SetRange("Date Filter", desde, hasta);
        SalesCue2.CalcFields("Pedidos Mes Actual");
        MesActual := SalesCue2."Pedidos Mes Actual";

        mes := Date2dmy(Today, 2);
        año := Date2dmy(Today, 3);
        desde := 20000101D;
        hasta := Dmy2date(1, mes, año);
        hasta := CalcDate('-1D', hasta);
        desdeact := Dmy2date(1, mes, año);
        hastaact := Today;
        desdeant := CalcDate('-1M', desdeact);
        date.Reset;
        date.SetRange("Period Type", 2);
        date.SetRange("Period Start", desdeant);
        if date.FindLast then begin
            hastaant := date."Period End";
        end;

        SalesCue2.Get;
        SalesCue2.SetRange("Date Filter", desde, hasta);
        SalesCue2.SetRange("Vendedor Filtro", UserSetup."Salespers./Purch. Code");
        SalesCue2.CalcFields(SalesCue2."Pedidos Mes Actual");
        Resto := SalesCue2."Pedidos Mes Actual";




        Num_presupu := 0;

        RecuperaRotura := 0;
        SalesHeader.Reset;
        SalesHeader.SetCurrentkey("Document Type", "Salesperson Code");
        SalesHeader.SetRange(SalesHeader."Document Type", 0);
        SalesHeader.SetRange(SalesHeader."Salesperson Code", UserSetup."Salespers./Purch. Code");
        SalesHeader.SetRange(SalesHeader."Order Date", 20180101D, Today);
        SalesHeader.SetRange("Estado presupuesto", SalesHeader."estado presupuesto"::Activo);
        if SalesHeader.FindSet then
            repeat
                Num_presupu := Num_presupu + 1;
                SalesLine.Reset;
                SalesLine.SetRange(SalesLine."Document Type", SalesHeader."Document Type");
                SalesLine.SetRange(SalesLine."Document No.", SalesHeader."No.");
                if SalesLine.FindSet then
                    repeat
                        if Item.Get(SalesLine."No.") then begin
                            if Item."No permite pedido" = false then begin
                                RecuperaRotura := RecuperaRotura + 1;
                                SALE := true;
                            end;

                        end;
                    until (SalesLine.Next = 0) or SALE;

            until SalesHeader.Next = 0;


        PedidosRetenidos := 0;
        PedidosPendieteComercial := 0;
        PedidosParaPreparar := 0;

        SalesHeader.Reset;
        SalesHeader.SetCurrentkey("Document Type", "Salesperson Code");
        SalesHeader.SetRange(SalesHeader."Document Type", 1);
        SalesHeader.SetRange(SalesHeader."Salesperson Code", UserSetup."Salespers./Purch. Code");
        SalesHeader.SetRange(SalesHeader."Order Date", 20180101D, Today);
        if SalesHeader.FindSet then
            repeat
                if SalesHeader."Estado pedido" = SalesHeader."estado pedido"::"Para preparar" then begin
                    PedidosParaPreparar := PedidosParaPreparar + 1;
                end;
                if SalesHeader."Estado pedido" = SalesHeader."estado pedido"::"Pdte. comercial" then begin
                    PedidosPendieteComercial := PedidosPendieteComercial + 1;
                end;
                if SalesHeader."Estado pedido" = SalesHeader."estado pedido"::Retenido then begin
                    PedidosRetenidos := PedidosRetenidos + 1;
                end;

            until SalesHeader.Next = 0;


        CuantosImp := 0;
        ImpImpagados := 0;

        Customer.Reset;
        Customer.SetCurrentkey("Salesperson Code");
        Customer.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
        if Customer.FindSet then
            repeat
                CustLedgerEntry.Reset;
                CustLedgerEntry.SetCurrentkey("Customer No.", Open);
                CustLedgerEntry.SetRange("Customer No.", Customer."No.");
                CustLedgerEntry.SetRange(Open, true);
                CustLedgerEntry.SetRange("Category Code", 'IMPAGADO');
                if CustLedgerEntry.FindSet then
                    repeat
                        CustLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                        ImpImpagados := ImpImpagados + CustLedgerEntry."Remaining Amt. (LCY)";
                        CuantosImp := CuantosImp + 1;
                    until CustLedgerEntry.Next = 0;
            until Customer.Next = 0;
        TEXTO1 := Format(ImpImpagados) + ' (' + Format(CuantosImp) + ')';


        diamenosuno := CalcDate('-1D', Today);
        Hasta30 := 0;
        Masde30 := 0;
        Masde60 := 0;
        Masde90 := 0;
        Customer.Reset;
        Customer.SetCurrentkey("Salesperson Code");
        Customer.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
        if Customer.FindSet then
            repeat
                CustLedgerEntry.Reset;
                CustLedgerEntry.SetCurrentkey("Customer No.", Open);
                CustLedgerEntry.SetRange("Customer No.", Customer."No.");
                CustLedgerEntry.SetRange(Open, true);
                ///CustLedgerEntry.SETFILTER("Category Code",'<>IMPAGADO');
                if CustLedgerEntry.FindSet then
                    repeat
                        if ((diamenosuno - CustLedgerEntry."Due Date") >= 0) and ((diamenosuno - CustLedgerEntry."Due Date") <= 30) then begin
                            CustLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                            Hasta30 := Hasta30 + CustLedgerEntry."Remaining Amt. (LCY)";
                        end;
                        if ((diamenosuno - CustLedgerEntry."Due Date") > 30) and ((diamenosuno - CustLedgerEntry."Due Date") <= 60) then begin
                            CustLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                            Masde30 := Masde30 + CustLedgerEntry."Remaining Amt. (LCY)";
                        end;
                        if ((diamenosuno - CustLedgerEntry."Due Date") > 60) and ((diamenosuno - CustLedgerEntry."Due Date") <= 90) then begin
                            CustLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                            Masde60 := Masde60 + CustLedgerEntry."Remaining Amt. (LCY)";
                        end;
                        if ((diamenosuno - CustLedgerEntry."Due Date") > 90) then begin
                            CustLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                            Masde90 := Masde90 + CustLedgerEntry."Remaining Amt. (LCY)";
                        end;
                    until CustLedgerEntry.Next = 0;
            until Customer.Next = 0;


        SALDOVENCIDO := 0;
        CustLedgerEntry.Reset;
        CustLedgerEntry.SetCurrentkey("Salesperson Code", Open, CustLedgerEntry."Category Code");
        CustLedgerEntry.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
        CustLedgerEntry.SetRange(Open, true);
        CustLedgerEntry.SetFilter("Category Code", '<>IMPAGADO');
        CustLedgerEntry.SetRange("Due Date", 20000101D, diamenosuno);
        if CustLedgerEntry.FindSet then
            repeat
                CustLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                SALDOVENCIDO := SALDOVENCIDO + CustLedgerEntry."Remaining Amt. (LCY)";
            until CustLedgerEntry.Next = 0;

        Customer.Reset;
        Customer.SetCurrentkey("Salesperson Code");
        Customer.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
        Customer.SetRange("Estatus del cliente", Customer."estatus del cliente"::Activo);
        MisClientes := Customer.Count;

        Customer.Reset;
        Customer.SetCurrentkey("Salesperson Code");
        Customer.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
        Customer.SetRange("Estatus del cliente", Customer."estatus del cliente"::"Posible cliente");
        MisPosibles := Customer.Count;


        Customer.Reset;
        Customer.SetCurrentkey("Salesperson Code");
        Customer.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
        Customer.SetRange("Estatus del cliente", Customer."estatus del cliente"::"Posible cliente WEB");
        MisPosiblesWEB := Customer.Count;

        FacturadoMesAnt := 0;
        SalesInvoiceHeader.Reset;
        SalesInvoiceHeader.SetCurrentkey("Salesperson Code", "Posting Date");
        SalesInvoiceHeader.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
        SalesInvoiceHeader.SetRange("Posting Date", desdeant, hastaant);
        if SalesInvoiceHeader.FindSet then
            repeat
                SalesInvoiceHeader.CalcFields(Amount);
                FacturadoMesAnt := FacturadoMesAnt + SalesInvoiceHeader.Amount;
            until SalesInvoiceHeader.Next = 0;

        SalesCrMemoHeader.Reset;
        SalesCrMemoHeader.SetCurrentkey("Salesperson Code", "Posting Date");
        SalesCrMemoHeader.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
        SalesCrMemoHeader.SetRange("Posting Date", desdeant, hastaant);
        if SalesCrMemoHeader.FindSet then
            repeat
                SalesCrMemoHeader.CalcFields(Amount);
                FacturadoMesAnt := FacturadoMesAnt + SalesCrMemoHeader.Amount * -1;
            until SalesCrMemoHeader.Next = 0;

        FacturadoMesAct := 0;
        SalesInvoiceHeader.Reset;
        SalesInvoiceHeader.SetCurrentkey("Salesperson Code", "Posting Date");
        SalesInvoiceHeader.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
        SalesInvoiceHeader.SetRange("Posting Date", desdeact, hastaact);
        if SalesInvoiceHeader.FindSet then
            repeat
                SalesInvoiceHeader.CalcFields(Amount);
                FacturadoMesAct := FacturadoMesAct + SalesInvoiceHeader.Amount;
            until SalesInvoiceHeader.Next = 0;

        SalesCrMemoHeader.Reset;
        SalesCrMemoHeader.SetCurrentkey("Salesperson Code", "Posting Date");
        SalesCrMemoHeader.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
        SalesCrMemoHeader.SetRange("Posting Date", desdeact, hastaact);
        if SalesCrMemoHeader.FindSet then
            repeat
                SalesCrMemoHeader.CalcFields(Amount);
                FacturadoMesAct := FacturadoMesAct + SalesCrMemoHeader.Amount * -1;
            until SalesCrMemoHeader.Next = 0;

        Albaranado := 0;
        desde := 20181101D;
        hasta := Today;
        Customer.Reset;
        Customer.SetCurrentkey("Salesperson Code");
        Customer.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
        if Customer.FindSet then
            repeat
                Customer.CalcFields("Shipped Not Invoiced (LCY)");
                Albaranado := Albaranado + Customer."Shipped Not Invoiced (LCY)";
            until Customer.Next = 0;

        Albaranado := ROUND(Albaranado, 1);

        pedidos := 0;
        SalesHeader.Reset;
        SalesHeader.SetCurrentkey("Document Type", "Salesperson Code");
        SalesHeader.SetRange("Document Type", 1);
        SalesHeader.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
        if SalesHeader.FindSet then
            repeat
                SalesLine.Reset;
                SalesLine.SetRange("Document Type", 1);
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                if SalesLine.FindSet then
                    repeat
                        if SalesLine."Outstanding Quantity" <> 0 then begin
                            if item2.Get(SalesLine."No.") then begin
                                if (item2."No permite pedido" = false) and (item2."Producto con reserva" = false) then begin
                                    if SalesLine."Producto asociado" = 0 then begin
                                        pedidos := pedidos + SalesLine.Amount;
                                    end;
                                end;
                            end;
                        end;
                    until SalesLine.Next = 0;
            until SalesHeader.Next = 0;

        pedidos := ROUND(pedidos, 1);


        año := Date2dmy(Today, 3);

        mes := Date2dmy(Today, 2);


        Rec3.Reset;
        Rec3.SetRange(Rec3.Vendedor, UserSetup."Salespers./Purch. Code");
        Rec3.SetRange(Rec3.Año, año);
        Rec3.SetRange(Rec3.Tipo, 0);
        if Rec3.FindSet then begin
            if mes = 1 then tantorecu := Rec3.Enero;
            if mes = 2 then tantorecu := Rec3.Febrero;
            if mes = 3 then tantorecu := Rec3.Marzo;
            if mes = 4 then tantorecu := Rec3.Abril;
            if mes = 5 then tantorecu := Rec3.Mayo;
            if mes = 6 then tantorecu := Rec3.Junio;
            if mes = 7 then tantorecu := Rec3.Julio;
            if mes = 8 then tantorecu := Rec3.Agosto;
            if mes = 9 then tantorecu := Rec3.Septiembre;
            if mes = 10 then tantorecu := Rec3.Octubre;
            if mes = 11 then tantorecu := Rec3.Noviembre;
            if mes = 12 then tantorecu := Rec3.Diciembre;
        end;


        Total := FacturadoMesAct + Albaranado + pedidos;
        Objetivoeuros := tantorecu;
        if tantorecu <> 0 then begin
            ComoVoy := ROUND(Total * 100 / tantorecu, 0.01);

        end;
        ComoVoyt := Format(ComoVoy) + '%'
    end;

    trigger OnOpenPage()
    var
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
    begin


        CuantosProductos := 9999;


        /* /////-
                Reset;
                if not Get then begin
                  Init;
                  Insert;
                end;

                SetRespCenterFilter;
                SetRange("Date Filter",0D,WorkDate - 1);
                SetFilter("Date Filter2",'>=%1',WorkDate);
                */

        ////RoleCenterNotificationMgt.ShowNotifications;
    end;

    var
        CueSetup: Codeunit "Cues And KPIs";
        ShowDocumentsPendingDodExchService: Boolean;
        ESTADO0: Integer;
        ESTADO1: Integer;
        ESTADO2: Integer;
        SalesHeader: Record "Sales Header";
        ComercialPedidosMesActual: Page "Comercial Pedidos";
        UserSetup: Record "User Setup";
        RecuperaRotura: Integer;
        SalesLine: Record "Sales Line";
        Item: Record Item;
        SALE: Boolean;
        ImpImpagados: Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        MisImpagados: Page "Mis Impagados";
        Masde30: Decimal;
        Masde60: Decimal;
        Masde90: Decimal;
        MisCobrosVencidos: Page "Mis Cobros Vencidos";
        desde: Date;
        hasta: Date;
        CuantosImp: Integer;
        TEXTO1: Text;
        SalesCue2: Record "Sales Cue";
        mes: Integer;
        "año": Integer;
        date: Record Date;
        MesActual: Integer;
        Resto: Integer;
        CuantosProductos: Integer;
        PagProductos: Page Productos;
        /////-NuevoPresu: Page "Nuevo presupuesto copia";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        codpedido: Code[10];
        Nuevop: Integer;
        MisClientes: Integer;
        MisPosibles: Integer;
        /////-PageMisClientes: Page "Mis Clientes";
        /////-PageMisPosiblesClientes: Page "Mis Posibles Clientes";
        Customer: Record Customer;
        MisPosiblesWEB: Integer;
        /////-PageMisPosiblesClientesWEB: Page "Mis Posibles Clientes WEB";
        Num_presupu: Integer;
        ComercialPresupuestos: Page "Comercial presupuestos";
        PedidosRetenidos: Integer;
        PedidosPendieteComercial: Integer;
        PedidosParaPreparar: Integer;
        filtroroturas: Text[1024];
        Facturado: Decimal;
        desdef: Date;
        hastaf: Date;
        Albaranado: Decimal;
        pedidos: Decimal;
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        HiatoricoAlbaranes: Decimal;
        PostedSalesShipments: Page "Posted Sales Shipments";
        item2: Record Item;
        Rec3: Record "Objetivos vendedores";
        tantorecu: Decimal;
        Total: Decimal;
        ComoVoy: Decimal;
        ComoVoyt: Text;
        FacturadoMesAct: Decimal;
        FacturadoMesAnt: Decimal;
        desdeact: Date;
        desdeant: Date;
        hastaant: Date;
        hastaact: Date;
        elmes: Integer;
        "elaño": Integer;
        SALDOVENCIDO: Decimal;
        Hasta30: Decimal;
        HASTA90D: Date;
        DESDE90D: Date;
        HASTA60D: Date;
        DESDE60D: Date;
        HASTA30D: Date;
        DESDE30D: Date;
        HASTAHOYD: Date;
        Masde0: Decimal;
        diamenosuno: Date;
        PDTETRANF: Integer;
        Objetivoeuros: Decimal;
        NuevoPresu: Page "Sales Quote";

    local procedure CalculateCueFieldValues()

    begin
        /*/////-
            if FieldActive("Average Days Delayed") then
              "Average Days Delayed" := CalculateAverageDaysDelayed;

            if FieldActive("Ready to Ship") then
              "Ready to Ship" := CountOrders(FieldNo("Ready to Ship"));

            if FieldActive("Partially Shipped") then
              "Partially Shipped" := CountOrders(FieldNo("Partially Shipped"));

            if FieldActive(Delayed) then
              Delayed := CountOrders(FieldNo(Delayed));
              */
    end;

}

