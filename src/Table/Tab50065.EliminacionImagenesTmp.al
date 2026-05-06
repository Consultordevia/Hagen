table 50065 "Eliminacion Imagenes Tmp"
{
    TableType = Temporary;
    Caption = 'Eliminación imágenes (temporal)';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Nº producto';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Descripción';
        }
        field(3; "Has Picture"; Boolean)
        {
            Caption = 'Tiene imagen';
        }
    }

    keys
    {
        key(PK; "Item No.") { Clustered = true; }
    }
}
