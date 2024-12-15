#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50019 Canarias
{

    trigger OnRun()
    begin





        RecVYC.Get;

        Rec110.Reset;
        Rec110.ChangeCompany('ROLF C HAGEN ESPAÑA S.A.');
        Rec110.SetCurrentkey(Rec110."Pasar a Canarias", Rec110."Pasada a Canarias");
        ///Rec110.SETRANGE("No.",'16CF-0823');
        Rec110.SetRange(Rec110."Pasar a Canarias", true);
        Rec110.SetRange(Rec110."Pasada a Canarias", false);
        if Rec110.FindSet then
            repeat
                /////  ERROR('%1',Rec110."No.");
                if not SalesInvoiceHeader.Get(Rec110."No.") then begin
                    Rec36.Init;
                    Rec36."Document Type" := 2;
                    Rec36."No." := Rec110."No.";
                    Rec36."Posting No." := Rec110."No.";
                    Rec36."Order Date" := Rec110."Posting Date";
                    Rec36."Posting Date" := Rec110."Posting Date";
                    Rec36."Document Date" := Rec110."Posting Date";
                    Rec36.Validate(Rec36."Sell-to Customer No.", Rec110."Sell-to Customer No.");
                    Rec36."Bill-to Customer No." := Rec110."Sell-to Customer No.";
                    Rec36."Your Reference" := Rec110."No.";
                    Rec36."External Document No." := Rec110."No.";
                    Rec36."Nº expedición" := Rec110."Nº expedición";
                    Rec36.Insert(true);
                    Rec36."Posting No. Series" := 'V-FAC+';
                    Rec36.Modify(true);
                    Rec111.ChangeCompany('ROLF C HAGEN ESPAÑA S.A.');
                    Rec111.Reset;
                    Rec111.SetRange(Rec111."Document No.", Rec110."No.");
                    if Rec111.FindSet then
                        repeat
                            if Rec111.Quantity <> 0 then begin
                                Rec37.Init;
                                Rec37."Document Type" := 2;
                                Rec37."Document No." := Rec110."No.";
                                Rec37."Line No." := Rec111."Line No.";
                                Rec37.Validate(Rec37.Type, 1);
                                Rec37.Validate(Rec37."No.", '70000000');
                                Rec37.Description := Rec111.Description;
                                Rec37.Validate(Rec37.Quantity, Rec111.Quantity);
                                Rec37.Validate(Rec37."Unit Price", Rec111."Unit Price");
                                Rec37.Validate(Rec37."Gen. Prod. Posting Group", Rec111."Gen. Prod. Posting Group");
                                ivaigic := '';
                                prod.ChangeCompany('ROLF C HAGEN ESPAÑA S.A.');
                                if prod.Get(Rec111."No.") then begin
                                    ivaigic := prod."IVA IGIC";
                                    Rec37."ean canarias" := prod.ean;
                                end;
                                Rec37.Validate(Rec37."VAT Prod. Posting Group", ivaigic);
                                Rec37.Validate(Rec37."VAT Bus. Posting Group", 'IGIC');
                                Rec37."Precio base" := Rec111."Unit Price";
                                Rec37.Validate(Rec37."Line Discount %", Rec111."Line Discount %");
                                Rec37."Description 2" := Rec111."No.";
                                Rec37.Insert;
                            end;
                        until Rec111.Next = 0;
                    Rec362.Reset;
                    Rec362.SetRange(Rec362."Document Type", Rec36."Document Type");
                    Rec362.SetRange(Rec362."No.", Rec36."No.");
                    if Rec362.FindFirst then begin
                        Codeunit.Run(Codeunit::"Sales-Post", Rec362);
                        SalesInvoiceHeader.Reset;
                        SalesInvoiceHeader.SetRange("No.", Rec362."Last Posting No.");
                        if SalesInvoiceHeader.FindFirst then begin
                            Report.Run(50914, false, false, SalesInvoiceHeader);
                        end;
                    end;
                end;



                Rec1120.ChangeCompany('ROLF C HAGEN ESPAÑA S.A.');
                Rec1120.Get(Rec110."No.");
                Rec1120."Pasar a Canarias" := false;
                Rec1120."Pasada a Canarias" := true;
                Rec1120.Modify;

            until Rec110.Next = 0;


        ///CLEAR(Codeunit50010);
        ///Codeunit50010.ENVIAREMIALFACTURASCANARIAS;






        RecCCP.Get;

        Rec112.Reset;
        Rec112.ChangeCompany('ROLF C HAGEN ESPAÑA S.A.');
        Rec112.SetCurrentkey(Rec112."Pasar a Canarias", Rec112."Pasada a Canarias");
        Rec112.SetRange(Rec112."Pasar a Canarias", true);
        Rec112.SetRange(Rec112."Pasada a Canarias", false);
        if Rec112.FindSet then
            repeat
                Rec38.Init;
                contadorfac := CU_NEXT.GetNextNo(RecCCP."Invoice Nos.", Today, true);
                Rec38."Document Type" := 2;
                Rec38."No." := contadorfac;
                Rec38."Order Date" := Rec112."Posting Date";
                Rec38."Posting Date" := Rec112."Posting Date";
                Rec38."Expected Receipt Date" := Rec112."Posting Date";
                Rec38."Document Date" := Rec112."Posting Date";
                Rec38.Validate(Rec38."Buy-from Vendor No.", 'P02538');
                Rec38."Your Reference" := Rec112."No.";
                Rec38."Vendor Invoice No." := Rec112."No.";
                Rec38."Receiving No. Series" := 'C-ALB';
                Rec38.Insert(true);
                Rec113.ChangeCompany('ROLF C HAGEN ESPAÑA S.A.');
                Rec113.Reset;
                Rec113.SetRange(Rec113."Document No.", Rec112."No.");
                if Rec113.FindSet then
                    repeat
                        if Rec113.Quantity <> 0 then begin
                            Rec39.Init;
                            Rec39."Document Type" := 2;
                            Rec39."Document No." := contadorfac;
                            Rec39."Line No." := Rec113."Line No.";
                            Rec39.Validate(Rec39.Type, 1);
                            Rec39.Validate(Rec39."No.", '60000000');
                            Rec39.Description := Rec113.Description;
                            Rec39.Validate(Rec39.Quantity, Rec113.Quantity);
                            Rec39.Validate(Rec39."Direct Unit Cost", ROUND(Rec113.Amount / Rec113.Quantity, 0.001));
                            Rec39.Validate(Rec39."VAT Bus. Posting Group", Rec113."VAT Bus. Posting Group");
                            Rec39.Validate(Rec39."VAT Prod. Posting Group", Rec113."VAT Prod. Posting Group");
                            Rec39.Insert;
                        end;
                    until Rec113.Next = 0;
                Rec382.Reset;
                Rec382.SetRange(Rec382."Document Type", Rec38."Document Type");
                Rec382.SetRange(Rec382."No.", Rec38."No.");
                if Rec382.FindFirst then begin
                    Codeunit.Run(Codeunit::"Purch.-Post", Rec382);
                end;



                Rec1122.ChangeCompany('ROLF C HAGEN ESPAÑA S.A.');
                Rec1122.Get(Rec112."No.");
                Rec1122."Pasar a Canarias" := false;
                Rec1122."Pasada a Canarias" := true;
                Rec1122.Modify;

            until Rec112.Next = 0;
    end;

    var
        OK: Boolean;
        ventana: Dialog;
        RecCC: Record "General Ledger Setup";
        RecItem: Record Item;
        RecMT2: Record "Multitabla 2";
        RecLC: Record "Purchase Line";
        PRIMERA: Boolean;
        DESDE: Date;
        RecClie: Record Customer;
        RecItem2: Record Item;
        Rec32: Record "Item Ledger Entry";
        VENTANA2: Dialog;
        SUMA: Decimal;
        PARA1: Decimal;
        PARA2: Decimal;
        dato1: Decimal;
        dato2: Decimal;
        diascompara: Integer;
        RecProve: Record Vendor;
        diablo: Code[10];
        diasprov: Decimal;
        DIASPARALLEGADA: Decimal;
        RecProd: Record Item;
        RUTA: Text[250];
        DAT1: Text[255];
        DAT2: Text[255];
        dPromedio: Decimal;
        dRotacion: Decimal;
        dVentas: Decimal;
        dSUMAPROM: Decimal;
        dCUANTOSPROD: Decimal;
        RecFecha: Record Date;
        RecItem22: Record Item;
        RecItem3: Record Item;
        DESDE2: Date;
        VENTANA3: Dialog;
        dispo: Decimal;
        ArchSalida: File;
        ArchExt: Text[250];
        TextoSalida: Text[250];
        dispoc: Code[10];
        CU_Q: Codeunit "Facturar sin imprimir";
        CU_50010: Codeunit "Automaticos Cartas";
        RecBom: Record "BOM Component";
        ELMIN: Decimal;
        ResItem2: Record Item;
        ResItem5: Record Item;
        DISPONI: Decimal;
        PVRTARIFA: Decimal;
        TARIFA: Decimal;
        TextoSalida1: Text[250];
        TextoSalida2: Text[250];
        UNIMEDAD: Decimal;
        FECHARECEP: Date;
        Rec39: Record "Purchase Line";
        Rec38: Record "Purchase Header";
        ventana32: Dialog;
        RecGP: Record "Gen. Product Posting Group";
        CASCII: Codeunit "ANSI <-> ASCII converter2";
        dtext1: Text[200];
        DESDEA: Date;
        Rec112: Record "Sales Invoice Header";
        Rec113: Record "Sales Invoice Line";
        Rec1122: Record "Sales Invoice Header";
        CU_NEXT: Codeunit NoSeriesManagement;
        RecCCP: Record "Purchases & Payables Setup";
        contadorfac: Code[20];
        Rec382: Record "Purchase Header";
        Rec110: Record "Sales Shipment Header";
        Rec111: Record "Sales Shipment Line";
        Rec36: Record "Sales Header";
        Rec37: Record "Sales Line";
        Rec1120: Record "Sales Shipment Header";
        Rec362: Record "Sales Header";
        RecVYC: Record "Sales & Receivables Setup";
        RecUMP: Record "Item Unit of Measure";
        CMARCA: Text[30];
        RecMt: Record Multitabla;
        ivaigic: Code[20];
        prod: Record Item;
        ventana22: Dialog;
        TextoSalida3: Text[250];
        TextoSalida4: Text[250];
        TextoSalida5: Text[250];
        TextoSalida6: Text[250];
        destinofichero: Text[250];
        ENTRA: Boolean;
        RecItem221: Record Item;
        item: Record Item;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Codeunit50010: Codeunit "Automaticos Cartas";
}

