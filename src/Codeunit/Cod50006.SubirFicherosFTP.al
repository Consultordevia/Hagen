codeunit 50006 SubirFicherosFTP
{
    Permissions = tabledata "Sales Invoice Header" = RMID, tabledata "Sales Shipment Header" = RMID, tabledata "Sales Cr.Memo Header" = RMID;

    trigger OnRun()
    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvHeader2: Record "Sales Invoice Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentHeader2: Record "Sales Shipment Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoHeader2: Record "Sales Cr.Memo Header";
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        InStream: InStream;
        fileName: TEXT;
        //FicheroHagen: Codeunit FicherosHagen;
        ftp: Codeunit "VFF FTP Management";
        repInforme: Report "Standard Sales - Invoice";
        Albaran: report "Standard Sales - Shipment";
        Abono: report "Standard Sales - Credit Memo";
        Errort: text;
    begin
        SalesInvHeader.Reset;
        SalesInvHeader.SetRange(SalesInvHeader.FicheroFTP, false);
        SalesInvHeader.SETRANGE("Posting Date", 20241205D, TODAY);
        if SalesInvHeader.FindSet() then begin
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
                if ftp.FtpUpload('HAGEN', fileName, InStream, Errort) then begin
                    //Error(ErrorT);
                    SalesInvHeader2.get(SalesInvHeader."No.");
                    SalesInvHeader2.FicheroFTP := true;
                    SalesInvHeader2.Modify();
                    Commit;
                end;
            until SalesInvHeader.Next() = 0;
        end;

        SalesShipmentHeader.Reset;
        SalesShipmentHeader.SetRange(SalesShipmentHeader.FicheroFTP, false);
        SalesShipmentHeader.SETRANGE("Posting Date", 20241205D, TODAY);
        if SalesShipmentHeader.FindSet() then begin

            repeat
                Clear(TempBlob);
                Clear(OutStream);
                Clear(InStream);
                TempBlob.CreateOutStream(OutStream);
                TempBlob.CreateInStream(InStream);
                clear(Albaran);
                SalesShipmentHeader2.RESET;
                SalesShipmentHeader2.SetRange("No.", SalesShipmentHeader."No.");
                SalesShipmentHeader2.FindFirst();
                Albaran.SetTableView(SalesShipmentHeader2);
                Albaran.SaveAs('', ReportFormat::Pdf, OutStream);
                fileName := SalesShipmentHeader2."No." + '.PDF';
                if ftp.FtpUpload('HAGEN', fileName, InStream, Errort) then begin
                    //Error(ErrorT);
                    SalesShipmentHeader2.get(SalesShipmentHeader."No.");
                    SalesShipmentHeader2.FicheroFTP := true;
                    SalesShipmentHeader2.Modify();
                    Commit;
                end;
            until SalesShipmentHeader.Next() = 0;
        end;

        SalesCrMemoHeader.Reset;
        SalesCrMemoHeader.SetRange(SalesCrMemoHeader.FicheroFTP, false);
        SalesCrMemoHeader.SETRANGE("Posting Date", 20241205D, TODAY);
        if SalesCrMemoHeader.FindSet() then begin
            repeat
                Clear(TempBlob);
                Clear(OutStream);
                Clear(InStream);
                TempBlob.CreateOutStream(OutStream);
                TempBlob.CreateInStream(InStream);
                clear(Abono);
                SalesCrMemoHeader2.RESET;
                SalesCrMemoHeader2.SetRange("No.", SalesCrMemoHeader."No.");
                SalesCrMemoHeader2.FindFirst();
                Abono.SetTableView(SalesCrMemoHeader2);
                Abono.SaveAs('', ReportFormat::Pdf, OutStream);
                fileName := SalesCrMemoHeader2."No." + '.PDF';
                if ftp.FtpUpload('HAGEN', fileName, InStream, Errort) then begin
                    //Error(ErrorT);
                    SalesCrMemoHeader2.get(SalesCrMemoHeader."No.");
                    SalesCrMemoHeader2.FicheroFTP := true;
                    SalesCrMemoHeader2.Modify();
                    Commit;
                end;
            until SalesCrMemoHeader.Next() = 0;
        end;
    end;
    /*SalesInvHeader.Reset;
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

    SalesShipmentHeader.Reset;
    SalesShipmentHeader.SetRange(SalesShipmentHeader.FicheroFTP, false);
    SalesShipmentHeader.SETRANGE("Posting Date", 20241205D, TODAY);
    if SalesShipmentHeader.FindSet(false, true) then begin
        repeat
            Clear(TempBlob);
            Clear(OutStream);
            Clear(InStream);
            TempBlob.CreateOutStream(OutStream);
            TempBlob.CreateInStream(InStream);
            clear(Albaran);
            SalesShipmentHeader2.RESET;
            SalesShipmentHeader2.SetRange("No.", SalesShipmentHeader."No.");
            SalesShipmentHeader2.FindFirst();
            Albaran.SetTableView(SalesShipmentHeader2);
            Albaran.SaveAs('', ReportFormat::Pdf, OutStream);
            fileName := SalesShipmentHeader2."No." + '.PDF';
            FicheroHagen.CrearFicheroFTP('', fileName, InStream);
            SalesShipmentHeader2.get(SalesShipmentHeader."No.");
            SalesShipmentHeader2.FicheroFTP := true;
            SalesShipmentHeader2.Modify();
            Commit;
        until SalesShipmentHeader.Next() = 0;
    end;

    SalesCrMemoHeader.Reset;
    SalesCrMemoHeader.SetRange(SalesCrMemoHeader.FicheroFTP, false);
    SalesCrMemoHeader.SETRANGE("Posting Date", 20241205D, TODAY);
    if SalesCrMemoHeader.FindSet(false, true) then begin
        repeat
            Clear(TempBlob);
            Clear(OutStream);
            Clear(InStream);
            TempBlob.CreateOutStream(OutStream);
            TempBlob.CreateInStream(InStream);
            clear(Abono);
            SalesCrMemoHeader2.RESET;
            SalesCrMemoHeader2.SetRange("No.", SalesCrMemoHeader."No.");
            SalesCrMemoHeader2.FindFirst();
            Abono.SetTableView(SalesCrMemoHeader2);
            Abono.SaveAs('', ReportFormat::Pdf, OutStream);
            fileName := SalesCrMemoHeader2."No." + '.PDF';
            FicheroHagen.CrearFicheroFTP('', fileName, InStream);
            SalesCrMemoHeader2.get(SalesCrMemoHeader."No.");
            SalesCrMemoHeader2.FicheroFTP := true;
            SalesCrMemoHeader2.Modify();
            Commit;
        until SalesCrMemoHeader.Next() = 0;
    end;
end;*/
}