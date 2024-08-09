#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50029 "Mul.atributos"
{

    fields
    {
        field(1; Tabla; Option)
        {
            OptionCaption = 'Atributos,Valor Atributo';
            OptionMembers = Atributos,"Valor Atributo";
        }
        field(2; Codigo1; Code[20])
        {
        }
        field(3; Codigo2; Code[20])
        {
        }
        field(4; "Descripción"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; Tabla, Codigo1, Codigo2)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Codigo1, Codigo2, "Descripción")
        {
        }
        fieldgroup(Brick; Codigo1, Codigo2, "Descripción")
        {
        }
    }
}

