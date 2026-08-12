/// <summary>
/// REQ-000145 - El único sitio donde se calcula el stock que se ofrece en la web.
///
/// Hasta ahora esta fórmula estaba escrita CUATRO veces (codeunits 50001, 50004,
/// 50008 y 50025) y no eran iguales entre sí: según cuál de los cuatro procesos
/// recalculara un artículo, el stock que veía el cliente cambiaba. Con el portal
/// convirtiéndose en la vía principal de entrada de pedidos, eso deja de ser un
/// detalle: es la diferencia entre prometer algo servible y prometer aire.
///
/// Lo que arregla, además de unificar:
///
///  - CANTIDAD POR CONJUNTO. Antes se tomaba el stock del componente más escaso sin
///    mirar cuántas unidades lleva el conjunto. Si un kit necesita 2 piezas y hay
///    10, se ofrecían 10 kits cuando salen 5.
///  - COMPONENTES YA VENDIDOS. El stock normal descuenta los pedidos de venta
///    pendientes; el de los conjuntos no lo hacía. Es la vía más rápida a prometer
///    algo que ya está comprometido con otro cliente.
///  - COLCHÓN Y RESERVA DE CATIT. Se aplicaban al resto de artículos y no a los
///    conjuntos.
///  - CONJUNTOS DENTRO DE CONJUNTOS. Antes solo bajaba un nivel.
///
/// El resultado nunca es negativo: si las cuentas dan menos de cero, se ofrece cero.
/// </summary>
codeunit 50106 StockWeb
{
    var
        ProfundidadMaxima: Integer;

    /// <summary>
    /// Unidades que se pueden ofrecer en la web de este artículo. Es la única
    /// función que deberían llamar los procesos que rellenan "Stock para la web".
    /// </summary>
    procedure Calcular(var Item: Record Item): Decimal
    begin
        exit(CalcularConProfundidad(Item, 0));
    end;

    local procedure CalcularConProfundidad(var Item: Record Item; Nivel: Integer): Decimal
    var
        Resultado: Decimal;
    begin
        // Artículo cerrado a la venta web: cero, sin más preguntas.
        if Item."No permite pedido" or Item."Producto con reserva" then
            exit(0);

        Item.CalcFields("Assembly BOM");
        if (not Item."Producto almacenable") and Item."Assembly BOM" then
            Resultado := StockDeConjunto(Item, Nivel)
        else
            Resultado := StockPropio(Item);

        if Resultado < 0 then
            exit(0);
        exit(Resultado);
    end;

    /// <summary>
    /// Stock de un artículo que existe físicamente: lo que hay, menos lo que está en
    /// tránsito FOB, menos lo ya vendido y pendiente de servir, menos lo reservado
    /// para Catit, más el colchón que se quiera dejar puesto a mano.
    /// </summary>
    local procedure StockPropio(var Item: Record Item): Decimal
    begin
        Item.CalcFields(Inventory, "Existencia FOB", "Qty. on Sales Order");
        exit(Item.Inventory - Item."Existencia FOB" - Item."Qty. on Sales Order"
             + Item."Cantidad colchon web" - Item."Stock para Catit");
    end;

    /// <summary>
    /// Cuántos conjuntos se pueden montar: manda el componente que antes se acaba,
    /// teniendo en cuenta cuántas unidades de cada uno lleva el conjunto.
    ///
    /// Un componente que a su vez sea conjunto se resuelve bajando otro nivel, con
    /// un tope de profundidad: si alguien monta una lista de materiales circular en
    /// BC, esto no se queda dando vueltas para siempre.
    /// </summary>
    local procedure StockDeConjunto(var Item: Record Item; Nivel: Integer): Decimal
    var
        Componente: Record "BOM Component";
        ItemComponente: Record Item;
        Menor: Decimal;
        Posibles: Decimal;
        Disponible: Decimal;
        PorConjunto: Decimal;
        Encontrado: Boolean;
    begin
        if ProfundidadMaxima = 0 then
            ProfundidadMaxima := 5;
        if Nivel >= ProfundidadMaxima then
            exit(0);

        Componente.SetRange("Parent Item No.", Item."No.");
        Componente.SetRange(Type, Componente.Type::Item);
        if not Componente.FindSet() then
            exit(0);

        repeat
            if ItemComponente.Get(Componente."No.") then begin
                Disponible := CalcularConProfundidad(ItemComponente, Nivel + 1);

                PorConjunto := Componente."Quantity per";
                if PorConjunto <= 0 then
                    PorConjunto := 1;

                // Hacia abajo: con 7 unidades y 2 por conjunto salen 3, no 3,5.
                Posibles := Round(Disponible / PorConjunto, 1, '<');

                if (not Encontrado) or (Posibles < Menor) then begin
                    Menor := Posibles;
                    Encontrado := true;
                end;
            end;
        until Componente.Next() = 0;

        // Una lista de materiales cuyos componentes no existen como artículo no
        // permite montar nada.
        if not Encontrado then
            exit(0);
        exit(Menor);
    end;
}
