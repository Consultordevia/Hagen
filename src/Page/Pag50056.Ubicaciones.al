#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50056 Ubicaciones
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Multitabla;
    SourceTableView = sorting(Tabla, Codigo)
                      where(Tabla = const(Ubicaciones));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Producto; Rec.Producto)
                {
                    ApplicationArea = Basic;
                }
                field("Descripción"; Rec.Descripcion)
                {
                    ApplicationArea = Basic;
                }
                field(Ubicacion; Rec.Ubicacion)
                {
                    ApplicationArea = Basic;
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = Basic;
                }
                field("Fecha caducidad"; Rec."Fecha caducidad")
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

