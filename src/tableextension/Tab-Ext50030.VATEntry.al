tableextension 50030 VATEntry extends "VAT Entry"
{
    fields
    {
        field(50000; "Base IVA Aduanas"; Decimal)
        {
        }
        field(50001; "Proveedor Importación"; Code[29])
        {
        }
        field(50002; "Factura de Aduanas"; Boolean)
        {
        }
        field(50003; "% IVA importación"; Decimal)
        {
        }
        field(50004; DUA; Text[30])
        {
        }
        field(50005; "Valor Viejo Grupo Contable Neg"; Code[20])
        {
        }
        field(50006; "Grupo cliente"; Code[10])
        {
            CalcFormula = lookup(Customer."Grupo clientes" where("No." = field("Bill-to/Pay-to No.")));
            FieldClass = FlowField;
        }
        field(66000; "No. mov. registro IVA"; Integer)
        {
        }
    }
}
