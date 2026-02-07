#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50016 NuevasComisiones
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ComisionesNuevas.rdlc';
    Caption = 'Comisiones';
    ApplicationArea = All;
    UsageCategory = Lists;


    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            DataItemTableView = sorting(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code";
            column(ReportForNavId_3065; 3065)
            {
            }
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(COMPANYNAME; CompanyProperty.DisplayName)
            {
            }
            column(Salesperson_Purchaser__TABLECAPTION__________SalespersonFilter; TableCaption + ': ' + SalespersonFilter)
            {
            }
            column(SalespersonFilter; SalespersonFilter)
            {
            }
            column(Cust__Ledger_Entry__TABLECAPTION__________CustLedgEntryFilter; "Cust. Ledger Entry".TableCaption + ': ' + CustLedgEntryFilter)
            {
            }
            column(CustLedgEntryFilter; CustLedgEntryFilter)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(Salesperson_Purchaser_Code; Code)
            {
            }
            column(Salesperson_Purchaser_Name; Name)
            {
            }
            column(Salesperson_Purchaser__Commission___; "Commission %")
            {
            }
            column(Cust__Ledger_Entry___Sales__LCY__; "Cust. Ledger Entry"."Sales (LCY)")
            {
            }
            column(Cust__Ledger_Entry___Profit__LCY__; "Cust. Ledger Entry"."Profit (LCY)")
            {
            }
            column(SalesCommissionAmt; SalesCommissionAmt)
            {
                AutoFormatType = 1;
            }
            column(ProfitCommissionAmt; ProfitCommissionAmt)
            {
                AutoFormatType = 1;
            }
            column(AdjProfit; AdjProfit)
            {
                AutoFormatType = 1;
            }
            column(AdjProfitCommissionAmt; AdjProfitCommissionAmt)
            {
                AutoFormatType = 1;
            }
            column(Salesperson___CommissionCaption; Salesperson___CommissionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; Cust__Ledger_Entry__Posting_Date_CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Document_No__Caption; "Cust. Ledger Entry".FieldCaption("Document No."))
            {
            }
            column(Cust__Ledger_Entry__Customer_No__Caption; "Cust. Ledger Entry".FieldCaption("Customer No."))
            {
            }
            column(Cust__Ledger_Entry__Sales__LCY__Caption; "Cust. Ledger Entry".FieldCaption("Sales (LCY)"))
            {
            }
            column(Cust__Ledger_Entry__Profit__LCY__Caption; 'Importe linea')
            {
            }
            column(SalesCommissionAmt_Control32Caption; SalesCommissionAmt_Control32CaptionLbl)
            {
            }
            column(ProfitCommissionAmt_Control33Caption; ProfitCommissionAmt_Control33CaptionLbl)
            {
            }
            column(AdjProfit_Control39Caption; AdjProfit_Control39CaptionLbl)
            {
            }
            column(AdjProfitCommissionAmt_Control45Caption; AdjProfitCommissionAmt_Control45CaptionLbl)
            {
            }
            column(Salesperson_Purchaser__Commission___Caption; FieldCaption("Commission %"))
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Salesperson Code" = field(Code);
                DataItemTableView = sorting("Salesperson Code", "Posting Date") where("Document Type" = filter(Invoice | "Credit Memo"));
                RequestFilterFields = "Posting Date";

                column(ReportForNavId_8503; 8503)
                {
                }
                column(Cust__Ledger_Entry__Posting_Date_; Format("Posting Date"))
                {
                }
                column(Cust__Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Cust__Ledger_Entry__Customer_No__; "Customer No.")
                {
                }
                column(Cust__Ledger_Entry__Sales__LCY__; "Sales (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Profit__LCY__; "Profit (LCY)")
                {
                }
                column(SalesCommissionAmt_Control32; SalesCommissionAmt)
                {
                    AutoFormatType = 1;
                }
                column(ProfitCommissionAmt_Control33; ProfitCommissionAmt)
                {
                    AutoFormatType = 1;
                }
                column(AdjProfit_Control39; AdjProfit)
                {
                    AutoFormatType = 1;
                }
                column(AdjProfitCommissionAmt_Control45; AdjProfitCommissionAmt)
                {
                    AutoFormatType = 1;
                }
                column(Salesperson_Purchaser__Name; "Salesperson/Purchaser".Name)
                {
                }
                column(SICustomeDiscGroup; SalesInvoiceHeader."Customer Disc. Group")
                {
                }
                column(TotalComisionLinea; TotalComisionLinea)
                {
                }
                column(VentaLinea; VentaLinea)
                {
                }
                column(Porcentaje; Porcentaje)
                {
                }
                column(PorcentajeNew; PorcentajeNew)
                {
                }

                column(TasaAplica; TasaAplica)
                {
                }
                column(NombreCliente; NombreCliente)
                {
                }
                column("ComisiónTOTAL"; 'Comisión TOTAL')
                {
                }
                column(Totalgeneral; 'Total general')
                {
                }
                column(RECUPERADOS; 'RECUPERADOS')
                {
                }
                column(IMPAGADOS; 'IMPAGADOS')
                {
                }
                column(Ventasportes; 'Ventas + portes')
                {
                }
                column(Objetivo; 'Objetivo')
                {
                }
                column(Entregadoacuenta; 'Entregado a cuenta')
                {
                }
                column(TOTALVENTAV; TOTALVENTAV)
                {
                }
                column(ImpComision; ImpComision)
                {
                }
                column(TotalVentaAntes; TotalVentaAntes)
                {
                }
                column(DatoBonus; DatoBonus)
                {
                }
                column(Bonus; Bonus)
                {
                }
                column(DatoEscalado; DatoEscalado)
                {
                }
                column(impverde; impverde)
                {
                }
                column(improjo; improjo)
                {
                }
                column(impazul; impazul)
                {
                }
                column(D1; D1) { }
                column(D2; D2) { }
                column(D3; D3) { }
                column(D4; D4) { }
                column(D5; D5) { }
                column(D6; D6) { }
                column(D7; D7) { }
                column(D8; D8) { }
                column(D9; D9) { }
                column(D10; D10) { }
                column(D11; D11) { }
                column(D12; D12) { }
                column(D13; D13) { }
                column(D14; D14) { }
                column(D15; D15) { }
                column(D16; D16) { }
                column(D17; D17) { }
                column(D18; D18) { }
                column(D19; D19) { }












                trigger OnAfterGetRecord()
                var
                    CostCalcMgt: Codeunit "Cost Calculation Management";
                begin



                    impverde := 0;
                    improjo := 0;
                    impazul := 0;


                    if "Cust. Ledger Entry"."Customer No." = '6445' then begin
                        CurrReport.Skip;
                    end;



                    desde := "Cust. Ledger Entry".GetRangeMin("Posting Date");

                    AÑO := Date2dmy(desde, 3);
                    MES := Date2dmy(desde, 2);


                    Rec3.Reset;
                    Rec3.SetRange(Rec3.Vendedor, "Salesperson/Purchaser".Code);
                    Rec3.SetRange(Rec3.Año, AÑO);
                    Rec3.SetRange(Rec3.Tipo, 0);
                    if Rec3.FindFirst then begin
                        if MES = 1 then TOTALVENTAV := Rec3.Enero;
                        if MES = 2 then TOTALVENTAV := Rec3.Febrero;
                        if MES = 3 then TOTALVENTAV := Rec3.Marzo;
                        if MES = 4 then TOTALVENTAV := Rec3.Abril;
                        if MES = 5 then TOTALVENTAV := Rec3.Mayo;
                        if MES = 6 then TOTALVENTAV := Rec3.Junio;
                        if MES = 7 then TOTALVENTAV := Rec3.Julio;
                        if MES = 8 then TOTALVENTAV := Rec3.Agosto;
                        if MES = 9 then TOTALVENTAV := Rec3.Septiembre;
                        if MES = 10 then TOTALVENTAV := Rec3.Octubre;
                        if MES = 11 then TOTALVENTAV := Rec3.Noviembre;
                        if MES = 12 then TOTALVENTAV := Rec3.Diciembre;
                    end;
                    D13 := TOTALVENTAV;




                    TotalVentaAntes := 0;
                    desdeFecha := "Cust. Ledger Entry".GetRangeMin("Cust. Ledger Entry"."Posting Date");
                    hastaFecha := "Cust. Ledger Entry".GetRangeMax("Cust. Ledger Entry"."Posting Date");
                    CustLedgerEntry.reset;
                    CustLedgerEntry.SetRange("Salesperson Code", "Cust. Ledger Entry"."Salesperson Code");
                    CustLedgerEntry.SetRange("Posting Date", desdeFecha, hastaFecha);
                    if CustLedgerEntry.FindFirst() then
                        repeat
                            if CustLedgerEntry."Customer No." <> '6445' then begin
                                if CustLedgerEntry."Document Type" = CustLedgerEntry."document type"::Invoice then begin
                                    SalesInvoiceHeader.Init;
                                    if SalesInvoiceHeader.Get(CustLedgerEntry."Document No.") then begin
                                        NombreCliente := SalesInvoiceHeader."Sell-to Customer Name";
                                    end;
                                    if SalesInvoiceHeader."Customer Disc. Group" = '' then begin
                                        SalesInvoiceHeader."Customer Disc. Group" := 'DC30';
                                    end;
                                    SUMAPORTES := 0;
                                    SalesInvoiceLine.Reset;
                                    SalesInvoiceLine.SetRange(SalesInvoiceLine."Document No.", CustLedgerEntry."Document No.");
                                    if SalesInvoiceLine.FindSet then
                                        repeat
                                            if SalesInvoiceLine."No." = '62400000' then begin
                                                SUMAPORTES := SUMAPORTES + SalesInvoiceLine.Amount;
                                            end;
                                            if SalesInvoiceLine."No." = 'TRAN' then begin
                                                SUMAPORTES := SUMAPORTES + SalesInvoiceLine.Amount;
                                            end;
                                        until SalesInvoiceLine.Next = 0;
                                end;
                                if CustLedgerEntry."Document Type" = CustLedgerEntry."document type"::"Credit Memo" then begin
                                    SalesCrMemoHeader.Init;
                                    if SalesCrMemoHeader.Get(CustLedgerEntry."Document No.") then begin
                                        NombreCliente := SalesCrMemoHeader."Sell-to Customer Name";
                                    end;
                                    if SalesCrMemoHeader."Customer Disc. Group" = '' then begin
                                        SalesCrMemoHeader."Customer Disc. Group" := 'DC30';
                                    end;
                                    SUMAPORTES := 0;
                                    SalesCrMemoLine.Reset;
                                    SalesCrMemoLine.SetRange(SalesCrMemoLine."Document No.", CustLedgerEntry."Document No.");
                                    if SalesCrMemoLine.FindSet then
                                        repeat
                                            if SalesCrMemoLine."No." = '62400000' then begin
                                                SUMAPORTES := SUMAPORTES + SalesCrMemoLine.Amount * -1;
                                            end;
                                            if SalesCrMemoLine."No." = 'TRAN' then begin
                                                SUMAPORTES := SUMAPORTES + SalesCrMemoLine.Amount * -1;
                                            end;
                                        until SalesCrMemoLine.Next = 0;
                                end;
                                TotalVentaAntes := TotalVentaAntes + (CustLedgerEntry."Sales (LCY)" - SUMAPORTES);
                            end;
                        until CustLedgerEntry.next = 0;

                    Bonus := 0;
                    if TOTALVENTAV <> 0 then begin
                        Bonus := Round((TotalVentaAntes * 100 / TOTALVENTAV) - 100, 0.01);
                        if bonus > 0 then begin
                            RecBonusBuenos.Reset();
                            RecBonusBuenos.SetRange(Vendedor, "Salesperson/Purchaser".Code);
                            if RecBonusBuenos.FindFirst() then
                                repeat
                                    if (Bonus >= RecBonusBuenos.Incremento) then begin
                                        DatoBonus := RecBonusBuenos.Aumento;
                                    end;
                                until RecBonusBuenos.next = 0;
                        end;
                        if bonus < 0 then begin
                            bonus := bonus * -1;
                            RecBuenosMalos.Reset();
                            RecBuenosMalos.SetRange(Vendedor, "Salesperson/Purchaser".Code);
                            if RecBuenosMalos.FindFirst() then
                                repeat
                                    if (Bonus >= RecBuenosMalos.Incremento) then begin
                                        DatoBonus := RecBuenosMalos.Aumento * -1;
                                    end;
                                until RecBuenosMalos.next = 0;
                            bonus := bonus * -1;
                        end;


                    end;


                    Porcentaje := 0;
                    Objetivosvendedores.Reset;
                    Objetivosvendedores.SetRange(Objetivosvendedores.Vendedor, "Salesperson/Purchaser".Code);
                    if CustLedgerEntry."Document Type" = CustLedgerEntry."document type"::Invoice then begin
                        Objetivosvendedores.SetRange(Objetivosvendedores.Código, SalesInvoiceHeader."Customer Disc. Group");
                    end;
                    if CustLedgerEntry."Document Type" = CustLedgerEntry."document type"::"Credit Memo" then begin
                        Objetivosvendedores.SetRange(Objetivosvendedores.Código, SalesCrMemoHeader."Customer Disc. Group");
                    end;
                    Objetivosvendedores.SetRange(Tipo, Objetivosvendedores.Tipo::"Comi-dto");
                    if Objetivosvendedores.FindSet then begin
                        Porcentaje := Objetivosvendedores."Decremento comisión";
                        TasaAplica := "Salesperson/Purchaser"."Commission %" - ((Porcentaje * "Salesperson/Purchaser"."Commission %") / 100);
                        AdjProfit := ROUND(("Sales (LCY)" - SUMAPORTES) * (TasaAplica / 100));
                    end;




                    NombreCliente := '';



                    /// 0,Pago,Factura,Abono,Docs. interés,Recordatorio,Reembolso,,,,,,,,,,,,,,,Efecto
                    if "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."document type"::Invoice then begin
                        SalesInvoiceHeader.Init;
                        if SalesInvoiceHeader.Get("Cust. Ledger Entry"."Document No.") then begin
                            NombreCliente := SalesInvoiceHeader."Sell-to Customer Name";
                        end;
                        if SalesInvoiceHeader."Customer Disc. Group" = '' then begin
                            SalesInvoiceHeader."Customer Disc. Group" := 'DC30';
                        end;
                        SUMAPORTES := 0;
                        SalesInvoiceLine.Reset;
                        SalesInvoiceLine.SetRange(SalesInvoiceLine."Document No.", "Cust. Ledger Entry"."Document No.");
                        if SalesInvoiceLine.FindSet then
                            repeat
                                if SalesInvoiceLine."No." = '62400000' then begin
                                    SUMAPORTES := SUMAPORTES + SalesInvoiceLine.Amount;
                                end;
                                if SalesInvoiceLine."No." = 'TRAN' then begin
                                    SUMAPORTES := SUMAPORTES + SalesInvoiceLine.Amount;
                                end;
                            until SalesInvoiceLine.Next = 0;
                        TOTALPORTES := TOTALPORTES + SUMAPORTES;

                        Porcentaje := 0;
                        Objetivosvendedores.Reset;
                        Objetivosvendedores.SetRange(Objetivosvendedores.Vendedor, "Salesperson/Purchaser".Code);
                        Objetivosvendedores.SetRange(Objetivosvendedores.Código, SalesInvoiceHeader."Customer Disc. Group");
                        Objetivosvendedores.SetRange(Tipo, Objetivosvendedores.Tipo::"Comi-dto");
                        if Objetivosvendedores.FindSet then begin
                            Porcentaje := Objetivosvendedores."Decremento comisión";
                            TasaAplica := "Salesperson/Purchaser"."Commission %" - ((Porcentaje * "Salesperson/Purchaser"."Commission %") / 100);
                            AdjProfit := ROUND(("Sales (LCY)" - SUMAPORTES) * (TasaAplica / 100));
                            TotalVenta := TotalVenta + ("Sales (LCY)" - SUMAPORTES);
                        end;


                        PORCENTAJEnew := 0;
                        coste := 0;
                        Diferencia := 0;
                        ImporteTarifaFull := 0;

                        Rec113.Reset();
                        Rec113.SetRange("Document No.", "Cust. Ledger Entry"."Document No.");
                        Rec113.SetRange(Type, rec113.Type::Item);
                        if Rec113.FindFirst() then
                            repeat
                                if Rec113."No." <> 'TRAN' THEN BEGIN
                                    PriceListLine.reset;
                                    PriceListLine.SetRange("Asset No.", Rec113."No.");
                                    PriceListLine.SetRange("Source No.", Rec113."Customer Price Group");
                                    IF PriceListLine.FindLast() THEN BEGIN
                                        ImporteTarifaFull := ImporteTarifaFull + round(Rec113.Quantity * PriceListLine."Unit Price", 0.01);
                                    END;
                                    pmp := 0;
                                    InventarioPMP.RESET;
                                    InventarioPMP.SETRANGE(InventarioPMP."Item No.", Rec113."No.");
                                    IF InventarioPMP.FINDLAST THEN BEGIN
                                        pmp := InventarioPMP."Unit Cost";
                                    END;
                                    coste := coste + Rec113.Quantity * pmp;
                                end;
                            until rec113.next = 0;
                        SalesInvoiceHeader.CalcFields(Amount);
                        Diferencia := SalesInvoiceHeader.Amount - ImporteTarifaFull;
                        if ImporteTarifaFull <> 0 then begin
                            PORCENTAJEnew := round(Diferencia * 100 / ImporteTarifaFull, 0.01) * -1;
                        end;
                        RecCusto.Get(SalesInvoiceHeader."Sell-to Customer No.");
                        if RecCusto."Des.Comision Vendedor" <> 0 then begin
                            Porcentajenew := RecCusto."Des.Comision Vendedor";
                        end;
                        D1 := Porcentajenew;


                        DatoEscalado := 0;
                        RecEscalado.Reset();
                        RecEscalado.SetRange(Vendedor, SalesInvoiceHeader."Salesperson Code");
                        if RecEscalado.FindFirst() then
                            repeat
                                if (Porcentajenew >= RecEscalado.Desde) and (Porcentajenew <= RecEscalado.Hasta) then begin
                                    DatoEscalado := RecEscalado.Comision;
                                end;
                            until RecEscalado.next = 0;
                        D3 := DatoEscalado;

                        ImpComision := 0;
                        Rec113.Reset();
                        Rec113.SetRange("Document No.", "Cust. Ledger Entry"."Document No.");
                        Rec113.SetRange(Type, rec113.Type::Item);
                        if Rec113.FindFirst() then
                            repeat
                                if Rec113."No." <> 'TRAN' THEN BEGIN
                                    IF RecItem.GET(Rec113."No.") THEN begin
                                        IF RecItem."Clasificación Comercial" = RecItem."Clasificación Comercial"::Azul THEN begin
                                            impazul := impazul + Rec113.Amount;
                                            RecClasiComer.Reset();
                                            RecClasiComer.SetRange(Vendedor, SalesInvoiceHeader."Salesperson Code");
                                            IF RecClasiComer.FindFirst() THEN begin
                                                DatoClasiAzul := RecClasiComer.Azul;
                                            end;
                                        end;
                                        IF RecItem."Clasificación Comercial" = RecItem."Clasificación Comercial"::Rojo THEN begin
                                            improjo := improjo + Rec113.Amount;
                                            RecClasiComer.Reset();
                                            RecClasiComer.SetRange(Vendedor, SalesInvoiceHeader."Salesperson Code");
                                            IF RecClasiComer.FindFirst() THEN begin
                                                DatoClasiRojo := RecClasiComer.Rojo;
                                            end;
                                        end;
                                        IF RecItem."Clasificación Comercial" = RecItem."Clasificación Comercial"::Verde THEN begin
                                            impverde := impverde + Rec113.Amount;
                                            RecClasiComer.Reset();
                                            RecClasiComer.SetRange(Vendedor, SalesInvoiceHeader."Salesperson Code");
                                            IF RecClasiComer.FindFirst() THEN begin
                                                DatoClasiVerde := RecClasiComer.Verde;
                                            end;
                                        end;
                                        ///ImpComision := ImpComision + (DatoClasi + DatoEscalado + DatoBonus / 100) / 100 * Rec113.Amount;
                                    end;
                                end;
                            until rec113.next = 0;
                        D4 := improjo;
                        D5 := DatoClasiRojo;
                        D6 := Round(improjo * DatoClasiRojo / 100, 0.01);
                        D7 := impazul;
                        D8 := DatoClasiAzul;
                        D9 := Round(impazul * DatoClasiAzul / 100, 0.01);
                        D10 := impverde;
                        D11 := DatoClasiVerde;
                        D12 := Round(impverde * DatoClasiVerde / 100, 0.01);


                    end;


                    if "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."document type"::"Credit Memo" then begin
                        SalesCrMemoHeader.Init;
                        if SalesCrMemoHeader.Get("Cust. Ledger Entry"."Document No.") then begin
                            NombreCliente := SalesCrMemoHeader."Sell-to Customer Name";
                        end;
                        if SalesCrMemoHeader."Customer Disc. Group" = '' then begin
                            SalesCrMemoHeader."Customer Disc. Group" := 'DC30';
                        end;
                        SUMAPORTES := 0;
                        SalesCrMemoLine.Reset;
                        SalesCrMemoLine.SetRange(SalesCrMemoLine."Document No.", "Cust. Ledger Entry"."Document No.");
                        if SalesCrMemoLine.FindSet then
                            repeat
                                if SalesCrMemoLine."No." = '62400000' then begin
                                    SUMAPORTES := SUMAPORTES + SalesCrMemoLine.Amount * -1;
                                end;
                                if SalesInvoiceLine."No." = 'TRAN' then begin
                                    SUMAPORTES := SUMAPORTES + SalesCrMemoLine.Amount * -1;
                                end;
                            until SalesCrMemoLine.Next = 0;
                        TOTALPORTES := TOTALPORTES + SUMAPORTES;

                        Porcentaje := 0;
                        Objetivosvendedores.Reset;
                        Objetivosvendedores.SetRange(Objetivosvendedores.Vendedor, "Salesperson/Purchaser".Code);
                        Objetivosvendedores.SetRange(Objetivosvendedores.Código, SalesCrMemoHeader."Customer Disc. Group");
                        Objetivosvendedores.SetRange(Tipo, Objetivosvendedores.Tipo::"Comi-dto");
                        if Objetivosvendedores.FindSet then begin
                            Porcentaje := Objetivosvendedores."Decremento comisión";
                            TasaAplica := "Salesperson/Purchaser"."Commission %" - ((Porcentaje * "Salesperson/Purchaser"."Commission %") / 100);
                            AdjProfit := ROUND(("Sales (LCY)" - SUMAPORTES) * (TasaAplica / 100));
                            TotalVenta := TotalVenta + ("Sales (LCY)" - SUMAPORTES);
                        end;


                        PORCENTAJEnew := 0;
                        coste := 0;
                        Diferencia := 0;
                        ImporteTarifaFull := 0;

                        Rec115.Reset();
                        Rec115.SetRange("Document No.", "Cust. Ledger Entry"."Document No.");
                        Rec115.SetRange(Type, rec115.Type::Item);
                        if Rec115.FindFirst() then
                            repeat
                                if Rec115."No." <> 'TRAN' THEN BEGIN
                                    PriceListLine.reset;
                                    PriceListLine.SetRange("Asset No.", Rec115."No.");
                                    PriceListLine.SetRange("Source No.", Rec115."Customer Price Group");
                                    IF PriceListLine.FindLast() THEN BEGIN
                                        ImporteTarifaFull := ImporteTarifaFull + round(Rec115.Quantity * PriceListLine."Unit Price", 0.01);
                                    END;
                                    pmp := 0;
                                    InventarioPMP.RESET;
                                    InventarioPMP.SETRANGE(InventarioPMP."Item No.", Rec115."No.");
                                    IF InventarioPMP.FINDLAST THEN BEGIN
                                        pmp := InventarioPMP."Unit Cost";
                                    END;
                                    coste := coste + Rec115.Quantity * pmp;
                                end;
                            until rec115.next = 0;
                        SalesCrMemoHeader.CalcFields(Amount);
                        Diferencia := SalesCrMemoHeader.Amount - ImporteTarifaFull;
                        if ImporteTarifaFull <> 0 then begin
                            PORCENTAJEnew := round(Diferencia * 100 / ImporteTarifaFull, 0.01) * -1;
                        end;
                        RecCusto.Get(SalesCrMemoHeader."Sell-to Customer No.");
                        if RecCusto."Des.Comision Vendedor" <> 0 then begin
                            Porcentajenew := RecCusto."Des.Comision Vendedor";
                        end;


                        DatoEscalado := 0;
                        RecEscalado.Reset();
                        RecEscalado.SetRange(Vendedor, SalesInvoiceHeader."Salesperson Code");
                        if RecEscalado.FindFirst() then
                            repeat
                                if (Porcentajenew >= RecEscalado.Desde) and (Porcentajenew <= RecEscalado.Hasta) then begin
                                    DatoEscalado := RecEscalado.Comision;
                                end;
                            until RecEscalado.next = 0;

                        ImpComision := 0;
                        Rec115.Reset();
                        Rec115.SetRange("Document No.", "Cust. Ledger Entry"."Document No.");
                        Rec115.SetRange(Type, rec115.Type::Item);
                        if Rec115.FindFirst() then
                            repeat
                                if Rec115."No." <> 'TRAN' THEN BEGIN
                                    IF RecItem.GET(Rec115."No.") THEN begin
                                        IF RecItem."Clasificación Comercial" = RecItem."Clasificación Comercial"::Azul THEN begin
                                            impazul := impazul + Rec115.Amount * -1;
                                            RecClasiComer.Reset();
                                            RecClasiComer.SetRange(Vendedor, SalesInvoiceHeader."Salesperson Code");
                                            IF RecClasiComer.FindFirst() THEN begin
                                                DatoClasiAzul := RecClasiComer.Azul;
                                            end;
                                        end;
                                        IF RecItem."Clasificación Comercial" = RecItem."Clasificación Comercial"::Rojo THEN begin
                                            improjo := improjo + Rec115.Amount * -1;
                                            RecClasiComer.Reset();
                                            RecClasiComer.SetRange(Vendedor, SalesInvoiceHeader."Salesperson Code");
                                            IF RecClasiComer.FindFirst() THEN begin
                                                DatoClasiRojo := RecClasiComer.Rojo;
                                            end;
                                        end;
                                        IF RecItem."Clasificación Comercial" = RecItem."Clasificación Comercial"::Verde THEN begin
                                            impverde := impverde + Rec115.Amount * -1;
                                            RecClasiComer.Reset();
                                            RecClasiComer.SetRange(Vendedor, SalesInvoiceHeader."Salesperson Code");
                                            IF RecClasiComer.FindFirst() THEN begin
                                                DatoClasiVerde := RecClasiComer.Verde;
                                            end;
                                        end;
                                    end;
                                end;
                            until rec115.next = 0;

                        D4 := improjo;
                        D5 := DatoClasiRojo;
                        D6 := Round(improjo * DatoClasiRojo / 100, 0.01);
                        D7 := impazul;
                        D8 := DatoClasiAzul;
                        D9 := Round(impazul * DatoClasiAzul / 100, 0.01);
                        D10 := impverde;
                        D11 := DatoClasiVerde;
                        D12 := Round(impverde * DatoClasiVerde / 100, 0.01);

                    end;


                    D14 := TotalVentaAntes;
                    D15 := Bonus;
                    D16 := DatoBonus;
                    VentaLinea := "Sales (LCY)";

                    D2 := round(VentaLinea / 100 * D3, 0.01);

                    D18 := D2 + D6 + D9 + D12;
                    D17 := round((DatoBonus / 100) * D18, 0.01);
                    D19 := D2 + D6 + D9 + D12 + D17;





                end;

                trigger OnPostDataItem()
                begin


                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CreateTotals(
                      "Sales (LCY)", "Profit (LCY)", AdjProfit,
                      ProfitCommissionAmt, AdjProfitCommissionAmt, SalesCommissionAmt);

                    TotalVentaAntes := 0;
                    desdeFecha := "Cust. Ledger Entry".GetRangeMin("Cust. Ledger Entry"."Posting Date");
                    hastaFecha := "Cust. Ledger Entry".GetRangeMax("Cust. Ledger Entry"."Posting Date");
                    CustLedgerEntry.reset;
                    CustLedgerEntry.SetRange("Salesperson Code", "Cust. Ledger Entry"."Salesperson Code");
                    CustLedgerEntry.SetRange("Posting Date", desdeFecha, hastaFecha);
                    if CustLedgerEntry.FindFirst() then
                        repeat
                            if CustLedgerEntry."Customer No." <> '6445' then begin
                                if CustLedgerEntry."Document Type" = CustLedgerEntry."document type"::Invoice then begin
                                    SalesInvoiceHeader.Init;
                                    if SalesInvoiceHeader.Get(CustLedgerEntry."Document No.") then begin
                                        NombreCliente := SalesInvoiceHeader."Sell-to Customer Name";
                                    end;
                                    if SalesInvoiceHeader."Customer Disc. Group" = '' then begin
                                        SalesInvoiceHeader."Customer Disc. Group" := 'DC30';
                                    end;
                                    SUMAPORTES := 0;
                                    SalesInvoiceLine.Reset;
                                    SalesInvoiceLine.SetRange(SalesInvoiceLine."Document No.", CustLedgerEntry."Document No.");
                                    if SalesInvoiceLine.FindSet then
                                        repeat
                                            if SalesInvoiceLine."No." = '62400000' then begin
                                                SUMAPORTES := SUMAPORTES + SalesInvoiceLine.Amount;
                                            end;
                                            if SalesInvoiceLine."No." = 'TRAN' then begin
                                                SUMAPORTES := SUMAPORTES + SalesInvoiceLine.Amount;
                                            end;
                                        until SalesInvoiceLine.Next = 0;
                                end;
                                if CustLedgerEntry."Document Type" = CustLedgerEntry."document type"::"Credit Memo" then begin
                                    SalesCrMemoHeader.Init;
                                    if SalesCrMemoHeader.Get(CustLedgerEntry."Document No.") then begin
                                        NombreCliente := SalesCrMemoHeader."Sell-to Customer Name";
                                    end;
                                    if SalesCrMemoHeader."Customer Disc. Group" = '' then begin
                                        SalesCrMemoHeader."Customer Disc. Group" := 'DC30';
                                    end;
                                    SUMAPORTES := 0;
                                    SalesCrMemoLine.Reset;
                                    SalesCrMemoLine.SetRange("Document No.", CustLedgerEntry."Document No.");
                                    if SalesCrMemoLine.FindSet then
                                        repeat
                                            if SalesInvoiceLine."No." = '62400000' then begin
                                                SUMAPORTES := SUMAPORTES + SalesInvoiceLine.Amount * -1;
                                            end;
                                            if SalesInvoiceLine."No." = 'TRAN' then begin
                                                SUMAPORTES := SUMAPORTES + SalesInvoiceLine.Amount * -1;
                                            end;
                                        until SalesCrMemoLine.Next = 0;
                                end;

                                TotalVentaAntes := TotalVentaAntes + (CustLedgerEntry."Sales (LCY)" - SUMAPORTES);
                            end;
                        until CustLedgerEntry.next = 0;

                    Porcentaje := 0;
                    Objetivosvendedores.Reset;
                    Objetivosvendedores.SetRange(Objetivosvendedores.Vendedor, "Salesperson/Purchaser".Code);
                    Objetivosvendedores.SetRange(Objetivosvendedores.Código, SalesInvoiceHeader."Customer Disc. Group");
                    Objetivosvendedores.SetRange(Tipo, Objetivosvendedores.Tipo::"Comi-dto");
                    if Objetivosvendedores.FindSet then begin
                        Porcentaje := Objetivosvendedores."Decremento comisión";
                        TasaAplica := "Salesperson/Purchaser"."Commission %" - ((Porcentaje * "Salesperson/Purchaser"."Commission %") / 100);
                        AdjProfit := ROUND(("Sales (LCY)" - SUMAPORTES) * (TasaAplica / 100));
                    end;




                end;
            }

            /*
                        dataitem(CustLedgerEntry2; "Cust. Ledger Entry") ; 
                        {

                            DataItemLink = "Salesperson Code" = field(Code);
                            DataItemTableView = sorting("Salesperson Code", "Posting Date") where("Document Type" = filter(Invoice | "Credit Memo"));
                            RequestFilterFields = "Posting Date";




                        }

            */


            dataitem("Integer"; "Integer")
            {
                MaxIteration = 1;
                column(ReportForNavId_1000000027; 1000000027)
                {
                }
                column(TOTALPORTES; TOTALPORTES)
                {
                }
                column(SUMAPORTES; SUMAPORTES)
                {
                }
                column(TotalVenta; TotalVenta)
                {
                }
                column(TotalComision; TotalComision)
                {
                }
                column(TOTALC; TOTALC)
                {
                }
                column(totalVende; totalVende)
                {
                }
                column(impagadosmes; impagadosmes)
                {
                }
                column(recuperadosmes; recuperadosmes)
                {
                }
                column(GLOBALVENTAS; GLOBALVENTAS)
                {
                }
                column(comisiontotal; comisiontotal)
                {
                }
                column(textoaumento; textoaumento)
                {
                }
                column(aumneto; aumneto)
                {
                }
                column(entregadoaceunta; entregadoaceunta)
                {
                }
                column(mediacomi; mediacomi)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    sincomision := false;
                    aumneto := 0;

                    if TOTALVENTAV <> 0 then begin
                        divisor := ((TotalVenta / TOTALVENTAV) * 100) - 100;
                        if divisor > 0 then begin
                            if divisor > 10 then begin
                                textoaumento := 'BONUS';
                                aumneto := ROUND((TotalComision + TOTASUMA2 + TotalImpaga + Totalrecupera) * 10 / 100, 0.01);
                            end;
                            if divisor > 20 then begin
                                aumneto := ROUND((TotalComision + TOTASUMA2 + TotalImpaga + Totalrecupera) * 20 / 100, 0.01);
                            end;
                            if divisor > 30 then begin
                                aumneto := ROUND((TotalComision + TOTASUMA2 + TotalImpaga + Totalrecupera) * 30 / 100, 0.01);
                            end;
                            if divisor > 40 then begin
                                aumneto := ROUND((TotalComision + TOTASUMA2 + TotalImpaga + Totalrecupera) * 40 / 100, 0.01);
                            end;
                            TOTALC := TotalComision + TOTASUMA2 - entregadoaceunta + TotalImpaga + Totalrecupera + aumneto;
                        end;
                        if "Salesperson/Purchaser".Autonomo = false then begin
                            if divisor < 0 then begin
                                divisor := divisor * -1;
                                if (divisor > 10) then begin
                                    aumneto := ROUND((TotalComision + TOTASUMA2 + TotalImpaga + Totalrecupera) * 10 / 100, 0.01) * -1;
                                    textoaumento := 'MALUS';
                                end;
                                if (divisor > 20) then begin
                                    aumneto := ROUND((TotalComision + TOTASUMA2 + TotalImpaga + Totalrecupera) * 20 / 100, 0.01) * -1;
                                end;
                                if (divisor > 30) then begin
                                    aumneto := ROUND((TotalComision + TOTASUMA2 + TotalImpaga + Totalrecupera) * 30 / 100, 0.01) * -1;
                                end;
                                TOTALC := TotalComision + TOTASUMA2 - entregadoaceunta + TotalImpaga + Totalrecupera + aumneto;
                                if divisor > 40 then begin
                                    aumneto := 0;
                                    sincomision := true;
                                end;
                            end;
                        end;
                    end;

                    TOTALC := TotalComision + aumneto;

                    mediacomi := 0;
                    if TotalVenta <> 0 then begin
                        mediacomi := ROUND(TotalComision / TotalVenta * 100, 0.01);
                    end;
                    comisiontotal := TotalComision + TOTASUMA2 + TotalImpaga + Totalrecupera;

                    if sincomision then begin
                        comisiontotal := 0;
                        TOTALC := 0;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if PrintOnlyOnePerPage then
                    PageGroupNo := PageGroupNo + 1;


                desde := "Cust. Ledger Entry".GetRangeMin("Posting Date");

                AÑO := Date2dmy(desde, 3);

                MES := Date2dmy(desde, 2);


                sincomision := false;


                Rec33.Reset;
                Rec33.SetRange(Rec33.Vendedor, "Salesperson/Purchaser".Code);
                Rec33.SetRange(Rec33.Año, AÑO);
                Rec33.SetRange(Rec33.Tipo, 7);
                if Rec33.FindFirst then begin
                    if MES = 1 then entregadoaceunta := Rec33.Enero;
                    if MES = 2 then entregadoaceunta := Rec33.Febrero;
                    if MES = 3 then entregadoaceunta := Rec33.Marzo;
                    if MES = 4 then entregadoaceunta := Rec33.Abril;
                    if MES = 5 then entregadoaceunta := Rec33.Mayo;
                    if MES = 6 then entregadoaceunta := Rec33.Junio;
                    if MES = 7 then entregadoaceunta := Rec33.Julio;
                    if MES = 8 then entregadoaceunta := Rec33.Agosto;
                    if MES = 9 then entregadoaceunta := Rec33.Septiembre;
                    if MES = 10 then entregadoaceunta := Rec33.Octubre;
                    if MES = 11 then entregadoaceunta := Rec33.Noviembre;
                    if MES = 12 then entregadoaceunta := Rec33.Diciembre;
                end;



                TotalImpaga := 0;
                TotalImpaga := 0;
                tantoimpa := 0;
                tantorecu := 0;
                recuperadosmes := 0;
                impagadosmes := 0;
                Rec3.Reset;
                Rec3.SetRange(Rec3.Vendedor, "Salesperson/Purchaser".Code);
                Rec3.SetRange(Rec3.Año, AÑO);
                Rec3.SetRange(Rec3.Tipo, 8);
                if Rec3.FindFirst then begin
                    if MES = 1 then impagadosmes := Rec3.Enero;
                    if MES = 2 then impagadosmes := Rec3.Febrero;
                    if MES = 3 then impagadosmes := Rec3.Marzo;
                    if MES = 4 then impagadosmes := Rec3.Abril;
                    if MES = 5 then impagadosmes := Rec3.Mayo;
                    if MES = 6 then impagadosmes := Rec3.Junio;
                    if MES = 7 then impagadosmes := Rec3.Julio;
                    if MES = 8 then impagadosmes := Rec3.Agosto;
                    if MES = 9 then impagadosmes := Rec3.Septiembre;
                    if MES = 10 then impagadosmes := Rec3.Octubre;
                    if MES = 11 then impagadosmes := Rec3.Noviembre;
                    if MES = 12 then impagadosmes := Rec3.Diciembre;
                end;

                Rec3.Reset;
                Rec3.SetRange(Rec3.Vendedor, "Salesperson/Purchaser".Code);
                Rec3.SetRange(Rec3.Año, AÑO);
                Rec3.SetRange(Rec3.Tipo, 10);
                if Rec3.FindFirst then begin
                    if MES = 1 then tantoimpa := Rec3.Enero;
                    if MES = 2 then tantoimpa := Rec3.Febrero;
                    if MES = 3 then tantoimpa := Rec3.Marzo;
                    if MES = 4 then tantoimpa := Rec3.Abril;
                    if MES = 5 then tantoimpa := Rec3.Mayo;
                    if MES = 6 then tantoimpa := Rec3.Junio;
                    if MES = 7 then tantoimpa := Rec3.Julio;
                    if MES = 8 then tantoimpa := Rec3.Agosto;
                    if MES = 9 then tantoimpa := Rec3.Septiembre;
                    if MES = 10 then tantoimpa := Rec3.Octubre;
                    if MES = 11 then tantoimpa := Rec3.Noviembre;
                    if MES = 12 then tantoimpa := Rec3.Diciembre;
                end;

                Rec3.Reset;
                Rec3.SetRange(Rec3.Vendedor, "Salesperson/Purchaser".Code);
                Rec3.SetRange(Rec3.Año, AÑO);
                Rec3.SetRange(Rec3.Tipo, 9);
                if Rec3.FindFirst then begin
                    if MES = 1 then recuperadosmes := Rec3.Enero;
                    if MES = 2 then recuperadosmes := Rec3.Febrero;
                    if MES = 3 then recuperadosmes := Rec3.Marzo;
                    if MES = 4 then recuperadosmes := Rec3.Abril;
                    if MES = 5 then recuperadosmes := Rec3.Mayo;
                    if MES = 6 then recuperadosmes := Rec3.Junio;
                    if MES = 7 then recuperadosmes := Rec3.Julio;
                    if MES = 8 then recuperadosmes := Rec3.Agosto;
                    if MES = 9 then recuperadosmes := Rec3.Septiembre;
                    if MES = 10 then recuperadosmes := Rec3.Octubre;
                    if MES = 11 then recuperadosmes := Rec3.Noviembre;
                    if MES = 12 then recuperadosmes := Rec3.Diciembre;
                end;

                Rec3.Reset;
                Rec3.SetRange(Rec3.Vendedor, "Salesperson/Purchaser".Code);
                Rec3.SetRange(Rec3.Año, AÑO);
                Rec3.SetRange(Rec3.Tipo, 11);
                if Rec3.FindFirst then begin
                    if MES = 1 then tantorecu := Rec3.Enero;
                    if MES = 2 then tantorecu := Rec3.Febrero;
                    if MES = 3 then tantorecu := Rec3.Marzo;
                    if MES = 4 then tantorecu := Rec3.Abril;
                    if MES = 5 then tantorecu := Rec3.Mayo;
                    if MES = 6 then tantorecu := Rec3.Junio;
                    if MES = 7 then tantorecu := Rec3.Julio;
                    if MES = 8 then tantorecu := Rec3.Agosto;
                    if MES = 9 then tantorecu := Rec3.Septiembre;
                    if MES = 10 then tantorecu := Rec3.Octubre;
                    if MES = 11 then tantorecu := Rec3.Noviembre;
                    if MES = 12 then tantorecu := Rec3.Diciembre;
                end;


                TotalImpaga := ROUND(impagadosmes * tantoimpa / 100, 0.01) * -1;
                Totalrecupera := ROUND(recuperadosmes * tantorecu / 100, 0.01);

                GLOBALVENTAS := GLOBALVENTAS + TotalImpaga + Totalrecupera;



                Rec3.Reset;
                Rec3.SetRange(Rec3.Vendedor, "Salesperson/Purchaser".Code);
                Rec3.SetRange(Rec3.Año, AÑO);
                Rec3.SetRange(Rec3.Tipo, 0);
                if Rec3.FindFirst then begin
                    if MES = 1 then TOTALVENTAV := Rec3.Enero;
                    if MES = 2 then TOTALVENTAV := Rec3.Febrero;
                    if MES = 3 then TOTALVENTAV := Rec3.Marzo;
                    if MES = 4 then TOTALVENTAV := Rec3.Abril;
                    if MES = 5 then TOTALVENTAV := Rec3.Mayo;
                    if MES = 6 then TOTALVENTAV := Rec3.Junio;
                    if MES = 7 then TOTALVENTAV := Rec3.Julio;
                    if MES = 8 then TOTALVENTAV := Rec3.Agosto;
                    if MES = 9 then TOTALVENTAV := Rec3.Septiembre;
                    if MES = 10 then TOTALVENTAV := Rec3.Octubre;
                    if MES = 11 then TOTALVENTAV := Rec3.Noviembre;
                    if MES = 12 then TOTALVENTAV := Rec3.Diciembre;
                    INCRETRAMO := Rec3."Importe tramos";
                    TANTOTARMO := Rec3."% Incremento por tramo";
                end;



            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;

                CurrReport.NewPagePerRecord := PrintOnlyOnePerPage;
                CurrReport.CreateTotals(
                  "Cust. Ledger Entry"."Sales (LCY)", "Cust. Ledger Entry"."Profit (LCY)",
                  AdjProfit, ProfitCommissionAmt, AdjProfitCommissionAmt, SalesCommissionAmt);
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
                    field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
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
        Objetivosvendedores: Record "Objetivos vendedores";
        ImporteFac: Decimal;
        Porcentaje: Decimal;
        PorcentajeNew: Decimal;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        totalVende: Decimal;
        Rec3: Record "Objetivos vendedores";
        Rec33: Record "Objetivos vendedores";
        DTM3: Decimal;
        DTM2: Decimal;
        DTM1: Decimal;
        HTM3: Decimal;
        HTM2: Decimal;
        HTM1: Decimal;
        suma1: Decimal;
        color: Code[10];
        margenlin: Decimal;
        TDESDE: array[5] of Decimal;
        CUANTALIN: Integer;
        MEDIACOL: Decimal;
        RecConfV: Record "Sales & Receivables Setup";
        THASTA: array[5] of Decimal;
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
        Comisionesporgrupo: Record "Comisiones por grupo";
        TasaAplica: Decimal;
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SUMAPORTES: Decimal;
        TOTALPORTES: Decimal;
        mediacomi: Decimal;
        NombreCliente: Text[100];
        sincomision: Boolean;
        RecEscalado: Record EscaladoComercial;
        RecClasiComer: Record ClasificacionComercial;
        RecBonusBuenos: Record BonusBuenos;
        RecBuenosMalos: Record BonusMalos;

        ImporteTarifaFull: Decimal;
        PriceListLine: Record "Price List Line";
        Rec113: Record "Sales Invoice Line";
        PORCENTAJEf: Decimal;
        Diferencia: Decimal;
        pmp: Decimal;
        InventarioPMP: Record "Inventario PMP";
        coste: Decimal;
        MargendeBeneficio: Decimal;
        Rec112: Record "Sales Invoice Header";
        DatoEscalado: Decimal;
        RecCusto: Record Customer;
        DatoClasiRojo: Decimal;
        DatoClasiAzul: Decimal;
        DatoClasiVerde: Decimal;
        ImpComision: Decimal;
        TotalVentaAntes: Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        desdeFecha: date;
        hastaFecha: Date;
        Bonus: Decimal;
        DatoBonus: Decimal;
        impverde: Decimal;
        improjo: Decimal;
        impazul: Decimal;
        Rec115: Record "Sales Cr.Memo Line";
        D1: Decimal;
        D2: Decimal;
        D3: Decimal;
        D4: Decimal;
        D5: Decimal;
        D6: Decimal;
        D7: Decimal;
        D8: Decimal;
        D9: Decimal;
        D10: Decimal;
        D11: Decimal;
        D12: Decimal;
        D13: Decimal;
        D14: Decimal;
        D15: Decimal;
        D16: Decimal;
        D17: Decimal;
        D18: Decimal;

        D19: Decimal;


}

