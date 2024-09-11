pageextension 50019 "Sales Prices" extends "Sales Prices"
{

    layout
    {
        addafter("Unit Price")
        {

            field("Codigo INNER o MASTET"; Rec."Codigo INNER o MASTET") { ApplicationArea = All; }
        }

    }

}
