#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50072 "Lineas Tienda Animal"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sales Shipment Line";
    SourceTableView = sorting("Sell-to Customer No.","No.","Shipment Date")
                      where("No."=filter(<>'TRAN'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("order-id";SalesShipmentHeader."Your Reference")
                {
                    ApplicationArea = Basic;
                    Caption = 'order-id';
                }
                field("carrier-code";ShippingAgent."Codigo externo")
                {
                    ApplicationArea = Basic;
                    Caption = 'carrier-code';
                }
                field("carrier-name";ShippingAgent.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'carrier-name';
                }
                field("carrier-url";carrierurl)
                {
                    ApplicationArea = Basic;
                    Caption = 'carrier-url';
                }
                field("tracking-number";trackingnumber)
                {
                    ApplicationArea = Basic;
                    Caption = 'tracking-number';
                }
                field("offer-sku";Rec."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'offer-sku';
                }
                field("order-line-id";Rec."id linea externo")
                {
                    ApplicationArea = Basic;
                    Caption = 'order-line-id';
                }
                field(Quantity;Rec.Quantity)
                {
                    ApplicationArea = Basic;
                    Caption = 'quantity';
                }
                field("Document No.";Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha alta";Rec."Fecha alta")
                {
                    ApplicationArea = Basic;
                }
                field("Sell-to Customer No.";Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field("Grupo clientes";Rec."Grupo clientes")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        Rec."id linea externo":='';
        trackingnumber:='';
        SalesShipmentHeader.Init;
        if SalesShipmentHeader.Get(Rec."Document No.") then begin
          trackingnumber:=SalesShipmentHeader."Numero segumiento";
        end;

        carrierurl:='';
        ShippingAgent.Init;
        if ShippingAgent.Get(SalesShipmentHeader."Shipping Agent Code") then begin
          carrierurl:=ShippingAgent."Link transporte";
        end;
    end;

    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        ShippingAgent: Record "Shipping Agent";
        carrierurl: Text;
        trackingnumber: Text;
}

