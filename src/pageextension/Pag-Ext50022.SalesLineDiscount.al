pageextension 50022 "Sales Line Discount" extends "Sales Line Discounts"
{
    layout
    {
        addafter(Type)
        {
            field(Description; Rec."Descripción") { ApplicationArea = All; }
            field(Ofertadedescuento; Rec."Oferta de descuento") { ApplicationArea = All; }
            field(Vigent; Rec."Vigente") { ApplicationArea = All; }
            field(Fechaalta; Rec."Fecha alta") { ApplicationArea = All; }
            field(Productopadre; Rec."Producto padre") { ApplicationArea = All; }
            field(Promo; Rec."Promocion") { ApplicationArea = All; }
            field(PdteEnviaraWEB; Rec."Pdte. Enviar a WEB") { ApplicationArea = All; }

        }
    }
}
