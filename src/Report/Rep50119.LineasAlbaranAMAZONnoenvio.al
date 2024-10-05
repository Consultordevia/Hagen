#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50119 "Lineas Albaran AMAZON no envio"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Lineas Albaran AMAZON no envio.rdlc';

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            CalcFields = "Cantidad master", "Cantidad inner";
            DataItemTableView = where("Outstanding Quantity" = filter(<> 0));
            RequestFilterFields = "Nº expedición";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(Prod; "Sales Line"."No.")
            {
            }
            column(Cantidad; "Sales Line"."Outstanding Quantity")
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
            column(Nexpedi; SalesHeader."Nº expedición")
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

            trigger OnAfterGetRecord()
            begin



                ncajas := 0;
                CajasAMAZON.Reset;
                CajasAMAZON.SetRange("Nº Expedicion", "Sales Line"."Nº expedición");
                if CajasAMAZON.FindFirst then
                    repeat
                        if CajasAMAZON.Caja > ncajas then begin
                            ncajas := CajasAMAZON.Caja;
                        end;
                    until CajasAMAZON.Next = 0;



                SalesHeader.Get(1, "Sales Line"."Document No.");

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


                Amazonmaster_inner.Reset;
                Amazonmaster_inner.SetRange(Amazonmaster_inner."Item No.", "Sales Line"."No.");
                if Amazonmaster_inner.FindFirst then begin
                    "Sales Line"."Cantidad inner" := Amazonmaster_inner."Cantidad inner";
                    "Sales Line"."Cantidad master" := Amazonmaster_inner."Cantidad master";
                end;


                if "Sales Line".Type = "Sales Line".Type::Item then begin
                    TotalLineas := TotalLineas + 1;
                    TotalCantidad := TotalCantidad + "Sales Line"."Outstanding Quantity";
                    if "Sales Line"."Cantidad master" <> 0 then begin
                        Q_Masters := ROUND("Sales Line"."Outstanding Quantity" / "Sales Line"."Cantidad master", 1, '<');
                        if Q_Masters * "Sales Line"."Cantidad master" <> "Sales Line"."Outstanding Quantity" then begin
                            Resto_inner := "Sales Line"."Outstanding Quantity" - (Q_Masters * "Sales Line"."Cantidad master");
                        end;
                    end;
                    if (Resto_inner >= "Sales Line"."Cantidad inner") and ("Sales Line"."Cantidad inner" <> 1) then begin
                        if Resto_inner <> 0 then begin
                            if "Sales Line"."Cantidad inner" <> 0 then begin
                                Q_Inners := ROUND(Resto_inner / "Sales Line"."Cantidad inner", 1, '<');
                                if (Q_Masters * "Sales Line"."Cantidad master") +
                                    (Q_Inners * "Sales Line"."Cantidad inner") <> "Sales Line"."Outstanding Quantity" then begin
                                    Resto_uni := "Sales Line"."Outstanding Quantity" - ((Q_Masters * "Sales Line"."Cantidad master") +
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


                textocajas := '';
                LineasAMAZON.Reset;
                LineasAMAZON.SetRange(LineasAMAZON.nexpe, "Sales Line"."Nº expedición");
                LineasAMAZON.SetRange(LineasAMAZON.your, "Sales Line"."Your Reference");
                LineasAMAZON.SetRange(prod, "Sales Line"."No.");
                if LineasAMAZON.FindFirst then
                    repeat
                        if LineasAMAZON.Q1 <> 0 then begin textocajas := textocajas + 'CJ.1 '; end;
                        if LineasAMAZON.Q2 <> 0 then begin textocajas := textocajas + 'CJ.2 '; end;
                        if LineasAMAZON.Q3 <> 0 then begin textocajas := textocajas + 'CJ.3 '; end;
                        if LineasAMAZON.Q4 <> 0 then begin textocajas := textocajas + 'CJ.4 '; end;
                        if LineasAMAZON.Q5 <> 0 then begin textocajas := textocajas + 'CJ.5 '; end;
                        if LineasAMAZON.Q6 <> 0 then begin textocajas := textocajas + 'CJ.6 '; end;
                        if LineasAMAZON.Q7 <> 0 then begin textocajas := textocajas + 'CJ.7 '; end;
                        if LineasAMAZON.Q8 <> 0 then begin textocajas := textocajas + 'CJ.8 '; end;
                        if LineasAMAZON.Q9 <> 0 then begin textocajas := textocajas + 'CJ.9 '; end;
                        if LineasAMAZON.Q10 <> 0 then begin textocajas := textocajas + 'CJ.10 '; end;
                        if LineasAMAZON.Q11 <> 0 then begin textocajas := textocajas + 'CJ.11 '; end;
                        if LineasAMAZON.Q12 <> 0 then begin textocajas := textocajas + 'CJ.12 '; end;
                        if LineasAMAZON.Q13 <> 0 then begin textocajas := textocajas + 'CJ.13 '; end;
                        if LineasAMAZON.Q14 <> 0 then begin textocajas := textocajas + 'CJ.14 '; end;
                        if LineasAMAZON.Q15 <> 0 then begin textocajas := textocajas + 'CJ.15 '; end;
                        if LineasAMAZON.Q16 <> 0 then begin textocajas := textocajas + 'CJ.16 '; end;
                        if LineasAMAZON.Q17 <> 0 then begin textocajas := textocajas + 'CJ.17 '; end;
                        if LineasAMAZON.Q18 <> 0 then begin textocajas := textocajas + 'CJ.18 '; end;
                        if LineasAMAZON.Q19 <> 0 then begin textocajas := textocajas + 'CJ.19 '; end;
                        if LineasAMAZON.Q20 <> 0 then begin textocajas := textocajas + 'CJ.20 '; end;
                        if LineasAMAZON.Q21 <> 0 then begin textocajas := textocajas + 'CJ.21 '; end;
                        if LineasAMAZON.Q22 <> 0 then begin textocajas := textocajas + 'CJ.22 '; end;
                        if LineasAMAZON.Q23 <> 0 then begin textocajas := textocajas + 'CJ.23 '; end;
                        if LineasAMAZON.Q24 <> 0 then begin textocajas := textocajas + 'CJ.24 '; end;
                        if LineasAMAZON.Q25 <> 0 then begin textocajas := textocajas + 'CJ.25 '; end;
                        if LineasAMAZON.Q26 <> 0 then begin textocajas := textocajas + 'CJ.26 '; end;
                        if LineasAMAZON.Q27 <> 0 then begin textocajas := textocajas + 'CJ.27 '; end;
                        if LineasAMAZON.Q28 <> 0 then begin textocajas := textocajas + 'CJ.28 '; end;
                        if LineasAMAZON.Q29 <> 0 then begin textocajas := textocajas + 'CJ.29 '; end;
                        if LineasAMAZON.Q30 <> 0 then begin textocajas := textocajas + 'CJ.30 '; end;
                        if LineasAMAZON.Q31 <> 0 then begin textocajas := textocajas + 'CJ.31 '; end;
                        if LineasAMAZON.Q32 <> 0 then begin textocajas := textocajas + 'CJ.32 '; end;
                        if LineasAMAZON.Q33 <> 0 then begin textocajas := textocajas + 'CJ.33 '; end;
                        if LineasAMAZON.Q34 <> 0 then begin textocajas := textocajas + 'CJ.34 '; end;
                        if LineasAMAZON.Q35 <> 0 then begin textocajas := textocajas + 'CJ.35 '; end;
                        if LineasAMAZON.Q36 <> 0 then begin textocajas := textocajas + 'CJ.36 '; end;
                        if LineasAMAZON.Q37 <> 0 then begin textocajas := textocajas + 'CJ.37 '; end;
                        if LineasAMAZON.Q38 <> 0 then begin textocajas := textocajas + 'CJ.38 '; end;
                        if LineasAMAZON.Q39 <> 0 then begin textocajas := textocajas + 'CJ.39 '; end;
                        if LineasAMAZON.Q40 <> 0 then begin textocajas := textocajas + 'CJ.40 '; end;
                        if LineasAMAZON.Q41 <> 0 then begin textocajas := textocajas + 'CJ.41 '; end;
                        if LineasAMAZON.Q42 <> 0 then begin textocajas := textocajas + 'CJ.42 '; end;
                        if LineasAMAZON.Q43 <> 0 then begin textocajas := textocajas + 'CJ.43 '; end;
                        if LineasAMAZON.Q44 <> 0 then begin textocajas := textocajas + 'CJ.44 '; end;
                        if LineasAMAZON.Q45 <> 0 then begin textocajas := textocajas + 'CJ.45 '; end;
                        if LineasAMAZON.Q46 <> 0 then begin textocajas := textocajas + 'CJ.46 '; end;
                        if LineasAMAZON.Q47 <> 0 then begin textocajas := textocajas + 'CJ.47 '; end;
                        if LineasAMAZON.Q48 <> 0 then begin textocajas := textocajas + 'CJ.48 '; end;
                        if LineasAMAZON.Q49 <> 0 then begin textocajas := textocajas + 'CJ.49 '; end;
                        if LineasAMAZON.Q50 <> 0 then begin textocajas := textocajas + 'CJ.50 '; end;
                        if LineasAMAZON.Q51 <> 0 then begin textocajas := textocajas + 'CJ.51 '; end;
                        if LineasAMAZON.Q52 <> 0 then begin textocajas := textocajas + 'CJ.52 '; end;
                        if LineasAMAZON.Q53 <> 0 then begin textocajas := textocajas + 'CJ.53 '; end;
                        if LineasAMAZON.Q54 <> 0 then begin textocajas := textocajas + 'CJ.54 '; end;
                        if LineasAMAZON.Q55 <> 0 then begin textocajas := textocajas + 'CJ.55 '; end;
                        if LineasAMAZON.Q56 <> 0 then begin textocajas := textocajas + 'CJ.56 '; end;
                        if LineasAMAZON.Q57 <> 0 then begin textocajas := textocajas + 'CJ.57 '; end;
                        if LineasAMAZON.Q58 <> 0 then begin textocajas := textocajas + 'CJ.58 '; end;
                        if LineasAMAZON.Q59 <> 0 then begin textocajas := textocajas + 'CJ.59 '; end;
                        if LineasAMAZON.Q60 <> 0 then begin textocajas := textocajas + 'CJ.60 '; end;
                        if LineasAMAZON.Q61 <> 0 then begin textocajas := textocajas + 'CJ.61 '; end;
                        if LineasAMAZON.Q62 <> 0 then begin textocajas := textocajas + 'CJ.62 '; end;
                        if LineasAMAZON.Q63 <> 0 then begin textocajas := textocajas + 'CJ.63 '; end;
                        if LineasAMAZON.Q64 <> 0 then begin textocajas := textocajas + 'CJ.64 '; end;
                        if LineasAMAZON.Q65 <> 0 then begin textocajas := textocajas + 'CJ.65 '; end;
                        if LineasAMAZON.Q66 <> 0 then begin textocajas := textocajas + 'CJ.66 '; end;
                        if LineasAMAZON.Q67 <> 0 then begin textocajas := textocajas + 'CJ.67 '; end;
                        if LineasAMAZON.Q68 <> 0 then begin textocajas := textocajas + 'CJ.68 '; end;
                        if LineasAMAZON.Q69 <> 0 then begin textocajas := textocajas + 'CJ.69 '; end;
                        if LineasAMAZON.Q70 <> 0 then begin textocajas := textocajas + 'CJ.70 '; end;
                        if LineasAMAZON.Q71 <> 0 then begin textocajas := textocajas + 'CJ.71 '; end;
                        if LineasAMAZON.Q72 <> 0 then begin textocajas := textocajas + 'CJ.72 '; end;
                        if LineasAMAZON.Q73 <> 0 then begin textocajas := textocajas + 'CJ.73 '; end;
                        if LineasAMAZON.Q74 <> 0 then begin textocajas := textocajas + 'CJ.74 '; end;
                        if LineasAMAZON.Q75 <> 0 then begin textocajas := textocajas + 'CJ.75 '; end;
                        if LineasAMAZON.Q76 <> 0 then begin textocajas := textocajas + 'CJ.76 '; end;
                        if LineasAMAZON.Q77 <> 0 then begin textocajas := textocajas + 'CJ.77 '; end;
                        if LineasAMAZON.Q78 <> 0 then begin textocajas := textocajas + 'CJ.78 '; end;
                        if LineasAMAZON.Q79 <> 0 then begin textocajas := textocajas + 'CJ.79 '; end;
                        if LineasAMAZON.Q80 <> 0 then begin textocajas := textocajas + 'CJ.80 '; end;
                        if LineasAMAZON.Q81 <> 0 then begin textocajas := textocajas + 'CJ.81 '; end;
                        if LineasAMAZON.Q82 <> 0 then begin textocajas := textocajas + 'CJ.82 '; end;
                        if LineasAMAZON.Q83 <> 0 then begin textocajas := textocajas + 'CJ.83 '; end;
                        if LineasAMAZON.Q84 <> 0 then begin textocajas := textocajas + 'CJ.84 '; end;
                        if LineasAMAZON.Q85 <> 0 then begin textocajas := textocajas + 'CJ.85 '; end;
                        if LineasAMAZON.Q86 <> 0 then begin textocajas := textocajas + 'CJ.86 '; end;
                        if LineasAMAZON.Q87 <> 0 then begin textocajas := textocajas + 'CJ.87 '; end;
                        if LineasAMAZON.Q88 <> 0 then begin textocajas := textocajas + 'CJ.88 '; end;
                        if LineasAMAZON.Q89 <> 0 then begin textocajas := textocajas + 'CJ.89 '; end;
                        if LineasAMAZON.Q90 <> 0 then begin textocajas := textocajas + 'CJ.90 '; end;
                        if LineasAMAZON.Q91 <> 0 then begin textocajas := textocajas + 'CJ.91 '; end;
                        if LineasAMAZON.Q92 <> 0 then begin textocajas := textocajas + 'CJ.92 '; end;
                        if LineasAMAZON.Q93 <> 0 then begin textocajas := textocajas + 'CJ.93 '; end;
                        if LineasAMAZON.Q94 <> 0 then begin textocajas := textocajas + 'CJ.94 '; end;
                        if LineasAMAZON.Q95 <> 0 then begin textocajas := textocajas + 'CJ.95 '; end;
                        if LineasAMAZON.Q96 <> 0 then begin textocajas := textocajas + 'CJ.96 '; end;
                        if LineasAMAZON.Q97 <> 0 then begin textocajas := textocajas + 'CJ.97 '; end;
                        if LineasAMAZON.Q98 <> 0 then begin textocajas := textocajas + 'CJ.98 '; end;
                        if LineasAMAZON.Q99 <> 0 then begin textocajas := textocajas + 'CJ.99 '; end;
                        if LineasAMAZON.Q100 <> 0 then begin textocajas := textocajas + 'CJ.100 '; end;
                        if LineasAMAZON.Q101 <> 0 then begin textocajas := textocajas + 'CJ.101 '; end;
                        if LineasAMAZON.Q102 <> 0 then begin textocajas := textocajas + 'CJ.102 '; end;
                        if LineasAMAZON.Q103 <> 0 then begin textocajas := textocajas + 'CJ.103 '; end;
                        if LineasAMAZON.Q104 <> 0 then begin textocajas := textocajas + 'CJ.104 '; end;
                        if LineasAMAZON.Q105 <> 0 then begin textocajas := textocajas + 'CJ.105 '; end;
                        if LineasAMAZON.Q106 <> 0 then begin textocajas := textocajas + 'CJ.106 '; end;
                        if LineasAMAZON.Q107 <> 0 then begin textocajas := textocajas + 'CJ.107 '; end;
                        if LineasAMAZON.Q108 <> 0 then begin textocajas := textocajas + 'CJ.108 '; end;
                        if LineasAMAZON.Q109 <> 0 then begin textocajas := textocajas + 'CJ.109 '; end;
                        if LineasAMAZON.Q110 <> 0 then begin textocajas := textocajas + 'CJ.110 '; end;
                        if LineasAMAZON.Q111 <> 0 then begin textocajas := textocajas + 'CJ.111 '; end;
                        if LineasAMAZON.Q112 <> 0 then begin textocajas := textocajas + 'CJ.112 '; end;
                        if LineasAMAZON.Q113 <> 0 then begin textocajas := textocajas + 'CJ.113 '; end;
                        if LineasAMAZON.Q114 <> 0 then begin textocajas := textocajas + 'CJ.114 '; end;
                        if LineasAMAZON.Q115 <> 0 then begin textocajas := textocajas + 'CJ.115 '; end;
                        if LineasAMAZON.Q116 <> 0 then begin textocajas := textocajas + 'CJ.116 '; end;
                        if LineasAMAZON.Q117 <> 0 then begin textocajas := textocajas + 'CJ.117 '; end;
                        if LineasAMAZON.Q118 <> 0 then begin textocajas := textocajas + 'CJ.118 '; end;
                        if LineasAMAZON.Q119 <> 0 then begin textocajas := textocajas + 'CJ.119 '; end;
                        if LineasAMAZON.Q120 <> 0 then begin textocajas := textocajas + 'CJ.120 '; end;
                        if LineasAMAZON.Q121 <> 0 then begin textocajas := textocajas + 'CJ.121 '; end;
                        if LineasAMAZON.Q122 <> 0 then begin textocajas := textocajas + 'CJ.122 '; end;
                        if LineasAMAZON.Q123 <> 0 then begin textocajas := textocajas + 'CJ.123 '; end;
                        if LineasAMAZON.Q124 <> 0 then begin textocajas := textocajas + 'CJ.124 '; end;
                        if LineasAMAZON.Q125 <> 0 then begin textocajas := textocajas + 'CJ.125 '; end;
                        if LineasAMAZON.Q126 <> 0 then begin textocajas := textocajas + 'CJ.126 '; end;
                        if LineasAMAZON.Q127 <> 0 then begin textocajas := textocajas + 'CJ.127 '; end;
                        if LineasAMAZON.Q128 <> 0 then begin textocajas := textocajas + 'CJ.128 '; end;
                        if LineasAMAZON.Q129 <> 0 then begin textocajas := textocajas + 'CJ.129 '; end;
                        if LineasAMAZON.Q130 <> 0 then begin textocajas := textocajas + 'CJ.130 '; end;
                        if LineasAMAZON.Q131 <> 0 then begin textocajas := textocajas + 'CJ.131 '; end;
                        if LineasAMAZON.Q132 <> 0 then begin textocajas := textocajas + 'CJ.132 '; end;
                        if LineasAMAZON.Q133 <> 0 then begin textocajas := textocajas + 'CJ.133 '; end;
                        if LineasAMAZON.Q134 <> 0 then begin textocajas := textocajas + 'CJ.134 '; end;
                        if LineasAMAZON.Q135 <> 0 then begin textocajas := textocajas + 'CJ.135 '; end;
                        if LineasAMAZON.Q136 <> 0 then begin textocajas := textocajas + 'CJ.136 '; end;
                        if LineasAMAZON.Q137 <> 0 then begin textocajas := textocajas + 'CJ.137 '; end;
                        if LineasAMAZON.Q138 <> 0 then begin textocajas := textocajas + 'CJ.138 '; end;
                        if LineasAMAZON.Q139 <> 0 then begin textocajas := textocajas + 'CJ.139 '; end;
                        if LineasAMAZON.Q140 <> 0 then begin textocajas := textocajas + 'CJ.140 '; end;
                        if LineasAMAZON.Q141 <> 0 then begin textocajas := textocajas + 'CJ.141 '; end;
                        if LineasAMAZON.Q142 <> 0 then begin textocajas := textocajas + 'CJ.142 '; end;
                        if LineasAMAZON.Q143 <> 0 then begin textocajas := textocajas + 'CJ.143 '; end;
                        if LineasAMAZON.Q144 <> 0 then begin textocajas := textocajas + 'CJ.144 '; end;
                        if LineasAMAZON.Q145 <> 0 then begin textocajas := textocajas + 'CJ.145 '; end;
                        if LineasAMAZON.Q146 <> 0 then begin textocajas := textocajas + 'CJ.146 '; end;
                        if LineasAMAZON.Q147 <> 0 then begin textocajas := textocajas + 'CJ.147 '; end;
                        if LineasAMAZON.Q148 <> 0 then begin textocajas := textocajas + 'CJ.148 '; end;
                        if LineasAMAZON.Q149 <> 0 then begin textocajas := textocajas + 'CJ.149 '; end;
                        if LineasAMAZON.Q150 <> 0 then begin textocajas := textocajas + 'CJ.150 '; end;
                        if LineasAMAZON.Q151 <> 0 then begin textocajas := textocajas + 'CJ.151 '; end;
                        if LineasAMAZON.Q152 <> 0 then begin textocajas := textocajas + 'CJ.152 '; end;
                        if LineasAMAZON.Q153 <> 0 then begin textocajas := textocajas + 'CJ.153 '; end;
                        if LineasAMAZON.Q154 <> 0 then begin textocajas := textocajas + 'CJ.154 '; end;
                        if LineasAMAZON.Q155 <> 0 then begin textocajas := textocajas + 'CJ.155 '; end;
                        if LineasAMAZON.Q156 <> 0 then begin textocajas := textocajas + 'CJ.156 '; end;
                        if LineasAMAZON.Q157 <> 0 then begin textocajas := textocajas + 'CJ.157 '; end;
                        if LineasAMAZON.Q158 <> 0 then begin textocajas := textocajas + 'CJ.158 '; end;
                        if LineasAMAZON.Q159 <> 0 then begin textocajas := textocajas + 'CJ.159 '; end;
                        if LineasAMAZON.Q160 <> 0 then begin textocajas := textocajas + 'CJ.160 '; end;
                        if LineasAMAZON.Q161 <> 0 then begin textocajas := textocajas + 'CJ.161 '; end;
                        if LineasAMAZON.Q162 <> 0 then begin textocajas := textocajas + 'CJ.162 '; end;
                        if LineasAMAZON.Q163 <> 0 then begin textocajas := textocajas + 'CJ.163 '; end;
                        if LineasAMAZON.Q164 <> 0 then begin textocajas := textocajas + 'CJ.164 '; end;
                        if LineasAMAZON.Q165 <> 0 then begin textocajas := textocajas + 'CJ.165 '; end;
                        if LineasAMAZON.Q166 <> 0 then begin textocajas := textocajas + 'CJ.166 '; end;
                        if LineasAMAZON.Q167 <> 0 then begin textocajas := textocajas + 'CJ.167 '; end;
                        if LineasAMAZON.Q168 <> 0 then begin textocajas := textocajas + 'CJ.168 '; end;
                        if LineasAMAZON.Q169 <> 0 then begin textocajas := textocajas + 'CJ.169 '; end;
                        if LineasAMAZON.Q170 <> 0 then begin textocajas := textocajas + 'CJ.170 '; end;
                        if LineasAMAZON.Q171 <> 0 then begin textocajas := textocajas + 'CJ.171 '; end;
                        if LineasAMAZON.Q172 <> 0 then begin textocajas := textocajas + 'CJ.172 '; end;
                        if LineasAMAZON.Q173 <> 0 then begin textocajas := textocajas + 'CJ.173 '; end;
                        if LineasAMAZON.Q174 <> 0 then begin textocajas := textocajas + 'CJ.174 '; end;
                        if LineasAMAZON.Q175 <> 0 then begin textocajas := textocajas + 'CJ.175 '; end;
                        if LineasAMAZON.Q176 <> 0 then begin textocajas := textocajas + 'CJ.176 '; end;
                        if LineasAMAZON.Q177 <> 0 then begin textocajas := textocajas + 'CJ.177 '; end;
                        if LineasAMAZON.Q178 <> 0 then begin textocajas := textocajas + 'CJ.178 '; end;
                        if LineasAMAZON.Q179 <> 0 then begin textocajas := textocajas + 'CJ.179 '; end;
                        if LineasAMAZON.Q180 <> 0 then begin textocajas := textocajas + 'CJ.180 '; end;
                        if LineasAMAZON.Q181 <> 0 then begin textocajas := textocajas + 'CJ.181 '; end;
                        if LineasAMAZON.Q182 <> 0 then begin textocajas := textocajas + 'CJ.182 '; end;
                        if LineasAMAZON.Q183 <> 0 then begin textocajas := textocajas + 'CJ.183 '; end;
                        if LineasAMAZON.Q184 <> 0 then begin textocajas := textocajas + 'CJ.184 '; end;
                        if LineasAMAZON.Q185 <> 0 then begin textocajas := textocajas + 'CJ.185 '; end;
                        if LineasAMAZON.Q186 <> 0 then begin textocajas := textocajas + 'CJ.186 '; end;
                        if LineasAMAZON.Q187 <> 0 then begin textocajas := textocajas + 'CJ.187 '; end;
                        if LineasAMAZON.Q188 <> 0 then begin textocajas := textocajas + 'CJ.188 '; end;
                        if LineasAMAZON.Q189 <> 0 then begin textocajas := textocajas + 'CJ.189 '; end;
                        if LineasAMAZON.Q190 <> 0 then begin textocajas := textocajas + 'CJ.190 '; end;
                        if LineasAMAZON.Q191 <> 0 then begin textocajas := textocajas + 'CJ.191 '; end;
                        if LineasAMAZON.Q192 <> 0 then begin textocajas := textocajas + 'CJ.192 '; end;
                        if LineasAMAZON.Q193 <> 0 then begin textocajas := textocajas + 'CJ.193 '; end;
                        if LineasAMAZON.Q194 <> 0 then begin textocajas := textocajas + 'CJ.194 '; end;
                        if LineasAMAZON.Q195 <> 0 then begin textocajas := textocajas + 'CJ.195 '; end;
                        if LineasAMAZON.Q196 <> 0 then begin textocajas := textocajas + 'CJ.196 '; end;
                        if LineasAMAZON.Q197 <> 0 then begin textocajas := textocajas + 'CJ.197 '; end;
                        if LineasAMAZON.Q198 <> 0 then begin textocajas := textocajas + 'CJ.198 '; end;
                        if LineasAMAZON.Q199 <> 0 then begin textocajas := textocajas + 'CJ.199 '; end;
                        if LineasAMAZON.Q200 <> 0 then begin textocajas := textocajas + 'CJ.200 '; end;

                        if LineasAMAZON.Q201 <> 0 then begin textocajas := textocajas + 'CJ.201 '; end;
                        if LineasAMAZON.Q202 <> 0 then begin textocajas := textocajas + 'CJ.202 '; end;
                        if LineasAMAZON.Q203 <> 0 then begin textocajas := textocajas + 'CJ.203 '; end;
                        if LineasAMAZON.Q204 <> 0 then begin textocajas := textocajas + 'CJ.204 '; end;
                        if LineasAMAZON.Q205 <> 0 then begin textocajas := textocajas + 'CJ.205 '; end;
                        if LineasAMAZON.Q206 <> 0 then begin textocajas := textocajas + 'CJ.206 '; end;
                        if LineasAMAZON.Q207 <> 0 then begin textocajas := textocajas + 'CJ.207 '; end;
                        if LineasAMAZON.Q208 <> 0 then begin textocajas := textocajas + 'CJ.208 '; end;
                        if LineasAMAZON.Q209 <> 0 then begin textocajas := textocajas + 'CJ.209 '; end;
                        if LineasAMAZON.Q210 <> 0 then begin textocajas := textocajas + 'CJ.210 '; end;
                        if LineasAMAZON.Q211 <> 0 then begin textocajas := textocajas + 'CJ.211 '; end;
                        if LineasAMAZON.Q212 <> 0 then begin textocajas := textocajas + 'CJ.212 '; end;
                        if LineasAMAZON.Q213 <> 0 then begin textocajas := textocajas + 'CJ.213 '; end;
                        if LineasAMAZON.Q214 <> 0 then begin textocajas := textocajas + 'CJ.214 '; end;
                        if LineasAMAZON.Q215 <> 0 then begin textocajas := textocajas + 'CJ.215 '; end;
                        if LineasAMAZON.Q216 <> 0 then begin textocajas := textocajas + 'CJ.216 '; end;
                        if LineasAMAZON.Q217 <> 0 then begin textocajas := textocajas + 'CJ.217 '; end;
                        if LineasAMAZON.Q218 <> 0 then begin textocajas := textocajas + 'CJ.218 '; end;
                        if LineasAMAZON.Q219 <> 0 then begin textocajas := textocajas + 'CJ.219 '; end;
                        if LineasAMAZON.Q220 <> 0 then begin textocajas := textocajas + 'CJ.220 '; end;
                        if LineasAMAZON.Q221 <> 0 then begin textocajas := textocajas + 'CJ.221 '; end;
                        if LineasAMAZON.Q222 <> 0 then begin textocajas := textocajas + 'CJ.222 '; end;
                        if LineasAMAZON.Q223 <> 0 then begin textocajas := textocajas + 'CJ.223 '; end;
                        if LineasAMAZON.Q224 <> 0 then begin textocajas := textocajas + 'CJ.224 '; end;
                        if LineasAMAZON.Q225 <> 0 then begin textocajas := textocajas + 'CJ.225 '; end;
                        if LineasAMAZON.Q226 <> 0 then begin textocajas := textocajas + 'CJ.226 '; end;
                        if LineasAMAZON.Q227 <> 0 then begin textocajas := textocajas + 'CJ.227 '; end;
                        if LineasAMAZON.Q228 <> 0 then begin textocajas := textocajas + 'CJ.228 '; end;
                        if LineasAMAZON.Q229 <> 0 then begin textocajas := textocajas + 'CJ.229 '; end;
                        if LineasAMAZON.Q230 <> 0 then begin textocajas := textocajas + 'CJ.230 '; end;
                        if LineasAMAZON.Q231 <> 0 then begin textocajas := textocajas + 'CJ.231 '; end;
                        if LineasAMAZON.Q232 <> 0 then begin textocajas := textocajas + 'CJ.232 '; end;
                        if LineasAMAZON.Q233 <> 0 then begin textocajas := textocajas + 'CJ.233 '; end;
                        if LineasAMAZON.Q234 <> 0 then begin textocajas := textocajas + 'CJ.234 '; end;
                        if LineasAMAZON.Q235 <> 0 then begin textocajas := textocajas + 'CJ.235 '; end;
                        if LineasAMAZON.Q236 <> 0 then begin textocajas := textocajas + 'CJ.236 '; end;
                        if LineasAMAZON.Q237 <> 0 then begin textocajas := textocajas + 'CJ.237 '; end;
                        if LineasAMAZON.Q238 <> 0 then begin textocajas := textocajas + 'CJ.238 '; end;
                        if LineasAMAZON.Q239 <> 0 then begin textocajas := textocajas + 'CJ.239 '; end;
                        if LineasAMAZON.Q240 <> 0 then begin textocajas := textocajas + 'CJ.240 '; end;
                        if LineasAMAZON.Q241 <> 0 then begin textocajas := textocajas + 'CJ.241 '; end;
                        if LineasAMAZON.Q242 <> 0 then begin textocajas := textocajas + 'CJ.242 '; end;
                        if LineasAMAZON.Q243 <> 0 then begin textocajas := textocajas + 'CJ.243 '; end;
                        if LineasAMAZON.Q244 <> 0 then begin textocajas := textocajas + 'CJ.244 '; end;
                        if LineasAMAZON.Q245 <> 0 then begin textocajas := textocajas + 'CJ.245 '; end;
                        if LineasAMAZON.Q246 <> 0 then begin textocajas := textocajas + 'CJ.246 '; end;
                        if LineasAMAZON.Q247 <> 0 then begin textocajas := textocajas + 'CJ.247 '; end;
                        if LineasAMAZON.Q248 <> 0 then begin textocajas := textocajas + 'CJ.248 '; end;
                        if LineasAMAZON.Q249 <> 0 then begin textocajas := textocajas + 'CJ.249 '; end;
                        if LineasAMAZON.Q250 <> 0 then begin textocajas := textocajas + 'CJ.250 '; end;
                        if LineasAMAZON.Q251 <> 0 then begin textocajas := textocajas + 'CJ.251 '; end;
                        if LineasAMAZON.Q252 <> 0 then begin textocajas := textocajas + 'CJ.252 '; end;
                        if LineasAMAZON.Q253 <> 0 then begin textocajas := textocajas + 'CJ.253 '; end;
                        if LineasAMAZON.Q254 <> 0 then begin textocajas := textocajas + 'CJ.254 '; end;
                        if LineasAMAZON.Q255 <> 0 then begin textocajas := textocajas + 'CJ.255 '; end;
                        if LineasAMAZON.Q256 <> 0 then begin textocajas := textocajas + 'CJ.256 '; end;
                        if LineasAMAZON.Q257 <> 0 then begin textocajas := textocajas + 'CJ.257 '; end;
                        if LineasAMAZON.Q258 <> 0 then begin textocajas := textocajas + 'CJ.258 '; end;
                        if LineasAMAZON.Q259 <> 0 then begin textocajas := textocajas + 'CJ.259 '; end;
                        if LineasAMAZON.Q260 <> 0 then begin textocajas := textocajas + 'CJ.260 '; end;
                        if LineasAMAZON.Q261 <> 0 then begin textocajas := textocajas + 'CJ.261 '; end;
                        if LineasAMAZON.Q262 <> 0 then begin textocajas := textocajas + 'CJ.262 '; end;
                        if LineasAMAZON.Q263 <> 0 then begin textocajas := textocajas + 'CJ.263 '; end;
                        if LineasAMAZON.Q264 <> 0 then begin textocajas := textocajas + 'CJ.264 '; end;
                        if LineasAMAZON.Q265 <> 0 then begin textocajas := textocajas + 'CJ.265 '; end;
                        if LineasAMAZON.Q266 <> 0 then begin textocajas := textocajas + 'CJ.266 '; end;
                        if LineasAMAZON.Q267 <> 0 then begin textocajas := textocajas + 'CJ.267 '; end;
                        if LineasAMAZON.Q268 <> 0 then begin textocajas := textocajas + 'CJ.268 '; end;
                        if LineasAMAZON.Q269 <> 0 then begin textocajas := textocajas + 'CJ.269 '; end;
                        if LineasAMAZON.Q270 <> 0 then begin textocajas := textocajas + 'CJ.270 '; end;
                        if LineasAMAZON.Q271 <> 0 then begin textocajas := textocajas + 'CJ.271 '; end;
                        if LineasAMAZON.Q272 <> 0 then begin textocajas := textocajas + 'CJ.272 '; end;
                        if LineasAMAZON.Q273 <> 0 then begin textocajas := textocajas + 'CJ.273 '; end;
                        if LineasAMAZON.Q274 <> 0 then begin textocajas := textocajas + 'CJ.274 '; end;
                        if LineasAMAZON.Q275 <> 0 then begin textocajas := textocajas + 'CJ.275 '; end;
                        if LineasAMAZON.Q276 <> 0 then begin textocajas := textocajas + 'CJ.276 '; end;
                        if LineasAMAZON.Q277 <> 0 then begin textocajas := textocajas + 'CJ.277 '; end;
                        if LineasAMAZON.Q278 <> 0 then begin textocajas := textocajas + 'CJ.278 '; end;
                        if LineasAMAZON.Q279 <> 0 then begin textocajas := textocajas + 'CJ.279 '; end;
                        if LineasAMAZON.Q280 <> 0 then begin textocajas := textocajas + 'CJ.280 '; end;
                        if LineasAMAZON.Q281 <> 0 then begin textocajas := textocajas + 'CJ.281 '; end;
                        if LineasAMAZON.Q282 <> 0 then begin textocajas := textocajas + 'CJ.282 '; end;
                        if LineasAMAZON.Q283 <> 0 then begin textocajas := textocajas + 'CJ.283 '; end;
                        if LineasAMAZON.Q284 <> 0 then begin textocajas := textocajas + 'CJ.284 '; end;
                        if LineasAMAZON.Q285 <> 0 then begin textocajas := textocajas + 'CJ.285 '; end;
                        if LineasAMAZON.Q286 <> 0 then begin textocajas := textocajas + 'CJ.286 '; end;
                        if LineasAMAZON.Q287 <> 0 then begin textocajas := textocajas + 'CJ.287 '; end;
                        if LineasAMAZON.Q288 <> 0 then begin textocajas := textocajas + 'CJ.288 '; end;
                        if LineasAMAZON.Q289 <> 0 then begin textocajas := textocajas + 'CJ.289 '; end;
                        if LineasAMAZON.Q290 <> 0 then begin textocajas := textocajas + 'CJ.290 '; end;
                        if LineasAMAZON.Q291 <> 0 then begin textocajas := textocajas + 'CJ.291 '; end;
                        if LineasAMAZON.Q292 <> 0 then begin textocajas := textocajas + 'CJ.292 '; end;
                        if LineasAMAZON.Q293 <> 0 then begin textocajas := textocajas + 'CJ.293 '; end;
                        if LineasAMAZON.Q294 <> 0 then begin textocajas := textocajas + 'CJ.294 '; end;
                        if LineasAMAZON.Q295 <> 0 then begin textocajas := textocajas + 'CJ.295 '; end;
                        if LineasAMAZON.Q296 <> 0 then begin textocajas := textocajas + 'CJ.296 '; end;
                        if LineasAMAZON.Q297 <> 0 then begin textocajas := textocajas + 'CJ.297 '; end;
                        if LineasAMAZON.Q298 <> 0 then begin textocajas := textocajas + 'CJ.298 '; end;
                        if LineasAMAZON.Q299 <> 0 then begin textocajas := textocajas + 'CJ.299 '; end;
                        if LineasAMAZON.Q300 <> 0 then begin textocajas := textocajas + 'CJ.300 '; end;


                        if LineasAMAZON.Q301 <> 0 then begin textocajas := textocajas + 'CJ.301 '; end;
                        if LineasAMAZON.Q302 <> 0 then begin textocajas := textocajas + 'CJ.302 '; end;
                        if LineasAMAZON.Q303 <> 0 then begin textocajas := textocajas + 'CJ.303 '; end;
                        if LineasAMAZON.Q304 <> 0 then begin textocajas := textocajas + 'CJ.304 '; end;
                        if LineasAMAZON.Q305 <> 0 then begin textocajas := textocajas + 'CJ.305 '; end;
                        if LineasAMAZON.Q306 <> 0 then begin textocajas := textocajas + 'CJ.306 '; end;
                        if LineasAMAZON.Q307 <> 0 then begin textocajas := textocajas + 'CJ.307 '; end;
                        if LineasAMAZON.Q308 <> 0 then begin textocajas := textocajas + 'CJ.308 '; end;
                        if LineasAMAZON.Q309 <> 0 then begin textocajas := textocajas + 'CJ.309 '; end;
                        if LineasAMAZON.Q310 <> 0 then begin textocajas := textocajas + 'CJ.310 '; end;
                        if LineasAMAZON.Q311 <> 0 then begin textocajas := textocajas + 'CJ.311 '; end;
                        if LineasAMAZON.Q312 <> 0 then begin textocajas := textocajas + 'CJ.312 '; end;
                        if LineasAMAZON.Q313 <> 0 then begin textocajas := textocajas + 'CJ.313 '; end;
                        if LineasAMAZON.Q314 <> 0 then begin textocajas := textocajas + 'CJ.314 '; end;
                        if LineasAMAZON.Q315 <> 0 then begin textocajas := textocajas + 'CJ.315 '; end;
                        if LineasAMAZON.Q316 <> 0 then begin textocajas := textocajas + 'CJ.316 '; end;
                        if LineasAMAZON.Q317 <> 0 then begin textocajas := textocajas + 'CJ.317 '; end;
                        if LineasAMAZON.Q318 <> 0 then begin textocajas := textocajas + 'CJ.318 '; end;
                        if LineasAMAZON.Q319 <> 0 then begin textocajas := textocajas + 'CJ.319 '; end;
                        if LineasAMAZON.Q320 <> 0 then begin textocajas := textocajas + 'CJ.320 '; end;
                        if LineasAMAZON.Q321 <> 0 then begin textocajas := textocajas + 'CJ.321 '; end;
                        if LineasAMAZON.Q322 <> 0 then begin textocajas := textocajas + 'CJ.322 '; end;
                        if LineasAMAZON.Q323 <> 0 then begin textocajas := textocajas + 'CJ.323 '; end;
                        if LineasAMAZON.Q324 <> 0 then begin textocajas := textocajas + 'CJ.324 '; end;
                        if LineasAMAZON.Q325 <> 0 then begin textocajas := textocajas + 'CJ.325 '; end;
                        if LineasAMAZON.Q326 <> 0 then begin textocajas := textocajas + 'CJ.326 '; end;
                        if LineasAMAZON.Q327 <> 0 then begin textocajas := textocajas + 'CJ.327 '; end;
                        if LineasAMAZON.Q328 <> 0 then begin textocajas := textocajas + 'CJ.328 '; end;
                        if LineasAMAZON.Q329 <> 0 then begin textocajas := textocajas + 'CJ.329 '; end;
                        if LineasAMAZON.Q330 <> 0 then begin textocajas := textocajas + 'CJ.330 '; end;
                        if LineasAMAZON.Q331 <> 0 then begin textocajas := textocajas + 'CJ.331 '; end;
                        if LineasAMAZON.Q332 <> 0 then begin textocajas := textocajas + 'CJ.332 '; end;
                        if LineasAMAZON.Q333 <> 0 then begin textocajas := textocajas + 'CJ.333 '; end;
                        if LineasAMAZON.Q334 <> 0 then begin textocajas := textocajas + 'CJ.334 '; end;
                        if LineasAMAZON.Q335 <> 0 then begin textocajas := textocajas + 'CJ.335 '; end;
                        if LineasAMAZON.Q336 <> 0 then begin textocajas := textocajas + 'CJ.336 '; end;
                        if LineasAMAZON.Q337 <> 0 then begin textocajas := textocajas + 'CJ.337 '; end;
                        if LineasAMAZON.Q338 <> 0 then begin textocajas := textocajas + 'CJ.338 '; end;
                        if LineasAMAZON.Q339 <> 0 then begin textocajas := textocajas + 'CJ.339 '; end;
                        if LineasAMAZON.Q340 <> 0 then begin textocajas := textocajas + 'CJ.340 '; end;
                        if LineasAMAZON.Q341 <> 0 then begin textocajas := textocajas + 'CJ.341 '; end;
                        if LineasAMAZON.Q342 <> 0 then begin textocajas := textocajas + 'CJ.342 '; end;
                        if LineasAMAZON.Q343 <> 0 then begin textocajas := textocajas + 'CJ.343 '; end;
                        if LineasAMAZON.Q344 <> 0 then begin textocajas := textocajas + 'CJ.344 '; end;
                        if LineasAMAZON.Q345 <> 0 then begin textocajas := textocajas + 'CJ.345 '; end;
                        if LineasAMAZON.Q346 <> 0 then begin textocajas := textocajas + 'CJ.346 '; end;
                        if LineasAMAZON.Q347 <> 0 then begin textocajas := textocajas + 'CJ.347 '; end;
                        if LineasAMAZON.Q348 <> 0 then begin textocajas := textocajas + 'CJ.348 '; end;
                        if LineasAMAZON.Q349 <> 0 then begin textocajas := textocajas + 'CJ.349 '; end;
                        if LineasAMAZON.Q350 <> 0 then begin textocajas := textocajas + 'CJ.350 '; end;
                        if LineasAMAZON.Q351 <> 0 then begin textocajas := textocajas + 'CJ.351 '; end;
                        if LineasAMAZON.Q352 <> 0 then begin textocajas := textocajas + 'CJ.352 '; end;
                        if LineasAMAZON.Q353 <> 0 then begin textocajas := textocajas + 'CJ.353 '; end;
                        if LineasAMAZON.Q354 <> 0 then begin textocajas := textocajas + 'CJ.354 '; end;
                        if LineasAMAZON.Q355 <> 0 then begin textocajas := textocajas + 'CJ.355 '; end;
                        if LineasAMAZON.Q356 <> 0 then begin textocajas := textocajas + 'CJ.356 '; end;
                        if LineasAMAZON.Q357 <> 0 then begin textocajas := textocajas + 'CJ.357 '; end;
                        if LineasAMAZON.Q358 <> 0 then begin textocajas := textocajas + 'CJ.358 '; end;
                        if LineasAMAZON.Q359 <> 0 then begin textocajas := textocajas + 'CJ.359 '; end;
                        if LineasAMAZON.Q360 <> 0 then begin textocajas := textocajas + 'CJ.360 '; end;

                    until LineasAMAZON.Next = 0;


                /////textocajas:=COPYSTR(textocajas,1,STRLEN(textocajas)-1);
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
        Amazonmaster_inner: Record "Amazon master_inner";
}

