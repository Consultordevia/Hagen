tableextension 50016 ItemVendor extends "Item Vendor"
{
    fields
    {
        field(50000; cod; Text[50])
        {
            CalcFormula = lookup(Item."Vendor Item No." where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
    }

    var
        RecA: Record "Item Vendor";

    trigger OnAfterInsert()
    begin
        if GuiAllowed then begin
            if CopyStr(COMPANYNAME, 1, 4) = 'ROLF' then begin
                RecA.Reset;
                RecA.ChangeCompany('HAGEN CANARIAS S.C.');
                if RecA.Get("Vendor No.", "Item No.", "Variant Code") then begin
                    RecA := Rec;
                    RecA.Modify;
                end;
                if not RecA.Get("Vendor No.", "Item No.", "Variant Code") then begin
                    RecA := Rec;
                    RecA.Insert;
                end;
            end;
        end;
    end;

    trigger OnAfterModify()
    begin
        if GuiAllowed then begin
            if CopyStr(COMPANYNAME, 1, 4) = 'ROLF' then begin
                RecA.Reset;
                RecA.ChangeCompany('HAGEN CANARIAS S.C.');
                if RecA.Get("Vendor No.", "Item No.", "Variant Code") then begin
                    RecA := Rec;
                    RecA.Modify;
                end;
                if not RecA.Get("Vendor No.", "Item No.", "Variant Code") then begin
                    RecA := Rec;
                    RecA.Insert;
                end;
            end;
        end;
    end;
}
