tableextension 50006 PurchaseLine extends "Purchase Line"
{
    fields
    {
        field(50000; "Pedido compra"; Code[10])
        {
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
        }
        field(50001; "Cantidad a pasar"; Decimal)
        {
        }
        field(50002; "Cantidad inicial"; Decimal)
        {
        }
        field(50003; Referencia; Text[50])
        {
        }
        field(50006; "Unidad de compra ficha"; Decimal)
        {
            CalcFormula = lookup(Item."Unidad compra" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50010; "Codigo Analisis"; Code[20])
        {
            TableRelation = "Grupos analisis".Codigo;
        }
        field(50011; "Analisis margenes"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const("Grupo de clientes"));
        }
        field(50018; "Estado Producto"; Option)
        {
            CalcFormula = lookup(Item."Estado Producto" where("No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Activo,Descatalogado,Anulado,Sin actualizar';
            OptionMembers = Activo,Descatalogado,Anulado,"Sin actualizar";
        }
        field(50019; ean; Code[20])
        {
            CalcFormula = lookup(Item.ean where("No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50050; "Cantidad palets"; Decimal)
        {
            CalcFormula = lookup(Item."Cantidad palets" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50051; "Cantidad master"; Decimal)
        {
            CalcFormula = lookup("Item Unit of Measure"."Qty. per Unit of Measure" where("Item No." = field("No."),
                                                                                          Code = const('MA')));
            FieldClass = FlowField;
        }
        field(50052; "Cantidad inner"; Decimal)
        {
            CalcFormula = lookup("Item Unit of Measure"."Qty. per Unit of Measure" where("Item No." = field("No."),
                                                                                          Code = const('IN')));
            FieldClass = FlowField;
        }
        field(50072; "Producto almacenable"; Boolean)
        {
            CalcFormula = lookup(Item."Producto almacenable" where("No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50073; "Tariff No."; Code[20])
        {
            CalcFormula = lookup(Item."Tariff No." where("No." = field("No.")));
            Caption = 'Tariff No.';
            FieldClass = FlowField;
            TableRelation = "Tariff Number";
        }
        field(50114; "Base IVA aduanas"; Decimal)
        {
        }
        field(50115; "Proveedor Importación"; Code[10])
        {
            TableRelation = Vendor;
        }
        field(50116; "% IVA Importación"; Decimal)
        {
        }
        field(50117; "Fecha Lanzamiento"; Date)
        {
            CalcFormula = lookup(Item."Fecha Lanzamiento" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50120; "Oferta para permite pedido"; Boolean)
        {
        }
    }
}
