pageextension 50000 "Item Card" extends "Item Card"
{

    layout

    {




        addlast(InventoryGrp)
        {
            group(Hagen_)
            {

                field("No permite pedido"; Rec."No permite pedido") { ApplicationArea = ALL; }
                field(Level1; Rec.Level1) { ApplicationArea = ALL; }
                field(Level2; Rec.Level2) { ApplicationArea = ALL; }
                field(Level3; Rec.Level3) { ApplicationArea = ALL; }
                field(Etiquetas1; Rec.Etiquetas1) { ApplicationArea = ALL; }
                field(Etiquetas2; Rec.Etiquetas2) { ApplicationArea = ALL; }
                field(Etiquetas3; Rec.Etiquetas3) { ApplicationArea = ALL; }
                field(Etiquetas4; Rec.Etiquetas4) { ApplicationArea = ALL; }
                field(Etiquetas5; Rec.Etiquetas5) { ApplicationArea = ALL; }
                field(Etiquetas6; Rec.Etiquetas6) { ApplicationArea = ALL; }
                field(Gama; Rec.Gama)
                {
                    ApplicationArea = ALL;
                }

                field("Umbral stock"; Rec."Umbral stock") { ApplicationArea = ALL; }

                field(CodVariante1; Rec.CodVariante1) { ApplicationArea = ALL; }
                field("Dato Variante1"; Rec."Dato Variante1") { ApplicationArea = ALL; }

                field(CodVariante2; Rec.codVariante2) { ApplicationArea = ALL; }
                field("Dato Variante2"; Rec."Dato Variante2") { ApplicationArea = ALL; }

                field("Precio medio ponderado"; pmp) { ApplicationArea = All; }
                field("Existencia SILLA"; Rec."Existencia SILLA") { ApplicationArea = All; }
                field("Existencia FOB"; Rec."Existencia FOB") { ApplicationArea = All; }
                field("Producto almacenable"; Rec."Producto almacenable") { ApplicationArea = All; }
                field("Permite fraccionar venta"; Rec."Permite fraccionar venta") { ApplicationArea = All; }
                field("Fecha recalcula no permitir"; Rec."Fecha recalcula no permitir") { ApplicationArea = All; }
            }
        }


        addlast(content)
        {
            group(Hagen)
            {


            
                field("Usuario última modificación"; Rec."Usuario última modificación") { ApplicationArea = All; }
                field("Fecha Alta"; Rec."Fecha Alta") { ApplicationArea = All; }
                field("Fecha Lanzamiento"; Rec."Fecha Lanzamiento") { ApplicationArea = All; }
                field("Fecha última modificación"; Rec."Fecha última modificación") { ApplicationArea = All; }
                field("Acumu. A,B,C"; Rec."Acumu. A,B,C") { ApplicationArea = All; }
                field("Clase logistica"; Rec."Clase logistica") { ApplicationArea = All; }
                field("Envíos (cdad.)"; Rec."Envíos (cdad.)") { ApplicationArea = All; }
                field("Ajustes (cdad.)"; Rec."Ajustes (cdad.)") { ApplicationArea = All; }
                field("Pro.Ped.Compra (cdad.)"; Rec."Pro.Ped.Compra (cdad.)") { ApplicationArea = All; }
                field("Prohibido Amazon"; Rec."Prohibido Amazon") { ApplicationArea = All; }
                field("Producto FRAGIL"; Rec."Producto FRAGIL") { ApplicationArea = All; }
                field("Observaciones AMAZON"; Rec."Observaciones AMAZON") { ApplicationArea = All; }
                field("Fecha prohibido Amazon"; Rec."Fecha prohibido Amazon") { ApplicationArea = All; }
                field("Usuario modificación"; Rec."Usuario modificación") { ApplicationArea = All; }
                field("Hora modificación"; Rec."Hora modificación") { ApplicationArea = All; }
                field("Stock para Catit"; Rec."Stock para Catit") { ApplicationArea = All; }
                field("Precio recomendado"; Rec."Precio recomendado") { ApplicationArea = All; }

                field("Tipo proveedor"; Rec."Tipo proveedor") { ApplicationArea = All; }
                field("Criterio rotacion"; Rec."Criterio rotacion") { ApplicationArea = All; }
                field("Unidades venta"; Rec."Unidades venta") { ApplicationArea = All; }

                field("Exit Point"; Rec."Exit Point") { ApplicationArea = All; }
                field("Stock Bloqueo Amz"; Rec."Stock Bloqueo Amz") { ApplicationArea = All; }
                field("Kgs. de plástico"; Rec."Kgs. de plástico") { ApplicationArea = All; }
                field("Pdte. Enviar a WEB"; Rec."Pdte. Enviar a WEB") { ApplicationArea = All; }
                field("Ref. AMAZON"; Rec."Ref. AMAZON") { ApplicationArea = All; }
                field("RII-AAEE"; Rec."RII-AAEE") { ApplicationArea = All; }
                field("Cantidad palets"; Rec."Cantidad palets") { ApplicationArea = All; }
                field("Cantidad master"; Rec."Cantidad master") { ApplicationArea = All; }
                field("Cantidad inner"; Rec."Cantidad inner") { ApplicationArea = All; }
                field("Fecha proxima recepción conten"; Rec."Fecha proxima recepción conten") { ApplicationArea = All; }
                field("Cantidad facturada"; Rec."Cantidad facturada") { ApplicationArea = All; }
                field("Cantidad abonada"; Rec."Cantidad abonada") { ApplicationArea = All; }
                field("Importe facturado"; Rec."Importe facturado") { ApplicationArea = All; }
                field("Importe abonado"; Rec."Importe abonado") { ApplicationArea = All; }
                field("Cantidad fabricada"; Rec."Cantidad fabricada") { ApplicationArea = All; }
                field("Unidad compra"; Rec."Unidad compra") { ApplicationArea = All; }
                field("Fecha proxima recepción pedido"; Rec."Fecha proxima recepción pedido") { ApplicationArea = All; }
                field("Comentario para pedido1"; Rec."Comentario para pedido1") { ApplicationArea = All; }
                field("Comentario para pedido2"; Rec."Comentario para pedido2") { ApplicationArea = All; }
                field("Tipo palet"; Rec."Tipo palet") { ApplicationArea = All; }

                field("Tiene productos asociados"; Rec."Tiene productos asociados") { ApplicationArea = All; }

                field("Cdad. en oferta compra"; Rec."Cdad. en oferta compra") { ApplicationArea = All; }
                field("Enviar siempre"; Rec."Enviar siempre") { ApplicationArea = All; }
                field("Cantidad palet transporte alma"; Rec."Cantidad palet transporte alma") { ApplicationArea = All; }
                field("Cantidad palet americano"; Rec."Cantidad palet americano") { ApplicationArea = All; }
                field("Fecha en picking"; Rec."Fecha en picking") { ApplicationArea = All; }
                field("Ref. hagen"; Rec."Ref. hagen") { ApplicationArea = All; }
                field("Fecha disponible Web"; Rec."Fecha disponible Web") { ApplicationArea = All; }
                field("Producto PADRE"; Rec."Producto PADRE") { ApplicationArea = All; }
                field("Producto con reserva"; Rec."Producto con reserva") { ApplicationArea = All; }
                field("Metros Cúbicos Master"; Rec."Metros Cúbicos Master") { ApplicationArea = All; }
                field("Kilos Master"; Rec."Kilos Master") { ApplicationArea = All; }
                field("EAN INNER"; Rec."EAN INNER") { ApplicationArea = All; }
                field("EAN MASTER"; Rec."EAN MASTER") { ApplicationArea = All; }
                field("Etiqueta portugues"; Rec."Etiqueta portugues") { ApplicationArea = All; }
                field("Tamaño etiqueta"; Rec."Tamaño etiqueta") { ApplicationArea = All; }
                field("Ventas"; Rec."Ventas") { ApplicationArea = All; }
                field("Promedio"; Rec."Promedio") { ApplicationArea = All; }
                field("Rotacion"; Rec."Rotacion") { ApplicationArea = All; }
                field("Dias"; Rec."Dias") { ApplicationArea = All; }
                field("Producto web"; Rec."Producto web") { ApplicationArea = All; }
                field("Unidad expedicion ECI"; Rec."Unidad expedicion ECI") { ApplicationArea = All; }


                field("+ Familia 2"; Rec."+ Familia 2") { ApplicationArea = All; }
                field("+ Familia 3"; Rec."+ Familia 3") { ApplicationArea = All; }
                field("+ Familia 4"; Rec."+ Familia 4") { ApplicationArea = All; }

                field("+ Subfamilia 2"; Rec."+ Subfamilia 2") { ApplicationArea = All; }
                field("+ Subfamilia 3"; Rec."+ Subfamilia 3") { ApplicationArea = All; }
                field("+ Subfamilia 4"; Rec."+ Subfamilia 4") { ApplicationArea = All; }
                field("+ Familia 1"; Rec."+ Familia 1") { ApplicationArea = All; }
                field("+ Subfamilia 1"; Rec."+ Subfamilia 1") { ApplicationArea = All; }
                field("+ Linea 1"; Rec."+ Linea 1") { ApplicationArea = All; }
                field("+ Linea 2"; Rec."+ Linea 2") { ApplicationArea = All; }
                field("+ Linea 3"; Rec."+ Linea 3") { ApplicationArea = All; }
                field("+ Linea 4"; Rec."+ Linea 4") { ApplicationArea = All; }
                field("Estado WEB Inactivo"; Rec."Estado WEB Inactivo") { ApplicationArea = All; }
                field("Producto Hagen"; Rec."Producto Hagen") { ApplicationArea = All; }
                field("Largo producto"; Rec."Largo producto") { ApplicationArea = All; }
                field("Ancho producto"; Rec."Ancho producto") { ApplicationArea = All; }
                field("Alto producto"; Rec."Alto producto") { ApplicationArea = All; }
                field("Ref. Catit"; Rec."Ref. Catit") { ApplicationArea = All; }
                field("Coste Catit"; Rec."Coste Catit") { ApplicationArea = All; }
                field("Familia Catit"; Rec."Familia Catit") { ApplicationArea = All; }
                field("Subfamilia Catit"; Rec."Subfamilia Catit") { ApplicationArea = All; }
                field("Estatus Web"; Rec."Estatus Web") { ApplicationArea = All; }
                field("Atributo 1"; Rec."Atributo 1") { ApplicationArea = All; }
                field("Atributo 2"; Rec."Atributo 2") { ApplicationArea = All; }
                field("Atributo 3"; Rec."Atributo 3") { ApplicationArea = All; }
                field("Valor Atributo 1"; Rec."Valor Atributo 1") { ApplicationArea = All; }
                field("Valor Atributo 2"; Rec."Valor Atributo 2") { ApplicationArea = All; }
                field("Valor Atributo 3"; Rec."Valor Atributo 3") { ApplicationArea = All; }
                //field("NO-Rotura de Stock"; Rec."NO-Rotura de Stock") { ApplicationArea = All; }
                field("Clasificacion CANADA"; Rec."Clasificacion CANADA") { ApplicationArea = All; }
                field("Fecha modif"; Rec."Fecha modif") { ApplicationArea = All; }
                field("Fecha sub web"; Rec."Fecha sub web") { ApplicationArea = All; }
                field("Existencia SILLA SALDO"; Rec."Existencia SILLA SALDO") { ApplicationArea = All; }
                field("Filtro Cliente"; Rec."Filtro Cliente") { ApplicationArea = All; }
                field("Imagen Articulo WEB"; Rec."Imagen Articulo WEB") { ApplicationArea = All; }
                field("NO MULTIPEDIDO"; Rec."NO MULTIPEDIDO") { ApplicationArea = All; }
                field("Importe ABC"; Rec."Importe ABC") { ApplicationArea = All; }
                field("Importe total ABC"; Rec."Importe total ABC") { ApplicationArea = All; }
                field("Cantidad colchon web"; Rec."Cantidad colchon web") { ApplicationArea = All; }
                field("Stock para la web"; Rec."Stock para la web") { ApplicationArea = All; }
                field("Stock en HAGEN"; Rec."Stock en HAGEN") { ApplicationArea = All; }
                field("PVP Recomendado 2019"; Rec."PVP Recomendado 2019") { ApplicationArea = All; }
                field("CUANTOS UDS EANS"; Rec."CUANTOS UDS EANS") { ApplicationArea = All; }
                field("Tarifa 2021"; Rec."Tarifa 2021") { ApplicationArea = All; }
                field("PVP Recomendado 2021"; Rec."PVP Recomendado 2021") { ApplicationArea = All; }
                field("Voluminoso web"; Rec."Voluminoso web") { ApplicationArea = All; }

                field("Excluir de dropbox"; Rec."Excluir de dropbox") { ApplicationArea = All; }
                field("FIJO Excluir de dropbox"; Rec."FIJO Excluir de dropbox") { ApplicationArea = All; }
                field("Tarifa 2021-2"; Rec."Tarifa 2021-2") { ApplicationArea = All; }
                field("PVP Recomendado 2021-2"; Rec."PVP Recomendado 2021-2") { ApplicationArea = All; }
                field("Tarifa 2021 amazon21"; Rec."Tarifa 2021 amazon21") { ApplicationArea = All; }
                field("PVP Recomendado 2021 amazon21"; Rec."PVP Recomendado 2021 amazon21") { ApplicationArea = All; }
                field("Tarifa 2021 AMZ2021-3"; Rec."Tarifa 2021 AMZ2021-3") { ApplicationArea = All; }
                field("PVP Recomendado 2021 AMZ2021-3"; Rec."PVP Recomendado 2021 AMZ2021-3") { ApplicationArea = All; }
                field("Tarifa 2022"; Rec."Tarifa 2022") { ApplicationArea = All; }
                field("PVP Recomendado 2022"; Rec."PVP Recomendado 2022") { ApplicationArea = All; }
                field("Tarifa AMZ2023"; Rec."Tarifa AMZ2023") { ApplicationArea = All; }
                field("PVP Recomendado AMZ2023"; Rec."PVP Recomendado AMZ2023") { ApplicationArea = All; }
                field("Precio inv 2009"; Rec."Precio inv 2009") { ApplicationArea = All; }
                field("URL IMAGEN 1"; Rec."URL IMAGEN 1") { ApplicationArea = All; }
                field("Actualizar WEB"; Rec."Actualizar WEB") { ApplicationArea = All; }
                field("Imagen Articulo WEB 2"; Rec."Imagen Articulo WEB 2") { ApplicationArea = All; }
                field("Imagen Articulo WEB 3"; Rec."Imagen Articulo WEB 3") { ApplicationArea = All; }
                field("Imagen Articulo WEB 4"; Rec."Imagen Articulo WEB 4") { ApplicationArea = All; }
                field("Actualizar WEB Imagenes"; Rec."Actualizar WEB Imagenes") { ApplicationArea = All; }
                field("Actualizar WEB Descripcion"; Rec."Actualizar WEB Descripcion") { ApplicationArea = All; }
                field("Producto en promocion WEB"; Rec."Producto en promocion WEB") { ApplicationArea = All; }
                field("Fecha inicio promocion WEB"; Rec."Fecha inicio promocion WEB") { ApplicationArea = All; }
                field("Fecha fin promocion WEB"; Rec."Fecha fin promocion WEB") { ApplicationArea = All; }
                field("No enviar precio especial"; Rec."No enviar precio especial") { ApplicationArea = All; }


            }
            group(Hagen_Producto)
            {
                field("ean"; Rec."ean") { ApplicationArea = All; }
                field("Estado Producto"; Rec."Estado Producto") { ApplicationArea = All; }
                field("Marca"; Rec."Marca") { ApplicationArea = All; }
                field("Descripcion web"; Rec."Descripcion web") { ApplicationArea = All; }
                field("Enviar a web"; Rec."Enviar a web") { ApplicationArea = All; }
                field("Clasificación A,B,C"; Rec."Clasificación A,B,C") { ApplicationArea = All; }
                field("Fecha asignada clasificación"; Rec."Fecha asignada clasificación") { ApplicationArea = All; }
                field("Fecha Descatalogación"; Rec."Fecha Descatalogación") { ApplicationArea = All; }
                field("% clasi A,B,C"; Rec."% clasi A,B,C") { ApplicationArea = All; }

            }
            group(Hagen_Coste_y_registro)
            {
                field("IVA IGIC"; Rec."IVA IGIC") { ApplicationArea = All; }
            }
            group(Hagen_Reposicion)
            {
                field("Alto master"; Rec."Alto master") { ApplicationArea = All; }
                field("Ancho master"; Rec."Ancho master") { ApplicationArea = All; }
                field("Largo master"; Rec."Largo master") { ApplicationArea = All; }
                field("Alto"; Rec."Alto") { ApplicationArea = All; }
                field("Ancho"; Rec."Ancho") { ApplicationArea = All; }
                field("Largo"; Rec."Largo") { ApplicationArea = All; }
                field("Alto CAJA"; Rec."Alto CAJA") { ApplicationArea = All; }
                field("Ancho CAJA"; Rec."Ancho CAJA") { ApplicationArea = All; }
                field("Largo CAJA"; Rec."Largo CAJA") { ApplicationArea = All; }
                field("Volumen CAJA"; Rec."Volumen CAJA") { ApplicationArea = All; }
                field("Alto INNER"; Rec."Alto INNER") { ApplicationArea = All; }
                field("Ancho INNER"; Rec."Ancho INNER") { ApplicationArea = All; }
                field("Largo INNER"; Rec."Largo INNER") { ApplicationArea = All; }
                field("Volumen INNER"; Rec."Volumen INNER") { ApplicationArea = All; }


            }
            group(Hagen_Planificacion)
            {
                field("Familia"; Rec."Familia") { ApplicationArea = All; }
                field("Subfamilia"; Rec."Subfamilia") { ApplicationArea = All; }

            }

        }
    }
    actions
    {
        addlast(processing)
        {


            action(AutomaticoLeroyMerlin)
            {
                Caption = 'AutomaticoLeroyMerlin';
                Image = Capacity;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                var
                ///                    CUAutomaticoLeroyMerlin: Codeunit "Automaticos Leroy Merlin";
                begin
                    ///Clear(CuAutomaticoLeroyMerlin);
                    ///CuAutomaticoLeroyMerlin.RUN

                end;
            }
        }

    }

    trigger OnAfterGetRecord()
    var
        InventarioPMP: Record "Inventario PMP";


    begin
        pmp := 0;
        InventarioPMP.RESET;
        InventarioPMP.SETRANGE(InventarioPMP."Item No.", Rec."No.");
        IF InventarioPMP.FINDLAST THEN BEGIN
            pmp := InventarioPMP."Unit Cost";
        END;
    end;

    var
        pmp: Decimal;

}
