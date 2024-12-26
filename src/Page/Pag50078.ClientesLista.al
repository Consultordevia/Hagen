#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50078 "Clientes Lista"
{
    PageType = List;
    SourceTable = Customer;     
    ApplicationArea = All;
    Caption = 'Clientes Lista';     
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Last Modified Date Time"; Rec."Last Modified Date Time")
                {
                    ApplicationArea = Basic;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Basic;
                }
                field("Mas comerciales"; Rec."Mas comerciales")
                {
                    ApplicationArea = Basic;
                }
                field("Observación para ALMACEN"; Rec."Observación para ALMACEN")
                {
                    ApplicationArea = Basic;
                }
                field("Observación PDA"; Rec."Observación PDA")
                {
                    ApplicationArea = Basic;
                }
                field("Tipo Factura SII"; Rec."Tipo Factura SII")
                {
                    ApplicationArea = Basic;
                }
                field("Enviar pdfs a WEB"; Rec."Enviar pdfs a WEB")
                {
                    ApplicationArea = Basic;
                }
                field("Enviar a Web"; Rec."Enviar a Web")
                {
                    ApplicationArea = Basic;
                }
                field("Email facturacion 1"; Rec."Email facturacion 1")
                {
                    ApplicationArea = Basic;
                }
                field("Email facturacion 2"; Rec."Email facturacion 2")
                {
                    ApplicationArea = Basic;
                }
                field("Email facturacion 3"; Rec."Email facturacion 3")
                {
                    ApplicationArea = Basic;
                }
                field("Email abono 1"; Rec."Email abono 1")
                {
                    ApplicationArea = Basic;
                }
                field("Email abono 2"; Rec."Email abono 2")
                {
                    ApplicationArea = Basic;
                }
                field("Email albaran sin detalle 1"; Rec."Email albaran sin detalle 1")
                {
                    ApplicationArea = Basic;
                }
                field("No agrupar en ADAIA"; Rec."No agrupar en ADAIA")
                {
                    ApplicationArea = Basic;
                }
                field("Enviar etiqueta grande"; Rec."Enviar etiqueta grande")
                {
                    ApplicationArea = Basic;
                }
                field("No enviar cartas contables"; Rec."No enviar cartas contables")
                {
                    ApplicationArea = Basic;
                }
                field("No enviar a EDICOM"; Rec."No enviar a EDICOM")
                {
                    ApplicationArea = Basic;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = Basic;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = Basic;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = Basic;
                }
                field("Check Clientes FTP"; Rec."Check Clientes FTP")
                {
                    ApplicationArea = Basic;
                }
                field("Ruta Pedido"; Rec."Ruta Pedido")
                {
                    ApplicationArea = Basic;
                }
                field("Ruta Albaran"; Rec."Ruta Albaran")
                {
                    ApplicationArea = Basic;
                }
                field("Ruta Factura"; Rec."Ruta Factura")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = Basic;
                }
                field("A quien se factura"; Rec."A quien se factura")
                {
                    ApplicationArea = Basic;
                }
                field("Quien pide"; Rec."Quien pide")
                {
                    ApplicationArea = Basic;
                }
                field("Central compradora"; Rec."Central compradora")
                {
                    ApplicationArea = Basic;
                }
                field("Quien paga"; Rec."Quien paga")
                {
                    ApplicationArea = Basic;
                }
                field("Sucrusal entrega"; Rec."Sucrusal entrega")
                {
                    ApplicationArea = Basic;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = Basic;
                }
                field("Grupo clientes"; Rec."Grupo clientes")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Nombre_Cliente; Rec.Nombre_Cliente)
                {
                    ApplicationArea = Basic;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Due (LCY)"; Rec."Balance Due (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Permite seguir adelante"; Rec."Permite seguir adelante")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = Basic;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = Basic;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document Sending Profile"; Rec."Document Sending Profile")
                {
                    ApplicationArea = Basic;
                }
                field("Our Account No."; Rec."Our Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Territory Code"; Rec."Territory Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Chain Name"; Rec."Chain Name")
                {
                    ApplicationArea = Basic;
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = Basic;
                }
                field("Statistics Group"; Rec."Statistics Group")
                {
                    ApplicationArea = Basic;
                }
                field("Fin. Charge Terms Code"; Rec."Fin. Charge Terms Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field("Place of Export"; Rec."Place of Export")
                {
                    ApplicationArea = Basic;
                }
                field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ApplicationArea = Basic;
                }
                field("Grupo dto. cliente 2"; Rec."Grupo dto. cliente 2")
                {
                    ApplicationArea = Basic;
                }
                field("Grupo dto. cliente 3"; Rec."Grupo dto. cliente 3")
                {
                    ApplicationArea = Basic;
                }
                field("Grupo dto. cliente 4"; Rec."Grupo dto. cliente 4")
                {
                    ApplicationArea = Basic;
                }
                field("Grupo dto. cliente 5"; Rec."Grupo dto. cliente 5")
                {
                    ApplicationArea = Basic;
                }
                field("Collection Method"; Rec."Collection Method")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field("Invoice Copies"; Rec."Invoice Copies")
                {
                    ApplicationArea = Basic;
                }
                field("Last Statement No."; Rec."Last Statement No.")
                {
                    ApplicationArea = Basic;
                }
                field("Print Statements"; Rec."Print Statements")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Filter"; Rec."Global Dimension 1 Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Filter"; Rec."Global Dimension 2 Filter")
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Net Change"; Rec."Net Change")
                {
                    ApplicationArea = Basic;
                }
                field("Net Change (LCY)"; Rec."Net Change (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Sales (LCY)"; Rec."Sales (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Profit (LCY)"; Rec."Profit (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Inv. Discounts (LCY)"; Rec."Inv. Discounts (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Pmt. Discounts (LCY)"; Rec."Pmt. Discounts (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Due"; Rec."Balance Due")
                {
                    ApplicationArea = Basic;
                }
                field(Payments; Rec.Payments)
                {
                    ApplicationArea = Basic;
                }
                field("Invoice Amounts"; Rec."Invoice Amounts")
                {
                    ApplicationArea = Basic;
                }
                field("Cr. Memo Amounts"; Rec."Cr. Memo Amounts")
                {
                    ApplicationArea = Basic;
                }
                field("Finance Charge Memo Amounts"; Rec."Finance Charge Memo Amounts")
                {
                    ApplicationArea = Basic;
                }
                field("Payments (LCY)"; Rec."Payments (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Inv. Amounts (LCY)"; Rec."Inv. Amounts (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Cr. Memo Amounts (LCY)"; Rec."Cr. Memo Amounts (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Fin. Charge Memo Amounts (LCY)"; Rec."Fin. Charge Memo Amounts (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Orders"; Rec."Outstanding Orders")
                {
                    ApplicationArea = Basic;
                }
                field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
                {
                    ApplicationArea = Basic;
                }
                field("Application Method"; Rec."Application Method")
                {
                    ApplicationArea = Basic;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = Basic;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = Basic;
                }
                field("Telex Answer Back"; Rec."Telex Answer Back")
                {
                    ApplicationArea = Basic;
                }
                field("Combine Shipments"; Rec."Combine Shipments")
                {
                    ApplicationArea = Basic;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(GLN; Rec.GLN)
                {
                    ApplicationArea = Basic;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = Basic;
                }
                field("Reminder Terms Code"; Rec."Reminder Terms Code")
                {
                    ApplicationArea = Basic;
                }
                field("Reminder Amounts"; Rec."Reminder Amounts")
                {
                    ApplicationArea = Basic;
                }
                field("Reminder Amounts (LCY)"; Rec."Reminder Amounts (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = Basic;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Filter"; Rec."Currency Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Orders (LCY)"; Rec."Outstanding Orders (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Shipped Not Invoiced (LCY)"; Rec."Shipped Not Invoiced (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = Basic;
                }
                field("Block Payment Tolerance"; Rec."Block Payment Tolerance")
                {
                    ApplicationArea = Basic;
                }
                field("Pmt. Disc. Tolerance (LCY)"; Rec."Pmt. Disc. Tolerance (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Pmt. Tolerance (LCY)"; Rec."Pmt. Tolerance (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = Basic;
                }
                field(Refunds; Rec.Refunds)
                {
                    ApplicationArea = Basic;
                }
                field("Refunds (LCY)"; Rec."Refunds (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Other Amounts"; Rec."Other Amounts")
                {
                    ApplicationArea = Basic;
                }
                field("Other Amounts (LCY)"; Rec."Other Amounts (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Invoices (LCY)"; Rec."Outstanding Invoices (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Invoices"; Rec."Outstanding Invoices")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to No. Of Archived Doc."; Rec."Bill-to No. Of Archived Doc.")
                {
                    ApplicationArea = Basic;
                }
                field("Sell-to No. Of Archived Doc."; Rec."Sell-to No. Of Archived Doc.")
                {
                    ApplicationArea = Basic;
                }
                field(Image; Rec.Image)
                {
                    ApplicationArea = Basic;
                }
                field("Preferred Bank Account Code"; Rec."Preferred Bank Account Code")
                {
                    ApplicationArea = Basic;
                }
                field("Cash Flow Payment Terms Code"; Rec."Cash Flow Payment Terms Code")
                {
                    ApplicationArea = Basic;
                }
                field("Catalogo Shopify"; Rec."Catalogo Shopify")
                {
                    ApplicationArea = Basic;
                }

                field("Primary Contact No."; Rec."Primary Contact No.")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = Basic;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = Basic;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = Basic;
                }
                field("Service Zone Code"; Rec."Service Zone Code")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Gain/Loss Amount"; Rec."Contract Gain/Loss Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Filter"; Rec."Ship-to Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Serv. Orders (LCY)"; Rec."Outstanding Serv. Orders (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Serv Shipped Not Invoiced(LCY)"; Rec."Serv Shipped Not Invoiced(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Serv.Invoices(LCY)"; Rec."Outstanding Serv.Invoices(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Quotes"; Rec."No. of Quotes")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Blanket Orders"; Rec."No. of Blanket Orders")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Orders"; Rec."No. of Orders")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Invoices"; Rec."No. of Invoices")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Return Orders"; Rec."No. of Return Orders")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Credit Memos"; Rec."No. of Credit Memos")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Pstd. Shipments"; Rec."No. of Pstd. Shipments")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Pstd. Invoices"; Rec."No. of Pstd. Invoices")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Pstd. Return Receipts"; Rec."No. of Pstd. Return Receipts")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Pstd. Credit Memos"; Rec."No. of Pstd. Credit Memos")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Ship-to Addresses"; Rec."No. of Ship-to Addresses")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-To No. of Quotes"; Rec."Bill-To No. of Quotes")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-To No. of Blanket Orders"; Rec."Bill-To No. of Blanket Orders")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-To No. of Orders"; Rec."Bill-To No. of Orders")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-To No. of Invoices"; Rec."Bill-To No. of Invoices")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-To No. of Return Orders"; Rec."Bill-To No. of Return Orders")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-To No. of Credit Memos"; Rec."Bill-To No. of Credit Memos")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-To No. of Pstd. Shipments"; Rec."Bill-To No. of Pstd. Shipments")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-To No. of Pstd. Invoices"; Rec."Bill-To No. of Pstd. Invoices")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-To No. of Pstd. Return R."; Rec."Bill-To No. of Pstd. Return R.")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-To No. of Pstd. Cr. Memos"; Rec."Bill-To No. of Pstd. Cr. Memos")
                {
                    ApplicationArea = Basic;
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    ApplicationArea = Basic;
                }
                field("Copy Sell-to Addr. to Qte From"; Rec."Copy Sell-to Addr. to Qte From")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Days Code"; Rec."Payment Days Code")
                {
                    ApplicationArea = Basic;
                }
                field("Non-Paymt. Periods Code"; Rec."Non-Paymt. Periods Code")
                {
                    ApplicationArea = Basic;
                }
                field("Clasificación A,B,C Hagen"; Rec."Clasificación A,B,C Hagen")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha alta"; Rec."Fecha alta")
                {
                    ApplicationArea = Basic;
                }
                field("Modificado por"; Rec."Modificado por")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha de Modificación"; Rec."Fecha de Modificación")
                {
                    ApplicationArea = Basic;
                }
                field("Tipo facturación"; Rec."Tipo facturación")
                {
                    ApplicationArea = Basic;
                }
                field("Aviso Notas"; Rec."Aviso Notas")
                {
                    ApplicationArea = Basic;
                }
                field("Frecuencia visita comercial"; Rec."Frecuencia visita comercial")
                {
                    ApplicationArea = Basic;
                }
                field(Televendedor; Rec.Televendedor)
                {
                    ApplicationArea = Basic;
                }
                field("Nº pedido obligatorio"; Rec."Nº pedido obligatorio")
                {
                    ApplicationArea = Basic;
                }
                field("Servicio email"; Rec."Servicio email")
                {
                    ApplicationArea = Basic;
                }
                field("Usuario alta"; Rec."Usuario alta")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha clasificación A,B,C"; Rec."Fecha clasificación A,B,C")
                {
                    ApplicationArea = Basic;
                }
                field("Zona de ventas"; Rec."Zona de ventas")
                {
                    ApplicationArea = Basic;
                }
                field("Clasificacion CRM"; Rec."Clasificacion CRM")
                {
                    ApplicationArea = Basic;
                }
                field("Nombre vendedor"; Rec."Nombre vendedor")
                {
                    ApplicationArea = Basic;
                }
                field(Borrado; Rec.Borrado)
                {
                    ApplicationArea = Basic;
                }
                field("Telefono 2"; Rec."Telefono 2")
                {
                    ApplicationArea = Basic;
                }
                field("Nº movil"; Rec."Nº movil")
                {
                    ApplicationArea = Basic;
                }
                field("Observación para transporte"; Rec."Observación para transporte")
                {
                    ApplicationArea = Basic;
                }
                field("Albaran sin detalle"; Rec."Albaran sin detalle")
                {
                    ApplicationArea = Basic;
                }
                field("No enviar excel"; Rec."No enviar excel")
                {
                    ApplicationArea = Basic;
                }
                field("Clasificación A,B,C Vendedor"; Rec."Clasificación A,B,C Vendedor")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha Clasi. A,B,C Vendedor"; Rec."Fecha Clasi. A,B,C Vendedor")
                {
                    ApplicationArea = Basic;
                }
                field("Contacto en factura"; Rec."Contacto en factura")
                {
                    ApplicationArea = Basic;
                }
                field("No Enviar factura en exp."; Rec."No Enviar factura en exp.")
                {
                    ApplicationArea = Basic;
                }
                field("No Enviar albaran en exp."; Rec."No Enviar albaran en exp.")
                {
                    ApplicationArea = Basic;
                }
                field("Correo elect. Comercial"; Rec."Correo elect. Comercial")
                {
                    ApplicationArea = Basic;
                }
                field("Estatus del cliente"; Rec."Estatus del cliente")
                {
                    ApplicationArea = Basic;
                }
                field("Incluir en propaganda"; Rec."Incluir en propaganda")
                {
                    ApplicationArea = Basic;
                }
                field("No incluir portes"; Rec."No incluir portes")
                {
                    ApplicationArea = Basic;
                }
                field("Respeta agencia transporte"; Rec."Respeta agencia transporte")
                {
                    ApplicationArea = Basic;
                }
                field("Importe impagado"; Rec."Importe impagado")
                {
                    ApplicationArea = Basic;
                }
                field("Importe vencido"; Rec."Importe vencido")
                {
                    ApplicationArea = Basic;
                }
                field("Respeta Tipo facturacion"; Rec."Respeta Tipo facturacion")
                {
                    ApplicationArea = Basic;
                }
                field("No imprimir facturas"; Rec."No imprimir facturas")
                {
                    ApplicationArea = Basic;
                }
                field("Dias tolerancias fecha vto."; Rec."Dias tolerancias fecha vto.")
                {
                    ApplicationArea = Basic;
                }
                field("No enviar emial de preparacion"; Rec."No enviar emial de preparacion")
                {
                    ApplicationArea = Basic;
                }
                field("Factura ordenada"; Rec."Factura ordenada")
                {
                    ApplicationArea = Basic;
                }
                field("Email pedido 1"; Rec."Email pedido 1")
                {
                    ApplicationArea = Basic;
                }
                field("Email pedido 2"; Rec."Email pedido 2")
                {
                    ApplicationArea = Basic;
                }
                field("Adjuntar pub. facturacion 1"; Rec."Adjuntar pub. facturacion 1")
                {
                    ApplicationArea = Basic;
                }
                field("Adjuntar pub. facturacion 2"; Rec."Adjuntar pub. facturacion 2")
                {
                    ApplicationArea = Basic;
                }
                field("Adjuntar pub. facturacion 3"; Rec."Adjuntar pub. facturacion 3")
                {
                    ApplicationArea = Basic;
                }
                field("Adjuntar pub. albaran sin det."; Rec."Adjuntar pub. albaran sin det.")
                {
                    ApplicationArea = Basic;
                }
                field("Adjuntar pub. abono 1"; Rec."Adjuntar pub. abono 1")
                {
                    ApplicationArea = Basic;
                }
                field("Adjuntar pub. abono 2"; Rec."Adjuntar pub. abono 2")
                {
                    ApplicationArea = Basic;
                }
                field("Adjuntar pub. pedido 1"; Rec."Adjuntar pub. pedido 1")
                {
                    ApplicationArea = Basic;
                }
                field("Adjuntar pub. pedido 2"; Rec."Adjuntar pub. pedido 2")
                {
                    ApplicationArea = Basic;
                }
                field("Adjuntar pub. albaran 1"; Rec."Adjuntar pub. albaran 1")
                {
                    ApplicationArea = Basic;
                }
                field("Adjuntar pub. albaran 2"; Rec."Adjuntar pub. albaran 2")
                {
                    ApplicationArea = Basic;
                }
                field("Adjuntar pub. albaran 3"; Rec."Adjuntar pub. albaran 3")
                {
                    ApplicationArea = Basic;
                }
                field("No imprimir albaran valorado"; Rec."No imprimir albaran valorado")
                {
                    ApplicationArea = Basic;
                }
                field("Nº serie factura registro"; Rec."Nº serie factura registro")
                {
                    ApplicationArea = Basic;
                }
                field("Impresion fact. sin dto."; Rec."Impresion fact. sin dto.")
                {
                    ApplicationArea = Basic;
                }
                field("Centro ECI"; Rec."Centro ECI")
                {
                    ApplicationArea = Basic;
                }
                field("Factura con PVP"; Rec."Factura con PVP")
                {
                    ApplicationArea = Basic;
                }
                field(Latitud; Rec.Latitud)
                {
                    ApplicationArea = Basic;
                }
                field(Longitud; Rec.Longitud)
                {
                    ApplicationArea = Basic;
                }
                field(Comunidad; Rec.Comunidad)
                {
                    ApplicationArea = Basic;
                }
                field("Factura CSV"; Rec."Factura CSV")
                {
                    ApplicationArea = Basic;
                }
                field("Albaran CSV"; Rec."Albaran CSV")
                {
                    ApplicationArea = Basic;
                }
                field("Codigo cliente externo"; Rec."Codigo cliente externo")
                {
                    ApplicationArea = Basic;
                }
                field("Ruta envio CSV"; Rec."Ruta envio CSV")
                {
                    ApplicationArea = Basic;
                }
                field("Grupo ventas"; Rec."Grupo ventas")
                {
                    ApplicationArea = Basic;
                }
                field("Localizacion tienda"; Rec."Localizacion tienda")
                {
                    ApplicationArea = Basic;
                }
                field("Tipo negocio"; Rec."Tipo negocio")
                {
                    ApplicationArea = Basic;
                }
                field("Año apertura"; Rec."Año apertura")
                {
                    ApplicationArea = Basic;
                }
                field("Ruta comercial"; Rec."Ruta comercial")
                {
                    ApplicationArea = Basic;
                }
                field("NULO Tipo socio"; Rec."NULO Tipo socio")
                {
                    ApplicationArea = Basic;
                }
                field("Partner Type"; Rec."Partner Type")
                {
                    ApplicationArea = Basic;
                }
                field("Contraseña WEB"; Rec."Contraseña WEB")
                {
                    ApplicationArea = Basic;
                }
                field("Nº proveedor"; Rec."Nº proveedor")
                {
                    ApplicationArea = Basic;
                }
                field("Usuario Web"; Rec."Usuario Web")
                {
                    ApplicationArea = Basic;
                }
                field("Nombre para email"; Rec."Nombre para email")
                {
                    ApplicationArea = Basic;
                }
                field("No email chimp"; Rec."No email chimp")
                {
                    ApplicationArea = Basic;
                }
                field("No incluir en ruta CRM"; Rec."No incluir en ruta CRM")
                {
                    ApplicationArea = Basic;
                }
                field("Atencion comercial"; Rec."Atencion comercial")
                {
                    ApplicationArea = Basic;
                }
                field("Actualizar WEB"; Rec."Actualizar WEB")
                {
                    ApplicationArea = Basic;
                }
                field("Enviar a Web Distribuidor"; Rec."Enviar a Web Distribuidor")
                {
                    ApplicationArea = Basic;
                }
                field("Direccion Envio Habitual Store"; Rec."Direccion Envio Habitual Store")
                {
                    ApplicationArea = Basic;
                }
                field("Metros Establecimiento"; Rec."Metros Establecimiento")
                {
                    ApplicationArea = Basic;
                }
                field("Números de Empleados"; Rec."Números de Empleados")
                {
                    ApplicationArea = Basic;
                }
                field(N1; Rec.N1)
                {
                    ApplicationArea = Basic;
                }
                field(N2; Rec.N2)
                {
                    ApplicationArea = Basic;
                }
                field("Como nos conocio"; Rec."Como nos conocio")
                {
                    ApplicationArea = Basic;
                }
                field(Perros; Rec.Perros)
                {
                    ApplicationArea = Basic;
                }
                field(Gatos; Rec.Gatos)
                {
                    ApplicationArea = Basic;
                }
                field(Pajaros; Rec.Pajaros)
                {
                    ApplicationArea = Basic;
                }
                field(Acuariofilia; Rec.Acuariofilia)
                {
                    ApplicationArea = Basic;
                }
                field(Reptiles; Rec.Reptiles)
                {
                    ApplicationArea = Basic;
                }
                field("Pequeños animales"; Rec."Pequeños animales")
                {
                    ApplicationArea = Basic;
                }
                field(Estanques; Rec.Estanques)
                {
                    ApplicationArea = Basic;
                }
                field("Emite nuestras facturas"; Rec."Emite nuestras facturas")
                {
                    ApplicationArea = Basic;
                }
                field("Cliente Inversion Sujeto Pasiv"; Rec."Cliente Inversion Sujeto Pasiv")
                {
                    ApplicationArea = Basic;
                }
                field("Comentario factura"; Rec."Comentario factura")
                {
                    ApplicationArea = Basic;
                }


            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ASD)
            {
                ApplicationArea = Basic;
                ShortCutKey = 'F9';

                trigger OnAction()
                begin



                    if Customer.FindFirst then
                        repeat
                            if Customer."Email facturacion 1" = 'info@catit.es' then begin
                                Customer."Tipo Factura SII" := Customer."tipo factura sii"::F2;
                                Customer.Modify;
                            end;
                        until Customer.Next = 0;

                    Message('hecho');


                    ///"Enviar pdfs a WEB":=FALSE;

                    ///"Email albaran sin detalle 1":='info@catit.es';
                    ///"Email facturacion 1":='info@catit.es';
                    ///"Email facturacion 2":='';
                    ///"Email facturacion 3":='';
                    ///"Email abono 1":='info@catit.es';
                    ///"Em///ail abono 2":='';
                    ///MODIFY;

                    /////VALIDATE("Search Name");
                    /////MODIFY;

                    /////C50000.RUN;

                    /////"Customer Disc. Group":='KIWOKO';
                    ///Rec."VAT Registration No.":="Country/Region Code"+Rec."VAT Registration No.";
                    /////MODIFY;
                end;
            }
        }
    }

    var
        /////- C50000: Codeunit UnknownCodeunit50000;
        Customer: Record Customer;
}

