#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50067 "Precios especiales"
{
    PageType = List;
    SourceTable = "Precios especiales TA";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Cliente;Rec.Cliente)
                {
                    ApplicationArea = Basic;
                }
                field("Item No.";Rec."Item No.")
                {
                    ApplicationArea = Basic;
                }
                field("Descripción";Rec.Descripción)
                {
                    ApplicationArea = Basic;
                }
                field("Starting Date";Rec."Starting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Ending Date";Rec."Ending Date")
                {
                    ApplicationArea = Basic;
                }
                field("Unit Price";Rec."Unit Price")
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

