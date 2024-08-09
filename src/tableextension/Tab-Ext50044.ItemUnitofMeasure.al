tableextension 50044 ItemUnitofMeasure extends "Item Unit of Measure"
{
    fields
    {
        field(50000; Description; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Caption = 'Description';
            FieldClass = FlowField;
        }
        field(50001; ean; Code[20])
        {


        }
        field(50002; EXISTE; Boolean)
        {
            CalcFormula = exist(Item where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50003; "enviar a adaia"; Boolean)
        {
        }
        field(50004; "ean PROD"; Code[20])
        {
            CalcFormula = lookup(Item.ean where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50005; EXISTE2; Boolean)
        {
            CalcFormula = exist("Item Reference" where("Item No." = field("Item No."),
                                                              "Unit of Measure" = field(Code),
                                                              "Reference Type" = const("Bar Code")));
            FieldClass = FlowField;
        }
        field(50006; "Kgs/Volumen WEB"; Decimal)
        {
        }
        field(50007; "fecha modif"; Date)
        {
        }
    }
}
