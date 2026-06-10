codeunit 50104 "Descargar Imagenes Oferta"
{
    // Genera un archivo ZIP con las imágenes (campo Picture) de los productos
    // de las líneas de una oferta de venta y lo descarga en el equipo del usuario.

    procedure DescargarImagenesProducto(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        Item: Record Item;
        TenantMedia: Record "Tenant Media";
        DataCompression: Codeunit "Data Compression";
        TempBlobZip: Codeunit "Temp Blob";
        ItemsProcesados: List of [Code[20]];
        ImageInStream: InStream;
        ZipOutStream: OutStream;
        ZipInStream: InStream;
        MediaId: Guid;
        Index: Integer;
        ImageCount: Integer;
        FileName: Text;
        EntryName: Text;
    begin
        DataCompression.CreateZipArchive();

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter("No.", '<>%1', '');
        if SalesLine.FindSet() then
            repeat
                // Evitar procesar el mismo producto varias veces si se repite en líneas
                if not ItemsProcesados.Contains(SalesLine."No.") then begin
                    ItemsProcesados.Add(SalesLine."No.");
                    if Item.Get(SalesLine."No.") then
                        for Index := 1 to Item.Picture.Count() do begin
                            MediaId := Item.Picture.Item(Index);
                            TenantMedia.SetAutoCalcFields(Content);
                            if TenantMedia.Get(MediaId) then
                                if TenantMedia.Content.HasValue() then begin
                                    TenantMedia.Content.CreateInStream(ImageInStream);
                                    EntryName := BuildEntryName(Item."No.", Index, Item.Picture.Count(), TenantMedia."Mime Type");
                                    DataCompression.AddEntry(ImageInStream, EntryName);
                                    ImageCount += 1;
                                end;
                        end;
                end;
            until SalesLine.Next() = 0;

        if ImageCount = 0 then begin
            DataCompression.CloseZipArchive();
            Message(NoImagesMsg);
            exit;
        end;

        TempBlobZip.CreateOutStream(ZipOutStream);
        DataCompression.SaveZipArchive(ZipOutStream);
        DataCompression.CloseZipArchive();

        TempBlobZip.CreateInStream(ZipInStream);
        FileName := StrSubstNo(ZipFileNameTok, SalesHeader."No.");
        DownloadFromStream(ZipInStream, '', '', '', FileName);

        Message(DoneMsg, ImageCount);
    end;

    local procedure BuildEntryName(ItemNo: Code[20]; Index: Integer; Total: Integer; MimeType: Text): Text
    var
        BaseName: Text;
    begin
        // Limpia caracteres no válidos para nombres de fichero dentro del ZIP
        BaseName := DelChr(ItemNo, '=', '\/:*?"<>|');
        if Total > 1 then
            exit(StrSubstNo('%1_%2.%3', BaseName, Index, MimeToExtension(MimeType)));
        exit(StrSubstNo('%1.%2', BaseName, MimeToExtension(MimeType)));
    end;

    local procedure MimeToExtension(MimeType: Text): Text
    begin
        case LowerCase(MimeType) of
            'image/jpeg', 'image/jpg':
                exit('jpg');
            'image/png':
                exit('png');
            'image/gif':
                exit('gif');
            'image/bmp':
                exit('bmp');
            'image/tiff':
                exit('tiff');
            'image/webp':
                exit('webp');
            else
                exit('jpg');
        end;
    end;

    var
        NoImagesMsg: Label 'No se han encontrado imágenes de producto en las líneas de esta oferta.';
        DoneMsg: Label 'Se han comprimido %1 imágenes de producto.', Comment = '%1 = número de imágenes';
        ZipFileNameTok: Label 'Imagenes_Oferta_%1.zip', Locked = true;
}
