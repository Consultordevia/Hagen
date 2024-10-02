#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50247 "Make 349 Declaration Disk3"
{
    Caption = 'Make 349 Declaration Disk';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Integer";"Integer")
        {
            DataItemTableView = sorting(Number) where(Number=const(1));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if not Evaluate(NumFiscalYear,"Fiscal Year") then
                  Error(Text1100102);
                FiscalYear2 := CopyStr("Fiscal Year",3,2);
                ///                                 FromDate := DMY2DATE(1,Period,NumFiscalYear);
                ///                                 ToDate := CALCDATE('<+CM>',FromDate);
                                                 FromDate := 20140101D;
                                                 ToDate := 20140331D;
            end;
        }
        dataitem("Country/Region";"Country/Region")
        {
            DataItemTableView = sorting("Intrastat Code");
            column(ReportForNavId_2; 2)
            {
            }
            dataitem(Customer;Customer)
            {
                DataItemLink = "Country/Region Code"=field(Code);
                DataItemTableView = sorting("VAT Registration No.");
                PrintOnlyIfDetail = true;
                column(ReportForNavId_3; 3)
                {
                }

                trigger OnPreDataItem()
                begin
                    SetFilter(Customer."Country/Region Code",'<>%1',CountryCode);
                end;
            }
            dataitem(Vendor;Vendor)
            {
                DataItemLink = "Country/Region Code"=field(Code);
                DataItemTableView = sorting("VAT Registration No.");
                column(ReportForNavId_4; 4)
                {
                }

                trigger OnPreDataItem()
                begin
                    SetFilter(Vendor."Country/Region Code",'<>%1',CountryCode);
                end;
            }

            trigger OnPreDataItem()
            begin
                "Country/Region".SetFilter("Intrastat Code",'<> %1','');
            end;
        }
        dataitem(Integer4;"Integer")
        {
            DataItemTableView = sorting(Number) where(Number=const(1));
            column(ReportForNavId_5; 5)
            {
            }
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
                    field("Fiscal Year";"Fiscal Year")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Fiscal Year';

                        trigger OnValidate()
                        begin
                            FileName := 'C:\349\349-'+"Fiscal Year";
                        end;
                    }
                    field(Period;Period)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Period';

                        trigger OnValidate()
                        begin
                            FileName := 'C:\349\349-'+"Fiscal Year"+'-'+Format(Period);
                            if RectPeriod=1 then RectPeriod2:='01';
                            if RectPeriod=2 then RectPeriod2:='02';
                            if RectPeriod=3 then RectPeriod2:='03';
                            if RectPeriod=4 then RectPeriod2:='04';
                            if RectPeriod=5 then RectPeriod2:='05';
                            if RectPeriod=6 then RectPeriod2:='06';
                            if RectPeriod=7 then RectPeriod2:='07';
                            if RectPeriod=8 then RectPeriod2:='08';
                            if RectPeriod=9 then RectPeriod2:='09';
                            if RectPeriod=10 then RectPeriod2:='10';
                            if RectPeriod=11 then RectPeriod2:='11';
                            if RectPeriod=12 then RectPeriod2:='12';
                        end;
                    }
                    field(ContactName;ContactName)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Period';
                    }
                    field(ContactTelephone;ContactTelephone)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Period';
                    }
                    field(DeclarationNum;DeclarationNum)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Period';
                    }
                    field(CountryCode;CountryCode)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Period';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            if Page.RunModal(10,"Country/Region") = Action::LookupOK then
                              CountryCode := "Country/Region".Code;
                        end;
                    }
                    field(GenProdPostGroupCode;GenProdPostGroupCode)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Excluded Gen. Product Posting Group';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            if Page.RunModal(313,GenProdPostGroup) = Action::LookupOK then
                              GenProdPostGroupCode := GenProdPostGroup.Code;
                        end;
                    }
                    field(FileName;FileName)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Nombre archivo';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnClosePage()
        begin
            if GenProdPostGroupCode = '' then
              Message(Text1100122);
        end;

        trigger OnInit()
        begin
            if FileName = '' then
              FileName := Text1100117;
            if "Fiscal Year" = '' then
              "Fiscal Year" := '0000';
            ////IF Period = '' THEN
            ////  Period := Text1100103;
            ////CountryCode := '';
            CountryCode:='ES';
            ContactName:='RAMON YAGO SANAGUSTIN';
            ContactTelephone:='961200945 ';
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        VatRegNo := CopyStr(DelChr(CompanyInfo."VAT Registration No.",'=','.-/'),1,9);
        NoOperations := 0;
        NoOfRectShips := 0;
        NoOfRectReciv := 0;
        DeclarationNum := '3490000000000';
    end;

    trigger OnPostReport()
    begin
        if TotalAmtShip < 0 then
          TotalAmtShip := -TotalAmtShip;
        TextOpAmount := FormatTextAmt(TotalAmtShip + TotalAmtReciv);
        TextCorreAmount := FormatTextAmt(TotalCorreAmt);
        /*
        Txt :=
          '1' + '349' + "Fiscal Year" + VatRegNo +
        ///PADSTR(CONVERTSTR(UPPERCASE(CompanyInfo.Nombre),'ÙÑÜ()"&','AAEEIIOOUUU     '),40,' ') + 'D' +
           PADSTR(CONVERTSTR(UPPERCASE(CompanyInfo.Nombre),'ÁÀÉÈÍÌÓÒÚÙÑÜ()"&´','AAEEIIOOUUÐU     '),40,' ') + 'D' +
          CONVERTSTR(FORMAT(ContactTelephone,9),' ','0') +
             PADSTR(CONVERTSTR(UPPERCASE(ContactName),'ÁÀÉÈÍÌÓÒÚÙÑÜ()"&´','AAEEIIOOUUÐU     '),40,' ') +
        ///  PADSTR(CONVERTSTR(UPPERCASE(ContactName),'ÙÑÜ()"&','AAEEIIOOUUU     '),40,' ') +
          PADSTR(ReceiptNum,13,' ') + '  ' + PADSTR('',13,'0') + Period +
          CONVERTSTR(FORMAT(NoOperations,9),' ','0') + CONVERTSTR(TextOpAmount,' ','0') +
          CONVERTSTR(FORMAT(NoOfCorrections,9),' ','0') + CONVERTSTR(TextCorreAmount,' ','0')
          + PADSTR('',65,' ');
        OutFile.SEEK(0);
        OutFile.WRITE(Txt);
        OutFile.CLOSE();
        */
        DeclarationMT := 'C';
                           if (StrLen(Format(Period)) <> 2)then begin
                             PeriodInt := Period;
                             PeriodText := Format(PeriodInt,2,'<Integer,2><Filler Character,0>');
                           end else
                             PeriodText := Format(Period);
        PeriodChangeText:=' ';
                   Txt :=
                     '1' + '349' + "Fiscal Year" + PadStr(VatRegNo,9,' ') +
                     PadStr(ConvertStr(UpperCase(CompanyInfo.Name),'µ·┼ÔÖÞàãéë¥┌░()"&┘+ï','AAEEIIOOUUÑUÇ     O '),40,' ') +
                     DeclarationMT+
                     ConvertStr(Format(ContactTelephone,9),' ','0') +
                     PadStr(ConvertStr(UpperCase(ContactName),'µ·┼ÔÖÞàãéë¥┌░()"&┘+ï','AAEEIIOOUUÑUÇ     O '),40,' ') +
                     DeclarationNum +
                               '  ' + PadStr('',13,'0') + PeriodText +
                               ConvertStr(Format(NoOperations,9),' ','0') + ConvertStr(TextOpAmount,' ','0') +
                               ConvertStr(Format(NoOfCorrections,9),' ','0') + ConvertStr(TextCorreAmount,' ','0') +
                               PeriodChangeText + PadStr('',65,' ');
                               Txt2 :=PadStr('',250,' ');
                             OutFile.SEEK(0);
                             if VatRegNo<>'' then begin
                             OutFile.Write(Txt+Txt2);
                             end;
                             OutFile.Close;

    end;

    trigger OnPreReport()
    begin
        if "Fiscal Year" = '' then
          Error(Text1100101);
        if ContactName = '' then
          Error(Text1100118);
        if ContactTelephone = '' then
          Error(Text1100119);
        if DeclarationNum = '' then
          Error(Text1100120);
        if CountryCode = '' then
          Error(Text1100121);
        Clear(OutFile);
        OutFile.TextMode := true;
        OutFile.WriteMode := true;
        OutFile.Create(FileName);
    end;

    var
        Text1100100: label 'Incorrect delegation';
        Text1100101: label 'Incorrect Fiscal Year.';
        Text1100102: label 'Incorrect Fiscal Year';
        Text1100103: label '0A';
        Text1100104: label '1T';
        Text1100105: label '2T';
        Text1100106: label '3T';
        Text1100107: label '4T';
        Text1100108: label 'X';
        Text1100109: label '<integer>';
        Text1100110: label 'OA';
        Text1100111: label 'O';
        Text1100112: label 'The following registers had been recorded in ...: \';
        Text1100113: label 'Intracommunity sales..................: #1######\';
        Text1100114: label 'Rectification intracommunity sales....: #2######\';
        Text1100115: label 'Intracommunity purchases..............: #3######\';
        Text1100116: label 'Rectification intracommunity purchases: #4######\';
        Text1100117: label 'C:\349\CE';
        Text1100118: label 'Contact name must be entered';
        Text1100119: label 'Contact telephone must be entered';
        Text1100120: label 'Receipt number must be entered';
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        CustCod: Record "Cust. Ledger Entry";
        VendCod: Record "Vendor Ledger Entry";
        CustEntries: Record "Cust. Ledger Entry";
        CustEntries2: Record "Cust. Ledger Entry";
        VendEntries: Record "Vendor Ledger Entry";
        CustVendCountry: Record "Country/Region";
        VendEntries2: Record "Vendor Ledger Entry";
        VATInvSales: Record "VAT Entry";
        VATCredSales: Record "VAT Entry";
        VATInvPurch: Record "VAT Entry";
        VATCredPurch: Record "VAT Entry";
        Customer2: Record Customer;
        Vendor2: Record Vendor;
        CustSale: Page UnknownPage10702;
        VendSale: Page UnknownPage10703;
        Window: Dialog;
        OutFile: File;
        Txt: Text[250];
        Txt2: Text[250];
        "Fiscal Year": Code[4];
        NumFiscalYear: Integer;
        VatRegNo: Text[9];
        FromDate: Date;
        ToDate: Date;
        FileName: Text[30];
        NormalAmount: Decimal;
        RectFiscalYear: Code[4];
        FiscalYear2: Code[2];
        RectPeriod: Integer;
        RectPeriod2: Code[2];
        OpTriang: Text[1];
        I: Integer;
        NoOfRectShips: Integer;
        NoOfRectReciv: Integer;
        PrintAddCurrAmt: Boolean;
        Ok: Boolean;
        NoOfCorrections: Decimal;
        TotalAmtShip: Decimal;
        TotalAmtReciv: Decimal;
        Sign: Text[1];
        AddCurrencyCod: Code[20];
        AmountOpTri: Decimal;
        AmountCrMemo: Decimal;
        CustVendVatRegNo: Text[12];
        ContactName: Text[40];
        ContactTelephone: Code[9];
        TextAmount: Text[13];
        TextAmount2: Text[13];
        TextOpAmount: Text[15];
        TextCorreAmount: Text[15];
        ReceiptNum: Text[13];
        NoOperations: Integer;
        TotalCorreAmt: Decimal;
        PrevDeclAmount: Decimal;
        RectAmount: Decimal;
        CountryCode: Code[10];
        Text1100121: label 'Company Country/Region must be entered';
        GenProdPostGroupCode: Code[10];
        GenProdPostGroup: Record "Gen. Product Posting Group";
        Text1100122: label 'The system will generate the 349 file according your Report 88 setup. \ Please be aware that this file will contain posted entries of services transactions of EU customers/vendors \ if you did not fill  "Excluding Gen. Prod. Posting Group" field.';
        ventana: Dialog;
        DeclarationMT: Code[1];
        DeclarationNum: Code[20];
        PeriodInt: Integer;
        Period: Option "0A","01","02","03","04","05","06","07","08","09","10","11","12","1T","2T","3T","4T";
        PeriodText: Text[30];
        PeriodChangeText: Code[1];
        SaldoFinal: Decimal;
        ClienAbonado: Decimal;
        ClienFacturado: Decimal;
        CONTA: Decimal;


    procedure FormatTextAmt(Amount: Decimal): Text[15]
    var
        TextAmt: Text[15];
    begin
        TextAmt := Format(Amount,0,'<Precision,2:2><Integer><Decimals>');
        TextAmt := DelChr(TextAmt,'=',',');
        while StrLen(TextAmt) < 15 do
          TextAmt := '0' + TextAmt;
        exit(TextAmt);
    end;
}

