#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50231 "Lineas pedido expedicion"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Lineas pedido expedicion.rdlc';

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
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
            column(EAN; "Sales Line".Ean)
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
            column(Nexpedi; "Sales Line"."Nº expedición")
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
            column(TOTBULTOS; totalBultos)
            {
            }
            column(textocajas; textocajas)
            {
            }
            column(expedicindropshp; SalesHeader."Nº expedición dropshp")
            {
            }
            column(NombreCliente; SalesHeader."Ship-to Name")
            {
            }
            column(ShippingAgentCode; SalesHeader."Shipping Agent Code")
            {
            }
            column(ObservacPDA; ObservacPDA)
            {
            }
           column(Nexpediciónagrupada;SalesHeader."Nº expedición agrupada")
            {
            }

            trigger OnAfterGetRecord()
            begin

                ///"Sales Shipment Line".SetFilter("Nº expedición", Nexpe);



                if SalesHeader.Get(1,"Sales Line"."Document No.") then begin
                    totalBultos := 1 + SalesHeader."Incrementa bultos";
                end;

                if "Sales Line"."No." = 'TRAN' then begin
                    CurrReport.Skip;
                end;
                if Item.Get("Sales Line"."No.") then begin
                    if Item."Producto almacenable" = false then begin
                        CurrReport.Skip;
                    end;
                end;



                YREF := "Sales Line"."Nº expedición";
            end;

            trigger OnPreDataItem()
            begin

                /////"Sales Shipment Line".SetFilter("Nº expedición", Nexpe);
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
                    field("Nº expedición"; Nexpe)
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Nº expedición';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
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
        Nexpe: Code[20];
        ObservacPDA: Text;
}

