table 50053 LinVenta
{
    Caption = 'LinVenta';
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
            Editable = false;
            TableRelation = Customer;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = CabVenta."No." where("Document Type" = field("Document Type"));
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Enum "Sales Line Type")
        {
            Caption = 'Type';


        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const("G/L Account"), "System-Created Entry" = const(false)) "G/L Account" where("Direct Posting" = const(true), "Account Type" = const(Posting), Blocked = const(false))
            else
            if (Type = const("G/L Account"), "System-Created Entry" = const(true)) "G/L Account"
            else
            if (Type = const(Resource)) Resource
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge"
            else
            if (Type = const("Allocation Account")) "Allocation Account"
            else
            if (Type = const(Item), "Document Type" = filter(<> "Credit Memo" & <> "Return Order")) Item where(Blocked = const(false), "Sales Blocked" = const(false))
            else
            if (Type = const(Item), "Document Type" = filter("Credit Memo" | "Return Order")) Item where(Blocked = const(false));
            ValidateTableRelation = false;


        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));


        }
        field(8; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = if (Type = const(Item)) "Inventory Posting Group"
            else
            if (Type = const("Fixed Asset")) "FA Posting Group";
        }
        field(10; "Shipment Date"; Date)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Shipment Date';


        }
        field(11; Description; Text[100])
        {
            Caption = 'Description';
            TableRelation = if (Type = const("G/L Account"),
                                "System-Created Entry" = const(false)) "G/L Account".Name where("Direct Posting" = const(true),
                                "Account Type" = const(Posting),
                                Blocked = const(false))
            else
            if (Type = const("G/L Account"), "System-Created Entry" = const(true)) "G/L Account".Name
            else
            if (Type = const(Item), "Document Type" = filter(<> "Credit Memo" & <> "Return Order")) Item.Description where(Blocked = const(false),
                                                    "Sales Blocked" = const(false))
            else
            if (Type = const(Item), "Document Type" = filter("Credit Memo" | "Return Order")) Item.Description where(Blocked = const(false))
            else
            if (Type = const(Resource)) Resource.Name
            else
            if (Type = const("Fixed Asset")) "Fixed Asset".Description
            else
            if (Type = const("Charge (Item)")) "Item Charge".Description;
            ValidateTableRelation = false;


        }
        field(12; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(13; "Unit of Measure"; Text[50])
        {
            Caption = 'Unit of Measure';
            TableRelation = if (Type = filter(<> " ")) "Unit of Measure".Description;
            ValidateTableRelation = false;


        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;


        }
        field(16; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(17; "Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice';
            DecimalPlaces = 0 : 5;


        }
        field(18; "Qty. to Ship"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Qty. to Ship';
            DecimalPlaces = 0 : 5;


        }
        field(22; "Unit Price"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 2;

            Caption = 'Unit Price';


        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';


        }
        field(25; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(27; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;


        }
        field(28; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';


        }
        field(29; Amount; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;


        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            Editable = false;


        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;


        }
        field(34; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(35; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
        }
        field(37; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            AccessByPermission = TableData Item = R;
            Caption = 'Appl.-to Item Entry';


        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));


        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));


        }
        field(42; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            Editable = false;
            TableRelation = "Customer Price Group";


        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Project No.';
            Editable = false;
            TableRelation = Job;
        }
        field(52; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";


        }
        field(56; "Recalculate Invoice Disc."; Boolean)
        {
            Caption = 'Recalculate Invoice Disc.';
            Editable = false;
        }
        field(57; "Outstanding Amount"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Outstanding Amount';
            Editable = false;


        }
        field(58; "Qty. Shipped Not Invoiced"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(59; "Shipped Not Invoiced"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced';
            Editable = false;

        }
        field(60; "Quantity Shipped"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Quantity Shipped';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(63; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.';
            Editable = false;
        }
        field(64; "Shipment Line No."; Integer)
        {
            Caption = 'Shipment Line No.';
            Editable = false;
        }
        field(67; "Profit %"; Decimal)
        {
            Caption = 'Profit %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
            Editable = false;


        }
        field(71; "Purchase Order No."; Code[20])
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Purchase Order No.';
            Editable = false;
            TableRelation = if ("Drop Shipment" = const(true)) "Purchase Header"."No." where("Document Type" = const(Order));


        }
        field(72; "Purch. Order Line No."; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Purch. Order Line No.';
            Editable = false;
            TableRelation = if ("Drop Shipment" = const(true)) "Purchase Line"."Line No." where("Document Type" = const(Order),
                                                                                               "Document No." = field("Purchase Order No."));


        }
        field(73; "Drop Shipment"; Boolean)
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Drop Shipment';
            Editable = true;


        }
        field(74; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

        }
        field(75; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";


        }
        field(77; "VAT Calculation Type"; Enum "Tax Calculation Type")
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
        }
        field(78; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(79; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(80; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            Editable = false;
            TableRelation = "Sales Line"."Line No." where("Document Type" = field("Document Type"),
                                                           "Document No." = field("Document No."));
        }
        field(81; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(82; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(83; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(84; "Tax Category"; Code[10])
        {
            Caption = 'Tax Category';
        }
        field(85; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";


        }
        field(86; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';


        }
        field(87; "Tax Group Code"; Code[20])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";


        }
        field(88; "VAT Clause Code"; Code[20])
        {
            Caption = 'VAT Clause Code';
            TableRelation = "VAT Clause";
        }
        field(89; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";


        }
        field(90; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";


        }
        field(91; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(92; "Outstanding Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY)';
            Editable = false;
        }
        field(93; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced (LCY) Incl. VAT';
            Editable = false;
        }
        field(94; "Shipped Not Inv. (LCY) No VAT"; Decimal)
        {
            Caption = 'Shipped Not Invoiced (LCY)';
            Editable = false;
            FieldClass = Normal;
        }
        field(95; "Reserved Quantity"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = - sum("Reservation Entry".Quantity where("Source ID" = field("Document No."),
                                                                   "Source Ref. No." = field("Line No."),
                                                                   "Source Type" = const(37),
#pragma warning disable AL0603
                                                                   "Source Subtype" = field("Document Type"),
#pragma warning restore
                                                                   "Reservation Status" = const(Reservation)));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(96; Reserve; Enum "Reserve Method")
        {
            AccessByPermission = TableData Item = R;
            Caption = 'Reserve';


        }
        field(97; "Blanket Order No."; Code[20])
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Blanket Order No.';
            TableRelation = CabVenta."No." where("Document Type" = const("Blanket Order"));


        }
        field(98; "Blanket Order Line No."; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Blanket Order Line No.';
            TableRelation = "Sales Line"."Line No." where("Document Type" = const("Blanket Order"),
                                                           "Document No." = field("Blanket Order No."));


        }
        field(99; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            Editable = false;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;

            Caption = 'Line Amount';


        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            Editable = false;
        }
        field(105; "Inv. Disc. Amount to Invoice"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Disc. Amount to Invoice';
            Editable = false;
        }
        field(106; "VAT Identifier"; Code[20])
        {
            Caption = 'VAT Identifier';
            Editable = false;
        }
        field(107; "IC Partner Ref. Type"; Enum "IC Partner Reference Type")
        {
            AccessByPermission = TableData "IC G/L Account" = R;
            Caption = 'IC Partner Ref. Type';


        }
        field(108; "IC Partner Reference"; Code[20])
        {
            AccessByPermission = TableData "IC G/L Account" = R;
            Caption = 'IC Partner Reference';


        }
        field(109; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;


        }
        field(110; "Prepmt. Line Amount"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;

            Caption = 'Prepmt. Line Amount';
            MinValue = 0;


        }
        field(111; "Prepmt. Amt. Inv."; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;

            Caption = 'Prepmt. Amt. Inv.';
            Editable = false;
        }
        field(112; "Prepmt. Amt. Incl. VAT"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amt. Incl. VAT';
            Editable = false;
        }
        field(113; "Prepayment Amount"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepayment Amount';
            Editable = false;
        }
        field(114; "Prepmt. VAT Base Amt."; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. VAT Base Amt.';
            Editable = false;
        }
        field(115; "Prepayment VAT %"; Decimal)
        {
            Caption = 'Prepayment VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(116; "Prepmt. VAT Calc. Type"; Enum "Tax Calculation Type")
        {
            Caption = 'Prepmt. VAT Calc. Type';
            Editable = false;
        }
        field(117; "Prepayment VAT Identifier"; Code[20])
        {
            Caption = 'Prepayment VAT Identifier';
            Editable = false;
        }
        field(118; "Prepayment Tax Area Code"; Code[20])
        {
            Caption = 'Prepayment Tax Area Code';
            TableRelation = "Tax Area";


        }
        field(119; "Prepayment Tax Liable"; Boolean)
        {
            Caption = 'Prepayment Tax Liable';


        }
        field(120; "Prepayment Tax Group Code"; Code[20])
        {
            Caption = 'Prepayment Tax Group Code';
            TableRelation = "Tax Group";


        }
        field(121; "Prepmt Amt to Deduct"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;

            Caption = 'Prepmt Amt to Deduct';
            MinValue = 0;


        }
        field(122; "Prepmt Amt Deducted"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;

            Caption = 'Prepmt Amt Deducted';
            Editable = false;
        }
        field(123; "Prepayment Line"; Boolean)
        {
            Caption = 'Prepayment Line';
            Editable = false;
        }
        field(124; "Prepmt. Amount Inv. Incl. VAT"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amount Inv. Incl. VAT';
            Editable = false;
        }
        field(129; "Prepmt. Amount Inv. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Prepmt. Amount Inv. (LCY)';
            Editable = false;
        }
        field(130; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";


        }
        field(132; "Prepmt. VAT Amount Inv. (LCY)"; Decimal)
        {
            Caption = 'Prepmt. VAT Amount Inv. (LCY)';
            Editable = false;
        }
        field(135; "Prepayment VAT Difference"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepayment VAT Difference';
            Editable = false;
        }
        field(136; "Prepmt VAT Diff. to Deduct"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt VAT Diff. to Deduct';
            Editable = false;
        }
        field(137; "Prepmt VAT Diff. Deducted"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt VAT Diff. Deducted';
            Editable = false;
        }
        field(138; "IC Item Reference No."; Code[50])
        {
            AccessByPermission = TableData "Item Reference" = R;
            Caption = 'IC Item Reference No.';


        }
        field(145; "Pmt. Discount Amount"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Pmt. Discount Amount';


        }
        field(146; "Prepmt. Pmt. Discount Amount"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Pmt. Discount Amount';
            Editable = false;
        }
        field(180; "Line Discount Calculation"; Option)
        {
            Caption = 'Line Discount Calculation';
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";


        }
        field(900; "Qty. to Assemble to Order"; Decimal)
        {
            AccessByPermission = TableData "BOM Component" = R;
            Caption = 'Qty. to Assemble to Order';
            DecimalPlaces = 0 : 5;


        }
        field(901; "Qty. to Asm. to Order (Base)"; Decimal)
        {
            Caption = 'Qty. to Asm. to Order (Base)';
            DecimalPlaces = 0 : 5;


        }
        field(902; "ATO Whse. Outstanding Qty."; Decimal)
        {
            AccessByPermission = TableData "BOM Component" = R;
            BlankZero = true;
            CalcFormula = sum("Warehouse Shipment Line"."Qty. Outstanding" where("Source Type" = const(37),
#pragma warning disable AL0603
                                                                                  "Source Subtype" = field("Document Type"),
#pragma warning restore
                                                                                  "Source No." = field("Document No."),
                                                                                  "Source Line No." = field("Line No."),
                                                                                  "Assemble to Order" = filter(true)));
            Caption = 'ATO Whse. Outstanding Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(903; "ATO Whse. Outstd. Qty. (Base)"; Decimal)
        {
            AccessByPermission = TableData "BOM Component" = R;
            BlankZero = true;
            CalcFormula = sum("Warehouse Shipment Line"."Qty. Outstanding (Base)" where("Source Type" = const(37),
#pragma warning disable AL0603
                                                                                         "Source Subtype" = field("Document Type"),
#pragma warning restore
                                                                                         "Source No." = field("Document No."),
                                                                                         "Source Line No." = field("Line No."),
                                                                                         "Assemble to Order" = filter(true)));
            Caption = 'ATO Whse. Outstd. Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Project Task No.';
            Editable = false;
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(1002; "Job Contract Entry No."; Integer)
        {
            AccessByPermission = TableData Job = R;
            Caption = 'Project Contract Entry No.';
            Editable = false;


        }
        field(1300; "Posting Date"; Date)
        {
            CalcFormula = lookup(CabVenta."Posting Date" where("Document Type" = field("Document Type"),
                                                                      "No." = field("Document No.")));
            Caption = 'Posting Date';
            FieldClass = FlowField;
        }
        field(1700; "Deferral Code"; Code[10])
        {
            Caption = 'Deferral Code';
            TableRelation = "Deferral Template"."Deferral Code";


        }
        field(1702; "Returns Deferral Start Date"; Date)
        {
            Caption = 'Returns Deferral Start Date';


        }
        field(2675; "Selected Alloc. Account No."; Code[20])
        {
            Caption = 'Allocation Account No.';
            DataClassification = CustomerContent;
            TableRelation = "Allocation Account";
        }
        field(2677; "Alloc. Acc. Modified by User"; Boolean)
        {
            Caption = 'Allocation Account Distributions Modified';
            FieldClass = FlowField;
            CalcFormula = exist("Alloc. Acc. Manual Override" where("Parent System Id" = field(SystemId), "Parent Table Id" = const(Database::"Sales Line")));
        }
        field(2678; "Allocation Account No."; Code[20])
        {
            Caption = 'Posting Allocation Account No.';
            DataClassification = CustomerContent;
            TableRelation = "Allocation Account";
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type = const(Item), "Document Type" = filter(<> "Credit Memo" & <> "Return Order")) "Item Variant".Code where("Item No." = field("No."), Blocked = const(false), "Sales Blocked" = const(false))
            else
            if (Type = const(Item), "Document Type" = filter("Credit Memo" | "Return Order")) "Item Variant".Code where("Item No." = field("No."), Blocked = const(false));


        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = if ("Document Type" = filter(Order | Invoice),
                                Quantity = filter(>= 0),
                                "Qty. to Asm. to Order (Base)" = const(0)) "Bin Content"."Bin Code" where("Location Code" = field("Location Code"),
                                                                                                         "Item No." = field("No."),
                                                                                                         "Variant Code" = field("Variant Code"))
            else
            if ("Document Type" = filter("Return Order" | "Credit Memo"),
                                                                                                                  Quantity = filter(< 0)) "Bin Content"."Bin Code" where("Location Code" = field("Location Code"),
                                                                                                                                                                       "Item No." = field("No."),
                                                                                                                                                                       "Variant Code" = field("Variant Code"))
            else
            Bin.Code where("Location Code" = field("Location Code"));


        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5405; Planned; Boolean)
        {
            Caption = 'Planned';
            Editable = false;
        }
        field(5406; "Qty. Rounding Precision"; Decimal)
        {
            Caption = 'Qty. Rounding Precision';
            InitValue = 0;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 1;
            Editable = false;
        }
        field(5408; "Qty. Rounding Precision (Base)"; Decimal)
        {
            Caption = 'Qty. Rounding Precision (Base)';
            InitValue = 0;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 1;
            Editable = false;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if (Type = const(Item),
                                "No." = filter(<> '')) "Item Unit of Measure".Code where("Item No." = field("No."))
            else
            if (Type = const(Resource),
                                         "No." = filter(<> '')) "Resource Unit of Measure".Code where("Resource No." = field("No."))
            else
            if (Type = filter("Charge (Item)" | "Fixed Asset" | "G/L Account")) "Unit of Measure";


        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;


        }
        field(5416; "Outstanding Qty. (Base)"; Decimal)
        {
            Caption = 'Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5417; "Qty. to Invoice (Base)"; Decimal)
        {
            Caption = 'Qty. to Invoice (Base)';
            DecimalPlaces = 0 : 5;


        }
        field(5418; "Qty. to Ship (Base)"; Decimal)
        {
            Caption = 'Qty. to Ship (Base)';
            DecimalPlaces = 0 : 5;


        }
        field(5458; "Qty. Shipped Not Invd. (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invd. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5460; "Qty. Shipped (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5495; "Reserved Qty. (Base)"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = - sum("Reservation Entry"."Quantity (Base)" where("Source ID" = field("Document No."),
                                                                            "Source Ref. No." = field("Line No."),
                                                                            "Source Type" = const(37),
#pragma warning disable AL0603
                                                                            "Source Subtype" = field("Document Type"),
#pragma warning restore
                                                                            "Reservation Status" = const(Reservation)));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5600; "FA Posting Date"; Date)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'FA Posting Date';
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";


        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'Depr. until FA Posting Date';
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            Caption = 'Duplicate in Depreciation Book';
            TableRelation = "Depreciation Book";


        }
        field(5613; "Use Duplication List"; Boolean)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'Use Duplication List';


        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";


        }
        field(5701; "Out-of-Stock Substitution"; Boolean)
        {
            Caption = 'Out-of-Stock Substitution';
            Editable = false;
        }
        field(5702; "Substitution Available"; Boolean)
        {
            CalcFormula = exist("Item Substitution" where(Type = const(Item),
                                                           "No." = field("No."),
                                                           "Substitute Type" = const(Item)));
            Caption = 'Substitution Available';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5703; "Originally Ordered No."; Code[20])
        {
            AccessByPermission = TableData "Item Substitution" = R;
            Caption = 'Originally Ordered No.';
            TableRelation = if (Type = const(Item)) Item;
        }
        field(5704; "Originally Ordered Var. Code"; Code[10])
        {
            AccessByPermission = TableData "Item Substitution" = R;
            Caption = 'Originally Ordered Var. Code';
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field("Originally Ordered No."));
        }
        field(5705; "Cross-Reference No."; Code[20])
        {

        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {

        }
        field(5707; "Cross-Reference Type"; Option)
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ",Customer,Vendor,"Bar Code";

        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            Caption = 'Cross-Reference Type No.';

        }
        field(5709; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(5710; Nonstock; Boolean)
        {
            AccessByPermission = TableData "Nonstock Item" = R;
            Caption = 'Catalog';
            Editable = false;
        }
        field(5711; "Purchasing Code"; Code[10])
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;


        }
        field(5712; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';

        }
        field(5713; "Special Order"; Boolean)
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Special Order';
            Editable = false;
        }
        field(5714; "Special Order Purchase No."; Code[20])
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Special Order Purchase No.';
            TableRelation = if ("Special Order" = const(true)) "Purchase Header"."No." where("Document Type" = const(Order));
        }
        field(5715; "Special Order Purch. Line No."; Integer)
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Special Order Purch. Line No.';
            TableRelation = if ("Special Order" = const(true)) "Purchase Line"."Line No." where("Document Type" = const(Order),
                                                                                               "Document No." = field("Special Order Purchase No."));
        }
        field(5725; "Item Reference No."; Code[50])
        {
            AccessByPermission = TableData "Item Reference" = R;
            Caption = 'Item Reference No.';
            ExtendedDatatype = Barcode;


        }
        field(5726; "Item Reference Unit of Measure"; Code[10])
        {
            AccessByPermission = TableData "Item Reference" = R;
            Caption = 'Reference Unit of Measure';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."));
        }
        field(5727; "Item Reference Type"; Enum "Item Reference Type")
        {
            Caption = 'Item Reference Type';
        }
        field(5728; "Item Reference Type No."; Code[30])
        {
            Caption = 'Item Reference Type No.';
        }
        field(5749; "Whse. Outstanding Qty."; Decimal)
        {
            AccessByPermission = TableData Location = R;
            BlankZero = true;
            CalcFormula = sum("Warehouse Shipment Line"."Qty. Outstanding" where("Source Type" = const(37),
#pragma warning disable AL0603
                                                                                  "Source Subtype" = field("Document Type"),
#pragma warning restore
                                                                                  "Source No." = field("Document No."),
                                                                                  "Source Line No." = field("Line No.")));
            Caption = 'Whse. Outstanding Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5750; "Whse. Outstanding Qty. (Base)"; Decimal)
        {
            AccessByPermission = TableData Location = R;
            BlankZero = true;
            CalcFormula = sum("Warehouse Shipment Line"."Qty. Outstanding (Base)" where("Source Type" = const(37),
#pragma warning disable AL0603
                                                                                         "Source Subtype" = field("Document Type"),
#pragma warning restore
                                                                                         "Source No." = field("Document No."),
                                                                                         "Source Line No." = field("Line No.")));
            Caption = 'Whse. Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            Caption = 'Completely Shipped';
            Editable = false;
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
            AccessByPermission = TableData "Order Promising Line" = R;
            Caption = 'Shipping Time';


        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            AccessByPermission = TableData Location = R;
            Caption = 'Outbound Whse. Handling Time';


        }
        field(5794; "Planned Delivery Date"; Date)
        {
            AccessByPermission = TableData "Order Promising Line" = R;
            Caption = 'Planned Delivery Date';


        }
        field(5795; "Planned Shipment Date"; Date)
        {
            AccessByPermission = TableData "Order Promising Line" = R;
            Caption = 'Planned Shipment Date';


        }
        field(5796; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";


        }
        field(5797; "Shipping Agent Service Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = field("Shipping Agent Code"));


        }
        field(5800; "Allow Item Charge Assignment"; Boolean)
        {
            AccessByPermission = TableData "Item Charge" = R;
            Caption = 'Allow Item Charge Assignment';
            InitValue = true;


        }
        field(5801; "Qty. to Assign"; Decimal)
        {
            CalcFormula = sum("Item Charge Assignment (Sales)"."Qty. to Assign" where("Document Type" = field("Document Type"),
                                                                                       "Document No." = field("Document No."),
                                                                                       "Document Line No." = field("Line No.")));
            Caption = 'Qty. to Assign';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5802; "Qty. Assigned"; Decimal)
        {
            CalcFormula = sum("Item Charge Assignment (Sales)"."Qty. Assigned" where("Document Type" = field("Document Type"),
                                                                                      "Document No." = field("Document No."),
                                                                                      "Document Line No." = field("Line No.")));
            Caption = 'Qty. Assigned';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5803; "Return Qty. to Receive"; Decimal)
        {
            AccessByPermission = TableData "Return Receipt Header" = R;
            Caption = 'Return Qty. to Receive';
            DecimalPlaces = 0 : 5;


        }
        field(5804; "Return Qty. to Receive (Base)"; Decimal)
        {
            Caption = 'Return Qty. to Receive (Base)';
            DecimalPlaces = 0 : 5;


        }
        field(5805; "Return Qty. Rcd. Not Invd."; Decimal)
        {
            Caption = 'Return Qty. Rcd. Not Invd.';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5806; "Ret. Qty. Rcd. Not Invd.(Base)"; Decimal)
        {
            Caption = 'Ret. Qty. Rcd. Not Invd.(Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5807; "Return Rcd. Not Invd."; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Return Rcd. Not Invd.';
            Editable = false;


        }
        field(5808; "Return Rcd. Not Invd. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Return Rcd. Not Invd. (LCY)';
            Editable = false;
        }
        field(5809; "Return Qty. Received"; Decimal)
        {
            AccessByPermission = TableData "Return Receipt Header" = R;
            Caption = 'Return Qty. Received';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5810; "Return Qty. Received (Base)"; Decimal)
        {
            Caption = 'Return Qty. Received (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            AccessByPermission = TableData Item = R;
            Caption = 'Appl.-from Item Entry';
            MinValue = 0;


        }
        field(5812; "Item Charge Qty. to Handle"; Decimal)
        {
            CalcFormula = sum("Item Charge Assignment (Sales)"."Qty. to Handle" where("Document Type" = field("Document Type"),
                                                                                       "Document No." = field("Document No."),
                                                                                       "Document Line No." = field("Line No.")));
            Caption = 'Item Charge Qty. to Handle';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5909; "BOM Item No."; Code[20])
        {
            Caption = 'BOM Item No.';
            TableRelation = Item;
        }
        field(6600; "Return Receipt No."; Code[20])
        {
            Caption = 'Return Receipt No.';
            Editable = false;
        }
        field(6601; "Return Receipt Line No."; Integer)
        {
            Caption = 'Return Receipt Line No.';
            Editable = false;
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";


        }
        field(6610; "Copied From Posted Doc."; Boolean)
        {
            Caption = 'Copied From Posted Doc.';
            DataClassification = SystemMetadata;
        }
        field(7000; "Price Calculation Method"; Enum "Price Calculation Method")
        {
            Caption = 'Price Calculation Method';
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
        }
        field(7002; "Customer Disc. Group"; Code[20])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";


        }
        field(7003; Subtype; Option)
        {
            Caption = 'Subtype';
            OptionCaption = ' ,Item - Inventory,Item - Service,Comment';
            OptionMembers = " ","Item - Inventory","Item - Service",Comment;
        }
        field(7004; "Price description"; Text[80])
        {
            Caption = 'Price description';
        }
        field(7010; "Attached Doc Count"; Integer)
        {
            BlankNumbers = DontBlank;
            CalcFormula = count("Document Attachment" where("Table ID" = const(37),
                                                             "No." = field("Document No."),
                                                             "Document Type" = field("Document Type"),
                                                             "Line No." = field("Line No.")));
            Caption = 'Attached Doc Count';
            FieldClass = FlowField;
            InitValue = 0;
        }
        field(7011; "Attached Lines Count"; Integer)
        {
            CalcFormula = count("Sales Line" where("Document Type" = field("Document Type"),
                                                    "Document No." = field("Document No."),
                                                    "Attached to Line No." = field("Line No."),
                                                    Quantity = filter(<> 0)));
            Caption = 'Attached Lines Count';
            Editable = false;
            FieldClass = FlowField;
            BlankZero = true;
        }
        field(10700; "Pmt. Disc. Given Amount (Old)"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Pmt. Disc. Given Amount (Old)';
            Editable = false;

        }
        field(10701; "EC %"; Decimal)
        {
            Caption = 'EC %';
        }
        field(10702; "EC Difference"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'EC Difference';
            Editable = false;
        }
        field(10703; "Prepayment EC %"; Decimal)
        {
            Caption = 'Prepayment EC %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(10704; "Special Scheme Code"; Enum "SII Sales Special Scheme Code")
        {
            Caption = 'Special Scheme Code';
        }
        field(50003; "Precio base"; Decimal)
        {
            Editable = false;
        }
        field(50004; "Precio final"; Decimal)
        {
            Editable = false;
        }
        field(50005; "Usuario alta"; Code[30])
        {
            Editable = false;
        }
        field(50006; "Fecha alta"; Date)
        {
            Editable = false;
        }
        field(50007; "Hora alta"; Time)
        {
            Editable = false;
        }
        field(50008; "Estado linea"; Option)
        {
            Editable = false;
            InitValue = Pendiente;
            OptionMembers = Pendiente,Servida,Cancelada,Resto;


        }
        field(50017; Defectuosos; Boolean)
        {


        }
        field(50019; "Dto 2009"; Decimal)
        {
        }
        field(50021; "Corrected Invoice No."; Code[20])
        {
            Caption = 'Corrected Invoice No.';

        }
        field(50022; "Linea correccion"; Integer)
        {
        }
        field(50023; Vendedor; Code[10])
        {
        }
        field(50024; "Importe dto. vendedor"; Decimal)
        {
        }
        field(50027; "Nº expedición"; Code[10])
        {
        }
        field(50028; "Linea Nº expedición"; Integer)
        {
            Caption = 'Linea Nº expedición';
        }
        field(50029; "Producto asociado"; Integer)
        {
        }
        field(50031; "Precio final sin dto.comer"; Decimal)
        {
        }
        field(50032; "Acumula Importe dto. comer"; Decimal)
        {
            Editable = false;
        }
        field(50057; "Cantidad a pasar pedido"; Decimal)
        {


        }
        field(50062; "Nº lote"; Code[20])
        {
        }
        field(50063; "Fecha caducidad"; Date)
        {
        }
        field(50068; "Cantidad anulada"; Decimal)
        {
            Editable = false;
        }
        field(50075; "Your Reference 2"; Code[10])
        {
            Caption = 'Your Reference';
        }
        field(50080; "Precio importado"; Decimal)
        {
        }
        field(50082; "id linea externo"; Code[100])
        {
        }
        field(50119; ean; Code[20])
        {
            CalcFormula = lookup(Item.ean where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50120; Referencia; Code[20])
        {

        }
        field(50125; "Cantidad master"; Decimal)
        {
            CalcFormula = lookup("Item Unit of Measure"."Qty. per Unit of Measure" where("Item No." = field("No."),
                                                                                          Code = const('MA')));
            FieldClass = FlowField;
        }
        field(50126; "Cantidad inner"; Decimal)
        {
            CalcFormula = lookup("Item Unit of Measure"."Qty. per Unit of Measure" where("Item No." = field("No."),
                                                                                          Code = const('IN')));
            FieldClass = FlowField;
        }
        field(50129; "Unidades venta"; Decimal)
        {
            CalcFormula = lookup(Item."Unidades venta" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50267; "Enviar a ADAIA"; Boolean)
        {
        }
        field(50510; "Descuento sin vendedor"; Decimal)
        {
        }
        field(50511; "Importe sin dto vendedor"; Decimal)
        {
        }
        field(50514; "Importe acumulado pedido"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Line Amount" where("Document Type" = field("Document Type"),
                                                                "Document No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50515; "% Dto. vendedor"; Decimal)
        {

        }
        field(50581; "Tipo preparacion"; Option)
        {
            CalcFormula = lookup(Item."Tipo preparacion" where("No." = field("No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,0-Sin Caja,1-Muy pequeño,2-Pequeño,3-Mediano,4-Grande,5- Extra Grande,6- Tubo';
            OptionMembers = " ","0-Sin Caja","1-Muy pequeño","2-Pequeño","3-Mediano","4-Grande","5- Extra Grande","6- Tubo";
        }
        field(50582; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
        }
        field(50584; "Precio Tarifa"; Decimal)
        {
        }
        field(50585; "Suma cdad padre_hijos"; Decimal)
        {
        }
        field(50586; "Dto% apli. lin."; Decimal)
        {
            Editable = false;
        }
        field(50587; "Incremento dto%"; Decimal)
        {


        }
        field(50588; "Line Discount % original"; Decimal)
        {
        }
        field(50590; "Importe inicial vendedor"; Decimal)
        {
            Editable = false;
        }
        field(50591; ImpLinea; Decimal)
        {
        }
        field(50592; "Producto Padre"; Code[20])
        {
        }
        field(50593; "Suma cdad. por envio"; Decimal)
        {

            CalcFormula = sum("Sales Line"."Outstanding Qty. (Base)" where("Nº expedición" = field("Nº expedición"),
                                                                         "No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50594; "Cantidad padre"; Decimal)
        {
            CalcFormula = sum("Sales Line".Quantity where("Document Type" = field("Document Type"),
                                                           "Document No." = field("Document No."),
                                                           "Producto Padre" = field("Producto Padre")));
            FieldClass = FlowField;
        }
        field(50595; "ean canarias"; Code[20])
        {
        }
        field(50596; "prod canarias"; Code[20])
        {
        }
        field(50597; "Linea pedido externo"; Code[20])
        {
        }
        field(50598; "Producto con reserva"; Boolean)
        {
            CalcFormula = lookup(Item."Producto con reserva" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50599; "Grupo clientes"; Code[20])
        {
            CalcFormula = lookup(Customer."Grupo clientes" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
        }
        field(50600; "Fecha cabecera ofer/ped"; Date)
        {
            CalcFormula = lookup(CabVenta."Order Date" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50601; "Estado presupuesto"; Option)
        {
            CalcFormula = lookup(CabVenta."Estado presupuesto" where("No." = field("Document No.")));
            FieldClass = FlowField;
            OptionMembers = Activo,"Parcialmente procesado",Procesado;
        }
        field(50602; existe; Boolean)
        {
            CalcFormula = exist(CabVenta where("Document Type" = field("Document Type"),
                                                      "No." = field("Document No.")));
            FieldClass = FlowField;
        }

        field(50503; "Estado"; Text[10])
        {
        }

        field(50504; RefLinProdWeb; Code[20])
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
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key3; "Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date")
        {
            IncludedFields = "Outstanding Qty. (Base)";
        }
        key(Key4; "Document Type", "Bill-to Customer No.", "Currency Code", "Document No.")
        {
            IncludedFields = "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)", "Return Rcd. Not Invd. (LCY)", "Prepmt. Amount Inv. (LCY)", "Prepmt. VAT Amount Inv. (LCY)", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "VAT %";
        }
        key(Key7; "Document Type", "Blanket Order No.", "Blanket Order Line No.")
        {
        }
        key(Key8; "Document Type", "Document No.", "Location Code")
        {
            IncludedFields = Amount, "Amount Including VAT", "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)";
        }
        key(Key9; "Document Type", "Shipment No.", "Shipment Line No.")
        {
        }
        key(Key10; Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Document Type", "Shipment Date")
        {
        }
        key(Key11; "Document Type", "Sell-to Customer No.", "Shipment No.", "Document No.")
        {
            IncludedFields = "Outstanding Amount (LCY)";
        }
        key(Key12; "Job Contract Entry No.")
        {
        }
        key(Key15; "Recalculate Invoice Disc.")
        {
        }
        key(Key16; "Qty. Shipped Not Invoiced")
        {
        }
        key(Key17; "Qty. Shipped (Base)")
        {
        }
        key(Key18; "Shipment Date", "Outstanding Quantity")
        {
        }
        key(Key19; SystemModifiedAt)
        {
        }
        key(Key20; "Completely Shipped")
        {
        }
        key(Key21; "Document Type", "Document No.", Type, "No.", "System-Created Entry")
        {
            IncludedFields = Quantity, "Outstanding Qty. (Base)";
        }
        key(Key22; "Document No.", Type, "No.")
        {
            IncludedFields = Quantity;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, "Line Amount", Quantity, "Unit of Measure Code", "Price description")
        {
        }
        fieldgroup(Brick; "No.", Description, "Line Amount", Quantity, "Unit of Measure Code", "Price description")
        {
        }
    }

}

