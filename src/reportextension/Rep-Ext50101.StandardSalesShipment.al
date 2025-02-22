reportextension 50101 StandardSalesShipment extends "Standard Sales - Shipment"
{
    WordLayout = './src/ReportExtension/Layouts/StandardSalesShipment.docx';

    dataset
    {
        add(Header)
        {
            column("N_expedición"; "Nº expedición") { }
        }
        add(Line)
        {
            column(Precio_base; "Precio base") { }
            column(Ean; Ean) { }
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            var
                item: Record Item;
            begin
                if Line.Ean = '' then begin
                    if item.get(Line."No.") then
                        Ean := Item.ean;
                end;
            end;
        }
    }
}
