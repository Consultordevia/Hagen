tableextension 50053 NoSeriesLine extends "No. Series Line"
{
    trigger OnBeforeModify()
    var
        NoSeriesLine: Record "No. Series Line";
    begin
        if CopyStr(COMPANYNAME, 1, 4) = 'ROLF' then begin
            NoSeriesLine.Reset;
            NoSeriesLine.ChangeCompany('HAGEN CANARIAS S.C.');
            if NoSeriesLine.Get("Series Code", "Line No.") then begin
                NoSeriesLine := Rec;
                NoSeriesLine.Modify;
            end;
            if not NoSeriesLine.Get("Series Code", "Line No.") then begin
                NoSeriesLine := Rec;
                NoSeriesLine.Insert;
            end;
        end;
    end;
}
