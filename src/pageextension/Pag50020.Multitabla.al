page 50020 Multitabla
{
    ApplicationArea = All;
    Caption = 'Multitabla';
    PageType = List;
    SourceTable = Multitabla;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Tabla; Rec.Tabla)
                {
                    ToolTip = 'Specifies the value of the Tabla field.', Comment = '%';
                }
                field("Código"; Rec."Código")
                {
                    ToolTip = 'Specifies the value of the Código field.', Comment = '%';
                }

                field("12 a 18 meses"; Rec."12 a 18 meses")
                {
                    ToolTip = 'Specifies the value of the 12 a 18 meses field.', Comment = '%';
                }
                field("6 a 9 meses"; Rec."6 a 9 meses")
                {
                    ToolTip = 'Specifies the value of the 6 a 9 meses field.', Comment = '%';
                }
                field("9 a 12 meses"; Rec."9 a 12 meses")
                {
                    ToolTip = 'Specifies the value of the 9 a 12 meses field.', Comment = '%';
                }
                field("<6 meses"; Rec."<6 meses")
                {
                    ToolTip = 'Specifies the value of the <6 meses field.', Comment = '%';
                }
                field(">6 meses"; Rec.">6 meses")
                {
                    ToolTip = 'Specifies the value of the >6 meses field.', Comment = '%';
                }
                field(">7 meses"; Rec.">7 meses")
                {
                    ToolTip = 'Specifies the value of the >7 meses field.', Comment = '%';
                }
                field(">8 meses a 9 meses"; Rec.">8 meses a 9 meses")
                {
                    ToolTip = 'Specifies the value of the >8 meses a 9 meses field.', Comment = '%';
                }
                field(ALMACENABLE; Rec.ALMACENABLE)
                {
                    ToolTip = 'Specifies the value of the ALMACENABLE field.', Comment = '%';
                }
                field("Actualizar WEB"; Rec."Actualizar WEB")
                {
                    ToolTip = 'Specifies the value of the Actualizar WEB field.', Comment = '%';
                }
                field("Albarán EDI"; Rec."Albarán EDI")
                {
                    ToolTip = 'Specifies the value of the Albarán EDI field.', Comment = '%';
                }
                field(Alto; Rec.Alto)
                {
                    ToolTip = 'Specifies the value of the Alto field.', Comment = '%';
                }
                field(Ancho; Rec.Ancho)
                {
                    ToolTip = 'Specifies the value of the Ancho field.', Comment = '%';
                }
                field("Bloquear envío"; Rec."Bloquear envío")
                {
                    ToolTip = 'Specifies the value of the Bloquear envío field.', Comment = '%';
                }
                field(CSV; Rec.CSV)
                {
                    ToolTip = 'Specifies the value of the CSV field.', Comment = '%';
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ToolTip = 'Specifies the value of the Cantidad field.', Comment = '%';
                }
                field("Cantidad venta"; Rec."Cantidad venta")
                {
                    ToolTip = 'Specifies the value of the Cantidad venta field.', Comment = '%';
                }
                field("Clave declarado"; Rec."Clave declarado")
                {
                    ToolTip = 'Specifies the value of the Clave declarado field.', Comment = '%';
                }
                field("Clave operación"; Rec."Clave operación")
                {
                    ToolTip = 'Specifies the value of the Clave operación field.', Comment = '%';
                }
                field("Codigo madre"; Rec."Codigo madre")
                {
                    ToolTip = 'Specifies the value of the Codigo madre field.', Comment = '%';
                }
                field(Contraparte; Rec.Contraparte)
                {
                    ToolTip = 'Specifies the value of the Contraparte field.', Comment = '%';
                }
                field("Cód. provincia"; Rec."Cód. provincia")
                {
                    ToolTip = 'Specifies the value of the Cód. provincia field.', Comment = '%';
                }
                field("Código error"; Rec."Código error")
                {
                    ToolTip = 'Specifies the value of the Código error field.', Comment = '%';
                }
                field(DESDE; Rec.DESDE)
                {
                    ToolTip = 'Specifies the value of the DESDE field.', Comment = '%';
                }
                field("Descripcion provincia"; Rec."Descripcion provincia")
                {
                    ToolTip = 'Specifies the value of the Descripcion provincia field.', Comment = '%';
                }
                field("Descripción"; Rec."Descripción")
                {
                    ToolTip = 'Specifies the value of the Descripción field.', Comment = '%';
                }
                field("Descripción bienes"; Rec."Descripción bienes")
                {
                    ToolTip = 'Specifies the value of the Descripción bienes field.', Comment = '%';
                }
                field("Descripción madre"; Rec."Descripción madre")
                {
                    ToolTip = 'Specifies the value of the Descripción madre field.', Comment = '%';
                }
                field("Dirección operador"; Rec."Dirección operador")
                {
                    ToolTip = 'Specifies the value of the Dirección operador field.', Comment = '%';
                }
                field("Dto 1"; Rec."Dto 1")
                {
                    ToolTip = 'Specifies the value of the Dto 1 field.', Comment = '%';
                }
                field("Dto 2"; Rec."Dto 2")
                {
                    ToolTip = 'Specifies the value of the Dto 2 field.', Comment = '%';
                }
                field("Dto 3"; Rec."Dto 3")
                {
                    ToolTip = 'Specifies the value of the Dto 3 field.', Comment = '%';
                }
                field("Dto 4"; Rec."Dto 4")
                {
                    ToolTip = 'Specifies the value of the Dto 4 field.', Comment = '%';
                }
                field("EDICON Grupo Sonae"; Rec."EDICON Grupo Sonae")
                {
                    ToolTip = 'Specifies the value of the EDICON Grupo Sonae field.', Comment = '%';
                }
                field("Estado envío"; Rec."Estado envío")
                {
                    ToolTip = 'Specifies the value of the Estado envío field.', Comment = '%';
                }
                field("Estado miembro"; Rec."Estado miembro")
                {
                    ToolTip = 'Specifies the value of the Estado miembro field.', Comment = '%';
                }
                field("Factura EDI"; Rec."Factura EDI")
                {
                    ToolTip = 'Specifies the value of the Factura EDI field.', Comment = '%';
                }
                field("Facturas o documentación"; Rec."Facturas o documentación")
                {
                    ToolTip = 'Specifies the value of the Facturas o documentación field.', Comment = '%';
                }
                field("Fecha Inicio utilización"; Rec."Fecha Inicio utilización")
                {
                    ToolTip = 'Specifies the value of the Fecha Inicio utilización field.', Comment = '%';
                }
                field("Fecha caducidad"; Rec."Fecha caducidad")
                {
                    ToolTip = 'Specifies the value of the Fecha caducidad field.', Comment = '%';
                }
                field("Fecha creación"; Rec."Fecha creación")
                {
                    ToolTip = 'Specifies the value of the Fecha creación field.', Comment = '%';
                }
                field("Fecha documento"; Rec."Fecha documento")
                {
                    ToolTip = 'Specifies the value of the Fecha documento field.', Comment = '%';
                }
                field("Fecha envío"; Rec."Fecha envío")
                {
                    ToolTip = 'Specifies the value of the Fecha envío field.', Comment = '%';
                }
                field("Fecha factura rectificada"; Rec."Fecha factura rectificada")
                {
                    ToolTip = 'Specifies the value of the Fecha factura rectificada field.', Comment = '%';
                }
                field("Fecha registro"; Rec."Fecha registro")
                {
                    ToolTip = 'Specifies the value of the Fecha registro field.', Comment = '%';
                }
                field("Grupo iva prod"; Rec."Grupo iva prod")
                {
                    ToolTip = 'Specifies the value of the Grupo iva prod field.', Comment = '%';
                }
                field("IBAN cobro"; Rec."IBAN cobro")
                {
                    ToolTip = 'Specifies the value of the IBAN cobro field.', Comment = '%';
                }
                field("ID WEB"; Rec."ID WEB")
                {
                    ToolTip = 'Specifies the value of the ID WEB field.', Comment = '%';
                }
                field("Identificación bien"; Rec."Identificación bien")
                {
                    ToolTip = 'Specifies the value of the Identificación bien field.', Comment = '%';
                }
                field("Identificación entrega"; Rec."Identificación entrega")
                {
                    ToolTip = 'Specifies the value of the Identificación entrega field.', Comment = '%';
                }
                field("Importe Base IVA"; Rec."Importe Base IVA")
                {
                    ToolTip = 'Specifies the value of the Importe Base IVA field.', Comment = '%';
                }
                field("Importe IVA"; Rec."Importe IVA")
                {
                    ToolTip = 'Specifies the value of the Importe IVA field.', Comment = '%';
                }
                field("Importe cobrado"; Rec."Importe cobrado")
                {
                    ToolTip = 'Specifies the value of the Importe cobrado field.', Comment = '%';
                }
                field("Importe dto 1"; Rec."Importe dto 1")
                {
                    ToolTip = 'Specifies the value of the Importe dto 1 field.', Comment = '%';
                }
                field("Importe dto 2"; Rec."Importe dto 2")
                {
                    ToolTip = 'Specifies the value of the Importe dto 2 field.', Comment = '%';
                }
                field("Importe dto 3"; Rec."Importe dto 3")
                {
                    ToolTip = 'Specifies the value of the Importe dto 3 field.', Comment = '%';
                }
                field("Importe dto 4"; Rec."Importe dto 4")
                {
                    ToolTip = 'Specifies the value of the Importe dto 4 field.', Comment = '%';
                }
                field("Importe venta"; Rec."Importe venta")
                {
                    ToolTip = 'Specifies the value of the Importe venta field.', Comment = '%';
                }
                field("Inventario EDI"; Rec."Inventario EDI")
                {
                    ToolTip = 'Specifies the value of the Inventario EDI field.', Comment = '%';
                }
                field(Largo; Rec.Largo)
                {
                    ToolTip = 'Specifies the value of the Largo field.', Comment = '%';
                }
                field(Lote; Rec.Lote)
                {
                    ToolTip = 'Specifies the value of the Lote field.', Comment = '%';
                }
                field("Medio cobro"; Rec."Medio cobro")
                {
                    ToolTip = 'Specifies the value of the Medio cobro field.', Comment = '%';
                }
                field("Motivo rechazo"; Rec."Motivo rechazo")
                {
                    ToolTip = 'Specifies the value of the Motivo rechazo field.', Comment = '%';
                }
                field(Multiplicador; Rec.Multiplicador)
                {
                    ToolTip = 'Specifies the value of the Multiplicador field.', Comment = '%';
                }
                field("No. doc. externo"; Rec."No. doc. externo")
                {
                    ToolTip = 'Specifies the value of the No. doc. externo field.', Comment = '%';
                }
                field("No. documento"; Rec."No. documento")
                {
                    ToolTip = 'Specifies the value of the No. documento field.', Comment = '%';
                }
                field("No. documento pago"; Rec."No. documento pago")
                {
                    ToolTip = 'Specifies the value of the No. documento pago field.', Comment = '%';
                }
                field("No. factura rectificada"; Rec."No. factura rectificada")
                {
                    ToolTip = 'Specifies the value of the No. factura rectificada field.', Comment = '%';
                }
                field("No. mov."; Rec."No. mov.")
                {
                    ToolTip = 'Specifies the value of the No. mov. field.', Comment = '%';
                }
                field("No. mov. registro IVA"; Rec."No. mov. registro IVA")
                {
                    ToolTip = 'Specifies the value of the No. mov. registro IVA field.', Comment = '%';
                }
                field("Nº pedido"; Rec."Nº pedido")
                {
                    ToolTip = 'Specifies the value of the Nº pedido field.', Comment = '%';
                }
                field(Observaciones; Rec.Observaciones)
                {
                    ToolTip = 'Specifies the value of the Observaciones field.', Comment = '%';
                }
                field(Ok; Rec.Ok)
                {
                    ToolTip = 'Specifies the value of the Ok field.', Comment = '%';
                }
                field(Orden; Rec.Orden)
                {
                    ToolTip = 'Specifies the value of the Orden field.', Comment = '%';
                }
                field("Orden EDI"; Rec."Orden EDI")
                {
                    ToolTip = 'Specifies the value of the Orden EDI field.', Comment = '%';
                }
                field("Plazo operación"; Rec."Plazo operación")
                {
                    ToolTip = 'Specifies the value of the Plazo operación field.', Comment = '%';
                }
                field(Producto; Rec.Producto)
                {
                    ToolTip = 'Specifies the value of the Producto field.', Comment = '%';
                }
                field("Prorrata anual definitiva"; Rec."Prorrata anual definitiva")
                {
                    ToolTip = 'Specifies the value of the Prorrata anual definitiva field.', Comment = '%';
                }
                field("Referencia catastral"; Rec."Referencia catastral")
                {
                    ToolTip = 'Specifies the value of the Referencia catastral field.', Comment = '%';
                }
                field("Registro anulado"; Rec."Registro anulado")
                {
                    ToolTip = 'Specifies the value of the Registro anulado field.', Comment = '%';
                }
                field("Regul. anual deducción"; Rec."Regul. anual deducción")
                {
                    ToolTip = 'Specifies the value of the Regul. anual deducción field.', Comment = '%';
                }
                field("Regul. deducción efectuada"; Rec."Regul. deducción efectuada")
                {
                    ToolTip = 'Specifies the value of the Regul. deducción efectuada field.', Comment = '%';
                }
                field("Resultado envío"; Rec."Resultado envío")
                {
                    ToolTip = 'Specifies the value of the Resultado envío field.', Comment = '%';
                }
                field("Serie documento"; Rec."Serie documento")
                {
                    ToolTip = 'Specifies the value of the Serie documento field.', Comment = '%';
                }
                field("Situación inmueble"; Rec."Situación inmueble")
                {
                    ToolTip = 'Specifies the value of the Situación inmueble field.', Comment = '%';
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
                field("Tipo comunicación"; Rec."Tipo comunicación")
                {
                    ToolTip = 'Specifies the value of the Tipo comunicación field.', Comment = '%';
                }
                field("Tipo documento"; Rec."Tipo documento")
                {
                    ToolTip = 'Specifies the value of the Tipo documento field.', Comment = '%';
                }
                field("Tipo envío"; Rec."Tipo envío")
                {
                    ToolTip = 'Specifies the value of the Tipo envío field.', Comment = '%';
                }
                field("Tipo factura"; Rec."Tipo factura")
                {
                    ToolTip = 'Specifies the value of the Tipo factura field.', Comment = '%';
                }
                field("Tipo factura expedida"; Rec."Tipo factura expedida")
                {
                    ToolTip = 'Specifies the value of the Tipo factura expedida field.', Comment = '%';
                }
                field("Tipo operacion intracomu"; Rec."Tipo operacion intracomu")
                {
                    ToolTip = 'Specifies the value of the Tipo operacion intracomu field.', Comment = '%';
                }
                field("Tipo rectificativa"; Rec."Tipo rectificativa")
                {
                    ToolTip = 'Specifies the value of the Tipo rectificativa field.', Comment = '%';
                }
                field("Tipo registro"; Rec."Tipo registro")
                {
                    ToolTip = 'Specifies the value of the Tipo registro field.', Comment = '%';
                }
                field(Ubicacion; Rec.Ubicacion)
                {
                    ToolTip = 'Specifies the value of the Ubicacion field.', Comment = '%';
                }
                field("Ultima fecha envío"; Rec."Ultima fecha envío")
                {
                    ToolTip = 'Specifies the value of the Ultima fecha envío field.', Comment = '%';
                }
                field("Ultimo CSV"; Rec."Ultimo CSV")
                {
                    ToolTip = 'Specifies the value of the Ultimo CSV field.', Comment = '%';
                }
                field("Ultimo motivo rechazo"; Rec."Ultimo motivo rechazo")
                {
                    ToolTip = 'Specifies the value of the Ultimo motivo rechazo field.', Comment = '%';
                }
                field("Ultimo resultado envío"; Rec."Ultimo resultado envío")
                {
                    ToolTip = 'Specifies the value of the Ultimo resultado envío field.', Comment = '%';
                }
                field(Usuario; Rec.Usuario)
                {
                    ToolTip = 'Specifies the value of the Usuario field.', Comment = '%';
                }
                field("Valor Dynamics Crm"; Rec."Valor Dynamics Crm")
                {
                    ToolTip = 'Specifies the value of the Valor Dynamics Crm field.', Comment = '%';
                }
                field(Vendedor; Rec.Vendedor)
                {
                    ToolTip = 'Specifies the value of the Vendedor field.', Comment = '%';
                }
                field("id prestashop"; Rec."id prestashop")
                {
                    ToolTip = 'Specifies the value of the id prestashop field.', Comment = '%';
                }
                field("iva igic"; Rec."iva igic")
                {
                    ToolTip = 'Specifies the value of the iva igic field.', Comment = '%';
                }
                field(linea; Rec.linea)
                {
                    ToolTip = 'Specifies the value of the linea field.', Comment = '%';
                }
                field("mas de 18 meses"; Rec."mas de 18 meses")
                {
                    ToolTip = 'Specifies the value of the mas de 18 meses field.', Comment = '%';
                }
            }
        }
    }
}
