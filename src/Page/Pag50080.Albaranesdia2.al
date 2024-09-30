#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50080 "Albaranes dia-2"
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
                        Rec.ShowDimensions;
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
                        Rec.StartTrackingSite;
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
                                /////- AutomaticosAdaia.ETISTD(Rec110);
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




                    /////- Clear(OKAlbaranValoradoECI);
                    Rec110.Reset;
                    Rec110.SetRange(Rec110."No.", Rec."No.");
                    if Rec110.FindFirst then begin
                        /////- OKAlbaranValoradoECI.SetTableview(Rec110);
                        /////- OKAlbaranValoradoECI.Run;
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



                    /////- Clear(OKAlbaranNOvalorado);

                    Rec110.Reset;
                    Rec110.SetRange(Rec110."No.", Rec."No.");
                    if Rec110.FindFirst then begin
                        /////- OKAlbaranNOvalorado.SetTableview(Rec110);
                        /////- OKAlbaranNOvalorado.Run;
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


                    /////- Clear(OKAlbaranValorado);



                    Rec110.Reset;
                    Rec110.SetRange(Rec110."No.", Rec."No.");
                    if Rec110.FindFirst then begin
                        /////- OKAlbaranValorado.SetTableview(Rec110);
                        /////- OKAlbaranValorado.Run;
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




                    if RecTra.Get(Rec."Shipping Agent Code") then begin
                        if RecTra."Link transporte" = '' then begin
                            if Rec."Shipping Agent Code" = 'DHL' then begin
                                paginaweb := 'http://www.dhl.es/services_es/seg_3dd/integra/SeguimientoDocumentos.aspx?codigo=' +
                                Format(Rec."Nº expedición") + '&anno=2012&lang=sp&refCli=1';
                                Hyperlink(paginaweb);
                            end;
                            if Rec."Shipping Agent Code" = 'TNT' then begin
                                paginaweb := 'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=' +
                                'REF&respLang=ES&respCountry=ES&sourceID=1&sourceCountry=' +
                                'ES&sourceID=1&sourceCountry=ww&cons=' +
                                Format(Rec."Nº expedición");
                                Hyperlink(paginaweb);
                            end;
                            if Rec."Shipping Agent Code" = 'CRON' then begin
                                paginaweb := 'http://www.chronoexpres.com/chronoExtraNET/env/verEnvio.seam?usuario=f4429f061740b2' +
                                'a5528f4aa361d36dac&tipo=&valor=' + Format(Rec."Nº expedición") + '&cp=' + Format(Rec."Ship-to Post Code");
                                /////            HYPERLINK(paginaweb);
                                /////     'a5528f4aa361d36dac&tipo=referencia&valor='+FORMAT("Nº expedición")+'&cp='+FORMAT("Ship-to Post Code");
                                paginaweb := 'https://www.correosexpress.com/url/v?s=' + Format(Rec."Nº expedición") + '&cp=' + Format(Rec."Ship-to Post Code");
                                Hyperlink(paginaweb);
                            end;
                            if Rec."Shipping Agent Code" = 'CORR' then begin
                                paginaweb := 'http://www.correos.es/ss/Satellite/site/pagina-localizador_envios/busqueda-sidioma=es_ES?numero=' +
                                Format(Rec."Nº expedición");
                                Hyperlink(paginaweb);
                            end;
                            if COMPANYNAME <> 'PEPE' then begin
                                if Rec."Shipping Agent Code" = 'TIPSA' then begin
                                    paginaweb := 'http://www.tip-sa.com/cliente/datos.php?id=04600400393' + Format(Rec."Nº expedición") +
                                    Format(Rec."Your Reference") + Format(Rec."Ship-to Post Code");
                                    Hyperlink(paginaweb);
                                end;
                            end;
                            if COMPANYNAME = 'PEPE' then begin
                                if Rec."Shipping Agent Code" = 'TIPSA' then begin
                                    paginaweb := 'http://www.tip-sa.com/cliente/datos.php?id=04600400393' + Format(Rec."Nº expedición") + ' - ' +
                                    Format(Rec."Your Reference") + ' - ' +
                                    Format(Rec."Order No.") +
                                    Format(Rec."Ship-to Post Code");
                                    paginaweb := 'http://www.tip-sa.com/cliente/datos.php?id=04600400393' + Format(Rec."Nº expedición") +
                                    Format(Rec."Your Reference") + Format(Rec."Ship-to Post Code");
                                    Hyperlink(paginaweb);
                                end;
                            end;
                            if COMPANYNAME = 'PEPE' then begin
                                if Rec."Shipping Agent Code" = 'TNT' then begin
                                    paginaweb :=
                                      'http://webtracker.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=REF&respLang=' +
                                       'ES&respCountry=ES&sourceID=1&sourceCountry=' +
                                     'ES&sourceID=1&sourceCountry=ww&cons=' + Format(Rec."Nº expedición");
                                    Hyperlink(paginaweb);
                                end;
                            end;
                        end;
                        if RecTra."Link transporte" <> '' then begin
                            paginaweb := RecTra."Link transporte";
                            if RecTra.Añadir = 0 then paginaweb := paginaweb + Format(Rec."Nº expedición");
                            if RecTra.Añadir = 1 then
                                paginaweb := paginaweb + Format(Rec."Nº expedición") +
        Format(Rec."Ship-to Post Code");
                            if RecTra.Añadir = 2 then
                                paginaweb := paginaweb + Format(Rec."Nº expedición") + '/' +
        Format(Rec."Ship-to Post Code");

                            Hyperlink(paginaweb);

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


                    /////- Clear(OKAlbaranValoradoCANARIAS);
                    Rec110.Reset;
                    Rec110.SetRange(Rec110."No.", Rec."No.");
                    if Rec110.FindFirst then begin
                        /////- OKAlbaranValoradoCANARIAS.SetTableview(Rec110);
                        /////- OKAlbaranValoradoCANARIAS.Run;
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
                /////- RunObject = Report UnknownReport50109;
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
                /////- RunObject = Report UnknownReport50119;
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


                    /////- Clear(CrearCajasAMAZON);
                    /////- CrearCajasAMAZON.envio(Rec."Nº expedición");
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
        /////- AutomaticosAdaia: Codeunit UnknownCodeunit50010;
        /////- REP50030: Report UnknownReport50030;
        /////- OKAlbaranValoradoECI: Report UnknownReport50905;
        /////- OKAlbaranValorado: Report UnknownReport50901;
        /////- OKAlbaranNOvalorado: Report UnknownReport50902;
        paginaweb: Text[500];
        /////- OKAlbaranValoradoCANARIAS: Report UnknownReport50908;
        RecCA: Record "Cajas AMAZON";
        PCajasAMAZON: Page "Cajas AMAZON";
        /////- CrearCajasAMAZON: Codeunit UnknownCodeunit50057;
        ClienteItemUnitofMeasure: Record "Clientes Item Unit of Measure";
        SalesShipmentHeader3: Record "Sales Shipment Header";
        Modificaalbaran: Page "Modifica albaran";
}

