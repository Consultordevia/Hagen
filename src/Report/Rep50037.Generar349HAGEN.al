#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50037 "Generar 349 HAGEN"
{
    Caption = 'Make 349 Declaration';
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
        }
        dataitem(Declaracion349;UnknownTable50015)
        {
            DataItemTableView = where(Registrada=const(No));
            column(ReportForNavId_1000000001; 1000000001)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Importe <> 0 then begin
                  TextAmount := CopyStr(FormatTextAmt(Importe),3,13);
                  Txt :=
                    '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') + PadStr(CIF,17,' ') + Nombre + Operacion +
                    ConvertStr(TextAmount,' ','0') + PadStr('',354,' ');
                  NoOperations := NoOperations + 1;
                  TotalAmtShip := TotalAmtShip + Importe;
                  OutFile.Write(Txt);
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetCurrentkey(CIF);
            end;
        }
        dataitem(Declaracion349Abonos;UnknownTable50015)
        {
            DataItemTableView = where(Registrada=const(No));
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            var
                CustomerVendorWarning349: Record "Customer/Vendor Warning 349";
            begin

                if "Abonos de otros periodos" <> 0 then begin
                  CustomerVendorWarning349.Reset;
                  CustomerVendorWarning349.SetRange(VAT,CIF);
                //  CustomerVendorWarning349.SETRANGE("Original Declaration Period",FORMAT(Period));
                //  CustomerVendorWarning349.SETRANGE("Original Declaration FY",FiscalYear);
                  if CustomerVendorWarning349.FindSet then
                    repeat
                      if (CustomerVendorWarning349."Original Declaration FY" <> FiscalYear) or
                         (CustomerVendorWarning349."Original Declaration Period" <> Format(Period)) then begin
                        TextAmount := CopyStr(FormatTextAmt(CustomerVendorWarning349."Previous Declared Amount"),3,13);
                        TextAmount2 := CopyStr(FormatTextAmt(CustomerVendorWarning349."Original Declared Amount"),3,13);

                        Txt :=
                          '2' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') + PadStr('',58,' ') + PadStr(CIF,17,' ') + Nombre + Operacion +
                          PadStr('',13,' ') + CustomerVendorWarning349."Original Declaration FY" +
                          CustomerVendorWarning349."Original Declaration Period" + TextAmount2 + TextAmount +
                          PadStr('',322,' ');
                        OutFile.Write(Txt);

                        NoOfCorrections += 1;
                        TotalCorreAmt := TotalCorreAmt + CustomerVendorWarning349."Original Declared Amount";
                      end;
                    until CustomerVendorWarning349.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                //SETRANGE(Declaracion,FiscalYear);
                //SETRANGE(Period,Period);
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
                        field(PeriodFrequencyChange;PeriodFreqChange)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Period Frequency Change';
                            Enabled = PeriodFrequencyChangeEnable;
                            ToolTip = 'Specifies the period frequency of the report.';
                        }
                        field(ContactName;ContactName)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Contact Name';
                            ToolTip = 'Specifies the name of the person making the declaration.';
                        }
                        field(TelephoneNumber;ContactTelephone)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Telephone Number';
                            Numeric = true;
                            ToolTip = 'Specifies the telephone number of the contact person.';

                            trigger OnValidate()
                            begin
                                if StrLen(ContactTelephone) < 9 then
                                  Error(Text1100012);
                            end;
                        }
                        field(DeclarationNumber;DeclarationNum)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Declaration Number';
                            Numeric = true;
                            ToolTip = 'Specifies a number to identify the operations declaration.';

                            trigger OnValidate()
                            begin
                                if StrLen(DeclarationNum) <> 13 then
                                  Error(Text1100007);
                            end;
                        }
                        field(CompanyCountryRegion;CountryCode)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Company Country/Region';
                            TableRelation = "Country/Region";
                            ToolTip = 'Specifies the country/region for your company.';

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                if Page.RunModal(10,"Country/Region") = Action::LookupOK then
                                  CountryCode := "Country/Region".Code;
                            end;
                        }
                        field(DeclarationMediaType;DeclarationMediaType)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Declaration Media Type';
                            OptionCaption = 'Physical support,Telematic';
                            ToolTip = 'Specifies the media type for the declaration. To submit the declaration electronically, select Telematic. To submit the declaration on a CD-ROM, select Physical support.';
                        }
                        field(ColumnGPPG;ColumnGPPG)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Excluded Gen. Product Posting Groups';
                            Editable = false;
                            ToolTip = 'Specifies the general product posting group that you do not want to include in the declaration.';

                            trigger OnAssistEdit()
                            var
                                GPPGSelectionBuf: Record "Gen. Prod. Post. Group Buffer";
                            begin
                                GPPGSelectionBuf.SetGPPGSelectionMultiple(ColumnGPPG,FilterString);
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
        if TotalAmtShip < 0 then
          TotalAmtShip := -TotalAmtShip;
        TextOpAmount := FormatTextAmt(TotalAmtShip + TotalAmtReciv);
        TextCorreAmount := FormatTextAmt(TotalCorreAmt);
        
        case DeclarationMediaType of
          Declarationmediatype::Telematic:
            DeclarationMT := 'T';
          Declarationmediatype::"Physical support":
            DeclarationMT := 'C';
        end;
        if PeriodFreqChange then
          PeriodChangeText := 'X'
        else
          PeriodChangeText := ' ';
        if (TextOpAmount <> PadStr('',15,'0')) or (TextCorreAmount <> PadStr('',15,'0')) then begin
          Txt :=
            '1' + '349' + FiscalYear + PadStr(VatRegNo,9,' ') +
            PadStr(ConvertStr(UpperCase(CompanyInfo.Name),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') + DeclarationMT +
            ConvertStr(Format(ContactTelephone,9),' ','0') +
            PadStr(ConvertStr(UpperCase(ContactName),'ÁÀÉÈÍÌÓÒÚÙÑÜÇ()"&´Ö+','AAEEIIOOUUÐUÃ     O '),40,' ') +
            DeclarationNum +
            '  ' + PadStr('',13,'0') + GetPeriodAsText +
            ConvertStr(Format(NoOperations,9),' ','0') + ConvertStr(TextOpAmount,' ','0') +
            ConvertStr(Format(NoOfCorrections,9),' ','0') + ConvertStr(TextCorreAmount,' ','0') +
            PeriodChangeText + PadStr('',314,' ');
        
          OutFile.SEEK(0);
          OutStr.WriteText(Txt);
          OutFile.Close;
        end else begin
          OutFile.Close;
          Erase(FileName);
          Message(Text1100013);
        end;
        
        /*
        CustVendWarning349.RESET;
        CustVendWarning349.DELETEALL;
        */
        ToFile := Text1100016 + '.txt';
        if ReportFileName <> '' then
          FileManagement.CopyServerFile(FileName,ReportFileName,true)
        else
          if not Download(FileName,Text1100006,'',Text1100017,ToFile) then
            exit;
        Message(Text1100010,ToFile);

    end;

    trigger OnPreReport()
    var
        RBMgt: Codeunit "File Management";
        TempString: Text[9];
        TempString1: Text[1];
    begin
        if FiscalYear = '' then
          Error(Text1100000);
        if ContactName = '' then
          Error(Text1100001);
        if ContactTelephone = '' then
          Error(Text1100002);
        TempString := ContactTelephone;
        if StrLen(TempString) > 0 then
          repeat
            TempString1 := CopyStr(TempString,1,1);
            if not (TempString1 in ['0'..'9']) then
              Error(Text1100012);
            TempString := DelStr(TempString,1,1);
          until StrLen(TempString) = 0;
        if DeclarationNum = '' then
          Error(Text1100003);
        if CountryCode = '' then
          Error(Text1100004);
        
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
        "Country/Region": Record "Country/Region";


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
    end;

    local procedure CombineEUCountryAndVATRegNo(CountryRegion: Record "Country/Region";VATRegistrationNo: Code[20]) CombinedVATRegNo: Text[17]
    begin
        if StrPos(VATRegistrationNo,CountryRegion."EU Country/Region Code") = 0 then
          VATRegistrationNo := CountryRegion."EU Country/Region Code" + VATRegistrationNo;

        CombinedVATRegNo :=
          Format(CountryRegion.GetVATRegistrationNoLimitedBySetup(VATRegistrationNo),MaxStrLen(CombinedVATRegNo));
    end;

    local procedure InsertVendWarning349(No: Code[20];Name: Text[50];PostingDate: Date;DocType: Option;DocNo: Code[20];EU3PartyTrade: Boolean;EUService: Boolean;PositiveBase: Boolean)
    begin
    end;

    local procedure InsertCustWarning349(No: Code[20];Name: Text[50];PostingDate: Date;DocType: Option;DocNo: Code[20];EU3PartyTrade: Boolean;EUService: Boolean;PositiveBase: Boolean;VATEntryNo: Integer;DeliveryOperationCode: Option)
    begin
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
                VendLedgEntry."document type"::"Credit Memo",PurchCrMemoHdr."No.",false,EUService,false);
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
}

