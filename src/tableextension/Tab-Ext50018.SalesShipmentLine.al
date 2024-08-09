tableextension 50018 SalesShipmentLine extends "Sales Shipment Line"
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
        field(50024; "Importe dto. vendedor"; Decimal)
        {
        }
        field(50025; Regalo; Boolean)
        {
        }
        field(50026; "Exento rappel"; Boolean)
        {
        }
        field(50027; "Nº expedición"; Code[10])
        {
        }
        field(50033; "Oferta de descuento"; Boolean)
        {
            Editable = false;
        }
        field(50053; Combo; Boolean)
        {
        }
        field(50062; "Nº lote"; Code[20])
        {
        }
        field(50063; "Fecha caducidad"; Date)
        {
        }
        field(50064; "NO imprimir en albaran"; Boolean)
        {
        }
        field(50065; "NO imprimir en factura"; Boolean)
        {
        }
        field(50075; "Your Reference 2"; Code[10])
        {
            Caption = 'Your Reference';
        }
        field(50078; "Excluir del exel amazon"; Boolean)
        {
        }
        field(50082; "id linea externo"; Code[100])
        {
        }
        field(50101; "Producto Hagen"; Boolean)
        {
        }
        field(50119; "cod ean"; Code[20])
        {
            CalcFormula = lookup(Item.ean where("No." = field("No.")));
            FieldClass = FlowField;
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
        field(50584; "Precio Tarifa"; Decimal)
        {
        }
        field(50585; "existe cab"; Boolean)
        {
            CalcFormula = exist("Sales Shipment Header" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50597; "Linea pedido externo"; Code[20])
        {
        }
        field(50599; "Grupo clientes"; Code[20])
        {
            CalcFormula = lookup(Customer."Grupo clientes" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
        }
        field(50602; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
        }
        field(50603; ESTADO; Option)
        {
            InitValue = "1";
            OptionCaption = ' ,1';
            OptionMembers = " ","1";
        }
    }
}
