pageextension 50056 "SII History" extends "SII History"
{
    actions
    {
        addafter(Retry)
        {
            action(ReintentarVarios)
            {
                ApplicationArea = All;
                Caption = 'Reintentar Varios';
                //Enabled = Enabled;
                Image = Refresh;
                Scope = Repeater;
                ToolTip = 'Retry to send the document to SII.';
                //Visible = RecordsFound;

                trigger OnAction()
                var
                    SIIHistory: Record "SII History";
                    TempSIIDocUploadState: Record "SII Doc. Upload State" temporary;
                    SIIDocUploadManagement: Codeunit "SII Doc. Upload Management";
                begin
                    CurrPage.SetSelectionFilter(SIIHistory);
                    SIIHistory.Ascending(false);
                    SIIHistory.SetFilter(Status, '<>%1', SIIHistory.Status::Accepted);
                    if SIIHistory.FindSet(true) then
                        repeat
                            CreateNewRequestPerDocument(
                              TempSIIDocUploadState, SIIHistory, SIIHistory."Upload Type", (SIIHistory.Status = SIIHistory.Status::"Accepted With Errors"));
                        until SIIHistory.Next() = 0;
                    SIIDocUploadManagement.UploadManualDocument();
                end;

            }
        }
    }

    local procedure CreateNewRequestPerDocument(var TempSIIDocUploadState: Record "SII Doc. Upload State" temporary; var SIIHistory: Record "SII History"; UploadType: Option; IsAcceptedWithErrorRetry: Boolean)
    var
        SIIDocUploadState: Record "SII Doc. Upload State";
    begin
        if not TempSIIDocUploadState.Get(SIIHistory."Document State Id") then begin
            TempSIIDocUploadState.Id := SIIHistory."Document State Id";
            TempSIIDocUploadState.Insert();

            if SIIHistory.Status <> SIIHistory.Status::Pending then
                // We set 1 retry for manual call.
                SIIHistory.CreateNewRequest(SIIHistory."Document State Id", UploadType, 1, true, IsAcceptedWithErrorRetry)
            else
                if not SIIHistory."Is Manual" and (SIIHistory.Status <> SIIHistory.Status::Accepted) then begin
                    SIIHistory."Is Manual" := true;
                    SIIHistory.Modify();
                    SIIDocUploadState.Get(SIIHistory."Document State Id");
                    SIIDocUploadState."Is Manual" := true;
                    SIIDocUploadState.Modify();
                end;
        end;
    end;
}
