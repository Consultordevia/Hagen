#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50055 "_Facturacion automatica"
{
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = true;

    dataset
    {
        dataitem("Sales Shipment Header";"Sales Shipment Header")
        {
            DataItemTableView = sorting("Bill-to Customer No.","Albaran facturado","Posting Date") where("Albaran facturado"=const(No),"No Agrupar en facturas"=const(No));
            RequestFilterFields = "No.","Bill-to Customer No.","Currency Code","Payment Method Code","Payment Terms Code","Pay-at Code","No. Series","Customer Posting Group","Anula restos","Shipping Agent Code","Ship-to Code","Posting Date";
            column(ReportForNavId_1; 1)
            {
            }
            dataitem("Sales Shipment Line";"Sales Shipment Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.","Line No.");
                column(ReportForNavId_2; 2)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if ("Qty. Shipped Not Invoiced" <> 0) then begin
                          SalesLine.SetRange("Document Type",2);
                          SalesLine.SetRange("Document No.",NDOC);
                          SalesLine."Document Type" := 2;
                          SalesLine."Document No." := NDOC;
                        SalesShptLine := "Sales Shipment Line";
                        SalesShptLine.InsertInvLineFromShptLine(SalesLine,TempFromLineDim);
                        DimMgt.MoveTempFromDimToTempToDim(TempFromLineDim,TempToLineDim);
                    ///    Rec362.GET(Rec36."Document Type",Rec36."No.");
                    ///    IF Rec362."Posting No. Series"='' THEN BEGIN
                    ///         RecGC.GET(Rec362."Gen. Bus. Posting Group",SalesLine."Gen. Prod. Posting Group");
                    ///         Rec362."Posting No. Series":=RecGC."Nº serie fact. registrada";
                    ///         Rec362.MODIFY;
                    ///    END;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                VENTANA.Update(1,"Sales Shipment Header"."Bill-to Customer No.");
                VENTANA.Update(2,"Sales Shipment Header"."No.");
                VENTANA.Update(3,"Sales Shipment Header"."Posting Date");
                Cust.Get("Sales Shipment Header"."Sell-to Customer No.");
                RecCI.Get;
                GrabaCabecera;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Pay-at Code");
                VENTANA.Open('CLIENTE: #1####################\'+
                             'Nº ALB.: #2####################\'+
                             'FECHA..: #3####################');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(FechaRegisSoli;FechaRegisSoli)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Fecha registro';
                    }
                    field(noauto;noauto)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Sacar los no automaticos';
                    }
                    field(FechaDocSol;FechaDocSol)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Fecha emision documento';
                    }
                    field(PORDIREC;PORDIREC)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Separa por direcc. envío';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            FechaRegisSoli:=WorkDate;
            FechaDocSol:=WorkDate;
            PORDIREC:=true;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        RecCV.Reset;
        RecCV.SetRange(RecCV."Document Type",2);
        RecCV.SetRange(RecCV."Usuario alta",UserId);
        if RecCV.Find('-') then repeat
             RecLV.Reset;
             RecLV.SetRange(RecLV."Document Type",RecCV."Document Type");
             RecLV.SetRange(RecLV."Document No.",RecCV."No.");
             if not RecLV.Find('-') then begin
                  RecCV.Delete;
             end;
        until RecCV.Next = 0;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Rec36: Record "Sales Header";
        FechaRegisSoli: Date;
        FechaDocSol: Date;
        NDOC: Code[20];
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesShptLine: Record "Sales Shipment Line";
        SalesSetup: Record "Sales & Receivables Setup";
        FromDocDim: Record "Dimension Set Entry";
        ToDocDim: Record "Dimension Set Entry";
        TempFromLineDim: Record "Dimension Set Entry" temporary;
        TempToLineDim: Record "Dimension Set Entry" temporary;
        Cust: Record Customer;
        Language: Record Language;
        PmtTerms: Record "Payment Terms";
        SalesCalcDisc: Codeunit "Sales-Calc. Discount";
        SalesPost: Codeunit "Sales-Post";
        DimMgt: Codeunit DimensionManagement;
        Window: Dialog;
        PostingDateReq: Date;
        DocDateReq: Date;
        CalcInvDisc: Boolean;
        PostInv: Boolean;
        OnlyStdPmtTerms: Boolean;
        HideDialog: Boolean;
        NextLineNo: Integer;
        NoOfSalesInvErrors: Integer;
        NoOfSalesInv: Integer;
        NoOfskippedShiment: Integer;
        VENTANA: Dialog;
        RecClie: Record Customer;
        RecPago: Record "Customer Pmt. Address";
        RecBancoCli: Record "Customer Bank Account";
        PAGOCLI: Code[20];
        RecGC: Record "General Posting Setup";
        TieneSerie: Boolean;
        Rec362: Record "Sales Header";
        AgrupaAlb: Boolean;
        RecCV: Record "Sales Header";
        RecLV: Record "Sales Line";
        PESOFAC: Decimal;
        BULTOSFAC: Decimal;
        Rec336: Record "Tracking Specification";
        ConfEx: Record "Inventory Setup";
        Constante: Decimal;
        RecItem: Record Item;
        RecCI: Record "Company Information";
        PORDIREC: Boolean;
        noauto: Boolean;


    procedure GrabaCabecera()
    begin
          AgrupaAlb:=true;
          PAGOCLI:='';
          RecPago.Reset;
          RecPago.SetRange(RecPago."Customer No.",RecClie."No.");
          if RecPago.Find('-') then begin
               PAGOCLI:= RecPago.Code;
          end;
          if AgrupaAlb then begin
               Rec36.Reset;
               Rec36.SetCurrentkey(Rec36."Document Type",
                                   Rec36."Bill-to Customer No.",
                                   Rec36."Currency Code",
                                   Rec36."Payment Method Code",
                                   Rec36."Payment Terms Code",
                                   Rec36."Pay-at Code",Rec36."No. Series");
               Rec36.SetRange(Rec36."Document Type",2);
               Rec36.SetRange(Rec36."Bill-to Customer No.","Sales Shipment Header"."Bill-to Customer No.");
               Rec36.SetRange(Rec36."Currency Code","Sales Shipment Header"."Currency Code");
               Rec36.SetRange(Rec36."Payment Method Code","Sales Shipment Header"."Payment Method Code");
               Rec36.SetRange(Rec36."Payment Terms Code","Sales Shipment Header"."Payment Terms Code");
               Rec36.SetRange(Rec36."Payment Discount %","Sales Shipment Header"."Payment Discount %");
           ///    IF PAGOCLI<>'' THEN BEGIN
        ///            Rec36.SETRANGE(Rec36."Pay-at Code",PAGOCLI);
        ///       END;
               if Rec36.Find('-') then begin
                    NDOC:=Rec36."No.";
               end;
               if not Rec36.Find('-') then begin
                    Rec36.Init;
                    Rec36."Document Type":=2;
                    Rec36."No.":='';
                    Rec36.Insert(true);
                    Rec36.Validate(Rec36."Sell-to Customer No.","Sales Shipment Header"."Bill-to Customer No.");
                    Rec36.Validate(Rec36."Posting Date",FechaRegisSoli);
                    Rec36.Validate(Rec36."Document Date",FechaDocSol);
                    Rec36.Validate(Rec36."Currency Code","Sales Shipment Header"."Currency Code");
                    Rec36.Validate(Rec36."Ship-to Code","Sales Shipment Header"."Ship-to Code");
                    Rec36.Validate(Rec36."Payment Method Code","Sales Shipment Header"."Payment Method Code");
                    Rec36.Validate(Rec36."Payment Terms Code","Sales Shipment Header"."Payment Terms Code");
        ///            Rec36."Salesperson Code" := "Sales Shipment Header"."Salesperson Code";
        ///            Rec36."Pay-at Code" := PAGOCLI;
        ///            Rec36."Cust. Bank Acc. Code":=RecClie."Default Bank Acc. Code";
                    Rec36."Shipping Agent Code" := "Sales Shipment Header"."Shipping Agent Code";
        ///            Rec36."No. Series":="Sales Shipment Header"."No. Series";
        ///            Rec36."Posting No. Series":='';
                    Rec36."Payment Discount %":="Sales Shipment Header"."Payment Discount %";
                    Rec36.Modify;
                    NDOC:=Rec36."No.";
               end;
          end;
          if not AgrupaAlb then begin
                    Rec36.Init;
                    Rec36."Document Type":=2;
                    Rec36."No.":='';
                    Rec36.Insert(true);
                    Rec36.Validate(Rec36."Sell-to Customer No.","Sales Shipment Header"."Bill-to Customer No.");
                    Rec36.Validate(Rec36."Posting Date",FechaRegisSoli);
                    Rec36.Validate(Rec36."Document Date",FechaDocSol);
                    Rec36.Validate(Rec36."Currency Code","Sales Shipment Header"."Currency Code");
                    Rec36.Validate(Rec36."Ship-to Code","Sales Shipment Header"."Ship-to Code");
                    Rec36.Validate(Rec36."Payment Method Code","Sales Shipment Header"."Payment Method Code");
                    Rec36.Validate(Rec36."Payment Terms Code","Sales Shipment Header"."Payment Terms Code");
        ///            Rec36."Salesperson Code" := "Sales Shipment Header"."Salesperson Code";
        ///            Rec36."Pay-at Code" := PAGOCLI;
        ////            Rec36."Cust. Bank Acc. Code":=RecClie."Default Bank Acc. Code";
                    Rec36."Shipping Agent Code" := "Sales Shipment Header"."Shipping Agent Code";
        ///            Rec36."No. Series":="Sales Shipment Header"."No. Series";
        ///            Rec36."Posting No. Series":='';
                    Rec36."Payment Discount %":="Sales Shipment Header"."Payment Discount %";
                    Rec36.Modify;
                    NDOC:=Rec36."No.";
          end;
    end;

    local procedure FinalizeSalesInvHeader()
    begin
        with SalesHeader do begin
          if CalcInvDisc then
            SalesCalcDisc.Run(SalesLine);
          SalesHeader.Find;
          DimMgt.TransferTempToDimToDocDim(TempToLineDim);
          Commit;
          Clear(SalesCalcDisc);
          Clear(SalesPost);
          NoOfSalesInv := NoOfSalesInv + 1;
          if PostInv then begin
            Clear(SalesPost);
            if not SalesPost.Run(SalesHeader) then
              NoOfSalesInvErrors := NoOfSalesInvErrors + 1;
          end;
        end;
    end;

    local procedure InsertSalesInvHeader()
    begin
    end;
}

