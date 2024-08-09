tableextension 50043 ItemVariant extends "Item Variant"
{
    fields
    {
        field(50000; "Ref. hagen"; Code[20])
        {
        }
        field(50001; "Ref. compe"; Code[20])
        {
        }
        field(50003; Ean; Code[20])
        {
            Caption = 'Ean';
            NotBlank = true;
        }
    }
}
