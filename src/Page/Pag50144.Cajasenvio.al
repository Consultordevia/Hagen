#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50144 "Cajas envio"
{
    PageType = List;
    SourceTable = "Extended Text Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table Name";Rec."Table Name")
                {
                    ApplicationArea = Basic;
                }
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Language Code";Rec."Language Code")
                {
                    ApplicationArea = Basic;
                }
                field("Text No.";Rec."Text No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(asd)
            {
                ApplicationArea = Basic;
                ShortCutKey = 'F9';

                trigger OnAction()
                begin


                    /////- Rename(Rec."table name"::Etiquetas,Rec."No.",Rec."Language Code",Rec."Text No.");
                end;
            }
        }
    }
}

