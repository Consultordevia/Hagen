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
        // REQ-001792: el estándar suma en TotalECAmount el R.E. ACUMULADO del grupo en cada línea
        // (sale de más con varias líneas del mismo IVA) y su TotalVATAmount lleva IVA + R.E. juntos.
        // Se suman aquí, sobre la especificación, y el resumen separa la línea del R.E.
        add(Totals)
        {
            column(TotalIVA_Hagen; TotalIVA)
            {
                AutoFormatExpression = Header."Currency Code";
                AutoFormatType = 1;
            }
            column(TotalRE_Hagen; TotalRE)
            {
                AutoFormatExpression = Header."Currency Code";
                AutoFormatType = 1;
            }
        }
        modify(VATAmountLine)
        {
            trigger OnBeforePreDataItem()
            begin
                TotalIVA := 0;
                TotalRE := 0;
            end;

            trigger OnAfterAfterGetRecord()
            begin
                TotalIVA += VATAmountLine."VAT Amount";
                TotalRE += VATAmountLine."EC Amount";
            end;
        }
        modify(ReportTotalsLine)
        {
            trigger OnAfterPreDataItem()
            begin
                SepararREDelResumen();
            end;
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
        TotalIVA: Decimal;
        TotalRE: Decimal;
        ImporteRELbl: Label 'Importe RE';

    // El estándar pone en el resumen una sola línea de IVA con el R.E. dentro: se rehace con
    // esa línea sin R.E. y otra «Importe RE» justo debajo (Line No. va de 1 en 1, no hay hueco)
    local procedure SepararREDelResumen()
    var
        TempTotales: Record "Report Totals Buffer" temporary;
        AutoFormat: Codeunit "Auto Format";
        TextoIVA: Text;
        NumLinea: Integer;
    begin
        if TotalRE = 0 then
            exit;
        if not ReportTotalsLine.FindSet() then
            exit;
        repeat
            TempTotales := ReportTotalsLine;
            TempTotales.Insert();
        until ReportTotalsLine.Next() = 0;
        ReportTotalsLine.DeleteAll();

        TextoIVA := VATAmountLine.VATAmountText();
        TempTotales.FindSet();
        repeat
            // La línea «... (DL)» la pone el estándar porque compara el IVA en DL con el IVA + R.E.;
            // en un abono en euros, con el R.E. ya aparte, repite el IVA
            if (Header."Currency Code" = '') and TempTotales."Font Underline" and
               (TempTotales.Description <> TextoIVA) and TempTotales.Description.StartsWith(TextoIVA)
            then
                continue;
            NumLinea += 1;
            ReportTotalsLine := TempTotales;
            ReportTotalsLine."Line No." := NumLinea;
            if TempTotales."Font Underline" and (TempTotales.Description = TextoIVA) then begin
                ReportTotalsLine.Amount := TempTotales.Amount - TotalRE;
                ReportTotalsLine."Amount Formatted" := Format(ReportTotalsLine.Amount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));
                ReportTotalsLine.Insert();
                NumLinea += 1;
                ReportTotalsLine := TempTotales;
                ReportTotalsLine."Line No." := NumLinea;
                ReportTotalsLine.Description := ImporteRELbl;
                ReportTotalsLine.Amount := TotalRE;
                ReportTotalsLine."Amount Formatted" := Format(TotalRE, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));
            end;
            ReportTotalsLine.Insert();
        until TempTotales.Next() = 0;
    end;
}
