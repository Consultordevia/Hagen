tableextension 50049 PurchaseLineDiscount extends "Purchase Line Discount"
{
    fields
    {
        field(50002; EXISTE; Boolean)
        {
            CalcFormula = exist(Item where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
    }
}