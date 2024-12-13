#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50104 "Modifica factura"
{
    PageType = Card;
    Permissions = TableData "Sales Invoice Header"=rim;
    SourceTable = "Sales Invoice Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sell-to Customer No.";Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sell-to Customer Name";Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Your Reference";Rec."Your Reference")
                {
                    ApplicationArea = Basic;
                }
                field("Nº expedición";Rec."Nº expedición")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

