pageextension 50026 ClientesLista extends "Customer List"
{

    layout
    {
        addafter("Salesperson Code")
        {



            field(NombreVendedor; NombreVendedor) { ApplicationArea = All; }
            field("Top produccto.1"; Rec."Top produccto 1") { ApplicationArea = All; }
            field("Top produccto.2"; Rec."Top produccto 2") { ApplicationArea = All; }
            field("Top produccto.3"; Rec."Top produccto 3") { ApplicationArea = All; }
            field("Top produccto.4"; Rec."Top produccto 4") { ApplicationArea = All; }
            field("Top produccto.5"; Rec."Top produccto 5") { ApplicationArea = All; }
            field("Top produccto.6"; Rec."Top produccto 6") { ApplicationArea = All; }
            field("Top produccto.7"; Rec."Top produccto 7") { ApplicationArea = All; }
            field("Top produccto.8"; Rec."Top produccto 8") { ApplicationArea = All; }
            field("Top produccto.9"; Rec."Top produccto 9") { ApplicationArea = All; }
            field("Top produccto.10"; Rec."Top produccto 10") { ApplicationArea = All; }
            field("Usuario Web"; Rec."Usuario Web") { ApplicationArea = All; }
            field("Grupo clientes"; Rec."Grupo clientes") { ApplicationArea = All; }
            field(Latitud; Rec.Latitud) { ApplicationArea = All; }
            field(Longitud; Rec.Longitud) { ApplicationArea = All; }




        }
    }
    trigger OnAfterGetRecord()
    begiN
        NombreVendedor := '';
        IF RecVendedores.get(Rec."Salesperson Code") then begin
            NombreVendedor := RecVendedores.Name;
        end;

    end;

    var

        RecVendedores: Record "Salesperson/Purchaser";
        NombreVendedor: text;
}
