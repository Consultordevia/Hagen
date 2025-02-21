reportextension 50100 StandardSalesInvoice extends "Standard Sales - Invoice"
{
    WordLayout = './src/ReportExtension/Layouts/OK Nueva Factura Venta.docx';

    dataset
    {
        add(Header)
        {
            column("N_expedición"; "Nº expedición") { }
        }
        add(Line)
        {
            column(Precio_base; FormattedPrecioBase) { }
            column(Dto_2009; FormattedDto_2009) { }
            column(Precio_final; FormattedPrecio_final) { }
            column(Ean; Ean) { }
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            begin
                dif := 0;
                if "Line"."Precio base" <> "Line"."Unit Price" then begin
                    IF "Line"."Precio base" <> 0 THEN BEGIN
                        if "Line"."Line Discount %" = 0 then begin
                            dif := round((("Line"."Precio base" - "Line"."Unit Price") * 100) / ("Line"."Precio base"), 1);
                            "Line"."Line Discount %" := dif;
                        end;
                    END;
                end;

                //NETO := 0;
                if "Line".Quantity <> 0 then begin
                    "Precio final" := "Line".Amount / "Line".Quantity;
                end;

                if not Line.HasTypeToFillMandatoryFields() then begin
                    FormattedPrecioBase := '';
                    FormattedDto_2009 := '';
                    FormattedPrecio_final := '';
                end else begin
                    FormattedPrecioBase := Format("Precio base");
                    FormattedDto_2009 := Format("Line Discount %");
                    FormattedPrecio_final := Format("Precio final");
                end;




            end;
        }
    }
    var
        FormattedPrecioBase: text;
        FormattedDto_2009: text;
        FormattedPrecio_final: text;
        dif: Decimal;
}
