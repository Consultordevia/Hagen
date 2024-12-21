pageextension 50037 SalesQuoteList extends "Sales Quotes"
{

    layout
    {


        addafter("Posting Date")
        {
            field("E-MAIL"; Rec."E-MAIL") { ApplicationArea = All; }
            field(GLN; Rec.GLN) { ApplicationArea = All; }

        }

    }

    actions
    {
        addlast("&Quote")
        {

            action(eliminade)
            {

                ApplicationArea = Suite;
                Caption = 'elimina OF';
                ShortCutKey = 'F9';
                trigger OnAction()
                var
                    rec36: Record "Sales Header";
                    rec37: Record "Sales Line";

                begin

                    rec37.reset;
                    rec37.SetRange("Document Type", Rec."Document Type");
                    rec37.SetRange("Document No.", Rec."No.");
                    IF rec37.FindFirst() THEN
                        repeat
                            REC37.DELETE;
                        UNTIL REC37.NEXT = 0;
                    REC36.GET(Rec."Document Type", REC."No.");
                    REC36.DELETE;



                end;
            }
        }
    }
}
