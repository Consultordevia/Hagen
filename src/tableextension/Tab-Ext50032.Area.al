tableextension 50032 "Area" extends "Area"
{
    fields
    {
        field(50000; Comunidad; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const("Comunidades autonomas"));

            trigger OnValidate()
            begin
                /////CALCFIELDS("Nombre comunidad");
                /////"Nombre comunidad G":="Nombre comunidad";
            end;
        }
        field(50001; "Nombre comunidad"; Text[50])
        {
            CalcFormula = lookup(Multitabla.Descripcion where(Tabla = const("Comunidades autonomas"),
                                                               Codigo = field(Comunidad)));
            FieldClass = FlowField;
        }
        field(50002; "Id Estado PrestaShop"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50003; "Chequeo control provincia"; Boolean)
        {
        }
        field(50004; "Nombre comunidad G"; Text[30])
        {
        }
        field(50005; "Pais PrestaShop"; Code[10])
        {
            Description = 'Web';
            TableRelation = "Country/Region".Code;
        }
        field(50006; "Provincia shopyfi"; Code[20])
        {
        }
        field(50007; "Pais shopyfi"; Code[10])
        {
        }
    }
}
