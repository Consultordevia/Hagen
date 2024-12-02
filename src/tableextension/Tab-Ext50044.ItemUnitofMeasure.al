tableextension 50044 ItemUnitofMeasure extends "Item Unit of Measure"
{
    fields
    {
        modify("Qty. per Unit of Measure")
        {
            trigger OnAfterValidate()
            var
                RecItem: Record Item;

            begin
                if CopyStr(COMPANYNAME, 1, 4) = 'ROLF' then begin
                    Commit;
                    RecItem.Reset;
                    RecItem.SetRange("No.", Rec."Item No.");
                    if RecItem.FindFirst then begin
                        CUADAIA.MODIFPROD(RecItem);
                    end;
                end;
            end;
        }

        field(50000; Description; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Caption = 'Description';
            FieldClass = FlowField;
        }
        field(50001; ean; Code[20])
        {
            trigger OnValidate()
            var
                Item: Record item;
            begin

                if ean = '' then begin
                    if Item.Get("Item No.") then begin
                        Item.ean := '';
                        Item.Modify;
                        Commit;
                    end;
                end;
                if (ean <> '') and (Code = 'UDS') then begin
                    if Item.Get("Item No.") then begin
                        Item.ean := ean;
                        Item.Modify;
                        Commit;
                    end;
                end;



                if CopyStr(COMPANYNAME, 1, 4) = 'ROLF' then begin
                    if ean <> '' then begin
                        RecRC2.Reset;
                        RecRC2.SetRange(RecRC2."Item No.", "Item No.");
                        RecRC2.SetRange(RecRC2."Unit of Measure", Code);
                        RecRC2.SetRange(RecRC2."Reference Type", 3);
                        RecRC2.SetRange(RecRC2."Reference No.", ean);
                        if not RecRC2.FindFirst then begin
                            RecRC2.Init;
                            RecRC2."Item No." := "Item No.";
                            RecRC2."Unit of Measure" := Code;
                            RecRC2."Reference Type" := 3;
                            RecRC2."Reference No." := ean;
                            RecRC2.Insert;
                            Commit;
                        end;
                        RecRC2.Reset;
                        RecRC2.SetRange(RecRC2."Item No.", "Item No.");
                        RecRC2.SetRange(RecRC2."Unit of Measure", Code);
                        RecRC2.SetRange(RecRC2."Reference Type", 3);
                        RecRC2.SetRange(RecRC2."Reference No.", xRec.ean);
                        if RecRC2.FindFirst then begin
                            ///           RecRC2.DELETE;
                            Commit;
                        end;



                    end;
                end;
            end;
        }
        field(50002; EXISTE; Boolean)
        {
            CalcFormula = exist(Item where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50003; "enviar a adaia"; Boolean)
        {
        }
        field(50004; "ean PROD"; Code[20])
        {
            CalcFormula = lookup(Item.ean where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50005; EXISTE2; Boolean)
        {
            CalcFormula = exist("Item Reference" where("Item No." = field("Item No."),
                                                              "Unit of Measure" = field(Code),
                                                              "Reference Type" = const("Bar Code")));
            FieldClass = FlowField;
        }
        field(50006; "Kgs/Volumen WEB"; Decimal)
        {
        }
        field(50007; "fecha modif"; Date)
        {
        }
    }

    trigger OnBeforeInsert()
    begin
        "enviar a adaia" := true;


        if CopyStr(COMPANYNAME, 1, 4) = 'ROLF' then begin
            RecItem.Reset;
            RecItem.SetRange("No.", Rec."Item No.");
            if RecItem.FindFirst then begin
                CUADAIA.MODIFPROD(RecItem);
            end;
        end;


        if GuiAllowed then begin
            if CopyStr(COMPANYNAME, 1, 4) = 'ROLF' then begin
                RecA.Reset;
                RecA.ChangeCompany('HAGEN CANARIAS S.C.');
                if RecA.Get("Item No.", Code) then begin
                    RecA := Rec;
                    RecA.Modify;
                end;
                if not RecA.Get("Item No.", Code) then begin
                    RecA := Rec;
                    RecA.Insert;
                end;
            end;
        end;
    end;

    trigger OnBeforeModify()
    begin
        "fecha modif" := Today;
        "enviar a adaia" := true;


        if CopyStr(COMPANYNAME, 1, 4) = 'ROLF' then begin
            Commit;
            RecItem.Reset;
            RecItem.SetRange("No.", Rec."Item No.");
            if RecItem.FindFirst then begin
                ///CUADAIA.MODIFPROD(RecItem);
            end;
        end;




        if GuiAllowed then begin
            if CopyStr(COMPANYNAME, 1, 4) = 'ROLF' then begin
                RecA.Reset;
                RecA.ChangeCompany('HAGEN CANARIAS S.C.');
                if RecA.Get("Item No.", Code) then begin
                    RecA := Rec;
                    RecA.Modify;
                end;
                if not RecA.Get("Item No.", Code) then begin
                    RecA := Rec;
                    RecA.Insert;
                end;
            end;
        end;
    end;

    var
        RecA: Record "Item Unit of Measure";
        RecUMPepe: Record "Item Unit of Measure";
        RecRC: Record "Item Reference";
        RecRC2: Record "Item Reference";
        RecItem: Record Item;
        xx: Integer;
        Rec1: Record "Item Unit of Measure";
        Item2: Record Item;
        Item3: Record Item;
        RecItemPepe: Record Item;
        RecCE: Record "Inventory Setup";
        CUADAIA: Codeunit "Automaticos Cartas";
}
