table 50067 "Log Impresion Reports"
{
    Caption = 'Log Impresion Reports';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Log Impresion Reports";
    LookupPageId = "Log Impresion Reports";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(10; "Report ID"; Integer)
        {
            Caption = 'Report ID';
        }
        field(11; "Report Name"; Text[100])
        {
            Caption = 'Report Name';
        }
        field(20; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(21; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
        }
        field(30; "Albaran sin detalle"; Boolean)
        {
            Caption = 'Albaran sin detalle';
        }
        field(31; Dropshipping; Boolean)
        {
            Caption = 'Dropshipping';
        }
        field(40; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(41; "Client Type"; Text[30])
        {
            Caption = 'Client Type';
        }
        field(43; Origen; Text[50])
        {
            Caption = 'Origen';
        }
        field(50; "Fecha Hora"; DateTime)
        {
            Caption = 'Fecha Hora';
        }
        field(60; Omitido; Boolean)
        {
            Caption = 'Omitido (Skip)';
        }
        field(61; Motivo; Text[100])
        {
            Caption = 'Motivo';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Doc; "Document No.")
        {
        }
        key(Rep; "Report ID", "Fecha Hora")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Fecha Hora", "Report ID", "Document No.", "User ID", Omitido)
        {
        }
    }
}
