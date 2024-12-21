pageextension 50036 SalesOrderList extends "Sales Order List"
{
    layout
    {
        

    addafter("Posting Date")  
    {            
    field("E-MAIL";Rec."E-MAIL") { ApplicationArea = All; }
    field("Observación para transporte";Rec."Observación para transporte") { ApplicationArea = All; }    
    field("Sell-to Customer Name 2";Rec."Sell-to Customer Name 2") { ApplicationArea = All; }
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
    

