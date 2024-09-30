#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50040 "Relacion trasnpor-provincia"
{
    PageType = List;
    SourceTable = "Tarifas Transportistas";
    SourceTableView = sorting(Opcion, Transportista, "Cod. provincia", Poblacion, Zona, "Hasta Peso")
                      where(Opcion = const(Cabecera));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Transportista; Rec.Transportista)
                {
                    ApplicationArea = Basic;
                }
                field("Cod. provincia"; Rec."Cod. provincia")
                {
                    ApplicationArea = Basic;
                }
                field(Provincia; Rec.Provincia)
                {
                    ApplicationArea = Basic;
                }
                field(Zona; Rec.Zona)
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

