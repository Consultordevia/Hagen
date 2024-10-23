tableextension 50027 ShiptoAddress extends "Ship-to Address"
{
    fields
    {
        field(50000; "Direccion habitual"; Boolean)
        {
        }
        field(50001; "Direccion postal"; Boolean)
        {
        }
        field(50002; "Transportista ficha cliente"; Code[10])
        {
            CalcFormula = lookup(Customer."Shipping Agent Code" where("No." = field("Customer No.")));
            FieldClass = FlowField;
        }
        field(50003; Dropshipping; Boolean)
        {
        }
        field(50004; "Direccion Ruta"; Boolean)
        {
        }
        field(50054; "Estatus del cliente"; Option)
        {
            CalcFormula = lookup(Customer."Estatus del cliente" where("No." = field("Customer No.")));
            FieldClass = FlowField;
            OptionMembers = Activo,"Posible cliente",Transformado,Cerrado;
        }
        field(50055; "Cod. forma de pago"; Code[10])
        {
            CalcFormula = lookup(Customer."Payment Method Code" where("No." = field("Customer No.")));
            FieldClass = FlowField;
        }
        field(50056; "Salesperson Code2"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50057; "Cod. entrega ECI"; Code[2])
        {
        }
        field(50058; "Filtro ECI"; Code[10])
        {
        }
        field(50140; Latitud; Text[50])
        {

            trigger OnValidate()
            begin

                ///ActualizazaMT2;
            end;
        }
        field(50141; Longitud; Text[50])
        {

            trigger OnValidate()
            begin

                ///ActualizazaMT2;
            end;
        }
        field(60000; "Nº Movil"; Text[30])
        {
        }
        field(60001; Dni; Text[30])
        {
        }
    }
}
