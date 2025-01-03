pageextension 50046 "ShippingAgentServices " extends "Shipping Agent Services"
{
    layout
    {

        addafter("Shipping Time")
        {
            field("Codigo Servicio";Rec."Codigo Servicio") { ApplicationArea = All; }
            field(Horario;Rec.Horario) { ApplicationArea = All; }
            field(Predeterminado;Rec.Predeterminado) { ApplicationArea = All; }
            field(Shopyfi;Rec.Shopyfi) { ApplicationArea = All; }

        }
    }
}
