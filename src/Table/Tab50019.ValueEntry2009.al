#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50019 "Value Entry2009"
{
    Caption = 'Value Entry2009';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; "Item Ledger Entry Type"; Option)
        {
            Caption = 'Item Ledger Entry Type';
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(5; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = if ("Source Type" = const(Customer)) Customer
            else if ("Source Type" = const(Vendor)) Vendor
            else if ("Source Type" = const(Item)) Item;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(9; "Inventory Posting Group"; Code[20])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
        }
        field(10; "Source Posting Group"; Code[20])
        {
            Caption = 'Source Posting Group';
            TableRelation = if ("Source Type" = const(Customer)) "Customer Posting Group"
            else if ("Source Type" = const(Vendor)) "Vendor Posting Group"
            else if ("Source Type" = const(Item)) "Inventory Posting Group";
        }
        field(11; "Item Ledger Entry No."; Integer)
        {
            Caption = 'Item Ledger Entry No.';
            TableRelation = "Item Ledger Entry";
        }
        field(12; "Valued Quantity"; Decimal)
        {
            Caption = 'Valued Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(13; "Item Ledger Entry Quantity"; Decimal)
        {
            Caption = 'Item Ledger Entry Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(14; "Invoiced Quantity"; Decimal)
        {
            Caption = 'Invoiced Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(15; "Cost per Unit"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Cost per Unit';
        }
        field(17; "Sales Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales Amount (Actual)';
        }
        field(22; "Salespers./Purch. Code"; Code[20])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(23; "Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Discount Amount';
        }
        field(24; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                //UserMgt.LookupUserID("User ID");
            end;
        }
        field(25; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(28; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';
        }
        field(33; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(34; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(41; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Item';
            OptionMembers = " ",Customer,Vendor,Item;
        }
        field(43; "Cost Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Actual)';
        }
        field(45; "Cost Posted to G/L"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Posted to G/L';
        }
        field(46; "Reason Code"; Code[10])
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(47; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
        }
        field(48; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(57; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(58; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(60; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(61; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(68; "Cost Amount (Actual) (ACY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Actual) (ACY)';
        }
        field(70; "Cost Posted to G/L (ACY)"; Decimal)
        {
            AccessByPermission = TableData Currency = R;
            AutoFormatType = 1;
            Caption = 'Cost Posted to G/L (ACY)';
        }
        field(72; "Cost per Unit (ACY)"; Decimal)
        {
            AccessByPermission = TableData Currency = R;
            AutoFormatType = 2;
            Caption = 'Cost per Unit (ACY)';
        }
        field(79; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Sales Shipment,Sales Invoice,Sales Return Receipt,Sales Credit Memo,Purchase Receipt,Purchase Invoice,Purchase Return Shipment,Purchase Credit Memo,Transfer Shipment,Transfer Receipt,Service Shipment,Service Invoice,Service Credit Memo,Posted Assembly';
            OptionMembers = " ","Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo","Purchase Receipt","Purchase Invoice","Purchase Return Shipment","Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo","Posted Assembly";
        }
        field(80; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
        field(90; "Order Type"; Option)
        {
            Caption = 'Order Type';
            Editable = false;
            OptionCaption = ' ,Production,Transfer,Service,Assembly';
            OptionMembers = " ",Production,Transfer,Service,Assembly;
        }
        field(91; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            Editable = false;
        }
        field(92; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
            Editable = false;
        }
        field(98; "Expected Cost"; Boolean)
        {
            Caption = 'Expected Cost';
        }
        field(99; "Item Charge No."; Code[20])
        {
            Caption = 'Item Charge No.';
            TableRelation = "Item Charge";
        }
        field(100; "Valued By Average Cost"; Boolean)
        {
            Caption = 'Valued By Average Cost';
        }
        field(102; "Partial Revaluation"; Boolean)
        {
            Caption = 'Partial Revaluation';
        }
        field(103; Inventoriable; Boolean)
        {
            Caption = 'Inventoriable';
        }
        field(104; "Valuation Date"; Date)
        {
            Caption = 'Valuation Date';
        }
        field(105; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            Editable = false;
            OptionCaption = 'Direct Cost,Revaluation,Rounding,Indirect Cost,Variance';
            OptionMembers = "Direct Cost",Revaluation,Rounding,"Indirect Cost",Variance;
        }
        field(106; "Variance Type"; Option)
        {
            Caption = 'Variance Type';
            Editable = false;
            OptionCaption = ' ,Purchase,Material,Capacity,Capacity Overhead,Manufacturing Overhead,Subcontracted';
            OptionMembers = " ",Purchase,Material,Capacity,"Capacity Overhead","Manufacturing Overhead",Subcontracted;
        }
        field(148; "Purchase Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Purchase Amount (Actual)';
        }
        field(149; "Purchase Amount (Expected)"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            AutoFormatType = 1;
            Caption = 'Purchase Amount (Expected)';
        }
        field(150; "Sales Amount (Expected)"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            AutoFormatType = 1;
            Caption = 'Sales Amount (Expected)';
        }
        field(151; "Cost Amount (Expected)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Expected)';
        }
        field(152; "Cost Amount (Non-Invtbl.)"; Decimal)
        {
            AccessByPermission = TableData "Item Charge" = R;
            AutoFormatType = 1;
            Caption = 'Cost Amount (Non-Invtbl.)';
        }
        field(156; "Cost Amount (Expected) (ACY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Expected) (ACY)';
        }
        field(157; "Cost Amount (Non-Invtbl.)(ACY)"; Decimal)
        {
            AccessByPermission = TableData "Item Charge" = R;
            AutoFormatType = 1;
            Caption = 'Cost Amount (Non-Invtbl.)(ACY)';
        }
        field(158; "Expected Cost Posted to G/L"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Expected Cost Posted to G/L';
        }
        field(159; "Exp. Cost Posted to G/L (ACY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Exp. Cost Posted to G/L (ACY)';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(1000; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job."No.";
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(1002; "Job Ledger Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Job Ledger Entry No.';
            TableRelation = "Job Ledger Entry"."Entry No.";
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }
        field(5818; Adjustment; Boolean)
        {
            Caption = 'Adjustment';
            Editable = false;
        }
        field(5819; "Average Cost Exception"; Boolean)
        {
            Caption = 'Average Cost Exception';
        }
        field(5831; "Capacity Ledger Entry No."; Integer)
        {
            Caption = 'Capacity Ledger Entry No.';
            TableRelation = "Capacity Ledger Entry";
        }
        field(5832; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Work Center,Machine Center, ,Resource';
            OptionMembers = "Work Center","Machine Center"," ",Resource;
        }
        field(5834; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const("Machine Center")) "Machine Center"
            else if (Type = const("Work Center")) "Work Center"
            else if (Type = const(Resource)) Resource;
        }
        field(6602; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
        }
        field(50000; "Exento rappel"; Boolean)
        {
        }
        field(50001; "Importe coste real FIFO"; Decimal)
        {
        }
        field(50002; "Al coste"; Decimal)
        {
        }
        field(50003; "Liq. de"; Code[100])
        {
        }
        field(50004; "A MODIFICAR"; Boolean)
        {
        }
        field(50005; "DATO ANTERIOR COSTE"; Decimal)
        {
        }
        field(50006; "IMPORTE ANT. COSTE"; Decimal)
        {
        }
        field(50007; "Pedido WEB"; Boolean)
        {
        }
        field(50008; "usuario alta"; Code[20])
        {
            CalcFormula = lookup("Sales Invoice Line"."Usuario alta" where("Document No." = field("Document No."),
                                                                            "Line No." = field("Document Line No.")));
            FieldClass = FlowField;
        }
        field(50039; "Dto% cabecera"; Decimal)
        {
            Editable = false;
        }
        field(50040; "Cod. Oferta"; Code[12])
        {
            Editable = false;
        }
        field(50041; "Coste KIT"; Decimal)
        {
        }
        field(50042; "Coste KIT Agregado"; Decimal)
        {
        }
        field(50043; TRANS; Code[20])
        {
            CalcFormula = lookup(Customer."Shipping Agent Code" where("No." = field("Source No.")));
            FieldClass = FlowField;
        }
        field(50050; "Standard Cost"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = lookup(Item."Standard Cost" where("No." = field("Item No.")));
            Caption = 'Standard Cost';
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(50051; "umtimo 5802"; Integer)
        {
        }
        field(50052; Cod_Provee; Code[20])
        {
        }
        field(50053; Dropshipping; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Item Ledger Entry No.", "Entry Type")
        {
            SumIndexFields = "Invoiced Quantity", "Sales Amount (Expected)", "Sales Amount (Actual)", "Cost Amount (Expected)", "Cost Amount (Actual)", "Cost Amount (Non-Invtbl.)", "Cost Amount (Expected) (ACY)", "Cost Amount (Actual) (ACY)", "Cost Amount (Non-Invtbl.)(ACY)", "Purchase Amount (Actual)", "Purchase Amount (Expected)", "Discount Amount";
        }
        key(Key3; "Item Ledger Entry No.", "Document No.", "Document Line No.")
        {
            Enabled = false;
            MaintainSQLIndex = false;
        }
        key(Key4; "Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code")
        {
            SumIndexFields = "Invoiced Quantity", "Sales Amount (Expected)", "Sales Amount (Actual)", "Cost Amount (Expected)", "Cost Amount (Actual)", "Cost Amount (Non-Invtbl.)", "Purchase Amount (Actual)", "Expected Cost Posted to G/L", "Cost Posted to G/L", "Item Ledger Entry Quantity", "Cost Amount (Expected) (ACY)", "Cost Amount (Actual) (ACY)";
        }
        key(Key5; "Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Source Type", "Source No.")
        {
            Enabled = false;
            SumIndexFields = "Invoiced Quantity", "Sales Amount (Expected)", "Sales Amount (Actual)", "Cost Amount (Expected)", "Cost Amount (Actual)", "Cost Amount (Non-Invtbl.)", "Purchase Amount (Actual)", "Expected Cost Posted to G/L", "Cost Posted to G/L", "Item Ledger Entry Quantity";
        }
        key(Key6; "Document No.")
        {
        }
        key(Key7; "Item No.", "Valuation Date", "Location Code", "Variant Code")
        {
            SumIndexFields = "Cost Amount (Expected)", "Cost Amount (Actual)", "Cost Amount (Expected) (ACY)", "Cost Amount (Actual) (ACY)", "Item Ledger Entry Quantity";
        }
        key(Key8; "Source Type", "Source No.", "Item No.", "Posting Date", "Entry Type", Adjustment, "Item Ledger Entry Type")
        {
            SumIndexFields = "Discount Amount", "Cost Amount (Non-Invtbl.)", "Cost Amount (Actual)", "Cost Amount (Expected)", "Sales Amount (Actual)", "Sales Amount (Expected)", "Invoiced Quantity";
        }
        key(Key9; "Item Charge No.", "Inventory Posting Group", "Item No.")
        {
        }
        key(Key10; "Capacity Ledger Entry No.", "Entry Type")
        {
            SumIndexFields = "Cost Amount (Actual)", "Cost Amount (Actual) (ACY)";
        }
        key(Key11; "Order Type", "Order No.", "Order Line No.")
        {
        }
        key(Key12; "Source Type", "Source No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Item No.", "Posting Date", "Entry Type", Adjustment)
        {
            Enabled = false;
            SumIndexFields = "Discount Amount", "Cost Amount (Non-Invtbl.)", "Cost Amount (Actual)", "Cost Amount (Expected)", "Sales Amount (Actual)", "Sales Amount (Expected)", "Invoiced Quantity";
        }
        key(Key13; "Job No.", "Job Task No.", "Document No.")
        {
        }
        key(Key14; "Item Ledger Entry Type", "Posting Date", "Item No.", "Inventory Posting Group", "Dimension Set ID")
        {
            SumIndexFields = "Invoiced Quantity", "Sales Amount (Actual)", "Purchase Amount (Actual)";
        }
        key(Key15; "Item Ledger Entry No.", "Valuation Date")
        {
            Enabled = false;
        }
        key(Key16; "umtimo 5802")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Item Ledger Entry Type", "Item Ledger Entry No.", "Item No.", "Posting Date", "Source No.", "Document No.")
        {
        }
    }

    var
        GLSetup: Record "General Ledger Setup";
        GLSetupRead: Boolean;
}

