#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50222 "cartera doc1"
{
    PageType = List;
    SourceTable = "Cartera Doc.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                /*  /////-
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field("Entry No.";"Entry No.")
                {
                    ApplicationArea = Basic;
                }
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Document No.";"Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Remaining Amount";"Remaining Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Remaining Amt. (LCY)";"Remaining Amt. (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Due Date";"Due Date")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Method Code";"Payment Method Code")
                {
                    ApplicationArea = Basic;
                }
                field(Accepted;Accepted)
                {
                    ApplicationArea = Basic;
                }
                field("Direct Debit Mandate ID";"Direct Debit Mandate ID")
                {
                    ApplicationArea = Basic;
                }
                field("code";code)
                {
                    ApplicationArea = Basic;
                }
                field("Cust./Vendor Bank Acc. Code";"Cust./Vendor Bank Acc. Code")
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";"Account No.")
                {
                    ApplicationArea = Basic;
                }
                */
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(asd)
            {
                ApplicationArea = Basic;
                ShortCutKey = 'F9';

                trigger OnAction()
                begin

                     /////-"Direct Debit Mandate ID":=code;
                     /////-Modify;
                end;
            }
        }
    }
}

