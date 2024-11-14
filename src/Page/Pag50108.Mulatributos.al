page 50108 Mulatributos
{
    ApplicationArea = All;
    Caption = 'Mulatributos';
    PageType = List;
    SourceTable = "Mul.atributos";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Tabla; Rec.Tabla)
                {
                    ApplicationArea = Basic;
                }
                field(Codigo1; Rec.Codigo1)
                {
                    ApplicationArea = Basic;
                }
                field(Codigo2; Rec.Codigo2)
                {
                    ApplicationArea = Basic;
                }
                field("Descripción"; Rec."Descripción")
                {
                    ApplicationArea = Basic;
                }

            }
        }
    }
}
