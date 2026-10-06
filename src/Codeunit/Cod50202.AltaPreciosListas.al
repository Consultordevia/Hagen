/// <summary>
/// REQ-001331 / REQ-001340 - La plantilla de alta de productos (xmlport 50010) graba las
/// tarifas en las listas de precios, que es lo que usa BC desde que tiene activados los
/// precios nuevos: la de venta del código de ventas (columna L, con el precio de la M)
/// y la de compra del proveedor (columna Q). Antes solo iban a las tablas antiguas
/// (Sales Price / Purchase Price), que ya no se ven; Alexis tenía que crear la tarifa a mano.
///
/// Si la lista es ACTIVA y la configuración no permite editar precios activos, no se toca
/// la lista (BC daría error y pararía la importación): se queda solo en la tabla antigua.
/// </summary>
codeunit 50202 "Alta Precios Listas"
{
    procedure PrecioVenta(ItemNo: Code[20]; GrupoPrecio: Code[20]; Precio: Decimal)
    begin
        if GrupoPrecio = '' then
            exit;
        Grabar("Price Type"::Sale, "Price Source Type"::"Customer Price Group", GrupoPrecio, ItemNo, Precio);
    end;

    procedure PrecioCompra(ItemNo: Code[20]; VendorNo: Code[20]; Coste: Decimal)
    begin
        if VendorNo = '' then
            exit;
        Grabar("Price Type"::Purchase, "Price Source Type"::Vendor, VendorNo, ItemNo, Coste);
    end;

    local procedure Grabar(Tipo: Enum "Price Type"; Origen: Enum "Price Source Type"; OrigenNo: Code[20]; ItemNo: Code[20]; Importe: Decimal)
    var
        Linea: Record "Price List Line";
        Cabecera: Record "Price List Header";
    begin
        Linea.SetRange("Price Type", Tipo);
        Linea.SetRange("Source Type", Origen);
        Linea.SetRange("Source No.", OrigenNo);
        Linea.SetRange("Asset Type", Linea."Asset Type"::Item);
        Linea.SetRange("Asset No.", ItemNo);
        if Linea.FindLast() then begin
            if not Cabecera.Get(Linea."Price List Code") or not PuedeEditar(Cabecera) then
                exit;
            PonerImporte(Linea, Tipo, Importe);
            Linea.Modify(true);
        end else begin
            if not ListaDondeGrabar(Tipo, Origen, OrigenNo, Cabecera) or not PuedeEditar(Cabecera) then
                exit;
            NuevaLinea(Cabecera, Origen, OrigenNo, ItemNo, Tipo, Importe);
        end;
        ActivarBorradores(Cabecera);
    end;

    /// <summary>La lista donde ya están las tarifas de ese grupo/proveedor; si no hay, la lista por defecto.</summary>
    local procedure ListaDondeGrabar(Tipo: Enum "Price Type"; Origen: Enum "Price Source Type"; OrigenNo: Code[20]; var Cabecera: Record "Price List Header"): Boolean
    var
        Linea: Record "Price List Line";
        PriceListMgt: Codeunit "Price List Management";
    begin
        Linea.SetRange("Price Type", Tipo);
        Linea.SetRange("Source Type", Origen);
        Linea.SetRange("Source No.", OrigenNo);
        if Linea.FindLast() then
            exit(Cabecera.Get(Linea."Price List Code"));
        if Tipo = Tipo::Sale then
            exit(Cabecera.Get(PriceListMgt.DefineDefaultPriceList(Tipo, "Price Source Group"::Customer)));
        exit(Cabecera.Get(PriceListMgt.DefineDefaultPriceList(Tipo, "Price Source Group"::Vendor)));
    end;

    local procedure NuevaLinea(Cabecera: Record "Price List Header"; Origen: Enum "Price Source Type"; OrigenNo: Code[20]; ItemNo: Code[20]; Tipo: Enum "Price Type"; Importe: Decimal)
    var
        Linea: Record "Price List Line";
        LineNo: Integer;
    begin
        Linea.SetRange("Price List Code", Cabecera.Code);
        if Linea.FindLast() then
            LineNo := Linea."Line No.";
        Linea.Init();
        Linea."Price List Code" := Cabecera.Code;
        Linea."Line No." := LineNo + 10000;
        Linea.CopyFrom(Cabecera);
        Linea.Validate("Source Type", Origen);
        Linea.Validate("Source No.", OrigenNo);
        Linea.Validate("Asset Type", Linea."Asset Type"::Item);
        Linea.Validate("Asset No.", ItemNo);
        PonerImporte(Linea, Tipo, Importe);
        Linea.Insert(true);
    end;

    local procedure PonerImporte(var Linea: Record "Price List Line"; Tipo: Enum "Price Type"; Importe: Decimal)
    begin
        if Tipo = Tipo::Sale then
            Linea.Validate("Unit Price", Importe)
        else
            Linea.Validate("Direct Unit Cost", Importe);
    end;

    local procedure PuedeEditar(Cabecera: Record "Price List Header"): Boolean
    var
        SalesSetup: Record "Sales & Receivables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        if Cabecera.Status <> Cabecera.Status::Active then
            exit(true);
        if Cabecera."Price Type" = Cabecera."Price Type"::Sale then
            exit(SalesSetup.Get() and SalesSetup."Allow Editing Active Price");
        exit(PurchSetup.Get() and PurchSetup."Allow Editing Active Price");
    end;

    /// <summary>En una lista activa, BC deja las líneas nuevas o cambiadas en borrador: se activan.</summary>
    local procedure ActivarBorradores(var Cabecera: Record "Price List Header")
    var
        PriceListMgt: Codeunit "Price List Management";
    begin
        if Cabecera.Status = Cabecera.Status::Active then
            PriceListMgt.ActivateDraftLines(Cabecera);
    end;
}
