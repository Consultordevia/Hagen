#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50035 "Cajas AMAZON"
{

    fields
    {
        field(1;"Nº Expedicion";Code[20])
        {
        }
        field(2;Producto;Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin

                CORRECTO:=false;
                SalesShipmentHeader.Reset;
                SalesShipmentHeader.SetRange("Nº expedición",Rec."Nº Expedicion");
                if SalesShipmentHeader.FindFirst then repeat
                    SalesShipmentLine.Reset;
                    SalesShipmentLine.SetRange(SalesShipmentLine."Document No.",SalesShipmentHeader."No.");
                    if SalesShipmentLine.FindFirst then repeat
                        if Producto=SalesShipmentLine."No." then begin
                            CORRECTO:=true;
                        end;
                    until SalesShipmentLine.Next=0;
                until SalesShipmentHeader.Next=0;

                if CORRECTO=false then begin
                    Error('Este producto no pertenece al envio.');
                end;
            end;
        }
        field(3;Caja;Integer)
        {
        }
        field(4;Cantidad;Integer)
        {
        }
        field(5;Contador;Integer)
        {
            AutoIncrement = true;
        }
        field(6;"your ref";Code[35])
        {
        }
    }

    keys
    {
        key(Key1;"Nº Expedicion",Contador)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        CORRECTO: Boolean;
}

