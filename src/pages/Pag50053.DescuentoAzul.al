#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50053 "Descuento Azul"
{
    PageType = List;
    SourceTable = "Objetivos vendedores";
    SourceTableView = where(Tipo = const(Descuento));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Código"; Rec.Código)
                {
                    ApplicationArea = Basic;
                }
                field("Año"; Rec.Año)
                {
                    ApplicationArea = Basic;
                }
                field(Enero; Rec.Enero)
                {
                    ApplicationArea = Basic;
                }
                field(Febrero; Rec.Febrero)
                {
                    ApplicationArea = Basic;
                }
                field(Marzo; Rec.Marzo)
                {
                    ApplicationArea = Basic;
                }
                field(Abril; Rec.Abril)
                {
                    ApplicationArea = Basic;
                }
                field(Mayo; Rec.Mayo)
                {
                    ApplicationArea = Basic;
                }
                field(Junio; Rec.Junio)
                {
                    ApplicationArea = Basic;
                }
                field(Julio; Rec.Julio)
                {
                    ApplicationArea = Basic;
                }
                field(Agosto; Rec.Agosto)
                {
                    ApplicationArea = Basic;
                }
                field(Septiembre; Rec.Septiembre)
                {
                    ApplicationArea = Basic;
                }
                field(Octubre; Rec.Octubre)
                {
                    ApplicationArea = Basic;
                }
                field(Noviembre; Rec.Noviembre)
                {
                    ApplicationArea = Basic;
                }
                field(Diciembre; Rec.Diciembre)
                {
                    ApplicationArea = Basic;
                }
                field(Anual; Rec.Anual)
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

