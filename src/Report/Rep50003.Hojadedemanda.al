#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50003 "Hoja de demanda"
{
    //      fnColorCelda('A'+FORMAT(intFila),0,1
    //      ,TRUE); NEGRO
    //      fnColorCelda('A'+FORMAT(intFila),0,3,TRUE); ROJO
    //      fnColorCelda('A'+FORMAT(intFila),0,4,TRUE); VERDE
    //      fnColorCelda('A'+FORMAT(intFila),0,5,TRUE); AZUL
    //      fnColorCelda('A'+FORMAT(intFila),0,3,TRUE); AMARILLO

    ProcessingOnly = true;

    dataset
    {
        dataitem(Item;Item)
        {
            DataItemTableView = sorting("Search Description") where("Estado Producto"=const(Activo));
            RequestFilterFields = "No.","Gen. Prod. Posting Group",Familia,Subfamilia,"Clasificación A,B,C","Vendor No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Cdadpedcompra:=0;
                TOTAL:=0;
                Clear(CantIntervalo);
                I:=12-IntervaloMeses;
                DIVIDE:=0;
                repeat
                     I:=I+1;
                     RECITEM.Reset;
                     RECITEM.Get(Item."No.");
                     RECITEM.SetRange(RECITEM."Date Filter",INTERVALOD[I],INTERVALOH[I]);
                     RECITEM.CalcFields(RECITEM."Cantidad facturada",RECITEM."Cantidad abonada",RECITEM."Cantidad fabricada");
                     CantIntervalo[I]:=RECITEM."Cantidad facturada"+RECITEM."Cantidad abonada"+RECITEM."Cantidad fabricada"*-1;
                     TOTAL:=TOTAL+CantIntervalo[I];
                     if CantIntervalo[I]<>0 then begin
                         DIVIDE:=DIVIDE+1;
                     end;
                until  I=12;
                MEDIA:=0;
                if DIVIDE<>0 then begin
                     MEDIA:=ROUND(TOTAL/DIVIDE,0.01);
                end;
                CONTENEDOR:=0;
                FECHAC:=0D;
                RecLC.SetCurrentkey(RecLC."Document Type",RecLC.Type,RecLC."No.");
                RecLC.SetRange(RecLC."Document Type",1);
                RecLC.SetRange(RecLC."No.",Item."No.");
                if RecLC.FindFirst then repeat
                     if RecLC."Outstanding Quantity"<>0 then begin
                          CONTENEDOR:=CONTENEDOR+RecLC."Outstanding Quantity";
                          if FECHAC=0D then begin
                               FECHAC:=RecLC."Expected Receipt Date";
                          end;
                     end;
                until RecLC.Next = 0;
                PEDIDO:=0;
                FECHAP:=0D;
                RecLC.SetCurrentkey(RecLC."Document Type",RecLC.Type,RecLC."No.");
                RecLC.SetRange(RecLC."Document Type",0);
                RecLC.SetRange(RecLC."No.",Item."No.");
                if RecLC.FindFirst then repeat
                     if RecLC."Outstanding Quantity"<>0 then begin
                          PEDIDO:=PEDIDO+RecLC."Outstanding Quantity";
                          if FECHAP=0D then begin
                               FECHAP:=RecLC."Expected Receipt Date";
                          end;
                     end;
                until RecLC.Next = 0;
                Item.CalcFields("Qty. on Purch. Order","Pro.Ped.Compra (cdad.)",Item.Inventory,Item."Existencia SILLA");
                Cdadpedcompra:="Qty. on Purch. Order"+"Pro.Ped.Compra (cdad.)";
                COSTE:=Item."Unit Cost";
                STOCK:=Item."Existencia SILLA";
                StockFuturo:=Item.Inventory+Cdadpedcompra;
                if MEDIA<>0 then begin
                     Totdispmes:=ROUND(STOCK/MEDIA,1);
                     Totdispfut:=ROUND(StockFuturo/MEDIA,1);
                end;
                PROPUESTA:=0;
                if Totdispmes<0 then begin
                     PROPUESTA:=MEDIA*Item."Meses de reposición";
                end;
                if TOTAL<>0 then begin
                     if Item."Clasificación A,B,C"=2 then begin
                          fnCrearCelda('A' + Format(intFila),Format(Item."No."));
                     end;
                     if Item."Clasificación A,B,C"=1 then begin
                          fnColorCelda('A'+Format(intFila),0,5,true);
                          fnCrearCelda('A' + Format(intFila),Format(Item."No."));
                          fnCrearCelda('D' + Format(intFila),Format(Item."Clasificación A,B,C"));
                     end;
                     if Item."Clasificación A,B,C"=0 then begin
                          fnColorCelda('A'+Format(intFila),0,3,true);
                          fnCrearCelda('A' + Format(intFila),Format(Item."No."));
                     end;
                     if Totdispmes>12 then begin
                          fnColorCelda('B'+Format(intFila),0,1,true);
                          fnCrearCelda('B' + Format(intFila),'+12 MESES');
                     end;
                     if Totdispmes>48 then begin
                          fnColorCelda('B'+Format(intFila),0,2,true);
                          fnCrearCelda('B' + Format(intFila),'+48 MESES');
                     end;
                     if Totdispmes<=12 then begin
                          fnColorCelda('B'+Format(intFila),0,3,true);
                          fnCrearCelda('B' + Format(intFila),'-12 MESES');
                     end;
                     if Totdispmes<=6 then begin
                          fnColorCelda('B'+Format(intFila),0,4,true);
                          fnCrearCelda('B' + Format(intFila),'-6 MESES');
                     end;
                     if Totdispmes<=4 then begin
                          fnColorCelda('B'+Format(intFila),0,5,true);
                          fnCrearCelda('B' + Format(intFila),'-4 MESES');
                     end;
                     if Totdispmes<=2 then begin
                          fnColorCelda('B'+Format(intFila),0,6,true);
                          fnCrearCelda('B' + Format(intFila),'-2 MESES');
                     end;
                     if Totdispfut>12 then begin
                          fnColorCelda('C'+Format(intFila),0,1,true);
                          fnCrearCelda('C' + Format(intFila),'+12 MESES');
                     end;
                     if Totdispfut>48 then begin
                          fnColorCelda('C'+Format(intFila),0,2,true);
                          fnCrearCelda('C' + Format(intFila),'+48 MESES');
                     end;
                     if Totdispfut<=12 then begin
                          fnColorCelda('C'+Format(intFila),0,3,true);
                          fnCrearCelda('C' + Format(intFila),'-12 MESES');
                     end;
                     if Totdispfut<=6 then begin
                          fnColorCelda('C'+Format(intFila),0,4,true);
                          fnCrearCelda('C' + Format(intFila),'-6 MESES');
                     end;
                     if Totdispfut<=4 then begin
                          fnColorCelda('C'+Format(intFila),0,5,true);
                          fnCrearCelda('C' + Format(intFila),'-4 MESES');
                     end;
                     if Totdispfut<=2 then begin
                          fnColorCelda('C'+Format(intFila),0,6,true);
                          fnCrearCelda('C' + Format(intFila),'-2 MESES');
                     end;
                     if Item."Clasificación A,B,C"=2 then begin
                          fnCrearCelda('D' + Format(intFila),Format(Item.Description));
                          fnCrearCelda('E' + Format(intFila),Format(Item."Gen. Prod. Posting Group"));
                          fnCrearCelda('F' + Format(intFila),Format(Item."Clasificación A,B,C"));
                     end;
                     if Item."Clasificación A,B,C"=1 then begin
                          fnColorCelda('D'+Format(intFila),0,5,true);
                          fnCrearCelda('D' + Format(intFila),Format(Item.Description));
                          fnColorCelda('E'+Format(intFila),0,5,true);
                          fnCrearCelda('E' + Format(intFila),Format(Item."Gen. Prod. Posting Group"));
                          fnCrearCelda('F' + Format(intFila),Format(Item."Clasificación A,B,C"));
                     end;
                     if Item."Clasificación A,B,C"=0 then begin
                          fnColorCelda('D'+Format(intFila),0,3,true);
                          fnCrearCelda('D' + Format(intFila),Format(Item.Description));
                          fnColorCelda('E'+Format(intFila),0,3,true);
                          fnCrearCelda('E' + Format(intFila),Format(Item."Gen. Prod. Posting Group"));
                          fnCrearCelda('F' + Format(intFila),Format(Item."Clasificación A,B,C"));
                     end;
                     if IntervaloMeses=12 then begin
                          fnCrearCelda('G' + Format(intFila),Format(CantIntervalo[12]));
                     end;
                     if IntervaloMeses>=11 then begin
                          fnCrearCelda('H' + Format(intFila),Format(CantIntervalo[11]));
                     end;
                     if IntervaloMeses>=10 then begin
                          fnCrearCelda('I' + Format(intFila),Format(CantIntervalo[10]));
                     end;
                     if IntervaloMeses>=9 then begin
                          fnCrearCelda('J' + Format(intFila),Format(CantIntervalo[9]));
                     end;
                     if IntervaloMeses>=8 then begin
                          fnCrearCelda('K' + Format(intFila),Format(CantIntervalo[8]));
                     end;
                     if IntervaloMeses>=7 then begin
                          fnCrearCelda('L' + Format(intFila),Format(CantIntervalo[7]));
                     end;
                     if IntervaloMeses>=6 then begin
                          fnCrearCelda('M' + Format(intFila),Format(CantIntervalo[6]));
                     end;
                     if IntervaloMeses>=5 then begin
                          fnCrearCelda('N' + Format(intFila),Format(CantIntervalo[5]));
                     end;
                     if IntervaloMeses>=4 then begin
                          fnCrearCelda('O' + Format(intFila),Format(CantIntervalo[4]));
                     end;
                     if IntervaloMeses>=3 then begin
                          fnCrearCelda('P' + Format(intFila),Format(CantIntervalo[3]));
                     end;
                     if IntervaloMeses>=2 then begin
                          fnCrearCelda('Q' + Format(intFila),Format(CantIntervalo[2]));
                     end;
                     if IntervaloMeses>=1 then begin
                          fnCrearCelda('R' + Format(intFila),Format(CantIntervalo[1]));
                     end;
                     fnCrearCelda('S' + Format(intFila),Format(TOTAL));
                     fnCrearCelda('T' + Format(intFila),Format(COSTE));
                     fnCrearCelda('U' + Format(intFila),Format(STOCK));
                     fnCrearCelda('V' + Format(intFila),Format(CONTENEDOR));
                     fnCrearCelda('W' + Format(intFila),Format(FECHAC));
                     fnCrearCelda('X' + Format(intFila),Format(PEDIDO));
                     fnCrearCelda('Y' + Format(intFila),Format(FECHAP));
                     fnCrearCelda('Z' + Format(intFila),Format(StockFuturo));
                     fnCrearCelda('AA' + Format(intFila),Format(MEDIA));
                     fnCrearCelda('AB' + Format(intFila),Format(Totdispmes));
                     fnCrearCelda('AC' + Format(intFila),Format(Totdispfut));
                     fnCrearCelda('AD' + Format(intFila),Format(Item."Unidad compra"));
                     fnCrearCelda('AE' + Format(intFila),Format(Item."Cantidad palets"));
                     fnCrearCelda('AF' + Format(intFila),Format(PROPUESTA));
                     fnCrearCelda('AG' + Format(intFila),Format(Item."Fecha Lanzamiento"));
                     if STOCK<=0 then begin
                        fnColorCelda('AH'+Format(intFila),0,3,true);
                        fnCrearCelda('AH' + Format(intFila),'Sin stock');
                     end;
                     fnCrearCelda('AI' + Format(intFila),Format(DIVIDE));
                     intFila := intFila + 1;
                end;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No.");
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
                    field(IntervaloMeses;IntervaloMeses)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Intervalo Meses';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IntervaloMeses:=12;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        INTERVALOD[1]:=CalcDate('-1M',Today);
        INTERVALOD[2]:=CalcDate('-2M',Today);
        INTERVALOD[3]:=CalcDate('-3M',Today);
        INTERVALOD[4]:=CalcDate('-4M',Today);
        INTERVALOD[5]:=CalcDate('-5M',Today);
        INTERVALOD[6]:=CalcDate('-6M',Today);
        INTERVALOD[7]:=CalcDate('-7M',Today);
        INTERVALOD[8]:=CalcDate('-8M',Today);
        INTERVALOD[9]:=CalcDate('-9M',Today);
        INTERVALOD[10]:=CalcDate('-10M',Today);
        INTERVALOD[11]:=CalcDate('-11M',Today);
        INTERVALOD[12]:=CalcDate('-12M',Today);
        INTERVALOH[1]:=CalcDate('+1M',INTERVALOD[1]);
        INTERVALOH[2]:=CalcDate('+1M',INTERVALOD[2]);
        INTERVALOH[3]:=CalcDate('+1M',INTERVALOD[3]);
        INTERVALOH[4]:=CalcDate('+1M',INTERVALOD[4]);
        INTERVALOH[5]:=CalcDate('+1M',INTERVALOD[5]);
        INTERVALOH[6]:=CalcDate('+1M',INTERVALOD[6]);
        INTERVALOH[7]:=CalcDate('+1M',INTERVALOD[7]);
        INTERVALOH[8]:=CalcDate('+1M',INTERVALOD[8]);
        INTERVALOH[9]:=CalcDate('+1M',INTERVALOD[9]);
        INTERVALOH[10]:=CalcDate('+1M',INTERVALOD[10]);
        INTERVALOH[11]:=CalcDate('+1M',INTERVALOD[11]);
        INTERVALOH[12]:=CalcDate('+1M',INTERVALOD[12]);
        INTERVALOD[1]:=CalcDate('+1D',INTERVALOD[1]);
        INTERVALOD[2]:=CalcDate('+1D',INTERVALOD[2]);
        INTERVALOD[3]:=CalcDate('+1D',INTERVALOD[3]);
        INTERVALOD[4]:=CalcDate('+1D',INTERVALOD[4]);
        INTERVALOD[5]:=CalcDate('+1D',INTERVALOD[5]);
        INTERVALOD[6]:=CalcDate('+1D',INTERVALOD[6]);
        INTERVALOD[7]:=CalcDate('+1D',INTERVALOD[7]);
        INTERVALOD[8]:=CalcDate('+1D',INTERVALOD[8]);
        INTERVALOD[9]:=CalcDate('+1D',INTERVALOD[9]);
        INTERVALOD[10]:=CalcDate('+1D',INTERVALOD[10]);
        INTERVALOD[11]:=CalcDate('+1D',INTERVALOD[11]);
        INTERVALOD[12]:=CalcDate('+1D',INTERVALOD[12]);
        fnCrearAut;
        intFila := 1;
          fnCrearHoja('HOJA DEMANDA',90);
          fnCrearCelda('A' + Format(intFila),'Producto');
          fnCrearCelda('B' + Format(intFila),'Dispo.actual');
          fnCrearCelda('C' + Format(intFila),'Dispo.futura');
          fnCrearCelda('D' + Format(intFila),'Descripcion');
          fnCrearCelda('E' + Format(intFila),'Línea');
          fnCrearCelda('F' + Format(intFila),'Clasificacion');
          fnCrearCelda('G' + Format(intFila),Format(INTERVALOD[12])+'-'+Format(INTERVALOH[12]));
          fnCrearCelda('H' + Format(intFila),Format(INTERVALOD[11])+'-'+Format(INTERVALOH[11]));
          fnCrearCelda('I' + Format(intFila),Format(INTERVALOD[10])+'-'+Format(INTERVALOH[10]));
          fnCrearCelda('J' + Format(intFila),Format(INTERVALOD[9])+'-'+Format(INTERVALOH[9]));
          fnCrearCelda('K' + Format(intFila),Format(INTERVALOD[8])+'-'+Format(INTERVALOH[8]));
          fnCrearCelda('L' + Format(intFila),Format(INTERVALOD[7])+'-'+Format(INTERVALOH[7]));
          fnCrearCelda('M' + Format(intFila),Format(INTERVALOD[6])+'-'+Format(INTERVALOH[6]));
          fnCrearCelda('N' + Format(intFila),Format(INTERVALOD[5])+'-'+Format(INTERVALOH[5]));
          fnCrearCelda('O' + Format(intFila),Format(INTERVALOD[4])+'-'+Format(INTERVALOH[4]));
          fnCrearCelda('P' + Format(intFila),Format(INTERVALOD[3])+'-'+Format(INTERVALOH[3]));
          fnCrearCelda('Q' + Format(intFila),Format(INTERVALOD[2])+'-'+Format(INTERVALOH[2]));
          fnCrearCelda('R' + Format(intFila),Format(INTERVALOD[1])+'-'+Format(INTERVALOH[1]));
          fnCrearCelda('S' + Format(intFila),'Total');
          fnCrearCelda('T' + Format(intFila),'Coste');
          fnCrearCelda('U' + Format(intFila),'Stock');
          fnCrearCelda('V' + Format(intFila),'Contenedor');
          fnCrearCelda('W' + Format(intFila),'Fecha');
          fnCrearCelda('X' + Format(intFila),'Pedido');
          fnCrearCelda('Y' + Format(intFila),'Fecha');
          fnCrearCelda('Z' + Format(intFila),'Stock Futuro');
          fnCrearCelda('AA' + Format(intFila),'Media');
          fnCrearCelda('AB' + Format(intFila),'Tot.disp.mes');
          fnCrearCelda('AC' + Format(intFila),'Tot.disp.fut.');
          fnCrearCelda('AD' + Format(intFila),'Unidad de compra');
          fnCrearCelda('AE' + Format(intFila),'Cantidad palet');
          fnCrearCelda('AF' + Format(intFila),'Propuesta');
          fnCrearCelda('AG' + Format(intFila),'Fecha lanzamiento');
          fnCrearCelda('AH' + Format(intFila),'Sin stock');
          fnCrearCelda('AI' + Format(intFila),'Meses media');
          intFila := intFila + 1;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        CantIntervalo: array [12] of Decimal;
        INTERVALOD: array [12] of Date;
        INTERVALOH: array [12] of Date;
        MediaTotal: Decimal;
        RECITEM: Record Item;
        I: Integer;
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
        TOTAL: Decimal;
        IntervaloMeses: Integer;
        MEDIA: Decimal;
        Cdadpedcompra: Decimal;
        COSTE: Decimal;
        STOCK: Decimal;
        StockFuturo: Decimal;
        Totdispmes: Decimal;
        Totdispfut: Decimal;
        PROPUESTA: Decimal;
        CONTENEDOR: Decimal;
        PEDIDO: Decimal;
        FECHAC: Date;
        FECHAP: Date;
        RecLC: Record "Purchase Line";
        DIVIDE: Integer;


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

