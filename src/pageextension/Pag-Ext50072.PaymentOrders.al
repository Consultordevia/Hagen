pageextension 50072 PaymentOrders extends "Payment Orders"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Elect. Pmts Exported"; Rec."Elect. Pmts Exported")
            {
                ApplicationArea = all;
            }
        }
    }
}
