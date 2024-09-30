#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50017 "Mis Cobros Vencidos"
{
    Caption = 'Mis Impagados';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Cust. Ledger Entry";
    SourceTableView = sorting("Salesperson Code", "Customer No.", Open)
                      where(Open = const(true),
                            "Remaining Amt. (LCY)" = filter(<> 0));

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
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic;
                }
                field("Remaining Amt. (LCY)"; Rec."Remaining Amt. (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Cliente; Nombre)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cliente';
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

        Nombre := '';
        Cust.Init;
        if Cust.Get(Rec."Customer No.") then begin
            Nombre := Cust."Search Name";
        end;
    end;

    trigger OnOpenPage()
    begin

        UserSetup.Get(UserId);
        if UserSetup."Salespers./Purch. Code" <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
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
        Nombre: Text;

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

