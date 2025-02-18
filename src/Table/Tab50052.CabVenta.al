table 50052 CabVenta
{
    Caption = 'CabVenta';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(5; "Bill-to Name"; Text[100])
        {
            Caption = 'Bill-to Name';
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }
        field(6; "Bill-to Name 2"; Text[50])
        {
            Caption = 'Bill-to Name 2';
        }
        field(7; "Bill-to Address"; Text[100])
        {
            Caption = 'Bill-to Address';

        }
        field(8; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Bill-to Address 2';


        }
        field(9; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';
            TableRelation = if ("Bill-to Country/Region Code" = const('')) "Post Code".City
            else
            if ("Bill-to Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Bill-to Country/Region Code"));
            ValidateTableRelation = false;

        }
        field(10; "Bill-to Contact"; Text[100])
        {
            Caption = 'Bill-to Contact';

        }
        field(11; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code where("Customer No." = field("Sell-to Customer No."));
        }
        field(13; "Ship-to Name"; Text[100])
        {
            Caption = 'Ship-to Name';
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(15; "Ship-to Address"; Text[100])
        {
            Caption = 'Ship-to Address';
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(17; "Ship-to City"; Text[30])
        {

        }
        field(18; "Ship-to Contact"; Text[100])
        {
            Caption = 'Ship-to Contact';
        }
        field(19; "Order Date"; Date)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Order Date';

        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

        }
        field(21; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';

        }
        field(22; "Posting Description"; Text[100])
        {
            Caption = 'Posting Description';
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(25; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(26; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";

        }
        field(28; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));

        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));

        }
        field(31; "Customer Posting Group"; Code[20])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";


        }
        field(32; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;


        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

        }
        field(34; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";


        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';


        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            AccessByPermission = TableData "Cust. Invoice Disc." = R;
            Caption = 'Invoice Disc. Code';


        }
        field(40; "Customer Disc. Group"; Code[20])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";


        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;


        }
        field(42; "Format Region"; Text[80])
        {
            Caption = 'Format Region';
            TableRelation = "Language Selection"."Language Tag";
        }
        field(43; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser" where(Blocked = const(false));


        }
        field(45; "Order Class"; Code[10])
        {
            Caption = 'Order Class';
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = exist("Sales Comment Line" where("Document Type" = field("Document Type"),
                                                            "No." = field("No."),
                                                            "Document Line No." = const(0)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(51; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
        }
        field(52; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

        }
        field(55; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account";


        }
        field(56; "Recalculate Invoice Disc."; Boolean)
        {
            CalcFormula = exist("Sales Line" where("Document Type" = field("Document Type"),
                                                    "Document No." = field("No."),
                                                    "Recalculate Invoice Disc." = const(true)));
            Caption = 'Recalculate Invoice Disc.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; Ship; Boolean)
        {
            Caption = 'Ship';
            Editable = false;
        }
        field(58; Invoice; Boolean)
        {
            Caption = 'Invoice';
        }
        field(59; "Print Posted Documents"; Boolean)
        {
            Caption = 'Print Posted Documents';
        }
        field(60; Amount; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line".Amount where("Document Type" = field("Document Type"),
                                                         "Document No." = field("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Amount Including VAT" where("Document Type" = field("Document Type"),
                                                                         "Document No." = field("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Shipping No."; Code[20])
        {
            Caption = 'Shipping No.';
        }
        field(63; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
        }
        field(64; "Last Shipping No."; Code[20])
        {
            Caption = 'Last Shipping No.';
            Editable = false;
            TableRelation = "Sales Shipment Header";
        }
        field(65; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
            Editable = false;
            TableRelation = "Sales Invoice Header";
        }
        field(66; "Prepayment No."; Code[20])
        {
            Caption = 'Prepayment No.';
        }
        field(67; "Last Prepayment No."; Code[20])
        {
            Caption = 'Last Prepayment No.';
            TableRelation = "Sales Invoice Header";
        }
        field(68; "Prepmt. Cr. Memo No."; Code[20])
        {
            Caption = 'Prepmt. Cr. Memo No.';
        }
        field(69; "Last Prepmt. Cr. Memo No."; Code[20])
        {
            Caption = 'Last Prepmt. Cr. Memo No.';
            TableRelation = "Sales Cr.Memo Header";
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';


        }
        field(71; "Combine Shipments"; Boolean)
        {
            Caption = 'Combine Shipments';
        }
        field(72; "Registration Number"; Text[50])
        {
            Caption = 'Registration No.';
            DataClassification = CustomerContent;
        }
        field(73; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(74; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";


        }
        field(75; "EU 3-Party Trade"; Boolean)
        {
            Caption = 'EU 3-Party Trade';
        }
        field(76; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";


        }
        field(77; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";


        }
        field(78; "VAT Country/Region Code"; Code[10])
        {
            Caption = 'VAT Country/Region Code';
            TableRelation = "Country/Region";


        }
        field(79; "Sell-to Customer Name"; Text[100])
        {
            Caption = 'Sell-to Customer Name';
            TableRelation = Customer.Name;
            ValidateTableRelation = false;


        }
        field(80; "Sell-to Customer Name 2"; Text[50])
        {
            Caption = 'Sell-to Customer Name 2';
        }
        field(81; "Sell-to Address"; Text[100])
        {
            Caption = 'Sell-to Address';


        }
        field(82; "Sell-to Address 2"; Text[50])
        {
            Caption = 'Sell-to Address 2';


        }
        field(83; "Sell-to City"; Text[30])
        {
            Caption = 'Sell-to City';
            TableRelation = if ("Sell-to Country/Region Code" = const('')) "Post Code".City
            else
            if ("Sell-to Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Sell-to Country/Region Code"));
            ValidateTableRelation = false;


        }
        field(84; "Sell-to Contact"; Text[100])
        {
            Caption = 'Sell-to Contact';


        }
        field(85; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = "Post Code";
            ValidateTableRelation = false;


        }
        field(86; "Bill-to County"; Text[30])
        {
            CaptionClass = '5,3,' + "Bill-to Country/Region Code";
            Caption = 'Bill-to County';


        }
        field(87; "Bill-to Country/Region Code"; Code[10])
        {
            Caption = 'Bill-to Country/Region Code';
            TableRelation = "Country/Region";


        }
        field(88; "Sell-to Post Code"; Code[20])
        {
            Caption = 'Sell-to Post Code';
            TableRelation = if ("Sell-to Country/Region Code" = const('')) "Post Code"
            else
            if ("Sell-to Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Sell-to Country/Region Code"));
            ValidateTableRelation = false;


        }
        field(89; "Sell-to County"; Text[30])
        {
            CaptionClass = '5,2,' + "Sell-to Country/Region Code";
            Caption = 'Sell-to County';


        }
        field(90; "Sell-to Country/Region Code"; Code[10])
        {
            Caption = 'Sell-to Country/Region Code';
            TableRelation = "Country/Region";


        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = if ("Ship-to Country/Region Code" = const('')) "Post Code"
            else
            if ("Ship-to Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Ship-to Country/Region Code"));
            ValidateTableRelation = false;


        }
        field(92; "Ship-to County"; Text[30])
        {
            CaptionClass = '5,4,' + "Ship-to Country/Region Code";
            Caption = 'Ship-to County';
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";


        }
        field(94; "Bal. Account Type"; Enum "Payment Balance Account Type")
        {
            Caption = 'Bal. Account Type';
        }
        field(97; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";


        }
        field(98; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(99; "Document Date"; Date)
        {
            Caption = 'Document Date';


        }
        field(100; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';


        }
        field(101; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;


        }
        field(102; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";


        }
        field(104; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";


        }
        field(105; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";


        }
#if not CLEAN24
        field(106; "Package Tracking No."; Text[30])
        {
            Caption = 'Package Tracking No.';
            ObsoleteReason = 'Field length will be increased to 50.';
            ObsoleteState = Pending;
            ObsoleteTag = '24.0';
        }
#else
#pragma warning disable AS0086
        field(106; "Package Tracking No."; Text[50])
        {
            Caption = 'Package Tracking No.';
        }
#pragma warning restore AS0086
#endif
        field(107; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";


        }
        field(109; "Shipping No. Series"; Code[20])
        {
            Caption = 'Shipping No. Series';
            TableRelation = "No. Series";


        }
        field(114; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
            ValidateTableRelation = false;


        }
        field(115; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';


        }
        field(116; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";


        }
        field(117; Reserve; Enum "Reserve Method")
        {
            AccessByPermission = TableData Item = R;
            Caption = 'Reserve';
            InitValue = Optional;
        }
        field(118; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';


        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;


        }
        field(120; Status; Enum "Sales Document Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(121; "Invoice Discount Calculation"; Option)
        {
            Caption = 'Invoice Discount Calculation';
            Editable = false;
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            Editable = false;
        }
        field(123; "Send IC Document"; Boolean)
        {
            Caption = 'Send IC Document';


        }
        field(124; "IC Status"; Enum "Sales Document IC Status")
        {
            Caption = 'IC Status';
        }
        field(125; "Sell-to IC Partner Code"; Code[20])
        {
            Caption = 'Sell-to IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(126; "Bill-to IC Partner Code"; Code[20])
        {
            Caption = 'Bill-to IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(127; "IC Reference Document No."; Code[20])
        {
            Caption = 'IC Reference Document No.';
            Editable = false;
        }
        field(129; "IC Direction"; Enum "IC Direction Type")
        {
            Caption = 'IC Direction';


        }
        field(130; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;


        }
        field(131; "Prepayment No. Series"; Code[20])
        {
            Caption = 'Prepayment No. Series';
            TableRelation = "No. Series";


        }
        field(132; "Compress Prepayment"; Boolean)
        {
            Caption = 'Compress Prepayment';
            InitValue = true;
        }
        field(133; "Prepayment Due Date"; Date)
        {
            Caption = 'Prepayment Due Date';


        }
        field(134; "Prepmt. Cr. Memo No. Series"; Code[20])
        {
            Caption = 'Prepmt. Cr. Memo No. Series';
            TableRelation = "No. Series";


        }
        field(135; "Prepmt. Posting Description"; Text[100])
        {
            Caption = 'Prepmt. Posting Description';
        }
        field(138; "Prepmt. Pmt. Discount Date"; Date)
        {
            Caption = 'Prepmt. Pmt. Discount Date';
        }
        field(139; "Prepmt. Payment Terms Code"; Code[10])
        {
            Caption = 'Prepmt. Payment Terms Code';
            TableRelation = "Payment Terms";


        }
        field(140; "Prepmt. Payment Discount %"; Decimal)
        {
            Caption = 'Prepmt. Payment Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;


        }
        field(151; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            Editable = false;
        }
        field(152; "Quote Valid Until Date"; Date)
        {
            Caption = 'Quote Valid To Date';
        }
        field(153; "Quote Sent to Customer"; DateTime)
        {
            Caption = 'Quote Sent to Customer';
            Editable = false;
        }
        field(154; "Quote Accepted"; Boolean)
        {
            Caption = 'Quote Accepted';


        }
        field(155; "Quote Accepted Date"; Date)
        {
            Caption = 'Quote Accepted Date';
            Editable = false;
        }
        field(160; "Job Queue Status"; Enum "Document Job Queue Status")
        {
            Caption = 'Job Queue Status';
            Editable = false;


        }
        field(161; "Job Queue Entry ID"; Guid)
        {
            Caption = 'Job Queue Entry ID';
            Editable = false;
        }
        field(163; "Company Bank Account Code"; Code[20])
        {
            Caption = 'Company Bank Account Code';
            TableRelation = "Bank Account" where("Currency Code" = field("Currency Code"));


        }
        field(165; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            TableRelation = "Incoming Document";


        }
        field(166; "Alt. VAT Registration No."; Boolean)
        {
            Caption = 'Alternative VAT Registration No.';
            Editable = false;
        }
        field(167; "Alt. Gen. Bus Posting Group"; Boolean)
        {
            Caption = 'Alternative Gen. Bus. Posting Group';
            Editable = false;
        }
        field(168; "Alt. VAT Bus Posting Group"; Boolean)
        {
            Caption = 'Alternative VAT Bus. Posting Group';
            Editable = false;
        }
        field(170; IsTest; Boolean)
        {
            Caption = 'IsTest';
            Editable = false;
        }
        field(171; "Sell-to Phone No."; Text[30])
        {
            Caption = 'Sell-to Phone No.';
            ExtendedDatatype = PhoneNo;


        }
        field(172; "Sell-to E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;


        }
        field(175; "Payment Instructions Id"; Integer)
        {

        }
        field(178; "Journal Templ. Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template" where(Type = filter(Sales));


        }
        field(179; "VAT Reporting Date"; Date)
        {
            Caption = 'VAT Date';
            Editable = false;


        }
        field(180; "Rcvd-from Country/Region Code"; Code[10])
        {

        }
        field(181; "Rcvd.-from Count./Region Code"; Code[10])
        {
            Caption = 'Received-from Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(185; "Last Email Sent Time"; DateTime)
        {
            Caption = 'Last Email Sent Time';
            FieldClass = FlowField;
            CalcFormula = max("Email Related Record".SystemCreatedAt where("Table Id" = const(Database::"Sales Header"),
                                                                           "System Id" = field(SystemId)));
        }
        field(186; "Last Email Sent Message Id"; Guid)
        {
            Caption = 'Last Email Sent Message Id';
            FieldClass = FlowField;
            CalcFormula = lookup("Email Related Record"."Email Message Id" where(SystemCreatedAt = field("Last Email Sent Time")));
        }
        field(200; "Work Description"; BLOB)
        {
            Caption = 'Work Description';
        }
        field(210; "Ship-to Phone No."; Text[30])
        {
            Caption = 'Ship-to Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(300; "Amt. Ship. Not Inv. (LCY)"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Shipped Not Invoiced (LCY)" where("Document Type" = field("Document Type"),
                                                                               "Document No." = field("No.")));
            Caption = 'Amount Shipped Not Invoiced (LCY) Incl. VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(301; "Amt. Ship. Not Inv. (LCY) Base"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Shipped Not Inv. (LCY) No VAT" where("Document Type" = field("Document Type"),
                                                                                  "Document No." = field("No.")));
            Caption = 'Amount Shipped Not Invoiced (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";


        }
        field(600; "Payment Service Set ID"; Integer)
        {
            Caption = 'Payment Service Set ID';
        }
        field(720; "Coupled to CRM"; Boolean)
        {

        }
        field(721; "Coupled to Dataverse"; Boolean)
        {
            FieldClass = FlowField;
            Caption = 'Coupled to Dynamics 365 Sales';
            Editable = false;
            CalcFormula = exist("CRM Integration Record" where("Integration ID" = field(SystemId), "Table ID" = const(Database::"Sales Header")));
        }
        field(1200; "Direct Debit Mandate ID"; Code[35])
        {
            Caption = 'Direct Debit Mandate ID';
            TableRelation = "SEPA Direct Debit Mandate" where("Customer No." = field("Bill-to Customer No."),
                                                               Closed = const(false),
                                                               Blocked = const(false));
        }
        field(1305; "Invoice Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Inv. Discount Amount" where("Document No." = field("No."),
                                                                         "Document Type" = field("Document Type")));
            Caption = 'Invoice Discount Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5043; "No. of Archived Versions"; Integer)
        {
            CalcFormula = max("Sales Header Archive"."Version No." where("Document Type" = field("Document Type"),
                                                                          "No." = field("No."),
                                                                          "Doc. No. Occurrence" = field("Doc. No. Occurrence")));
            Caption = 'No. of Archived Versions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;


        }
        field(5051; "Sell-to Customer Template Code"; Code[10])
        {

        }
        field(5052; "Sell-to Contact No."; Code[20])
        {
            Caption = 'Sell-to Contact No.';
            TableRelation = Contact;


        }
        field(5053; "Bill-to Contact No."; Code[20])
        {
            Caption = 'Bill-to Contact No.';
            TableRelation = Contact;


        }
        field(5054; "Bill-to Customer Template Code"; Code[10])
        {

        }
        field(5055; "Opportunity No."; Code[20])
        {
            Caption = 'Opportunity No.';
            TableRelation = if ("Document Type" = filter(<> Order)) Opportunity."No." where("Contact No." = field("Sell-to Contact No."),
                                                                                          Closed = const(false))
            else
            if ("Document Type" = const(Order)) Opportunity."No." where("Contact No." = field("Sell-to Contact No."),
                                                                                                                                                          "Sales Document No." = field("No."),
                                                                                                                                                          "Sales Document Type" = const(Order));


        }
        field(5056; "Sell-to Customer Templ. Code"; Code[20])
        {
            Caption = 'Sell-to Customer Template Code';
            TableRelation = "Customer Templ.";


        }
        field(5057; "Bill-to Customer Templ. Code"; Code[20])
        {
            Caption = 'Bill-to Customer Template Code';
            TableRelation = "Customer Templ.";


        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";


        }
        field(5750; "Shipping Advice"; Enum "Sales Header Shipping Advice")
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Shipping Advice';


        }
        field(5751; "Shipped Not Invoiced"; Boolean)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = exist("Sales Line" where("Document Type" = field("Document Type"),
                                                    "Document No." = field("No."),
                                                    "Qty. Shipped Not Invoiced" = filter(<> 0)));
            Caption = 'Shipped Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            CalcFormula = min("Sales Line"."Completely Shipped" where("Document Type" = field("Document Type"),
                                                                       "Document No." = field("No."),
                                                                       Type = filter(<> " "),
                                                                       "Location Code" = field("Location Filter")));
            Caption = 'Completely Shipped';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5753; "Posting from Whse. Ref."; Integer)
        {
            AccessByPermission = TableData Location = R;
            Caption = 'Posting from Whse. Ref.';
        }
        field(5754; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(5755; Shipped; Boolean)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = exist("Sales Line" where("Document Type" = field("Document Type"),
                                                    "Document No." = field("No."),
                                                    "Qty. Shipped (Base)" = filter(<> 0)));
            Caption = 'Shipped';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5756; "Last Shipment Date"; Date)
        {
            CalcFormula = lookup("Sales Shipment Header"."Shipment Date" where("No." = field("Last Shipping No.")));
            Caption = 'Last Shipment Date';
            FieldClass = FlowField;
        }
        field(5790; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';


        }
        field(5791; "Promised Delivery Date"; Date)
        {
            AccessByPermission = TableData "Order Promising Line" = R;
            Caption = 'Promised Delivery Date';


        }
        field(5792; "Shipping Time"; DateFormula)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Shipping Time';


        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            AccessByPermission = TableData "Warehouse Shipment Header" = R;
            Caption = 'Outbound Whse. Handling Time';


        }
        field(5794; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = field("Shipping Agent Code"));


        }
        field(5795; "Late Order Shipping"; Boolean)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = exist("Sales Line" where("Document Type" = field("Document Type"),
                                                    "Sell-to Customer No." = field("Sell-to Customer No."),
                                                    "Document No." = field("No."),
                                                    "Shipment Date" = field("Date Filter"),
                                                    "Outstanding Quantity" = filter(<> 0)));
            Caption = 'Late Order Shipping';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5800; Receive; Boolean)
        {
            Caption = 'Receive';
        }
        field(5801; "Return Receipt No."; Code[20])
        {
            Caption = 'Return Receipt No.';
        }
        field(5802; "Return Receipt No. Series"; Code[20])
        {
            Caption = 'Return Receipt No. Series';
            TableRelation = "No. Series";


        }
        field(5803; "Last Return Receipt No."; Code[20])
        {
            Caption = 'Last Return Receipt No.';
            Editable = false;
            TableRelation = "Return Receipt Header";
        }
        field(7000; "Price Calculation Method"; Enum "Price Calculation Method")
        {
            Caption = 'Price Calculation Method';
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';


        }
        field(7200; "Get Shipment Used"; Boolean)
        {
            Caption = 'Get Shipment Used';
            Editable = false;
        }
        field(8000; Id; Guid)
        {

        }
        field(9000; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup";


        }
        field(10705; "Corrected Invoice No."; Code[20])
        {
            Caption = 'Corrected Invoice No.';


        }
        field(10706; "Due Date Modified"; Boolean)
        {
            Caption = 'Due Date Modified';
            Editable = false;
        }
        field(10707; "Invoice Type"; Enum "SII Sales Invoice Type")
        {
            Caption = 'Invoice Type';

        }
        field(10708; "Cr. Memo Type"; Enum "SII Sales Credit Memo Type")
        {
            Caption = 'Cr. Memo Type';

        }
        field(10709; "Special Scheme Code"; Enum "SII Sales Special Scheme Code")
        {
            Caption = 'Special Scheme Code';


        }
        field(10710; "Operation Description"; Text[250])
        {
            Caption = 'Operation Description';
        }
        field(10711; "Correction Type"; Option)
        {
            Caption = 'Correction Type';
            OptionCaption = ' ,Replacement,Difference,Removal';
            OptionMembers = " ",Replacement,Difference,Removal;


        }
        field(10712; "Operation Description 2"; Text[250])
        {
            Caption = 'Operation Description 2';
        }
        field(10720; "Succeeded Company Name"; Text[250])
        {
            Caption = 'Succeeded Company Name';
        }
        field(10721; "Succeeded VAT Registration No."; Text[20])
        {
            Caption = 'Succeeded VAT Registration No.';
        }
        field(10722; "ID Type"; Enum "SII ID Type")
        {
            Caption = 'ID Type';
        }
        field(10724; "Do Not Send To SII"; Boolean)
        {
            Caption = 'Do Not Send To SII';
        }
        field(10725; "Issued By Third Party"; Boolean)
        {
            Caption = 'Issued By Third Party';
        }
        field(10726; "SII First Summary Doc. No."; Blob)
        {
            Caption = 'First Summary Doc. No.';
        }
        field(10727; "SII Last Summary Doc. No."; Blob)
        {
            Caption = 'Last Summary Doc. No.';
        }
        field(7000000; "Applies-to Bill No."; Code[20])
        {
            Caption = 'Applies-to Bill No.';
        }
        field(7000001; "Cust. Bank Acc. Code"; Code[20])
        {
            Caption = 'Cust. Bank Acc. Code';
            TableRelation = "Customer Bank Account".Code where("Customer No." = field("Bill-to Customer No."));
        }
        field(7000003; "Pay-at Code"; Code[10])
        {

        }
        field(50000; "Estado pedido"; Option)
        {
            OptionCaption = 'Retenido,Para preparar,Pdte. comercial,Servido,Pendiente stock';
            OptionMembers = Retenido,"Para preparar","Pdte. comercial",Servido,"Pendiente stock";


        }
        field(50003; "Usuario alta"; Code[30])
        {
            Editable = false;
        }
        field(50004; "Fecha alta"; Date)
        {
            Editable = true;
        }
        field(50005; "Hora alta"; Time)
        {
            Editable = false;
        }
        field(50007; "Base Pdte."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Outstanding Amount (LCY)" where("Document Type" = field("Document Type"),
                                                                             "Document No." = field("No.")));
            Caption = 'Base Pdte.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50008; Base; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Line Amount" where("Document Type" = field("Document Type"),
                                                                "Document No." = field("No.")));
            Caption = 'Base';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; "Super urgente"; Boolean)
        {


        }
        field(50011; Preparador; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(Preparadores));
        }
        field(50012; Urgente; Boolean)
        {
        }
        field(50014; "Nº bultos"; Decimal)
        {


        }
        field(50015; "Nº Palets"; Decimal)
        {


        }
        field(50016; "Total bultos"; Decimal)
        {
            Editable = false;
        }
        field(50017; "Anula restos"; Boolean)
        {
        }
        field(50018; "Usuario para preparar"; Code[30])
        {
            Editable = false;
        }
        field(50019; "Fecha para preparar"; Date)
        {
            Editable = false;
        }
        field(50020; "Hora para preparar"; Time)
        {
            Editable = false;
        }
        field(50021; "Nombre comercial"; Text[50])
        {
        }
        field(50022; Televendedor; Code[10])
        {
            TableRelation = User;
        }
        field(50023; "No incluir portes"; Boolean)
        {
        }
        field(50024; "No imprimir albaran valorado"; Boolean)
        {
        }
        field(50027; "Total peso"; Decimal)
        {
        }
        field(50032; "Cdad. Pdte. Servir"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Outstanding Quantity" where("Document Type" = field("Document Type"),
                                                                         "Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50034; "Observación para transporte"; Text[60])
        {
        }
        field(50035; "Permite fraccionar uni. venta"; Boolean)
        {

        }
        field(50037; "Usuario Retenido"; Code[30])
        {
            Editable = false;
        }
        field(50038; "Fecha Retenido"; Date)
        {
            Editable = false;
        }
        field(50039; "Hora Retenido"; Time)
        {
            Editable = false;
        }
        field(50040; "Ampliacion del pedido nº"; Code[20])
        {
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order),
                                                        "Sell-to Customer No." = field("Sell-to Customer No."),
                                                        "Estado pedido" = filter(<> Servido));


        }
        field(50041; "Nº expedición"; Code[10])
        {
        }
        field(50042; "Recibido de adaia"; Boolean)
        {
        }
        field(50043; "Observación para ALMACEN"; Text[60])
        {
        }
        field(50044; "No Enviar factura en exp."; Boolean)
        {
        }
        field(50045; "No Enviar albaran en exp."; Boolean)
        {
        }
        field(50046; "Importe a descontar reembolso"; Decimal)
        {
        }
        field(50047; "Albaran sin detalle"; Boolean)
        {
        }
        field(50053; "Pedido WEB"; Boolean)
        {
        }
        field(50059; "Respeta agencia transporte"; Boolean)
        {
        }
        field(50060; "Envio a-Nº Telefono"; Text[30])
        {
        }
        field(50061; "Estado presupuesto"; Option)
        {
            OptionMembers = Activo,"Parcialmente procesado",Procesado;


        }
        field(50062; "Tipo facturación"; Option)
        {
            OptionMembers = Diaria,Semanal,Mensual;
        }
        field(50064; "Respeta Tipo facturacion"; Boolean)
        {
        }
        field(50067; "Nº exped. pequeña"; Boolean)
        {
        }
        field(50068; "Docu. requerida prov. sacada"; Boolean)
        {
        }
        field(50069; "Check contrareemolso verificad"; Boolean)
        {


        }
        field(50075; ASN; Text[40])
        {
        }
        field(50076; "No imprimir facturas"; Boolean)
        {
        }
        field(50077; "Provincia shopyfi"; Code[10])
        {
        }
        field(50111; SupraOferta; Code[10])
        {
        }
        field(50144; Comunidad; Code[10])
        {
        }
        field(50147; "Codigo cliente externo"; Code[20])
        {
            CalcFormula = lookup(Customer."Codigo cliente externo" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
        }
        field(50170; "Fecha incial de entrega EDICOM"; Date)
        {
        }
        field(50171; "REFTRANS EDICOM"; Text[35])
        {
        }
        field(50172; "Tipo de documento EDICOM"; Option)
        {
            OptionCaption = '351-Aviso de expedicion,35E-Aviso de devolucion,YA5-Expedicion CrossDocking';
            OptionMembers = "351-Aviso de expedicion","35E-Aviso de devolucion","YA5-Expedicion CrossDocking";
        }
        field(50173; "Funcion del mensaje EDICOM"; Option)
        {
            OptionCaption = '9-Original,1-Cancelacion,7-Duplicado,31-Copia,4-Cambio,5-Sustitucion';
            OptionMembers = "9-Original","1-Cancelacion","7-Duplicado","31-Copia","4-Cambio","5-Sustitucion";
        }
        field(50174; "Tipo transporte EDICOM"; Option)
        {
            OptionCaption = ' ,10-Transporte maritimo,20-Transporte ferroviario,30-Transporte por carretera,40-Transporte aereo,60-Transporte muitimodo';
            OptionMembers = " ","10-Transporte maritimo","20-Transporte ferroviario","30-Transporte por carretera","40-Transporte aereo","60-Transporte muitimodo";
        }
        field(50177; "IDENTIF EDICOM"; Option)
        {
            OptionCaption = 'X7-No viene identificado,X6-Sí esta identificado';
            OptionMembers = "X7-No viene identificado","X6-Sí esta identificado";
        }
        field(50178; "Nº Nota Debito"; Code[20])
        {
        }
        field(50202; "Enviado email preparación"; Boolean)
        {
        }
        field(50203; "Importe a cuenta"; Decimal)
        {
        }
        field(50205; "Puede retocar"; Boolean)
        {
        }
        field(50207; "Filtro ECI"; Code[10])
        {
        }
        field(50209; "No agrupar en ADAIA"; Boolean)
        {
        }
        field(50210; "Marcar para agrupar"; Boolean)
        {
        }
        field(50216; "Fecha envio pendiente stock"; Date)
        {
        }
        field(50217; Reembolso; Decimal)
        {
        }
        field(50218; "Importe optimo transporte"; Decimal)
        {
        }
        field(50219; "Cobra portes entre empresas"; Boolean)
        {
        }
        field(50220; Dropshipping; Boolean)
        {

        }
        field(50221; "Nº expedición agrupada"; Code[10])
        {
        }
        field(50222; "Frecuencia visita comercial"; Code[10])
        {
            CalcFormula = lookup(Customer."Frecuencia visita comercial" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
            TableRelation = Multitabla.Codigo where(Tabla = const("Frecuencia visita"));
        }
        field(50223; "E-MAIL"; Text[80])
        {
        }
        field(50224; "Observación PDA"; Text[40])
        {
        }
        field(50225; "Recibido y facturado"; Boolean)
        {
        }
        field(50236; "Transferencia web"; Boolean)
        {
        }
        field(50237; "Pago Aceptado"; Boolean)
        {
        }
        field(50238; "Importe total pedido WEB"; Decimal)
        {
        }
        field(50245; "Nº expedición dropshp"; Code[10])
        {
        }
        field(50293; "NO MULTIPEDIDO"; Boolean)
        {
        }
        field(50294; "No agrupar en CANARIAS"; Boolean)
        {


        }
        field(50301; "Incrementa bultos"; Integer)
        {
        }
        field(50321; "EDI factueas enviar"; Boolean)
        {
        }
        field(50329; "Grupo clientes"; Code[10])
        {
            CalcFormula = lookup(Customer."Grupo clientes" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
            TableRelation = Multitabla.Codigo where(Tabla = const("Grupo de clientes"));
        }
        field(50363; "Multi-picking"; Boolean)
        {
        }
        field(50364; "Dpto.ECI"; Code[10])
        {
        }
        field(50365; "Discount%"; Decimal)
        {
            CalcFormula = lookup("Payment Terms"."Discount %" where(code = field("Payment Terms Code")));
            FieldClass = FlowField;



        }
        field(50367; TextoWebApi; Text[100])
        {
        }




        field(60000; "Id Pedido Presta Shop"; BigInteger)
        {
            Description = 'WEB';
        }
        field(60001; "Referencia Pedido Presta Shop"; Code[50])
        {
            Description = 'WEB';
        }
        field(60002; "Importe Descuento Presta Shop"; Decimal)
        {
            Description = 'WEB';
        }
        field(60003; "Notificar Pago"; Boolean)
        {
            Description = 'WEB';


        }
        field(60004; "Notificar Envio"; Boolean)
        {
            Description = 'WEB';
        }
        field(60005; "Nº Factura Notificar Envio"; Code[20])
        {
            TableRelation = "Sales Invoice Header"."No." where("Bill-to Customer No." = field("Bill-to Customer No."));
        }
        field(60006; "Texto Descuento Presta Shop"; Text[50])
        {
        }
        field(60007; "Nº Albaran Notificar Envio"; Code[20])
        {
            TableRelation = "Sales Shipment Header"."No." where("Sell-to Customer No." = field("Sell-to Customer No."));
        }
        field(60008; "Factura EDI"; Boolean)
        {
        }
        field(60009; "Albarán EDI"; Boolean)
        {
        }
        field(50668; GLN; Code[13])
        {
            CalcFormula = lookup(Customer.GLN where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
        }
        field(50669; "Etq.Adaia"; Code[30])
        {
        }
        field(50998; Error; text[2048])
        {

        }
        field(50999; CreadoSalesHeader; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "No.", "Document Type")
        {
        }
        key(Key3; "Document Type", "Sell-to Customer No.")
        {
        }
        key(Key4; "Document Type", "Bill-to Customer No.")
        {
        }
        key(Key5; "Document Type", "Combine Shipments", "Bill-to Customer No.", "Currency Code", "EU 3-Party Trade", "Dimension Set ID", "Journal Templ. Name")
        {
        }
        key(Key6; "Sell-to Customer No.", "External Document No.")
        {
        }
        key(Key7; "Document Type", "Sell-to Contact No.")
        {
        }
        key(Key8; "Bill-to Contact No.")
        {
        }
        key(Key9; "Incoming Document Entry No.")
        {
        }
        key(Key10; "Document Date")
        {
        }
        key(Key11; "Shipment Date", Status, "Location Code", "Responsibility Center")
        {
        }
        key(Key12; "Salesperson Code")
        {
        }
        key(Key13; SystemModifiedAt)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Sell-to Customer Name", Amount, "Sell-to Contact", "Amount Including VAT")
        {
        }
        fieldgroup(Brick; "No.", "Sell-to Customer Name", Amount, "Sell-to Contact", "Amount Including VAT")
        {
        }
    }

}

