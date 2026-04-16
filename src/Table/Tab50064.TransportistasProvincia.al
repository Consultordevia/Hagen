#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50064 "Transportistas Provincia"
{
    Caption = 'Transportistas por Provincia';
    DataClassification = CustomerContent;
    LookupPageId = "Transportistas por Provincia";
    DrillDownPageId = "Transportistas por Provincia";

    fields
    {
        field(1; "Cod. Pais"; Code[10])
        {
            Caption = 'Cód. País';
            TableRelation = "Country/Region";
            NotBlank = true;
            trigger OnValidate()
            begin
                "Cod. Provincia" := '';
            end;
        }
        field(2; "Nombre Pais"; Text[50])
        {
            Caption = 'País';
            CalcFormula = lookup("Country/Region".Name where(Code = field("Cod. Pais")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(3; "Cod. Provincia"; Code[10])
        {
            Caption = 'Cód. Provincia';
            TableRelation = Area;
            NotBlank = true;
        }
        field(4; Provincia; Text[50])
        {
            Caption = 'Provincia';
            CalcFormula = lookup(Area.Text where(Code = field("Cod. Provincia")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(5; "Cod. Transportista"; Code[10])
        {
            Caption = 'Cód. Transportista';
            TableRelation = "Shipping Agent";
            NotBlank = true;
        }
        field(6; "Nombre Transportista"; Text[50])
        {
            Caption = 'Nombre Transportista';
            CalcFormula = lookup("Shipping Agent".Name where(Code = field("Cod. Transportista")));
            FieldClass = FlowField;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Cod. Pais", "Cod. Provincia")
        {
            Clustered = true;
        }
    }
}
