page 50004 CabAlbaran
{
    ApplicationArea = All;
    Caption = 'CabAlbaran';
    PageType = List;
    SourceTable = "Sales Shipment Header";
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
                field(Actividad; Rec.Actividad)
                {
                    ToolTip = 'Specifies the value of the Actividad field.', Comment = '%';
                }
                field("Albaran facturado"; Rec."Albaran facturado")
                {
                    ToolTip = 'Specifies the value of the Albaran facturado field.', Comment = '%';
                }
                field("Albaran sin detalle"; Rec."Albaran sin detalle")
                {
                    ToolTip = 'Specifies the value of the Albaran sin detalle field.', Comment = '%';
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ToolTip = 'Specifies the value of the Allow Line Disc. field.', Comment = '%';
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
                    ToolTip = 'Specifies the value of the Applies-to Doc. No. field.', Comment = '%';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ToolTip = 'Specifies the value of the Applies-to Doc. Type field.', Comment = '%';
                }
                field("Area"; Rec."Area")
                {
                    ToolTip = 'Specifies the value of the Area field.', Comment = '%';
                }
                field("Aviso falta stock"; Rec."Aviso falta stock")
                {
                    ToolTip = 'Specifies the value of the Aviso falta stock field.', Comment = '%';
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
                    ToolTip = 'Specifies the address that you sent the invoice to.';
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ToolTip = 'Specifies the extended address that you sent the invoice to.';
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ToolTip = 'Specifies the city of the customer on the sales document.';
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact at the customer to whom you sent the invoice.';
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ToolTip = 'Specifies the number of the contact person at the customer''s bill-to address.';
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country or region of the address.';
                }
                field("Bill-to County"; Rec."Bill-to County")
                {
                    ToolTip = 'Specifies the state, province or county as a part of the address.';
                }
                field("Bill-to Customer Id"; Rec."Bill-to Customer Id")
                {
                    ToolTip = 'Specifies the value of the Bill-to Customer Id field.', Comment = '%';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer that you send or sent the invoice or credit memo to.';
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that you sent the invoice to.';
                }
                field("Bill-to Name 2"; Rec."Bill-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Bill-to Name 2 field.', Comment = '%';
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the customer''s bill-to address.';
                }
                field("CSV Enviar"; Rec."CSV Enviar")
                {
                    ToolTip = 'Specifies the value of the CSV Enviar field.', Comment = '%';
                }
                field("CSV Fecha enviado"; Rec."CSV Fecha enviado")
                {
                    ToolTip = 'Specifies the value of the CSV Fecha enviado field.', Comment = '%';
                }
                field("CSV enviado"; Rec."CSV enviado")
                {
                    ToolTip = 'Specifies the value of the CSV enviado field.', Comment = '%';
                }
                field("CSV enviado catit"; Rec."CSV enviado catit")
                {
                    ToolTip = 'Specifies the value of the CSV enviado catit field.', Comment = '%';
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ToolTip = 'Specifies the value of the Campaign No. field.', Comment = '%';
                }
                field("Cantidad enviada"; Rec."Cantidad enviada")
                {
                    ToolTip = 'Specifies the value of the Cantidad enviada field.', Comment = '%';
                }
                field("Cantidad enviada no facturada"; Rec."Cantidad enviada no facturada")
                {
                    ToolTip = 'Specifies the value of the Cantidad enviada no facturada field.', Comment = '%';
                }
                field("Cantidad facturada"; Rec."Cantidad facturada")
                {
                    ToolTip = 'Specifies the value of the Cantidad facturada field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
                field("Company Bank Account Code"; Rec."Company Bank Account Code")
                {
                    ToolTip = 'Specifies the value of the Company Bank Account Code field.', Comment = '%';
                }
                field(Correction; Rec.Correction)
                {
                    ToolTip = 'Specifies the value of the Correction field.', Comment = '%';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code of the shipment.';
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.', Comment = '%';
                }
                field("Cust. Bank Acc. Code"; Rec."Cust. Bank Acc. Code")
                {
                    ToolTip = 'Specifies the client''s bank code that was in the header, on the order from which this sales receipt was created.';
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ToolTip = 'Specifies the value of the Customer Disc. Group field.', Comment = '%';
                }
                field("Customer Id"; Rec."Customer Id")
                {
                    ToolTip = 'Specifies the value of the Customer Id field.', Comment = '%';
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ToolTip = 'Specifies the value of the Customer Posting Group field.', Comment = '%';
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ToolTip = 'Specifies the value of the Customer Price Group field.', Comment = '%';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ToolTip = 'Specifies the value of the Dimension Set ID field.', Comment = '%';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the posting date of the document.';
                }
                field("Dpto.ECI"; Rec."Dpto.ECI")
                {
                    ToolTip = 'Specifies the value of the Dpto.ECI field.', Comment = '%';
                }
                field(Dropshipping; Rec.Dropshipping)
                {
                    ToolTip = 'Specifies the value of the Dropshipping field.', Comment = '%';
                }
                field("Dto% cabecera"; Rec."Dto% cabecera")
                {
                    ToolTip = 'Specifies the value of the Dto% cabecera field.', Comment = '%';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the Due Date field.', Comment = '%';
                }
                field("E-MAIL"; Rec."E-MAIL")
                {
                    ToolTip = 'Specifies the value of the E-MAIL field.', Comment = '%';
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ToolTip = 'Specifies the value of the EU 3-Party Trade field.', Comment = '%';
                }
                field("Email enviado"; Rec."Email enviado")
                {
                    ToolTip = 'Specifies the value of the Email enviado field.', Comment = '%';
                }
                field("Email enviado sin detalle"; Rec."Email enviado sin detalle")
                {
                    ToolTip = 'Specifies the value of the Email enviado sin detalle field.', Comment = '%';
                }
                field("Enlace transporte"; Rec."Enlace transporte")
                {
                    ToolTip = 'Specifies the value of the Enlace transporte field.', Comment = '%';
                }
                field("Enlace transporte 2"; Rec."Enlace transporte 2")
                {
                    ToolTip = 'Specifies the value of the Enlace transporte 2 field.', Comment = '%';
                }
                field("Enlace transporte 3"; Rec."Enlace transporte 3")
                {
                    ToolTip = 'Specifies the value of the Enlace transporte 3 field.', Comment = '%';
                }
                field("Enviado fichero"; Rec."Enviado fichero")
                {
                    ToolTip = 'Specifies the value of the Enviado fichero field.', Comment = '%';
                }
                field("Enviado pdf web"; Rec."Enviado pdf web")
                {
                    ToolTip = 'Specifies the value of the Enviado pdf web field.', Comment = '%';
                }
                field("Enviar email"; Rec."Enviar email")
                {
                    ToolTip = 'Specifies the value of the Enviar email field.', Comment = '%';
                }
                field("Enviar email sin detalle"; Rec."Enviar email sin detalle")
                {
                    ToolTip = 'Specifies the value of the Enviar email sin detalle field.', Comment = '%';
                }
                field("Envio a-Nº Telefono"; Rec."Envio a-Nº Telefono")
                {
                    ToolTip = 'Specifies the value of the Envio a-Nº Telefono field.', Comment = '%';
                }
                field("Estado Expedicion"; Rec."Estado Expedicion")
                {
                    ToolTip = 'Specifies the value of the Estado Expedicion field.', Comment = '%';
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
                    ToolTip = 'Specifies the number that the customer uses in their own system to refer to this sales document.';
                }
                field("Fecha activo"; Rec."Fecha activo")
                {
                    ToolTip = 'Specifies the value of the Fecha activo field.', Comment = '%';
                }
                field("Fecha alta"; Rec."Fecha alta")
                {
                    ToolTip = 'Specifies the value of the Fecha alta field.', Comment = '%';
                }
                field("Fecha aviso falta stock"; Rec."Fecha aviso falta stock")
                {
                    ToolTip = 'Specifies the value of the Fecha aviso falta stock field.', Comment = '%';
                }
                field("Fecha entrega"; Rec."Fecha entrega")
                {
                    ToolTip = 'Specifies the value of the Fecha entrega field.', Comment = '%';
                }
                field("Fecha enviado"; Rec."Fecha enviado")
                {
                    ToolTip = 'Specifies the value of the Fecha enviado field.', Comment = '%';
                }
                field("Fecha enviado sin detalle"; Rec."Fecha enviado sin detalle")
                {
                    ToolTip = 'Specifies the value of the Fecha enviado sin detalle field.', Comment = '%';
                }
                field("Fecha envio"; Rec."Fecha envio")
                {
                    ToolTip = 'Specifies the value of the Fecha envio field.', Comment = '%';
                }
                field("Fecha incial de entrega EDICOM"; Rec."Fecha incial de entrega EDICOM")
                {
                    ToolTip = 'Specifies the value of the Fecha incial de entrega EDICOM field.', Comment = '%';
                }
                field("Format Region"; Rec."Format Region")
                {
                    ToolTip = 'Specifies the value of the Format Region field.', Comment = '%';
                }
                field("Funcion del mensaje EDICOM"; Rec."Funcion del mensaje EDICOM")
                {
                    ToolTip = 'Specifies the value of the Funcion del mensaje EDICOM field.', Comment = '%';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.', Comment = '%';
                }
                field("Grupo clientes"; Rec."Grupo clientes")
                {
                    ToolTip = 'Specifies the value of the Grupo clientes field.', Comment = '%';
                }
                field(Historificado; Rec.Historificado)
                {
                    ToolTip = 'Specifies the value of the Historificado field.', Comment = '%';
                }
                field("Hora activo"; Rec."Hora activo")
                {
                    ToolTip = 'Specifies the value of the Hora activo field.', Comment = '%';
                }
                field("Hora alta"; Rec."Hora alta")
                {
                    ToolTip = 'Specifies the value of the Hora alta field.', Comment = '%';
                }
                field("Hora entrega"; Rec."Hora entrega")
                {
                    ToolTip = 'Specifies the value of the Hora entrega field.', Comment = '%';
                }
                field("Hora enviado"; Rec."Hora enviado")
                {
                    ToolTip = 'Specifies the value of the Hora enviado field.', Comment = '%';
                }
                field("Hora enviado sin detalle"; Rec."Hora enviado sin detalle")
                {
                    ToolTip = 'Specifies the value of the Hora enviado sin detalle field.', Comment = '%';
                }
                field("IDENTIF EDICOM"; Rec."IDENTIF EDICOM")
                {
                    ToolTip = 'Specifies the value of the IDENTIF EDICOM field.', Comment = '%';
                }
                field("Id Pedido Presta Shop"; Rec."Id Pedido Presta Shop")
                {
                    ToolTip = 'Specifies the value of the Id Pedido Presta Shop field.', Comment = '%';
                }
                field("Importe a descontar reembolso"; Rec."Importe a descontar reembolso")
                {
                    ToolTip = 'Specifies the value of the Importe a descontar reembolso field.', Comment = '%';
                }
                field("Importe albaran"; Rec."Importe albaran")
                {
                    ToolTip = 'Specifies the value of the Importe albaran field.', Comment = '%';
                }
                field("Importe optimo transporte"; Rec."Importe optimo transporte")
                {
                    ToolTip = 'Specifies the value of the Importe optimo transporte field.', Comment = '%';
                }
                field("Importe seguro envio"; Rec."Importe seguro envio")
                {
                    ToolTip = 'Specifies the value of the Importe seguro envio field.', Comment = '%';
                }
                field("Importe total pedido WEB"; Rec."Importe total pedido WEB")
                {
                    ToolTip = 'Specifies the value of the Importe total pedido WEB field.', Comment = '%';
                }
                field("Importe transporte"; Rec."Importe transporte")
                {
                    ToolTip = 'Specifies the value of the Importe transporte field.', Comment = '%';
                }
                field("Imprime eti. envio"; Rec."Imprime eti. envio")
                {
                    ToolTip = 'Specifies the value of the Imprime eti. envio field.', Comment = '%';
                }
                field("Incrementa bultos"; Rec."Incrementa bultos")
                {
                    ToolTip = 'Specifies the value of the Incrementa bultos field.', Comment = '%';
                }
                field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                {
                    ToolTip = 'Specifies the value of the Invoice Disc. Code field.', Comment = '%';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ToolTip = 'Specifies the value of the Language Code field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                }
                field("Logo cabecera"; Rec."Logo cabecera")
                {
                    ToolTip = 'Specifies the value of the Logo cabecera field.', Comment = '%';
                }
                field("Marcar para listado carga"; Rec."Marcar para listado carga")
                {
                    ToolTip = 'Specifies the value of the Marcar para listado carga field.', Comment = '%';
                }
                field("Multi-picking"; Rec."Multi-picking")
                {
                    ToolTip = 'Specifies the value of the Multi-picking field.', Comment = '%';
                }
                field("No Agrupar en facturas"; Rec."No Agrupar en facturas")
                {
                    ToolTip = 'Specifies the value of the No Agrupar en facturas field.', Comment = '%';
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
                field("No incluir portes"; Rec."No incluir portes")
                {
                    ToolTip = 'Specifies the value of the No incluir portes field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the shipment number.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies how many times the document has been printed.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.', Comment = '%';
                }
                field(Num_lineas; Rec.Num_lineas)
                {
                    ToolTip = 'Specifies the value of the Num_lineas field.', Comment = '%';
                }
                field("Numero segumiento"; Rec."Numero segumiento")
                {
                    ToolTip = 'Specifies the value of the Numero segumiento field.', Comment = '%';
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
                field("Nº lineas"; Rec."Nº lineas")
                {
                    ToolTip = 'Specifies the value of the Nº lineas field.', Comment = '%';
                }
                field("Nº pedido obligatorio"; Rec."Nº pedido obligatorio")
                {
                    ToolTip = 'Specifies the value of the Nº pedido obligatorio field.', Comment = '%';
                }
                field("Observación para transporte"; Rec."Observación para transporte")
                {
                    ToolTip = 'Specifies the value of the Observación para transporte field.', Comment = '%';
                }
                field("Ofertas calculadas"; Rec."Ofertas calculadas")
                {
                    ToolTip = 'Specifies the value of the Ofertas calculadas field.', Comment = '%';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ToolTip = 'Specifies the value of the On Hold field.', Comment = '%';
                }
                field("Opportunity No."; Rec."Opportunity No.")
                {
                    ToolTip = 'Specifies the value of the Opportunity No. field.', Comment = '%';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the value of the Order Date field.', Comment = '%';
                }
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the number of the sales order that this invoice was posted from.';
                }
                field("Order No. Series"; Rec."Order No. Series")
                {
                    ToolTip = 'Specifies the value of the Order No. Series field.', Comment = '%';
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ToolTip = 'Specifies a date formula for the time it takes to get items ready to ship from this location. The time element is used in the calculation of the delivery date as follows: Shipment Date + Outbound Warehouse Handling Time = Planned Shipment Date + Shipping Time = Planned Delivery Date.';
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ToolTip = 'Specifies the shipping agent''s package number.';
                }
                field("Pasada a Canarias"; Rec."Pasada a Canarias")
                {
                    ToolTip = 'Specifies the value of the Pasada a Canarias field.', Comment = '%';
                }
                field("Pasar a Canarias"; Rec."Pasar a Canarias")
                {
                    ToolTip = 'Specifies the value of the Pasar a Canarias field.', Comment = '%';
                }
                /*field("Pay-at Code"; Rec."Pay-at Code")
                {
                    ToolTip = 'Specifies the client''s payment address code that was on the order header, Payments tab, from which this sales receipt was created.';
                }*/
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the value of the Payment Discount % field.', Comment = '%';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.', Comment = '%';
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
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ToolTip = 'Specifies the value of the Posting Description field.', Comment = '%';
                }
                field(Preparador; Rec.Preparador)
                {
                    ToolTip = 'Specifies the value of the Preparador field.', Comment = '%';
                }
                field("Price Calculation Method"; Rec."Price Calculation Method")
                {
                    ToolTip = 'Specifies the value of the Price Calculation Method field.', Comment = '%';
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ToolTip = 'Specifies the value of the Prices Including VAT field.', Comment = '%';
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ToolTip = 'Specifies the date that you have promised to deliver the order, as a result of the Order Promising function.';
                }
                field("Provincia shopyfi"; Rec."Provincia shopyfi")
                {
                    ToolTip = 'Specifies the value of the Provincia shopyfi field.', Comment = '%';
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ToolTip = 'Specifies the number of the sales quote document if a quote was used to start the sales process.';
                }
                field("REFTRANS EDICOM"; Rec."REFTRANS EDICOM")
                {
                    ToolTip = 'Specifies the value of the REFTRANS EDICOM field.', Comment = '%';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Specifies the value of the Reason Code field.', Comment = '%';
                }
                field(Reembolso; Rec.Reembolso)
                {
                    ToolTip = 'Specifies the value of the Reembolso field.', Comment = '%';
                }
                field("Referencia Pedido Presta Shop"; Rec."Referencia Pedido Presta Shop")
                {
                    ToolTip = 'Specifies the value of the Referencia Pedido Presta Shop field.', Comment = '%';
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ToolTip = 'Specifies the date that the customer has asked for the order to be delivered.';
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
                    ToolTip = 'Specifies the code for the responsibility center that serves the customer on this sales document.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies a code for the salesperson who normally handles this customer''s account.';
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ToolTip = 'Specifies the customer''s sell-to address.';
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ToolTip = 'Specifies the customer''s extended sell-to address.';
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ToolTip = 'Specifies the city of the customer on the sales document.';
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ToolTip = 'Specifies the name of the person to contact at the customer that the items were sold to.';
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ToolTip = 'Specifies the contact number.';
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                }
                field("Sell-to County"; Rec."Sell-to County")
                {
                    ToolTip = 'Specifies the state, province or county as a part of the address.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the name of the customer that you shipped the items in the shipment to.';
                }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer Name 2 field.', Comment = '%';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer the items were shipped to.';
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
                    ToolTip = 'Specifies the postal code of the address.';
                }
                field("Servir sabado"; Rec."Servir sabado")
                {
                    ToolTip = 'Specifies the value of the Servir sabado field.', Comment = '%';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the address that you delivered the items to.';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies the extended address that you delivered the items to.';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the city of the customer on the sales document.';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the code for the customer''s additional shipment address.';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact at the address that the items were shipped to.';
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the customer''s country/region.';
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ToolTip = 'Specifies the state, province or county as a part of the address.';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that you shipped the items in the shipment to.';
                }
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Ship-to Name 2 field.', Comment = '%';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the customer''s ship-to address.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the shipment method for the shipment.';
                }
                field("Shipping Agent Code"; NombreCarrier)
                {
                    ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ToolTip = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.';
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
                field("Source Code"; Rec."Source Code")
                {
                    ToolTip = 'Specifies the value of the Source Code field.', Comment = '%';
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
                    ToolTip = 'Specifies the value of the Tax Area Code field.', Comment = '%';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ToolTip = 'Specifies the value of the Tax Liable field.', Comment = '%';
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
                field("Total horas"; Rec."Total horas")
                {
                    ToolTip = 'Specifies the value of the Total horas field.', Comment = '%';
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
                    ToolTip = 'Specifies the value of the VAT Registration No. field.', Comment = '%';
                }
                field(Volumen; Rec.Volumen)
                {
                    ToolTip = 'Specifies the value of the Volumen field.', Comment = '%';
                }
                field("Work Description"; Rec."Work Description")
                {
                    ToolTip = 'Specifies the value of the Work Description field.', Comment = '%';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ToolTip = 'Specifies the value of the Your Reference field.', Comment = '%';
                }
                field("nuloAlbaran sin detalle"; Rec."nuloAlbaran sin detalle")
                {
                    ToolTip = 'Specifies the value of the nuloAlbaran sin detalle field.', Comment = '%';
                }
                field("nuloAlbaran valorado"; Rec."nuloAlbaran valorado")
                {
                    ToolTip = 'Specifies the value of the nuloAlbaran valorado field.', Comment = '%';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        if ShippingAgent.Get(rec."Shipping Agent Code") then begin
            if ShippingAgent.NombreCarrier <> '' then begin
                NombreCarrier := ShippingAgent.NombreCarrier;
            end else begin
                NombreCarrier := '';
            end;
        end;
    end;

    var
        NombreCarrier: Text;
}
