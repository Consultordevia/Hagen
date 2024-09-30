#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50045 Etiquetas
{
    Caption = 'Extended Text List';
    CardPageID = "Extended Text";
    DataCaptionFields = "No.";
    PageType = List;
    SourceTable = "Extended Text Header";
    SourceTableView = sorting("Table Name", "No.", "Language Code", "Text No.")
                      where("Table Name" = filter('Etiquetas' | 'EtiquetasECI'));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = Basic;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the language code of the extended text.';
                }
            }
        }

    }

    actions
    {
    }
}

