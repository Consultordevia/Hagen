codeunit 50004 PruebaMailsDevConsultIA
{

    trigger OnRun()
    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvHeader2: Record "Sales Invoice Header";
        txtDestinatario: List of [Text];
        Recipient: Text[250];
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        InStream: InStream;
        repInforme: Report "OK Nueva Factura Venta";
        fileName: TEXT;
    begin
        SalesInvHeader.Reset;
        SalesInvHeader.SetCurrentkey(SalesInvHeader."Enviar email", SalesInvHeader."Email enviado");
        SalesInvHeader.SetRange(SalesInvHeader."Enviar email", true);
        /////SalesInvHeader.SETRANGE("Posting Date",TODAY,TODAY);
        SalesInvHeader.SetRange(SalesInvHeader."Email enviado", false);
        /////SalesInvHeader.SetRange("No.", '24FV122053');
        if SalesInvHeader.FindSet then begin
            repeat
                //txtOrigen := 'facturacion@hagen.es';
                Recipient := 'oscarraea@hotmail.com';
                txtDestinatario.Add(Recipient);
                //recCompanyInformation.Get;
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
                BCEnviarEmailSinC(txtDestinatario, '', '', true, fileName, 'PDF', Enum::"Email Scenario"::Albaran, '', '', InStream);
            //FicheroHagen.CrearFicheroFTP('', fileName, InStream);
            until SalesInvHeader.Next() = 0;
        end;
    end;

    procedure BCEnviarEmailSinC(parDestinatarios: List of [Text]; parSubject: Text; parBody: Text; parHtmlFormatted: Boolean;
       parAttachmentName: Text[250]; parContentType: Text[250]; parEmailScenario: Enum "Email Scenario"; parCC: Text; parBCC: Text; AttachmentInStream: InStream)
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        cduFileManagement: Codeunit "File Management";
        AttachmentTempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
    begin
        Clear(EmailMessage);
        Clear(Email);

        EmailMessage.Create(parDestinatarios, parSubject, parBody, parHtmlFormatted, parCC.Split(';'), parBCC.Split(';'));

        //Base64Text := Base64Convert.ToBase64(AttachmentInStream);
        EmailMessage.AddAttachment(parAttachmentName, parContentType, AttachmentInStream);

        Email.Send(EmailMessage, parEmailScenario);
    end;
}
