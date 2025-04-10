table 50055 LogAdaiaPedidos
{
    Caption = 'LogAdaiaPedidos';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Expedicion; Code[20])
        {
            Caption = 'Expedicion';
        }
        field(2; Pedido; Code[20])
        {
            Caption = 'Pedido';
            TableRelation = "Sales Header"."No." where("Document Type" = const(order));
        }
        field(3; Linea; Integer)
        {
            Caption = 'Linea';
        }
        field(4; Producto; Code[20])
        {
            Caption = 'Producto';
            TableRelation = Item;
        }
        field(5; Cantidad; Decimal)
        {
            Caption = 'Cantidad';
        }
    }
    keys
    {
        key(PK; Expedicion, Pedido, Linea)
        {
            Clustered = true;
        }
    }
}
