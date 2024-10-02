#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50038 "Comisiones Plus"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Comisiones Plus.rdlc';
    Caption = 'Comisiones';

    dataset
    {
        dataitem("Salesperson/Purchaser";"Salesperson/Purchaser")
        {
            DataItemTableView = sorting(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code";
            column(ReportForNavId_3065; 3065)
            {
            }
            column(STRSUBSTNO_Text000_PeriodText_;StrSubstNo(Text000,PeriodText))
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(COMPANYNAME;CompanyProperty.DisplayName)
            {
            }
            column(Salesperson_Purchaser__TABLECAPTION__________SalespersonFilter;TableCaption + ': ' + SalespersonFilter)
            {
            }
            column(SalespersonFilter;SalespersonFilter)
            {
            }
            column(Cust__Ledger_Entry__TABLECAPTION__________CustLedgEntryFilter;"Cust. Ledger Entry".TableCaption + ': ' + CustLedgEntryFilter)
            {
            }
            column(CustLedgEntryFilter;CustLedgEntryFilter)
            {
            }
            column(PageGroupNo;PageGroupNo)
            {
            }
            column(Salesperson_Purchaser_Code;Code)
            {
            }
            column(Salesperson_Purchaser_Name;Name)
            {
            }
            column(Salesperson_Purchaser__Commission___;"Commission %")
            {
            }
            column(Cust__Ledger_Entry___Sales__LCY__;"Cust. Ledger Entry"."Sales (LCY)")
            {
            }
            column(Cust__Ledger_Entry___Profit__LCY__;"Cust. Ledger Entry"."Profit (LCY)")
            {
            }
            column(SalesCommissionAmt;SalesCommissionAmt)
            {
                AutoFormatType = 1;
            }
            column(ProfitCommissionAmt;ProfitCommissionAmt)
            {
                AutoFormatType = 1;
            }
            column(AdjProfit;AdjProfit)
            {
                AutoFormatType = 1;
            }
            column(AdjProfitCommissionAmt;AdjProfitCommissionAmt)
            {
                AutoFormatType = 1;
            }
            column(Salesperson___CommissionCaption;Salesperson___CommissionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption;All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption;Cust__Ledger_Entry__Posting_Date_CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Document_No__Caption;"Cust. Ledger Entry".FieldCaption("Document No."))
            {
            }
            column(Cust__Ledger_Entry__Customer_No__Caption;"Cust. Ledger Entry".FieldCaption("Customer No."))
            {
            }
            column(Cust__Ledger_Entry__Sales__LCY__Caption;"Cust. Ledger Entry".FieldCaption("Sales (LCY)"))
            {
            }
            column(Cust__Ledger_Entry__Profit__LCY__Caption;'Importe linea')
            {
            }
            column(SalesCommissionAmt_Control32Caption;SalesCommissionAmt_Control32CaptionLbl)
            {
            }
            column(ProfitCommissionAmt_Control33Caption;ProfitCommissionAmt_Control33CaptionLbl)
            {
            }
            column(AdjProfit_Control39Caption;AdjProfit_Control39CaptionLbl)
            {
            }
            column(AdjProfitCommissionAmt_Control45Caption;AdjProfitCommissionAmt_Control45CaptionLbl)
            {
            }
            column(Salesperson_Purchaser__Commission___Caption;FieldCaption("Commission %"))
            {
            }
            column(TotalCaption;TotalCaptionLbl)
            {
            }
            dataitem("Cust. Ledger Entry";"Cust. Ledger Entry")
            {
                DataItemLink = "Salesperson Code"=field(Code);
                DataItemTableView = sorting("Salesperson Code","Posting Date") where("Document Type"=filter(Invoice|"Credit Memo"));
                RequestFilterFields = "Posting Date";
                column(ReportForNavId_8503; 8503)
                {
                }
                column(Cust__Ledger_Entry__Posting_Date_;Format("Posting Date"))
                {
                }
                column(Cust__Ledger_Entry__Document_No__;"Document No.")
                {
                }
                column(Cust__Ledger_Entry__Customer_No__;"Customer No.")
                {
                }
                column(Cust__Ledger_Entry__Sales__LCY__;"Sales (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Profit__LCY__;"Profit (LCY)")
                {
                }
                column(SalesCommissionAmt_Control32;SalesCommissionAmt)
                {
                    AutoFormatType = 1;
                }
                column(ProfitCommissionAmt_Control33;ProfitCommissionAmt)
                {
                    AutoFormatType = 1;
                }
                column(AdjProfit_Control39;AdjProfit)
                {
                    AutoFormatType = 1;
                }
                column(AdjProfitCommissionAmt_Control45;AdjProfitCommissionAmt)
                {
                    AutoFormatType = 1;
                }
                column(Salesperson_Purchaser__Name;"Salesperson/Purchaser".Name)
                {
                }
                column(SICustomeDiscGroup;SalesInvoiceHeader."Customer Disc. Group")
                {
                }
                column(totalVende;totalVende)
                {
                }
                column(IMPAGADOS;'IMPAGADOS')
                {
                }
                column(impagadosmes;impagadosmes)
                {
                }
                column(RECUPERADOS;'RECUPERADOS')
                {
                }
                column(recuperadosmes;recuperadosmes)
                {
                }
                column(Ventasportes;'Ventas + portes')
                {
                }
                column(GLOBALVENTAS;GLOBALVENTAS)
                {
                }
                column(Objetivo;'Objetivo')
                {
                }
                column(TOTALVENTAV;TOTALVENTAV)
                {
                }
                column("ComisiónTOTAL";'Comisión TOTAL')
                {
                }
                column(comisiontotal;comisiontotal)
                {
                }
                column(textoaumento;textoaumento)
                {
                }
                column(aumneto;aumneto)
                {
                }
                column(Entregadoacuenta;'Entregado a cuenta')
                {
                }
                column(entregadoaceunta;entregadoaceunta)
                {
                }
                column(Totalgeneral;'Total general')
                {
                }
                column(TOTALC;TOTALC)
                {
                }
                column(TotalComisionLinea;TotalComisionLinea)
                {
                }
                column(TotalVenta;TotalVenta)
                {
                }
                column(TotalComision;TotalComision)
                {
                }
                column(VentaLinea;VentaLinea)
                {
                }
                column(Porcentaje;Porcentaje)
                {
                }
                column(TasaAplica;TasaAplica)
                {
                }
                column(SUMAPORTES;SUMAPORTES)
                {
                }
                column(TOTALPORTES;TOTALPORTES)
                {
                }
                column(mediacomi;mediacomi)
                {
                }

                trigger OnAfterGetRecord()
                var
                    CostCalcMgt: Codeunit "Cost Calculation Management";
                begin
                    
                    
                    if "Cust. Ledger Entry"."Customer No."='6445' then begin
                         CurrReport.Skip;
                    end;
                    
                    /// 0,Pago,Factura,Abono,Docs. interés,Recordatorio,Reembolso,,,,,,,,,,,,,,,Efecto
                    if "Cust. Ledger Entry"."Document Type"="Cust. Ledger Entry"."document type"::Invoice then begin
                    
                         SalesInvoiceLine.Reset;
                         SalesInvoiceLine.SetRange(SalesInvoiceLine."Document No.","Cust. Ledger Entry"."Document No.");
                         /////SalesInvoiceLine.SETRANGE(Type,SalesInvoiceLine.Type::Item);
                         if SalesInvoiceLine.FindFirst then repeat
                           if SalesInvoiceLine."Document No."='18FV040715' then begin
                             Message('a');
                             end;
                    
                              codprod:=SalesInvoiceLine."No.";
                              if codprod='43165' then begin
                                               Message(' %1',codprod);
                                               end;
                              Objetivosvendedores.Reset;
                              Objetivosvendedores.SetRange(Vendedor,"Salesperson/Purchaser".Code);
                              Objetivosvendedores.SetRange(Tipo,Objetivosvendedores.Tipo::Plus);
                              Objetivosvendedores.SetRange(Código,codprod);
                              if Objetivosvendedores.FindFirst then begin
                    
                                   Objetivosvendedores."Cantidad vendida":=Objetivosvendedores."Cantidad vendida"+SalesInvoiceLine.Quantity;
                                   Objetivosvendedores.Modify;
                              //     MESSAGE('1 %1',SalesInvoiceLine."Document No.");
                              end;
                              if not Objetivosvendedores.FindFirst then begin
                    
                                   if Item.Get(SalesInvoiceLine."No.") then begin
                                        if Item."Producto PADRE"<>'' then begin
                                             codprod:=Item."Producto PADRE";
                                             if codprod='43165' then begin
                                               Message(' %1',codprod);
                                               end;
                                             Objetivosvendedores.Reset;
                                             Objetivosvendedores.SetRange(Vendedor,"Salesperson/Purchaser".Code);
                                             Objetivosvendedores.SetRange(Tipo,Objetivosvendedores.Tipo::Plus);
                                             Objetivosvendedores.SetRange(Código,codprod);
                                             if Objetivosvendedores.FindFirst then begin
                                                  Objetivosvendedores."Cantidad vendida":=Objetivosvendedores."Cantidad vendida"+SalesInvoiceLine.Quantity;
                                                  Objetivosvendedores.Modify;
                    ///                              MESSAGE('2 %1',SalesInvoiceLine."Document No.");
                    
                                             end;
                                        end;
                                   end;
                              end;
                    
                         until SalesInvoiceLine.Next=0;
                    end;
                    
                    
                    
                    /*
                    /// 0,Pago,Factura,Abono,Docs. interés,Recordatorio,Reembolso,,,,,,,,,,,,,,,Efecto
                    IF "Cust. Ledger Entry"."Document Type"="Cust. Ledger Entry"."Document Type"::"Credit Memo" THEN BEGIN
                    
                    
                         SalesCrMemoLine.RESET;
                         SalesCrMemoLine.SETRANGE(SalesCrMemoLine."Document No.","Cust. Ledger Entry"."Document No.");
                         SalesCrMemoLine.SETRANGE(Type,SalesCrMemoLine.Type::Item);
                         IF SalesCrMemoLine.FINDSET THEN REPEAT
                               codprod:=SalesCrMemoLine."No.";
                               IF Item.GET(SalesCrMemoLine."No.") THEN BEGIN
                               IF Item."Producto PADRE"<>'' THEN BEGIN
                                 codprod:=Item."Producto PADRE";
                                 END;
                    
                              END;
                              Objetivosvendedores.RESET;
                              Objetivosvendedores.SETRANGE(Objetivosvendedores.Vendedor,"Salesperson/Purchaser".Code);
                              Objetivosvendedores.SETRANGE(Tipo,Objetivosvendedores.Tipo::Plus);
                              Objetivosvendedores.SETRANGE(Objetivosvendedores.Código,codprod);
                              IF Objetivosvendedores.FINDFIRST THEN BEGIN
                                   Objetivosvendedores."Cantidad vendida":=Objetivosvendedores."Cantidad vendida"+SalesCrMemoLine.Quantity*-1;
                                    Objetivosvendedores.MODIFY;
                              END;
                         UNTIL SalesInvoiceLine.NEXT=0;
                    END;
                    */

                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CreateTotals(
                      ProfitCommissionAmt,AdjProfitCommissionAmt,SalesCommissionAmt);
                end;
            }
            dataitem(UnknownTable50014;UnknownTable50014)
            {
                DataItemLink = Vendedor=field(Code);
                DataItemTableView = sorting(Vendedor,Tipo,Código,Año,Desde) where(Tipo=const(Plus));
                column(ReportForNavId_1000000027; 1000000027)
                {
                }
                column("ObjetivosvendedoresCódigo";Objetivosvendedores.Código)
                {
                }
                column(ObjetivosvendedoresDescripiconproducto;Objetivosvendedores."Descripicon producto")
                {
                }
                column(ObjetivosvendedoresCantidad;Objetivosvendedores.Cantidad)
                {
                }
                column(ObjetivosvendedoresCantidadvendida;Objetivosvendedores."Cantidad vendida")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                if PrintOnlyOnePerPage then
                  PageGroupNo := PageGroupNo + 1;


                desde:="Cust. Ledger Entry".GetRangeMin("Posting Date");

                AÑO:=Date2dmy(desde,3);

                MES:=Date2dmy(desde,2);
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;

                CurrReport.NewPagePerRecord := PrintOnlyOnePerPage;
                CurrReport.CreateTotals(
                  "Cust. Ledger Entry"."Sales (LCY)","Cust. Ledger Entry"."Profit (LCY)",
                  AdjProfit,ProfitCommissionAmt,AdjProfitCommissionAmt,SalesCommissionAmt);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintOnlyOnePerPage;PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Suite;
                        Caption = 'New Page per Person';
                        ToolTip = 'Specifies if each person''s information is printed on a new page if you have chosen two or more persons to be included in the report.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        SalespersonFilter := "Salesperson/Purchaser".GetFilters;
        CustLedgEntryFilter := "Cust. Ledger Entry".GetFilters;
        PeriodText := "Cust. Ledger Entry".GetFilter("Posting Date");
    end;

    var
        Text000: label 'Period: %1';
        SalespersonFilter: Text;
        CustLedgEntryFilter: Text;
        PeriodText: Text;
        AdjProfit: Decimal;
        ProfitCommissionAmt: Decimal;
        AdjProfitCommissionAmt: Decimal;
        SalesCommissionAmt: Decimal;
        PrintOnlyOnePerPage: Boolean;
        PageGroupNo: Integer;
        Salesperson___CommissionCaptionLbl: label 'Salesperson - Commission';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        All_amounts_are_in_LCYCaptionLbl: label 'All amounts are in LCY';
        Cust__Ledger_Entry__Posting_Date_CaptionLbl: label 'Posting Date';
        SalesCommissionAmt_Control32CaptionLbl: label 'Sales Commission (LCY)';
        ProfitCommissionAmt_Control33CaptionLbl: label 'Profit Commission (LCY)';
        AdjProfit_Control39CaptionLbl: label 'Adjusted Profit (LCY)';
        AdjProfitCommissionAmt_Control45CaptionLbl: label 'Adjusted Profit Commission (LCY)';
        TotalCaptionLbl: label 'Total';
        Objetivosvendedores: Record UnknownRecord50014;
        ImporteFac: Decimal;
        Porcentaje: Decimal;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        totalVende: Decimal;
        Rec3: Record UnknownRecord50014;
        Rec33: Record UnknownRecord50014;
        DTM3: Decimal;
        DTM2: Decimal;
        DTM1: Decimal;
        HTM3: Decimal;
        HTM2: Decimal;
        HTM1: Decimal;
        suma1: Decimal;
        color: Code[10];
        margenlin: Decimal;
        TDESDE: array [5] of Decimal;
        CUANTALIN: Integer;
        MEDIACOL: Decimal;
        RecConfV: Record "Sales & Receivables Setup";
        THASTA: array [5] of Decimal;
        sumamar: Decimal;
        contalin: Integer;
        tantocom2: Decimal;
        totalcomi2: Decimal;
        TOTASUMA2: Decimal;
        MEDIA2: Decimal;
        impagados2013: Decimal;
        impagados2014: Decimal;
        RecCliente: Record Customer;
        TotalComisionImp: Decimal;
        impagadosmes: Decimal;
        recuperadosmes: Decimal;
        tantorecu: Decimal;
        tantoimpa: Decimal;
        TotalImpaga: Decimal;
        Totalrecupera: Decimal;
        exentocolores: Boolean;
        RecItem: Record Item;
        datoa: Decimal;
        datob: Decimal;
        divisor: Decimal;
        aumneto: Decimal;
        textoaumento: Text[30];
        "AÑO": Integer;
        desde: Date;
        MES: Integer;
        entregadoaceunta: Decimal;
        GLOBALVENTAS: Decimal;
        TOTALVENTAV: Decimal;
        INCRETRAMO: Decimal;
        TANTOTARMO: Decimal;
        CUANTOSTRAMOS: Decimal;
        Media22: Decimal;
        TotalVenta: Decimal;
        TotalComision: Decimal;
        TOTALC: Decimal;
        comisiontotal: Decimal;
        Tasa: Decimal;
        TotalComisionLinea: Decimal;
        VentaLinea: Decimal;
        Comisionesporgrupo: Record UnknownRecord50006;
        TasaAplica: Decimal;
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SUMAPORTES: Decimal;
        TOTALPORTES: Decimal;
        mediacomi: Decimal;
        codprod: Code[20];
        Item: Record Item;
}

