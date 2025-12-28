table 50063 BonusMalos
{
    Caption = 'Bonus Malos';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Vendedor; Code[20])
        {
            Caption = 'Vendedor';
            TableRelation = "Salesperson/Purchaser";
        }
        field(2; Incremento; Decimal)
        {
            Caption = 'Incremento Objetivo';
        }
        field(3; Aumento; Decimal)
        {
            Caption = 'Aumento Comision';
        }
        field(4; NombreComercial; Text[100])
        {
            Caption = 'Nombre Comercial';
            FieldClass = FlowField;
            CalcFormula = lookup("Salesperson/Purchaser".Name where(Code = field(Vendedor)));
        }


    }
    keys
    {
        key(PK; Vendedor, Incremento, Aumento)
        {
            Clustered = true;
        }
    }
}
