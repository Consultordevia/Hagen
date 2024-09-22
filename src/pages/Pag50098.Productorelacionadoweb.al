#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50098 "Producto relacionado web"
{
    PageType = List;
    SourceTable = "Multitabla 2";
    SourceTableView = where(Tabla=const("Relacionado web"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Tabla;Rec.Tabla)
                {
                    ApplicationArea = Basic;
                }
                field("Código 1";Rec."Código 1")
                {
                    ApplicationArea = Basic;
                }
                field("Código 2";Rec."Código 2")
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

