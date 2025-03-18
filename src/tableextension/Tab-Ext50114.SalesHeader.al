tableextension 50114 SalesHeader extends "Sales Header"
{
    // VER  cesta compra
    fields
    {

        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                Reccust: Record customer;
            begin
                if Reccust.get("Sell-to Customer No.") then begin
                    Rec."Permite fraccionar uni. venta" := Reccust."Permite fraccionar unidad de venta";
                end;

            end;
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if COMPANYNAME = 'HAGEN CANARIAS S.C.' then begin
                    "Posting No. Series" := SalesSetup."Posted Invoice Nos.";
                end;
            end;
        }

        modify("Your Reference")
        {
            trigger OnAfterValidate()
            var
                RecCV: Record "Sales Header";
                Rec110: Record "Sales Shipment Header";
            begin
                if "Your Reference" <> '' then begin
                    /////25B2B1058
                    /////12345
                    if CopyStr("No.", 3, 3) <> 'B2B' then begin
                        RecCV.reset;
                        RecCV.SetCurrentKey("Your Reference");
                        RecCV.SetRange("Your Reference", "Your Reference");
                        IF RecCV.FindSet() THEN
                            repeat
                                IF RECCV."No." <> "No." THEN begin
                                    ERROR('Esta referencia de pedido %2 ya existe en el pedido %1', RecCV."No.", "Your Reference");
                                end;
                            UNTIL RecCV.NEXT = 0;
                        Rec110.reset;
                        Rec110.SetCurrentKey("Your Reference");
                        Rec110.SetRange("Your Reference", "Your Reference");
                        IF Rec110.FindSet() THEN
                            repeat
                                IF Rec110."No." <> "No." THEN begin
                                    ERROR('Esta referencia de pedido %2 ya existe en el albaran %1', Rec110."No.", "Your Reference");
                                end;
                            UNTIL Rec110.NEXT = 0;
                    end;
                end;
            end;
        }


        modify("Customer Disc. Group")
        {
            trigger OnAfterValidate()
            var
                Item2: Record Item;
                dtolin: Decimal;
                RecUS: Record "User Setup";
            begin
                if Rec."Document Type" = Rec."Document Type"::Quote then begin
                    IF RecUS.get(userid) THEN begin
                        IF RecUS."Permite modif. Grupo dto en OFERTA" = false then begin
                            if CopyStr("No.", 3, 3) <> 'B2B' then begin
                                    Error('No tiene permiso a modificar este campo');
                            END;
                        end;
                    end;
                end;
                SalesLine.Reset;
                SalesLine.SetRange(SalesLine."Document Type", Rec."Document Type");
                SalesLine.SetRange("Document No.", Rec."No.");
                if SalesLine.FindSet then
                    repeat
                        if Item2.Get(SalesLine."No.") then begin
                            dtolin := SalesLine."Line Discount %";
                            SalesLine.Validate("Customer Disc. Group", Rec."Customer Disc. Group");
                            if dtolin = 100 then begin
                                SalesLine.Validate("Line Discount %", dtolin);
                            end;
                            SalesLine.Modify;
                        end;
                    until SalesLine.Next = 0;
            end;
        }

        modify("Shipping Agent Code")
        {
            trigger OnAfterValidate()
            var
                ShippingAgentServices: Record "Shipping Agent Services";
            begin
                ShippingAgentServices.Reset;
                ShippingAgentServices.SetRange(ShippingAgentServices."Shipping Agent Code", Rec."Shipping Agent Code");
                ShippingAgentServices.SetRange(Predeterminado, true);
                if ShippingAgentServices.FindFirst then begin
                    "Shipping Agent Service Code" := ShippingAgentServices.Code;
                end;
            end;
        }



        field(50000; "Estado pedido"; Option)
        {
            OptionCaption = 'Retenido,Para preparar,Pdte. comercial,Servido,Pendiente stock';
            OptionMembers = Retenido,"Para preparar","Pdte. comercial",Servido,"Pendiente stock";

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
                Cust: Record Customer;
                Rec372: Record "Sales Line";
                RecTransp: Record "Shipping Agent";
                RecClie4: Record CUSTOMER;
                SALDOC: Decimal;
                Rec21C: Record "Cust. Ledger Entry";
                CustLedgerEntry: Record "Cust. Ledger Entry";
                SUMAVAL: Decimal;
                PaymentMethod: Record "Payment Method";
                CODAGENRESPE: CODE[20];
                Rec89: Record "BOM Component";
                RecCV3: Record "Sales Header";
                nlineas: Integer;
                nkilos: Decimal;
                RecLV3: Record "Sales Line";
                CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
            begin


                UserSetup.Get(UserId);


                if "Estado pedido" = 0 then begin

                    Cust.Get("Sell-to Customer No.");
                    if Cust."Permite seguir adelante" = false then begin
                        rec.ChequeoFechaVtos;
                    end;
                    Rec372.Reset;
                    Rec372.SetRange(Rec372."Document Type", "Document Type");
                    Rec372.SetRange(Rec372."Document No.", "No.");
                    if Rec372.FindFirst then begin
                        CustCheckCreditLimit.SalesLineCheck(Rec372);
                    end;


                    Cust.Get("Sell-to Customer No.");
                    Cust.CalcFields(Cust."Importe impagado");
                    if Cust."Permite seguir adelante" = false then begin
                        if Cust."Importe impagado" <> 0 then begin
                            if UserSetup."Permite alta pedido con impago" = false then begin                                 
                                Error('No puede pasar pedido porque el cliente tiene impagos.');                                 
                            end;
                        end;
                    end;
                end;

                if "Estado pedido" = 1 then begin

                    Cust.Get("Sell-to Customer No.");
                    if Cust."Permite seguir adelante" = false then begin
                        ChequeoFechaVtos;
                    end;
                    Rec372.Reset;
                    Rec372.SetRange(Rec372."Document Type", "Document Type");
                    Rec372.SetRange(Rec372."Document No.", "No.");
                    if Rec372.FindFirst then begin
                        CustCheckCreditLimit.SalesLineCheck(Rec372);
                    end;


                    Cust.Get("Sell-to Customer No.");
                    Cust.CalcFields(Cust."Importe impagado");
                    if Cust."Permite seguir adelante" = false then begin
                        if Cust."Importe impagado" <> 0 then begin
                            if UserSetup."Permite alta pedido con impago" = false then begin                                 
                                Error('No puede pasar pedido porque el cliente tiene impagos.');                                 
                            end;
                        end;
                    end;
                end;


                if "Estado pedido" = 1 then begin
                    if "Ship-to Post Code" = '' then begin                         
                        Error('Falta el codigo postal en la direccion de envio.');                         
                    end;



                    if RecTransp.Get("Shipping Agent Code") then begin
                        if Dropshipping = false then begin
                            Dropshipping := false;
                            "Cobra portes entre empresas" := RecTransp."Cobrar portes entre empresas";
                            if "Cobra portes entre empresas" then begin
                                Dropshipping := true;
                            end;
                        end;
                        if RecTransp."No incluir portes" then begin
                            "No incluir portes" := true;
                        end;
                        if RecTransp."No agrupar" then begin
                            "No agrupar en ADAIA" := true;
                        end;
                    end;
                end;

                if "Estado pedido" = 1 then begin
                    RecClie4.Get("Sell-to Customer No.");
                    if RecClie4."Estatus del cliente" <> 0 then begin                     
                        Error('Este cliente no esta activo, esta %1', RecClie4."Estatus del cliente");                         
                    end;
                end;

                if "Estado pedido" = 1 then begin
                    Cust.Get("Sell-to Customer No.");
                    if Cust."Permite seguir adelante" = false then begin
                        SALDOC := 0;
                        if Cust.Comunidad = '7' then begin
                            Rec21C.ChangeCompany('HAGEN CANARIAS S.C.');
                            Rec21C.Reset;
                            Rec21C.SetCurrentkey(Rec21C."Customer No.", Rec21C.Open);
                            Rec21C.SetRange(Rec21C."Customer No.", "Sell-to Customer No.");
                            Rec21C.SetRange(Rec21C.Open, true);
                            Rec21C.SetRange(Rec21C."Due Date", 0D, Today);
                            if Rec21C.FindFirst then
                                repeat
                                    SALDOC := SALDOC + Rec21C."Remaining Amount (LCY) stats.";
                                until Rec21C.Next = 0;
                        end;
                        CustLedgerEntry.Reset;
                        CustLedgerEntry.SetCurrentkey("Sell-to Customer No.");
                        CustLedgerEntry.SetRange("Sell-to Customer No.", "Sell-to Customer No.");
                        CustLedgerEntry.SetRange(Open, true);
                        CustLedgerEntry.SetRange("Due Date", 0D, Today);
                        if CustLedgerEntry.FindSet then
                            repeat
                                CustLedgerEntry.CalcFields(CustLedgerEntry."Remaining Amt. (LCY)");
                                SUMAVAL := SUMAVAL + CustLedgerEntry."Remaining Amt. (LCY)";
                            until CustLedgerEntry.Next = 0;
                        /////RecClie4.GET("Sell-to Customer No.");
                        /////RecClie4.SETRANGE(RecClie4."Date Filter",0D,TODAY);
                        /////RecClie4.CALCFIELDS(RecClie4."Balance Due (LCY)");
                        if SUMAVAL + SALDOC > 0 then begin                             
                            Error('Tiene saldos vencidos por un importe de %1', SUMAVAL + SALDOC);                             
                        end;
                    end;
                end;


                if "Estado pedido" = 1 then begin
                    if PaymentMethod.Get("Payment Method Code") then begin
                        if PaymentMethod."Transferencia WEB" then begin                             
                            Error('Este pedido no se puede pasar a preparar porque es transferencia WEB.');
                        end;
                    end;
                end;

                if "Estado pedido" = 1 then begin
                    /*
                                        if Rec."Respeta agencia transporte" = false then begin
                                            BuscaOptimo;
                                        end;
                                        if Rec."Respeta agencia transporte" = true then begin
                                            CODAGENRESPE := "Shipping Agent Code";
                                            BuscaOptimo;
                                            Rec89.Reset;
                                            Rec89.SetRange(Rec89."Parent Item No.", "No.");
                                            Rec89.SetRange(Rec89."Cod. transportista", CODAGENRESPE);
                                            if Rec89.FindFirst then begin
                                                "Importe optimo transporte" := Rec89.Euros;
                                                Validate("Shipping Agent Code", CODAGENRESPE);
                                                Modify;
                                                Commit;
                                            end;
                                        end;
                                        */

                end;



                if "Estado pedido" = 1 then begin
                    if "Shipping Agent Code" = 'CASH' then begin
                        "Observación para transporte" := "Observación para transporte" + ' CASH&CARRY'
                    end;
                    UserSetup.Get(UserId);
                    ChequeoFechaVtos;
                    Rec372.Reset;
                    Rec372.SetRange(Rec372."Document Type", "Document Type");
                    Rec372.SetRange(Rec372."Document No.", "No.");
                    if Rec372.FindFirst then begin
                        Commit;
                        CustCheckCreditLimit.SalesLineCheck(Rec372);
                    end;


                    Cust.Get("Sell-to Customer No.");
                    if Cust."Permite seguir adelante" = false then begin
                        Cust.CalcFields(Cust."Importe impagado");
                        if Cust."Importe impagado" <> 0 then begin
                            if UserSetup."Permite alta pedido con impago" = false then begin
                                Error('No puede pasar pedido porque el cliente tiene impagos.');
                            end;
                        end;
                    end;
                    RecCV3.Reset;
                    RecCV3.SetRange(RecCV3."Document Type", "Document Type");
                    RecCV3.SetRange(RecCV3."No.", "No.");
                    if RecCV3.FindFirst then begin
                        if UserId <> 'OSCAR' then begin
                            ///CU_Exporta.ENVIAREMAILPARAPREPARAR(RecCV3);
                        end;
                        ///Rec."Enviado email preparación":=TRUE;
                        ///Rec.MODIFY;
                    end;

                end;

                if "Estado pedido" = 1 then begin
                    UserSetup.Get(UserId);
                    if PaymentMethod.Get("Payment Method Code") then begin
                        if PaymentMethod."Pago anticipado" then begin
                            if UserSetup."Permite env.  ANTICIPOS" = false then begin
                                Error('No puede pasar porque no tiene permiso por pago ANTICIPADO.');
                            end;
                        end;
                    end;
                end;

                if "Estado pedido" = 1 then begin
                    nlineas := 0;
                    nkilos := 0;
                    RecLV3.Reset;
                    RecLV3.SetRange(RecLV3."Document Type", "Document Type");
                    RecLV3.SetRange(RecLV3."Document No.", "No.");
                    RecLV3.SetRange(RecLV3.Type, 2);
                    if RecLV3.FindFirst then
                        repeat
                            if (RecLV3."No." <> 'TRAN') and (RecLV3."No." <> 'REM') then begin
                                nlineas := nlineas + 1;
                                nkilos := nkilos + RecLV3.Quantity * RecLV3."Gross Weight";
                            end;
                        until RecLV3.Next = 0;
                    SalesSetup.Get;
                    Rec."Multi-picking" := false;
                    if (nlineas <= SalesSetup."Multi-picking lineas") and (nkilos <= SalesSetup."Multi-picking kilos") then begin
                        Rec."Multi-picking" := true;
                    end;
                    Rec.Modify;

                end;




                if (Rec."Estado pedido" = 3) or (Rec."Estado pedido" = 4) then begin
                    Error('No puede poner este estado.1');
                end;

                /////Retenido,Para preparar,Pdte. comercial,Servido,Pendiente stock
                /////   0,         1       ,      2        ,    3  , 4 
                ///// en BC ya se puede
                if (Rec."Estado pedido" <> 0) and (xRec."Estado pedido" = 0) then begin
                    UserSetup.Get(UserId);
                    if UserSetup.Comercial <> '' then begin
                        /////Error('No puede modificar el estado del pedido.2');
                    end;
                    if UserSetup."No Permite pasar pedido a preparar" then begin
                        Error('No puede modificar el estado del pedido.0');
                    end;
                end;

                if xRec."Estado pedido" = 1 then begin
                    UserSetup.Get(UserId);
                    if not UserSetup."Cambio de Activo a Retenido" then begin
                        Error('No puede modificar el estado del pedido.3');
                    end;
                    if Rec."Nº expedición" <> '' then begin
                        Error('No puede modificar, se envio a adaia.4');
                    end;
                end;
                if "Estado pedido" = 1 then begin
                    /*     RecAct2.RESET;
                         RecAct2.SETRANGE(RecAct2."Nº pedido","No.");
                         IF RecAct2.FINDFIRST THEN BEGIN
                         END;
                         RecLCV.RESET;
                         RecLCV.SETRANGE(RecLCV."Document Type",10);
                         RecLCV.SETRANGE(RecLCV."No.",RecAct2."Cód. Actividad");
                         IF RecLCV.FINDLAST THEN BEGIN
                              RecLCV."Line No.":=RecLCV."Line No."+10000;
                              RecLCV.Date:=TODAY;
                              RecLCV.Comment:='El pedido pasa de retenido a activo';
                              RecLCV."Usuario alta":=USERID;
                              RecLCV."Fecha alta":=TODAY;
                              RecLCV."Hora alta":=TIME;
                              RecLCV.INSERT;
                         END;
                         IF NOT RecLCV.FINDLAST THEN BEGIN
                              RecLCV."Document Type":=10;
                              RecLCV."No.":=RecAct2."Cód. Actividad";
                              RecLCV."Line No.":=RecLCV."Line No."+10000;
                              RecLCV.Date:=TODAY;
                              RecLCV.Comment:='El pedido pasa de retenido a activo';
                              RecLCV."Usuario alta":=USERID;
                              RecLCV."Fecha alta":=TODAY;
                              RecLCV."Hora alta":=TIME;
                              RecLCV.INSERT;
                         END;

                         RecAct2.RESET;
                         RecAct2.SETRANGE(RecAct2."Nº pedido","No.");
                         IF RecAct2.FINDFIRST THEN BEGIN
                              FormAct.SETTABLEVIEW(RecAct2);
                              FormAct.RUN;
                         END;
                         */
                end;

                ///Retenido,Para preparar,Pdte. comercial,Servido,Pendiente stock
                if "Estado pedido" = 1 then begin
                    "Usuario para preparar" := UserId;
                    "Fecha para preparar" := Today;
                    "Hora para preparar" := Time;
                    if "Customer Price Group" = 'ECI' then begin
                        "Shipping No. Series" := 'ALBECI'
                    end;
                    /////"Pedido pendiente":=TRUE;
                    UserSetup.Get(UserId);
                    if UserSetup.Comercial <> '' then begin
                        ///// en bc si puede
                        /////Error('No puede ponerlo en para preparar.');
                    end;

                end;
                if "Estado pedido" <> 1 then begin
                    "Usuario para preparar" := '';
                    "Fecha para preparar" := 0D;
                    "Hora para preparar" := 0T;
                end;

                if "Estado pedido" = 0 then begin
                    "Usuario Retenido" := UserId;
                    "Fecha Retenido" := Today;
                    "Hora Retenido" := Time;
                    "Usuario para preparar" := '';
                    "Fecha para preparar" := 0D;
                    "Hora para preparar" := 0T;

                end;

                ////IF "Descuento especial"<>0 THEN BEGIN
                ///VALIDATE("Descuento especial");
                ///END;

                // WEB
                if ("Estado pedido" in ["estado pedido"::"Para preparar", "estado pedido"::Servido]) and ("Id Pedido Presta Shop" > 0)
                  and (COMPANYNAME = 'ROLF C HAGEN ESPAÑA S.A.') then
                    "Notificar Envio" := true;
                // FIN

                if "Estado pedido"="Estado pedido"::"Para preparar" then begin
                    if TextoWebApi<>'' then begin
                        Error('Revise el campo TextoWebAp');
                    end;
                end;

            end;
        }
        field(50003; "Usuario alta"; Code[30])
        {
            Editable = false;
        }
        field(50004; "Fecha alta"; Date)
        {
            Editable = true;
        }
        field(50005; "Hora alta"; Time)
        {
            Editable = false;
        }
        field(50007; "Base Pdte."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Outstanding Amount (LCY)" where("Document Type" = field("Document Type"),
                                                                             "Document No." = field("No.")));
            Caption = 'Base Pdte.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50008; Base; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Line Amount" where("Document Type" = field("Document Type"),
                                                                "Document No." = field("No.")));
            Caption = 'Base';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; "Super urgente"; Boolean)
        {

            trigger OnValidate()
            begin
                /*
                RecUs.GET(USERID);
                IF NOT RecUs."Permiso pedidos urgentes" THEN BEGIN
                     ERROR('No tiene permiso para este campo.');
                END;
                */

            end;
        }
        field(50011; Preparador; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(Preparadores));
        }
        field(50012; Urgente; Boolean)
        {
        }
        field(50014; "Nº bultos"; Decimal)
        {

            trigger OnValidate()
            begin
                ///"Total bultos":="Nº bultos"+"Nº Palets";
            end;
        }
        field(50015; "Nº Palets"; Decimal)
        {

            trigger OnValidate()
            begin

                ///"Total bultos":="Nº bultos"+"Nº Palets";
            end;
        }
        field(50016; "Total bultos"; Decimal)
        {
            Editable = false;
        }
        field(50017; "Anula restos"; Boolean)
        {
        }
        field(50018; "Usuario para preparar"; Code[30])
        {
            Editable = false;
        }
        field(50019; "Fecha para preparar"; Date)
        {
            Editable = false;
        }
        field(50020; "Hora para preparar"; Time)
        {
            Editable = false;
        }
        field(50021; "Nombre comercial"; Text[50])
        {
        }
        field(50022; Televendedor; Code[10])
        {
            TableRelation = User;
        }
        field(50023; "No incluir portes"; Boolean)
        {
        }
        field(50024; "No imprimir albaran valorado"; Boolean)
        {
        }
        field(50027; "Total peso"; Decimal)
        {
        }
        field(50032; "Cdad. Pdte. Servir"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Outstanding Quantity" where("Document Type" = field("Document Type"),
                                                                         "Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50034; "Observación para transporte"; Text[80])
        {
        }
        field(50035; "Permite fraccionar uni. venta"; Boolean)
        {

            trigger OnValidate()
            begin
                /*RecUs.GET(USERID);
                IF NOT RecUs."Permite fraccionar uni. venta" THEN BEGIN
                     ERROR('No se puede modificar este campo.');
                END;
                */

            end;
        }
        field(50037; "Usuario Retenido"; Code[30])
        {
            Editable = false;
        }
        field(50038; "Fecha Retenido"; Date)
        {
            Editable = false;
        }
        field(50039; "Hora Retenido"; Time)
        {
            Editable = false;
        }
        field(50040; "Ampliacion del pedido nº"; Code[20])
        {
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order),
                                                        "Sell-to Customer No." = field("Sell-to Customer No."),
                                                        "Estado pedido" = filter(<> Servido));

            trigger OnValidate()
            begin

                if "Ampliacion del pedido nº" = "No." then begin
                    Error('No tiene pedidos pendientes.');
                end;

                if "Ampliacion del pedido nº" <> '' then begin
                    "No incluir portes" := true;
                end;
            end;
        }
        field(50041; "Nº expedición"; Code[10])
        {
        }
        field(50042; "Recibido de adaia"; Boolean)
        {
        }
        field(50043; "Observación para ALMACEN"; Text[60])
        {
        }
        field(50044; "No Enviar factura en exp."; Boolean)
        {
        }
        field(50045; "No Enviar albaran en exp."; Boolean)
        {
        }
        field(50046; "Importe a descontar reembolso"; Decimal)
        {
        }
        field(50047; "Albaran sin detalle"; Boolean)
        {
        }
        field(50053; "Pedido WEB"; Boolean)
        {
        }
        field(50059; "Respeta agencia transporte"; Boolean)
        {
        }
        field(50060; "Envio a-Nº Telefono"; Text[30])
        {
        }
        field(50061; "Estado presupuesto"; Option)
        {
            OptionMembers = Activo,"Parcialmente procesado",Procesado;

            trigger OnValidate()
            begin

                if ("Estado presupuesto" = 0) and (xRec."Estado presupuesto" = 1) then begin
                    Error('No puede volver a Activo.');
                end;

                if ("Estado presupuesto" = 0) and (xRec."Estado presupuesto" = 2) then begin
                    Error('No puede volver a Activo.');
                end;
            end;
        }
        field(50062; "Tipo facturación"; Option)
        {
            OptionMembers = Diaria,Semanal,Mensual;
        }
        field(50064; "Respeta Tipo facturacion"; Boolean)
        {
        }
        field(50067; "Nº exped. pequeña"; Boolean)
        {
        }
        field(50068; "Docu. requerida prov. sacada"; Boolean)
        {
        }
        field(50069; "Check contrareemolso verificad"; Boolean)
        {

            trigger OnValidate()
            begin

                if "Check contrareemolso verificad" then begin
                    "Respeta agencia transporte" := true;
                end;
            end;
        }
        field(50075; ASN; Text[40])
        {
        }
        field(50076; "No imprimir facturas"; Boolean)
        {
        }
        field(50077; "Provincia shopyfi"; Code[10])
        {
        }
        field(50111; SupraOferta; Code[10])
        {
        }
        field(50144; Comunidad; Code[10])
        {
        }
        field(50147; "Codigo cliente externo"; Code[20])
        {
            CalcFormula = lookup(Customer."Codigo cliente externo" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
        }
        field(50170; "Fecha incial de entrega EDICOM"; Date)
        {
        }
        field(50171; "REFTRANS EDICOM"; Text[35])
        {
        }
        field(50172; "Tipo de documento EDICOM"; Option)
        {
            OptionCaption = '351-Aviso de expedicion,35E-Aviso de devolucion,YA5-Expedicion CrossDocking';
            OptionMembers = "351-Aviso de expedicion","35E-Aviso de devolucion","YA5-Expedicion CrossDocking";
        }
        field(50173; "Funcion del mensaje EDICOM"; Option)
        {
            OptionCaption = '9-Original,1-Cancelacion,7-Duplicado,31-Copia,4-Cambio,5-Sustitucion';
            OptionMembers = "9-Original","1-Cancelacion","7-Duplicado","31-Copia","4-Cambio","5-Sustitucion";
        }
        field(50174; "Tipo transporte EDICOM"; Option)
        {
            OptionCaption = ' ,10-Transporte maritimo,20-Transporte ferroviario,30-Transporte por carretera,40-Transporte aereo,60-Transporte muitimodo';
            OptionMembers = " ","10-Transporte maritimo","20-Transporte ferroviario","30-Transporte por carretera","40-Transporte aereo","60-Transporte muitimodo";
        }
        field(50177; "IDENTIF EDICOM"; Option)
        {
            OptionCaption = 'X7-No viene identificado,X6-Sí esta identificado';
            OptionMembers = "X7-No viene identificado","X6-Sí esta identificado";
        }
        field(50178; "Nº Nota Debito"; Code[20])
        {
        }
        field(50202; "Enviado email preparación"; Boolean)
        {
        }
        field(50203; "Importe a cuenta"; Decimal)
        {
        }
        field(50205; "Puede retocar"; Boolean)
        {
        }
        field(50207; "Filtro ECI"; Code[10])
        {
        }
        field(50209; "No agrupar en ADAIA"; Boolean)
        {
        }
        field(50210; "Marcar para agrupar"; Boolean)
        {
        }
        field(50216; "Fecha envio pendiente stock"; Date)
        {
        }
        field(50217; Reembolso; Decimal)
        {
        }
        field(50218; "Importe optimo transporte"; Decimal)
        {
        }
        field(50219; "Cobra portes entre empresas"; Boolean)
        {
        }
        field(50220; Dropshipping; Boolean)
        {
            trigger OnValidate()
            var
                cust: Record customer;
            begin

                if Dropshipping = true then begin
                    "No Enviar albaran en exp." := true;
                    "No Enviar factura en exp." := true;
                    "No imprimir albaran valorado" := true;
                    "Albaran sin detalle" := false;
                    "No imprimir facturas" := true;
                end;

                if Dropshipping = false then begin
                    Cust.Get("Sell-to Customer No.");
                    "No Enviar factura en exp." := Cust."No Enviar factura en exp.";
                    "No Enviar albaran en exp." := Cust."No Enviar albaran en exp.";
                    "No imprimir albaran valorado" := Cust."No imprimir albaran valorado";
                    "Albaran sin detalle" := Cust."Albaran sin detalle";
                    "No imprimir facturas" := Cust."No imprimir facturas";
                end;
            end;
        }
        field(50221; "Nº expedición agrupada"; Code[10])
        {
        }
        field(50222; "Frecuencia visita comercial"; Code[10])
        {
            CalcFormula = lookup(Customer."Frecuencia visita comercial" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
            TableRelation = Multitabla.Codigo where(Tabla = const("Frecuencia visita"));
        }
        field(50223; "E-MAIL"; Text[80])
        {
        }
        field(50224; "Observación PDA"; Text[40])
        {
        }
        field(50225; "Recibido y facturado"; Boolean)
        {
        }
        field(50236; "Transferencia web"; Boolean)
        {
        }
        field(50237; "Pago Aceptado"; Boolean)
        {
        }
        field(50238; "Importe total pedido WEB"; Decimal)
        {
        }
        field(50245; "Nº expedición dropshp"; Code[10])
        {
        }
        field(50293; "NO MULTIPEDIDO"; Boolean)
        {
        }
        field(50294; "No agrupar en CANARIAS"; Boolean)
        {

            trigger OnValidate()
            begin
                /*
                IF "No agrupar en CANARIAS"=TRUE THEN BEGIN
                     "Bill-to Customer No.":="Sell-to Customer No.";
                     IF RecClie2.GET("Sell-to Customer No.") THEN BEGIN
                          "Bill-to Name":=RecClie2.Name;
                          "Bill-to Name 2":=RecClie2."Name 2";
                          "Bill-to Address":=RecClie2.Address;
                          "Bill-to Address 2":=RecClie2."Address 2";
                          "Bill-to City":=RecClie2.City;
                          "Bill-to Contact":=RecClie2.Contact;
                          "Bill-to Post Code":=RecClie2."Post Code";
                          "Bill-to County":=RecClie2.County;
                          "Bill-to Country/Region Code":=RecClie2."Country/Region Code";
                          "Shipping No. Series":='V-ALB';
                          MODIFY;
                     END;
                END;
                IF "No agrupar en CANARIAS"=FALSE THEN BEGIN
                     "Bill-to Customer No.":='6445';
                     IF RecClie2.GET('6445') THEN BEGIN
                          "Bill-to Name":=RecClie2.Name;
                          "Bill-to Name 2":=RecClie2."Name 2";
                          "Bill-to Address":=RecClie2.Address;
                          "Bill-to Address 2":=RecClie2."Address 2";
                          "Bill-to City":=RecClie2.City;
                          "Bill-to Contact":=RecClie2.Contact;
                          "Bill-to Post Code":=RecClie2."Post Code";
                          "Bill-to County":=RecClie2.County;
                          "Bill-to Country/Region Code":=RecClie2."Country/Region Code";
                          MODIFY;
                     END;
                
                END;
                */

            end;
        }
        field(50301; "Incrementa bultos"; Integer)
        {
        }
        field(50302; ClienteEnviadoAdaia; Boolean)
        {
        }
        
        field(50321; "EDI factueas enviar"; Boolean)
        {
        }
        field(50329; "Grupo clientes"; Code[10])
        {
            CalcFormula = lookup(Customer."Grupo clientes" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
            TableRelation = Multitabla.Codigo where(Tabla = const("Grupo de clientes"));
        }
        field(50363; "Multi-picking"; Boolean)
        {
        }
        field(50364; "Dpto.ECI"; Code[10])
        {
        }
        field(50365; "Discount%"; Decimal)
        {
            CalcFormula = lookup("Payment Terms"."Discount %" where(code = field("Payment Terms Code")));
            FieldClass = FlowField;



        }
        field(50367; TextoWebApi; Text[300])
        {
        }




        field(60000; "Id Pedido Presta Shop"; BigInteger)
        {
            Description = 'WEB';
        }
        field(60001; "Referencia Pedido Presta Shop"; Code[50])
        {
            Description = 'WEB';
        }
        field(60002; "Importe Descuento Presta Shop"; Decimal)
        {
            Description = 'WEB';
        }
        field(60003; "Notificar Pago"; Boolean)
        {
            Description = 'WEB';

            trigger OnValidate()
            begin
                /*
                IF "Notificar Pago" THEN BEGIN
                     RecLV.RESET;
                     RecLV.SETRANGE(RecLV."Document Type","Document Type");
                     RecLV.SETRANGE(RecLV."Document No.","No.");
                     IF RecLV.FINDFIRST THEN REPEAT
                          RecLV.Nonstock:=FALSE;
                          RecLV.MODIFY;
                     UNTIL RecLV.NEXT=0;
                END;
                
                IF NOT "Notificar Pago" THEN BEGIN
                     RecLV.RESET;
                     RecLV.SETRANGE(RecLV."Document Type","Document Type");
                     RecLV.SETRANGE(RecLV."Document No.","No.");
                     IF RecLV.FINDFIRST THEN REPEAT
                          RecLV.Nonstock:=TRUE;
                          RecLV.MODIFY;
                     UNTIL RecLV.NEXT=0;
                END;
                */

            end;
        }
        field(60004; "Notificar Envio"; Boolean)
        {
            Description = 'WEB';
        }
        field(60005; "Nº Factura Notificar Envio"; Code[20])
        {
            TableRelation = "Sales Invoice Header"."No." where("Bill-to Customer No." = field("Bill-to Customer No."));
        }
        field(60006; "Texto Descuento Presta Shop"; Text[50])
        {
        }
        field(60007; "Nº Albaran Notificar Envio"; Code[20])
        {
            TableRelation = "Sales Shipment Header"."No." where("Sell-to Customer No." = field("Sell-to Customer No."));
        }
        field(60008; "Factura EDI"; Boolean)
        {
        }
        field(60009; "Albarán EDI"; Boolean)
        {
        }
        field(50668; GLN; Code[13])
        {
            CalcFormula = lookup(Customer.GLN where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
        }
        field(50669; "Etq.Adaia"; Code[30])
        {
        }

    }

    keys
    {
        key(Key14; "Posting Date")
        {
        }
        key(Key15; "Estado pedido", "Super urgente", Urgente, "Fecha para preparar", "Hora para preparar")
        {
        }
        key(Key16; ClienteEnviadoAdaia)
        {
        }
    
    }

    fieldgroups
    {
        addlast(DropDown; "No.", "Sell-to Customer Name", "Sell-to Contact", "Amount Including VAT")
        { }
    }

    trigger OnAfterDelete()
    var
        Pedidosanulados: Record "Pedidos anulados";
    begin
        if not Pedidosanulados.Get("No.") then begin
            Pedidosanulados.Num_pedido := "No.";
            Pedidosanulados.Insert;
        end;
    end;

    trigger OnAfterInsert()
    begin
        "Usuario alta" := UserId;
        "Fecha alta" := Today;
        "Hora alta" := Time;

        if not GuiAllowed then begin
            "Permite fraccionar uni. venta" := true;
        end;
    end;


    procedure BuscaOptimo()
    var
        PESO: Decimal;
        VOL: Decimal;
        RecLV3: Record "Sales Line";
        pesoini: Decimal;
        IMPOP: Decimal;
        RecTrans: Record "Shipping Agent";
        PESCAL: array[5] of Decimal;
        LIN: Integer;
        codtrasopti: Code[10];
        RecCV: Record "Sales Header";
        codpedido: Code[10];
        PORVOL: array[99] of Decimal;
        IMPORTEPORTE: Decimal;
        RecCP: Record "Post Code";
        CODPROV: Code[10];
        IMPDHL: Decimal;
        Rectrap: Record "Tarifas Transportistas";
        Rectrap2: Record "Tarifas Transportistas";
        RecCfC: Record "General Ledger Setup";
        Rec36: Record "Sales Header";
        lineas: Integer;
        Rec83: Record "Item Journal Line";
        Rec362: Record "Sales Header";
        CODACTI: Code[20];
        Rec372: Record "Sales Line";
        RecProd: Record Item;
        RecLC1: Record "Sales Comment Line";
        RecLC2: Record "Sales Comment Line";
        Rec912: Record "User Setup";
        IMPTNT: Decimal;
        IMPCRONO: Decimal;
        IMPCORREO: Decimal;
        RecMT3: Record "Multitabla 3";
        SalesHeader: Record "Sales Header";
        RecMT4: Record "Multitabla 3";
        RecTras: Record "Shipping Agent";
        PRECIOOPTIO: Decimal;
        optimo: Text[30];
        pesol: Decimal;
        Rec89: Record "BOM Component";
    begin


        /*
        codpedido:="No.";
        
        
             Rec89.RESET;
             Rec89.SETRANGE(Rec89."Parent Item No.",codpedido);
             IF Rec89.FINDFIRST THEN REPEAT
                  Rec89.DELETE;
             UNTIL Rec89.NEXT=0;
        
        
             PESO:=0;
             VOL:=0;
        
             CLEAR(PORVOL);
             RecLV3.RESET;
             RecLV3.SETRANGE(RecLV3."Document Type",1);
             RecLV3.SETRANGE(RecLV3."Document No.",codpedido);
             IF RecLV3.FINDFIRST THEN REPEAT
                  PESO:=PESO+RecLV3."Gross Weight"*RecLV3.Quantity;
                  VOL:=VOL+RecLV3."Unit Volume"*RecLV3.Quantity;
             UNTIL RecLV3.NEXT=0;
             pesoini:=PESO;
             codtrasopti:='';
             IMPOP:=999999;
        
        
        
             RecTrans.RESET;
             IF RecTrans.FINDFIRST THEN REPEAT
                  IMPORTEPORTE:=0;
                  RecCP.RESET;
                  RecCP.SETRANGE(RecCP.Code,Rec."Ship-to Post Code");
                  IF RecCP.FINDFIRST THEN BEGIN
                       CODPROV:=RecCP."County Code";
                       PORVOL[1]:=VOL*RecTrans."Conversion Volumen/kilos";
                       pesol:=PESO;
                       IF PORVOL[1]>PESO THEN BEGIN
                            pesol:=PORVOL[1];
                       END;
                       PESCAL[1]:=0;
                       PRECIOOPTIO:=0;
                       RecMT3.RESET;
                       RecMT3.SETRANGE(RecMT3.Tabla,2);
                       RecMT3.SETRANGE(RecMT3."Transportista-Cliente",RecTrans.Code);
                       RecMT3.SETRANGE(RecMT3.Provincia,CODPROV);
                       IF RecMT3.FINDFIRST THEN BEGIN
                            RecMT3.RESET;
                            RecMT4.SETRANGE(RecMT4.Tabla,3);
                            RecMT4.SETRANGE(RecMT4."Transportista tarifa",RecTrans.Code);
                            RecMT4.SETRANGE(RecMT4."Zona tarifa",RecMT3."Zona transportistas-Cliente");
                            RecMT4.SETRANGE(RecMT4."Hasta Kilos",pesol,99999999);
                            IF RecMT4.FINDFIRST THEN BEGIN
                                PRECIOOPTIO:=RecMT4.Precio;
                                PESCAL[1]:=RecMT4."Hasta Kilos";
                            END;
                       END;
                       IF PORVOL[1]>0 THEN BEGIN
                            Rec89.INIT;
                            Rec89."Parent Item No.":=codpedido;
                            LIN:=LIN+10000;
                            Rec89."Line No.":=LIN;
                            Rec89."Cod. transportista":=RecTrans.Code;
                            Rec89.Pesos:=pesoini;
                            Rec89."Kilos/vol":=PORVOL[1];
                            Rec89."Kilos/tarifa":=PESCAL[1];
                            Rec89.Euros:=PRECIOOPTIO;
                            IF PRECIOOPTIO>0 THEN BEGIN
                                 IF IMPOP>PRECIOOPTIO THEN BEGIN
                                      codtrasopti:=RecTrans.Code;
                                      IMPOP:=PRECIOOPTIO;
                                 END;
                            END;
                            Rec89.INSERT;
                       END;
                  END;
             UNTIL RecTrans.NEXT=0;
             Rec89.RESET;
             Rec89.SETRANGE(Rec89."Parent Item No.",codpedido);
             IF Rec89.FINDFIRST THEN REPEAT
                  IF Rec89."Cod. transportista"=codtrasopti THEN BEGIN
                       Rec89.Optimo:=TRUE;
                       Rec89.MODIFY;
                  END;
             UNTIL Rec89.NEXT=0;
        
        
        
        
        
             IF Rec."Respeta agencia transporte"=FALSE THEN BEGIN
                  Rec89.RESET;
                  Rec89.SETRANGE(Rec89."Parent Item No.",codpedido);
                  Rec89.SETRANGE(Rec89.Optimo,TRUE);
                  IF Rec89.FINDFIRST THEN BEGIN
                       "Importe optimo transporte":=Rec89.Euros;
                       VALIDATE("Shipping Agent Code",Rec89."Cod. transportista");
                       MODIFY;
                  END;
             END;
        
        
        
        */



        codpedido := "No.";


        Rec89.Reset;
        Rec89.SetRange("Parent Item No.", codpedido);
        if Rec89.FindFirst then
            repeat
                Rec89.Delete;
            until Rec89.Next = 0;

        PESO := 0;
        VOL := 0;

        Clear(PORVOL);
        RecLV3.Reset;
        RecLV3.SetRange(RecLV3."Document Type", 1);
        RecLV3.SetRange(RecLV3."Document No.", codpedido);
        if RecLV3.FindFirst then
            repeat
                PESO := PESO + RecLV3."Gross Weight" * RecLV3.Quantity;
                VOL := VOL + RecLV3."Unit Volume" * RecLV3.Quantity;
            until RecLV3.Next = 0;
        pesoini := PESO;
        codtrasopti := '';
        IMPOP := 999999;


        RecCV.Get(1, codpedido);
        RecTrans.Reset;
        if RecTrans.FindFirst then
            repeat
                IMPORTEPORTE := 0;
                RecCP.Reset;
                RecCP.SetRange(RecCP.Code, RecCV."Ship-to Post Code");
                RecCP.SetRange(RecCP.City, RecCV."Ship-to City");
                if RecTrans.Paises <> '' then begin
                    RecCP.SetFilter("Country/Region Code", RecTrans.Paises + '*');
                end;
                if RecCP.FindFirst then begin
                    CODPROV := RecCP."County Code";
                    PORVOL[1] := VOL * RecTrans."Conversion Volumen/kilos";
                    pesol := PESO;
                    if PORVOL[1] > PESO then begin
                        pesol := PORVOL[1];
                    end;
                    PESCAL[1] := 0;
                    PRECIOOPTIO := 0;
                    RecMT3.Reset;
                    RecMT3.SetRange(RecMT3.Tabla, 2);
                    RecMT3.SetRange(RecMT3."Transportista-Cliente", RecTrans.Code);
                    RecMT3.SetRange(RecMT3.Provincia, CODPROV);
                    if RecMT3.FindFirst then begin
                        RecMT3.Reset;
                        RecMT4.SetRange(RecMT4.Tabla, 3);
                        RecMT4.SetRange(RecMT4."Transportista tarifa", RecTrans.Code);
                        RecMT4.SetRange(RecMT4."Zona tarifa", RecMT3."Zona transportistas-Cliente");
                        RecMT4.SetRange(RecMT4."Hasta Kilos", pesol, 99999999);
                        if RecMT4.FindFirst then begin
                            PRECIOOPTIO := RecMT4.Precio;
                            PESCAL[1] := RecMT4."Hasta Kilos";
                        end;
                    end;
                    if PORVOL[1] > 0 then begin
                        Rec89.Init;
                        Rec89."Parent Item No." := codpedido;
                        LIN := LIN + 10000;
                        Rec89."Line No." := LIN;
                        Rec89."Cod. transportista" := RecTrans.Code;
                        Rec89.Pesos := pesoini;
                        Rec89."Kilos/vol" := PORVOL[1];
                        Rec89."Kilos/tarifa" := PESCAL[1];
                        Rec89.Euros := PRECIOOPTIO;
                        if PRECIOOPTIO > 0 then begin
                            if IMPOP > PRECIOOPTIO then begin
                                codtrasopti := RecTrans.Code;
                                IMPOP := PRECIOOPTIO;
                            end;
                        end;
                        Rec89.Insert;
                    end;
                end;
            until RecTrans.Next = 0;
        Rec89.Reset;
        Rec89.SetRange("Parent Item No.", codpedido);
        if Rec89.FindFirst then
            repeat
                if Rec89."Cod. transportista" = codtrasopti then begin
                    Rec89.Optimo := true;
                    Rec89.Modify;
                end;
            until Rec89.Next = 0;


        if Rec."Respeta agencia transporte" = false then begin
            Rec89.Reset;
            Rec89.SetRange(Rec89."Parent Item No.", codpedido);
            Rec89.SetRange(Rec89.Optimo, true);
            if Rec89.FindFirst then begin
                "Importe optimo transporte" := Rec89.Euros;
                Validate("Shipping Agent Code", Rec89."Cod. transportista");
                Modify;
            end;
        end;

    end;

    procedure ChequeoFechaVtos()
    var
        cust: Record Customer;
        RecIE: Record "Company Information";
        RecCVP: Record "Sales & Receivables Setup";
        Fechavto: date;
        SEPASA: Boolean;
        Rec21: Record "Cust. Ledger Entry";
    begin



        Cust.Get("Sell-to Customer No.");
        if Cust."Permite seguir adelante" = false then begin

            RecIE.Get;

            ///// IF COPYSTR(RecIE.Name,1,4)='PEPE' THEN BEGIN
            ///if "Usuario alta" <> 'USERNWS' then begin
            if CopyStr("No.", 3, 3) <> 'B2B' then begin


                RecCVP.Get;
                Fechavto := 0D;
                SEPASA := false;
                Rec21.Reset;
                Rec21.SetCurrentkey("Customer No.", Open, Positive, "Due Date", "Currency Code");
                Rec21.SetRange(Rec21."Customer No.", "Sell-to Customer No.");
                Rec21.SetRange(Rec21.Positive, true);
                Rec21.SetRange(Rec21.Open, true);
                if Rec21.FindFirst then begin
                    Fechavto := Rec21."Due Date";
                    if Today - Fechavto > (RecCVP."Dias aviso falta pago" + Cust."Dias tolerancias fecha vto.") then begin
                        SEPASA := true;
                    end;
                end;

                if SEPASA then begin
                    if CopyStr("No.", 3, 3) <> 'B2B' then begin
                        Error('El cliente %1 esta bloqueado por exceso en dias %2 %3 de pago. ', "Sell-to Customer No.", Fechavto, RecCVP."Dias aviso falta pago" + Cust."Dias tolerancias fecha vto.");
                    END;
                end;


            end;
        end;
    end;




}
