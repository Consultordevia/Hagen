pageextension 50028 SalesOrder extends "Sales Order"
{
    layout
    {

        addafter("Ship-to Address 2")
        {

            field("Envio a-Nº Telefono"; Rec."Envio a-Nº Telefono") { ApplicationArea = All; }
            field("E-MAIL"; Rec."E-MAIL") { ApplicationArea = All; }
            field(Dropshipping; Rec.Dropshipping) { ApplicationArea = All; }
            field("Tipo facturación"; Rec."Tipo facturación") { ApplicationArea = All; }

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
            field("Nº bultos"; Rec."Nº bultos") { ApplicationArea = All; }
            field("Estado pedido"; Rec."Estado pedido") { ApplicationArea = All; }
            field(Urgente; Rec.Urgente) { ApplicationArea = All; }
            field("Super urgente"; Rec."Super urgente") { ApplicationArea = All; }



        }
    }
    actions
    {
        addlast(processing)
        {

            action("Crear EXPEDICION")
            {
                ApplicationArea = Basic;
                Caption = 'Crear EXPEDICION';
                Ellipsis = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                begin
                    CrearEXEDICION;
                end;
            }


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


    local procedure CrearEXEDICION()
    var
        AutomaticosAdaia: Codeunit "Automaticos Cartas";
        SalesHeader: Record "Sales Header";
        LogAdaiaPedidos: Record LogAdaiaPedidos;
        LogAdaiaFicheros: Record LogFicherosAdaia;
        RecCV: Record "Sales Header";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        CodeCV: Codeunit "Automaticos Cartas";
        enviar: Boolean;
        EXPEDI: CODE[20];
        REC110: Record "Sales Shipment Header";
        REC1102: Record "Sales Shipment Header";
        Rec112: Record "Sales Invoice Header";
        CUEXP: Codeunit "Automaticos Cartas";
        RecTra: Record "Shipping Agent";
        Rec113: Record "Sales Invoice Line";
        NALBARAN: CODE[20];
        Cajasporenvio: Record "Cajas por envio";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentHeader2: Record "Sales Shipment Header";
        LLINEA: Integer;
        RecLVSuma: Record "Sales Line";
        contadordeagrup: CODE[20];
        NoSeriesLine: Record "No. Series Line";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        NPEDIDO: CODE[20];
        ItemJournalLine: Record "Item Journal Line";
        LETRA: CODE[1];
        CODTRANS: Code[20];
        npedidos: Integer;
        SalesHeader3: Record "Sales Header";
        SalesHeader33: Record "Sales Header";
        EXPEDROP: Code[20];
        SalesLine3: Record "Sales Line";
        SalesLine5: Record "Sales Line";
        Customer: Record Customer;



    begin

        Commit;

        contadordeagrup := '0';

        NoSeriesLine.Reset;
        if Rec."VAT Country/Region Code" <> 'PT' then begin
            NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAP');
            if Rec."Nº exped. pequeña" then begin
                NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAPP');
            end;
        end;
        if Rec."VAT Country/Region Code" = 'PT' then begin
            NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAPT');
        end;
        if NoSeriesLine.FindFirst then begin
            NPEDIDO := NoSeriesLine."Last No. Used";
            NoSeriesLine."Last No. Used" := IncStr(NPEDIDO);
            NoSeriesLine.Modify;
        end;



        SalesReceivablesSetup.Get;
        ItemJournalLine.Reset;
        ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", 'PRODUCTO');
        ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", 'ABC');
        ItemJournalLine.SetRange(ItemJournalLine."Line No.", SalesReceivablesSetup."Ultima letra" + 1);
        if ItemJournalLine.FindFirst then begin
            LETRA := ItemJournalLine."Document No.";
            if SalesReceivablesSetup."Ultima letra" + 1 = 26 then begin
                SalesReceivablesSetup."Ultima letra" := 1;
                SalesReceivablesSetup.Modify;
            end;
            if SalesReceivablesSetup."Ultima letra" + 1 <> 26 then begin
                SalesReceivablesSetup."Ultima letra" := SalesReceivablesSetup."Ultima letra" + 1;
                SalesReceivablesSetup.Modify;
            end;
        end;

        NPEDIDO := NPEDIDO + LETRA;


        if CopyStr(Rec."No.", 3, 4) = 'CATW' then begin
            NPEDIDO := Rec."Your Reference";
        end;





        CODTRANS := '';
        npedidos := 1;

        SalesHeader3.Reset;
        SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
        SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
        SalesHeader3.SetRange(SalesHeader3."Estado pedido", 1);
        SalesHeader3.SetRange(SalesHeader3."Nº expedición", '');
        SalesHeader3.SetRange(SalesHeader3."No.", Rec."No.");
        if SalesHeader3.FindSet then
            repeat
                SalesHeader33.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                SalesHeader33."Nº expedición" := NPEDIDO;
                SalesHeader33."Nº expedición dropshp" := EXPEDROP;
                SalesHeader33."Package Tracking No." := EXPEDROP;
                SalesLine3.Reset;
                SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                if SalesLine3.FindSet then
                    repeat
                        if SalesLine3.Type = 2 then begin
                            SalesLine3."Nº expedición" := NPEDIDO;
                            SalesLine3.Modify;
                        end;
                    until SalesLine3.Next = 0;
                SalesHeader33.Modify;
            until SalesHeader3.Next = 0;


        /*        SalesHeader35.Reset;
                SalesHeader35.SetRange(SalesHeader35."Document Type", Rec."Document Type");
                SalesHeader35.SetRange(SalesHeader35."No.", Rec."No.");
                if SalesHeader35.FindFirst then begin
                    if CopyStr(SalesHeader35."No.", 3, 3) <> 'WEB' then begin
                        AutomaticosAdaia.ENVIAREMAILPARAPREPARAR(SalesHeader35);
                    end;
                end;*/

        SalesHeader3.Reset;
        SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
        SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
        SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
        if SalesHeader3.FindSet then
            repeat
                if CopyStr(SalesHeader3."No.", 3, 3) = 'WEB' then begin
                    SalesLine5.Reset;
                    SalesLine5.SetRange(SalesLine5."Document Type", SalesHeader3."Document Type");
                    SalesLine5.SetRange(SalesLine5."Document No.", SalesHeader3."No.");
                    if SalesLine5.FindSet then
                        repeat
                            SalesLine5."Usuario alta" := 'HAGEN\OSCAR';
                            SalesLine5.Modify;
                        until SalesLine5.Next = 0;
                end;

            until SalesHeader3.Next = 0;


        Commit;

        /// REGISTRAR
        RecCV.RESET;
        RecCV.SETCURRENTKEY(RecCV."Document Type", RecCV."Nº expedición");
        RecCV.SETRANGE(RecCV."Document Type", 1);
        RecCV.SETRANGE(RecCV."Nº expedición", NPEDIDO);
        IF RecCV.FINDFIRST THEN
            REPEAT
                CLEAR(ReleaseSalesDoc);
                CLEAR(CodeCV);
                ReleaseSalesDoc.RUN(RecCV);
                CodeCV.REGISTRASOLOEXPE(RecCV);
            UNTIL RecCV.NEXT = 0;
        ///          
        enviar := TRUE;
        EXPEDI := NPEDIDO;
        REC110.SETCURRENTKEY(REC110."Nº expedición");
        REC110.SETFILTER(REC110."Nº expedición", NPEDIDO + '*');
        IF REC110.FINDSET THEN
            REPEAT
                IF REC110.Dropshipping = FALSE THEN BEGIN
                    IF REC110."Albaran sin detalle" = TRUE THEN BEGIN
                        IF REC110."No. Printed" = 0 THEN BEGIN
                            enviar := FALSE;
                        END;
                    END;
                END;
            UNTIL REC110.NEXT = 0;




        IF enviar THEN BEGIN
            EXPEDI := NPEDIDO;
            REC110.RESET;
            REC110.SETCURRENTKEY(REC110."Nº expedición");
            REC110.SETFILTER(REC110."Nº expedición", NPEDIDO + '*');
            IF REC110.FINDFIRST THEN
                REPEAT
                    NALBARAN := REC110."No.";
                    Rec1102.RESET;
                    Rec1102.SETRANGE(Rec1102."No.", REC110."No.");
                    IF Rec1102.FINDFIRST THEN
                        REPEAT
                            IF Rec1102."Nº Palets" = 0 THEN BEGIN
                                IF RecTra.GET(Rec1102."Shipping Agent Code") THEN BEGIN
                                    IF RecTra."Fichero estandar" = TRUE THEN BEGIN
                                        CUEXP.ETISTD(Rec1102);
                                    END;
                                    IF RecTra."Fichero estandar" = FALSE THEN BEGIN
                                        ///IF Rec1102."Shipping Agent Code"='DHL' THEN BEGIN
                                        ///CUEXP.EtiDHL2NUEVA(Rec1102);
                                        //END;
                                        IF Rec1102."Shipping Agent Code" = 'TIPSA' THEN BEGIN
                                            CUEXP.Etitipsa2NUEVA(Rec1102);
                                        END;
                                        IF Rec1102."Shipping Agent Code" = 'CORR' THEN BEGIN
                                            CUEXP.EtiCORRa2NUEVA(Rec1102);
                                        END;
                                        IF Rec1102."Shipping Agent Code" = 'CRON' THEN BEGIN
                                            CUEXP.EtiCRON2NUEVA(Rec1102);
                                        END;
                                        IF Rec1102."Shipping Agent Code" = 'SEUR' THEN BEGIN
                                            CUEXP.EtiSEURNUEVA(Rec1102);
                                        END;
                                        IF Rec1102."Shipping Agent Code" = 'TNT' THEN BEGIN
                                            ///CUEXP.EtiTNT2NUEVA(Rec1102);
                                            CUEXP.EtiTNT2(Rec1102);
                                        END;
                                    END;
                                    IF Rec1102."Shipping Agent Code" = 'ECI' THEN BEGIN
                                        ///     CUEXP.ETIECI(Rec1102);
                                    END;
                                END;
                            END;
                            IF Rec1102."Bill-to Customer No." = '6445' THEN BEGIN
                                ///REPORT.RUNMODAL(50035,FALSE,FALSE,Rec1102);
                                ///REPORT.RUNMODAL(50039,FALSE,FALSE,Rec1102);
                            END;
                        UNTIL Rec1102.NEXT = 0;
                    IF Rec1102."Bill-to Customer No." = '10925' THEN BEGIN
                        /////-                         ficehrocovaldroper;
                    END;
                    IF Customer.GET(REC110."Sell-to Customer No.") THEN BEGIN
                        IF Customer."Enviar etiqueta grande" THEN BEGIN
                            REPORT.RUNMODAL(50039, FALSE, FALSE, REC110);
                        END;
                    END;
                UNTIL REC110.NEXT = 0;






            ///// etiqueta edi

            Rec112.RESET;
            Rec112.SETCURRENTKEY(Rec112."Nº expedición");
            Rec112.SETFILTER(Rec112."Nº expedición", NPEDIDO + '*');
            IF Rec112.FINDFIRST THEN BEGIN
                IF Rec112."Nº bultos" = 1 THEN BEGIN
                    Rec113.RESET;
                    Rec113.SETRANGE("Document No.", Rec112."No.");
                    Rec113.SETRANGE(Type, Rec113.Type::Item);
                    IF Rec113.FINDFIRST THEN
                        REPEAT

                            Cajasporenvio.Nfac := Rec113."Document No.";
                            Cajasporenvio.nlin := Rec113."Line No.";
                            Cajasporenvio.Producto := Rec113."No.";
                            Cajasporenvio."Caja num" := 1;
                            Cajasporenvio.Cantidad := Rec113.Quantity;
                            Cajasporenvio."nº expedicion" := NPEDIDO;
                            IF Cajasporenvio.INSERT THEN;
                            Rec113."Cantidad caja" := 1;
                            Rec113.MODIFY;
                        UNTIL Rec113.NEXT = 0;
                    Cajasporenvio.RESET;
                    Cajasporenvio.SETRANGE(Nfac, Rec112."No.");
                    IF Cajasporenvio.FINDFIRST THEN
                        REPEAT
                            Cajasporenvio.CreaSSCC;
                            Cajasporenvio.MODIFY;
                        UNTIL Cajasporenvio.NEXT = 0;
                    SalesShipmentHeader.RESET;
                    SalesShipmentHeader.SETRANGE("Nº expedición", Rec112."Nº expedición");
                    IF SalesShipmentHeader.FINDFIRST THEN BEGIN
                        SalesShipmentHeader2.RESET;
                        SalesShipmentHeader2.SETRANGE("No.", SalesShipmentHeader."No.");
                        IF SalesShipmentHeader2.FINDFIRST THEN BEGIN
                            ///CLEAR(EtiquetaECINUEVAALB);            
                            ///EtiquetaECINUEVAALB.Pasadatos(Cajasporenvio."Caja num",Rec113."Cantidad caja",Cajasporenvio.SSCC);   
                            ///EtiquetaECINUEVAALB.SETTABLEVIEW(SalesShipmentHeader2);
                            ///EtiquetaECINUEVAALB.RUNMODAL;
                            //// REPORT.RUN(50105,FALSE,FALSE,SalesShipmentHeader2);                                   
                        END;
                    END;




                END;
            END;
        end;
    end;





}
