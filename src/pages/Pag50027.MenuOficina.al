#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50027 "Menu Oficina"
{
    Caption = 'Menu Oficina';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                part(Control1901851508;"Pantalla Oficina")
                {
                    AccessByPermission = TableData "Sales Shipment Header"=R;
                    ApplicationArea = Basic,Suite;
                    Caption = 'Pantalla Oficina';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Etiquetas ECI")
            {
                ApplicationArea = Basic;
                RunObject = Page "Lineas EDI - ECI";
            }
        }
    }
}

