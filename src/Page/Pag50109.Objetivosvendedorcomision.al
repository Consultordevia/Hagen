page 50109 "Objetivos vendedor comision"
{
    ApplicationArea = All;
    Caption = 'Objetivos vendedor comision';
    PageType = List;
    SourceTable = "Objetivos vendedores";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Vendedor; Rec.Vendedor)
                {
                    ToolTip = 'Specifies the value of the Vendedor field.', Comment = '%';
                }
                field(Tipo; Rec.Tipo)
                {
                    ToolTip = 'Specifies the value of the Tipo field.', Comment = '%';
                }
                field("Código"; Rec."Código")
                {
                    ToolTip = 'Specifies the value of the Código field.', Comment = '%';
                }
                field("Año"; Rec."Año")
                {
                    ToolTip = 'Specifies the value of the Año field.', Comment = '%';
                }
                field(Enero; Rec.Enero)
                {
                    ToolTip = 'Specifies the value of the Enero field.', Comment = '%';
                }
                field(Febrero; Rec.Febrero)
                {
                    ToolTip = 'Specifies the value of the Febrero field.', Comment = '%';
                }
                field(Marzo; Rec.Marzo)
                {
                    ToolTip = 'Specifies the value of the Marzo field.', Comment = '%';
                }
                field(Abril; Rec.Abril)
                {
                    ToolTip = 'Specifies the value of the Abril field.', Comment = '%';
                }
                field(Mayo; Rec.Mayo)
                {
                    ToolTip = 'Specifies the value of the Mayo field.', Comment = '%';
                }
                field(Junio; Rec.Junio)
                {
                    ToolTip = 'Specifies the value of the Junio field.', Comment = '%';
                }
                field(Julio; Rec.Julio)
                {
                    ToolTip = 'Specifies the value of the Julio field.', Comment = '%';
                }
                field(Agosto; Rec.Agosto)
                {
                    ToolTip = 'Specifies the value of the Agosto field.', Comment = '%';
                }
                field(Septiembre; Rec.Septiembre)
                {
                    ToolTip = 'Specifies the value of the Septiembre field.', Comment = '%';
                }
                field(Octubre; Rec.Octubre)
                {
                    ToolTip = 'Specifies the value of the Octubre field.', Comment = '%';
                }
                field(Noviembre; Rec.Noviembre)
                {
                    ToolTip = 'Specifies the value of the Noviembre field.', Comment = '%';
                }
                field(Diciembre; Rec.Diciembre)
                {
                    ToolTip = 'Specifies the value of the Diciembre field.', Comment = '%';
                }
                field(Anual; Rec.Anual)
                {
                    ToolTip = 'Specifies the value of the Anual field.', Comment = '%';
                }
                field("Importe tramos"; Rec."Importe tramos")
                {
                    ToolTip = 'Specifies the value of the Importe tramos field.', Comment = '%';
                }
                field("% Incremento por tramo"; Rec."% Incremento por tramo")
                {
                    ToolTip = 'Specifies the value of the % Incremento por tramo field.', Comment = '%';
                }
                field("% Decremento 1"; Rec."% Decremento 1")
                {
                    ToolTip = 'Specifies the value of the % Decremento 1 field.', Comment = '%';
                }
                field("% Decremento 2"; Rec."% Decremento 2")
                {
                    ToolTip = 'Specifies the value of the % Decremento 2 field.', Comment = '%';
                }
                field(Desde; Rec.Desde)
                {
                    ToolTip = 'Specifies the value of the Desde field.', Comment = '%';
                }
                field("Decremento comisión"; Rec."Decremento comisión")
                {
                    ToolTip = 'Specifies the value of the Decremento comisión field.', Comment = '%';
                }
                field(Porcentaje; Rec.Porcentaje)
                {
                    ToolTip = 'Specifies the value of the Porcentaje field.', Comment = '%';
                }
                field(Importe; Rec.Importe)
                {
                    ToolTip = 'Specifies the value of the Importe field.', Comment = '%';
                }
                field("Descripicon producto"; Rec."Descripicon producto")
                {
                    ToolTip = 'Specifies the value of the Descripicon producto field.', Comment = '%';
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ToolTip = 'Specifies the value of the Cantidad field.', Comment = '%';
                }
            }
        }
    }
}
