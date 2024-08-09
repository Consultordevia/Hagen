tableextension 50011 ItemJournalLine extends "Item Journal Line"
{
    fields
    {
        field(50000; "Exento rappel"; Boolean)
        {
        }
        field(50001; Incorpora; Boolean)
        {
        }
        field(50002; Stock; Decimal)
        {
        }
        field(50003; Precio; Decimal)
        {
        }
        field(50004; "Producto almacenable"; Boolean)
        {
            CalcFormula = lookup(Item."Producto almacenable" where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50005; Enviado; Code[20])
        {
            CalcFormula = lookup("Sales Header"."Last Shipping No." where("No." = field("Journal Batch Name")));
            FieldClass = FlowField;
        }
        field(50006; Existe; Boolean)
        {
            CalcFormula = exist("Sales Header" where("No." = field("Journal Batch Name")));
            FieldClass = FlowField;
        }
        field(50007; "Existe 2"; Boolean)
        {
            CalcFormula = exist("Sales Line" where("Document No." = field("Journal Batch Name"),
                                                    "No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50008; "Nº proveedor"; Code[20])
        {
            CalcFormula = lookup(Item."Vendor No." where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50009; "Pedido WEB"; Boolean)
        {
        }
        field(50026; ean; Code[20])
        {
            CalcFormula = lookup(Item.ean where("No." = field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50039; "Dto% cabecera"; Decimal)
        {
            Editable = false;
        }
        field(50040; "Cod. Oferta"; Code[12])
        {
            Editable = false;
        }
        field(50050; "Cod. transportista"; Code[10])
        {
        }
        field(50051; Pesos; Decimal)
        {
        }
        field(50052; "Kilos/vol"; Decimal)
        {
        }
        field(50053; "Kilos/tarifa"; Decimal)
        {
        }
        field(50054; Euros; Decimal)
        {
        }
        field(50055; Optimo; Boolean)
        {
        }
    }
}
