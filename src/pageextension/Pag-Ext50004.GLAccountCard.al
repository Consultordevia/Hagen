pageextension 50004 "G/L Account Card" extends "G/L Account Card"
{
    layout
    {
        addlast(content)
        {
            group(Hagen)
            {
                field("Linea Retencion IRPF"; Rec."Linea Retencion IRPF")
                {
                    ApplicationArea = All;
                }
            }
            group(ImagenGrupo)
            {
                Caption = 'Imagen';
                field("Imagen Cuenta"; Rec."Imagen Cuenta")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Imagen de la cuenta contable.';
                }
            }
        }
    }

    actions
    {
        addlast(processing)
        {
            action(SubirImagenCuenta)
            {
                ApplicationArea = All;
                Caption = 'Subir imagen';
                Image = Import;
                ToolTip = 'Importa una imagen para la cuenta contable.';

                trigger OnAction()
                var
                    FileName: Text;
                    InStr: InStream;
                begin
                    if UploadIntoStream('Seleccionar imagen', '', 'Imágenes (*.jpg,*.jpeg,*.png,*.bmp)|*.jpg;*.jpeg;*.png;*.bmp', FileName, InStr) then begin
                        Clear(Rec."Imagen Cuenta");
                        Rec."Imagen Cuenta".ImportStream(InStr, FileName);
                        Rec.Modify(true);
                    end;
                end;
            }
            action(EliminarImagenCuenta)
            {
                ApplicationArea = All;
                Caption = 'Eliminar imagen';
                Image = Delete;
                ToolTip = 'Elimina la imagen de la cuenta contable.';

                trigger OnAction()
                begin
                    if Confirm('¿Eliminar la imagen de esta cuenta contable?') then begin
                        Clear(Rec."Imagen Cuenta");
                        Rec.Modify(true);
                    end;
                end;
            }
        }
    }
}
