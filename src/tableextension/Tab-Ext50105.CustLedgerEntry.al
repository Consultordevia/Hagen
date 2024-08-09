tableextension 50105 "CustLedgerEntry." extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000; "Nombre cliente"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            FieldClass = FlowField;
        }
        field(50001; "Category Code calc."; Code[10])
        {
            CalcFormula = lookup("Cartera Doc."."Category Code" where("Entry No." = field("Entry No.")));
            Caption = 'Category Code calc.';
            FieldClass = FlowField;
            TableRelation = "Category Code";
        }
        field(50002; "Fecha vto. orig"; Date)
        {
        }
        field(50005; existe; Boolean)
        {
            CalcFormula = exist(Customer where("No." = field("Customer No.")));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50006; "Category Code"; Code[10])
        {
            Caption = 'Category Code';
            TableRelation = "Category Code";
        }
        field(50010; "cod vende"; Code[20])
        {
            CalcFormula = lookup("Sales Invoice Header"."Salesperson Code" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
    }
    keys
    {
        /*key(Key50; "Salesperson Code", Open, "Category Code")
        {
        }*/
        key(Key51; "Salesperson Code", "Customer No.", Open)
        {
        }
    }

}
