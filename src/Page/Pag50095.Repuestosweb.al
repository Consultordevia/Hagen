#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50095 "Repuestos web"
{
    PageType = List;
    SourceTable = "Multitabla 2";
    SourceTableView = where(Tabla = const("Repuestos web"));
    ApplicationArea = all;
    UsageCategory = Lists;

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
                field("Codigo 1"; Rec."Codigo 1")
                {
                    ApplicationArea = Basic;
                }
                field("Codigo 2"; Rec."Codigo 2")
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

