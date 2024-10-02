#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50036 "Calcular 349 HAGEN"
{
    Caption = 'Calcular 349 HAGEN';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Integer";"Integer")
        {
            DataItemTableView = sorting(Number) where(Number=const(1));
            column(ReportForNavId_5444; 5444)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if not Evaluate(NumFiscalYear,FiscalYear) then
                  Error(Text1100000);
                FiscalYear2 := CopyStr(FiscalYear,3,2);

                case true of
                  Period in [1..12]:
                    begin
                      FromDate := Dmy2date(1,Period,NumFiscalYear);
                      ToDate := CalcDate('<+CM>',FromDate);
                      if PeriodFreqChange then
                        FromDate := Dmy2date(1,Period - 1,NumFiscalYear);
                    end;
                  Period in [Period::"1T",Period::"2T",Period::"3T",Period::"4T"]:
                    begin
                      Evaluate(NumPeriod,DelChr(GetPeriodAsText,'=','T'));
                      FromDate := Dmy2date(1,(NumPeriod * 3) - 2,NumFiscalYear);
                      ToDate := CalcDate('<+CQ>',FromDate);
                    end;
                  Period = Period::"0A":
                    begin
                      FromDate := Dmy2date(1,1,NumFiscalYear);
                      ToDate := CalcDate('<+CY>',FromDate);
                    end;
                  else
                    Error(Text1100000);
                end;
            end;

            trigger OnPostDataItem()
            begin
                Txt := PadStr('',500,' ');
                OutFile.Write(Txt);
            end;

            trigger OnPreDataItem()
            begin
                Window.Open('Proceso #1#######################################################################\' +
                            'Numero #2######### de #3#########');
            end;
        }
        dataitem(CustomerWarnings;Customer)
        {
            DataItemTableView = sorting("VAT Registration No.");
            PrintOnlyIfDetail = false;
            column(ReportForNavId_2274; 2274)
            {
            }

            trigger OnAfterGetRecord()
            begin
                i += 1;
                Window.Update(2,i);
                while ("VAT Registration No." = PreVATRegNo) or ("VAT Registration No." = '') do
                  if Next = 0 then
                    exit;
                PreVATRegNo := "VAT Registration No.";

                Customer2.Reset;
                Customer2.SetRange("VAT Registration No.","VAT Registration No.");
                if Customer2.FindSet then begin
                  repeat
                    VATCredSales.Reset;
                    VATCredSales.SetRange(Type,VATCredSales.Type::Sale);
                    VATCredSales.SetRange("Document Type",VATCredSales."document type"::"Credit Memo");
                    VATCredSales.SetRange("Bill-to/Pay-to No.",Customer2."No.");
                    VATCredSales.SetRange("Posting Date",FromDate,ToDate);
                    VATCredSales.SetFilter("Gen. Prod. Posting Group",FilterString);
                    if VATCredSales.FindSet then
                      repeat
                        if IncludeIn349(VATCredSales,AmountToIncludein349,LocationDiffCountryCode) then begin
                          if (VATCredSales."Country/Region Code" <> CountryCode) or
                             ((VATCredSales."Country/Region Code" = CountryCode) and LocationDiffCountryCode) and
                             (VATCredSales."Country/Region Code" <> CompanyInfo."Country/Region Code")
                          then
                            InsertCustWarning349(
                              Customer2."No.",Customer2.Name,VATCredSales."Posting Date",
                              VATCredSales."Document Type",VATCredSales."Document No.",
                              VATCredSales."EU 3-Party Trade",VATCredSales."EU Service",VATCredSales.Base >= 0,
                              VATCredSales."Entry No.",VATCredSales."Delivery Operation Code");
                        end;
                      until VATCredSales.Next = 0;

                    InsertCustWarningsFromSalesCrMemoLine;
                  until Customer2.Next = 0;

                  Commit;
                end;
            end;

            trigger OnPreDataItem()
            begin
                PreVATRegNo := '';

                Window.Update(1,'Clientes: Abonos');
                i := 0;
                Window.Update(3,CustomerWarnings.Count);
            end;
        }
        dataitem(VendorWarnings;Vendor)
        {
            DataItemTableView = sorting("VAT Registration No.");
            PrintOnlyIfDetail = false;
            column(ReportForNavId_6809; 6809)
            {
            }

            trigger OnAfterGetRecord()
            begin
                i += 1;
                Window.Update(2,i);
                while ("VAT Registration No." = PreVATRegNo) or ("VAT Registration No." = '') do
                  if Next = 0 then
                    exit;
                PreVATRegNo := "VAT Registration No.";

                Vendor2.Reset;
                Vendor2.SetRange("VAT Registration No.","VAT Registration No.");
                if Vendor2.FindSet then begin
                  repeat
                    VATCredPurch.Reset;
                    VATCredPurch.SetRange(Type,VATCredPurch.Type::Purchase);
                    VATCredPurch.SetRange("Document Type",VATCredPurch."document type"::"Credit Memo");
                    VATCredPurch.SetRange("Bill-to/Pay-to No.",Vendor2."No.");
                    VATCredPurch.SetRange("Posting Date",FromDate,ToDate);
                    VATCredPurch.SetFilter("Gen. Prod. Posting Group",FilterString);
                    if VATCredPurch.FindSet then
                      repeat
                        if IncludeIn349(VATCredPurch,AmountToIncludein349,LocationDiffCountryCode) then begin
                          if (VATCredPurch."Country/Region Code" <> CountryCode) or
                             ((VATCredPurch."Country/Region Code" = CountryCode) and LocationDiffCountryCode) and
                             (VATCredPurch."Country/Region Code" <> CompanyInfo."Country/Region Code")
                          then
                            InsertVendWarning349(
                              Vendor2."No.",Vendor2.Name,VATCredPurch."Posting Date",
                              VATCredPurch."Document Type",VATCredPurch."Document No.",
                              VATCredPurch."EU 3-Party Trade",VATCredPurch."EU Service",VATCredPurch.Base >= 0,VATCredPurch."Entry No.",VATCredPurch."Delivery Operation Code");
                        end;
                      until VATCredPurch.Next = 0;

                    InsertVendWarningsFromPurchCrMemoLine;
                  until Vendor2.Next = 0;

                  Commit;
                end;
            end;

            trigger OnPostDataItem()
            begin
                //AQ 16/01/2018
                /*
                IF CustVendWarning349.FINDFIRST THEN BEGIN
                  IF NOT CONFIRM(Text1100008,FALSE) THEN
                    MESSAGE(Text1100009)
                  ELSE BEGIN
                    CVWarning349.SETRECORD(CustVendWarning349);
                    IF (CVWarning349.RUNMODAL IN [ACTION::Cancel,ACTION::OK]) AND CVWarning349.Cancelled THEN BEGIN
                      CustVendWarning349.RESET;
                      CustVendWarning349.DELETEALL;
                      COMMIT;
                      ERROR(Text1100011);
                    END;
                  END;
                END;
                */

            end;

            trigger OnPreDataItem()
            begin
                PreVATRegNo := '';

                Window.Update(1,'Proveedores: Abonos');
                i := 0;
                Window.Update(3,VendorWarnings.Count);
            end;
        }
        dataitem("Country/Region";"Country/Region")
        {
            DataItemTableView = sorting("EU Country/Region Code") where(Code=const('PT'));
            column(ReportForNavId_4153; 4153)
            {
            }
            dataitem(Customer;Customer)
            {
                DataItemLink = "Country/Region Code"=field(Code);
                DataItemTableView = sorting("VAT Registration No.") where("VAT Registration No."=filter(<>''));
                PrintOnlyIfDetail = false;
                column(ReportForNavId_6836; 6836)
                {
                }

                trigger OnAfterGetRecord()
                var
                    VATEntry: Record "VAT Entry";
                    Amount: array [3] of Decimal;
                    AccPrevDeclAmount: array [3] of Decimal;
                    AccOrigDeclAmount: array [3] of Decimal;
                    i: Integer;
                    CreditMemoOrgDeclaredAmt: Decimal;
                    CreditMemoAmt: Decimal;
                    AppliedAmt: Decimal;
                    NoTaxableNormalAmountSales: array [3] of Decimal;
                    IsCreditMemoPrinted: Boolean;
                begin
                    i += 1;
                    Window.Update(2,i);
                    
                    while (Customer."VAT Registration No." = PreVATRegNo) or (Customer."VAT Registration No." = '') do
                      if Customer.Next = 0 then
                        exit;
                    PreVATRegNo := Customer."VAT Registration No.";
                    
                    CustVendCountry.Get("Country/Region Code");
                    CustVendVatRegNo := CombineEUCountryAndVATRegNo(CustVendCountry,"VAT Registration No.");
                    OpTriang := ' ';
                    AmountOpTri := 0;
                    NormalAmount := 0;
                    Clear(Amount);
                    Clear(AccPrevDeclAmount);
                    Clear(AccOrigDeclAmount);
                    RectAmount := 0;
                    PrevDeclAmount := 0;
                    AccumPrevDeclAmount := 0;
                    AccumOrigDeclAmount := 0;
                    AmountEUService := 0;
                    AccumPrevDeclAmountEUService := 0;
                    AccumOrigDeclAmountEUService := 0;
                    AccumPrevDeclAmountTri := 0;
                    AccumOrigDeclAmountTri := 0;
                    NoTaxableAmountOpTri := 0;
                    NoTaxableAmountEUService := 0;
                    Customer2.Reset;
                    Customer2.SetRange("VAT Registration No.","VAT Registration No.");
                    if Customer2.FindSet then begin
                      repeat
                        GetVATInvSalesEntries(VATInvSales,Customer2."No.",FromDate,ToDate,false,FilterString);
                        VATInvSales.SetRange("EU 3-Party Trade",true);
                        if VATInvSales.FindSet then
                          repeat
                            if IncludeIn349(VATInvSales,AmountToIncludein349,LocationDiffCountryCode) then begin
                              if (VATInvSales."Country/Region Code" <> CountryCode) or
                                 ((VATInvSales."Country/Region Code" = CountryCode) and LocationDiffCountryCode)
                              then begin
                                if "VAT Registration No." <> '' then begin
                                  if AmountToIncludein349 <> 0 then begin
                                    OpTriang := 'X';
                                    AmountOpTri := AmountOpTri + AmountToIncludein349
                                  end else begin
                                    OpTriang := 'X';
                                    AmountOpTri := AmountOpTri + VATInvSales.Base;
                                  end;
                                end else
                                  EmptyVATRegNo := true;
                              end;
                            end;
                          until VATInvSales.Next = 0;
                    
                        GetVATInvSalesEntries(VATInvSales,Customer2."No.",FromDate,ToDate,false,FilterString);
                        VATInvSales.SetRange("EU 3-Party Trade",false);
                        if VATInvSales.FindSet then
                          repeat
                            if IncludeIn349(VATInvSales,AmountToIncludein349,LocationDiffCountryCode) then begin
                              if (VATInvSales."Country/Region Code" <> CountryCode) or
                                 ((VATInvSales."Country/Region Code" = CountryCode) and LocationDiffCountryCode)
                              then begin
                                if "VAT Registration No." <> '' then
                                  SummarizeBaseAmount(VATInvSales,AmountToIncludein349,Amount)
                                else
                                  EmptyVATRegNo := true;
                              end;
                            end;
                          until VATInvSales.Next = 0;
                    
                        GetVATInvSalesEntries(VATInvSales,Customer2."No.",FromDate,ToDate,true,FilterString);
                        if VATInvSales.FindSet then
                          repeat
                            if IncludeIn349(VATInvSales,AmountToIncludein349,LocationDiffCountryCode) then begin
                              if (VATInvSales."Country/Region Code" <> CountryCode) or
                                 ((VATInvSales."Country/Region Code" = CountryCode) and LocationDiffCountryCode)
                              then begin
                                if "VAT Registration No." <> '' then begin
                                  if AmountToIncludein349 <> 0 then
                                    AmountEUService := AmountEUService + AmountToIncludein349
                                  else
                                    AmountEUService := AmountEUService + VATInvSales.Base;
                                end else
                                  EmptyVATRegNo := true;
                              end;
                            end;
                          until VATInvSales.Next = 0;
                    
                        CalcNoTaxableAmountFromSalesInvLine(NoTaxableNormalAmountSales);
                        for i := 1 to 3 do
                          Amount[i] += NoTaxableNormalAmountSales[i];
                        AmountEUService := AmountEUService + NoTaxableAmountEUService;
                        AmountOpTri := AmountOpTri + NoTaxableAmountOpTri;
                    
                        CorrIncludedForNormalAmount := false;
                        CorrIncludedForOpTriAmount := false;
                        CorrIncludedForEUServiceAmount := false;
                    /*
                        CustVendWarning349.RESET;
                        CustVendWarning349.SETRANGE(Type,CustVendWarning349.Type::Sale);
                        CustVendWarning349.SETRANGE("Customer/Vendor No.",Customer2."No.");
                        CustVendWarning349.SETRANGE("Posting Date",FromDate,ToDate);
                        CustVendWarning349.SETRANGE("Include Correction",TRUE);
                        IF CustVendWarning349.FINDFIRST THEN
                          REPEAT
                            IF ((CustVendWarning349."Original Declaration FY" <> FiscalYear) OR
                                (CustVendWarning349."Original Declaration Period" <> GetPeriodAsText))
                            THEN BEGIN
                              TotalCorreAmt := TotalCorreAmt + CustVendWarning349."Original Declared Amount";
                              NoOfCorrections := NoOfCorrections + 1;
                    
                              AccumPrevDeclAmount := 0;
                              AccumOrigDeclAmount := 0;
                              AccumPrevDeclAmountEUService := 0;
                              AccumOrigDeclAmountEUService := 0;
                              AccumPrevDeclAmountTri := 0;
                              AccumOrigDeclAmountTri := 0;
                              CLEAR(AccPrevDeclAmount);
                              CLEAR(AccOrigDeclAmount);
                    
                              CustVendWarning349_2 := CustVendWarning349;
                              GetCustVendWarnings(CustVendWarning349_2,CustVendWarning349,FALSE,FALSE);
                              CustVendWarning349_2.SETRANGE("EU 3-Party Trade",FALSE);
                              AlreadyExported := FALSE;
                    
                              IF CustVendWarning349_2.FINDFIRST THEN BEGIN
                                IF CustVendWarning349_2."VAT Entry No." = 0 THEN
                                  VATEntry.INIT
                                ELSE
                                  VATEntry.GET(CustVendWarning349_2."VAT Entry No.");
                                IF CustVendWarning349_2.COUNT > 1 THEN BEGIN
                                  REPEAT
                                    IF "VAT Registration No." <> '' THEN BEGIN
                                      AccPrevDeclAmount[MapDeliveryOperationCode(VATEntry."Delivery Operation Code")] :=
                                        CustVendWarning349_2."Previous Declared Amount";
                                      SummarizeBaseAmount(VATEntry,CustVendWarning349_2."Original Declared Amount",AccOrigDeclAmount);
                                      CustVendWarning349_2.Exported := TRUE;
                                      CustVendWarning349_2.MODIFY;
                                    END;
                                  UNTIL CustVendWarning349_2.NEXT = 0;
                                END ELSE BEGIN
                                  IF "VAT Registration No." <> '' THEN BEGIN
                                    SummarizeBaseAmount(VATEntry,ABS(CustVendWarning349."Previous Declared Amount"),AccPrevDeclAmount);
                                    AccOrigDeclAmount[MapDeliveryOperationCode(VATEntry."Delivery Operation Code")] +=
                                      CustVendWarning349."Original Declared Amount";
                                  END;
                                END;
                              END ELSE
                                AlreadyExported := TRUE;
                    
                              ThirdPartyAlreadyExported := FALSE;
                              EUServiceAlreadyExported := FALSE;
                    
                              CustVendWarning349_2.RESET;
                              GetCustVendWarnings(CustVendWarning349_2,CustVendWarning349,FALSE,TRUE);
                              IF CustVendWarning349_2.FINDSET THEN
                                IF CustVendWarning349_2.COUNT > 1 THEN BEGIN
                                  IF "VAT Registration No." <> '' THEN
                                    AccumPrevDeclAmountEUService :=
                                      AccumPrevDeclAmountEUService + ABS(CustVendWarning349_2."Previous Declared Amount");
                                  REPEAT
                                    IF "VAT Registration No." <> '' THEN BEGIN
                                      AccumOrigDeclAmountEUService :=
                                        AccumOrigDeclAmountEUService + CustVendWarning349_2."Original Declared Amount";
                                      CustVendWarning349_2.Exported := TRUE;
                                      CustVendWarning349_2.MODIFY;
                                    END;
                                  UNTIL CustVendWarning349_2.NEXT = 0;
                                END ELSE BEGIN
                                  IF "VAT Registration No." <> '' THEN BEGIN
                                    AccumPrevDeclAmountEUService := ABS(CustVendWarning349."Previous Declared Amount");
                                    AccumOrigDeclAmountEUService := CustVendWarning349."Original Declared Amount";
                                  END;
                                END
                              ELSE
                                EUServiceAlreadyExported := TRUE;
                    
                              CustVendWarning349_2.RESET;
                              GetCustVendWarnings(CustVendWarning349_2,CustVendWarning349,FALSE,FALSE);
                              CustVendWarning349_2.SETRANGE("EU 3-Party Trade",TRUE);
                              IF CustVendWarning349_2.FINDSET THEN
                                IF CustVendWarning349_2.COUNT > 1 THEN BEGIN
                                  IF "VAT Registration No." <> '' THEN
                                    AccumPrevDeclAmountTri :=
                                      AccumPrevDeclAmountTri + ABS(CustVendWarning349_2."Previous Declared Amount");
                                  REPEAT
                                    IF "VAT Registration No." <> '' THEN BEGIN
                                      AccumOrigDeclAmountTri := AccumOrigDeclAmountTri + CustVendWarning349_2."Original Declared Amount";
                                      CustVendWarning349_2.Exported := TRUE;
                                      CustVendWarning349_2.MODIFY;
                                    END;
                                  UNTIL CustVendWarning349_2.NEXT = 0;
                                END ELSE BEGIN
                                  IF "VAT Registration No." <> '' THEN BEGIN
                                    AccumPrevDeclAmountTri := ABS(CustVendWarning349."Previous Declared Amount");
                                    AccumOrigDeclAmountTri := CustVendWarning349."Original Declared Amount";
                                  END;
                                END
                              ELSE
                                ThirdPartyAlreadyExported := TRUE;
                    
                              OpTriang := ' ';
                              IF VATCredSales."EU 3-Party Trade" THEN
                                OpTriang := 'X';
                              Sign := CustVendWarning349.Sign;
                    
                    
                              IF NOT (AlreadyExported AND EUServiceAlreadyExported AND ThirdPartyAlreadyExported) THEN BEGIN
                                IF "VAT Registration No." <> '' THEN BEGIN
                                  CustVendCountry.GET(Customer2."Country/Region Code");
                    
                                  IF CustVendWarning349."EU Service" THEN BEGIN
                                    TextAmount := COPYSTR(FormatTextAmt(AccumPrevDeclAmountEUService),3,13);
                                    TextAmount2 := COPYSTR(FormatTextAmt(AccumOrigDeclAmountEUService),3,13);
                    
                                    Txt :=
                                      '2' + '349' + FiscalYear + PADSTR(VatRegNo,9,' ') + PADSTR('',58,' ') +
                                      CustVendVatRegNo +
                                      PADSTR(CONVERTSTR(UPPERCASE(Customer2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                                      'S' + PADSTR('',13,' ') + CustVendWarning349."Original Declaration FY" +
                                      CustVendWarning349."Original Declaration Period" + TextAmount2 + TextAmount +
                                      PADSTR('',322,' ');
                    
                    //AQ 16/01/2018
                    GrabaFichero349(0,NoOperations,CustVendVatRegNo,Customer2.Name,'S',0,CustVendWarning349."Original Declaration FY",CustVendWarning349."Original Declaration Period",AccumOrigDeclAmountEUService,AccumPrevDeclAmountEUService);
                    //FIN AQ
                                    OutFile.WRITE(Txt);
                                  END ELSE
                                    IF CustVendWarning349."EU 3-Party Trade" THEN BEGIN
                                      TextAmount := COPYSTR(FormatTextAmt(AccumPrevDeclAmountTri),3,13);
                                      TextAmount2 := COPYSTR(FormatTextAmt(AccumOrigDeclAmountTri),3,13);
                    
                                      Txt :=
                                        '2' + '349' + FiscalYear + PADSTR(VatRegNo,9,' ') + PADSTR('',58,' ') +
                                        CustVendVatRegNo +
                                        PADSTR(CONVERTSTR(UPPERCASE(Customer2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                                        'T' + PADSTR('',13,' ') + CustVendWarning349."Original Declaration FY" +
                                        CustVendWarning349."Original Declaration Period" + TextAmount2 + TextAmount +
                                        PADSTR('',322,' ');
                    //AQ 16/01/2018
                    GrabaFichero349(0,NoOperations,CustVendVatRegNo,Customer2.Name,'T',0,CustVendWarning349."Original Declaration FY",CustVendWarning349."Original Declaration Period",AccumOrigDeclAmountTri,AccumPrevDeclAmountTri);
                    //FIN AQ
                                      OutFile.WRITE(Txt);
                                    END ELSE
                                      FOR i := 1 TO 3 DO
                                        IF (AccPrevDeclAmount[i] <> 0) OR (AccOrigDeclAmount[i] <> 0) THEN BEGIN
                                          TextAmount := COPYSTR(FormatTextAmt(AccPrevDeclAmount[i]),3,13);
                                          TextAmount2 := COPYSTR(FormatTextAmt(AccOrigDeclAmount[i]),3,13);
                    
                                          Txt :=
                                            '2' + '349' + FiscalYear + PADSTR(VatRegNo,9,' ') + PADSTR('',58,' ') +
                                            CustVendVatRegNo +
                                            PADSTR(CONVERTSTR(UPPERCASE(Customer2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                                            OperationCode[i] + PADSTR('',13,' ') + CustVendWarning349."Original Declaration FY" +
                                            CustVendWarning349."Original Declaration Period" + TextAmount2 + TextAmount +
                                            PADSTR('',322,' ');
                    //AQ 16/01/2018
                    //GrabaFichero349(0,NoOperations,CustVendVatRegNo,Customer2.Name,OperationCode[i],Amount[i],'','',0,0);
                    //FIN AQ
                                          OutFile.WRITE(Txt);
                                        END;
                    
                                END ELSE
                                  EmptyVATRegNo := TRUE;
                              END;
                    
                            END ELSE BEGIN
                              IF "VAT Registration No." <> '' THEN BEGIN
                                IF CustVendWarning349."EU Service" THEN BEGIN
                                  AmountEUService := AmountEUService - CustVendWarning349."Original Declared Amount";
                                  CorrIncludedForEUServiceAmount := TRUE;
                                END ELSE BEGIN
                                  IF CustVendWarning349."EU 3-Party Trade" THEN BEGIN
                                    AmountOpTri := AmountOpTri + CustVendWarning349."Original Declared Amount";
                                    CorrIncludedForOpTriAmount := TRUE;
                                  END ELSE BEGIN
                                    IF CustVendWarning349."VAT Entry No." = 0 THEN
                                      VATEntry.INIT
                                    ELSE
                                      VATEntry.GET(CustVendWarning349."VAT Entry No.");
                                    IF ABS(Amount[1]) >= GetTotalCreditMemoAmt - AppliedAmt THEN BEGIN
                                      AppliedAmt += ABS(Amount[1]);
                                      SummarizeBaseAmount(VATEntry,-CustVendWarning349."Original Declared Amount",Amount);
                                      AppliedAmt -= ABS(Amount[1]);
                                    END ELSE BEGIN
                                      CreditMemoOrgDeclaredAmt += CustVendWarning349."Original Declared Amount";
                                      CreditMemoAmt += VATEntry.Base;
                                      NoOfCorrections += 1;
                                      IsCreditMemoPrinted := TRUE;
                                    END;
                                    CorrIncludedForNormalAmount := TRUE;
                                  END;
                                END;
                              END;
                            END;
                            IF RectPeriod = 'O' THEN
                              RectPeriod := '0';
                          UNTIL CustVendWarning349.NEXT = 0;
                    */
                      until Customer2.Next = 0;
                    
                      if "VAT Registration No." <> '' then begin
                        for i := 1 to 3 do begin
                          if Amount[i] < 0 then
                            Amount[i] := -Amount[i];
                          if Amount[i] <> 0 then begin
                            TextAmount := CopyStr(FormatTextAmt(Amount[i]),3,13);
                            CustVendCountry.Get(Customer2."Country/Region Code");
                            Txt :=
                              '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') +
                              CustVendVatRegNo +
                              PadStr(ConvertStr(UpperCase(Customer2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                              OperationCode[i] + ConvertStr(TextAmount,' ','0') + PadStr('',354,' ');
                            NoOperations := NoOperations + 1;
                            TotalAmtShip := TotalAmtShip + Amount[i];
                    //AQ 16/01/2018
                    GrabaFichero349(0,NoOperations,CustVendVatRegNo,Customer2.Name,OperationCode[i],Amount[i],'','',0,0);
                    //FIN AQ 16/01/2018
                    //        OutFile.WRITE(Txt);
                          end;
                        end;
                        if AmountOpTri < 0 then
                          AmountOpTri := -AmountOpTri;
                        if CorrIncludedForOpTriAmount or (AmountOpTri <> 0) then begin
                          TextAmount := CopyStr(FormatTextAmt(AmountOpTri),3,13);
                          CustVendCountry.Get(Customer2."Country/Region Code");
                          Txt :=
                            '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') +
                            CustVendVatRegNo +
                            PadStr(ConvertStr(UpperCase(Customer2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                            'T' + ConvertStr(TextAmount,' ','0') + PadStr('',354,' ');
                          NoOperations := NoOperations + 1;
                          TotalAmtShip := TotalAmtShip + AmountOpTri;
                    //AQ 16/01/2018
                    GrabaFichero349(0,NoOperations,CustVendVatRegNo,Customer2.Name,'T',AmountOpTri,'','',0,0);
                    //FIN AQ
                    //      OutFile.WRITE(Txt);
                        end;
                        if AmountEUService < 0 then
                          AmountEUService := -AmountEUService;
                        if CorrIncludedForEUServiceAmount or (AmountEUService <> 0) then begin
                          TextAmount := CopyStr(FormatTextAmt(AmountEUService),3,13);
                          CustVendCountry.Get(Customer2."Country/Region Code");
                          Txt :=
                            '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') +
                            CustVendVatRegNo +
                            PadStr(ConvertStr(UpperCase(Customer2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                            'S' + ConvertStr(TextAmount,' ','0') + PadStr('',354,' ');
                          NoOperations := NoOperations + 1;
                          TotalAmtShip := TotalAmtShip + AmountEUService;
                    //AQ 16/01/18
                    GrabaFichero349(0,NoOperations,CustVendVatRegNo,Customer2.Name,'S',AmountEUService,'','',0,0);
                    //FIN AQ
                    //      OutFile.WRITE(Txt);
                        end;
                        if IsCreditMemoPrinted then begin
                          TextAmount2 := CopyStr(FormatTextAmt(Abs(CreditMemoOrgDeclaredAmt)),3,13);
                          TextAmount := CopyStr(FormatTextAmt(Abs(CreditMemoAmt)),3,13);
                          CustVendCountry.Get(Customer2."Country/Region Code");
                          Txt :=
                            '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') +
                            CustVendVatRegNo +
                            PadStr(ConvertStr(UpperCase(Customer2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                            'E' + PadStr('',13,' ') + CustVendWarning349."Original Declaration FY" +
                            CustVendWarning349."Original Declaration Period" + TextAmount2 + TextAmount +
                            PadStr('',322,' ');
                          NoOperations += 1;
                          TotalAmtShip += AmountEUService;
                    //      GrabaFichero349(0,NoOperations,CustVendVatRegNo,Customer2.Name,'E',0,CustVendWarning349."Original Declaration FY",CustVendWarning349."Original Declaration Period",CreditMemoOrgDeclaredAmt,CreditMemoAmt);
                    //      OutFile.WRITE(Txt);
                        end;
                      end;
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    PreVATRegNo := '';

                    Window.Update(1,'Clientes: Calculando');
                    i := 0;
                    Window.Update(3,Customer.Count);
                end;
            }
            dataitem(Vendor;Vendor)
            {
                DataItemLink = "Country/Region Code"=field(Code);
                DataItemTableView = sorting("VAT Registration No.") where("VAT Registration No."=filter(<>''));
                PrintOnlyIfDetail = false;
                column(ReportForNavId_3182; 3182)
                {
                }

                trigger OnAfterGetRecord()
                var
                    PurchInvLine: Record "Purch. Inv. Line";
                    AppliedAmt: Decimal;
                    PurchCreditMemoOrgDeclaredAmt: Decimal;
                    PurchCreditMemoAmt: Integer;
                    IsPurchCreditMemoPrinted: Boolean;
                begin
                    i += 1;
                    Window.Update(2,i);

                    while (Vendor."VAT Registration No." = PreVATRegNo) or (Vendor."VAT Registration No." = '') do
                      if Vendor.Next = 0 then
                        exit;
                    PreVATRegNo := Vendor."VAT Registration No.";

                    CustVendCountry.Get("Country/Region Code");
                    CustVendVatRegNo := CombineEUCountryAndVATRegNo(CustVendCountry,"VAT Registration No.");
                    OpTriang := ' ';
                    AmountOpTri := 0;
                    NormalAmount := 0;
                    RectAmount := 0;
                    PrevDeclAmount := 0;
                    AccumPrevDeclAmount := 0;
                    AccumOrigDeclAmount := 0;
                    AmountEUService := 0;
                    AccumPrevDeclAmountEUService := 0;
                    AccumOrigDeclAmountEUService := 0;
                    AccumPrevDeclAmountTri := 0;
                    AccumOrigDeclAmountTri := 0;
                    NoTaxableAmountEUService := 0;

                    Vendor2.Reset;
                    Vendor2.SetRange("VAT Registration No.","VAT Registration No.");
                    if Vendor2.Find('-') then
                      begin
                      repeat
                        GetVATInvPurchEntries(VATInvPurch,Vendor2."No.",FromDate,ToDate,false,FilterString);
                        VATInvPurch.SetRange("EU 3-Party Trade",true);
                        if VATInvPurch.Find('-') then
                          repeat
                            if IncludeIn349(VATInvPurch,AmountToIncludein349,LocationDiffCountryCode) then begin
                              if (VATInvPurch."Country/Region Code" <> CountryCode) or
                                 ((VATInvPurch."Country/Region Code" = CountryCode) and LocationDiffCountryCode)
                              then begin
                                if "VAT Registration No." <> '' then begin
                                  if AmountToIncludein349 <> 0 then begin
                                    OpTriang := 'X';
                                    AmountOpTri := AmountOpTri + AmountToIncludein349;
                                  end else begin
                                    OpTriang := 'X';
                                    AmountOpTri := AmountOpTri + VATInvPurch.Base;
                                  end;
                                end else
                                  EmptyVATRegNo := true;
                              end;
                            end;
                          until VATInvPurch.Next = 0;

                        GetVATInvPurchEntries(VATInvPurch,Vendor2."No.",FromDate,ToDate,false,FilterString);
                        VATInvPurch.SetRange("EU 3-Party Trade",false);
                        if VATInvPurch.Find('-') then
                          repeat
                            if IncludeIn349(VATInvPurch,AmountToIncludein349,LocationDiffCountryCode) then begin
                              if (VATInvPurch."Country/Region Code" <> CountryCode) or
                                 ((VATInvPurch."Country/Region Code" = CountryCode) and LocationDiffCountryCode)
                              then begin
                                if "VAT Registration No." <> '' then begin
                                  if (AmountToIncludein349 <> 0) and ("Currency Code" = '') then
                                    NormalAmount := NormalAmount + AmountToIncludein349
                                  else
                                    NormalAmount := NormalAmount + VATInvPurch.Base;
                                end else
                                  EmptyVATRegNo := true;
                              end;
                            end;
                          until VATInvPurch.Next = 0;

                        GetVATInvPurchEntries(VATInvPurch,Vendor2."No.",FromDate,ToDate,true,FilterString);
                        if VATInvPurch.Find('-') then
                          repeat
                            if IncludeIn349(VATInvPurch,AmountToIncludein349,LocationDiffCountryCode) then begin
                              if (VATInvPurch."Country/Region Code" <> CountryCode) or
                                 ((VATInvPurch."Country/Region Code" = CountryCode) and LocationDiffCountryCode)
                              then begin
                                if "VAT Registration No." <> '' then begin
                                  if (AmountToIncludein349 <> 0) and ("Currency Code" = '') then
                                    AmountEUService := AmountEUService + AmountToIncludein349
                                  else
                                    AmountEUService := AmountEUService + VATInvPurch.Base;
                                end else
                                  EmptyVATRegNo := true;
                              end;
                            end;
                          until VATInvPurch.Next = 0;

                        PurchInvLine.CalcNoTaxableAmount(NormalAmount,AmountEUService,Vendor2."No.",FromDate,ToDate,FilterString);

                        CorrIncludedForNormalAmount := false;
                        CorrIncludedForOpTriAmount := false;
                        CorrIncludedForEUServiceAmount := false;

                        CustVendWarning349.Reset;
                        CustVendWarning349.SetRange(Type,CustVendWarning349.Type::Purchase);
                        CustVendWarning349.SetRange("Customer/Vendor No.",Vendor2."No.");
                        CustVendWarning349.SetRange("Posting Date",FromDate,ToDate);
                        CustVendWarning349.SetRange("Include Correction",true);
                        if CustVendWarning349.FindFirst then
                          repeat
                            if ((CustVendWarning349."Original Declaration FY" <> FiscalYear) or
                                (CustVendWarning349."Original Declaration Period" <> GetPeriodAsText))
                            then begin
                              TotalCorreAmt := TotalCorreAmt + CustVendWarning349."Original Declared Amount";
                              NoOfCorrections := NoOfCorrections + 1;
                              AccumPrevDeclAmount := 0;
                              AccumOrigDeclAmount := 0;
                              AccumPrevDeclAmountEUService := 0;
                              AccumOrigDeclAmountEUService := 0;
                              AccumPrevDeclAmountTri := 0;
                              AccumOrigDeclAmountTri := 0;

                              CustVendWarning349_2 := CustVendWarning349;
                              GetCustVendWarnings(CustVendWarning349_2,CustVendWarning349,false,false);
                              CustVendWarning349_2.SetRange("EU 3-Party Trade",false);
                              AlreadyExported := false;

                              if CustVendWarning349_2.FindFirst then begin
                                if CustVendWarning349_2.Count > 1 then begin
                                  if "VAT Registration No." <> '' then
                                    AccumPrevDeclAmount := AccumPrevDeclAmount + Abs(CustVendWarning349_2."Previous Declared Amount");
                                  repeat
                                    if "VAT Registration No." <> '' then begin
                                      AccumOrigDeclAmount := AccumOrigDeclAmount + CustVendWarning349_2."Original Declared Amount";
                                      CustVendWarning349_2.Exported := true;
                                      CustVendWarning349_2.Modify;
                                    end;
                                  until CustVendWarning349_2.Next = 0;
                                end else begin
                                  if "VAT Registration No." <> '' then begin
                                    AccumPrevDeclAmount := Abs(CustVendWarning349_2."Previous Declared Amount");
                                    AccumOrigDeclAmount := CustVendWarning349."Original Declared Amount";
                                  end;
                                end;
                              end else
                                AlreadyExported := true;
                              ThirdPartyAlreadyExported := false;
                              EUServiceAlreadyExported := false;

                              CustVendWarning349_2.Reset;
                              GetCustVendWarnings(CustVendWarning349_2,CustVendWarning349,false,true);
                              if CustVendWarning349_2.FindSet then
                                if CustVendWarning349_2.Count > 1 then begin
                                  if "VAT Registration No." <> '' then
                                    AccumPrevDeclAmountEUService :=
                                      AccumPrevDeclAmountEUService + Abs(CustVendWarning349_2."Previous Declared Amount");
                                  repeat
                                    if "VAT Registration No." <> '' then begin
                                      AccumOrigDeclAmountEUService := AccumOrigDeclAmountEUService + CustVendWarning349_2."Original Declared Amount";
                                      CustVendWarning349_2.Exported := true;
                                      CustVendWarning349_2.Modify;
                                    end;
                                  until CustVendWarning349_2.Next = 0;
                                end else begin
                                  if "VAT Registration No." <> '' then begin
                                    AccumPrevDeclAmountEUService := Abs(CustVendWarning349."Previous Declared Amount");
                                    AccumOrigDeclAmountEUService := CustVendWarning349."Original Declared Amount";
                                  end;
                                end
                              else
                                EUServiceAlreadyExported := true;

                              CustVendWarning349_2.Reset;
                              GetCustVendWarnings(CustVendWarning349_2,CustVendWarning349,false,false);
                              CustVendWarning349_2.SetRange("EU 3-Party Trade",true);
                              if CustVendWarning349_2.FindSet then
                                if CustVendWarning349_2.Count > 1 then begin
                                  if "VAT Registration No." <> '' then
                                    AccumPrevDeclAmountTri :=
                                      AccumPrevDeclAmountTri + Abs(CustVendWarning349_2."Previous Declared Amount");
                                  repeat
                                    if "VAT Registration No." <> '' then begin
                                      AccumOrigDeclAmountTri := AccumOrigDeclAmountTri + CustVendWarning349_2."Original Declared Amount";
                                      CustVendWarning349_2.Exported := true;
                                      CustVendWarning349_2.Modify;
                                    end;
                                  until CustVendWarning349_2.Next = 0;
                                end else begin
                                  if "VAT Registration No." <> '' then begin
                                    AccumPrevDeclAmountTri := Abs(CustVendWarning349."Previous Declared Amount");
                                    AccumOrigDeclAmountTri := CustVendWarning349."Original Declared Amount";
                                  end;
                                end
                              else
                                ThirdPartyAlreadyExported := true;
                              OpTriang := ' ';
                              if VATCredPurch."EU 3-Party Trade" then
                                OpTriang := 'X';
                              Sign := CustVendWarning349.Sign;

                              if not (AlreadyExported and EUServiceAlreadyExported and ThirdPartyAlreadyExported) then begin
                                if "VAT Registration No." <> '' then begin
                                  CustVendCountry.Get(Vendor2."Country/Region Code");
                                  if CustVendWarning349."EU Service" then begin
                                    TextAmount := CopyStr(FormatTextAmt(AccumPrevDeclAmountEUService),3,13);
                                    TextAmount2 := CopyStr(FormatTextAmt(AccumOrigDeclAmountEUService),3,13);

                                    Txt :=
                                      '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') +
                                      CustVendVatRegNo +
                                      PadStr(ConvertStr(UpperCase(Vendor2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                                      'I' + PadStr('',13,' ') + CustVendWarning349."Original Declaration FY" +
                                      CustVendWarning349."Original Declaration Period" + TextAmount2 + TextAmount +
                                      PadStr('',322,' ');
                    //                OutFile.WRITE(Txt);
                                  end else
                                    if CustVendWarning349."EU 3-Party Trade" then begin
                                      TextAmount := CopyStr(FormatTextAmt(AccumPrevDeclAmountTri),3,13);
                                      TextAmount2 := CopyStr(FormatTextAmt(AccumOrigDeclAmountTri),3,13);

                                      Txt :=
                                        '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') +
                                        CustVendVatRegNo +
                                        PadStr(ConvertStr(UpperCase(Vendor2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                                        'T' + PadStr('',13,' ') + CustVendWarning349."Original Declaration FY" +
                                        CustVendWarning349."Original Declaration Period" + TextAmount2 + TextAmount +
                                        PadStr('',322,' ');
                    //                  OutFile.WRITE(Txt);
                                    end else begin
                                      TextAmount := CopyStr(FormatTextAmt(AccumPrevDeclAmount),3,13);
                                      TextAmount2 := CopyStr(FormatTextAmt(AccumOrigDeclAmount),3,13);
                                      Txt :=
                                        '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') +
                                        CustVendVatRegNo +
                                        PadStr(ConvertStr(UpperCase(Vendor2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                                        'A' + PadStr('',13,' ') + CustVendWarning349."Original Declaration FY" +
                                        CustVendWarning349."Original Declaration Period" + TextAmount2 + TextAmount +
                                        PadStr('',322,' ');
                    //                  OutFile.WRITE(Txt);
                                    end;
                                end else
                                  EmptyVATRegNo := true;
                              end;
                            end else begin
                              if "VAT Registration No." <> '' then begin
                                if CustVendWarning349."EU Service" then begin
                                  AmountEUService := AmountEUService - CustVendWarning349."Original Declared Amount";
                                  CorrIncludedForEUServiceAmount := true;
                                end else begin
                                  if CustVendWarning349."EU 3-Party Trade" then begin
                                    AmountOpTri := AmountOpTri - CustVendWarning349."Original Declared Amount";
                                    CorrIncludedForOpTriAmount := true;
                                  end else begin
                                    if Abs(NormalAmount) >= GetTotalPurchCreditMemoAmt - AppliedAmt then begin
                                      AppliedAmt += Abs(NormalAmount);
                                      NormalAmount := NormalAmount - CustVendWarning349."Original Declared Amount";
                                      AppliedAmt -= Abs(NormalAmount);
                                    end else begin
                                      PurchCreditMemoOrgDeclaredAmt += CustVendWarning349."Original Declared Amount";
                                      NoOfCorrections += 1;
                                      IsPurchCreditMemoPrinted := true;
                                    end;
                                    CorrIncludedForNormalAmount := true;
                                  end;
                                end;
                              end;
                            end;
                            if RectPeriod = 'O' then
                              RectPeriod := '0';
                          until CustVendWarning349.Next = 0;
                      until Vendor2.Next = 0;

                      if "VAT Registration No." <> '' then begin
                        if NormalAmount < 0 then
                          NormalAmount := -NormalAmount;
                        if CorrIncludedForNormalAmount or (NormalAmount <> 0) then begin
                          TextAmount := CopyStr(FormatTextAmt(NormalAmount),3,13);
                          CustVendCountry.Get(Vendor2."Country/Region Code");
                          Txt :=
                            '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') +
                            CustVendVatRegNo +
                            PadStr(ConvertStr(UpperCase(Vendor2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                            'A' + ConvertStr(TextAmount,' ','0') + PadStr('',354,' ');
                          NoOperations := NoOperations + 1;
                          TotalAmtReciv := TotalAmtReciv + NormalAmount;

                    //AQ 16/01/18
                    GrabaFichero349(1,NoOperations,CustVendVatRegNo,Vendor2.Name,'A',NormalAmount,'','',0,0);
                    //FIN AQ

                    //      OutFile.WRITE(Txt);
                        end;
                        if AmountOpTri < 0 then
                          AmountOpTri := -AmountOpTri;
                        if CorrIncludedForOpTriAmount or (AmountOpTri <> 0) then begin
                          TextAmount := CopyStr(FormatTextAmt(AmountOpTri),3,13);
                          CustVendCountry.Get(Vendor2."Country/Region Code");
                          Txt :=
                            '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') +
                            CustVendVatRegNo +
                            PadStr(ConvertStr(UpperCase(Vendor2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                            'T' + ConvertStr(TextAmount,' ','0') + PadStr('',354,' ');
                          NoOperations := NoOperations + 1;
                          TotalAmtReciv := TotalAmtReciv + AmountOpTri;

                    //AQ 16/01/18
                    GrabaFichero349(1,NoOperations,CustVendVatRegNo,Vendor2.Name,'T',AmountOpTri,'','',0,0);
                    //FIN AQ

                    //      OutFile.WRITE(Txt);
                        end;
                      end;
                      if AmountEUService < 0 then
                        AmountEUService := -AmountEUService;
                      if CorrIncludedForEUServiceAmount or (AmountEUService <> 0) then begin
                        TextAmount := CopyStr(FormatTextAmt(AmountEUService),3,13);
                        CustVendCountry.Get(Vendor2."Country/Region Code");
                        Txt :=
                          '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') +
                          CustVendVatRegNo +
                          PadStr(ConvertStr(UpperCase(Vendor2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                          'I' + ConvertStr(TextAmount,' ','0') + PadStr('',354,' ');
                        NoOperations := NoOperations + 1;
                        TotalAmtReciv := TotalAmtReciv + AmountEUService;

                    //AQ 16/01/18
                    GrabaFichero349(1,NoOperations,CustVendVatRegNo,Vendor2.Name,'I',AmountEUService,'','',0,0);
                    //FIN AQ

                    //    OutFile.WRITE(Txt);
                      end;
                      if IsPurchCreditMemoPrinted then begin
                        TextAmount := CopyStr(FormatTextAmt(Abs(PurchCreditMemoOrgDeclaredAmt)),3,13);
                        CustVendCountry.Get(Customer2."Country/Region Code");
                        Txt :=
                          '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') +
                          CustVendVatRegNo +
                          PadStr(ConvertStr(UpperCase(Vendor2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                          'E' + PadStr('',13,' ') + CustVendWarning349."Original Declaration FY" +
                          CustVendWarning349."Original Declaration Period" + TextAmount +
                          PadStr('',322,' ');
                        NoOperations += 1;
                        TotalAmtShip += AmountEUService;

                    //AQ 16/01/18
                    GrabaFichero349(1,NoOperations,CustVendVatRegNo,Vendor2.Name,'E',PurchCreditMemoOrgDeclaredAmt,CustVendWarning349."Original Declaration FY",CustVendWarning349."Original Declaration Period",0,0);
                    //FIN AQ

                    //    OutFile.WRITE(Txt);
                      end;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    PreVATRegNo := '';

                    Window.Update(1,'Proveedores: Calculando');

                    i := 0;
                    Window.Update(3,Vendor.Count);
                end;
            }
            dataitem("Order Address";"Order Address")
            {
                DataItemLink = "Country/Region Code"=field(Code);
                DataItemTableView = sorting("VAT Registration No.") where("VAT Registration No."=filter(<>""));
                column(ReportForNavId_1000000000; 1000000000)
                {
                }

                trigger OnAfterGetRecord()
                var
                    PurchInvLine: Record "Purch. Inv. Line";
                    AppliedAmt: Decimal;
                    PurchCreditMemoOrgDeclaredAmt: Decimal;
                    IsPurchCreditMemoPrinted: Boolean;
                    PurchInvHeader: Record "Purch. Inv. Header";
                    PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
                begin
                    i += 1;
                    Window.Update(2,i);
                    
                    while ("Order Address"."VAT Registration No." = PreVATRegNo) or ("Order Address"."VAT Registration No." = '') do
                      if "Order Address".Next = 0 then
                        exit;
                    PreVATRegNo := "Order Address"."VAT Registration No.";
                    
                    CustVendCountry.Get("Country/Region Code");
                    CustVendVatRegNo := CombineEUCountryAndVATRegNo(CustVendCountry,"VAT Registration No.");
                    OpTriang := ' ';
                    AmountOpTri := 0;
                    NormalAmount := 0;
                    RectAmount := 0;
                    PrevDeclAmount := 0;
                    AccumPrevDeclAmount := 0;
                    AccumOrigDeclAmount := 0;
                    AmountEUService := 0;
                    AccumPrevDeclAmountEUService := 0;
                    AccumOrigDeclAmountEUService := 0;
                    AccumPrevDeclAmountTri := 0;
                    AccumOrigDeclAmountTri := 0;
                    NoTaxableAmountEUService := 0;
                    
                    
                    Vendor2.Reset;
                    //Vendor2.SETRANGE("VAT Registration No.","VAT Registration No.");
                    Vendor2.SetRange("No.","Order Address"."Vendor No.");
                    if Vendor2.Find('-') then
                      begin
                      repeat
                        /*
                        GetVATInvPurchEntries(VATInvPurch,Vendor2."No.",FromDate,ToDate,FALSE,FilterString);
                        VATInvPurch.SETRANGE("EU 3-Party Trade",TRUE);
                        IF VATInvPurch.FIND('-') THEN
                          REPEAT
                            IF IncludeIn349(VATInvPurch,AmountToIncludein349,LocationDiffCountryCode) THEN BEGIN
                              IF (VATInvPurch."Country/Region Code" <> CountryCode) OR
                                 ((VATInvPurch."Country/Region Code" = CountryCode) AND LocationDiffCountryCode)
                              THEN BEGIN
                                IF "VAT Registration No." <> '' THEN BEGIN
                                  IF AmountToIncludein349 <> 0 THEN BEGIN
                                    OpTriang := 'X';
                                    AmountOpTri := AmountOpTri + AmountToIncludein349;
                                  END ELSE BEGIN
                                    OpTriang := 'X';
                                    AmountOpTri := AmountOpTri + VATInvPurch.Base;
                                  END;
                                END ELSE
                                  EmptyVATRegNo := TRUE;
                              END;
                            END;
                          UNTIL VATInvPurch.NEXT = 0;
                        */
                    
                        GetVATInvPurchEntries(VATInvPurch,Vendor2."No.",FromDate,ToDate,false,FilterString);
                        VATInvPurch.SetRange("EU 3-Party Trade",false);
                        if VATInvPurch.Find('-') then
                          repeat
                            if PurchInvHeader.Get(VATInvPurch."Document No.") and (PurchInvHeader."Order Address Code" = Code) then begin
                              VATInvPurch."Country/Region Code" := "Order Address"."Country/Region Code";
                              if IncludeIn349(VATInvPurch,AmountToIncludein349,LocationDiffCountryCode) then begin
                                if (VATInvPurch."Country/Region Code" <> CountryCode) or
                                   ((VATInvPurch."Country/Region Code" = CountryCode) and LocationDiffCountryCode)
                                then begin
                                  if "VAT Registration No." <> '' then begin
                                    if (AmountToIncludein349 <> 0) /*AND ("Currency Code" = '')*/ then
                                      NormalAmount := NormalAmount + AmountToIncludein349
                                    else
                                      NormalAmount := NormalAmount + VATInvPurch.Base;
                                  end else
                                    EmptyVATRegNo := true;
                                end;
                              end;
                            end;
                          until VATInvPurch.Next = 0;
                    
                        GetVATInvPurchEntries(VATInvPurch,Vendor2."No.",FromDate,ToDate,true,FilterString);
                        if VATInvPurch.Find('-') then
                          repeat
                            if PurchInvHeader.Get(VATInvPurch."Document No.") and (PurchInvHeader."Order Address Code" = Code) then begin
                              VATInvPurch."Country/Region Code" := "Order Address"."Country/Region Code";
                              if IncludeIn349(VATInvPurch,AmountToIncludein349,LocationDiffCountryCode) then begin
                                if (VATInvPurch."Country/Region Code" <> CountryCode) or
                                   ((VATInvPurch."Country/Region Code" = CountryCode) and LocationDiffCountryCode)
                                then begin
                                  if "VAT Registration No." <> '' then begin
                                    if (AmountToIncludein349 <> 0) /*AND ("Currency Code" = '')*/ then
                                      AmountEUService := AmountEUService + AmountToIncludein349
                                    else
                                      AmountEUService := AmountEUService + VATInvPurch.Base;
                                  end else
                                    EmptyVATRegNo := true;
                                end;
                              end;
                            end;
                          until VATInvPurch.Next = 0;
                    
                        /*
                        PurchInvLine.CalcNoTaxableAmount(NormalAmount,AmountEUService,Vendor2."No.",FromDate,ToDate,FilterString);
                    
                        CorrIncludedForNormalAmount := FALSE;
                        CorrIncludedForOpTriAmount := FALSE;
                        CorrIncludedForEUServiceAmount := FALSE;
                    
                        CustVendWarning349.RESET;
                        CustVendWarning349.SETRANGE(Type,CustVendWarning349.Type::Purchase);
                        CustVendWarning349.SETRANGE("Customer/Vendor No.",Vendor2."No.");
                        CustVendWarning349.SETRANGE("Posting Date",FromDate,ToDate);
                        CustVendWarning349.SETRANGE("Include Correction",TRUE);
                        IF CustVendWarning349.FINDFIRST THEN
                          REPEAT
                            IF ((CustVendWarning349."Original Declaration FY" <> FiscalYear) OR
                                (CustVendWarning349."Original Declaration Period" <> GetPeriodAsText))
                            THEN BEGIN
                              TotalCorreAmt := TotalCorreAmt + CustVendWarning349."Original Declared Amount";
                              NoOfCorrections := NoOfCorrections + 1;
                              AccumPrevDeclAmount := 0;
                              AccumOrigDeclAmount := 0;
                              AccumPrevDeclAmountEUService := 0;
                              AccumOrigDeclAmountEUService := 0;
                              AccumPrevDeclAmountTri := 0;
                              AccumOrigDeclAmountTri := 0;
                    
                              CustVendWarning349_2 := CustVendWarning349;
                              GetCustVendWarnings(CustVendWarning349_2,CustVendWarning349,FALSE,FALSE);
                              CustVendWarning349_2.SETRANGE("EU 3-Party Trade",FALSE);
                              AlreadyExported := FALSE;
                    
                              IF CustVendWarning349_2.FINDFIRST THEN BEGIN
                                IF CustVendWarning349_2.COUNT > 1 THEN BEGIN
                                  IF "VAT Registration No." <> '' THEN
                                    AccumPrevDeclAmount := AccumPrevDeclAmount + ABS(CustVendWarning349_2."Previous Declared Amount");
                                  REPEAT
                                    IF "VAT Registration No." <> '' THEN BEGIN
                                      AccumOrigDeclAmount := AccumOrigDeclAmount + CustVendWarning349_2."Original Declared Amount";
                                      CustVendWarning349_2.Exported := TRUE;
                                      CustVendWarning349_2.MODIFY;
                                    END;
                                  UNTIL CustVendWarning349_2.NEXT = 0;
                                END ELSE BEGIN
                                  IF "VAT Registration No." <> '' THEN BEGIN
                                    AccumPrevDeclAmount := ABS(CustVendWarning349_2."Previous Declared Amount");
                                    AccumOrigDeclAmount := CustVendWarning349."Original Declared Amount";
                                  END;
                                END;
                              END ELSE
                                AlreadyExported := TRUE;
                              ThirdPartyAlreadyExported := FALSE;
                              EUServiceAlreadyExported := FALSE;
                    
                              CustVendWarning349_2.RESET;
                              GetCustVendWarnings(CustVendWarning349_2,CustVendWarning349,FALSE,TRUE);
                              IF CustVendWarning349_2.FINDSET THEN
                                IF CustVendWarning349_2.COUNT > 1 THEN BEGIN
                                  IF "VAT Registration No." <> '' THEN
                                    AccumPrevDeclAmountEUService :=
                                      AccumPrevDeclAmountEUService + ABS(CustVendWarning349_2."Previous Declared Amount");
                                  REPEAT
                                    IF "VAT Registration No." <> '' THEN BEGIN
                                      AccumOrigDeclAmountEUService := AccumOrigDeclAmountEUService + CustVendWarning349_2."Original Declared Amount";
                                      CustVendWarning349_2.Exported := TRUE;
                                      CustVendWarning349_2.MODIFY;
                                    END;
                                  UNTIL CustVendWarning349_2.NEXT = 0;
                                END ELSE BEGIN
                                  IF "VAT Registration No." <> '' THEN BEGIN
                                    AccumPrevDeclAmountEUService := ABS(CustVendWarning349."Previous Declared Amount");
                                    AccumOrigDeclAmountEUService := CustVendWarning349."Original Declared Amount";
                                  END;
                                END
                              ELSE
                                EUServiceAlreadyExported := TRUE;
                    
                              CustVendWarning349_2.RESET;
                              GetCustVendWarnings(CustVendWarning349_2,CustVendWarning349,FALSE,FALSE);
                              CustVendWarning349_2.SETRANGE("EU 3-Party Trade",TRUE);
                              IF CustVendWarning349_2.FINDSET THEN
                                IF CustVendWarning349_2.COUNT > 1 THEN BEGIN
                                  IF "VAT Registration No." <> '' THEN
                                    AccumPrevDeclAmountTri :=
                                      AccumPrevDeclAmountTri + ABS(CustVendWarning349_2."Previous Declared Amount");
                                  REPEAT
                                    IF "VAT Registration No." <> '' THEN BEGIN
                                      AccumOrigDeclAmountTri := AccumOrigDeclAmountTri + CustVendWarning349_2."Original Declared Amount";
                                      CustVendWarning349_2.Exported := TRUE;
                                      CustVendWarning349_2.MODIFY;
                                    END;
                                  UNTIL CustVendWarning349_2.NEXT = 0;
                                END ELSE BEGIN
                                  IF "VAT Registration No." <> '' THEN BEGIN
                                    AccumPrevDeclAmountTri := ABS(CustVendWarning349."Previous Declared Amount");
                                    AccumOrigDeclAmountTri := CustVendWarning349."Original Declared Amount";
                                  END;
                                END
                              ELSE
                                ThirdPartyAlreadyExported := TRUE;
                              OpTriang := ' ';
                              IF VATCredPurch."EU 3-Party Trade" THEN
                                OpTriang := 'X';
                              Sign := CustVendWarning349.Sign;
                    
                              IF NOT (AlreadyExported AND EUServiceAlreadyExported AND ThirdPartyAlreadyExported) THEN BEGIN
                                IF "VAT Registration No." <> '' THEN BEGIN
                                  CustVendCountry.GET(Vendor2."Country/Region Code");
                                  IF CustVendWarning349."EU Service" THEN BEGIN
                                    TextAmount := COPYSTR(FormatTextAmt(AccumPrevDeclAmountEUService),3,13);
                                    TextAmount2 := COPYSTR(FormatTextAmt(AccumOrigDeclAmountEUService),3,13);
                    
                                    Txt :=
                                      '2' + '349' + FiscalYear + PADSTR(VatRegNo,9,' ') + PADSTR('',58,' ') +
                                      CustVendVatRegNo +
                                      PADSTR(CONVERTSTR(UPPERCASE(Vendor2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                                      'I' + PADSTR('',13,' ') + CustVendWarning349."Original Declaration FY" +
                                      CustVendWarning349."Original Declaration Period" + TextAmount2 + TextAmount +
                                      PADSTR('',322,' ');
                    //                OutFile.WRITE(Txt);
                                  END ELSE
                                    IF CustVendWarning349."EU 3-Party Trade" THEN BEGIN
                                      TextAmount := COPYSTR(FormatTextAmt(AccumPrevDeclAmountTri),3,13);
                                      TextAmount2 := COPYSTR(FormatTextAmt(AccumOrigDeclAmountTri),3,13);
                    
                                      Txt :=
                                        '2' + '349' + FiscalYear + PADSTR(VatRegNo,9,' ') + PADSTR('',58,' ') +
                                        CustVendVatRegNo +
                                        PADSTR(CONVERTSTR(UPPERCASE(Vendor2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                                        'T' + PADSTR('',13,' ') + CustVendWarning349."Original Declaration FY" +
                                        CustVendWarning349."Original Declaration Period" + TextAmount2 + TextAmount +
                                        PADSTR('',322,' ');
                    //                  OutFile.WRITE(Txt);
                                    END ELSE BEGIN
                                      TextAmount := COPYSTR(FormatTextAmt(AccumPrevDeclAmount),3,13);
                                      TextAmount2 := COPYSTR(FormatTextAmt(AccumOrigDeclAmount),3,13);
                                      Txt :=
                                        '2' + '349' + FiscalYear + PADSTR(VatRegNo,9,' ') + PADSTR('',58,' ') +
                                        CustVendVatRegNo +
                                        PADSTR(CONVERTSTR(UPPERCASE(Vendor2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                                        'A' + PADSTR('',13,' ') + CustVendWarning349."Original Declaration FY" +
                                        CustVendWarning349."Original Declaration Period" + TextAmount2 + TextAmount +
                                        PADSTR('',322,' ');
                    //                  OutFile.WRITE(Txt);
                                    END;
                                END ELSE
                                  EmptyVATRegNo := TRUE;
                              END;
                            END ELSE BEGIN
                              IF "VAT Registration No." <> '' THEN BEGIN
                                IF CustVendWarning349."EU Service" THEN BEGIN
                                  AmountEUService := AmountEUService - CustVendWarning349."Original Declared Amount";
                                  CorrIncludedForEUServiceAmount := TRUE;
                                END ELSE BEGIN
                                  IF CustVendWarning349."EU 3-Party Trade" THEN BEGIN
                                    AmountOpTri := AmountOpTri - CustVendWarning349."Original Declared Amount";
                                    CorrIncludedForOpTriAmount := TRUE;
                                  END ELSE BEGIN
                                    IF ABS(NormalAmount) >= GetTotalPurchCreditMemoAmt - AppliedAmt THEN BEGIN
                                      AppliedAmt += ABS(NormalAmount);
                                      NormalAmount := NormalAmount - CustVendWarning349."Original Declared Amount";
                                      AppliedAmt -= ABS(NormalAmount);
                                    END ELSE BEGIN
                                      PurchCreditMemoOrgDeclaredAmt += CustVendWarning349."Original Declared Amount";
                                      NoOfCorrections += 1;
                                      IsPurchCreditMemoPrinted := TRUE;
                                    END;
                                    CorrIncludedForNormalAmount := TRUE;
                                  END;
                                END;
                              END;
                            END;
                            IF RectPeriod = 'O' THEN
                              RectPeriod := '0';
                          UNTIL CustVendWarning349.NEXT = 0;
                        */
                      until Vendor2.Next = 0;
                    
                      Vendor2.Name := "Order Address".Name;
                      Vendor2."VAT Registration No." := "Order Address"."VAT Registration No.";
                    
                      if "VAT Registration No." <> '' then begin
                        if NormalAmount < 0 then
                          NormalAmount := -NormalAmount;
                        if CorrIncludedForNormalAmount or (NormalAmount <> 0) then begin
                          TextAmount := CopyStr(FormatTextAmt(NormalAmount),3,13);
                          CustVendCountry.Get(Vendor2."Country/Region Code");
                          Txt :=
                            '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') +
                            CustVendVatRegNo +
                            PadStr(ConvertStr(UpperCase(Vendor2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                            'A' + ConvertStr(TextAmount,' ','0') + PadStr('',354,' ');
                          NoOperations := NoOperations + 1;
                          TotalAmtReciv := TotalAmtReciv + NormalAmount;
                    
                    //AQ 16/01/18
                    GrabaFichero349(1,NoOperations,CustVendVatRegNo,Vendor2.Name,'A',NormalAmount,'','',0,0);
                    //FIN AQ
                    
                    //      OutFile.WRITE(Txt);
                        end;
                        if AmountOpTri < 0 then
                          AmountOpTri := -AmountOpTri;
                        if CorrIncludedForOpTriAmount or (AmountOpTri <> 0) then begin
                          TextAmount := CopyStr(FormatTextAmt(AmountOpTri),3,13);
                          CustVendCountry.Get(Vendor2."Country/Region Code");
                          Txt :=
                            '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') +
                            CustVendVatRegNo +
                            PadStr(ConvertStr(UpperCase(Vendor2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                            'T' + ConvertStr(TextAmount,' ','0') + PadStr('',354,' ');
                          NoOperations := NoOperations + 1;
                          TotalAmtReciv := TotalAmtReciv + AmountOpTri;
                    
                    //AQ 16/01/18
                    GrabaFichero349(1,NoOperations,CustVendVatRegNo,Vendor2.Name,'T',AmountOpTri,'','',0,0);
                    //FIN AQ
                    
                    //      OutFile.WRITE(Txt);
                        end;
                      end;
                      if AmountEUService < 0 then
                        AmountEUService := -AmountEUService;
                      if CorrIncludedForEUServiceAmount or (AmountEUService <> 0) then begin
                        TextAmount := CopyStr(FormatTextAmt(AmountEUService),3,13);
                        CustVendCountry.Get(Vendor2."Country/Region Code");
                        Txt :=
                          '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') +
                          CustVendVatRegNo +
                          PadStr(ConvertStr(UpperCase(Vendor2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                          'I' + ConvertStr(TextAmount,' ','0') + PadStr('',354,' ');
                        NoOperations := NoOperations + 1;
                        TotalAmtReciv := TotalAmtReciv + AmountEUService;
                    
                    //AQ 16/01/18
                    GrabaFichero349(1,NoOperations,CustVendVatRegNo,Vendor2.Name,'I',AmountEUService,'','',0,0);
                    //FIN AQ
                    
                    //    OutFile.WRITE(Txt);
                      end;
                      if IsPurchCreditMemoPrinted then begin
                        TextAmount := CopyStr(FormatTextAmt(Abs(PurchCreditMemoOrgDeclaredAmt)),3,13);
                        CustVendCountry.Get(Customer2."Country/Region Code");
                        Txt :=
                          '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') +
                          CustVendVatRegNo +
                          PadStr(ConvertStr(UpperCase(Vendor2.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
                          'E' + PadStr('',13,' ') + CustVendWarning349."Original Declaration FY" +
                          CustVendWarning349."Original Declaration Period" + TextAmount +
                          PadStr('',322,' ');
                        NoOperations += 1;
                        TotalAmtShip += AmountEUService;
                    
                    //AQ 16/01/18
                    GrabaFichero349(1,NoOperations,CustVendVatRegNo,Vendor2.Name,'E',PurchCreditMemoOrgDeclaredAmt,CustVendWarning349."Original Declaration FY",CustVendWarning349."Original Declaration Period",0,0);
                    //FIN AQ
                    
                    //    OutFile.WRITE(Txt);
                      end;
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    PreVATRegNo := '';

                    Window.Update(1,'Direcciones de entrega: Calculando');

                    i := 0;
                    Window.Update(3,Vendor.Count);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Window.Update(4,"Country/Region".Code);
            end;

            trigger OnPostDataItem()
            begin
                Window.Close;
            end;

            trigger OnPreDataItem()
            begin
                Window.Close;
                Window.Open('País #4#######################################################################\'+
                            'Proceso #1#######################################################################\' +
                            'Numero #2######### de #3#########');
            end;
        }
        dataitem(Integer4;"Integer")
        {
            DataItemTableView = sorting(Number) where(Number=const(1));
            column(ReportForNavId_3930; 3930)
            {
            }

            trigger OnPreDataItem()
            begin
                //AQ
                /*
                IF EmptyVATRegNo THEN BEGIN
                  IF NOT CONFIRM(STRSUBSTNO(Text1100015,Customer.TABLECAPTION,Vendor.TABLECAPTION,
                         Customer.FIELDCAPTION("VAT Registration No.")),FALSE)
                  THEN BEGIN
                    CustVendWarning349.RESET;
                    CustVendWarning349.DELETEALL;
                    COMMIT;
                    OutFile.CLOSE;
                    ERASE(FileName);
                    ERROR(Text1100011);
                  END;
                END;
                */
                Message(StrSubstNo(Text1100015,Customer.TableCaption,Vendor.TableCaption,
                         Customer.FieldCaption("VAT Registration No.")));
                //FIN AQ

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
                    group("Operations EU")
                    {
                        Caption = 'Operations EU';
                        field(FiscalYear;FiscalYear)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Fiscal Year';
                            Numeric = true;
                            ToolTip = 'Specifies the year of the reporting period. It must be 4 digits without spaces or special characters.';
                        }
                        field(Period;Period)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Period';
                            OptionCaption = 'Annual,January,February,March,April,May,June,July,August,September,October,November,December,1st Quarter,2nd Quarter,3rd Quarter,4th Quarter';
                            ToolTip = 'Specifies the period that the report covers, such as a year, a month, or a quarter.';

                            trigger OnValidate()
                            begin
                                PeriodFreqChange := false;
                                UpdateRequestForm;
                            end;
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            PeriodFrequencyChangeEnable := true;
            if FiscalYear = '' then
              FiscalYear := '0000';
            DeclarationNum := '3490000000000';
            CountryCode := '';
        end;

        trigger OnOpenPage()
        begin
            UpdateRequestForm;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin

        CompanyInfo.Get;
        VatRegNo := CopyStr(DelChr(CompanyInfo."VAT Registration No.",'=','.-/'),1,9);
        NoOperations := 0;
        NoOfRectShips := 0;
        NoOfRectReciv := 0;
        OperationCode[Idx::E] := 'E';
        OperationCode[Idx::M] := 'M';
        OperationCode[Idx::H] := 'H';
    end;

    trigger OnPostReport()
    var
        FileManagement: Codeunit "File Management";
    begin
        /*
        IF TotalAmtShip < 0 THEN
          TotalAmtShip := -TotalAmtShip;
        TextOpAmount := FormatTextAmt(TotalAmtShip + TotalAmtReciv);
        TextCorreAmount := FormatTextAmt(TotalCorreAmt);
        
        CASE DeclarationMediaType OF
          DeclarationMediaType::Telematic:
            DeclarationMT := 'T';
          DeclarationMediaType::"Physical support":
            DeclarationMT := 'C';
        END;
        IF PeriodFreqChange THEN
          PeriodChangeText := 'X'
        ELSE
          PeriodChangeText := ' ';
        IF (TextOpAmount <> PADSTR('',15,'0')) OR (TextCorreAmount <> PADSTR('',15,'0')) THEN BEGIN
          Txt :=
            '1' + '349' + FiscalYear + PADSTR(VatRegNo,9,' ') +
            PADSTR(CONVERTSTR(UPPERCASE(CompanyInfo.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') + DeclarationMT +
            CONVERTSTR(FORMAT(ContactTelephone,9),' ','0') +
            PADSTR(CONVERTSTR(UPPERCASE(ContactName),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
            DeclarationNum +
            '  ' + PADSTR('',13,'0') + GetPeriodAsText +
            CONVERTSTR(FORMAT(NoOperations,9),' ','0') + CONVERTSTR(TextOpAmount,' ','0') +
            CONVERTSTR(FORMAT(NoOfCorrections,9),' ','0') + CONVERTSTR(TextCorreAmount,' ','0') +
            PeriodChangeText + PADSTR('',314,' ');
        
          OutFile.SEEK(0);
          OutStr.WRITETEXT(Txt);
          OutFile.CLOSE;
        END ELSE BEGIN
          OutFile.CLOSE;
          ERASE(FileName);
          MESSAGE(Text1100013);
        END;
        */
        /*
        CustVendWarning349.RESET;
        CustVendWarning349.DELETEALL;
        
        ToFile := Text1100016 + '.txt';
        IF ReportFileName <> '' THEN
          FileManagement.CopyServerFile(FileName,ReportFileName,TRUE)
        ELSE
          IF NOT DOWNLOAD(FileName,Text1100006,'',Text1100017,ToFile) THEN
            EXIT;
        MESSAGE(Text1100010,ToFile);
        */
        //ERASE(FileName);

    end;

    trigger OnPreReport()
    var
        RBMgt: Codeunit "File Management";
        TempString: Text[9];
        TempString1: Text[1];
        Declaracion349: Record UnknownRecord50015;
    begin
        if FiscalYear = '' then
          Error(Text1100000);
        CountryCode := 'ES';
        /*
        IF ContactName = '' THEN
          ERROR(Text1100001);
        IF ContactTelephone = '' THEN
          ERROR(Text1100002);
        TempString := ContactTelephone;
        IF STRLEN(TempString) > 0 THEN
          REPEAT
            TempString1 := COPYSTR(TempString,1,1);
            IF NOT (TempString1 IN ['0'..'9']) THEN
              ERROR(Text1100012);
            TempString := DELSTR(TempString,1,1);
          UNTIL STRLEN(TempString) = 0;
        IF DeclarationNum = '' THEN
          ERROR(Text1100003);
        IF CountryCode = '' THEN
          ERROR(Text1100004);
        */
        FileName := RBMgt.ServerTempFileName('txt');
        
        Clear(OutFile);
        OutFile.TextMode := true;
        OutFile.WriteMode := true;
        if OutFile.Open(FileName) then begin
          if not Confirm(Text1100014,false) then
            Error(Text1100011);
        
          OutFile.Create(FileName);
        end else
          OutFile.Create(FileName);
        OutFile.CreateOutstream(OutStr);
        
        /*
        IF ColumnGPPG = '' THEN
          MESSAGE(Text1100005)
        ELSE
          IF FilterString = '' THEN
            GetFilterStringFromColumnGPPG;
        */
        GetCompInfShipToCountryRegCode(CompInfShipToCountryRegCode);
        GetCompanyCountryRegCode(ReqFormCountryRegCode);
        CheckIfEULocations(AllLocationsAreEU);
        CVWarning349.Initialize(FiscalYear,GetPeriodAsText);
        EmptyVATRegNo := false;
        
        //AQ 16/01/2018
        CustVendWarning349.Reset;
        CustVendWarning349.DeleteAll;
        Declaracion349.Reset;
        Declaracion349.SetRange(Declaracion,FiscalYear);
        Declaracion349.SetRange(Period,Period);
        Declaracion349.DeleteAll;
        //FIN AQ

    end;

    var
        Text1100000: label 'Incorrect Fiscal Year.';
        Text1100001: label 'Contact name must be entered.';
        Text1100002: label 'Contact telephone must be entered.';
        Text1100003: label 'Receipt number must be entered.';
        CompanyInfo: Record "Company Information";
        CustEntries: Record "Cust. Ledger Entry";
        CustEntries2: Record "Cust. Ledger Entry";
        CustVendCountry: Record "Country/Region";
        VATInvSales: Record "VAT Entry";
        VATCredSales: Record "VAT Entry";
        VATInvPurch: Record "VAT Entry";
        VATCredPurch: Record "VAT Entry";
        Customer2: Record Customer;
        Vendor2: Record Vendor;
        CustVendWarning349: Record "Customer/Vendor Warning 349";
        CustVendWarning349_2: Record "Customer/Vendor Warning 349";
        TempSalesInvLines: Record "Sales Invoice Line" temporary;
        TempServiceInvLines: Record "Service Invoice Line" temporary;
        TempPurchInvLines: Record "Purch. Inv. Line" temporary;
        VATPostingSetup: Record "VAT Posting Setup";
        OutFile: File;
        CVWarning349: Page "Customer/Vendor Warnings 349";
        FiscalYear: Code[4];
        RectFiscalYear: Code[4];
        FiscalYear2: Code[2];
        RectPeriod: Code[2];
        ContactTelephone: Code[9];
        CountryCode: Code[10];
        OperationCode: array [3] of Code[1];
        NormalAmount: Decimal;
        NoOfCorrections: Decimal;
        TotalAmtShip: Decimal;
        TotalAmtReciv: Decimal;
        AmountOpTri: Decimal;
        TotalCorreAmt: Decimal;
        PrevDeclAmount: Decimal;
        RectAmount: Decimal;
        AccumPrevDeclAmount: Decimal;
        AccumOrigDeclAmount: Decimal;
        AmountToIncludein349: Decimal;
        Txt: Text[500];
        VatRegNo: Text[9];
        FileName: Text;
        OpTriang: Text[1];
        Sign: Text[1];
        CustVendVatRegNo: Text[20];
        ContactName: Text[40];
        TextAmount: Text[13];
        TextAmount2: Text[13];
        TextOpAmount: Text[15];
        TextCorreAmount: Text[15];
        DeclarationNum: Text[13];
        ColumnGPPG: Text[1024];
        FilterString: Text[1024];
        DeclarationMT: Text[1];
        PreVATRegNo: Text[20];
        ToFile: Text[1024];
        NumFiscalYear: Integer;
        NoOfRectShips: Integer;
        NoOfRectReciv: Integer;
        NoOperations: Integer;
        Period: Option "0A","01","02","03","04","05","06","07","08","09","10","11","12","1T","2T","3T","4T";
        DeclarationMediaType: Option "Physical support",Telematic;
        FromDate: Date;
        ToDate: Date;
        Text1100004: label 'Company Country/Region must be entered.';
        Text1100005: label 'Please be aware that this file will contain posted entries of services transactions of EU Customers/Vendors if you did not fill \"Excluding Gen. Prod. Posting Groups" field.';
        Text1100006: label 'Path to export 349 file.';
        Text1100007: label 'Lenght should be 13 digits for Declaration Number.';
        Text1100008: label 'One or more Credit Memos were found for the specified period. \You can select the ones that require a correction entry in current declaration and specify the correction amount for them. \Would you like to specify these corrections?';
        Text1100009: label 'No correction will be included in this declaration.';
        Text1100010: label '349 Declaration has been exported successfully under %1.';
        AlreadyExported: Boolean;
        Text1100011: label 'The process has been aborted. No file will be generated.';
        CompInfShipToCountryRegCode: Boolean;
        ReqFormCountryRegCode: Boolean;
        AllLocationsAreEU: Boolean;
        Text1100012: label 'Telephone Number must be 9 digits without spaces or special characters.';
        Text1100013: label 'The report is empty. File generation has been cancelled.';
        Text1100014: label 'The file already exists, do you want to replace it?';
        Text1100015: label 'At least one %1/%2 does not have any value in the %3 field. \Only Customers/Vendors with a value for %3 will be included in the file. \Do you still want to create the 349 Declaration file?';
        EmptyVATRegNo: Boolean;
        LocationDiffCountryCode: Boolean;
        Text1100016: label 'Default';
        Text1100017: label 'Txt Files|*.txt|All Files|*.*''';
        OutStr: OutStream;
        PeriodFreqChange: Boolean;
        PeriodChangeText: Text[1];
        AmountEUService: Decimal;
        NumPeriod: Integer;
        AccumPrevDeclAmountEUService: Decimal;
        AccumPrevDeclAmountTri: Decimal;
        AccumOrigDeclAmountEUService: Decimal;
        AccumOrigDeclAmountTri: Decimal;
        CorrIncludedForNormalAmount: Boolean;
        CorrIncludedForOpTriAmount: Boolean;
        CorrIncludedForEUServiceAmount: Boolean;
        EUServiceAlreadyExported: Boolean;
        ThirdPartyAlreadyExported: Boolean;
        [InDataSet]
        PeriodFrequencyChangeEnable: Boolean;
        NoTaxableAmountOpTri: Decimal;
        NoTaxableAmountEUService: Decimal;
        Idx: Option ,E,M,H;
        ReportFileName: Text[250];
        Window: Dialog;
        i: Integer;


    procedure FormatTextAmt(Amount: Decimal): Text[15]
    var
        TextAmt: Text[15];
    begin
        TextAmt := Format(Amount,0,'<Precision,2:2><Integer><Decimals>');
        TextAmt := DelChr(TextAmt,'=','.,');
        while StrLen(TextAmt) < 15 do
          TextAmt := '0' + TextAmt;
        exit(TextAmt);
    end;


    procedure IncludeIn349(VATEntry: Record "VAT Entry";var AmountIn349: Decimal;var LocationDifferentCountryCode: Boolean): Boolean
    var
        EUCountryInLocCodeHeader: Boolean;
        EUCountryInLocCodeLines: Boolean;
        VATEntryEUCountryRegCode: Boolean;
    begin
        AmountIn349 := 0;
        VATEntryEUCountryRegCode := FindEUCountryRegionCode(VATEntry."Country/Region Code");
        if VATEntryEUCountryRegCode then begin
          if CompInfShipToCountryRegCode then begin
            if AllLocationsAreEU then
              exit(true);

            GetPostedCountryLocCode(VATEntry."Document No.",VATEntry,AmountIn349,CompInfShipToCountryRegCode,
              EUCountryInLocCodeHeader,EUCountryInLocCodeLines,LocationDifferentCountryCode,VATEntry."VAT Prod. Posting Group");
            if EUCountryInLocCodeHeader or EUCountryInLocCodeLines then
              exit(true);
          end else begin
            GetPostedCountryLocCode(VATEntry."Document No.",VATEntry,AmountIn349,CompInfShipToCountryRegCode,
              EUCountryInLocCodeHeader,EUCountryInLocCodeLines,LocationDifferentCountryCode,VATEntry."VAT Prod. Posting Group");
            if EUCountryInLocCodeHeader or EUCountryInLocCodeLines then
              exit(true);
          end;
        end;
    end;


    procedure FindEUCountryRegionCode(CountryCode: Code[10]): Boolean
    var
        Country: Record "Country/Region";
    begin
        if Country.Get(CountryCode) then
          if Country."EU Country/Region Code" <> '' then
            exit(true)
          else
            exit(false)
        else
          exit(false);
    end;


    procedure GetCompInfShipToCountryRegCode(var CInfoShipToCountryRegCode: Boolean)
    var
        CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.Get;
        CInfoShipToCountryRegCode := FindEUCountryRegionCode(CompanyInfo."Ship-to Country/Region Code");
    end;


    procedure GetCompanyCountryRegCode(var EUCountryRegCode: Boolean)
    begin
        EUCountryRegCode := FindEUCountryRegionCode(CountryCode);
    end;


    procedure GetPostedCountryLocCode(DocNo: Code[20];VATEntry: Record "VAT Entry";var AmountToIncludeIn349: Decimal;CompInforShipToCountryCode: Boolean;var EUCountryHeaderLocationCode: Boolean;var EUCountryLinesLocationCode: Boolean;var LocationDifferentCountryCode: Boolean;VATPPG: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvLines: Record "Sales Invoice Line";
        ServiceInvHeader: Record "Service Invoice Header";
        ServiceInvLines: Record "Service Invoice Line";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLines: Record "Purch. Inv. Line";
        Location: Record Location;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ServiceCrMemoHeader: Record "Service Cr.Memo Header";
        ServiceCrMemoLine: Record "Service Cr.Memo Line";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        CustLedgeEntry: Record "Cust. Ledger Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
    begin
        EUCountryHeaderLocationCode := false;
        EUCountryLinesLocationCode := false;
        LocationDifferentCountryCode := false;
        AmountToIncludeIn349 := 0;
        case VATEntry.Type of
          VATEntry.Type::Sale:
            case VATEntry."Document Type" of
              VATEntry."document type"::Invoice:
                begin
                  SourceCodeSetup.Get;
                  if VATEntry."Source Code" = SourceCodeSetup.Sales then begin
                    if SalesInvHeader.Get(DocNo) then begin
                      if SalesInvHeader."Location Code" <> '' then begin
                        if Location.Get(SalesInvHeader."Location Code") then begin
                          EUCountryHeaderLocationCode := FindEUCountryRegionCode(Location."Country/Region Code");
                          if EUCountryHeaderLocationCode and
                             (GetCountryfromLocation(SalesInvHeader."Location Code") <> CountryCode)
                          then
                            LocationDifferentCountryCode := true;
                        end;
                      end else begin
                        TempSalesInvLines.SetRange("Document No.",DocNo);
                        TempSalesInvLines.SetRange("Gen. Prod. Posting Group",VATEntry."Gen. Prod. Posting Group");
                        TempSalesInvLines.SetRange("VAT Prod. Posting Group",VATPPG);
                        if not TempSalesInvLines.FindFirst then begin
                          SalesInvLines.SetRange("Document No.",DocNo);
                          SalesInvLines.SetRange("Gen. Prod. Posting Group",VATEntry."Gen. Prod. Posting Group");
                          SalesInvLines.SetRange("VAT Prod. Posting Group",VATPPG);
                          if SalesInvLines.FindSet then
                            repeat
                              if SalesInvLines."Location Code" <> '' then begin
                                if Location.Get(SalesInvLines."Location Code") then
                                  EUCountryLinesLocationCode := FindEUCountryRegionCode(Location."Country/Region Code");
                                if EUCountryLinesLocationCode then begin
                                  AmountToIncludeIn349 +=
                                    GetExportedAmountIn349(SalesInvHeader."Currency Code",
                                    SalesInvHeader."Currency Factor",SalesInvLines."Line Amount");
                                  if GetCountryfromLocation(SalesInvLines."Location Code") <> CountryCode then
                                    LocationDifferentCountryCode := true;
                                  TempSalesInvLines := SalesInvLines;
                                  TempSalesInvLines.Insert;
                                end;
                              end else
                                if CompInforShipToCountryCode then begin
                                  EUCountryLinesLocationCode := true;
                                  AmountToIncludeIn349 +=
                                    GetExportedAmountIn349(SalesInvHeader."Currency Code",
                                    SalesInvHeader."Currency Factor",SalesInvLines."Line Amount");
                                  TempSalesInvLines := SalesInvLines;
                                  TempSalesInvLines.Insert;
                                end;
                            until SalesInvLines.Next = 0;
                        end;
                      end;
                    end;
                  end else begin
                    if ServiceInvHeader.Get(DocNo) then begin
                      if ServiceInvHeader."Location Code" <> '' then begin
                        if Location.Get(ServiceInvHeader."Location Code") then begin
                          EUCountryHeaderLocationCode := FindEUCountryRegionCode(Location."Country/Region Code");
                          if EUCountryHeaderLocationCode and
                             (GetCountryfromLocation(ServiceInvHeader."Location Code") <> CountryCode)
                          then
                            LocationDifferentCountryCode := true;
                        end;
                      end else begin
                        TempServiceInvLines.SetRange("Document No.",DocNo);
                        TempServiceInvLines.SetRange("Gen. Prod. Posting Group",VATEntry."Gen. Prod. Posting Group");
                        TempServiceInvLines.SetRange("VAT Prod. Posting Group",VATPPG);
                        if not TempServiceInvLines.FindFirst then begin
                          ServiceInvLines.SetRange("Document No.",DocNo);
                          ServiceInvLines.SetRange("Gen. Prod. Posting Group",VATEntry."Gen. Prod. Posting Group");
                          ServiceInvLines.SetRange("VAT Prod. Posting Group",VATPPG);
                          if ServiceInvLines.FindSet then
                            repeat
                              if ServiceInvLines."Location Code" <> '' then begin
                                if Location.Get(ServiceInvLines."Location Code") then
                                  EUCountryLinesLocationCode := FindEUCountryRegionCode(Location."Country/Region Code");
                                if EUCountryLinesLocationCode then begin
                                  AmountToIncludeIn349 := AmountToIncludeIn349 + ServiceInvLines.Amount;
                                  if GetCountryfromLocation(ServiceInvLines."Location Code") <> CountryCode then
                                    LocationDifferentCountryCode := true;
                                  TempServiceInvLines := ServiceInvLines;
                                  TempServiceInvLines.Insert;
                                end;
                              end else
                                if CompInforShipToCountryCode then begin
                                  EUCountryLinesLocationCode := true;
                                  AmountToIncludeIn349 := AmountToIncludeIn349 + ServiceInvLines.Amount;
                                  TempServiceInvLines := ServiceInvLines;
                                  TempServiceInvLines.Insert;
                                end;
                            until ServiceInvLines.Next = 0;
                        end;
                      end;
                    end else
                      GetSalesEntryPostedByJournal(
                        VATEntry."Gen. Prod. Posting Group",VATPPG,DocNo,AmountToIncludeIn349,
                        EUCountryLinesLocationCode,CompInforShipToCountryCode);
                  end;
                  AmountToIncludeIn349 := -AmountToIncludeIn349;
                end;
              VATEntry."document type"::"Credit Memo":
                begin
                  SourceCodeSetup.Get;
                  if VATEntry."Source Code" = SourceCodeSetup.Sales then begin
                    if SalesCrMemoHeader.Get(DocNo) then begin
                      if SalesCrMemoHeader."Location Code" <> '' then begin
                        if Location.Get(SalesCrMemoHeader."Location Code") then begin
                          EUCountryHeaderLocationCode := FindEUCountryRegionCode(Location."Country/Region Code");
                          if EUCountryHeaderLocationCode and
                             (GetCountryfromLocation(SalesCrMemoHeader."Location Code") <> CountryCode)
                          then
                            LocationDifferentCountryCode := true;
                        end;
                      end else begin
                        SalesCrMemoLine.SetRange("Document No.",DocNo);
                        SalesCrMemoLine.SetRange("Gen. Prod. Posting Group",VATEntry."Gen. Prod. Posting Group");
                        SalesCrMemoLine.SetRange("VAT Prod. Posting Group",VATPPG);
                        if SalesCrMemoLine.Find('-') then
                          repeat
                            if SalesCrMemoLine."Location Code" <> '' then begin
                              if Location.Get(SalesCrMemoLine."Location Code") then begin
                                EUCountryLinesLocationCode := FindEUCountryRegionCode(Location."Country/Region Code");
                                if EUCountryLinesLocationCode and
                                   (GetCountryfromLocation(SalesCrMemoLine."Location Code") <> CountryCode)
                                then
                                  LocationDifferentCountryCode := true;
                              end;
                            end else
                              if CompInforShipToCountryCode then
                                EUCountryLinesLocationCode := true;
                          until SalesCrMemoLine.Next = 0;
                      end;
                    end;
                  end else begin
                    if ServiceCrMemoHeader.Get(DocNo) then begin
                      if ServiceCrMemoHeader."Location Code" <> '' then begin
                        if Location.Get(ServiceCrMemoHeader."Location Code") then begin
                          EUCountryHeaderLocationCode := FindEUCountryRegionCode(Location."Country/Region Code");
                          if EUCountryHeaderLocationCode and
                             (GetCountryfromLocation(ServiceCrMemoHeader."Location Code") <> CountryCode)
                          then
                            LocationDifferentCountryCode := true;
                        end;
                      end else begin
                        ServiceCrMemoLine.SetRange("Document No.",DocNo);
                        ServiceCrMemoLine.SetRange("Gen. Prod. Posting Group",VATEntry."Gen. Prod. Posting Group");
                        ServiceCrMemoLine.SetRange("VAT Prod. Posting Group",VATPPG);
                        if ServiceCrMemoLine.Find('-') then
                          repeat
                            if ServiceCrMemoLine."Location Code" <> '' then begin
                              if Location.Get(ServiceCrMemoLine."Location Code") then begin
                                EUCountryLinesLocationCode := FindEUCountryRegionCode(Location."Country/Region Code");
                                if EUCountryLinesLocationCode and
                                   (GetCountryfromLocation(ServiceCrMemoLine."Location Code") <> CountryCode)
                                then
                                  LocationDifferentCountryCode := true;
                              end;
                            end else
                              if CompInforShipToCountryCode then
                                EUCountryLinesLocationCode := true;
                          until ServiceCrMemoLine.Next = 0;
                      end;
                    end else begin
                      CustLedgeEntry.SetFilter("Journal Batch Name",'<>%1','');
                      CustLedgeEntry.SetRange("Document No.",DocNo);
                      CustLedgeEntry.SetRange("Document Type",CustLedgeEntry."document type"::"Credit Memo");
                      EUCountryLinesLocationCode := (not CustLedgeEntry.IsEmpty) and CompInforShipToCountryCode;
                    end;
                  end;
                end;
            end;
          VATEntry.Type::Purchase:
            case VATEntry."Document Type" of
              VATEntry."document type"::Invoice:
                begin
                  if PurchInvHeader.Get(DocNo) then begin
                    if PurchInvHeader."Location Code" <> '' then begin
                      if Location.Get(PurchInvHeader."Location Code") then begin
                        EUCountryHeaderLocationCode := FindEUCountryRegionCode(Location."Country/Region Code");
                        if EUCountryHeaderLocationCode and
                           (GetCountryfromLocation(PurchInvHeader."Location Code") <> CountryCode)
                        then
                          LocationDifferentCountryCode := true;
                      end;
                    end else begin
                      TempPurchInvLines.SetRange("Document No.",DocNo);
                      TempPurchInvLines.SetRange("Gen. Prod. Posting Group",VATEntry."Gen. Prod. Posting Group");
                      TempPurchInvLines.SetRange("VAT Prod. Posting Group",VATPPG);
                      if not TempPurchInvLines.FindFirst then begin
                        PurchInvLines.SetRange("Document No.",DocNo);
                        PurchInvLines.SetRange("Gen. Prod. Posting Group",VATEntry."Gen. Prod. Posting Group");
                        PurchInvLines.SetRange("VAT Prod. Posting Group",VATPPG);
                        if PurchInvLines.FindSet then
                          repeat
                            if PurchInvLines."Location Code" <> '' then begin
                              if Location.Get(PurchInvLines."Location Code") then
                                EUCountryLinesLocationCode := FindEUCountryRegionCode(Location."Country/Region Code");
                              if EUCountryLinesLocationCode then begin
                                AmountToIncludeIn349 +=
                                  GetExportedAmountIn349(PurchInvHeader."Currency Code",
                                  PurchInvHeader."Currency Factor",PurchInvLines."Line Amount");
                                if GetCountryfromLocation(PurchInvLines."Location Code") <> CountryCode then
                                  LocationDifferentCountryCode := true;
                                TempPurchInvLines := PurchInvLines;
                                TempPurchInvLines.Insert;
                              end;
                            end else
                              if CompInforShipToCountryCode then begin
                                EUCountryLinesLocationCode := true;
                                AmountToIncludeIn349 +=
                                  GetExportedAmountIn349(PurchInvHeader."Currency Code",
                                  PurchInvHeader."Currency Factor",PurchInvLines."Line Amount");
                                TempPurchInvLines := PurchInvLines;
                                TempPurchInvLines.Insert;
                              end;
                          until PurchInvLines.Next = 0;
                      end;
                    end;
                  end else
                    GetPurchEntryPostedByJournal(
                      VATEntry."Gen. Prod. Posting Group",VATPPG,DocNo,AmountToIncludeIn349,
                      EUCountryLinesLocationCode,CompInforShipToCountryCode);
                end;
              VATEntry."document type"::"Credit Memo":
                begin
                  if PurchCrMemoHdr.Get(DocNo) then begin
                    if PurchCrMemoHdr."Location Code" <> '' then begin
                      if Location.Get(PurchCrMemoHdr."Location Code") then begin
                        EUCountryHeaderLocationCode := FindEUCountryRegionCode(Location."Country/Region Code");
                        if EUCountryHeaderLocationCode and
                           (GetCountryfromLocation(PurchCrMemoHdr."Location Code") <> CountryCode)
                        then
                          LocationDifferentCountryCode := true;
                      end;
                    end else begin
                      PurchCrMemoLine.SetRange("Document No.",DocNo);
                      PurchCrMemoLine.SetRange("Gen. Prod. Posting Group",VATEntry."Gen. Prod. Posting Group");
                      PurchCrMemoLine.SetRange("VAT Prod. Posting Group",VATPPG);
                      if PurchCrMemoLine.Find('-') then
                        repeat
                          if PurchCrMemoLine."Location Code" <> '' then begin
                            if Location.Get(PurchCrMemoLine."Location Code") then begin
                              EUCountryLinesLocationCode := FindEUCountryRegionCode(Location."Country/Region Code");
                              if EUCountryLinesLocationCode and
                                 (GetCountryfromLocation(PurchCrMemoLine."Location Code") <> CountryCode)
                              then
                                LocationDifferentCountryCode := true;
                            end;
                          end else
                            if CompInforShipToCountryCode then
                              EUCountryLinesLocationCode := true;
                        until PurchCrMemoLine.Next = 0;
                    end;
                  end else begin
                    VendLedgerEntry.SetFilter("Journal Batch Name",'<>%1','');
                    VendLedgerEntry.SetRange("Document No.",DocNo);
                    VendLedgerEntry.SetRange("Document Type",VendLedgerEntry."document type"::"Credit Memo");
                    EUCountryLinesLocationCode := (not VendLedgerEntry.IsEmpty) and CompInforShipToCountryCode;
                  end;
                end;
            end;
        end;
    end;


    procedure CheckIfEULocations(var EULocations: Boolean)
    var
        Location: Record Location;
        EULoc: Boolean;
    begin
        EULocations := true;
        if Location.Find('-') then
          repeat
            EULoc := FindEUCountryRegionCode(Location."Country/Region Code");
            if not EULoc then
              EULocations := false;
          until Location.Next = 0;
    end;


    procedure GetFilterStringFromColumnGPPG()
    var
        GPPGCode: Text[1024];
        Position: Integer;
    begin
        GPPGCode := ColumnGPPG;
        repeat
          Position := StrPos(GPPGCode,';');
          if GPPGCode <> '' then begin
            if Position <> 0 then begin
              FilterString := FilterString + '<>' + CopyStr(GPPGCode,1,Position - 1);
              GPPGCode := CopyStr(GPPGCode,Position + 1);
            end else begin
              FilterString := FilterString + '<>' + CopyStr(GPPGCode,1);
              GPPGCode := '';
            end;
            if GPPGCode <> '' then
              FilterString := FilterString + '&';
          end;
        until GPPGCode = '';
    end;


    procedure GetCountryfromLocation("Code": Code[10]): Code[10]
    var
        Location: Record Location;
    begin
        Location.Get(Code);
        exit(Location."Country/Region Code");
    end;


    procedure UpdateRequestForm()
    begin
        PageUpdateRequestForm;
    end;

    local procedure PageUpdateRequestForm()
    begin
        PeriodFrequencyChangeEnable := Period in [Period::"02",Period::"05",Period::"08",Period::"11"];
    end;

    local procedure SummarizeBaseAmount(VATEntry: Record "VAT Entry";AmountToIncludein349: Decimal;var Amount: array [3] of Decimal)
    var
        IncAmount: Decimal;
    begin
        if AmountToIncludein349 <> 0 then
          IncAmount := AmountToIncludein349
        else
          IncAmount := VATEntry.Base;

        Amount[MapDeliveryOperationCode(VATEntry."Delivery Operation Code")] += IncAmount;
    end;

    local procedure SummarizeNonTaxableNormalAmount(var NoTaxableAmount: array [3] of Decimal;NoTaxableAmountIncrement: Decimal;VATProdPostGroupCode: Code[20])
    var
        VATProductPostingGroup: Record "VAT Product Posting Group";
    begin
        VATProductPostingGroup.Get(VATProdPostGroupCode);
        NoTaxableAmount[MapDeliveryOperationCode(VATProductPostingGroup."Delivery Operation Code")] += NoTaxableAmountIncrement;
    end;

    local procedure MapDeliveryOperationCode(DeliveryOperationCode: Option " ","E - General","M - Imported Tax Exempt","H - Imported Tax Exempt (Representative)"): Integer
    begin
        if DeliveryOperationCode = Deliveryoperationcode::" " then
          exit(Deliveryoperationcode::"E - General");
        exit(DeliveryOperationCode);
    end;


    procedure InitializeRequest(ReportTempFileName: Text[250])
    begin
        ReportFileName := ReportTempFileName;
    end;

    local procedure GetExportedAmountIn349(CurrencyCode: Code[20];CurrencyFactor: Decimal;LineAmount: Decimal): Decimal
    var
        Currency: Record Currency;
    begin
        if CurrencyCode <> '' then begin
          Currency.Get(CurrencyCode);
          exit(ROUND(LineAmount / CurrencyFactor,Currency."Amount Rounding Precision"))
        end;
        exit(LineAmount);
    end;

    local procedure GetSalesEntryPostedByJournal(GenProdPostingGroup: Code[20];VATPPG: Code[20];DocNo: Code[20];var AmountToIncludeIn349: Decimal;var EUCountryLinesLocationCode: Boolean;CompInforShipToCountryCode: Boolean)
    var
        CustLedgeEntry: Record "Cust. Ledger Entry";
    begin
        with CustLedgeEntry do begin
          SetFilter("Journal Batch Name",'<>%1','');
          SetRange("Document No.",DocNo);
          SetRange("Document Type","document type"::Invoice);
          if FindFirst and CompInforShipToCountryCode then begin
            CalcFields("Amount (LCY)");
            AmountToIncludeIn349 := "Amount (LCY)";
            EUCountryLinesLocationCode := true;
          end;
        end;
    end;

    local procedure GetPurchEntryPostedByJournal(GenProdPostingGroup: Code[20];VATPPG: Code[20];DocNo: Code[20];var AmountToIncludeIn349: Decimal;var EUCountryLinesLocationCode: Boolean;CompInforShipToCountryCode: Boolean)
    var
        VendLedgerEntry: Record "Vendor Ledger Entry";
    begin
        with VendLedgerEntry do begin
          SetFilter("Journal Batch Name",'<>%1','');
          SetRange("Document No.",DocNo);
          SetRange("Document Type",VendLedgerEntry."document type"::Invoice);
          if FindFirst and CompInforShipToCountryCode then begin
            CalcFields("Amount (LCY)");
            AmountToIncludeIn349 := Abs("Amount (LCY)");
            EUCountryLinesLocationCode := true;
          end;
        end;
    end;

    local procedure GetTotalCreditMemoAmt(): Decimal
    var
        CustVendWarning349: Record "Customer/Vendor Warning 349";
        VATEntry: Record "VAT Entry";
        TotalAmount: array [3] of Decimal;
    begin
        FilterCustVendWarning349(CustVendWarning349,CustVendWarning349.Type::Sale,Customer2."No.");
        if CustVendWarning349.FindSet then begin
          repeat
            if Customer2."VAT Registration No." <> '' then begin
              if CustVendWarning349."VAT Entry No." = 0 then
                VATEntry.Init
              else
                VATEntry.Get(CustVendWarning349."VAT Entry No.");
              if not VATEntry.IsCorrectiveCrMemoDiffPeriod then
                SummarizeBaseAmount(VATEntry,CustVendWarning349."Original Declared Amount",TotalAmount)
            end;
          until CustVendWarning349.Next = 0;
          exit(TotalAmount[1]);
        end;
    end;

    local procedure GetTotalPurchCreditMemoAmt(): Decimal
    var
        CustVendWarning349: Record "Customer/Vendor Warning 349";
        VATEntry: Record "VAT Entry";
        TotalAmount: Decimal;
    begin
        FilterCustVendWarning349(CustVendWarning349,CustVendWarning349.Type::Purchase,Vendor2."No.");
        if CustVendWarning349.FindSet then begin
          repeat
            if Vendor2."VAT Registration No." <> '' then begin
              TotalAmount += Abs(CustVendWarning349."Original Declared Amount");
            end;
          until CustVendWarning349.Next = 0;
          exit(TotalAmount);
        end;
    end;

    local procedure CalcVendDeclarationPeriodInfo(DocType: Option;DocNo: Code[20];VendNo: Code[20])
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        AppliedVendLedgEntry: Record "Vendor Ledger Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    begin
        VendLedgEntry.SetRange("Document Type",DocType);
        VendLedgEntry.SetRange("Document No.",DocNo);
        VendLedgEntry.SetRange("Vendor No.",VendNo);
        VendLedgEntry.FindFirst;
        /*IF (VendLedgEntry."Applies-to Doc. Type" IN
            [VendLedgEntry."Applies-to Doc. Type"::Invoice,VendLedgEntry."Applies-to Doc. Type"::Reminder]) AND
           (VendLedgEntry."Closed by Entry No." <> 0) AND
           AppliedVendLedgEntry.GET(VendLedgEntry."Closed by Entry No.")
        THEN
          RectFiscalYear := FORMAT(DATE2DMY(AppliedVendLedgEntry."Posting Date",3))
        ELSE
          RectFiscalYear := FORMAT(DATE2DMY(VendLedgEntry."Posting Date",3));
        */
        RectFiscalYear := '';
        RectPeriod := '';
        
        if PurchCrMemoHdr.Get(DocNo) then
          if PurchCrMemoHdr."Corrected Invoice No." <> '' then
            if PurchInvHeader.Get(PurchCrMemoHdr."Corrected Invoice No.") then
                RectFiscalYear := Format(Date2dmy(PurchInvHeader."Posting Date",3))
              else
                RectFiscalYear := Format(Date2dmy(VendLedgEntry."Posting Date",3));
        
        if RectFiscalYear = '' then
          RectFiscalYear := FiscalYear;
        
        if RectPeriod = '' then
          RectPeriod := GetPeriodAsText;

    end;

    local procedure CalcCustDeclarationPeriodInfo(DocType: Option;DocNo: Code[20];CustNo: Code[20])
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        CustEntries.SetRange("Document Type",DocType);
        CustEntries.SetRange("Document No.",DocNo);
        CustEntries.SetRange("Customer No.",CustNo);
        CustEntries.FindFirst;
        /*
        IF (CustEntries."Applies-to Doc. Type" IN
            [CustEntries."Applies-to Doc. Type"::Invoice,CustEntries."Applies-to Doc. Type"::Reminder]) AND
           (CustEntries."Closed by Entry No." <> 0) AND
           CustEntries2.GET(CustEntries."Closed by Entry No.")
        THEN
          RectFiscalYear := FORMAT(DATE2DMY(CustEntries2."Posting Date",3))
        ELSE
          RectFiscalYear := FORMAT(DATE2DMY(CustEntries."Posting Date",3));
        */
        RectFiscalYear := '';
        RectPeriod := '';
        if SalesCrMemoHeader.Get(DocNo) then
          if SalesCrMemoHeader."Corrected Invoice No." <> '' then
            if SalesInvoiceHeader.Get(SalesCrMemoHeader."Corrected Invoice No.") then begin
                RectFiscalYear := Format(Date2dmy(SalesInvoiceHeader."Posting Date",3));
                RectPeriod := Format(Date2dmy(SalesInvoiceHeader."Posting Date",2));
              end else begin
                RectFiscalYear := Format(Date2dmy(CustEntries."Posting Date",3));
                RectPeriod := Format(Date2dmy(CustEntries."Posting Date",2));
              end;
        
        
        if StrLen(RectPeriod) = 1 then
          RectPeriod := '0' + RectPeriod;
        
        if RectFiscalYear = '' then
          RectFiscalYear := FiscalYear;
        
        if RectPeriod = '' then
          RectPeriod := GetPeriodAsText;

    end;

    local procedure FilterCustVendWarning349(var CustVendWarning349: Record "Customer/Vendor Warning 349";docType: Option;No: Code[20])
    begin
        with CustVendWarning349 do begin
          SetRange(Type,docType);
          SetRange("Customer/Vendor No.",No);
          SetRange("Posting Date",FromDate,ToDate);
          SetRange("Include Correction",true);
        end;
    end;


    procedure GetPeriodAsText(): Code[2]
    var
        PeriodInt: Integer;
    begin
        if StrLen(Format(Period)) = 2 then
          exit(CopyStr(Format(Period),1,2));

        PeriodInt := Period;
        exit(Format(PeriodInt,2,'<Integer,2><Filler Character,0>'));
    end;

    local procedure GetVATInvPurchEntries(var VATEntry: Record "VAT Entry";BillToPayNo: Code[20];FromDate: Date;ToDate: Date;EUService: Boolean;GenProdPostingGroupFilter: Text)
    begin
        with VATEntry do begin
          Reset;
          SetRange(Type,Type::Purchase);
          SetRange("Document Type","document type"::Invoice);
          SetRange("Bill-to/Pay-to No.",BillToPayNo);
          SetRange("Posting Date",FromDate,ToDate);
          SetRange("EU Service",EUService);
          SetFilter("Gen. Prod. Posting Group",GenProdPostingGroupFilter);
        end;
    end;

    local procedure GetVATInvSalesEntries(var VATEntry: Record "VAT Entry";BillToPayNo: Code[20];FromDate: Date;ToDate: Date;EUService: Boolean;GenProdPostingGroupFilter: Text)
    begin
        with VATEntry do begin
          Reset;
          SetRange(Type,Type::Sale);
          SetRange("Document Type","document type"::Invoice);
          SetRange("Bill-to/Pay-to No.",BillToPayNo);
          SetRange("Posting Date",FromDate,ToDate);
          SetRange("EU Service",EUService);
          SetFilter("Gen. Prod. Posting Group",GenProdPostingGroupFilter);
        end;
    end;

    local procedure GetCustVendWarnings(var CustVendWarning349To: Record "Customer/Vendor Warning 349";var CustVendWarning349From: Record "Customer/Vendor Warning 349";IsExported: Boolean;EUService: Boolean)
    begin
        with CustVendWarning349To do begin
          Copy(CustVendWarning349);
          SetRange("Original Declaration FY",CustVendWarning349From."Original Declaration FY");
          SetRange("Original Declaration Period",CustVendWarning349From."Original Declaration Period");
          SetRange(Exported,IsExported);
          SetRange("EU Service",EUService);
        end;
    end;

    local procedure CombineEUCountryAndVATRegNo(CountryRegion: Record "Country/Region";VATRegistrationNo: Code[20]) CombinedVATRegNo: Text[17]
    begin
        if StrPos(VATRegistrationNo,CountryRegion."EU Country/Region Code") = 0 then
          VATRegistrationNo := CountryRegion."EU Country/Region Code" + VATRegistrationNo;

        CombinedVATRegNo :=
          Format(CountryRegion.GetVATRegistrationNoLimitedBySetup(VATRegistrationNo),MaxStrLen(CombinedVATRegNo));
    end;

    local procedure InsertVendWarning349(No: Code[20];Name: Text[50];PostingDate: Date;DocType: Option;DocNo: Code[20];EU3PartyTrade: Boolean;EUService: Boolean;PositiveBase: Boolean;VATEntryNo: Integer;DeliveryOperationCode: Option)
    var
        VATEntry: Record "VAT Entry";
    begin
        CalcVendDeclarationPeriodInfo(DocType,DocNo,No);
        
        /*
        IF CustVendWarning349.FINDLAST THEN;
        CustVendWarning349.INIT;
        CustVendWarning349."Entry No." := CustVendWarning349."Entry No." + 1;
        CustVendWarning349.Type := CustVendWarning349.Type::Purchase;
        CustVendWarning349."Customer/Vendor No." := No;
        CustVendWarning349."Customer/Vendor Name" := Name;
        CustVendWarning349."Posting Date" := PostingDate;
        CustVendWarning349."Document No." := DocNo;
        CustVendWarning349."EU 3-Party Trade" := EU3PartyTrade;
        CustVendWarning349."EU Service" := EUService;
        CustVendWarning349."Original Declaration FY" := RectFiscalYear;
        //CustVendWarning349."Original Declaration Period" := GetPeriodAsText;
        CustVendWarning349."Original Declaration Period" := RectPeriod;
        
        IF PositiveBase THEN
          CustVendWarning349.Sign := '-'
        ELSE
          CustVendWarning349.Sign := '+';
        CustVendWarning349.INSERT;
        */
        
        CustVendWarning349.Reset;
        CustVendWarning349.SetRange("Document No.",DocNo);
        if not CustVendWarning349.FindFirst then begin
          CustVendWarning349.Reset;
          if CustVendWarning349.FindLast then;
        
          CustVendWarning349.Init;
          CustVendWarning349."Entry No." := CustVendWarning349."Entry No." + 1;
          CustVendWarning349.Insert;
        end;
        
        CustVendWarning349.Type := CustVendWarning349.Type::Purchase;
        CustVendWarning349."Customer/Vendor No." := No;
        CustVendWarning349."Customer/Vendor Name" := Name;
        CustVendWarning349."Posting Date" := PostingDate;
        CustVendWarning349."Document No." := DocNo;
        CustVendWarning349."EU 3-Party Trade" := EU3PartyTrade;
        CustVendWarning349."EU Service" := EUService;
        CustVendWarning349."Original Declaration FY" := RectFiscalYear;
        //CustVendWarning349."Original Declaration Period" := GetPeriodAsText;
        CustVendWarning349."Original Declaration Period" := RectPeriod;
        CustVendWarning349."VAT Entry No." := VATEntryNo;
        CustVendWarning349."Delivery Operation Code" := DeliveryOperationCode;
        
        //AQ 16/01/18
        CustVendWarning349."Include Correction" := true;
        VATEntry.Get(VATEntryNo);
        CustVendWarning349.VAT := VATEntry."VAT Registration No.";
        CustVendWarning349.Importe += Abs(VATEntry.Base);
        //FIN AQ
        
        /*
        IF PositiveBase THEN
          CustVendWarning349.Sign := '-'
        ELSE
          CustVendWarning349.Sign := '+';
        */
        CustVendWarning349.Sign := '-';
        CustVendWarning349.Modify;
        
        //AQ 16/01/2018
        GrabaFichero349(1,NoOperations,CustVendWarning349.VAT,CustVendWarning349."Customer/Vendor Name",'I',0,'','',0,0);
        //FIN AQ

    end;

    local procedure InsertCustWarning349(No: Code[20];Name: Text[50];PostingDate: Date;DocType: Option;DocNo: Code[20];EU3PartyTrade: Boolean;EUService: Boolean;PositiveBase: Boolean;VATEntryNo: Integer;DeliveryOperationCode: Option)
    var
        VATEntry: Record "VAT Entry";
    begin
        CalcCustDeclarationPeriodInfo(DocType,DocNo,No);
        
        CustVendWarning349.Reset;
        CustVendWarning349.SetRange("Document No.",DocNo);
        if not CustVendWarning349.FindFirst then begin
          CustVendWarning349.Reset;
          if CustVendWarning349.FindLast then;
        
          CustVendWarning349.Init;
          CustVendWarning349."Entry No." := CustVendWarning349."Entry No." + 1;
          CustVendWarning349.Insert;
        end;
        
        CustVendWarning349.Type := CustVendWarning349.Type::Sale;
        CustVendWarning349."Customer/Vendor No." := No;
        CustVendWarning349."Customer/Vendor Name" := Name;
        CustVendWarning349."Posting Date" := PostingDate;
        CustVendWarning349."Document No." := DocNo;
        CustVendWarning349."EU 3-Party Trade" := EU3PartyTrade;
        CustVendWarning349."EU Service" := EUService;
        CustVendWarning349."Original Declaration FY" := RectFiscalYear;
        //CustVendWarning349."Original Declaration Period" := GetPeriodAsText;
        CustVendWarning349."Original Declaration Period" := RectPeriod;
        CustVendWarning349."VAT Entry No." := VATEntryNo;
        CustVendWarning349."Delivery Operation Code" := DeliveryOperationCode;
        
        //AQ 16/01/18
        CustVendWarning349."Include Correction" := true;
        VATEntry.Get(VATEntryNo);
        CustVendWarning349.VAT := VATEntry."VAT Registration No.";
        CustVendWarning349.Importe += VATEntry.Base;
        //FIN AQ
        
        /*
        IF PositiveBase THEN
          CustVendWarning349.Sign := '-'
        ELSE
          CustVendWarning349.Sign := '+';
        */
        CustVendWarning349.Sign := '-';
        CustVendWarning349.Modify;
        
        //AQ 16/01/2018
        GrabaFichero349(0,NoOperations,CustVendWarning349.VAT,CustVendWarning349."Customer/Vendor Name",'E',0,'','',0,0);
        //FIN AQ

    end;

    local procedure InsertCustWarningsFromSalesCrMemoLine()
    var
        SalesCrMemoHdr: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
        EUService: Boolean;
    begin
        SalesCrMemoLine.Reset;
        SalesCrMemoLine.SetRange("Bill-to Customer No.",Customer2."No.");
        SalesCrMemoLine.SetRange("Posting Date",FromDate,ToDate);
        SalesCrMemoLine.SetRange("VAT Calculation Type",SalesCrMemoLine."vat calculation type"::"No Taxable VAT");
        SalesCrMemoLine.SetFilter("Gen. Prod. Posting Group",FilterString);
        if SalesCrMemoLine.FindSet then begin
          SalesCrMemoHdr.Get(SalesCrMemoLine."Document No.");
          if SalesCrMemoHdr."Bill-to Country/Region Code" <> CompanyInfo."Country/Region Code" then
            repeat
              EUService := false;
              if VATPostingSetup.Get(SalesCrMemoLine."VAT Bus. Posting Group",SalesCrMemoLine."VAT Prod. Posting Group") then
                if VATPostingSetup."EU Service" then
                  EUService := true;
              InsertCustWarning349(
                Customer2."No.",Customer2.Name,SalesCrMemoHdr."Posting Date",
                CustLedgEntry."document type"::"Credit Memo",SalesCrMemoHdr."No.",SalesCrMemoHdr."EU 3-Party Trade",EUService,false,0,0);
            until SalesCrMemoLine.Next = 0;
        end;
    end;

    local procedure InsertVendWarningsFromPurchCrMemoLine()
    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        VendLedgEntry: Record "Vendor Ledger Entry";
        EUService: Boolean;
    begin
        PurchCrMemoLine.Reset;
        PurchCrMemoLine.SetRange("Pay-to Vendor No.",Vendor2."No.");
        PurchCrMemoLine.SetRange("Posting Date",FromDate,ToDate);
        PurchCrMemoLine.SetRange("VAT Calculation Type",PurchCrMemoLine."vat calculation type"::"No Taxable VAT");
        PurchCrMemoLine.SetFilter("Gen. Prod. Posting Group",FilterString);
        if PurchCrMemoLine.FindSet then begin
          PurchCrMemoHdr.Get(PurchCrMemoLine."Document No.");
          if PurchCrMemoHdr."Pay-to Country/Region Code" <> CompanyInfo."Country/Region Code" then
            repeat
              EUService := false;
              if VATPostingSetup.Get(PurchCrMemoLine."VAT Bus. Posting Group",PurchCrMemoLine."VAT Prod. Posting Group") then
                if VATPostingSetup."EU Service" then
                  EUService := true;

              InsertVendWarning349(
                Vendor2."No.",Vendor2.Name,PurchCrMemoHdr."Posting Date",
                VendLedgEntry."document type"::"Credit Memo",PurchCrMemoHdr."No.",false,EUService,false,0,0);
            until PurchCrMemoLine.Next = 0;
        end;
    end;

    local procedure CalcNoTaxableAmountFromSalesInvLine(var NoTaxableNormalAmountSales: array [3] of Decimal)
    var
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        if SalesInvLine.FindNoTaxableLines(Customer2."No.",FromDate,ToDate,FilterString) then
          repeat
            SalesInvHeader.Get(SalesInvLine."Document No.");
            if SalesInvHeader."Bill-to Country/Region Code" <> CompanyInfo."Country/Region Code" then
              if VATPostingSetup.Get(SalesInvLine."VAT Bus. Posting Group",SalesInvLine."VAT Prod. Posting Group") then
                if VATPostingSetup."EU Service" then
                  NoTaxableAmountEUService := NoTaxableAmountEUService + SalesInvLine."Line Amount"
                else
                  if SalesInvHeader."EU 3-Party Trade" then
                    NoTaxableAmountOpTri := NoTaxableAmountOpTri + SalesInvLine."Line Amount"
                  else
                    SummarizeNonTaxableNormalAmount(
                      NoTaxableNormalAmountSales,SalesInvLine."Line Amount",SalesInvLine."VAT Prod. Posting Group");
          until SalesInvLine.Next = 0;
    end;

    local procedure GrabaFichero349(Cliente_Proveedor: Option Cliente,Proveedor;NOperacion: Integer;LCustVendVatRegNo: Code[20];LCustomerName: Text[100];LOperationCode: Code[1];LAmount: Decimal;DeclaracionRect: Code[4];PeriodoRect: Code[2];ImporteOriginal: Decimal;ImporteActual: Decimal)
    var
        Declaracion349: Record UnknownRecord50015;
        VLinea: Integer;
    begin
        //GrabaFichero349(FiscalYear,VatRegNo,LCustVendVatRegNo,Customer2.Name,OperationCode[i],Amount[i]);
        Declaracion349.Reset;
        Declaracion349.SetRange(Declaracion,FiscalYear);
        Declaracion349.SetRange(Period,Period);
        Declaracion349.SetRange(Tipo,Cliente_Proveedor);
        Declaracion349.SetRange(CIF,LCustVendVatRegNo);
        if not Declaracion349.FindFirst then begin
          Declaracion349.SetRange(CIF);
          Declaracion349.SetRange(Tipo);
          if Declaracion349.FindLast then
            VLinea := Declaracion349.NLinea;

          VLinea += 1;

          Declaracion349.Init;
          Declaracion349.Declaracion := FiscalYear;
          Declaracion349.Period := Period;
          Declaracion349.NLinea := VLinea;
          Declaracion349.NOperacion := NOperacion;
          Declaracion349.Tipo := Cliente_Proveedor;
          Declaracion349.FiscalYear := FiscalYear;
          Declaracion349.VAT := VatRegNo;
          Declaracion349.CIF := LCustVendVatRegNo;
          Declaracion349.Nombre := PadStr(ConvertStr(UpperCase(LCustomerName),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ');
        //  Declaracion349.Nombre := COPYSTR(LCustomerName,1,40);
          Declaracion349.Operacion := LOperationCode;
          Declaracion349.Insert;
        end;

        Declaracion349.Facturas := LAmount;
        CustVendWarning349.Reset;
        CustVendWarning349.SetRange(VAT,LCustVendVatRegNo);
        CustVendWarning349.CalcSums(Importe);
        Declaracion349."Abonos del periodo" := CustVendWarning349.Importe;
        Declaracion349.Importe := Declaracion349.Facturas - Declaracion349."Abonos del periodo";
        // Declaracion349."Declaracion Rectificada" := DeclaracionRect;
        // Declaracion349."Period Rectificado" := PeriodoRect;
        // Declaracion349."Importe Original" := ImporteOriginal;
        // Declaracion349."Importe Actual" := ImporteActual;
        Declaracion349.Modify;
    end;
}

