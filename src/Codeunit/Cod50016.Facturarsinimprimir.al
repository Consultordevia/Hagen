#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50016 "Facturar sin imprimir"
{
    TableNo = "Sales Header";

    trigger OnRun()
    begin


        SalesHeader.Copy(Rec);
        Code;
        Rec := SalesHeader;
    end;

    var
        SalesHeader: Record "Sales Header";
        SalesShptHeader: Record "Sales Shipment Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        ReturnRcptHeader: Record "Return Receipt Header";
        ReportSelection: Record "Report Selections";
        SalesPost: Codeunit "Sales-Post";
        Selection: Integer;
        RecClie: Record Customer;
        Rec112: Record "Sales Invoice Header";
        Rec36: Record "Sales Header";

    local procedure "Code"()
    begin
          SalesHeader.Ship := false;
          SalesHeader.Invoice := true;
          SalesPost.Run(SalesHeader);
        /////  GetReport(SalesHeader);
          Commit;
    end;


    procedure GetReport(var SalesHeader: Record "Sales Header")
    begin
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

    local procedure PrintReport(ReportUsage: Integer)
    begin

        ReportSelection.Reset;
        ReportSelection.SetRange(Usage,ReportUsage);
        ReportSelection.FindSet;
        repeat
          ReportSelection.TestField("Report ID");
          case ReportUsage of
            ReportSelection.Usage::"SM.Invoice":
              Report.Run(ReportSelection."Report ID",false,false,SalesInvHeader);
            ReportSelection.Usage::"SM.Credit Memo":
              Report.Run(ReportSelection."Report ID",false,false,SalesCrMemoHeader);
            ReportSelection.Usage::"S.Invoice":
              begin
                   Rec112.Get(SalesInvHeader."No.");
                   if RecClie.Get(Rec112."Sell-to Customer No.") then begin
                        if SalesInvHeader."No imprimir facturas"=false then begin
                             if not SalesInvHeader."No Enviar factura en exp." then begin
                                  Report.Run(ReportSelection."Report ID",false,false,SalesInvHeader);
                             end;
                             if SalesInvHeader."No Enviar factura en exp." then begin
                                  Report.Run(50063,false,false,SalesInvHeader);
                             end;
                        end;
                   end;
              end;

            ReportSelection.Usage::"S.Cr.Memo":
              Report.Run(ReportSelection."Report ID",false,false,SalesCrMemoHeader);
            ReportSelection.Usage::"S.Shipment":
              begin
                   if not SalesShptHeader."No Enviar albaran en exp." then begin
                        Report.Run(ReportSelection."Report ID",false,false,SalesShptHeader);
                   end;
                   if SalesShptHeader."No Enviar albaran en exp." then begin
                        Report.Run(50901,false,false,SalesShptHeader);
                   end;
                   ///IF SalesHeader."Albaran sin detalle" THEN BEGIN
                        ///REPORT.RUN(50902,FALSE,FALSE,SalesShptHeader);
                   ///END;
              end;
              ReportSelection.Usage::"S.Ret.Rcpt.":
              Report.Run(ReportSelection."Report ID",false,false,ReturnRcptHeader);
          end;
        until ReportSelection.Next = 0;
    end;
}

