#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50047 "Tarifas transportistas"
{
    PageType = List;
    SourceTable = "Tarifas Transportistas";
    SourceTableView = sorting(Opcion, Transportista, "Cod. provincia", Poblacion, Zona, "Hasta Peso")
                      where(Opcion = const(Linea));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Opcion; Rec.Opcion)
                {
                    ApplicationArea = Basic;
                }
                field(Transportista; Rec.Transportista)
                {
                    ApplicationArea = Basic;
                }
                field(Zona; Rec.Zona)
                {
                    ApplicationArea = Basic;
                }
                field("Hasta Peso"; Rec."Hasta Peso")
                {
                    ApplicationArea = Basic;
                }
                field(Importe; Rec.Importe)
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

