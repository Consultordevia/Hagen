#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50074 "Lista tipo cajas"
{
    PageType = List;
    SourceTable = "Tipo caja";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo caja"; Rec."Tipo caja")
                {
                    ApplicationArea = Basic;
                }
                field(Combinable; Rec.Combinable)
                {
                    ApplicationArea = Basic;
                }
                field("Maximo kilos"; Rec."Maximo kilos")
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

