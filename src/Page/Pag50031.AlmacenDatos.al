#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50031 "Almacen Datos"
{
    // Retenido,Para preparar,Pdte. comercial,Servido,Pendiente stock

    Caption = 'Almacen Datos';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Sales Cue";

    layout
    {
        area(content)
        {
            cuegroup(Control1000000009)
            {
                Caption = 'URGENTES';
                field(SUPERURGENTES; SUPERURGENTES)
                {
                    ApplicationArea = Basic;
                    Caption = 'SUPER URGENTES';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(SalesHeader."Super urgente", true);
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(URGENTES; URGENTES)
                {
                    ApplicationArea = Basic;
                    Caption = 'URGENTES';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(SalesHeader.Urgente, true);
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(SUPERURGENTESPDTEENVIAR; SUPERURGENTESPDTEENVIAR)
                {
                    ApplicationArea = Basic;
                    Caption = 'SUPERURGENTES PDTE. ENVIAR';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(SalesHeader."Super urgente", true);
                        SalesHeader.SetRange("Nº expedición", '');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(URGENTESPDTEENVIAR; URGENTESPDTEENVIAR)
                {
                    ApplicationArea = Basic;
                    Caption = 'URGENTES PDTE. ENVIAR';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(SalesHeader.Urgente, true);
                        SalesHeader.SetRange("Nº expedición", '');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
            }
            cuegroup(RETRASADOS)
            {
                Caption = 'RETRASADOS';
                field("Retrasado 72 horas"; PEDIDORETRA72)
                {
                    ApplicationArea = Basic;
                    Caption = 'Retrasado 72 horas';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(SalesHeader."Fecha para preparar", 20000101D, FECHA72);
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field("Retrasado 48 horas"; PEDIDORETRA48)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'RETENIDO';
                    DrillDownPageID = "Pantalla Almacen";
                    ToolTip = 'Especifica el número de Presupuestos de venta que aún no se han convertido en pedidos.';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(SalesHeader."Fecha para preparar", FECHA48, FECHA48);
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field("Retrasado 24 horas"; PEDIDORETRA24)
                {
                    ApplicationArea = Basic;
                    Caption = 'Retrasado 24 horas';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(SalesHeader."Fecha para preparar", FECHA24, FECHA24);
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(PEDIDORETRA72pdteenviar; PEDIDORETRA72pdteenviar)
                {
                    ApplicationArea = Basic;
                    Caption = 'Retrasado 72 horas PDTE. ENVIAR';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(SalesHeader."Fecha para preparar", 20000101D, FECHA72);
                        SalesHeader.SetRange("Nº expedición", '');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(PEDIDORETRA48pdteenviar; PEDIDORETRA48pdteenviar)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'RETENIDO';
                    DrillDownPageID = "Pantalla Almacen";
                    ToolTip = 'Especifica el número de Presupuestos de venta que aún no se han convertido en pedidos.';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(SalesHeader."Fecha para preparar", FECHA48, FECHA48);
                        SalesHeader.SetRange("Nº expedición", '');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(PEDIDORETRA24pdteenviar; PEDIDORETRA24pdteenviar)
                {
                    ApplicationArea = Basic;
                    Caption = 'Retrasado 24 horas PDTE. ENVIAR';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(SalesHeader."Fecha para preparar", FECHA24, FECHA24);
                        SalesHeader.SetRange("Nº expedición", '');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
            }
            cuegroup("PARA PREPARAR")
            {
                Caption = 'PARA PREPARAR';
                field("ESPAÑA"; ESPAÑA)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ESPAÑA';
                    DrillDownPageID = "Pantalla Almacen";
                    ToolTip = 'Especifica el número de Presupuestos de venta que aún no se han convertido en pedidos.';

                    trigger OnDrillDown()
                    begin


                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(SalesHeader."VAT Country/Region Code", 'ES');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(ECI; ECI)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pedidos - Retenidos';
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Especifica el número de pedidos de venta Retenidos.';

                    trigger OnDrillDown()
                    begin


                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange("Customer Price Group", 'ECI');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(AMAZON; AMAZON)
                {
                    ApplicationArea = Basic;
                    Caption = 'AMAZON';

                    trigger OnDrillDown()
                    begin


                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange("Grupo clientes", 'G10');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(CATIT; CATIT)
                {
                    ApplicationArea = Basic;
                    Caption = 'CATIT';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange("Grupo clientes", 'G52');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(MANOMANO; MANOMANO)
                {
                    ApplicationArea = Basic;
                    Caption = 'MANOMANO';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange("Sell-to Customer No.", 'NAV0127');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(TIENDAANIMAL; TIENDAANIMAL)
                {
                    ApplicationArea = Basic;
                    Caption = 'TIENDAANIMAL';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange("Sell-to Customer No.", '12496');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(PORTUGAL; PORTUGAL)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pedidos Pendiente Comercial';
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Especifica el número de pedidos de venta Pendiente Comercial.';

                    trigger OnDrillDown()
                    begin


                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(SalesHeader."VAT Country/Region Code", 'PT');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(CANARIAS; CANARIAS)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pedidos Para Preparar';
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Especifica el número de pedidos de venta Para Preparar';

                    trigger OnDrillDown()
                    begin


                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(Comunidad, '7');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(TODOS; TODOS)
                {
                    ApplicationArea = Basic;
                    Caption = 'TODOS';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field("ESPAÑAPDTE"; ESPAÑAPDTE)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ESPAÑA';
                    DrillDownPageID = "Pantalla Almacen";
                    ToolTip = 'Especifica el número de Presupuestos de venta que aún no se han convertido en pedidos.';

                    trigger OnDrillDown()
                    begin


                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(SalesHeader."VAT Country/Region Code", 'ES');
                        SalesHeader.SetRange("Nº expedición", '');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(ECIPDTE; ECIPDTE)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pedidos - Retenidos';
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Especifica el número de pedidos de venta Retenidos.';

                    trigger OnDrillDown()
                    begin


                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange("Customer Price Group", 'ECI');
                        SalesHeader.SetRange("Nº expedición", '');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(PORTUGALPDTE; PORTUGALPDTE)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pedidos Pendiente Comercial';
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Especifica el número de pedidos de venta Pendiente Comercial.';

                    trigger OnDrillDown()
                    begin


                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(SalesHeader."VAT Country/Region Code", 'PT');
                        SalesHeader.SetRange("Nº expedición", '');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(CANARIASPDTE; CANARIASPDTE)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pedidos Para Preparar';
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Especifica el número de pedidos de venta Para Preparar';

                    trigger OnDrillDown()
                    begin


                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(Comunidad, '7');
                        SalesHeader.SetRange("Nº expedición", '');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(TODOSPDTE; TODOSPDTE)
                {
                    ApplicationArea = Basic;
                    Caption = 'TODOS PDTE. ENVIAR';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange("Nº expedición", '');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(DROPSHIPMENT; DROPSHIPMENT)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'DROPSHIPMENT';
                    DrillDownPageID = "Pantalla Almacen";

                    trigger OnDrillDown()
                    begin


                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange(SalesHeader.Dropshipping, true);
                        SalesHeader.SetFilter("Grupo clientes", '<>G52');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field("G12 KIWOKO"; G12KIWOKO)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G12  KIWOKO';
                    DrillDownPageID = "Pantalla Almacen";

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Para preparar");
                        SalesHeader.SetRange("Grupo clientes", 'G12');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
            }
            cuegroup("PROXIMOS PEDIDOS")
            {
                Caption = 'PROXIMOS PEDIDOS';
                field(RETENIDO; RETENIDO)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Retenido';
                    DrillDownPageID = "Pantalla Almacen";
                    ToolTip = 'Especifica el número de Presupuestos de venta que aún no se han convertido en pedidos.';

                    trigger OnDrillDown()
                    begin
                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::Retenido);
                        SalesHeader.SetFilter(SalesHeader."Payment Method Code", '<>P.ANTICIPA&<>TRANSFWEB');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
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
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::Retenido);

                        SalesHeader.SetFilter(SalesHeader."Payment Method Code", 'P.ANTICIPA|TRANSFWEB');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(PDTECOMERCIAL; PDTECOMERCIAL)
                {
                    ApplicationArea = Basic;
                    Caption = 'Pdte. Comercial';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::"Pdte. comercial");

                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
            }
            cuegroup(Control1000000015)
            {
                Caption = 'PROXIMOS PEDIDOS';
                field(PEDIDOCONTENEDORact; PEDIDOCONTENEDORact)
                {
                    ApplicationArea = Basic;
                    Caption = 'Pedido Contenedor Semana Actual';
                    DrillDownPageID = "Pantalla Almacen";
                    ToolTip = 'Especifica el número de Pedidos Contenedor Semana Actual';

                    trigger OnDrillDown()
                    begin

                        PurchaseHeader.Reset;
                        PurchaseHeader.SetRange("Document Type", PurchaseHeader."document type"::Order);
                        PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Open);
                        PurchaseHeader.SetRange(Receive, false);
                        PurchaseHeader.SetRange(PurchaseHeader."Expected Receipt Date", lunes, viernes);
                        if PurchaseHeader.FindFirst then begin
                            Clear(PurchaseOrderList);
                            PurchaseOrderList.SetTableview(PurchaseHeader);
                            PurchaseOrderList.RunModal;
                        end;
                    end;
                }
                field(PEDIDOCONTENEDOR; PEDIDOCONTENEDOR)
                {
                    ApplicationArea = Basic;
                    Caption = 'Pedido Contenedor Total';
                    DrillDownPageID = "Pantalla Almacen";
                    ToolTip = 'Especifica el número de Pedidos Contenedor Total';

                    trigger OnDrillDown()
                    begin



                        PurchaseHeader.Reset;
                        PurchaseHeader.SetRange("Document Type", PurchaseHeader."document type"::Order);
                        PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Open);
                        PurchaseHeader.SetRange(Receive, false);
                        if PurchaseHeader.FindFirst then begin
                            Clear(PurchaseOrderList);
                            PurchaseOrderList.SetTableview(PurchaseHeader);
                            PurchaseOrderList.RunModal;
                        end;
                    end;
                }
            }
            cuegroup("Historico Albaranes")
            {
                Caption = 'Historico Albaranes';
                field(HistoricoAlbaranes; HiatoricoAlbaranes)
                {
                    ApplicationArea = Basic;
                    Caption = 'Historico Albaranes';
                    DrillDownPageID = "Posted Sales Shipments";
                    TableRelation = "Sales Shipment Header";

                    trigger OnDrillDown()
                    begin

                        SalesShipmentHeader.Reset;
                        SalesShipmentHeader.SetRange(SalesShipmentHeader."Posting Date", Today);
                        if SalesShipmentHeader.FindFirst then begin
                            Clear(PostedSalesShipments);
                            PostedSalesShipments.SetTableview(SalesShipmentHeader);
                            PostedSalesShipments.RunModal;
                        end;
                    end;
                }
                field(HiatoricoAlbaranesTodos; HiatoricoAlbaranesTodos)
                {
                    ApplicationArea = Basic;
                    Caption = 'Historico Albaranes';
                    DrillDownPageID = "Posted Sales Shipments";
                    TableRelation = "Sales Shipment Header";

                    trigger OnDrillDown()
                    begin

                        DESDEFECHA := CalcDate('-1M', Today);

                        SalesShipmentHeader.Reset;
                        SalesShipmentHeader.SetRange(SalesShipmentHeader."Posting Date", DESDEFECHA, Today);
                        if SalesShipmentHeader.FindFirst then begin
                            Clear(PostedSalesShipments);
                            PostedSalesShipments.SetTableview(SalesShipmentHeader);
                            PostedSalesShipments.RunModal;
                        end;
                    end;
                }
            }
            cuegroup("Diarios de inventario")
            {
                Caption = 'Diarios de inventario';
                field(DiarioInv; DiarioInv)
                {
                    ApplicationArea = Basic;
                    Caption = 'Diario inventario';

                    trigger OnDrillDown()
                    begin
                        Clear(PhysInventoryJournal);

                        PhysInventoryJournal.RunModal;
                    end;
                }
                field(Cola; Cola)
                {
                    ApplicationArea = Basic;
                    Caption = 'Diario inventario';

                    trigger OnDrillDown()
                    begin
                        Clear(JobQueueEntries);

                        JobQueueEntries.RunModal;
                    end;
                }
                field(DiarioProd; DiarioProd)
                {
                    ApplicationArea = Basic;
                    Caption = 'Diario producto';

                    trigger OnDrillDown()
                    begin
                        /////-Clear(ItemJournal);

                        /////- ItemJournal.RunModal;
                    end;
                }
                field(Preparadores; Preparadores)
                {
                    ApplicationArea = Basic;
                    Caption = 'Preparadores';

                    trigger OnDrillDown()
                    begin
                        Page.Run(50093);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    trigger OnAfterGetRecord()
    var
        DocExchServiceSetup: Record "Doc. Exch. Service Setup";
    begin


        SalesCue2.Get;
        SalesCue2.CalcFields("Pedidos MANOMANO", "Pedidos TIEDAANIMAL");
        SalesCue2.CalcFields("Pedidos CATIT", "Pedidos españa", SalesCue2."Pedidos eci", SalesCue2."Pedidos portugal", SalesCue2."Pedidos canarias", SalesCue2."Pedidos todos", "Pedidos DROPSHIMENT");
        SalesCue2.CalcFields(SalesCue2."Pedidos Pdte. comercial", SalesCue2."Pedidos Retenido", SalesCue2."Pedidos Urgentes", SalesCue2."Pedidos Super Urgentes", SalesCue2."Pedidos Transferencia");
        SalesCue2.CalcFields(SalesCue2."Pedidos Urgentes PDTE. ENV.", SalesCue2."Pedidos Super Urgentes PDTE. E", "Pedidos Retrasado PDTE.ENVIAR", "Pedidos AMAZON", "Pedidos G12 (KIWOKO)");
        SalesCue2.CalcFields(
   SalesCue2."Pedidos españa PDTE ENVIAR", SalesCue2."Pedidos eci PDTE ENVIAR", SalesCue2."Pedidos portugal PDTE ENVIAR", SalesCue2."Pedidos canarias PDTE ENVIAR", SalesCue2."Pedidos todos PDTE ENVIAR");


        CATIT := SalesCue2."Pedidos CATIT";
        MANOMANO := SalesCue2."Pedidos MANOMANO";
        TIENDAANIMAL := SalesCue2."Pedidos TIEDAANIMAL";
        AMAZON := SalesCue2."Pedidos AMAZON";
        SUPERURGENTESPDTEENVIAR := SalesCue2."Pedidos Super Urgentes PDTE. E";
        URGENTESPDTEENVIAR := SalesCue2."Pedidos Urgentes PDTE. ENV.";
        SUPERURGENTES := SalesCue2."Pedidos Super Urgentes";
        URGENTES := SalesCue2."Pedidos Urgentes";
        ECI := SalesCue2."Pedidos eci";
        PORTUGAL := SalesCue2."Pedidos portugal";
        CANARIAS := SalesCue2."Pedidos canarias";
        ESPAÑA := SalesCue2."Pedidos españa" - ECI - CANARIAS;
        DROPSHIPMENT := SalesCue2."Pedidos DROPSHIMENT";
        G12KIWOKO := SalesCue2."Pedidos G12 (KIWOKO)";
        RESTO := SalesCue2."Pedidos todos" - ESPAÑA - PORTUGAL;
        TODOS := SalesCue2."Pedidos todos";

        ECIPDTE := SalesCue2."Pedidos eci PDTE ENVIAR";
        PORTUGALPDTE := SalesCue2."Pedidos portugal PDTE ENVIAR";
        CANARIASPDTE := SalesCue2."Pedidos canarias PDTE ENVIAR";
        ESPAÑAPDTE := SalesCue2."Pedidos españa PDTE ENVIAR" - ECIPDTE - CANARIASPDTE;
        TODOSPDTE := SalesCue2."Pedidos todos PDTE ENVIAR";

        RETENIDO := SalesCue2."Pedidos Retenido";
        PDTETRANF := SalesCue2."Pedidos Transferencia";
        PDTECOMERCIAL := SalesCue2."Pedidos Pdte. comercial";
        FECHA24 := CalcDate('-1D', Today);
        SalesCue2.SetRange("Date Filter", FECHA24, FECHA24);
        SalesCue2.CalcFields("Pedidos Retrasado");
        PEDIDORETRA24 := SalesCue2."Pedidos Retrasado";

        FECHA48 := CalcDate('-2D', Today);
        SalesCue2.SetRange("Date Filter", FECHA48, FECHA48);
        SalesCue2.CalcFields("Pedidos Retrasado");
        PEDIDORETRA48 := SalesCue2."Pedidos Retrasado";

        FECHA72 := CalcDate('-3D', Today);
        SalesCue2.SetRange("Date Filter", 20000101D, FECHA72);
        SalesCue2.CalcFields("Pedidos Retrasado");
        PEDIDORETRA72 := SalesCue2."Pedidos Retrasado";

        SalesCue2.SetRange("Date Filter", FECHA24, FECHA24);
        SalesCue2.CalcFields("Pedidos Retrasado PDTE.ENVIAR");
        PEDIDORETRA24pdteenviar := SalesCue2."Pedidos Retrasado PDTE.ENVIAR";

        FECHA48 := CalcDate('-2D', Today);
        SalesCue2.SetRange("Date Filter", FECHA48, FECHA48);
        SalesCue2.CalcFields("Pedidos Retrasado PDTE.ENVIAR");
        PEDIDORETRA48pdteenviar := SalesCue2."Pedidos Retrasado PDTE.ENVIAR";

        FECHA72 := CalcDate('-3D', Today);
        SalesCue2.SetRange("Date Filter", 20000101D, FECHA72);
        SalesCue2.CalcFields("Pedidos Retrasado PDTE.ENVIAR");
        PEDIDORETRA72pdteenviar := SalesCue2."Pedidos Retrasado PDTE.ENVIAR";


        DiarioInv := 0;
        ItemJournalBatch.SetRange("Journal Template Name", 'INVENT. FÍ');
        if ItemJournalBatch.FindFirst then
            repeat
                DiarioInv := DiarioInv + 1;
            until ItemJournalBatch.Next = 0;


        SalesShipmentHeader.Reset;
        SalesShipmentHeader.SetRange(SalesShipmentHeader."Posting Date", Today);
        if SalesShipmentHeader.FindFirst then begin
            HiatoricoAlbaranes := SalesShipmentHeader.Count;
        end;


        SalesCue2.CalcFields(SalesCue2."Pedidos contenedor");
        PEDIDOCONTENEDOR := SalesCue2."Pedidos contenedor";

        dia := Date2dwy(Today, 1);
        if dia = 1 then begin lunes := Today; end;  ///// Lunes
        if dia = 2 then begin lunes := CalcDate('-1D', Today); end;  ///// Martes
        if dia = 3 then begin lunes := CalcDate('-2D', Today); end;  ///// Miercoles
        if dia = 4 then begin lunes := CalcDate('-3D', Today); end;  ///// Jueves
        if dia = 5 then begin lunes := CalcDate('-4D', Today); end;  ///// Viernes
        if dia = 6 then begin lunes := CalcDate('-5D', Today); end;  ///// Sabado
        if dia = 7 then begin lunes := CalcDate('-6D', Today); end;  ///// Domingo


        if dia = 1 then begin viernes := CalcDate('+6D', Today); end;  ///// Martes
        if dia = 2 then begin viernes := CalcDate('+5D', Today); end;  ///// Martes
        if dia = 3 then begin viernes := CalcDate('+4D', Today); end;  ///// Miercoles
        if dia = 4 then begin viernes := CalcDate('+3D', Today); end;  ///// Jueves
        if dia = 5 then begin viernes := CalcDate('+2D', Today); end;  ///// Viernes
        if dia = 6 then begin viernes := CalcDate('+1D', Today); end;  ///// Sabado
        if dia = 7 then begin viernes := Today; end;  ///// Domingo


        SalesCue2.SetRange("Date Filter", lunes, viernes);
        SalesCue2.CalcFields("Pedidos contenedor sem.actual");
        PEDIDOCONTENEDORact := SalesCue2."Pedidos contenedor sem.actual";
    end;

    trigger OnOpenPage()
    var
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
    begin

        HiatoricoAlbaranesTodos := 9999;
        CuantosProductos := 9999;
        if UserSetup.Get(UserId) then begin

        end;


        /////-Reset;
        /////-if not Get then begin
        /////-Init;
        /////-Insert;
        /////-end;

        /////-SetRespCenterFilter;
        /////-SetRange("Date Filter",0D,WorkDate - 1);
        /////-SetFilter("Date Filter2",'>=%1',WorkDate);

        RoleCenterNotificationMgt.ShowNotifications;
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
        CuantosProductos: Integer;
        PagProductos: Page Productos;
        "ESPAÑA": Integer;
        ECI: Integer;
        CANARIAS: Integer;
        PORTUGAL: Integer;
        RESTO: Integer;
        TODOS: Integer;
        RETENIDO: Integer;
        PDTECOMERCIAL: Integer;
        PEDIDORETRA48: Integer;
        PEDIDORETRA24: Integer;
        PEDIDORETRA72: Integer;
        PantallaAlmacen: Page "Pantalla almacen Pascual5";
        FECHA24: Date;
        FECHA48: Date;
        FECHA72: Date;
        URGENTES: Integer;
        SUPERURGENTES: Integer;
        ETIQUETAECI: Boolean;
        PEDIDOCONTENEDOR: Integer;
        PurchaseHeader: Record "Purchase Header";
        PurchaseOrderList: Page "Purchase Order List";
        PDTETRANF: Integer;
        PEDIDOCONTENEDORact: Integer;
        lunes: Date;
        viernes: Date;
        dia: Integer;
        HiatoricoAlbaranes: Integer;
        SalesShipmentHeader: Record "Sales Shipment Header";
        PostedSalesShipments: Page "Albaranes dia-3";
        SUPERURGENTESPDTEENVIAR: Integer;
        URGENTESPDTEENVIAR: Integer;
        PEDIDORETRA72pdteenviar: Integer;
        PEDIDORETRA48pdteenviar: Integer;
        PEDIDORETRA24pdteenviar: Integer;
        "ESPAÑAPDTE": Integer;
        ECIPDTE: Integer;
        PORTUGALPDTE: Integer;
        CANARIASPDTE: Integer;
        TODOSPDTE: Integer;
        DiarioInv: Integer;
        PhysInventoryJournal: Page "Registrar inventario";
        ItemJournalBatch: Record "Item Journal Batch";
        HiatoricoAlbaranesTodos: Integer;
        DESDEFECHA: Date;
        JobQueueEntries: Page "Job Queue Entries";
        Cola: Integer;
        DROPSHIPMENT: Integer;
        CATIT: Integer;
        AMAZON: Integer;
        G12KIWOKO: Integer;
        DiarioProd: Integer;
        /////- ItemJournal: Page "Item Journal copia";
        Preparadores: Integer;
        MANOMANO: Integer;
        TIENDAANIMAL: Integer;

    local procedure CalculateCueFieldValues()
    begin
        /////-        if FieldActive("Average Days Delayed") then
        /////-"Average Days Delayed" := CalculateAverageDaysDelayed;
        /////-
        /////-if FieldActive("Ready to Ship") then
        /////-"Ready to Ship" := CountOrders(FieldNo("Ready to Ship"));
        /////-
        /////-if FieldActive("Partially Shipped") then
        /////-"Partially Shipped" := CountOrders(FieldNo("Partially Shipped"));

        /////-if FieldActive(Delayed) then
        /////-Delayed := CountOrders(FieldNo(Delayed));
    end;

}

