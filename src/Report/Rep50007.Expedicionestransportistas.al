#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50007 "_Expediciones transportistas"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Shipment Header";"Sales Shipment Header")
        {
            DataItemTableView = sorting("Nº expedición");
            RequestFilterFields = "Nº expedición","Posting Date","Sell-to Customer No.","Shipping Agent Code";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Sales Shipment Header"."Nº expedición"='' then begin
                     CurrReport.Skip;
                end;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Nº expedición");
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

    trigger OnPreReport()
    begin
        RecCE.Get;
        fnCrearAut;
        intFila := 1;
          fnCrearHoja('EXPEDICIONES TRANSPORTISTAS',90);
          fnCrearCelda('A' + Format(intFila),'Expedicion');
          fnCrearCelda('B' + Format(intFila),'Fecha');
          fnCrearCelda('C' + Format(intFila),'Cliente');
          fnCrearCelda('D' + Format(intFila),'Nombre cliente');
          fnCrearCelda('E' + Format(intFila),'Poblacion envio');
          fnCrearCelda('F' + Format(intFila),'Provincia envio');
          fnCrearCelda('G' + Format(intFila),'Transportista');
          fnCrearCelda('H' + Format(intFila),'Bultos');
          fnCrearCelda('I' + Format(intFila),'Palets');
          fnCrearCelda('J' + Format(intFila),'Dimensiones');
          fnCrearCelda('K' + Format(intFila),'Zona');
          fnCrearCelda('L' + Format(intFila),'Kilos');
          fnCrearCelda('M' + Format(intFila),'Kilos del Volumen');
          fnCrearCelda('N' + Format(intFila),'Modif.');
          fnCrearCelda('O' + Format(intFila),'Precio');
          fnCrearCelda('P' + Format(intFila),'Albaranes');
          intFila := intFila + 1;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Window: Dialog;
        ItemAmount: Record "Item Amount";
        ItemAmount2: Record "Item Amount";
        ItemFilter: Text[250];
        ItemDateFilter: Text[30];
        Sequence: Text[30];
        Heading: Text[30];
        ShowSorting: Option Largest,Smallest;
        ShowType: Option "Sales (LCY)";
        NoOfRecordsToPrint: Integer;
        PrintAlsoIfZero: Boolean;
        ItemSales: Decimal;
        QtyOnHand: Decimal;
        SalesAmountPct: Decimal;
        QtyOnHandPct: Decimal;
        MaxAmount: Decimal;
        BarText: Text[50];
        i: Integer;
        Acumu: Decimal;
        TAcumu: Decimal;
        Tanto: Decimal;
        Clasi: Option A,B,C;
        RecCE: Record "Sales & Receivables Setup";
        TA: Decimal;
        TB: Decimal;
        TC: Decimal;
        Tipo: Option Propuesta,"Guardar datos";
        Rec1: Record "Sales Price";
        pvp: Decimal;
        dato1: Decimal;
        dato2: Decimal;
        CONTA: Integer;
        RecItem: Record Item;
        Tcanti: Decimal;
        tantoa: Decimal;
        tantob: Decimal;
        autXLApp: Automation ;
        autXLLibros: Automation ;
        autXLLibro: Automation ;
        autXLHojas: Automation ;
        autXLHoja: Automation ;
        autXLGraficos: Automation ;
        autXLGrafico: Automation ;
        autXLChart: Automation ;
        autXLRango: Automation ;
        autXLSeries: Automation ;
        autXLEjes: Automation ;
        autXLEjes1: Automation ;
        autXLSerieColeccion: Automation ;
        autXLSerie: Integer;
        intFila: Integer;
        PVMEDIO: Decimal;
        RecSP: Record "Sales Price";
        ROTACION: Decimal;
        DESDEFECHA: Date;
        HASTAFECHA: Date;
        DIAS: Integer;
        XX: Integer;
        CODLETRA: array [60] of Code[10];
        CODMES: array [60] of Date;
        NMES: Integer;
        "NAÑO": Integer;
        FECHAINI: Date;
        RecItem2: Record Item;
        canti: Decimal;
        desdeini: Date;
        hastafin: Date;
        mesescompra: Integer;
        sumatot: Decimal;
        mediamensual: Decimal;
        ZONA: Decimal;
        KILOS: Decimal;
        VOLUMEN: Decimal;
        PRECIO: Decimal;
        BULTOS: Decimal;
        RecMT3: Record UnknownRecord50022;
        CODZONA: Code[20];
        Rec111: Record "Sales Shipment Line";
        RecArea: Record "Area";
        RecCP: Record "Post Code";
        BUSCA: Decimal;
        TEXTOALBARANES: Text[1000];
        DIMENSIONES: Text[1000];
        MODIF: Code[3];


    procedure fnCrearAut()
    begin
        Create(autXLApp);
        autXLApp.WindowState := -4143;
        autXLLibros := autXLApp.Workbooks;
        autXLLibro  := autXLLibros.Add;
        autXLHojas  := autXLLibro.Worksheets;
        autXLApp.Visible := true;
    end;


    procedure fnElimnarAut()
    begin
        //autXLApp.Columns.EntireColumn.AutoFit;
        autXLApp.Visible := true;
        Clear(autXLChart);
        Clear(autXLHoja);
        Clear(autXLHojas);
        Clear(autXLLibro);
        Clear(autXLLibros);
        Clear(autXLApp);
    end;


    procedure fnCrearHoja(txtNombreHoja: Text[100];intZoom: Integer)
    begin
        autXLHojas.Add;
        autXLHoja := autXLLibro.ActiveSheet;
        autXLHoja.Name := txtNombreHoja;
        autXLApp.ActiveWindow.Zoom := intZoom;
    end;


    procedure fnCrearCelda(txtCelda: Text[30];txtValor: Text[100])
    begin
        autXLHoja.Range(txtCelda).Value := txtValor;
    end;


    procedure fnFormatoCelda(txtCelda: Text[100];txtFormato: Text[100])
    begin
        autXLHoja.Range(txtCelda).NumberFormat := txtFormato;
    end;


    procedure fnAliniacionCelda(txtCelda: Text[100];intHorAli: Integer)
    begin
        autXLHoja.Range(txtCelda).HorizontalAlignment := intHorAli;
    end;


    procedure fnColorCelda(pnRango: Text[100];pnColorInterior: Integer;pnColorFuente: Integer;pnNegrita: Boolean)
    begin
        autXLHoja.Range(pnRango).Interior.ColorIndex := pnColorInterior;
        autXLHoja.Range(pnRango).Font.ColorIndex := pnColorFuente;
        autXLHoja.Range(pnRango).Font.Bold := pnNegrita;
    end;


    procedure fnBordes(pnRango: Text[100];pnBorde: Integer;pnLinea: Integer;pnAncho: Integer;pnColor: Integer)
    begin
        autXLHoja.Range(pnRango).Borders.Item(pnBorde).LineStyle := pnLinea;
        autXLHoja.Range(pnRango).Borders.Item(pnBorde).Weight    := pnAncho;
        autXLHoja.Range(pnRango).Borders.Item(pnBorde).Color     := pnColor;
    end;


    procedure fnGraficoCrear(pnTop: Integer;pnPosicion: Integer;pnAncho: Integer;pnAlto: Integer;"pnTamaño": Integer)
    begin
        autXLGraficos := autXLHoja.ChartObjects;
        autXLGrafico := autXLGraficos.Add(pnTop,pnPosicion,pnAlto,pnAncho);
        autXLChart   := autXLGrafico.Chart;
        //autXLChart.ChartArea.Width := pnTamaño;
    end;


    procedure fnGraficoParam(pnRango: Text[30];pnTipo: Integer;pnLeyLeft: Integer;pnLeyTop: Integer)
    begin
        autXLRango := autXLHoja.Range(pnRango);
        autXLChart.SetSourceData(autXLRango,'xlColumns');
        autXLChart.ChartType(pnTipo);
        autXLChart.PlotArea.Interior.ColorIndex := -4142;
        autXLChart.Legend.Left := pnLeyLeft;
        autXLChart.Legend.Top  := pnLeyTop;
        //autXLChart.ChartArea.Width := 692;
        //autXLChart.Legend.Font.Size := 10;
    end;


    procedure fnGraficoSeries(pnSerie: Integer;pnColor: Integer;pnTipoGrafico: Integer;pnMarca: Integer;pnPrimerPlano: Integer;pnSegundoPlano: Integer)
    begin
        autXLSerieColeccion := autXLChart.SeriesCollection;
        autXLSerieColeccion.Item(pnSerie).Interior.ColorIndex := pnColor;
        autXLSerieColeccion.Item(pnSerie).ChartType   := pnTipoGrafico;
        if pnTipoGrafico = 65 then begin
         autXLSerieColeccion.Item(pnSerie).Border.ColorIndex := pnColor;
         autXLSerieColeccion.Item(pnSerie).MarkerBackgroundColorIndex := pnPrimerPlano;
         autXLSerieColeccion.Item(pnSerie).MarkerForegroundColorIndex := pnSegundoPlano;
         autXLSerieColeccion.Item(pnSerie).MarkerStyle := pnMarca;
         autXLSerieColeccion.Item(pnSerie).Border.Weight := 4;
        end;
    end;


    procedure fnGraficoEjes(pnMenor: Integer;pnMayor: Integer)
    begin
        autXLEjes           := autXLChart.Axes(2);
        autXLEjes.MinorUnit := pnMenor;
        autXLEjes.MajorUnit := pnMayor;
        autXLEjes.DisplayUnit := -6;
        /*
        autXLEjes1     := autXLChart.Axes(1);
        autXLEjes1.TickLabels.Orientation := 90;
        //autXLEjes1.TickLabels.Font.Size   := 10;
        */
        Clear(autXLEjes);
        /*
        CLEAR(autXLEjes1);
        */

    end;


    procedure fnOrientacionEjes(pnOrientacion: Integer)
    begin
        autXLChart.PlotBy := pnOrientacion;
    end;


    procedure fnFormatoEjes(pnEje: Integer)
    begin
        //autXLEjes := autXLChart.Axes(pnEje);
        //autXLEjes.TickLabels.Font.Name := 'Verdana';
        //autXLEjes.TickLabels.Font.Size := 25;
    end;


    procedure fnGrabarHoja(Carpeta: Text[250])
    begin
        if Exists(Carpeta) then
          exit;
        autXLLibro.__SaveAs(Carpeta);
    end;
}

