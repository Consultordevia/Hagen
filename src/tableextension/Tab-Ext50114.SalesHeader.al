tableextension 50114 SalesHeader extends "Sales Header"
{
    // VER  cesta compra
    fields
    {
        field(50000; "Estado pedido"; Option)
        {
            OptionCaption = 'Retenido,Para preparar,Pdte. comercial,Servido,Pendiente stock';
            OptionMembers = Retenido,"Para preparar","Pdte. comercial",Servido,"Pendiente stock";
        }
        field(50003; "Usuario alta"; Code[30])
        {
            Editable = false;
        }
        field(50004; "Fecha alta"; Date)
        {
            Editable = false;
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
        field(50034; "Observación para transporte"; Text[60])
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

    }


}
