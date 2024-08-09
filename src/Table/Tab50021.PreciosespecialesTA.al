#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50021 "Precios especiales TA"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;

            trigger OnValidate()
            begin

                /*
                IF "Item No." <> xRec."Item No." THEN BEGIN
                END;
                */

            end;
        }
        field(3; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                /*
                IF ("Ending Date" > "Ending Date") AND ("Ending Date" <> 0D) THEN
                  ERROR(Text000,FIELDCAPTION("Ending Date"),FIELDCAPTION("Ending Date"));
                  */

            end;
        }
        field(4; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(5; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;

            trigger OnValidate()
            begin

                /*
                RecCC.GET;
                pvptarifa:=0;
                RecSP.RESET;
                RecSP.SETRANGE(RecSP."Item No.","Item No.");
                RecSP.SETRANGE(RecSP."Sales Code",RecCC."Tarifa vigente");
                IF RecSP.FINDFIRST THEN BEGIN
                     pvptarifa:=RecSP."Unit Price";
                END;
                
                Descuento:=0;
                IF pvptarifa<>0 THEN BEGIN
                    Descuento:=100-ROUND("Unit Price"/pvptarifa*100,0.01);
                END;
                */

            end;
        }
        field(7; "Descripción"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(8; Cliente; Code[20])
        {
            TableRelation = Customer;
        }
    }

    keys
    {
        key(Key1; Cliente, "Item No.", "Starting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

