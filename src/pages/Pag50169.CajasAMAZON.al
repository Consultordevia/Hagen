#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50169 "Cajas AMAZON"
{
    PageType = List;
    SourceTable = "Cajas AMAZON";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Producto; Rec.Producto)
                {
                    ApplicationArea = Basic;
                }
                field(Caja; Rec.Caja)
                {
                    ApplicationArea = Basic;
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = Basic;
                }
                field("your ref"; Rec."your ref")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Rellena Pedido MIX")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin



                    SalesLine.Reset;
                    SalesLine.SetCurrentkey("Your Reference", "Line No.");
                    SalesLine.SetRange("Nº expedición", Rec."Nº Expedicion");
                    if SalesLine.FindFirst then
                        repeat
                            if SalesLine.Quantity > 0 then begin
                                if SalesLine.Type = SalesLine.Type::Item then begin

                                    Q_Inners := 0;
                                    Q_Masters := 0;
                                    Q_Unidades := 0;
                                    Resto_inner := 0;
                                    Resto_uni := 0;
                                    SalesLine.CalcFields("Cantidad inner", "Cantidad master");
                                    Amazonmaster_inner.Reset;
                                    Amazonmaster_inner.SetRange("Item No.", SalesLine."No.");
                                    if Amazonmaster_inner.FindFirst then begin
                                        SalesLine."Cantidad inner" := Amazonmaster_inner."Cantidad inner";
                                        SalesLine."Cantidad master" := Amazonmaster_inner."Cantidad master";
                                    end;

                                    if SalesLine."Cantidad master" <> 0 then begin
                                        Q_Masters := ROUND(SalesLine.Quantity / SalesLine."Cantidad master", 1, '<');
                                        if Q_Masters * SalesLine."Cantidad master" <> SalesLine.Quantity then begin
                                            Resto_inner := SalesLine.Quantity - (Q_Masters * SalesLine."Cantidad master");
                                        end;
                                    end;
                                    if (Resto_inner >= SalesLine."Cantidad inner") and (SalesLine."Cantidad inner" <> 1) then begin
                                        if Resto_inner <> 0 then begin
                                            if SalesLine."Cantidad inner" <> 0 then begin
                                                Q_Inners := ROUND(Resto_inner / SalesLine."Cantidad inner", 1, '<');
                                                if (Q_Masters * SalesLine."Cantidad master") +
                                                    (Q_Inners * SalesLine."Cantidad inner") <> SalesLine.Quantity then begin
                                                    Resto_uni := SalesLine.Quantity - ((Q_Masters * SalesLine."Cantidad master") +
                                                           (Q_Inners * SalesLine."Cantidad inner"));
                                                end;
                                            end;
                                        end;
                                    end;
                                    if (Resto_inner < SalesLine."Cantidad inner") then begin
                                        Resto_uni := Resto_inner;
                                    end;
                                    if (SalesLine."Cantidad inner" = 1) then begin
                                        Resto_uni := Resto_inner;
                                    end;
                                    if Resto_uni <> 0 then begin
                                        Q_Unidades := Resto_uni;
                                    end;

                                    if (Q_Unidades <> 0) then begin
                                        CajasAMAZON.Init;
                                        CajasAMAZON."Nº Expedicion" := SalesLine."Nº expedición";
                                        Conta := Conta + 1;
                                        CajasAMAZON.Contador := Conta;
                                        CajasAMAZON.Producto := SalesLine."No.";
                                        CajasAMAZON.Cantidad := Q_Unidades;
                                        CajasAMAZON."your ref" := SalesLine."Your Reference";
                                        CajasAMAZON.Insert(true);
                                    end;
                                end;
                            end;
                        until SalesLine.Next = 0;
                end;
            }
            action("Rellena Albaran MIX")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin


                    SalesShipmentLine.Reset;
                    SalesShipmentLine.SetCurrentkey("Your Reference", "Line No.");
                    SalesShipmentLine.SetRange("Nº expedición", Rec."Nº Expedicion");
                    SalesShipmentLine.SetRange("Excluir del exel amazon", false);
                    if SalesShipmentLine.FindFirst then
                        repeat
                            if SalesShipmentLine.Quantity > 0 then begin
                                if SalesShipmentLine.Type = SalesShipmentLine.Type::Item then begin

                                    Q_Inners := 0;
                                    Q_Masters := 0;
                                    Q_Unidades := 0;
                                    Resto_inner := 0;
                                    Resto_uni := 0;
                                    SalesShipmentLine.CalcFields("Cantidad inner", "Cantidad master");
                                    Amazonmaster_inner.Reset;
                                    Amazonmaster_inner.SetRange("Item No.", SalesShipmentLine."No.");
                                    if Amazonmaster_inner.FindFirst then begin
                                        SalesShipmentLine."Cantidad inner" := Amazonmaster_inner."Cantidad inner";
                                        SalesShipmentLine."Cantidad master" := Amazonmaster_inner."Cantidad master";
                                    end;
                                    if SalesShipmentLine."Cantidad master" <> 0 then begin
                                        Q_Masters := ROUND(SalesShipmentLine.Quantity / SalesShipmentLine."Cantidad master", 1, '<');
                                        if Q_Masters * SalesShipmentLine."Cantidad master" <> SalesShipmentLine.Quantity then begin
                                            Resto_inner := SalesShipmentLine.Quantity - (Q_Masters * SalesShipmentLine."Cantidad master");
                                        end;
                                    end;
                                    if (Resto_inner >= SalesShipmentLine."Cantidad inner") and (SalesShipmentLine."Cantidad inner" <> 1) then begin
                                        if Resto_inner <> 0 then begin
                                            if SalesShipmentLine."Cantidad inner" <> 0 then begin
                                                Q_Inners := ROUND(Resto_inner / SalesShipmentLine."Cantidad inner", 1, '<');
                                                if (Q_Masters * SalesShipmentLine."Cantidad master") +
                                                    (Q_Inners * SalesShipmentLine."Cantidad inner") <> SalesShipmentLine.Quantity then begin
                                                    Resto_uni := SalesShipmentLine.Quantity - ((Q_Masters * SalesShipmentLine."Cantidad master") +
                                                           (Q_Inners * SalesShipmentLine."Cantidad inner"));
                                                end;
                                            end;
                                        end;
                                    end;
                                    if (Resto_inner < SalesShipmentLine."Cantidad inner") then begin
                                        Resto_uni := Resto_inner;
                                    end;
                                    if (SalesShipmentLine."Cantidad inner" = 1) then begin
                                        Resto_uni := Resto_inner;
                                    end;
                                    if Resto_uni <> 0 then begin
                                        Q_Unidades := Resto_uni;
                                    end;

                                    if (Q_Unidades <> 0) then begin
                                        CajasAMAZON.Init;
                                        CajasAMAZON."Nº Expedicion" := SalesShipmentLine."Nº expedición";
                                        Conta := Conta + 1;
                                        CajasAMAZON.Contador := Conta;
                                        CajasAMAZON.Producto := SalesShipmentLine."No.";
                                        CajasAMAZON.Cantidad := Q_Unidades;
                                        CajasAMAZON."your ref" := SalesShipmentLine."Your Reference";
                                        CajasAMAZON.Insert(true);
                                    end;
                                end;
                            end;
                        until SalesShipmentLine.Next = 0;
                end;
            }
        }
    }

    var
        CajasAMAZON: Record "Cajas AMAZON";
        SalesShipmentLine: Record "Sales Shipment Line";
        Q_Inners: Decimal;
        Q_Masters: Decimal;
        Q_Unidades: Decimal;
        Resto_inner: Decimal;
        Resto_uni: Decimal;
        Conta: Integer;
        SalesLine: Record "Sales Line";
        Amazonmaster_inner: Record "Amazon master_inner";
}

