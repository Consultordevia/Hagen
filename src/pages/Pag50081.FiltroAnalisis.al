#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50081 "Filtro Analisis"
{
    PageType = List;
    SourceTable = "User Setup";

    layout
    {
        area(content)
        {
            group(Control1000000017)
            {
                field("Año";Rec.Año)
                {
                    ApplicationArea = Basic;
                }
                field("hasta fecha";Rec."hasta fecha")
                {
                    ApplicationArea = Basic;
                }
                field("Analisis margenes";Rec."Analisis margenes")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        MATRIX_CellData: array [13] of Decimal;
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        DESDEFECHA: array [12] of Date;
        HASTAFECHA: array [12] of Date;
        X: Integer;
        Date: Record Date;
        "AÑO": Integer;
        CodAnalisis: Code[20];
        DESDEINI: Date;
        HASTAINI: Date;
        YYYY: Integer;
        HastaMes: Integer;

    local procedure Recalcula()
    begin
    end;
}

