#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50012 Comisiones
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Comisiones.rdlc';
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
                column(TotalComisionLinea;TotalComisionLinea)
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
                column(NombreCliente;NombreCliente)
                {
                }
                column("ComisiónTOTAL";'Comisión TOTAL')
                {
                }
                column(Totalgeneral;'Total general')
                {
                }
                column(RECUPERADOS;'RECUPERADOS')
                {
                }
                column(IMPAGADOS;'IMPAGADOS')
                {
                }
                column(Ventasportes;'Ventas + portes')
                {
                }
                column(Objetivo;'Objetivo')
                {
                }
                column(Entregadoacuenta;'Entregado a cuenta')
                {
                }
                column(TOTALVENTAV;TOTALVENTAV)
                {
                }

                trigger OnAfterGetRecord()
                var
                    CostCalcMgt: Codeunit "Cost Calculation Management";
                begin
                    
                    
                    
                    
                    
                    if "Cust. Ledger Entry"."Customer No."='6445' then begin
                         CurrReport.Skip;
                    end;
                    
                    
                    NombreCliente:='';
                    
                    
                    
                    /// 0,Pago,Factura,Abono,Docs. interés,Recordatorio,Reembolso,,,,,,,,,,,,,,,Efecto
                    if "Cust. Ledger Entry"."Document Type"="Cust. Ledger Entry"."document type"::Invoice then begin
                         SalesInvoiceHeader.Init;
                         if SalesInvoiceHeader.Get("Cust. Ledger Entry"."Document No.") then begin
                              NombreCliente:=SalesInvoiceHeader."Sell-to Customer Name";
                         end;
                         if SalesInvoiceHeader."Customer Disc. Group"='' then begin
                             SalesInvoiceHeader."Customer Disc. Group":='DC30';
                         end;
                         SUMAPORTES:=0;
                         SalesInvoiceLine.Reset;
                         SalesInvoiceLine.SetRange(SalesInvoiceLine."Document No.","Cust. Ledger Entry"."Document No.");
                         if SalesInvoiceLine.FindSet then repeat
                              if SalesInvoiceLine."No."='62400000' then begin
                                   SUMAPORTES:=SUMAPORTES+SalesInvoiceLine.Amount;
                              end;
                              if SalesInvoiceLine."No."='TRAN' then begin
                                   SUMAPORTES:=SUMAPORTES+SalesInvoiceLine.Amount;
                              end;
                         until SalesInvoiceLine.Next=0;
                         TOTALPORTES:=TOTALPORTES+SUMAPORTES;
                    
                              Porcentaje:=0;
                              Objetivosvendedores.Reset;
                         Objetivosvendedores.SetRange(Objetivosvendedores.Vendedor,"Salesperson/Purchaser".Code);
                         Objetivosvendedores.SetRange(Objetivosvendedores.Código,SalesInvoiceHeader."Customer Disc. Group");
                         Objetivosvendedores.SetRange(Tipo,Objetivosvendedores.Tipo::"Comi-dto");
                         if Objetivosvendedores.FindSet then begin
                              Porcentaje:=Objetivosvendedores."Decremento comisión";
                              TasaAplica:="Salesperson/Purchaser"."Commission %"-((Porcentaje*"Salesperson/Purchaser"."Commission %")/100);
                              AdjProfit := ROUND(("Sales (LCY)"-SUMAPORTES) * (TasaAplica/100));
                              TotalVenta:=TotalVenta+("Sales (LCY)"-SUMAPORTES);
                         end;
                    end;
                    
                    
                    
                    /// 0,Pago,Factura,Abono,Docs. interés,Recordatorio,Reembolso,,,,,,,,,,,,,,,Efecto
                    if "Cust. Ledger Entry"."Document Type"="Cust. Ledger Entry"."document type"::"Credit Memo" then begin
                         SalesCrMemoHeader.Init;
                         if SalesCrMemoHeader.Get("Cust. Ledger Entry"."Document No.") then begin
                            NombreCliente:=SalesCrMemoHeader."Sell-to Customer Name";
                         end;
                         if SalesCrMemoHeader."Customer Disc. Group"='' then begin
                             SalesCrMemoHeader."Customer Disc. Group":='DC30';
                         end;
                         SUMAPORTES:=0;
                         SalesCrMemoLine.Reset;
                         SalesCrMemoLine.SetRange("Document No.","Cust. Ledger Entry"."Document No.");
                         if SalesCrMemoLine.FindSet then repeat
                              if SalesCrMemoLine."No."='62400000' then begin
                                   SUMAPORTES:=SUMAPORTES+SalesCrMemoLine.Amount;
                              end;
                              if SalesCrMemoLine."No."='TRAN' then begin
                                   SUMAPORTES:=SUMAPORTES+SalesCrMemoLine.Amount;
                              end;
                         until SalesCrMemoLine.Next=0;
                         TOTALPORTES:=TOTALPORTES-SUMAPORTES;
                    
                         Porcentaje:=0;
                         Objetivosvendedores.Reset;
                         Objetivosvendedores.SetRange(Objetivosvendedores.Vendedor,"Salesperson/Purchaser".Code);
                         Objetivosvendedores.SetRange(Objetivosvendedores.Código,SalesCrMemoHeader."Customer Disc. Group");
                         Objetivosvendedores.SetRange(Tipo,Objetivosvendedores.Tipo::"Comi-dto");
                         if Objetivosvendedores.FindSet then begin
                              Porcentaje:=Objetivosvendedores."Decremento comisión";
                              TasaAplica:="Salesperson/Purchaser"."Commission %"-((Porcentaje*"Salesperson/Purchaser"."Commission %")/100);
                              AdjProfit := ROUND(("Sales (LCY)"+SUMAPORTES) * (TasaAplica/100));
                              TotalVenta:=TotalVenta+("Sales (LCY)"+SUMAPORTES);
                    
                         end;
                    end;
                    
                    VentaLinea:="Sales (LCY)";
                    
                    TotalComisionLinea:=AdjProfit;
                    TotalComision:=TotalComision+AdjProfit;
                    
                    
                    
                    ///// Customer Disc. Group
                    
                    /*
                    
                    aumneto:=0;
                    
                    IF TOTALVENTAV<>0 THEN BEGIN
                         divisor:=((TotalVenta/TOTALVENTAV)*100)-100;
                         IF divisor>0 THEN BEGIN
                              IF divisor>10 THEN BEGIN
                                   textoaumento:='BONUS';
                                   aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*10/100,0.01);
                              END;
                              IF divisor>20 THEN BEGIN
                                   aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*20/100,0.01);
                              END;
                              IF divisor>30 THEN BEGIN
                                   aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*30/100,0.01);
                              END;
                              IF divisor>40 THEN BEGIN
                                   aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*40/100,0.01);
                              END;
                              TOTALC:=TotalComision+TOTASUMA2-entregadoaceunta+TotalImpaga+Totalrecupera+aumneto;
                         END;
                         IF "Salesperson/Purchaser".Autonomo=FALSE THEN BEGIN
                              IF divisor<0 THEN BEGIN
                                   divisor:=divisor*-1;
                                   IF (divisor>10) THEN BEGIN
                                        aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*10/100,0.01)*-1;
                                        textoaumento:='MALUS';
                                   END;
                                   IF (divisor>20) THEN BEGIN
                                        aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*20/100,0.01)*-1;
                                   END;
                                   IF (divisor>30) THEN BEGIN
                                        aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*30/100,0.01)*-1;
                                   END;
                                   TOTALC:=TotalComision+TOTASUMA2-entregadoaceunta+TotalImpaga+Totalrecupera+aumneto;
                                   IF divisor>40 THEN BEGIN
                                        aumneto:=0;
                                        TOTALC:=0;
                                        sincomision:=TRUE;
                                        /////TotalComision:=0;
                                  END;
                             END;
                        END;
                    END;
                    
                    TOTALC:=TotalComision+aumneto;
                    
                    mediacomi:=0;
                    IF TotalVenta<>0 THEN BEGIN
                         mediacomi:=ROUND(TotalComision/TotalVenta*100,0.01);
                    END;
                    comisiontotal:=TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera;
                    
                    IF sincomision THEN BEGIN
                        comisiontotal:=0;
                        TOTALC:=0;
                    END;
                    */

                end;

                trigger OnPostDataItem()
                begin
                    
                    /*
                    aumneto:=0;
                    
                    IF TOTALVENTAV<>0 THEN BEGIN
                         divisor:=((TotalVenta/TOTALVENTAV)*100)-100;
                         IF divisor>0 THEN BEGIN
                              IF divisor>10 THEN BEGIN
                                   textoaumento:='BONUS';
                                   aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*10/100,0.01);
                              END;
                              IF divisor>20 THEN BEGIN
                                   aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*20/100,0.01);
                              END;
                              IF divisor>30 THEN BEGIN
                                   aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*30/100,0.01);
                              END;
                              IF divisor>40 THEN BEGIN
                                   aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*40/100,0.01);
                              END;
                              TOTALC:=TotalComision+TOTASUMA2-entregadoaceunta+TotalImpaga+Totalrecupera+aumneto;
                         END;
                         IF "Salesperson/Purchaser".Autonomo=FALSE THEN BEGIN
                              IF divisor<0 THEN BEGIN
                                   divisor:=divisor*-1;
                                   IF (divisor>10) THEN BEGIN
                                        aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*10/100,0.01)*-1;
                                        textoaumento:='MALUS';
                                   END;
                                   IF (divisor>20) THEN BEGIN
                                        aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*20/100,0.01)*-1;
                                   END;
                                   IF (divisor>30) THEN BEGIN
                                        aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*30/100,0.01)*-1;
                                   END;
                                   TOTALC:=TotalComision+TOTASUMA2-entregadoaceunta+TotalImpaga+Totalrecupera+aumneto;
                                   IF divisor>40 THEN BEGIN
                                        aumneto:=0;
                                        TOTALC:=0;
                                        sincomision:=TRUE;
                                        /////TotalComision:=0;
                                  END;
                             END;
                        END;
                    END;
                    
                    TOTALC:=TotalComision+aumneto;
                    
                    mediacomi:=0;
                    IF TotalVenta<>0 THEN BEGIN
                         mediacomi:=ROUND(TotalComision/TotalVenta*100,0.01);
                    END;
                    comisiontotal:=TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera;
                    
                    IF sincomision THEN BEGIN
                        comisiontotal:=0;
                        TOTALC:=0;
                    END;
                    */

                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CreateTotals(
                      "Sales (LCY)","Profit (LCY)",AdjProfit,
                      ProfitCommissionAmt,AdjProfitCommissionAmt,SalesCommissionAmt);
                end;
            }
            dataitem("Integer";"Integer")
            {
                MaxIteration = 1;
                column(ReportForNavId_1000000027; 1000000027)
                {
                }
                column(TOTALPORTES;TOTALPORTES)
                {
                }
                column(SUMAPORTES;SUMAPORTES)
                {
                }
                column(TotalVenta;TotalVenta)
                {
                }
                column(TotalComision;TotalComision)
                {
                }
                column(TOTALC;TOTALC)
                {
                }
                column(totalVende;totalVende)
                {
                }
                column(impagadosmes;impagadosmes)
                {
                }
                column(recuperadosmes;recuperadosmes)
                {
                }
                column(GLOBALVENTAS;GLOBALVENTAS)
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
                column(entregadoaceunta;entregadoaceunta)
                {
                }
                column(mediacomi;mediacomi)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    sincomision:=false;
                    aumneto:=0;

                    if TOTALVENTAV<>0 then begin
                         divisor:=((TotalVenta/TOTALVENTAV)*100)-100;
                         if divisor>0 then begin
                              if divisor>10 then begin
                                   textoaumento:='BONUS';
                                   aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*10/100,0.01);
                              end;
                              if divisor>20 then begin
                                   aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*20/100,0.01);
                              end;
                              if divisor>30 then begin
                                   aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*30/100,0.01);
                              end;
                              if divisor>40 then begin
                                   aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*40/100,0.01);
                              end;
                              TOTALC:=TotalComision+TOTASUMA2-entregadoaceunta+TotalImpaga+Totalrecupera+aumneto;
                         end;
                         if "Salesperson/Purchaser".Autonomo=false then begin
                              if divisor<0 then begin
                                   divisor:=divisor*-1;
                                   if (divisor>10) then begin
                                        aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*10/100,0.01)*-1;
                                        textoaumento:='MALUS';
                                   end;
                                   if (divisor>20) then begin
                                        aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*20/100,0.01)*-1;
                                   end;
                                   if (divisor>30) then begin
                                        aumneto:=ROUND((TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera)*30/100,0.01)*-1;
                                   end;
                                   TOTALC:=TotalComision+TOTASUMA2-entregadoaceunta+TotalImpaga+Totalrecupera+aumneto;
                                   if divisor>40 then begin
                                        aumneto:=0;
                                        sincomision:=true;
                                  end;
                             end;
                        end;
                    end;

                    TOTALC:=TotalComision+aumneto;

                    mediacomi:=0;
                    if TotalVenta<>0 then begin
                         mediacomi:=ROUND(TotalComision/TotalVenta*100,0.01);
                    end;
                    comisiontotal:=TotalComision+TOTASUMA2+TotalImpaga+Totalrecupera;

                    if sincomision then begin
                        comisiontotal:=0;
                        TOTALC:=0;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if PrintOnlyOnePerPage then
                  PageGroupNo := PageGroupNo + 1;


                desde:="Cust. Ledger Entry".GetRangeMin("Posting Date");

                AÑO:=Date2dmy(desde,3);

                MES:=Date2dmy(desde,2);


                sincomision:=false;


                Rec33.Reset;
                Rec33.SetRange(Rec33.Vendedor,"Salesperson/Purchaser".Code);
                Rec33.SetRange(Rec33.Año,AÑO);
                Rec33.SetRange(Rec33.Tipo,7);
                if Rec33.FindFirst then begin
                     if MES=1 then entregadoaceunta:=Rec33.Enero;
                     if MES=2 then entregadoaceunta:=Rec33.Febrero;
                     if MES=3 then entregadoaceunta:=Rec33.Marzo;
                     if MES=4 then entregadoaceunta:=Rec33.Abril;
                     if MES=5 then entregadoaceunta:=Rec33.Mayo;
                     if MES=6 then entregadoaceunta:=Rec33.Junio;
                     if MES=7 then entregadoaceunta:=Rec33.Julio;
                     if MES=8 then entregadoaceunta:=Rec33.Agosto;
                     if MES=9 then entregadoaceunta:=Rec33.Septiembre;
                     if MES=10 then entregadoaceunta:=Rec33.Octubre;
                     if MES=11 then entregadoaceunta:=Rec33.Noviembre;
                     if MES=12 then entregadoaceunta:=Rec33.Diciembre;
                end;



                TotalImpaga:=0;
                TotalImpaga:=0;
                tantoimpa:=0;
                tantorecu:=0;
                recuperadosmes:=0;
                impagadosmes:=0;
                Rec3.Reset;
                Rec3.SetRange(Rec3.Vendedor,"Salesperson/Purchaser".Code);
                Rec3.SetRange(Rec3.Año,AÑO);
                Rec3.SetRange(Rec3.Tipo,8);
                if Rec3.FindFirst then begin
                     if MES=1 then impagadosmes:=Rec3.Enero;
                     if MES=2 then impagadosmes:=Rec3.Febrero;
                     if MES=3 then impagadosmes:=Rec3.Marzo;
                     if MES=4 then impagadosmes:=Rec3.Abril;
                     if MES=5 then impagadosmes:=Rec3.Mayo;
                     if MES=6 then impagadosmes:=Rec3.Junio;
                     if MES=7 then impagadosmes:=Rec3.Julio;
                     if MES=8 then impagadosmes:=Rec3.Agosto;
                     if MES=9 then impagadosmes:=Rec3.Septiembre;
                     if MES=10 then impagadosmes:=Rec3.Octubre;
                     if MES=11 then impagadosmes:=Rec3.Noviembre;
                     if MES=12 then impagadosmes:=Rec3.Diciembre;
                end;

                Rec3.Reset;
                Rec3.SetRange(Rec3.Vendedor,"Salesperson/Purchaser".Code);
                Rec3.SetRange(Rec3.Año,AÑO);
                Rec3.SetRange(Rec3.Tipo,10);
                if Rec3.FindFirst then begin
                     if MES=1 then tantoimpa:=Rec3.Enero;
                     if MES=2 then tantoimpa:=Rec3.Febrero;
                     if MES=3 then tantoimpa:=Rec3.Marzo;
                     if MES=4 then tantoimpa:=Rec3.Abril;
                     if MES=5 then tantoimpa:=Rec3.Mayo;
                     if MES=6 then tantoimpa:=Rec3.Junio;
                     if MES=7 then tantoimpa:=Rec3.Julio;
                     if MES=8 then tantoimpa:=Rec3.Agosto;
                     if MES=9 then tantoimpa:=Rec3.Septiembre;
                     if MES=10 then tantoimpa:=Rec3.Octubre;
                     if MES=11 then tantoimpa:=Rec3.Noviembre;
                     if MES=12 then tantoimpa:=Rec3.Diciembre;
                end;

                Rec3.Reset;
                Rec3.SetRange(Rec3.Vendedor,"Salesperson/Purchaser".Code);
                Rec3.SetRange(Rec3.Año,AÑO);
                Rec3.SetRange(Rec3.Tipo,9);
                if Rec3.FindFirst then begin
                     if MES=1 then recuperadosmes:=Rec3.Enero;
                     if MES=2 then recuperadosmes:=Rec3.Febrero;
                     if MES=3 then recuperadosmes:=Rec3.Marzo;
                     if MES=4 then recuperadosmes:=Rec3.Abril;
                     if MES=5 then recuperadosmes:=Rec3.Mayo;
                     if MES=6 then recuperadosmes:=Rec3.Junio;
                     if MES=7 then recuperadosmes:=Rec3.Julio;
                     if MES=8 then recuperadosmes:=Rec3.Agosto;
                     if MES=9 then recuperadosmes:=Rec3.Septiembre;
                     if MES=10 then recuperadosmes:=Rec3.Octubre;
                     if MES=11 then recuperadosmes:=Rec3.Noviembre;
                     if MES=12 then recuperadosmes:=Rec3.Diciembre;
                end;

                Rec3.Reset;
                Rec3.SetRange(Rec3.Vendedor,"Salesperson/Purchaser".Code);
                Rec3.SetRange(Rec3.Año,AÑO);
                Rec3.SetRange(Rec3.Tipo,11);
                if Rec3.FindFirst then begin
                     if MES=1 then tantorecu:=Rec3.Enero;
                     if MES=2 then tantorecu:=Rec3.Febrero;
                     if MES=3 then tantorecu:=Rec3.Marzo;
                     if MES=4 then tantorecu:=Rec3.Abril;
                     if MES=5 then tantorecu:=Rec3.Mayo;
                     if MES=6 then tantorecu:=Rec3.Junio;
                     if MES=7 then tantorecu:=Rec3.Julio;
                     if MES=8 then tantorecu:=Rec3.Agosto;
                     if MES=9 then tantorecu:=Rec3.Septiembre;
                     if MES=10 then tantorecu:=Rec3.Octubre;
                     if MES=11 then tantorecu:=Rec3.Noviembre;
                     if MES=12 then tantorecu:=Rec3.Diciembre;
                end;


                TotalImpaga:=ROUND(impagadosmes*tantoimpa/100,0.01)*-1;
                Totalrecupera:=ROUND(recuperadosmes*tantorecu/100,0.01);

                GLOBALVENTAS:=GLOBALVENTAS+TotalImpaga+Totalrecupera;



                Rec3.Reset;
                Rec3.SetRange(Rec3.Vendedor,"Salesperson/Purchaser".Code);
                Rec3.SetRange(Rec3.Año,AÑO);
                Rec3.SetRange(Rec3.Tipo,0);
                if Rec3.FindFirst then begin
                     if MES=1 then TOTALVENTAV:=Rec3.Enero;
                     if MES=2 then TOTALVENTAV:=Rec3.Febrero;
                     if MES=3 then TOTALVENTAV:=Rec3.Marzo;
                     if MES=4 then TOTALVENTAV:=Rec3.Abril;
                     if MES=5 then TOTALVENTAV:=Rec3.Mayo;
                     if MES=6 then TOTALVENTAV:=Rec3.Junio;
                     if MES=7 then TOTALVENTAV:=Rec3.Julio;
                     if MES=8 then TOTALVENTAV:=Rec3.Agosto;
                     if MES=9 then TOTALVENTAV:=Rec3.Septiembre;
                     if MES=10 then TOTALVENTAV:=Rec3.Octubre;
                     if MES=11 then TOTALVENTAV:=Rec3.Noviembre;
                     if MES=12 then TOTALVENTAV:=Rec3.Diciembre;
                     INCRETRAMO:=Rec3."Importe tramos";
                     TANTOTARMO:=Rec3."% Incremento por tramo";
                end;



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
        NombreCliente: Text[100];
        sincomision: Boolean;
}

