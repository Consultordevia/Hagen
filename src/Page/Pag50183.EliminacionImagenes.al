page 50183 "Eliminacion Imagenes"
{
    PageType = List;
    SourceTable = "Eliminacion Imagenes Tmp";
    SourceTableTemporary = true;
    Caption = 'Eliminar imágenes de producto';
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº producto';
                    trigger OnValidate()
                    begin
                        UpdateItemInfo();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    Editable = false;
                }
                field("Has Picture"; Rec."Has Picture")
                {
                    ApplicationArea = All;
                    Caption = 'Tiene imagen';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(EliminarImagenes)
            {
                ApplicationArea = All;
                Caption = 'Eliminar imágenes';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    Item: Record Item;
                    Contador: Integer;
                begin
                    if not Confirm('¿Desea eliminar las imágenes de los productos de la lista? Esta acción no se puede deshacer.', false) then
                        exit;

                    Contador := 0;
                    if Rec.FindSet() then
                        repeat
                            if Item.Get(Rec."Item No.") then
                                if Item.Picture.Count > 0 then begin
                                    Clear(Item.Picture);
                                    Item.Modify();
                                    Contador += 1;
                                end;
                        until Rec.Next() = 0;

                    Message('Se han eliminado las imágenes de %1 producto(s).', Contador);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateItemInfo();
    end;

    local procedure UpdateItemInfo()
    var
        Item: Record Item;
    begin
        if Rec."Item No." = '' then begin
            Rec.Description := '';
            Rec."Has Picture" := false;
            exit;
        end;

        if Item.Get(Rec."Item No.") then begin
            Rec.Description := Item.Description;
            Rec."Has Picture" := Item.Picture.Count > 0;
        end else begin
            Rec.Description := '';
            Rec."Has Picture" := false;
        end;
    end;
}
