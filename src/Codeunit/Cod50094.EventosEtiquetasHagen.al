codeunit 50094 "Eventos Etiquetas Hagen"
{
    /// <summary>
    /// Obtiene el preparador a mostrar en las etiquetas grandes (reports 50039/50041).
    /// El dato real del preparador no vive en este proyecto (Hagen), sino en una
    /// dependencia (Incidencias_Preparacion), por lo que se resuelve mediante el evento
    /// OnObtenerPreparador, suscrito en el proyecto Hagen_Dependencias.
    /// </summary>
    procedure ObtenerPreparador(SalesShipmentHeader: Record "Sales Shipment Header") Preparador: Text[150]
    begin
        OnObtenerPreparador(SalesShipmentHeader, Preparador);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnObtenerPreparador(SalesShipmentHeader: Record "Sales Shipment Header"; var Preparador: Text[150])
    begin
    end;
}
