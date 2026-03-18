#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006
Report 50931 "Presupuesto Venta Productos"
{
    Caption = 'Presupuesto Venta con Datos Producto';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PresupuestoVentaProductos.rdlc';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Presupuesto Venta';

            column(No_Presupuesto; "No.") { }
            column(SellToCustomerNo; "Sell-to Customer No.") { }
            column(SellToCustomerName; "Sell-to Customer Name") { }
            column(SellToAddress; "Sell-to Address") { }
            column(SellToAddress2; "Sell-to Address 2") { }
            column(SellToCity; "Sell-to City") { }
            column(SellToPostCode; "Sell-to Post Code") { }
            column(SellToCounty; "Sell-to County") { }
            column(DocumentDate; "Document Date") { }
            column(DueDate; "Due Date") { }
            column(ExternalDocumentNo; "External Document No.") { }
            column(YourReference; "Your Reference") { }
            column(SalespersonCode; "Salesperson Code") { }
            column(CurrencyCode; "Currency Code") { }
            column(ShipToName; "Ship-to Name") { }
            column(ShipToAddress; "Ship-to Address") { }
            column(ShipToAddress2; "Ship-to Address 2") { }
            column(ShipToCity; "Ship-to City") { }
            column(ShipToPostCode; "Ship-to Post Code") { }
            column(CompanyName; CompanyName) { }
            column(CompanyAddress; CompanyAddr) { }
            column(CompanyPostCode; CompanyInfo."Post Code") { }
            column(CompanyCity; CompanyInfo.City) { }
            column(CompanyCounty; CompanyInfo.County) { }
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(SalespersonName; SalespersonName) { }
            column(PaymentTermsDesc; PaymentTermsDesc) { }
            column(ShipmentMethodDesc; ShipmentMethodDesc) { }


            dataitem(SalesLine; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                // Datos de la línea de presupuesto
                column(LineNo; "Line No.") { }
                column(Type; Type) { }
                column(ItemNo; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(UnitOfMeasureCode; "Unit of Measure Code") { }
                column(UnitPrice; "Unit Price") { }
                column(LineDiscountPercent; "Line Discount %") { }
                column(LineAmount; "Line Amount") { }
                column(Amount; Amount) { }
                column(AmountIncludingVAT; "Amount Including VAT") { }
                column(PrecioTarifa; "Precio Tarifa") { }

                // Datos del producto (desde Item)
                column(ItemEAN; ItemEAN) { }
                column(ItemMarca; ItemMarca) { }
                column(ItemPVP; ItemPVP) { }
                column(ItemCompraMin; ItemCompraMin) { }
                column(ItemPrecioFinal; ItemPrecioFinal) { }
                column(ItemCountryOfOrigin; ItemCountryOfOrigin) { }
                column(ItemTariffNo; ItemTariffNo) { }
                column(ItemPicture; ItemPictureBase64) { }
                column(ItemDescription; ItemDescription) { }

                // Datos logísticos del producto (unidad)
                column(ItemAlto; ItemAlto) { }
                column(ItemAncho; ItemAncho) { }
                column(ItemLargo; ItemLargo) { }
                column(ItemPeso; ItemPeso) { }
                column(ItemVolumen; ItemVolumen) { }

                // Datos Inner
                column(ItemEanInner; ItemEanInner) { }
                column(ItemCantidadInner; ItemCantidadInner) { }
                column(ItemAltoInner; ItemAltoInner) { }
                column(ItemAnchoInner; ItemAnchoInner) { }
                column(ItemLargoInner; ItemLargoInner) { }
                column(ItemPesoInner; ItemPesoInner) { }
                column(ItemVolumenInner; ItemVolumenInner) { }

                // Datos Master
                column(ItemEanMaster; ItemEanMaster) { }
                column(ItemCantidadMaster; ItemCantidadMaster) { }
                column(ItemAltoMaster; ItemAltoMaster) { }
                column(ItemAnchoMaster; ItemAnchoMaster) { }
                column(ItemLargoMaster; ItemLargoMaster) { }
                column(ItemPesoMaster; ItemPesoMaster) { }
                column(ItemVolumenMaster; ItemVolumenMaster) { }

                trigger OnAfterGetRecord()
                begin
                    ClearItemVars();

                    if (Type = Type::Item) and ("No." <> '') then begin
                        if RecItem.Get("No.") then begin
                            RecItem.CalcFields("Cantidad inner", "Cantidad master", "EAN INNER", "EAN MASTER");

                            // Imagen del producto
                            GetItemPicture(RecItem);

                            // Datos principales
                            ItemEAN := RecItem.ean;
                            ItemMarca := RecItem.Marca;
                            ItemPVP := RecItem."PVP 2025DC00";
                            ItemCountryOfOrigin := RecItem."Country/Region of Origin Code";
                            ItemTariffNo := RecItem."Tariff No.";
                            ItemDescription := RecItem.Description;

                            // Dimensiones producto unitario
                            ItemAlto := RecItem.Alto;
                            ItemAncho := RecItem.Ancho;
                            ItemLargo := RecItem.Largo;
                            ItemPeso := RecItem."Net Weight";
                            if (RecItem.Alto <> 0) and (RecItem.Ancho <> 0) and (RecItem.Largo <> 0) then
                                ItemVolumen := Round((RecItem.Alto * RecItem.Ancho * RecItem.Largo) / 1000000, 0.00001);

                            // Datos Inner
                            ItemEanInner := RecItem."EAN INNER";
                            ItemCantidadInner := RecItem."Cantidad inner";
                            ItemAltoInner := RecItem."Alto INNER";
                            ItemAnchoInner := RecItem."Ancho INNER";
                            ItemLargoInner := RecItem."Largo INNER";
                            ItemVolumenInner := RecItem."Volumen INNER";

                            // Peso Inner desde Item Unit of Measure
                            RecUMP.Reset();
                            RecUMP.SetRange("Item No.", "No.");
                            RecUMP.SetRange(Code, 'IN');
                            if RecUMP.FindFirst() then
                                ItemPesoInner := RecUMP.Weight;

                            // Datos Master
                            ItemEanMaster := RecItem."EAN MASTER";
                            ItemCantidadMaster := RecItem."Cantidad master";
                            ItemAltoMaster := RecItem."Alto master";
                            ItemAnchoMaster := RecItem."Ancho master";
                            ItemLargoMaster := RecItem."Largo master";
                            ItemVolumenMaster := RecItem."Metros Cúbicos Master";
                            ItemPesoMaster := RecItem."Kilos Master";

                            // Compra mínima y precio final
                            ItemCompraMin := RecItem."Cantidad inner";
                            ItemPrecioFinal := "Unit Price" * (1 - "Line Discount %" / 100);
                        end;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // Obtener datos de compañía
                if not CompanyInfoRead then begin
                    CompanyInfo.Get();
                    CompanyInfoRead := true;
                    CompanyInfo.CalcFields(Picture);
                    CompanyAddr := CompanyInfo.Address + ' ' + CompanyInfo."Address 2";
                end;

                // Nombre del vendedor
                SalespersonName := '';
                if "Salesperson Code" <> '' then
                    if RecSalesperson.Get("Salesperson Code") then
                        SalespersonName := RecSalesperson.Name;

                // Descripción términos de pago
                PaymentTermsDesc := '';
                if "Payment Terms Code" <> '' then
                    if RecPaymentTerms.Get("Payment Terms Code") then
                        PaymentTermsDesc := RecPaymentTerms.Description;

                // Descripción condiciones de envío
                ShipmentMethodDesc := '';
                if "Shipment Method Code" <> '' then
                    if RecShipmentMethod.Get("Shipment Method Code") then
                        ShipmentMethodDesc := RecShipmentMethod.Description;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Opciones';
                }
            }
        }
    }

    var
        RecItem: Record Item;
        RecUMP: Record "Item Unit of Measure";
        CompanyInfo: Record "Company Information";
        RecSalesperson: Record "Salesperson/Purchaser";
        RecPaymentTerms: Record "Payment Terms";
        RecShipmentMethod: Record "Shipment Method";
        CompanyInfoRead: Boolean;
        CompanyAddr: Text[250];
        SalespersonName: Text[50];
        PaymentTermsDesc: Text[100];
        ShipmentMethodDesc: Text[100];
        ItemPictureBase64: Text;

        // Variables producto
        ItemEAN: Code[20];
        ItemMarca: Code[20];
        ItemPVP: Decimal;
        ItemCompraMin: Decimal;
        ItemPrecioFinal: Decimal;
        ItemCountryOfOrigin: Code[10];
        ItemTariffNo: Code[20];
        ItemDescription: Text[100];

        // Dimensiones unitarias
        ItemAlto: Decimal;
        ItemAncho: Decimal;
        ItemLargo: Decimal;
        ItemPeso: Decimal;
        ItemVolumen: Decimal;

        // Inner
        ItemEanInner: Code[50];
        ItemCantidadInner: Decimal;
        ItemAltoInner: Decimal;
        ItemAnchoInner: Decimal;
        ItemLargoInner: Decimal;
        ItemPesoInner: Decimal;
        ItemVolumenInner: Decimal;

        // Master
        ItemEanMaster: Code[50];
        ItemCantidadMaster: Decimal;
        ItemAltoMaster: Decimal;
        ItemAnchoMaster: Decimal;
        ItemLargoMaster: Decimal;
        ItemPesoMaster: Decimal;
        ItemVolumenMaster: Decimal;

    local procedure GetItemPicture(var Item: Record Item)
    var
        TenantMedia: Record "Tenant Media";
        InStr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        ItemPictureBase64 := '';
        if Item.Picture.Count = 0 then
            exit;
        if TenantMedia.Get(Item.Picture.Item(1)) then begin
            TenantMedia.CalcFields(Content);
            if TenantMedia.Content.HasValue() then begin
                TenantMedia.Content.CreateInStream(InStr);
                ItemPictureBase64 := Base64Convert.ToBase64(InStr);
            end;
        end;
    end;

    local procedure ClearItemVars()
    begin
        ItemPictureBase64 := '';
        ItemEAN := '';
        ItemMarca := '';
        ItemPVP := 0;
        ItemCompraMin := 0;
        ItemPrecioFinal := 0;
        ItemCountryOfOrigin := '';
        ItemTariffNo := '';
        ItemDescription := '';
        ItemAlto := 0;
        ItemAncho := 0;
        ItemLargo := 0;
        ItemPeso := 0;
        ItemVolumen := 0;
        ItemEanInner := '';
        ItemCantidadInner := 0;
        ItemAltoInner := 0;
        ItemAnchoInner := 0;
        ItemLargoInner := 0;
        ItemPesoInner := 0;
        ItemVolumenInner := 0;
        ItemEanMaster := '';
        ItemCantidadMaster := 0;
        ItemAltoMaster := 0;
        ItemAnchoMaster := 0;
        ItemLargoMaster := 0;
        ItemPesoMaster := 0;
        ItemVolumenMaster := 0;
    end;
}
