codeunit 50002 Eventos
{
    [EventSubscriber(ObjectType::Table, 18, 'OnAfterOnInsert', '', true, true)]
    local procedure OnAfterOnInsert(var Customer: Record Customer; xCustomer: Record Customer)
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin

        EnvioFicheros.ALTACLIENTES(Customer);


    end;

    [EventSubscriber(ObjectType::Table, 18, OnAfterModifyEvent, '', true, true)]
    local procedure OnAfterModifyEvent(RunTrigger: Boolean; var Rec: Record Customer);
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin
        EnvioFicheros.MODIFCLIENTES(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 23, 'OnAfterOnInsert', '', true, true)]
    local procedure OnAfterOnInsertV(var Vendor: Record Vendor)
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin
        EnvioFicheros.ALTAPROVEE(Vendor);
    end;

    [EventSubscriber(ObjectType::Table, 23, OnAfterModifyEvent, '', true, true)]
    local procedure OnAfterModifyEventV(RunTrigger: Boolean; var Rec: Record Vendor);
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin
        EnvioFicheros.MODIFPROVEE(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterOnInsert', '', true, true)]
    local procedure OnAfterOnInsertProd(var Item: Record Item; xItem: Record Item)
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin

        EnvioFicheros.ALTAPROD(item);


    end;

    [EventSubscriber(ObjectType::Table, 27, OnAfterModifyEvent, '', true, true)]
    local procedure OnAfterModifyEventProd(RunTrigger: Boolean; var Rec: Record Item);
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin
        EnvioFicheros.MODIFPROD(Rec);
    end;

}
