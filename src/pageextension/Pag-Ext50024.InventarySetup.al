pageextension 50024 "Inventary Setup" extends "Inventory Setup"
{
    layout
    {
        addlast(content)
        {
            group(Hagen)
            {
                field("Ruta edi-eci"; Rec."Ruta edi-eci") { ApplicationArea = All; }
                field("Ruta edi-eci copia"; Rec."Ruta edi-eci copia") { ApplicationArea = All; }
                field("Ruta fichero COVALDROPER"; Rec."Ruta fichero COVALDROPER") { ApplicationArea = All; }
                field("Ruta fichero COVALDROPER COPIA"; Rec."Ruta fichero COVALDROPER COPIA") { ApplicationArea = All; }
                field("Ruta salida a_gestion"; Rec."Ruta salida a_gestion") { ApplicationArea = All; }
                field("Ruta salida a_gestion copia"; Rec."Ruta salida a_gestion copia") { ApplicationArea = All; }
                field("Ruta salida de_gestion"; Rec."Ruta salida de_gestion") { ApplicationArea = All; }
                field("Ruta salida incial adaia"; Rec."Ruta salida incial adaia") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        addlast(processing)
        {
            action(EliminarImagenesProducto)
            {
                ApplicationArea = All;
                Caption = 'Eliminar imágenes de producto';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ClearLog;
                trigger OnAction()
                var
                    EliminacionImagenesPage: Page "Eliminacion Imagenes";
                begin
                    EliminacionImagenesPage.RunModal();
                end;
            }
            action(ExportarImagenesProducto)
            {
                ApplicationArea = All;
                Caption = 'Exportar imágenes de producto';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ExportFile;
                trigger OnAction()
                var
                    RecItem: Record Item;
                    TenantMedia: Record "Tenant Media";
                    DataCompression: Codeunit "Data Compression";
                    TempBlob: Codeunit "Temp Blob";
                    InStr: InStream;
                    ZipOutStr: OutStream;
                    ZipInStr: InStream;
                    EntryName: Text;
                    FileName: Text;
                    Counter: Integer;
                begin
                    DataCompression.CreateZipArchive();
                    Counter := 0;

                    RecItem.Reset();
                    if RecItem.FindSet() then
                        repeat
                            if RecItem.Picture.Count > 0 then begin
                                if TenantMedia.Get(RecItem.Picture.Item(1)) then begin
                                    TenantMedia.CalcFields(Content);
                                    if TenantMedia.Content.HasValue() then begin
                                        TenantMedia.Content.CreateInStream(InStr);
                                        EntryName := RecItem."No." + GetImageExtension(TenantMedia."Mime Type");
                                        DataCompression.AddEntry(InStr, EntryName);
                                        Counter += 1;
                                    end;
                                end;
                            end;
                        until RecItem.Next() = 0;

                    if Counter = 0 then begin
                        Message('No se encontraron imágenes de productos.');
                        exit;
                    end;

                    TempBlob.CreateOutStream(ZipOutStr);
                    DataCompression.SaveZipArchive(ZipOutStr);
                    DataCompression.CloseZipArchive();

                    TempBlob.CreateInStream(ZipInStr);
                    FileName := 'ImagenesProductos.zip';
                    DownloadFromStream(ZipInStr, 'Exportar imágenes de producto', '', 'Archivos ZIP (*.zip)|*.zip', FileName);
                end;
            }
        }
    }

    local procedure GetImageExtension(MimeType: Text): Text
    begin
        case LowerCase(MimeType) of
            'image/jpeg', 'image/jpg':
                exit('.jpg');
            'image/png':
                exit('.png');
            'image/gif':
                exit('.gif');
            'image/bmp':
                exit('.bmp');
            'image/webp':
                exit('.webp');
            else
                exit('.jpg');
        end;
    end;

}
