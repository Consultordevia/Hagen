#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50099 "Pantalla almacen Pascual5"
{
    // 
    // 
    // 
    // Standard: letra normal
    // StandardAccent: Azul
    // Strong: Negrita
    // StrongAccent: Azul negrita
    // Attention: Rojo en cursiva
    // AttentionAccent: Azul en cursiva
    // Favorable: Verde negrita
    // UnFavorable: Rojo negrita en cursiva
    // Ambiguos: Naranja
    // Suborodinate: Gris

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableView = sorting("Document Type", "Estado pedido", "Super urgente", Urgente, "Fecha para preparar", "Hora para preparar");
    Permissions = tabledata 110 = rmid, tabledata 112 = rmid, tabledata 114 = rmid, tabledata "Cajas por pedido" = rmid, tabledata 113 = rmid, tabledata 115 = rmid;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = ESTILOLINEA;

                    trigger OnDrillDown()
                    begin


                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", Rec."Document Type");
                        SalesHeader.SetRange("No.", Rec."No.");
                        if SalesHeader.FindFirst then begin

                            Clear(SalesOrder);
                            SalesOrder.SetTableview(SalesHeader);
                            SalesOrder.RunModal;
                        end;
                    end;
                }
                field("Nº expedición"; Rec."Nº expedición")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nº expedición';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Nº expedición dropshp"; Rec."Nº expedición dropshp")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Ampliacion del pedido nº"; Rec."Ampliacion del pedido nº")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ampliacion del pedido nº';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field(PesoReal; PesoReal)
                {
                    ApplicationArea = Basic;
                    Caption = 'Kilos';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ApplicationArea = Basic;
                    StyleExpr = ESTILOLINEA;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Basic;
                    StyleExpr = ESTILOLINEA;
                }
                field("Estado pedido"; Rec."Estado pedido")
                {
                    ApplicationArea = Basic;
                    StyleExpr = ESTILOLINEA;
                    Editable = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic;
                    StyleExpr = ESTILOLINEA;
                    Editable = false;
                }

                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = Basic;
                }
                field("Observación para ALMACEN"; Rec."Observación para ALMACEN")
                {
                    ApplicationArea = Basic;
                    Caption = 'Observación para ALMACEN';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field(Urgente; Rec.Urgente)
                {
                    ApplicationArea = Basic;
                    Caption = 'Urgente';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Super urgente"; Rec."Super urgente")
                {
                    ApplicationArea = Basic;
                    Caption = 'Super urgente';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Fecha alta"; Rec."Fecha alta")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fecha alta';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Fecha para preparar"; Rec."Fecha para preparar")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fecha para preparar';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field(TLinea; TLinea)
                {
                    ApplicationArea = Basic;
                    Caption = 'Lineas';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Total Cantidad"; TotalCantidad)
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                }
                field("Marcar para agrupar"; Rec."Marcar para agrupar")
                {
                    ApplicationArea = Basic;
                    StyleExpr = ESTILOLINEA;
                }
                field("Filtro ECI"; Rec."Filtro ECI")
                {
                    ApplicationArea = Basic;
                    Caption = 'FiltroEci';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Peso DROPSHIMENT"; pesopedido)
                {
                    ApplicationArea = Basic;
                    Caption = 'Peso DROPSHIMENT';
                    Editable = false;
                }
                field("Cajas DROPSHIMENT"; textocaja)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cajas DROPSHIMENT';
                    Editable = false;
                }
                field("Recibido de adaia"; Rec."Recibido de adaia")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recibido de adaia';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("No agrupar en ADAIA"; Rec."No agrupar en ADAIA")
                {
                    ApplicationArea = Basic;
                    Caption = 'No agrupar en ADAIA';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Nº expedición agrupada"; Rec."Nº expedición agrupada")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nº expedición agrupada';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Multi-picking"; Rec."Multi-picking")
                {
                    ApplicationArea = Basic;
                    Caption = 'Multi-picking';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field(NombreComercial; NombreComercial)
                {
                    ApplicationArea = Basic;
                    Caption = 'NombreComercial';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Tipo facturación"; Rec."Tipo facturación")
                {
                    ApplicationArea = Basic;
                    Caption = 'Tipo facturación';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field(Ship; Rec.Ship)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field(Invoice; Rec.Invoice)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Shipping No."; Rec."Shipping No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Posting No."; Rec."Posting No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Usuario para preparar"; Rec."Usuario para preparar")
                {
                    ApplicationArea = Basic;
                    Caption = 'Usuario para preparar';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("Hora para preparar"; Rec."Hora para preparar")
                {
                    ApplicationArea = Basic;
                    Caption = 'Hora para preparar';
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field("VAT Country/Region Code"; Rec."VAT Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = ESTILOLINEA;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Grupo clientes"; Rec."Grupo clientes")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ApplicationArea = Basic;
                }
                field(FechaReenvioAdaia; Rec.FechaReenvioAdaia)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("Enviar a ADAIA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Enviar a ADAIA';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Cu14: Codeunit 50014;
                    begin
                        cu14.Run();
                        EnviaraADAIA;
                    end;
                }
                action("Reenviar a ADAIA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reenviar a ADAIA';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Cu14: Codeunit 50014;
                    begin
                        cu14.Run();
                        ReenviaFicheroaADAIA();
                    end;
                }

                /*
                  CurrPage.SetSelectionFilter(Customer);
                        Customer.Next();
                */
                action("Enviar Seleccionados")
                {
                    ApplicationArea = Basic;
                    Caption = 'Enviar Seleccionados';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Cu14: Codeunit 50014;
                        RecSH: Record "Sales Header";
                    begin
                        cu14.Run();
                        CurrPage.SetSelectionFilter(RecSH);
                        if RecSH.FindFirst() then
                            repeat
                                ///message('%1', RecSH."No.");
                                EnviaraADAIASelccionado(RecSH);
                            until RecSH.next = 0;
                    end;

                }
                action("Incrementa")
                {
                    ApplicationArea = Basic;
                    Caption = 'Incrementa';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        RecSH: Record "Sales Header";
                        RecSH2: Record "Sales Header";

                    begin
                        RecSH.Reset();
                        RecSH.SetRange("Document Type", Rec."Document Type");
                        RecSH.SetRange("No.", Rec."No.");
                        if RecSH.FindFirst() then
                            repeat
                                Incrementos(RecSH);
                            until RecSH.next = 0;

                    end;
                }



                action("Crear EXPEDICION")
                {
                    ApplicationArea = Basic;
                    Caption = 'Crear EXPEDICION';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                    begin
                        CrearEXEDICION;
                    end;
                }
                action("Modifica expedicion")
                {
                    ApplicationArea = Basic;
                    Caption = 'Modifica expedicion';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        Page.RunModal(50008);
                    end;
                }
                action("Eti. PORTUGAL")
                {
                    ApplicationArea = Basic;
                    Caption = 'Eti. PORTUGAL';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        NPEDIDO := Rec."Nº expedición";
                        ImprimeEtiPortugal;
                    end;
                }
                action("ImportaDatosPVPWEB")
                {
                    ApplicationArea = Basic;
                    Caption = 'Importa Datos PVP-WEB';

                    trigger OnAction()
                    var
                        xmldatosPVPWEB: XmlPort "Importa datos PVP WEB";
                    begin
                        clear(xmldatosPVPWEB);
                        xmldatosPVPWEB.run;
                        Message('hecho');

                    end;
                }


                action(unitprice)
                {
                    ApplicationArea = Basic;
                    Caption = 'unitprice';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        xmlunitprice: XmlPort "Importa datos precio venta";
                        PMP: Decimal;
                        RecPMP: Record "Inventario PMP";
                        Rec112: Record "Sales Invoice Header";
                        Rec113: Record "Sales Invoice Line";
                        Rec114: Record "Sales Cr.Memo Header";
                        Rec115: Record "Sales Cr.Memo Line";
                        Rec36: Record "Sales Header";
                        Reccust: Record customer;
                        v: Dialog;
                        conta: Integer;
                        XmlPort50101: XmlPort 50006;
                    begin
                        v.Open('#1######################');
                        XmlPort50101.run;
                        /*
                                                Reccust.Reset();
                                                ;
                                                if Reccust.FindSet() then
                                                    repeat
                                                        v.Update(1, Reccust."No.");
                                                        Reccust."Invoice Type" := Reccust."Invoice Type"::"F1 Invoice";
                                                        Reccust."Cr. Memo Type" := Reccust."Cr. Memo Type"::"R1 Corrected Invoice";
                                                        Reccust.Modify;
                                                    until Reccust.next = 0;
                                                Reccust.Reset();
                                                ;
                                                Reccust.Reset();
                                                ;
                                                Reccust.SetRange("No.", '11010');
                                                if Reccust.FindSet() then
                                                    repeat
                                                        v.Update(1, Reccust."No.");
                                                        Reccust."Invoice Type" := Reccust."Invoice Type"::"F2 Simplified Invoice";
                                                        Reccust."Cr. Memo Type" := Reccust."Cr. Memo Type"::"R2 Corrected Invoice (Art. 80.3)";
                                                        Reccust.Modify;
                                                    until Reccust.next = 0;


                                                rec112.Reset();
                                                ;
                                                REC112.SetRange("Posting Date", 20250101D, Today);
                                                if Rec112.FindSet() then
                                                    repeat
                                                        v.Update(1, Rec112."No.");
                                                        Reccust.get(rec112."Bill-to Customer No.");
                                                        rec112."Invoice Type" := Reccust."Invoice Type";
                                                        rec112.Modify;
                                                    until rec112.next = 0;

                                                rec114.Reset();
                                                ;
                                                REC114.SetRange("Posting Date", 20250101D, Today);
                                                if Rec114.FindSet() then
                                                    repeat
                                                        v.Update(1, Rec114."No.");
                                                        Reccust.get(rec114."Bill-to Customer No.");
                                                        rec114."Cr. Memo Type" := Reccust."Cr. Memo Type";
                                                        rec114.Modify;
                                                    until rec114.next = 0;

                                                      rec112.Reset();
                                                */
                        /*
                                                if Rec36.FindSet() then
                                                    repeat
                                                        v.Update(1, Rec36."No.");
                                                        if Reccust.get(Rec36."Bill-to Customer No.") then begin

                                                            rec36."Invoice Type" := Reccust."Invoice Type";
                                                            rec36."Cr. Memo Type" := Reccust."Cr. Memo Type";
                                                            rec36.Modify;
                                                        end;
                                                    until rec36.next = 0;

                        */

                        /*clear(xmlunitprice);
                        xmlunitprice.Run();                
                        Message('hecho');*/
                        /*
                        v.Open('#1######################');
                        conta:=0;
                        Reccust.reset;
                        IF Reccust.FindFirst() THEN repeat
                            Reccust."No enviar excel":=TRUE;                             
                            Reccust.Modify;
                        UNTIL Reccust.NEXT=0;
                        */

                        /*rec113.Reset();;
                        REC113.SetRange("Posting Date",20240101D,20241231D);    
                        REC113.SetRange(type,rec113.type::Item);
                        if Rec113.FindSet() then repeat
                            v.Update(1,Rec113."Document No.");
                            conta:=conta+1;
                            if conta>1000 then begin
                                Commit();;
                                conta:=0;
                            end;
                            
                            PMP := 0;
                            RecPMP.RESET;
                            RecPMP.SETCURRENTKEY(RecPMP."Item No.", RecPMP."Posting Date");
                            RecPMP.SETRANGE(RecPMP."Item No.", rec113."No.");
                            RecPMP.SETRANGE(RecPMP."Posting Date", 0D, Rec113."Posting Date");
                            IF RecPMP.FINDLAST THEN BEGIN
                                PMP := RecPMP."Unit Cost";
                            END;
                            rec113."Unit Cost (LCY)":=pmp;
                            rec113.Modify;
                        until rec113.next=0;

                        rec115.Reset();;
                        REC115.SetRange("Posting Date",20240101D,20241231D);    
                        REC115.SetRange(type,rec115.type::Item);
                        if Rec115.FindSet() then repeat
                        v.Update(1,Rec115."Document No.");
                        if conta>1000 then begin
                                Commit();;
                                conta:=0;
                            end;
                            
                            PMP := 0;
                            RecPMP.RESET;
                            RecPMP.SETCURRENTKEY(RecPMP."Item No.", RecPMP."Posting Date");
                            RecPMP.SETRANGE(RecPMP."Item No.", rec115."No.");
                            RecPMP.SETRANGE(RecPMP."Posting Date", 0D, Rec115."Posting Date");
                            IF RecPMP.FINDLAST THEN BEGIN
                                PMP := RecPMP."Unit Cost";
                            END;
                            rec115."Unit Cost (LCY)":=pmp;
                            rec115.Modify;
                        until rec115.next=0;
                        */
                        v.Close();
                        Message('hecho');




                    end;
                }





                action(variant11)
                {
                    ApplicationArea = Basic;
                    Caption = 'ENVIAREMIALFACTURAS';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var

                        Automaticos: Codeunit "Automaticos Cartas";
                        RecHFV: Record "Sales Invoice Header";
                        RecCust: record Customer;
                        Rec222: Record 222;
                        v: Dialog;

                    begin
                        v.open('#1###########################');
                        if RecCust.FindFirst() then
                            repeat
                                v.Update(1, RecCust."No.");
                                if RecCust."Nº movil" = '617285625' then begin
                                    RecCust."Nº movil" := '';
                                    RecCust.Modify();
                                end;
                            until RecCust.next = 0;
                        v.Close();
                        Message('hecho');

                        /*IF RecItem.FindFirst() THEN repeat
                            RecItem.CalcFields("PVP-Web2");
                            RecItem."PVP-Web":=RecItem."PVP-Web2";
                            RecItem.Modify;
                        UNTIL RecItem.NEXT=0;
                        */

                        //RecHFV.Reset();;
                        //RecHFV.SetRange("Posting Date",20250127D,TODAY);
                        //if RecHFV.FindFirst then repeat
                        //  Automaticos.ENVIAREMIALFACTURAS(RecHFV);
                        //until RecHFV.next=0;


                        /*
                        RecItem.RESET;
                        if RecItem.FindFirst() then
                            repeat
                            RecSP.reset;
                            RecSP.SetRange("Sales Code",'2022-2');
                            RecSP.SetRange("Item No.",RecItem."No.");
                            if RecSP.FindLast() then begin
                                    RecSP."Unit Price":=RecSP."Unit Price";
                                    RecSP.Modify();
                            end;                               
                                
                            until RecItem.next = 0;
                            */


                    end;
                }
                /*
                                    action(variant112)
                                    {
                                    ApplicationArea = Basic;
                                    Caption = 'variante2';
                                    Ellipsis = true;
                                    Promoted = true;
                                    PromotedIsBig = true;
                                    PromotedOnly = true;

                                    trigger OnAction()
                                    var
                                        RecItem: Record Item;
                                        RecMA: Record "Mul.atributos";
                                    begin
                                        RecItem.RESET;
                                        if RecItem.FindFirst() then
                                            repeat
                                                if (RecItem."Dato Variante1" <> '') then begin
                                                    RecMA.Codigo1 := RecItem.CodVariante1;
                                                    RecMA.Codigo2 :=  RecItem."Dato Variante1";
                                                    RecMA."Descripción" := RecItem."Dato Variante1";
                                                    recma.Tabla := recma.Tabla::"Valor Atributo";
                                                    if RecMA.insert then;
                                                end;

                                                if (RecItem."Dato Variante2" <> '') then begin
                                                    RecMA.Codigo1 := RecItem.CodVariante2;
                                                    RecMA.Codigo2 :=  RecItem."Dato Variante2";
                                                    RecMA."Descripción" := RecItem."Dato Variante2";
                                                    recma.Tabla := recma.Tabla::"Valor Atributo";
                                                    if RecMA.insert then;
                                                end;


                                            until RecItem.next = 0;
                                        Message('hecho');

                                    end;
                                }
                */
                /*
                action(DESMARCAR)
                {
                    ApplicationArea = Basic;
                    Caption = 'DESMARCAR';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        RecClie: Record CUSTOMER;
                    begin
                        RecClie.RESET;
                        if RecClie.FindFirst() then
                            repeat
                                if (RecClie."Phone No." = '') and
                                    (RecClie."Mobile Phone No." = '')
                                    then begin
                                    RecClie."Enviar a Web" := false;
                                    RecClie.Modify;
                                end;
                            until RecClie.next = 0;
                        Message('hecho');

                    end;
                }
                */

                /*
                action(USUARIOS)
                {
                    ApplicationArea = Basic;
                    Caption = 'USUARIOS';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        RecCV: Record "Sales Header";
                        RecLV: Record "Sales Line";
                        V: Dialog;


                    begin
                        V.Open('#1##########################################');
                        RecCV.reset;
                        RecCV.SetRange("Posting Date", 20241231D, 20240101D);
                        IF RecCV.FindFirst() THEN
                            REPEAT
                                V.Update(1, 'L' + FORMAT(RECCV."Posting Date"));
                                RECCV."Usuario alta" := 'NAVISION';
                                RecCV."Usuario para preparar" := 'NAVISION';
                                RECCV."Usuario Retenido" := 'NAVISION';
                                RecCV.Modify;
                            UNTIL RECCV.NEXT = 0;
                        RecLV.reset;
                        RecLV.SetRange("Posting Date", 20241231D, 20240101D);
                        IF RecLV.FindFirst() THEN
                            REPEAT
                                V.Update(1, 'L' + FORMAT(RECLV."Posting Date"));
                                RECLV."Usuario alta" := 'NAVISION';
                                RecLV.Modify;
                            UNTIL RECLV.NEXT = 0;
                        Message('HECHO');

                    end;
                }
                */
                action("Marcar como SERVIDO")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        Rec."Estado pedido" := Rec."estado pedido"::Servido;
                        Rec.Modify;
                    end;
                }
                action("Eti. ADAIA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Eti. ADAIA';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin


                        NPEDIDO := Rec."Nº expedición";

                        SalesHeader32.Reset;
                        SalesHeader32.SetRange(SalesHeader32."Document Type", Rec."Document Type");
                        SalesHeader32.SetRange(SalesHeader32."No.", Rec."No.");
                        if SalesHeader32.FindSet then begin
                            Clear(RepETAD);
                            RepETAD.SetTableview(SalesHeader32);
                            RepETAD.RunModal;
                            ///Report 50009 "ETI. envio"
                        end;
                        if Rec."Marcar para agrupar" then begin
                            SalesHeader3.Reset;
                            SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
                            SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
                            SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
                            if SalesHeader3.FindSet then
                                repeat
                                    SalesHeader22.Reset;
                                    SalesHeader22.SetRange(SalesHeader22."Document Type", SalesHeader3."Document Type");
                                    SalesHeader22.SetRange(SalesHeader22."No.", SalesHeader3."No.");
                                    if SalesHeader22.FindSet then begin
                                        Clear(EtiAgrppeque);
                                        EtiAgrppeque.SetTableview(SalesHeader22);
                                        EtiAgrppeque.RunModal;
                                    end;

                                until SalesHeader3.Next = 0;

                        end;
                    end;
                }

                /*action("Cajas DROPSHIMENT1")
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = ShipmentLines;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        CajasDrop;
                    end;
                }
                */
                /*
                action("Eti. drop.agrupada")
                {
                    ApplicationArea = Basic;
                    Caption = 'Eti. drop.agrupada';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        SalesHeader3.Reset;
                        SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
                        SalesHeader3.SetRange(SalesHeader3."No.", Rec."No.");
                        if SalesHeader3.FindSet then begin
                            Clear(ETIenvioagrupadoresumen);
                            ETIenvioagrupadoresumen.SetTableview(SalesHeader3);
                            ETIenvioagrupadoresumen.RunModal;
                        end;
                    end;
                }
                "ETI. envio agrupado ka"
                */
                action("Eti. agrupada Catit")
                {
                    ApplicationArea = Basic;
                    Caption = 'Eti. agrupada Catit';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin


                        SalesHeader4.Reset;
                        SalesHeader4.SetRange("Document Type", 1);
                        SalesHeader4.SetRange("Nº expedición", Rec."Nº expedición");
                        if SalesHeader4.FindSet then
                            repeat
                                SalesHeader3.Reset;
                                SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
                                SalesHeader3.SetRange(SalesHeader3."No.", SalesHeader4."No.");
                                SalesHeader3.SetRange(SalesHeader3."Nº expedición", SalesHeader4."Nº expedición");
                                if SalesHeader3.FindSet then
                                    repeat
                                        /////Message('1 - %1',SalesHeader3."No.");
                                        Clear(ETIenvioagrupadod);
                                        ETIenvioagrupadod.SetTableview(SalesHeader3);
                                        ETIenvioagrupadod.RunModal;
                                    until SalesHeader3.next = 0;
                            until SalesHeader4.next = 0;
                        SalesHeader4.Reset;
                        SalesHeader4.SetRange("Document Type", 1);
                        SalesHeader4.SetRange("Nº expedición", Rec."Nº expedición");
                        if SalesHeader4.FindSet then
                            repeat
                                SalesHeader3.Reset;
                                SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
                                SalesHeader3.SetRange(SalesHeader3."No.", SalesHeader4."No.");
                                SalesHeader3.SetRange(SalesHeader3."Nº expedición", SalesHeader4."Nº expedición");
                                if SalesHeader3.FindSet then
                                    repeat
                                        imprimearena := false;
                                        Rec37.Reset;
                                        Rec37.SetRange(Rec37."Document Type", SalesHeader3."Document Type");
                                        Rec37.SetRange(Rec37."Document No.", SalesHeader3."No.");
                                        Rec37.SetRange(Rec37.Type, 2);
                                        if Rec37.FindFirst then
                                            repeat
                                                if RecItem2.Get(Rec37."No.") then begin
                                                    if RecItem2."Bultos en caja" then begin
                                                        imprimearena := true;
                                                    end;
                                                end;
                                            until Rec37.next = 0;
                                        if imprimearena then begin
                                            Clear(ETIenvioagrupadodARENA);
                                            ETIenvioagrupadodARENA.SetTableview(SalesHeader3);
                                            ETIenvioagrupadodARENA.RunModal;
                                        end;
                                    until SalesHeader3.next = 0;
                            until SalesHeader4.next = 0;
                    end;
                }
                /*
                action("Eti. agrupada Catit ARENA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Eti. agrupada Catit ARENA';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin


                        SalesHeader4.Reset;
                        SalesHeader4.SetRange("Document Type", 1);
                        SalesHeader4.SetRange("Nº expedición", Rec."Nº expedición");
                        if SalesHeader4.FindSet then
                            repeat
                                SalesHeader3.Reset;
                                SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
                                SalesHeader3.SetRange(SalesHeader3."No.", SalesHeader4."No.");
                                SalesHeader3.SetRange(SalesHeader3."Nº expedición", SalesHeader4."Nº expedición");
                                if SalesHeader3.FindSet then
                                    repeat
                                        imprimearena := false;
                                        Rec37.Reset;
                                        Rec37.SetRange(Rec37."Document Type", SalesHeader3."Document Type");
                                        Rec37.SetRange(Rec37."Document No.", SalesHeader3."No.");
                                        Rec37.SetRange(Rec37.Type, 2);
                                        if Rec37.FindFirst then
                                            repeat
                                                if RecItem2.Get(Rec37."No.") then begin
                                                    if RecItem2."Bultos en caja" then begin
                                                        imprimearena := true;
                                                    end;
                                                end;
                                            until Rec37.next = 0;
                                        if imprimearena then begin
                                            Clear(ETIenvioagrupadodARENA);
                                            ETIenvioagrupadodARENA.SetTableview(SalesHeader3);
                                            ETIenvioagrupadodARENA.RunModal;
                                        end;
                                    until SalesHeader3.next = 0;
                            until SalesHeader4.next = 0;
                    end;
                }


                action("Eti. Catit_eti")
                {
                    ApplicationArea = Basic;
                    Caption = 'Eti. Catit_eti';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ETIenvioagrupadoka: report "ETI. envio agrupado ka";

                    begin


                        SalesHeader4.Reset;
                        SalesHeader4.SetRange("Document Type", 1);
                        SalesHeader4.SetRange("Nº expedición", Rec."Nº expedición");
                        if SalesHeader4.FindSet then
                            repeat
                                SalesHeader3.Reset;
                                SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
                                SalesHeader3.SetRange(SalesHeader3."No.", SalesHeader4."No.");
                                SalesHeader3.SetRange(SalesHeader3."Nº expedición", SalesHeader4."Nº expedición");
                                if SalesHeader3.FindSet then
                                    repeat
                                        Clear(ETIenvioagrupadoka);
                                        ETIenvioagrupadoka.SetTableview(SalesHeader3);
                                        ETIenvioagrupadoka.RunModal;
                                    until SalesHeader3.next = 0;
                            until SalesHeader4.next = 0;
                    end;
                }
                */


                action("Eti. agrupada")
                {
                    ApplicationArea = Basic;
                    Caption = 'Eti. agrupada';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin


                        SalesHeader4.Reset;
                        SalesHeader4.SetRange("Document Type", 1);
                        SalesHeader4.SetRange("Nº expedición", Rec."Nº expedición");
                        if SalesHeader4.FindSet then
                            repeat
                                SalesHeader3.Reset;
                                SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
                                SalesHeader3.SetRange(SalesHeader3."No.", SalesHeader4."No.");
                                SalesHeader3.SetRange(SalesHeader3."Nº expedición", SalesHeader4."Nº expedición");
                                if SalesHeader3.FindSet then
                                    repeat
                                        Clear(ETIenvioagrupadod2);
                                        ETIenvioagrupadod2.SetTableview(SalesHeader3);
                                        ETIenvioagrupadod2.RunModal;
                                    until SalesHeader3.next = 0;
                            until SalesHeader4.next = 0;
                    end;
                }
                action("Listado AMAZON")
                {
                    ApplicationArea = Basic;
                    Caption = 'Listado AMAZON';
                    Ellipsis = true;
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        SalesLine.Reset;
                        SalesLine.SetRange("Document Type", 1);
                        SalesLine.SetRange("Nº expedición", Rec."Nº expedición");
                        if SalesLine.FindSet then begin
                            Clear(LineaspedidoAMAZON);
                            LineaspedidoAMAZON.SetTableview(SalesLine);
                            LineaspedidoAMAZON.RunModal;
                        end;
                    end;
                }
                action("Eliminar envio a ADAIA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Eliminar envio a ADAIA';

                    trigger OnAction()
                    begin
                        ReenviaraADAIA;
                    end;
                }
                action("Reprt.Agrupado")
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = Add;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        Clear(LineasPedidosexpedicion);
                        LineasPedidosexpedicion.Run;
                    end;
                }


            }
        }
    }

    trigger OnAfterGetRecord()
    begin



        if Customer.Get(Rec."Sell-to Customer No.") then begin
        end;

        TOTALPedido := Rec.COUNT;


        TotalCantidad := 0;
        TLinea := 0;
        SalesLine.Reset;
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet then
            repeat
                if SalesLine."No." <> 'TRAN' then begin
                    TLinea := TLinea + 1;
                    TotalCantidad := TotalCantidad + SalesLine."Quantity (Base)";
                end;
            until SalesLine.Next = 0;
        Commenta := false;
        if Rec."Observación para ALMACEN" <> '' then begin
            Commenta := true;
        end;


        PesoReal := 0;
        PESO := 0;

        if Rec."Nº expedición" <> '' then begin
            SalesHeader.Reset;
            SalesHeader.SetCurrentkey("Document Type", "Nº expedición");
            SalesHeader.SetRange("Document Type", 1);
            SalesHeader.SetRange("Nº expedición", Rec."Nº expedición");
            if SalesHeader.FindSet then
                repeat
                    SalesLine.Reset;
                    SalesLine.SetRange("Document Type", 1);
                    SalesLine.SetRange("Document No.", SalesHeader."No.");
                    if SalesLine.FindFirst then
                        repeat
                            PESO := PESO + SalesLine."Quantity (Base)" * SalesLine."Gross Weight";
                        until SalesLine.Next = 0;
                until SalesHeader.Next = 0;
            PesoReal := PESO;
        end;




        ESTILOLINEA := '';
        if (Rec."Ship-to Country/Region Code" <> 'ES') and
           (Rec."Ship-to Country/Region Code" <> 'PT') then begin
            ESTILOLINEA := 'Attention';
        end;

        if Rec."Recibido de adaia" then begin
            ESTILOLINEA := 'StandardAccent';
        end;


        textocaja := '';
        Multitabla2.Reset;
        Multitabla2.SetRange("Código 1", Rec."No.");
        if not Multitabla2.FindFirst then begin
            pesopedido := 0;
            cajas0 := 0;
            cajas6 := 0;
            cajas7 := 0;
            cajas8 := 0;
            cajas9 := 0;
            cajas10 := 0;
            SalesLineTC.Reset;
            SalesLineTC.SetRange(SalesLineTC."Document No.", Rec."No.");
            if SalesLineTC.FindFirst then
                repeat
                    if Item.Get(SalesLineTC."No.") then begin
                        if Item."Tipo preparacion" = Item."tipo preparacion"::"0-Sin Caja" then begin
                            cajas0 := cajas0 + SalesLineTC."Quantity (Base)";
                        end;
                        if Item."Tipo preparacion" = Item."tipo preparacion"::"6-Tubo" then begin
                            cajas6 := cajas6 + SalesLineTC."Quantity (Base)";
                        end;
                        if Item."Tipo preparacion" = Item."tipo preparacion"::"7-Alargado" then begin
                            cajas7 := cajas7 + SalesLineTC."Quantity (Base)";
                        end;
                        if Item."Tipo preparacion" = Item."tipo preparacion"::"8-Cuadrado" then begin
                            cajas8 := cajas8 + SalesLineTC."Quantity (Base)";
                        end;
                        if Item."Tipo preparacion" = Item."tipo preparacion"::"9-Gateras" then begin
                            cajas9 := cajas9 + SalesLineTC."Quantity (Base)";
                        end;
                        if Item."Tipo preparacion" = Item."tipo preparacion"::"10-Arena" then begin
                            cajas10 := cajas10 + SalesLineTC."Quantity (Base)";
                        end;
                        if (Item."Tipo preparacion" = Item."tipo preparacion"::"1-Muy pequeño") or
                           (Item."Tipo preparacion" = Item."tipo preparacion"::"2-Pequeño") or
                           (Item."Tipo preparacion" = Item."tipo preparacion"::"3-Mediano") or
                           (Item."Tipo preparacion" = Item."tipo preparacion"::"4-Grande") or
                           (Item."Tipo preparacion" = Item."tipo preparacion"::"5- Extra Grande") then begin
                            pesopedido := pesopedido + (SalesLineTC."Quantity (Base)" * SalesLineTC."Net Weight");
                        end;
                    end;
                until SalesLineTC.Next = 0;
            textocaja := '';
            if cajas0 <> 0 then begin
                textocaja := textocaja + ' CJ00: ' + Format(cajas0);
            end;
            if cajas6 <> 0 then begin
                NCAJAS := cajas6 / 6;
                NCAJAS := ROUND(NCAJAS, 1);
                if NCAJAS = 0 then NCAJAS := 1;
                textocaja := textocaja + ' CJT: ' + Format(NCAJAS);
            end;
            if cajas7 <> 0 then begin
                textocaja := textocaja + ' CJ09: ' + Format(cajas0);
            end;
            if cajas8 <> 0 then begin
                textocaja := textocaja + ' CJ23: ' + Format(cajas0);
            end;
            if cajas9 <> 0 then begin
                textocaja := textocaja + ' CJ22: ' + Format(cajas0);
            end;
            if cajas10 <> 0 then begin
                textocaja := textocaja + ' CJ12: ' + Format(cajas0);
            end;
            if pesopedido <> 0 then begin
                Tipocaja.Reset;
                Tipocaja.SetCurrentkey("Maximo kilos");
                Tipocaja.SetRange(Combinable, true);
                Tipocaja.SetRange("Maximo kilos", pesopedido, 999999);
                if Tipocaja.FindFirst then begin
                    IF Tipocaja."Maximo kilos" <> 0 THEN BEGIN
                        NCAJAS := ROUND(pesopedido / Tipocaja."Maximo kilos", 1);
                    END;
                    if NCAJAS = 0 then NCAJAS := 1;
                    textocaja := textocaja + ' ' + Tipocaja."Tipo caja" + ': ' + Format(NCAJAS);

                end;
                if not Tipocaja.FindFirst then begin
                    Tipocaja.Reset;
                    Tipocaja.SetRange(Combinable, true);
                    if Tipocaja.FindLast then begin
                        NCAJAS := ROUND(pesopedido / 10, 1);
                        if NCAJAS = 0 then NCAJAS := 1;
                        textocaja := textocaja + ' ' + Tipocaja."Tipo caja" + ': ' + Format(NCAJAS);
                    end;
                end;
            end;
        end;


        Multitabla2.Reset;
        Multitabla2.SetRange("Código 1", Rec."No.");
        if Multitabla2.FindFirst then
            repeat
                textocaja := textocaja + ' ' + Multitabla2."Código 2" + ': ' + Format(Multitabla2."Cantidad caja");
            until Multitabla2.Next = 0;
    end;

    var
        PesoReal: Decimal;
        Frecuenciavisitacomercial: Code[10];
        Ampliaciondelpedido: Code[10];
        NombreComercial: Text;
        Commenta: Boolean;
        Base: Decimal;
        TLinea: Decimal;
        REC2: Record "Sales Header";
        REC3: Record "Sales Header";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        CUENTAPT: Decimal;
        Customer: Record Customer;
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        TOTALPedido: Integer;
        PESO: Decimal;
        SalesHeader3: Record "Sales Header";
        SalesHeader4: Record "Sales Header";
        SalesLine5: Record "Sales Line";
        NoSeriesLine: Record "No. Series Line";
        NPEDIDO: Code[20];
        SalesLine3: Record "Sales Line";
        SalesHeader22: Record "Sales Header";
        SalesHeader32: Record "Sales Header";
        contadordeagrup: Code[10];
        npedidos: Integer;
        SalesHeader33: Record "Sales Header";
        SalesHeader35: Record "Sales Header";
        RepETAD: Report "ETI. envio";
        RepDropShi: Report "Etiqueta DROPSHIPPING";
        EtiAgrppeque: Report "ETI. envio agrupado";
        Multitabla: Record Multitabla;
        ExtendedTextHeader: Record "Extended Text Header";
        RepEti: Report "ETI. PORTUGES";
        Item: Record Item;
        X: Integer;
        AutomaticosAdaia: Codeunit "Automaticos Cartas";
        SalesOrder: Page "Sales Order";
        Automaticosvarios: Codeunit "Automaticos Cartas";
        ESTILOLINEA: Text;
        CODTRANS: Code[20];
        TextoColores: Code[20];
        ItemJournalLine: Record "Item Journal Line";
        ConrtadorABC: Integer;
        LETRA: Code[1];
        pesopedido: Decimal;
        SalesLineTC: Record "Sales Line";
        Tipocaja: Record "Tipo caja";
        textocaja: Text;
        sale: Boolean;
        cajas0: Integer;
        cajas6: Integer;
        ItemTC: Record Item;
        NCAJAS: Decimal;
        Multitabla2: Record "Cajas por pedido";
        Tipocajaporpedido: Page "Tipo caja por pedido";
        EXPEDROP: Code[10];
        NoSeriesManagement: Codeunit "No. Series"; // v27
        ETIenvioagrupadoresumen: Report "ETI. envio agrupado resumen";
        ETIenvioagrupadod: Report "ETI. envio agrupado d";
        ETIenvioagrupadodARENA: Report ETIenvioagrupadoArena;
        ETIenvioagrupadoArena: Report "ETIenvioagrupadoArena";
        ETIenvioagrupadod2: Report "ETI. envio agrupado d2";
        cajas7: Integer;
        cajas8: Integer;
        cajas9: Integer;
        cajas10: Integer;
        LineaspedidoAMAZON: Report "Lineas pedido AMAZON";
        SalesLine33: Record "Sales Line";
        npedi: Code[20];
        LineasPedidosexpedicion: Report "Lineas pedido expedicion";
        TotalCantidad: Decimal;


        iMPORTANAV2018: XmlPort "Importa datos nav2018";
        iMPORTANAV20182: XmlPort "Importa datos nav2018-3";
        iMPORTANAV20184: XmlPort "Importa datos nav2018-4";
        iMPORTANAV20185: XmlPort "Importa datos nav2018-5";
        iMPORTANAV20186: XmlPort "Importa datos nav2018-6";
        iMPORTANAV20187: XmlPort "Importa datos nav2018-7";
        iMPORTANAV20188: XmlPort "Importa datos nav2018-8";
        iMPORTANAV2018CLIE: XmlPort "Importa datos nav2018-CLIE";
        RecItem: Record item;
        codprod: code[20];
        codcate: code[20];
        grupo: code[20];

        cod1: code[20];
        cod2: code[20];
        descrip: text;
        sangria: Decimal;
        orden: Decimal;
        RecICP: Record "Item Category";
        cate: Code[20];

        Direnvi: Record "Ship-to Address";
        RecCust: Record Customer;
        AutomaticosBC: Codeunit "AutomaticosBC";
        Rec111: Record "Sales Shipment Line";
        fichero: text[250];
        vv: Dialog;
        imprimearena: Boolean;
        Rec37: Record "Sales Line";
        RecItem2: Record Item;


    /*
        local procedure EnviaraADAIA()    
        var
            AutomaticosAdaia: Codeunit "Automaticos Cartas";
            SalesHeader: Record "Sales Header";
            LogAdaiaPedidos: Record LogAdaiaPedidos;
            LogAdaiaFicheros: Record LogFicherosAdaia;
        begin
            // Commit;  -- ELIMINADO (commit intermedio)

            contadordeagrup := '0';

            if Rec."Nº expedición" <> '' then begin
                /////Error('Ya se ha enviado a Adaia.');
            end;
            NoSeriesLine.Reset;
            if Rec."VAT Country/Region Code" <> 'PT' then begin
                NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAP');
                if Rec."Nº exped. pequeña" then begin
                    NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAPP');
                end;
            end;
            if Rec."VAT Country/Region Code" = 'PT' then begin
                NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAPT');
            end;
            if NoSeriesLine.FindFirst then begin
                NPEDIDO := NoSeriesLine."Last No. Used";
                NoSeriesLine."Last No. Used" := IncStr(NPEDIDO);
                NoSeriesLine.Modify;
            end;

            LogAdaiaFicheros.Init();
            LogAdaiaFicheros.Expedicion := NPEDIDO;
            LogAdaiaFicheros.Error := true;
            if LogAdaiaFicheros.Insert() then;

            SalesReceivablesSetup.Get;
            ItemJournalLine.Reset;
            ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", 'PRODUCTO');
            ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", 'ABC');
            ItemJournalLine.SetRange(ItemJournalLine."Line No.", SalesReceivablesSetup."Ultima letra" + 1);
            if ItemJournalLine.FindFirst then begin
                LETRA := ItemJournalLine."Document No.";
                if SalesReceivablesSetup."Ultima letra" + 1 = 26 then begin
                    SalesReceivablesSetup."Ultima letra" := 1;
                    SalesReceivablesSetup.Modify;
                end;
                if SalesReceivablesSetup."Ultima letra" + 1 <> 26 then begin
                    SalesReceivablesSetup."Ultima letra" := SalesReceivablesSetup."Ultima letra" + 1;
                    SalesReceivablesSetup.Modify;
                end;
            end;

            NPEDIDO := NPEDIDO + LETRA;

            if CopyStr(Rec."No.", 3, 4) = 'CATW' then begin
                NPEDIDO := Rec."Your Reference";
            end;

            if Rec."No agrupar en ADAIA" = false then begin
                CODTRANS := '';
                npedidos := 0;
                npedi := '';
                SalesHeader4.Reset;
                SalesHeader4.SetCurrentkey("Document Type", "Sell-to Customer No.", "Estado pedido");
                SalesHeader4.SetRange(SalesHeader4."Document Type", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader4.SetRange(SalesHeader4."Sell-to Customer No.", Rec."Sell-to Customer No.");
                end;
                SalesHeader4.SetRange(SalesHeader4."Estado pedido", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader4.SetRange(SalesHeader4."Ship-to Address", Rec."Ship-to Address");
                end;
                SalesHeader4.SetRange(SalesHeader4."Nº expedición", '');
                SalesHeader4.SetRange(SalesHeader4."No agrupar en ADAIA", false);
                if Rec."Marcar para agrupar" then begin
                    SalesHeader4.SetRange(SalesHeader4."Marcar para agrupar", true);
                end;
                SalesHeader4.SetRange("Shipping Agent Code", Rec."Shipping Agent Code");
                if SalesHeader4.FindSet then
                    repeat
                        CODTRANS := SalesHeader4."Shipping Agent Code";
                        npedi := SalesHeader4."No.";
                        if CODTRANS <> SalesHeader4."Shipping Agent Code" then begin
                            Error('Tienen distinto transportista. %1 %2 %3', SalesHeader4."No.", CODTRANS, npedi);
                        end;
                        if not SalesHeader4."Respeta Tipo facturacion" then begin
                            npedidos := npedidos + 1;
                        end;
                    until SalesHeader4.Next = 0;

                SalesHeader3.Reset;
                SalesHeader3.SetCurrentkey("Document Type", "Sell-to Customer No.", "Estado pedido");
                SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader3.SetRange(SalesHeader3."Sell-to Customer No.", Rec."Sell-to Customer No.");
                end;
                SalesHeader3.SetRange(SalesHeader3."Estado pedido", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader3.SetRange(SalesHeader3."Ship-to Address", Rec."Ship-to Address");
                end;
                SalesHeader3.SetRange(SalesHeader3."Nº expedición", '');
                SalesHeader3.SetRange(SalesHeader3."No agrupar en ADAIA", false);
                if Rec."Marcar para agrupar" then begin
                    SalesHeader3.SetRange(SalesHeader3."Marcar para agrupar", true);
                end;
                if SalesHeader3.FindSet then
                    repeat
                        SalesHeader33.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                        SalesHeader33."Nº expedición" := NPEDIDO;
                        SalesHeader33."Package Tracking No." := NPEDIDO;
                        SalesLine3.Reset;
                        SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                        SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                        if SalesLine3.FindSet then
                            repeat
                                if SalesLine3.Type = 2 then begin
                                    SalesLine3."Nº expedición" := NPEDIDO;
                                    SalesLine3.Modify;

                                    LogAdaiaPedidos.Init();
                                    LogAdaiaPedidos.Expedicion := NPEDIDO;
                                    LogAdaiaPedidos.Pedido := SalesLine3."Document No.";
                                    LogAdaiaPedidos.Producto := SalesLine3."No.";
                                    LogAdaiaPedidos.Linea := SalesLine3."Line No.";
                                    LogAdaiaPedidos.Cantidad := SalesLine3.Quantity;
                                    if LogAdaiaPedidos.Insert() then;
                                end;

                            until SalesLine3.Next = 0;

                        if npedidos > 1 then begin
                            if SalesHeader3."Tipo facturación" <> 2 then begin
                                if SalesHeader3."Multi-picking" = false then begin
                                    SalesHeader33."Tipo facturación" := 1;
                                end;
                            end;
                        end;
                        SalesHeader33.Modify;
                        if SalesHeader33."Marcar para agrupar" then begin
                            Incrementos(SalesHeader33);
                        end;
                        SalesLine3.Reset;
                        SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                        SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                        if SalesLine3.FindSet then
                            repeat
                                if SalesLine3.Type = 2 then begin
                                    if SalesLine3."Location Code" = '' then begin
                                        Error('Falta el almacen en la lineas %1 %2', SalesLine3."No.", SalesLine3.Description)
                                    end;
                                end;
                            until SalesLine3.Next = 0;
                        if SalesHeader3."Marcar para agrupar" = true then begin
                            if SalesHeader3."Shipping Agent Code" <> 'ECI' then begin
                                SalesHeader22.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                                contadordeagrup := IncStr(contadordeagrup);
                                SalesHeader22."Nº expedición agrupada" := contadordeagrup;
                                EXPEDROP := '';
                                if (Rec.Dropshipping = true) and (Rec."Marcar para agrupar" = true) then begin
                                    EXPEDROP := NoSeriesManagement.GetNextNo('ADAIADROP', Today, true);
                                end;
                                SalesHeader3.CalcFields("Grupo clientes");
                                if (SalesHeader3."Grupo clientes" = 'G52') and (SalesHeader3."Customer Disc. Group" = 'DCCA') then begin
                                    EXPEDROP := CopyStr(SalesHeader3."Your Reference", 1, 10);
                                end;
                                SalesHeader22."Nº expedición dropshp" := EXPEDROP;
                                SalesHeader22."Package Tracking No." := EXPEDROP;
                                SalesHeader22.Modify;
                                if SalesHeader22."Marcar para agrupar" then begin
                                    Incrementos(SalesHeader22);
                                end;
                            end;
                        end;
                    until SalesHeader3.Next = 0;
            end;

            if Rec."No agrupar en ADAIA" = true then begin
                CODTRANS := '';
                npedidos := 0;
                SalesHeader4.Reset;
                SalesHeader4.SetCurrentkey("Document Type", "Sell-to Customer No.", "Estado pedido");
                SalesHeader4.SetRange(SalesHeader4."Document Type", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader4.SetRange(SalesHeader4."Sell-to Customer No.", Rec."Sell-to Customer No.");
                end;
                SalesHeader4.SetRange(SalesHeader4."Estado pedido", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader4.SetRange(SalesHeader4."Ship-to Address", Rec."Ship-to Address");
                end;
                SalesHeader4.SetRange(SalesHeader4."Nº expedición", '');
                SalesHeader4.SetRange(SalesHeader4."No.", Rec."No.");
                if Rec."Marcar para agrupar" then begin
                    SalesHeader4.SetRange(SalesHeader4."Marcar para agrupar", true);
                end;
                if SalesHeader4.FindSet then
                    repeat
                        if not SalesHeader4."Respeta Tipo facturacion" then begin
                            npedidos := npedidos + 1;
                        end;
                    until SalesHeader4.Next = 0;

                SalesHeader3.Reset;
                SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
                SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader3.SetRange(SalesHeader3."Sell-to Customer No.", Rec."Sell-to Customer No.");
                end;
                SalesHeader3.SetRange(SalesHeader3."Estado pedido", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader3.SetRange(SalesHeader3."Ship-to Address", Rec."Ship-to Address");
                end;
                SalesHeader3.SetRange(SalesHeader3."Nº expedición", '');
                SalesHeader3.SetRange(SalesHeader3."No.", Rec."No.");
                if Rec."Marcar para agrupar" then begin
                    SalesHeader3.SetRange(SalesHeader3."Marcar para agrupar", true);
                end;
                if SalesHeader3.FindSet then
                    repeat
                        SalesHeader33.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                        SalesHeader33."Nº expedición" := NPEDIDO;
                        SalesHeader33."Nº expedición dropshp" := EXPEDROP;
                        SalesHeader33."Package Tracking No." := EXPEDROP;
                        SalesLine3.Reset;
                        SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                        SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                        if SalesLine3.FindSet then
                            repeat
                                if SalesLine3.Type = 2 then begin
                                    SalesLine3."Nº expedición" := NPEDIDO;
                                    SalesLine3.Modify;
                                    LogAdaiaPedidos.Init();
                                    LogAdaiaPedidos.Expedicion := NPEDIDO;
                                    LogAdaiaPedidos.Pedido := SalesLine3."Document No.";
                                    LogAdaiaPedidos.Producto := SalesLine3."No.";
                                    LogAdaiaPedidos.Linea := SalesLine3."Line No.";
                                    LogAdaiaPedidos.Cantidad := SalesLine3.Quantity;
                                    if LogAdaiaPedidos.Insert() then;
                                end;
                            until SalesLine3.Next = 0;
                        if npedidos > 1 then begin
                            if SalesHeader3."Tipo facturación" <> 2 then begin
                                if SalesHeader3."Multi-picking" = false then begin
                                    SalesHeader33."Tipo facturación" := 1;
                                end;
                            end;
                        end;
                        SalesHeader33.Modify;
                        if SalesHeader33."Marcar para agrupar" then begin
                            Incrementos(SalesHeader33);
                        end;
                        SalesLine3.Reset;
                        SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                        SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                        if SalesLine3.FindSet then
                            repeat
                                if SalesLine3.Type = 2 then begin
                                    if SalesLine3."Location Code" = '' then begin
                                        Error('Falta el almacen en la lineas %1 %2', SalesLine3."No.", SalesLine3.Description)
                                    end;
                                end;
                            until SalesLine3.Next = 0;
                    until SalesHeader3.Next = 0;
            end;

            // Sleep(3000);  -- ELIMINADO

            SalesHeader3.Reset;
            SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
            SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
            SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
            if SalesHeader3.FindFirst then begin
                Clear(AutomaticosAdaia);

                // ► NUEVO: ENVÍO CON REINTENTOS (x3) + TELEMETRÍA
                if not EnviarExpedicionConReintentos(SalesHeader3, NPEDIDO, 3) then
                    Error('No se pudo exportar la expedición %1 tras varios intentos. Revise telemetría/log.', NPEDIDO);
            end;

            // Commit;  -- ELIMINADO (deja solo uno al final)

            SalesHeader35.Reset;
            SalesHeader35.SetRange(SalesHeader35."Document Type", Rec."Document Type");
            SalesHeader35.SetRange(SalesHeader35."No.", Rec."No.");
            if SalesHeader35.FindFirst then begin
                if CopyStr(SalesHeader35."No.", 3, 3) <> 'WEB' then begin
                    AutomaticosAdaia.ENVIAREMAILPARAPREPARAR(SalesHeader35);
                end;
            end;

            SalesHeader3.Reset;
            SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
            SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
            SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
            if SalesHeader3.FindSet then
                repeat
                    if CopyStr(SalesHeader3."No.", 3, 3) = 'WEB' then begin
                        SalesLine5.Reset;
                        SalesLine5.SetRange(SalesLine5."Document Type", SalesHeader3."Document Type");
                        SalesLine5.SetRange(SalesLine5."Document No.", SalesHeader3."No.");
                        if SalesLine5.FindSet then
                            repeat
                                SalesLine5."Usuario alta" := 'HAGEN\OSCAR';
                                SalesLine5.Modify;
                            until SalesLine5.Next = 0;
                    end;
                until SalesHeader3.Next = 0;

            Commit; // ← ÚNICO COMMIT (final)

            ///// ImprimeEtiAdaia;

            if Rec."VAT Country/Region Code" = 'PT' then begin
                //       ImprimeEtiPortugal;
            end;
        end;
    */


    local procedure EnviaraADAIA()
    var
        AutomaticosAdaia: Codeunit "Automaticos Cartas";
        SalesHeader: Record "Sales Header";
        LogAdaiaPedidos: Record LogAdaiaPedidos;
        LogAdaiaFicheros: Record LogFicherosAdaia;
        ErrTxt: Text;           // ← añadido para mostrar el error
        CRLF: Text[2];          // ← añadido para salto de línea (CRLF)
    begin

        // Commit;  -- ELIMINADO (commit intermedio)

        contadordeagrup := '0';

        if Rec."Nº expedición" <> '' then begin
            /////Error('Ya se ha enviado a Adaia.');
        end;
        NoSeriesLine.Reset;
        if Rec."VAT Country/Region Code" <> 'PT' then begin
            NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAP');
            if Rec."Nº exped. pequeña" then begin
                NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAPP');
            end;
        end;
        if Rec."VAT Country/Region Code" = 'PT' then begin
            NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAPT');
        end;
        if NoSeriesLine.FindFirst then begin
            NPEDIDO := NoSeriesLine."Last No. Used";
            NoSeriesLine."Last No. Used" := IncStr(NPEDIDO);
            NoSeriesLine.Modify;
        end;

        LogAdaiaFicheros.Init();
        LogAdaiaFicheros.Expedicion := NPEDIDO;
        LogAdaiaFicheros.Error := true;
        if LogAdaiaFicheros.Insert() then;

        SalesReceivablesSetup.Get;
        ItemJournalLine.Reset;
        ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", 'PRODUCTO');
        ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", 'ABC');
        ItemJournalLine.SetRange(ItemJournalLine."Line No.", SalesReceivablesSetup."Ultima letra" + 1);
        if ItemJournalLine.FindFirst then begin
            LETRA := ItemJournalLine."Document No.";
            if SalesReceivablesSetup."Ultima letra" + 1 = 26 then begin
                SalesReceivablesSetup."Ultima letra" := 1;
                SalesReceivablesSetup.Modify;
            end;
            if SalesReceivablesSetup."Ultima letra" + 1 <> 26 then begin
                SalesReceivablesSetup."Ultima letra" := SalesReceivablesSetup."Ultima letra" + 1;
                SalesReceivablesSetup.Modify;
            end;
        end;

        NPEDIDO := NPEDIDO + LETRA;

        if CopyStr(Rec."No.", 3, 4) = 'CATW' then begin
            NPEDIDO := Rec."Your Reference";
        end;

        if Rec."No agrupar en ADAIA" = false then begin
            CODTRANS := '';
            npedidos := 0;
            npedi := '';
            SalesHeader4.Reset;
            SalesHeader4.SetCurrentkey("Document Type", "Sell-to Customer No.", "Estado pedido");
            SalesHeader4.SetRange(SalesHeader4."Document Type", 1);
            if Rec."Marcar para agrupar" = false then begin
                SalesHeader4.SetRange(SalesHeader4."Sell-to Customer No.", Rec."Sell-to Customer No.");
            end;
            SalesHeader4.SetRange(SalesHeader4."Estado pedido", 1);
            if Rec."Marcar para agrupar" = false then begin
                SalesHeader4.SetRange(SalesHeader4."Ship-to Address", Rec."Ship-to Address");
            end;
            SalesHeader4.SetRange(SalesHeader4."Nº expedición", '');
            SalesHeader4.SetRange(SalesHeader4."No agrupar en ADAIA", false);
            if Rec."Marcar para agrupar" then begin
                SalesHeader4.SetRange(SalesHeader4."Marcar para agrupar", true);
            end;
            SalesHeader4.SetRange("Shipping Agent Code", Rec."Shipping Agent Code");
            if SalesHeader4.FindSet then
                repeat
                    CODTRANS := SalesHeader4."Shipping Agent Code";
                    npedi := SalesHeader4."No.";
                    if CODTRANS <> SalesHeader4."Shipping Agent Code" then begin
                        Error('Tienen distinto transportista. %1 %2 %3', SalesHeader4."No.", CODTRANS, npedi);
                    end;
                    if not SalesHeader4."Respeta Tipo facturacion" then begin
                        npedidos := npedidos + 1;
                    end;
                until SalesHeader4.Next = 0;

            SalesHeader3.Reset;
            SalesHeader3.SetCurrentkey("Document Type", "Sell-to Customer No.", "Estado pedido");
            SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
            if Rec."Marcar para agrupar" = false then begin
                SalesHeader3.SetRange(SalesHeader3."Sell-to Customer No.", Rec."Sell-to Customer No.");
            end;
            SalesHeader3.SetRange(SalesHeader3."Estado pedido", 1);
            if Rec."Marcar para agrupar" = false then begin
                SalesHeader3.SetRange(SalesHeader3."Ship-to Address", Rec."Ship-to Address");
            end;
            SalesHeader3.SetRange(SalesHeader3."Nº expedición", '');
            SalesHeader3.SetRange(SalesHeader3."No agrupar en ADAIA", false);
            if Rec."Marcar para agrupar" then begin
                SalesHeader3.SetRange(SalesHeader3."Marcar para agrupar", true);
            end;
            if SalesHeader3.FindSet then
                repeat
                    SalesHeader33.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                    SalesHeader33."Nº expedición" := NPEDIDO;
                    SalesHeader33."Package Tracking No." := NPEDIDO;
                    SalesLine3.Reset;
                    SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                    SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                    if SalesLine3.FindSet then
                        repeat
                            if SalesLine3.Type = 2 then begin
                                SalesLine3."Nº expedición" := NPEDIDO;
                                SalesLine3.Modify;

                                LogAdaiaPedidos.Init();
                                LogAdaiaPedidos.Expedicion := NPEDIDO;
                                LogAdaiaPedidos.Pedido := SalesLine3."Document No.";
                                LogAdaiaPedidos.Producto := SalesLine3."No.";
                                LogAdaiaPedidos.Linea := SalesLine3."Line No.";
                                LogAdaiaPedidos.Cantidad := SalesLine3.Quantity;
                                if LogAdaiaPedidos.Insert() then;
                            end;

                        until SalesLine3.Next = 0;

                    if npedidos > 1 then begin
                        if SalesHeader3."Tipo facturación" <> 2 then begin
                            if SalesHeader3."Multi-picking" = false then begin
                                SalesHeader33."Tipo facturación" := 1;
                            end;
                        end;
                    end;
                    SalesHeader33.Modify;
                    if SalesHeader33."Marcar para agrupar" then begin
                        Incrementos(SalesHeader33);
                    end;
                    SalesLine3.Reset;
                    SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                    SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                    if SalesLine3.FindSet then
                        repeat
                            if SalesLine3.Type = 2 then begin
                                if SalesLine3."Location Code" = '' then begin
                                    Error('Falta el almacen en la lineas %1 %2', SalesLine3."No.", SalesLine3.Description)
                                end;
                            end;
                        until SalesLine3.Next = 0;
                    if SalesHeader3."Marcar para agrupar" = true then begin
                        if SalesHeader3."Shipping Agent Code" <> 'ECI' then begin
                            SalesHeader22.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                            contadordeagrup := IncStr(contadordeagrup);
                            EXPEDROP := '';
                            if (Rec.Dropshipping = true) and (Rec."Marcar para agrupar" = true) then begin
                                EXPEDROP := NoSeriesManagement.GetNextNo('ADAIADROP', Today, true);
                            end;
                            SalesHeader3.CalcFields("Grupo clientes");
                            if (SalesHeader3."Grupo clientes" = 'G52') and (SalesHeader3."Customer Disc. Group" = 'DCCA') then begin
                                EXPEDROP := CopyStr(SalesHeader3."Your Reference", 1, 10);
                                ////SalesHeader22.Validate("Bill-to Customer No.", '11010');
                            end;
                            SalesHeader22."Nº expedición dropshp" := EXPEDROP;
                            SalesHeader22."Package Tracking No." := EXPEDROP;
                            SalesHeader22.Modify;
                            if SalesHeader22."Marcar para agrupar" then begin
                                Incrementos(SalesHeader22);
                            end;
                        end;
                    end;
                until SalesHeader3.Next = 0;
        end;

        if Rec."No agrupar en ADAIA" = true then begin
            CODTRANS := '';
            npedidos := 0;
            SalesHeader4.Reset;
            SalesHeader4.SetCurrentkey("Document Type", "Sell-to Customer No.", "Estado pedido");
            SalesHeader4.SetRange(SalesHeader4."Document Type", 1);
            if Rec."Marcar para agrupar" = false then begin
                SalesHeader4.SetRange(SalesHeader4."Sell-to Customer No.", Rec."Sell-to Customer No.");
            end;
            SalesHeader4.SetRange(SalesHeader4."Estado pedido", 1);
            if Rec."Marcar para agrupar" = false then begin
                SalesHeader4.SetRange(SalesHeader4."Ship-to Address", Rec."Ship-to Address");
            end;
            SalesHeader4.SetRange(SalesHeader4."Nº expedición", '');
            SalesHeader4.SetRange(SalesHeader4."No.", Rec."No.");
            if Rec."Marcar para agrupar" then begin
                SalesHeader4.SetRange(SalesHeader4."Marcar para agrupar", true);
            end;
            if SalesHeader4.FindSet then
                repeat
                    if not SalesHeader4."Respeta Tipo facturacion" then begin
                        npedidos := npedidos + 1;
                    end;
                until SalesHeader4.Next = 0;

            SalesHeader3.Reset;
            SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
            SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
            if Rec."Marcar para agrupar" = false then begin
                SalesHeader3.SetRange(SalesHeader3."Sell-to Customer No.", Rec."Sell-to Customer No.");
            end;
            SalesHeader3.SetRange(SalesHeader3."Estado pedido", 1);
            if Rec."Marcar para agrupar" = false then begin
                SalesHeader3.SetRange(SalesHeader3."Ship-to Address", Rec."Ship-to Address");
            end;
            SalesHeader3.SetRange(SalesHeader3."Nº expedición", '');
            SalesHeader3.SetRange(SalesHeader3."No.", Rec."No.");
            if Rec."Marcar para agrupar" then begin
                SalesHeader3.SetRange(SalesHeader3."Marcar para agrupar", true);
            end;
            if SalesHeader3.FindSet then
                repeat
                    SalesHeader33.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                    SalesHeader33."Nº expedición" := NPEDIDO;
                    SalesHeader33."Nº expedición dropshp" := EXPEDROP;
                    SalesHeader33."Package Tracking No." := EXPEDROP;
                    SalesLine3.Reset;
                    SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                    SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                    if SalesLine3.FindSet then
                        repeat
                            if SalesLine3.Type = 2 then begin
                                SalesLine3."Nº expedición" := NPEDIDO;
                                SalesLine3.Modify;
                                LogAdaiaPedidos.Init();
                                LogAdaiaPedidos.Expedicion := NPEDIDO;
                                LogAdaiaPedidos.Pedido := SalesLine3."Document No.";
                                LogAdaiaPedidos.Producto := SalesLine3."No.";
                                LogAdaiaPedidos.Linea := SalesLine3."Line No.";
                                LogAdaiaPedidos.Cantidad := SalesLine3.Quantity;
                                if LogAdaiaPedidos.Insert() then;
                            end;
                        until SalesLine3.Next = 0;
                    if npedidos > 1 then begin
                        if SalesHeader3."Tipo facturación" <> 2 then begin
                            if SalesHeader3."Multi-picking" = false then begin
                                SalesHeader33."Tipo facturación" := 1;
                            end;
                        end;
                    end;
                    SalesHeader33.Modify;
                    if SalesHeader33."Marcar para agrupar" then begin
                        Incrementos(SalesHeader33);
                    end;
                    SalesLine3.Reset;
                    SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                    SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                    if SalesLine3.FindSet then
                        repeat
                            if SalesLine3.Type = 2 then begin
                                if SalesLine3."Location Code" = '' then begin
                                    Error('Falta el almacen en la lineas %1 %2', SalesLine3."No.", SalesLine3.Description)
                                end;
                            end;
                        until SalesLine3.Next = 0;
                until SalesHeader3.Next = 0;
        end;

        // Sleep(3000);  -- ELIMINADO (espera artificial)

        // ======= ENVÍO + POPUP DE FALLO =======
        SalesHeader3.Reset;
        SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
        SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
        SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
        if SalesHeader3.FindFirst then begin
            Clear(AutomaticosAdaia);

            if not TryEnviarExpedicionAdaiaLocal(SalesHeader3) then begin
                // Marca de fallo en log
                if LogAdaiaFicheros.Get(NPEDIDO) then begin
                    LogAdaiaFicheros.Error := true;
                    LogAdaiaFicheros.Subido := false;
                    LogAdaiaFicheros.Modify();
                end;

                // Preparar salto de línea y texto de error
                CRLF[1] := 13; // CR
                CRLF[2] := 10; // LF
                ErrTxt := CopyStr(GetLastErrorText(), 1, 250);
                ClearLastError;

                // Popup al usuario
                Message(
                  'ATENCIÓN: No se ha podido exportar la expedición %1 (pedido %2).%3Error: %4',
                  NPEDIDO, SalesHeader3."No.", CRLF, ErrTxt);

                exit; // parar para no continuar pasos posteriores
            end;

            // Éxito: marcar log
            if LogAdaiaFicheros.Get(NPEDIDO) then begin
                LogAdaiaFicheros.Error := false;
                LogAdaiaFicheros.Subido := true;
                LogAdaiaFicheros.Modify();
            end;
        end;
        // ======= FIN ENVÍO =======

        // Commit;  -- ELIMINADO (deja solo uno al final)

        SalesHeader35.Reset;
        SalesHeader35.SetRange(SalesHeader35."Document Type", Rec."Document Type");
        SalesHeader35.SetRange(SalesHeader35."No.", Rec."No.");
        if SalesHeader35.FindFirst then begin
            if CopyStr(SalesHeader35."No.", 3, 3) <> 'WEB' then begin
                AutomaticosAdaia.ENVIAREMAILPARAPREPARAR(SalesHeader35);
            end;
        end;

        SalesHeader3.Reset;
        SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
        SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
        SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
        if SalesHeader3.FindSet then
            repeat
                if CopyStr(SalesHeader3."No.", 3, 3) = 'WEB' then begin
                    SalesLine5.Reset;
                    SalesLine5.SetRange(SalesLine5."Document Type", SalesHeader3."Document Type");
                    SalesLine5.SetRange(SalesLine5."Document No.", SalesHeader3."No.");
                    if SalesLine5.FindSet then
                        repeat
                            SalesLine5."Usuario alta" := 'HAGEN\OSCAR';
                            SalesLine5.Modify;
                        until SalesLine5.Next = 0;
                end;
            until SalesHeader3.Next = 0;

        Commit; // ← ÚNICO COMMIT (final)

        ///// ImprimeEtiAdaia;

        if Rec."VAT Country/Region Code" = 'PT' then begin
            //       ImprimeEtiPortugal;
        end;
    end;

    // Helper TryFunction con nombre único para evitar ambigüedad
    [TryFunction]
    local procedure TryEnviarExpedicionAdaiaLocal(var SalesHeaderRec: Record "Sales Header")
    var
        AutomaticosAdaiaLocal: Codeunit "Automaticos Cartas";
    begin
        AutomaticosAdaiaLocal.ENVIAEXPEDICIONES(SalesHeaderRec);
    end;


    // -----------------------
    //  Helpers de reintento
    // -----------------------
    local procedure EnviarExpedicionConReintentos(var SalesHeader3: Record "Sales Header"; NPEDIDO: Code[50]; MaxIntentos: Integer): Boolean
    var
        Intento: Integer;
        Ok: Boolean;
        LastErr: Text;
        LogAdaiaFicheros: Record LogFicherosAdaia;

    begin
        for Intento := 1 to MaxIntentos do begin
            // Telemetría: intento
            ///   Session.LogMessage(
            ///'ADAIA-TRY',
            ///StrSubstNo('Intento %1 de %2. NPEDIDO=%3', Intento, MaxIntentos, NPEDIDO),
            ///Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::All);

            if TryEnviarExpedicion(SalesHeader3) then begin
                // marcado de éxito
                if LogAdaiaFicheros.Get(NPEDIDO) then begin
                    LogAdaiaFicheros.Error := false;
                    LogAdaiaFicheros.Subido := true;
                    LogAdaiaFicheros.Modify();
                end;

                ///Session.LogMessage(
                /// 'ADAIA-END',
                ///StrSubstNo('Export OK en intento %1. NPEDIDO=%2', Intento, NPEDIDO),
                ///Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::All);

                exit(true);
            end else begin
                LastErr := GetLastErrorText();
                ClearLastError;

                ///Session.LogMessage(
                ///'ADAIA-RETRY',
                ///StrSubstNo('Fallo intento %1. NPEDIDO=%2. Error=%3', Intento, NPEDIDO, CopyStr(LastErr,1,250)),
                ///Verbosity::Warning, DataClassification::SystemMetadata, TelemetryScope::All);
            end;
        end;

        // Si llegó aquí, todos fallaron
        if LogAdaiaFicheros.Get(NPEDIDO) then begin
            LogAdaiaFicheros.Error := true;
            LogAdaiaFicheros.Subido := false;
            // Si tu tabla tiene un campo de mensaje, guarda LastErr (omite si no existe)
            // LogAdaiaFicheros."Mensaje error" := CopyStr(LastErr,1,250);
            LogAdaiaFicheros.Modify();
        end;

        ///Session.LogMessage(
        ///'ADAIA-FAIL',
        ///StrSubstNo('Fallo definitivo tras %1 intentos. NPEDIDO=%2. UltErr=%3', MaxIntentos, NPEDIDO, CopyStr(LastErr,1,250)),
        ///Verbosity::Error, DataClassification::SystemMetadata, TelemetryScope::All);

        exit(false);
    end;

    [TryFunction]
    local procedure TryEnviarExpedicion(var SalesHeader3: Record "Sales Header")
    begin
        AutomaticosAdaia.ENVIAEXPEDICIONES(SalesHeader3);
    end;

    /*
        local procedure EnviaraADAIA()
        var
            AutomaticosAdaia: Codeunit "Automaticos Cartas";
            SalesHeader: Record "Sales Header";
            LogAdaiaPedidos: Record LogAdaiaPedidos;
            LogAdaiaFicheros: Record LogFicherosAdaia;
        begin

            // Commit;  -- ELIMINADO (commit intermedio)

            contadordeagrup := '0';

            if Rec."Nº expedición" <> '' then begin
                /////Error('Ya se ha enviado a Adaia.');
            end;
            NoSeriesLine.Reset;
            if Rec."VAT Country/Region Code" <> 'PT' then begin
                NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAP');
                if Rec."Nº exped. pequeña" then begin
                    NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAPP');
                end;
            end;
            if Rec."VAT Country/Region Code" = 'PT' then begin
                NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAPT');
            end;
            if NoSeriesLine.FindFirst then begin
                NPEDIDO := NoSeriesLine."Last No. Used";
                NoSeriesLine."Last No. Used" := IncStr(NPEDIDO);
                NoSeriesLine.Modify;
            end;

            LogAdaiaFicheros.Init();
            LogAdaiaFicheros.Expedicion := NPEDIDO;
            LogAdaiaFicheros.Error := true;
            if LogAdaiaFicheros.Insert() then;

            SalesReceivablesSetup.Get;
            ItemJournalLine.Reset;
            ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", 'PRODUCTO');
            ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", 'ABC');
            ItemJournalLine.SetRange(ItemJournalLine."Line No.", SalesReceivablesSetup."Ultima letra" + 1);
            if ItemJournalLine.FindFirst then begin
                LETRA := ItemJournalLine."Document No.";
                if SalesReceivablesSetup."Ultima letra" + 1 = 26 then begin
                    SalesReceivablesSetup."Ultima letra" := 1;
                    SalesReceivablesSetup.Modify;
                end;
                if SalesReceivablesSetup."Ultima letra" + 1 <> 26 then begin
                    SalesReceivablesSetup."Ultima letra" := SalesReceivablesSetup."Ultima letra" + 1;
                    SalesReceivablesSetup.Modify;
                end;
            end;

            NPEDIDO := NPEDIDO + LETRA;

            if CopyStr(Rec."No.", 3, 4) = 'CATW' then begin
                NPEDIDO := Rec."Your Reference";
            end;

            if Rec."No agrupar en ADAIA" = false then begin
                CODTRANS := '';
                npedidos := 0;
                npedi := '';
                SalesHeader4.Reset;
                SalesHeader4.SetCurrentkey("Document Type", "Sell-to Customer No.", "Estado pedido");
                SalesHeader4.SetRange(SalesHeader4."Document Type", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader4.SetRange(SalesHeader4."Sell-to Customer No.", Rec."Sell-to Customer No.");
                end;
                SalesHeader4.SetRange(SalesHeader4."Estado pedido", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader4.SetRange(SalesHeader4."Ship-to Address", Rec."Ship-to Address");
                end;
                SalesHeader4.SetRange(SalesHeader4."Nº expedición", '');
                SalesHeader4.SetRange(SalesHeader4."No agrupar en ADAIA", false);
                if Rec."Marcar para agrupar" then begin
                    SalesHeader4.SetRange(SalesHeader4."Marcar para agrupar", true);
                end;
                SalesHeader4.SetRange("Shipping Agent Code", Rec."Shipping Agent Code");
                if SalesHeader4.FindSet then
                    repeat
                        CODTRANS := SalesHeader4."Shipping Agent Code";
                        npedi := SalesHeader4."No.";
                        if CODTRANS <> SalesHeader4."Shipping Agent Code" then begin
                            Error('Tienen distinto transportista. %1 %2 %3', SalesHeader4."No.", CODTRANS, npedi);
                        end;
                        if not SalesHeader4."Respeta Tipo facturacion" then begin
                            npedidos := npedidos + 1;
                        end;
                    until SalesHeader4.Next = 0;

                SalesHeader3.Reset;
                SalesHeader3.SetCurrentkey("Document Type", "Sell-to Customer No.", "Estado pedido");
                SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader3.SetRange(SalesHeader3."Sell-to Customer No.", Rec."Sell-to Customer No.");
                end;
                SalesHeader3.SetRange(SalesHeader3."Estado pedido", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader3.SetRange(SalesHeader3."Ship-to Address", Rec."Ship-to Address");
                end;
                SalesHeader3.SetRange(SalesHeader3."Nº expedición", '');
                SalesHeader3.SetRange(SalesHeader3."No agrupar en ADAIA", false);
                if Rec."Marcar para agrupar" then begin
                    SalesHeader3.SetRange(SalesHeader3."Marcar para agrupar", true);
                end;
                if SalesHeader3.FindSet then
                    repeat
                        SalesHeader33.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                        SalesHeader33."Nº expedición" := NPEDIDO;
                        SalesHeader33."Package Tracking No." := NPEDIDO;
                        SalesLine3.Reset;
                        SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                        SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                        if SalesLine3.FindSet then
                            repeat
                                if SalesLine3.Type = 2 then begin
                                    SalesLine3."Nº expedición" := NPEDIDO;
                                    SalesLine3.Modify;

                                    LogAdaiaPedidos.Init();
                                    LogAdaiaPedidos.Expedicion := NPEDIDO;
                                    LogAdaiaPedidos.Pedido := SalesLine3."Document No.";
                                    LogAdaiaPedidos.Producto := SalesLine3."No.";
                                    LogAdaiaPedidos.Linea := SalesLine3."Line No.";
                                    LogAdaiaPedidos.Cantidad := SalesLine3.Quantity;
                                    if LogAdaiaPedidos.Insert() then;
                                end;

                            until SalesLine3.Next = 0;

                        if npedidos > 1 then begin
                            if SalesHeader3."Tipo facturación" <> 2 then begin
                                if SalesHeader3."Multi-picking" = false then begin
                                    SalesHeader33."Tipo facturación" := 1;
                                end;
                            end;
                        end;
                        SalesHeader33.Modify;
                        if SalesHeader33."Marcar para agrupar" then begin
                            Incrementos(SalesHeader33);
                        end;
                        SalesLine3.Reset;
                        SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                        SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                        if SalesLine3.FindSet then
                            repeat
                                if SalesLine3.Type = 2 then begin
                                    if SalesLine3."Location Code" = '' then begin
                                        Error('Falta el almacen en la lineas %1 %2', SalesLine3."No.", SalesLine3.Description)
                                    end;
                                end;
                            until SalesLine3.Next = 0;
                        if SalesHeader3."Marcar para agrupar" = true then begin
                            if SalesHeader3."Shipping Agent Code" <> 'ECI' then begin
                                SalesHeader22.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                                contadordeagrup := IncStr(contadordeagrup);
                                SalesHeader22."Nº expedición agrupada" := contadordeagrup;
                                EXPEDROP := '';
                                if (Rec.Dropshipping = true) and (Rec."Marcar para agrupar" = true) then begin
                                    EXPEDROP := NoSeriesManagement.GetNextNo('ADAIADROP', Today, true);
                                end;
                                SalesHeader3.CalcFields("Grupo clientes");
                                if (SalesHeader3."Grupo clientes" = 'G52') and (SalesHeader3."Customer Disc. Group" = 'DCCA') then begin
                                    EXPEDROP := CopyStr(SalesHeader3."Your Reference", 1, 10);
                                    ////SalesHeader22.Validate("Bill-to Customer No.", '11010');
                                end;
                                SalesHeader22."Nº expedición dropshp" := EXPEDROP;
                                SalesHeader22."Package Tracking No." := EXPEDROP;
                                SalesHeader22.Modify;
                                if SalesHeader22."Marcar para agrupar" then begin
                                    Incrementos(SalesHeader22);
                                end;
                            end;
                        end;
                    until SalesHeader3.Next = 0;
            end;

            if Rec."No agrupar en ADAIA" = true then begin
                CODTRANS := '';
                npedidos := 0;
                SalesHeader4.Reset;
                SalesHeader4.SetCurrentkey("Document Type", "Sell-to Customer No.", "Estado pedido");
                SalesHeader4.SetRange(SalesHeader4."Document Type", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader4.SetRange(SalesHeader4."Sell-to Customer No.", Rec."Sell-to Customer No.");
                end;
                SalesHeader4.SetRange(SalesHeader4."Estado pedido", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader4.SetRange(SalesHeader4."Ship-to Address", Rec."Ship-to Address");
                end;
                SalesHeader4.SetRange(SalesHeader4."Nº expedición", '');
                SalesHeader4.SetRange(SalesHeader4."No.", Rec."No.");
                if Rec."Marcar para agrupar" then begin
                    SalesHeader4.SetRange(SalesHeader4."Marcar para agrupar", true);
                end;
                if SalesHeader4.FindSet then
                    repeat
                        if not SalesHeader4."Respeta Tipo facturacion" then begin
                            npedidos := npedidos + 1;
                        end;
                    until SalesHeader4.Next = 0;

                SalesHeader3.Reset;
                SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
                SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader3.SetRange(SalesHeader3."Sell-to Customer No.", Rec."Sell-to Customer No.");
                end;
                SalesHeader3.SetRange(SalesHeader3."Estado pedido", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader3.SetRange(SalesHeader3."Ship-to Address", Rec."Ship-to Address");
                end;
                SalesHeader3.SetRange(SalesHeader3."Nº expedición", '');
                SalesHeader3.SetRange(SalesHeader3."No.", Rec."No.");
                if Rec."Marcar para agrupar" then begin
                    SalesHeader3.SetRange(SalesHeader3."Marcar para agrupar", true);
                end;
                if SalesHeader3.FindSet then
                    repeat
                        SalesHeader33.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                        SalesHeader33."Nº expedición" := NPEDIDO;
                        SalesHeader33."Nº expedición dropshp" := EXPEDROP;
                        SalesHeader33."Package Tracking No." := EXPEDROP;
                        SalesLine3.Reset;
                        SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                        SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                        if SalesLine3.FindSet then
                            repeat
                                if SalesLine3.Type = 2 then begin
                                    SalesLine3."Nº expedición" := NPEDIDO;
                                    SalesLine3.Modify;
                                    LogAdaiaPedidos.Init();
                                    LogAdaiaPedidos.Expedicion := NPEDIDO;
                                    LogAdaiaPedidos.Pedido := SalesLine3."Document No.";
                                    LogAdaiaPedidos.Producto := SalesLine3."No.";
                                    LogAdaiaPedidos.Linea := SalesLine3."Line No.";
                                    LogAdaiaPedidos.Cantidad := SalesLine3.Quantity;
                                    if LogAdaiaPedidos.Insert() then;
                                end;
                            until SalesLine3.Next = 0;
                        if npedidos > 1 then begin
                            if SalesHeader3."Tipo facturación" <> 2 then begin
                                if SalesHeader3."Multi-picking" = false then begin
                                    SalesHeader33."Tipo facturación" := 1;
                                end;
                            end;
                        end;
                        SalesHeader33.Modify;
                        if SalesHeader33."Marcar para agrupar" then begin
                            Incrementos(SalesHeader33);
                        end;
                        SalesLine3.Reset;
                        SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                        SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                        if SalesLine3.FindSet then
                            repeat
                                if SalesLine3.Type = 2 then begin
                                    if SalesLine3."Location Code" = '' then begin
                                        Error('Falta el almacen en la lineas %1 %2', SalesLine3."No.", SalesLine3.Description)
                                    end;
                                end;
                            until SalesLine3.Next = 0;
                    until SalesHeader3.Next = 0;
            end;

            // Sleep(3000);  -- ELIMINADO (espera artificial)

            SalesHeader3.Reset;
            SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
            SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
            SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
            if SalesHeader3.FindFirst then begin
                Clear(AutomaticosAdaia);
                AutomaticosAdaia.ENVIAEXPEDICIONES(SalesHeader3);

                if LogAdaiaFicheros.get(NPEDIDO) then begin
                    LogAdaiaFicheros.Error := false;
                    LogAdaiaFicheros.Subido := true;
                    LogAdaiaFicheros.Modify();
                end;
            end;

            // Commit;  -- ELIMINADO (deja solo uno al final)

            SalesHeader35.Reset;
            SalesHeader35.SetRange(SalesHeader35."Document Type", Rec."Document Type");
            SalesHeader35.SetRange(SalesHeader35."No.", Rec."No.");
            if SalesHeader35.FindFirst then begin
                if CopyStr(SalesHeader35."No.", 3, 3) <> 'WEB' then begin
                    AutomaticosAdaia.ENVIAREMAILPARAPREPARAR(SalesHeader35);
                end;
            end;

            SalesHeader3.Reset;
            SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
            SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
            SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
            if SalesHeader3.FindSet then
                repeat
                    if CopyStr(SalesHeader3."No.", 3, 3) = 'WEB' then begin
                        SalesLine5.Reset;
                        SalesLine5.SetRange(SalesLine5."Document Type", SalesHeader3."Document Type");
                        SalesLine5.SetRange(SalesLine5."Document No.", SalesHeader3."No.");
                        if SalesLine5.FindSet then
                            repeat
                                SalesLine5."Usuario alta" := 'HAGEN\OSCAR';
                                SalesLine5.Modify;
                            until SalesLine5.Next = 0;
                    end;
                until SalesHeader3.Next = 0;

            Commit; // ← ÚNICO COMMIT (final)

            ///// ImprimeEtiAdaia;

            if Rec."VAT Country/Region Code" = 'PT' then begin
                //       ImprimeEtiPortugal;
            end;
        end;
    */
    /*
        local procedure EnviaraADAIA()
        var
            AutomaticosAdaia: Codeunit "Automaticos Cartas";
            SalesHeader: Record "Sales Header";
            LogAdaiaPedidos: Record LogAdaiaPedidos;
            LogAdaiaFicheros: Record LogFicherosAdaia;
        begin

            Commit;

            contadordeagrup := '0';



            if Rec."Nº expedición" <> '' then begin
                /////Error('Ya se ha enviado a Adaia.');
            end;
            NoSeriesLine.Reset;
            if Rec."VAT Country/Region Code" <> 'PT' then begin
                NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAP');
                if Rec."Nº exped. pequeña" then begin
                    NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAPP');
                end;
            end;
            if Rec."VAT Country/Region Code" = 'PT' then begin
                NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAPT');
            end;
            if NoSeriesLine.FindFirst then begin
                NPEDIDO := NoSeriesLine."Last No. Used";
                NoSeriesLine."Last No. Used" := IncStr(NPEDIDO);
                NoSeriesLine.Modify;
            end;

            LogAdaiaFicheros.Init();
            LogAdaiaFicheros.Expedicion := NPEDIDO;
            LogAdaiaFicheros.Error := true;
            if LogAdaiaFicheros.Insert() then;



            SalesReceivablesSetup.Get;
            ItemJournalLine.Reset;
            ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", 'PRODUCTO');
            ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", 'ABC');
            ItemJournalLine.SetRange(ItemJournalLine."Line No.", SalesReceivablesSetup."Ultima letra" + 1);
            if ItemJournalLine.FindFirst then begin
                LETRA := ItemJournalLine."Document No.";
                if SalesReceivablesSetup."Ultima letra" + 1 = 26 then begin
                    SalesReceivablesSetup."Ultima letra" := 1;
                    SalesReceivablesSetup.Modify;
                end;
                if SalesReceivablesSetup."Ultima letra" + 1 <> 26 then begin
                    SalesReceivablesSetup."Ultima letra" := SalesReceivablesSetup."Ultima letra" + 1;
                    SalesReceivablesSetup.Modify;
                end;
            end;

            NPEDIDO := NPEDIDO + LETRA;


            if CopyStr(Rec."No.", 3, 4) = 'CATW' then begin
                NPEDIDO := Rec."Your Reference";
            end;



            if Rec."No agrupar en ADAIA" = false then begin
                CODTRANS := '';
                npedidos := 0;
                npedi := '';
                SalesHeader4.Reset;
                SalesHeader4.SetCurrentkey("Document Type", "Sell-to Customer No.", "Estado pedido");
                SalesHeader4.SetRange(SalesHeader4."Document Type", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader4.SetRange(SalesHeader4."Sell-to Customer No.", Rec."Sell-to Customer No.");
                end;
                SalesHeader4.SetRange(SalesHeader4."Estado pedido", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader4.SetRange(SalesHeader4."Ship-to Address", Rec."Ship-to Address");
                end;
                SalesHeader4.SetRange(SalesHeader4."Nº expedición", '');
                SalesHeader4.SetRange(SalesHeader4."No agrupar en ADAIA", false);
                if Rec."Marcar para agrupar" then begin
                    SalesHeader4.SetRange(SalesHeader4."Marcar para agrupar", true);
                end;
                SalesHeader4.SetRange("Shipping Agent Code", Rec."Shipping Agent Code");
                if SalesHeader4.FindSet then
                    repeat
                        ///IF CODTRANS='' THEN BEGIN
                        CODTRANS := SalesHeader4."Shipping Agent Code";
                        npedi := SalesHeader4."No.";
                        ///END;
                        if CODTRANS <> SalesHeader4."Shipping Agent Code" then begin
                            Error('Tienen distinto transportista. %1 %2 %3', SalesHeader4."No.", CODTRANS, npedi);
                        end;
                        if not SalesHeader4."Respeta Tipo facturacion" then begin
                            npedidos := npedidos + 1;
                        end;
                    until SalesHeader4.Next = 0;




                SalesHeader3.Reset;
                SalesHeader3.SetCurrentkey("Document Type", "Sell-to Customer No.", "Estado pedido");
                SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader3.SetRange(SalesHeader3."Sell-to Customer No.", Rec."Sell-to Customer No.");
                end;
                SalesHeader3.SetRange(SalesHeader3."Estado pedido", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader3.SetRange(SalesHeader3."Ship-to Address", Rec."Ship-to Address");
                end;
                SalesHeader3.SetRange(SalesHeader3."Nº expedición", '');
                SalesHeader3.SetRange(SalesHeader3."No agrupar en ADAIA", false);
                if Rec."Marcar para agrupar" then begin
                    SalesHeader3.SetRange(SalesHeader3."Marcar para agrupar", true);
                end;
                if SalesHeader3.FindSet then
                    repeat
                        SalesHeader33.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                        SalesHeader33."Nº expedición" := NPEDIDO;
                        SalesHeader33."Package Tracking No." := NPEDIDO;
                        SalesLine3.Reset;
                        SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                        SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                        if SalesLine3.FindSet then
                            repeat
                                if SalesLine3.Type = 2 then begin
                                    SalesLine3."Nº expedición" := NPEDIDO;
                                    SalesLine3.Modify;

                                    LogAdaiaPedidos.Init();
                                    LogAdaiaPedidos.Expedicion := NPEDIDO;
                                    LogAdaiaPedidos.Pedido := SalesLine3."Document No.";
                                    LogAdaiaPedidos.Producto := SalesLine3."No.";
                                    LogAdaiaPedidos.Linea := SalesLine3."Line No.";
                                    LogAdaiaPedidos.Cantidad := SalesLine3.Quantity;
                                    if LogAdaiaPedidos.Insert() then;
                                end;

                            until SalesLine3.Next = 0;

                        if npedidos > 1 then begin
                            if SalesHeader3."Tipo facturación" <> 2 then begin
                                if SalesHeader3."Multi-picking" = false then begin
                                    SalesHeader33."Tipo facturación" := 1;
                                end;
                            end;
                        end;
                        SalesHeader33.Modify;
                        if SalesHeader33."Marcar para agrupar" then begin
                            Incrementos(SalesHeader33);
                        end;
                        SalesLine3.Reset;
                        SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                        SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                        if SalesLine3.FindSet then
                            repeat
                                if SalesLine3.Type = 2 then begin
                                    if SalesLine3."Location Code" = '' then begin
                                        Error('Falta el almacen en la lineas %1 %2', SalesLine3."No.", SalesLine3.Description)
                                    end;
                                end;
                            until SalesLine3.Next = 0;
                        if SalesHeader3."Marcar para agrupar" = true then begin
                            if SalesHeader3."Shipping Agent Code" <> 'ECI' then begin
                                SalesHeader22.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                                contadordeagrup := IncStr(contadordeagrup);
                                SalesHeader22."Nº expedición agrupada" := contadordeagrup;
                                EXPEDROP := '';
                                if (Rec.Dropshipping = true) and (Rec."Marcar para agrupar" = true) then begin
                                    EXPEDROP := NoSeriesManagement.GetNextNo('ADAIADROP', Today, true);
                                end;
                                SalesHeader3.CalcFields("Grupo clientes");
                                if (SalesHeader3."Grupo clientes" = 'G52') and (SalesHeader3."Customer Disc. Group" = 'DCCA') then begin
                                    EXPEDROP := CopyStr(SalesHeader3."Your Reference", 1, 10);
                                    ////SalesHeader22.Validate("Bill-to Customer No.", '11010');
                                end;
                                SalesHeader22."Nº expedición dropshp" := EXPEDROP;
                                SalesHeader22."Package Tracking No." := EXPEDROP;
                                SalesHeader22.Modify;
                                if SalesHeader22."Marcar para agrupar" then begin
                                    Incrementos(SalesHeader22);
                                end;
                            end;
                        end;
                    until SalesHeader3.Next = 0;
            end;


            if Rec."No agrupar en ADAIA" = true then begin

                CODTRANS := '';
                npedidos := 0;
                SalesHeader4.Reset;
                SalesHeader4.SetCurrentkey("Document Type", "Sell-to Customer No.", "Estado pedido");
                SalesHeader4.SetRange(SalesHeader4."Document Type", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader4.SetRange(SalesHeader4."Sell-to Customer No.", Rec."Sell-to Customer No.");
                end;
                SalesHeader4.SetRange(SalesHeader4."Estado pedido", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader4.SetRange(SalesHeader4."Ship-to Address", Rec."Ship-to Address");
                end;
                SalesHeader4.SetRange(SalesHeader4."Nº expedición", '');
                SalesHeader4.SetRange(SalesHeader4."No.", Rec."No.");
                if Rec."Marcar para agrupar" then begin
                    SalesHeader4.SetRange(SalesHeader4."Marcar para agrupar", true);
                end;
                if SalesHeader4.FindSet then
                    repeat
                        if not SalesHeader4."Respeta Tipo facturacion" then begin
                            npedidos := npedidos + 1;
                        end;
                    until SalesHeader4.Next = 0;

                SalesHeader3.Reset;
                SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
                SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader3.SetRange(SalesHeader3."Sell-to Customer No.", Rec."Sell-to Customer No.");
                end;
                SalesHeader3.SetRange(SalesHeader3."Estado pedido", 1);
                if Rec."Marcar para agrupar" = false then begin
                    SalesHeader3.SetRange(SalesHeader3."Ship-to Address", Rec."Ship-to Address");
                end;
                SalesHeader3.SetRange(SalesHeader3."Nº expedición", '');
                SalesHeader3.SetRange(SalesHeader3."No.", Rec."No.");
                if Rec."Marcar para agrupar" then begin
                    SalesHeader3.SetRange(SalesHeader3."Marcar para agrupar", true);
                end;
                if SalesHeader3.FindSet then
                    repeat
                        SalesHeader33.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                        SalesHeader33."Nº expedición" := NPEDIDO;
                        SalesHeader33."Nº expedición dropshp" := EXPEDROP;
                        SalesHeader33."Package Tracking No." := EXPEDROP;
                        SalesLine3.Reset;
                        SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                        SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                        if SalesLine3.FindSet then
                            repeat
                                if SalesLine3.Type = 2 then begin
                                    SalesLine3."Nº expedición" := NPEDIDO;
                                    SalesLine3.Modify;
                                    LogAdaiaPedidos.Init();
                                    LogAdaiaPedidos.Expedicion := NPEDIDO;
                                    LogAdaiaPedidos.Pedido := SalesLine3."Document No.";
                                    LogAdaiaPedidos.Producto := SalesLine3."No.";
                                    LogAdaiaPedidos.Linea := SalesLine3."Line No.";
                                    LogAdaiaPedidos.Cantidad := SalesLine3.Quantity;
                                    if LogAdaiaPedidos.Insert() then;
                                end;
                            until SalesLine3.Next = 0;
                        if npedidos > 1 then begin
                            if SalesHeader3."Tipo facturación" <> 2 then begin
                                if SalesHeader3."Multi-picking" = false then begin
                                    SalesHeader33."Tipo facturación" := 1;
                                end;
                            end;
                        end;
                        SalesHeader33.Modify;
                        if SalesHeader33."Marcar para agrupar" then begin
                            Incrementos(SalesHeader33);
                        end;
                        SalesLine3.Reset;
                        SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                        SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                        if SalesLine3.FindSet then
                            repeat
                                if SalesLine3.Type = 2 then begin
                                    if SalesLine3."Location Code" = '' then begin
                                        Error('Falta el almacen en la lineas %1 %2', SalesLine3."No.", SalesLine3.Description)
                                    end;
                                end;
                            until SalesLine3.Next = 0;
                    until SalesHeader3.Next = 0;
            end;





            Sleep(3000);
            SalesHeader3.Reset;
            SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
            SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
            SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
            if SalesHeader3.FindFirst then begin
                Clear(AutomaticosAdaia);
                AutomaticosAdaia.ENVIAEXPEDICIONES(SalesHeader3);


                if LogAdaiaFicheros.get(NPEDIDO) then begin
                    LogAdaiaFicheros.Error := false;
                    LogAdaiaFicheros.Subido := true;
                    LogAdaiaFicheros.Modify();
                end;

            end;

            Commit;

            SalesHeader35.Reset;
            SalesHeader35.SetRange(SalesHeader35."Document Type", Rec."Document Type");
            SalesHeader35.SetRange(SalesHeader35."No.", Rec."No.");
            if SalesHeader35.FindFirst then begin
                if CopyStr(SalesHeader35."No.", 3, 3) <> 'WEB' then begin
                    AutomaticosAdaia.ENVIAREMAILPARAPREPARAR(SalesHeader35);
                end;
            end;

            SalesHeader3.Reset;
            SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
            SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
            SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
            if SalesHeader3.FindSet then
                repeat
                    if CopyStr(SalesHeader3."No.", 3, 3) = 'WEB' then begin
                        SalesLine5.Reset;
                        SalesLine5.SetRange(SalesLine5."Document Type", SalesHeader3."Document Type");
                        SalesLine5.SetRange(SalesLine5."Document No.", SalesHeader3."No.");
                        if SalesLine5.FindSet then
                            repeat
                                SalesLine5."Usuario alta" := 'HAGEN\OSCAR';
                                SalesLine5.Modify;
                            until SalesLine5.Next = 0;
                    end;

                until SalesHeader3.Next = 0;


            Commit;

            ///// ImprimeEtiAdaia;


            if Rec."VAT Country/Region Code" = 'PT' then begin
                //       ImprimeEtiPortugal;
            end;
        end;

    */
    local procedure ReenviaFicheroaADAIA()
    var
        AutomaticosAdaia: Codeunit "Automaticos Cartas";
        SalesHeader: Record "Sales Header";
        LogAdaiaPedidos: Record LogAdaiaPedidos;
        LogAdaiaFicheros: Record LogFicherosAdaia;
    begin

        Commit;

        contadordeagrup := '0';

        LogAdaiaFicheros.Init();
        LogAdaiaFicheros.Expedicion := NPEDIDO;
        LogAdaiaFicheros.Error := true;
        if LogAdaiaFicheros.Insert() then;



        SalesReceivablesSetup.Get;

        NPEDIDO := Rec."Nº expedición";


        if CopyStr(Rec."No.", 3, 4) = 'CATW' then begin
            NPEDIDO := Rec."Your Reference";
        end;






        Sleep(3000);
        SalesHeader3.Reset;
        SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
        SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
        SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
        if SalesHeader3.FindFirst then begin
            Clear(AutomaticosAdaia);
            AutomaticosAdaia.ENVIAEXPEDICIONES2(SalesHeader3);
            SalesHeader3.FechaReenvioAdaia := CreateDateTime(today, time);
            SalesHeader3.Modify();

            if LogAdaiaFicheros.get(NPEDIDO) then begin
                LogAdaiaFicheros.Error := false;
                LogAdaiaFicheros.Subido := true;
                LogAdaiaFicheros.Modify();
            end;

        end;

        Commit;

        SalesHeader35.Reset;
        SalesHeader35.SetRange(SalesHeader35."Document Type", Rec."Document Type");
        SalesHeader35.SetRange(SalesHeader35."No.", Rec."No.");
        if SalesHeader35.FindFirst then begin
            if CopyStr(SalesHeader35."No.", 3, 3) <> 'WEB' then begin
                AutomaticosAdaia.ENVIAREMAILPARAPREPARAR(SalesHeader35);
            end;
        end;



        Commit;

        ///// ImprimeEtiAdaia;


        if Rec."VAT Country/Region Code" = 'PT' then begin
            //       ImprimeEtiPortugal;
        end;
    end;





    local procedure CrearEXEDICION()
    var
        AutomaticosAdaia: Codeunit "Automaticos Cartas";
        SalesHeader: Record "Sales Header";
        LogAdaiaPedidos: Record LogAdaiaPedidos;
        LogAdaiaFicheros: Record LogFicherosAdaia;
        RecCV: Record "Sales Header";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        CodeCV: Codeunit "Automaticos Cartas";
        enviar: Boolean;
        EXPEDI: CODE[20];
        REC110: Record "Sales Shipment Header";
        REC1102: Record "Sales Shipment Header";
        Rec112: Record "Sales Invoice Header";
        CUEXP: Codeunit "Automaticos Cartas";
        RecTra: Record "Shipping Agent";
        Rec113: Record "Sales Invoice Line";
        NALBARAN: CODE[20];
        Cajasporenvio: Record "Cajas por envio";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentHeader2: Record "Sales Shipment Header";
        LLINEA: Integer;
        RecLVSuma: Record "Sales Line";

    begin

        Commit;

        contadordeagrup := '0';

        NoSeriesLine.Reset;
        if Rec."VAT Country/Region Code" <> 'PT' then begin
            NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAP');
            if Rec."Nº exped. pequeña" then begin
                NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAPP');
            end;
        end;
        if Rec."VAT Country/Region Code" = 'PT' then begin
            NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAPT');
        end;
        if NoSeriesLine.FindFirst then begin
            NPEDIDO := NoSeriesLine."Last No. Used";
            NoSeriesLine."Last No. Used" := IncStr(NPEDIDO);
            NoSeriesLine.Modify;
        end;



        SalesReceivablesSetup.Get;
        ItemJournalLine.Reset;
        ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", 'PRODUCTO');
        ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", 'ABC');
        ItemJournalLine.SetRange(ItemJournalLine."Line No.", SalesReceivablesSetup."Ultima letra" + 1);
        if ItemJournalLine.FindFirst then begin
            LETRA := ItemJournalLine."Document No.";
            if SalesReceivablesSetup."Ultima letra" + 1 = 26 then begin
                SalesReceivablesSetup."Ultima letra" := 1;
                SalesReceivablesSetup.Modify;
            end;
            if SalesReceivablesSetup."Ultima letra" + 1 <> 26 then begin
                SalesReceivablesSetup."Ultima letra" := SalesReceivablesSetup."Ultima letra" + 1;
                SalesReceivablesSetup.Modify;
            end;
        end;

        NPEDIDO := NPEDIDO + LETRA;


        if CopyStr(Rec."No.", 3, 4) = 'CATW' then begin
            NPEDIDO := Rec."Your Reference";
        end;





        CODTRANS := '';
        npedidos := 1;

        SalesHeader3.Reset;
        SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
        SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
        SalesHeader3.SetRange(SalesHeader3."Estado pedido", 1);
        SalesHeader3.SetRange(SalesHeader3."Nº expedición", '');
        SalesHeader3.SetRange(SalesHeader3."No.", Rec."No.");
        if SalesHeader3.FindSet then
            repeat
                SalesHeader33.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                SalesHeader33."Nº expedición" := NPEDIDO;
                SalesHeader33."Nº expedición dropshp" := EXPEDROP;
                SalesHeader33."Package Tracking No." := EXPEDROP;
                SalesLine3.Reset;
                SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                if SalesLine3.FindSet then
                    repeat
                        if SalesLine3.Type = 2 then begin
                            SalesLine3."Nº expedición" := NPEDIDO;
                            SalesLine3.Modify;
                        end;
                    until SalesLine3.Next = 0;
                SalesHeader33.Modify;
            until SalesHeader3.Next = 0;


        /*        SalesHeader35.Reset;
                SalesHeader35.SetRange(SalesHeader35."Document Type", Rec."Document Type");
                SalesHeader35.SetRange(SalesHeader35."No.", Rec."No.");
                if SalesHeader35.FindFirst then begin
                    if CopyStr(SalesHeader35."No.", 3, 3) <> 'WEB' then begin
                        AutomaticosAdaia.ENVIAREMAILPARAPREPARAR(SalesHeader35);
                    end;
                end;*/

        SalesHeader3.Reset;
        SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
        SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
        SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
        if SalesHeader3.FindSet then
            repeat
                if CopyStr(SalesHeader3."No.", 3, 3) = 'WEB' then begin
                    SalesLine5.Reset;
                    SalesLine5.SetRange(SalesLine5."Document Type", SalesHeader3."Document Type");
                    SalesLine5.SetRange(SalesLine5."Document No.", SalesHeader3."No.");
                    if SalesLine5.FindSet then
                        repeat
                            SalesLine5."Usuario alta" := 'HAGEN\OSCAR';
                            SalesLine5.Modify;
                        until SalesLine5.Next = 0;
                end;

            until SalesHeader3.Next = 0;


        Commit;

        /// REGISTRAR
        RecCV.RESET;
        RecCV.SETCURRENTKEY(RecCV."Document Type", RecCV."Nº expedición");
        RecCV.SETRANGE(RecCV."Document Type", 1);
        RecCV.SETRANGE(RecCV."Nº expedición", NPEDIDO);
        IF RecCV.FINDFIRST THEN
            REPEAT
                CLEAR(ReleaseSalesDoc);
                CLEAR(CodeCV);
                ReleaseSalesDoc.RUN(RecCV);
                CodeCV.REGISTRASOLOEXPE(RecCV);
            UNTIL RecCV.NEXT = 0;
        ///          
        enviar := TRUE;
        EXPEDI := NPEDIDO;
        REC110.SETCURRENTKEY(REC110."Nº expedición");
        REC110.SETFILTER(REC110."Nº expedición", NPEDIDO + '*');
        IF REC110.FINDSET THEN
            REPEAT
                IF REC110.Dropshipping = FALSE THEN BEGIN
                    IF REC110."Albaran sin detalle" = TRUE THEN BEGIN
                        IF REC110."No. Printed" = 0 THEN BEGIN
                            enviar := FALSE;
                        END;
                    END;
                END;
            UNTIL REC110.NEXT = 0;




        IF enviar THEN BEGIN
            EXPEDI := NPEDIDO;
            REC110.RESET;
            REC110.SETCURRENTKEY(REC110."Nº expedición");
            REC110.SETFILTER(REC110."Nº expedición", NPEDIDO + '*');
            IF REC110.FINDFIRST THEN
                REPEAT
                    NALBARAN := REC110."No.";
                    Rec1102.RESET;
                    Rec1102.SETRANGE(Rec1102."No.", REC110."No.");
                    IF Rec1102.FINDFIRST THEN
                        REPEAT
                            IF Rec1102."Nº Palets" = 0 THEN BEGIN
                                IF RecTra.GET(Rec1102."Shipping Agent Code") THEN BEGIN
                                    IF RecTra."Fichero estandar" = TRUE THEN BEGIN
                                        CUEXP.ETISTD(Rec1102);
                                    END;
                                    IF RecTra."Fichero estandar" = FALSE THEN BEGIN
                                        ///IF Rec1102."Shipping Agent Code"='DHL' THEN BEGIN
                                        ///CUEXP.EtiDHL2NUEVA(Rec1102);
                                        //END;
                                        IF Rec1102."Shipping Agent Code" = 'TIPSA' THEN BEGIN
                                            CUEXP.Etitipsa2NUEVA(Rec1102);
                                        END;
                                        IF Rec1102."Shipping Agent Code" = 'CORR' THEN BEGIN
                                            CUEXP.EtiCORRa2NUEVA(Rec1102);
                                        END;
                                        IF Rec1102."Shipping Agent Code" = 'CRON' THEN BEGIN
                                            CUEXP.EtiCRON2NUEVA(Rec1102);
                                        END;
                                        IF Rec1102."Shipping Agent Code" = 'SEUR' THEN BEGIN
                                            CUEXP.EtiSEURNUEVA(Rec1102);
                                        END;
                                        IF Rec1102."Shipping Agent Code" = 'TNT' THEN BEGIN
                                            ///CUEXP.EtiTNT2NUEVA(Rec1102);
                                            CUEXP.EtiTNT2(Rec1102);
                                        END;
                                    END;
                                    IF Rec1102."Shipping Agent Code" = 'ECI' THEN BEGIN
                                        ///     CUEXP.ETIECI(Rec1102);
                                    END;
                                END;
                            END;
                            IF Rec1102."Bill-to Customer No." = '6445' THEN BEGIN
                                ///REPORT.RUNMODAL(50035,FALSE,FALSE,Rec1102);
                                ///REPORT.RUNMODAL(50039,FALSE,FALSE,Rec1102);
                            END;
                        UNTIL Rec1102.NEXT = 0;
                    IF Rec1102."Bill-to Customer No." = '10925' THEN BEGIN
                        /////-                         ficehrocovaldroper;
                    END;
                    IF Customer.GET(REC110."Sell-to Customer No.") THEN BEGIN
                        IF Customer."Enviar etiqueta grande" THEN BEGIN
                            REPORT.RUNMODAL(50039, FALSE, FALSE, REC110);
                        END;
                    END;
                UNTIL REC110.NEXT = 0;






            ///// etiqueta edi

            Rec112.RESET;
            Rec112.SETCURRENTKEY(Rec112."Nº expedición");
            Rec112.SETFILTER(Rec112."Nº expedición", NPEDIDO + '*');
            IF Rec112.FINDFIRST THEN BEGIN
                IF Rec112."Nº bultos" = 1 THEN BEGIN
                    Rec113.RESET;
                    Rec113.SETRANGE("Document No.", Rec112."No.");
                    Rec113.SETRANGE(Type, Rec113.Type::Item);
                    IF Rec113.FINDFIRST THEN
                        REPEAT

                            Cajasporenvio.Nfac := Rec113."Document No.";
                            Cajasporenvio.nlin := Rec113."Line No.";
                            Cajasporenvio.Producto := Rec113."No.";
                            Cajasporenvio."Caja num" := 1;
                            Cajasporenvio.Cantidad := Rec113.Quantity;
                            Cajasporenvio."nº expedicion" := NPEDIDO;
                            IF Cajasporenvio.INSERT THEN;
                            Rec113."Cantidad caja" := 1;
                            Rec113.MODIFY;
                        UNTIL Rec113.NEXT = 0;
                    Cajasporenvio.RESET;
                    Cajasporenvio.SETRANGE(Nfac, Rec112."No.");
                    IF Cajasporenvio.FINDFIRST THEN
                        REPEAT
                            Cajasporenvio.CreaSSCC;
                            Cajasporenvio.MODIFY;
                        UNTIL Cajasporenvio.NEXT = 0;
                    SalesShipmentHeader.RESET;
                    SalesShipmentHeader.SETRANGE("Nº expedición", Rec112."Nº expedición");
                    IF SalesShipmentHeader.FINDFIRST THEN BEGIN
                        SalesShipmentHeader2.RESET;
                        SalesShipmentHeader2.SETRANGE("No.", SalesShipmentHeader."No.");
                        IF SalesShipmentHeader2.FINDFIRST THEN BEGIN
                            ///CLEAR(EtiquetaECINUEVAALB);            
                            ///EtiquetaECINUEVAALB.Pasadatos(Cajasporenvio."Caja num",Rec113."Cantidad caja",Cajasporenvio.SSCC);   
                            ///EtiquetaECINUEVAALB.SETTABLEVIEW(SalesShipmentHeader2);
                            ///EtiquetaECINUEVAALB.RUNMODAL;
                            //// REPORT.RUN(50105,FALSE,FALSE,SalesShipmentHeader2);                                   
                        END;
                    END;




                END;
            END;





            ///
        END;
    END;






    local procedure ImprimeEtiAdaia()
    begin



        SalesHeader32.Reset;
        SalesHeader32.SetRange(SalesHeader32."Document Type", Rec."Document Type");
        SalesHeader32.SetRange(SalesHeader32."No.", Rec."No.");
        if SalesHeader32.FindSet then begin
            Clear(RepETAD);
            RepETAD.SetTableview(SalesHeader32);
            RepETAD.RunModal;
        end;
        if Rec."Marcar para agrupar" then begin
            /*
               SalesHeader3.RESET;
               SalesHeader3.SETCURRENTKEY("Document Type","Nº expedición");
               SalesHeader3.SETRANGE(SalesHeader3."Document Type",1);
               SalesHeader3.SETRANGE(SalesHeader3."Nº expedición",NPEDIDO);
               IF SalesHeader3.FINDSET THEN REPEAT
                    SalesHeader22.RESET;
                    SalesHeader22.SETRANGE(SalesHeader22."Document Type",SalesHeader3."Document Type");
                    SalesHeader22.SETRANGE(SalesHeader22."No.",SalesHeader3."No.");
                    IF SalesHeader22.FINDSET THEN BEGIN
                         CLEAR(EtiAgrppeque);
                         EtiAgrppeque.SETTABLEVIEW(SalesHeader22);
                         EtiAgrppeque.RUNMODAL;
                    END;
               UNTIL SalesHeader3.NEXT=0;
               */
            SalesHeader3.Reset;
            SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
            SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
            SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
            SalesHeader3.SetRange(SalesHeader3."No.", Rec."No.");
            if SalesHeader3.FindSet then begin
                if SalesHeader3.Dropshipping = true then begin
                    Clear(ETIenvioagrupadoresumen);
                    ETIenvioagrupadoresumen.SetTableview(SalesHeader3);
                    ETIenvioagrupadoresumen.RunModal;
                end;
            end;

            SalesHeader3.Reset;
            SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
            SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
            SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
            if SalesHeader3.FindSet then begin
                if SalesHeader3.Dropshipping = true then begin
                    Clear(ETIenvioagrupadod);
                    ETIenvioagrupadod.SetTableview(SalesHeader3);
                    ETIenvioagrupadod.RunModal;
                end;
            end;
        end;

    end;

    local procedure ImprimeEtiPortugal()
    begin



        Multitabla.Reset;
        Multitabla.SetRange(Multitabla.Tabla, 17);
        Multitabla.SetCurrentkey(Multitabla.Tabla, Multitabla.Ubicacion);
        Multitabla.Ascending(false);
        Multitabla.SetFilter(Multitabla.Ubicacion, '010*01|010*02');
        if Multitabla.FindFirst then
            repeat
                SalesLine.Reset;
                SalesLine.SetRange(SalesLine."Document Type", Rec."Document Type");
                SalesLine.SetRange(SalesLine."Document No.", Rec."No.");
                SalesLine.SetRange(SalesLine."No.", Multitabla.Producto);
                if SalesLine.FindFirst then
                    repeat
                        if SalesLine.Type = 2 then begin
                            if Item.Get(SalesLine."No.") then begin
                                if Item."Etiqueta portugues" = true then begin
                                    X := 0;
                                    repeat
                                        X := X + 1;
                                        ExtendedTextHeader.Reset;
                                        /////-ExtendedTextHeader.SetRange(ExtendedTextHeader."Table Name", ExtendedTextHeader.tablename2::Etiquetas);
                                        ExtendedTextHeader.SetRange(ExtendedTextHeader."No.", SalesLine."No.");
                                        if ExtendedTextHeader.FindFirst then begin

                                            Clear(RepEti);
                                            RepEti.NEXPE(NPEDIDO);
                                            RepEti.SetTableview(ExtendedTextHeader);
                                            RepEti.RunModal;
                                        end;
                                    until X = SalesLine."Outstanding Quantity";
                                end;
                            end;
                        end;
                    until SalesLine.Next = 0;
            until Multitabla.Next = 0;
    end;

    /*
        local procedure CajasDrop()
        begin



            Multitabla2.Reset;
            Multitabla2.SetRange("Código 1", Rec."No.");
            if not Multitabla2.FindFirst then begin

                Multitabla2.Reset;
                Multitabla2.SetRange("Código 1", Rec."No.");
                if Multitabla2.FindFirst then
                    repeat
                        Multitabla2.Delete;
                    until Multitabla2.Next = 0;


                pesopedido := 0;
                cajas0 := 0;
                cajas6 := 0;
                SalesLineTC.Reset;
                SalesLineTC.SetRange(SalesLineTC."Document No.", Rec."No.");
                if SalesLineTC.FindFirst then
                    repeat
                        if Item.Get(SalesLineTC."No.") then begin
                            if Item."Tipo preparacion" = Item."tipo preparacion"::"0-Sin Caja" then begin
                                cajas0 := cajas0 + SalesLineTC."Quantity (Base)";
                            end;
                            if Item."Tipo preparacion" = Item."tipo preparacion"::"6-Tubo" then begin
                                cajas6 := cajas6 + SalesLineTC."Quantity (Base)";
                            end;
                            if (Item."Tipo preparacion" = Item."tipo preparacion"::"1-Muy pequeño") or
                               (Item."Tipo preparacion" = Item."tipo preparacion"::"2-Pequeño") or
                               (Item."Tipo preparacion" = Item."tipo preparacion"::"3-Mediano") or
                               (Item."Tipo preparacion" = Item."tipo preparacion"::"4-Grande") or
                               (Item."Tipo preparacion" = Item."tipo preparacion"::"5- Extra Grande") then begin
                                pesopedido := pesopedido + (SalesLineTC."Quantity (Base)" * SalesLineTC."Net Weight");
                            end;
                        end;
                    until SalesLineTC.Next = 0;



                textocaja := '';
                if cajas0 <> 0 then begin
                    textocaja := textocaja + ' CJ00: ' + Format(cajas0);
                    Multitabla2.Init;
                    Multitabla2."Código 1" := Rec."No.";
                    Multitabla2."Código 2" := 'CJ00';
                    Multitabla2."Cantidad caja" := cajas0;
                    Multitabla2.Insert;
                end;
                if cajas6 <> 0 then begin
                    NCAJAS := cajas6 / 6;
                    NCAJAS := ROUND(NCAJAS, 1);
                    if NCAJAS = 0 then NCAJAS := 1;
                    textocaja := textocaja + ' CJT: ' + Format(NCAJAS);
                    Multitabla2.Init;
                    Multitabla2."Código 1" := Rec."No.";
                    Multitabla2."Código 2" := 'CJT';
                    Multitabla2."Cantidad caja" := cajas6;
                    Multitabla2.Insert;

                end;


                if pesopedido <> 0 then begin
                    Tipocaja.Reset;
                    Tipocaja.SetRange(Combinable, true);
                    Tipocaja.SetRange("Maximo kilos", pesopedido, 999999);
                    if Tipocaja.FindFirst then begin
                        NCAJAS := ROUND(PESO / Tipocaja."Maximo kilos", 1);
                        if NCAJAS = 0 then NCAJAS := 1;
                        textocaja := textocaja + ' ' + Tipocaja."Tipo caja" + ': ' + Format(NCAJAS);
                        Multitabla2.Init;
                        Multitabla2."Código 1" := Rec."No.";
                        Multitabla2."Código 2" := Tipocaja."Tipo caja";
                        Multitabla2."Cantidad caja" := NCAJAS;
                        Multitabla2.Insert;
                    end;
                    if not Tipocaja.FindFirst then begin
                        Tipocaja.Reset;
                        Tipocaja.SetRange(Combinable, true);
                        if Tipocaja.FindLast then begin
                            NCAJAS := ROUND(pesopedido / 10, 1);
                            if NCAJAS = 0 then NCAJAS := 1;
                            textocaja := textocaja + ' ' + Tipocaja."Tipo caja" + ': ' + Format(NCAJAS);
                            Multitabla2.Init;
                            Multitabla2."Código 1" := Rec."No.";
                            Multitabla2."Código 2" := Tipocaja."Tipo caja";
                            Multitabla2."Cantidad caja" := NCAJAS;
                            Multitabla2.Insert;

                        end;
                    end;
                end;
            end;
            Commit;

            Multitabla2.Reset;
            Multitabla2.SetRange("Código 1", Rec."No.");
            if Multitabla2.FindFirst then begin
                Clear(Tipocajaporpedido);
                Tipocajaporpedido.SetTableview(Multitabla2);
                Tipocajaporpedido.RunModal
            end;
        end;
        */

    local procedure ReenviaraADAIA()
    begin
        SalesHeader3.Reset;
        SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
        SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
        SalesHeader3.SetRange(SalesHeader3."Nº expedición", Rec."Nº expedición");
        if SalesHeader3.FindFirst then
            repeat
                SalesLine33.Reset;
                SalesLine33.SetRange("Document Type", 1);
                SalesLine33.SetRange("Document No.", SalesHeader3."No.");
                if SalesLine33.FindFirst then
                    repeat
                        SalesLine33."Nº expedición" := '';
                        SalesLine33."Linea Nº expedición" := 0;
                        SalesLine33.Modify;
                    until SalesLine33.Next = 0;
                SalesHeader3."Nº expedición" := '';
                SalesHeader3."Nº expedición agrupada" := '';
                SalesHeader3."Nº expedición dropshp" := '';
                SalesHeader3.Modify;
            until SalesHeader3.Next = 0;
    end;

    local procedure graba()
    var
        Recat: Record "Document Attachment";
    begin



        vv.Update(1, fichero);
        Recat."Table ID" := 17;
        Recat."No." := copystr(fichero, 1, 20);
        Recat."Attached Date" := CreateDateTime(today, time);
        Recat."File Name" := copystr(fichero, 1, strlen(fichero) - 4);
        Recat."File Type" := Recat."File Type"::PDF;
        Recat."File Extension" := 'pdf';
        Recat.insert;

        ///IF RecItem.GET(codprod) THEN BEGIN
        /// RecItem."Item Category Code" := codcate;
        ///RecItem.item "Product Group Code" := grupo;
        ///RecItem.MODIFY;
        ///END;


    end;

    local procedure grabafc()
     Recat: Record "Document Attachment";
    begin

        vv.Update(1, fichero);
        Recat."Table ID" := 122;
        Recat."No." := copystr(fichero, 1, 20);
        Recat."Attached Date" := CreateDateTime(today, time);
        Recat."File Name" := copystr(fichero, 1, strlen(fichero) - 4);
        Recat."File Type" := Recat."File Type"::PDF;
        Recat."File Extension" := 'pdf';
        Recat.insert;


    end;

    local procedure graba2()
    begin

        RecICP.Code := cod1;
        RecICP."Parent Category" := cod2;
        RecICP.Description := descrip;
        RecICP.Indentation := sangria;
        RecICP."Presentation Order" := orden;
        if RecICP.Insert() then;






    end;

    local procedure grabacat()
    var
        v: Dialog;
    begin

        v.Open('#1##############################');
        if RecItem.get(codprod) then begin
            RecItem."Item Category Code" := cate;
            RecItem.Modify;
            v.Update(1, codprod);
            v.Close();
        end;





    end;

    local procedure grabaimagen()
    var
        Rec1: record Item;
        codprod: code[20];
        url: Text[1000];
        Item: Record Item;
        Client: HttpClient;
        Content: HttpContent;
        Response: HttpResponseMessage;
        InStr: InStream;
        PictureURL: Text;
    begin

        PictureURL := url;
        Client.Get(PictureURL, Response);
        Response.Content.ReadAs(InStr);
        Clear(Rec1.Picture);
        Rec1.Picture.ImportStream(InStr, Format(Rec1."No."));
        Message('%1', rec1."No.");



    end;

    local procedure EnviaraADAIASelccionado(RecSH2: Record "Sales Header")
    var
        AutomaticosAdaia: Codeunit "Automaticos Cartas";
        SalesHeader: Record "Sales Header";
        LogAdaiaPedidos: Record LogAdaiaPedidos;
        LogAdaiaFicheros: Record LogFicherosAdaia;
    begin


        ///Message('%1', RecSH2."No.");





        Commit;

        contadordeagrup := '0';

        if RecSH2."Nº expedición" <> '' then begin
            /////Error('Ya se ha enviado a Adaia.');
        end;
        NoSeriesLine.Reset;
        if RecSH2."VAT Country/Region Code" <> 'PT' then begin
            NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAP');
            if RecSH2."Nº exped. pequeña" then begin
                NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAPP');
            end;
        end;
        if RecSH2."VAT Country/Region Code" = 'PT' then begin
            NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'ADAIAPT');
        end;
        if NoSeriesLine.FindFirst then begin
            NPEDIDO := NoSeriesLine."Last No. Used";
            NoSeriesLine."Last No. Used" := IncStr(NPEDIDO);
            NoSeriesLine.Modify;
        end;

        LogAdaiaFicheros.Init();
        LogAdaiaFicheros.Expedicion := NPEDIDO;
        LogAdaiaFicheros.Error := true;
        if LogAdaiaFicheros.Insert() then;



        SalesReceivablesSetup.Get;
        ItemJournalLine.Reset;
        ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", 'PRODUCTO');
        ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", 'ABC');
        ItemJournalLine.SetRange(ItemJournalLine."Line No.", SalesReceivablesSetup."Ultima letra" + 1);
        if ItemJournalLine.FindFirst then begin
            LETRA := ItemJournalLine."Document No.";
            if SalesReceivablesSetup."Ultima letra" + 1 = 26 then begin
                SalesReceivablesSetup."Ultima letra" := 1;
                SalesReceivablesSetup.Modify;
            end;
            if SalesReceivablesSetup."Ultima letra" + 1 <> 26 then begin
                SalesReceivablesSetup."Ultima letra" := SalesReceivablesSetup."Ultima letra" + 1;
                SalesReceivablesSetup.Modify;
            end;
        end;

        NPEDIDO := NPEDIDO + LETRA;


        if CopyStr(RecSH2."No.", 3, 4) = 'CATW' then begin
            NPEDIDO := RecSH2."Your Reference";
        end;



        if RecSH2."No agrupar en ADAIA" = false then begin
            CODTRANS := '';
            npedidos := 0;
            npedi := '';
            SalesHeader4.Reset;
            SalesHeader4.SetCurrentkey("Document Type", "Sell-to Customer No.", "Estado pedido");
            SalesHeader4.SetRange(SalesHeader4."Document Type", 1);
            if RecSH2."Marcar para agrupar" = false then begin
                SalesHeader4.SetRange(SalesHeader4."Sell-to Customer No.", RecSH2."Sell-to Customer No.");
            end;
            SalesHeader4.SetRange(SalesHeader4."Estado pedido", 1);
            if RecSH2."Marcar para agrupar" = false then begin
                SalesHeader4.SetRange(SalesHeader4."Ship-to Address", RecSH2."Ship-to Address");
            end;
            SalesHeader4.SetRange(SalesHeader4."Nº expedición", '');
            SalesHeader4.SetRange(SalesHeader4."No agrupar en ADAIA", false);
            if RecSH2."Marcar para agrupar" then begin
                SalesHeader4.SetRange(SalesHeader4."Marcar para agrupar", true);
            end;
            SalesHeader4.SetRange("Shipping Agent Code", RecSH2."Shipping Agent Code");
            if SalesHeader4.FindSet then
                repeat
                    ///IF CODTRANS='' THEN BEGIN
                    CODTRANS := SalesHeader4."Shipping Agent Code";
                    npedi := SalesHeader4."No.";
                    ///END;
                    if CODTRANS <> SalesHeader4."Shipping Agent Code" then begin
                        Error('Tienen distinto transportista. %1 %2 %3', SalesHeader4."No.", CODTRANS, npedi);
                    end;
                    if not SalesHeader4."Respeta Tipo facturacion" then begin
                        npedidos := npedidos + 1;
                    end;
                until SalesHeader4.Next = 0;




            SalesHeader3.Reset;
            SalesHeader3.SetCurrentkey("Document Type", "Sell-to Customer No.", "Estado pedido");
            SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
            if RecSH2."Marcar para agrupar" = false then begin
                SalesHeader3.SetRange(SalesHeader3."Sell-to Customer No.", RecSH2."Sell-to Customer No.");
            end;
            SalesHeader3.SetRange(SalesHeader3."Estado pedido", 1);
            if RecSH2."Marcar para agrupar" = false then begin
                SalesHeader3.SetRange(SalesHeader3."Ship-to Address", RecSH2."Ship-to Address");
            end;
            SalesHeader3.SetRange(SalesHeader3."Nº expedición", '');
            SalesHeader3.SetRange(SalesHeader3."No agrupar en ADAIA", false);
            if RecSH2."Marcar para agrupar" then begin
                SalesHeader3.SetRange(SalesHeader3."Marcar para agrupar", true);
            end;
            if SalesHeader3.FindSet then
                repeat
                    SalesHeader33.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                    SalesHeader33."Nº expedición" := NPEDIDO;
                    SalesHeader33."Package Tracking No." := NPEDIDO;
                    SalesLine3.Reset;
                    SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                    SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                    if SalesLine3.FindSet then
                        repeat
                            if SalesLine3.Type = 2 then begin
                                SalesLine3."Nº expedición" := NPEDIDO;
                                SalesLine3.Modify;
                                LogAdaiaPedidos.Init();
                                LogAdaiaPedidos.Expedicion := NPEDIDO;
                                LogAdaiaPedidos.Pedido := SalesLine3."Document No.";
                                LogAdaiaPedidos.Producto := SalesLine3."No.";
                                LogAdaiaPedidos.Linea := SalesLine3."Line No.";
                                LogAdaiaPedidos.Cantidad := SalesLine3.Quantity;
                                if LogAdaiaPedidos.Insert() then;
                            end;

                        until SalesLine3.Next = 0;

                    if npedidos > 1 then begin
                        if SalesHeader3."Tipo facturación" <> 2 then begin
                            if SalesHeader3."Multi-picking" = false then begin
                                SalesHeader33."Tipo facturación" := 1;
                            end;
                        end;
                    end;
                    SalesHeader33.Modify;
                    if SalesHeader33."Marcar para agrupar" then begin
                        Incrementos(SalesHeader33);
                    end;
                    SalesLine3.Reset;
                    SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                    SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                    if SalesLine3.FindSet then
                        repeat
                            if SalesLine3.Type = 2 then begin
                                if SalesLine3."Location Code" = '' then begin
                                    Error('Falta el almacen en la lineas %1 %2', SalesLine3."No.", SalesLine3.Description)
                                end;
                            end;
                        until SalesLine3.Next = 0;
                    if SalesHeader3."Marcar para agrupar" = true then begin
                        if SalesHeader3."Shipping Agent Code" <> 'ECI' then begin
                            SalesHeader22.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                            contadordeagrup := IncStr(contadordeagrup);
                            SalesHeader22."Nº expedición agrupada" := contadordeagrup;
                            EXPEDROP := '';
                            if (RecSH2.Dropshipping = true) and (RecSH2."Marcar para agrupar" = true) then begin
                                EXPEDROP := NoSeriesManagement.GetNextNo('ADAIADROP', Today, true);
                            end;
                            SalesHeader3.CalcFields("Grupo clientes");
                            if (SalesHeader3."Grupo clientes" = 'G52') and (SalesHeader3."Customer Disc. Group" = 'DCCA') then begin
                                EXPEDROP := CopyStr(SalesHeader3."Your Reference", 1, 10);
                                ////SalesHeader22.Validate("Bill-to Customer No.", '11010');
                            end;
                            SalesHeader22."Nº expedición dropshp" := EXPEDROP;
                            SalesHeader22."Package Tracking No." := EXPEDROP;
                            SalesHeader22.Modify;
                            if SalesHeader22."Marcar para agrupar" then begin
                                Incrementos(SalesHeader22);
                            end;
                        end;
                    end;
                until SalesHeader3.Next = 0;
        end;


        if RecSH2."No agrupar en ADAIA" = true then begin

            CODTRANS := '';
            npedidos := 0;
            SalesHeader4.Reset;
            SalesHeader4.SetCurrentkey("Document Type", "Sell-to Customer No.", "Estado pedido");
            SalesHeader4.SetRange(SalesHeader4."Document Type", 1);
            if RecSH2."Marcar para agrupar" = false then begin
                SalesHeader4.SetRange(SalesHeader4."Sell-to Customer No.", RecSH2."Sell-to Customer No.");
            end;
            SalesHeader4.SetRange(SalesHeader4."Estado pedido", 1);
            if RecSH2."Marcar para agrupar" = false then begin
                SalesHeader4.SetRange(SalesHeader4."Ship-to Address", RecSH2."Ship-to Address");
            end;
            SalesHeader4.SetRange(SalesHeader4."Nº expedición", '');
            SalesHeader4.SetRange(SalesHeader4."No.", RecSH2."No.");
            if RecSH2."Marcar para agrupar" then begin
                SalesHeader4.SetRange(SalesHeader4."Marcar para agrupar", true);
            end;
            if SalesHeader4.FindSet then
                repeat
                    if not SalesHeader4."Respeta Tipo facturacion" then begin
                        npedidos := npedidos + 1;
                    end;
                until SalesHeader4.Next = 0;

            SalesHeader3.Reset;
            SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
            SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
            if RecSH2."Marcar para agrupar" = false then begin
                SalesHeader3.SetRange(SalesHeader3."Sell-to Customer No.", RecSH2."Sell-to Customer No.");
            end;
            SalesHeader3.SetRange(SalesHeader3."Estado pedido", 1);
            if RecSH2."Marcar para agrupar" = false then begin
                SalesHeader3.SetRange(SalesHeader3."Ship-to Address", RecSH2."Ship-to Address");
            end;
            SalesHeader3.SetRange(SalesHeader3."Nº expedición", '');
            SalesHeader3.SetRange(SalesHeader3."No.", RecSH2."No.");
            if RecSH2."Marcar para agrupar" then begin
                SalesHeader3.SetRange(SalesHeader3."Marcar para agrupar", true);
            end;
            if SalesHeader3.FindSet then
                repeat
                    SalesHeader33.Get(SalesHeader3."Document Type", SalesHeader3."No.");
                    SalesHeader33."Nº expedición" := NPEDIDO;
                    SalesHeader33."Nº expedición dropshp" := EXPEDROP;
                    SalesHeader33."Package Tracking No." := EXPEDROP;
                    SalesLine3.Reset;
                    SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                    SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                    if SalesLine3.FindSet then
                        repeat
                            if SalesLine3.Type = 2 then begin
                                SalesLine3."Nº expedición" := NPEDIDO;
                                SalesLine3.Modify;
                                LogAdaiaPedidos.Init();
                                LogAdaiaPedidos.Expedicion := NPEDIDO;
                                LogAdaiaPedidos.Pedido := SalesLine3."Document No.";
                                LogAdaiaPedidos.Producto := SalesLine3."No.";
                                LogAdaiaPedidos.Linea := SalesLine3."Line No.";
                                LogAdaiaPedidos.Cantidad := SalesLine3.Quantity;
                                if LogAdaiaPedidos.Insert() then;
                            end;
                        until SalesLine3.Next = 0;
                    if npedidos > 1 then begin
                        if SalesHeader3."Tipo facturación" <> 2 then begin
                            if SalesHeader3."Multi-picking" = false then begin
                                SalesHeader33."Tipo facturación" := 1;
                            end;
                        end;
                    end;
                    SalesHeader33.Modify;
                    if SalesHeader33."Marcar para agrupar" then begin
                        Incrementos(SalesHeader33);
                    end;
                    SalesLine3.Reset;
                    SalesLine3.SetRange(SalesLine3."Document Type", SalesHeader3."Document Type");
                    SalesLine3.SetRange(SalesLine3."Document No.", SalesHeader3."No.");
                    if SalesLine3.FindSet then
                        repeat
                            if SalesLine3.Type = 2 then begin
                                if SalesLine3."Location Code" = '' then begin
                                    Error('Falta el almacen en la lineas %1 %2', SalesLine3."No.", SalesLine3.Description)
                                end;
                            end;
                        until SalesLine3.Next = 0;
                until SalesHeader3.Next = 0;
        end;





        Sleep(3000);
        SalesHeader3.Reset;
        SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
        SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
        SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
        if SalesHeader3.FindFirst then begin
            Clear(AutomaticosAdaia);
            AutomaticosAdaia.ENVIAEXPEDICIONES(SalesHeader3);


            if LogAdaiaFicheros.get(NPEDIDO) then begin
                LogAdaiaFicheros.Error := false;
                LogAdaiaFicheros.Subido := true;
                LogAdaiaFicheros.Modify();
            end;

        end;

        Commit;

        SalesHeader35.Reset;
        SalesHeader35.SetRange(SalesHeader35."Document Type", RecSH2."Document Type");
        SalesHeader35.SetRange(SalesHeader35."No.", RecSH2."No.");
        if SalesHeader35.FindFirst then begin
            if CopyStr(SalesHeader35."No.", 3, 3) <> 'WEB' then begin
                AutomaticosAdaia.ENVIAREMAILPARAPREPARAR(SalesHeader35);
            end;
        end;

        SalesHeader3.Reset;
        SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
        SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
        SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
        if SalesHeader3.FindSet then
            repeat
                if CopyStr(SalesHeader3."No.", 3, 3) = 'WEB' then begin
                    SalesLine5.Reset;
                    SalesLine5.SetRange(SalesLine5."Document Type", SalesHeader3."Document Type");
                    SalesLine5.SetRange(SalesLine5."Document No.", SalesHeader3."No.");
                    if SalesLine5.FindSet then
                        repeat
                            SalesLine5."Usuario alta" := 'HAGEN\OSCAR';
                            SalesLine5.Modify;
                        until SalesLine5.Next = 0;
                end;

            until SalesHeader3.Next = 0;


        Commit;




    end;


    local procedure Incrementos(RecSH2: Record "Sales Header")
    var
        SalesHeader: Record "Sales Header";
        RecItem: Record Item;
        RecLV: Record "Sales Line";
        VASOLO: Boolean;
        TIENEINCREMENTO: Boolean;
        INCREMENTO: INTEGER;
        AINCREMENTO: INTEGER;
        tienecombina: Boolean;
        difcombina: Integer;
        INCREMENTOcombina: INTEGER;
        RecCV2: Record "Sales Header";
    begin

        VASOLO := true;
        TIENEINCREMENTO := false;
        tienecombina := false;
        INCREMENTOcombina := 0;
        INCREMENTO := 0;
        RecCV2.get(RecSH2."Document Type", RecSH2."No.");
        RecCV2."Incrementa bultos" := 0;
        RecCV2.Modify();

        RecLV.reset;
        RecLV.SetRange("Document Type", RecSH2."Document Type");
        RecLV.SetRange("Document No.", RecSH2."No.");
        RecLV.SetRange(RecLV.Type, RecLV.Type::Item);
        IF RecLV.FindFirst() THEN
            repeat
                IF RecItem.GET(RecLV."No.") THEN begin
                    IF RecItem."Bultos en caja" THEN begin
                        TIENEINCREMENTO := TRUE;
                        INCREMENTO := INCREMENTO + RecLV."Outstanding Qty. (Base)";
                    end;
                    IF RecItem."Bultos solos" THEN begin
                        tienecombina := TRUE;
                        difcombina := difcombina + 1;
                        INCREMENTOcombina := INCREMENTOcombina + RecLV."Outstanding Qty. (Base)";
                    end;
                end;
            UNTIL RecLV.NEXT = 0;
        RecLV.reset;
        RecLV.SetRange("Document Type", RecSH2."Document Type");
        RecLV.SetRange("Document No.", RecSH2."No.");
        RecLV.SetRange(RecLV.Type, RecLV.Type::Item);
        IF RecLV.FindFirst() THEN
            repeat
                IF RecItem.GET(RecLV."No.") THEN begin
                    IF NOT RecItem."Bultos en caja" THEN begin
                        VASOLO := false;
                    end;
                end;
            UNTIL RecLV.NEXT = 0;
        IF VASOLO THEN begin
            if INCREMENTO = 1 then begin AINCREMENTO := 0; end;
            if INCREMENTO = 2 then begin AINCREMENTO := 0; end;
            if INCREMENTO = 3 then begin AINCREMENTO := 1; end;
            if INCREMENTO = 4 then begin AINCREMENTO := 1; end;
            if INCREMENTO = 5 then begin AINCREMENTO := 2; end;
            if INCREMENTO = 6 then begin AINCREMENTO := 2; end;
            if INCREMENTO = 7 then begin AINCREMENTO := 3; end;
            if INCREMENTO = 8 then begin AINCREMENTO := 3; end;
            if INCREMENTO = 9 then begin AINCREMENTO := 4; end;
            if INCREMENTO = 10 then begin AINCREMENTO := 4; end;
            if INCREMENTO = 11 then begin AINCREMENTO := 5; end;
            if INCREMENTO = 12 then begin AINCREMENTO := 5; end;
            if INCREMENTO = 13 then begin AINCREMENTO := 6; end;
            if INCREMENTO = 14 then begin AINCREMENTO := 6; end;
            if INCREMENTO = 15 then begin AINCREMENTO := 7; end;
            if INCREMENTO = 16 then begin AINCREMENTO := 7; end;
            if INCREMENTO = 17 then begin AINCREMENTO := 8; end;
            if INCREMENTO = 18 then begin AINCREMENTO := 8; end;
            if INCREMENTO = 19 then begin AINCREMENTO := 9; end;
            if INCREMENTO = 20 then begin AINCREMENTO := 9; end;
            if INCREMENTO = 21 then begin AINCREMENTO := 10; end;
            if INCREMENTO = 22 then begin AINCREMENTO := 10; end;
            if INCREMENTO = 23 then begin AINCREMENTO := 11; end;
            if INCREMENTO = 24 then begin AINCREMENTO := 11; end;
            if INCREMENTO = 25 then begin AINCREMENTO := 12; end;
            if INCREMENTO = 26 then begin AINCREMENTO := 12; end;
            if INCREMENTO = 27 then begin AINCREMENTO := 13; end;
            if INCREMENTO = 28 then begin AINCREMENTO := 13; end;
            if INCREMENTO = 29 then begin AINCREMENTO := 14; end;
            if INCREMENTO = 30 then begin AINCREMENTO := 14; end;
            if INCREMENTO = 31 then begin AINCREMENTO := 15; end;
            if INCREMENTO = 32 then begin AINCREMENTO := 15; end;
            if INCREMENTO = 33 then begin AINCREMENTO := 16; end;
            if INCREMENTO = 34 then begin AINCREMENTO := 16; end;
            if INCREMENTO = 35 then begin AINCREMENTO := 17; end;
            if INCREMENTO = 36 then begin AINCREMENTO := 17; end;
            if INCREMENTO = 37 then begin AINCREMENTO := 18; end;
            if INCREMENTO = 38 then begin AINCREMENTO := 18; end;
            if INCREMENTO = 39 then begin AINCREMENTO := 19; end;
            if INCREMENTO = 40 then begin AINCREMENTO := 19; end;
            if INCREMENTO = 41 then begin AINCREMENTO := 20; end;
            if INCREMENTO = 42 then begin AINCREMENTO := 20; end;
            if INCREMENTO = 43 then begin AINCREMENTO := 21; end;
            if INCREMENTO = 44 then begin AINCREMENTO := 21; end;
            if INCREMENTO = 45 then begin AINCREMENTO := 22; end;
            if INCREMENTO = 46 then begin AINCREMENTO := 22; end;
            if INCREMENTO = 47 then begin AINCREMENTO := 23; end;
            if INCREMENTO = 48 then begin AINCREMENTO := 23; end;
            if INCREMENTO = 49 then begin AINCREMENTO := 24; end;
            if INCREMENTO = 50 then begin AINCREMENTO := 24; end;

            RecCV2."Incrementa bultos" := RecCV2."Incrementa bultos" + AINCREMENTO;
            RecCV2.Modify();
        end;
        IF NOT VASOLO THEN begin
            if INCREMENTO = 1 then begin AINCREMENTO := 1; end;
            if INCREMENTO = 2 then begin AINCREMENTO := 1; end;
            if INCREMENTO = 3 then begin AINCREMENTO := 2; end;
            if INCREMENTO = 4 then begin AINCREMENTO := 2; end;
            if INCREMENTO = 5 then begin AINCREMENTO := 3; end;
            if INCREMENTO = 6 then begin AINCREMENTO := 3; end;
            if INCREMENTO = 7 then begin AINCREMENTO := 4; end;
            if INCREMENTO = 8 then begin AINCREMENTO := 4; end;
            if INCREMENTO = 9 then begin AINCREMENTO := 5; end;
            if INCREMENTO = 10 then begin AINCREMENTO := 5; end;
            if INCREMENTO = 11 then begin AINCREMENTO := 6; end;
            if INCREMENTO = 12 then begin AINCREMENTO := 6; end;
            if INCREMENTO = 13 then begin AINCREMENTO := 7; end;
            if INCREMENTO = 14 then begin AINCREMENTO := 7; end;
            if INCREMENTO = 15 then begin AINCREMENTO := 8; end;
            if INCREMENTO = 16 then begin AINCREMENTO := 8; end;
            if INCREMENTO = 17 then begin AINCREMENTO := 9; end;
            if INCREMENTO = 18 then begin AINCREMENTO := 9; end;
            if INCREMENTO = 19 then begin AINCREMENTO := 10; end;
            if INCREMENTO = 20 then begin AINCREMENTO := 10; end;
            if INCREMENTO = 21 then begin AINCREMENTO := 11; end;
            if INCREMENTO = 22 then begin AINCREMENTO := 11; end;
            if INCREMENTO = 23 then begin AINCREMENTO := 12; end;
            if INCREMENTO = 24 then begin AINCREMENTO := 12; end;
            if INCREMENTO = 25 then begin AINCREMENTO := 13; end;
            if INCREMENTO = 26 then begin AINCREMENTO := 13; end;
            if INCREMENTO = 27 then begin AINCREMENTO := 14; end;
            if INCREMENTO = 28 then begin AINCREMENTO := 14; end;
            if INCREMENTO = 29 then begin AINCREMENTO := 15; end;
            if INCREMENTO = 30 then begin AINCREMENTO := 15; end;
            if INCREMENTO = 31 then begin AINCREMENTO := 16; end;
            if INCREMENTO = 32 then begin AINCREMENTO := 16; end;
            if INCREMENTO = 33 then begin AINCREMENTO := 17; end;
            if INCREMENTO = 34 then begin AINCREMENTO := 17; end;
            if INCREMENTO = 35 then begin AINCREMENTO := 18; end;
            if INCREMENTO = 36 then begin AINCREMENTO := 18; end;
            if INCREMENTO = 37 then begin AINCREMENTO := 19; end;
            if INCREMENTO = 38 then begin AINCREMENTO := 19; end;
            if INCREMENTO = 39 then begin AINCREMENTO := 20; end;
            if INCREMENTO = 40 then begin AINCREMENTO := 20; end;
            if INCREMENTO = 41 then begin AINCREMENTO := 21; end;
            if INCREMENTO = 42 then begin AINCREMENTO := 21; end;
            if INCREMENTO = 43 then begin AINCREMENTO := 22; end;
            if INCREMENTO = 44 then begin AINCREMENTO := 22; end;
            if INCREMENTO = 45 then begin AINCREMENTO := 23; end;
            if INCREMENTO = 46 then begin AINCREMENTO := 23; end;
            if INCREMENTO = 47 then begin AINCREMENTO := 24; end;
            if INCREMENTO = 48 then begin AINCREMENTO := 24; end;
            if INCREMENTO = 49 then begin AINCREMENTO := 25; end;
            if INCREMENTO = 50 then begin AINCREMENTO := 25; end;

            RecCV2."Incrementa bultos" := RecCV2."Incrementa bultos" + AINCREMENTO;
            RecCV2.Modify();
        end;
        if tienecombina then begin
            if INCREMENTOcombina = 1 then begin AINCREMENTO := 0; end;
            if INCREMENTOcombina = 2 then begin AINCREMENTO := 1; end;
            if INCREMENTOcombina = 3 then begin AINCREMENTO := 2; end;
            if INCREMENTOcombina = 4 then begin AINCREMENTO := 3; end;
            if INCREMENTOcombina = 5 then begin AINCREMENTO := 4; end;
            if INCREMENTOcombina = 6 then begin AINCREMENTO := 5; end;
            if INCREMENTOcombina = 7 then begin AINCREMENTO := 6; end;
            if INCREMENTOcombina = 8 then begin AINCREMENTO := 7; end;
            if INCREMENTOcombina = 9 then begin AINCREMENTO := 8; end;
            if INCREMENTOcombina = 10 then begin AINCREMENTO := 9; end;
            if INCREMENTOcombina = 11 then begin AINCREMENTO := 10; end;
            if INCREMENTOcombina = 12 then begin AINCREMENTO := 11; end;
            if INCREMENTOcombina = 13 then begin AINCREMENTO := 12; end;
            if INCREMENTOcombina = 14 then begin AINCREMENTO := 13; end;
            if INCREMENTOcombina = 15 then begin AINCREMENTO := 14; end;
            if INCREMENTOcombina = 16 then begin AINCREMENTO := 15; end;
            if INCREMENTOcombina = 17 then begin AINCREMENTO := 16; end;
            if INCREMENTOcombina = 18 then begin AINCREMENTO := 17; end;
            if INCREMENTOcombina = 19 then begin AINCREMENTO := 18; end;
            if INCREMENTOcombina = 20 then begin AINCREMENTO := 19; end;
            if INCREMENTOcombina = 21 then begin AINCREMENTO := 20; end;
            if INCREMENTOcombina = 22 then begin AINCREMENTO := 21; end;
            if INCREMENTOcombina = 23 then begin AINCREMENTO := 22; end;
            if INCREMENTOcombina = 24 then begin AINCREMENTO := 23; end;
            if INCREMENTOcombina = 25 then begin AINCREMENTO := 24; end;
            if INCREMENTOcombina = 26 then begin AINCREMENTO := 25; end;
            if INCREMENTOcombina = 27 then begin AINCREMENTO := 26; end;
            if INCREMENTOcombina = 28 then begin AINCREMENTO := 27; end;
            if INCREMENTOcombina = 29 then begin AINCREMENTO := 28; end;
            if INCREMENTOcombina = 30 then begin AINCREMENTO := 29; end;
            if INCREMENTOcombina = 31 then begin AINCREMENTO := 30; end;
            if INCREMENTOcombina = 32 then begin AINCREMENTO := 31; end;
            if INCREMENTOcombina = 33 then begin AINCREMENTO := 32; end;
            if INCREMENTOcombina = 34 then begin AINCREMENTO := 33; end;
            if INCREMENTOcombina = 35 then begin AINCREMENTO := 34; end;
            if INCREMENTOcombina = 36 then begin AINCREMENTO := 35; end;
            if INCREMENTOcombina = 37 then begin AINCREMENTO := 36; end;
            if INCREMENTOcombina = 38 then begin AINCREMENTO := 37; end;
            if INCREMENTOcombina = 39 then begin AINCREMENTO := 38; end;
            if INCREMENTOcombina = 40 then begin AINCREMENTO := 39; end;
            if INCREMENTOcombina = 41 then begin AINCREMENTO := 40; end;
            if INCREMENTOcombina = 42 then begin AINCREMENTO := 41; end;
            if INCREMENTOcombina = 43 then begin AINCREMENTO := 42; end;
            if INCREMENTOcombina = 44 then begin AINCREMENTO := 43; end;
            if INCREMENTOcombina = 45 then begin AINCREMENTO := 44; end;
            if INCREMENTOcombina = 46 then begin AINCREMENTO := 45; end;
            if INCREMENTOcombina = 47 then begin AINCREMENTO := 46; end;
            if INCREMENTOcombina = 48 then begin AINCREMENTO := 47; end;
            if INCREMENTOcombina = 49 then begin AINCREMENTO := 48; end;
            if INCREMENTOcombina = 50 then begin AINCREMENTO := 49; end;
            if INCREMENTOcombina = 51 then begin AINCREMENTO := 50; end;
            if INCREMENTOcombina = 52 then begin AINCREMENTO := 51; end;
            if INCREMENTOcombina = 53 then begin AINCREMENTO := 52; end;
            if INCREMENTOcombina = 54 then begin AINCREMENTO := 53; end;
            if INCREMENTOcombina = 55 then begin AINCREMENTO := 54; end;
            if INCREMENTOcombina = 56 then begin AINCREMENTO := 55; end;
            if INCREMENTOcombina = 57 then begin AINCREMENTO := 56; end;
            if INCREMENTOcombina = 58 then begin AINCREMENTO := 57; end;
            if INCREMENTOcombina = 59 then begin AINCREMENTO := 58; end;
            if INCREMENTOcombina = 60 then begin AINCREMENTO := 59; end;

            RecCV2."Incrementa bultos" := RecCV2."Incrementa bultos" + AINCREMENTO;
            RecCV2.Modify();






        end;

        ///Message('%1', RecSH2."Nº bultos");








    end;



}

