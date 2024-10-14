page 50021 Multitabla2
{
    ApplicationArea = All;
    Caption = 'Multitabla2';
    PageType = List;
    SourceTable = "Multitabla 2";
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
                field("Codigo 1"; Rec."Codigo 1")
                {
                    ToolTip = 'Specifies the value of the Código 1 field.', Comment = '%';
                }
                field("Codigo 2"; Rec."Codigo 2")
                {
                    ToolTip = 'Specifies the value of the Código 2 field.', Comment = '%';
                }
                field("Actualizar WEB"; Rec."Actualizar WEB")
                {
                    ToolTip = 'Specifies the value of the Actualizar WEB field.', Comment = '%';
                }
                field("Bloquear a dias"; Rec."Bloquear a dias")
                {
                    ToolTip = 'Specifies the value of the Bloquear a dias field.', Comment = '%';
                }
                field("Cantidad caja"; Rec."Cantidad caja")
                {
                    ToolTip = 'Specifies the value of the Cantidad caja field.', Comment = '%';
                }
                field("Cantidad en pedido"; Rec."Cantidad en pedido")
                {
                    ToolTip = 'Specifies the value of the Cantidad en pedido field.', Comment = '%';
                }
                field("Descripcion 1"; Rec."Descripcion 1")
                {
                    ToolTip = 'Specifies the value of the Descripcion 1 field.', Comment = '%';
                }
                field("Descripcion 2"; Rec."Descripcion 2")
                {
                    ToolTip = 'Specifies the value of the Descripcion 2 field.', Comment = '%';
                }
                field("Descripcion Grado interes"; Rec."Descripcion Grado interes")
                {
                    ToolTip = 'Specifies the value of the Descripcion Grado interes field.', Comment = '%';
                }
                field("Descripcion Marca"; Rec."Descripcion Marca")
                {
                    ToolTip = 'Specifies the value of the Descripcion Marca field.', Comment = '%';
                }
                field("Descripcion WEB"; Rec."Descripcion WEB")
                {
                    ToolTip = 'Specifies the value of the Descripcion WEB field.', Comment = '%';
                }
                field("Descripcion WEB2"; Rec."Descripcion WEB2")
                {
                    ToolTip = 'Specifies the value of the Descripcion WEB2 field.', Comment = '%';
                }
                field("Descripcion tecnica"; Rec."Descripcion tecnica")
                {
                    ToolTip = 'Specifies the value of the Descripcion tecnica field.', Comment = '%';
                }
                field("Descuento a aplicar"; Rec."Descuento a aplicar")
                {
                    ToolTip = 'Specifies the value of the Descuento a aplicar field.', Comment = '%';
                }
                field("Dias para llegada"; Rec."Dias para llegada")
                {
                    ToolTip = 'Specifies the value of the Dias para llegada field.', Comment = '%';
                }
                field("Eliminar de WEB"; Rec."Eliminar de WEB")
                {
                    ToolTip = 'Specifies the value of the Eliminar de WEB field.', Comment = '%';
                }
                field("Estado Producto"; Rec."Estado Producto")
                {
                    ToolTip = 'Specifies the value of the Estado Producto field.', Comment = '%';
                }
                field("Fecha eliminar"; Rec."Fecha eliminar")
                {
                    ToolTip = 'Specifies the value of the Fecha eliminar field.', Comment = '%';
                }
                field("Fecha pedido contenedor"; Rec."Fecha pedido contenedor")
                {
                    ToolTip = 'Specifies the value of the Fecha pedido contenedor field.', Comment = '%';
                }
                field("Importe Venta"; Rec."Importe Venta")
                {
                    ToolTip = 'Specifies the value of the Importe Venta field.', Comment = '%';
                }
                field("Importe minimo para descuento"; Rec."Importe minimo para descuento")
                {
                    ToolTip = 'Specifies the value of the Importe minimo para descuento field.', Comment = '%';
                }
                field(Linea; Rec.Linea)
                {
                    ToolTip = 'Specifies the value of the Linea field.', Comment = '%';
                }
                field("Marca Interes"; Rec."Marca Interes")
                {
                    ToolTip = 'Specifies the value of the Marca Interes field.', Comment = '%';
                }
                field("No permite pedido"; Rec."No permite pedido")
                {
                    ToolTip = 'Specifies the value of the No permite pedido field.', Comment = '%';
                }
                field("Nombre cliente"; Rec."Nombre cliente")
                {
                    ToolTip = 'Specifies the value of the Nombre cliente field.', Comment = '%';
                }
                field(NombreAtributo; Rec.NombreAtributo)
                {
                    ToolTip = 'Specifies the value of the NombreAtributo field.', Comment = '%';
                }
                field("Orden de LineasNegoWEB"; Rec."Orden de LineasNegoWEB")
                {
                    ToolTip = 'Specifies the value of the Orden de LineasNegoWEB field.', Comment = '%';
                }
                field("Para dias general"; Rec."Para dias general")
                {
                    ToolTip = 'Specifies the value of the Para dias general field.', Comment = '%';
                }
                field("Para dias grupos"; Rec."Para dias grupos")
                {
                    ToolTip = 'Specifies the value of the Para dias grupos field.', Comment = '%';
                }
                field("Pedido contenedor"; Rec."Pedido contenedor")
                {
                    ToolTip = 'Specifies the value of the Pedido contenedor field.', Comment = '%';
                }
                field("Por defecto"; Rec."Por defecto")
                {
                    ToolTip = 'Specifies the value of the Por defecto field.', Comment = '%';
                }
                field("Porcentaje Real"; Rec."Porcentaje Real")
                {
                    ToolTip = 'Specifies the value of the Porcentaje Real field.', Comment = '%';
                }
                field("Porcentaje encuesta"; Rec."Porcentaje encuesta")
                {
                    ToolTip = 'Specifies the value of the Porcentaje encuesta field.', Comment = '%';
                }
                field("Proveedor ref."; Rec."Proveedor ref.")
                {
                    ToolTip = 'Specifies the value of the Proveedor ref. field.', Comment = '%';
                }
                field(Reservar; Rec.Reservar)
                {
                    ToolTip = 'Specifies the value of the Reservar field.', Comment = '%';
                }
                field("Stock actual"; Rec."Stock actual")
                {
                    ToolTip = 'Specifies the value of the Stock actual field.', Comment = '%';
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
                field("URL IMAGEN 1"; Rec."URL IMAGEN 1")
                {
                    ToolTip = 'Specifies the value of the URL IMAGEN 1 field.', Comment = '%';
                }
                field("URL IMAGEN 2"; Rec."URL IMAGEN 2")
                {
                    ToolTip = 'Specifies the value of the URL IMAGEN 2 field.', Comment = '%';
                }
                field("URL IMAGEN 3"; Rec."URL IMAGEN 3")
                {
                    ToolTip = 'Specifies the value of the URL IMAGEN 3 field.', Comment = '%';
                }
                field("URL IMAGEN 4"; Rec."URL IMAGEN 4")
                {
                    ToolTip = 'Specifies the value of the URL IMAGEN 4 field.', Comment = '%';
                }
                field("Valor Grado interes"; Rec."Valor Grado interes")
                {
                    ToolTip = 'Specifies the value of the Valor Grado interes field.', Comment = '%';
                }
                field(ValorAtributo; Rec.ValorAtributo)
                {
                    ToolTip = 'Specifies the value of the ValorAtributo field.', Comment = '%';
                }
                field(Vendedor; Rec.Vendedor)
                {
                    ToolTip = 'Specifies the value of the Vendedor field.', Comment = '%';
                }
                field("Venta de contenedor"; Rec."Venta de contenedor")
                {
                    ToolTip = 'Specifies the value of the Venta de contenedor field.', Comment = '%';
                }
                field("Venta diaria general"; Rec."Venta diaria general")
                {
                    ToolTip = 'Specifies the value of the Venta diaria general field.', Comment = '%';
                }
                field("Venta diaria grupo"; Rec."Venta diaria grupo")
                {
                    ToolTip = 'Specifies the value of the Venta diaria grupo field.', Comment = '%';
                }
                field("Venta global"; Rec."Venta global")
                {
                    ToolTip = 'Specifies the value of the Venta global field.', Comment = '%';
                }
                field("Venta grupos"; Rec."Venta grupos")
                {
                    ToolTip = 'Specifies the value of the Venta grupos field.', Comment = '%';
                }
            }
        }
    }
}
