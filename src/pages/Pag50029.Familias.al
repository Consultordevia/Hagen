#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50029 Familias
{

    PageType = List;
    SourceTable = Familias;

    layout
    {

        area(content)
        {
            repeater(Group)
            {


                field("Línea"; Rec.Línea)
                {
                    ApplicationArea = Basic;
                }
                field(Familia; Rec.Familia)
                {
                    ApplicationArea = Basic;
                }
                field(Subfamilia; Rec.Subfamilia)
                {
                    ApplicationArea = Basic;
                }
                field(Cod; Rec.Cod)
                {
                    ApplicationArea = Basic;
                }
                field("Cod. web"; Rec."Cod. web")
                {
                    ApplicationArea = Basic;
                }
                field("Actualizar WEB"; Rec."Actualizar WEB")
                {
                    ApplicationArea = Basic;
                }
                field("Id PS Familia"; Rec."Id PS Familia")
                {
                    ApplicationArea = Basic;
                }
                field("Id PS Subfamilia"; Rec."Id PS Subfamilia")
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

