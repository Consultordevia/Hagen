#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50028 "Pantalla Oficina"
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
                field(CATIT; CATIT)
                {
                    ApplicationArea = Basic;
                    Caption = 'CATIT';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                        SalesHeader.SetRange("Estado pedido", SalesHeader."estado pedido"::Retenido);
                        SalesHeader.SetRange("Grupo clientes", 'G52');
                        if SalesHeader.FindFirst then begin
                            Clear(PantallaAlmacen);
                            PantallaAlmacen.SetTableview(SalesHeader);
                            PantallaAlmacen.RunModal;
                        end;
                    end;
                }
                field(EDIPENDIENTE; EDIPENDIENTE)
                {
                    ApplicationArea = Basic;
                    Caption = 'EDI PENDIENTE';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", SalesHeader."document type"::Quote);
                        SalesHeader.SetRange("Factura EDI", true);
                        SalesHeader.SetRange("Estado presupuesto", SalesHeader."estado presupuesto"::Activo);
                        if SalesHeader.FindFirst then begin
                            Clear(ComercialPresupuestos);
                            ComercialPresupuestos.SetTableview(SalesHeader);
                            ComercialPresupuestos.RunModal;
                        end;
                    end;
                }
            }
            cuegroup(Historicos)
            {
                Caption = 'Historicos';
                field(HistoricoAlbaranes; HiatoricoAlbaranes)
                {
                    ApplicationArea = Basic;
                    Caption = 'Historico Albaranes';
                    DrillDownPageID = "Posted Sales Shipments";
                    TableRelation = "Sales Shipment Header";

                    trigger OnDrillDown()
                    begin

                        SalesShipmentHeader.Reset;
                        SalesShipmentHeader.SetRange("Posting Date", unasemana, Today);
                        if SalesShipmentHeader.FindFirst then begin
                            Clear(PostedSalesShipments);
                            PostedSalesShipments.SetTableview(SalesShipmentHeader);
                            PostedSalesShipments.RunModal;
                        end;
                    end;
                }
                field(HiatoricoFacturas; HiatoricoFacturas)
                {
                    ApplicationArea = Basic;
                    Caption = 'Historico Albaranes';
                    DrillDownPageID = "Posted Sales Invoices";
                    TableRelation = "Sales Invoice Header";

                    trigger OnDrillDown()
                    begin

                        SalesInvoiceHeader.Reset;
                        SalesInvoiceHeader.SetRange("Posting Date", unasemana, Today);
                        if SalesInvoiceHeader.FindFirst then begin
                            Clear(PostedSalesInvoices);
                            PostedSalesInvoices.SetTableview(SalesInvoiceHeader);
                            PostedSalesInvoices.RunModal;
                        end;
                    end;
                }
                field(HiatoricoAbonos; HiatoricoAbonos)
                {
                    ApplicationArea = Basic;
                    Caption = 'Historico Albaranes';
                    DrillDownPageID = "Posted Sales Shipments";
                    TableRelation = "Sales Shipment Header";

                    trigger OnDrillDown()
                    begin

                        SalesCrMemoHeader.Reset;
                        SalesCrMemoHeader.SetRange("Posting Date", unasemana, Today);
                        if SalesCrMemoHeader.FindFirst then begin
                            Clear(PostedSalesCreditMemos);
                            PostedSalesCreditMemos.SetTableview(SalesCrMemoHeader);
                            PostedSalesCreditMemos.RunModal;
                        end;
                    end;
                }
            }
            cuegroup(Control1000000006)
            {
                Caption = 'Productos';
                field(Productos; Productos)
                {
                    ApplicationArea = Basic;
                    Caption = 'Productos';
                    DrillDownPageID = "Item List";
                    TableRelation = Item;

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
                field("Menu Almacen"; menu)
                {
                    ApplicationArea = Basic;
                    Caption = 'Menu Almacen';

                    trigger OnDrillDown()
                    begin

                        Clear(MenuAlmacen);
                        MenuAlmacen.RunModal;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Fact. automatica")
            {
                ApplicationArea = Basic;
                RunObject = Report "Combine Shipments";
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        DocExchServiceSetup: Record "Doc. Exch. Service Setup";
    begin




        SalesCue2.Get;


        SalesCue2.Get;
        SalesCue2.CalcFields("Pedidos CATIT retenido", "Pedidos EDIPENDIENTE");
        SalesCue2.CalcFields(SalesCue2."Pedidos españa", SalesCue2."Pedidos eci", SalesCue2."Pedidos portugal", SalesCue2."Pedidos canarias", SalesCue2."Pedidos todos");
        SalesCue2.CalcFields(SalesCue2."Pedidos Pdte. comercial", SalesCue2."Pedidos Retenido", SalesCue2."Pedidos Urgentes", SalesCue2."Pedidos Super Urgentes", SalesCue2."Pedidos Transferencia");
        SalesCue2.CalcFields(SalesCue2."Pedidos Urgentes PDTE. ENV.", SalesCue2."Pedidos Super Urgentes PDTE. E", "Pedidos Retrasado PDTE.ENVIAR");
        SalesCue2.CalcFields(
   SalesCue2."Pedidos españa PDTE ENVIAR", SalesCue2."Pedidos eci PDTE ENVIAR", SalesCue2."Pedidos portugal PDTE ENVIAR", SalesCue2."Pedidos canarias PDTE ENVIAR", SalesCue2."Pedidos todos PDTE ENVIAR");


        CATIT := SalesCue2."Pedidos CATIT retenido";
        SUPERURGENTESPDTEENVIAR := SalesCue2."Pedidos Super Urgentes PDTE. E";
        URGENTESPDTEENVIAR := SalesCue2."Pedidos Urgentes PDTE. ENV.";
        SUPERURGENTES := SalesCue2."Pedidos Super Urgentes";
        URGENTES := SalesCue2."Pedidos Urgentes";
        ECI := SalesCue2."Pedidos eci";
        EDIPENDIENTE := SalesCue2."Pedidos EDIPENDIENTE";
        PORTUGAL := SalesCue2."Pedidos portugal";
        CANARIAS := SalesCue2."Pedidos canarias";
        ESPAÑA := SalesCue2."Pedidos españa" - ECI - CANARIAS;
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




        Productos := Item.Count;

        unasemana := CalcDate('-1S', Today);
        SalesShipmentHeader.Reset;
        SalesShipmentHeader.SetRange("Posting Date", unasemana, Today);
        if SalesShipmentHeader.FindFirst then begin
            HiatoricoAlbaranes := SalesShipmentHeader.Count;
        end;
        SalesInvoiceHeader.Reset;
        SalesInvoiceHeader.SetRange("Posting Date", unasemana, Today);
        if SalesInvoiceHeader.FindFirst then begin
            HiatoricoFacturas := SalesInvoiceHeader.Count;
        end;
        SalesCrMemoHeader.Reset;
        SalesCrMemoHeader.SetRange("Posting Date", unasemana, Today);
        if SalesCrMemoHeader.FindFirst then begin
            HiatoricoAbonos := SalesCrMemoHeader.Count;
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


        CuantosProductos := 9999;
        if UserSetup.Get(UserId) then begin

        end;


        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;

        Rec.SetRespCenterFilter;
        Rec.SetRange("Date Filter", 0D, WorkDate - 1);
        Rec.SetFilter("Date Filter2", '>=%1', WorkDate);

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
        PantallaAlmacen: Page "Pantalla Almacen";
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
        PostedSalesShipments: Page "Albaranes dia";
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
        HiatoricoFacturas: Integer;
        HiatoricoAbonos: Integer;
        Productos: Integer;
        unasemana: Date;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        PostedSalesCreditMemos: Page "Posted Sales Credit Memos";
        PostedSalesInvoices: Page "Posted Sales Invoices";
        MenuAlmacen: Page "Menu Almacen";
        menu: Integer;
        CATIT: Integer;
        EDIPENDIENTE: Integer;
        ComercialPresupuestos: Page "Comercial presupuestos";

}

