page 50023 TablaCajas
{
    ApplicationArea = All;
    Caption = 'TablaCajas';
    PageType = List;
    SourceTable = TablaCajas;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Sku; Rec.Sku)
                {
                    ToolTip = 'Specifies the value of the Sku field.', Comment = '%';
                }
                field(Alto; Rec.Alto)
                {
                    ToolTip = 'Specifies the value of the Alto field.', Comment = '%';
                }
                field(Ancho; Rec.Ancho)
                {
                    ToolTip = 'Specifies the value of the Ancho field.', Comment = '%';
                }
                field("Atributo Variante1"; Rec."Atributo Variante1")
                {
                    ToolTip = 'Specifies the value of the Atributo Variante1 field.', Comment = '%';
                }
                field("Atributo Variante2"; Rec."Atributo Variante2")
                {
                    ToolTip = 'Specifies the value of the Atributo Variante2 field.', Comment = '%';
                }
                field("Cantidad x caja"; Rec."Cantidad x caja")
                {
                    ToolTip = 'Specifies the value of the Cantidad x caja field.', Comment = '%';
                }
                field("Criterio de Rotacion"; Rec."Criterio de Rotacion")
                {
                    ToolTip = 'Specifies the value of the Criterio de Rotacion field.', Comment = '%';
                }
                field("Descricion marca"; Rec."Descricion marca")
                {
                    ToolTip = 'Specifies the value of the Descricion marca field.', Comment = '%';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ToolTip = 'Specifies the value of the Descripcion field.', Comment = '%';
                }
                field(Ean; Rec.Ean)
                {
                    ToolTip = 'Specifies the value of the Ean field.', Comment = '%';
                }
                field("El producto es Caja"; Rec."El producto es Caja")
                {
                    ToolTip = 'Specifies the value of the El producto es Caja field.', Comment = '%';
                }
                field("Estado web Inactivo"; Rec."Estado web Inactivo")
                {
                    ToolTip = 'Specifies the value of the Estado web Inactivo field.', Comment = '%';
                }
                field("IVA IGIC Canario"; Rec."IVA IGIC Canario")
                {
                    ToolTip = 'Specifies the value of the IVA IGIC Canario field.', Comment = '%';
                }
                field(Iva; Rec.Iva)
                {
                    ToolTip = 'Specifies the value of the Iva field.', Comment = '%';
                }
                field(Largo; Rec.Largo)
                {
                    ToolTip = 'Specifies the value of the Largo field.', Comment = '%';
                }
                field("NombreUtem Categoria"; Rec."NombreUtem Categoria")
                {
                    ToolTip = 'Specifies the value of the NombreUtem Categoria field.', Comment = '%';
                }
                field(Peso; Rec.Peso)
                {
                    ToolTip = 'Specifies the value of the Peso field.', Comment = '%';
                }
                field("Precio unitario"; Rec."Precio unitario")
                {
                    ToolTip = 'Specifies the value of the Precio unitario field.', Comment = '%';
                }
                field("Producto padre"; Rec."Producto padre")
                {
                    ToolTip = 'Specifies the value of the Producto padre field.', Comment = '%';
                }
                field("Producto web"; Rec."Producto web")
                {
                    ToolTip = 'Specifies the value of the Producto web field.', Comment = '%';
                }
                field("Proxima fecha de llegada"; Rec."Proxima fecha de llegada")
                {
                    ToolTip = 'Specifies the value of the Proxima fecha de llegada field.', Comment = '%';
                }
                field(Stock; Rec.Stock)
                {
                    ToolTip = 'Specifies the value of the Stock" field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
                field("Umbral de Stock"; Rec."Umbral de Stock")
                {
                    ToolTip = 'Specifies the value of the Umbral de Stock field.', Comment = '%';
                }
                field("Unidad de medida"; Rec."Unidad de medida")
                {
                    ToolTip = 'Specifies the value of the Unidad de medida field.', Comment = '%';
                }
                field("Unidades venta"; Rec."Unidades venta")
                {
                    ToolTip = 'Specifies the value of the Unidades venta field.', Comment = '%';
                }
                field("Valor Atributo Variante1"; Rec."Valor Atributo Variante1")
                {
                    ToolTip = 'Specifies the value of the Valor Atributo Variante1 field.', Comment = '%';
                }
                field("Valor Atributo Variante2"; Rec."Valor Atributo Variante2")
                {
                    ToolTip = 'Specifies the value of the Valor Atributo Variante2 field.', Comment = '%';
                }
                field(Volumen; Rec.Volumen)
                {
                    ToolTip = 'Specifies the value of the Volumen field.', Comment = '%';
                }
                field("Voluminoso web"; Rec."Voluminoso web")
                {
                    ToolTip = 'Specifies the value of the Voluminoso web field.', Comment = '%';
                }
            }
        }
    }
    trigger OnInit()
    var
        RecTC: Record TablaCajas;
        RecItem: Record Item;
        RecSP: Record "Sales Price";

    begiN        

    RecTC.Reset();;
    if RecTC.FindSet then repeat    
        RecTC.delete;
    until RecTC.next=0;

    RecSP.Reset();;
    IF RecSP.FindSet THEN REPEAT
        IF RecSP."Codigo concatenado"<>'' THEN begin
            RecTC.Sku:=RecSP."Codigo concatenado";
            RecItem.GET(RecSP."Item No.");
            RecTC.Alto:=RecItem.Alto;                              
            RecTC.Ancho:=RecItem.Ancho;
            //RecTC."Atributo Variante1":=RecItem.Variante1;
            //RecTC."Atributo Variante2":=RecItem.Variante2;
            ///RecTC."Cantidad x caja":=
            ///RecTC."Criterio de Rotacion":=
            ///RecTC."Descricion marca":=
            RecTC.Descripcion:=RecItem.Description;
            RecTC.Ean:=RecItem.ean;
            RecTC."El producto es Caja":=true;
            //RecTC."Estado web Inactivo":=
            RecTC."IVA IGIC Canario":=RecItem."IVA IGIC";
            ///RecTC.Iva:= 
            RecTC.Largo:=RecItem.Largo;
            ///RecTC."NombreUtem Categoria":=
            RecTC.Peso:=RecItem."Net Weight";
            //RecTC."Precio unitario":=
            //RecTC."Producto padre":= 
            //RecTC."Producto web":= 
            ///RecTC."Proxima fecha de llegada":=RecItem.fec
            //RecTC.Stock:= 
            //RecTC."Umbral de Stock":=
            //RecTC."Unidad de medida":=
            //RecTC."Unidades venta":= 
            RecTC."Valor Atributo Variante1":=RecItem."Dato Variante1";
            RecTC."Valor Atributo Variante2":=RecItem."Dato Variante2";
            RecTC.Volumen:=RecItem."Unit Volume";
            ///RecTC."Voluminoso web":=
            RecTC.INSERT;                          
        end;    
    until RecTC.next=0;            
    end;
}    
    
