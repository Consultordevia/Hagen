#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50008 "ADAIA_Conf. Expediciones"
{
    Caption = 'ADAIA_Ajustes adaia';
    Direction = Import;
    FieldSeparator = '|';
    Format = VariableText;
    TextEncoding = WINDOWS;
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            MinOccurs = Zero;
            tableelement("Payment Terms"; "Payment Terms")
            {
                AutoSave = false;
                XmlName = 'DataExchDocument';
                textelement(DOC1)
                {
                    Width = 255;

                    trigger OnAfterAssignVariable()
                    begin


                        if CopyStr(DOC1, 1, 4) = 'CECA' then begin
                            POS := 9;
                            if CopyStr(DOC1, POS, 1) <> '|' then begin
                                repeat
                                    NPEDIDO := NPEDIDO + CopyStr(DOC1, POS, 1);
                                    POS := POS + 1;
                                    if CopyStr(DOC1, POS, 1) = '|' then begin
                                        SALE := true;
                                    end;
                                until SALE;
                            end;
                            if CopyStr(DOC1, POS, 1) = '|' then begin
                            end;
                            POS := POS + 1;
                            SALE := false;
                            CLIENTE := '';
                            repeat
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            POS := POS + 1;
                            SALE := false;
                            CLIENTE := '';
                            repeat
                                CLIENTE := CLIENTE + CopyStr(DOC1, POS, 1);
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            POS := POS + 2;
                            SALE := false;
                            TIPOPEDI := '';
                            repeat
                                TIPOPEDI := TIPOPEDI + CopyStr(DOC1, POS, 1);
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;

                            D := Today;

                            if (TIPOPEDI <> 'DVPR') and (TIPOPEDI <> 'NORM') then begin
                                ESPEDIDO := true;
                                RecCV.SetCurrentkey(RecCV."Document Type", RecCV."Nº expedición");
                                RecCV.SetRange(RecCV."Document Type", 1);
                                RecCV.SetRange(RecCV."Nº expedición", NPEDIDO);
                                if RecCV.FindSet then
                                    repeat
                                        RecCV."Recibido de adaia" := true;
                                        PEDIDONAV := RecCV."No.";
                                        ModifFecha;
                                        if RecCusto.Get(RecCV."Sell-to Customer No.") then begin
                                            if RecCusto."Estatus del cliente" = 1 then begin
                                                RecCusto."Estatus del cliente" := 0;
                                                RecCusto.Modify;
                                            end;
                                        end;
                                        RecCV.Modify;

                                    until RecCV.Next = 0;
                                if CC.Get(1, NPEDIDO) then begin
                                    ESPEDIDO := true;
                                    ESTRANSF := false;
                                    ReleaseSalesDoc.Reopen(CC);
                                end;
                                if ESPEDIDO then begin
                                    ///CC.VALIDATE(CC."Posting Date",D);
                                    ///CC.VALIDATE(CC."Document Date",D);
                                    ///CC.MODIFY;
                                    LC.SetCurrentkey(LC."Document Type", LC."Nº expedición", LC."Linea Nº expedición");
                                    LC.SetRange(LC."Document Type", 1);
                                    LC.SetRange(LC."Nº expedición", NPEDIDO);
                                    if LC.FindSet then
                                        repeat
                                            LC.Validate(LC."Qty. to Ship", 0);
                                            if RecItem2.Get(LC."No.") then begin
                                                if RecItem2."Enviar siempre" = true then begin
                                                    LC.Validate(LC."Qty. to Ship", LC.Quantity);
                                                end;
                                            end;
                                            LC.Modify;
                                        until LC.Next = 0;
                                end;
                            end;
                            if TIPOPEDI = 'DVPR' then begin
                                CODALMA := 'SILLA';
                                RecComp.Init;
                                RecComp."Document Type" := 3;
                                RecComp."Order Date" := Today;
                                RecComp."Posting Date" := Today;
                                RecComp."Document Date" := Today;
                                RecComp.Validate(RecComp."Buy-from Vendor No.", CLIENTE);
                                RecComp.Insert(true);
                                RecComp."Location Code" := CODALMA;
                                RecComp.Modify(true);
                                ndocdv := RecComp."No.";
                                lin := 10000;
                            end;
                            if TIPOPEDI = 'NORM' then begin
                                CODALMA := 'SILLA';
                            end;

                        end;
                        SALE := false;
                        REF := '';
                        CANTI := '';
                        KILOSC := '';
                        TIPOUNI := '';
                        CLIN := '';

                        if CopyStr(DOC1, 1, 4) = 'CELI' then begin
                            POS := 9;
                            NPEDIDO := '';
                            if CopyStr(DOC1, POS, 1) <> '|' then begin
                                repeat
                                    NPEDIDO := NPEDIDO + CopyStr(DOC1, POS, 1);
                                    POS := POS + 1;
                                    if CopyStr(DOC1, POS, 1) = '|' then begin
                                        SALE := true;
                                    end;
                                until SALE;
                            end;
                            SALE := false;
                            POS := POS + 1;
                            repeat
                                CLIN := CLIN + CopyStr(DOC1, POS, 1);
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            Evaluate(LINEA, CLIN);
                            SALE := false;
                            POS := POS + 1;
                            repeat
                                REF := REF + CopyStr(DOC1, POS, 1);
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '-' then begin
                                    SALE := true;
                                    POS := POS + 3;
                                end;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            SALE := false;
                            POS := POS + 2;
                            repeat
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            SALE := false;
                            POS := POS + 2;
                            repeat
                                CANTI := CANTI + CopyStr(DOC1, POS, 1);
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            SALE := false;
                            POS := POS + 1;
                            repeat
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            SALE := false;
                            POS := POS + 1;
                            ///     REPEAT
                            ///          KILOSC:=KILOSC+COPYSTR(DOC1,POS,1);
                            ///          POS:=POS+1;
                            ///          IF COPYSTR(DOC1,POS,1)='|' THEN BEGIN
                            ///               SALE:=TRUE;
                            ///          END;
                            ///     UNTIL SALE;
                            KILOS := 0;

                            if TIPOPEDI <> 'DVPR' then begin
                                grabapepe;
                                if ESPEDIDO then begin
                                    LC.SetRange(LC."Document Type", 1);
                                    LC.SetRange(LC."Nº expedición", NPEDIDO);
                                    LC.SetRange(LC."Linea Nº expedición", LINEA);
                                    LC.SetRange(LC."No.", REF);
                                    if LC.Find('-') then begin

                                        LC.CalcFields(LC."Suma cdad. por envio");


                                        if LC."Suma cdad. por envio" = LC."Outstanding Quantity" then begin
                                            Evaluate(DECI, CANTI);
                                            if KILOS = 0 then begin
                                                DECI := DECI / LC."Qty. per Unit of Measure";
                                                LC.Validate(LC."Qty. to Ship", DECI);
                                            end;
                                            LC.Modify;
                                        end;
                                        if LC."Suma cdad. por envio" > LC."Outstanding Quantity" then begin

                                            Evaluate(DECI, CANTI);
                                            DECI := DECI / LC."Qty. per Unit of Measure";
                                            RecLVSuma.Reset;
                                            RecLVSuma.SetCurrentkey(RecLVSuma."Nº expedición", RecLVSuma."No.");
                                            RecLVSuma.SetRange(RecLVSuma."Nº expedición", NPEDIDO);
                                            RecLVSuma.SetRange(RecLVSuma."No.", REF);
                                            RecLVSuma.SetRange(RecLVSuma."Linea Nº expedición", LINEA);
                                            if RecLVSuma.FindFirst then
                                                repeat
                                                    if RecLVSuma."Outstanding Quantity" <= DECI then begin
                                                        if RecLVSuma."Document No." <> LC."Document No." then begin
                                                            if CC.Get(1, RecLVSuma."Document No.") then begin
                                                                ReleaseSalesDoc.Reopen(CC);
                                                            end;
                                                        end;
                                                        RecLVSuma.Validate(RecLVSuma."Qty. to Ship", RecLVSuma."Outstanding Quantity");
                                                        RecLVSuma.Modify;
                                                        DECI := DECI - RecLVSuma."Outstanding Quantity";
                                                    end else begin
                                                        if DECI > 0 then begin
                                                            if RecLVSuma."Document No." <> LC."Document No." then begin
                                                                if CC.Get(1, RecLVSuma."Document No.") then begin
                                                                    ReleaseSalesDoc.Reopen(CC);
                                                                end;
                                                            end;
                                                            RecLVSuma.Validate(RecLVSuma."Qty. to Ship", DECI);
                                                            RecLVSuma.Modify;
                                                            DECI := 0;
                                                        end;

                                                    end;
                                                until RecLVSuma.Next = 0;
                                        end;

                                    end;
                                    /////          grabapepe;

                                    if REF = '10' then begin
                                        Evaluate(DECI, CANTI);
                                        RecCV2.Reset;
                                        RecCV2.SetCurrentkey(RecCV2."Document Type", RecCV2."Nº expedición");
                                        RecCV2.SetRange(RecCV2."Document Type", 1);
                                        RecCV2.SetRange(RecCV2."Nº expedición", NPEDIDO);
                                        if RecCV2.FindSet then begin
                                            RecCV2.Validate(RecCV2."Nº bultos", DECI);
                                            RecCV2.Modify;
                                        end;


                                    end;
                                    if REF = '11' then begin
                                        Evaluate(DECI, CANTI);
                                        RecCV2.Reset;
                                        RecCV2.SetCurrentkey(RecCV2."Document Type", RecCV2."Nº expedición");
                                        RecCV2.SetRange(RecCV2."Document Type", 1);
                                        RecCV2.SetRange(RecCV2."Nº expedición", NPEDIDO);
                                        if RecCV2.FindSet then begin
                                            RecCV2.Validate(RecCV2."Nº Palets", DECI);
                                            RecCV2.Modify;
                                        end;
                                    end;
                                    if REF = '15' then begin
                                        POS := 1;
                                        repeat
                                            POS := POS + 1;
                                            if (CopyStr(CANTI, POS, 1) = '0') or
                                               (CopyStr(CANTI, POS, 1) = '1') or
                                               (CopyStr(CANTI, POS, 1) = '2') or
                                               (CopyStr(CANTI, POS, 1) = '3') or
                                               (CopyStr(CANTI, POS, 1) = '4') or
                                               (CopyStr(CANTI, POS, 1) = '5') or
                                               (CopyStr(CANTI, POS, 1) = '6') or
                                               (CopyStr(CANTI, POS, 1) = '7') or
                                               (CopyStr(CANTI, POS, 1) = '8') or
                                               (CopyStr(CANTI, POS, 1) = '9') then begin
                                                SALE := true;
                                            end;
                                        until SALE;
                                        CANTI := CopyStr(CANTI, POS);

                                        RecCV2.Reset;
                                        RecCV2.SetCurrentkey(RecCV2."Document Type", RecCV2."Nº expedición");
                                        RecCV2.SetRange(RecCV2."Document Type", 1);
                                        RecCV2.SetRange(RecCV2."Nº expedición", NPEDIDO);
                                        if RecCV2.FindSet then begin
                                            RecCV2.Preparador := CANTI;
                                            RecCV2.Modify;
                                        end;
                                    end;


                                    if REF = '12' then begin
                                        Evaluate(DECI, CANTI);
                                        RecCV2.Reset;
                                        RecCV2.SetCurrentkey(RecCV2."Document Type", RecCV2."Nº expedición");
                                        RecCV2.SetRange(RecCV2."Document Type", 1);
                                        RecCV2.SetRange(RecCV2."Nº expedición", NPEDIDO);
                                        if RecCV2.FindSet then begin
                                            decre := 1;
                                            if RecTra.Get(RecCV2."Shipping Agent Code") then begin
                                                if RecTra."Decremento kilo" <> 0 then begin
                                                    decre := (100 - RecTra."Decremento kilo") / 100;
                                                end;
                                            end;
                                            RecCV2."Total peso" := ROUND(DECI * decre, 1);
                                            RecCV2.Modify;
                                        end;
                                    end;
                                    if REF = '13' then begin
                                        Evaluate(DECI, CANTI);
                                        RecCV2.Reset;
                                        RecCV2.SetCurrentkey(RecCV2."Document Type", RecCV2."Nº expedición");
                                        RecCV2.SetRange(RecCV2."Document Type", 1);
                                        RecCV2.SetRange(RecCV2."Nº expedición", NPEDIDO);
                                        if RecCV2.FindSet then begin
                                            if DECI = 1 then begin
                                                RecCV2."Shipping Agent Code" := 'DHL';
                                                RecCV2.Modify;
                                            end;
                                            if DECI = 3 then begin
                                                RecCV2."Shipping Agent Code" := 'TIPSA';
                                                RecCV2.Modify;
                                            end;
                                            if DECI = 2 then begin
                                                RecCV2."Shipping Agent Code" := 'SEUR';
                                                RecCV2.Modify;
                                            end;
                                        end;
                                    end;

                                end;



                            end;
                        end;


                        if CopyStr(DOC1, 1, 4) = 'CECN' then begin
                            POS := 9;
                            DOC := '';
                            if CopyStr(DOC1, POS, 1) <> '|' then begin
                                repeat
                                    DOC := DOC + CopyStr(DOC1, POS, 1);
                                    POS := POS + 1;
                                    if CopyStr(DOC1, POS, 1) = '|' then begin
                                        SALE := true;
                                    end;
                                until SALE;
                            end;
                            SALE := false;
                            POS := POS + 1;
                            repeat
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            SALE := false;
                            POS := POS + 1;
                            repeat
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            SALE := false;
                            POS := POS + 2;
                            REF := '';
                            repeat
                                REF := REF + CopyStr(DOC1, POS, 1);
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            SALE := false;
                            POS := POS + 3;
                            CANTI := '';
                            repeat
                                CANTI := CANTI + CopyStr(DOC1, POS, 1);

                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            ///     ERROR('%1 %2',REF,CANTI);
                            POS := POS + 1;
                            repeat
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            SALE := false;
                            POS := POS + 1;
                            repeat
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            SALE := false;
                            POS := POS + 1;
                            repeat
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            SALE := false;
                            POS := POS + 1;
                            repeat
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            SALE := false;
                            /////
                            POS := POS + 1;
                            FECHACAD := '';
                            repeat
                                FECHACAD := FECHACAD + CopyStr(DOC1, POS, 1);
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            POS := POS + 1;
                            SALE := false;
                            repeat
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            POS := POS + 1;
                            SALE := false;
                            repeat
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            POS := POS + 1;
                            repeat
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            /////
                            SALE := false;
                            NLOTE := '';
                            repeat
                                NLOTE := NLOTE + CopyStr(DOC1, POS, 1);
                                POS := POS + 1;
                                if CopyStr(DOC1, POS, 1) = '|' then begin
                                    SALE := true;
                                end;
                            until SALE;
                            if RecItem.Get(REF) then begin
                                if RecItem."Criterio rotacion" = 0 then begin
                                    if FECHACAD <> '|' then begin
                                        FAÑO := CopyStr(FECHACAD, 1, 4);
                                        Evaluate(DAÑO, FAÑO);
                                        FMES := CopyStr(FECHACAD, 6, 2);
                                        Evaluate(DMES, FMES);
                                        FDIA := CopyStr(FECHACAD, 9, 2);
                                        Evaluate(DDIA, FDIA);
                                        FFCAD := Dmy2date(DDIA, DMES, DAÑO);
                                        LC.Reset;
                                        LC.SetCurrentkey("Document Type", "Nº expedición");
                                        LC.SetRange(LC."Document Type", 1);
                                        LC.SetRange(LC."Nº expedición", NPEDIDO);
                                        LC.SetRange(LC."No.", REF);
                                        if LC.Find('-') then begin
                                            LC."Nº lote" := NLOTE;
                                            LC."Fecha caducidad" := FFCAD;
                                            LC.Modify;
                                        end;
                                    end;
                                end;
                            end;






                            if CLIENTE = 'HAGEN01' then begin
                                lin := 10000;
                                Rec83.Reset;
                                Rec83.SetRange(Rec83."Journal Template Name", 'ELEMENTO');
                                Rec83.SetRange(Rec83."Journal Batch Name", 'KITS');
                                if Rec83.FindLast then begin
                                    lin := Rec83."Line No." + 10000;
                                end;
                                RecItem.Get(REF);
                                Evaluate(cantideci, CANTI);
                                Rec83."Journal Template Name" := 'ELEMENTO';
                                Rec83."Journal Batch Name" := 'KITS';
                                Rec83."Line No." := lin;
                                Rec83.Validate(Rec83."Item No.", REF);
                                Rec83."Posting Date" := Today;
                                Rec83.Validate(Rec83."Entry Type", 3);
                                Rec83.Validate(Rec83.Quantity, cantideci);
                                Rec83."Document No." := 'KIT:' + Format(DOC, 16);
                                Rec83."Location Code" := 'SILLA';
                                Rec83.Insert;
                            end;

                        end;
                    end;
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin

        RecCV.Reset;
        RecCV.SetCurrentkey(RecCV."Document Type", RecCV."Nº expedición");
        RecCV.SetRange(RecCV."Document Type", 1);
        RecCV.SetRange(RecCV."Nº expedición", NPEDIDO);
        if RecCV.FindFirst then
            repeat
                RecCV."Total bultos" := RecCV."Nº bultos" + RecCV."Nº Palets";
                ///RecCV.Invoice:=TRUE;
                ///RecCV.Ship:=TRUE;
                ///RecCV.MODIFY;
                Clear(ReleaseSalesDoc);
                ReleaseSalesDoc.Run(RecCV);
                ///CODEUNIT.RUN(CODEUNIT::"Sales-Post",RecCV);
                CodeCV.REGISTRAEXPE(RecCV);
            until RecCV.Next = 0;

        /*
        RecCV.RESET;
        RecCV.SETCURRENTKEY(RecCV."Document Type",RecCV."Nº expedición");
        RecCV.SETRANGE(RecCV."Document Type",1);
        RecCV.SETRANGE(RecCV."Nº expedición",NPEDIDO);
        IF RecCV.FINDFIRST THEN REPEAT
            ArchiveManagement.StoreSalesDocument(RecCV,FALSE);
        UNTIL RecCV.NEXT=0;
        RecCV.RESET;
        RecCV.SETCURRENTKEY(RecCV."Document Type",RecCV."Nº expedición");
        RecCV.SETRANGE(RecCV."Document Type",1);
        RecCV.SETRANGE(RecCV."Nº expedición",NPEDIDO);
        IF RecCV.FINDFIRST THEN REPEAT
            RecCV.DELETE;
        UNTIL RecCV.NEXT=0;
         */


        EXPEDI := NPEDIDO;
        REC110.Reset;
        REC110.SetCurrentkey(REC110."Nº expedición");
        REC110.SetFilter(REC110."Nº expedición", NPEDIDO + '*');
        if REC110.FindFirst then
            repeat
                Rec1102.Reset;
                Rec1102.SetRange(Rec1102."No.", REC110."No.");
                if Rec1102.FindFirst then
                    repeat
                        if Rec1102."Nº Palets" = 0 then begin
                            if RecTra.Get(Rec1102."Shipping Agent Code") then begin
                                if RecTra."Fichero estandar" = true then begin
                                    CUEXP.ETISTD(Rec1102);
                                end;
                                if RecTra."Fichero estandar" = false then begin
                                    if Rec1102."Shipping Agent Code" = 'DHL' then begin
                                        CUEXP.EtiDHL2NUEVA(Rec1102);
                                    end;
                                    if Rec1102."Shipping Agent Code" = 'TIPSA' then begin
                                        CUEXP.Etitipsa2NUEVA(Rec1102);
                                    end;
                                    if Rec1102."Shipping Agent Code" = 'CORR' then begin
                                        CUEXP.EtiCORRa2NUEVA(Rec1102);
                                    end;
                                    if Rec1102."Shipping Agent Code" = 'CRON' then begin
                                        CUEXP.EtiCRON2NUEVA(Rec1102);
                                    end;
                                    if Rec1102."Shipping Agent Code" = 'SEUR' then begin
                                        CUEXP.EtiSEURNUEVA(Rec1102);
                                    end;
                                    if Rec1102."Shipping Agent Code" = 'TNT' then begin
                                        CUEXP.EtiTNT2NUEVA(Rec1102);
                                    end;
                                end;
                                if Rec1102."Shipping Agent Code" = 'ECI' then begin
                                    CUEXP.ETIECI(Rec1102);
                                end;
                            end;
                        end;
                        if Rec1102."Bill-to Customer No." = '6445' then begin
                            Report.RunModal(50035, false, false, Rec1102);
                            Report.RunModal(50039, false, false, Rec1102);
                        end;
                    until Rec1102.Next = 0;
            until REC110.Next = 0;

    end;

    var
        LastLineIsHeaderErr: label 'The imported file contains unexpected formatting. One or more lines may be missing in the file.';
        WrongHeaderErr: label 'The imported file contains unexpected formatting. One or more headers are incorrect.';
        D: Date;
        "DECIAÑO": Integer;
        "Año": Code[10];
        Mes: Decimal;
        Dia: Decimal;
        SALE: Boolean;
        NPEDIDO: Code[20];
        REF: Code[10];
        POS: Decimal;
        CANTI: Code[10];
        LC: Record "Sales Line";
        DECI: Decimal;
        TIPOUNI: Code[10];
        NALBA: Code[20];
        CC: Record "Sales Header";
        ImprInfor: Codeunit "Test Report-Print";
        ImprDocu: Codeunit "Document-Print";
        CabCompra: Record "Sales Header";
        Seleccion: Integer;
        RegCompra: Codeunit "Purch.-Post";
        "PuntLínCompra": Record "Sales Line";
        "ExistenLíneasPendientes": Boolean;
        Borrado: Boolean;
        LinCompra: Record "Sales Line";
        Producto: Record Item;
        "<< SSG_DIST_VARS": Boolean;
        tabla_LinCompra: Record "Sales Line";
        nuevas_unidades: Decimal;
        num_producto: Code[20];
        num_documento: Code[20];
        num_linea: Integer;
        ControlKilos: Decimal;
        Proveedor: Record Vendor;
        "cAlmacén": Code[250];
        Rec2: Record "Sales Header";
        "tabla_almacén": Record Location;
        ventana: Dialog;
        codigoalmacen: Code[20];
        tabla_conf_exist: Record "Inventory Setup";
        T_InfoEmpresa: Record "Company Information";
        tabla_almacenes: Record Location;
        dFechaCaducidad: Date;
        cExpr1: Code[3];
        ha_ubicado: Boolean;
        P: Record Item;
        KILOSC: Code[10];
        KILOS: Decimal;
        OADAIA: Code[10];
        NOADAIA: Decimal;
        FEC: Code[8];
        CLITIEN: Decimal;
        todocero: Boolean;
        RecCV: Record "Sales Header";
        ESPEDIDO: Boolean;
        ESTRANSF: Boolean;
        CLIENTE: Code[10];
        TIPOPEDI: Code[10];
        RecComp: Record "Purchase Header";
        RecCompL: Record "Purchase Line";
        ndocdv: Code[20];
        lin: Integer;
        RecAlma: Record Location;
        CODALMA: Code[10];
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        RESTO: Decimal;
        RecUDM: Record "Item Unit of Measure";
        CUMV: Code[10];
        PORUNMV: Decimal;
        TDIVISION: Decimal;
        CLIN: Code[10];
        LINEA: Integer;
        RecCV2: Record "Sales Header";
        MESH: Decimal;
        MESDE: Decimal;
        "AÑODE": Decimal;
        PEDIDONAV: Code[20];
        RecSDP: Record "Item Journal Batch";
        Rec83: Record "Item Journal Line";
        RecItem: Record Item;
        cantideci: Decimal;
        Codeunit50010: Codeunit "Automaticos Cartas";
        DOC: Code[20];
        RecCusto: Record Customer;
        RecItem2: Record Item;
        FECHACAD: Code[20];
        NLOTE: Code[20];
        FDIA: Code[2];
        FMES: Code[2];
        "FAÑO": Code[4];
        DDIA: Integer;
        DMES: Integer;
        "DAÑO": Integer;
        FFCAD: Date;
        RecTra: Record "Shipping Agent";
        decre: Decimal;
        REC110: Record "Sales Shipment Header";
        REC111: Record "Sales Shipment Line";
        EXPEDI: Code[20];
        PESO: Decimal;
        CUEXP: Codeunit "Automaticos Cartas";
        Rec36Pepe: Record "Sales Header";
        Rec832: Record "Item Journal Line";
        LIN2: Integer;
        REC36PE: Record "Sales Header";
        NOMFICHERO: Text[100];
        DD: Code[2];
        MM: Code[2];
        AA: Code[2];
        FECHAFEC: Date;
        DDD: Integer;
        DMM: Integer;
        DAA: Integer;
        RecLVSuma: Record "Sales Line";
        Rec1102: Record "Sales Shipment Header";
        ArchiveManagement: Codeunit ArchiveManagement;
        CodeCV: Codeunit "Automaticos Cartas";

    local procedure InitializeGlobals()
    var
        DataExchDef: Record "Data Exch. Def";
    begin
    end;

    local procedure CheckLineType()
    begin
        ValidateNonDataLine;
        TrackNonDataLines;
    end;

    local procedure IdentifyLineType()
    begin
    end;

    local procedure ValidateNonDataLine()
    begin
    end;

    local procedure TrackNonDataLines()
    begin
    end;

    local procedure HeaderTagLength(): Integer
    var
        DataExchDef: Record "Data Exch. Def";
    begin
    end;

    local procedure FooterTagLength(): Integer
    var
        DataExchDef: Record "Data Exch. Def";
    begin
    end;

    local procedure GetFieldLength(TableNo: Integer; FieldNo: Integer): Integer
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
    end;

    local procedure InsertColumn(columnNumber: Integer; var columnValue: Text)
    var
        savedColumnValue: Text;
    begin
    end;

    local procedure ValidateHeaderTag()
    begin
    end;


    procedure ModifFecha()
    begin


        RecCV."Posting Date" := Today;
        RecCV."Document Date" := Today;

        /*
        MESDE := DATE2DMY(RecCV."Order Date",2);
        AÑODE := DATE2DMY(RecCV."Order Date",3);
        
        
        MESH := DATE2DMY(TODAY,2);
        
        IF MESDE<>MESH THEN BEGIN
        
             IF MESDE=1 THEN BEGIN
                  RecCV."Posting Date":=DMY2DATE(31,MESDE,AÑODE);
                  RecCV."Document Date":=DMY2DATE(31,MESDE,AÑODE);
             END;
             IF MESDE=2 THEN BEGIN
                  RecCV."Posting Date":=DMY2DATE(28,MESDE,AÑODE);
                  RecCV."Document Date":=DMY2DATE(28,MESDE,AÑODE);
             END;
             IF MESDE=3 THEN BEGIN
                  RecCV."Posting Date":=DMY2DATE(31,MESDE,AÑODE);
                  RecCV."Document Date":=DMY2DATE(31,MESDE,AÑODE);
             END;
             IF MESDE=4 THEN BEGIN
                  RecCV."Posting Date":=DMY2DATE(30,MESDE,AÑODE);
                  RecCV."Document Date":=DMY2DATE(30,MESDE,AÑODE);
             END;
             IF MESDE=5 THEN BEGIN
                  RecCV."Posting Date":=DMY2DATE(31,MESDE,AÑODE);
                  RecCV."Document Date":=DMY2DATE(31,MESDE,AÑODE);
             END;
             IF MESDE=6 THEN BEGIN
                  RecCV."Posting Date":=DMY2DATE(30,MESDE,AÑODE);
                  RecCV."Document Date":=DMY2DATE(30,MESDE,AÑODE);
             END;
             IF MESDE=7 THEN BEGIN
                  RecCV."Posting Date":=DMY2DATE(31,MESDE,AÑODE);
                  RecCV."Document Date":=DMY2DATE(31,MESDE,AÑODE);
             END;
             IF MESDE=8 THEN BEGIN
                  RecCV."Posting Date":=DMY2DATE(31,MESDE,AÑODE);
                  RecCV."Document Date":=DMY2DATE(31,MESDE,AÑODE);
             END;
             IF MESDE=9 THEN BEGIN
                  RecCV."Posting Date":=DMY2DATE(30,MESDE,AÑODE);
                  RecCV."Document Date":=DMY2DATE(30,MESDE,AÑODE);
             END;
             IF MESDE=10 THEN BEGIN
                  RecCV."Posting Date":=DMY2DATE(31,MESDE,AÑODE);
                  RecCV."Document Date":=DMY2DATE(31,MESDE,AÑODE);
             END;
             IF MESDE=11 THEN BEGIN
                  RecCV."Posting Date":=DMY2DATE(30,MESDE,AÑODE);
                  RecCV."Document Date":=DMY2DATE(30,MESDE,AÑODE);
             END;
             IF MESDE=12 THEN BEGIN
                  RecCV."Posting Date":=DMY2DATE(31,MESDE,AÑODE);
                  RecCV."Document Date":=DMY2DATE(31,MESDE,AÑODE);
             END;
        
        
        END;
        
        */


        RecCV.Validate(RecCV."Posting Date");
        RecCV.Validate(RecCV."Document Date");

    end;


    procedure grabapepe()
    begin
    end;
}

