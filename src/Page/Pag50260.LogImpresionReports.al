page 50260 "Log Impresion Reports"
{
    Caption = 'Log Impresion Reports';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Log Impresion Reports";
    Editable = false;
    SourceTableView = sorting("Entry No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Fecha Hora"; Rec."Fecha Hora") { ApplicationArea = All; }
                field("Report ID"; Rec."Report ID") { ApplicationArea = All; }
                field("Report Name"; Rec."Report Name") { ApplicationArea = All; }
                field("Document No."; Rec."Document No.") { ApplicationArea = All; }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.") { ApplicationArea = All; }
                field("Albaran sin detalle"; Rec."Albaran sin detalle") { ApplicationArea = All; }
                field(Dropshipping; Rec.Dropshipping) { ApplicationArea = All; }
                field(Omitido; Rec.Omitido) { ApplicationArea = All; }
                field(Motivo; Rec.Motivo) { ApplicationArea = All; }
                field(Origen; Rec.Origen) { ApplicationArea = All; }
                field("User ID"; Rec."User ID") { ApplicationArea = All; }
                field("Client Type"; Rec."Client Type") { ApplicationArea = All; }
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; }
            }
        }
    }
}
