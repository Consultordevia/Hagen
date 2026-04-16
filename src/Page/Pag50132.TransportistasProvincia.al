#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50132 "Transportistas por Provincia"
{
    ApplicationArea = All;
    Caption = 'Transportistas por Provincia';
    PageType = List;
    SourceTable = "Transportistas Provincia";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Cod. Pais"; Rec."Cod. Pais")
                {
                    ApplicationArea = All;
                }
                field("Nombre Pais"; Rec."Nombre Pais")
                {
                    ApplicationArea = All;
                }
                field("Cod. Provincia"; Rec."Cod. Provincia")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        AreaRec: Record "Area";
                        AreaList: Page "Areas";
                    begin
                        if Rec."Cod. Pais" = '' then begin
                            Message('Seleccione primero el país.');
                            exit(false);
                        end;

                        // Filtra las provincias (Area) que tienen códigos postales
                        // asociados al país seleccionado.
                        AreaRec.Reset();
                        AreaRec.SetFilter(Code, GetAreaFilterForCountry(Rec."Cod. Pais"));
                        AreaList.SetTableView(AreaRec);
                        AreaList.LookupMode(true);
                        if AreaList.RunModal() = Action::LookupOK then begin
                            AreaList.GetRecord(AreaRec);
                            Text := AreaRec.Code;
                            Rec.Validate("Cod. Provincia", AreaRec.Code);
                            exit(true);
                        end;
                        exit(false);
                    end;
                }
                field(Provincia; Rec.Provincia)
                {
                    ApplicationArea = All;
                }
                field("Cod. Transportista"; Rec."Cod. Transportista")
                {
                    ApplicationArea = All;
                }
                field("Nombre Transportista"; Rec."Nombre Transportista")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    // Devuelve un filtro de códigos Area que existen en Post Code para el país dado.
    local procedure GetAreaFilterForCountry(CodPais: Code[10]): Text
    var
        PostCode: Record "Post Code";
        Filter: Text;
    begin
        PostCode.Reset();
        PostCode.SetRange("Country/Region Code", CodPais);
        PostCode.SetFilter("County Code", '<>%1', '');
        if PostCode.FindSet() then
            repeat
                if StrPos(Filter, PostCode."County Code") = 0 then begin
                    if Filter <> '' then
                        Filter += '|';
                    Filter += PostCode."County Code";
                end;
            until PostCode.Next() = 0;
        exit(Filter);
    end;
}
