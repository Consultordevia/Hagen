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

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterOnInsert', '', true, true)]
    local procedure OnAfterOnInsert(var Customer: Record Customer; xCustomer: Record Customer)
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin

        EnvioFicheros.MODIFCLIENTES(Customer);


    end;

    [EventSubscriber(ObjectType::Table, 18, OnAfterModifyEvent, '', true, true)]
    local procedure OnAfterModifyEvent(RunTrigger: Boolean; var Rec: Record Customer);
    var
        EnvioFicheros: Codeunit "Automaticos Cartas";
    begin
        EnvioFicheros.MODIFCLIENTES(Rec);
    end;

}
