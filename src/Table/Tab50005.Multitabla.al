#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50005 Multitabla
{
    //DrillDownPageID = UnknownPage50054;
    //LookupPageID = UnknownPage50054;

    fields
    {
        field(1; Tabla; Option)
        {
            OptionCaption = 'Actividades,Caracteres,Resultado,Ruta de reparto,Zona de ventas,Grupo de clientes,Tipo cliente,Descripción incidencia,Causa incidencia,Corrección incidencia,Marca competencia,Distribuidor competencia,Zona competencia,Frecuencia visita,Preparadores,Comunidades autonomas,Dimensión hueco,Ubicaciones,Grupo dto. cabecera,Responsable incidencia,Resultado incidencia,Morivo devol,Estadistica,Grupo descuento mensual,Marcas,Categoria,Actividades nuevas,Clasificacion WEB,MAPA,TipoPalet,lp,GV,BIC,LT,TN,ME,EE,Esca,aa,igic,Ruta comercial,WebComoCono,WebGradoInt,WebMarca,WGI1,WGI2,WGI3,WGI4,WGI5,WGI6,WGI7,SII,SII2,Variante';
            OptionMembers = Actividades,Caracteres,Resultado,"Ruta de reparto","Zona de ventas","Grupo de clientes","Tipo cliente","Descripción incidencia","Causa incidencia","Corrección incidencia","Marca competencia","Distribuidor competencia","Zona competencia","Frecuencia visita",Preparadores,"Comunidades autonomas","Dimensión hueco",Ubicaciones,"Grupo dto. cabecera","Responsable incidencia","Resultado incidencia","Morivo devol",Estadistica,"Grupo descuento mensual",Marcas,Categoria,"Actividades nuevas","Clasificacion WEB",MAPA,TipoPalet,lp,GV,BIC,LT,TN,ME,EE,Esca,aa,igic,"Ruta comercial",WebComoCono,WebGradoInt,WebMarca,WGI1,WGI2,WGI3,WGI4,WGI5,WGI6,WGI7,SII,SII2,Variante;
        }
        field(2; "Codigo"; Code[10])
        {
        }
        field(3; "Descripcion"; Text[50])
        {
        }
        field(4; Ok; Boolean)
        {
        }
        field(5; Producto; Code[20])
        {
        }
        field(6; Ubicacion; Code[20])
        {
        }
        field(7; Cantidad; Decimal)
        {

            trigger OnValidate()
            begin
                CalculaFechaCaducidad;
            end;
        }
        field(8; "Cód. provincia"; Code[10])
        {
            TableRelation = Area;
        }
        field(9; "Descripcion provincia"; Text[50])
        {
            CalcFormula = lookup(Area.Text where(Code = field("Cód. provincia")));
            FieldClass = FlowField;
        }
        field(10; Observaciones; Text[30])
        {
        }
        field(11; ALMACENABLE; Boolean)
        {
            CalcFormula = lookup(Item."Producto almacenable" where("No." = field(Codigo)));
            FieldClass = FlowField;
        }
        field(12; "Cantidad venta"; Decimal)
        {
        }
        field(13; "Importe venta"; Decimal)
        {
        }
        field(14; DESDE; Date)
        {
        }
        field(15; "Importe dto 1"; Decimal)
        {
        }
        field(16; "Dto 1"; Decimal)
        {
        }
        field(17; "Importe dto 2"; Decimal)
        {
        }
        field(18; "Dto 2"; Decimal)
        {
        }
        field(19; "Importe dto 3"; Decimal)
        {
        }
        field(20; "Dto 3"; Decimal)
        {
        }
        field(21; "Importe dto 4"; Decimal)
        {
        }
        field(22; "Dto 4"; Decimal)
        {
        }
        field(23; "Codigo madre"; Code[20])
        {
        }
        field(24; "Descripción madre"; Text[50])
        {
        }
        field(25; "Fecha caducidad"; Date)
        {
        }
        field(26; Lote; Code[30])
        {
        }
        field(50000; Orden; Integer)
        {
        }
        field(50001; "ID WEB"; Integer)
        {
        }
        field(50002; "Valor Dynamics Crm"; Integer)
        {
        }
        field(50003; Vendedor; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(50100; "Nº pedido"; Code[20])
        {
        }
        field(50101; linea; Integer)
        {
        }
        field(50200; "Tipo comunicación"; Option)
        {
            OptionMembers = Alta,Modificacion,Baja;
        }
        field(50201; "Tipo registro"; Option)
        {
            OptionMembers = Documento,Pago,"Operación en metálico","Bienes de Inversión","Otras operaciones intracomunitarias","Operaciones de seguros";

            trigger OnValidate()
            begin
                /*
                IF "Tipo registro"="Tipo registro"::"Operaciones de seguros" THEN
                  IF "Tipo documento"="Tipo documento"::"Abono compra" THEN
                    "Clave operación":="Clave operación"::"12-Local sin retencion"
                  ELSE
                    "Clave operación":="Clave operación"::"14-IVA pdte Certif.Obra AAPP";
                    */

            end;
        }
        field(50202; "Tipo documento"; Option)
        {
            OptionMembers = " ","Factura compra","Abono compra","Factura venta","Abono venta";
        }
        field(50203; "Serie documento"; Code[10])
        {
        }
        field(50204; "No. documento"; Code[20])
        {
        }
        field(50205; "Fecha documento"; Date)
        {
        }
        field(50206; "No. documento pago"; Code[20])
        {
        }
        field(50207; "Fecha registro"; Date)
        {
        }
        field(50208; "No. doc. externo"; Code[20])
        {
        }
        field(50209; "Tipo factura"; Option)
        {
            OptionMembers = " ",Factura,Simplificada,Rectificativa,Resumen;
        }
        field(50210; "No. factura rectificada"; Code[20])
        {
        }
        field(50211; "Fecha factura rectificada"; Date)
        {
        }
        field(50212; "Clave operación"; Option)
        {
            OptionMembers = "01-Regimen común","02-Exportacion","03-Arte","04-Oro","05-Viajes","06-Especial Avanzado","07-Caja","08-IPSI/IGIC","09-Mediador viajes","10-cobros de terceros","11-Local con retencion","12-Local sin retencion","13-Local sin/con retencion","14-IVA pdte Certif.Obra AAPP","15-IVA pdte Tracto sucesivo";
        }
        field(50213; "Situación inmueble"; Option)
        {
            OptionMembers = " ","1-con referencia catastral","2-con referencia catastral Pais Vasco y Navarra","3-sin referencia catastral","4-en el extranjero";
        }
        field(50214; "Referencia catastral"; Text[25])
        {
        }
        field(50215; "Tipo factura expedida"; Option)
        {
            OptionMembers = "Entrega bienes","Prestación servicio";
        }
        field(50216; "Registro anulado"; Boolean)
        {
        }
        field(50217; "Estado envío"; Option)
        {
            OptionMembers = Pendiente,"Enviado OK","Enviado con errores";
        }
        field(50218; "Bloquear envío"; Boolean)
        {
        }
        field(50219; "Importe cobrado"; Decimal)
        {
        }
        field(50220; "IBAN cobro"; Text[34])
        {
        }
        field(50221; "Medio cobro"; Option)
        {
            OptionMembers = " ",Transferencia,Cheque,"No se paga",Otro;
        }
        field(50222; "Ultima fecha envío"; DateTime)
        {
        }
        field(50223; "Ultimo resultado envío"; Option)
        {
            OptionMembers = Aceptada,Rechazada,"Aceptada con errores";
        }
        field(50224; "Ultimo motivo rechazo"; Text[250])
        {
        }
        field(50225; "Ultimo CSV"; Text[1])
        {
        }
        field(50226; "Fecha creación"; DateTime)
        {
        }
        field(50227; "Identificación bien"; Text[40])
        {
        }
        field(50228; "Fecha Inicio utilización"; Date)
        {
        }
        field(50229; "Prorrata anual definitiva"; Decimal)
        {
        }
        field(50230; "Regul. anual deducción"; Decimal)
        {
        }
        field(50231; "Identificación entrega"; Text[40])
        {
        }
        field(50232; "Regul. deducción efectuada"; Decimal)
        {
        }
        field(50233; "Tipo operacion intracomu"; Option)
        {
            OptionMembers = " ",A,B;
        }
        field(50234; "Clave declarado"; Option)
        {
            OptionMembers = " ",D,R;
        }
        field(50235; "Estado miembro"; Text[2])
        {
        }
        field(50236; "Plazo operación"; Integer)
        {
        }
        field(50237; "Descripción bienes"; Text[40])
        {
        }
        field(50238; "Dirección operador"; Text[120])
        {
        }
        field(50239; "Facturas o documentación"; Text[150])
        {
        }
        field(50240; Contraparte; Code[20])
        {
        }
        field(50241; "Importe Base IVA"; Decimal)
        {
        }
        field(50242; "Importe IVA"; Decimal)
        {
        }
        field(50243; "Tipo rectificativa"; Option)
        {
            OptionMembers = " ",Sustitucion,Diferencia;
        }
        field(50300; "No. mov."; Integer)
        {
        }
        field(50301; "No. mov. registro IVA"; Integer)
        {
        }
        field(50302; "Tipo envío"; Option)
        {
            OptionMembers = Alta,Modificacion,Baja;
        }
        field(50303; "Fecha envío"; DateTime)
        {
        }
        field(50304; "Resultado envío"; Option)
        {
            OptionMembers = Aceptada,Rechazada,"Aceptada con errores";
        }
        field(50305; "Código error"; Text[5])
        {
        }
        field(50306; "Motivo rechazo"; Text[250])
        {
        }
        field(50307; CSV; Text[14])
        {
        }
        field(50308; Usuario; Code[30])
        {
        }
        field(60000; "Actualizar WEB"; Boolean)
        {
        }
        field(60001; Largo; Decimal)
        {
        }
        field(60002; Ancho; Decimal)
        {
        }
        field(60003; Alto; Decimal)
        {
        }
        field(60004; Multiplicador; Decimal)
        {
        }
        field(60005; "Grupo iva prod"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(60006; "iva igic"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(60007; "id prestashop"; Integer)
        {
        }
        field(60008; "Factura EDI"; Boolean)
        {
        }
        field(60009; "Albarán EDI"; Boolean)
        {
        }
        field(60010; "Orden EDI"; Boolean)
        {
        }
        field(60011; "Inventario EDI"; Boolean)
        {
        }
        field(60012; ">6 meses"; Integer)
        {
        }
        field(60013; "6 a 9 meses"; Integer)
        {
        }
        field(60014; "9 a 12 meses"; Integer)
        {
        }
        field(60015; "12 a 18 meses"; Integer)
        {
        }
        field(60016; "mas de 18 meses"; Integer)
        {
        }
        field(60017; "<6 meses"; Integer)
        {
        }
        field(60018; ">7 meses"; Integer)
        {
        }
        field(60019; ">8 meses a 9 meses"; Integer)
        {
        }
        field(60020; "EDICON Grupo Sonae"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Tabla, "Codigo")
        {
            Clustered = true;
        }
        key(Key2; Tabla, "Descripcion")
        {
        }
        key(Key3; Producto)
        {
        }
        key(Key4; Tabla, Ubicacion)
        {
        }
        key(Key5; Tabla, Orden)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Codigo", "Descripcion")
        {
        }
        fieldgroup(Brick; "Codigo", "Descripcion")
        {
        }
    }

    var
        DIFDIAS: Integer;

    local procedure CalculaFechaCaducidad()
    begin


        DIFDIAS := "Fecha caducidad" - Today;
        if DIFDIAS <> 0 then begin
            if (DIFDIAS / 30) < 6 then begin
                "<6 meses" := "<6 meses" + Cantidad;
            end;
            if ((DIFDIAS / 30) >= 6) and ((DIFDIAS / 30) < 7) then begin
                ">6 meses" := ">6 meses" + Cantidad;
            end;
            if ((DIFDIAS / 30) >= 7) and ((DIFDIAS / 30) < 8) then begin
                ">7 meses" := ">7 meses" + Cantidad;
            end;
            if ((DIFDIAS / 30) >= 8) and ((DIFDIAS / 30) < 9) then begin
                ">8 meses a 9 meses" := ">8 meses a 9 meses" + Cantidad;
            end;
            if ((DIFDIAS / 30) >= 9) and ((DIFDIAS / 30) < 12) then begin
                "9 a 12 meses" := "9 a 12 meses" + Cantidad;
            end;
            if ((DIFDIAS / 30) >= 12) and ((DIFDIAS / 30) < 18) then begin
                "12 a 18 meses" := "12 a 18 meses" + Cantidad;
            end;
            if (DIFDIAS / 30) >= 18 then begin
                "mas de 18 meses" := "mas de 18 meses" + Cantidad;
            end;

        end;
    end;
}

