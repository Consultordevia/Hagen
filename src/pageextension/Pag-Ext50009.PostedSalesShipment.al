pageextension 50009 "Posted Sales Shipment" extends "Posted Sales Shipments"
{

    layout
    {
        addafter("Location Code")
        {

            field("Nº expedición"; Rec."Nº expedición") { ApplicationArea = All; }
            field("Nº expedición agrupada"; Rec."Nº expedición agrupada") { ApplicationArea = All; }
            field("Nº expedición dropshp"; Rec."Nº expedición dropshp") { ApplicationArea = All; }
            field("Estado Expedicion"; Rec."Estado Expedicion") { ApplicationArea = All; }
            field("Numero segumiento"; Rec."Numero segumiento") { ApplicationArea = All; }

            field("Fecha envio"; Rec."Fecha envio") { ApplicationArea = All; }

            field("Fecha entrega"; Rec."Fecha entrega") { ApplicationArea = All; }

            field("Hora entrega"; Rec."Hora entrega") { ApplicationArea = All; }

            field("Total horas"; Rec."Total horas") { ApplicationArea = All; }

            field("Importe albaran"; Rec."Importe albaran") { ApplicationArea = All; }
            field("Importe Coste"; ImporteCoste) { ApplicationArea = All; }

        }
    }
    trigger OnAfterGetRecord()


    begin
        Customer.INIT;
        IF Customer.GET(Rec."Sell-to Customer No.") THEN BEGIN
        END;

        Peso := 0;
        cajas0 := 0;
        cajas6 := 0;
        ImporteCoste := 0;
        SalesShipmentLine.RESET;
        SalesShipmentLine.SETRANGE(SalesShipmentLine."Document No.", Rec."No.");
        IF SalesShipmentLine.FINDFIRST THEN
            REPEAT
                ImporteCoste := ImporteCoste + SalesShipmentLine."Unit Cost (LCY)" * SalesShipmentLine."Quantity (Base)";



                IF Item.GET(SalesShipmentLine."No.") THEN BEGIN
                    IF Item."Tipo preparacion" = Item."Tipo preparacion"::"0-Sin Caja" THEN BEGIN
                        cajas0 := cajas0 + SalesShipmentLine.Quantity;
                    END;
                    IF Item."Tipo preparacion" = Item."Tipo preparacion"::"6-Tubo" THEN BEGIN
                        cajas6 := cajas6 + SalesShipmentLine.Quantity;
                    END;
                    IF (Item."Tipo preparacion" = Item."Tipo preparacion"::"1-Muy pequeño") OR
                    (Item."Tipo preparacion" = Item."Tipo preparacion"::"2-Pequeño") OR
                    (Item."Tipo preparacion" = Item."Tipo preparacion"::"3-Mediano") OR
                    (Item."Tipo preparacion" = Item."Tipo preparacion"::"4-Grande") OR
                    (Item."Tipo preparacion" = Item."Tipo preparacion"::"5- Extra Grande") THEN BEGIN
                        Peso := Peso + (SalesShipmentLine.Quantity * SalesShipmentLine."Net Weight");
                    END;
                END;
            UNTIL SalesShipmentLine.NEXT = 0;



        textocaja := '';
        IF cajas0 <> 0 THEN BEGIN
            textocaja := textocaja + ' CJ0: ' + FORMAT(cajas0);
        END;
        IF cajas6 <> 0 THEN BEGIN
            NCAJAS := cajas6 / 6;
            NCAJAS := ROUND(NCAJAS, 1);
            IF NCAJAS = 0 THEN NCAJAS := 1;
            textocaja := textocaja + ' CJ6: ' + FORMAT(NCAJAS);
        END;


        IF Peso <> 0 THEN BEGIN
            Tipocaja.RESET;
            Tipocaja.SETRANGE(Combinable, TRUE);
            Tipocaja.SETRANGE("Maximo kilos", Peso, 999999);
            IF Tipocaja.FINDFIRST THEN BEGIN
                NCAJAS := ROUND(Peso / Tipocaja."Maximo kilos", 1);
                IF NCAJAS = 0 THEN NCAJAS := 1;
                textocaja := textocaja + ' ' + Tipocaja."Tipo caja" + ': ' + FORMAT(NCAJAS);
            END;
            IF NOT Tipocaja.FINDFIRST THEN BEGIN
                Tipocaja.RESET;
                Tipocaja.SETRANGE(Combinable, TRUE);
                IF Tipocaja.FINDLAST THEN BEGIN
                    NCAJAS := ROUND(Peso / 10, 1);
                    IF NCAJAS = 0 THEN NCAJAS := 1;
                    textocaja := textocaja + ' ' + Tipocaja."Tipo caja" + ': ' + FORMAT(NCAJAS);
                END;
            END;
        END;

    end;

    var
        RecTra: Record "Shipping Agent";
        Rec110: Record "Sales Shipment Header";
        AutomaticosAdaia: Codeunit "Automaticos Cartas";
        Customer: Record Customer;
        paginaweb: Text[500];
        codexpe: Code[50];
        Peso: Decimal;
        SalesShipmentLine: Record "Sales Shipment Line";
        Tipocaja: Record "Tipo caja";
        textocaja: Text;
        sale: Boolean;
        cajas0: Integer;
        cajas6: Integer;
        Item: Record Item;
        NCAJAS: Decimal;
        ImporteCoste: Decimal;
        Rec32: Record "Item Ledger Entry";
        coste: Decimal;
        valor: Decimal;
        filtro: Text[250];
        DESDE: Date;
        HASTA: Date;
        coste2: Decimal;
        sincargos: Boolean;
        total: Decimal;
        RecItem: Record Item;
        RecItem2: Record Item;
        ventana: Dialog;
        COSTEMEDIO: Decimal;
        VALORMEDIO: Decimal;
        CANTPENDIENTE: Decimal;
        STOCKACT: Decimal;
        CANTIDADAVALORAR: Decimal;
        SUMAMEDIA: Decimal;
        Rec32Temp: Record "Item Ledger Entry";
        CONTADOR: Integer;
        VALORSTOC: Decimal;
        vMEDIA: Decimal;
        Unfavorable: Text;
        Modificaalbaran: Page "Modifica albaran";
        SalesShipmentHeader3: Record "Sales Shipment Header";
        ANYO: Integer;
        codigopostal: Code[20];
        RecTransp: Record "Shipping Agent";


}


/*
Customer.INIT;
IF Customer.GET("Sell-to Customer No.") THEN BEGIN

END;

Peso:=0;
cajas0:=0;
cajas6:=0;
ImporteCoste:=0;
SalesShipmentLine.RESET;
SalesShipmentLine.SETRANGE(SalesShipmentLine."Document No.","No.");
IF SalesShipmentLine.FINDFIRST THEN REPEAT
{

DESDE:=010100D;
HASTA:="Posting Date";       

vMEDIA:=0;

Rec32Temp.RESET;
IF Rec32Temp.FINDFIRST THEN REPEAT
     Rec32Temp.DELETE;
UNTIL Rec32Temp.NEXT=0;

   
    VALORMEDIO:=0;
    COSTEMEDIO:=0;
    CANTPENDIENTE:=0;
    sale:=FALSE;
    IF Item.GET(SalesShipmentLine."No.") THEN BEGIN
        Item.SETRANGE("Date Filter",DESDE,HASTA);
        Item.CALCFIELDS("Net Change");
        STOCKACT:=Item."Net Change";
        CONTADOR:=99999999;
        Rec32.RESET;
        Rec32.SETCURRENTKEY(Rec32."Item No.");
        Rec32.SETRANGE(Rec32."Item No.",SalesShipmentLine."No.");
        Rec32.SETRANGE(Rec32."Entry Type",0);
        Rec32.SETRANGE(Rec32."Location Code",'SILLA');
        Rec32.SETRANGE(Rec32."Posting Date",DESDE,HASTA);
        IF Rec32.FINDSET THEN REPEAT
            Rec32Temp:=Rec32;
            CONTADOR:=CONTADOR-1;
            Rec32Temp."Entry No.":=CONTADOR;
            Rec32.CALCFIELDS(Rec32."Cost Amount (Actual)",Rec32."Tiene cargos");
            Rec32Temp."Invoiced Quantity":=Rec32."Cost Amount (Actual)";
            Rec32Temp.INSERT;
        UNTIL (Rec32.NEXT=0);
        vMEDIA:=0;
        VALORMEDIO:=0;
        COSTEMEDIO:=0;
        CANTPENDIENTE:=0;
        sale:=FALSE;
        STOCKACT:=Item."Net Change";
        Rec32Temp.RESET;
        IF Rec32Temp.FINDFIRST THEN REPEAT
              vMEDIA:=Rec32Temp."Invoiced Quantity"/Rec32Temp.Quantity;

              IF STOCKACT<Rec32Temp.Quantity THEN BEGIN
                  VALORMEDIO:=VALORMEDIO+(vMEDIA*STOCKACT);
                  SUMAMEDIA:=(vMEDIA*STOCKACT);
                  STOCKACT:=0;
              END;

      IF STOCKACT>=Rec32Temp.Quantity THEN BEGIN
           VALORMEDIO:=VALORMEDIO+(vMEDIA*Rec32Temp.Quantity);
           SUMAMEDIA:=(vMEDIA*Rec32Temp.Quantity);
           STOCKACT:=STOCKACT-Rec32Temp.Quantity;
      END;
         IF STOCKACT<=0 THEN BEGIN
             sale:=TRUE;
        END;
/////      END;
UNTIL (Rec32Temp.NEXT=0) OR (sale);



COSTEMEDIO:=0;
IF Item."Net Change"<>0 THEN BEGIN
     COSTEMEDIO:=VALORMEDIO/Item."Net Change";
END;


IF COSTEMEDIO=0 THEN BEGIN
     COSTEMEDIO:=Item."Precio inv 2009";
     IF VALORMEDIO=0 THEN BEGIN
          VALORMEDIO:=COSTEMEDIO*Item."Net Change";
     END;
END;




END;
}
 ImporteCoste:=ImporteCoste+SalesShipmentLine."Unit Cost (LCY)"*SalesShipmentLine."Quantity (Base)";



    IF Item.GET(SalesShipmentLine."No.") THEN BEGIN
        IF Item."Tipo preparacion"=Item."Tipo preparacion"::"0-Sin Caja" THEN BEGIN
            cajas0:=cajas0+SalesShipmentLine.Quantity;
        END;
        IF Item."Tipo preparacion"=Item."Tipo preparacion"::"6-Tubo" THEN BEGIN
            cajas6:=cajas6+SalesShipmentLine.Quantity;
        END;    
        IF (Item."Tipo preparacion"=Item."Tipo preparacion"::"1-Muy pequeño") OR
           (Item."Tipo preparacion"=Item."Tipo preparacion"::"2-Pequeño") OR
           (Item."Tipo preparacion"=Item."Tipo preparacion"::"3-Mediano") OR
           (Item."Tipo preparacion"=Item."Tipo preparacion"::"4-Grande") OR
           (Item."Tipo preparacion"=Item."Tipo preparacion"::"5- Extra Grande") THEN BEGIN
            Peso:=Peso+(SalesShipmentLine.Quantity*SalesShipmentLine."Net Weight");
        END;
    END;
UNTIL SalesShipmentLine.NEXT=0;



textocaja:='';
IF cajas0<>0 THEN BEGIN
    textocaja:=textocaja+' CJ0: '+FORMAT(cajas0); 
END;
IF cajas6<>0 THEN BEGIN
    NCAJAS:=cajas6/6;
    NCAJAS:=ROUND(NCAJAS,1);
    IF NCAJAS=0 THEN NCAJAS:=1;
    textocaja:=textocaja+' CJ6: '+FORMAT(NCAJAS); 
END;


IF Peso<>0 THEN BEGIN
    Tipocaja.RESET;
    Tipocaja.SETRANGE(Combinable,TRUE);
    Tipocaja.SETRANGE("Maximo kilos",Peso,999999);
    IF Tipocaja.FINDFIRST THEN BEGIN
        NCAJAS:=ROUND(Peso/Tipocaja."Maximo kilos",1);
        IF NCAJAS=0 THEN NCAJAS:=1;
        textocaja:=textocaja+' '+Tipocaja."Tipo caja"+': '+FORMAT(NCAJAS); 
    END;
    IF NOT Tipocaja.FINDFIRST THEN BEGIN
        Tipocaja.RESET;
        Tipocaja.SETRANGE(Combinable,TRUE);    
        IF Tipocaja.FINDLAST THEN BEGIN
            NCAJAS:=ROUND(Peso/10,1);
            IF NCAJAS=0 THEN NCAJAS:=1;
            textocaja:=textocaja+' '+Tipocaja."Tipo caja"+': '+FORMAT(NCAJAS);    
        END;
    END;
END;         
 
 

*/
