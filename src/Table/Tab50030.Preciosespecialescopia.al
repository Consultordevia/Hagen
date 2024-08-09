#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50030 "Precios especiales copia"
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
        field(2; "Minimum Quantity"; Decimal)
        {
            Caption = 'Minimum Quantity';
            MinValue = 0;
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
        field(6; NETO; Boolean)
        {

            trigger OnValidate()
            begin
                /*
                Rec91.GET(USERID);
                IF NOT Rec91.Super THEN BEGIN
                     ERROR('No tiene permiso a modificar este campo.');
                END;
                */

            end;
        }
        field(7; "Descripción"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50001; "Clasificación A,B,C"; Option)
        {
            CalcFormula = lookup(Item."Clasificación A,B,C" where("No." = field("Item No.")));
            FieldClass = FlowField;
            InitValue = C;
            OptionMembers = A,B,C;
        }
        field(50018; "Estado Producto"; Option)
        {
            CalcFormula = lookup(Item."Estado Producto" where("No." = field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = Activo,Descatalogado,Anulado,"Sin actualizar";
        }
        field(50024; Familia; Code[50])
        {
            CalcFormula = lookup(Item.Familia where("No." = field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50025; Descuento; Decimal)
        {

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
                
                
                IF Descuento<>0 THEN BEGIN
                    "Unit Price":=pvptarifa-ROUND(pvptarifa*Descuento/100,0.01);
                END;
                */

            end;
        }
        field(50027; Visible; Boolean)
        {
        }
        field(50028; "no existe"; Boolean)
        {
            CalcFormula = exist(Item where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50029; PVP; Decimal)
        {
        }
        field(50030; DTO; Decimal)
        {
        }
        field(50031; "Tiene hijos"; Boolean)
        {
            CalcFormula = exist(Item where("Producto PADRE" = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50033; "Producto padre"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

