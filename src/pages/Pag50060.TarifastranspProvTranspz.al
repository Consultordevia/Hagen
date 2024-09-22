#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50060 "Tarifas transp.- Prov-Transp-z"
{
    PageType = List;
    SourceTable = "Multitabla 3";
    SourceTableView = sorting(Tabla, Zona, "Zona transportistas", Codigo)
                      where(Tabla = const("Provincia-Transp-Zona"));

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
                field(Provincia; Rec.Provincia)
                {
                    ApplicationArea = Basic;
                }
                field("Zona transportistas-Cliente"; Rec."Zona transportistas-Cliente")
                {
                    ApplicationArea = Basic;
                }
                field("Transportista-Cliente"; Rec."Transportista-Cliente")
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

