tableextension 50016 ItemVendor extends "Item Vendor"
{
    fields
    {
        field(50000; cod; Text[50])
        {
            CalcFormula = lookup(Item."Vendor Item No." where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
    }
}
