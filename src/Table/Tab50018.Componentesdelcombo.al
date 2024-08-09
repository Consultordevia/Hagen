#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50018 "Componentes del combo"
{

    fields
    {
        field(1; "Parent Item No."; Code[20])
        {
            Caption = 'Parent Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            InitValue = Item;
            OptionCaption = ' ,Item,Resource';
            OptionMembers = " ",Item,Resource;

            trigger OnValidate()
            begin
                /*
                "No." := '';
                */

            end;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Item)) Item
            else if (Type = const(Resource)) Resource;

            trigger OnValidate()
            begin
                /*
                TESTFIELD(Type);
                IF "No." = '' THEN
                  EXIT;
                
                CASE Type OF
                  Type::Item:
                    BEGIN
                      Item.GET("No.");
                      Item.CALCFIELDS("Bill of Materials");
                      "Bill of Materials" := Item."Bill of Materials";
                      Description := Item.Description;
                      "Unit of Measure Code" := Item."Base Unit of Measure";
                    END;
                  Type::Resource:
                    BEGIN
                      Res.GET("No.");
                      "Bill of Materials" := FALSE;
                      Description := Res.Name;
                      "Unit of Measure Code" := Res."Base Unit of Measure";
                    END;
                END;
                */

            end;
        }
        field(5; "Bill of Materials"; Boolean)
        {
            CalcFormula = exist("BOM Component" where(Type = const(Item),
                                                       "Parent Item No." = field("No.")));
            Caption = 'Bill of Materials';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."))
            else if (Type = const(Resource)) "Unit of Measure";
        }
        field(8; "Quantity per"; Decimal)
        {
            Caption = 'Quantity per';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(14; "BOM Description"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Parent Item No.")));
            Caption = 'BOM Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; Desde; Date)
        {

            trigger OnValidate()
            begin
                /*
                IF Hasta=0D THEN BEGIN
                     Hasta:=TODAY;
                END;
                */

            end;
        }
        field(50001; Hasta; Date)
        {

            trigger OnValidate()
            begin
                /*
                IF Desde<>0D THEN BEGIN
                     IF Hasta=0D THEN BEGIN
                          Hasta:=TODAY;
                     END;
                END;
                */

            end;
        }
        field(50002; "% descuento"; Decimal)
        {
        }
        field(50003; Cantidad; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                IF Rec.Cantidad>xRec.Cantidad THEN BEGIN
                     ERROR('No se pueden pedir mas de %1',xRec.Cantidad);
                END;
                
                Pedir:=TRUE;
                */

            end;
        }
        field(50004; Pedir; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Parent Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

