#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50092 "Demanda almacenes"
{

    
    ApplicationArea = All;
    Caption = 'Demanda Almacenes';     
    DelayedInsert = true;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SaveValues = true;     
    Editable = false;     
    SourceTable = Item;
    SourceTableView = where("Location Filter" = filter(<> 'SILLA' & <> 'FOB'),
                            Inventory = filter(<> 0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field("Existencia SILLA"; Rec."Existencia SILLA")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field("Existencia FOB";Rec."Existencia FOB")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field("Existencia CATIT";Rec."Existencia CATIT")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field("Existencia OPER";Rec."Existencia OPER")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field("Existencia TENERIFE";Rec."Existencia TENERIFE")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field("Existencia TRANS";Rec."Existencia TRANS")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field("Existencia TSTO";Rec."Existencia TSTO")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field("Existencia VCD";Rec."Existencia VCD")
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field(Laventasp; Laventasp)
                {
                    ApplicationArea = Basic;
                    Caption = 'En pedido';
                    DecimalPlaces = 0 : 0;
                    StyleExpr = COLOR;
                }
                field(Venta; Laventas)
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    StyleExpr = color;
                }
                field(Media; LAMedia)
                {
                    ApplicationArea = Basic;
                    StyleExpr = color;
                }
                field(Paradias; Paradias)
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    StyleExpr = color;
                }
                field("Existencias almacenes"; Rec.Inventory)
                {
                    ApplicationArea = Basic;
                    Caption = 'Existencias almacenes';
                    StyleExpr = color;
                }
                field("Cantidad palet transporte alma"; Rec."Cantidad palet transporte alma")
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad palet americano"; Rec."Cantidad palet americano")
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


        desde := CalcDate('-31D', Today);
        hasta := Today;
        Laventas := 0;
        SalesShipmentLine.Reset;
        SalesShipmentLine.SetCurrentkey("No.");
        SalesShipmentLine.SetRange("No.", Rec."No.");
        SalesShipmentLine.SetRange("Posting Date", desde, hasta);
        if SalesShipmentLine.FindSet then
            repeat
                Laventas := Laventas + SalesShipmentLine."Quantity (Base)";
            until SalesShipmentLine.Next = 0;

        Laventasp := 0;
        SalesLine.Reset;
        SalesLine.SetCurrentkey("No.");
        SalesLine.SetRange("Document Type", SalesLine."document type"::Order);
        SalesLine.SetRange("No.", Rec."No.");
        SalesLine.SetRange(SalesLine."Shipment Date", desde, CalcDate('+1S', Today));
        if SalesLine.FindSet then
            repeat
                Laventas := Laventas + SalesLine."Outstanding Qty. (Base)";
                Laventasp := Laventasp + SalesLine."Outstanding Qty. (Base)";
            until SalesLine.Next = 0;


        Paradias := 0;
        LAMedia := 0;
        if Laventas <> 0 then begin
            LAMedia := Laventas / 31;
            Paradias := ROUND(Rec."Existencia SILLA" / LAMedia, 1);
        end;

        color := '';
        if Paradias <> 0 then begin
            if Paradias <= 5 then begin
                color := 'Unfavorable';
            end;
        end;
    end;

    var
        SalesShipmentLine: Record "Sales Shipment Line";
        Laventas: Decimal;
        LAMedia: Decimal;
        Paradias: Decimal;
        desde: Date;
        hasta: Date;
        color: Text;
        apedir: Decimal;
        Paradias2: Decimal;
        SalesLine: Record "Sales Line";
        Laventasp: Decimal;
}

