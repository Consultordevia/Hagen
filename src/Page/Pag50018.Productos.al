#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50018 Productos
{
    Caption = 'Item List';
    CardPageID = "Item Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Item;
    SourceTableView = sorting("Search Description")
                      where("Estado Producto" = filter('Activo' | 'Descatalogado' | 'Sin actualizar' | '4' | '5'));

    layout
    {
        area(content)
        {
            repeater(Item)
            {
                Caption = 'Item';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the item.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the item.';
                }
                field("Stock disponible"; Existencia)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
                {
                    ApplicationArea = Basic;
                }
                field(PVenta; PVenta)
                {
                    ApplicationArea = Basic;
                    Caption = 'Precio venta';
                }
                field(PVPrecomendado; PVPrecomendado)
                {
                    ApplicationArea = Basic;
                    Caption = 'PVP recomendado';
                }
                field("Fecha proxima recepción conten"; Rec."Fecha proxima recepción conten")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha proxima recepción pedido"; Rec."Fecha proxima recepción pedido")
                {
                    ApplicationArea = Basic;
                }
                field("Estado Producto"; Rec."Estado Producto")
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad facturada"; Rec."Cantidad facturada")
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad abonada"; Rec."Cantidad abonada")
                {
                    ApplicationArea = Basic;
                }
                field("Importe facturado"; Rec."Importe facturado")
                {
                    ApplicationArea = Basic;
                }
                field("Importe abonado"; Rec."Importe abonado")
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad fabricada"; Rec."Cantidad fabricada")
                {
                    ApplicationArea = Basic;
                }
                field("Etiqueta portugues"; Rec."Etiqueta portugues")
                {
                    ApplicationArea = Basic;
                }
                field("Imagen Articulo WEB"; Rec."Imagen Articulo WEB")
                {
                    ApplicationArea = Basic;
                }
                field("Imagen Articulo WEB 2"; Rec."Imagen Articulo WEB 2")
                {
                    ApplicationArea = Basic;
                }
                field("Imagen Articulo WEB 3"; Rec."Imagen Articulo WEB 3")
                {
                    ApplicationArea = Basic;
                }
                field("Imagen Articulo WEB 4"; Rec."Imagen Articulo WEB 4")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha Lanzamiento"; Rec."Fecha Lanzamiento") { ApplicationArea = All; }
                field("Permite fraccionar venta"; Rec."Permite fraccionar venta") { ApplicationArea = All; }
                field("Criterio rotacion"; Rec."Criterio rotacion") { ApplicationArea = All; }
                field("Fecha en picking"; Rec."Fecha en picking") { ApplicationArea = All; }
                field("Producto FRAGIL"; Rec."Producto FRAGIL") { ApplicationArea = All; }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        SetSocialListeningFactboxVisibility;

        /////-CRMIsCoupledToRecord :=
        /////-CRMCouplingManagement.IsRecordCoupledToCRM(RecordId) and CRMIntegrationEnabled;

        /////-OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);

        /////-CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
    end;

    trigger OnAfterGetRecord()
    begin

        SalesPrice.Reset;
        SalesPrice.SetRange(SalesPrice."Item No.", Rec."No.");
        SalesPrice.SetRange(SalesPrice."Sales Code", TarifaVigente);
        if SalesPrice.FindLast then begin
            PVenta := SalesPrice."Unit Price";
            PVPrecomendado := SalesPrice."Precio recomendado";
        end;

        Rec.CalcFields(Rec.Inventory, Rec."Existencia FOB", Rec."Qty. on Sales Order");
        Existencia := Rec.Inventory - Rec."Existencia FOB" - Rec."Qty. on Sales Order";
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    begin

        SalesReceivablesSetup.Get;
        TarifaVigente := SalesReceivablesSetup."Tarifa vigente";
    end;

    var
        TempFilterItemAttributesBuffer: Record "Filter Item Attributes Buffer" temporary;
        ApplicationAreaSetup: Record "Application Area Setup";
        CalculateStdCost: Codeunit "Calculate Standard Cost";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        SkilledResourceList: Page "Skilled Resource List";
        IsFoundationEnabled: Boolean;
        [InDataSet]
        SocialListeningSetupVisible: Boolean;
        [InDataSet]
        SocialListeningVisible: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;
        [InDataSet]
        IsService: Boolean;
        [InDataSet]
        InventoryItemEditable: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        PVPrecomendado: Decimal;
        PVenta: Decimal;
        SalesPrice: Record "Sales Price";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        TarifaVigente: Code[20];
        Existencia: Decimal;


    procedure GetSelectionFilter(): Text
    var
        Item: Record Item;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SetSelectionFilter(Item);
        exit(SelectionFilterManagement.GetSelectionFilterForItem(Item));
    end;


    procedure SetSelection(var Item: Record Item)
    begin
        CurrPage.SetSelectionFilter(Item);
    end;

    local procedure SetSocialListeningFactboxVisibility()
    var
    /////-SocialListeningMgt: Codeunit UnknownCodeunit871;
    begin
        /////-SocialListeningMgt.GetItemFactboxVisibility(Rec,SocialListeningSetupVisible,SocialListeningVisible);
    end;

    local procedure EnableControls()
    begin
        /////-IsService := (Type = Type::Service);
        /////-InventoryItemEditable := Type = Type::Inventory;
    end;

    local procedure SetWorkflowManagementEnabledState()
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        EventFilter := WorkflowEventHandling.RunWorkflowOnSendItemForApprovalCode + '|' +
          WorkflowEventHandling.RunWorkflowOnItemChangedCode;

        EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(Database::Item, EventFilter);
    end;
}

