codeunit 50007 CrearPedidosVenta
{
    trigger OnRun()
    var
        CabVenta: Record "CabVenta";
        LinVenta: Record LinVenta;
    begin
        CabVenta.reset;
        CabVenta.SetRange(CreadoSalesHeader, false);
        if CabVenta.FindSet() then begin
            repeat
                //SalesHeader.Init();                 // Inicializar el registro de Sales Header
                if FillSalesHeaderFromCustomTable(CabVenta) then begin
                    CabVenta.CreadoSalesHeader := true;
                    CabVenta.Error := '';
                    CabVenta.Modify();
                    //Commit();
                end else begin
                    CabVenta.Error := GetLastErrorText();
                    CabVenta.Modify();
                end;
            until CabVenta.Next() = 0;
        end;

        LinVenta.reset;
        LinVenta.SetRange(CreadoSalesHeader, false);
        if LinVenta.FindSet() then begin
            repeat
                //SalesHeader.Init();                 // Inicializar el registro de Sales Header
                if FillSalesHeaderFromCustomTable(LinVenta) then begin
                    LinVenta.Error := '';
                    LinVenta.CreadoSalesHeader := true;
                    LinVenta.Modify();
                    //Commit();
                end else begin
                    LinVenta.Error := GetLastErrorText();
                    LinVenta.Modify();
                end;
            until LinVenta.Next() = 0;
        end;
    end;

    [TryFunction]
    procedure FillSalesHeaderFromCustomTable(CabVenta: Record "CabVenta")
    var
        Field: Record Field;
        SourceRecordRef: RecordRef;
        DestRecordRef: RecordRef;
        SourceFieldRef: FieldRef;
        DestFieldRef: FieldRef;
        FieldDestino: Record Field;
        SalesHeader: Record "Sales Header";
    begin
        // Abrimos los RecordRefs para ambas tablas
        SourceRecordRef.Get(CabVenta.RecordId);
        DestRecordRef.Open(Database::"Sales Header");
        DestRecordRef.init;

        Field.reset;
        field.SetRange(TableNo, Database::"Sales Header");
        field.SetRange(ObsoleteState, Field.ObsoleteState::No);
        Field.SetRange(class, Field.class::Normal);
        if Field.FindSet() then begin
            repeat
                FieldDestino.reset;
                FieldDestino.SetRange(TableNo, Database::CabVenta);
                FieldDestino.SetRange("No.", Field."No.");
                FieldDestino.SetRange(ObsoleteState, Field.ObsoleteState::No);
                FieldDestino.SetRange(class, Field.class::Normal);
                if FieldDestino.FindFirst() then begin
                    SourceFieldRef := SourceRecordRef.Field(Field."No.");
                    if IsFieldFilled(SourceFieldRef) then begin
                        DestFieldRef := DestRecordRef.Field(Field."No.");
                        DestFieldRef.validate(SourceFieldRef.Value);
                    end;
                end;
            until Field.Next() = 0;
            DestRecordRef.Insert(true);
        end;
    end;

    [TryFunction]
    procedure FillSalesHeaderFromCustomTable(CabVenta: Record "LinVenta")
    var
        Field: Record Field;
        SourceRecordRef: RecordRef;
        DestRecordRef: RecordRef;
        SourceFieldRef: FieldRef;
        DestFieldRef: FieldRef;
        FieldDestino: Record Field;
        SalesHeader: Record "Sales Header";
    begin
        // Abrimos los RecordRefs para ambas tablas
        SourceRecordRef.Get(CabVenta.RecordId);
        DestRecordRef.Open(Database::"Sales Line");
        DestRecordRef.init;

        Field.reset;
        field.SetRange(TableNo, Database::"Sales Line");
        field.SetRange(ObsoleteState, Field.ObsoleteState::No);
        Field.SetRange(class, Field.class::Normal);
        if Field.FindSet() then begin
            repeat
                FieldDestino.reset;
                FieldDestino.SetRange(TableNo, Database::LinVenta);
                FieldDestino.SetRange("No.", Field."No.");
                FieldDestino.SetRange(ObsoleteState, Field.ObsoleteState::No);
                FieldDestino.SetRange(class, Field.class::Normal);
                if FieldDestino.FindFirst() then begin
                    SourceFieldRef := SourceRecordRef.Field(Field."No.");
                    if IsFieldFilled(SourceFieldRef) then begin
                        DestFieldRef := DestRecordRef.Field(Field."No.");
                        DestFieldRef.validate(SourceFieldRef.Value);
                    end;
                end;
            until Field.Next() = 0;
            DestRecordRef.Insert(true);
        end;
    end;

    local procedure IsFieldFilled(FieldRef: FieldRef): Boolean
    var
        FieldValue: Variant;
        Entero: Integer;
        Decimal: Decimal;
        Fecha: Date;
        FechaYHora: DateTime;
    begin
        FieldValue := FieldRef.Value;

        case FieldRef.Type of
            FieldType::Text, FieldType::Code:
                exit(Format(FieldValue) <> ''); // Convertimos a texto y comprobamos si no está vacío
            FieldType::Integer:
                begin
                    Evaluate(Entero, format(FieldValue));
                    exit(Entero <> 0); // Comprobamos si el valor numérico no es 0
                end;
            FieldType::Decimal:
                begin
                    Evaluate(Decimal, format(FieldValue));
                    exit(Decimal <> 0); // Comprobamos si el valor numérico no es 0
                end;
            FieldType::Date:
                begin
                    Evaluate(Fecha, format(FieldValue));
                    exit(Fecha <> 0D); // Comprobamos si el valor numérico no es 0
                end;
            FieldType::DateTime:
                begin
                    Evaluate(FechaYHora, format(FieldValue));
                    exit(FechaYHora <> 0DT); // Comprobamos si el valor numérico no es 0
                end;
            FieldType::Boolean:
                exit(FieldValue); // Un booleano está "relleno" si es verdadero
            else
                exit(true); // Para otros tipos, usamos IsNull para verificar si tiene datos
        end;
    end;
}
