codeunit 50801 "Hagen Prepago Event Sub."
{
    // Bloqueo al confirmar pedido si el cliente requiere prepago
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure CheckPrepagoOnRelease(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; SkipCheckReleaseRestrictions: Boolean)
    var
        PrepagoMgt: Codeunit "Hagen Prepago Mgt.";
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;
        if PreviewMode then
            exit;
        if SkipCheckReleaseRestrictions then
            exit;

        PrepagoMgt.CheckPrepaymentRequired(SalesHeader);
    end;

    // Bloquear registro de factura si falta pago anticipado
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
