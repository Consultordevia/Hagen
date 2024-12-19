#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50024 "Comercial presupuestos"
{
    Caption = 'Comercial presupuestos';
    CardPageID = "Sales Quote";
    DataCaptionFields = "Sell-to Customer No.";
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Quote,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const(Quote));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the sales document. The field can be filled automatically or manually and can be set up to be invisible.';

                    trigger OnDrillDown()
                    begin

                        SalesHeader.Reset;
                        SalesHeader.SetRange("Document Type", 0);
                        SalesHeader.SetRange("No.", Rec."No.");
                        if SalesHeader.FindFirst then begin
                            Clear(NuevoPresu);
                            NuevoPresu.SetTableview(SalesHeader);
                            NuevoPresu.RunModal;
                        end;
                    end;
                }

                field("Estado pedido";Rec."Estado pedido")
                {ApplicationArea = All;}
                field("Sell-to Customer Name 2";Rec."Sell-to Customer Name 2")
                {ApplicationArea = All;}
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the customer who will receive the products and be billed by default. When you fill this field, most of the other fields on the document are filled from the customer card.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the customer who will receive the products and be billed by default.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the number that the customer uses in their own system to refer to this sales document.';
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the person to contact at the customer that the items were sold to.';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the number of the customer that you send or sent the invoice or credit memo to.';
                    Visible = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the name of the customer that you send or sent the invoice or credit memo to.';
                    Visible = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the postal code of the customer''s billing address.';
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the country/region code of the customer''s billing address.';
                    Visible = false;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the name of the contact person at the customer''s billing address.';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies a code for an alternate shipment address if you want to ship to another address than the one that has been entered automatically. This field is also used in case of drop shipment.';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the name of the contact person at the address that products will be shipped to.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the posting of the sales document will be recorded.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies when the sales invoice must be paid.';
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date that the customer has asked for the order to be delivered.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of amounts in the Line Amount field on the sales order lines. It is used to calculate the invoice discount of the sales order.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the code for the shipping agent who is transporting the items.';
                    Visible = false;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the code for the service, such as a one-day delivery, that is offered by the shipping agent.';
                    Visible = false;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the name of the sales person who is assigned to the customer.';
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the currency of amounts on the sales document.';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the date when the document was created.';
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = RelationshipMgmt;
                    ToolTip = 'Specifies the number of the campaign that the document is linked to.';
                    Visible = false;
                }
                field("Opportunity No."; Rec."Opportunity No.")
                {
                    ApplicationArea = RelationshipMgmt;
                    ToolTip = 'Specifies the number of the opportunity that the sales quote is assigned to.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';
                    Visible = false;
                }

            }
        }
        area(factboxes)
        {
            part(Control1902018507; "Customer Statistics FactBox")
            {
                ApplicationArea = Advanced;
                SubPageLink = "No." = field("Bill-to Customer No."),
                              "Date Filter" = field("Date Filter");
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                ApplicationArea = Advanced;
                SubPageLink = "No." = field("Bill-to Customer No."),
                              "Date Filter" = field("Date Filter");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
                Visible = false;
            }

        }
    }

    actions
    {
        area(navigation)
        {
            group("&Quote")
            {
                Caption = '&Quote';
                Image = Quote;
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Enabled = QuoteActionsEnabled;
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        /////-WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId,Database::"Sales Header","Document Type","No.");
                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Enabled = QuoteActionsEnabled;
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        /////-ShowDocDim;
                    end;
                }
            }
            group("&View")
            {
                Caption = '&View';
                action(Customer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer';
                    Enabled = CustomerSelected;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = field("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the customer.';
                }
                action("C&ontact")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'C&ontact';
                    Enabled = ContactSelected;
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Contact Card";
                    RunPageLink = "No." = field("Sell-to Contact No.");
                    ToolTip = 'View or edit detailed information about the contact person at the customer.';
                }
            }
        }
        area(processing)
        {
            group(ActionGroup1102601026)
            {
                Caption = '&Quote';
                Image = Quote;
                action(Statistics)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Statistics';
                    Enabled = QuoteActionsEnabled;
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                    trigger OnAction()
                    begin
                        /////-CalcInvDiscForHeader;
                        Commit;
                        Page.RunModal(Page::"Sales Statistics", Rec);
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Co&mments';
                    Enabled = QuoteActionsEnabled;
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                    ToolTip = 'View or add comments for the record.';
                }
                action(Print)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Print';
                    Ellipsis = true;
                    Enabled = QuoteActionsEnabled;
                    Image = Print;
                    ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                    Visible = not IsOfficeAddin;

                    trigger OnAction()
                    begin
                        CheckSalesCheckAllLinesHaveQuantityAssigned;
                        DocPrint.PrintSalesHeader(Rec);
                    end;
                }
                action(Email)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send by Email';
                    Enabled = QuoteActionsEnabled;
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Finalize and prepare to email the document. The Send Email window opens prefilled with the customer''s email address so you can add or edit information.';

                    trigger OnAction()
                    begin
                        CheckSalesCheckAllLinesHaveQuantityAssigned;
                        DocPrint.EmailSalesHeader(Rec);
                    end;
                }
            }
            group(Create)
            {
                Caption = 'Create';
                action(MakeOrder)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Make &Order';
                    Enabled = QuoteActionsEnabled;
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Convert the sales quote to a sales order. The sales order will contain the sales quote number.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                            Codeunit.Run(Codeunit::"Sales-Quote to Order (Yes/No)", Rec);
                    end;
                }
                action(MakeInvoice)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Make Invoice';
                    Enabled = QuoteActionsEnabled;
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Scope = Repeater;
                    ToolTip = 'Convert the selected sales quote to a sales invoice.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then begin
                            CheckSalesCheckAllLinesHaveQuantityAssigned;
                            Codeunit.Run(Codeunit::"Sales-Quote to Invoice Yes/No", Rec);
                        end;
                    end;
                }
                action(CreateCustomer)
                {
                    ApplicationArea = Advanced;
                    Caption = 'C&reate Customer';
                    Enabled = ContactSelected and not CustomerSelected;
                    Image = NewCustomer;
                    ToolTip = 'Create a new customer card for the contact.';

                    trigger OnAction()
                    begin
                        /////-if CheckCustomerCreated(false) then
                        /////-CurrPage.Update(true);
                    end;
                }
                action(CreateTask)
                {
                    AccessByPermission = TableData Contact = R;
                    ApplicationArea = Advanced;
                    Caption = 'Create &Task';
                    Enabled = ContactSelected;
                    Image = NewToDo;
                    ToolTip = 'Create a new marketing task for the contact.';

                    trigger OnAction()
                    begin
                        /////-CreateTask;
                    end;
                }
            }
            group(ActionGroup3)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Re&lease';
                    Enabled = QuoteActionsEnabled;
                    Image = ReleaseDoc;
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
                    Enabled = QuoteActionsEnabled;
                    Image = ReOpen;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = Approval;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Send A&pproval Request';
                    Enabled = QuoteActionsEnabled and not OpenApprovalEntriesExist and CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
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
                    Enabled = QuoteActionsEnabled and (CanCancelApprovalForRecord or CanCancelApprovalForFlow);
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                        /////-WorkflowWebhookManagement.FindAndCancel(RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.Page.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage()
    var
        OfficeMgt: Codeunit "Office Management";
    begin
        /////-SetSecurityFilterOnRespCenter;
        IsOfficeAddin := OfficeMgt.IsAvailable;

        /////-CopySellToCustomerFilter;

        UserSetup.Get(UserId);
        /////-if UserSetup."Salespers./Purch. Code"<>'' then begin
        /////-SetRange("Salesperson Code",UserSetup."Salespers./Purch. Code");
        /////-end;
    end;

    var
        DocPrint: Codeunit "Document-Print";
        OpenApprovalEntriesExist: Boolean;
        IsOfficeAddin: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CustomerSelected: Boolean;
        ContactSelected: Boolean;
        QuoteActionsEnabled: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        UserSetup: Record "User Setup";
        SalesHeader: Record "Sales Header";
        NuevoPresu: Page "Sales Quote";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        /////-OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);

        /////-CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        /////-CustomerSelected := "Sell-to Customer No." <> '';
        /////-ContactSelected := "Sell-to Contact No." <> '';
        /////-QuoteActionsEnabled := "No." <> '';

        /////-WorkflowWebhookManagement.GetCanRequestAndCanCancel(RecordId,CanRequestApprovalForFlow,CanCancelApprovalForFlow);
    end;

    local procedure CheckSalesCheckAllLinesHaveQuantityAssigned()
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    begin
        /////-        if ApplicationAreaSetup.IsFoundationEnabled then
        /////-LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
    end;
}

