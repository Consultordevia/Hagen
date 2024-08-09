tableextension 50045 "Value Entry" extends "Value Entry"
{
    fields
    {
        field(50000; "Exento rappel"; Boolean)
        {
        }
        field(50001; "Importe coste real FIFO"; Decimal)
        {
        }
        field(50002; "Al coste"; Decimal)
        {
        }
        field(50003; "Liq. de"; Code[100])
        {
        }
        field(50004; "A MODIFICAR"; Boolean)
        {
        }
        field(50005; "DATO ANTERIOR COSTE"; Decimal)
        {
        }
        field(50006; "IMPORTE ANT. COSTE"; Decimal)
        {
        }
        field(50007; "Pedido WEB"; Boolean)
        {
        }
        field(50008; "usuario alta"; Code[30])
        {
            CalcFormula = lookup("Sales Invoice Line"."Usuario alta" where("Document No." = field("Document No."),
                                                                            "Line No." = field("Document Line No.")));
            FieldClass = FlowField;
        }
        field(50039; "Dto% cabecera"; Decimal)
        {
            Editable = false;
        }
        field(50040; "Cod. Oferta"; Code[12])
        {
            Editable = false;
        }
        field(50041; "Coste KIT"; Decimal)
        {
        }
        field(50042; "Coste KIT Agregado"; Decimal)
        {
        }
        field(50043; TRANS; Code[20])
        {
            CalcFormula = lookup(Customer."Shipping Agent Code" where("No." = field("Source No.")));
            FieldClass = FlowField;
        }
        field(50050; "Standard Cost"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = lookup(Item."Standard Cost" where("No." = field("Item No.")));
            Caption = 'Standard Cost';
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(50051; "cosye 2009"; Decimal)
        {
            CalcFormula = lookup(Item."Precio inv 2009" where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50052; "Unit Cost (LCY) fac"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = lookup("Purch. Inv. Line"."Unit Cost (LCY)" where("Document No." = field("Document No."),
                                                                             "No." = field("Item No.")));
            Caption = 'Unit Cost (LCY)';
            FieldClass = FlowField;
        }
    }
}
