pageextension 50022 SalesPrice extends "Sales Prices"
{

    layout
    {



        addlast(content)
        {
            group(Hagen)
            {
                field("Unit of Measure"; Rec."Unit of Measure Code") { ApplicationArea = All; }
                field("Variant Code	Code"; Rec."Variant Code") { ApplicationArea = All; }
                field("Precio recomendado"; Rec."Precio recomendado") { ApplicationArea = All; }
                field("Descripción"; Rec."Descripción") { ApplicationArea = All; }
                field("EXISTE"; Rec.EXISTE) { ApplicationArea = All; }
                field("INCREMENTO"; Rec.INCREMENTO) { ApplicationArea = All; }
                field("EXISTE COD PADRE"; Rec."EXISTE COD PADRE") { ApplicationArea = All; }
                field("NETO"; Rec.NETO) { ApplicationArea = All; }
                field("EXISTE 2012"; Rec."EXISTE 2012") { ApplicationArea = All; }
                field("Precio incial"; Rec."Precio incial") { ApplicationArea = All; }
                field("Dto1"; Rec.Dto1) { ApplicationArea = All; }
                field("Dto2"; Rec.Dto2) { ApplicationArea = All; }
                field("Dto3"; Rec.Dto3) { ApplicationArea = All; }
                field("Ref. hagen"; Rec."Ref. hagen") { ApplicationArea = All; }
                field("Ref. hagen 2"; Rec."Ref. hagen 2") { ApplicationArea = All; }
                field("cuantos"; Rec.cuantos) { ApplicationArea = All; }
                field("Fecha modif"; Rec."Item No.") { ApplicationArea = All; }
                field("Hora modif"; Rec."Hora modif") { ApplicationArea = All; }
                field("Fecha hora modif"; Rec."Fecha hora modif") { ApplicationArea = All; }
                field("Fecha hora modif web"; Rec."Fecha hora modif web") { ApplicationArea = All; }
                field("Codigo concatenado"; Rec."Codigo concatenado") { ApplicationArea = All; }



            }
        }

    }
}