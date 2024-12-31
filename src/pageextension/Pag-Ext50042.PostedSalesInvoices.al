pageextension 50042 PostedSalesInvoices extends "Posted Sales Invoices"

{
    

        layout
        
    {

    
        
        addafter("Posting Date")   
    {
        field("Your Reference";Rec."Your Reference") {ApplicationArea = All; }
        
    }

    }

    actions
    {
        addlast(navigation)
        {

            action(MarcaCanarias)
            {

                ApplicationArea = Suite;
                Caption = 'MarcaCanarias';
                ShortCutKey = 'F9';
                trigger OnAction()
                var

                    CUAC: Codeunit "Automaticos Cartas";
                                        

                begin


                    CUAC.ModifCanarias(Rec);                                          
                    
                    
                end;
            }}
    }


}
