#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50093 Preparadores
{
    PageType = List;
    SourceTable = Preparadores;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Preparador;Rec.Preparador)
                {
                    ApplicationArea = Basic;
                }
                field(Nombre;Rec.Nombre)
                {
                    ApplicationArea = Basic;
                }
                field("Printer Name";Rec."Printer Name")
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

