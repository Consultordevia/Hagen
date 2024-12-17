pageextension 50019 "Sales Prices" extends "Sales Prices"
{



    layout
    {
        addafter("Unit Price")
        {
            field("Codigo INNER o MASTET"; Rec."Codigo INNER o MASTET") { ApplicationArea = All; }
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
            field(ean; Rec.ean) { ApplicationArea = All; }
            field("Cantidad unidades medida"; Rec."Cantidad unidades medida") { ApplicationArea = All; }
            field("Producto_web"; Rec."Producto_web") { ApplicationArea = All; }
<<<<<<< HEAD
            field(WebB2BMWe; Rec.WebB2B)
=======
            field(WebB2BMWe; rec.WebB2BMWe)
>>>>>>> 19e9d2160ab376f94f41cf8cf374e517fc3d7fc4
            {

                ApplicationArea = All;
            }





        }

    }

<<<<<<< HEAD
    trigger OnAfterGetRecord()
    var
        CustomerPriceGroup: Record "Customer Price Group";
    begin
        /////        WebB2B := false;
        /////        if (rec."Sales Type" = rec."Sales Type"::"Customer Price Group") and (CustomerPriceGroup.get(rec."Sales Code")) then begin
        /////            WebB2B := CustomerPriceGroup."Web-B2B";
        /////        end;

    end;
=======
>>>>>>> 19e9d2160ab376f94f41cf8cf374e517fc3d7fc4

}
