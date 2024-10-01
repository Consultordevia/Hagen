codeunit 50002 Eventos
{
    [EventSubscriber(ObjectType::Table, 18, 'OnAfterOnInsert', '', true, true)]
    local procedure OnAfterOnInsert(var Customer: Record Customer; xCustomer: Record Customer)
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin

        EnvioFicheros.MODIFCLIENTES(Customer);


    end;

    [EventSubscriber(ObjectType::Table, 18, OnAfterModifyEvent, '', true, true)]
    local procedure OnAfterModifyEvent(RunTrigger: Boolean; var Rec: Record Customer);
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin
        EnvioFicheros.ALTACLIENTES(Rec);
    end;

    /*[EventSubscriber(ObjectType::Table, 27, 'OnAfterOnInsert', '', true, true)]
    local procedure OnAfterOnInsert(var Item: Record Item; xItem: Record Item)
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin

        EnvioFicheros.MODIFPROD(Item);


    end;

    [EventSubscriber(ObjectType::Table, 27, OnAfterModifyEvent, '', true, true)]
    local procedure OnAfterModifyEvent(RunTrigger: Boolean; var Rec: Record Item);
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin
        EnvioFicheros.ALTAPROD(Rec);
    end;
    */
}
