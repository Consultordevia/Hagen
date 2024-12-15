pageextension 50038 CustomerPriceGroup extends "Customer Price Groups"
{
      
        layout
    {
        
        addafter(Description )  
    {
        field("Web-B2B";Rec."Web-B2B") {ApplicationArea = All; }
        
    }
    }
}
