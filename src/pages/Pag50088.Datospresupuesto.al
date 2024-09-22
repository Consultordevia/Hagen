#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50088 "Datos presupuesto"
{
    PageType = List;
    SourceTable = "G/L Budget Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No.";Rec."Entry No.")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Name";Rec."Budget Name")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account No.";Rec."G/L Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date;Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Tipo;Rec.Tipo)
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

