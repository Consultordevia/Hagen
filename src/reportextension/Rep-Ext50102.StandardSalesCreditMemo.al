reportextension 50102 StandardSalesCreditMemo extends "Standard Sales - Credit Memo"
{
    WordLayout = './src/ReportExtension/Layouts/StandardSalesCreditMemo.docx';
    dataset
    {
        add(Header)
        {
            column("N_expedición"; '"Nº expedición"') { }
        }
        add(Line)
        {
            column(Precio_base; FormattedPrecioBase) { }
            column(Dto_2009; FormattedDto_2009) { }
            column(Precio_final; FormattedPrecio_final) { }
            column(Ean; ean) { }
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            var
                item: Record Item;
            begin
                dif := 0;
                if "Line"."Precio base" <> "Line"."Unit Price" then begin
                    IF "Line"."Precio base" <> 0 THEN BEGIN
                        if "Line"."Line Discount %" = 0 then begin
                            dif := round((("Line"."Precio base" - "Line"."Unit Price") * 100) / ("Line"."Precio base"), 0.01);
                            "Line"."Line Discount %" := dif;
                        end;
                    END;
                end;

                //NETO := 0;
                if "Line".Quantity <> 0 then begin
                    "Precio final" := round("Line".Amount / "Line".Quantity, 0.01);
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

                if Ean = '' then begin
                    if item.get(Line."No.") then
                        Ean := Item.ean;
                end;

            end;
        }
    }
    var
        ean: code[20];
        FormattedPrecioBase: text;
        FormattedDto_2009: text;
        FormattedPrecio_final: text;
        dif: Decimal;


}
