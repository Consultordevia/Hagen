#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50006 "Comisiones por grupo"
{
    Caption = 'Comisiones por grupo';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            TableRelation = "Customer Discount Group";
        }
        field(2; Description; Text[100])
        {
            CalcFormula = lookup("Customer Discount Group".Description where(Code = field(Code)));
            Caption = 'Description';
            FieldClass = FlowField;
        }
        field(3; Desde; Date)
        {
        }
        field(4; "Reducción Tasa"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Code", Desde)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "Code", Description)
        {
        }
    }

}

