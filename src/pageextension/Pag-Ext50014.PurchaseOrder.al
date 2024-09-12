pageextension 50014 "Purchase Order" extends "Purchase Order"
{
    layout
    {
        addlast(content)
        {
            group(Hagen)
            {
                field("Importe pedido"; Rec."Importe pedido") { ApplicationArea = All; }
                field("Importe Pdte. pedido"; Rec."Importe Pdte. pedido") { ApplicationArea = All; }
                field("BL"; Rec."BL") { ApplicationArea = All; }
                field("Nº contenedor"; Rec."Nº contenedor") { ApplicationArea = All; }
                field("Kilos"; Rec."Kilos") { ApplicationArea = All; }
                field("E.T.Departure"; Rec."E.T.Departure") { ApplicationArea = All; }
                field("E.T.Arrival"; Rec."E.T.Arrival") { ApplicationArea = All; }
                field("Recepción Documentos"; Rec."Recepción Documentos") { ApplicationArea = All; }
                field("Fecha recepción docs."; Rec."Fecha recepción docs.") { ApplicationArea = All; }
                field("Envio docs. aduana"; Rec."Envio docs. aduana") { ApplicationArea = All; }
                field("Fecha envio docs. aduana"; Rec."Fecha envio docs. aduana") { ApplicationArea = All; }
                field("Fletes estimado"; Rec."Fletes estimado") { ApplicationArea = All; }
                field("Fecha de despacho"; Rec."Fecha de despacho") { ApplicationArea = All; }
                field("Shipping Agent Code"; Rec."Shipping Agent Code") { ApplicationArea = All; }
                field("Código importación"; Rec."Código importación") { ApplicationArea = All; }
                field("DUA"; Rec."DUA") { ApplicationArea = All; }
                field("Fecha dua"; Rec."Fecha dua") { ApplicationArea = All; }
                field("Nº meses a periodificar"; Rec."Nº meses a periodificar") { ApplicationArea = All; }
                field("TIEN LI"; Rec."TIEN LI") { ApplicationArea = All; }
                field("Nº doc. factura proveedor"; Rec."Nº doc. factura proveedor") { ApplicationArea = All; }
                field("Fecha llegada puerto"; Rec."Fecha llegada puerto") { ApplicationArea = All; }
                field("Permite multiplos distintos"; Rec."Permite multiplos distintos") { ApplicationArea = All; }
                field("Enviado adaia"; Rec."Enviado adaia") { ApplicationArea = All; }
                field("Fecha enviado adaia"; Rec."Fecha enviado adaia") { ApplicationArea = All; }
                field("Usuario enviado adaia"; Rec."Usuario enviado adaia") { ApplicationArea = All; }
                field("Puerto salida"; Rec."Puerto salida") { ApplicationArea = All; }
                field("nulo Dua."; Rec."nulo Dua.") { ApplicationArea = All; }
                field("nulp Base IVA aduanas"; Rec."nulp Base IVA aduanas") { ApplicationArea = All; }
                field("nulo % iva importacion"; Rec."nulo % iva importacion") { ApplicationArea = All; }
                field("Incremento flete euros"; Rec."Incremento flete euros") { ApplicationArea = All; }
                field("Incremento aduana euros"; Rec."Incremento aduana euros") { ApplicationArea = All; }
                field("tiene lineas"; Rec."tiene lineas") { ApplicationArea = All; }
                field("cantidad pdte"; Rec."cantidad pdte") { ApplicationArea = All; }
                field("Oferta para permite pedido"; Rec."Oferta para permite pedido") { ApplicationArea = All; }
                field("Base imponible"; Rec."Base imponible") { ApplicationArea = All; }
                field("No cuenta gasto"; Rec."No cuenta gasto") { ApplicationArea = All; }

            }
        }
    }

}
