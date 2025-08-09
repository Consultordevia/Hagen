pageextension 50063 BankAccReconciliation extends "Bank Acc. Reconciliation"
{
    actions
    {
        addlast(navigation)
        {
            action(ImportarQ43)
            {
                ApplicationArea = Suite;
                Caption = 'Importar Q43';
                trigger OnAction()
                var
                    XMLconc: XmlPort Importacionconcilia;
                    Rec91: Record "User Setup";
                begin
                    Rec91.get(UserId);
                    Rec91.Concilia := Rec."Bank Account No.";
                    Rec91.extracto := Rec."Statement No.";
                    Rec91.Modify();
                    Commit();
                    Clear(XMLconc);
                    XMLconc.Run();

                end;
            }
        }
    }
}
