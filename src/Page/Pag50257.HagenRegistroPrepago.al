page 50257 "Hagen Registro Prepago"
{
    Caption = 'Registrar Pago Anticipado';
    PageType = Card;
    SourceTable = "Hagen Prepago Pedido";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Datos del Pago';

                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº Pedido';
                    Editable = false;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Cliente';
                    Editable = false;
                }
                field("Invoice to Other Customer"; Rec."Invoice to Other Customer")
                {
                    ApplicationArea = All;
                    Caption = 'Factura a otro cliente';
                    Editable = Rec.Status = Rec.Status::Pendiente;

                    trigger OnValidate()
                    begin
                        if not Rec."Invoice to Other Customer" then
                            Rec."Invoice Customer No." := '';
                        CurrPage.Update(false);
                    end;
                }
                field("Invoice Customer No."; Rec."Invoice Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Cliente Facturación';
                    Editable = Rec."Invoice to Other Customer" and (Rec.Status = Rec.Status::Pendiente);
                    ShowMandatory = Rec."Invoice to Other Customer";
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha Cobro';
                    Editable = Rec.Status = Rec.Status::Pendiente;
                }
                field("Company Bank Account No."; Rec."Company Bank Account No.")
                {
                    ApplicationArea = All;
                    Caption = 'Cta. Bancaria Empresa';
                    Editable = Rec.Status = Rec.Status::Pendiente;
                    ShowMandatory = true;
                    ToolTip = 'Cuenta bancaria de la empresa que recibe el pago. Configurable en Conf. ventas y cobros.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Importe Cobrado';
                    Editable = Rec.Status = Rec.Status::Pendiente;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Referencia / Nº Documento';
                    Editable = Rec.Status = Rec.Status::Pendiente;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Estado';
                    Editable = false;
                    StyleExpr = StatusStyle;
                }
                field("Applied to Invoice No."; Rec."Applied to Invoice No.")
                {
                    ApplicationArea = All;
                    Caption = 'Factura Aplicada';
                    Editable = false;
                    Visible = Rec.Status = Rec.Status::Aplicado;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RegistrarCobro)
            {
                ApplicationArea = All;
                Caption = 'Registrar Cobro';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Enabled = Rec.Status = Rec.Status::Pendiente;

                trigger OnAction()
                var
                    PrepagoMgt: Codeunit "Hagen Prepago Mgt.";
                begin
                    PrepagoMgt.RegisterPayment(Rec);
                    CurrPage.Update(false);
                end;
            }
            action(AnularCobro)
            {
                ApplicationArea = All;
                Caption = 'Anular Cobro';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec.Status = Rec.Status::Registrado;

                trigger OnAction()
                var
                    PrepagoMgt: Codeunit "Hagen Prepago Mgt.";
                begin
                    PrepagoMgt.ReversePayment(Rec);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        StatusStyle: Text;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        PrepagoMgt: Codeunit "Hagen Prepago Mgt.";
    begin
        Rec."Posting Date" := WorkDate();
        Rec."Company Bank Account No." := PrepagoMgt.GetDefaultCompanyBankAccount(Rec."Customer No.");
    end;

    trigger OnAfterGetRecord()
    begin
        case Rec.Status of
            Rec.Status::Pendiente:
                StatusStyle := 'Unfavorable';
            Rec.Status::Registrado:
                StatusStyle := 'Favorable';
            Rec.Status::Aplicado:
                StatusStyle := 'StrongAccent';
        end;
    end;
}
