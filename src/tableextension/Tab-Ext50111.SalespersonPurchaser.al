tableextension 50111 SalespersonPurchaser extends "Salesperson/Purchaser"
{
    fields
    {
        field(50000; "Estado vendedor"; Option)
        {
            OptionCaption = 'Activo,Retirado';
            OptionMembers = Activo,Retirado;
        }
        field(50001; Importe; Decimal)
        {
        }
        field(50002; "Importe Acumulado Dto."; Decimal)
        {
            CalcFormula = sum("Sales Line"."Importe dto. vendedor" where("Document Type" = const(Order),
                                                                          Vendedor = field(Code),
                                                                          "Fecha alta" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50003; "Comision ROJO"; Decimal)
        {
        }
        field(50004; "Comision MORADO"; Decimal)
        {
        }
        field(50005; "Comision AMARILLO"; Decimal)
        {
        }
        field(50006; "Comision AZUL"; Decimal)
        {
        }
        field(50007; "Comision VERDE"; Decimal)
        {
        }
        field(50008; "Comision impagado"; Decimal)
        {
        }
        field(50009; "Clave Web"; Text[50])
        {
            Description = 'WEB1.00';
        }
        field(50010; "E-Mail Web"; Text[80])
        {
        }
        field(50011; "Comision ROJO Hagen"; Decimal)
        {
        }
        field(50012; "Comision MORADO Hagen"; Decimal)
        {
        }
        field(50013; "Comision AMARILLO Hagen"; Decimal)
        {
        }
        field(50014; "Comision AZUL Hagen"; Decimal)
        {
        }
        field(50015; "Comision VERDE Hagen"; Decimal)
        {
        }
        field(50016; "Comision ROJO NO Hagen"; Decimal)
        {
        }
        field(50017; "Comision MORADO NO Hagen"; Decimal)
        {
        }
        field(50018; "Comision AMARILLO NO Hagen"; Decimal)
        {
        }
        field(50019; "Comision AZUL NO Hagen"; Decimal)
        {
        }
        field(50020; "Comision VERDE NO Hagen"; Decimal)
        {
        }
        field(50021; "% Comisión Hagen"; Decimal)
        {
        }
        field(50022; "% Comisión NO Hagen"; Decimal)
        {
        }
        field(50023; "Importe Venta Anterior"; Decimal)
        {
        }
        field(50024; "Importe Objetivo Anterior"; Decimal)
        {
        }
        field(50025; "Importe Venta Actual"; Decimal)
        {
        }
        field(50026; "Importe Objetivo Actual"; Decimal)
        {
        }
        field(50027; "Minimo objetivo plus"; Decimal)
        {
        }
        field(50028; Autonomo; Boolean)
        {
        }
        field(50029; "Importe Acumulado Dto.2"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Importe dto. vendedor" where("Document Type" = const(Order),
                                                                          Vendedor = field(Code),
                                                                          "Fecha alta" = field("Date Filter")));
            FieldClass = FlowField;
        }
    }
}
