table 50061 ClasificacionComercial
{
    Caption = 'Clasificacion Comercial';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Vendedor; Code[20])
        {
            Caption = 'Vendedor';
            TableRelation = "Salesperson/Purchaser";
        }
        field(2; Verde; Decimal)
        {
            Caption = 'Verde';
        }
        field(3; Azul; Decimal)
        {
            Caption = 'Azul';
        }
        field(4; Rojo; Decimal)
        {
            Caption = 'Rojo';
        }

        field(5; NombreComercial; Text[100])
        {
            Caption = 'Nombre Comercial';
            FieldClass = FlowField;
            CalcFormula = lookup("Salesperson/Purchaser".Name where(Code = field(Vendedor)));
        }


    }
    keys
    {
        key(PK; Vendedor)
        {
            Clustered = true;
        }
    }
}
