tableextension 50102 BOMComponent extends "BOM Component"
{
    fields
    {
        field(50000; "Cod. transportista"; Code[10])
        {
        }
        field(50001; Pesos; Decimal)
        {
        }
        field(50002; "Kilos/vol"; Decimal)
        {
        }
        field(50003; "Kilos/tarifa"; Decimal)
        {
        }
        field(50004; Euros; Decimal)
        {
        }
        field(50005; Optimo; Boolean)
        {
        }
        field(50010; Desde; Date)
        {

            trigger OnValidate()
            begin

                if Hasta = 0D then begin
                    Hasta := Today;
                end;
            end;
        }
        field(50011; Hasta; Date)
        {

            trigger OnValidate()
            begin

                if Desde <> 0D then begin
                    if Hasta = 0D then begin
                        Hasta := Today;
                    end;
                end;
            end;
        }
        field(50012; "% descuento"; Decimal)
        {
        }
        field(50013; "NO imprimir en albaran"; Boolean)
        {
        }
        field(50014; "NO imprimir en factura"; Boolean)
        {
        }
    }
}
