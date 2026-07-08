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
                    SalesInvoice: Record "Sales Header";
                    SalesInvoiceLine: Record "Sales Line";
                    Item: Record item;
                    TariffNumber: Record "Tariff Number";
                    SILTemp: Record "Sales Line" temporary;
                    linea: Integer;
                    textoaran: Text;
                    peso: Decimal;


                begin
                    IF Rec."No." = '' THEN BEGIN
                        ERROR('Falta numero de documento.')
                    END;

                    SalesInvoiceLine.RESET;
                    SalesInvoiceLine.SETRANGE("Document No.", Rec."No.");
                    IF SalesInvoiceLine.FINDFIRST THEN
                        REPEAT
                            linea := SalesInvoiceLine."Line No.";
                            IF (SalesInvoiceLine.Type = SalesInvoiceLine.Type::Item) AND (SalesInvoiceLine.Quantity <> 0) THEN BEGIN
                                IF Item.GET(SalesInvoiceLine."No.") THEN BEGIN
                                    SILTemp.RESET;
                                    SILTemp.SETRANGE("No.", Item."Codigo arancelario Canarias");
                                    IF SILTemp.FINDFIRST THEN BEGIN
                                        SILTemp.Quantity := SILTemp.Quantity + SalesInvoiceLine."Quantity (Base)";
                                        SILTemp."Net Weight" := SILTemp."Net Weight" + SalesInvoiceLine."Amount Including VAT";
                                        SILTemp.MODIFY;
                                    END;
                                    IF NOT SILTemp.FINDFIRST THEN BEGIN
                                        SILTemp."Line No." := SalesInvoiceLine."Line No.";
                                        SILTemp."No." := Item."Codigo arancelario Canarias";
                                        SILTemp."Job No." := Item."Codigo arancelario Canarias";
                                        SILTemp.Quantity := SalesInvoiceLine."Quantity (Base)";
                                        SILTemp."Net Weight" := SalesInvoiceLine."Amount Including VAT";
                                        SILTemp.INSERT;
                                    END;
                                END;
                            END;
                        UNTIL SalesInvoiceLine.NEXT = 0;

                    linea := linea + 30000;

                    SalesInvoiceLine.INIT;
                    SalesInvoiceLine."Document No." := Rec."No.";
                    linea := linea + 10000;
                    SalesInvoiceLine."Line No." := linea;
                    SalesInvoiceLine.Quantity := 1;
                    SalesInvoiceLine.Description := 'Codigos arancelarios:';
                    SalesInvoiceLine.INSERT;


                    textoaran := '';
                    peso := 0;
                    SILTemp.RESET;
                    IF SILTemp.FINDFIRST THEN
                        REPEAT
                            textoaran := textoaran + FORMAT(SILTemp."No.", 12) + ' ; ';
                            peso := peso + SILTemp."Net Weight";
                        until SILTemp.next = 0;



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
                    Rec37.Description := 'PESO: ' + format(peso);
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
                    Rec37.Description := CopyStr(textoaran, 1, 100);
                    Rec37.INSERT;
                    if StrLen(textoaran) > 100 then begin
                        Rec37.INIT;
                        Rec37."Document Type" := Rec."Document Type";
                        Rec37."Document No." := Rec."No.";
                        Rec37."Line No." := 60;
                        Rec37."Sell-to Customer No." := Rec."Sell-to Customer No.";
                        Rec37."Bill-to Customer No." := Rec."Bill-to Customer No.";
                        Rec37.Type := 0;
                        Rec37.Description := CopyStr(textoaran, 101, 100);
                        Rec37.INSERT;

                    end;




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
