codeunit 50201 "Hagen Prepago Event Sub."
{
    // El check de prepago se realiza únicamente en el momento del registro (albaran/factura),
    // no al liberar el pedido, para permitir la creación desde Shopify y otros canales sin bloqueos.

    // Bloquear registro (albaran o factura) si falta pago anticipado
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure CheckPrepagoOnPost(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    var
        PrepagoMgt: Codeunit "Hagen Prepago Mgt.";
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;
        PrepagoMgt.CheckPrepaymentRequired(SalesHeader);
    end;

    // Actualizar estado a Aplicado tras facturar
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterFinalizePosting', '', false, false)]
    local procedure UpdatePrepagoOnPost(
        var SalesHeader: Record "Sales Header";
        var SalesShipmentHeader: Record "Sales Shipment Header";
        var SalesInvoiceHeader: Record "Sales Invoice Header";
        var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        var ReturnReceiptHeader: Record "Return Receipt Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        CommitIsSuppressed: Boolean)
    var
        PrepagoMgt: Codeunit "Hagen Prepago Mgt.";
    begin
        if SalesInvoiceHeader."No." = '' then
            exit;
        if SalesInvoiceHeader."Order No." = '' then
            exit;

        PrepagoMgt.UpdateStatusToApplied(SalesInvoiceHeader."Order No.", SalesInvoiceHeader."No.");
    end;
}
