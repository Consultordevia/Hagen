#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50138 "Unidades medida producto"
{
    PageType = List;
    SourceTable = "Item Unit of Measure";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("Qty. per Unit of Measure";Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(Length;Rec.Length)
                {
                    ApplicationArea = Basic;
                }
                field(Width;Rec.Width)
                {
                    ApplicationArea = Basic;
                }
                field(Height;Rec.Height)
                {
                    ApplicationArea = Basic;
                }
                field(Cubage;Rec.Cubage)
                {
                    ApplicationArea = Basic;
                }
                field(Weight;Rec.Weight)
                {
                    ApplicationArea = Basic;
                }
                field(ean;Rec.ean)
                {
                    ApplicationArea = Basic;
                }
                field(EXISTE;Rec.EXISTE)
                {
                    ApplicationArea = Basic;
                }
                field("enviar a adaia";Rec."enviar a adaia")
                {
                    ApplicationArea = Basic;
                }
                field("ean PROD";Rec."ean PROD")
                {
                    ApplicationArea = Basic;
                }
                field(EXISTE2;Rec.EXISTE2)
                {
                    ApplicationArea = Basic;
                }
                field("Kgs/Volumen WEB";Rec."Kgs/Volumen WEB")
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

