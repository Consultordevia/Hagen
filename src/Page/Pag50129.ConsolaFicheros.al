page 50129 ConsolaFicheros
{
    ApplicationArea = All;
    Caption = 'ConsolaFicheros';
    PageType = List;
    SourceTable = ConsolaFicheros;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(NombreFichero; Rec.NombreFichero)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(URL; rec.URL)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(DesdeDondeSeGuarda; rec.DesdeDondeSeGuarda)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }

    }
    actions
    {
        area(Creation)
        {
            action(DescargarFichero)
            {
                ApplicationArea = All;
                Caption = 'Descargar fichero';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Download;

                trigger OnAction()
                var
                    FicheroInStream: InStream;
                    Nombre: Text;

                begin
                    rec.CalcFields(rec.Fichero);
                    rec.Fichero.CreateInStream(FicheroInStream);
                    Nombre := rec.NombreFichero;
                    DownloadFromStream(FicheroInStream, '', '', '', Nombre);
                end;
            }

            action(Reenviarfichero)
            {
                ApplicationArea = All;
                Caption = 'Reenviar fichero';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Share;

                trigger OnAction()
                var
                    FicherosHagen: Codeunit FicherosHagen;
                    FicheroInStream: InStream;

                begin
                    rec.CalcFields(rec.Fichero);
                    rec.Fichero.CreateInStream(FicheroInStream);
                    FicherosHagen.CrearFichero(rec.URL, rec.NombreFichero, FicheroInStream, 'Reenvío Consola Ficheros');
                end;
            }
        }
    }

}
