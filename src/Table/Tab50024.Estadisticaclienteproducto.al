#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50024 "Estadistica cliente producto"
{
    Caption = 'Estadistica cliente producto';

    fields
    {
        field(1;"Item No.";Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(2;Amount;Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(3;"Amount 2";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount 2';
        }
        field(4;Cliente;Code[29])
        {
        }
    }

    keys
    {
        key(Key1;"Item No.",Cliente)
        {
            Clustered = true;
        }
        key(Key2;Cliente,Amount)
        {
        }
    }

    fieldgroups
    {
    }
}

