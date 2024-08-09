#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50047 "Inventario PMP"
{
    Caption = 'Inventario PMP';
    DrillDownPageID = "Item Journal Lines";
    LookupPageID = "Item Journal Lines";

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Item Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;

            trigger OnValidate()
            var
                ProdOrderLine: Record "Prod. Order Line";
                ProdOrderComp: Record "Prod. Order Component";
            begin
            end;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(8; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(13; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                CallWhseCheck: Boolean;
            begin
            end;
        }
        field(17; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
        }
        field(18; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(20; doc1; Code[20])
        {
        }
        field(21; fecha1; Date)
        {
        }
        field(22; cantidad1; Decimal)
        {
        }
        field(23; precio1; Decimal)
        {
        }
        field(24; doc2; Code[20])
        {
        }
        field(25; fecha2; Date)
        {
        }
        field(26; cantidad2; Decimal)
        {
        }
        field(27; precio2; Decimal)
        {
        }
        field(28; doc3; Code[20])
        {
        }
        field(29; fecha3; Date)
        {
        }
        field(30; cantidad3; Decimal)
        {
        }
        field(31; precio3; Decimal)
        {
        }
        field(32; doc4; Code[20])
        {
        }
        field(33; fecha4; Date)
        {
        }
        field(34; cantidad4; Decimal)
        {
        }
        field(35; precio4; Decimal)
        {
        }
        field(36; doc5; Code[20])
        {
        }
        field(37; fecha5; Date)
        {
        }
        field(38; cantidad5; Decimal)
        {
        }
        field(39; precio5; Decimal)
        {
        }
        field(40; doc6; Code[20])
        {
        }
        field(41; fecha6; Date)
        {
        }
        field(42; cantidad6; Decimal)
        {
        }
        field(43; precio6; Decimal)
        {
        }
        field(44; doc7; Code[20])
        {
        }
        field(45; fecha7; Date)
        {
        }
        field(46; cantidad7; Decimal)
        {
        }
        field(47; precio7; Decimal)
        {
        }
        field(48; doc8; Code[20])
        {
        }
        field(49; fecha8; Date)
        {
        }
        field(50; cantidad8; Decimal)
        {
        }
        field(51; precio8; Decimal)
        {
        }
        field(52; doc9; Code[20])
        {
        }
        field(53; fecha9; Date)
        {
        }
        field(54; cantidad9; Decimal)
        {
        }
        field(55; precio9; Decimal)
        {
        }
        field(56; doc10; Code[20])
        {
        }
        field(57; fecha10; Date)
        {
        }
        field(58; cantidad10; Decimal)
        {
        }
        field(59; precio10; Decimal)
        {
        }
        field(60; "Clasificación A,B,C"; Option)
        {
            CalcFormula = lookup(Item."Clasificación A,B,C" where("No." = field("Item No.")));
            FieldClass = FlowField;
            InitValue = C;
            OptionCaption = 'A,B,C';
            OptionMembers = A,B,C;
        }
        field(61; ean; Code[20])
        {
            CalcFormula = lookup(Item.ean where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(62; "Vendor Item No."; Text[20])
        {
            CalcFormula = lookup(Item."Vendor Item No." where("No." = field("Item No.")));
            Caption = 'Vendor Item No.';
            FieldClass = FlowField;
        }
        field(63; "Nombre Vendedor"; Text[80])
        {
        }
        field(64; "Estado Producto"; Option)
        {
            CalcFormula = lookup(Item."Estado Producto" where("No." = field("Item No.")));
            FieldClass = FlowField;
            OptionCaption = 'Activo,Descatalogado,Anulado,Sin actualizar';
            OptionMembers = Activo,Descatalogado,Anulado,"Sin actualizar";

            trigger OnValidate()
            begin
                /*
                     RecITEMPepe.CHANGECOMPANY('PEPE');
                     IF RecITEMPepe.GET("No.") THEN BEGIN
                          RecITEMPepe."Estado Producto":=Rec."Estado Producto";
                          RecITEMPepe.MODIFY;
                     END;
                     IF "Estado Producto"=1 THEN BEGIN
                          "Fecha Descatalogación":=TODAY;
                     END;
                     IF "Estado Producto"=0 THEN BEGIN
                          "Fecha Descatalogación":=0D;
                     END;
                     */

            end;
        }
        field(65; "Tarifa 2022-2"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Unit Price" where("Item No." = field("Item No."),
                                                                   "Sales Code" = const('2022-2')));
            Caption = 'Tarifa 2022-2';
            FieldClass = FlowField;
        }
        field(66; "PVP Recomendado 2022-2"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Precio recomendado" where("Item No." = field("Item No."),
                                                                           "Sales Code" = const('2022-2')));
            Caption = 'PVP Recomendado 2022-2';
            FieldClass = FlowField;
        }
        field(67; cuantos; Integer)
        {
            CalcFormula = count("Inventario PMP" where("Posting Date" = field("Posting Date"),
                                                        "Item No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(68; "Tarifa AMZ2023"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Unit Price" where("Item No." = field("Item No."),
                                                                   "Sales Code" = const('AMZ2023')));
            Caption = 'Tarifa AMZ2023';
            FieldClass = FlowField;
        }
        field(69; "Ref. AMAZON"; Code[20])
        {
            CalcFormula = lookup(Item."Ref. AMAZON" where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Line No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: label '%1 must be reduced.';
        Text002: label 'You cannot change %1 when %2 is %3.';
        Text006: label 'You must not enter %1 in a revaluation sum line.';
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        GLSetup: Record "General Ledger Setup";
        MfgSetup: Record "Manufacturing Setup";
        WorkCenter: Record "Work Center";
        MachineCenter: Record "Machine Center";
        Location: Record Location;
        Bin: Record Bin;
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
        //NoSeriesMgt: Codeunit UnknownCodeunit396;
        UOMMgt: Codeunit "Unit of Measure Management";
        DimMgt: Codeunit DimensionManagement;
        UserMgt: Codeunit "User Setup Management";
        CalendarMgt: Codeunit "Shop Calendar Management";
        CostCalcMgt: Codeunit "Cost Calculation Management";
        WMSManagement: Codeunit "WMS Management";
        WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
        PhysInvtEntered: Boolean;
        GLSetupRead: Boolean;
        MfgSetupRead: Boolean;
        UnitCost: Decimal;
        Text007: label 'New ';
        UpdateInterruptedErr: label 'The update has been interrupted to respect the warning.';
        Text021: label 'The entered bin code %1 is different from the bin code %2 in production order component %3.\\Are you sure that you want to post the consumption from bin code %1?';
        Text029: label 'must be positive';
        Text030: label 'must be negative';
        Text031: label 'You can not insert item number %1 because it is not produced on released production order %2.';
        Text032: label 'When posting, the entry %1 will be opened first.';
        Text033: label 'If the item carries serial or lot numbers, then you must use the %1 field in the %2 window.';
        Text034: label 'You cannot revalue individual item ledger entries for items that use the average costing method.';
        SubcontractedErr: label '%1 must be zero in line number %2 because it is linked to the subcontracted work center.', Comment = '%1 - Field Caption, %2 - Line No.';
        FinishedOutputQst: label 'The operation has been finished. Do you want to post output for the finished operation?';
}

