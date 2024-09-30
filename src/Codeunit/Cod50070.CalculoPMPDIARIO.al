#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50070 "Calculo PMP DIARIO"
{

    trigger OnRun()
    begin

        VENTANA.Open('#1######################\' +
                     '#2##############################################################\' +
                     '#3######################');



        Recdate.Reset;
        Recdate.SetRange(Recdate."Period Type", 0);
        Recdate.SetRange(Recdate."Period Start", Today, Today);
        if Recdate.FindFirst then
            repeat
                afecha := Recdate."Period Start";
                VENTANA.Update(1, afecha);
                LIN := 1;
                RecItem.Reset;
                /////RecItem.SETRANGE("No.",'A595');
                if RecItem.FindFirst then
                    repeat
                        if RecItem."Producto almacenable" then begin
                            VENTANA.Update(2, Format(RecItem."Item Category Code") + ' ' + Format(RecItem."No."));
                            LINLIN := 0;
                            Rec83PMP.Reset;
                            if Rec83PMP.FindLast then begin
                                LINLIN := Rec83PMP."Line No.";
                            end;
                            Rec83PMP.Init;
                            Rec83PMP."Journal Template Name" := 'PMP';
                            Rec83PMP."Item No." := RecItem."No.";
                            LINLIN := LINLIN + 1;
                            Rec83PMP."Line No." := LINLIN;
                            Rec83PMP."Posting Date" := afecha;
                            Rec83PMP.Description := RecItem.Description;
                            if Vendor.Get(RecItem."Vendor No.") then begin
                                Rec83PMP."Nombre Vendedor" := Vendor.Name;
                            end;
                            Rec83PMP.Insert;
                            RecItem.CalcFields(RecItem.Inventory);
                            Rec123Temp.Reset;
                            if Rec123Temp.FindFirst then
                                repeat
                                    Rec123Temp.Delete;
                                until (Rec123Temp.Next = 0);

                            Rec123Temp2.Reset;
                            if Rec123Temp2.FindFirst then
                                repeat
                                    Rec123Temp2.Delete;
                                until (Rec123Temp2.Next = 0);

                            ST1 := RecItem.Inventory;

                            STOCKTOTAL := ST1;

                            if (STOCKTOTAL <> 0) then begin

                                Clear(Rec123Temp);
                                Rec123Temp.Reset;
                                if Rec123Temp.FindFirst then
                                    repeat
                                        Rec123Temp.Delete;
                                    until Rec123Temp.Next = 0;

                                Clear(PRECIO);
                                Clear(DOCPRECIO);
                                Clear(CANTIDAD);

                                totalcant := ST1;

                                sincompras := true;
                                SUMACOMPRA := 0;
                                REC121.Reset;
                                REC121.SetCurrentkey("No.", "Posting Date");
                                REC121.SetRange("No.", RecItem."No.");
                                REC121.SetRange("Posting Date", 20000101D, afecha);
                                REC121.SetRange(Type, 2);
                                if REC121.FindLast then
                                    repeat
                                        if REC121.Quantity > 0 then begin
                                            SUMACOMPRA := SUMACOMPRA + REC121.Quantity;
                                            XX := 0;
                                            repeat
                                                XX := XX + 1;
                                                Rec123Temp2."Document No." := '1';
                                                LIN := LIN + 1;
                                                Rec123Temp2."Line No." := LIN;
                                                Rec123Temp2.Quantity := 1;
                                                Rec123Temp2."Unit Cost (LCY)" := REC121."Unit Cost (LCY)";
                                                Rec32.Reset;
                                                Rec32.SetRange("Document No.", REC121."Document No.");
                                                Rec32.SetRange(Rec32."Document Line No.", REC121."Line No.");
                                                if Rec32.FindFirst then begin
                                                    Rec32.CalcFields(Rec32."Cost Amount (Actual)");
                                                    Rec123Temp2."Unit Cost (LCY)" := Rec32."Cost Amount (Actual)" / Rec32.Quantity;
                                                end;
                                                Rec123Temp2.Description := REC121."Document No.";
                                                Rec123Temp2."Posting Date" := REC121."Posting Date";
                                                Rec123Temp2."Quantity (Base)" := REC121."Quantity (Base)";
                                                sincompras := false;
                                                Rec123Temp2.Insert;
                                            until XX >= REC121.Quantity;
                                            Rec123Temp."Document No." := '1';
                                            LIN := LIN + 1;
                                            Rec123Temp."Line No." := LIN;
                                            Rec123Temp.Quantity := REC121.Quantity;
                                            ;
                                            Rec123Temp."Unit Cost (LCY)" := REC121."Unit Cost (LCY)";
                                            Rec32.Reset;
                                            Rec32.SetRange("Document No.", REC121."Document No.");
                                            Rec32.SetRange(Rec32."Document Line No.", REC121."Line No.");
                                            if Rec32.FindFirst then begin
                                                Rec32.CalcFields(Rec32."Cost Amount (Actual)");
                                                Rec123Temp."Unit Cost (LCY)" := Rec32."Cost Amount (Actual)" / Rec32.Quantity;
                                            end;
                                            Rec123Temp.Description := REC121."Document No.";
                                            Rec123Temp."Posting Date" := REC121."Posting Date";
                                            Rec123Temp."Quantity (Base)" := REC121."Quantity (Base)";
                                            Rec123Temp.Insert;
                                        end;
                                    until (REC121.Next(-1) = 0) or (SUMACOMPRA >= STOCKTOTAL);
                                if sincompras then begin
                                    Rec123Temp2."Document No." := '1';
                                    LIN := LIN + 1;
                                    Rec123Temp2."Line No." := LIN;
                                    Rec32.Reset;
                                    Rec32.SetRange("Document No.", 'AJUSTES');
                                    Rec32.SetRange("Item No.", RecItem."No.");
                                    Rec32.SetRange(Rec32."Entry Type", Rec32."entry type"::"Positive Adjmt.");
                                    if Rec32.FindFirst then begin
                                        Rec32.CalcFields(Rec32."Cost Amount (Actual)");
                                        Rec123Temp2."Unit Cost (LCY)" := Rec32."Cost Amount (Actual)" / Rec32.Quantity;
                                    end;
                                    Rec123Temp2.Quantity := 1;
                                    Rec123Temp2.Description := Rec32."Document No.";
                                    Rec123Temp2."Posting Date" := Rec32."Posting Date";
                                    Rec123Temp2."Quantity (Base)" := Rec32.Quantity;
                                    Rec123Temp2.Insert;
                                    Rec123Temp."Document No." := '1';
                                    LIN := LIN + 1;
                                    Rec123Temp."Line No." := LIN;
                                    Rec32.Reset;
                                    Rec32.SetRange("Document No.", 'AJUSTES');
                                    Rec32.SetRange("Item No.", RecItem."No.");
                                    Rec32.SetRange(Rec32."Entry Type", Rec32."entry type"::"Positive Adjmt.");
                                    if Rec32.FindFirst then begin
                                        Rec32.CalcFields(Rec32."Cost Amount (Actual)");
                                        Rec123Temp."Unit Cost (LCY)" := Rec32."Cost Amount (Actual)" / Rec32.Quantity;
                                        Rec123Temp.Quantity := Rec32.Quantity;
                                    end;
                                    Rec123Temp.Description := Rec32."Document No.";
                                    Rec123Temp."Posting Date" := Rec32."Posting Date";
                                    Rec123Temp."Quantity (Base)" := Rec32.Quantity;
                                    Rec123Temp.Insert;
                                end;

                                YY := 0;
                                Rec123Temp.Reset;
                                if Rec123Temp.FindFirst then
                                    repeat
                                        YY := YY + 1;
                                        PRECIO[YY] := Rec123Temp."Unit Cost (LCY)";
                                        DOCPRECIO[YY] := Rec123Temp.Description;
                                        CANTIDAD[YY] := Rec123Temp.Quantity;
                                    until (Rec123Temp.Next = 0) or (YY > 10);

                                ULTPRE := 0;
                                YY := 0;
                                IMPORTE := 0;
                                numdoc := 0;
                                ndoc := '';
                                Rec123Temp2.Reset;
                                if Rec123Temp2.FindFirst then
                                    repeat
                                        if ndoc <> Rec123Temp2.Description then begin
                                            ndoc := Rec123Temp2.Description;
                                            Rec83PMP.Reset;
                                            Rec83PMP.SetRange("Journal Template Name", 'PMP');
                                            Rec83PMP.SetRange("Item No.", RecItem."No.");
                                            Rec83PMP.SetRange("Posting Date", afecha);
                                            if Rec83PMP.FindFirst then begin
                                                numdoc := numdoc + 1;
                                                if numdoc = 1 then begin
                                                    Rec83PMP.doc1 := Rec123Temp2.Description;
                                                    Rec83PMP.cantidad1 := Rec123Temp2.Quantity;
                                                    Rec83PMP.precio1 := Rec123Temp2."Unit Cost (LCY)";
                                                    Rec83PMP.fecha1 := Rec123Temp2."Posting Date";
                                                    Rec83PMP.cantidad1 := Rec123Temp2."Quantity (Base)";
                                                end;
                                                if numdoc = 2 then begin
                                                    Rec83PMP.doc2 := Rec123Temp2.Description;
                                                    Rec83PMP.cantidad2 := Rec123Temp2.Quantity;
                                                    Rec83PMP.precio2 := Rec123Temp2."Unit Cost (LCY)";
                                                    Rec83PMP.fecha2 := Rec123Temp2."Posting Date";
                                                    Rec83PMP.cantidad2 := Rec123Temp2."Quantity (Base)";
                                                end;
                                                if numdoc = 3 then begin
                                                    Rec83PMP.doc3 := Rec123Temp2.Description;
                                                    Rec83PMP.cantidad3 := Rec123Temp2.Quantity;
                                                    Rec83PMP.precio3 := Rec123Temp2."Unit Cost (LCY)";
                                                    Rec83PMP.fecha3 := Rec123Temp2."Posting Date";
                                                    Rec83PMP.cantidad3 := Rec123Temp2."Quantity (Base)";
                                                end;
                                                if numdoc = 4 then begin
                                                    Rec83PMP.doc4 := Rec123Temp2.Description;
                                                    Rec83PMP.cantidad4 := Rec123Temp2.Quantity;
                                                    Rec83PMP.precio4 := Rec123Temp2."Unit Cost (LCY)";
                                                    Rec83PMP.fecha4 := Rec123Temp2."Posting Date";
                                                    Rec83PMP.cantidad4 := Rec123Temp2."Quantity (Base)";
                                                end;
                                                if numdoc = 5 then begin
                                                    Rec83PMP.doc5 := Rec123Temp2.Description;
                                                    Rec83PMP.cantidad5 := Rec123Temp2.Quantity;
                                                    Rec83PMP.precio5 := Rec123Temp2."Unit Cost (LCY)";
                                                    Rec83PMP.fecha5 := Rec123Temp2."Posting Date";
                                                    Rec83PMP.cantidad5 := Rec123Temp2."Quantity (Base)";
                                                end;
                                                if numdoc = 6 then begin
                                                    Rec83PMP.doc6 := Rec123Temp2.Description;
                                                    Rec83PMP.cantidad6 := Rec123Temp2.Quantity;
                                                    Rec83PMP.precio6 := Rec123Temp2."Unit Cost (LCY)";
                                                    Rec83PMP.fecha6 := Rec123Temp2."Posting Date";
                                                    Rec83PMP.cantidad6 := Rec123Temp2."Quantity (Base)";
                                                end;
                                                if numdoc = 7 then begin
                                                    Rec83PMP.doc7 := Rec123Temp2.Description;
                                                    Rec83PMP.cantidad7 := Rec123Temp2.Quantity;
                                                    Rec83PMP.precio7 := Rec123Temp2."Unit Cost (LCY)";
                                                    Rec83PMP.fecha7 := Rec123Temp2."Posting Date";
                                                    Rec83PMP.cantidad7 := Rec123Temp2."Quantity (Base)";
                                                end;
                                                if numdoc = 8 then begin
                                                    Rec83PMP.doc8 := Rec123Temp2.Description;
                                                    Rec83PMP.cantidad8 := Rec123Temp2.Quantity;
                                                    Rec83PMP.precio8 := Rec123Temp2."Unit Cost (LCY)";
                                                    Rec83PMP.fecha8 := Rec123Temp2."Posting Date";
                                                    Rec83PMP.cantidad8 := Rec123Temp2."Quantity (Base)";
                                                end;
                                                if numdoc = 9 then begin
                                                    Rec83PMP.doc9 := Rec123Temp2.Description;
                                                    Rec83PMP.cantidad9 := Rec123Temp2.Quantity;
                                                    Rec83PMP.precio9 := Rec123Temp2."Unit Cost (LCY)";
                                                    Rec83PMP.fecha9 := Rec123Temp2."Posting Date";
                                                    Rec83PMP.cantidad9 := Rec123Temp2."Quantity (Base)";
                                                end;
                                                if numdoc = 10 then begin
                                                    Rec83PMP.doc10 := Rec123Temp2.Description;
                                                    Rec83PMP.cantidad10 := Rec123Temp2.Quantity;
                                                    Rec83PMP.precio10 := Rec123Temp2."Unit Cost (LCY)";
                                                    Rec83PMP.fecha10 := Rec123Temp2."Posting Date";
                                                    Rec83PMP.cantidad10 := Rec123Temp2."Quantity (Base)";
                                                end;

                                                Rec83PMP.Modify;
                                            end;

                                        end;
                                        YY := YY + 1;
                                        IMPORTE := IMPORTE + Rec123Temp2.Quantity * Rec123Temp2."Unit Cost (LCY)";
                                        ULTPRE := Rec123Temp2."Unit Cost (LCY)";
                                        LINLIN := 0;
                                    until (Rec123Temp2.Next = 0) or (YY >= STOCKTOTAL);
                                if YY < STOCKTOTAL then begin
                                    IMPORTE := IMPORTE + ((STOCKTOTAL - YY) * ULTPRE);
                                end;
                            end;
                            if STOCKTOTAL > 0 then begin

                                Rec83PMP.Reset;
                                Rec83PMP.SetRange("Journal Template Name", 'PMP');
                                Rec83PMP.SetRange("Item No.", RecItem."No.");
                                Rec83PMP.SetRange("Posting Date", afecha);
                                if Rec83PMP.FindFirst then begin
                                    PMP := 0;
                                    if STOCKTOTAL <> 0 then begin
                                        PMP := ROUND(IMPORTE / STOCKTOTAL, 0.001);
                                    end;
                                    Rec83PMP."Unit Cost" := PMP;
                                    Rec83PMP.Amount := IMPORTE;
                                    Rec83PMP.Quantity := STOCKTOTAL;
                                    Rec83PMP.Modify;
                                end;
                                if not Rec83PMP.FindFirst then begin
                                    LINLIN := 0;
                                    Rec83PMP.Reset;
                                    Rec83PMP.SetRange("Journal Template Name", 'PMP');
                                    if Rec83PMP.FindLast then begin
                                        LINLIN := Rec83PMP."Line No.";
                                    end;
                                    Rec83PMP.Init;
                                    Rec83PMP."Journal Template Name" := 'PMP';
                                    Rec83PMP."Item No." := RecItem."No.";
                                    LINLIN := LINLIN + 1;
                                    Rec83PMP."Line No." := LINLIN;
                                    Rec83PMP."Posting Date" := afecha;
                                    PMP := 0;
                                    if STOCKTOTAL <> 0 then begin
                                        PMP := ROUND(IMPORTE / STOCKTOTAL, 0.001);
                                    end;
                                    Rec83PMP."Unit Cost" := PMP;
                                    Rec83PMP.Amount := IMPORTE;
                                    Rec83PMP.Quantity := STOCKTOTAL;
                                    Rec83PMP.Description := RecItem.Description;
                                    Rec83PMP.Insert;
                                end;
                            end;
                        end;
                    until RecItem.Next = 0;


            until Recdate.Next = 0;
        VENTANA.Close;

        Message('Proceso realizado.');
    end;

    var
        WindowStyle: Integer;
        WaitForEnd: Boolean;
        ReturnValue: Integer;
        RecTransp: Record "Shipping Agent";
        PAGINAWEB: Text;
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        FixedAsset: Record "Fixed Asset";
        FALedgerEntry: Record "FA Ledger Entry";
        ValueEntry: Record "Value Entry";
        Vendor: Record Vendor;
        SalesShipmentLine: Record "Sales Shipment Line";
        Rec1: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        SalesLineDiscount: Record "Sales Line Discount";
        SalesLineDiscount2: Record "Sales Line Discount";
        SalesPrice: Record "Sales Price";
        SalesPrice2: Record "Sales Price";
        Rec83: Record "Item Journal Line";
        Rec832: Record "Item Journal Line";
        RecSDP: Record "Item Journal Batch";
        RecRMP: Record "Item Register";
        RecBom: Record "BOM Component";
        RecRMP2: Record "Item Register";
        BLOQ: Boolean;
        RecItemP: Record Item;
        autXLSerie: Integer;
        "añoactual": Integer;
        "añoanterior": Integer;
        "añoanterior2": Integer;
        "AÑO": Integer;
        VENTANA: Dialog;
        RecFecha: Record Date;
        RecClie: Record Customer;
        RecProvee: Record Vendor;
        RecMovClie: Record "Cust. Ledger Entry";
        RecPeriodo: Record "Accounting Period";
        intFila: Integer;
        dlgDialogo: Dialog;
        Meses: Option " ",Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre;
        "Años": array[4] of Date;
        i: Integer;
        x: Integer;
        ImporteImpagados: Decimal;
        RecGCE: Record "Gen. Product Posting Group";
        ACumAnt2: Decimal;
        ACumAnt: Decimal;
        ACumAct: Decimal;
        MesAnt2: Decimal;
        MesAnt: Decimal;
        MesAct: Decimal;
        IncDecAct2: Decimal;
        IncDecAct: Decimal;
        RecV: Record "Salesperson/Purchaser";
        RecPais: Record "Country/Region";
        RecProv: Record "Area";
        CMES: Integer;
        "CAÑO": Integer;
        CArea: Option "Tapicería","Decoración";
        CMercado: Option Nacional,"Exportación";
        TACumAnt: Decimal;
        TACumAnt2: Decimal;
        TACumAct: Decimal;
        TMesAnt2: Decimal;
        TMesAnt: Decimal;
        TMesAct: Decimal;
        TIncDecAct: Decimal;
        RecItem: Record Item;
        CODDIBU: Text[20];
        TIncDecAct2: Decimal;
        CodVende: Code[10];
        codletra: Code[10];
        XY: Integer;
        Rec32: Record "Item Ledger Entry";
        Rec32LM: Record "Item Ledger Entry";
        Expositores: Decimal;
        CODVEN: Code[20];
        MOTIVO: Text[50];
        DESDETACT: Date;
        HASTATACT: Date;
        ULTDIA: Date;
        PRIDIA: Date;
        DESDETANT: Date;
        HASTATANT: Date;
        DESDETANT2: Date;
        HASTATANT2: Date;
        RecMI: Record "VAT Entry";
        FACTURADO: Decimal;
        ABONADO: Decimal;
        PDTEFAC: Decimal;
        TFACTURADO: Decimal;
        TABONADO: Decimal;
        TPDTEFAC: Decimal;
        Rec111: Record "Sales Shipment Line";
        Rec110: Record "Sales Shipment Header";
        Rec112: Record "Sales Invoice Header";
        Rec113: Record "Sales Invoice Line";
        IMPDTOCLIE: Decimal;
        TIMPDTOCLIE: Decimal;
        SUMA: Decimal;
        TANTODTO: Decimal;
        TOTCLIE: Decimal;
        T1: Decimal;
        T2: Decimal;
        T3: Decimal;
        T4: Decimal;
        RecProvin: Record "Area";
        CFACTURADO: Decimal;
        CABONADO: Decimal;
        CPDTEFAC: Decimal;
        CTFACTURADO: Decimal;
        CTABONADO: Decimal;
        CTPDTEFAC: Decimal;
        REC120: Record "Purch. Rcpt. Header";
        REC121: Record "Purch. Rcpt. Line";
        TOTALALB: Decimal;
        DTOFAC: Decimal;
        RecDTOfc: Record "Cust. Invoice Disc.";
        TOTALBASE: Decimal;
        IMPORTEL: Decimal;
        TOTALIVA: Decimal;
        TOTALBASE1: Decimal;
        TANTOREC: Decimal;
        RecCGRIP: Record "VAT Posting Setup";
        RecItem2: Record Item;
        STOCKALGE: Decimal;
        STOCKCAMIO: Decimal;
        STOCKENDL: Decimal;
        OPCION: Integer;
        afecha: Date;
        PRECIO: array[12] of Decimal;
        CANTIDAD: array[12] of Decimal;
        PRIMERO: Integer;
        Rec123: Record "Purch. Inv. Line";
        STOCKGIRO: Decimal;
        Recitem3: Record Item;
        Recitem4: Record Item;
        Recitem5: Record Item;
        Rec123Temp: Record "Purch. Inv. Line" temporary;
        Rec123Temp2: Record "Purch. Inv. Line" temporary;
        LIN: Integer;
        XX: Integer;
        YY: Integer;
        DOCPRECIO: array[12] of Text[30];
        STOCKTOTAL: Decimal;
        SUMACOMPRA: Decimal;
        IMPORTE: Decimal;
        totalcant: Decimal;
        ULTPRE: Decimal;
        rec91: Record "User Setup";
        RecMV: Record "Value Entry";
        RecMVLM: Record "Value Entry";
        VTAPERIODO: Decimal;
        IR: Decimal;
        MARGEN: Decimal;
        CR: Decimal;
        STOCKPERI: Decimal;
        DESDEFECHA: Date;
        HASTAFECHA: Date;
        hojacatalogo: Code[10];
        MEDIAPRECIO: Decimal;
        VALALGE: Decimal;
        VALGIRO: Decimal;
        VALCER: Decimal;
        ULTVTAFECHA: Date;
        ULTCOMFECHA: Date;
        ULTCOMUNI: Decimal;
        ULTVTAUNI: Decimal;
        Rec321: Record "Item Ledger Entry";
        stockxpo: Decimal;
        LIN2: Integer;
        Recitemlm2: Record Item;
        RecBOMC: Record "BOM Component";
        Rec1234TempLM: Record "Purch. Inv. Line" temporary;
        Rec1234Temp2LM: Record "Purch. Inv. Line" temporary;
        sumalm: Decimal;
        Rec1232: Record "Purch. Inv. Line";
        CANTIDADL: Integer;
        STOCKALGELM: Decimal;
        STOCKCAMIOLM: Decimal;
        STOCKENDLLM: Decimal;
        STOCKGIROLM: Decimal;
        PRECIOLM: array[12] of Decimal;
        CANTIDADLM: array[12] of Decimal;
        PRIMEROLM: Decimal;
        LINLM: Integer;
        XXLM: Integer;
        YYLM: Integer;
        DOCPRECIOLM: array[12] of Text[30];
        STOCKTOTALLM: Decimal;
        SUMACOMPRALM: Decimal;
        IMPORTELM: Decimal;
        totalcantLM: Decimal;
        ULTPRELM: Decimal;
        MEDIAPRECIOLM: Decimal;
        RecItem222: Record Item;
        CANTIDADLML: Decimal;
        RecBM2: Record "BOM Component";
        SUMALMI: Decimal;
        RecItemBC: Record Item;
        intULTCOMUNI: Decimal;
        intULTVTAUNI: Decimal;
        intULTCOMFECHA: Date;
        intULTVTAFECHA: Date;
        FECHAULTVTA: Date;
        "AÑOULTVTA": Integer;
        Rec322: Record "Item Ledger Entry";
        FECHAULTVTAG: Date;
        "AÑOULTVTAG": Integer;
        STOCKMADRID: Decimal;
        VALMAD: Decimal;
        VALOROTROS: Decimal;
        STOCKOTROS: Decimal;
        DIFOTROS: Decimal;
        ArchSalida: File;
        ArchSalida2: File;
        ArchSalida3: File;
        ArchSalida4: File;
        ArchSalida5: File;
        ArchSalida6: File;
        ArchExt: Text[80];
        TextoSalida1: Text[250];
        TextoSalida2: Text[250];
        TextoSalida3: Text[250];
        TextoSalida4: Text[250];
        TextoSalida5: Text[250];
        TextoSalida6: Text[250];
        TextoSalida7: Text[250];
        TextoSalida8: Text[250];
        TextoSalida9: Text[250];
        stoctot: Decimal;
        RecLoca: Record Location;
        STG1: Decimal;
        STG2: Decimal;
        STG3: Decimal;
        v: Dialog;
        RecGLE1: Record "G/L Entry";
        SalesInvHeader: Record "Sales Invoice Header";
        RecCust: Record Customer;
        SalesInvHeader2: Record "Sales Invoice Header";
        FileDirectory: Code[250];
        FileName: Code[250];
        RunOnceFile: Text[250];
        TimeOut: Integer;
        SenderName: Code[250];
        Body: Code[250];
        Subject: Code[250];
        SenderAddress: Code[250];
        Recipient: Code[250];
        SalesInvHeader3: Record "Sales Invoice Header";
        Rec114: Record "Sales Cr.Memo Header";
        Rec1142: Record "Sales Cr.Memo Header";
        Rec1143: Record "Sales Cr.Memo Header";
        ST1: Decimal;
        ST2: Decimal;
        ST3: Decimal;
        ST4: Decimal;
        ST5: Decimal;
        ST6: Decimal;
        ST7: Decimal;
        VT1: Decimal;
        VT2: Decimal;
        VT3: Decimal;
        VT4: Decimal;
        VT5: Decimal;
        VT6: Decimal;
        VT7: Decimal;
        Rec83PMP: Record "Inventario PMP";
        PMP: Decimal;
        LINLIN: Integer;
        Recdate: Record Date;
        PC: Decimal;
        CODDIVI: Code[20];
        RecPC: Record "Purchase Price";
        DTO: Decimal;
        sincompras: Boolean;
        ndoc: Code[20];
        numdoc: Integer;


}

