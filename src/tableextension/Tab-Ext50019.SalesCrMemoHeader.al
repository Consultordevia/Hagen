tableextension 50019 SalesCrMemoHeader extends "Sales Cr.Memo Header"
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
        field(50011; Preparador; Code[10])
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
        field(50035; "Permite multiplos distintos"; Boolean)
        {
        }
        field(50044; "No Enviar factura en exp."; Boolean)
        {
        }
        field(50045; "No Enviar albaran en exp."; Boolean)
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
        field(50053; "Pedido WEB"; Boolean)
        {
        }
        field(50076; "No imprimir facturas"; Boolean)
        {
        }
        field(50100; "Importe coste Real"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50178; "Nº Nota Debito"; Code[20])
        {
        }
        field(50200; "Logo cabecera"; Blob)
        {
        }
        field(50245; "Nº expedición dropshp"; Code[10])
        {
        }
        field(50280; "Tipo rectificativa"; Option)
        {
            OptionCaption = ' ,Sustitucion,Diferencia';
            OptionMembers = " ",Sustitucion,Diferencia;
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
        field(50329; "Grupo clientes"; Code[10])
        {
            CalcFormula = lookup(Customer."Grupo clientes" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
            TableRelation = Multitabla.Codigo where(Tabla = const("Grupo de clientes"));
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
        field(50662; "Nº factura rectificativa"; Code[20])
        {
        }
        field(50663; "Fecha fact. rectifi."; Date)
        {
        }
        field(60000; "Id Pedido Presta Shop"; BigInteger)
        {
        }
        field(60001; "Referencia Pedido Presta Shop"; Code[50])
        {
        }
    }
}
