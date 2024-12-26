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
    Permissions = tabledata 110 = rmid, tabledata "Cajas por pedido" = rmid;

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
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Basic;
                    StyleExpr = ESTILOLINEA;
                }
                field("Estado pedido";Rec."Estado pedido")
                {
                    ApplicationArea = Basic;
                    StyleExpr = ESTILOLINEA;
                    Editable = false;
                }
                field("Payment Method Code";Rec."Payment Method Code")
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
                    begin

                        EnviaraADAIA;
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

                action(CODIGOSPOSTALES)
                {
                    ApplicationArea = Basic;
                    Caption = 'CODIGOSPOSTALES';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                    XmlPort50509:  XmlPort "Importa datos nav2018-8cp";
                    begin

                        CLEAR(XmlPort50509);
                        XmlPort50509.Run();
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
                        RecItem: Record Item;
                        RecSP: Record "Sales Price";
                        Automaticos: Codeunit "Automaticos Cartas";
                    begin
                        Automaticos.ENVIAREMIALFACTURAS();
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
                        Message('hecho');

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
                                        Clear(ETIenvioagrupadod);
                                        ETIenvioagrupadod.SetTableview(SalesHeader3);
                                        ETIenvioagrupadod.RunModal;
                                    until SalesHeader3.next = 0;
                            until SalesHeader4.next = 0;
                    end;
                }
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
                    NCAJAS := ROUND(pesopedido / Tipocaja."Maximo kilos", 1);
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
        NoSeriesManagement: Codeunit NoSeriesManagement;
        ETIenvioagrupadoresumen: Report "ETI. envio agrupado resumen";
        ETIenvioagrupadod: Report "ETI. envio agrupado d";
        ETIenvioagrupadod2: Report "ETI. envio agrupado d2";
        cajas7: Integer;
        cajas8: Integer;
        cajas9: Integer;
        cajas10: Integer;
        LineaspedidoAMAZON: Report "Lineas pedido AMAZON";
        SalesLine33: Record "Sales Line";
        npedi: Code[20];
        LineasPedidosexpedicion: Report "Lineas albaran expedicion";
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



    local procedure EnviaraADAIA()
    var
        AutomaticosAdaia: Codeunit "Automaticos Cartas";
        SalesHeader: Record "Sales Header";
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

                    if npedidos > 1 then begin
                        if SalesHeader3."Tipo facturación" <> 2 then begin
                            if SalesHeader3."Multi-picking" = false then begin
                                SalesHeader33."Tipo facturación" := 1;
                            end;
                        end;
                    end;
                    SalesHeader33.Modify;
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
                            if CopyStr(SalesHeader3."No.", 3, 4) = 'CATW' then begin
                                EXPEDROP := SalesHeader3."Your Reference";
                            end;
                            SalesHeader22."Nº expedición dropshp" := EXPEDROP;
                            SalesHeader22.Modify;
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
                    if npedidos > 1 then begin
                        if SalesHeader3."Tipo facturación" <> 2 then begin
                            if SalesHeader3."Multi-picking" = false then begin
                                SalesHeader33."Tipo facturación" := 1;
                            end;
                        end;
                    end;
                    SalesHeader33.Modify;
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






        SalesHeader3.Reset;
        SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
        SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
        SalesHeader3.SetRange(SalesHeader3."Nº expedición", NPEDIDO);
        if SalesHeader3.FindFirst then begin
            Clear(AutomaticosAdaia);
            AutomaticosAdaia.ENVIAEXPEDICIONES(SalesHeader3);

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
    begin

        IF RecItem.GET(codprod) THEN BEGIN
            RecItem."Item Category Code" := codcate;
            ///RecItem.item "Product Group Code" := grupo;
            RecItem.MODIFY;
        END;


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



}

