pageextension 50036 SalesOrderList extends "Sales Order List"
{
    layout
    {
        

     addafter("Posting Date")  
     {            
     field("E-MAIL";Rec."E-MAIL") { ApplicationArea = All; }
     }

    }

}
/*
    actions
    {
        addlast("&Print")
        {

            action(eliminade)
            {

                ApplicationArea = Suite;
                Caption = 'elimina de';
                trigger OnAction()
                var

                begin

                    Rec."Ship-to Code" := '';
                    Rec.Modify;

                end;
            }
        }
    }
    */
    

