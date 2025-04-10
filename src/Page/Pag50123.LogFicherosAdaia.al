page 50123 LogFicherosAdaia
{
    ApplicationArea = All;
    Caption = 'Log Ficheros Adaia';
    PageType = List;
    SourceTable = LogFicherosAdaia;
    UsageCategory = Administration;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Expedicion; Rec.Expedicion)
                {
                    ToolTip = 'Specifies the value of the Expedicion field.', Comment = '%';
                }
                field(Subido; Rec.Subido)
                {
                    ToolTip = 'Specifies the value of the Subido field.', Comment = '%';
                }
                field(Error; Rec.Error)
                {
                    ToolTip = 'Specifies the value of the Error field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
            }
            part(LogAdaiaPedidos; LogAdaiaPedidos)
            {
                SubPageLink = Expedicion = field(Expedicion);
            }
        }
    }
}
