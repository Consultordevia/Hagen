tableextension 50001 SalesInvoiceLine extends "Sales Invoice Line"
{
    fields
    {
        field(50000; Oferta; Code[20])
        {
            Editable = false;
        }
        field(50001; "Dto% cabecera/oferta"; Decimal)
        {
            Editable = false;
        }
        field(50003; "Precio base"; Decimal)
        {
            Editable = false;
        }
        field(50004; "Precio final"; Decimal)
        {
            Editable = false;
        }
        field(50005; "Usuario alta"; Code[30])
        {
        }
        field(50006; "Fecha alta"; Date)
        {
        }
        field(50007; "Hora alta"; Time)
        {
        }
        field(50008; "Estado linea"; Option)
        {
            Editable = false;
            InitValue = "NO servida";
            OptionMembers = Servida,"Servido parcial","NO servida",Cancelada;
        }
        field(50009; "Detalle reposición"; Option)
        {
            OptionMembers = " ",Rotura,"Defectuoso  ";
        }
        field(50010; "Cod. Oferta"; Code[12])
        {
            Editable = false;
        }
        field(50011; "Precio especial cliente"; Boolean)
        {
        }
        field(50012; Familia; Code[30])
        {
        }
        field(50013; Subfamilia; Code[30])
        {
        }
        field(50015; "% Dto. vendedor"; Decimal)
        {
        }
        field(50017; Defectuosos; Boolean)
        {
        }
        field(50019; "Dto 2009"; Decimal)
        {
        }
        field(50020; Ean; Code[20])
        {
        }
        field(50023; Vendedor; Code[10])
        {
        }
        field(50025; Regalo; Boolean)
        {
        }
        field(50033; "Oferta de descuento"; Boolean)
        {
            Editable = false;
        }
        field(50050; Abonar; Boolean)
        {
        }
        field(50051; "Cantidad a abonar"; Decimal)
        {
        }
        field(50053; Combo; Boolean)
        {
        }
        field(50064; "NO imprimir en albaran"; Boolean)
        {
        }
        field(50065; "NO imprimir en factura"; Boolean)
        {
        }
        field(50066; vende; Code[10])
        {
            CalcFormula = lookup("Sales Shipment Header"."Salesperson Code" where("No." = field("Shipment No.")));
            FieldClass = FlowField;
        }
        field(50075; "Your Reference 2"; Code[10])
        {
            Caption = 'Your Reference';
        }
        field(50082; "id linea externo"; Code[100])
        {
        }
        field(50100; "Fecha factura"; Date)
        {
        }
        field(50101; "Producto Hagen"; Boolean)
        {
        }
        field(50125; "Cantidad master"; Decimal)
        {
            CalcFormula = lookup("Item Unit of Measure"."Qty. per Unit of Measure" where("Item No." = field("No."),
                                                                                          Code = const('MA')));
            FieldClass = FlowField;
        }
        field(50126; "Cantidad inner"; Decimal)
        {
            CalcFormula = lookup("Item Unit of Measure"."Qty. per Unit of Measure" where("Item No." = field("No."),
                                                                                          Code = const('IN')));
            FieldClass = FlowField;
        }
        field(50266; "VENDE CABECERA"; Code[10])
        {
            CalcFormula = lookup("Sales Invoice Header"."Shortcut Dimension 1 Code" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50300; "Num expedicion"; Code[10])
        {
            CalcFormula = lookup("Sales Invoice Header"."Nº expedición" where("No." = field("Document No.")));
            Caption = 'Num expedicion';
            FieldClass = FlowField;
        }
        field(50301; "Sell-to Country/Region Code"; Code[10])
        {
            Caption = 'Sell-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50400; "Nº caja"; Integer)
        {
        }
        field(50401; "Cantidad caja"; Integer)
        {
        }
        field(50402; "Nº caja."; Integer)
        {
        }
        field(50403; "Cantidad caja."; Integer)
        {
        }
        field(50404; "Nº caja.."; Integer)
        {
        }
        field(50405; "Cantidad caja..."; Integer)
        {
        }
        field(50584; "Precio Tarifa"; Decimal)
        {
        }
        field(50585; "existe cab"; Boolean)
        {
            CalcFormula = exist("Sales Invoice Header" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50596; "prod canarias"; Code[20])
        {
        }
        field(50597; "Linea pedido externo"; Code[20])
        {
        }
        field(50599; "Grupo clientes"; Code[20])
        {
            CalcFormula = lookup(Customer."Grupo clientes" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
        }
        field(50603; ESTADO; Option)
        {
            InitValue = "1";
            OptionCaption = ' ,1';
            OptionMembers = " ","1";
        }
        field(50685; "Nº expedición ECI"; Code[10])
        {
        }
        field(50686; "Num expedicion grabado"; Code[10])
        {
        }
    }

    keys
    {
        key(Key50003; "Sell-to Customer No.", "No.")
        {
        }
        key(Key50008; "Nº expedición ECI")
        {
        }
        //key(Key50009; "No.", "Fecha factura", "Sell-to Country/Region Code")
        //{
        //    SumIndexFields = Quantity, "VAT Base Amount";
        //}
        key(Key50010; "Posting Date")
        {
        }
        key(Key50011; "No.", "Posting Date")


        {
            SumIndexFields = Quantity, "VAT Base Amount";
        }






    }
    trigger OnBeforeDelete()
    begin
        Error('Error, no se puede borrar');
    end;
}
