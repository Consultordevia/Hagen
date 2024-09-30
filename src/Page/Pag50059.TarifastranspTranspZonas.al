#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50059 "Tarifas transp.- Transp-Zonas"
{
    PageType = List;
    SourceTable = "Multitabla 3";
    SourceTableView = sorting(Tabla, Zona, "Zona transportistas", Codigo)
                      where(Tabla = const("Transportistas-Zonas"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Tabla; Rec.Tabla)
                {
                    ApplicationArea = Basic;
                }
                field("Zona transportistas"; Rec."Zona transportistas")
                {
                    ApplicationArea = Basic;
                }
                field(Transportista; Rec.Transportista)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

