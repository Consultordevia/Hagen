codeunit 50000 ImportExportFileServer
{
    procedure ProcessFilesServer(Path: text; hasta: text; PathError: text)
    var
        //SalesReceivablesSetup: Record "Sales & Receivables Setup";
        FileManagement: Codeunit "File Management";
        NameValueBuffer: Record "Name/Value Buffer" temporary;
        ErrorPath: Text[1024];
        PDFFile: Text[1024];
        IsOK: Boolean;
        Body: Text;
        URL: Text;
        Content: HttpContent;
        gheaders: HttpHeaders;
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
    begin

        NameValueBuffer.RESET;
        NameValueBuffer.DELETEALL(FALSE);

        GetFilesFromPath(NameValueBuffer, Path);
        NameValueBuffer.RESET;

        IF GUIALLOWED THEN
            IF NOT CONFIRM('Desea importar los ' + FORMAT(NameValueBuffer.COUNT) + ' ficheros proporcionados?') THEN
                ERROR('Proceso abortado por el usuario');

        IF NameValueBuffer.FINDSET THEN
            REPEAT

                UploadFile(NameValueBuffer.Name, IsOK);

                IF IsOK THEN BEGIN

                    Body := '{';
                    Body += '"name": "' + FileManagement.GetFileName(NameValueBuffer.Name) + '",';
                    Body += '"desde": "' + path.replace('\', '\\') + '",';
                    Body += '"hasta": "' + hasta.replace('\', '\\') + '"';
                    Body += '}';
                    //Flow Moure fitxer únic
                    URL := 'https://prod-161.westeurope.logic.azure.com:443/workflows/71478d9107594df4bed7e62ec38671ec/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=IMImR0KJtRtf8t-laRQe9Ok1CGD4CLwkXOKAwoRQaV4';
                END ELSE BEGIN

                    Body := '{';
                    Body += '"name": "' + FileManagement.GetFileName(NameValueBuffer.Name) + '",';
                    Body += '"desde": "' + path.replace('\', '\\') + '",';
                    Body += '"hasta": "' + PathError.replace('\', '\\') + '"';
                    Body += '}';
                    //Flow Moure fitxer únic
                    URL := 'https://prod-161.westeurope.logic.azure.com:443/workflows/71478d9107594df4bed7e62ec38671ec/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=IMImR0KJtRtf8t-laRQe9Ok1CGD4CLwkXOKAwoRQaV4';
                END;

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
            //end;
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
        URL := 'https://prod-240.westeurope.logic.azure.com:443/workflows/64e1ed9039f045078e2ee89936aada44/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=rJl2AqH3Q3XYHO6VooGloqbj5oIGXuS0oV3D0HvVUVY';

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

    local procedure UploadFile(parFilePath: Text[1024]; var IsOK: Boolean)
    var
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
        COMMIT;
        IF parFilePath = '' THEN EXIT;
        // DummyFile.CLOSE;

        CLEAR(OutStream);
        CLEAR(InStream);

        Body := '{"path": "' + parFilePath.replace('\', '\\') + '"}';
        //Flow Baixar fitxer
        URL := 'https://prod-177.westeurope.logic.azure.com:443/workflows/9a14bc38aab54a579fb670f7733f31ad/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=Qk95LhXiHQhEO3za1oCTbXGxPks1Ikze2acQ1ieAh68';

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
                    //if tipo = Tipo then
                    //    TempBlob.CreateOutStream(OutStream, TextEncoding::UTF16)
                    //else
                    TempBlob.CreateOutStream(OutStream);

                    FileText := Base64Convert.FromBase64(FileText);
                    OutStream.WriteText(FileText);
                    //if tipo = Tipo then
                    //    TempBlob.CreateInStream(InStream, TextEncoding::UTF16)
                    //else
                    TempBlob.CreateInStream(InStream);

                    //fes el que vullgues en el instream
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

}
