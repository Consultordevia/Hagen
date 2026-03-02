report 50002 FacturaExcel
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Excel;
    ExcelLayout = './Layouts/FacturaExcel.xlsx';

    dataset
    {
        dataitem(SalesInvHeader; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";

            column(Factura_Nº; "No.") { }
            column(Fecha_Factura; "Posting Date") { }

            dataitem(SalesInvLine; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");

                column(Nº; "No.") { }
                column(Gtin; GtinTxt) { }
                column(Descripción; Description) { }
                column(Cantidad; Quantity) { }
                column(Cód_unidad_medida; "Unit of Measure Code") { }
                column(Precio_venta_excl_IVA; "Unit Price") { }
                column(Descuento_línea; "Line Discount %") { }
                column(Precio_Neto; NetUnitPrice) { }
                column(Importe_línea_excl_IVA; "Line Amount") { }
                column(Tipo_de_IVA; "VAT Identifier") { }

                trigger OnAfterGetRecord()
                begin
                    if Quantity <> 0 then
                        NetUnitPrice := "Line Amount" / Quantity
                    else
                        NetUnitPrice := 0;

                    Clear(GtinTxt);
                    if "No." <> '' then begin
                        if Item.Get("No.") then
                            GtinTxt := Item.GTIN;
                    end;
                end;
            }
        }
    }

    var
        NetUnitPrice: Decimal;
        Item: Record Item;
        GtinTxt: Text[30];
}
