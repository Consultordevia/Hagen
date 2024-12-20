#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50014 "Mis Cobros pendientes"
{
    Caption = 'Mis Cobros pendientes';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Cust. Ledger Entry";
    SourceTableView = sorting("Salesperson Code", "Posting Date", Open)
                      where(Open = const(true),
                            "Document Type" = filter(Invoice | "Credit Memo"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = Basic;
                }
                field("Search Name"; Cust.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Original Amt. (LCY)"; Rec."Original Amt. (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Remaining Amt. (LCY)"; Rec."Remaining Amt. (LCY)")
                {
                    ApplicationArea = Basic;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Ver Total")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Accounts;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    VerFiltro;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        Cust.Init;
        if Cust.Get(Rec."Customer No.") then begin
        end;
    end;

    trigger OnOpenPage()
    begin

        UserSetup.Get(UserId);
        if UserSetup.Comercial <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange(Rec."Salesperson Code", UserSetup.Comercial);
            Rec.FilterGroup(0);
        end;
    end;

    var
        Cust: Record Customer;
        UserSetup: Record "User Setup";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Total: Decimal;
        RecCust: Record Customer;
    /////-RepCarta: Report UnknownReport50192;

    local procedure VerFiltro()
    begin


        Total := 0;
        CustLedgerEntry.CopyFilters(Rec);
        if CustLedgerEntry.FindFirst then
            repeat
                CustLedgerEntry.CalcFields(CustLedgerEntry."Remaining Amt. (LCY)");
                Total := Total + CustLedgerEntry."Remaining Amt. (LCY)";
            until CustLedgerEntry.Next = 0;


        Message('Total: %1', Total);
    end;
}

