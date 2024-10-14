tableextension 50026 PurchCrMemoLine extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(50000; "Pedido compra"; Code[10])
        {
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
        }
        field(50001; "Cantidad a pasar"; Decimal)
        {
        }
        field(50002; "Cantidad inicial"; Decimal)
        {
            Editable = false;
        }
        field(50003; Referencia; Text[50])
        {
        }
        field(50004; "Incremento %"; Decimal)
        {
        }
        field(50005; "Precio original"; Decimal)
        {
        }
        field(50010; "Codigo Analisis"; Code[20])
        {
            TableRelation = "Grupos analisis".Codigo;
        }
        field(50011; "Analisis margenes"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const("Grupo de clientes"));
        }
        field(50114; "Base IVA aduanas"; Decimal)
        {
        }
        field(50115; "Proveedor Importación"; Code[10])
        {
            TableRelation = Vendor;
        }
        field(50116; "% IVA Importación"; Decimal)
        {
        }
        field(50585; "existe cab"; Boolean)
        {
            CalcFormula = exist("Purch. Cr. Memo Hdr." where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
    }
}
