report 50003 LineasOferta36
{
    DefaultLayout = Excel;
    ExcelLayout = './Layouts/LineasOferta36.xlsx';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No."),
                               "Document Type" = field("Document Type");
                DataItemLinkReference = "Sales Header";
                CalcFields = "Cantidad master", "Cantidad inner";

                RequestFilterFields = "Nº expedición";

                column(ReportForNavId_1000000000; 1000000000) { }
                column(Referencia; "Sales Line"."No.") { }
                column(Cantidad; "Sales Line".Quantity) { }
                column(Descripcion; "Sales Line".Description) { }
                column(GTIN; "Sales Line".ean) { }
                column(Master; "Sales Line"."Cantidad master") { }
                column(Inner; "Sales Line"."Cantidad inner") { }
                column(Q_Masters; Q_Masters) { }
                column(Q_Inners; Q_Inners) { }
                column(Q_Unidades; Q_Unidades) { }
                column(totalBultos; totalBultos) { }
                column(totalMix; totalMix) { }
                column(NumPedido; "Sales Header"."No.") { }
                column(TotalBulLin; Q_Masters + Q_Inners) { }
                column(Texto; Texto) { }
                column(Orden; Orden) { }
                column(TotalLineas; TotalLineas) { }
                column(TotalCantidad; TotalCantidad) { }
                column(YREF; YREF) { }
                column(ref; "Sales Line"."Your Reference") { }
                column(linea; "Sales Line"."Line No.") { }
                column(TOTBULTOS; totalBultos + ncajas) { }
                column(textocajas; textocajas) { }
                column(Peso; Peso) { }
                column(Tarifa; "Sales Line"."Unit Price") { }
                column(cajainnner; cajainnner) { }
                column(cajamaster; cajamaster) { }
                column(Dto; Dto) { }
                column(PrecioNeto; precioneto) { }
                column(urlprod; urlprod) { }
                column(Largo; Item.Largo) { }
                column(Ancho; Item.Ancho) { }
                column(Alto; Item.Alto) { }
                column(PesoInner; PesoInner) { }
                column(LargoInner; LargoInner) { }
                column(AnchoInner; AnchoInner) { }
                column(AltoInner; AltoInner) { }
                column(DUM14Inner; DUM14Inner) { }
                column(DUM14Master; DUM14Master) { }
                column(PesoMaster; PesoMaster) { }
                column(LargoMaster; LargoMaster) { }
                column(AnchoMaster; AnchoMaster) { }
                column(AltoMaster; AltoMaster) { }

                trigger OnAfterGetRecord()
                begin
                    Peso := ("Sales Line"."Net Weight");
                    Dto := "Sales Line"."Line Discount %";
                    if "Sales Line".Quantity <> 0 then
                        precioneto := "Sales Line".Amount / "Sales Line".Quantity
                    else
                        precioneto := 0;

                    cajainnner := 0;
                    cajamaster := 0;
                    urlprod := '';

                    if Item.Get("Sales Line"."No.") then begin
                        Item.CalcFields("Cantidad inner", "Cantidad master");
                        cajainnner := Item."Cantidad inner";
                        cajamaster := Item."Cantidad master";
                        urlprod := Item."URL IMAGEN 1";
                    end;

                    ncajas := 0;
                    CajasAMAZON.Reset();
                    CajasAMAZON.SetRange("Nº Expedicion", "Sales Line"."Nº expedición");
                    if CajasAMAZON.FindFirst() then
                        repeat
                            if CajasAMAZON.Caja > ncajas then
                                ncajas := CajasAMAZON.Caja;
                        until CajasAMAZON.Next() = 0;

                    if "Sales Line"."No." = 'TRAN' then
                        CurrReport.Skip();

                    if Item.Get("Sales Line"."No.") then
                        if Item."Producto almacenable" = false then
                            CurrReport.Skip();

                    SalesHeadertmp := "Sales Header";
                    if SalesHeadertmp.Insert() then;

                    Q_Inners := 0;
                    Q_Masters := 0;
                    Q_Unidades := 0;
                    Resto_inner := 0;
                    Resto_uni := 0;

                    if "Sales Line".Type = "Sales Line".Type::Item then begin
                        TotalLineas := TotalLineas + 1;
                        TotalCantidad := TotalCantidad + "Sales Line".Quantity;

                        if "Sales Line"."Cantidad master" <> 0 then begin
                            Q_Masters := Round("Sales Line".Quantity / "Sales Line"."Cantidad master", 1, '<');
                            if Q_Masters * "Sales Line"."Cantidad master" <> "Sales Line".Quantity then
                                Resto_inner := "Sales Line".Quantity - (Q_Masters * "Sales Line"."Cantidad master");
                        end;

                        if (Resto_inner >= "Sales Line"."Cantidad inner") and ("Sales Line"."Cantidad inner" <> 1) then begin
                            if Resto_inner <> 0 then
                                if "Sales Line"."Cantidad inner" <> 0 then begin
                                    Q_Inners := Round(Resto_inner / "Sales Line"."Cantidad inner", 1, '<');
                                    if (Q_Masters * "Sales Line"."Cantidad master") +
                                       (Q_Inners * "Sales Line"."Cantidad inner") <> "Sales Line".Quantity then
                                        Resto_uni := "Sales Line".Quantity -
                                            ((Q_Masters * "Sales Line"."Cantidad master") +
                                             (Q_Inners * "Sales Line"."Cantidad inner"));
                                end;
                        end;

                        if Resto_inner < "Sales Line"."Cantidad inner" then
                            Resto_uni := Resto_inner;

                        if "Sales Line"."Cantidad inner" = 1 then
                            Resto_uni := Resto_inner;

                        if Resto_uni <> 0 then
                            Q_Unidades := Resto_uni;
                    end;

                    totalBultos := totalBultos + Q_Masters + Q_Inners;
                    totalMix := totalMix + Q_Unidades;

                    Texto := 'T.Lineas: ' + Format(TotalLineas) + ' T.Cantidad: ' + Format(TotalCantidad);

                    Multitabla.Reset();
                    Multitabla.SetRange(Multitabla.Tabla, 17);
                    Multitabla.SetCurrentKey(Multitabla.Tabla, Multitabla.Ubicacion);
                    Multitabla.Ascending(false);
                    Multitabla.SetFilter(Multitabla.Ubicacion, '010*01|010*02');
                    Multitabla.SetRange(Producto, "Sales Line"."No.");
                    if Multitabla.FindFirst() then
                        repeat
                            Orden := Multitabla.Ubicacion;
                        until Multitabla.Next() = 0;

                    YREF := '';
                    if SalesHeadertmp.FindFirst() then
                        repeat
                            YREF := YREF + ' ' + SalesHeadertmp."Your Reference";
                        until SalesHeadertmp.Next() = 0;

                    PesoInner := 0;
                    LargoInner := 0;
                    AnchoInner := 0;
                    AltoInner := 0;
                    DUM14Inner := '';
                    DUM14Master := '';
                    PesoMaster := 0;
                    LargoMaster := 0;
                    AnchoMaster := 0;
                    AltoMaster := 0;

                    RefCruzada.Reset();
                    RefCruzada.SetRange("Item No.", "Sales Line"."No.");
                    RefCruzada.SetRange("Unit of Measure", 'IN');
                    if RefCruzada.FindFirst() then
                        DUM14Inner := RefCruzada."Reference No.";

                    RefCruzada.Reset();
                    RefCruzada.SetRange("Item No.", "Sales Line"."No.");
                    RefCruzada.SetRange("Unit of Measure", 'MA');
                    if RefCruzada.FindFirst() then
                        DUM14Master := RefCruzada."Reference No.";

                    RecUMP.Reset();
                    RecUMP.SetRange("Item No.", "Sales Line"."No.");
                    RecUMP.SetRange(Code, 'IN');
                    if RecUMP.FindFirst() then begin
                        PesoInner := RecUMP.Weight;
                        LargoInner := RecUMP.Length;
                        AnchoInner := RecUMP.Width;
                        AltoInner := RecUMP.Height;
                    end;

                    RecUMP.Reset();
                    RecUMP.SetRange("Item No.", "Sales Line"."No.");
                    RecUMP.SetRange(Code, 'MA');
                    if RecUMP.FindFirst() then begin
                        PesoMaster := RecUMP.Weight;
                        LargoMaster := RecUMP.Length;
                        AnchoMaster := RecUMP.Width;
                        AltoMaster := RecUMP.Height;
                    end;
                end;
            }
        }
    }

    requestpage
    {
        layout { }
        actions { }
    }

    labels { }

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
        Orden: Code[20];
        Multitabla: Record Multitabla;
        SalesLine: Record "Sales Line";
        SalesHeadertmp: Record "Sales Header" temporary;
        YREF: Text;
        CajasAMAZON: Record "Cajas AMAZON";
        ncajas: Integer;
        LineasAMAZON: Record "Lineas AMAZON";
        textocajas: Text;
        Peso: Decimal;
        SalesLine2: Record "Sales Line";
        RecUMP: Record "Item Unit of Measure";
        cajainnner: Decimal;
        Precioventa: Decimal;
        cajamaster: Decimal;
        Dto: Decimal;
        precioneto: Decimal;
        urlprod: Text[250];
        RefCruzada: Record "Item Reference";
        PesoInner: Decimal;
        LargoInner: Decimal;
        AnchoInner: Decimal;
        AltoInner: Decimal;
        DUM14Inner: Code[30];
        DUM14Master: Code[30];
        PesoMaster: Decimal;
        LargoMaster: Decimal;
        AnchoMaster: Decimal;
        AltoMaster: Decimal;
}
