pageextension 50041 SalesInvoice extends "Sales Invoice"
{

    layout
    {

    }

    actions
    {
        addlast(navigation)
        {

            action(IncorporatextoADUANA)
            {

                ApplicationArea = Suite;
                Caption = 'Incorpora texto ADUANA';
                ShortCutKey = 'F9';
                trigger OnAction()
                var


                    Rec37: Record "Sales Line";


                begin
                    IF Rec."No." = '' THEN BEGIN
                        ERROR('Falta numero de documento.')
                    END;



                    Rec37.INIT;
                    Rec37."Document Type" := Rec."Document Type";
                    Rec37."Document No." := Rec."No.";
                    Rec37."Line No." := 10;
                    Rec37."Sell-to Customer No." := Rec."Sell-to Customer No.";
                    Rec37."Bill-to Customer No." := Rec."Bill-to Customer No.";
                    Rec37.Type := 0;
                    Rec37.Description := 'T2LF SIN DECLARACION DE EXPEDICION';
                    Rec37.INSERT;
                    Rec37.INIT;
                    Rec37."Document Type" := Rec."Document Type";
                    Rec37."Document No." := Rec."No.";
                    Rec37."Line No." := 20;
                    Rec37."Sell-to Customer No." := Rec."Sell-to Customer No.";
                    Rec37."Bill-to Customer No." := Rec."Bill-to Customer No.";
                    Rec37.Type := 0;
                    Rec37.Description := 'NUM. BULTOS:';
                    Rec37.INSERT;
                    Rec37.INIT;
                    Rec37."Document Type" := Rec."Document Type";
                    Rec37."Document No." := Rec."No.";
                    Rec37."Line No." := 30;
                    Rec37."Sell-to Customer No." := Rec."Sell-to Customer No.";
                    Rec37."Bill-to Customer No." := Rec."Bill-to Customer No.";
                    Rec37.Type := 0;
                    Rec37.Description := 'PESO:';
                    Rec37.INSERT;
                    Rec37.INIT;
                    Rec37."Document Type" := Rec."Document Type";
                    Rec37."Document No." := Rec."No.";
                    Rec37."Line No." := 40;
                    Rec37."Sell-to Customer No." := Rec."Sell-to Customer No.";
                    Rec37."Bill-to Customer No." := Rec."Bill-to Customer No.";
                    Rec37.Type := 0;
                    Rec37.Description := 'PARTIDA ARANCELARIA Num';
                    Rec37.INSERT;
                    Rec37.INIT;
                    Rec37."Document Type" := Rec."Document Type";
                    Rec37."Document No." := Rec."No.";
                    Rec37."Line No." := 50;
                    Rec37."Sell-to Customer No." := Rec."Sell-to Customer No.";
                    Rec37."Bill-to Customer No." := Rec."Bill-to Customer No.";
                    Rec37.Type := 0;
                    Rec37.Description := '42010000.90;84749090.00;84745090.00;42010000.90';
                    Rec37.INSERT;




                end;
            }
        }
    }

    /*
    IF Rec."No."='' THEN BEGIN
     ERROR('Falta numero de documento.')
END; 



Rec37.INIT;Rec37."Document Type":="Document Type";Rec37."Document No.":="No.";Rec37."Line No.":=10;
Rec37."Sell-to Customer No.":="Sell-to Customer No.";Rec37."Bill-to Customer No.":="Bill-to Customer No.";Rec37.Type:=0;
Rec37.Description:='T2LF SIN DECLARACION DE EXPEDICION';Rec37.INSERT;
Rec37.INIT;Rec37."Document Type":="Document Type";Rec37."Document No.":="No.";Rec37."Line No.":=20;
Rec37."Sell-to Customer No.":="Sell-to Customer No.";Rec37."Bill-to Customer No.":="Bill-to Customer No.";Rec37.Type:=0;
Rec37.Description:='NUM. BULTOS:';Rec37.INSERT;
Rec37.INIT;Rec37."Document Type":="Document Type";Rec37."Document No.":="No.";Rec37."Line No.":=30;
Rec37."Sell-to Customer No.":="Sell-to Customer No.";Rec37."Bill-to Customer No.":="Bill-to Customer No.";Rec37.Type:=0;
Rec37.Description:='PESO:';Rec37.INSERT;
Rec37.INIT;Rec37."Document Type":="Document Type";Rec37."Document No.":="No.";Rec37."Line No.":=40;
Rec37."Sell-to Customer No.":="Sell-to Customer No.";Rec37."Bill-to Customer No.":="Bill-to Customer No.";Rec37.Type:=0;
Rec37.Description:='PARTIDA ARANCELARIA Num';Rec37.INSERT;
Rec37.INIT;Rec37."Document Type":="Document Type";Rec37."Document No.":="No.";Rec37."Line No.":=50;
Rec37."Sell-to Customer No.":="Sell-to Customer No.";Rec37."Bill-to Customer No.":="Bill-to Customer No.";Rec37.Type:=0;
Rec37.Description:='42010000.90;84749090.00;84745090.00;42010000.90';Rec37.INSERT;

    */
}
