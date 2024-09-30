#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50037 "Declaración 349 AQ"
{
    /*
    InsertAllowed = false;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Declaracion 349";
    SourceTableView = where(Registrada = const(No));

    layout
    {
        area(content)
        {
            field(VarDeclaracion; VarDeclaracion)
            {
                ApplicationArea = Basic;
                Caption = 'Declaración';

                trigger OnValidate()
                begin
                    SetRange(Declaracion, VarDeclaracion);
                    SetRange(Period, VarPeriodo);
                    CurrPage.Update(false);
                end;
            }
            field(VarPeriodo; VarPeriodo)
            {
                ApplicationArea = Basic;
                Caption = 'Periodo';
                OptionCaption = 'Anual,Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre,1er trimestre,2º trimestre,3er trimestre,4º trimestre';

                trigger OnValidate()
                begin
                    SetRange(Declaracion, VarDeclaracion);
                    SetRange(Period, VarPeriodo);
                    CurrPage.Update(false);
                end;
            }
            repeater(Group)
            {
                field(NLinea; NLinea)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExpr;
                }
                field(NOperacion; NOperacion)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExpr;
                }
                field(Tipo; Tipo)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExpr;
                }
                field(FiscalYear; FiscalYear)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExpr;
                }
                field(VAT; VAT)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExpr;
                }
                field(CIF; CIF)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExpr;
                }
                field(Nombre; Nombre)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExpr;
                }
                field(Operacion; Operacion)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExpr;
                }
                field(Importe; Importe)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExpr;
                }
                field(Facturas; Facturas)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExpr;
                }
                field("Abonos del periodo"; "Abonos del periodo")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExpr;
                }
                field("Abonos de otros periodos"; "Abonos de otros periodos")
                {
                    ApplicationArea = Basic;
                }
            }
            grid(Control1000000028)
            {
                GridLayout = Columns;
                group(Totales)
                {
                    Caption = 'Totales';
                    field(VarVentas; VarVentas)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Base Ventas';
                        Editable = false;
                    }
                    field(VarCompras; VarCompras)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Base Compras';
                        Editable = false;
                    }
                    field("VarCompras+VarVentas"; VarCompras + VarVentas)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Base Total';
                        Editable = false;
                        Style = Strong;
                        StyleExpr = true;
                    }
                }
                group(Rectificaciones)
                {
                    Caption = 'Rectificaciones';
                    field(VarBasesRectificadasOriginales; VarBasesRectificadasOriginales)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Base anterior';
                        Editable = false;
                    }
                    field(VarBasesRectificadasActuales; VarBasesRectificadasActuales)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Bases rectificadas';
                        Editable = false;
                        Style = Strong;
                        StyleExpr = true;
                    }
                    field(VarRectificaciones; VarRectificaciones)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Importe Rectificaciones';
                        Editable = false;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Calcular)
            {
                ApplicationArea = Basic;
                Caption = 'Calcular 349';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Calcular349AQ: Report UnknownReport50036;
                begin
                    Calcular349AQ.Run;
                end;
            }
            action(CalcularNegativos)
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Declaracion349: Record UnknownRecord50015;
                    CustomerVendorWarning349: Record "Customer/Vendor Warning 349";
                begin
                    Declaracion349.CopyFilters(Rec);
                    if Declaracion349.FindSet then
                        repeat
                            if (Declaracion349."Abonos del periodo" <> 0) and (Declaracion349.Facturas <> 0) then begin
                                if Declaracion349."Abonos del periodo" > Declaracion349.Facturas then begin
                                    Declaracion349."Abonos del periodo" := Declaracion349."Abonos del periodo" - Declaracion349.Facturas;
                                    Declaracion349.Facturas := 0;
                                    Declaracion349.Modify;
                                    CustomerVendorWarning349.Reset;
                                    CustomerVendorWarning349.SetRange(VAT, Declaracion349.CIF);
                                    CustomerVendorWarning349.FindFirst;
                                    CustomerVendorWarning349.Importe := Declaracion349."Abonos del periodo";
                                    CustomerVendorWarning349.Modify;
                                    if CustomerVendorWarning349.Count > 1 then
                                        while CustomerVendorWarning349.Next <> 0 do
                                            CustomerVendorWarning349.Delete;
                                end;
                            end;
                        until Declaracion349.Next = 0;
                end;
            }
            action("Filtrar Negativos")
            {
                ApplicationArea = Basic;
                Caption = 'Filtrar Negativos';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SetFilter(Importe, '<%1', 0);
                    CurrPage.Update(false);
                end;
            }
            action("Generar Fichero")
            {
                ApplicationArea = Basic;
                Caption = 'Generar Fichero';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Generar349AQ: Report UnknownReport50012;
                begin
                    Generar349AQ.Run;
                end;
            }
            action("Pasar a Histórico")
            {
                ApplicationArea = Basic;
                Caption = 'Pasar a Histórico';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Renerar349AQ: Report UnknownReport50012;
                begin
                    if Confirm('¿Desea pasar la declaración al histórico?') then begin
                        if FindSet then
                            repeat
                                "Importe Original" := Importe;
                                "Importe Actual Corregido" := Importe;
                                Registrada := true;
                                Modify;
                            until Next = 0;
                        CurrPage.Update(false);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Importe >= 0 then
            StyleExpr := 'Standart'
        else
            StyleExpr := 'Attention';

        ActualizaImportes;
    end;

    trigger OnOpenPage()
    begin
        SetRange(Declaracion, VarDeclaracion);
        SetRange(Period, VarPeriodo);
        //CurrPage.UPDATE(FALSE);

        Clear(VarVentas);
        Clear(VarCompras);
        Clear(VarRectificaciones);
        Clear(VarBasesRectificadasOriginales);
        Clear(VarBasesRectificadasActuales);
    end;

    var
        VarDeclaracion: Code[6];
        VarPeriodo: Option "0A","01","02","03","04","05","06","07","08","09","10","11","12","1T","2T","3T","4T";
        StyleExpr: Text;
        VarVentas: Decimal;
        VarCompras: Decimal;
        VarRectificaciones: Decimal;
        VarBasesRectificadasOriginales: Decimal;
        VarBasesRectificadasActuales: Decimal;

    local procedure ActualizaImportes()
    var
        Declaracion349: Record UnknownRecord50015;
        CustomerVendorWarning349: Record "Customer/Vendor Warning 349";
    begin
        Declaracion349.CopyFilters(Rec);

        Declaracion349.CalcSums("Abonos de otros periodos");
        VarRectificaciones := Declaracion349."Abonos de otros periodos";

        Declaracion349.SetRange(Tipo, Declaracion349.Tipo::Cliente);
        Declaracion349.CalcSums(Importe);
        VarVentas := Declaracion349.Importe;

        Declaracion349.SetRange(Tipo, Declaracion349.Tipo::Proveedor);
        Declaracion349.CalcSums(Importe);
        VarCompras := Declaracion349.Importe;

        CustomerVendorWarning349.Reset;
        CustomerVendorWarning349.CalcSums("Previous Declared Amount");
        CustomerVendorWarning349.CalcSums("Original Declared Amount");

        VarBasesRectificadasOriginales := CustomerVendorWarning349."Previous Declared Amount";
        VarBasesRectificadasActuales := CustomerVendorWarning349."Original Declared Amount";
    end;
    */
}

