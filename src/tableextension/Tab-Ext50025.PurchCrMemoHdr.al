tableextension 50025 PurchCrMemoHdr extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50000; "Importe abono"; Decimal)
        {
            CalcFormula = sum("Purch. Cr. Memo Line"."Unit Cost (LCY)" where("Document No." = field("No.")));
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
        field(50035; "Permite multiplos distintos"; Boolean)
        {
        }
        field(50053; "Puerto salida"; Text[30])
        {
        }
        field(50054; "Dua."; Text[30])
        {
        }
        field(50055; "nulot Base IVA aduanas"; Decimal)
        {
        }
        field(50056; "nulo % iva importacion"; Decimal)
        {
        }
        field(50116; "Incremento flete"; Decimal)
        {
        }
        field(50117; "Incremento aduana"; Decimal)
        {
        }
        field(50280; "Tipo rectificativa"; Option)
        {
            OptionCaption = ' ,Sustitucion,Diferencia';
            OptionMembers = " ",Sustitucion,Diferencia;
        }
        field(50660; "Referencia catastral"; Text[25])
        {
        }
        field(50661; "Situación inmueble"; Option)
        {
            OptionCaption = ' ,1-con referencia catastral,2-con referencia catastral Pais Vasco y Navarra,3-sin referencia catastral,4-en el extranjero';
            OptionMembers = " ","1-con referencia catastral","2-con referencia catastral Pais Vasco y Navarra","3-sin referencia catastral","4-en el extranjero";
        }
        field(50662; "Nº factura rectificativa"; Code[20])
        {
        }
        field(50663; "Fecha fact. rectifi."; Date)
        {
        }
    }

    trigger OnBeforeDelete()
    begin
        Error('Error, no se puede borrar');
    end;
}
