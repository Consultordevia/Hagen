tableextension 50115 SalesLine extends "Sales Line"
{
    fields
    {
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
            Editable = false;
        }
        field(50006; "Fecha alta"; Date)
        {
            Editable = false;
        }
        field(50007; "Hora alta"; Time)
        {
            Editable = false;
        }
        field(50008; "Estado linea"; Option)
        {
            Editable = false;
            InitValue = Pendiente;
            OptionMembers = Pendiente,Servida,Cancelada,Resto;

            trigger OnValidate()
            begin
                /*
                IF "Estado linea"=4 THEN BEGIN
                     Rec91.GET(USERID);
                     IF NOT Rec91."Permite modificar estado lin.p" THEN BEGIN
                          ERROR('No tiene permiso para cambiar el estado linea.');
                     END;
                END;
                */

            end;
        }
        field(50017; Defectuosos; Boolean)
        {

            trigger OnValidate()
            begin
                /*
                
                Rec91.GET(USERID);
                IF NOT Rec91."Permiso Defectuoso" THEN BEGIN
                     ERROR('No puede utilizar este campo.');
                END;
                IF Defectuosos=TRUE THEN BEGIN
                     "Line Discount %":=100;
                      VALIDATE("Unit Price");
                     "Precio final":=0;
                END;
                IF Defectuosos=FALSE THEN BEGIN
                     "Line Discount %":=0;
                     VALIDATE("Unit Price");
                END;
                
                */

            end;
        }
        field(50019; "Dto 2009"; Decimal)
        {
        }
        field(50021; "Corrected Invoice No."; Code[20])
        {
            Caption = 'Corrected Invoice No.';

            trigger OnLookup()
            var
                SalesInvoiceHeader: Record "Sales Invoice Header";
                PostedSalesInvoices: Page "Posted Sales Invoices";
            begin
            end;

            trigger OnValidate()
            var
                SalesInvoiceHeader: Record "Sales Invoice Header";
            begin
            end;
        }
        field(50022; "Linea correccion"; Integer)
        {
        }
        field(50023; Vendedor; Code[10])
        {
        }
        field(50024; "Importe dto. vendedor"; Decimal)
        {
        }
        field(50027; "Nº expedición"; Code[10])
        {
        }
        field(50028; "Linea Nº expedición"; Integer)
        {
            Caption = 'Linea Nº expedición';
        }
        field(50029; "Producto asociado"; Integer)
        {
        }
        field(50031; "Precio final sin dto.comer"; Decimal)
        {
        }
        field(50032; "Acumula Importe dto. comer"; Decimal)
        {
            Editable = false;
        }
        field(50057; "Cantidad a pasar pedido"; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                IF "Cantidad a pasar a pedido">Quantity THEN BEGIN
                     ERROR('No es posible pasar mas de las pedidas.');
                END;
                */

            end;
        }
        field(50062; "Nº lote"; Code[20])
        {
        }
        field(50063; "Fecha caducidad"; Date)
        {
        }
        field(50068; "Cantidad anulada"; Decimal)
        {
            Editable = false;
        }
        field(50075; "Your Reference 2"; Code[10])
        {
            Caption = 'Your Reference';
        }
        field(50080; "Precio importado"; Decimal)
        {
        }
        field(50082; "id linea externo"; Code[100])
        {
        }
        field(50119; ean; Code[20])
        {
            CalcFormula = lookup(Item.ean where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50120; Referencia; Code[20])
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
        field(50129; "Unidades venta"; Decimal)
        {
            CalcFormula = lookup(Item."Unidades venta" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50267; "Enviar a ADAIA"; Boolean)
        {
        }
        field(50510; "Descuento sin vendedor"; Decimal)
        {
        }
        field(50511; "Importe sin dto vendedor"; Decimal)
        {
        }
        field(50514; "Importe acumulado pedido"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Line Amount" where("Document Type" = field("Document Type"),
                                                                "Document No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50515; "% Dto. vendedor"; Decimal)
        {
        }
        field(50581; "Tipo preparacion"; Option)
        {
            CalcFormula = lookup(Item."Tipo preparacion" where("No." = field("No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,0-Sin Caja,1-Muy pequeño,2-Pequeño,3-Mediano,4-Grande,5- Extra Grande,6- Tubo';
            OptionMembers = " ","0-Sin Caja","1-Muy pequeño","2-Pequeño","3-Mediano","4-Grande","5- Extra Grande","6- Tubo";
        }
        field(50582; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
        }
        field(50584; "Precio Tarifa"; Decimal)
        {
        }
        field(50585; "Suma cdad padre_hijos"; Decimal)
        {
        }
        field(50586; "Dto% apli. lin."; Decimal)
        {
            Editable = false;
        }
        field(50587; "Incremento dto%"; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                IF "Line Discount % original"=0 THEN BEGIN
                     "Line Discount % original":="Line Discount %";
                END;
                
                IF "Inv. Discount Amount"=0 THEN BEGIN
                     PF2:="Precio final"*(100-"Incremento dto%")/100;
                     DTO:=(("Unit Price"-PF2)*100)/("Unit Price");
                     VALIDATE("Line Discount %",DTO);
                END;
                
                IF "Inv. Discount Amount"<>0 THEN BEGIN
                     PF2:=("Precio final"+"Inv. Discount Amount")*(100-"Incremento dto%")/100;
                     DTO:=(("Unit Price"-PF2)*100)/("Unit Price");
                     VALIDATE("Line Discount %",DTO);
                END;
                */

            end;
        }
        field(50588; "Line Discount % original"; Decimal)
        {
        }
        field(50590; "Importe inicial vendedor"; Decimal)
        {
            Editable = false;
        }
        field(50591; ImpLinea; Decimal)
        {
        }
        field(50592; "Producto Padre"; Code[20])
        {
        }
        field(50593; "Suma cdad. por envio"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Outstanding Quantity" where("Nº expedición" = field("Nº expedición"),
                                                                         "No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50594; "Cantidad padre"; Decimal)
        {
            CalcFormula = sum("Sales Line".Quantity where("Document Type" = field("Document Type"),
                                                           "Document No." = field("Document No."),
                                                           "Producto Padre" = field("Producto Padre")));
            FieldClass = FlowField;
        }
        field(50595; "ean canarias"; Code[20])
        {
        }
        field(50596; "prod canarias"; Code[20])
        {
        }
        field(50597; "Linea pedido externo"; Code[20])
        {
        }
        field(50598; "Producto con reserva"; Boolean)
        {
            CalcFormula = lookup(Item."Producto con reserva" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50599; "Grupo clientes"; Code[20])
        {
            CalcFormula = lookup(Customer."Grupo clientes" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
        }
        field(50600; "Fecha cabecera ofer/ped"; Date)
        {
            CalcFormula = lookup("Sales Header"."Order Date" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50601; "Estado presupuesto"; Option)
        {
            CalcFormula = lookup("Sales Header"."Estado presupuesto" where("No." = field("Document No.")));
            FieldClass = FlowField;
            OptionMembers = Activo,"Parcialmente procesado",Procesado;
        }
        field(50602; existe; Boolean)
        {
            CalcFormula = exist("Sales Header" where("Document Type" = field("Document Type"),
                                                      "No." = field("Document No.")));
            FieldClass = FlowField;
        }

    }

}
