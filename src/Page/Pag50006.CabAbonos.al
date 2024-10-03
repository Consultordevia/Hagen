page 50006 CabAbonos
{
    ApplicationArea = All;
    Caption = 'CabAbonos';
    PageType = List;
    SourceTable = "Sales Cr.Memo Header";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Actividad; Rec.Actividad)
                {
                    ToolTip = 'Specifies the value of the Actividad field.', Comment = '%';
                }
                field("Albaran sin detalle"; Rec."Albaran sin detalle")
                {
                    ToolTip = 'Specifies the value of the Albaran sin detalle field.', Comment = '%';
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ToolTip = 'Specifies the value of the Allow Line Disc. field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the total of the amounts on all the credit memo lines, in the currency of the credit memo. The amount does not include VAT.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ToolTip = 'Specifies the total of the amounts, including VAT, on all the lines on the document.';
                }
                field("Anula restos"; Rec."Anula restos")
                {
                    ToolTip = 'Specifies the value of the Anula restos field.', Comment = '%';
                }
                field("Applies-to Bill No."; Rec."Applies-to Bill No.")
                {
                    ToolTip = 'Specifies the value of the Applies-to Bill No. field.', Comment = '%';
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ToolTip = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Area"; Rec."Area")
                {
                    ToolTip = 'Specifies the value of the Area field.', Comment = '%';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ToolTip = 'Specifies the value of the Bal. Account No. field.', Comment = '%';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ToolTip = 'Specifies the value of the Bal. Account Type field.', Comment = '%';
                }
                field(Base; Rec.Base)
                {
                    ToolTip = 'Specifies the value of the Base field.', Comment = '%';
                }
                field("Base Pdte."; Rec."Base Pdte.")
                {
                    ToolTip = 'Specifies the value of the Base Pdte. field.', Comment = '%';
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ToolTip = 'Specifies the address of the customer that the credit memo was sent to.';
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ToolTip = 'Specifies the city of the customer on the sales document.';
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact when you communicate with the customer to whom the credit memo was sent.';
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ToolTip = 'Specifies the number of the contact at the customer who handles the credit memo.';
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country or region of the address.';
                }
                field("Bill-to County"; Rec."Bill-to County")
                {
                    ToolTip = 'Specifies the state, province or county as a part of the address.';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer that you send or sent the invoice or credit memo to.';
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that the credit memo was sent to.';
                }
                field("Bill-to Name 2"; Rec."Bill-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Bill-to Name 2 field.', Comment = '%';
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ToolTip = 'Specifies the value of the Campaign No. field.', Comment = '%';
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ToolTip = 'Specifies if the posted sales invoice that relates to this sales credit memo has been either corrected or canceled.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
                field("Company Bank Account Code"; Rec."Company Bank Account Code")
                {
                    ToolTip = 'Specifies the bank account to use for bank information when the document is printed.';
                }
                field("Corrected Invoice No."; Rec."Corrected Invoice No.")
                {
                    ToolTip = 'Specifies the number of the posted invoice that you need to correct.';
                }
                field(Correction; Rec.Correction)
                {
                    ToolTip = 'Specifies the entry was posted as a corrective entry.';
                }
                field("Correction Type"; Rec."Correction Type")
                {
                    ToolTip = 'Specifies the Correction Type.';
                }
                field(Corrective; Rec.Corrective)
                {
                    ToolTip = 'Specifies if the posted sales invoice has been either corrected or canceled by this sales credit memo.';
                }
                field("Cr. Memo Type"; Rec."Cr. Memo Type")
                {
                    ToolTip = 'Specifies the Credit Memo Type.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code of the credit memo.';
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.', Comment = '%';
                }
                field("Cust. Bank Acc. Code"; Rec."Cust. Bank Acc. Code")
                {
                    ToolTip = 'Specifies the customer''s bank code that was on the sales header when this credit memo was issued.';
                }
                field("Cust. Ledger Entry No."; Rec."Cust. Ledger Entry No.")
                {
                    ToolTip = 'Specifies the value of the Cust. Ledger Entry No. field.', Comment = '%';
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ToolTip = 'Specifies the value of the Customer Disc. Group field.', Comment = '%';
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ToolTip = 'Specifies the customer''s market type to link business transactions to.';
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ToolTip = 'Specifies the value of the Customer Price Group field.', Comment = '%';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ToolTip = 'Specifies the value of the Dimension Set ID field.', Comment = '%';
                }
                field("Do Not Send To SII"; Rec."Do Not Send To SII")
                {
                    ToolTip = 'Specifies if the document must not be sent to SII.';
                }
                field("Doc. Exch. Original Identifier"; Rec."Doc. Exch. Original Identifier")
                {
                    ToolTip = 'Specifies the value of the Doc. Exch. Original Identifier field.', Comment = '%';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date on which you created the sales document.';
                }
                field("Document Exchange Identifier"; Rec."Document Exchange Identifier")
                {
                    ToolTip = 'Specifies the value of the Document Exchange Identifier field.', Comment = '%';
                }
                field("Document Exchange Status"; Rec."Document Exchange Status")
                {
                    ToolTip = 'Specifies the status of the document if you are using a document exchange service to send it as an electronic document. The status values are reported by the document exchange service.';
                }
                field("Draft Cr. Memo SystemId"; Rec."Draft Cr. Memo SystemId")
                {
                    ToolTip = 'Specifies the value of the Draft Cr. Memo System Id field.', Comment = '%';
                }
                field("Dto% cabecera"; Rec."Dto% cabecera")
                {
                    ToolTip = 'Specifies the value of the Dto% cabecera field.', Comment = '%';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the date on which the shipment is due for payment.';
                }
                field("EDI Facturas Fecha enviado"; Rec."EDI Facturas Fecha enviado")
                {
                    ToolTip = 'Specifies the value of the EDI Facturas Fecha enviado field.', Comment = '%';
                }
                field("EDI factueas enviado"; Rec."EDI factueas enviado")
                {
                    ToolTip = 'Specifies the value of the EDI factueas enviado field.', Comment = '%';
                }
                field("EDI factueas enviar"; Rec."EDI factueas enviar")
                {
                    ToolTip = 'Specifies the value of the EDI factueas enviar field.', Comment = '%';
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ToolTip = 'Specifies whether the invoice was part of an EU 3-party trade transaction.';
                }
                field("Enviado pdf web"; Rec."Enviado pdf web")
                {
                    ToolTip = 'Specifies the value of the Enviado pdf web field.', Comment = '%';
                }
                field("Estado pedido"; Rec."Estado pedido")
                {
                    ToolTip = 'Specifies the value of the Estado pedido field.', Comment = '%';
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ToolTip = 'Specifies the value of the Exit Point field.', Comment = '%';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the external document number that is entered on the sales header that this line was posted from.';
                }
                field("Fecha activo"; Rec."Fecha activo")
                {
                    ToolTip = 'Specifies the value of the Fecha activo field.', Comment = '%';
                }
                field("Fecha alta"; Rec."Fecha alta")
                {
                    ToolTip = 'Specifies the value of the Fecha alta field.', Comment = '%';
                }
                field("Fecha fact. rectifi."; Rec."Fecha fact. rectifi.")
                {
                    ToolTip = 'Specifies the value of the Fecha fact. rectifi. field.', Comment = '%';
                }
                field("Format Region"; Rec."Format Region")
                {
                    ToolTip = 'Specifies the value of the Format Region field.', Comment = '%';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.', Comment = '%';
                }
                field("Get Return Receipt Used"; Rec."Get Return Receipt Used")
                {
                    ToolTip = 'Specifies the value of the Get Return Receipt Used field.', Comment = '%';
                }
                field("Grupo clientes"; Rec."Grupo clientes")
                {
                    ToolTip = 'Specifies the value of the Grupo clientes field.', Comment = '%';
                }
                field("Hora activo"; Rec."Hora activo")
                {
                    ToolTip = 'Specifies the value of the Hora activo field.', Comment = '%';
                }
                field("Hora alta"; Rec."Hora alta")
                {
                    ToolTip = 'Specifies the value of the Hora alta field.', Comment = '%';
                }
                field("ID Type"; Rec."ID Type")
                {
                    ToolTip = 'Specifies the ID Type.';
                }
                field("Id Pedido Presta Shop"; Rec."Id Pedido Presta Shop")
                {
                    ToolTip = 'Specifies the value of the Id Pedido Presta Shop field.', Comment = '%';
                }
                field("Importe coste Real"; Rec."Importe coste Real")
                {
                    ToolTip = 'Specifies the value of the Importe coste Real field.', Comment = '%';
                }
                field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                {
                    ToolTip = 'Specifies the value of the Invoice Disc. Code field.', Comment = '%';
                }
                field("Invoice Discount Amount"; Rec."Invoice Discount Amount")
                {
                    ToolTip = 'Specifies the value of the Invoice Discount Amount field.', Comment = '%';
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ToolTip = 'Specifies the value of the Invoice Type field.', Comment = '%';
                }
                field("Issued By Third Party"; Rec."Issued By Third Party")
                {
                    ToolTip = 'Specifies that the credit memo was issued by a third party.';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ToolTip = 'Specifies the value of the Language Code field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location where the credit memo was registered.';
                }
                field("Logo cabecera"; Rec."Logo cabecera")
                {
                    ToolTip = 'Specifies the value of the Logo cabecera field.', Comment = '%';
                }
                field("No Enviar albaran en exp."; Rec."No Enviar albaran en exp.")
                {
                    ToolTip = 'Specifies the value of the No Enviar albaran en exp. field.', Comment = '%';
                }
                field("No Enviar factura en exp."; Rec."No Enviar factura en exp.")
                {
                    ToolTip = 'Specifies the value of the No Enviar factura en exp. field.', Comment = '%';
                }
                field("No imprimir albaran valorado"; Rec."No imprimir albaran valorado")
                {
                    ToolTip = 'Specifies the value of the No imprimir albaran valorado field.', Comment = '%';
                }
                field("No imprimir facturas"; Rec."No imprimir facturas")
                {
                    ToolTip = 'Specifies the value of the No imprimir facturas field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the posted credit memo number.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies how many times the document has been printed.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.', Comment = '%';
                }
                field("Nº Nota Debito"; Rec."Nº Nota Debito")
                {
                    ToolTip = 'Specifies the value of the Nº Nota Debito field.', Comment = '%';
                }
                field("Nº Palets"; Rec."Nº Palets")
                {
                    ToolTip = 'Specifies the value of the Nº Palets field.', Comment = '%';
                }
                field("Nº bultos"; Rec."Nº bultos")
                {
                    ToolTip = 'Specifies the value of the Nº bultos field.', Comment = '%';
                }
                field("Nº copias solicitud trabajo"; Rec."Nº copias solicitud trabajo")
                {
                    ToolTip = 'Specifies the value of the No. Printed field.', Comment = '%';
                }
                field("Nº expedición dropshp"; Rec."Nº expedición dropshp")
                {
                    ToolTip = 'Specifies the value of the Nº expedición dropshp field.', Comment = '%';
                }
                field("Nº factura rectificativa"; Rec."Nº factura rectificativa")
                {
                    ToolTip = 'Specifies the value of the Nº factura rectificativa field.', Comment = '%';
                }
                field("Nº pedido obligatorio"; Rec."Nº pedido obligatorio")
                {
                    ToolTip = 'Specifies the value of the Nº pedido obligatorio field.', Comment = '%';
                }
                field("Ofertas calculadas"; Rec."Ofertas calculadas")
                {
                    ToolTip = 'Specifies the value of the Ofertas calculadas field.', Comment = '%';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ToolTip = 'Specifies the value of the On Hold field.', Comment = '%';
                }
                field("Operation Description"; Rec."Operation Description")
                {
                    ToolTip = 'Specifies the value of the Operation Description field.', Comment = '%';
                }
                field("Operation Description 2"; Rec."Operation Description 2")
                {
                    ToolTip = 'Specifies the value of the Operation Description 2 field.', Comment = '%';
                }
                field("Opportunity No."; Rec."Opportunity No.")
                {
                    ToolTip = 'Specifies the value of the Opportunity No. field.', Comment = '%';
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ToolTip = 'Specifies the shipping agent''s package number.';
                }
                field(Paid; Rec.Paid)
                {
                    ToolTip = 'Specifies if the posted sales invoice that relates to this sales credit memo is paid.';
                }
                field("Pay-at Code"; Rec."Pay-at Code")
                {
                    ToolTip = 'Specifies the customer''s payment address code that was on the sales header, Payments tab, when this credit memo was issued.';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percentage that is granted if the customer pays on or before the date entered in the Pmt. Discount Date field. The discount percentage is specified in the Payment Terms Code field.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies the customer''s method of payment. The program has copied the code from the Payment Method Code field on the sales header.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the value of the Payment Terms Code field.', Comment = '%';
                }
                field("Pedido WEB"; Rec."Pedido WEB")
                {
                    ToolTip = 'Specifies the value of the Pedido WEB field.', Comment = '%';
                }
                field("Permite multiplos distintos"; Rec."Permite multiplos distintos")
                {
                    ToolTip = 'Specifies the value of the Permite multiplos distintos field.', Comment = '%';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ToolTip = 'Specifies the value of the Pmt. Discount Date field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date on which the credit memo was posted.';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ToolTip = 'Specifies any text that is entered to accompany the posting, for example for information to auditors.';
                }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.")
                {
                    ToolTip = 'Specifies the number of the credit memo that the posted credit memo was created from.';
                }
                field("Pre-Assigned No. Series"; Rec."Pre-Assigned No. Series")
                {
                    ToolTip = 'Specifies the value of the Pre-Assigned No. Series field.', Comment = '%';
                }
                field(Preparador; Rec.Preparador)
                {
                    ToolTip = 'Specifies the value of the Preparador field.', Comment = '%';
                }
                field("Prepayment Credit Memo"; Rec."Prepayment Credit Memo")
                {
                    ToolTip = 'Specifies the value of the Prepayment Credit Memo field.', Comment = '%';
                }
                field("Prepayment Order No."; Rec."Prepayment Order No.")
                {
                    ToolTip = 'Specifies the value of the Prepayment Order No. field.', Comment = '%';
                }
                field("Prepmt. Cr. Memo No. Series"; Rec."Prepmt. Cr. Memo No. Series")
                {
                    ToolTip = 'Specifies the value of the Prepmt. Cr. Memo No. Series field.', Comment = '%';
                }
                field("Price Calculation Method"; Rec."Price Calculation Method")
                {
                    ToolTip = 'Specifies the value of the Price Calculation Method field.', Comment = '%';
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ToolTip = 'Specifies the value of the Prices Including VAT field.', Comment = '%';
                }
                field("Rcvd.-from Count./Region Code"; Rec."Rcvd.-from Count./Region Code")
                {
                    ToolTip = 'Specifies the value of the Received-from Country/Region Code field.', Comment = '%';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Specifies the value of the Reason Code field.', Comment = '%';
                }
                field("Referencia Pedido Presta Shop"; Rec."Referencia Pedido Presta Shop")
                {
                    ToolTip = 'Specifies the value of the Referencia Pedido Presta Shop field.', Comment = '%';
                }
                field("Referencia catastral"; Rec."Referencia catastral")
                {
                    ToolTip = 'Specifies the value of the Referencia catastral field.', Comment = '%';
                }
                field("Registration Number"; Rec."Registration Number")
                {
                    ToolTip = 'Specifies the value of the Registration No. field.', Comment = '%';
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ToolTip = 'Specifies the amount that remains to be paid for the posted sales invoice.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the code for the responsibility center that serves the customer on this sales document.';
                }
                field("Return Order No."; Rec."Return Order No.")
                {
                    ToolTip = 'Specifies the value of the Return Order No. field.', Comment = '%';
                }
                field("Return Order No. Series"; Rec."Return Order No. Series")
                {
                    ToolTip = 'Specifies the value of the Return Order No. Series field.', Comment = '%';
                }
                field("SII First Summary Doc. No."; Rec."SII First Summary Doc. No.")
                {
                    ToolTip = 'Specifies the value of the First Summary Doc. No. field.', Comment = '%';
                }
                field("SII Last Summary Doc. No."; Rec."SII Last Summary Doc. No.")
                {
                    ToolTip = 'Specifies the value of the Last Summary Doc. No. field.', Comment = '%';
                }
                field("SII Status"; Rec."SII Status")
                {
                    ToolTip = 'Specifies the document''s status with regard to tax declaration, the Immediate Information Supply requirement.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies which salesperson is associated with the credit memo.';
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ToolTip = 'Specifies the address of the customer that the items on the credit memo were sent to.';
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ToolTip = 'Specifies the city of the customer on the sales document.';
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ToolTip = 'Specifies the name of the person to contact when you communicate with the customer who you shipped the items on the credit memo to.';
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ToolTip = 'Specifies the number of the contact at the customer who handles the credit memo.';
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country or region of the address.';
                }
                field("Sell-to County"; Rec."Sell-to County")
                {
                    ToolTip = 'Specifies the state, province or county as a part of the address.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the name of the customer that you shipped the items on the credit memo to.';
                }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer Name 2 field.', Comment = '%';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer.';
                }
                field("Sell-to E-Mail"; Rec."Sell-to E-Mail")
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field("Sell-to Phone No."; Rec."Sell-to Phone No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Phone No. field.', Comment = '%';
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field("Sent to SII"; Rec."Sent to SII")
                {
                    ToolTip = 'Specifies that the document has been sent to the Immediate Information Supply system.';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the address that the items were shipped to.';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the city of the customer on the sales document.';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies a code for an alternate shipment address if you want to ship to another address than the one that has been entered automatically. This field is also used in case of drop shipment.';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact at the customer to whom the items were shipped.';
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country or region of the address.';
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ToolTip = 'Specifies the state, province or county as a part of the address.';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that the items were shipped to.';
                }
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Ship-to Name 2 field.', Comment = '%';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies the value of the Shipment Date field.', Comment = '%';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the shipment method for the shipment.';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ToolTip = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Situación inmueble"; Rec."Situación inmueble")
                {
                    ToolTip = 'Specifies the value of the Situación inmueble field.', Comment = '%';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ToolTip = 'Specifies the value of the Source Code field.', Comment = '%';
                }
                field("Special Scheme Code"; Rec."Special Scheme Code")
                {
                    ToolTip = 'Specifies the Special Scheme Code.';
                }
                field("Succeeded Company Name"; Rec."Succeeded Company Name")
                {
                    ToolTip = 'Specifies the name of the company sucessor in connection with corporate restructuring.';
                }
                field("Succeeded VAT Registration No."; Rec."Succeeded VAT Registration No.")
                {
                    ToolTip = 'Specifies the VAT registration number of the company sucessor in connection with corporate restructuring.';
                }
                field("Super urgente"; Rec."Super urgente")
                {
                    ToolTip = 'Specifies the value of the Super urgente field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ToolTip = 'Specifies the tax area that is used to calculate and post sales tax.';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ToolTip = 'Specifies if the customer or vendor is liable for sales tax.';
                }
                field("Tipo rectificativa"; Rec."Tipo rectificativa")
                {
                    ToolTip = 'Specifies the value of the Tipo rectificativa field.', Comment = '%';
                }
                field("Total bultos"; Rec."Total bultos")
                {
                    ToolTip = 'Specifies the value of the Total bultos field.', Comment = '%';
                }
                field("Total peso"; Rec."Total peso")
                {
                    ToolTip = 'Specifies the value of the Total peso field.', Comment = '%';
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ToolTip = 'Specifies the value of the Transaction Specification field.', Comment = '%';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.', Comment = '%';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the value of the Transport Method field.', Comment = '%';
                }
                field(Urgente; Rec.Urgente)
                {
                    ToolTip = 'Specifies the value of the Urgente field.', Comment = '%';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
                field("Usuario activo"; Rec."Usuario activo")
                {
                    ToolTip = 'Specifies the value of the Usuario activo field.', Comment = '%';
                }
                field("Usuario alta"; Rec."Usuario alta")
                {
                    ToolTip = 'Specifies the value of the Usuario alta field.', Comment = '%';
                }
                field("VAT Base Discount %"; Rec."VAT Base Discount %")
                {
                    ToolTip = 'Specifies the value of the VAT Base Discount % field.', Comment = '%';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.', Comment = '%';
                }
                field("VAT Country/Region Code"; Rec."VAT Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the VAT Country/Region Code field.', Comment = '%';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ToolTip = 'Specifies the customer''s VAT registration number for customers.';
                }
                field("VAT Reporting Date"; Rec."VAT Reporting Date")
                {
                    ToolTip = 'Specifies the VAT date on the invoice.';
                }
                field("Work Description"; Rec."Work Description")
                {
                    ToolTip = 'Specifies the value of the Work Description field.', Comment = '%';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ToolTip = 'Specifies the customer''s reference. The contents will be printed on sales documents.';
                }
                field(vende; Rec.vende)
                {
                    ToolTip = 'Specifies the value of the vende field.', Comment = '%';
                }
            }
        }
    }
}
