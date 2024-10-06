#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50043 "Amazon master_inner"
{
    Caption = 'Amazon master_inner';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(50051; "Cantidad master"; Decimal)
        {
        }
        field(50052; "Cantidad inner"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {

    }

    var
        Text000: label 'must be greater than 0';
        Item: Record Item;
        RecA: Record "Item Unit of Measure";
        RecUMPepe: Record "Item Unit of Measure";
        //RecRC: Record "Item Cross Reference";
        //RecRC2: Record "Item Cross Reference";
        RecItem: Record Item;
        CUADAIA: Codeunit "Automaticos Cartas";
        xx: Integer;
        Rec1: Record "Item Unit of Measure";
        Item2: Record Item;
        Item3: Record Item;
        RecItemPepe: Record Item;
        RecCE: Record "Inventory Setup";
        Text001: label 'You cannot rename %1 %2 for item %3 because it is the item''s %4 and there are one or more open ledger entries for the item.';
        CannotModifyBaseUnitOfMeasureErr: label 'You cannot modify %1 %2 for item %3 because it is the item''s %4.', Comment = '%1 Table name (Item Unit of measure), %2 Value of Measure (KG, PCS...), %3 Item ID, %4 Base unit of Measure';
        CannotModifyUnitOfMeasureErr: label 'You cannot modify %1 %2 for item %3 because non-zero %5 with %2 exists in %4.', Comment = '%1 Table name (Item Unit of measure), %2 Value of Measure (KG, PCS...), %3 Item ID, %4 Entry Table Name, %5 Field Caption';
        CannotModifyUOMWithWhseEntriesErr: label 'You cannot modify %1 %2 for item %3 because there are one or more warehouse adjustment entries for the item.', Comment = '%1 = Item Unit of Measure %2 = Code %3 = Item No.';
}

