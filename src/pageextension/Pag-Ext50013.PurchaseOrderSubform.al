pageextension 50013 "Purchase Order Subform" extends "Purchase Order Subform"
{

layout
    {
        addbefore("Qty. Assigned")
        {


            field("Cantidad a pasar"; Rec."Cantidad a pasar") { ApplicationArea = All; }
            field("Pedido compra"; Rec."Pedido compra") { ApplicationArea = All; }
            field("Tariff No.";Rec."Tariff No.") { ApplicationArea = All; }

        }
    }
    /*
    layout
    {
        addlast(content)
        {
            group(Hagen)
            {
                field("Pedido compra"; Rec."Pedido compra") { ApplicationArea = All; }
                field("Cantidad a pasar"; Rec."Cantidad a pasar") { ApplicationArea = All; }
                field("Cantidad inicial"; Rec."Cantidad inicial") { ApplicationArea = All; }
                field("Referencia"; Rec."Referencia") { ApplicationArea = All; }
                field("Unidad de compra ficha"; Rec."Unidad de compra ficha") { ApplicationArea = All; }
                field("Codigo Analisis"; Rec."Codigo Analisis") { ApplicationArea = All; }
                field("Analisis margenes"; Rec."Analisis margenes") { ApplicationArea = All; }
                field("Estado Producto"; Rec."Estado Producto") { ApplicationArea = All; }
                field("ean"; Rec."ean") { ApplicationArea = All; }
                field("Cantidad palets"; Rec."Cantidad palets") { ApplicationArea = All; }
                field("Cantidad master"; Rec."Cantidad master") { ApplicationArea = All; }
                field("Cantidad inner"; Rec."Cantidad inner") { ApplicationArea = All; }
                field("Producto almacenable"; Rec."Producto almacenable") { ApplicationArea = All; }
                field("Tariff No."; Rec."Tariff No.") { ApplicationArea = All; }
                field("Base IVA aduanas"; Rec."Base IVA aduanas") { ApplicationArea = All; }
                field("Proveedor Importación"; Rec."Proveedor Importación") { ApplicationArea = All; }
                field("% IVA Importación"; Rec."% IVA Importación") { ApplicationArea = All; }
                field("Fecha Lanzamiento"; Rec."Fecha Lanzamiento") { ApplicationArea = All; }
                field("Oferta para permite pedido"; Rec."Oferta para permite pedido") { ApplicationArea = All; }

            }
        }
    }
    */
}
