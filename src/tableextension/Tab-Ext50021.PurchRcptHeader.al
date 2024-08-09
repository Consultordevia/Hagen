tableextension 50021 PurchRcptHeader extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50000; "Importe albaran"; Decimal)
        {
            CalcFormula = sum("Purch. Rcpt. Line"."Unit Cost (LCY)" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50001; "Importe Pdte. pedido"; Decimal)
        {
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
        }
        field(50008; "Recepción Documentos"; Boolean)
        {
        }
        field(50009; "Fecha recepción docs."; Date)
        {
            Editable = false;
        }
        field(50010; "Envio docs. aduana"; Boolean)
        {
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
        field(50021; "Nº doc. factura proveedor"; Code[20])
        {
        }
        field(50025; "Vendedor temp"; Code[10])
        {
        }
        field(50035; "Permite multiplos distintos"; Boolean)
        {
        }
        field(50053; "Puerto salida"; Text[30])
        {
        }
        field(50054; "Dua."; Text[30])
        {
        }
        field(50060; "Cantidad recibida"; Decimal)
        {
            CalcFormula = sum("Purch. Rcpt. Line".Quantity where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50061; "Cantidad facturada"; Decimal)
        {
            CalcFormula = sum("Purch. Rcpt. Line"."Quantity Invoiced" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50062; "Cantidad recida no facturada"; Decimal)
        {
            CalcFormula = sum("Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50116; "Incremento flete"; Decimal)
        {
        }
        field(50117; "Incremento aduana"; Decimal)
        {
        }
        field(50196; "Hora enviado"; Time)
        {
        }
        field(50197; "Fecha enviado"; Date)
        {
        }
        field(50198; "Email enviado"; Boolean)
        {
        }
        field(50199; "Enviar email"; Boolean)
        {
        }
        field(50300; "tiene lineas"; Boolean)
        {
            CalcFormula = exist("Purch. Rcpt. Line" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
    }
}
