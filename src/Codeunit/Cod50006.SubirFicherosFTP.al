codeunit 50006 SubirFicherosFTP
{
    Permissions = tabledata "Sales Invoice Header" = RMID;

    trigger OnRun()
    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvHeader2: Record "Sales Invoice Header";
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        InStream: InStream;
        repInforme: Report "OK Nueva Factura Venta";
        fileName: TEXT;
        FicheroHagen: Codeunit FicherosHagen;
    begin
        SalesInvHeader.Reset;
        SalesInvHeader.SetRange(SalesInvHeader.FicheroFTP, false);
        SalesInvHeader.SETRANGE("Posting Date", 20241205D, TODAY);
        if SalesInvHeader.FindSet(false, true) then begin
            repeat
                Clear(TempBlob);
                Clear(OutStream);
                Clear(InStream);
                TempBlob.CreateOutStream(OutStream);
                TempBlob.CreateInStream(InStream);
                clear(repInforme);
                SalesInvHeader2.RESET;
                SalesInvHeader2.SetRange("No.", SalesInvHeader."No.");
                SalesInvHeader2.FindFirst();
                repInforme.SetTableView(SalesInvHeader2);
                repInforme.SaveAs('', ReportFormat::Pdf, OutStream);
                fileName := SalesInvHeader2."No." + '.PDF';
                FicheroHagen.CrearFicheroFTP('', fileName, InStream);
                SalesInvHeader2.get(SalesInvHeader."No.");
                SalesInvHeader2.FicheroFTP := true;
                SalesInvHeader2.Modify();
                Commit;
            until SalesInvHeader.Next() = 0;
        end;
    end;
}