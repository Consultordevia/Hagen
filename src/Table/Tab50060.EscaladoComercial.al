table 50060 EscaladoComercial
{
    Caption = 'Escalado Comercial';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Vendedor; Code[20])
        {
            Caption = 'Vendedor';
            TableRelation = "Salesperson/Purchaser";
        }
        field(2; Desde; Decimal)
        {
            Caption = 'Desde';
        }
        field(3; Hasta; Decimal)
        {
            Caption = 'Hasta';
        }
        field(4; NombreComercial; Text[100])
        {
            Caption = 'Nombre Comercial';
            FieldClass = FlowField;
            CalcFormula = lookup("Salesperson/Purchaser".Name where(Code = field(Vendedor)));
        }
        field(5; Comision; Decimal)
        {
            Caption = 'Comision';
        }


    }
    keys
    {
        key(PK; Vendedor, Desde, Hasta)
        {
            Clustered = true;
        }
    }
}
