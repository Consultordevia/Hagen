page 50261 "Setup Log Reports"
{
    Caption = 'Setup Log Reports';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Setup Log Reports";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(Prueba)
            {
                Caption = 'Modo prueba';
                field("Desactivar Impresion"; Rec."Desactivar Impresion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Si está activado, la cola 50017 y los informes de albarán NO imprimen: solo registran en el Log Impresion Reports.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(VerLog)
            {
                ApplicationArea = All;
                Caption = 'Ver Log de impresiones';
                Image = Log;
                RunObject = page "Log Impresion Reports";
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.GetSetup();
    end;
}
