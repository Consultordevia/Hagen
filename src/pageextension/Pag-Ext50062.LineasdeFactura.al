pageextension 50062 LineasdeFactura extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter(Description)
        {


            field("Clasificación Comercial"; Rec."Clasificación Comercial")
            { ApplicationArea = All; }
            field("Allow Line Disc."; Rec."Allow Line Disc.")
            { ApplicationArea = All; }
            field("Cód. arancelario"; Rec."Cód. arancelario")
            { ApplicationArea = All; }
            field("Codigo arancelario Canarias"; Rec."Codigo arancelario Canarias")
            { ApplicationArea = All; }
            field("IVA IGIC"; Rec."IVA IGIC")
            { ApplicationArea = All; }
            field("IVA IGIC2"; Rec."IVA IGIC2")
            { ApplicationArea = All; }



        }
    }
}
