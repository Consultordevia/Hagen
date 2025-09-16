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

            action(RellenaPreparador)
            {

                ApplicationArea = Suite;
                Caption = 'RellenaPreparador';

                trigger OnAction()
                var

                    cu: Codeunit rellenaprepa;



                begin
                    clear(cu);
                    cu.Run();

                    Message('hecho');






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

                    cu: Codeunit rellenaprepa;



                begin

                    Clear(Rec."Work Description");
                    Rec.Modify();




                    Message('hecho');






                end;
            }


        }
    }
}
