codeunit 50200 "Hagen Prepago Mgt."
{
    procedure RegisterPayment(var PrepagoPedido: Record "Hagen Prepago Pedido")
    var
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SalesHeader: Record "Sales Header";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        SourceCodeSetup: Record "Source Code Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        MaxEntryNo: Integer;
    begin
        PrepagoPedido.TestField("Sales Order No.");
        PrepagoPedido.TestField(Amount);
        PrepagoPedido.TestField("Posting Date");

        if PrepagoPedido.Status <> PrepagoPedido.Status::Pendiente then
            Error('Este pago ya fue registrado. Estado actual: %1.', PrepagoPedido.Status);

        SalesHeader.Get(SalesHeader."Document Type"::Order, PrepagoPedido."Sales Order No.");

        if (SalesHeader."Applies-to Doc. No." <> '') and (SalesHeader."Applies-to Doc. No." <> PrepagoPedido."Document No.") then
            Error('El pedido ya tiene un documento de aplicación asignado (%1). Revise antes de continuar.',
                SalesHeader."Applies-to Doc. No.");

        SourceCodeSetup.Get();

        // Capturar el último Nº de movimiento de cliente para encontrar el nuevo tras registrar
        CustLedgerEntry.Reset();
        if CustLedgerEntry.FindLast() then
            MaxEntryNo := CustLedgerEntry."Entry No.";

        // Asignar Nº documento si no se indicó
        if PrepagoPedido."Document No." = '' then
            PrepagoPedido."Document No." := PrepagoPedido."Sales Order No.";

        // Construir la línea de diario y registrar
        GenJnlLine.Init();
        GenJnlLine."Line No." := 10000;
        GenJnlLine."Posting Date" := PrepagoPedido."Posting Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No." := PrepagoPedido."Document No.";
        GenJnlLine."External Document No." := PrepagoPedido."Sales Order No.";
        GenJnlLine.Description :=
            CopyStr('Prepago Ped. ' + PrepagoPedido."Sales Order No.", 1, MaxStrLen(GenJnlLine.Description));
        PrepagoPedido.TestField("Company Bank Account No.");
        GenJnlLine."Source Code" := SourceCodeSetup."Sales Entry Application";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine.Validate("Account No.", PrepagoPedido."Company Bank Account No.");
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::Customer;
        GenJnlLine.Validate("Bal. Account No.", SalesHeader."Sell-to Customer No.");
        GenJnlLine.Validate(Amount, PrepagoPedido.Amount);

        GenJnlPostLine.RunWithCheck(GenJnlLine);

        // Vincular el pago al pedido: BC aplicará automáticamente al facturar
        SalesHeader."Applies-to Doc. Type" := SalesHeader."Applies-to Doc. Type"::Payment;
        SalesHeader."Applies-to Doc. No." := PrepagoPedido."Document No.";

        SalesSetup.Get();
        if SalesSetup."Forma pago PAGADO" <> '' then
            SalesHeader."Payment Method Code" := SalesSetup."Forma pago PAGADO";

        SalesHeader.Modify();

        // Guardar el Nº de movimiento de cliente generado
        CustLedgerEntry.Reset();
        CustLedgerEntry.SetRange("Customer No.", SalesHeader."Sell-to Customer No.");
        CustLedgerEntry.SetFilter("Entry No.", '>%1', MaxEntryNo);
        CustLedgerEntry.SetRange("Document No.", PrepagoPedido."Document No.");
        if CustLedgerEntry.FindFirst() then
            PrepagoPedido."Cust. Ledger Entry No." := CustLedgerEntry."Entry No.";

        PrepagoPedido.Status := PrepagoPedido.Status::Registrado;
        PrepagoPedido."User ID" := CopyStr(UserId(), 1, MaxStrLen(PrepagoPedido."User ID"));
        PrepagoPedido.Modify();

        Message('Cobro de %1 € registrado correctamente.\nEl pedido %2 puede confirmarse y facturarse.',
            PrepagoPedido.Amount, PrepagoPedido."Sales Order No.");
    end;

    procedure ReversePayment(var PrepagoPedido: Record "Hagen Prepago Pedido")
    var
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        SalesHeader: Record "Sales Header";
        SourceCodeSetup: Record "Source Code Setup";
    begin
        if PrepagoPedido.Status <> PrepagoPedido.Status::Registrado then
            Error('Solo se puede anular un pago en estado Registrado.');

        if not Confirm('¿Está seguro de que desea anular el cobro de %1 €?', false, PrepagoPedido.Amount) then
            exit;

        CustLedgerEntry.Get(PrepagoPedido."Cust. Ledger Entry No.");
        if not CustLedgerEntry.Open then
            Error('El asiento del cobro ya está aplicado y no puede anularse directamente.');

        // Registrar el asiento inverso y aplicarlo contra el original
        SourceCodeSetup.Get();
        GenJnlLine.Init();
        GenJnlLine."Line No." := 10000;
        GenJnlLine."Posting Date" := WorkDate();
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No." := CopyStr('A-' + PrepagoPedido."Document No.", 1, MaxStrLen(GenJnlLine."Document No."));
        GenJnlLine."External Document No." := PrepagoPedido."Sales Order No.";
        GenJnlLine.Description :=
            CopyStr('Anulación Prepago ' + PrepagoPedido."Sales Order No.", 1, MaxStrLen(GenJnlLine.Description));
        GenJnlLine."Source Code" := SourceCodeSetup."Sales Entry Application";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine.Validate("Account No.", PrepagoPedido."Company Bank Account No.");
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::Customer;
        SalesHeader.Get(SalesHeader."Document Type"::Order, PrepagoPedido."Sales Order No.");
        GenJnlLine.Validate("Bal. Account No.", SalesHeader."Sell-to Customer No.");
        GenJnlLine.Validate(Amount, -PrepagoPedido.Amount);
        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Payment;
        GenJnlLine."Applies-to Doc. No." := PrepagoPedido."Document No.";

        GenJnlPostLine.RunWithCheck(GenJnlLine);

        // Limpiar el vínculo en el pedido de venta
        if SalesHeader.Get(SalesHeader."Document Type"::Order, PrepagoPedido."Sales Order No.") then
            if SalesHeader."Applies-to Doc. No." = PrepagoPedido."Document No." then begin
                SalesHeader."Applies-to Doc. Type" := SalesHeader."Applies-to Doc. Type"::" ";
                SalesHeader."Applies-to Doc. No." := '';
                SalesHeader.Modify();
            end;

        PrepagoPedido.Status := PrepagoPedido.Status::Pendiente;
        PrepagoPedido."Cust. Ledger Entry No." := 0;
        PrepagoPedido.Modify();
    end;

    procedure CheckPrepaymentRequired(var SalesHeader: Record "Sales Header")
    var
        Customer: Record Customer;
        PaymentMethod: Record "Payment Method";
        PrepagoPedido: Record "Hagen Prepago Pedido";
        RequierePrepago: Boolean;
    begin
        if Customer.Get(SalesHeader."Sell-to Customer No.") then
            if Customer."Requiere Prepago" then
                RequierePrepago := true;

        if PaymentMethod.Get(SalesHeader."Payment Method Code") then
            if PaymentMethod."Pago anticipado" then
                RequierePrepago := true;

        if not RequierePrepago then
            exit;

        PrepagoPedido.Reset();
        PrepagoPedido.SetRange("Sales Order No.", SalesHeader."No.");
        PrepagoPedido.SetRange(Status, PrepagoPedido.Status::Registrado);
        if PrepagoPedido.IsEmpty() then
            Error('El pedido %1 requiere pago anticipado registrado.\Utilice el botón "Registrar Pago Anticipado" antes de confirmar.',
                SalesHeader."No.");
    end;

    procedure EsPagoAnticipado(PaymentMethodCode: Code[10]): Boolean
    var
        PaymentMethod: Record "Payment Method";
    begin
        if PaymentMethodCode = '' then
            exit(false);
        if PaymentMethod.Get(PaymentMethodCode) then
            exit(PaymentMethod."Pago anticipado");
        exit(false);
    end;

    procedure UpdateStatusToApplied(SalesOrderNo: Code[20]; PostedInvoiceNo: Code[20])
    var
        PrepagoPedido: Record "Hagen Prepago Pedido";
    begin
        PrepagoPedido.Reset();
        PrepagoPedido.SetRange("Sales Order No.", SalesOrderNo);
        PrepagoPedido.SetRange(Status, PrepagoPedido.Status::Registrado);
        if PrepagoPedido.FindFirst() then begin
            PrepagoPedido.Status := PrepagoPedido.Status::Aplicado;
            PrepagoPedido."Applied to Invoice No." := PostedInvoiceNo;
            PrepagoPedido.Modify();
        end;
    end;

    procedure GetDefaultBankAccount(CustomerNo: Code[20]): Code[20]
    var
        Customer: Record Customer;
    begin
        if Customer.Get(CustomerNo) then
            exit(Customer."Preferred Bank Account Code");
        exit('');
    end;

    procedure GetDefaultCompanyBankAccount(CustomerNo: Code[20]): Code[20]
    var
        Customer: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        if Customer.Get(CustomerNo) then
            if Customer."Banco Prepago Empresa" <> '' then
                exit(Customer."Banco Prepago Empresa");

        SalesSetup.Get();
        exit(SalesSetup."Banco Prepago");
    end;
}
