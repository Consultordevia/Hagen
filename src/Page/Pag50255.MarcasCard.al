page 50255 "Marcas Card"
{
    ApplicationArea = All;
    Caption = 'Ficha Marca';
    PageType = Card;
    SourceTable = Multitabla;
    SourceTableView = where(Tabla = const(Marcas));
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Codigo"; Rec."Codigo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Código de la marca.';
                }
                field("Descripcion"; Rec."Descripcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripción de la marca.';
                }
                field(Orden; Rec.Orden)
                {
                    ApplicationArea = All;
                    ToolTip = 'Orden de visualización.';
                }
            }
            group(Imagen)
            {
                Caption = 'Imagen';
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Logo de la marca.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SubirImagen)
            {
                ApplicationArea = All;
                Caption = 'Subir imagen';
                Image = Import;
                ToolTip = 'Importa una imagen para el logo de la marca.';

                trigger OnAction()
                var
                    FileName: Text;
                    InStr: InStream;
                begin
                    if UploadIntoStream('Seleccionar imagen', '', 'Imágenes (*.jpg,*.jpeg,*.png,*.bmp)|*.jpg;*.jpeg;*.png;*.bmp', FileName, InStr) then begin
                        Clear(Rec.Picture);
                        Rec.Picture.ImportStream(InStr, FileName);
                        Rec.Modify(true);
                    end;
                end;
            }
            action(EliminarImagen)
            {
                ApplicationArea = All;
                Caption = 'Eliminar imagen';
                Image = Delete;
                ToolTip = 'Elimina la imagen del logo de la marca.';

                trigger OnAction()
                begin
                    if Confirm('¿Eliminar la imagen de esta marca?') then begin
                        Clear(Rec.Picture);
                        Rec.Modify(true);
                    end;
                end;
            }
        }
    }
}
