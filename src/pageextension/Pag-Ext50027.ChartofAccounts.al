pageextension 50027 "Chart of Accounts" extends "Chart of Accounts"
{
    layout
    {
    }
    actions
    {
        addlast(reporting)
        {
            action(SII)
            {
                ApplicationArea = All;
                Caption = 'SII', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Order;

                trigger OnAction()
                var
                    cusii2: Codeunit sii2;
                begin
                    clear(cusii2);
                    cusii2.run;
                END;
            }
        }
    }
}
