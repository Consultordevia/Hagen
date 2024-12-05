pageextension 50027 "G/L Account List" extends "G/L Account List"
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
                Caption = 'SII';
                Image = Order;


                trigger OnAction()
                var
                cusii2: Codeunit sii2;
                begin
                    clear(cusii2);
                    cusii2.run;
                END;
        }   }
    
    }
}
