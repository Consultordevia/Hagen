#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50034 "Lista de descuentos"
{
    PageType = List;
    SourceTable = "Sales Line Discount";

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
                field("Sales Code";Rec."Sales Code")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code";Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Starting Date";Rec."Starting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Line Discount %";Rec."Line Discount %")
                {
                    ApplicationArea = Basic;
                }
                field("Sales Type";Rec."Sales Type")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Quantity";Rec."Minimum Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Ending Date";Rec."Ending Date")
                {
                    ApplicationArea = Basic;
                }
                field(Type;Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Unit of Measure Code";Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic;
                }
                field("Variant Code";Rec."Variant Code")
                {
                    ApplicationArea = Basic;
                }
                field("Descripción";Rec.Descripción)
                {
                    ApplicationArea = Basic;
                }
                field("Oferta de descuento";Rec."Oferta de descuento")
                {
                    ApplicationArea = Basic;
                }
                field(Vigente;Rec.Vigente)
                {
                    ApplicationArea = Basic;
                }
                field("Fecha alta";Rec."Fecha alta")
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

