tableextension 50017 SalesShipmentHeader extends "Sales Shipment Header"
{
    fields
    {
        field(50000; "Estado pedido"; Option)
        {
            OptionMembers = Retenido,Activo;
        }
        field(50001; "Ofertas calculadas"; Boolean)
        {
            Editable = false;
        }
        field(50002; "Dto% cabecera"; Decimal)
        {
            Editable = false;
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
        field(50006; "Nº pedido obligatorio"; Boolean)
        {
        }
        field(50007; "Base Pdte."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Base Pdte.';
            Editable = false;
        }
        field(50008; Base; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Base';
            Editable = false;
        }
        field(50009; "Super urgente"; Boolean)
        {
        }
        field(50010; Actividad; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(Actividades));
        }
        field(50011; Preparador; Code[20])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(Preparadores));
        }
        field(50012; Urgente; Boolean)
        {
        }
        field(50013; "Nº copias solicitud trabajo"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(50014; "Nº bultos"; Decimal)
        {

            trigger OnValidate()
            begin
                /////"Total bultos":="Nº bultos"+"Nº Palets";
            end;
        }
        field(50015; "Nº Palets"; Decimal)
        {

            trigger OnValidate()
            begin
                /////"Total bultos":="Nº bultos"+"Nº Palets";
            end;
        }
        field(50016; "Total bultos"; Decimal)
        {
        }
        field(50017; "Anula restos"; Boolean)
        {
        }
        field(50018; "Usuario activo"; Code[25])
        {
            Editable = false;
        }
        field(50019; "Fecha activo"; Date)
        {
            Editable = false;
        }
        field(50020; "Hora activo"; Time)
        {
            Editable = false;
        }
        field(50023; "No incluir portes"; Boolean)
        {
        }
        field(50024; "No imprimir albaran valorado"; Boolean)
        {
        }
        field(50025; "nuloAlbaran valorado"; Boolean)
        {
        }
        field(50027; "Total peso"; Decimal)
        {
        }
        field(50028; Volumen; Decimal)
        {
        }
        field(50030; "nuloAlbaran sin detalle"; Boolean)
        {
        }
        field(50033; "Nº lineas"; Integer)
        {
            CalcFormula = count("Sales Shipment Line" where("Document No." = field("No."),
                                                             Type = const(Item),
                                                             Quantity = filter(<> 0)));
            FieldClass = FlowField;
        }
        field(50034; "Observación para transporte"; Text[60])
        {
        }
        field(50035; "Permite multiplos distintos"; Boolean)
        {
        }
        field(50041; "Nº expedición"; Code[20])
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
        field(50062; "Tipo facturación"; Option)
        {
            OptionMembers = Diaria,Semanal,Mensual;
        }
        field(50063; "No Agrupar en facturas"; Boolean)
        {
        }
        field(50064; "Respeta Tipo facturacion"; Boolean)
        {
        }
        field(50070; "Pasar a Canarias"; Boolean)
        {
        }
        field(50071; "Pasada a Canarias"; Boolean)
        {
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
        field(50100; "Albaran facturado"; Boolean)
        {
        }
        field(50101; "Importe albaran"; Decimal)
        {
            CalcFormula = sum("Sales Shipment Line"."Item Charge Base Amount" where("Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50102; Historificado; Boolean)
        {
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
        field(50195; "Importe transporte"; Decimal)
        {
        }
        field(50196; "Hora enviado"; Time)
        {
        }
        field(50197; "Fecha enviado"; Date)
        {
        }
        field(50198; "Email enviado"; Boolean)
        {
        }
        field(50199; "Enviar email"; Boolean)
        {
        }
        field(50200; "Logo cabecera"; Blob)
        {
        }
        field(50211; "Hora enviado sin detalle"; Time)
        {
        }
        field(50212; "Fecha enviado sin detalle"; Date)
        {
        }
        field(50213; "Email enviado sin detalle"; Boolean)
        {
        }
        field(50214; "Enviar email sin detalle"; Boolean)
        {
        }
        field(50215; "Imprime eti. envio"; Boolean)
        {
        }
        field(50217; Reembolso; Decimal)
        {
        }
        field(50218; "Importe optimo transporte"; Decimal)
        {
        }
        field(50220; Dropshipping; Boolean)
        {
        }
        field(50221; "Nº expedición agrupada"; Code[20])
        {
        }
        field(50223; "E-MAIL"; Text[80])
        {
        }
        field(50228; "Importe total pedido WEB"; Decimal)
        {
        }
        field(50231; "CSV Fecha enviado"; DateTime)
        {
        }
        field(50232; "CSV enviado"; Boolean)
        {
        }
        field(50233; "CSV Enviar"; Boolean)
        {
        }
        field(50239; "Servir sabado"; Boolean)
        {
        }
        field(50240; "Importe seguro envio"; Decimal)
        {
        }
        field(50241; "CSV enviado catit"; Boolean)
        {
        }
        field(50245; "Nº expedición dropshp"; Code[20])
        {
        }
        field(50246; "Aviso falta stock"; Boolean)
        {
        }
        field(50247; "Fecha aviso falta stock"; DateTime)
        {
        }
        field(50250; "Enviado fichero"; Boolean)
        {
        }
        field(50251; "Estado Expedicion"; Code[100])
        {
        }
        field(50252; "Fecha envio"; Date)
        {
        }
        field(50253; "Fecha entrega"; Date)
        {
        }
        field(50254; "Hora entrega"; Code[20])
        {
        }
        field(50255; "Numero segumiento"; Code[20])
        {
        }
        field(50256; "Total horas"; Decimal)
        {
        }
        field(50295; "Marcar para listado carga"; Boolean)
        {
            trigger OnValidate()
            begin
                if xRec."Marcar para listado carga" = false then begin
                    rEC1103.Reset;
                    rEC1103.SetCurrentkey(rEC1103."Posting Date", rEC1103."Shipping Agent Code");
                    rEC1103.SetRange(rEC1103."Posting Date", "Posting Date");
                    rEC1103.SetRange(rEC1103."Shipping Agent Code", "Shipping Agent Code");
                    if rEC1103.FindFirst then
                        repeat
                            if rEC1103."No." <> "No." then begin
                                rEC1103."Marcar para listado carga" := true;
                                rEC1103.Modify;
                            end;
                        until rEC1103.Next = 0;

                end;
            end;
        }
        field(50301; "Incrementa bultos"; Integer)
        {
        }
        field(50309; "Enlace transporte"; Text[250])
        {
        }
        field(50310; "Enlace transporte 2"; Text[250])
        {
        }
        field(50311; "Enlace transporte 3"; Text[230])
        {
        }
        field(50329; "Grupo clientes"; Code[10])
        {
            CalcFormula = lookup(Customer."Grupo clientes" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
            TableRelation = Multitabla.Codigo where(Tabla = const("Grupo de clientes"));
        }
        field(50360; "Cantidad enviada"; Decimal)
        {
            CalcFormula = sum("Sales Shipment Line".Quantity where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50361; "Cantidad facturada"; Decimal)
        {
            CalcFormula = sum("Sales Shipment Line"."Quantity Invoiced" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50362; "Cantidad enviada no facturada"; Decimal)
        {
            CalcFormula = sum("Sales Shipment Line"."Qty. Shipped Not Invoiced" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50363; "Multi-picking"; Boolean)
        {
        }
        field(50364; "Dpto.ECI"; Code[10])
        {
        }
        field(50365; "Enviado pdf web"; Boolean)
        {
        }
        field(50366; Num_lineas; Integer)
        {
        }
        field(60000; "Id Pedido Presta Shop"; BigInteger)
        {
        }
        field(60001; "Referencia Pedido Presta Shop"; Code[50])
        {
        }
        field(50669; "Etq.Adaia"; Code[30])
        {            
        }
    }

    keys
    {
        key(Key50005; "Posting Date", "Shipping Agent Code", "No.")
        {
        }
        key(Key50006; "Salesperson Code", "Posting Date")
        {
        }
        //key(Key50007;"Shipping Agent Code","Posting Date","Nº expedición")
        //{
        //}
        key(Key50008; "Aviso falta stock")
        {
        }
        
    }

    fieldgroups
    {
        addlast(DropDown;
        "Nº expedición")
        { }
    }
    var
        rEC1103: Record "Sales Shipment Header";

    trigger OnBeforeDelete()
    begin
        Error('Error, no se puede borrar');
    end;
}
