table 50058 ConsolaFicheros
{
    Caption = 'Consola Ficheros';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Integer)
        {
            Caption = 'Id';
            AutoIncrement = true;
        }
        field(2; NombreFichero; Code[75])
        {
            Caption = 'NombreFichero';
        }
        field(3; URL; Code[250])
        {
            Caption = 'URL';
        }
        field(4; Fichero; Blob)
        {
            Caption = 'Fichero';
        }
        field(5; DesdeDondeSeGuarda; Code[75])
        {
            Caption = 'Se guarda desde';
        }
        field(6; Error; Boolean)
        {
            CAption = 'Error';
        }
        field(7; DescripcionError; Text[2048])
        {
            Caption = ' Descripción del error';
        }
    }
    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
    }
}
