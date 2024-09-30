#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50068 Inventario
{
    PageType = List;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Estado Producto";Rec."Estado Producto")
                {
                    ApplicationArea = Basic;
                }
                field("Net Change";Rec."Net Change")
                {
                    ApplicationArea = Basic;
                    Caption = 'STOCK A FECHA';
                    StyleExpr = Unfavorable;
                }
                field(COSTEMEDIO;COSTEMEDIO)
                {
                    ApplicationArea = Basic;
                    Caption = 'COSTE UNITARIO';
                    StyleExpr = Unfavorable;
                }
                field(VALORMEDIO;VALORMEDIO)
                {
                    ApplicationArea = Basic;
                    Caption = 'VALOR STOCK';
                    StyleExpr = Unfavorable;
                }
                field(Inventory;Rec.Inventory)
                {
                    ApplicationArea = Basic;
                }
                field("Inventory-""Net Change""";Rec.Inventory-Rec."Net Change")
                {
                    ApplicationArea = Basic;
                    Caption = 'Diferencia';
                }
                field("Clasificación A,B,C";Rec."Clasificación A,B,C")
                {
                    ApplicationArea = Basic;
                }
                field("Producto almacenable";Rec."Producto almacenable")
                {
                    ApplicationArea = Basic;
                }
                field(coste;coste)
                {
                    ApplicationArea = Basic;
                    Caption = 'Coste';
                }
                field("Unit Cost";Rec."Unit Cost")
                {
                    ApplicationArea = Basic;
                    Caption = 'Coste ficha';
                }
                field("Precio inv 2009";Rec."Precio inv 2009")
                {
                    ApplicationArea = Basic;
                }
                field(valor;valor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Valor';
                }
                field(HASTA;HASTA)
                {
                    ApplicationArea = Basic;
                    Caption = 'HASTA';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        
        
        
        coste:=0;
        coste2:=0;
        
        /*
        Rec32.RESET;
        Rec32.SETCURRENTKEY(Rec32."Item No.");
        Rec32.SETRANGE(Rec32."Item No.","No.");
        Rec32.SETRANGE(Rec32."Entry Type",0);
        Rec32.SETRANGE(Rec32."Posting Date",DESDE,HASTA);
        Rec32.SETRANGE(Rec32."Location Code",'SILLA');
        IF Rec32.FINDFIRST THEN REPEAT
              Rec32.CALCFIELDS(Rec32."Cost Amount (Actual)",Rec32."Tiene cargos");
              coste2:=Rec32."Cost Amount (Actual)"/Rec32.Quantity;
              IF Rec32."Tiene cargos" THEN BEGIN
                   coste:=Rec32."Cost Amount (Actual)"/Rec32.Quantity;
                   ///IF "No."='A206' THEN BEGIN
                   ///MESSAGE('%1 %2 %3 %4 ',Rec32."Cost Amount (Actual)",Rec32.Quantity);
                   ///END;
              END;
        
        UNTIL Rec32.NEXT=0;
        
        */
        
        
        HASTA:=Rec.GetRangemax("Date Filter");
        
        
        vMEDIA:=0;
        
        Rec32Temp.Reset;
        if Rec32Temp.FindFirst then repeat
             Rec32Temp.Delete;
        until Rec32Temp.Next=0;
        
        VALORMEDIO:=0;
        COSTEMEDIO:=0;
        CANTPENDIENTE:=0;
        SALE:=false;
        STOCKACT:=Rec."Net Change";
        CONTADOR:=99999999;
        Rec32.Reset;
        Rec32.SetCurrentkey(Rec32."Item No.");
        Rec32.SetRange(Rec32."Item No.",Rec."No.");
        Rec32.SetRange(Rec32."Entry Type",0);
        Rec32.SetRange(Rec32."Location Code",'SILLA');
        Rec32.SetRange(Rec32."Posting Date",DESDE,HASTA);
        if Rec32.FindSet then repeat
             Rec32Temp:=Rec32;
             CONTADOR:=CONTADOR-1;
             Rec32Temp."Entry No.":=CONTADOR;
             Rec32.CalcFields(Rec32."Cost Amount (Actual)",Rec32."Tiene cargos");
             Rec32Temp."Invoiced Quantity":=Rec32."Cost Amount (Actual)";
             Rec32Temp.Insert;
        until (Rec32.Next=0);
        
        
        vMEDIA:=0;
        VALORMEDIO:=0;
        COSTEMEDIO:=0;
        CANTPENDIENTE:=0;
        SALE:=false;
        STOCKACT:=Rec."Net Change";
        
        Rec32Temp.Reset;
        if Rec32Temp.FindFirst then repeat
              vMEDIA:=Rec32Temp."Invoiced Quantity"/Rec32Temp.Quantity;
        
              if STOCKACT<Rec32Temp.Quantity then begin
                   VALORMEDIO:=VALORMEDIO+(vMEDIA*STOCKACT);
                   SUMAMEDIA:=(vMEDIA*STOCKACT);
        ///IF "No."='80530' THEN BEGIN
        ///MESSAGE('2 STOCK %1 MEDIA %2 VALOR %3 %4 %5',STOCKACT,MEDIA,SUMAMEDIA,Rec32Temp);
        ///END;
                  STOCKACT:=0;
              end;
        
              if STOCKACT>=Rec32Temp.Quantity then begin
                   VALORMEDIO:=VALORMEDIO+(vMEDIA*Rec32Temp.Quantity);
                   SUMAMEDIA:=(vMEDIA*Rec32Temp.Quantity);
        ///IF "No."='80530' THEN BEGIN
        ///MESSAGE('1 STOCK %1 MEDIA %2 VALOR %3 %4 %5',STOCKACT,MEDIA,SUMAMEDIA,Rec32Temp);
        ///END;
                   STOCKACT:=STOCKACT-Rec32Temp.Quantity;
              end;
                 if STOCKACT<=0 then begin
                     SALE:=true;
                end;
        /////      END;
        until (Rec32Temp.Next=0) or (SALE);
        
        
        
        COSTEMEDIO:=0;
        if Rec."Net Change"<>0 then begin
             COSTEMEDIO:=VALORMEDIO/Rec."Net Change";
        end;
        
        
        if COSTEMEDIO=0 then begin
             COSTEMEDIO:=Rec."Precio inv 2009";
             if VALORMEDIO=0 then begin
                  VALORMEDIO:=COSTEMEDIO*Rec."Net Change";
             end;
        end;
        
        
        
        sincargos:=false;
        if coste=0 then begin
             coste:=coste2;
             sincargos:=true;
        end;
        
        valor:=Rec."Unit Cost"*Rec."Net Change";
        valor:=Rec.Inventory*COSTEMEDIO;
        
        if Rec."Net Change"<=0 then begin
             sincargos:=false;
        end;

    end;

    trigger OnOpenPage()
    begin

        Unfavorable:='Unfavorable';
        DESDE:=20000101D;
        HASTA:=Today;
    end;

    var
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
        SALE: Boolean;
        CANTIDADAVALORAR: Decimal;
        SUMAMEDIA: Decimal;
        Rec32Temp: Record "Item Ledger Entry" temporary;
        CONTADOR: Integer;
        VALORSTOC: Decimal;
        vMEDIA: Decimal;
        Unfavorable: Text;
}

