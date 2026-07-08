pageextension 50071 FacturaVenta extends "Sales Invoice"
{


    actions
    {
        addlast("&Invoice")
        {
            action(MeterCodArance)
            {
                ApplicationArea = Suite;
                Caption = 'Mete codigos aracelarios';
                Visible = false;
                trigger OnAction()
                var

                    SalesInvoice: Record "Sales Header";
                    SalesInvoiceLine: Record "Sales Line";
                    Item: Record item;
                    TariffNumber: Record "Tariff Number";
                    SILTemp: Record "Sales Line" temporary;
                    linea: Integer;
                begin


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


                    SILTemp.RESET;
                    IF SILTemp.FINDFIRST THEN
                        REPEAT
                            SalesInvoiceLine.INIT;
                            SalesInvoiceLine."Document No." := Rec."No.";
                            linea := linea + 10000;
                            SalesInvoiceLine."Line No." := linea;
                            SalesInvoiceLine.Type := SalesInvoiceLine.Type::" ";
                            SalesInvoiceLine.Description :=
                            FORMAT(SILTemp."Job No.", 2) + ' - ' +
                            FORMAT(SILTemp."No.", 12) + ' - ' + ' Cantidad: ' + FORMAT(SILTemp.Quantity, 8) + ' - Peso:' + FORMAT(SILTemp."Net Weight", 8);
                            SalesInvoiceLine.INSERT;
                        UNTIL SILTemp.NEXT = 0;


                end;
            }
        }
    }



    /*
    SalesInvoiceLine.RESET;
SalesInvoiceLine.SETRANGE("Document No.","Sales Invoice Header"."No.");
IF SalesInvoiceLine.FINDFIRST THEN REPEAT
    IF (SalesInvoiceLine.Type=SalesInvoiceLine.Type::Item) AND (SalesInvoiceLine.Quantity<>0) THEN BEGIN
        totallineas:=totallineas+1;
        totalcantidad:=totalcantidad+SalesInvoiceLine."Quantity (Base)";
        Kilos:=Kilos+(SalesInvoiceLine."Net Weight"/1000)*SalesInvoiceLine.Quantity;
    END;
    Base:=Base+SalesInvoiceLine.Amount;
    Totalf:=Totalf+SalesInvoiceLine."Amount Including VAT";
    DatosIVAS:=FORMAT(SalesInvoiceLine."VAT %");
    IF SalesInvoiceLine."EC %"<>0 THEN BEGIN
        TextoIVAS:='IVA+REC';
        DatosIVAS:=FORMAT(SalesInvoiceLine."VAT %")+'+'+FORMAT(SalesInvoiceLine."EC %");
    END;
    DTOFAC:=DTOFAC+(SalesInvoiceLine."Inv. Discount Amount"+SalesInvoiceLine."Pmt. Discount Amount")*-1;

    IF SalesInvoiceLine."No."="Sales Invoice Header"."Cuenta de embalaje" THEN BEGIN
        EMBALAJES:=SalesInvoiceLine.Amount;
    END;
    IF SalesInvoiceLine."No."="Sales Invoice Header"."Cuenta de portes" THEN BEGIN
        PORTES:=SalesInvoiceLine.Amount;
    END;
    IF Item.GET(SalesInvoiceLine."No.") THEN BEGIN
        IF TariffNumber.GET(Item."Tariff No.") THEN BEGIN

            SILTemp.RESET;
            SILTemp.SETRANGE("No.",Item."Tariff No.");
            IF SILTemp.FINDFIRST THEN BEGIN              
                SILTemp.Quantity:=SILTemp.Quantity+SalesInvoiceLine."Quantity (Base)";
                SILTemp."Net Weight":=SILTemp."Net Weight"+SalesInvoiceLine."Amount Including VAT";                                      
                SILTemp.MODIFY;
            END;
            IF NOT SILTemp.FINDFIRST THEN BEGIN                   
                SILTemp."Line No.":=SalesInvoiceLine."Line No.";               
                SILTemp."No.":=Item."Tariff No.";
                SILTemp."Job No.":=TariffNumber.Referencia;
                SILTemp.Quantity:=SalesInvoiceLine."Quantity (Base)";
                SILTemp."Net Weight":=SalesInvoiceLine."Amount Including VAT";                                                           
                SILTemp.INSERT;
            END;
            codpa:='';
            elpesoneto:=(SalesInvoiceLine."Net Weight"/1000)*SalesInvoiceLine.Quantity;               
            IF Vendor.GET(Item."Vendor No.") THEN BEGIN
                codpa:=Vendor."Country/Region Code";
            END;    
            IF SacarCodAranPais THEN BEGIN
                SILTempPais.RESET;
                SILTempPais.SETRANGE("No.",codpa); ///+'-'+Item."Tariff No.");             
                IF SILTempPais.FINDFIRST THEN BEGIN              
                    SILTempPais.Quantity:=SILTempPais.Quantity+elpesoneto;
                    SILTempPais."Net Weight":=SILTempPais."Net Weight"+SalesInvoiceLine."Amount Including VAT";                                      
                    SILTempPais.MODIFY;
                END;
                IF NOT SILTempPais.FINDFIRST THEN BEGIN                   
                    SILTempPais.INIT;
                    SILTempPais."Line No.":=SalesInvoiceLine."Line No.";               
                    SILTempPais."No.":=codpa; ///+'-'+Item."Tariff No.";             
                    SILTempPais."Job No.":=TariffNumber.Referencia;
                    SILTempPais.Quantity:=elpesoneto;
                    SILTempPais."Net Weight":=SalesInvoiceLine."Amount Including VAT";                                                           
                    SILTempPais.INSERT;
                END;
            END;

        END;
    END;
    linea:=SalesInvoiceLine."Line No.";   
    IF SalesInvoiceLine."Description 2"='UE' THEN BEGIN
         SalesInvoiceLine.DELETE;
    END;
    IF SalesInvoiceLine.Type=SalesInvoiceLine.Type::"G/L Account" THEN BEGIN
        sumacuentas:=sumacuentas+SalesInvoiceLine.Amount;
    END; 
    IF (SalesInvoiceLine.Type=SalesInvoiceLine.Type::Item) AND (SalesInvoiceLine.Quantity=0) THEN BEGIN
        SalesInvoiceLine.DELETE;
    END;


UNTIL SalesInvoiceLine.NEXT=0;

linea:=linea+30000;  

SalesInvoiceLine.INIT;
    SalesInvoiceLine."Document No.":="Sales Invoice Header"."No.";
    linea:=linea+10000;          
    SalesInvoiceLine."Line No.":=linea;
    SalesInvoiceLine.Quantity:=1;
    SalesInvoiceLine.Description:='Tariff Number:';    
    SalesInvoiceLine."Description 2":='UE';
    SalesInvoiceLine.INSERT;


SILTemp.RESET;
IF SILTemp.FINDFIRST THEN REPEAT
    SalesInvoiceLine.INIT;
    SalesInvoiceLine."Document No.":="Sales Invoice Header"."No.";
    linea:=linea+10000;          
    SalesInvoiceLine."Line No.":=linea;
    SalesInvoiceLine.Type:=SalesInvoiceLine.Type::Item;
    SalesInvoiceLine.Quantity:=1;
    codar:=INCSTR(codar);
    SalesInvoiceLine."No.":=codar;
    SalesInvoiceLine.Description:=    
    FORMAT(SILTemp."Job No.",2)+' - '+    
    FORMAT(SILTemp."No.",12)+' - '+' Qty: '+FORMAT(SILTemp.Quantity,8)+' - Net Weight:'+FORMAT(SILTemp."Net Weight",8);
    SalesInvoiceLine."Description 2":='UE';
    SalesInvoiceLine.INSERT;

UNTIL SILTemp.NEXT=0;


    */

}
