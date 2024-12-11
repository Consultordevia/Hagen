#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50102 "Albaranes dia-3"
{
    Caption = 'Posted Sales Shipments';
    CardPageID = "Posted Sales Shipment";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sales Shipment Header";
    SourceTableView = sorting("Posting Date")
                      order(descending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Nº expedición"; Rec."Nº expedición")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the shipment number.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ApplicationArea = Basic;
                }
                field("Albaran sin detalle"; Rec."Albaran sin detalle")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Advanced;
                    Editable = false;
                    ToolTip = 'Specifies the number of the customer the items were shipped to.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the name of the customer that you shipped the items in the shipment to.';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = Basic;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the name of the person to contact at the customer that the items were sold to.';
                    Visible = false;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = Advanced;
                    Editable = false;
                    ToolTip = 'Specifies the number of the customer that you send or sent the invoice or credit memo to.';
                    Visible = false;
                }
                field("Nº bultos"; Rec."Nº bultos")
                {
                    ApplicationArea = Basic;
                }
                field("Nº Palets"; Rec."Nº Palets")
                {
                    ApplicationArea = Basic;
                }
                field(Preparador; Rec.Preparador)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total bultos"; Rec."Total bultos")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = Basic;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field("Nº expedición dropshp"; Rec."Nº expedición dropshp")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {

        }
    }

    actions
    {
        area(navigation)
        {
            group("&Shipment")
            {
                Caption = '&Shipment';
                Image = Shipment;
                action(Statistics)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Shipment Statistics";
                    RunPageLink = "No." = field("No.");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                }
                action("Co&mments")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = const(Shipment),
                                  "No." = field("No.");
                    ToolTip = 'View or add comments for the record.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        /////-ShowDimensions;
                    end;
                }
                action(CertificateOfSupplyDetails)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Certificate of Supply Details';
                    Image = Certificate;
                    RunObject = Page "Certificates of Supply";
                    RunPageLink = "Document Type" = filter("Sales Shipment"),
                                  "Document No." = field("No.");
                    ToolTip = 'View the certificate of supply that you must send to your customer for signature as confirmation of receipt. You must print a certificate of supply if the shipment uses a combination of VAT business posting group and VAT product posting group that have been marked to require a certificate of supply in the VAT Posting Setup window.';
                }
                action(PrintCertificateofSupply)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Print Certificate of Supply';
                    Image = PrintReport;
                    Promoted = false;
                    ToolTip = 'Print the certificate of supply that you must send to your customer for signature as confirmation of receipt.';

                    trigger OnAction()
                    var
                        CertificateOfSupply: Record "Certificate of Supply";
                    begin
                        CertificateOfSupply.SetRange("Document Type", CertificateOfSupply."document type"::"Sales Shipment");
                        CertificateOfSupply.SetRange("Document No.", Rec."No.");
                        CertificateOfSupply.Print;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("&Track Package")
                {
                    ApplicationArea = Advanced;
                    Caption = '&Track Package';
                    Image = ItemTracking;
                    ToolTip = 'Open the shipping agent''s tracking page to track the package. ';

                    trigger OnAction()
                    begin
                        /////-StartTrackingSite;
                    end;
                }
            }
            action("&Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                Visible = not IsOfficeAddin;

                trigger OnAction()
                var
                    SalesShptHeader: Record "Sales Shipment Header";
                begin
                    CurrPage.SetSelectionFilter(SalesShptHeader);
                    SalesShptHeader.PrintRecords(true);
                end;
            }
            action("&Navigate")
            {
                ApplicationArea = Advanced;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
                Visible = not IsOfficeAddin;

                trigger OnAction()
                begin
                    Rec.Navigate;
                end;
            }
            action("Envia doc. transportista")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Shipment;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin



                    if RecTra.Get(Rec."Shipping Agent Code") then begin
                        if RecTra."Fichero estandar" = true then begin
                            Rec110.Reset;
                            Rec110.SetRange(Rec110."No.", Rec."No.");
                            if Rec110.FindFirst then begin
                                AutomaticosAdaia.ETISTD(Rec110);
                            end;
                        end;
                    end;
                end;
            }
            action("Imprimir ECI")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin




                    /////-Clear(OKAlbaranValoradoECI);
                    Rec110.Reset;
                    Rec110.SetRange(Rec110."No.", Rec."No.");
                    if Rec110.FindFirst then begin
                        /////-OKAlbaranValoradoECI.SetTableview(Rec110);
                        /////-OKAlbaranValoradoECI.Run;
                    end;
                end;
            }
            action("Imprimir sin Valorar")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin



                    Clear(OKAlbaranNOvalorado);

                    Rec110.Reset;
                    Rec110.SetRange(Rec110."No.", Rec."No.");
                    if Rec110.FindFirst then begin
                        OKAlbaranNOvalorado.SetTableview(Rec110);
                        OKAlbaranNOvalorado.Run;
                    end;

                    if RecTra.Get(Rec."Shipping Agent Code") then begin
                        if RecTra."Fichero estandar" = true then begin
                            Rec110.Reset;
                            Rec110.SetRange(Rec110."No.", Rec."No.");
                            if Rec110.FindFirst then begin
                                AutomaticosAdaia.ETISTD(Rec110);
                            end;
                        end;
                    end;
                end;
            }
            action("Imprimir Valorado")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin


                    Clear(OKAlbaranValorado);
                    Rec110.Reset;
                    Rec110.SetRange(Rec110."No.", Rec."No.");
                    if Rec110.FindFirst then begin
                       OKAlbaranValorado.SetTableview(Rec110);
                        OKAlbaranValorado.Run;
                    end;

                    if RecTra.Get(Rec."Shipping Agent Code") then begin
                        if RecTra."Fichero estandar" = true then begin
                            Rec110.Reset;
                            Rec110.SetRange(Rec110."No.", Rec."No.");
                            if Rec110.FindFirst then begin
                                AutomaticosAdaia.ETISTD(Rec110);
                            end;
                        end;
                    end;
                end;
            }
            action("Ver transporte")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Travel;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin


                    /*
                    
                    
                    codigopostal:=FORMAT("Ship-to Post Code");
                    IF "Bill-to Country/Region Code"='PT' THEN BEGIN
                        codigopostal:=COPYSTR(codigopostal,1,4)+'-'+COPYSTR(codigopostal,6);
                    END;
                    
                    IF Rec."Shipping Agent Code"='GLSP' THEN BEGIN
                        codigopostal:=COPYSTR(codigopostal,1,4)+'-'+COPYSTR(codigopostal,6);
                    END;
                    
                    
                    
                    
                    
                    
                    
                    IF RecTra.GET("Shipping Agent Code") THEN BEGIN
                         IF RecTra."Link transporte"='' THEN BEGIN
                              IF "Shipping Agent Code"='DHL' THEN BEGIN
                       ////           paginaweb:='https://clientesparcel.dhl.es/seguimientoenvios/integra/SeguimientoDocumentos.aspx?codigo'+
                                   ///FORMAT("Nº expedición")+'&anno='+FORMAT(DATE2DMY(WORKDATE,3))+'&lang=sp&refCli=1&cuenta=4855&agencia=46';
                                   ///HYPERLINK(paginaweb);
                    
                    
                              END;
                              IF "Shipping Agent Code"='TNT' THEN BEGIN
                                    paginaweb:='http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType='+
                                    'REF&respLang=ES&respCountry=ES&sourceID=1&sourceCountry='+
                                    'ES&sourceID=1&sourceCountry=ww&cons='+
                                    FORMAT("Nº expedición");
                                    HYPERLINK(paginaweb);
                               END;
                               IF "Shipping Agent Code"='CRON' THEN BEGIN
                                   paginaweb:='http://www.chronoexpres.com/chronoExtraNET/env/verEnvio.seam?usuario=f4429f061740b2'+
                                   'a5528f4aa361d36dac&tipo=&valor='+FORMAT("Nº expedición")+'&cp='+FORMAT("Ship-to Post Code");
                      /////            HYPERLINK(paginaweb);
                         /////     'a5528f4aa361d36dac&tipo=referencia&valor='+FORMAT("Nº expedición")+'&cp='+FORMAT("Ship-to Post Code");
                                        paginaweb:='https://www.correosexpress.com/url/v?s='+FORMAT("Nº expedición")+'&cp='+FORMAT("Ship-to Post Code");
                                   HYPERLINK(paginaweb);
                                END;
                                IF "Shipping Agent Code"='CORR' THEN BEGIN
                                     paginaweb:='http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero='+
                                     FORMAT("Nº expedición");
                                     HYPERLINK(paginaweb);
                                END;
                                IF COMPANYNAME<>'PEPE' THEN BEGIN
                                     IF "Shipping Agent Code"='TIPSA' THEN BEGIN
                                          paginaweb:='http://www.tip-sa.com/cliente/datos.php?id=04600400393'+FORMAT("Nº expedición")+
                                          FORMAT("Your Reference")+FORMAT("Ship-to Post Code");
                                          HYPERLINK(paginaweb);
                                     END;
                                END;
                                IF COMPANYNAME='PEPE' THEN BEGIN
                                     IF "Shipping Agent Code"='TIPSA' THEN BEGIN
                                          paginaweb:='http://www.tip-sa.com/cliente/datos.php?id=04600400393'+FORMAT("Nº expedición")+' - '+
                                          FORMAT("Your Reference")+' - '+
                                          FORMAT("Order No.")+
                                          FORMAT("Ship-to Post Code");
                                          paginaweb:='http://www.tip-sa.com/cliente/datos.php?id=04600400393'+FORMAT("Nº expedición")+
                                          FORMAT("Your Reference")+FORMAT("Ship-to Post Code");
                                          HYPERLINK(paginaweb);
                                     END;
                                END;
                                IF COMPANYNAME='PEPE' THEN BEGIN
                                      IF "Shipping Agent Code"='TNT' THEN BEGIN
                                           paginaweb:=
                                             'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=REF&respLang='+
                                              'ES&respCountry=ES&sourceID=1&sourceCountry='+
                                            'ES&sourceID=1&sourceCountry=ww&cons='+FORMAT("Nº expedición");
                                              HYPERLINK(paginaweb);
                                   END;
                              END;
                         END;
                         IF RecTra."Link transporte"<>'' THEN BEGIN
                              paginaweb:=RecTra."Link transporte";
                              IF RecTra.Añadir=0 THEN paginaweb:=paginaweb+FORMAT("Nº expedición");
                              IF RecTra.Añadir=1 THEN paginaweb:=paginaweb+FORMAT("Nº expedición")+
                              FORMAT("Ship-to Post Code");
                              IF RecTra.Añadir=2 THEN paginaweb:=paginaweb+FORMAT("Nº expedición")+'/'+
                              FORMAT("Ship-to Post Code");
                              IF RecTra.Añadir=3 THEN BEGIN
                                    paginaweb:='https://clientesparcel.dhl.es/seguimientoenvios/integra/SeguimientoDocumentos.aspx?codigo='+
                                   FORMAT("Nº expedición")+'&anno='+FORMAT(DATE2DMY(WORKDATE,3))+'&lang=sp&refCli=1&cuenta=4855&agencia=46';
                                IF "Nº expedición dropshp"<>'' THEN BEGIN
                                      paginaweb:='https://clientesparcel.dhl.es/seguimientoenvios/integra/SeguimientoDocumentos.aspx?codigo='+
                                   FORMAT("Nº expedición dropshp")+'&anno='+FORMAT(DATE2DMY(WORKDATE,3))+'&lang=sp&refCli=1&cuenta=4855&agencia=46';
                    
                               END;
                    
                    
                              END;
                    
                    
                    
                    
                              HYPERLINK(paginaweb);
                    
                         END;
                    END;
                    
                    */

                    codexpe := Rec."Nº expedición";
                    if Rec."Nº expedición dropshp" <> '' then begin
                        codexpe := Rec."Nº expedición dropshp";
                    end;
                    if Rec.ASN <> '' then begin
                        codexpe := Rec.ASN;
                    end;



                    codigopostal := Format(Rec."Ship-to Post Code");
                    if Rec."Bill-to Country/Region Code" = 'PT' then begin
                        codigopostal := CopyStr(codigopostal, 1, 4) + '-' + CopyStr(codigopostal, 6);
                    end;

                    if Rec."Shipping Agent Code" = 'GLSP' then begin
                        codigopostal := CopyStr(codigopostal, 1, 4) + '-' + CopyStr(codigopostal, 6);
                    end;

                    if RecTra.Get(Rec."Shipping Agent Code") then begin
                        if RecTra."Link transporte" = '' then begin
                            if Rec."Shipping Agent Code" = 'DHL' then begin
                                paginaweb := 'http://www.dhl.es/services_es/seg_3dd/integra/SeguimientoDocumentos.aspx?codigo=' +
                                Format(codexpe) + '&anno=2012&lang=sp&refCli=1';
                                Hyperlink(paginaweb);
                            end;
                            if Rec."Shipping Agent Code" = 'TNT' then begin
                                paginaweb := 'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=' +
                                'REF&respLang=ES&respCountry=ES&sourceID=1&sourceCountry=' +
                                'ES&sourceID=1&sourceCountry=ww&cons=' +
                                Format(codexpe);
                                Hyperlink(paginaweb);
                            end;
                            if Rec."Shipping Agent Code" = 'CRON' then begin
                                paginaweb := 'http://www.chronoexpres.com/chronoExtraNET/env/verEnvio.seam?usuario=f4429f061740b2' +
                                'a5528f4aa361d36dac&tipo=&valor=' + Format(codexpe) + '&cp=' + Format(codigopostal);
                                /////            HYPERLINK(paginaweb);
                                /////     'a5528f4aa361d36dac&tipo=referencia&valor='+FORMAT("Nº expedición")+'&cp='+FORMAT("Ship-to Post Code");
                                paginaweb := 'https://www.correosexpress.com/url/v?s=' + Format(codexpe) + '&cp=' + Format(Rec."Ship-to Post Code");
                                Hyperlink(paginaweb);
                            end;
                            if Rec."Shipping Agent Code" = 'CORR' then begin
                                paginaweb := 'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                                Format(codexpe);
                                Hyperlink(paginaweb);
                            end;
                            if COMPANYNAME <> 'PEPE' then begin
                                if Rec."Shipping Agent Code" = 'TIPSA' then begin
                                    paginaweb := 'http://www.tip-sa.com/cliente/datos.php?id=04600400393' + Format(codexpe) +
                                    Format(Rec."Your Reference") + Format(codigopostal);
                                    Hyperlink(paginaweb);
                                end;
                            end;
                            if COMPANYNAME = 'PEPE' then begin
                                if Rec."Shipping Agent Code" = 'TIPSA' then begin
                                    paginaweb := 'http://www.tip-sa.com/cliente/datos.php?id=04600400393' + Format(codexpe) + ' - ' +
                                    Format(Rec."Your Reference") + ' - ' +
                                    Format(Rec."Order No.") +
                                    Format(codigopostal);
                                    paginaweb := 'http://www.tip-sa.com/cliente/datos.php?id=04600400393' + Format(codexpe) +
                                    Format(Rec."Your Reference") + Format(codigopostal);
                                    Hyperlink(paginaweb);
                                end;
                            end;
                            if COMPANYNAME = 'PEPE' then begin
                                if Rec."Shipping Agent Code" = 'TNT' then begin
                                    paginaweb :=
                                      'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=REF&respLang=' +
                                       'ES&respCountry=ES&sourceID=1&sourceCountry=' +
                                     'ES&sourceID=1&sourceCountry=ww&cons=' + Format(codexpe);
                                    Hyperlink(paginaweb);
                                end;
                            end;
                        end;
                        if RecTra."Link transporte" <> '' then begin
                            if RecTra.Code <> 'TXT' then begin
                                paginaweb := RecTra."Link transporte";
                                if RecTra.Añadir = 0 then paginaweb := paginaweb + Format(codexpe);
                                if RecTra.Añadir = 1 then
                                    paginaweb := paginaweb + Format(codexpe) +
            Format(Rec."Ship-to Post Code");
                                if RecTra.Añadir = 2 then
                                    paginaweb := paginaweb + Format(codexpe) + '/' +
            Format(codigopostal);

                                Hyperlink(paginaweb);
                            end;

                            if RecTra.Code = 'TXT' then begin
                                ANYO := Date2dmy(Rec."Posting Date", 3);
                                paginaweb := 'http://tracking.txt.es/?EXPED=@68381@fcyd0y4ui2n6emo@R@' + Format(codexpe) + '@' + Format(ANYO) + '@';
                                Hyperlink(paginaweb);
                            end;


                        end;
                    end;

                end;
            }
            action("Imprimir CANARIAS")
            {
                ApplicationArea = Basic;
                Caption = 'Imprimir CANARIAS';
                Ellipsis = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin


                    /////-Clear(OKAlbaranValoradoCANARIAS);
                    Rec110.Reset;
                    Rec110.SetRange(Rec110."No.", Rec."No.");
                    if Rec110.FindFirst then begin
                        /////-OKAlbaranValoradoCANARIAS.SetTableview(Rec110);
                        /////-OKAlbaranValoradoCANARIAS.Run;
                    end;
                end;
            }
            action("Cajas AMAZON")
            {
                ApplicationArea = Basic;
                Caption = 'Cajas AMAZON';
                Ellipsis = true;
                Image = Shipment;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin


                    RecCA.Reset;
                    RecCA.SetRange(RecCA."Nº Expedicion", Rec."Nº expedición");
                    Clear(PCajasAMAZON);
                    PCajasAMAZON.SetTableview(RecCA);
                    PCajasAMAZON.RunModal;
                end;
            }
            action("Informe AMAZON")
            {
                ApplicationArea = Basic;
                Caption = 'Informe AMAZON';
                Ellipsis = true;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report 50109;
            }
            action("FALTAS Informe AMAZON")
            {
                ApplicationArea = Basic;
                Caption = 'FALTAS Informe AMAZON';
                Ellipsis = true;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report 50119;
            }
            action("Excel AMAZON")
            {
                ApplicationArea = Basic;
                Caption = 'Excel AMAZON';
                Ellipsis = true;
                Image = Excel;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    /////-Clear(CrearCajasAMAZON);
                    /////-CrearCajasAMAZON.envio(Rec."Nº expedición");
                end;
            }
            action(ASN)
            {
                ApplicationArea = Basic;
                Caption = 'ASN';
                Ellipsis = true;
                Image = MoveUp;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    SalesShipmentHeader3.Reset;
                    SalesShipmentHeader3.SetRange(SalesShipmentHeader3."No.", Rec."No.");
                    if SalesShipmentHeader3.FindFirst then begin
                        Clear(Modificaalbaran);
                        Modificaalbaran.SetTableview(SalesShipmentHeader3);
                        Modificaalbaran.RunModal;
                    end;
                end;
            }
            action("Carta EL moscar")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    if RecTransp.Get(Rec."Shipping Agent Code") then begin
                        if RecTransp."Carta Tamaño A4" then begin
                            Rec110.SetCurrentkey(Rec110."Nº expedición");
                            Rec110.SetRange(Rec110."Nº expedición", Rec."Nº expedición");
                            if Rec110.FindSet then begin
                                /////- Clear(OKAlbaranElmosca);
                                /////- OKAlbaranElmosca.SetTableview(Rec110);
                                /////- OKAlbaranElmosca.RunModal;
                                Message('Hecho.');
                            end;
                        end;
                    end;
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

                    /////- Clear(Lineasalbaranexpedicion);
                    /////- Lineasalbaranexpedicion.Run;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        OfficeMgt: Codeunit "Office Management";
        HasFilters: Boolean;
    begin

        HasFilters := Rec.GetFilters <> '';
        Rec.SetSecurityFilterOnRespCenter;
        if HasFilters then
            if Rec.FindFirst then;
        IsOfficeAddin := OfficeMgt.IsAvailable;
    end;

    var
        IsOfficeAddin: Boolean;
        RecTra: Record "Shipping Agent";
        Rec110: Record "Sales Shipment Header";
        AutomaticosAdaia: Codeunit "Automaticos Cartas";
        /////- REP50030: Report UnknownReport50030;
        /////- OKAlbaranValoradoECI: Report UnknownReport50905;
        OKAlbaranValorado: Report 50901;
        OKAlbaranNOvalorado: Report 50902;
        paginaweb: Text[500];
        /////- OKAlbaranValoradoCANARIAS: Report UnknownReport50908;
        RecCA: Record "Cajas AMAZON";
        PCajasAMAZON: Page "Cajas AMAZON";
        ///CrearCajasAMAZON: Codeunit "Crear Cajas AMAZON";
        ClienteItemUnitofMeasure: Record "Clientes Item Unit of Measure";
        SalesShipmentHeader3: Record "Sales Shipment Header";
        Modificaalbaran: Page "Modifica albaran";
        RecTransp: Record "Shipping Agent";
        /////-OKAlbaranElmosca: Report 50917;
        codigopostal: Code[20];
        codexpe: Code[20];
        ANYO: Integer;
        Report50109: Report "Lineas Albaran AMAZON";
    /////- Lineasalbaranexpedicion: Report UnknownReport50230;
}

