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

                        
                        codprod := 'A16353';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16353_product-1536x1536.jpg?v=1731667801';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;
                        PictureURL:=url;
                        Client.Get(PictureURL, Response);                         
                        Response.Content.ReadAs(InStr);
                        Clear(Rec1.Picture);                        
                        Rec1.Picture.ImportStream(InStr, Format(Rec1."No."));                                                                          
                        rec1.Modify;commit;
                        commit;
                        codprod := 'A16053';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16053_product-1536x1536.jpg?v=1731667800';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;
                        PictureURL:=url;
                        Client.Get(PictureURL, Response);                         
                        Response.Content.ReadAs(InStr);
                        Clear(Rec1.Picture);                        
                        Rec1.Picture.ImportStream(InStr, Format(Rec1."No."));                                                                                                  
                        rec1.Modify;commit;
                        commit;
                        codprod := 'A236';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/foamex-para-filtros-externos-fluval-serie-06-y-07_2.jpg?v=1731681939';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;
                        PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No."));                                                                                                  
                        rec1.Modify;commit;
                        commit;                        
                        codprod := 'A237';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/foamex-para-filtros-externos-fluval-serie-06-y-07_1.jpg?v=1731681939';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16351';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16351_product-1536x1536.jpg?v=1731667644';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16412';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16412_product-1536x1536.jpg?v=1731667644';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16051';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16051_product-1536x1536.jpg?v=1731667644';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20234';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/abrazadera-2pc-fluval-fx5fx6.jpg?v=1733651838';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8354';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/fluval-limpiador-bioligico-waste-control-120ml_e18e42b3-1c93-4cde-bef3-ca63011e4335.jpg?v=1734503761';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8355';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/fluval-limpiador-bioligico-waste-control-250ml_9d358353-8551-4071-b5f6-58821e78c925.jpg?v=1734503761';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1425';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1425.jpg?v=1731601967';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20010';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20011.jpg?v=1731601625';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20011';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20010.jpg?v=1731601625';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1428';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1428.jpg?v=1731601961';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1422';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1422.jpg?v=1731601978';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A337';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a337.jpg?v=1731600715';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A335';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a336.jpg?v=1731600715';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A336';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a335.jpg?v=1731600714';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A334';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a334.jpg?v=1731600714';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20233';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20233.jpg?v=1731601176';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1377';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1377.jpg?v=1731602076';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19631';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19635_packaging_front_INT.png?v=1731603439';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19633';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19635_image1.png?v=1731603439';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19635';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19635_image2.png?v=1731603439';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A854';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A854-2.jpg?v=1731600187';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A853';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A854.jpg?v=1731600187';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A851';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A853-2.jpg?v=1731600187';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A13341';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/iluminacion-bluetooth-acuario-fluval-roma.jpg?v=1731608141';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20172';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20172.jpg?v=1731601318';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20152';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20152.jpg?v=1731601357';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20111';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20111.jpg?v=1731601455';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20221';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20221.jpg?v=1731601214';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19682';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19682_packaging-1536x1536.jpg?v=1731603264';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19680';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19682_image1-1536x1536.jpg?v=1731603264';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20038';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20064.jpg?v=1731601520';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20063';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20063.jpg?v=1731601520';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20064';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20038.jpg?v=1731601571';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A6584';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a6584.jpg?v=1731600375';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A6583';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a6584-2.jpg?v=1731600375';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        //codprod:='A6584CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A6583.jpg?v=1731600375';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        //codprod:='A6583CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a6583-2.jpg?v=1731600375';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        codprod := 'A16331';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16031_product-1536x1536.jpg?v=1731643732';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16131';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16131_product-1536x1536.jpg?v=1731643731';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16431';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16231_product-1536x1536.jpg?v=1731643732';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16031';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16431_product-1536x1536.jpg?v=1731643732';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16231';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16331_product-1536x1536.jpg?v=1731643834';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20020';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20020.jpg?v=1731601594';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20183';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20198.jpg?v=1731601300';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20188';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20193.jpg?v=1731601300';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20193';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20188.jpg?v=1731601300';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20198';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20183.jpg?v=1731601300';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1462';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a1462.jpg?v=1731601924';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18175';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18183.jpg?v=1731603751';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18176';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18182.jpg?v=1731603751';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18177';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18181.jpg?v=1731603751';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18171';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18177.jpg?v=1731603751';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18170';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18176.jpg?v=1731603751';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18182';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18175.jpg?v=1731603751';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18183';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18171.jpg?v=1731603751';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18181';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18170.jpg?v=1731603751';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18169';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18169.jpg?v=1731603751';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '17561';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/17561.jpg?v=1731603762';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19665';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19665_packaging_front_INT.png?v=1731603301';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19660';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19665_image1.png?v=1731603301';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19662';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19665_image2.png?v=1731603301';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18197';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18205.jpg?v=1731603735';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18198';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18204.jpg?v=1731603735';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18199';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18203.jpg?v=1731603735';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18193';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18199.jpg?v=1731603735';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18191';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18198.jpg?v=1731603735';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18192';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18197.jpg?v=1731603735';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18203';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18193.jpg?v=1731603735';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18204';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18192.jpg?v=1731603735';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18205';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18191.jpg?v=1731603735';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14652';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14672.jpg?v=1731601884';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14672';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14652.jpg?v=1731601911';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8348';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8352.jpg?v=1731600273';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8349';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8351.jpg?v=1731600273';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8351';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8349.jpg?v=1731600273';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8352';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8348.jpg?v=1731600273';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8346';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8346.jpg?v=1731600273';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20026';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20026.jpg?v=1731601583';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A208';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A208.jpg?v=1731600917';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14345';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14345.jpg?v=1734093015';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14346';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14346.jpg?v=1734093015';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14347';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14347.jpg?v=1734093015';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14348';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14348.jpg?v=1734093015';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1457';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1457.jpg?v=1731601942';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1456';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1457-2.jpg?v=1731601941';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        //codprod:='A1457CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1456.jpg?v=1731601942';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        codprod := '19686';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19684_product-1536x1536.jpg?v=1731603250';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19684';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19684_image1-1536x1536.jpg?v=1731603250';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1348';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1348.jpg?v=1731602113';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20236';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20236.jpg?v=1731601157';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1378';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1378.jpg?v=1731602062';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A6586';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A6586.jpg?v=1734090924';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A6587';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a6586-2.jpg?v=1734090924';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        //codprod:='A6586CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A6587.jpg?v=1734090924';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        //codprod:='A6587CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a6587-2.jpg?v=1734090924';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        codprod := '19694';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19693_packaging-1536x1536.jpg?v=1731603242';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19693';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19694_image1-1536x1536.jpg?v=1731603242';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19690';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19694_packaging-1536x1536.jpg?v=1731603242';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19692';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19694_product-1536x1536.jpg?v=1731603242';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19691';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19693_image1-1536x1536.jpg?v=1731603242';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14513';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14513.jpg?v=1731604012';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20008';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20008.jpg?v=1731601631';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A744';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a745-2.jpg?v=1731600325';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A745';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a745.jpg?v=1731600325';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A743';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a744.jpg?v=1731600324';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        //codprod:='A744CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a743.jpg?v=1731600325';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        //codprod:='A745CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a743-2.jpg?v=1731600324';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        //codprod:='A743CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a743-3.jpg?v=1731600324';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        codprod := 'A8340';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8344.jpg?v=1734091064';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8342';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8343.jpg?v=1734091064';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8343';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8342.jpg?v=1734091064';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8344';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8340.jpg?v=1734091064';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8345';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8345.jpg?v=1734091064';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14551';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14555.jpg?v=1731603899';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14550';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14553.jpg?v=1731603899';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14555';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14551.jpg?v=1731603899';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14553';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14550.jpg?v=1731603899';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        //codprod:='14551CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14550-2.jpg?v=1731603899';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        codprod := 'A20101';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20104.jpg?v=1731601472';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20104';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20103.jpg?v=1731601472';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20102';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20102.jpg?v=1731601472';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20103';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20101.jpg?v=1731601472';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A263';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a264.jpg?v=1731600769';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A264';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a264-2.jpg?v=1731600770';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14782';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14782.jpg?v=1731601766';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20232';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20232.jpg?v=1731601182';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1470';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1470.jpg?v=1731601815';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20121';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20121.jpg?v=1731601415';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14770';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14770.jpg?v=1731601772';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14763';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14763.jpg?v=1731601784';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A239';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A239.jpg?v=1731600842';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14001';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14003.jpg?v=1731604114';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14002';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14002.jpg?v=1731604114';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14003';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14001.jpg?v=1731604114';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20210';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20210.jpg?v=1731601257';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20071';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20073.jpg?v=1731601501';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20072';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20072.jpg?v=1731601501';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20073';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20071.jpg?v=1731601501';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14005';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14007.jpg?v=1731604105';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14006';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14006.jpg?v=1731604105';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14007';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14005.jpg?v=1731604105';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20207';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20213.jpg?v=1731601238';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20211';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a20211.jpg?v=1731601251';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20213';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20207.jpg?v=1731601270';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A228';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A228.jpg?v=1731600876';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20225';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20225.jpg?v=1731601208';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1379';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1379.jpg?v=1731602054';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10505';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10505.jpg?v=1731604642';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10681';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10681.jpg?v=1731604585';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20060';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20060.jpg?v=1731601538';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10515';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10525.jpg?v=1731604632';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10516';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10525-2.jpg?v=1731604633';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10525';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10525-3.jpg?v=1731604633';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10517';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10518.jpg?v=1731604632';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10518';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10518-2.jpg?v=1731604632';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14659';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14659.jpg?v=1731601891';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A465';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A480.jpg?v=1731600610';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A475';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A480-2.jpg?v=1731600610';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A470';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A475-2.jpg?v=1731600610';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A480';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A475.jpg?v=1731600610';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        //codprod:='A465CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A470-2.jpg?v=1731600610';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        //codprod:='A475CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A470.jpg?v=1731600610';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        //codprod:='A480CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A465.jpg?v=1731600610';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        //codprod:='A470CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A465-2.jpg?v=1731600610';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        codprod := '19623';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19618_packaging_front_US.png?v=1731603562';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19605';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19623_image1.png?v=1731603538';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19618';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19623_packaging_front_INT.png?v=1731603538';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19613';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19618_image1.png?v=1731603562';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19598';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19618_packaging_front_INT.png?v=1731603562';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14566';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14566.jpg?v=1731603876';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14565';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14566.png?v=1731603879';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        //odprod:='14566CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14565.jpg?v=1731603882';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        //codprod:='14565CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14565.png?v=1731603885';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        codprod := 'A6589';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A6590.jpg?v=1731600345';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A6590';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A6590.png?v=1731600348';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        //odprod:='A6590CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A6589.jpg?v=1731600351';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        //codprod:='A6589CAJA';url:='https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a6589-2.jpg?v=1731600355';Rec1.get(codprod);Rec1."URL IMAGEN 1":=url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); rec1.Modify;commit;
                        codprod := 'A14695';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14702.jpg?v=1731601796';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14691';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14695.jpg?v=1731601822';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14687';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a14691.jpg?v=1731601837';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14702';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14687.jpg?v=1731601852';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14678';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14678.jpg?v=1731601865';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14674';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14674.jpg?v=1731601878';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A425';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A425.jpg?v=1731600661';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14016';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14016.jpg?v=1731604079';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14014';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14015.jpg?v=1731604079';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14015';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14014.jpg?v=1731604078';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19595';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19595_packaging_front_INT.png?v=1731603667';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19600';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19620_image1-1536x1536.jpg?v=1731603548';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19610';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19620_image2-1536x1536.jpg?v=1731603548';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19615';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19620_image3-1536x1536.jpg?v=1731603547';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19620';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19620_image5.png?v=1731603548';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A458';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A458.jpg?v=1731600619';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A456';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A457.jpg?v=1731600618';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A457';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A456.jpg?v=1731600619';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14988';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14988.jpg?v=1731603850';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14987';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14988-2.jpg?v=1731603850';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '11085';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/11086.jpg?v=1731604403';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '11086';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/11086.png?v=1731604406';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A259';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A265.jpg?v=1731600757';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A265';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A262.jpg?v=1731600777';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A262';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a259.jpg?v=1731600795';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20123';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20123.jpg?v=1731601403';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1376';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1376.jpg?v=1731602086';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1375';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1376-2.jpg?v=1731602089';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1465';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1465.jpg?v=1731601917';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14549';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14549.jpg?v=1731603905';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A226';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A222.jpg?v=1731600893';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A222';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A226.jpg?v=1731600893';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A220';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A220-2.jpg?v=1731600893';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20174';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20174.jpg?v=1731601306';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '15015';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/15015.jpg?v=1731603812';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20257';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20257.jpg?v=1731601108';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20235';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20235.jpg?v=1731601164';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20204';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20204.jpg?v=1731601283';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A19998';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A19990.jpg?v=1731601645';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A19990';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a19990-2.jpg?v=1731601645';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19643';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19645_packaging_front_INT.png?v=1731603370';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19645';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19645_image1.png?v=1731603370';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19641';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19645_image2.png?v=1731603371';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19650';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19650_packaging_front_US.png?v=1731603351';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19652';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19652_image1.png?v=1731603321';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8466';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8466.jpg?v=1731600223';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8463';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8466-2.jpg?v=1731600223';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8460';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8466-3.jpg?v=1731600223';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10683';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10683.jpg?v=1731604567';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20066';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20066.jpg?v=1731601507';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1140';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1140.jpg?v=1731602178';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20092';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20093.jpg?v=1731601492';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20093';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20092.jpg?v=1731601492';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20090';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20091.jpg?v=1731601492';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20091';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20090.jpg?v=1731601492';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14012';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14013.jpg?v=1731604088';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14013';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14012.jpg?v=1731604088';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14011';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14011.jpg?v=1731604088';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16321';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16321_product-1536x1536.jpg?v=1731666668';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16121';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16420.jpg?v=1731601699';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16420';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16021_product-1536x1536.jpg?v=1731666667';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16021';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16121_product-1536x1536.jpg?v=1731666668';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16221';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16221_product-1536x1536.jpg?v=1731666668';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A6592';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A6593.jpg?v=1731600335';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A6593';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a6593-2.jpg?v=1731600335';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A19085';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A19085.jpg?v=1731601657';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20354';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20354.jpg?v=1731600999';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1344';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1344.jpg?v=1731602119';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20154';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20154.jpg?v=1731601343';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20288';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20288.jpg?v=1731601051';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A13883';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A13883.jpg?v=1731602002';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A13880';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A13880.jpg?v=1731602003';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A188';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a189.jpg?v=1731601668';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A189';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a188.jpg?v=1731601668';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A187';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a187-2.jpg?v=1731601667';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10682';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10682.jpg?v=1731604576';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20148';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20148.jpg?v=1731601370';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20169';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20169.jpg?v=1731601325';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20149';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20149.jpg?v=1731601364';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20109';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20109.jpg?v=1731601462';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20253';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20253.jpg?v=1731601120';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16002';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16002_image1-1536x1536.jpg?v=1731637595';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20062';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20062.jpg?v=1731601527';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20237';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20237.jpg?v=1731601151';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20007';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20007.jpg?v=1731601637';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14325';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14325-2.jpg?v=1734094775';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14324';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14325.jpg?v=1734094775';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A370';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a370-2.png?v=1731600695';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20423';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20421.jpg?v=1734499492';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20424';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20422.jpg?v=1734499492';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A373';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A373.jpg?v=1731600686';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A372';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a373-2.jpg?v=1731600686';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20261';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20264.jpg?v=1731601081';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20264';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a20264-3.jpg?v=1731601081';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20259';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20261.jpg?v=1731601081';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A261';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a261.jpg?v=1731600788';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A260';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a261-2.jpg?v=1731600788';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19628';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19628_packaging_front_INT.png?v=1731603528';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19627';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19628_image1.png?v=1731603528';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19626';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19628_image2.png?v=1731603528';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20243';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20243.jpg?v=1731601132';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20230';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20230.jpg?v=1731601188';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20065';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20065.jpg?v=1731601513';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A13950';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A13950.jpg?v=1731601984';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '11065';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/11066.jpg?v=1731604432';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '11066';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/11066-2.jpg?v=1731604432';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1424';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1424.jpg?v=1731601972';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10942';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10942.jpg?v=1731604522';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10943';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10943.jpg?v=1731604522';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A13879';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A13879.jpg?v=1731602008';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A13255';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A13246-LED-Lamp-Strip-for-Shaker-Aquarium_c6359245-b0f0-426a-aea2-0073ac0427ba.jpg?v=1731637979';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20012';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20012.jpg?v=1731601618';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A15041';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A15041.jpg?v=1731601748';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20061';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20061_product-1.jpg?v=1731650546';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8478';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8478.jpg?v=1731600204';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8476';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a8478-2.jpg?v=1731600204';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8477';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8478-3.jpg?v=1731600204';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20430';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20438.jpg?v=1731600943';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20431';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20437.jpg?v=1731600943';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20432';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20436.jpg?v=1731600943';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20433';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20433.jpg?v=1731600943';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20438';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a20433-2.png?v=1731600943';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20436';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a20433-3.png?v=1731600944';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20437';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20432.jpg?v=1731600943';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20342';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20348.jpg?v=1731601020';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20344';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20346.jpg?v=1731601020';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20346';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20344.jpg?v=1731601020';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20348';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20342.jpg?v=1731601020';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10532';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10532.jpg?v=1731604600';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20251';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20251.jpg?v=1731601126';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20371';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20372.jpg?v=1731600969';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20372';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a20372-2.jpg?v=1731600969';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20370';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20371.jpg?v=1731600969';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1389';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1389.jpg?v=1731601996';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14654';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14654.jpg?v=1731601904';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20260';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20260.jpg?v=1731601088';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A419';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A420.jpg?v=1731600674';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A420';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A419.jpg?v=1731600674';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14677';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14677.jpg?v=1731601871';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A421';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A421.jpg?v=1731600667';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16316';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16415.jpg?v=1731601705';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16415';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16014_image1-1536x1536.jpg?v=1731650119';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16014';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16014_product-1536x1536.jpg?v=1731650119';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20219';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20219.jpg?v=1731601220';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20226';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20227.jpg?v=1731601201';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20227';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20226.jpg?v=1731601202';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A219';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A219.jpg?v=1731600909';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A214';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A219-2.jpg?v=1731600909';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A213';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A219-3.jpg?v=1731600909';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20053';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20053.jpg?v=1731601551';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20033';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20033.jpg?v=1731601577';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20338';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20340.jpg?v=1731601028';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20340';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20338.jpg?v=1731601028';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A492';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A490-2.jpg?v=1731600571';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A490';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A492.jpg?v=1731600570';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A491';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A492-2.jpg?v=1731600571';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19676';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19676_packaging_US-1536x1536.jpg?v=1731603281';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19672';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19676_product-1536x1536.jpg?v=1731603281';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19674';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19674_packaging_US-1536x1536.jpg?v=1731603281';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19670';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19674_product-1536x1536.jpg?v=1731603281';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14689';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a14701.jpg?v=1731601803';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14685';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14689.jpg?v=1731601844';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14701';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14685.jpg?v=1731601859';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20122';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20122.jpg?v=1731601409';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A455';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A455-2.jpg?v=1731600626';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A13944';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A13944.jpg?v=1731601990';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A248';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A248.jpg?v=1731600825';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A246';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A248-2.jpg?v=1731600825';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20021';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20021.jpg?v=1731601588';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20254';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20254.jpg?v=1731601114';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1459';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a1459.jpg?v=1731601933';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14658';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14658.jpg?v=1731601898';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14657';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14657.jpg?v=1731601898';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A234';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a234.jpg?v=1731600863';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14017';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14019.jpg?v=1731604070';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14018';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14018.jpg?v=1731604070';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14019';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14017.jpg?v=1731604070';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20201';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20202.jpg?v=1731601290';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20202';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20201.jpg?v=1731601290';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20217';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20217_product-scaled-1-1536x1536.jpg?v=1731609195';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14023';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14024.jpg?v=1731604053';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14024';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14023.jpg?v=1731604053';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20208';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20208.jpg?v=1731601263';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20206';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20206.jpg?v=1731601277';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '12693';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/12695.jpg?v=1731604206';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '12694';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/12694.jpg?v=1731604206';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '12695';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/12693.jpg?v=1731604206';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20212';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20212.jpg?v=1731601244';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A13871';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A13871.jpg?v=1731602035';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A13870';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A13870.jpg?v=1731602036';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16141';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16440.jpg?v=1731601692';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20352';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20352.jpg?v=1731601005';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20016';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20017.jpg?v=1731601601';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20017';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20016.jpg?v=1731601601';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20228';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20228.jpg?v=1731601194';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14761';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14761.jpg?v=1731601790';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '11195';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/11195.jpg?v=1731604337';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20427';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20427.jpg?v=1731600953';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20425';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20426.jpg?v=1731600953';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20426';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20425.jpg?v=1731600953';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A15101';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A15101.jpg?v=1731601742';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18388';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18389.jpg?v=1731603718';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18389';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18389-2.jpg?v=1731603718';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18386';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18389-3.jpg?v=1731603718';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18387';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18389-4.jpg?v=1731603718';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18395';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18388.jpg?v=1731603718';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18394';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18388-2.jpg?v=1731603718';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20126';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a20126.jpg?v=1731601397';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A244';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A242.jpg?v=1731600834';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A242';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a244-2.jpg?v=1731600834';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A449';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/fluval-serie-07-filtro-externo_1.jpg?v=1731577667';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A446';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/fluval-serie-07-filtro-externo_2.jpg?v=1731577667';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A443';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/fluval-serie-07-filtro-externo_3.jpg?v=1731577667';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A440';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/fluval-serie-07-filtro-externo.jpg?v=1731577641';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A13246';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A13246-LED-Lamp-Strip-for-Shaker-Aquarium.jpg?v=1731637817';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20173';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20173.jpg?v=1731601312';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20153';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20153.jpg?v=1731601350';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20112';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20112.jpg?v=1731601448';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8457';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8457.jpg?v=1731600234';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '11083';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/11084.jpg?v=1731604423';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '11084';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/11084-2.jpg?v=1731604423';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20052';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20052.jpg?v=1731601558';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20051';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20051.jpg?v=1731601558';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A258';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a258.jpg?v=1731600807';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A257';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a258-2.jpg?v=1731600807';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A198';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A198_packaging-scaled-1-1024x1024-1.webp?v=1731604037';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14693';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14700.jpg?v=1731601809';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14700';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14693.jpg?v=1731601829';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8366';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8366.jpg?v=1731600247';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20366';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20366.jpg?v=1731600976';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20364';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20364.jpg?v=1731600981';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19653';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19653_packaging_front_INT.png?v=1731603311';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19651';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19653_image1.png?v=1731603312';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14881';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14884.jpg?v=1731603864';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14882';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14883.jpg?v=1731603865';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14880';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14882.jpg?v=1731603864';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14883';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14881.jpg?v=1731603865';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14884';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14880.jpg?v=1731603865';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '11198';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/11198.jpg?v=1731604330';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A487';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A486-2.jpg?v=1734501960';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A488';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A499.jpg?v=1734501960';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A485';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A488.jpg?v=1734501960';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A486';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A488-2.jpg?v=1734501960';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1490';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1490.jpg?v=1731601754';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '12696';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/12698__Bio_Stratum.jpg?v=1733916136';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '12697';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/12697.jpg?v=1731604197';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '12698';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/12696.jpg?v=1731604197';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20216';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20216.jpg?v=1731601226';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14995';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14995.jpg?v=1731603829';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20362';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20362.jpg?v=1731600987';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20360';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20360.jpg?v=1731600993';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A233';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a233.jpg?v=1731600869';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8367';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8367.jpg?v=1731600241';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20298';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20299.jpg?v=1731601044';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20299';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20298.jpg?v=1731601045';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20297';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20297.jpg?v=1731601044';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20350';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20350.jpg?v=1731601011';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A6577';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A6577.jpg?v=1731600406';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14541';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14541.jpg?v=1731603915';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14517';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14541-2.png?v=1731603915';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14515';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14541-3.png?v=1731603915';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14516';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14541-4.jpg?v=1731603915';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14020';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14020.jpg?v=1731604061';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14021';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14022.jpg?v=1731604061';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14022';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14021.jpg?v=1731604062';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20096';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20097.jpg?v=1731601482';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20097';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20096.jpg?v=1731601483';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20094';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20095.jpg?v=1731601482';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20095';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20094.jpg?v=1731601482';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '11061';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/11063_EasyVAC.jpg?v=1733916079';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '11060';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/11063-2.jpg?v=1731604445';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '11063';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/11062.jpg?v=1731604446';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '11062';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/11062-2.jpg?v=1731604445';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19632';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19634_packaging_front_INT.png?v=1731603449';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19634';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19634_image1.png?v=1731603449';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19630';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19634_image2.png?v=1731603449';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20320';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20320.jpg?v=1731601036';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20318';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20318.jpg?v=1731601036';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20316';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20316.jpg?v=1731601036';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20241';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20242.jpg?v=1731601139';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20242';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20241.jpg?v=1731601139';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10680';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10680.jpg?v=1731604594';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A13877';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A13878.jpg?v=1731602015';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A13878';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A13877.jpg?v=1731602015';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '11096';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/11096.jpg?v=1731604394';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '11095';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/11095.jpg?v=1731604394';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14994';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14994.jpg?v=1731603838';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1480';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1480.jpg?v=1731601760';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A495';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A495-2.jpg?v=1731600559';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A6578';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a6579.jpg?v=1731600398';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A6579';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a6579-2.jpg?v=1731600398';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14486';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14486.jpg?v=1731604019';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14010';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14010.jpg?v=1731604097';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14009';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14009.jpg?v=1731604097';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14008';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14008.jpg?v=1731604097';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20274';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20276.jpg?v=1731601059';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20275';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20275.jpg?v=1731601059';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20276';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20274.jpg?v=1731601059';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20059';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20059.jpg?v=1731601544';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20215';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20215.jpg?v=1731601232';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18454';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18457.jpg?v=1731603692';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18456';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18457-2.jpg?v=1731603692';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18457';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18457-3.jpg?v=1731603692';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18450';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18456.jpg?v=1731603692';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18451';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18456-2.jpg?v=1731603692';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '18453';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/18456-3.jpg?v=1731603692';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1448';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1448.jpg?v=1731601954';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1440';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a1448-2.jpg?v=1731601955';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1447';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1447.jpg?v=1731601955';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A249';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A249.jpg?v=1731600815';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19642';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19646_packaging_front_INT.png?v=1731603361';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19644';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19646_image1.png?v=1731603361';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '19646';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/19646_image2.png?v=1731603361';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14360';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14360.jpg?v=1731604026';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20014';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20015.jpg?v=1731601611';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20015';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20015-2.jpg?v=1731601611';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A6581';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A6580.jpg?v=1731600385';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A6580';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a6581.jpg?v=1731600385';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8359';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8360.jpg?v=1731600255';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A8360';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A8359.jpg?v=1731600255';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14539';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14539.jpg?v=1731603931';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14522';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14539-2.png?v=1731603934';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14523';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14539-3.png?v=1731603937';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '14521';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/14539-4.png?v=1731603940';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20239';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20239.jpg?v=1731601145';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20265';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20267.jpg?v=1731601070';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20266';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20266.jpg?v=1731601070';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20267';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20265.jpg?v=1731601070';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10528';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10531.jpg?v=1731604613';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10531';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10531-2.jpg?v=1731604613';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20199';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20199_product.jpg?v=1731648991';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20155';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20155.jpg?v=1731601337';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A20039';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A20039.jpg?v=1731601564';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '15894';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/15899.jpg?v=1731603768';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '15899';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/15894.jpg?v=1731603768';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A1387';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A1387.jpg?v=1731602042';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '10786';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/10786.jpg?v=1731604552';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A199';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/a199.jpg?v=1731601651';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A787';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A787.jpg?v=1731600302';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A784';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A787-2.jpg?v=1731600302';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A782';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A784.jpg?v=1731600303';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A783';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A784-2.jpg?v=1731600302';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A781';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A783.jpg?v=1731600302';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A13872';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A13872.jpg?v=1731602028';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16352';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16052_product-1536x1536.jpg?v=1731644294';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A16052';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A16352_product-1536x1536.jpg?v=1731644332';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '15035';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/15035.jpg?v=1731603807';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '15034';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/15034.jpg?v=1731603806';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '15039';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/15039.jpg?v=1731603799';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := '15038';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/15038.jpg?v=1731603799';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A14764';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A14764.jpg?v=1731601778';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A13873';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A13874.jpg?v=1731602023';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        codprod := 'A13874';
                        url := 'https://cdn.shopify.com/s/files/1/0658/5450/5149/files/A13873.jpg?v=1731602023';
                        Rec1.get(codprod);
                        Rec1."URL IMAGEN 1" := url;PictureURL:=url;Client.Get(PictureURL, Response);Response.Content.ReadAs(InStr);Clear(Rec1.Picture);Rec1.Picture.ImportStream(InStr, Format(Rec1."No.")); 
                        rec1.Modify;commit;
                        
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

        PictureURL:=url;
        Client.Get(PictureURL, Response);                         
        Response.Content.ReadAs(InStr);
        Clear(Rec1.Picture);                        
        Rec1.Picture.ImportStream(InStr, Format(Rec1."No."));                                                 
        Message('%1',rec1."No.");

        

    end;



}

