tableextension 50002 SalesInvoiceHeader extends "Sales Invoice Header"
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
        field(50010; Actividad; Code[1])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(Actividades));
        }
        field(50011; Preparador; Code[20])
        {
            TableRelation = User;
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
        }
        field(50015; "Nº Palets"; Decimal)
        {
        }
        field(50016; "Total bultos"; Decimal)
        {
        }
        field(50017; "Anula restos"; Boolean)
        {
        }
        field(50018; "Usuario activo"; Code[30])
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
        field(50024; "No imprimir albaran valorado"; Boolean)
        {
        }
        field(50027; "Total peso"; Decimal)
        {
        }
        field(50028; Volumen; Decimal)
        {
        }
        field(50034; "Observación para transporte"; Text[60])
        {
        }
        field(50035; "Permite multiplos distintos"; Boolean)
        {
        }
        field(50041; "Nº expedición"; Code[10])
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
        field(50050; vende; Code[20])
        {
            CalcFormula = lookup(Customer."Salesperson Code" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
        }
        field(50052; "VENDE DIR ENVIO"; Code[10])
        {
            //CalcFormula = lookup("Ship-to Address".Field19876728 where("Customer No." = field("Sell-to Customer No."),
            //                                                          Code = field("Ship-to Code")));
            FieldClass = FlowField;
        }
        field(50053; "Pedido WEB"; Boolean)
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
        field(50072; "Excluir SII"; Boolean)
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
        field(50100; "Importe coste Real"; Decimal)
        {
            CalcFormula = - sum("Value Entry"."Cost Amount (Actual)" where("Document No." = field("No.")));
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
        field(50201; "TIENE LINEAS"; Boolean)
        {
            CalcFormula = exist("Sales Invoice Line" where("Document No." = field("No.")));
            FieldClass = FlowField;
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
        field(50221; "Nº expedición agrupada"; Code[10])
        {
        }
        field(50223; "E-MAIL"; Text[80])
        {
        }
        field(50228; "Importe total pedido WEB"; Decimal)
        {
        }
        field(50229; Diferente; Boolean)
        {
        }
        field(50230; "Llevatelo a la WEB"; Boolean)
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
        field(50245; "Nº expedición dropshp"; Code[10])
        {
        }
        field(50305; "Tipo cliente"; Boolean)
        {
            CalcFormula = lookup(Customer."No enviar excel" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
            TableRelation = Multitabla.Codigo where(Tabla = const("Tipo cliente"));
        }
        field(50306; "Tipo facturación 2"; Option)
        {
            CalcFormula = lookup(Customer."Tipo facturación" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
            OptionMembers = Diaria,Semanal,Mensual;
        }
        field(50309; "Enlace transporte"; Text[250])
        {
        }
        field(50310; "Enlace transporte 2"; Text[250])
        {
        }
        field(50311; "Enlace transporte 3"; Text[180])
        {
        }
        field(50320; "EDI Facturas Fecha enviado"; DateTime)
        {
        }
        field(50321; "EDI factueas enviar"; Boolean)
        {
        }
        field(50322; "EDI factueas enviado"; Boolean)
        {
        }
        field(50323; "EDI Albaran Fecha enviado"; DateTime)
        {
        }
        field(50324; "EDI Albaran enviar"; Boolean)
        {
        }
        field(50325; "EDI Albaran enviado"; Boolean)
        {
        }
        field(50326; "EDI Palets"; Integer)
        {
        }
        field(50329; "Grupo clientes"; Code[10])
        {
            CalcFormula = lookup(Customer."Grupo clientes" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
            TableRelation = Multitabla.Codigo where(Tabla = const("Grupo de clientes"));
        }
        field(50364; "Dpto.ECI"; Code[10])
        {
        }
        field(50365; "Enviado pdf web"; Boolean)
        {
        }
        field(50660; "Referencia catastral"; Text[25])
        {
        }
        field(50661; "Situación inmueble"; Option)
        {
            OptionCaption = ' ,1-con referencia catastral,2-con referencia catastral Pais Vasco y Navarra,3-sin referencia catastral,4-en el extranjero';
            OptionMembers = " ","1-con referencia catastral","2-con referencia catastral Pais Vasco y Navarra","3-sin referencia catastral","4-en el extranjero";
        }
        field(60000; "Id Pedido Presta Shop"; BigInteger)
        {
        }
        field(60001; "Referencia Pedido Presta Shop"; Code[50])
        {
        }
    }
}
