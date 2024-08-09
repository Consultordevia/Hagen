tableextension 50022 PurchRcptLine extends "Purch. Rcpt. Line"
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
        field(50006; EXISTE; Boolean)
        {
            CalcFormula = exist("Purch. Rcpt. Header" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50010; "Codigo Analisis"; Code[20])
        {
            TableRelation = "Grupos analisis".Codigo;
        }
        field(50011; "Analisis margenes"; Code[10])
        {
            TableRelation = Multitabla.Código where(Tabla = const("Grupo de clientes"));
        }
        field(50020; "Nº oferta"; Code[20])
        {

            trigger OnValidate()
            begin
                /*
                IF Rec38.GET(0,"Nº oferta") THEN BEGIN
                     "Fecha oferta":=Rec38."Document Date";
                END;
                */

            end;
        }
        field(50021; "Fecha oferta"; Date)
        {
        }
        field(50072; "Producto almacenable"; Boolean)
        {
            CalcFormula = lookup(Item."Producto almacenable" where("No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50585; "existe cab"; Boolean)
        {
            CalcFormula = exist("Purch. Rcpt. Header" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
    }
}
