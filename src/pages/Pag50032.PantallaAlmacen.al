#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50032 "Pantalla Almacen"
{
    Caption = 'Pantalla Almacen';
    CardPageID = "Sales Order";
    DataCaptionFields = "Sell-to Customer No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Request Approval,Order';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const(Order));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the sales document.';
                }
                field("Ampliacion del pedido nº"; Rec."Ampliacion del pedido nº")
                {
                    ApplicationArea = Basic;
                }
                field("Recibido de adaia"; Rec."Recibido de adaia")
                {
                    ApplicationArea = Basic;
                }
                field(PesoReal; PesoReal)
                {
                    ApplicationArea = Basic;
                    Caption = 'Peso Real';
                }
                field("No agrupar en ADAIA"; Rec."No agrupar en ADAIA")
                {
                    ApplicationArea = Basic;
                }
                field("Marcar para agrupar"; Rec."Marcar para agrupar")
                {
                    ApplicationArea = Basic;
                }
                field("Nº expedición"; Rec."Nº expedición")
                {
                    ApplicationArea = Basic;
                }
                field("Nº expedición agrupada"; Rec."Nº expedición agrupada")
                {
                    ApplicationArea = Basic;
                }
                field(Frecuenciavisitacomercial; Frecuenciavisitacomercial)
                {
                    ApplicationArea = Basic;
                }
                field("Multi-picking"; Rec."Multi-picking")
                {
                    ApplicationArea = Basic;
                }
                field(NombreComercial; NombreComercial)
                {
                    ApplicationArea = Basic;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = Basic;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic;
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ApplicationArea = Basic;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field("Observación para ALMACEN"; Rec."Observación para ALMACEN")
                {
                    ApplicationArea = Basic;
                }
                field(Commenta; Commenta)
                {
                    ApplicationArea = Basic;
                }
                field("Super urgente"; Rec."Super urgente")
                {
                    ApplicationArea = Basic;
                }
                field(Urgente; Rec.Urgente)
                {
                    ApplicationArea = Basic;
                }
                field(TLinea; TLinea)
                {
                    ApplicationArea = Basic;
                }
                field(Ship; Rec.Ship)
                {
                    ApplicationArea = Basic;
                }
                field(Invoice; Rec.Invoice)
                {
                    ApplicationArea = Basic;
                }
                field("Fecha alta"; Rec."Fecha alta")
                {
                    ApplicationArea = Basic;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the number of the customer who will receive the products and be billed by default.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the customer who will receive the products and be billed by default.';
                }
                field(Televendedor; Rec.Televendedor)
                {
                    ApplicationArea = Basic;
                }
                field(FiltroEci; FiltroEci)
                {
                    ApplicationArea = Basic;
                }
                field(Base; Base)
                {
                    ApplicationArea = Basic;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shipping No."; Rec."Shipping No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting No."; Rec."Posting No.")
                {
                    ApplicationArea = Basic;
                }
                field("Usuario para preparar"; Rec."Usuario para preparar")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha para preparar"; Rec."Fecha para preparar")
                {
                    ApplicationArea = Basic;
                }
                field("Hora para preparar"; Rec."Hora para preparar")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Country/Region Code"; Rec."VAT Country/Region Code")
                {
                    ApplicationArea = Basic;
                }

            }
        }
        area(factboxes)
        {
            /////-            part("Power BI Report FactBox";UnknownPage6306)
            /////-{
            /////-ApplicationArea = Basic,Suite;
            /////-Caption = 'Power BI Reports';
            /////-Visible = PowerBIVisible;
            /////-}
            part(Control1902018507; "Customer Statistics FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = field("Bill-to Customer No."),
                              "Date Filter" = field("Date Filter");
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = field("Bill-to Customer No."),
                              "Date Filter" = field("Date Filter");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = false;
            }

        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
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
                        Rec.ShowDocDim;
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                    trigger OnAction()
                    begin
                        Rec.OpenSalesOrderStatistics;
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        /////-                  WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId,Database::"Sales Header","Document Type","No.");
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                    ToolTip = 'View or add comments for the record.';
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("S&hipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = field("No.");
                    RunPageView = sorting("Order No.");
                    ToolTip = 'View related posted sales shipments.';
                }
                action(PostedSalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = field("No.");
                    RunPageView = sorting("Order No.");
                    ToolTip = 'View a list of ongoing sales invoices for the order.';
                }
                action(PostedSalesPrepmtInvoices)
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = field("No.");
                    RunPageView = sorting("Prepayment Order No.");
                    ToolTip = 'View related posted sales invoices that involve a prepayment. ';
                }
                action("Prepayment Credi&t Memos")
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = field("No.");
                    RunPageView = sorting("Prepayment Order No.");
                    ToolTip = 'View related posted sales credit memos that involve a prepayment. ';
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Whse. Shipment Lines")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Whse. Shipment Lines';
                    Image = ShipmentLines;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = const(37),
                                  /////-"Source Subtype"=field("Document Type"),
                                  "Source No." = field("No.");
                    RunPageView = sorting("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ToolTip = 'View ongoing warehouse shipments for the document, in advanced warehouse configurations.';
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = const("Sales Order"),
                                  "Source No." = field("No.");
                    RunPageView = sorting("Source Document", "Source No.", "Location Code");
                    ToolTip = 'View items that are inbound or outbound on inventory put-away or inventory pick documents for the transfer order.';
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics 365 for Sales';
                Visible = CRMIntegrationEnabled;
                action(CRMGoToSalesOrderListInNAV)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Order List';
                    Enabled = CRMIntegrationEnabled;
                    Image = "Order";
                    ToolTip = 'Open the Sales Order List - Dynamics 365 for Sales page in Dynamics NAV';
                    Visible = CRMIntegrationEnabled;

                    trigger OnAction()
                    var
                        CRMSalesorder: Record "CRM Salesorder";
                    begin
                        Page.Run(Page::"CRM Sales Order List", CRMSalesorder);
                    end;
                }
            }
        }
        area(processing)
        {
            group(ActionGroup12)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
                action("Enviar a ADAIA")
                {
                    ApplicationArea = Basic;
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

                    trigger OnAction()
                    begin

                        Page.RunModal(50008);
                    end;
                }
                action("Eti. PORTUGAL")
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        ImprimeEtiPortugal;
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
                    begin
                        ReenviaraADAIA;
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Pla&nning")
                {
                    ApplicationArea = Planning;
                    Caption = 'Pla&nning';
                    Image = Planning;
                    ToolTip = 'Open a tool for manual supply planning that displays all new demand along with availability information and suggestions for supply. It provides the visibility and tools needed to plan for demand from sales lines and component lines and then create different types of supply orders directly.';

                    trigger OnAction()
                    var
                        SalesOrderPlanningForm: Page "Sales Order Planning";
                    begin
                        SalesOrderPlanningForm.SetSalesOrder(Rec."No.");
                        SalesOrderPlanningForm.RunModal;
                    end;
                }
                action("Order &Promising")
                {
                    AccessByPermission = TableData "Order Promising Line" = R;
                    ApplicationArea = Planning;
                    Caption = 'Order &Promising';
                    Image = OrderPromising;
                    ToolTip = 'Calculate the shipment and delivery dates based on the item''s known and expected availability dates, and then promise the dates to the customer.';

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SetRange("Source Type", Rec."Document Type");
                        OrderPromisingLine.SetRange("Source ID", Rec."No.");
                        Page.RunModal(Page::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    ApplicationArea = Intercompany;
                    Caption = 'Send IC Sales Order Cnfmn.';
                    Image = IntercompanyOrder;
                    ToolTip = 'Send the document to the intercompany outbox or directly to the intercompany partner if automatic transaction sending is enabled.';

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                            ICInOutboxMgt.SendSalesDoc(Rec, false);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist and CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord or CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
                    begin
                        /////-ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                        /////-WorkflowWebhookManagement.FindAndCancel(RecordId);
                    end;
                }
            }
            group(ActionGroup3)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                    ApplicationArea = Warehouse;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreatePutawayPick;
                    ToolTip = 'Create an inventory put-away or inventory pick to handle items on the document according to a basic warehouse configuration that does not require warehouse receipt or shipment documents.';

                    trigger OnAction()
                    begin
                        /////-CreateInvtPutAwayPick;

                        /////-if not Find('=><') then
                        /////-Init;
                    end;
                }
                action("Create &Whse. Shipment")
                {
                    AccessByPermission = TableData "Warehouse Shipment Header" = R;
                    ApplicationArea = Warehouse;
                    Caption = 'Create &Whse. Shipment';
                    Image = NewShipment;
                    ToolTip = 'Create a warehouse shipment to start a pick a ship process according to an advanced warehouse configuration.';

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);

                        /////-if not Find('=><') then
                        /////-Init;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = Advanced;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        SalesBatchPostMgt: Codeunit "Sales Batch Post Mgt.";
                        BatchProcessingMgt: Codeunit "Batch Processing Mgt.";
                    /////-BatchPostParameterTypes: Codeunit UnknownCodeunit1370;
                    begin
                        CurrPage.SetSelectionFilter(SalesHeader);
                        /////-if SalesHeader.Count > 1 then begin
                        /////-BatchProcessingMgt.AddParameter(BatchPostParameterTypes.Invoice,true);
                        /////-BatchProcessingMgt.AddParameter(BatchPostParameterTypes.Ship,true);

                        SalesBatchPostMgt.SetBatchProcessor(BatchProcessingMgt);
                        /////-SalesBatchPostMgt.RunWithUI(SalesHeader,Count,ReadyToPostQst);
                        /////-end else
                        /////-Post(Codeunit::"Sales-Post (Yes/No)");
                    end;
                }
                action(PostAndSend)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Post and Send';
                    Ellipsis = true;
                    Image = PostMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens where you can confirm or select a sending profile.';

                    trigger OnAction()
                    begin
                        /////-Post(Codeunit::"Sales-Post and Send");
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Post several documents at once. A report request window opens where you can specify which documents to post.';

                    trigger OnAction()
                    begin
                        Report.RunModal(Report::"Batch Post Sales Orders", true, true, Rec);
                        CurrPage.Update(false);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = JobQueueActive;

                    trigger OnAction()
                    begin
                        /////-CancelBackgroundPosting;
                    end;
                }
                action("Preview Posting")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    begin
                        ShowPreview
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                action("Work Order")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Work Order';
                    Ellipsis = true;
                    Image = Print;
                    ToolTip = 'Prepare to registers actual item quantities or time used in connection with the sales order. For example, the document can be used by staff who perform any kind of processing work in connection with the sales order. It can also be exported to Excel if you need to process the sales line data further.';

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                    end;
                }
                action("Pick Instruction")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Pick Instruction';
                    Image = Print;
                    ToolTip = 'Print a picking list that shows which items to pick and ship for the sales order. If an item is assembled to order, then the report includes rows for the assembly components that must be picked. Use this report as a pick instruction to employees in charge of picking sales items or assembly components for the sales order.';

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Pick Instruction");
                    end;
                }
            }
            group("&Order Confirmation")
            {
                Caption = '&Order Confirmation';
                Image = Email;
                action("Email Confirmation")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Email Confirmation';
                    Ellipsis = true;
                    Image = Email;
                    ToolTip = 'Send an order confirmation by email. The Send Email window opens prefilled for the customer so you can add or change information before you send the email.';

                    trigger OnAction()
                    begin
                        DocPrint.EmailSalesHeader(Rec);
                    end;
                }
                action("Print Confirmation")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Print Confirmation';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Print an order confirmation. A report request window opens where you can specify what to include on the print-out.';
                    Visible = not IsOfficeAddin;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                    end;
                }
            }
            group(Display)
            {
                Caption = 'Display';
                action(ReportFactBoxVisibility)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show/Hide Power BI Reports';
                    Image = "Report";
                    ToolTip = 'Select if the Power BI FactBox is visible or not.';

                    trigger OnAction()
                    begin
                        if PowerBIVisible then
                            PowerBIVisible := false
                        else
                            PowerBIVisible := true;
                        // save visibility value into the table
                        /////-CurrPage."Power BI Report FactBox".Page.SetFactBoxVisibility(PowerBIVisible);
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Sales Reservation Avail.")
            {
                ApplicationArea = Advanced;
                Caption = 'Sales Reservation Avail.';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Sales Reservation Avail.";
                ToolTip = 'View, print, or save an overview of availability of items for shipment on sales documents, filtered on shipment status.';
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlVisibility;
        CurrPage.IncomingDocAttachFactBox.Page.LoadDataFromRecord(Rec);

        // Contextual Power BI FactBox: send data to filter the report in the FactBox
        /////-CurrPage."Power BI Report FactBox".Page.SetCurrentListSelection("No.",false);
    end;

    trigger OnAfterGetRecord()
    begin






        if Customer.Get(Rec."Sell-to Customer No.") then begin
        end;

        ///// TOTALPedido:=COUNT;


        TLinea := 0;
        SalesLine.Reset;
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        TLinea := SalesLine.Count;
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
                            PESO := PESO + SalesLine.Quantity * SalesLine."Gross Weight";
                        until SalesLine.Next = 0;
                until SalesHeader.Next = 0;
            PesoReal := PESO;

        end;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        exit(Rec.Find(Which) and ShowHeader);
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    var
        NewStepCount: Integer;
    begin
        repeat
            NewStepCount := Rec.Next(Steps);
        until (NewStepCount = 0) or ShowHeader;

        exit(NewStepCount);
    end;

    trigger OnOpenPage()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        OfficeMgt: Codeunit "Office Management";
    begin









        /*
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
          FILTERGROUP(0);
        END;
        
        SETRANGE("Date Filter",0D,WORKDATE - 1);
        
        JobQueueActive := SalesSetup.JobQueueActive;
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        IsOfficeAddin := OfficeMgt.IsAvailable;
        
        CopySellToCustomerFilter;
        
        // Contextual Power BI FactBox: filtering available reports, setting context, loading Power BI related user settings
        CurrPage."Power BI Report FactBox".PAGE.SetNameFilter(CurrPage.CAPTION);
        CurrPage."Power BI Report FactBox".PAGE.SetContext(CurrPage.OBJECTID(FALSE));
        PowerBIVisible := SetPowerBIUserConfig.SetUserConfig(PowerBIUserConfiguration,CurrPage.OBJECTID(FALSE));
        
        */

    end;

    var
        ApplicationAreaSetup: Record "Application Area Setup";
        PowerBIUserConfiguration: Record "Power BI User Configuration";
        /////-SetPowerBIUserConfig: Codeunit UnknownCodeunit6305;
        DocPrint: Codeunit "Document-Print";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
        [InDataSet]
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CRMIntegrationEnabled: Boolean;
        IsOfficeAddin: Boolean;
        CanCancelApprovalForRecord: Boolean;
        SkipLinesWithoutVAT: Boolean;
        PowerBIVisible: Boolean;
        ReadyToPostQst: label '%1 out of %2 selected orders are ready for post. \Do you want to continue and post them?', Comment = '%1 - selected count, %2 - total count';
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        PesoReal: Decimal;
        Frecuenciavisitacomercial: Code[10];
        Ampliaciondelpedido: Code[10];
        NombreComercial: Text;
        Commenta: Boolean;
        FiltroEci: Code[10];
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
        /////-RepETAD: Report UnknownReport50009;
        /////-RepDropShi: Report UnknownReport50013;
        /////-EtiAgrppeque: Report UnknownReport50025;
        Multitabla: Record Multitabla;
        ExtendedTextHeader: Record "Extended Text Header";
        /////-RepEti: Report UnknownReport50054;
        Item: Record Item;
        X: Integer;
    /////-AutomaticosAdaia: Codeunit UnknownCodeunit50010;


    procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        /////-OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);

        /////-CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);

        /////-WorkflowWebhookManagement.GetCanRequestAndCanCancel(RecordId,CanRequestApprovalForFlow,CanCancelApprovalForFlow);
    end;

    /////-local procedure Post(PostingCodeunitID: Integer)
    /////-var
    /////-LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    /////-begin
    /////-if ApplicationAreaSetup.IsFoundationEnabled then
    /////-          LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);

    /////-  SendToPosting(PostingCodeunitID);

    /////-CurrPage.Update(false);
    /////-    end;

    procedure SkipShowingLinesWithoutVAT()
    begin
        SkipLinesWithoutVAT := true;
    end;

    local procedure ShowHeader(): Boolean
    var
        CashFlowManagement: Codeunit "Cash Flow Management";
    begin
        if not SkipLinesWithoutVAT then
            exit(true);

        exit(CashFlowManagement.GetTaxAmountFromSalesOrder(Rec) <> 0);
    end;

    local procedure EnviaraADAIA()
    var
        /////-  AutomaticosAdaia: Codeunit UnknownCodeunit50010;
        SalesHeader: Record "Sales Header";
    begin


        contadordeagrup := '0';

        if Rec."Nº expedición" <> '' then begin
            Error('Ya se ha enviado a Adaia.');
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

        if Rec."No agrupar en ADAIA" = false then begin

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
            SalesHeader4.SetRange(SalesHeader4."No agrupar en ADAIA", false);
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
                            SalesHeader22.Modify;
                        end;
                    end;
                until SalesHeader3.Next = 0;
        end;


        if Rec."No agrupar en ADAIA" = true then begin

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
            /////-Clear(AutomaticosAdaia);
            /////-AutomaticosAdaia.ENVIAEXPEDICIONES(SalesHeader3);

        end;

        Commit;

        SalesHeader35.Reset;
        SalesHeader35.SetRange(SalesHeader35."Document Type", Rec."Document Type");
        SalesHeader35.SetRange(SalesHeader35."No.", Rec."No.");
        if SalesHeader35.FindFirst then begin
            if CopyStr(SalesHeader35."No.", 3, 3) <> 'WEB' then begin
                /////-AutomaticosAdaia.ENVIAREMAILPARAPREPARAR(SalesHeader35);
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

        ImprimeEtiAdaia;


        if Rec."VAT Country/Region Code" = 'PT' then begin
            ImprimeEtiPortugal;
        end;

    end;

    local procedure ImprimeEtiAdaia()
    begin



        SalesHeader32.Reset;
        SalesHeader32.SetRange(SalesHeader32."Document Type", Rec."Document Type");
        SalesHeader32.SetRange(SalesHeader32."No.", Rec."No.");
        if SalesHeader32.FindSet then begin
            /////-Clear(RepETAD);
            /////-RepETAD.SetTableview(SalesHeader32);
            /////-RepETAD.RunModal;
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
                        /////-Clear(EtiAgrppeque);
                        /////-EtiAgrppeque.SetTableview(SalesHeader22);
                        /////-EtiAgrppeque.RunModal;
                    end;

                until SalesHeader3.Next = 0;

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
                                        /////-ExtendedTextHeader.SetRange(ExtendedTextHeader."Table Name", ExtendedTextHeader."table name"::'Etiquetas');
                                        ExtendedTextHeader.SetRange(ExtendedTextHeader."No.", SalesLine."No.");
                                        if ExtendedTextHeader.FindFirst then begin
                                            /////-Clear(RepEti);
                                            /////-RepEti.NEXPE("Nº expedición");
                                            /////-RepEti.SetTableview(ExtendedTextHeader);
                                            /////-RepEti.RunModal;
                                        end;
                                    until X = SalesLine."Outstanding Quantity";
                                end;
                            end;
                        end;
                    until SalesLine.Next = 0;
            until Multitabla.Next = 0;

    end;

    local procedure ReenviaraADAIA()
    var
        /////-AutomaticosAdaia: Codeunit UnknownCodeunit50010;
        SalesHeader: Record "Sales Header";
    begin

        SalesHeader3.Reset;
        SalesHeader3.SetCurrentkey("Document Type", "Nº expedición");
        SalesHeader3.SetRange(SalesHeader3."Document Type", 1);
        SalesHeader3.SetRange(SalesHeader3."Nº expedición", Rec."Nº expedición");
        if SalesHeader3.FindFirst then begin
            /////-Clear(AutomaticosAdaia);
            /////-AutomaticosAdaia.ENVIAEXPEDICIONES(SalesHeader3);

        end;
    end;
}

