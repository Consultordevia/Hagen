#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50097 "Desde hasta SII"
{
    PageType = Card;
    SourceTable = "General Ledger Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Desde fecha SII";Rec."Desde fecha SII")
                {
                    ApplicationArea = Basic;
                }
                field("Hasta fecha SII";Rec."Hasta fecha SII")
                {
                    ApplicationArea = Basic;
                }
                field("Desde Numero documento SII";Rec."Desde Numero documento SII")
                {
                    ApplicationArea = Basic;
                }
                field("Hasta Numero documento SII";Rec."Hasta Numero documento SII")
                {
                    ApplicationArea = Basic;
                }
                field("Serie SII";Rec."Serie SII")
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

