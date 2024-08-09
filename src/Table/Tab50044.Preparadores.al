#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50044 Preparadores
{

    fields
    {
        field(1;Preparador;Code[20])
        {
        }
        field(3;"Printer Name";Text[250])
        {
            Caption = 'Printer Name';
            TableRelation = Printer;
        }
        field(4;Nombre;Text[30])
        {
        }
        field(5;"Report ID";Integer)
        {
            Caption = 'Report ID';
            TableRelation = AllObjWithCaption."Object ID" where ("Object Type"=const(Report));

            trigger OnValidate()
            begin
                CalcFields("Report Caption");
            end;
        }
        field(6;"Report Caption";Text[250])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where ("Object Type"=const(Report),
                                                                           "Object ID"=field("Report ID")));
            Caption = 'Report Caption';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;Preparador)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

