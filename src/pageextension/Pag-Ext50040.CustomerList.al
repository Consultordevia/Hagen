pageextension 50040 CustomerList extends "Customer List"
{
    layout
    {

    
    }

    actions
    {
        addlast(navigation)
        {

            action(CopiaCliente)
            {

                ApplicationArea = Suite;
                Caption = 'Copia Clientes';
                ShortCutKey = 'F9';
                trigger OnAction()
                var

                    RecCusto: Record Customer;
                    SalesSetup: Record "Sales & Receivables Setup";
                    NoSeriesManagement: Codeunit NoSeriesManagement;
                    codclie: Code[20];
                    SalesInvoiceLine: Record "Sales Invoice Line";
                    ShiptoAddress: Record "Ship-to Address";
                    ShiptoAddress2: Record "Ship-to Address";


                begin


                    RecCusto.INIT;
                    RecCusto := Rec;
                    SalesSetup.GET;
                    SalesSetup.TESTFIELD("Customer Nos.");
                    codclie := NoSeriesManagement.GetNextNo('C-NAV', TODAY, TRUE);

                    RecCusto."No." := codclie;
                    RecCusto."Fecha alta" := TODAY;
                    RecCusto."Usuario alta" := USERID;
                    RecCusto.Name := 'COPIA ' + COPYSTR(Rec.Name, 1, 53);
                    RecCusto."Usuario Web" := '';
                    RecCusto."Contraseña WEB" := '';
                    RecCusto.INSERT;


                    ShiptoAddress.RESET;
                    ShiptoAddress.SETRANGE(ShiptoAddress."Customer No.", Rec."No.");
                    IF ShiptoAddress.FINDFIRST THEN
                        REPEAT
                            ShiptoAddress2 := ShiptoAddress;
                            ShiptoAddress2."Customer No." := codclie;
                            ShiptoAddress2.INSERT;
                        UNTIL ShiptoAddress.NEXT = 0;


                    MESSAGE('El nuevo clientes es %1', codclie);



                end;
            }
            action(Enviaraadaia)
            {

                ApplicationArea = Suite;
                Caption = 'Envar a Adaia';
                ShortCutKey = 'F9';
                trigger OnAction()
                var

                    CU_adaia: Codeunit "Automaticos Cartas";
                    

                begin


                    
                    CU_adaia.ENVIATERCEROSMODIF;
                    MESSAGE('hecho');



                end;
            }
        }
    }
}
