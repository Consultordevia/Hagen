tableextension 50121 CarteraDoc extends "Cartera Doc."
{
    fields
    {
        field(50000; "code"; Code[50])
        {
            CalcFormula = lookup("SEPA Direct Debit Mandate".ID where("Customer No." = field("Account No."),
                                                                       "Customer Bank Account Code" = field("Cust./Vendor Bank Acc. Code")));
            FieldClass = FlowField;
        }
    }
    trigger OnInsert()
    begin
        if "Direct Debit Mandate ID" = '' then begin
            SEPADirectDebitMandate.Reset;
            SEPADirectDebitMandate.SetRange("Customer No.", Rec."Account No.");
            if SEPADirectDebitMandate.FindLast then begin
                "Direct Debit Mandate ID" := SEPADirectDebitMandate.ID;
            end;
        end;
    end;

    var
        SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";

}
