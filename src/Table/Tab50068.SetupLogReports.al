table 50068 "Setup Log Reports"
{
    Caption = 'Setup Log Reports';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(10; "Desactivar Impresion"; Boolean)
        {
            Caption = 'Desactivar impresión (modo prueba)';
            ToolTip = 'Si está activado, la cola y los informes de albarán NO imprimen: solo registran en el Log Impresion Reports.';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure GetSetup()
    begin
        if not Get() then begin
            Init();
            "Primary Key" := '';
            Insert();
        end;
    end;
}
