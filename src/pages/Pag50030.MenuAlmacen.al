#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50030 "Menu Almacen"
{
    Caption = 'Menu Almacen';
    PageType = RoleCenter;
    UsageCategory = Lists;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                part(Control1901851508; "Almacen Datos")
                {
                    AccessByPermission = TableData "Sales Shipment Header" = R;
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Lista Ubicaciones")
            {
                ApplicationArea = Basic;
                RunObject = Page "Productos Lista ubicaciones";
            }
            action("Etiquetas ECI")
            {
                ApplicationArea = Basic;
                RunObject = Page "Lineas EDI - ECI";
            }
            action("Etiquetas EDI")
            {
                ApplicationArea = Basic;
                ///                RunObject = Page "Lineas Albaran EDI";
            }
            action("Modifica expedicion")
            {
                ApplicationArea = Basic;
                RunObject = Page Modifica;
            }
            action("Pantalla de carga")
            {
                ApplicationArea = Basic;
                RunObject = Page "Listado carga";
            }
        }
    }

    var
    ///Automaticosvarios: Codeunit UnknownCodeunit50010;
}

