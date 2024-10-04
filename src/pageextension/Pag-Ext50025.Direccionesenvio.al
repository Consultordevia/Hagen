pageextension 50025 "Direcciones envio" extends "Ship-to Address List"
{
    layout
    {

        addafter(City)
        {



            field("Estatus del cliente"; Rec."Estatus del cliente") { ApplicationArea = All; }
            field("Direccion Ruta"; Rec."Direccion Ruta") { ApplicationArea = All; }
            field("Dirección habitual"; Rec."Dirección habitual") { ApplicationArea = All; }
            field("Dirección postal"; Rec."Dirección postal") { ApplicationArea = All; }
            field(Dni; Rec.Dni) { ApplicationArea = All; }

            field(Dropshipping; Rec.Dropshipping) { ApplicationArea = All; }
            field("Cód. forma de pago"; Rec."Cód. forma de pago") { ApplicationArea = All; }
            field("Nº Movil"; Rec."Nº Movil") { ApplicationArea = All; }
            field(County; Rec.County) { ApplicationArea = All; }
            field("E-Mail"; Rec."E-Mail") { ApplicationArea = All; }
            field(Latitud; Rec.Latitud) { ApplicationArea = All; }
            field(Longitud; Rec.Longitud) { ApplicationArea = All; }


        }
    }
}
