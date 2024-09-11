codeunit 50999 FicherosHagen
{
    procedure CrearFichero(URL: TEXT; NombreFichero: text; fichero: InStream)
    var
        Base64Text: Text;
        Base64Convert: Codeunit "Base64 Convert";
        Body: Text;
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
    end;
}
