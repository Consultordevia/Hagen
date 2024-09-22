#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50054 "Lista multitabla"
{
    PageType = List;
    SourceTable = Multitabla;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Tabla; Rec.Tabla)
                {
                    ApplicationArea = Basic;
                }
                field("Código"; Rec.Código)
                {
                    ApplicationArea = Basic;
                }
                field("Descripción"; Rec.Descripción)
                {
                    ApplicationArea = Basic;
                }
                field("Factura EDI"; Rec."Factura EDI")
                {
                    ApplicationArea = Basic;
                }
                field("Albarán EDI"; Rec."Albarán EDI")
                {
                    ApplicationArea = Basic;
                }
                field("Orden EDI"; Rec."Orden EDI")
                {
                    ApplicationArea = Basic;
                }
                field("Inventario EDI"; Rec."Inventario EDI")
                {
                    ApplicationArea = Basic;
                }
                field("EDICON Grupo Sonae"; Rec."EDICON Grupo Sonae")
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

