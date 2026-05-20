page 50801 "Hagen Prepagos FactBox"
{
    Caption = 'Pagos Anticipados';
    PageType = ListPart;
    SourceTable = "Hagen Prepago Pedido";
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Importe';
                    StyleExpr = AmountStyle;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Estado';
                    StyleExpr = AmountStyle;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                    Caption = 'Banco';
                }
                field("Applied to Invoice No."; Rec."Applied to Invoice No.")
                {
                    ApplicationArea = All;
                    Caption = 'Factura';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AbrirPrepago)
            {
                ApplicationArea = All;
                Caption = 'Ver / Registrar';
                Image = Payment;
                RunObject = page "Hagen Registro Prepago";
                RunPageOnRec = true;
            }
        }
    }

    var
        AmountStyle: Text;

    trigger OnAfterGetRecord()
    begin
        case Rec.Status of
            Rec.Status::Pendiente:
                AmountStyle := 'Unfavorable';
            Rec.Status::Registrado:
                AmountStyle := 'Favorable';
            Rec.Status::Aplicado:
                AmountStyle := 'StrongAccent';
        end;
    end;
}
