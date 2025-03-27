tableextension 50056 GlEntry extends "G/L Entry"
{
    fields
    {
        field(50650; Advance; Boolean)
        {

            CalcFormula = lookup("G/L Account".Advance where("No." = field("G/L Account No.")));            
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key20; "Source No.")
        {
            SumIndexFields = Amount;
        }
    }


}
