tableextension 50128 ServiceItem extends "Service Item"
{
    fields
    {
        field(50000; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(50001; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = field("Shipping Agent Code"));
        }
        field(50002; "Estado SAT"; Option)
        {
            Caption = 'Estado SAT';
            OptionCaption = 'Pendiente,En revisión,Finalizado';
            OptionMembers = Pendiente,"En revisión",Finalizado;

        }
        field(50003; "Ship-to Email"; Text[80])
        {
            Caption = 'Email envio';
        }
        field(50004; "Nº bultos"; Integer)
        {
        }
    }
}
