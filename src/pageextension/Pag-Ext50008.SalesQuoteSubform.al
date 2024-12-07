pageextension 50008 "Sales Quote Subform" extends "Sales Quote Subform"
{




    layout
    {


        addafter(Quantity)
        {
            field(ColorLinea; Rec.ColorLinea) { ApplicationArea = All; }
        }
        addlast(content)
        {
            group(Hagen)
            {

                field("Precio base"; Rec."Precio base") { ApplicationArea = All; }
                field("Precio final"; Rec."Precio final") { ApplicationArea = All; }
                field("Usuario alta"; Rec."Usuario alta") { ApplicationArea = All; }
                field("Fecha alta"; Rec."Fecha alta") { ApplicationArea = All; }
                field("Hora alta"; Rec."Hora alta") { ApplicationArea = All; }
                field("Estado linea"; Rec."Estado linea") { ApplicationArea = All; }
                field("Defectuosos"; Rec."Defectuosos") { ApplicationArea = All; }
                field("Dto 2009"; Rec."Dto 2009") { ApplicationArea = All; }
                field("Corrected Invoice No."; Rec."Corrected Invoice No.") { ApplicationArea = All; }
                field("Linea correccion"; Rec."Linea correccion") { ApplicationArea = All; }
                field("Vendedor"; Rec."Vendedor") { ApplicationArea = All; }
                field("Importe dto. vendedor"; Rec."Importe dto. vendedor") { ApplicationArea = All; }
                field("Nº expedición"; Rec."Nº expedición") { ApplicationArea = All; }
                field("Linea Nº expedición"; Rec."Linea Nº expedición") { ApplicationArea = All; }
                field("Producto asociado"; Rec."Producto asociado") { ApplicationArea = All; }
                field("Precio final sin dto.comer"; Rec."Precio final sin dto.comer") { ApplicationArea = All; }
                field("Acumula Importe dto. comer"; Rec."Acumula Importe dto. comer") { ApplicationArea = All; }
                field("Cantidad a pasar pedido"; Rec."Cantidad a pasar pedido") { ApplicationArea = All; }
                field("Nº lote"; Rec."Nº lote") { ApplicationArea = All; }
                field("Fecha caducidad"; Rec."Fecha caducidad") { ApplicationArea = All; }
                field("Cantidad anulada"; Rec."Cantidad anulada") { ApplicationArea = All; }
                field("Your Reference 2"; Rec."Your Reference 2") { ApplicationArea = All; }
                field("Precio importado"; Rec."Precio importado") { ApplicationArea = All; }
                field("id linea externo"; Rec."id linea externo") { ApplicationArea = All; }
                field("ean"; Rec."ean") { ApplicationArea = All; }
                field("Referencia"; Rec."Referencia") { ApplicationArea = All; }
                field("Cantidad master"; Rec."Cantidad master") { ApplicationArea = All; }
                field("Cantidad inner"; Rec."Cantidad inner") { ApplicationArea = All; }
                field("Unidades venta"; Rec."Unidades venta") { ApplicationArea = All; }
                field("Enviar a ADAIA"; Rec."Enviar a ADAIA") { ApplicationArea = All; }
                field("Descuento sin vendedor"; Rec."Descuento sin vendedor") { ApplicationArea = All; }
                field("Importe sin dto vendedor"; Rec."Importe sin dto vendedor") { ApplicationArea = All; }
                field("Importe acumulado pedido"; Rec."Importe acumulado pedido") { ApplicationArea = All; }
                field("% Dto. vendedor"; Rec."% Dto. vendedor") { ApplicationArea = All; }
                field("Tipo preparacion"; Rec."Tipo preparacion") { ApplicationArea = All; }
                field("Your Reference"; Rec."Your Reference") { ApplicationArea = All; }
                field("Precio Tarifa"; Rec."Precio Tarifa") { ApplicationArea = All; }
                field("Suma cdad padre_hijos"; Rec."Suma cdad padre_hijos") { ApplicationArea = All; }
                field("Dto% apli. lin."; Rec."Dto% apli. lin.") { ApplicationArea = All; }
                field("Incremento dto%"; Rec."Incremento dto%") { ApplicationArea = All; }
                field("Line Discount % original"; Rec."Line Discount % original") { ApplicationArea = All; }
                field("Importe inicial vendedor"; Rec."Importe inicial vendedor") { ApplicationArea = All; }
                field("ImpLinea"; Rec."ImpLinea") { ApplicationArea = All; }
                field("Producto Padre"; Rec."Producto Padre") { ApplicationArea = All; }
                field("Suma cdad. por envio"; Rec."Suma cdad. por envio") { ApplicationArea = All; }
                field("Cantidad padre"; Rec."Cantidad padre") { ApplicationArea = All; }
                field("ean canarias"; Rec."ean canarias") { ApplicationArea = All; }
                field("prod canarias"; Rec."prod canarias") { ApplicationArea = All; }
                field("Linea pedido externo"; Rec."Linea pedido externo") { ApplicationArea = All; }
                field("Producto con reserva"; Rec."Producto con reserva") { ApplicationArea = All; }
                field("Grupo clientes"; Rec."Grupo clientes") { ApplicationArea = All; }
                field("Fecha cabecera ofer/ped"; Rec."Fecha cabecera ofer/ped") { ApplicationArea = All; }
                field("Estado presupuesto"; Rec."Estado presupuesto") { ApplicationArea = All; }
                field("existe"; Rec."existe") { ApplicationArea = All; }


            }
        }
    }
    trigger OnAfterGetRecord()
    var
        RecItem: Record Item;

    begin
        Rec.ColorLinea := '';
        IF RecItem.GET(Rec."No.") THEN BEGIN
            IF (RecItem."No permite pedido") THEN BEGIN
                Rec.ColorLinea := 'Rojo';
            END;
            IF (RecItem."Producto con reserva") THEN BEGIN
                Rec.ColorLinea := 'Attention';
            END;
            IF RecItem."Estado Producto" <> RecItem."Estado Producto"::Activo THEN BEGIN
                Rec.ColorLinea := 'Ambiguous';
            END;

        END;

    end;

}

