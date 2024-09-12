pageextension 50018 "Ship-to Address" extends "Ship-to Address"
{
    layout
    {
        addlast(content)
        {
            group(Hagen)
            {
                field("Dirección habitual"; Rec."Dirección habitual") { ApplicationArea = All; }
                field("Dirección postal"; Rec."Dirección postal") { ApplicationArea = All; }
                field("Transportista ficha cliente"; Rec."Transportista ficha cliente") { ApplicationArea = All; }
                field("Dropshipping"; Rec."Dropshipping") { ApplicationArea = All; }
                field("Direccion Ruta"; Rec."Direccion Ruta") { ApplicationArea = All; }
                field("Estatus del cliente"; Rec."Estatus del cliente") { ApplicationArea = All; }
                field("Cód. forma de pago"; Rec."Cód. forma de pago") { ApplicationArea = All; }
                ///field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = All; }
                field("Cod. entrega ECI"; Rec."Cod. entrega ECI") { ApplicationArea = All; }
                field("Filtro ECI"; Rec."Filtro ECI") { ApplicationArea = All; }
                field("Latitud"; Rec."Latitud") { ApplicationArea = All; }
                field("Longitud"; Rec."Longitud") { ApplicationArea = All; }
                field("Nº Movil"; Rec."Nº Movil") { ApplicationArea = All; }
                field("Dni"; Rec."Dni") { ApplicationArea = All; }
            }
        }
    }
}
