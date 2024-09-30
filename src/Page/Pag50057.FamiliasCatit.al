#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50057 "Familias Catit"
{
    PageType = List;
    SourceTable = "Familias catit";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Familia Catit"; Rec."Familia Catit")
                {
                    ApplicationArea = Basic;
                }
                field("Subfamilia Catit"; Rec."Subfamilia Catit")
                {
                    ApplicationArea = Basic;
                }
                field("ID Web"; Rec."ID Web")
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

