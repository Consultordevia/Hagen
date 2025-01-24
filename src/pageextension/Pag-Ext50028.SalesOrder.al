pageextension 50028 SalesOrder extends "Sales Order"
{
    layout
    {

        addafter("Ship-to Address 2")
        {

            field("Envio a-Nº Telefono"; Rec."Envio a-Nº Telefono") { ApplicationArea = All; }
            field("E-MAIL"; Rec."E-MAIL") { ApplicationArea = All; }
            field(Dropshipping; Rec.Dropshipping) { ApplicationArea = All; }
        }


        addafter("Sell-to Customer Name")
        {


            field(TextoWebApi; Rec.TextoWebApi) { ApplicationArea = All; }
            field("Fecha alta"; Rec."Fecha alta") { ApplicationArea = All; }
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
    }
    actions
    {
        addlast(processing)
        {


            action(CopiaraPedido)
            {
                ApplicationArea = Suite;
                Caption = 'Copiar a Pedido';
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
                    Cestadelacompra: Page "Cesta de la compra";
                    Cestacompra: Record "Cesta compra";
                    Rec91: Record "User Setup";
                    ImportacionPEDIDOSMASKOcome: XMLport "Importacion PEDIDOS MASKO-come";
                    NoSeriesManagement: Codeunit NoSeriesManagement;


                begin

                    ReleaseSalesDoc.PerformManualReopen(Rec);



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
                        RecCVP.GET;
                        Cust.GET(SalesHeader3."Sell-to Customer No.");
                        Cust.CALCFIELDS(Cust."Balance (LCY)");
                        IF Cust."Balance (LCY)" <> 0 THEN BEGIN
                            Fechavto := 0D;
                            SEPASA := FALSE;
                            Rec21.RESET;
                            Rec21.SETCURRENTKEY("Customer No.", Open, Positive, "Due Date", "Currency Code");
                            Rec21.SETRANGE(Rec21."Customer No.", SalesHeader3."Sell-to Customer No.");
                            Rec21.SETRANGE(Rec21.Positive, TRUE);
                            Rec21.SETRANGE(Rec21.Open, TRUE);
                            IF Rec21.FINDFIRST THEN BEGIN
                                Fechavto := Rec21."Due Date";
                                IF TODAY - Fechavto > (RecCVP."Dias aviso falta pago" + Cust."Dias tolerancias fecha vto.") THEN BEGIN
                                    SEPASA := TRUE;
                                END;
                            END;
                        END;

                        IF SEPASA THEN BEGIN
                            ERROR('El cliente esta bloqueado por exceso falta de pago.');
                        END;
                    END;




                    UserSetup.GET(USERID);
                    CODACTI := INCSTR(UserSetup."Serie pedidos");
                    UserSetup."Serie pedidos" := CODACTI;
                    UserSetup."Nº cliente" := Rec."No.";
                    UserSetup.MODIFY;

                    CODACTI := NoSeriesManagement.GetNextNo('V-OFPE-1', TODAY, TRUE);

                    Rec362.INIT;
                    Rec362 := Rec;
                    Rec362."No." := CODACTI;
                    Rec362."Document Type" := 1;
                    Rec362."Estado pedido" := 2;
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
                                    IF (NOT RecProd."No permite pedido") AND (NOT RecProd."Producto con reserva") THEN BEGIN
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
                            ///END;
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
                                    fecha2 := 0D;
                                    RecProd.CALCFIELDS(RecProd."Fecha proxima recepción conten");
                                    fecha2 := RecProd."Fecha proxima recepción conten";
                                    IF fecha2 = 0D THEN BEGIN
                                        fecha2 := 20501231D;
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
                                        MESSAGE('2  %1 ', Rec372);
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
                            //END;
                            UNTIL Rec372.NEXT = 0;
                    END;

                    Rec372.RESET;
                    Rec372.SETRANGE(Rec372."Document Type", Rec."Document Type");
                    Rec372.SETRANGE(Rec372."Document No.", Rec."No.");
                    IF Rec372.FINDFIRST THEN BEGIN
                        ///     Rec."Estado presupuesto":=1;
                        ///     Rec.MODIFY;
                    END;
                    Rec372.RESET;
                    Rec372.SETRANGE(Rec372."Document Type", Rec."Document Type");
                    Rec372.SETRANGE(Rec372."Document No.", Rec."No.");
                    IF NOT Rec372.FINDFIRST THEN BEGIN
                        ///Rec."Estado presupuesto":=2;
                        ///Rec.MODIFY;
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

                    ///MESSAGE('Nuevo pedido el %1',Rec362."No.");



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



                end;
            }

            action(Importardropshiping)
            {
                ApplicationArea = Suite;
                Caption = 'Importar dropshiping';
                trigger OnAction()
                var
                    ImportacionPEDIDOSMASKOcome: XmlPort "Importacion PEDIDOS MASKO-come";
                begin
                    clear(ImportacionPEDIDOSMASKOcome);
                    ImportacionPEDIDOSMASKOcome.Run();
                end;
            }
            action(ImportarPedido)
            {
                ApplicationArea = Suite;
                Caption = 'Importar Pedido';
                trigger OnAction()
                var
                    ImportacionPEDIDOSOTROS2: XMLport "Importacion PEDIDOS OTROS2";
                begin
                    CLEAR(ImportacionPEDIDOSOTROS2);
                    ImportacionPEDIDOSOTROS2.PasoClie(Rec."No.");
                    ImportacionPEDIDOSOTROS2.RUN;


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

            action(ImportacionPEDIDOSCARREFOUR)
            {
                ApplicationArea = Suite;
                Caption = 'Importacion PEDIDOS CARREFOUR';
                trigger OnAction()
                var
                    xmlImportacionPEDIDOSCARREFOUR: Xmlport "Importacion PEDIDOS CARREFOUR";


                begin

                    Clear(xmlImportacionPEDIDOSCARREFOUR);
                    xmlImportacionPEDIDOSCARREFOUR.Run();

                    MESSAGE('Hecho.');

                end;
            }
            action(ImportacionPEDIDOSLeroyMerl)
            {
                ApplicationArea = Suite;
                Caption = 'Importacion PEDIDOS Leroy Merl';
                trigger OnAction()
                var
                    xmlImportacionPEDIDOSLeroyMerl: Xmlport "Importacion PEDIDOS Leroy Merl";
                begin
                    Clear(xmlImportacionPEDIDOSLeroyMerl);

                    MESSAGE('Hecho.');
                end;
            }

            action(ImportacionPEDIDOSmanomano)
            {
                ApplicationArea = Suite;
                Caption = 'Importacion PEDIDOS mano mano';
                trigger OnAction()
                var
                    xmlImportacionPEDIDOSmanomano: Xmlport "Importacion PEDIDOS mano mano";
                begin
                    Clear(xmlImportacionPEDIDOSmanomano);
                    xmlImportacionPEDIDOSmanomano.Run();
                    MESSAGE('Hecho.');
                end;
            }

            action(ImportacionPEDIDOStiendaan)
            {
                ApplicationArea = Suite;
                Caption = 'Importacion PEDIDOS tienda animal';
                trigger OnAction()
                var
                    xmlImportacionPEDIDOStiendaan: Xmlport "Importacion PEDIDOS tienda an";
                begin
                    Clear(xmlImportacionPEDIDOStiendaan);
                    xmlImportacionPEDIDOStiendaan.Run();
                    MESSAGE('Hecho.');
                end;
            }
            action(ImportacionPEDIDOSWEB)
            {
                ApplicationArea = Suite;
                Caption = 'Importacion PEDIDOS WEB';
                trigger OnAction()
                var
                    xmlImportacionPEDIDOSWEB18: Xmlport "Importacion PEDIDOS WEB18";
                begin
                    Clear(xmlImportacionPEDIDOSWEB18);
                    xmlImportacionPEDIDOSWEB18.Run();
                    MESSAGE('Hecho.');
                end;
            }
            action(Importacionmirivaaqua)
            {
                ApplicationArea = Suite;
                Caption = 'Importacion PED miriva aqua';
                trigger OnAction()
                var
                    xmlImportacionPEDIDOSWEB18: Xmlport "Importacion PED miriva NAV0316";
                begin
                    Clear(xmlImportacionPEDIDOSWEB18);
                    xmlImportacionPEDIDOSWEB18.Run();
                    MESSAGE('Hecho.');
                end;
            }
            action(xmlImportacionPEDmirivaNAV0317)
            {
                ApplicationArea = Suite;
                Caption = 'Importacion PED miriva catit';
                trigger OnAction()
                var
                    xmlImportacionPEDmirivaNAV0317: Xmlport "Importacion PED miriva NAV0317";
                begin
                    Clear(xmlImportacionPEDmirivaNAV0317);
                    xmlImportacionPEDmirivaNAV0317.Run();
                    MESSAGE('Hecho.');
                end;
            }


            action(Importacionpedicattit)
            {
                ApplicationArea = Suite;
                Caption = 'Importacion PEDIDOS catitt new';
                trigger OnAction()
                var
                    xmlImportacionPEDIDOSWEB18: Xmlport "Importacion PEDIDOS catitt new";
                begin
                    Clear(xmlImportacionPEDIDOSWEB18);
                    xmlImportacionPEDIDOSWEB18.Run();
                    MESSAGE('Hecho.');
                end;
            }

            action(ImportacionPEDIDOSKIWOKO3)
            {
                ApplicationArea = Suite;
                Caption = 'Importacion PEDIDOS KIWOKO3';
                trigger OnAction()
                var
                    ImportacionPEDIDOSKIWOKO3: XmlPort "Importacion PEDIDOS KIWOKO3";
                begin
                    Clear(ImportacionPEDIDOSKIWOKO3);
                    ImportacionPEDIDOSKIWOKO3.Run();
                    MESSAGE('Hecho.');
                end;
            }
            action(ImportacionPEDIDOSKIWOKO5)
            {
                ApplicationArea = Suite;
                Caption = 'Importacion PEDIDOS KIWOKO5';
                trigger OnAction()
                var
                    ImportacionPEDIDOSKIWOKO5: XmlPort "Importacion PEDIDOS KIWOKO5";
                begin
                    Clear(ImportacionPEDIDOSKIWOKO5);
                    ImportacionPEDIDOSKIWOKO5.Run();
                    MESSAGE('Hecho.');
                end;
            }







            /*
                                   Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PEDIDOS KIWOKO3", InStream);
                                   Xmlport.Import(Xmlport::"Importacion COVALPROPER", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PEDIDOS AMAZON2", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PEDIDOS tienda an", InStream);
                                   Xmlport.Import(Xmlport::"Importacion SENDING", InStream);
                                   Xmlport.Import(Xmlport::"Importacion transaher", InStream);
                                   Xmlport.Import(Xmlport::"Importacion transaher", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PEDIDOS MASKO-new", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PEDIDOS Verdecora", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PEDIDOS Verdecora2", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PEDIDOS CARREFOUR", InStream);
                                   Xmlport.Import(Xmlport::"Importacion GLS", InStream);
                                   Xmlport.Import(Xmlport::"Importacion CORREOS", InStream);
                                   Xmlport.Import(Xmlport::"Importacion TXT", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PEDIDOS catitt new", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PEDIDOS Leroy Merl", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PEDIDOS V-12827", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PEDIDOS V-12832", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PEDIDOS V-12833", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PED miriva NAV0317", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PED miriva NAV0316", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PEDIDOS ECI EDICOM", InStream);
                                   Xmlport.Import(Xmlport::"Importacion PEDLIN ECI EDICOM", InStream);
                                   */











        }
    }
}
