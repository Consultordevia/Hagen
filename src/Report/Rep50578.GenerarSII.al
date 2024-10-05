Report 50578 "Generar SII"
{
    Permissions = TableData "VAT Entry" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            DataItemTableView = sorting("Document No.", "Posting Date");
            RequestFilterFields = "Document No.", "Document Type", "Gen. Prod. Posting Group", "Gen. Bus. Posting Group", "Posting Date";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Regenerar then begin
                    "No. mov. registro IVA" := 0;
                    Modify;
                end;
                ///SII.GenerarRegistroIVA("VAT Entry"."Entry No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        /////- SII: Codeunit UnknownCodeunit50146;
        Regenerar: Boolean;
}

