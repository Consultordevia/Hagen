pageextension 50055 HistoFactVenta extends "Posted Sales Invoices"
{

    actions
    {
        addlast(navigation)
        {

            action(Enviaremialexcel)
            {

                ApplicationArea = Suite;
                Caption = 'Enviar email + excel';                 
                trigger OnAction()
                var

                    CU_cartas: Codeunit "Automaticos Cartas";
                    RecHFV: Record "Sales Invoice Header";


                begin

                    RecHFV.reset;
                    RecHFV.SetRange("No.",Rec."No.");
                    IF RecHFV.FindFirst() THEN begin
                        CU_cartas.ENVIAREMIALFACTURAS(RecHFV);

                    end;
                    




                end;
            }
        }
    }
}
