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

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterValidateEvent', 'Item Category Code', false, false)]

    procedure OnAfterValidateEventItemCategoryCode(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    var
        ItemCategory: Record "Item Category";
        ItemCategory1: Record "Item Category";
        ItemCategory2: Record "Item Category";
        ItemCategory3: Record "Item Category";
        ItemCategory4: Record "Item Category";
        ItemCategory5: Record "Item Category";
        ItemCategory6: Record "Item Category";
        ItemCategory7: Record "Item Category";
        ItemCategory8: Record "Item Category";
        ItemCategory9: Record "Item Category";
        ItemCategory10: Record "Item Category";
        Recitem: Record item;
        RecPMTemp: Record "Payment Method" temporary;
        conta: integer;
        v: Dialog;

    begin


        commit;
        RecItem.Reset();
        Recitem.SetRange("No.", Rec."No.");
        if RecItem.FindSet() then begin
            Message('%1 %2', Rec."No.", Rec."Item Category Code");
            ///     v.Update(1, RecItem."No.");
            RecPMTemp.Reset();
            if RecPMTemp.FindFirst() then
                repeat
                    RecPMTemp.Delete;
                until RecPMTemp.next = 0;
            Message('item categori %1', Recitem."Item Category Code");
            if Recitem."Item Category Code" <> '' then begin
                IF ItemCategory.get(Recitem."Item Category Code") THEN begin
                    ///Recitem.Level1 := ItemCategory.Description;
                    RecPMTemp.Code := '10';
                    RecPMTemp.Description := ItemCategory.Description;
                    RecPMTemp.Insert;
                    IF ItemCategory1.get(ItemCategory."Parent Category") THEN begin
                        ///Recitem.Level2 := ItemCategory1.Description;
                        RecPMTemp.Code := '09';
                        RecPMTemp.Description := ItemCategory1.Description;
                        RecPMTemp.Insert;
                        IF ItemCategory2.get(ItemCategory1."Parent Category") THEN begin
                            ///Recitem.Level3 := ItemCategory2.Description;
                            RecPMTemp.Code := '08';
                            RecPMTemp.Description := ItemCategory2.Description;
                            RecPMTemp.Insert;
                            IF ItemCategory3.get(ItemCategory2."Parent Category") THEN begin
                                ///Recitem.Level4 := ItemCategory3.Description;
                                RecPMTemp.Code := '07';
                                RecPMTemp.Description := ItemCategory3.Description;
                                RecPMTemp.Insert;
                                IF ItemCategory4.get(ItemCategory3."Parent Category") THEN begin
                                    ///Recitem.Level5 := ItemCategory4.Description;
                                    RecPMTemp.Code := '06';
                                    RecPMTemp.Description := ItemCategory4.Description;
                                    RecPMTemp.Insert;
                                    IF ItemCategory5.get(ItemCategory4."Parent Category") THEN begin
                                        ///Recitem.Level6 := ItemCategory5.Description;
                                        RecPMTemp.Code := '05';
                                        RecPMTemp.Description := ItemCategory5.Description;
                                        RecPMTemp.Insert;
                                        IF ItemCategory6.get(ItemCategory5."Parent Category") THEN begin
                                            ///Recitem.Level7 := ItemCategory6.Description;
                                            RecPMTemp.Code := '04';
                                            RecPMTemp.Description := ItemCategory7.Description;
                                            RecPMTemp.Insert;
                                            IF ItemCategory7.get(ItemCategory6."Parent Category") THEN begin
                                                ///Recitem.Level8 := ItemCategory7.Description;
                                                RecPMTemp.Code := '03';
                                                RecPMTemp.Description := ItemCategory7.Description;
                                                RecPMTemp.Insert;
                                                IF ItemCategory8.get(ItemCategory7."Parent Category") THEN begin
                                                    ///Recitem.Level9 := ItemCategory8.Description;
                                                    RecPMTemp.Code := '02';
                                                    RecPMTemp.Description := ItemCategory8.Description;
                                                    RecPMTemp.Insert;
                                                    IF ItemCategory9.get(ItemCategory8."Parent Category") THEN begin
                                                        ///Recitem.Level10 := ItemCategory9.Description;
                                                        RecPMTemp.Code := '01';
                                                        RecPMTemp.Description := ItemCategory9.Description;
                                                        RecPMTemp.Insert;

                                                    end;
                                                end;

                                            end;

                                        end;

                                    end;

                                end;

                            end;

                        end;

                    end;
                end;
            end;
            RecItem.Level1 := '';
            RecItem.Level2 := '';
            RecItem.Level3 := '';
            RecItem.Level4 := '';
            RecItem.Level5 := '';
            RecItem.Level6 := '';
            RecItem.Level7 := '';
            RecItem.Level8 := '';
            RecItem.Level9 := '';
            RecItem.Level10 := '';
            RecItem.Modify;
            Message('entra level');
            conta := 0;
            RecPMTemp.Reset();
            if RecPMTemp.FindFirst() then
                repeat
                    conta := conta + 1;
                    if conta = 1 then begin RecItem.Level1 := RecPMTemp.Description; RecItem.Modify; end;
                    if conta = 2 then begin RecItem.Level2 := RecPMTemp.Description; RecItem.Modify; end;
                    if conta = 3 then begin RecItem.Level3 := RecPMTemp.Description; RecItem.Modify; end;
                    if conta = 4 then begin RecItem.Level4 := RecPMTemp.Description; RecItem.Modify; end;
                    if conta = 5 then begin RecItem.Level5 := RecPMTemp.Description; RecItem.Modify; end;
                    if conta = 6 then begin RecItem.Level6 := RecPMTemp.Description; RecItem.Modify; end;
                    if conta = 7 then begin RecItem.Level7 := RecPMTemp.Description; RecItem.Modify; end;
                    if conta = 8 then begin RecItem.Level8 := RecPMTemp.Description; RecItem.Modify; end;
                    if conta = 9 then begin RecItem.Level9 := RecPMTemp.Description; RecItem.Modify; end;
                    if conta = 10 then begin RecItem.Level10 := RecPMTemp.Description; RecItem.Modify; end;
                until RecPMTemp.next = 0;
        end;
        Commit();
    end;
}
