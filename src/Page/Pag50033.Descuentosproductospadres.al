#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50033 "Descuentos productos padres"

{
    ApplicationArea = All;
    Caption = 'Descuentos productos padres';
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Sales Line Discount Padre";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                /////-
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("Descripción"; Rec.Descripción)
                {
                    ApplicationArea = Basic;
                }
                field("Sales Code"; Rec."Sales Code")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = Basic;
                }
                field("Sales Type"; Rec."Sales Type")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = Basic;
                }
                field("Producto en promocion"; Rec."Producto en promocion")
                {
                    ApplicationArea = Basic;
                }
                field("+ Linea"; Rec."+ Linea")
                {
                    ApplicationArea = Basic;
                }
                field("+ Familia"; Rec."+ Familia")
                {
                    ApplicationArea = Basic;
                }
                field("+ Subfamilia"; Rec."+ Subfamilia")
                {
                    ApplicationArea = Basic;
                }
                field("+ Linea 1"; Rec."+ Linea 1")
                {
                    ApplicationArea = Basic;
                }
                field("+ Familia 1"; Rec."+ Familia 1")
                {
                    ApplicationArea = Basic;
                }
                field("+ Subfamilia 1"; Rec."+ Subfamilia 1")
                {
                    ApplicationArea = Basic;
                }
                field("+ Linea 2"; Rec."+ Linea 2")
                {
                    ApplicationArea = Basic;
                }
                field("+ Familia 2"; Rec."+ Familia 2")
                {
                    ApplicationArea = Basic;
                }
                field("+ Subfamilia 2"; Rec."+ Subfamilia 2")
                {
                    ApplicationArea = Basic;
                }
                field("+ Linea 3"; Rec."+ Linea 3")
                {
                    ApplicationArea = Basic;
                }
                field("+ Familia 3"; Rec."+ Familia 3")
                {
                    ApplicationArea = Basic;
                }
                field("+ Subfamilia 3"; Rec."+ Subfamilia 3")
                {
                    ApplicationArea = Basic;
                }
                field("+ Linea 4"; Rec."+ Linea 4")
                {
                    ApplicationArea = Basic;
                }
                field("+ Familia 4"; Rec."+ Familia 4")
                {
                    ApplicationArea = Basic;
                }
                field("+ Subfamilia 4"; Rec."+ Subfamilia 4")
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
            action("Recalcula DC00")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Promoted = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    /////-Automaticos.DescuentosGrupos2;

                    Message('Hecho.');
                end;
            }
            action("Importa datos")
            {
                ApplicationArea = Basic;
                Caption = 'Importa datos';
                Ellipsis = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    /////-Clear(ImportaDescuentosPadre);
                    /////-ImportaDescuentosPadre.Run;
                end;
            }
        }
    }

    var
    /////-Automaticos: Codeunit UnknownCodeunit50001;
    /////-ImportaDescuentosPadre: XmlPort UnknownXmlPort50000;

}
