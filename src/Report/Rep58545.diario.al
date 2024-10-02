#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 58545 diario
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/diario.rdlc';
    Caption = 'Account - Official Acc. Book';

    dataset
    {
        dataitem("G/L Entry";"G/L Entry")
        {
            DataItemTableView = sorting("Entry No.");
            RequestFilterFields = "Posting Date";
            column(ReportForNavId_7069; 7069)
            {
            }
            column(Num_cuenta;"G/L Account No.")
            {
            }
            column(Nombre_cuenta;GLAccount.Name)
            {
            }
            column(Tipo;"Document Type")
            {
            }
            column(Debe;"Debit Amount")
            {
            }
            column(Haber;"Credit Amount")
            {
            }
            column(Document_No;"Document No.")
            {
            }
            column(Description;Description)
            {
            }
            column(Fecha;"G/L Entry"."Posting Date")
            {
            }
            column(asiento;"G/L Entry"."Transaction No.")
            {
            }
            column(TipoProce;"G/L Entry"."Source Type")
            {
            }
            column(CodProce;"G/L Entry"."Source No.")
            {
            }
            column(NomProce;NomProce)
            {
            }

            trigger OnAfterGetRecord()
            begin

                GLAccount.Get("G/L Entry"."G/L Account No.");


                NomProce:='';

                if "G/L Entry"."Source Type"="G/L Entry"."source type"::Customer then begin
                    Customer.Get("G/L Entry"."Source No.");
                    NomProce:=Customer.Name;
                end;

                if "G/L Entry"."Source Type"="G/L Entry"."source type"::Vendor then begin
                    Vendor.Get("G/L Entry"."Source No.");
                    NomProce:=Vendor.Name;
                end;
                if "G/L Entry"."Source Type"="G/L Entry"."source type"::"Bank Account" then begin
                    BankAccount.Get("G/L Entry"."Source No.");
                    NomProce:=BankAccount.Name;
                end;
                if "G/L Entry"."Source Type"="G/L Entry"."source type"::"Fixed Asset" then begin
                    FixedAsset.Get("G/L Entry"."Source No.");
                    NomProce:=FixedAsset.Description;
                end;





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
                    field(CloseTransactDesc;CloseTransactDesc)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Closing Transaction Description';
                        ToolTip = 'Specifies the closing transaction description that you want to include in the report.';
                    }
                    field(OpenTransactDesc;OpenTransactDesc)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Opening Transaction Description';
                        ToolTip = 'Specifies a description for the initial transaction that you want to include in the report.';
                    }
                    field(FirstPage;FirstPage)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'First Page';
                        ToolTip = 'Specifies the beginning page number to include in the report or view.';
                    }
                    field(PrintAmountsInAddCurrency;PrintAmountsInAddCurrency)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Show Amounts in Add. Currency';
                        ToolTip = 'Specifies if amounts in the additional currency are included.';
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

    trigger OnInitReport()
    begin
        FirstRec := true;
        if OpenTransactDesc = '' then
          OpenTransactDesc := Text1100000;
        if CloseTransactDesc = '' then
          CloseTransactDesc := Text1100001;
    end;

    trigger OnPreReport()
    var
        GLEntryTrans: Record "G/L Entry";
        StartTransNo: Integer;
        EndTransNo: Integer;
    begin
    end;

    var
        Text1100000: label 'Period Opening Transaction';
        Text1100001: label 'Period Closing Transaction';
        Text1100003: label 'Period: ';
        Text1100004: label 'All amounts are in ';
        Text1100005: label 'No hay m s AccPeriods y s´┐¢ registros. Trans: %1', Comment='%1=GL register number';
        Text1100006: label 'There is not any period in this range of date';
        GLAccount: Record "G/L Account";
        AccPeriod: Record "Accounting Period";
        NextAccPeriod: Record "Accounting Period";
        GLReg2: Record "G/L Register";
        GLSetup: Record "General Ledger Setup";
        GLentry: Record "G/L Entry";
        GLFilter: Text[250];
        LoopEnd: Boolean;
        FirstRec: Boolean;
        TempDate: Date;
        OldDate: Date;
        FromDate: Date;
        ToDate: Date;
        FromPerTransNo: Integer;
        ToPerTransNo: Integer;
        OpenTransactDesc: Text[30];
        CloseTransactDesc: Text[30];
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        TFTotalCreditAmt: Decimal;
        TFTotalDebitAmt: Decimal;
        TotalDebitAmt: Decimal;
        TotalCreditAmt: Decimal;
        OpenClosePerTransNo: Integer;
        OpenCloseDate: Date;
        TableEnd: Boolean;
        FirstPage: Integer;
        GLDateFilter: Text;
        FirstReg: Boolean;
        CurrTransNo: Integer;
        PrintAmountsInAddCurrency: Boolean;
        HeaderText: Text[50];
        InitPeriodDate: Date;
        FirstPeriodDate: Date;
        LineID: Integer;
        FirstPageNum: Integer;
        TFTotalCreditAmt1: Decimal;
        TFTotalDebitAmt1: Decimal;
        Official_Accounting_BookCaptionLbl: label 'Official Accounting Book';
        CurrReport_PAGENO___FirstPageCaptionLbl: label 'Page';
        GLAccount_NameCaptionLbl: label 'Name';
        ContinuedCaptionLbl: label 'Continued';
        ContinuedCaption_Control60Lbl: label 'Continued';
        TotalCaptionLbl: label 'Total';
        V1CaptionLbl: label 'Period Trans. No.';
        NORMALDATE_OpenCloseDate_CaptionLbl: label 'Posting Date';
        OpenClosePerTransNoCaptionLbl: label 'Period Trans. No.';
        NORMALDATE_OpenCloseDate__Control29CaptionLbl: label 'Posting Date';
        ContinuedCaption_Control43Lbl: label 'Continued';
        G_L_Register__Posting_Date_CaptionLbl: label 'Posting Date';
        ContinuedCaption_Control42Lbl: label 'Continued';
        G_L_Register__Posting_Date__Control39CaptionLbl: label 'Posting Date';
        OpenClosePerTransNo_Control58CaptionLbl: label 'Period Trans. No.';
        FORMAT_CLOSINGDATE_OpenCloseDate__CaptionLbl: label 'Posting Date';
        NomProce: Text;
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        BankAccount: Record "Bank Account";


    procedure CalcPeriod(InitialDate: Date): Date
    begin
        AccPeriod.SetRange("New Fiscal Year",true);
        AccPeriod.SetFilter("Starting Date",'<=%1',InitialDate);
        if AccPeriod.Find('+') then
          exit(AccPeriod."Starting Date");

        Error(Text1100006);
    end;
}

