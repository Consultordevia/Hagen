pageextension 50007 "Sales Quote" extends "Sales Quote"
{

    layout
    {


        addafter("Sell-to Customer Name")
        {


            field("Posting No.";Rec."Posting No.") { ApplicationArea = All; }

            field("Customer Disc. Group"; Rec."Customer Disc. Group") { ApplicationArea = All; }

            field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2") { ApplicationArea = All; }
            field("Observación para ALMACEN"; Rec."Observación para ALMACEN") { ApplicationArea = All; }
            field("Observación PDA"; Rec."Observación PDA") { ApplicationArea = All; }
            field("Observación para transporte"; Rec."Observación para transporte") { ApplicationArea = All; }
            field("Nº expedición"; Rec."Nº expedición") { ApplicationArea = All; }
            field("No agrupar en ADAIA"; Rec."No agrupar en ADAIA") { ApplicationArea = All; }
            field("Permite fraccionar uni. venta"; Rec."Permite fraccionar uni. venta") { ApplicationArea = All; }
            field("No incluir portes"; Rec."No incluir portes") { ApplicationArea = All; }
            field("Incrementa bultos"; Rec."Incrementa bultos") { ApplicationArea = All; }
            field("Estado pedido"; Rec."Estado pedido") { ApplicationArea = All; }
            field(Urgente; Rec.Urgente) { ApplicationArea = All; }
            field("Super urgente"; Rec."Super urgente") { ApplicationArea = All; }
        }

        /////addlast(content)
        /////{
        /////group(Hagen)
        /////{


        /////field("Usuario alta"; Rec."Usuario alta") { ApplicationArea = All; }
        /////field("Fecha alta"; Rec."Fecha alta") { ApplicationArea = All; }
        /////field("Hora alta"; Rec."Hora alta") { ApplicationArea = All; }
        /////field("Base Pdte."; Rec."Base Pdte.") { ApplicationArea = All; }
        /////field("Base"; Rec."Base") { ApplicationArea = All; }
        /////field("Preparador"; Rec."Preparador") { ApplicationArea = All; }
        /////field("Nº bultos"; Rec."Nº bultos") { ApplicationArea = All; }
        /////field("Nº Palets"; Rec."Nº Palets") { ApplicationArea = All; }
        /////field("Total bultos"; Rec."Total bultos") { ApplicationArea = All; }
        /////field("Anula restos"; Rec."Anula restos") { ApplicationArea = All; }
        /////field("Usuario para preparar"; Rec."Usuario para preparar") { ApplicationArea = All; }
        /////field("Fecha para preparar"; Rec."Fecha para preparar") { ApplicationArea = All; }
        /////field("Hora para preparar"; Rec."Hora para preparar") { ApplicationArea = All; }
        /////field("Nombre comercial"; Rec."Nombre comercial") { ApplicationArea = All; }
        /////field("Televendedor"; Rec."Televendedor") { ApplicationArea = All; }
        /////field("No imprimir albaran valorado"; Rec."No imprimir albaran valorado") { ApplicationArea = All; }
        /////field("Total peso"; Rec."Total peso") { ApplicationArea = All; }
        /////field("Cdad. Pdte. Servir"; Rec."Cdad. Pdte. Servir") { ApplicationArea = All; }
        /////field("Usuario Retenido"; Rec."Usuario Retenido") { ApplicationArea = All; }
        /////field("Fecha Retenido"; Rec."Fecha Retenido") { ApplicationArea = All; }
        /////field("Hora Retenido"; Rec."Hora Retenido") { ApplicationArea = All; }
        /////field("Ampliacion del pedido nº"; Rec."Ampliacion del pedido nº") { ApplicationArea = All; }
        /////field("Recibido de adaia"; Rec."Recibido de adaia") { ApplicationArea = All; }
        /////field("No Enviar factura en exp."; Rec."No Enviar factura en exp.") { ApplicationArea = All; }
        /////field("No Enviar albaran en exp."; Rec."No Enviar albaran en exp.") { ApplicationArea = All; }
        /////field("Importe a descontar reembolso"; Rec."Importe a descontar reembolso") { ApplicationArea = All; }
        /////field("Albaran sin detalle"; Rec."Albaran sin detalle") { ApplicationArea = All; }
        /////field("Pedido WEB"; Rec."Pedido WEB") { ApplicationArea = All; }
        /////field("Respeta agencia transporte"; Rec."Respeta agencia transporte") { ApplicationArea = All; }
        /////field("Envio a-Nº Telefono"; Rec."Envio a-Nº Telefono") { ApplicationArea = All; }
        /////field("Estado presupuesto"; Rec."Estado presupuesto") { ApplicationArea = All; }
        /////field("Tipo facturación"; Rec."Tipo facturación") { ApplicationArea = All; }
        /////field("Respeta Tipo facturacion"; Rec."Respeta Tipo facturacion") { ApplicationArea = All; }
        /////field("Nº exped. pequeña"; Rec."Nº exped. pequeña") { ApplicationArea = All; }
        /////field("Docu. requerida prov. sacada"; Rec."Docu. requerida prov. sacada") { ApplicationArea = All; }
        /////field("Check contrareemolso verificad"; Rec."Check contrareemolso verificad") { ApplicationArea = All; }
        /////field("ASN"; Rec."ASN") { ApplicationArea = All; }
        /////field("No imprimir facturas"; Rec."No imprimir facturas") { ApplicationArea = All; }
        /////field("Provincia shopyfi"; Rec."Provincia shopyfi") { ApplicationArea = All; }
        /////field("SupraOferta"; Rec."SupraOferta") { ApplicationArea = All; }
        /////field("Comunidad"; Rec."Comunidad") { ApplicationArea = All; }
        /////field("Codigo cliente externo"; Rec."Codigo cliente externo") { ApplicationArea = All; }
        /////field("Fecha incial de entrega EDICOM"; Rec."Fecha incial de entrega EDICOM") { ApplicationArea = All; }
        /////field("REFTRANS EDICOM"; Rec."REFTRANS EDICOM") { ApplicationArea = All; }
        /////field("Tipo de documento EDICOM"; Rec."Tipo de documento EDICOM") { ApplicationArea = All; }
        /////field("Funcion del mensaje EDICOM"; Rec."Funcion del mensaje EDICOM") { ApplicationArea = All; }
        /////field("Tipo transporte EDICOM"; Rec."Tipo transporte EDICOM") { ApplicationArea = All; }
        /////field("IDENTIF EDICOM"; Rec."IDENTIF EDICOM") { ApplicationArea = All; }
        /////field("Nº Nota Debito"; Rec."Nº Nota Debito") { ApplicationArea = All; }
        /////field("Enviado email preparación"; Rec."Enviado email preparación") { ApplicationArea = All; }
        /////field("Importe a cuenta"; Rec."Importe a cuenta") { ApplicationArea = All; }
        /////field("Puede retocar"; Rec."Puede retocar") { ApplicationArea = All; }
        /////field("Filtro ECI"; Rec."Filtro ECI") { ApplicationArea = All; }
        /////field("Marcar para agrupar"; Rec."Marcar para agrupar") { ApplicationArea = All; }
        /////field("Fecha envio pendiente stock"; Rec."Fecha envio pendiente stock") { ApplicationArea = All; }
        /////field("Reembolso"; Rec."Reembolso") { ApplicationArea = All; }
        /////field("Importe optimo transporte"; Rec."Importe optimo transporte") { ApplicationArea = All; }
        /////field("Cobra portes entre empresas"; Rec."Cobra portes entre empresas") { ApplicationArea = All; }
        /////field("Dropshipping"; Rec."Dropshipping") { ApplicationArea = All; }
        /////field("Nº expedición agrupada"; Rec."Nº expedición agrupada") { ApplicationArea = All; }
        /////field("Frecuencia visita comercial"; Rec."Frecuencia visita comercial") { ApplicationArea = All; }
        /////field("E-MAIL"; Rec."E-MAIL") { ApplicationArea = All; }
        /////field("Recibido y facturado"; Rec."Recibido y facturado") { ApplicationArea = All; }
        /////field("Transferencia web"; Rec."Transferencia web") { ApplicationArea = All; }
        /////field("Pago Aceptado"; Rec."Pago Aceptado") { ApplicationArea = All; }
        /////field("Importe total pedido WEB"; Rec."Importe total pedido WEB") { ApplicationArea = All; }
        /////field("Nº expedición dropshp"; Rec."Nº expedición dropshp") { ApplicationArea = All; }
        /////field("NO MULTIPEDIDO"; Rec."NO MULTIPEDIDO") { ApplicationArea = All; }
        /////field("No agrupar en CANARIAS"; Rec."No agrupar en CANARIAS") { ApplicationArea = All; }
        /////field("EDI factueas enviar"; Rec."EDI factueas enviar") { ApplicationArea = All; }
        /////field("Grupo clientes"; Rec."Grupo clientes") { ApplicationArea = All; }
        /////field("Multi-picking"; Rec."Multi-picking") { ApplicationArea = All; }
        /////field("Dpto.ECI"; Rec."Dpto.ECI") { ApplicationArea = All; }
        /////field("Id Pedido Presta Shop"; Rec."Id Pedido Presta Shop") { ApplicationArea = All; }
        /////field("Referencia Pedido Presta Shop"; Rec."Referencia Pedido Presta Shop") { ApplicationArea = All; }
        /////field("Importe Descuento Presta Shop"; Rec."Importe Descuento Presta Shop") { ApplicationArea = All; }
        /////field("Notificar Pago"; Rec."Notificar Pago") { ApplicationArea = All; }
        /////field("Notificar Envio"; Rec."Notificar Envio") { ApplicationArea = All; }
        /////field("Nº Factura Notificar Envio"; Rec."Nº Factura Notificar Envio") { ApplicationArea = All; }
        /////field("Texto Descuento Presta Shop"; Rec."Texto Descuento Presta Shop") { ApplicationArea = All; }
        /////field("Nº Albaran Notificar Envio"; Rec."Nº Albaran Notificar Envio") { ApplicationArea = All; }
        /////field("Factura EDI"; Rec."Factura EDI") { ApplicationArea = All; }
        /////field("Albarán EDI"; Rec."Albarán EDI") { ApplicationArea = All; }                 

        ///// }
        /////}        

    }

    actions
    {
        addlast("&Quote")
        {
            action(CopiaraPEDIDO)
            {
                ApplicationArea = All;
                Caption = 'Copiar a PEDIDO';
                Image = Order;


                trigger OnAction()
                var
                    SalesHeader3: Record "Sales Header";
                    SEPASA: Boolean;
                    UserSetup: Record "User Setup";
                    CODACTI: Code[20];
                    Rec362: Record "Sales Header";
                    Rec372: Record "Sales Line";
                    Rec37: Record "Sales Line";
                    RecMT2: Record "Multitabla 2";
                    RecProd: Record Item;
                    Rec367: Record "Sales Header";
                    DESDEA: Date;
                    RecGP: Record "Gen. Product Posting Group";
                    DTOOPTIMO: Decimal;
                    DTOOPTIMO3: Decimal;
                    RecCfC: Record "General Ledger Setup";
                    falta: Boolean;
                    RecCVP: Record "Sales & Receivables Setup";
                    RecClie: Record Customer;
                    fecha2: Date;
                    RecLC1: Record "Sales Comment Line";
                    RecLC2: Record "Sales Comment Line";
                    RecSDLM: Record "Item Journal Batch";
                    Rec89: Record "Item Journal Line";
                    FormPedido: Page "Sales Order";
                    RecCV: Record "Sales Header";
                    Cust: Record Customer;
                    Rec21: Record "Cust. Ledger Entry";
                    Fechavto: Date;
                    SalesLine: Record "Sales Line";
                    ImporteTarifa: Decimal;
                    ImporteAServir: Decimal;
                    Item2: Record Item;
                    Conseguido: Text;
                    Multitabla2: Record "Multitabla 2";
                    CustomerDiscountGroup: Record "Customer Discount Group";
                    Importenuevodto: Decimal;
                    ImportacionPEDIDOSOTROS2: XMLport "Importacion PEDIDOS OTROS2";
                    ReleaseSalesDoc: Codeunit "Release Sales Document";
                    Customer: Record Customer;
                    dtoconse: Decimal;
                    CustInvoiceDisc: Record "Cust. Invoice Disc.";
                    pasa: Boolean;
                    lin: Integer;
                    SalesLineO: Record "Sales Line";
                    SalesLineDiscount: Record "Sales Line Discount";
                    RecLV: Record "Sales Line";
                    SalesReceivablesSetup: Record "Sales & Receivables Setup";
                    NoSeriesManagement: Codeunit NoSeriesManagement;
                    ImportacionPEDIDOSMASKOcome: XMLport "Importacion PEDIDOS MASKO-come";
                begin


                    SalesReceivablesSetup.GET;

                    RecCV.GET(Rec."Document Type", Rec."No.");


                    Customer.GET(Rec."Sell-to Customer No.");
                    IF Customer."Permite seguir adelante" = FALSE THEN BEGIN
                        Customer.CALCFIELDS("Importe impagado");
                        IF Customer."Importe impagado" <> 0 THEN BEGIN
                            MESSAGE('Este cliente tiene impagos.');
                        END;
                        COMMIT;
                        IF DTOOPTIMO3 - RecCfC."Margen necesario" < 0 THEN BEGIN
                            /////     MESSAGE('Este presupuesto supera el maximo permitido.');
                        END;
                        SalesHeader3.GET(Rec."Document Type", Rec."No.");
                        /////-ChequeoFechaVtosOferta;
                        IF SEPASA THEN BEGIN
                            ERROR('El cliente esta bloqueado por exceso falta de pago.');
                        END;
                    END;

                    /////UserSetup.GET(USERID);
                    CODACTI := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Order Nos.", TODAY, TRUE);


                    Rec362.INIT;
                    Rec362 := Rec;
                    Rec362."No." := CODACTI;
                    Rec362."Document Type" := 1;
                    Rec362."Estado pedido" := 2;
                    Rec362."Nº expedición" := '';
                    Rec362.INSERT(TRUE);
                    ////CODACTI:=Rec362."No.";
                    Rec362."Shipping No. Series" := Rec."Shipping No. Series";
                    Rec362."Location Code" := Rec."Location Code";
                    Rec362.MODIFY;


                    falta := FALSE;

                    IF Rec."Fecha envio pendiente stock" = 0D THEN BEGIN
                        Rec372.RESET;
                        Rec372.SETRANGE(Rec372."Document Type", Rec."Document Type");
                        Rec372.SETRANGE(Rec372."Document No.", Rec."No.");
                        IF Rec372.FINDFIRST THEN
                            REPEAT
                                ///IF Rec372."Estado linea"<>2 THEN BEGIN
                                IF RecProd.GET(Rec372."No.") THEN BEGIN
                                    pasa := TRUE;
                                    IF RecProd."Prohibido Amazon" THEN BEGIN
                                        Rec372.CALCFIELDS("Grupo clientes");
                                        IF Rec372."Grupo clientes" = 'G10' THEN BEGIN
                                            pasa := FALSE;
                                        END;
                                    END;
                                    IF pasa THEN BEGIN

                                        IF (NOT RecProd."No permite pedido") AND (NOT RecProd."Producto con reserva") THEN BEGIN
                                            Rec37.INIT;
                                            Rec37 := Rec372;
                                            Rec37."Document Type" := 1;
                                            Rec37."Document No." := CODACTI;
                                            IF Rec372."Cantidad a pasar pedido" <> 0 THEN BEGIN
                                                Rec37.VALIDATE(Rec37.Quantity, Rec372."Cantidad a pasar pedido");
                                            END;
                                            Rec37."Nº expedición" := '';
                                            Rec37.INSERT;
                                            IF Rec372."Cantidad a pasar pedido" = 0 THEN BEGIN
                                                Rec372.DELETE;
                                            END;
                                            IF Rec372."Cantidad a pasar pedido" <> 0 THEN BEGIN
                                                Rec372.VALIDATE(Rec372.Quantity, Rec372.Quantity - Rec372."Cantidad a pasar pedido");
                                                Rec372."Cantidad a pasar pedido" := 0;
                                                Rec372.MODIFY;
                                            END;
                                        END;
                                        IF (NOT RecProd."No permite pedido") AND (RecProd."Producto con reserva") THEN BEGIN
                                            RecClie.GET(Rec."Sell-to Customer No.");
                                            IF RecClie."No." <> '4703' THEN BEGIN
                                                RecMT2.RESET;
                                                RecMT2.SETRANGE(RecMT2.Tabla, 1);
                                                RecMT2.SETRANGE(RecMT2."Codigo 1", Rec372."No.");
                                                RecMT2.SETRANGE(RecMT2."Codigo 2", RecClie."Grupo clientes");
                                                IF RecMT2.FINDFIRST THEN BEGIN
                                                    Rec37.INIT;
                                                    Rec37 := Rec372;
                                                    Rec37."Document Type" := 1;
                                                    Rec37."Document No." := CODACTI;
                                                    IF Rec372."Cantidad a pasar pedido" <> 0 THEN BEGIN
                                                        Rec37.VALIDATE(Rec37.Quantity, Rec372."Cantidad a pasar pedido");
                                                    END;
                                                    Rec37.INSERT;
                                                    IF Rec372."Cantidad a pasar pedido" = 0 THEN BEGIN
                                                        Rec372.DELETE;
                                                    END;
                                                    IF Rec372."Cantidad a pasar pedido" <> 0 THEN BEGIN
                                                        Rec372.VALIDATE(Rec372.Quantity, Rec372.Quantity - Rec372."Cantidad a pasar pedido");
                                                        Rec372."Cantidad a pasar pedido" := 0;
                                                        Rec372.MODIFY;
                                                    END;
                                                END;
                                            END;
                                            IF RecClie."No." = '4703' THEN BEGIN
                                                Rec37.INIT;
                                                Rec37 := Rec372;
                                                Rec37."Document Type" := 1;
                                                Rec37."Document No." := CODACTI;
                                                IF Rec372."Cantidad a pasar pedido" <> 0 THEN BEGIN
                                                    Rec37.VALIDATE(Rec37.Quantity, Rec372."Cantidad a pasar pedido");
                                                END;
                                                Rec37."Nº expedición" := '';
                                                Rec37.INSERT;
                                                IF Rec372."Cantidad a pasar pedido" = 0 THEN BEGIN
                                                    Rec372.DELETE;
                                                END;
                                                IF Rec372."Cantidad a pasar pedido" <> 0 THEN BEGIN
                                                    Rec372.VALIDATE(Rec372.Quantity, Rec372.Quantity - Rec372."Cantidad a pasar pedido");
                                                    Rec372."Cantidad a pasar pedido" := 0;
                                                    Rec372.MODIFY;
                                                END;
                                            END;

                                        END;
                                        IF RecProd."No permite pedido" THEN BEGIN
                                            falta := TRUE;
                                        END;
                                        IF RecProd."Producto con reserva" THEN BEGIN
                                            falta := TRUE;
                                        END;
                                    END;
                                END;
                            UNTIL Rec372.NEXT = 0;
                    END;

                    IF Rec."Fecha envio pendiente stock" <> 0D THEN BEGIN
                        Rec372.RESET;
                        Rec372.SETRANGE(Rec372."Document Type", Rec."Document Type");
                        Rec372.SETRANGE(Rec372."Document No.", Rec."No.");
                        IF Rec372.FINDFIRST THEN
                            REPEAT
                                //IF Rec372."Estado linea"<>2 THEN BEGIN
                                IF RecProd.GET(Rec372."No.") THEN BEGIN
                                    pasa := TRUE;
                                    IF RecProd."Prohibido Amazon" THEN BEGIN
                                        Rec372.CALCFIELDS("Grupo clientes");
                                        IF Rec372."Grupo clientes" = 'G10' THEN BEGIN
                                            pasa := FALSE;
                                        END;
                                    END;

                                    IF pasa THEN BEGIN
                                        fecha2 := 0D;
                                        RecProd.CALCFIELDS(RecProd."Fecha proxima recepción conten");
                                        fecha2 := RecProd."Fecha proxima recepción conten";
                                        IF fecha2 = 0D THEN BEGIN
                                            fecha2 := 20151231D;
                                        END;
                                        IF NOT RecProd."No permite pedido" THEN BEGIN
                                            fecha2 := 0D;
                                        END;


                                        IF (Rec."Fecha envio pendiente stock" > fecha2) AND (NOT RecProd."Producto con reserva") THEN BEGIN
                                            Rec37.INIT;
                                            Rec37 := Rec372;
                                            Rec37."Document Type" := 1;
                                            Rec37."Document No." := CODACTI;
                                            IF Rec372."Cantidad a pasar pedido" <> 0 THEN BEGIN
                                                Rec37.VALIDATE(Rec37.Quantity, Rec372."Cantidad a pasar pedido");
                                            END;
                                            Rec37."Nº expedición" := '';
                                            Rec37.INSERT;
                                            IF Rec372."Cantidad a pasar pedido" = 0 THEN BEGIN
                                                Rec372.DELETE;
                                            END;
                                            IF Rec372."Cantidad a pasar pedido" <> 0 THEN BEGIN
                                                Rec372.VALIDATE(Rec372.Quantity, Rec372.Quantity - Rec372."Cantidad a pasar pedido");
                                                Rec372."Cantidad a pasar pedido" := 0;
                                                Rec372.MODIFY;
                                            END;
                                        END;
                                        IF (Rec."Fecha envio pendiente stock" > fecha2) AND (RecProd."Producto con reserva") THEN BEGIN
                                            RecClie.GET(Rec."Sell-to Customer No.");
                                            RecMT2.RESET;
                                            RecMT2.SETRANGE(RecMT2.Tabla, 1);
                                            RecMT2.SETRANGE(RecMT2."Codigo 1", Rec372."No.");
                                            RecMT2.SETRANGE(RecMT2."Codigo 2", RecClie."Grupo clientes");
                                            IF RecMT2.FINDFIRST THEN BEGIN
                                                Rec37.INIT;
                                                Rec37 := Rec372;
                                                Rec37."Document Type" := 1;
                                                Rec37."Document No." := CODACTI;
                                                IF Rec372."Cantidad a pasar pedido" <> 0 THEN BEGIN
                                                    Rec37.VALIDATE(Rec37.Quantity, Rec372."Cantidad a pasar pedido");
                                                END;
                                                Rec37."Nº expedición" := '';
                                                Rec37.INSERT;
                                                IF Rec372."Cantidad a pasar pedido" = 0 THEN BEGIN
                                                    Rec372.DELETE;
                                                END;
                                                IF Rec372."Cantidad a pasar pedido" <> 0 THEN BEGIN
                                                    Rec372.VALIDATE(Rec372.Quantity, Rec372.Quantity - Rec372."Cantidad a pasar pedido");
                                                    Rec372."Cantidad a pasar pedido" := 0;
                                                    Rec372.MODIFY;
                                                END;
                                            END;
                                        END;

                                        IF RecProd."No permite pedido" THEN BEGIN
                                            falta := TRUE;
                                        END;
                                        IF RecProd."Producto con reserva" THEN BEGIN
                                            falta := TRUE;
                                        END;
                                    END;
                                END;
                            UNTIL Rec372.NEXT = 0;
                    END;

                    Rec372.RESET;
                    Rec372.SETRANGE(Rec372."Document Type", Rec."Document Type");
                    Rec372.SETRANGE(Rec372."Document No.", Rec."No.");
                    IF Rec372.FINDFIRST THEN BEGIN
                        Rec."Estado presupuesto" := 1;
                        Rec.MODIFY;
                    END;
                    Rec372.RESET;
                    Rec372.SETRANGE(Rec372."Document Type", Rec."Document Type");
                    Rec372.SETRANGE(Rec372."Document No.", Rec."No.");
                    IF NOT Rec372.FINDFIRST THEN BEGIN
                        Rec."Estado presupuesto" := 2;
                        Rec.MODIFY;
                    END;
                    RecLC1.RESET;
                    RecLC1.SETRANGE(RecLC1."Document Type", Rec."Document Type");
                    RecLC1.SETRANGE(RecLC1."No.", Rec."No.");
                    IF RecLC1.FINDFIRST THEN
                        REPEAT
                            IF NOT RecLC2.GET(1, Rec362."No.", RecLC1."Line No.") THEN BEGIN
                                RecLC2 := RecLC1;
                                RecLC2."Document Type" := 1;
                                RecLC2."No." := Rec362."No.";
                                RecLC2.INSERT;
                            END;

                        UNTIL RecLC1.NEXT = 0;

                    RecSDLM.RESET;
                    RecSDLM.SETRANGE(RecSDLM."Journal Template Name", 'PRODUCTO');
                    RecSDLM.SETRANGE(RecSDLM.Name, Rec362."No.");
                    IF NOT RecSDLM.FINDFIRST THEN BEGIN
                        RecSDLM.INIT;
                        RecSDLM."Journal Template Name" := 'PRODUCTO';
                        RecSDLM.Name := Rec362."No.";
                        RecSDLM.INSERT;
                        Rec89.INIT;
                        Rec89."Journal Template Name" := 'PRODUCTO';
                        Rec89."Journal Batch Name" := Rec362."No.";
                        Rec89."Line No." := 10000;
                        Rec89.INSERT;
                    END;


                    Rec367.GET(1, CODACTI);
                    Rec367.CALCFIELDS(Rec367.Base);
                    Rec367."Importe total pedido WEB" := Rec367.Base;
                    Rec367.MODIFY;
                    COMMIT;

                    CLEAR(FormPedido);
                    RecCV.SETRANGE(RecCV."Document Type", 1);
                    RecCV.SETRANGE(RecCV."No.", Rec362."No.");
                    IF RecCV.FINDFIRST THEN BEGIN
                        FormPedido.SETTABLEVIEW(RecCV);
                        FormPedido.RUNMODAL;
                    END;

                END;

            }
            action(Importardropshiping)
            {
                ApplicationArea = All;
                Caption = 'Importar dropshiping';
                Image = Order;


                trigger OnAction()
                var
                    Importardropshiping: XmlPort "Importacion PEDIDOS MASKO-come";


                begin
                    clear(Importardropshiping);
                    Importardropshiping.run;

                end;
            }
            action(Importalineas)
            {
                ApplicationArea = All;
                Caption = 'Importar lineas';
                Image = Order;


                trigger OnAction()
                var
                    ImportacionPEDIDOSOTROS3: XmlPort "Importacion PEDIDOS OTROS3";


                begin

                    CLEAR(ImportacionPEDIDOSOTROS3);
                    ImportacionPEDIDOSOTROS3.PasoClie(Rec."No.");
                    ImportacionPEDIDOSOTROS3.RUN;



                end;
            }

            action(QuitarSupraOferta)
            {
                ApplicationArea = Suite;
                Caption = 'Quitar Supra Oferta';
                trigger OnAction()
                var
                    RecClie: Record Customer;
                    SalesLine: Record "Sales Line";
                    Item2: Record Item;

                begin

                    RecClie.GET(Rec."Sell-to Customer No.");
                    Rec."Customer Disc. Group" := RecClie."Customer Disc. Group";
                    Rec.MODIFY;

                    SalesLine.RESET;
                    SalesLine.SETRANGE(SalesLine."Document Type", Rec."Document Type");
                    SalesLine.SETRANGE("Document No.", Rec."No.");
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            IF Item2.GET(SalesLine."No.") THEN BEGIN
                                IF (Item2."No permite pedido" = FALSE) AND (Item2."Producto con reserva" = FALSE) THEN BEGIN
                                    IF SalesLine."Producto asociado" = 0 THEN BEGIN
                                        SalesLine.VALIDATE("Customer Disc. Group", Rec."Customer Disc. Group");
                                        SalesLine.MODIFY;
                                    END;
                                END;
                            END;
                        UNTIL SalesLine.NEXT = 0;



                    MESSAGE('Hecho.');

                end;
            }

            action(PonerSupraOferta)
            {
                ApplicationArea = Suite;
                Caption = 'Poner Supra Oferta';
                trigger OnAction()
                var
                    RecClie: Record Customer;
                    SalesLine: Record "Sales Line";
                    Item2: Record Item;
                    ImporteTarifa: Decimal;
                    ImporteAServir: Decimal;
                    dtoconse: Decimal;
                    CustInvoiceDisc: Record "Cust. Invoice Disc.";
                    Conseguido: text[100];
                    Multitabla2: Record "Multitabla 2";
                    CustomerDiscountGroup: Record "Customer Discount Group";
                    Importenuevodto: Decimal;


                begin


                    ImporteTarifa := 0;
                    ImporteAServir := 0;
                    SalesLine.RESET;
                    SalesLine.SETRANGE(SalesLine."Document Type", Rec."Document Type");
                    SalesLine.SETRANGE("Document No.", Rec."No.");
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            IF Item2.GET(SalesLine."No.") THEN BEGIN
                                IF (Item2."No permite pedido" = FALSE) AND (Item2."Producto con reserva" = FALSE) THEN BEGIN
                                    ImporteAServir := ImporteAServir + SalesLine.Amount;
                                END;
                            END;
                        UNTIL SalesLine.NEXT = 0;

                    dtoconse := 0;
                    CustInvoiceDisc.RESET;
                    CustInvoiceDisc.SETRANGE(CustInvoiceDisc.Code, 'SUPRAOFERTA');
                    IF CustInvoiceDisc.FINDSET THEN
                        REPEAT
                            IF ImporteAServir > CustInvoiceDisc."Minimum Amount" THEN BEGIN
                                dtoconse := CustInvoiceDisc."Discount %";
                            END;
                        UNTIL CustInvoiceDisc.NEXT = 0;

                    SalesLine.RESET;
                    SalesLine.SETRANGE(SalesLine."Document Type", Rec."Document Type");
                    SalesLine.SETRANGE("Document No.", Rec."No.");
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            IF Item2.GET(SalesLine."No.") THEN BEGIN
                                IF (Item2."No permite pedido" = FALSE) AND (Item2."Producto con reserva" = FALSE) THEN BEGIN
                                    IF SalesLine."Producto asociado" = 0 THEN BEGIN
                                        SalesLine.VALIDATE(SalesLine."Line Discount %", 0);
                                        SalesLine.VALIDATE("Customer Disc. Group", '');
                                        SalesLine.VALIDATE(SalesLine."Line Discount %", dtoconse);
                                        SalesLine.MODIFY;
                                    END;
                                END;
                            END;
                        UNTIL SalesLine.NEXT = 0;




                    ImporteTarifa := 0;
                    ImporteAServir := 0;
                    SalesLine.RESET;
                    SalesLine.SETRANGE(SalesLine."Document Type", Rec."Document Type");
                    SalesLine.SETRANGE("Document No.", Rec."No.");
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            IF Item2.GET(SalesLine."No.") THEN BEGIN
                                IF (Item2."No permite pedido" = FALSE) AND (Item2."Producto con reserva" = FALSE) THEN BEGIN
                                    ImporteAServir := ImporteAServir + SalesLine.Amount;
                                    ImporteTarifa := ImporteTarifa + (SalesLine.Quantity * SalesLine."Unit Price");
                                END;
                            END;
                        UNTIL SalesLine.NEXT = 0;

                    Conseguido := '';
                    Multitabla2.RESET;
                    Multitabla2.SETRANGE(Multitabla2.Tabla, 15);
                    Multitabla2.SETRANGE(Multitabla2."Codigo 1", Rec."Sell-to Customer No.");
                    Multitabla2.SETRANGE(Multitabla2."Importe minimo para descuento", 0, ImporteTarifa);
                    IF Multitabla2.FINDLAST THEN BEGIN
                        CustomerDiscountGroup.RESET;
                        IF CustomerDiscountGroup.GET(Multitabla2."Codigo 2") THEN BEGIN
                            Conseguido := Multitabla2."Codigo 2" + ' ' + CustomerDiscountGroup.Description + ' supera: ' + FORMAT(Multitabla2."Importe minimo para descuento");
                            Importenuevodto := ImporteTarifa - ROUND(ImporteTarifa * Multitabla2."Descuento a aplicar" / 100, 0.01);
                        END;

                    END;


                    Rec."Customer Disc. Group" := Multitabla2."Codigo 2";
                    Rec.MODIFY;

                    MESSAGE('Hecho.');

                end;
            }
            action(ImportacionPEDIDOSAMAZON2)
            {
                ApplicationArea = Suite;
                Caption = 'Importacion OFERTAS AMAZON2';
                trigger OnAction()
                var
                    xmlImportacionPEDIDOSAMAZON2: Xmlport "Importacion PEDIDOS AMAZON2";
                begin
                    Clear(xmlImportacionPEDIDOSAMAZON2);
                    xmlImportacionPEDIDOSAMAZON2.Run();
                    MESSAGE('Hecho.');
                end;
            }
            action(ImportacionPEDIDOSVerdecora)
            {
                ApplicationArea = Suite;
                Caption = 'Importacion PEDIDOS Verdecora';
                trigger OnAction()
                var
                    xmlImportacionPEDIDOSVerdecora: Xmlport "Importacion PEDIDOS Verdecora";
                begin
                    Clear(xmlImportacionPEDIDOSVerdecora);
                    xmlImportacionPEDIDOSVerdecora.Run();
                    MESSAGE('Hecho.');
                end;
            }


            action(ImportacionPEDIDOSVerdecora2)
            {
                ApplicationArea = Suite;
                Caption = 'Importacion PEDIDOS Verdecora-2';
                trigger OnAction()
                var
                    xmlImportacionPEDIDOSVerdecora2: Xmlport "Importacion PEDIDOS Verdecora2";
                begin
                    Clear(xmlImportacionPEDIDOSVerdecora2);
                    xmlImportacionPEDIDOSVerdecora2.PasoClie(Rec."No.");
                    xmlImportacionPEDIDOSVerdecora2.Run();
                    MESSAGE('Hecho.');
                end;
            }
            action(ImportacionPEDIDOSKIWOKO5)
            {
                ApplicationArea = Suite;
                Caption = 'Importacion PEDIDOS AVILA';
                trigger OnAction()
                var
                    ImportacionPEDIDOSKIWOKO5: XmlPort "Importacion PEDIDOS AVILA";
                begin
                    Clear(ImportacionPEDIDOSKIWOKO5);
                    ImportacionPEDIDOSKIWOKO5.Run();
                    MESSAGE('Hecho.');
                end;
            }

            action(LineasOfertaaExcel)
            {
                ApplicationArea = Suite;
                Caption = 'Plantilla de Alta Productos';
                trigger OnAction()
                var
                    ReportLineasExcel: Report "Plantilla de Alta Productos";
                    Rec37: Record "Sales Line";
                begin
                    Clear(ReportLineasExcel);
                    Rec37.reset;
                    Rec37.SetRange("Document Type", Rec."Document Type");
                    Rec37.SetRange("Document No.", Rec."No.");
                    IF Rec37.FindFirst() THEN BEGIN
                        ReportLineasExcel.SetTableView(Rec37);
                        ReportLineasExcel.Run();
                    END;

                    MESSAGE('Hecho.');
                end;
            }
            action(Proforma)
            {
                ApplicationArea = Suite;
                Caption = 'Proforma Catit Canarias';
                trigger OnAction()
                var
                    ReportProforma: report "Standard Sales - Pro Forma Inv";
                    Rec36: Record "Sales Header";
                begin
                    Clear(ReportProforma);
                    Rec36.reset;
                    Rec36.SetRange("Document Type", Rec."Document Type");
                    Rec36.SetRange("No.", Rec."No.");
                    IF Rec36.FindFirst() THEN BEGIN
                        ReportProforma.SetTableView(Rec36);
                        ReportProforma.Run();
                    END;

                    MESSAGE('Hecho.');
                end;
            }








        }






    }

    trigger OnClosePage()
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", Rec."Document Type");
        SalesLine.SETRANGE("Document No.", rec."No.");
        IF NOT SalesLine.FINDFIRST THEN BEGIN
            Rec.DELETE;
        END;
    end;



}
