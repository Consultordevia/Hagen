tableextension 50020 SalesCrMemoLine extends "Sales Cr.Memo Line"
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
        field(50033; "Oferta de descuento"; Boolean)
        {
            Editable = false;
        }
        field(50034; "Fecha abono"; Date)
        {
        }
        field(50075; "Your Reference 2"; Code[10])
        {
            Caption = 'Your Reference';
        }
        field(50101; "Producto Hagen"; Boolean)
        {
        }
        field(50125; "Cantidad master"; Decimal)
        {
            CalcFormula = lookup(Item."Cantidad master" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50126; "Cantidad inner"; Decimal)
        {
            CalcFormula = lookup(Item."Cantidad inner" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50301; "Sell-to Country/Region Code"; Code[10])
        {
            Caption = 'Sell-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50584; "Precio Tarifa"; Decimal)
        {
        }
        field(50585; "existe cab"; Boolean)
        {
            CalcFormula = exist("Sales Cr.Memo Header" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50599; "Grupo clientes"; Code[20])
        {
            CalcFormula = lookup(Customer."Grupo clientes" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        //key(Key7; "No.", "Fecha abono", "Sell-to Country/Region Code")
        //{
        //    SumIndexFields = Quantity, "VAT Base Amount";
        //}
        //key(Key8; "No.", "Posting Date", "Sell-to Country/Region Code", "Sell-to Customer No.")
        //{
        //   SumIndexFields = Quantity, "VAT Base Amount";
        //}
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
