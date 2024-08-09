tableextension 50004 ItemLedgerEntry extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Exento rappel"; Boolean)
        {
        }
        field(50001; "Tiene cargos"; Boolean)
        {
            CalcFormula = exist("Value Entry" where("Item Ledger Entry No." = field("Entry No."),
                                                     "Item Charge No." = filter(<> '')));
            FieldClass = FlowField;
        }
        field(50002; TEXTO; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Source No.")));
            FieldClass = FlowField;
        }
        field(50003; "Unit Cost producto"; Decimal)
        {
        }
        field(50072; Productoalmacenable; Boolean)
        {
        }
    }
}
