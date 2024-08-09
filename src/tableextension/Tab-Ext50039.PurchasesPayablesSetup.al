tableextension 50039 "Purchases&PayablesSetup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "% Compra Clasificación A"; Decimal)
        {
        }
        field(50001; "% Compra Clasificación B"; Decimal)
        {
        }
        field(50002; "% Compra Clasificación C"; Decimal)
        {
        }
        field(50003; "Meses calculo demanda"; Integer)
        {
        }
        field(50070; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(50071; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(50072; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(50073; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(50074; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(50075; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
    }
}
