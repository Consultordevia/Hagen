tableextension 50003 "G/LAccount" extends "G/L Account"
{
    fields
    {
        field(53002; "Linea Retencion IRPF"; Boolean)
        {
        }
        field(50650; Advance; Boolean)
        {
            Caption = 'Advance', comment = 'ESP="Advance"';
            DataClassification = ToBeClassified;
        }
    }
}
