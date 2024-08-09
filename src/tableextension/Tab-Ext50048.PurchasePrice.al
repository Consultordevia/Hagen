tableextension 50048 PurchasePrice extends "Purchase Price"
{
    fields
    {
        field(50000; "% Dto1"; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                     IF "% Dto1"<>0 THEN BEGIN
                          "Direct Unit Cost":="Precio Tarifa"-ROUND("% Dto1"*"Precio Tarifa"/100,0.0001);
                     END;
                     */

            end;
        }
        field(50001; "% Dto2"; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                     IF "% Dto2"<>0 THEN BEGIN
                          "Direct Unit Cost":="Direct Unit Cost"-ROUND("% Dto2"*"Direct Unit Cost"/100,0.0001);
                     END;
                     */

            end;
        }
        field(50002; "% Dto3"; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                IF "% Dto3"<>0 THEN BEGIN
                     "Direct Unit Cost":="Direct Unit Cost"-ROUND("% Dto3"*"Direct Unit Cost"/100,0.0001);
                END;
                */

            end;
        }
        field(50003; "Precio Tarifa"; Decimal)
        {

            trigger OnValidate()
            begin
                ///"Direct Unit Cost":="Precio Tarifa";
            end;
        }
        field(50004; "Pedido Minimo"; Decimal)
        {
        }
        field(50005; "Descripción"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50022; EXISTE; Boolean)
        {
            CalcFormula = exist(Item where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
    }
}
