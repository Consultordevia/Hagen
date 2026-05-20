table 50800 "Hagen Prepago Pedido"
{
    Caption = 'Prepago Pedido';
    DataClassification = CustomerContent;
    LookupPageId = "Hagen Prepagos FactBox";
    DrillDownPageId = "Hagen Prepagos FactBox";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Nº Entrada';
            AutoIncrement = true;
        }
        field(2; "Sales Order No."; Code[20])
        {
            Caption = 'Nº Pedido Venta';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Nº Cliente';
            TableRelation = Customer;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Fecha Registro';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Importe';
            MinValue = 0;
        }
        field(6; "Bank Account No."; Code[20])
        {
            Caption = 'Cta. Bancaria Cliente';
            TableRelation = "Customer Bank Account".Code where("Customer No." = field("Customer No."));
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Nº Documento';
        }
        field(8; Status; Enum "Hagen Prepago Status")
        {
            Caption = 'Estado';
        }
        field(9; "Cust. Ledger Entry No."; Integer)
        {
            Caption = 'Nº Mov. Cliente';
            TableRelation = "Cust. Ledger Entry";
        }
        field(10; "Applied to Invoice No."; Code[20])
        {
            Caption = 'Aplicado a Factura';
        }
        field(11; "User ID"; Code[50])
        {
            Caption = 'Usuario';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(12; "Company Bank Account No."; Code[20])
        {
            Caption = 'Cuenta Bancaria Empresa';
            TableRelation = "Bank Account";
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(K1; "Sales Order No.", Status) { }
        key(K2; "Customer No.") { }
    }
}
