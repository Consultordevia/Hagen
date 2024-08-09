tableextension 50029 "GenProductPostingGroup" extends "Gen. Product Posting Group"
{
    fields
    {
        field(50000; Estadistica; Boolean)
        {
        }
        field(50001; "Nº serie"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50002; Cuantos; Integer)
        {
            CalcFormula = count(Item where("Gen. Prod. Posting Group" = field(Code)));
            FieldClass = FlowField;
        }
        field(50003; "Filtro Cliente"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = Customer;
        }
        field(50004; Importe; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line".Amount where("Gen. Prod. Posting Group" = field(Code),
                                                                 "Sell-to Customer No." = field("Filtro Cliente"),
                                                                 "Fecha factura" = field("Filtro fecha")));
            FieldClass = FlowField;
        }
        field(50005; "Filtro fecha"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50006; "Es producto"; Boolean)
        {
        }
        field(50007; "Id. publicidad"; Integer)
        {
        }
        field(60000; "Actualizar WEB"; Boolean)
        {
        }
        field(60001; "Id Prestashop"; BigInteger)
        {
        }
    }
}
