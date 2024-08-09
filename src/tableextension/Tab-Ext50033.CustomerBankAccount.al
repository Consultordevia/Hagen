tableextension 50033 CustomerBankAccount extends "Customer Bank Account"
{
    fields
    {
        field(50000; BIC; Code[12])
        {
        }
        field(50001; "COAP PAIS"; Code[10])
        {
            CalcFormula = lookup(Customer."Country/Region Code" where("No." = field("Customer No.")));
            FieldClass = FlowField;
        }
    }
}
