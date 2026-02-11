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
                    RecHFV.SetRange("No.", Rec."No.");
                    IF RecHFV.FindFirst() THEN begin
                        CU_cartas.ENVIAREMIALFACTURAS(RecHFV);

                    end;





                end;
            }


            action(Rellenamovbanco)
            {

                ApplicationArea = Suite;
                Caption = 'Rellenamovbanco';

                trigger OnAction()
                var
                    cu: Codeunit rellenamovbanco;

                begin
                    clear(cu);
                    cu.Run();

                    Message('hecho');






                end;

            }

            action(ModifComentario)
            {

                ApplicationArea = Suite;
                Caption = 'ModifComentario';

                trigger OnAction()
                var

                    Rec112: Record "Sales Invoice Header";
                    cu: Codeunit "Automaticos Cartas";



                begin

                    Rec112.reset;
                    Rec112.SetRange("No.", Rec."No.");
                    IF Rec112.FindFirst() THEN begin
                        cu.modiffact(Rec112);
                    end;



                    Message('hecho');






                end;
            }


        }
    }
}
