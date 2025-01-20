#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50025 Demanda
{
    AutoSplitKey = true;
    ApplicationArea = All;
    Caption = 'Demanda';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SaveValues = true;
    SourceTable = "Requisition Line";
    SourceTableView = sorting("Worksheet Template Name", "Journal Batch Name", "Line No.")
                      where("Worksheet Template Name" = const('APROV.'),
                            "Journal Batch Name" = const('DEMANDA'));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = Planning;
                    StyleExpr = color;
                    ToolTip = 'Specifies the number of the general ledger account or item to be entered on the line.';

                    trigger OnValidate()
                    begin
                        /////-ReqJnlManagement.GetDescriptionAndRcptName(Rec,Description2,BuyFromVendorName);
                        /////-ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Unidad de compra"; Rec."Unidad de compra")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Planning;
                    /////-StyleExpr = color;
                    ToolTip = 'Specifies text that describes the entry.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Vendor.Name"; Vendor.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Nombre Proveedor';
                    Editable = false;
                    /////-StyleExpr = color;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = Planning;
                    /////-StyleExpr = color;
                    ToolTip = 'Specifies additional text describing the entry, or a remark about the requisition worksheet line.';
                    Visible = false;
                }
                field("Dispo.actual"; Rec."Dispo.actual")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Dispo.futura"; Rec."Dispo.futura")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Línea"; Rec.Línea)
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field(Clasificacion; Rec.Clasificacion)
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Cantidad en presupuestos"; Rec."Cantidad en presupuestos")
                {
                    ApplicationArea = Basic;
                }
                field(Total; Rec.Total)
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field(Coste; Rec.Coste)
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field(Media; Rec.Media)
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Media dia de ult. x meses"; Rec."Media dia de ult. x meses")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field(Stock; Rec.Stock)
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Para dias stock"; Rec."Para dias stock")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field(Pedir; Rec.Pedir)
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Dias rearov."; Rec."Dias rearov.")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field(Contenedor; Rec.Contenedor)
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field(Pedido; Rec.Pedido)
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field(Fecha2; Rec.Fecha2)
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Fecha oferta 1"; Rec."Fecha oferta 1")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Pedido oferta 1"; Rec."Pedido oferta 1")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fecha oferta 2"; Rec."Fecha oferta 2")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Pedido oferta 2"; Rec."Pedido oferta 2")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fecha oferta 3"; Rec."Fecha oferta 3")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Pedido oferta 3"; Rec."Pedido oferta 3")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fecha oferta 4"; Rec."Fecha oferta 4")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Pedido oferta 4"; Rec."Pedido oferta 4")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fecha contenedor 1"; Rec."Fecha contenedor 1")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Pedido contenedor 1"; Rec."Pedido contenedor 1")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fecha contenedor 2"; Rec."Fecha contenedor 2")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Pedido contenedor 2"; Rec."Pedido contenedor 2")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Stock Futuro"; Rec."Stock Futuro")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Para dias futuro"; Rec."Para dias futuro")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Cantidad master"; Rec."Cantidad master")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field(Propuesta; Rec.Propuesta)
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Para dias propuesta"; Rec."Para dias propuesta")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Tot.disp.mes"; Rec."Tot.disp.mes")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Tot.disp.fut."; Rec."Tot.disp.fut.")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Fecha lanzamiento"; Rec."Fecha lanzamiento")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Sin stock"; Rec."Sin stock")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Meses media"; Rec."Meses media")
                {
                    ApplicationArea = Basic;
                    /////-StyleExpr = color;
                }
                field("Canridad en pedidos venta"; Rec."Canridad en pedidos venta")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                }
                field("Intervalo-12"; Rec."Intervalo-12")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Presupuesto-12"; Rec."Presupuesto-12")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Intervalo-11"; Rec."Intervalo-11")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Presupuesto-11"; Rec."Presupuesto-11")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Intervalo-10"; Rec."Intervalo-10")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Presupuesto-10"; Rec."Presupuesto-10")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Intervalo-9"; Rec."Intervalo-9")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Presupuesto-9"; Rec."Presupuesto-9")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Intervalo-8"; Rec."Intervalo-8")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Presupuesto-8"; Rec."Presupuesto-8")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Intervalo-7"; Rec."Intervalo-7")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Presupuesto-7"; Rec."Presupuesto-7")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Intervalo-6"; Rec."Intervalo-6")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Presupuesto-6"; Rec."Presupuesto-6")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Intervalo-5"; Rec."Intervalo-5")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Presupuesto-5"; Rec."Presupuesto-5")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Intervalo-4"; Rec."Intervalo-4")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Presupuesto-4"; Rec."Presupuesto-4")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Intervalo-3"; Rec."Intervalo-3")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Presupuesto-3"; Rec."Presupuesto-3")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Intervalo-2"; Rec."Intervalo-2")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Presupuesto-2"; Rec."Presupuesto-2")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Intervalo-1"; Rec."Intervalo-1")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field("Presupuesto-1"; Rec."Presupuesto-1")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    /////-StyleExpr = color;
                }
                field(Temporalidad; RECITEM.Temporalidad)
                {
                    ApplicationArea = Basic;
                    /////-Editable = false;
                }
                field("Objetivo Anual"; RECITEM."Objetivo Anual")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Objetivo trimestre 1"; RECITEM."Objetivo trimestre 1")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Objetivo trimestre 2"; RECITEM."Objetivo trimestre 2")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Objetivo trimestre 3"; RECITEM."Objetivo trimestre 3")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Objetivo trimestre 4"; RECITEM."Objetivo trimestre 4")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Volumen; RECITEM."Unit Volume")
                {
                    ApplicationArea = Basic;
                }
                field("Observaciones AMAZON"; Rec."Observaciones AMAZON")
                {
                    ApplicationArea = Basic;
                }

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Card)
                {
                    ApplicationArea = Planning;
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    /////-RunObject = Codeunit "Req. Wksh.-Show Card";
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or change detailed information about the item or resource.';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(Recalcula_Datos)
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Recalcula;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ReqJnlManagement.GetDescriptionAndRcptName(Rec, Description2, BuyFromVendorName);
    end;

    trigger OnAfterGetRecord()
    begin

        Vendor.Init;
        if Vendor.Get(Rec."Vendor No.") then begin
        end;


        Rec.ShowShortcutDimCode(ShortcutDimCode);



        color := '';
        if Rec.Pedir then begin
            color := 'Unfavorable';
        end;

        if Rec."Observaciones AMAZON" <> '' then begin
            color := 'Favorable';
        end;


        /*
        
        color1:='';
        IF sSTOCK<=0 THEN BEGIN
             color1 :='Unfavorable';
        END;
        COLORITEM:='';
        color2:='';
        color3:='';
        colordes:='';
        
        {
             IF Item."Clasificación A,B,C"=1 THEN BEGIN
                  fnColorCelda('A'+FORMAT(intFila),0,5,TRUE);
                  fnCrearCelda('A' + FORMAT(intFila),FORMAT(Item."No."));
                  fnCrearCelda('D' + FORMAT(intFila),FORMAT(Item."Clasificación A,B,C"));
             END;
             }
             IF Rec.Clasificacion='A' THEN BEGIN
                  COLORITEM:='Unfavorable';
             END;
             {
             IF Totdispmes>12 THEN BEGIN
                  fnColorCelda('B'+FORMAT(intFila),0,1,TRUE);
                  fnCrearCelda('B' + FORMAT(intFila),'+12 MESES');
             END;
             IF Totdispmes>48 THEN BEGIN
                  fnColorCelda('B'+FORMAT(intFila),0,2,TRUE);
                  fnCrearCelda('B' + FORMAT(intFila),'+48 MESES');
             END;
             IF Totdispmes<=12 THEN BEGIN
                  fnColorCelda('B'+FORMAT(intFila),0,3,TRUE);
                  fnCrearCelda('B' + FORMAT(intFila),'-12 MESES');
             END;
             IF Totdispmes<=6 THEN BEGIN
                  fnColorCelda('B'+FORMAT(intFila),0,4,TRUE);
                  fnCrearCelda('B' + FORMAT(intFila),'-6 MESES');
             END;
             IF Totdispmes<=4 THEN BEGIN
                  fnColorCelda('B'+FORMAT(intFila),0,5,TRUE);
                  fnCrearCelda('B' + FORMAT(intFila),'-4 MESES');
             END;
             IF Totdispmes<=2 THEN BEGIN
                  fnColorCelda('B'+FORMAT(intFila),0,6,TRUE);
                  fnCrearCelda('B' + FORMAT(intFila),'-2 MESES');
             END;
        
             IF Totdispfut>12 THEN BEGIN
                  fnColorCelda('C'+FORMAT(intFila),0,1,TRUE);
                  fnCrearCelda('C' + FORMAT(intFila),'+12 MESES');
             END;
             IF Totdispfut>48 THEN BEGIN
                  fnColorCelda('C'+FORMAT(intFila),0,2,TRUE);
                  fnCrearCelda('C' + FORMAT(intFila),'+48 MESES');
             END;
             IF Totdispfut<=12 THEN BEGIN
                  fnColorCelda('C'+FORMAT(intFila),0,3,TRUE);
                  fnCrearCelda('C' + FORMAT(intFila),'-12 MESES');
             END;
             IF Totdispfut<=6 THEN BEGIN
                  fnColorCelda('C'+FORMAT(intFila),0,4,TRUE);
                  fnCrearCelda('C' + FORMAT(intFila),'-6 MESES');
             END;
             IF Totdispfut<=4 THEN BEGIN
                  fnColorCelda('C'+FORMAT(intFila),0,5,TRUE);
                  fnCrearCelda('C' + FORMAT(intFila),'-4 MESES');
             END;
             IF Totdispfut<=2 THEN BEGIN
                  fnColorCelda('C'+FORMAT(intFila),0,6,TRUE);
                  fnCrearCelda('C' + FORMAT(intFila),'-2 MESES');
             END;
        
             IF Item."Clasificación A,B,C"=1 THEN BEGIN
                  fnColorCelda('D'+FORMAT(intFila),0,5,TRUE);
                  fnCrearCelda('D' + FORMAT(intFila),FORMAT(Item.Description));
                  fnColorCelda('E'+FORMAT(intFila),0,5,TRUE);
                  fnCrearCelda('E' + FORMAT(intFila),FORMAT(Item."Gen. Prod. Posting Group"));
                  fnCrearCelda('F' + FORMAT(intFila),FORMAT(Item."Clasificación A,B,C"));
             END;
             }
             IF Rec.Clasificacion='A' THEN BEGIN
               colordes:='Unfavorable';
             END;
        
        
        */

        RECITEM.Get(Rec."No.");

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Rec."Accept Action Message" := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ReqJnlManagement.SetUpNewLine(Rec, xRec);
        Clear(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin

        /*
        OpenedFromBatch := ("Journal Batch Name" <> '') AND ("Worksheet Template Name" = '');
        IF OpenedFromBatch THEN BEGIN
          CurrentJnlBatchName := "Journal Batch Name";
          ReqJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
          EXIT;
        END;
        ReqJnlManagement.TemplateSelection(PAGE::"Req. Worksheet",FALSE,0,Rec,JnlSelected);
        IF NOT JnlSelected THEN
          ERROR('');
        ReqJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
        */

    end;

    var
        SalesHeader: Record "Sales Header";
        GetSalesOrder: Report "Get Sales Orders";
        CalculatePlan: Report "Calculate Plan - Req. Wksh.";
        ReqJnlManagement: Codeunit ReqJnlManagement;
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        ChangeExchangeRate: Page "Change Exchange Rate";
        SalesOrder: Page "Sales Order";
        CurrentJnlBatchName: Code[10];
        Description2: Text[50];
        BuyFromVendorName: Text[50];
        ShortcutDimCode: array[8] of Code[20];
        OpenedFromBatch: Boolean;
        "------ demanda": Integer;
        CantIntervaloPre: array[12] of Decimal;
        CantIntervalo: array[12] of Decimal;
        INTERVALOD: array[12] of Date;
        INTERVALOH: array[12] of Date;
        MediaTotal: Decimal;
        RECITEM: Record Item;
        I: Integer;
        Item: Record Item;
        TTOTAL: Decimal;
        IntervaloMeses: Integer;
        Cdadpedcompra: Decimal;
        cCOSTE: Decimal;
        sSTOCK: Decimal;
        sStockFuturo: Decimal;
        Totdispmes: Decimal;
        Totdispfut: Decimal;
        PROPUESTA: Decimal;
        cCONTENEDOR: Decimal;
        pPEDIDO: Decimal;
        FECHAC: Date;
        FECHAP: Date;
        RecLC: Record "Purchase Line";
        DIVIDE: Integer;
        RequisitionLine: Record "Requisition Line";
        CONTADOR: Integer;
        VENTANA: Dialog;
        Item22: Record Item;
        mMedia: Decimal;
        color1: Text;
        COLORITEM: Text;
        color2: Text;
        color3: Text;
        colordes: Text;
        Vendor: Record Vendor;
        para1: Decimal;
        para2: Decimal;
        para3: Decimal;
        media3: Decimal;
        desde3m: Date;
        total3m: Decimal;
        DIASCAL: Integer;
        DIASCALF: Code[20];
        color: Text;
        TIPOCAL: Code[1];
        SALE: Boolean;
        PARA4: Decimal;
        CONTA: Integer;
        pPropuesta: Decimal;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        SalesLine22: Record "Sales Line";
        sumaofertas: Decimal;
        TTsumaofertas: Decimal;
        SalesHeader22: Record "Sales Header";
        SUMACPV: Decimal;
        nofer: Integer;
        v: Dialog;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SaveRecord;
        ReqJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.Update(false);
    end;

    local procedure Recalcula()
    begin


        PurchasesPayablesSetup.Get;

        IntervaloMeses := 12;


        INTERVALOD[1] := CalcDate('-1M', Today);
        INTERVALOD[2] := CalcDate('-2M', Today);
        INTERVALOD[3] := CalcDate('-3M', Today);
        INTERVALOD[4] := CalcDate('-4M', Today);
        INTERVALOD[5] := CalcDate('-5M', Today);
        INTERVALOD[6] := CalcDate('-6M', Today);
        INTERVALOD[7] := CalcDate('-7M', Today);
        INTERVALOD[8] := CalcDate('-8M', Today);
        INTERVALOD[9] := CalcDate('-9M', Today);
        INTERVALOD[10] := CalcDate('-10M', Today);
        INTERVALOD[11] := CalcDate('-11M', Today);
        INTERVALOD[12] := CalcDate('-12M', Today);

        INTERVALOH[1] := CalcDate('+1M', INTERVALOD[1]);
        INTERVALOH[2] := CalcDate('+1M', INTERVALOD[2]);
        INTERVALOH[3] := CalcDate('+1M', INTERVALOD[3]);
        INTERVALOH[4] := CalcDate('+1M', INTERVALOD[4]);
        INTERVALOH[5] := CalcDate('+1M', INTERVALOD[5]);
        INTERVALOH[6] := CalcDate('+1M', INTERVALOD[6]);
        INTERVALOH[7] := CalcDate('+1M', INTERVALOD[7]);
        INTERVALOH[8] := CalcDate('+1M', INTERVALOD[8]);
        INTERVALOH[9] := CalcDate('+1M', INTERVALOD[9]);
        INTERVALOH[10] := CalcDate('+1M', INTERVALOD[10]);
        INTERVALOH[11] := CalcDate('+1M', INTERVALOD[11]);
        INTERVALOH[12] := CalcDate('+1M', INTERVALOD[12]);


        INTERVALOD[1] := CalcDate('+1D', INTERVALOD[1]);
        INTERVALOD[2] := CalcDate('+1D', INTERVALOD[2]);
        INTERVALOD[3] := CalcDate('+1D', INTERVALOD[3]);
        INTERVALOD[4] := CalcDate('+1D', INTERVALOD[4]);
        INTERVALOD[5] := CalcDate('+1D', INTERVALOD[5]);
        INTERVALOD[6] := CalcDate('+1D', INTERVALOD[6]);
        INTERVALOD[7] := CalcDate('+1D', INTERVALOD[7]);
        INTERVALOD[8] := CalcDate('+1D', INTERVALOD[8]);
        INTERVALOD[9] := CalcDate('+1D', INTERVALOD[9]);
        INTERVALOD[10] := CalcDate('+1D', INTERVALOD[10]);
        INTERVALOD[11] := CalcDate('+1D', INTERVALOD[11]);
        INTERVALOD[12] := CalcDate('+1D', INTERVALOD[12]);

        desde3m := CalcDate('-' + Format(PurchasesPayablesSetup."Meses calculo demanda") + 'M', Today);

        VENTANA.Open('#1#############################/' +
                     '#2#############################/' +
                     '#3#############################/' +
                     '#4#############################/' +
                     '#5#############################/' +
                     '#6#############################/' +
                     '#7#############################');

        RequisitionLine.Reset;
        RequisitionLine.SetRange("Worksheet Template Name", 'APROV.');
        RequisitionLine.SetRange("Journal Batch Name", 'DEMANDA');
        if RequisitionLine.FindSet then
            repeat
                RequisitionLine.Delete;
                VENTANA.Update(1, 'eliminando ' + Format(RequisitionLine."Line No."));
            until RequisitionLine.Next = 0;



        Item.Reset;
        Item.SetRange("Estado Producto", Item."estado producto"::Activo);
        ///Item.SetFilter("No.",'1*');
        Item.SetRange("Producto almacenable", true);
        if Item.FindSet then
            repeat
                VENTANA.Update(1, '1-' + Format(Item."No."));
                
                Cdadpedcompra := 0;
                TTOTAL := 0;
                TTsumaofertas := 0;
                sumaofertas := 0;
                Clear(CantIntervalo);
                Clear(CantIntervaloPre);
                I := 12 - IntervaloMeses;
                DIVIDE := 0;
                repeat
                    I := I + 1;
                    RECITEM.Reset;
                    RECITEM.Get(Item."No.");
                    RECITEM.SetRange(RECITEM."Date Filter", INTERVALOD[I], INTERVALOH[I]);
                    RECITEM.CalcFields(RECITEM."Cantidad facturada", RECITEM."Cantidad abonada", RECITEM."Cantidad fabricada");
                    CantIntervalo[I] := RECITEM."Cantidad facturada" + RECITEM."Cantidad abonada"; /////+RECITEM."Cantidad fabricada"*-1;
                    TTOTAL := TTOTAL + CantIntervalo[I];
                    sumaofertas := 0;
                    SalesLine22.Reset;
                    SalesLine22.SetCurrentkey("Document Type", "No.", "Fecha alta");
                    SalesLine22.SetRange("Document Type", SalesLine22."document type"::Quote);
                    SalesLine22.SetRange("No.", Item."No.");
                    SalesLine22.SetRange("Fecha alta", INTERVALOD[I], INTERVALOH[I]);
                    if SalesLine22.FindSet then
                        repeat
                            SalesLine22.CalcFields("Estado presupuesto");
                            if (SalesLine22."Estado presupuesto" = SalesLine22."estado presupuesto"::"Parcialmente procesado") or
                               (SalesLine22."Estado presupuesto" = SalesLine22."estado presupuesto"::Procesado) then begin
                                sumaofertas := sumaofertas + SalesLine22.Quantity;
                                TTsumaofertas := TTsumaofertas + SalesLine22.Quantity;
                                CantIntervaloPre[I] := CantIntervaloPre[I] + SalesLine22.Quantity;
                            end;
                        until SalesLine22.Next = 0;

                    TTOTAL := TTOTAL + sumaofertas;

                    if CantIntervalo[I] <> 0 then begin
                        DIVIDE := DIVIDE + 1;
                    end;


                until I = 12;
                
                VENTANA.Update(2, '2-' + Format(Item."No."));

                SUMACPV := 0;
                SalesLine22.Reset;
                SalesLine22.SetCurrentkey("Document Type", "No.", "Outstanding Quantity");
                SalesLine22.SetRange("Document Type", SalesLine22."document type"::Order);
                SalesLine22.SetRange("No.", Item."No.");
                SalesLine22.SetFilter("Outstanding Quantity", '<>0');
                if SalesLine22.FindSet then
                    repeat
                        if SalesHeader22.Get(SalesLine22."Document Type", SalesLine22."Document No.") then begin
                            if (SalesHeader22."Estado pedido" = SalesHeader22."estado pedido"::"Para preparar") or
                               (SalesHeader22."Estado pedido" = SalesHeader22."estado pedido"::"Pdte. comercial") then begin
                                SUMACPV := SUMACPV + SalesLine22.Quantity;
                            end;
                        end;
                    until SalesLine22.Next = 0;
                    
                VENTANA.Update(3, '3-' + Format(Item."No."));
                TTOTAL := TTOTAL + SUMACPV;

                total3m := CantIntervalo[1] + CantIntervalo[2] + CantIntervalo[3] + SUMACPV;
                media3 := total3m / 90;
                ///MESSAGE('Media 3 %1',media3);
                mMedia := 0;
                if DIVIDE <> 0 then begin
                    mMedia := ROUND(TTOTAL / DIVIDE, 0.01);
                end;

                RequisitionLine.Init;

                cCONTENEDOR := 0;
                FECHAC := 0D;
                nofer := 0;
                RecLC.SetCurrentkey(RecLC."Document Type", RecLC.Type, RecLC."No.");
                RecLC.SetRange(RecLC."Document Type", 1);
                RecLC.SetRange(RecLC."No.", Item."No.");
                if RecLC.FindSet then
                    repeat
                        if RecLC."Outstanding Quantity" <> 0 then begin
                            nofer := nofer + 1;
                            cCONTENEDOR := cContenedor + RecLC."Outstanding Quantity";
                            if FECHAC = 0D then begin
                                FECHAC := RecLC."Expected Receipt Date";
                            end;

                            if nofer = 1 then begin
                                RequisitionLine."Fecha contenedor 1" := RecLC."Expected Receipt Date";
                                RequisitionLine."Pedido contenedor 1" := RecLC."Outstanding Quantity";
                            end;
                            if nofer = 2 then begin
                                RequisitionLine."Fecha contenedor 2" := RecLC."Expected Receipt Date";
                                RequisitionLine."Pedido contenedor 2" := RecLC."Outstanding Quantity";
                            end;

                        end;
                    until RecLC.Next = 0;
                VENTANA.Update(4, '4-' + Format(Item."No."));

                pPEDIDO := 0;
                FECHAP := 0D;
                nofer := 0;
                RecLC.SetCurrentkey(RecLC."Document Type", RecLC.Type, RecLC."No.");
                RecLC.SetRange(RecLC."Document Type", 0);
                RecLC.SetRange(RecLC."No.", Item."No.");
                if RecLC.FindSet then
                    repeat
                        if RecLC."Outstanding Quantity" <> 0 then begin
                            nofer := nofer + 1;
                            pPEDIDO := pPEDIDO + RecLC."Outstanding Quantity";
                            if FECHAP = 0D then begin
                                FECHAP := RecLC."Expected Receipt Date";
                            end;
                            if nofer = 1 then begin
                                RequisitionLine."Fecha oferta 1" := RecLC."Expected Receipt Date";
                                RequisitionLine."Pedido oferta 1" := RecLC."Outstanding Quantity";
                            end;
                            if nofer = 2 then begin
                                RequisitionLine."Fecha oferta 2" := RecLC."Expected Receipt Date";
                                RequisitionLine."Pedido oferta 2" := RecLC."Outstanding Quantity";
                            end;
                            if nofer = 3 then begin
                                RequisitionLine."Fecha oferta 3" := RecLC."Expected Receipt Date";
                                RequisitionLine."Pedido oferta 3" := RecLC."Outstanding Quantity";
                            end;
                            if nofer = 4 then begin
                                RequisitionLine."Fecha oferta 4" := RecLC."Expected Receipt Date";
                                RequisitionLine."Pedido oferta 4" := RecLC."Outstanding Quantity";
                            end;

                        end;
                    until RecLC.Next = 0;
                VENTANA.Update(5, '5-' + Format(Item."No."));
                Item.CalcFields("Qty. on Purch. Order", "Pro.Ped.Compra (cdad.)", Item.Inventory, Item."Existencia SILLA", "Existencia FOB");
                VENTANA.Update(1, '6-' + Format(Item."No."));
                Cdadpedcompra := Item."Qty. on Purch. Order" + Item."Pro.Ped.Compra (cdad.)";
                cCOSTE := Item."Standard Cost";
                sSTOCK := Item.Inventory - Item."Existencia FOB";
                /////sSTOCK:=Item."Existencia SILLA";
                sStockFuturo := Item.Inventory - Item."Existencia FOB" + Cdadpedcompra;
                /////sStockFuturo:=Item."Existencia SILLA"+Cdadpedcompra;
                if mMedia <> 0 then begin
                    Totdispmes := ROUND(sSTOCK / mMedia, 1);
                    Totdispfut := ROUND(sStockFuturo / mMedia, 1);
                end;
                pPropuesta := 0;
                /////IF Totdispmes<0 THEN BEGIN
                /////Propuesta:=mMedia*Item."Unidad compra";
                /////END;
                /////IF TTOTAL<>0 THEN BEGIN
                VENTANA.Update(6, '6-' + Format(Item."No."));

                RequisitionLine."Worksheet Template Name" := 'APROV.';
                RequisitionLine."Journal Batch Name" := 'DEMANDA';
                CONTADOR := CONTADOR + 1;
                RequisitionLine."Line No." := CONTADOR;
                RequisitionLine."No." := Item."No.";
                RequisitionLine."Cantidad en presupuestos" := TTsumaofertas;
                RequisitionLine.Description := Item.Description;
                if Totdispmes > 12 then begin
                    RequisitionLine."Dispo.actual" := '+12 MESES';
                end;
                if Totdispmes > 48 then begin
                    RequisitionLine."Dispo.actual" := '48 MESES';
                end;
                if Totdispmes <= 12 then begin
                    RequisitionLine."Dispo.actual" := '-12 MESES';
                end;
                if Totdispmes <= 6 then begin
                    RequisitionLine."Dispo.actual" := '-6 MESES';
                end;
                if Totdispmes <= 4 then begin
                    RequisitionLine."Dispo.actual" := '-4 MESES';
                end;
                if Totdispmes <= 2 then begin
                    RequisitionLine."Dispo.actual" := '-2 MESES';
                end;
                if Totdispfut > 12 then begin
                    RequisitionLine."Dispo.futura" := '+12 MESES';
                end;
                if Totdispfut > 48 then begin
                    RequisitionLine."Dispo.futura" := '+48 MESES';
                end;
                if Totdispfut <= 12 then begin
                    RequisitionLine."Dispo.futura" := '-12 MESES';
                end;
                if Totdispfut <= 6 then begin
                    RequisitionLine."Dispo.futura" := '-6 MESES';
                end;
                if Totdispfut <= 4 then begin
                    RequisitionLine."Dispo.futura" := '-4 MESES';
                end;
                if Totdispfut <= 2 then begin
                    RequisitionLine."Dispo.futura" := '-2 MESES';
                end;
                RequisitionLine."Vendor No." := Item."Vendor No.";
                RequisitionLine."Vendor Item No." := Item."Vendor Item No.";
                RequisitionLine.Línea := Format(Item."Gen. Prod. Posting Group");
                RequisitionLine.Clasificacion := Format(Item."Clasificación A,B,C");
                RequisitionLine."Intervalo-12" := CantIntervalo[12];
                RequisitionLine."Intervalo-11" := CantIntervalo[11];
                RequisitionLine."Intervalo-10" := CantIntervalo[10];
                RequisitionLine."Intervalo-9" := CantIntervalo[9];
                RequisitionLine."Intervalo-8" := CantIntervalo[8];
                RequisitionLine."Intervalo-7" := CantIntervalo[7];
                RequisitionLine."Intervalo-6" := CantIntervalo[6];
                RequisitionLine."Intervalo-5" := CantIntervalo[5];
                RequisitionLine."Intervalo-4" := CantIntervalo[4];
                RequisitionLine."Intervalo-3" := CantIntervalo[3];
                RequisitionLine."Intervalo-2" := CantIntervalo[2];
                RequisitionLine."Intervalo-1" := CantIntervalo[1];
                RequisitionLine."Presupuesto-1" := CantIntervaloPre[1];
                RequisitionLine."Presupuesto-2" := CantIntervaloPre[2];
                RequisitionLine."Presupuesto-3" := CantIntervaloPre[3];
                RequisitionLine."Presupuesto-4" := CantIntervaloPre[4];
                RequisitionLine."Presupuesto-5" := CantIntervaloPre[5];
                RequisitionLine."Presupuesto-6" := CantIntervaloPre[6];
                RequisitionLine."Presupuesto-7" := CantIntervaloPre[7];
                RequisitionLine."Presupuesto-8" := CantIntervaloPre[8];
                RequisitionLine."Presupuesto-9" := CantIntervaloPre[9];
                RequisitionLine."Presupuesto-10" := CantIntervaloPre[10];
                RequisitionLine."Presupuesto-11" := CantIntervaloPre[11];
                RequisitionLine."Presupuesto-12" := CantIntervaloPre[12];
                RequisitionLine."Canridad en pedidos venta" := SUMACPV;
                RequisitionLine.Total := TTOTAL;
                RequisitionLine.Coste := cCOSTE;
                RequisitionLine.Stock := sSTOCK;
                RequisitionLine.Contenedor := cCONTENEDOR;
                RequisitionLine.Fecha := FECHAC;
                RequisitionLine.Pedido := pPEDIDO;
                RequisitionLine.Fecha2 := FECHAP;
                RequisitionLine.Media := mMedia;
                RequisitionLine."Tot.disp.mes" := Totdispmes;
                RequisitionLine."Tot.disp.fut." := Totdispfut;
                RequisitionLine."Unidad de compra" := Item."Unidad compra";
                RequisitionLine."Cantidad palet" := Item."Cantidad palets";
                RequisitionLine."Fecha lanzamiento" := Item."Fecha Lanzamiento";
                Item.CalcFields("Cantidad master");
                RequisitionLine."Cantidad master" := Item."Cantidad master";
                RequisitionLine."Stock Futuro" := sStockFuturo;
                if sSTOCK <= 0 then begin
                    RequisitionLine."Sin stock" := 'Sin stock';
                    RequisitionLine."Meses media" := DIVIDE;
                end;
                para1 := 0;
                para2 := 0;
                para3 := 0;
                if media3 > 0 then begin
                    para1 := ROUND(RequisitionLine.Stock / media3, 0.01);
                    //////MESSAGE('%1 %2 %3',para1,Stock,media3);
                    para2 := ROUND(RequisitionLine."Stock Futuro" / media3, 0.01);
                    RequisitionLine."Para dias stock" := para1;
                    RequisitionLine."Para dias futuro" := para2;
                    DIASCALF := Format(Item."Lead Time Calculation");
                    if DIASCALF <> '' then begin
                        TIPOCAL := CopyStr(DIASCALF, StrLen(DIASCALF) - 1, 1);
                        DIASCALF := CopyStr(DIASCALF, 1, StrLen(DIASCALF) - 1);
                        Evaluate(DIASCAL, DIASCALF);
                        if TIPOCAL = 'D' then DIASCAL := DIASCAL + 7;
                        if TIPOCAL = 'S' then DIASCAL := (DIASCAL * 7) + 7;
                        if TIPOCAL = 'M' then DIASCAL := (DIASCAL * 30) + 7;
                        if TIPOCAL = 'T' then DIASCAL := (DIASCAL * 90) + 7;
                        if TIPOCAL = 'A' then DIASCAL := (DIASCAL * 365) + 7;
                        RequisitionLine.Pedir := false;
                        if DIASCAL > para1 then begin
                            RequisitionLine.Pedir := true;
                            if DIASCAL > para2 then begin
                                SALE := false;
                                CONTA := 0;
                                pPropuesta := Item."Unidad compra";
                                PARA4 := ROUND(((RequisitionLine."Stock Futuro" + pPropuesta) / media3), 0.01);
                                if PARA4 < DIASCAL then begin
                                    repeat
                                        CONTA := CONTA + 1;
                                        pPropuesta := pPropuesta + Item."Cantidad master";
                                        PARA4 := ROUND(((RequisitionLine."Stock Futuro" + pPropuesta) / media3), 0.01);
                                        if PARA4 > DIASCAL then begin
                                            SALE := true;
                                        end;
                                    until (SALE) or (CONTA > 200);
                                end;
                                para3 := ROUND(((RequisitionLine."Stock Futuro" + pPropuesta) / media3), 0.01);
                                RequisitionLine."Para dias propuesta" := para3;
                            end;
                        end;
                    end;
                end;
                RequisitionLine.Propuesta := pPropuesta;
                RequisitionLine."Media dia de ult. x meses" := media3;
                RequisitionLine."Dias rearov." := Item."Lead Time Calculation";
                RequisitionLine.Insert;
                VENTANA.Update(7, '7-' + Format(Item."No."));

            ///Commit();


            until Item.Next = 0;
        VENTANA.Close;
    end;
}

