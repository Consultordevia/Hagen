tableextension 50005 PurchaseHeader extends "Purchase Header"
{
    fields
    {
        field(50000; "Importe pedido"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Line Amount" where("Document Type" = field("Document Type"),
                                                                   "Document No." = field("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Importe Pdte. pedido"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Amount (LCY)" where("Document Type" = field("Document Type"),
                                                                                "Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50002; BL; Code[20])
        {
        }
        field(50003; "Nº contenedor"; Code[20])
        {
        }
        field(50004; Kilos; Decimal)
        {
        }
        field(50006; "E.T.Departure"; Date)
        {
        }
        field(50007; "E.T.Arrival"; Date)
        {

            trigger OnValidate()
            begin

                /////VALIDATE("Expected Receipt Date","E.T.Arrival");
            end;
        }
        field(50008; "Recepción Documentos"; Boolean)
        {

            trigger OnValidate()
            begin

                "Fecha recepción docs." := Today;
            end;
        }
        field(50009; "Fecha recepción docs."; Date)
        {
            Editable = false;
        }
        field(50010; "Envio docs. aduana"; Boolean)
        {

            trigger OnValidate()
            begin

                "Fecha envio docs. aduana" := Today;
            end;
        }
        field(50011; "Fecha envio docs. aduana"; Date)
        {
            Editable = false;
        }
        field(50012; "Fletes estimado"; Decimal)
        {
        }
        field(50013; "Fecha de despacho"; Date)
        {
        }
        field(50014; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(50015; "Código importación"; Code[10])
        {
        }
        field(50016; DUA; Text[30])
        {
        }
        field(50017; "Fecha dua"; Date)
        {
        }
        field(50018; "Nº meses a periodificar"; Integer)
        {
        }
        field(50020; "TIEN LI"; Boolean)
        {
            CalcFormula = exist("Purchase Line" where("Document Type" = field("Document Type"),
                                                       "Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50021; "Nº doc. factura proveedor"; Code[20])
        {

            trigger OnValidate()
            begin
                "Vendor Invoice No." := "Nº doc. factura proveedor";
            end;
        }
        field(50022; "Fecha llegada puerto"; Date)
        {
        }
        field(50035; "Permite multiplos distintos"; Boolean)
        {
        }
        field(50050; "Enviado adaia"; Boolean)
        {
        }
        field(50051; "Fecha enviado adaia"; Date)
        {
        }
        field(50052; "Usuario enviado adaia"; Code[20])
        {
        }
        field(50053; "Puerto salida"; Text[30])
        {
        }
        field(50054; "nulo Dua."; Text[30])
        {
        }
        field(50055; "nulp Base IVA aduanas"; Decimal)
        {
        }
        field(50056; "nulo % iva importacion"; Decimal)
        {
        }
        field(50116; "Incremento flete euros"; Decimal)
        {
        }
        field(50117; "Incremento aduana euros"; Decimal)
        {
        }
        field(50118; "tiene lineas"; Boolean)
        {
            CalcFormula = exist("Purchase Line" where("Document Type" = field("Document Type"),
                                                       "Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50119; "cantidad pdte"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Quantity" where("Document Type" = field("Document Type"),
                                                                            "Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50120; "Oferta para permite pedido"; Boolean)
        {
        }
        field(59008; "Base imponible"; Decimal)
        {


        }
        field(59009; "No cuenta gasto"; Code[20])
        {


        }
    }
}
