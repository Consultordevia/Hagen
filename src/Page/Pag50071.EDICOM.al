#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50071 EDICOM
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Cajas por envio";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Nfac;Rec.Nfac)
                {
                    ApplicationArea = Basic;
                }
                field(nlin;Rec.nlin)
                {
                    ApplicationArea = Basic;
                }
                field(Producto;Rec.Producto)
                {
                    ApplicationArea = Basic;
                }
                field("Caja num";Rec."Caja num")
                {
                    ApplicationArea = Basic;
                }
                field(Cantidad;Rec.Cantidad)
                {
                    ApplicationArea = Basic;
                }
                field(Descripcion;Rec.Descripcion)
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad incial";Rec."Cantidad incial")
                {
                    ApplicationArea = Basic;
                }
                field(Envio;Rec.Envio)
                {
                    ApplicationArea = Basic;
                }
                field(SSCC;Rec.SSCC)
                {
                    ApplicationArea = Basic;
                }
                field("nº expedicion";Rec."nº expedicion")
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

