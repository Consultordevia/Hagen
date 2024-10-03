page 50002 CabVenta
{
    ApplicationArea = All;
    Caption = 'CabVenta';
    PageType = List;
    SourceTable = "Sales Header";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ASN; Rec.ASN)
                {
                    ToolTip = 'Specifies the value of the ASN field.', Comment = '%';
                }
                field("Albaran sin detalle"; Rec."Albaran sin detalle")
                {
                    ToolTip = 'Specifies the value of the Albaran sin detalle field.', Comment = '%';
                }
                field("Albarán EDI"; Rec."Albarán EDI")
                {
                    ToolTip = 'Specifies the value of the Albarán EDI field.', Comment = '%';
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ToolTip = 'Specifies the value of the Allow Line Disc. field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the sum of amounts in the Line Amount field on the sales order lines. It is used to calculate the invoice discount of the sales order.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ToolTip = 'Specifies the sum of amounts, including VAT, on all the lines in the document. This will include invoice discounts.';
                }
                field("Ampliacion del pedido nº"; Rec."Ampliacion del pedido nº")
                {
                    ToolTip = 'Specifies the value of the Ampliacion del pedido nº field.', Comment = '%';
                }
                field("Amt. Ship. Not Inv. (LCY)"; Rec."Amt. Ship. Not Inv. (LCY)")
                {
                    ToolTip = 'Specifies the sum, in LCY, for items that have been shipped but not yet been invoiced. The amount is calculated as Amount Including VAT x Qty. Shipped Not Invoiced / Quantity.';
                }
                field("Amt. Ship. Not Inv. (LCY) Base"; Rec."Amt. Ship. Not Inv. (LCY) Base")
                {
                    ToolTip = 'Specifies the sum, in LCY, for items that have been shipped but not yet been invoiced. The amount is calculated as Amount Including VAT x Qty. Shipped Not Invoiced / Quantity.';
                }
                field("Anula restos"; Rec."Anula restos")
                {
                    ToolTip = 'Specifies the value of the Anula restos field.', Comment = '%';
                }
                field("Applies-to Bill No."; Rec."Applies-to Bill No.")
                {
                    ToolTip = 'Specifies if you want to apply an open receivable bill with a credit memo from a customer.';
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ToolTip = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.';
                }
                field("Area"; Rec."Area")
                {
                    ToolTip = 'Specifies the country or region of origin for the purpose of Intrastat reporting.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
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
                    ToolTip = 'Specifies the address of the customer that you will send the invoice to.';
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ToolTip = 'Specifies an additional part of the billing address.';
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ToolTip = 'Specifies the city of the billing address.';
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ToolTip = 'Specifies the name of the contact person at the customer''s billing address.';
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ToolTip = 'Specifies the number of the contact person at the billing address.';
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the customer''s billing address.';
                }
                field("Bill-to County"; Rec."Bill-to County")
                {
                    ToolTip = 'Specifies the county of the address.';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer that you send or sent the invoice or credit memo to.';
                }
                field("Bill-to Customer Templ. Code"; Rec."Bill-to Customer Templ. Code")
                {
                    ToolTip = 'Specifies the value of the Bill-to Customer Template Code field.', Comment = '%';
                }
                field("Bill-to IC Partner Code"; Rec."Bill-to IC Partner Code")
                {
                    ToolTip = 'Specifies the value of the Bill-to IC Partner Code field.', Comment = '%';
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that you send or sent the invoice or credit memo to.';
                }
                field("Bill-to Name 2"; Rec."Bill-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Bill-to Name 2 field.', Comment = '%';
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the customer''s billing address.';
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ToolTip = 'Specifies the number of the campaign that the document is linked to.';
                }
                field("Cdad. Pdte. Servir"; Rec."Cdad. Pdte. Servir")
                {
                    ToolTip = 'Specifies the value of the Cdad. Pdte. Servir field.', Comment = '%';
                }
                field("Check contrareemolso verificad"; Rec."Check contrareemolso verificad")
                {
                    ToolTip = 'Specifies the value of the Check contrareemolso verificad field.', Comment = '%';
                }
                field("Cobra portes entre empresas"; Rec."Cobra portes entre empresas")
                {
                    ToolTip = 'Specifies the value of the Cobra portes entre empresas field.', Comment = '%';
                }
                field("Codigo cliente externo"; Rec."Codigo cliente externo")
                {
                    ToolTip = 'Specifies the value of the Codigo cliente externo field.', Comment = '%';
                }
                field("Combine Shipments"; Rec."Combine Shipments")
                {
                    ToolTip = 'Specifies whether the order will be included when you use the Combine Shipments function.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
                field("Company Bank Account Code"; Rec."Company Bank Account Code")
                {
                    ToolTip = 'Specifies the bank account to use for bank information when the document is printed.';
                }
                field("Completely Shipped"; Rec."Completely Shipped")
                {
                    ToolTip = 'Specifies whether all the items on the order have been shipped or, in the case of inbound items, completely received.';
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ToolTip = 'Specifies that prepayments on the sales order are combined if they have the same general ledger account for prepayments or the same dimensions.';
                }
                field(Comunidad; Rec.Comunidad)
                {
                    ToolTip = 'Specifies the value of the Comunidad field.', Comment = '%';
                }
                field("Corrected Invoice No."; Rec."Corrected Invoice No.")
                {
                    ToolTip = 'Specifies the number of the posted invoice that you need to correct.';
                }
                field(Correction; Rec.Correction)
                {
                    ToolTip = 'Specifies the entry as a corrective entry. You can use the field if you need to post a corrective entry to a customer account. If you place a check mark in this field when posting a corrective entry, the system will post a negative debit instead of a credit or a negative credit instead of a debit. Correction flag does not affect how inventory reconciled with general ledger.';
                }
                field("Correction Type"; Rec."Correction Type")
                {
                    ToolTip = 'Specifies the Correction Type.';
                }
                field("Coupled to CRM"; Rec."Coupled to CRM")
                {
                    ToolTip = 'Specifies that the sales order is coupled to an order in Dynamics 365 Sales.';
                }
                field("Coupled to Dataverse"; Rec."Coupled to Dataverse")
                {
                    ToolTip = 'Specifies that the sales order is coupled to an order in Dynamics 365 Sales.';
                }
                field("Cr. Memo Type"; Rec."Cr. Memo Type")
                {
                    ToolTip = 'Specifies the Credit Memo Type.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency of amounts on the sales document.';
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.', Comment = '%';
                }
                field("Cust. Bank Acc. Code"; Rec."Cust. Bank Acc. Code")
                {
                    ToolTip = 'Specifies the customer bank code to assign to the sales header in this field.';
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ToolTip = 'Specifies the value of the Customer Disc. Group field.', Comment = '%';
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ToolTip = 'Specifies the customer s market type to link business transactions to.';
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ToolTip = 'Specifies the value of the Customer Price Group field.', Comment = '%';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ToolTip = 'Specifies the value of the Dimension Set ID field.', Comment = '%';
                }
                field("Direct Debit Mandate ID"; Rec."Direct Debit Mandate ID")
                {
                    ToolTip = 'Specifies the direct-debit mandate that the customer has signed to allow direct debit collection of payments.';
                }
                field("Do Not Send To SII"; Rec."Do Not Send To SII")
                {
                    ToolTip = 'Specifies if the document must not be sent to SII.';
                }
                field("Doc. No. Occurrence"; Rec."Doc. No. Occurrence")
                {
                    ToolTip = 'Specifies the value of the Doc. No. Occurrence field.', Comment = '%';
                }
                field("Docu. requerida prov. sacada"; Rec."Docu. requerida prov. sacada")
                {
                    ToolTip = 'Specifies the value of the Docu. requerida prov. sacada field.', Comment = '%';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date when the document was created.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.', Comment = '%';
                }
                field("Dpto.ECI"; Rec."Dpto.ECI")
                {
                    ToolTip = 'Specifies the value of the Dpto.ECI field.', Comment = '%';
                }
                field(Dropshipping; Rec.Dropshipping)
                {
                    ToolTip = 'Specifies the value of the Dropshipping field.', Comment = '%';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies when the sales invoice must be paid.';
                }
                field("Due Date Modified"; Rec."Due Date Modified")
                {
                    ToolTip = 'Specifies the value of the Due Date Modified field.', Comment = '%';
                }
                field("E-MAIL"; Rec."E-MAIL")
                {
                    ToolTip = 'Specifies the value of the E-MAIL field.', Comment = '%';
                }
                field("EDI factueas enviar"; Rec."EDI factueas enviar")
                {
                    ToolTip = 'Specifies the value of the EDI factueas enviar field.', Comment = '%';
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ToolTip = 'Specifies if the transaction is related to trade with a third party within the EU.';
                }
                field("Enviado email preparación"; Rec."Enviado email preparación")
                {
                    ToolTip = 'Specifies the value of the Enviado email preparación field.', Comment = '%';
                }
                field("Envio a-Nº Telefono"; Rec."Envio a-Nº Telefono")
                {
                    ToolTip = 'Specifies the value of the Envio a-Nº Telefono field.', Comment = '%';
                }
                field("Estado pedido"; Rec."Estado pedido")
                {
                    ToolTip = 'Specifies the value of the Estado pedido field.', Comment = '%';
                }
                field("Estado presupuesto"; Rec."Estado presupuesto")
                {
                    ToolTip = 'Specifies the value of the Estado presupuesto field.', Comment = '%';
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ToolTip = 'Specifies the point of exit through which you ship the items out of your country/region, for reporting to Intrastat.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the number that the customer uses in their own system to refer to this sales document.';
                }
                field("Factura EDI"; Rec."Factura EDI")
                {
                    ToolTip = 'Specifies the value of the Factura EDI field.', Comment = '%';
                }
                field("Fecha Retenido"; Rec."Fecha Retenido")
                {
                    ToolTip = 'Specifies the value of the Fecha Retenido field.', Comment = '%';
                }
                field("Fecha alta"; Rec."Fecha alta")
                {
                    ToolTip = 'Specifies the value of the Fecha alta field.', Comment = '%';
                }
                field("Fecha envio pendiente stock"; Rec."Fecha envio pendiente stock")
                {
                    ToolTip = 'Specifies the value of the Fecha envio pendiente stock field.', Comment = '%';
                }
                field("Fecha incial de entrega EDICOM"; Rec."Fecha incial de entrega EDICOM")
                {
                    ToolTip = 'Specifies the value of the Fecha incial de entrega EDICOM field.', Comment = '%';
                }
                field("Fecha para preparar"; Rec."Fecha para preparar")
                {
                    ToolTip = 'Specifies the value of the Fecha para preparar field.', Comment = '%';
                }
                field("Filtro ECI"; Rec."Filtro ECI")
                {
                    ToolTip = 'Specifies the value of the Filtro ECI field.', Comment = '%';
                }
                field("Format Region"; Rec."Format Region")
                {
                    ToolTip = 'Specifies the format to be used on printouts for this document.';
                }
                field("Frecuencia visita comercial"; Rec."Frecuencia visita comercial")
                {
                    ToolTip = 'Specifies the value of the Frecuencia visita comercial field.', Comment = '%';
                }
                field("Funcion del mensaje EDICOM"; Rec."Funcion del mensaje EDICOM")
                {
                    ToolTip = 'Specifies the value of the Funcion del mensaje EDICOM field.', Comment = '%';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.', Comment = '%';
                }
                field("Get Shipment Used"; Rec."Get Shipment Used")
                {
                    ToolTip = 'Specifies the value of the Get Shipment Used field.', Comment = '%';
                }
                field("Grupo clientes"; Rec."Grupo clientes")
                {
                    ToolTip = 'Specifies the value of the Grupo clientes field.', Comment = '%';
                }
                field("Hora Retenido"; Rec."Hora Retenido")
                {
                    ToolTip = 'Specifies the value of the Hora Retenido field.', Comment = '%';
                }
                field("Hora alta"; Rec."Hora alta")
                {
                    ToolTip = 'Specifies the value of the Hora alta field.', Comment = '%';
                }
                field("Hora para preparar"; Rec."Hora para preparar")
                {
                    ToolTip = 'Specifies the value of the Hora para preparar field.', Comment = '%';
                }
                field("IC Direction"; Rec."IC Direction")
                {
                    ToolTip = 'Specifies the value of the IC Direction field.', Comment = '%';
                }
                field("IC Reference Document No."; Rec."IC Reference Document No.")
                {
                    ToolTip = 'Specifies the value of the IC Reference Document No. field.', Comment = '%';
                }
                field("IC Status"; Rec."IC Status")
                {
                    ToolTip = 'Specifies the value of the IC Status field.', Comment = '%';
                }
                field("ID Type"; Rec."ID Type")
                {
                    ToolTip = 'Specifies the ID Type.';
                }
                field("IDENTIF EDICOM"; Rec."IDENTIF EDICOM")
                {
                    ToolTip = 'Specifies the value of the IDENTIF EDICOM field.', Comment = '%';
                }
                field("Id Pedido Presta Shop"; Rec."Id Pedido Presta Shop")
                {
                    ToolTip = 'Specifies the value of the Id Pedido Presta Shop field.', Comment = '%';
                }
                field("Importe Descuento Presta Shop"; Rec."Importe Descuento Presta Shop")
                {
                    ToolTip = 'Specifies the value of the Importe Descuento Presta Shop field.', Comment = '%';
                }
                field("Importe a cuenta"; Rec."Importe a cuenta")
                {
                    ToolTip = 'Specifies the value of the Importe a cuenta field.', Comment = '%';
                }
                field("Importe a descontar reembolso"; Rec."Importe a descontar reembolso")
                {
                    ToolTip = 'Specifies the value of the Importe a descontar reembolso field.', Comment = '%';
                }
                field("Importe optimo transporte"; Rec."Importe optimo transporte")
                {
                    ToolTip = 'Specifies the value of the Importe optimo transporte field.', Comment = '%';
                }
                field("Importe total pedido WEB"; Rec."Importe total pedido WEB")
                {
                    ToolTip = 'Specifies the value of the Importe total pedido WEB field.', Comment = '%';
                }
                field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
                {
                    ToolTip = 'Specifies the number of the incoming document that this sales document is created for.';
                }
                field("Incrementa bultos"; Rec."Incrementa bultos")
                {
                    ToolTip = 'Specifies the value of the Incrementa bultos field.', Comment = '%';
                }
                field(Invoice; Rec.Invoice)
                {
                    ToolTip = 'Specifies the value of the Invoice field.', Comment = '%';
                }
                field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                {
                    ToolTip = 'Specifies the value of the Invoice Disc. Code field.', Comment = '%';
                }
                field("Invoice Discount Amount"; Rec."Invoice Discount Amount")
                {
                    ToolTip = 'Specifies the value of the Invoice Discount Amount field.', Comment = '%';
                }
                field("Invoice Discount Calculation"; Rec."Invoice Discount Calculation")
                {
                    ToolTip = 'Specifies the value of the Invoice Discount Calculation field.', Comment = '%';
                }
                field("Invoice Discount Value"; Rec."Invoice Discount Value")
                {
                    ToolTip = 'Specifies the value of the Invoice Discount Value field.', Comment = '%';
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ToolTip = 'Specifies the Special Scheme Code.';
                }
                field(IsTest; Rec.IsTest)
                {
                    ToolTip = 'Specifies the value of the IsTest field.', Comment = '%';
                }
                field("Issued By Third Party"; Rec."Issued By Third Party")
                {
                    ToolTip = 'Specifies that the invoice was issued by a third party.';
                }
                field("Job Queue Entry ID"; Rec."Job Queue Entry ID")
                {
                    ToolTip = 'Specifies the value of the Job Queue Entry ID field.', Comment = '%';
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ToolTip = 'Specifies the status of a job queue entry or task that handles the posting of sales orders.';
                }
                field("Journal Templ. Name"; Rec."Journal Templ. Name")
                {
                    ToolTip = 'Specifies the name of the journal template in which the sales header is to be posted.';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ToolTip = 'Specifies the language to be used on printouts for this document.';
                }
                field("Last Posting No."; Rec."Last Posting No.")
                {
                    ToolTip = 'Specifies the value of the Last Posting No. field.', Comment = '%';
                }
                field("Last Prepayment No."; Rec."Last Prepayment No.")
                {
                    ToolTip = 'Specifies the value of the Last Prepayment No. field.', Comment = '%';
                }
                field("Last Prepmt. Cr. Memo No."; Rec."Last Prepmt. Cr. Memo No.")
                {
                    ToolTip = 'Specifies the value of the Last Prepmt. Cr. Memo No. field.', Comment = '%';
                }
                field("Last Return Receipt No."; Rec."Last Return Receipt No.")
                {
                    ToolTip = 'Specifies the value of the Last Return Receipt No. field.', Comment = '%';
                }
                field("Last Shipment Date"; Rec."Last Shipment Date")
                {
                    ToolTip = 'Specifies the value of the Last Shipment Date field.', Comment = '%';
                }
                field("Last Shipping No."; Rec."Last Shipping No.")
                {
                    ToolTip = 'Specifies the value of the Last Shipping No. field.', Comment = '%';
                }
                field("Late Order Shipping"; Rec."Late Order Shipping")
                {
                    ToolTip = 'Indicates a delay in the shipment of one or more lines, or that the shipment date is either the same as or earlier than the work date.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                }
                field("Marcar para agrupar"; Rec."Marcar para agrupar")
                {
                    ToolTip = 'Specifies the value of the Marcar para agrupar field.', Comment = '%';
                }
                field("Multi-picking"; Rec."Multi-picking")
                {
                    ToolTip = 'Specifies the value of the Multi-picking field.', Comment = '%';
                }
                field("NO MULTIPEDIDO"; Rec."NO MULTIPEDIDO")
                {
                    ToolTip = 'Specifies the value of the NO MULTIPEDIDO field.', Comment = '%';
                }
                field("No Enviar albaran en exp."; Rec."No Enviar albaran en exp.")
                {
                    ToolTip = 'Specifies the value of the No Enviar albaran en exp. field.', Comment = '%';
                }
                field("No Enviar factura en exp."; Rec."No Enviar factura en exp.")
                {
                    ToolTip = 'Specifies the value of the No Enviar factura en exp. field.', Comment = '%';
                }
                field("No agrupar en ADAIA"; Rec."No agrupar en ADAIA")
                {
                    ToolTip = 'Specifies the value of the No agrupar en ADAIA field.', Comment = '%';
                }
                field("No agrupar en CANARIAS"; Rec."No agrupar en CANARIAS")
                {
                    ToolTip = 'Specifies the value of the No agrupar en CANARIAS field.', Comment = '%';
                }
                field("No imprimir albaran valorado"; Rec."No imprimir albaran valorado")
                {
                    ToolTip = 'Specifies the value of the No imprimir albaran valorado field.', Comment = '%';
                }
                field("No imprimir facturas"; Rec."No imprimir facturas")
                {
                    ToolTip = 'Specifies the value of the No imprimir facturas field.', Comment = '%';
                }
                field("No incluir portes"; Rec."No incluir portes")
                {
                    ToolTip = 'Specifies the value of the No incluir portes field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the sales document.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies the value of the No. Printed field.', Comment = '%';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.', Comment = '%';
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ToolTip = 'Specifies the number of archived versions for this document.';
                }
                field("Nombre comercial"; Rec."Nombre comercial")
                {
                    ToolTip = 'Specifies the value of the Nombre comercial field.', Comment = '%';
                }
                field("Notificar Envio"; Rec."Notificar Envio")
                {
                    ToolTip = 'Specifies the value of the Notificar Envio field.', Comment = '%';
                }
                field("Notificar Pago"; Rec."Notificar Pago")
                {
                    ToolTip = 'Specifies the value of the Notificar Pago field.', Comment = '%';
                }
                field("Nº Albaran Notificar Envio"; Rec."Nº Albaran Notificar Envio")
                {
                    ToolTip = 'Specifies the value of the Nº Albaran Notificar Envio field.', Comment = '%';
                }
                field("Nº Factura Notificar Envio"; Rec."Nº Factura Notificar Envio")
                {
                    ToolTip = 'Specifies the value of the Nº Factura Notificar Envio field.', Comment = '%';
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
                field("Nº exped. pequeña"; Rec."Nº exped. pequeña")
                {
                    ToolTip = 'Specifies the value of the Nº exped. pequeña field.', Comment = '%';
                }
                field("Nº expedición"; Rec."Nº expedición")
                {
                    ToolTip = 'Specifies the value of the Nº expedición field.', Comment = '%';
                }
                field("Nº expedición agrupada"; Rec."Nº expedición agrupada")
                {
                    ToolTip = 'Specifies the value of the Nº expedición agrupada field.', Comment = '%';
                }
                field("Nº expedición dropshp"; Rec."Nº expedición dropshp")
                {
                    ToolTip = 'Specifies the value of the Nº expedición dropshp field.', Comment = '%';
                }
                field("Observación PDA"; Rec."Observación PDA")
                {
                    ToolTip = 'Specifies the value of the Observación PDA field.', Comment = '%';
                }
                field("Observación para ALMACEN"; Rec."Observación para ALMACEN")
                {
                    ToolTip = 'Specifies the value of the Observación para ALMACEN field.', Comment = '%';
                }
                field("Observación para transporte"; Rec."Observación para transporte")
                {
                    ToolTip = 'Specifies the value of the Observación para transporte field.', Comment = '%';
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
                    ToolTip = 'Specifies the number of the opportunity that the sales quote is assigned to.';
                }
                field("Order Class"; Rec."Order Class")
                {
                    ToolTip = 'Specifies the value of the Order Class field.', Comment = '%';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the date when the order was created.';
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ToolTip = 'Specifies a date formula for the time it takes to get items ready to ship from this location. The time element is used in the calculation of the delivery date as follows: Shipment Date + Outbound Warehouse Handling Time = Planned Shipment Date + Shipping Time = Planned Delivery Date.';
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ToolTip = 'Specifies the shipping agent''s package number.';
                }
                field("Pago Aceptado"; Rec."Pago Aceptado")
                {
                    ToolTip = 'Specifies the value of the Pago Aceptado field.', Comment = '%';
                }
                field("Pay-at Code"; Rec."Pay-at Code")
                {
                    ToolTip = 'Specifies a code associated with a payment address other than the customer''s standard payment address.';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percentage that is granted if the customer pays on or before the date entered in the Pmt. Discount Date field. The discount percentage is specified in the Payment Terms Code field.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
                }
                field("Payment Service Set ID"; Rec."Payment Service Set ID")
                {
                    ToolTip = 'Specifies the value of the Payment Service Set ID field.', Comment = '%';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the sales document.';
                }
                field("Pedido WEB"; Rec."Pedido WEB")
                {
                    ToolTip = 'Specifies the value of the Pedido WEB field.', Comment = '%';
                }
                field("Permite fraccionar uni. venta"; Rec."Permite fraccionar uni. venta")
                {
                    ToolTip = 'Specifies the value of the Permite fraccionar uni. venta field.', Comment = '%';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date when the posting of the sales document will be recorded.';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ToolTip = 'Specifies additional posting information for the document. After you post the document, the description can add detail to vendor and customer ledger entries.';
                }
                field("Posting No."; Rec."Posting No.")
                {
                    ToolTip = 'Specifies the number of the posted invoice that will be created if you post the sales invoice.';
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ToolTip = 'Specifies the value of the Posting No. Series field.', Comment = '%';
                }
                field("Posting from Whse. Ref."; Rec."Posting from Whse. Ref.")
                {
                    ToolTip = 'Specifies the value of the Posting from Whse. Ref. field.', Comment = '%';
                }
                field(Preparador; Rec.Preparador)
                {
                    ToolTip = 'Specifies the value of the Preparador field.', Comment = '%';
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ToolTip = 'Specifies the prepayment percentage to use to calculate the prepayment for sales.';
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    ToolTip = 'Specifies when the prepayment invoice for this sales order is due.';
                }
                field("Prepayment No."; Rec."Prepayment No.")
                {
                    ToolTip = 'Specifies the value of the Prepayment No. field.', Comment = '%';
                }
                field("Prepayment No. Series"; Rec."Prepayment No. Series")
                {
                    ToolTip = 'Specifies the value of the Prepayment No. Series field.', Comment = '%';
                }
                field("Prepmt. Cr. Memo No."; Rec."Prepmt. Cr. Memo No.")
                {
                    ToolTip = 'Specifies the value of the Prepmt. Cr. Memo No. field.', Comment = '%';
                }
                field("Prepmt. Cr. Memo No. Series"; Rec."Prepmt. Cr. Memo No. Series")
                {
                    ToolTip = 'Specifies the value of the Prepmt. Cr. Memo No. Series field.', Comment = '%';
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percent granted on the prepayment if the customer pays on or before the date entered in the Prepmt. Pmt. Discount Date field.';
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ToolTip = 'Specifies the code that represents the payment terms for prepayment invoices related to the sales document.';
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ToolTip = 'Specifies the last date the customer can pay the prepayment invoice and still receive a payment discount on the prepayment amount.';
                }
                field("Prepmt. Posting Description"; Rec."Prepmt. Posting Description")
                {
                    ToolTip = 'Specifies the value of the Prepmt. Posting Description field.', Comment = '%';
                }
                field("Price Calculation Method"; Rec."Price Calculation Method")
                {
                    ToolTip = 'Specifies the value of the Price Calculation Method field.', Comment = '%';
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on document lines should be shown with or without VAT.';
                }
                field("Print Posted Documents"; Rec."Print Posted Documents")
                {
                    ToolTip = 'Specifies the value of the Print Posted Documents field.', Comment = '%';
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ToolTip = 'Specifies the date that you have promised to deliver the order, as a result of the Order Promising function.';
                }
                field("Provincia shopyfi"; Rec."Provincia shopyfi")
                {
                    ToolTip = 'Specifies the value of the Provincia shopyfi field.', Comment = '%';
                }
                field("Puede retocar"; Rec."Puede retocar")
                {
                    ToolTip = 'Specifies the value of the Puede retocar field.', Comment = '%';
                }
                field("Quote Accepted"; Rec."Quote Accepted")
                {
                    ToolTip = 'Specifies the value of the Quote Accepted field.', Comment = '%';
                }
                field("Quote Accepted Date"; Rec."Quote Accepted Date")
                {
                    ToolTip = 'Specifies the value of the Quote Accepted Date field.', Comment = '%';
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ToolTip = 'Specifies the number of the sales quote that the sales order was created from. You can track the number to sales quote documents that you have printed, saved, or emailed.';
                }
                field("Quote Sent to Customer"; Rec."Quote Sent to Customer")
                {
                    ToolTip = 'Specifies the value of the Quote Sent to Customer field.', Comment = '%';
                }
                field("Quote Valid Until Date"; Rec."Quote Valid Until Date")
                {
                    ToolTip = 'Specifies how long the quote is valid.';
                }
                field("REFTRANS EDICOM"; Rec."REFTRANS EDICOM")
                {
                    ToolTip = 'Specifies the value of the REFTRANS EDICOM field.', Comment = '%';
                }
                field("Rcvd.-from Count./Region Code"; Rec."Rcvd.-from Count./Region Code")
                {
                    ToolTip = 'Specifies the country or region from which the items are returned for the purpose of Intrastat reporting.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the document.';
                }
                field("Recalculate Invoice Disc."; Rec."Recalculate Invoice Disc.")
                {
                    ToolTip = 'Specifies the value of the Recalculate Invoice Disc. field.', Comment = '%';
                }
                field(Receive; Rec.Receive)
                {
                    ToolTip = 'Specifies the value of the Receive field.', Comment = '%';
                }
                field("Recibido de adaia"; Rec."Recibido de adaia")
                {
                    ToolTip = 'Specifies the value of the Recibido de adaia field.', Comment = '%';
                }
                field("Recibido y facturado"; Rec."Recibido y facturado")
                {
                    ToolTip = 'Specifies the value of the Recibido y facturado field.', Comment = '%';
                }
                field(Reembolso; Rec.Reembolso)
                {
                    ToolTip = 'Specifies the value of the Reembolso field.', Comment = '%';
                }
                field("Referencia Pedido Presta Shop"; Rec."Referencia Pedido Presta Shop")
                {
                    ToolTip = 'Specifies the value of the Referencia Pedido Presta Shop field.', Comment = '%';
                }
                field("Registration Number"; Rec."Registration Number")
                {
                    ToolTip = 'Specifies the customer''s registration number.';
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ToolTip = 'Specifies the date that the customer has asked for the order to be delivered.';
                }
                field(Reserve; Rec.Reserve)
                {
                    ToolTip = 'Specifies the value of the Reserve field.', Comment = '%';
                }
                field("Respeta Tipo facturacion"; Rec."Respeta Tipo facturacion")
                {
                    ToolTip = 'Specifies the value of the Respeta Tipo facturacion field.', Comment = '%';
                }
                field("Respeta agencia transporte"; Rec."Respeta agencia transporte")
                {
                    ToolTip = 'Specifies the value of the Respeta agencia transporte field.', Comment = '%';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the code of the responsibility center, such as a distribution hub, that is associated with the involved user, company, customer, or vendor.';
                }
                field("Return Receipt No."; Rec."Return Receipt No.")
                {
                    ToolTip = 'Specifies the value of the Return Receipt No. field.', Comment = '%';
                }
                field("Return Receipt No. Series"; Rec."Return Receipt No. Series")
                {
                    ToolTip = 'Specifies the value of the Return Receipt No. Series field.', Comment = '%';
                }
                field("SII First Summary Doc. No."; Rec."SII First Summary Doc. No.")
                {
                    ToolTip = 'Specifies the value of the First Summary Doc. No. field.', Comment = '%';
                }
                field("SII Last Summary Doc. No."; Rec."SII Last Summary Doc. No.")
                {
                    ToolTip = 'Specifies the value of the Last Summary Doc. No. field.', Comment = '%';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the name of the sales person who is assigned to the customer.';
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ToolTip = 'Specifies the customer''s address.';
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ToolTip = 'Specifies an additional part of the customer''s address.';
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ToolTip = 'Specifies the city of the customer''s address.';
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ToolTip = 'Specifies the name of the person to contact at the customer that the items were sold to.';
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ToolTip = 'Specifies the number of the contact person at the customer.';
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                }
                field("Sell-to County"; Rec."Sell-to County")
                {
                    ToolTip = 'Specifies the county of the address.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the name of the customer who will receive the products and be billed by default.';
                }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer Name 2 field.', Comment = '%';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer who will receive the products and be billed by default.';
                }
                field("Sell-to Customer Templ. Code"; Rec."Sell-to Customer Templ. Code")
                {
                    ToolTip = 'Specifies the code for the template to create a new customer';
                }
                field("Sell-to E-Mail"; Rec."Sell-to E-Mail")
                {
                    ToolTip = 'Specifies the email address of the contact person that the sales document will be sent to.';
                }
                field("Sell-to IC Partner Code"; Rec."Sell-to IC Partner Code")
                {
                    ToolTip = 'Specifies the value of the Sell-to IC Partner Code field.', Comment = '%';
                }
                field("Sell-to Phone No."; Rec."Sell-to Phone No.")
                {
                    ToolTip = 'Specifies the telephone number of the contact person that the sales document will be sent to.';
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                }
                field("Send IC Document"; Rec."Send IC Document")
                {
                    ToolTip = 'Specifies the value of the Send IC Document field.', Comment = '%';
                }
                field(Ship; Rec.Ship)
                {
                    ToolTip = 'Specifies the value of the Ship field.', Comment = '%';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the address that products on the sales document will be shipped to. By default, the field is filled with the value in the Address field on the customer card or with the value in the Address field in the Ship-to Address window.';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies an additional part of the shipping address.';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the city of the shipping address.';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies a code for an alternate shipment address if you want to ship to another address than the one that has been entered automatically. This field is also used in case of drop shipment.';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of the contact person at the address that products will be shipped to.';
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ToolTip = 'Specifies the county of the address.';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                }
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Ship-to Name 2 field.', Comment = '%';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the delivery conditions of the related shipment, such as free on board (FOB).';
                }
                field(Shipped; Rec.Shipped)
                {
                    ToolTip = 'Specifies the value of the Shipped field.', Comment = '%';
                }
                field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
                {
                    ToolTip = 'Specifies the value of the Shipped Not Invoiced field.', Comment = '%';
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ToolTip = 'Specifies if the customer accepts partial shipment of orders.';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the code for the shipping agent who is transporting the items.';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ToolTip = 'Specifies the code for the service, such as a one-day delivery, that is offered by the shipping agent.';
                }
                field("Shipping No."; Rec."Shipping No.")
                {
                    ToolTip = 'Specifies the value of the Shipping No. field.', Comment = '%';
                }
                field("Shipping No. Series"; Rec."Shipping No. Series")
                {
                    ToolTip = 'Specifies the value of the Shipping No. Series field.', Comment = '%';
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ToolTip = 'Specifies how long it takes from when the items are shipped from the warehouse to when they are delivered.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Special Scheme Code"; Rec."Special Scheme Code")
                {
                    ToolTip = 'Specifies the Special Scheme Code.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';
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
                field(SupraOferta; Rec.SupraOferta)
                {
                    ToolTip = 'Specifies the value of the SupraOferta field.', Comment = '%';
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
                    ToolTip = 'Specifies if this vendor charges you sales tax for purchases.';
                }
                field(Televendedor; Rec.Televendedor)
                {
                    ToolTip = 'Specifies the value of the Televendedor field.', Comment = '%';
                }
                field("Texto Descuento Presta Shop"; Rec."Texto Descuento Presta Shop")
                {
                    ToolTip = 'Specifies the value of the Texto Descuento Presta Shop field.', Comment = '%';
                }
                field("Tipo de documento EDICOM"; Rec."Tipo de documento EDICOM")
                {
                    ToolTip = 'Specifies the value of the Tipo de documento EDICOM field.', Comment = '%';
                }
                field("Tipo facturación"; Rec."Tipo facturación")
                {
                    ToolTip = 'Specifies the value of the Tipo facturación field.', Comment = '%';
                }
                field("Tipo transporte EDICOM"; Rec."Tipo transporte EDICOM")
                {
                    ToolTip = 'Specifies the value of the Tipo transporte EDICOM field.', Comment = '%';
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
                    ToolTip = 'Specifies a specification of the document''s transaction, for the purpose of reporting to INTRASTAT.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the type of transaction that the document represents, for the purpose of reporting to INTRASTAT.';
                }
                field("Transferencia web"; Rec."Transferencia web")
                {
                    ToolTip = 'Specifies the value of the Transferencia web field.', Comment = '%';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the transport method, for the purpose of reporting to INTRASTAT.';
                }
                field(Urgente; Rec.Urgente)
                {
                    ToolTip = 'Specifies the value of the Urgente field.', Comment = '%';
                }
                field("Usuario Retenido"; Rec."Usuario Retenido")
                {
                    ToolTip = 'Specifies the value of the Usuario Retenido field.', Comment = '%';
                }
                field("Usuario alta"; Rec."Usuario alta")
                {
                    ToolTip = 'Specifies the value of the Usuario alta field.', Comment = '%';
                }
                field("Usuario para preparar"; Rec."Usuario para preparar")
                {
                    ToolTip = 'Specifies the value of the Usuario para preparar field.', Comment = '%';
                }
                field("VAT Base Discount %"; Rec."VAT Base Discount %")
                {
                    ToolTip = 'Specifies the value of the VAT Base Discount % field.', Comment = '%';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
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
                    ToolTip = 'Specifies the date used to include entries on VAT reports in a VAT period. This is either the date that the document was created or posted, depending on your setting on the General Ledger Setup page.';
                }
                field("Work Description"; Rec."Work Description")
                {
                    ToolTip = 'Specifies the value of the Work Description field.', Comment = '%';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ToolTip = 'Specifies the customer''s reference. The content will be printed on sales documents.';
                }
            }
        }
    }
}
