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
        field(50651; "Imagen Cuenta"; MediaSet)
        {
            Caption = 'Imagen', comment = 'ESP="Imagen"';
        }
    }
}
