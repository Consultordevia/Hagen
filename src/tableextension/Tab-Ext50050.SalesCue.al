tableextension 50050 "Sales Cue" extends "Sales Cue"
{
    fields
    {
        field(50000; "Pedidos Retenidos VENDE"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      Status = filter(Open),
                                                      "Responsibility Center" = field("Responsibility Center Filter"),
                                                      Status = const(Open),
                                                      "Estado pedido" = const(Retenido),
                                                      "Salesperson Code" = field("Vendedor Filtro")));
            Caption = 'Sales Orders - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Vendedor Filtro"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Salesperson/Purchaser";
        }
        field(50002; "Pedidos Pendiete Comercial"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      Status = filter(Open),
                                                      "Responsibility Center" = field("Responsibility Center Filter"),
                                                      Status = const(Open),
                                                      "Estado pedido" = const("Pdte. comercial"),
                                                      "Salesperson Code" = field("Vendedor Filtro")));
            Caption = 'Sales Orders - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Pedidos Para Preparar"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      Status = filter(Open),
                                                      "Responsibility Center" = field("Responsibility Center Filter"),
                                                      Status = const(Open),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Salesperson Code" = field("Vendedor Filtro")));
            Caption = 'Sales Orders - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Pedidos Mes Actual"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Salesperson Code" = field("Vendedor Filtro"),
                                                      "Order Date" = field("Date Filter")));
            Caption = 'Pedidos Mes Actual';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Pedidos Pago Anticipado"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      Status = filter(Open),
                                                      "Responsibility Center" = field("Responsibility Center Filter"),
                                                      "Salesperson Code" = field("Vendedor Filtro"),
                                                      "Order Date" = field("Date Filter"),
                                                      "Payment Method Code" = filter('TRANSFWEB' | 'P.ANTICIPA' | 'S_TRANSF')));
            Caption = 'Pedidos Anteriores Resto';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Pedidos españa"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "VAT Country/Region Code" = filter('ES'),
                                                      "Estado pedido" = const("Para preparar")));
            FieldClass = FlowField;
        }
        field(50008; "Pedidos eci"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Customer Price Group" = const('ECI')));
            FieldClass = FlowField;
        }
        field(50009; "Pedidos portugal"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "VAT Country/Region Code" = filter('PT'),
                                                      "Estado pedido" = const("Para preparar")));
            FieldClass = FlowField;
        }
        field(50010; "Pedidos canarias"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      ///// Comunidad = filter('7'),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "VAT Bus. Posting Group" = filter('EXENTOCANARIAS'),
                                                      "Customer Price Group" = filter(<> 'ECI')));
            FieldClass = FlowField;
        }
        field(50011; "Pedidos todos"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar")));
            FieldClass = FlowField;
        }
        field(50012; "Pedidos Retenido"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const(Retenido),
                                                      "Payment Method Code" = filter(<> 'P.ANTICIPA')));
            ///// en bc ya no  <> 'TRANSFWEB')));                                                           
            /////-"Payment Method Code" = filter(<> 'P.ANTICIPA' & <> 'TRANSFWEB')));
            FieldClass = FlowField;
        }
        field(50013; "Pedidos Pdte. comercial"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Pdte. comercial")));
            FieldClass = FlowField;
        }
        field(50014; "Pedidos Retrasado"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Fecha para preparar" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50015; "Pedidos Urgentes"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar"),
                                                      Urgente = const(true)));
            FieldClass = FlowField;
        }
        field(50016; "Pedidos Super Urgentes"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Super urgente" = const(true)));
            FieldClass = FlowField;
        }
        field(50017; "Pedidos contenedor"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const(Order),
                                                         Status = const(Open),
                                                         Receive = const(false)));
            FieldClass = FlowField;
        }
        field(50018; "Pedidos Transferencia"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const(Retenido),
                                                      "Payment Method Code" = filter('P.ANTICIPA' | 'TRANSFWEB' | 'S_TRANSF'),
                                                      "Salesperson Code" = field("Vendedor Filtro")));
            FieldClass = FlowField;
        }
        field(50019; "Pedidos contenedor sem.actual"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const(Order),
                                                         Status = const(Open),
                                                         Receive = const(false),
                                                         "Expected Receipt Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50025; "Pedidos Urgentes PDTE. ENV."; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar"),
                                                      Urgente = const(true),
                                                      "Nº expedición" = const('')));
            FieldClass = FlowField;
        }
        field(50026; "Pedidos Super Urgentes PDTE. E"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Super urgente" = const(true),
                                                      "Nº expedición" = const('')));
            FieldClass = FlowField;
        }
        field(50027; "Pedidos Retrasado PDTE.ENVIAR"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Fecha para preparar" = field("Date Filter"),
                                                      "Nº expedición" = const('')));
            FieldClass = FlowField;
        }
        field(50028; "Pedidos españa PDTE ENVIAR"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "VAT Country/Region Code" = filter('ES'),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Nº expedición" = const('')));
            FieldClass = FlowField;
        }
        field(50029; "Pedidos eci PDTE ENVIAR"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Customer Price Group" = const('ECI'),
                                                      "Nº expedición" = const('')));
            FieldClass = FlowField;
        }
        field(50030; "Pedidos portugal PDTE ENVIAR"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "VAT Country/Region Code" = filter('PT'),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Nº expedición" = const('')));
            FieldClass = FlowField;
        }
        field(50031; "Pedidos canarias PDTE ENVIAR"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      Comunidad = filter('7'),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Customer Price Group" = filter(<> 'ECI'),
                                                      "Nº expedición" = const('')));
            FieldClass = FlowField;
        }
        field(50032; "Pedidos todos PDTE ENVIAR"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Nº expedición" = const('')));
            FieldClass = FlowField;
        }
        field(50033; "Pedidos DROPSHIMENT"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar"),
                                                      Dropshipping = const(true),
                                                      "Grupo clientes" = filter(<> 'G52')));
            FieldClass = FlowField;
        }
        field(50034; "Pedidos CATIT"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Grupo clientes" = const('G52')));
            FieldClass = FlowField;
        }
        field(50035; "Pedidos AMAZON"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Grupo clientes" = const('G10')));
            FieldClass = FlowField;
        }
        field(50036; "Pedidos G12 (KIWOKO)"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Grupo clientes" = const('G12')));
            FieldClass = FlowField;
        }
        field(50037; "Pedidos CATIT retenido"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const(Retenido),
                                                      "Grupo clientes" = const('G52')));
            FieldClass = FlowField;
        }
        field(50038; "Pedidos MANOMANO"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Sell-to Customer No." = const('NAV0127')));
            FieldClass = FlowField;
        }
        field(50039; "Pedidos TIEDAANIMAL"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                      "Estado pedido" = const("Para preparar"),
                                                      "Sell-to Customer No." = const('12496')));
            FieldClass = FlowField;
        }
        field(50040; "Pedidos EDIPENDIENTE"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Quote),
                                                      "Factura EDI" = filter(true),
                                                      "Estado presupuesto" = const(Activo)));
            FieldClass = FlowField;
        }
    }
}
