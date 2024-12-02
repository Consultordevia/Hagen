tableextension 50031 DetailedCustLedgEntry extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        field(50006; "Category Code"; Code[10])
        {
            Caption = 'Category Code';
            TableRelation = "Category Code";
        }
        field(50010; "Due Date"; Date)
        {
            CalcFormula = lookup("Cust. Ledger Entry"."Due Date" where("Entry No." = field("Cust. Ledger Entry No.")));
            Caption = 'Due Date';
            FieldClass = FlowField;

            trigger OnValidate()
            var
                ReminderEntry: Record "Reminder/Fin. Charge Entry";
                PaymentTerms: Record "Payment Terms";
                ReminderIssue: Codeunit "Reminder-Issue";
            begin
            end;
        }
    }

    keys
    {
        key(Key50012; "Cust. Ledger Entry No.")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
        key(Key50013; "Customer No.", "Excluded from calculation")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
    }
}
