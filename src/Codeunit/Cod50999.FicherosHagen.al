codeunit 50999 FicherosHagen
{
    procedure CrearFichero(URL: TEXT; NombreFichero: text; fichero: InStream)
    var
        Base64Text: Text;
        Base64Convert: Codeunit "Base64 Convert";
        Body: Text;
        Content: HttpContent;
        gheaders: HttpHeaders;
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
    begin
        Base64Text := Base64Convert.ToBase64(fichero);

        Body := '{';
        Body += '"path": "' + URL.replace('\', '\\') + '",';
        Body += '"fileName": "' + NombreFichero + '",';
        Body += '"fileContent": "' + Base64Text + '"';
        //Body += '"desde": "' + SalesReceivablesSetup."Path Input Voxel" + '",';
        //Body += '"hasta": "' + SalesReceivablesSetup."Path Input Processed Voxel" + '"';
        Body += '}';
        //Flow Moure fitxer únic
        URL := 'https://prod-183.westeurope.logic.azure.com:443/workflows/40144355390341d987b3d19cfa04905a/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=-6-QUvQxsQdwtao0TJbPVBii41Z0rhht-xR37T0FzBo';

        Content.WriteFrom(Body);
        Content.GetHeaders(gheaders);
        gheaders.Remove('Content-Type');
        gheaders.Remove('Content-Length');
        gheaders.Add('Content-Type', 'application/json');

        Client.Clear();
        Client.DefaultRequestHeaders.Add('accept', 'application/json');

        Client.Post(URL, Content, ResponseMessage);
        if ResponseMessage.IsSuccessStatusCode then begin
            //exit(true);
        end else begin
            Error(ResponseMessage.ReasonPhrase);
            //exit(false);
        end;
    end;

    procedure LeerArchivosCarpeta(Path: text; hasta: text; Tipo: enum Ficherets);
    var
        NameValueBuffer: Record "Name/Value Buffer" temporary;
        InStream: InStream;
        IsOK: Boolean;
        Content: HttpContent;
        gheaders: HttpHeaders;
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        FileManagement: Codeunit "File Management";
        Body: Text;
        URL: Text;
    begin
        NameValueBuffer.RESET;
        NameValueBuffer.DELETEALL(FALSE);
        GetFilesFromPath(NameValueBuffer, Path);

        NameValueBuffer.RESET;
        ///NameValueBuffer.SetFilter(Value, '<>%1', '');
        NameValueBuffer.SetRange(id, 2, 9999999);
        IF NameValueBuffer.FINDSET THEN
            REPEAT
                ///Message('upload %1', NameValueBuffer.Name);

                UploadFile(NameValueBuffer.Name, Tipo);

                IF hasta <> '' THEN BEGIN
                    // FILE.COPY(NameValueBuffer.Name, SalesReceivablesSetup."Path Input Processed Voxel" + FileManagement.GetFileName(NameValueBuffer.Name)); // XML
                    // FILE.ERASE(NameValueBuffer.Name);
                    Body := '{';
                    Body += '"name": "' + FileManagement.GetFileName(NameValueBuffer.Name) + '",';
                    Body += '"desde": "' + path.replace('\', '\\') + '",';
                    Body += '"hasta": "' + hasta.replace('\', '\\') + '"';
                    //Body += '"desde": "' + SalesReceivablesSetup."Path Input Voxel" + '",';
                    //Body += '"hasta": "' + SalesReceivablesSetup."Path Input Processed Voxel" + '"';
                    Body += '}';
                    //Flow Moure fitxer únic
                    URL := 'https://prod-09.westeurope.logic.azure.com:443/workflows/7db12e79978a4b6e94d0af91ab1ce686/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=ZmHmE6RxJHyq1OTJWvR1JD06EEv9IuVI9jRa_I-uais';


                    //if Tipo = tipo::Voxel then begin
                    Content.WriteFrom(Body);
                    Content.GetHeaders(gheaders);
                    gheaders.Remove('Content-Type');
                    gheaders.Remove('Content-Length');
                    gheaders.Add('Content-Type', 'application/json');

                    Client.Clear();
                    Client.DefaultRequestHeaders.Add('accept', 'application/json');

                    Client.Post(URL, Content, ResponseMessage);
                    if ResponseMessage.IsSuccessStatusCode then begin
                        //exit(true);
                    end else begin
                        Error(ResponseMessage.ReasonPhrase);
                        //exit(false);
                    end;

                END;

            UNTIL NameValueBuffer.NEXT = 0;

    end;

    procedure GetFilesFromPath(var NameValueBuffer: Record "Name/Value Buffer"; Path: Text)
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Body: Text;
        URL: Text;
        Content: HttpContent;
        gheaders: HttpHeaders;
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        JsonText: Text;
        JsonTokenGlobal: JsonToken;
        JsonArray: JsonArray;
        JsonObject: JsonObject;
        JsonToken: JsonToken;
    begin
        SalesReceivablesSetup.Get();

        Body := '{';
        Body += '"name": "' + path.replace('\', '\\') + '"';
        Body += '}';
        //Flow Llegir fitxers
        URL := 'https://prod-106.westeurope.logic.azure.com:443/workflows/f452b2aec68f48dd8c5dbefe5f1ec5bd/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=8rHvB3mwr6wektoVhmG2CDTJho8GpJpQzitoSqN9LK8';

        Content.WriteFrom(Body);
        Content.GetHeaders(gheaders);
        gheaders.Remove('Content-Type');
        gheaders.Add('Content-Type', 'application/json');

        Client.Clear();
        Client.DefaultRequestHeaders.Add('accept', 'application/json');

        Client.Post(URL, Content, ResponseMessage);
        if ResponseMessage.IsSuccessStatusCode then begin
            ResponseMessage.Content.ReadAs(JsonText);
            JsonTokenGlobal.ReadFrom(JsonText);
            //Guardo l'array
            JsonArray := JsonTokenGlobal.AsArray();
            //Recorro l'array un a un. D'aquesta manera sé que el token que agafo és d'aquella tempoorada
            foreach JsonToken in JsonArray do begin
                JsonObject := JsonToken.AsObject;
                if JsonTokenExists(JsonObject, 'name') then begin
                    if not GetJsonToken(JsonObject, 'name').AsValue.IsNull then begin
                        NameValueBuffer.AddNewEntry(Path + CopyStr(GetTextValueFromJson(JsonObject, 'name', 1, 0), 1, 250), '');
                    end;
                end;
            end;
            //exit(true);
        end else begin
            Error(ResponseMessage.ReasonPhrase);
            //exit(false);
        end;
    end;

    local procedure JsonTokenExists(JsonObject: JsonObject; TokenKey: text): Boolean
    var
        JsonToken: JsonToken;
    begin
        if JsonObject.Get(TokenKey, JsonToken) then
            exit(true);
        exit(false);
    end;

    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
    end;

    local procedure GetTextValueFromJson(JsonObject: JsonObject; TokenKey: text; Position: Integer; Length: Integer): Text
    begin
        if not GetJsonToken(JsonObject, TokenKey).AsValue.IsNull then begin
            if Length = 0 then
                exit(CopyStr(DelChr(GetJsonToken(JsonObject, TokenKey).AsValue.AsText, '<'), Position))
            else
                exit(CopyStr(DelChr(GetJsonToken(JsonObject, TokenKey).AsValue.AsText, '<'), Position, Length));
        end else
            exit('');
    end;

    local procedure UploadFile(parFilePath: Text[1024]; Tipo: enum Ficherets)
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Body: Text;
        URL: Text;
        Content: HttpContent;
        gheaders: HttpHeaders;
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        OutStream: OutStream;
        InStream: InStream;
        DummyFile: File;
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        ResponseText: Text;
        FileText: Text;
        JsonTokenGlobal: JsonToken;
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        streamText: Text;
        TotalstreamText: Text;
    begin
        //COMMIT;
        IF parFilePath = '' THEN EXIT;
        // DummyFile.CLOSE;

        //SalesReceivablesSetup.Get();
        CLEAR(OutStream);
        CLEAR(InStream);

        Body := '{"path": "' + parFilePath.replace('\', '\\') + '"}';
        //Flow Baixar fitxer
        URL := 'https://prod-141.westeurope.logic.azure.com:443/workflows/1c7bc6b090a74c1ba70a4562e22b93f7/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=cJIYk8LFWVWy78hO_XZtDAbW_A8n47MHrZqdVSc8BYE';

        Content.WriteFrom(Body);
        Content.GetHeaders(gheaders);
        gheaders.Remove('Content-Type');
        gheaders.Add('Content-Type', 'application/json');

        Client.Clear();
        Client.DefaultRequestHeaders.Add('accept', 'application/json');

        Client.Post(URL, Content, ResponseMessage);
        if ResponseMessage.IsSuccessStatusCode then begin
            // ResponseMessage.Content.ReadAs(IStream);
            ResponseMessage.Content.ReadAs(ResponseText);
            JsonTokenGlobal.ReadFrom(ResponseText);
            JsonObject := JsonTokenGlobal.AsObject;
            if JsonTokenExists(JsonObject, 'content') then begin
                if not GetJsonToken(JsonObject, 'content').AsValue.IsNull then begin
                    FileText := GetTextValueFromJson(JsonObject, 'content', 1, 0);
                    TempBlob.CreateOutStream(OutStream);

                    FileText := Base64Convert.FromBase64(FileText);
                    OutStream.WriteText(FileText);
                    TempBlob.CreateInStream(InStream);
                    ///// PedidosManoMano,KIWOKO,COVALDROPER,EDICOM,AMAZON,TAMK,SENDING,TRANSAHER,MASKOKOTAS,CARREFOUR,MIRAVIA,GLS,TXT,CATITNUEVO,LEROYMERLIN);                    
                    /*
                    if Tipo = Tipo::PedidosManoMano then begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);                        
                    end;                                        
                    if Tipo = Tipo::KIWOKO then begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                    end;
                    if Tipo = Tipo::COVALDROPER then begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                    end;
                    if Tipo = Tipo::EDICOM then begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                    end;
                    if Tipo = Tipo::AMAZON then begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                    end;
                    if Tipo = Tipo::TAMK begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                    end;
                    if Tipo = Tipo::SENDING then begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                    end;
                    if Tipo = Tipo::TRANSAHER then begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                    end;
                    if Tipo = Tipo::MASKOKOTAS then begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                    end;
                    if Tipo = Tipo::MASKOKOTAS then begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                    end;
                    if Tipo = Tipo::CARREFOUR then begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                    end;
                    if Tipo = Tipo::MIRAVIA then begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                    end;
                    if Tipo = Tipo::GLS then begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                    end;
                    if Tipo = Tipo::TXT then begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                    end;
                    if Tipo = Tipo::CATITNUEVO then begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                    end;
                    if Tipo = Tipo::LEROYMERLIN then begin
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", InStream);
                    end;
                    */

                end;
            end;
            //exit(true);
        end else begin
            Error(ResponseMessage.ReasonPhrase);
            //exit(false);
        end;
    end;






}