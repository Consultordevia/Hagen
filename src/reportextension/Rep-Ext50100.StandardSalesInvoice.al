reportextension 50100 StandardSalesInvoice extends "Standard Sales - Invoice"
{
    WordLayout = './src/ReportExtension/Layouts/prueba.docx';

    dataset
    {
        add(Header)
        {
            column("N_expedición"; "Nº expedición") { }
        }
        add(Line)
        {
            column(Precio_base; FormattedPrecioBase)
            {
            }
            column(Dto_2009; FormattedDto_2009) { }
            column(Precio_final; FormattedPrecio_final)
            {
            }
            column(Ean; Ean) { }
        }
        // REQ-001792: el estándar hace TotalECAmount := (no +=) en cada línea y el total del
        // R.E. sale con el importe de un solo tipo de IVA. Se suma aquí, sobre la especificación.
        add(Totals)
        {
            column(TotalRE_Hagen; TotalRE)
            {
                AutoFormatExpression = Header."Currency Code";
                AutoFormatType = 1;
            }
        }
        addafter(Totals)
        {
            // Solo tiene registro si la factura lleva R.E.: así la línea del resumen no sale en las demás
            dataitem(ResumenRE_Hagen; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(ResumenRE_Lbl; ImporteRELbl) { }
                column(ResumenRE_Importe; TotalRE)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }

                trigger OnPreDataItem()
                begin
                    if TotalRE = 0 then
                        CurrReport.Break();
                end;
            }
        }
        modify(VATAmountLine)
        {
            trigger OnBeforePreDataItem()
            begin
                TotalRE := 0;
            end;

            trigger OnAfterAfterGetRecord()
            begin
                TotalRE += VATAmountLine."EC Amount";
            end;
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            begin
                dtofac := '';
                if Line."Inv. Discount Amount" <> 0 then begin
                    dtofac := '+dto.fac.';
                end;
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
                    "Precio final" := round("Line".Amount / "Line".Quantity, 0.01);
                end;

                if not Line.HasTypeToFillMandatoryFields() then begin
                    FormattedPrecioBase := '';
                    FormattedDto_2009 := '';
                    FormattedPrecio_final := '';
                end else begin
                    FormattedPrecioBase := Format("Precio base", 0, '<Precision,2:2><Standard Format,0>');
                    FormattedDto_2009 := Format("Line Discount %") + dtofac;
                    FormattedPrecio_final := Format("Precio final", 0, '<Precision,2:2><Standard Format,0>');
                end;




            end;
        }
    }
    var
        FormattedPrecioBase: text;
        FormattedDto_2009: text;
        FormattedPrecio_final: text;
        dif: Decimal;
        dtofac: code[20];
        TotalRE: Decimal;
        ImporteRELbl: Label 'Importe RE';
}
