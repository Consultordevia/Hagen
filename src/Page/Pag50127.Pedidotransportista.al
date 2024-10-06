#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50127 "Pedido transportista"
{
    PageType = List;
    SourceTable = "Item Journal Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. transportista"; Rec."Cod. transportista")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field(Pesos; Rec.Pesos)
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field("Kilos/vol"; Rec."Kilos/vol")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field("Kilos/tarifa"; Rec."Kilos/tarifa")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field(Euros; Rec.Euros)
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field(Optimo; Rec.Optimo)
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Actualiza1)
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    if SalesHeader.Get(1, codpedido) then begin
                        if SalesHeader."Shipping Agent Code" = 'WEB' then begin
                            RecLST.Reset;
                            RecLST.SetRange(RecLST."Shipping Agent Code", 'WEB');
                            RecLST.SetRange(RecLST.Code, SalesHeader."Shipping Agent Service Code");
                            if RecLST.FindFirst then begin
                                textoser := RecLST.Description;
                            end;
                            ACTUALIZAWEB;
                        end;
                        if SalesHeader."Shipping Agent Code" <> 'WEB' then begin
                            ACTUALIZA;
                        end;
                    end;
                end;
            }
            action("Graba Optimo")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin


                    Rec89.Reset;
                    Rec89.SetRange(Rec89."Journal Template Name", 'PEDIDO');
                    Rec89.SetRange(Rec89."Journal Batch Name", codpedido);
                    if Rec89.FindFirst then
                        repeat
                            if Rec89.Optimo then begin
                                codpedido := Rec."Journal Batch Name";
                                SalesHeader.Get(1, codpedido);
                                SalesHeader.Validate("Shipping Agent Code", Rec89."Cod. transportista");
                                SalesHeader."Importe optimo transporte" := Rec89.Euros;
                                SalesHeader."Shipping Agent Service Code" := '';
                                RecTrans.Get(Rec89."Cod. transportista");
                                if RecTrans."Super Urgente" then begin
                                    SalesHeader."Super urgente" := true;
                                end;
                                SalesHeader.Modify;
                            end;
                        until Rec89.Next = 0;


                    Message('Hecho.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        color := '';
        if Rec.Optimo then begin
            color := 'Unfavorable';
        end;
    end;

    trigger OnOpenPage()
    begin

        DEF(codpedido);
    end;

    var
        Rec89: Record "Item Journal Line";
        PESO: Decimal;
        VOL: Decimal;
        RecLV3: Record "Sales Line";
        pesoini: Decimal;
        IMPOP: Decimal;
        RecTrans: Record "Shipping Agent";
        PESCAL: array[5] of Decimal;
        LIN: Integer;
        codtrasopti: Code[10];
        codpedido: Code[10];
        PORVOL: array[99] of Decimal;
        IMPORTEPORTE: Decimal;
        RecCP: Record "Post Code";
        CODPROV: Code[10];
        IMPDHL: Decimal;
        Rectrap: Record "Tarifas Transportistas";
        Rectrap2: Record "Tarifas Transportistas";
        RecCfC: Record "General Ledger Setup";
        Rec36: Record "Sales Header";
        lineas: Integer;
        Rec83: Record "Item Journal Line";
        Rec362: Record "Sales Header";
        CODACTI: Code[20];
        Rec372: Record "Sales Line";
        RecProd: Record Item;
        RecLC1: Record "Sales Comment Line";
        RecLC2: Record "Sales Comment Line";
        Rec912: Record "User Setup";
        IMPTNT: Decimal;
        IMPCRONO: Decimal;
        IMPCORREO: Decimal;
        RecMT3: Record "Multitabla 3";
        RecMT4: Record "Multitabla 3";
        SalesHeader: Record "Sales Header";
        RecTras: Record "Shipping Agent";
        PRECIOOPTIO: Decimal;
        optimo: Text[30];
        pesol: Decimal;
        RecLST: Record "Shipping Agent Services";
        textoser: Text[30];
        CONTA: Integer;
        color: Text;


    local procedure ACTUALIZAWEB()
    begin



        codpedido := Rec."Journal Batch Name";


        Rec89.Reset;
        Rec89.SetRange(Rec89."Journal Template Name", 'PEDIDO');
        Rec89.SetRange(Rec89."Journal Batch Name", codpedido);
        if Rec89.FindFirst then
            repeat
                Rec89.Delete;
            until Rec89.Next = 0;

        PESO := 0;
        VOL := 0;

        Clear(PORVOL);
        RecLV3.Reset;
        RecLV3.SetRange(RecLV3."Document Type", 1);
        RecLV3.SetRange(RecLV3."Document No.", codpedido);
        if RecLV3.FindFirst then
            repeat
                PESO := PESO + RecLV3."Gross Weight" * RecLV3.Quantity;
                VOL := VOL + RecLV3."Unit Volume" * RecLV3.Quantity;
            until RecLV3.Next = 0;
        pesoini := PESO;
        codtrasopti := '';
        IMPOP := 999999;


        SalesHeader.Get(1, codpedido);
        RecTrans.Reset;
        if RecTrans.FindFirst then
            repeat
                RecLST.Reset;
                RecLST.SetRange(RecLST."Shipping Agent Code", RecTrans.Code);
                RecLST.SetRange(RecLST.Description, textoser);
                if RecLST.FindFirst then begin

                    IMPORTEPORTE := 0;
                    RecCP.Reset;
                    RecCP.SetRange(RecCP.Code, SalesHeader."Ship-to Post Code");
                    if RecCP.FindFirst then begin
                        CODPROV := RecCP."County Code";
                        PORVOL[1] := VOL * RecTrans."Conversion Volumen/kilos";
                        pesol := PESO;
                        if PORVOL[1] > PESO then begin
                            pesol := PORVOL[1];
                        end;
                        PESCAL[1] := 0;
                        PRECIOOPTIO := 0;
                        RecMT3.Reset;
                        RecMT3.SetRange(RecMT3.Tabla, 2);
                        RecMT3.SetRange(RecMT3."Transportista-Cliente", RecTrans.Code);
                        RecMT3.SetRange(RecMT3.Provincia, CODPROV);
                        if RecMT3.FindFirst then begin
                            RecMT3.Reset;
                            RecMT4.SetRange(RecMT4.Tabla, 3);
                            RecMT4.SetRange(RecMT4."Transportista tarifa", RecTrans.Code);
                            RecMT4.SetRange(RecMT4."Zona tarifa", RecMT3."Zona transportistas-Cliente");
                            RecMT4.SetRange(RecMT4."Hasta Kilos", pesol, 99999999);
                            if RecMT4.FindFirst then begin
                                PRECIOOPTIO := RecMT4.Precio;
                                PESCAL[1] := RecMT4."Hasta Kilos";
                            end;
                        end;
                        if PORVOL[1] > 0 then begin
                            Rec89.Init;
                            Rec89."Journal Template Name" := 'PEDIDO';
                            Rec89."Journal Batch Name" := codpedido;
                            LIN := LIN + 10000;
                            Rec89."Line No." := LIN;
                            Rec89."Cod. transportista" := RecTrans.Code;
                            Rec89.Pesos := pesoini;
                            Rec89."Kilos/vol" := PORVOL[1];
                            Rec89."Kilos/tarifa" := PESCAL[1];
                            Rec89.Euros := PRECIOOPTIO;
                            if PRECIOOPTIO > 0 then begin
                                if IMPOP > PRECIOOPTIO then begin
                                    codtrasopti := RecTrans.Code;
                                    IMPOP := PRECIOOPTIO;
                                end;
                            end;
                            Rec89.Insert;
                        end;
                    end;
                end;
            until RecTrans.Next = 0;
        Rec89.Reset;
        Rec89.SetRange(Rec89."Journal Template Name", 'PEDIDO');
        Rec89.SetRange(Rec89."Journal Batch Name", codpedido);
        if Rec89.FindFirst then
            repeat
                if Rec89."Cod. transportista" = codtrasopti then begin
                    Rec89.Optimo := true;
                    Rec89.Modify;
                end;
            until Rec89.Next = 0;
    end;

    local procedure ACTUALIZA()
    begin



        Rec89.Reset;
        Rec89.SetRange(Rec89."Journal Template Name", 'PEDIDO');
        Rec89.SetRange(Rec89."Journal Batch Name", codpedido);
        if Rec89.FindFirst then
            repeat
                Rec89.Delete;
            until Rec89.Next = 0;

        PESO := 0;
        VOL := 0;
        CONTA := 0;
        Clear(PORVOL);
        RecLV3.Reset;
        RecLV3.SetRange(RecLV3."Document Type", 1);
        RecLV3.SetRange(RecLV3."Document No.", codpedido);
        if RecLV3.FindFirst then
            repeat
                PESO := PESO + RecLV3."Gross Weight" * RecLV3.Quantity;
                VOL := VOL + RecLV3."Unit Volume" * RecLV3.Quantity;
            until RecLV3.Next = 0;
        pesoini := PESO;
        codtrasopti := '';
        IMPOP := 999999;


        SalesHeader.Get(1, codpedido);
        RecTrans.Reset;
        if RecTrans.FindFirst then
            repeat
                IMPORTEPORTE := 0;
                RecCP.Reset;
                RecCP.SetRange(RecCP.Code, SalesHeader."Ship-to Post Code");
                if RecCP.FindFirst then begin
                    CODPROV := RecCP."County Code";
                    PORVOL[1] := VOL * RecTrans."Conversion Volumen/kilos";
                    pesol := PESO;
                    if PORVOL[1] > PESO then begin
                        pesol := PORVOL[1];
                    end;
                    PESCAL[1] := 0;
                    PRECIOOPTIO := 0;
                    RecMT3.Reset;
                    RecMT3.SetRange(RecMT3.Tabla, 2);
                    RecMT3.SetRange(RecMT3."Transportista-Cliente", RecTrans.Code);
                    RecMT3.SetRange(RecMT3.Provincia, CODPROV);
                    if RecMT3.FindFirst then begin
                        RecMT3.Reset;
                        RecMT4.SetRange(RecMT4.Tabla, 3);
                        RecMT4.SetRange(RecMT4."Transportista tarifa", RecTrans.Code);
                        RecMT4.SetRange(RecMT4."Zona tarifa", RecMT3."Zona transportistas-Cliente");
                        RecMT4.SetRange(RecMT4."Hasta Kilos", pesol, 99999999);
                        if RecMT4.FindFirst then begin
                            PRECIOOPTIO := RecMT4.Precio;
                            PESCAL[1] := RecMT4."Hasta Kilos";
                        end;
                    end;
                    if PORVOL[1] > 0 then begin
                        Rec89.Init;
                        Rec89."Journal Template Name" := 'PEDIDO';
                        Rec89."Journal Batch Name" := codpedido;
                        LIN := LIN + 10000;
                        Rec89."Line No." := LIN;
                        Rec89."Cod. transportista" := RecTrans.Code;
                        Rec89.Pesos := pesoini;
                        Rec89."Kilos/vol" := PORVOL[1];
                        Rec89."Kilos/tarifa" := PESCAL[1];
                        Rec89.Euros := PRECIOOPTIO;
                        if PRECIOOPTIO > 0 then begin
                            if IMPOP > PRECIOOPTIO then begin
                                codtrasopti := RecTrans.Code;
                                IMPOP := PRECIOOPTIO;
                            end;
                        end;
                        Rec89.Insert;
                    end;
                end;
            until RecTrans.Next = 0;
        Rec89.Reset;
        Rec89.SetRange(Rec89."Journal Template Name", 'PEDIDO');
        Rec89.SetRange(Rec89."Journal Batch Name", codpedido);
        if Rec89.FindFirst then
            repeat
                if Rec89."Cod. transportista" = codtrasopti then begin
                    Rec89.Optimo := true;
                    Rec89.Modify;
                end;
            until Rec89.Next = 0;
    end;


    procedure DEF(CODPEDI: Code[10])
    begin

        codpedido := CODPEDI;
    end;
}

