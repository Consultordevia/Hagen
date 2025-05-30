pageextension 50058 MovsPRoductos extends "Item Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {

            field(Nombre; Nombre)
            { ApplicationArea = All; }

        }

    }

    trigger OnAfterGetRecord()

    begiN
        Nombre := '';
        IF Rec."Source Type" = Rec."Source Type"::Customer then begin
            RecClie.get(Rec."Source No.");
            Nombre := RecClie.Name;
        end;
        IF Rec."Source Type" = Rec."Source Type"::Vendor then begin
            RecVend.get(Rec."Source No.");
            Nombre := RecVend.Name;
        end;



    end;

    var

        Nombre: Text;
        RecClie: Record Customer;
        RecVend: Record Vendor;
}