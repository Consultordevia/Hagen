#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50141 "CUSTOMEWER 2"
{
    PageType = List;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Grupo descuento mensual"; Rec."Grupo descuento mensual")
                {
                    ApplicationArea = Basic;
                }
                field("Partner Type"; Rec."Partner Type")
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Estatus del cliente"; Rec."Estatus del cliente")
                {
                    ApplicationArea = Basic;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Net Change"; Rec."Net Change")
                {
                    ApplicationArea = Basic;
                }
                field("Net Change (LCY)"; Rec."Net Change (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Due"; Rec."Balance Due")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Due (LCY)"; Rec."Balance Due (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Observación para transporte"; Rec."Observación para transporte")
                {
                    ApplicationArea = Basic;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = Basic;
                }
                field("Grupo clientes"; Rec."Grupo clientes")
                {
                    ApplicationArea = Basic;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
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
            action(asd)
            {
                ApplicationArea = Basic;
                ShortCutKey = 'F9';

                trigger OnAction()
                begin
                    Rec.Modify(true);

                    CUADAIA.ALTACLIENTES(Rec);
                end;
            }
        }
    }

    var
        CUADAIA: Codeunit "Automaticos Cartas";
}

