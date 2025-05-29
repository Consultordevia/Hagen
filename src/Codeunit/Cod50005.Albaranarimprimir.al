#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50005 "Albaranar + imprimir"
{
    // 
    // 
    // 
    // 
    // 
    // 
    // TypeIDNameCaptionModificadoLista versionesFechaHoraCompiledBloqueadoBloqueado por
    // 350063OK Nueva Factura VentaSíNAVW111.00,NAVES11.0010/11/18 9:06:45SíNo
    // 350900OK Factura Venta EMAILSíNAVW111.00,NAVES11.0008/11/1822:19:33SíNo
    // 350901OK Albaran ValoradoSíNAVW111.0009/11/1813:40:45SíNo
    // 350902OK Albaran NO valoradoSíNAVW111.0009/11/1813:41:04SíNo
    // 
    // 350903OK Albaran Valorado EMAILSíNAVW111.0009/11/1813:41:23SíNo
    // 350904OK Albaran NO valorado EMAILSíNAVW111.0009/11/1813:33:17SíNo
    // 350905OK Albaran NO Valorado ECISíNAVW111.0009/11/1812:05:45SíNo

    TableNo = "Sales Header";

    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
    begin

        SalesHeader.Copy(Rec);
        Code(SalesHeader);
        Rec := SalesHeader;

        /*SalesHeader.RESET;
        SalesHeader.SETRANGE("Document Type",1);
        SalesHeader.SETRANGE("No.",'1104');
        IF SalesHeader.FINDFIRST THEN BEGIN
             GetReport(SalesHeader);/// 18ALB11-0009
        END;
        */

    end;

    var
        ShipInvoiceQst: label '&Ship,&Invoice,Ship &and Invoice';
        PostAndPrintQst: label 'Do you want to post and print the %1?', Comment = '%1 = Document Type';
        PostAndEmailQst: label 'Do you want to post and email the %1?', Comment = '%1 = Document Type';
        ReceiveInvoiceQst: label '&Receive,&Invoice,Receive &and Invoice';
        SendReportAsEmail: Boolean;
        SalesPost: Codeunit "Sales-Post";
        Selection: Integer;
        RecClie: Record Customer;
        SalesHeader: Record "Sales Header";
        SalesShptHeader: Record "Sales Shipment Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        ReturnRcptHeader: Record "Return Receipt Header";
        ReportSelection: Record "Report Selections";
        Preparadores: Record Preparadores;


    procedure PostAndEmail(var ParmSalesHeader: Record "Sales Header")
    var
        SalesHeader: Record "Sales Header";
    begin
        SendReportAsEmail := true;
        SalesHeader.Copy(ParmSalesHeader);
        Code(SalesHeader);
        ParmSalesHeader := SalesHeader;
    end;

    local procedure "Code"(var SalesHeader: Record "Sales Header")
    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPostViaJobQueue: Codeunit "Sales Post via Job Queue";
        HideDialog: Boolean;
    begin

        SalesHeader.Ship := true;
        SalesHeader.Invoice := false;
        SalesPost.Run(SalesHeader);
        GetReport(SalesHeader);
        Commit;


        /*
        HideDialog := FALSE;
        OnBeforeConfirmPost(SalesHeader,HideDialog);
        IF NOT HideDialog THEN
          IF NOT ConfirmPost(SalesHeader) THEN
            EXIT;
        SalesSetup.GET;
        IF SalesSetup."Post & Print with Job Queue" AND NOT SendReportAsEmail THEN
          SalesPostViaJobQueue.EnqueueSalesDoc(SalesHeader)
        ELSE BEGIN
          CODEUNIT.RUN(CODEUNIT::"Sales-Post",SalesHeader);
          GetReport(SalesHeader);
        END;
        
        OnAfterPost(SalesHeader);
        COMMIT;
        */

    end;

    procedure GetReport(var SalesHeader: Record "Sales Header")
    begin

        /*
        WITH SalesHeader DO
          CASE "Document Type" OF
            "Document Type"::Order:
              BEGIN
                IF Ship THEN
                  PrintShip(SalesHeader);
                IF Invoice THEN
                  PrintInvoice(SalesHeader);
              END;
            "Document Type"::Invoice:
              PrintInvoice(SalesHeader);
            "Document Type"::"Return Order":
              BEGIN
                IF Receive THEN
                  PrintReceive(SalesHeader);
                IF Invoice THEN
                  PrintCrMemo(SalesHeader);
              END;
            "Document Type"::"Credit Memo":
              PrintCrMemo(SalesHeader);
          END;
          */


        with SalesHeader do begin
            case "Document Type" of
                "document type"::Order:
                    begin
                        if Ship then begin
                            SalesShptHeader."No." := "Last Shipping No.";
                            SalesShptHeader.SetRecfilter;
                            PrintReport(ReportSelection.Usage::"S.Shipment");
                        end;
                        if Invoice then begin
                            SalesInvHeader."No." := "Last Posting No.";
                            SalesInvHeader.SetRecfilter;
                            PrintReport(ReportSelection.Usage::"S.Invoice");
                        end;
                    end;
                "document type"::Invoice:
                    begin
                        if "Last Posting No." = '' then
                            SalesInvHeader."No." := "No."
                        else
                            SalesInvHeader."No." := "Last Posting No.";
                        SalesInvHeader.SetRecfilter;
                        PrintReport(ReportSelection.Usage::"S.Invoice");
                    end;
                "document type"::"Return Order":
                    begin
                        if Receive then begin
                            ReturnRcptHeader."No." := "Last Return Receipt No.";
                            ReturnRcptHeader.SetRecfilter;
                            PrintReport(ReportSelection.Usage::"S.Ret.Rcpt.");
                        end;
                        if Invoice then begin
                            SalesCrMemoHeader."No." := "Last Posting No.";
                            SalesCrMemoHeader.SetRecfilter;
                            PrintReport(ReportSelection.Usage::"S.Cr.Memo");
                        end;
                    end;
                "document type"::"Credit Memo":
                    begin
                        if "Last Posting No." = '' then
                            SalesCrMemoHeader."No." := "No."
                        else
                            SalesCrMemoHeader."No." := "Last Posting No.";
                        SalesCrMemoHeader.SetRecfilter;
                        PrintReport(ReportSelection.Usage::"S.Cr.Memo");
                    end;
            end;
        end;

    end;

    local procedure ConfirmPost(var SalesHeader: Record "Sales Header"): Boolean
    var
        Selection: Integer;
    begin
        with SalesHeader do begin
            case "Document Type" of
                "document type"::Order:
                    begin
                        Selection := StrMenu(ShipInvoiceQst, 3);
                        if Selection = 0 then
                            exit(false);
                        Ship := Selection in [1, 3];
                        Invoice := Selection in [2, 3];
                    end;
                "document type"::"Return Order":
                    begin
                        Selection := StrMenu(ReceiveInvoiceQst, 3);
                        if Selection = 0 then
                            exit(false);
                        Receive := Selection in [1, 3];
                        Invoice := Selection in [2, 3];
                    end
                else
                    if not Confirm(ConfirmationMessage, false, "Document Type") then
                        exit(false);
            end;
            "Print Posted Documents" := true;
        end;
        exit(true);
    end;

    local procedure ConfirmationMessage(): Text
    begin
        if SendReportAsEmail then
            exit(PostAndEmailQst);
        exit(PostAndPrintQst);
    end;

    local procedure PrintReceive(SalesHeader: Record "Sales Header")
    var
        ReturnRcptHeader: Record "Return Receipt Header";
    begin
        ReturnRcptHeader."No." := SalesHeader."Last Return Receipt No.";
        if ReturnRcptHeader.Find then;
        ReturnRcptHeader.SetRecfilter;

        if SendReportAsEmail then
            ReturnRcptHeader.EmailRecords(true)
        else
            ReturnRcptHeader.PrintRecords(false);
    end;

    local procedure PrintInvoice(SalesHeader: Record "Sales Header")
    var
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        if SalesHeader."Last Posting No." = '' then
            SalesInvHeader."No." := SalesHeader."No."
        else
            SalesInvHeader."No." := SalesHeader."Last Posting No.";
        SalesInvHeader.Find;
        SalesInvHeader.SetRecfilter;

        if SendReportAsEmail then
            SalesInvHeader.EmailRecords(true)
        else
            SalesInvHeader.PrintRecords(false);
    end;

    local procedure PrintShip(SalesHeader: Record "Sales Header")
    var
        SalesShptHeader: Record "Sales Shipment Header";
    begin
        SalesShptHeader."No." := SalesHeader."Last Shipping No.";
        if SalesShptHeader.Find then;
        SalesShptHeader.SetRecfilter;

        if SendReportAsEmail then
            SalesShptHeader.EmailRecords(true)
        else
            SalesShptHeader.PrintRecords(false);
    end;

    local procedure PrintCrMemo(SalesHeader: Record "Sales Header")
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        if SalesHeader."Last Posting No." = '' then
            SalesCrMemoHeader."No." := SalesHeader."No."
        else
            SalesCrMemoHeader."No." := SalesHeader."Last Posting No.";
        SalesCrMemoHeader.Find;
        SalesCrMemoHeader.SetRecfilter;

        if SendReportAsEmail then
            SalesCrMemoHeader.EmailRecords(true)
        else
            SalesCrMemoHeader.PrintRecords(false);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPost(var SalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeConfirmPost(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean)
    begin
    end;

    local procedure PrintReport(ReportUsage: Integer)
    begin
        ReportSelection.Reset;
        ReportSelection.SetRange(Usage, ReportUsage);
        ReportSelection.FindSet;
        repeat
            ReportSelection.TestField("Report ID");
            case ReportUsage of
                /////  ReportSelection.Usage::"SM.Invoice":
                /////      REPORT.RUN(ReportSelection."Report ID",FALSE,FALSE,SalesInvHeader);
                /////    ReportSelection.Usage::"SM.Credit Memo":
                /////      REPORT.RUN(ReportSelection."Report ID",FALSE,FALSE,SalesCrMemoHeader);
                /////    ReportSelection.Usage::"S.Invoice":
                /////      BEGIN
                /////    IF NOT SalesHeader."No Enviar factura" THEN BEGIN
                /////           REPORT.RUN(ReportSelection."Report ID",FALSE,FALSE,SalesInvHeader);
                /////        END;
                /////     IF SalesHeader."No Enviar factura" THEN BEGIN
                /////     REPORT.RUN(50081,FALSE,FALSE,SalesInvHeader);
                /////     END;
                /////    END;
                /////    ReportSelection.Usage::"S.Cr.Memo":
                /////      REPORT.RUN(ReportSelection."Report ID",FALSE,FALSE,SalesCrMemoHeader);

                ReportSelection.Usage::"S.Shipment":

                    begin
                        SalesShptHeader.Get(SalesShptHeader."No.");
                        if SalesShptHeader."Shipping Agent Code" <> 'ECI' then begin
                            RecClie.Get(SalesShptHeader."Sell-to Customer No.");
                            if SalesShptHeader."No Enviar albaran en exp." = true then begin
                                if RecClie."Albaran valorado" = true then begin
                                    /////     REPORT.RUN(50906,FALSE,FALSE,SalesShptHeader);
                                end;
                            end;
                            if SalesShptHeader."No Enviar albaran en exp." = false then begin
                                if SalesShptHeader."No imprimir albaran valorado" = false then begin
                                    if RecClie."Albaran valorado" = true then begin
                                        if SalesShptHeader.Dropshipping = true then begin
                                            ///if Preparadores.Get(SalesShptHeader.Preparador) then begin
                                                ///if UpperCase(CopyStr(Preparadores."Printer Name", 1, 13)) <> 'RICOH DERECHA' then begin
                                                Report.Run(50901, false, false, SalesShptHeader);
                                                ///end;
                                                ///if UpperCase(CopyStr(Preparadores."Printer Name", 1, 13)) = 'RICOH DERECHA' then begin
                                                ///Report.Run(50915, false, false, SalesShptHeader);
                                                ///end;
                                            ///end;
                                        end;
                                    end;
                                end;
                            end;
                            if SalesShptHeader."Albaran sin detalle" = true then begin
                                if SalesShptHeader.Dropshipping = true then begin
                                    if Preparadores.Get(SalesShptHeader.Preparador) then begin
                                        ///if UpperCase(CopyStr(Preparadores."Printer Name", 1, 13)) <> 'RICOH DERECHA' then begin
                                        Report.Run(50902, false, false, SalesShptHeader);
                                        ///end;
                                        ///if UpperCase(CopyStr(Preparadores."Printer Name", 1, 13)) = 'RICOH DERECHA' then begin
                                        /// Report.Run(50916, false, false, SalesShptHeader);
                                        ///end;
                                    end;
                                end;
                            end;
                        end;
                        if SalesShptHeader."Shipping Agent Code" = 'ECI' then begin
                            Report.Run(50905, false, false, SalesShptHeader);
                        end;
                        /////----
                        ///// eci y canarias
                        /////-----

                        /*                IF SalesHeader."Shipping Agent Code"<>'ECI' THEN BEGIN
                                             REPORT.RUN(50030,FALSE,FALSE,SalesShptHeader);
                                        END;
                                        IF SalesHeader."Shipping Agent Code"='ECI' THEN BEGIN
                                             REPORT.RUN(50058,FALSE,FALSE,SalesShptHeader);
                                             ///REPORT.RUN(50058,FALSE,FALSE,SalesShptHeader);
                                             ///REPORT.RUN(50058,FALSE,FALSE,SalesShptHeader);
                                        END;
                                        */
                        ///END;
                        ///  END;
                    end;
            /////    ReportSelection.Usage::"S.Ret.Rcpt.":
            /////      REPORT.RUN(ReportSelection."Report ID",FALSE,FALSE,ReturnRcptHeader);
            end;
        until ReportSelection.Next = 0;

    end;
}

