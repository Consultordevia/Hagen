tableextension 50046 "SalesPrice" extends "Sales Price"
{
    fields
    {
        field(50000; "Precio recomendado"; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                RecSLPepe.CHANGECOMPANY('PEPE');
                RecSLPepe.SETRANGE(RecSLPepe."Item No.","Item No.");
                RecSLPepe.SETRANGE(RecSLPepe."Sales Type","Sales Type");
                RecSLPepe.SETRANGE(RecSLPepe."Sales Code","Sales Code");
                IF RecSLPepe.FINDLAST THEN BEGIN
                     RecSLPepe."Precio recomendado":=Rec."Precio recomendado";
                     RecItem.CHANGECOMPANY('PEPE');
                     RecItem.GET("Item No.");
                     preciosiniva:=Rec."Precio recomendado";
                     RecCGI.CHANGECOMPANY('PEPE');
                     RecCGI.RESET;
                     RecCGI.SETRANGE(RecCGI."VAT Bus. Posting Group",'NACIONAL');
                     RecCGI.SETRANGE(RecCGI."VAT Prod. Posting Group",RecItem."VAT Prod. Posting Group");
                     IF RecCGI.FINDFIRST THEN BEGIN
                          preciosiniva:=ROUND("Precio recomendado"/(1+(RecCGI."VAT+EC %"/100)),0.01);
                     END;
                     RecSLPepe."Unit Price":=preciosiniva;

                     RecSLPepe.MODIFY;
                END;
                 */

            end;
        }
        field(50001; "Descripción"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; EXISTE; Boolean)
        {
            CalcFormula = exist(Item where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50003; INCREMENTO; Decimal)
        {
        }
        field(50004; "EXISTE COD PADRE"; Code[20])
        {
            CalcFormula = lookup(Item."Producto PADRE" where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50005; NETO; Boolean)
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
        field(50006; "EXISTE 2012"; Boolean)
        {
            CalcFormula = exist("Sales Price" where("Item No." = field("Item No."),
                                                     "Sales Code" = const('2012')));
            FieldClass = FlowField;
        }
        field(50007; "Precio incial"; Decimal)
        {
        }
        field(50008; Dto1; Decimal)
        {
        }
        field(50009; Dto2; Decimal)
        {
        }
        field(50010; Dto3; Decimal)
        {
        }
        field(50098; "Ref. hagen"; Code[20])
        {

            trigger OnValidate()
            begin
                /*
                     IF RecItem2.GET("Item No.") THEN BEGIN
                          RecItem2."Ref. AMAZON":="Ref. hagen";
                          RecItem2.MODIFY;
                     END;
                     */

            end;
        }
        field(50099; "Ref. hagen 2"; Code[20])
        {
            CalcFormula = lookup(Item."Ref. hagen" where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50100; cuantos; Integer)
        {
            CalcFormula = count("Sales Price" where("Item No." = field("Item No."), "Sales Code" = field("Sales Code")));
            FieldClass = FlowField;
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
        field(50105; "Codigo INNER o MASTET"; Code[10])
        {

            trigger OnValidate()
            begin
                "Codigo concatenado" := "Item No." + "Codigo INNER o MASTET";
            end;
        }
        field(50106; "Codigo concatenado"; Code[20])
        {
        }
        field(50107; ean; Code[50])
        {
            CalcFormula = lookup("Item Reference"."Reference No." where("Item No." = field("Item No."), "Unit of Measure" = field("Unit of Measure Code")));
            FieldClass = FlowField;
        }
        field(50108; "Cantidad unidades medida"; Decimal)
        {
            CalcFormula = lookup("Item Unit of Measure"."Qty. per Unit of Measure" where("Item No." = field("Item No."), Code = field("Unit of Measure Code")));
            FieldClass = FlowField;
        }
        field(50109; "Producto_web"; Boolean)
        {
        }


    }
}
