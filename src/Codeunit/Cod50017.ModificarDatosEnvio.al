codeunit 50017 ModificarDatosEnvio
{
    Permissions = TableData "Sales Shipment Header" = rm;
    TableNo = "Sales Shipment Header";

    trigger OnRun()
    begin
        SalesShptHeader := Rec;
        SalesShptHeader.LockTable();
        SalesShptHeader.Find();
        SalesShptHeader."Numero segumiento" := Rec."Numero segumiento";
        SalesShptHeader."Estado Expedicion" := Rec."Estado Expedicion";
        SalesShptHeader."Total bultos" := Rec."Total bultos";
        SalesShptHeader."Nº Palets" := Rec."Nº Palets";
        SalesShptHeader."Total peso" := Rec."Total peso";
        SalesShptHeader.ASN := Rec.ASN;
        SalesShptHeader."Observación para transporte" := Rec."Observación para transporte";

        SalesShptHeader.TestField("No.", Rec."No.");
        SalesShptHeader.Modify();
        Rec := SalesShptHeader;
    end;

    var
        SalesShptHeader: Record "Sales Shipment Header";
}
