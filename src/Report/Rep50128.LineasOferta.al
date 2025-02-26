#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50128 "Lineas Oferta"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Lineas Ofertas.rdlc';

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            CalcFields = "Cantidad master", "Cantidad inner";
            RequestFilterFields = "Nº expedición";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(Prod; "Sales Line"."No.")
            {
            }
            column(Cantidad; "Sales Line".Quantity)
            {
            }
            column(Descrip; "Sales Line".Description)
            {
            }
            column(EAN; "Sales Line".ean)
            {
            }
            column(Cantidadmaster; "Sales Line"."Cantidad master")
            {
            }
            column(Cantidadinner; "Sales Line"."Cantidad inner")
            {
            }
            column(Q_Masters; Q_Masters)
            {
            }
            column(Q_Inners; Q_Inners)
            {
            }
            column(Q_Unidades; Q_Unidades)
            {
            }
            column(totalBultos; totalBultos)
            {
            }
            column(totalMix; totalMix)
            {
            }
            column(Nexpedi; SalesHeader."No.")
            {
            }
            column(TotalBulLin; Q_Masters + Q_Inners)
            {
            }
            column(Texto; Texto)
            {
            }
            column(Orden; Orden)
            {
            }
            column(TotalLineas; TotalLineas)
            {
            }
            column(TotalCantidad; TotalCantidad)
            {
            }
            column(YREF; YREF)
            {
            }
            column(ref; "Sales Line"."Your Reference")
            {
            }
            column(linea; "Sales Line"."Line No.")
            {
            }
            column(TOTBULTOS; totalBultos + ncajas)
            {
            }
            column(textocajas; textocajas)
            {
            }
            column(Peso; Peso)
            {
            }
            column(Precio; "Sales Line"."Unit Price")
            {
            }
            column(cajainnner; cajainnner)
            {
            }
            column(cajamaster; cajamaster)
            {
            }



            trigger OnAfterGetRecord()
            begin


                Peso := ("Sales Line".Quantity * "Sales Line"."Net Weight");

                cajainnner := 0;
                cajamaster := 0;

                IF Item.get("Sales Line"."No.") then begin
                    item.CalcFields("Cantidad inner", "Cantidad master");
                    cajainnner := Item."Cantidad inner";
                    cajamaster := Item."Cantidad master";
                end;


                ncajas := 0;
                CajasAMAZON.Reset;
                CajasAMAZON.SetRange("Nº Expedicion", "Sales Line"."Nº expedición");
                if CajasAMAZON.FindFirst then
                    repeat
                        if CajasAMAZON.Caja > ncajas then begin
                            ncajas := CajasAMAZON.Caja;
                        end;
                    until CajasAMAZON.Next = 0;



                SalesHeader.Get("Sales Line"."Document Type", "Sales Line"."Document No.");

                if "Sales Line"."No." = 'TRAN' then begin
                    CurrReport.Skip;
                end;
                if Item.Get("Sales Line"."No.") then begin
                    if Item."Producto almacenable" = false then begin
                        CurrReport.Skip;
                    end;
                end;



                SalesHeadertmp := SalesHeader;
                if SalesHeadertmp.Insert then;

                Q_Inners := 0;
                Q_Masters := 0;
                Q_Unidades := 0;
                Resto_inner := 0;
                Resto_uni := 0;



                if "Sales Line".Type = "Sales Line".Type::Item then begin
                    TotalLineas := TotalLineas + 1;
                    TotalCantidad := TotalCantidad + "Sales Line".Quantity;
                    if "Sales Line"."Cantidad master" <> 0 then begin
                        Q_Masters := ROUND("Sales Line".Quantity / "Sales Line"."Cantidad master", 1, '<');
                        if Q_Masters * "Sales Line"."Cantidad master" <> "Sales Line".Quantity then begin
                            Resto_inner := "Sales Line".Quantity - (Q_Masters * "Sales Line"."Cantidad master");
                        end;
                    end;
                    if (Resto_inner >= "Sales Line"."Cantidad inner") and ("Sales Line"."Cantidad inner" <> 1) then begin
                        if Resto_inner <> 0 then begin
                            if "Sales Line"."Cantidad inner" <> 0 then begin
                                Q_Inners := ROUND(Resto_inner / "Sales Line"."Cantidad inner", 1, '<');
                                if (Q_Masters * "Sales Line"."Cantidad master") +
                                    (Q_Inners * "Sales Line"."Cantidad inner") <> "Sales Line".Quantity then begin
                                    Resto_uni := "Sales Line".Quantity - ((Q_Masters * "Sales Line"."Cantidad master") +
                                                   (Q_Inners * "Sales Line"."Cantidad inner"));
                                end;
                            end;
                        end;
                    end;
                    if (Resto_inner < "Sales Line"."Cantidad inner") then begin
                        Resto_uni := Resto_inner;
                    end;
                    if ("Sales Line"."Cantidad inner" = 1) then begin
                        Resto_uni := Resto_inner;
                    end;

                    if Resto_uni <> 0 then begin
                        Q_Unidades := Resto_uni;
                    end;
                end;

                totalBultos := totalBultos + Q_Masters + Q_Inners;
                totalMix := totalMix + Q_Unidades;

                Texto := 'T.Lineas: ' + Format(TotalLineas) + ' T.Cantidad: ' + Format(TotalCantidad);

                Multitabla.Reset;
                Multitabla.SetRange(Multitabla.Tabla, 17);
                Multitabla.SetCurrentkey(Multitabla.Tabla, Multitabla.Ubicacion);
                Multitabla.Ascending(false);
                Multitabla.SetFilter(Multitabla.Ubicacion, '010*01|010*02');
                Multitabla.SetRange(Producto, "Sales Line"."No.");
                if Multitabla.FindFirst then
                    repeat
                        Orden := Multitabla.Ubicacion;
                    until Multitabla.Next = 0;

                YREF := '';
                if SalesHeadertmp.FindFirst then
                    repeat
                        YREF := YREF + ' ' + SalesHeadertmp."Your Reference";
                    until SalesHeadertmp.Next = 0;


            end;
        }
    }

    requestpage
    {

        layout
        {

        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Q_Inners: Decimal;
        Q_Masters: Decimal;
        Q_Unidades: Decimal;
        Resto_inner: Decimal;
        Resto_uni: Decimal;
        totalBultos: Decimal;
        totalMix: Decimal;
        Item: Record Item;
        TotalLineas: Decimal;
        TotalCantidad: Decimal;
        Texto: Text;
        SalesHeader: Record "Sales Header";
        Orden: Code[20];
        Multitabla: Record Multitabla;
        SalesLine: Record "Sales Line";
        SalesHeadertmp: Record "Sales Header" temporary;
        YREF: Text;
        CajasAMAZON: Record "Cajas AMAZON";
        ncajas: Integer;
        LineasAMAZON: Record "Lineas AMAZON";
        textocajas: Text;
        Peso: decimal;
        SalesLine2: Record "Sales Line";
        RecUMP: Record "Item Unit of Measure";

        cajainnner: Decimal;
        Precioventa: Decimal;
        cajamaster: Decimal;

}

