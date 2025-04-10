table 50054 LogFicherosAdaia
{
    Caption = 'Log Ficheros Adaia';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Expedicion; Code[20])
        {
            Caption = 'Expedicion';
        }
        field(2; Fichero; Blob)
        {
            Caption = 'Fichero';
        }
        field(3; Subido; Boolean)
        {
            Caption = 'Subido';
        }
        field(4; Error; Boolean)
        {
            Caption = 'Error';
        }
    }
    keys
    {
        key(PK; Expedicion)
        {
            Clustered = true;
        }
    }
}
