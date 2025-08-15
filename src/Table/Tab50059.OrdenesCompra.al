table 50059 OrdenesCompra
{
    Caption = 'OrdenesCompra';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Integer)
        {
            Caption = 'Id';
            AutoIncrement = true;
        }
        field(2; Col1; Code[100])
        {
            Caption = 'Col1';
        }
        field(3; Col2; Code[100])
        {
            Caption = 'Col2';
        }
        field(4; Col3; Code[100])
        {
            Caption = 'Col3';
        }
        field(5; Col4; Code[100])
        {
            Caption = 'Col4';
        }
        field(6; Col5; Code[100])
        {
            CAption = 'Col5';
        }
        field(7; Col6; Code[100])
        {
            CAption = 'Col6';
        }
        field(8; Col7; Code[100])
        {
            CAption = 'Col7';
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
