#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50001 "Sales Line Discount Padre"
{
    Caption = 'Sales Line Discount Padre';
    //LookupPageID = UnknownPage50022;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            TableRelation = if (Type = const(Item)) Item
            else if (Type = const("Item Disc. Group")) "Item Discount Group";

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if xRec.Code <> Code then begin
                    "Unit of Measure Code" := '';
                    "Variant Code" := '';

                    if Type = Type::Item then
                        if Item.Get(Code) then
                            "Unit of Measure Code" := Item."Sales Unit of Measure"
                end;
            end;
        }
        field(2; "Sales Code"; Code[20])
        {
            Caption = 'Sales Code';
            TableRelation = if ("Sales Type" = const("Customer Disc. Group")) "Customer Discount Group"
            else if ("Sales Type" = const(Customer)) Customer
            else if ("Sales Type" = const(Campaign)) Campaign;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if "Sales Code" <> '' then
                    case "Sales Type" of
                        "sales type"::"All Customers":
                            Error(Text001, FieldCaption("Sales Code"));
                        "sales type"::Campaign:
                            begin
                                Campaign.Get("Sales Code");
                                "Starting Date" := Campaign."Starting Date";
                                "Ending Date" := Campaign."Ending Date";
                            end;
                    end;
            end;
        }
        field(3; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
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
        field(13; "Sales Type"; Option)
        {
            Caption = 'Sales Type';
            OptionCaption = 'Customer,Customer Disc. Group,All Customers,Campaign';
            OptionMembers = Customer,"Customer Disc. Group","All Customers",Campaign;

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
        field(21; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Item,Item Disc. Group';
            OptionMembers = Item,"Item Disc. Group";

            trigger OnValidate()
            begin
                if xRec.Type <> Type then
                    Validate(Code, '');
            end;
        }
        field(5400; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field(Code));

            trigger OnValidate()
            begin
                TestField(Type, Type::Item);
            end;
        }
        field(5700; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field(Code));

            trigger OnValidate()
            begin
                TestField(Type, Type::Item);
            end;
        }
        field(50000; "Descripción"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Oferta de descuento"; Boolean)
        {
        }
        field(50002; Vigente; Boolean)
        {
        }
        field(50134; "Producto en promocion"; Boolean)
        {
        }
        field(50135; "+ Linea"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50136; "+ Familia"; BigInteger)
        {

            trigger OnValidate()
            begin
                //"Actualizar WEB" := TRUE;
            end;
        }
        field(50137; "+ Familia 2"; BigInteger)
        {

            trigger OnValidate()
            begin

                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50138; "+ Familia 3"; BigInteger)
        {

            trigger OnValidate()
            begin

                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50139; "+ Familia 4"; BigInteger)
        {

            trigger OnValidate()
            begin

                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50140; "+ Subfamilia"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50141; "+ Subfamilia 2"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50142; "+ Subfamilia 3"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50143; "+ Subfamilia 4"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50144; "+ Familia 1"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50145; "+ Subfamilia 1"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50146; "+ Linea 1"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50147; "+ Linea 2"; BigInteger)
        {

            trigger OnValidate()
            begin
                ///"Actualizar WEB" := TRUE;
            end;
        }
        field(50148; "+ Linea 3"; BigInteger)
        {

            trigger OnValidate()
            begin
                ////"Actualizar WEB" := TRUE;
            end;
        }
        field(50149; "+ Linea 4"; BigInteger)
        {

            trigger OnValidate()
            begin
                ////"Actualizar WEB" := TRUE;
            end;
        }
    }

    keys
    {
        key(Key1; Type, "Code", "Sales Type", "Sales Code", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity")
        {
            Clustered = true;
        }
        key(Key2; "Sales Type", "Sales Code", Type, "Code", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "Sales Type", "Sales Code", "Line Discount %", Type, "Code", "Starting Date", "Ending Date")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Sales Type" = "sales type"::"All Customers" then
            "Sales Code" := ''
        else
            TestField("Sales Code");
        TestField(Code);
    end;

    trigger OnRename()
    begin
        if "Sales Type" <> "sales type"::"All Customers" then
            TestField("Sales Code");
        TestField(Code);
    end;

    var
        Text000: label '%1 cannot be after %2';
        Text001: label '%1 must be blank.';
        Campaign: Record Campaign;
        Text003: label 'You can only change the %1 and %2 from the Campaign Card when %3 = %4.';
}

