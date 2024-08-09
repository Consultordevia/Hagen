#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50049 Promociones
{
    Caption = 'Promociones';

    fields
    {
        field(1; Producto; Code[20])
        {
            Caption = 'Producto';
            NotBlank = true;
            TableRelation = Item;

            trigger OnValidate()
            var
                Item: Record Item;
            begin
            end;
        }
        field(2; "Sales Code"; Code[20])
        {
            Caption = 'Sales Code';
            TableRelation = "Customer Price Group";
        }
        field(3; "Producto regalo"; Code[20])
        {
            Caption = 'Producto regalo';
            TableRelation = Item;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                if ("Starting Date" > "Ending Date") and ("Ending Date" <> 0D) then
                    Error(Text000, FieldCaption("Starting Date"), FieldCaption("Ending Date"));

                if CurrFieldNo = 0 then
                    exit;
                if "Sales Type" = "sales type"::Campaign then
                    Error(Text003, FieldCaption("Starting Date"), FieldCaption("Ending Date"), FieldCaption("Sales Type"), "Sales Type");
            end;
        }
        field(5; "Line Discount %"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Line Discount %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(10; "Grupo clientes"; Code[10])
        {
            TableRelation = Multitabla.Código where(Tabla = const("Grupo de clientes"));
        }
        field(13; "Sales Type"; Option)
        {
            Caption = 'Sales Type';
            OptionCaption = 'Customer,Customer Disc. Group,All Customers,Campaign,Regalo';
            OptionMembers = Customer,"Customer Disc. Group","All Customers",Campaign,Regalo;

            trigger OnValidate()
            begin
                if "Sales Type" <> xRec."Sales Type" then
                    Validate("Sales Code", '');
            end;
        }
        field(14; "Minimum Quantity"; Decimal)
        {
            Caption = 'Minimum Quantity';
            MinValue = 0;
        }
        field(15; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                Validate("Starting Date");

                if CurrFieldNo = 0 then
                    exit;
                if "Sales Type" = "sales type"::Campaign then
                    Error(Text003, FieldCaption("Starting Date"), FieldCaption("Ending Date"), FieldCaption("Sales Type"), "Sales Type");
            end;
        }
        field(16; "Cantiada a regalar"; Decimal)
        {
        }
        field(17; Cliente; Code[10])
        {
            TableRelation = Customer;
        }
        field(50003; "Fecha alta"; DateTime)
        {
        }
        field(50101; "Fecha modif"; Date)
        {
        }
        field(50102; "Hora modif"; Time)
        {
        }
        field(50103; "Fecha hora modif"; DateTime)
        {
        }
        field(50104; "Fecha hora modif web"; DateTime)
        {
        }
        field(50105; "Pdte. Enviar a WEB"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Producto, "Sales Type", "Sales Code", "Starting Date", "Producto regalo", "Minimum Quantity")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        /*fieldgroup(Brick;"Sales Type","Sales Code","Line Discount %",Field21,Producto,"Starting Date","Ending Date")
        {
        }*/
    }

    trigger OnInsert()
    begin
        if "Sales Type" = "sales type"::"All Customers" then
            "Sales Code" := ''
        else
            TestField("Sales Code");
        TestField(Producto);

        "Fecha modif" := Today;
        "Hora modif" := Time;
        "Fecha hora modif" := CreateDatetime(Today, Time);
        "Fecha hora modif web" := CreateDatetime(0D, 0T);
        "Pdte. Enviar a WEB" := true;
    end;

    trigger OnModify()
    begin

        "Fecha modif" := Today;
        "Hora modif" := Time;
        "Fecha hora modif" := CreateDatetime(Today, Time);
        "Fecha hora modif web" := CreateDatetime(0D, 0T);
        "Pdte. Enviar a WEB" := true;
    end;

    trigger OnRename()
    begin
        if "Sales Type" <> "sales type"::"All Customers" then
            TestField("Sales Code");
        TestField(Producto);
    end;

    var
        Text000: label '%1 cannot be after %2';
        Text001: label '%1 must be blank.';
        Campaign: Record Campaign;
        Text003: label 'You can only change the %1 and %2 from the Campaign Card when %3 = %4.';
}

