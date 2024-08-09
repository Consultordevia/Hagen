#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50012 "Cesta compra"
{

    fields
    {
        field(1; "Código"; Code[20])
        {
            TableRelation = if (Tipo = const(Cliente)) Customer."No." where("No." = field(Código))
            else if (Tipo = const(Proveedor)) Vendor."No." where("No." = field(Código));
        }
        field(2; Referencia; Code[20])
        {
        }
        field(3; "Descripción"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field(Referencia)));
            FieldClass = FlowField;
        }
        field(5; "Cantidad a Comprar"; Decimal)
        {

            trigger OnValidate()
            begin

                if "Cantidad a Comprar" = 0 then begin
                    Comprar := false;
                end;
                if "Cantidad a Comprar" <> 0 then begin
                    Comprar := true;
                end;
            end;
        }
        field(6; "Línea"; Code[20])
        {
        }
        field(7; Familia; Code[30])
        {
        }
        field(8; Subfamilia; Code[30])
        {
        }
        field(9; "Fecha ultimo pedido"; Date)
        {
        }
        field(10; "Historico cantidad pedida"; Decimal)
        {
            CalcFormula = sum("Sales Line".Quantity where("Sell-to Customer No." = field(Código),
                                                           "No." = field(Referencia)));
            FieldClass = FlowField;
        }
        field(11; Comprar; Boolean)
        {

            trigger OnValidate()
            begin

                if Comprar = true then begin
                    "Cantidad a Comprar" := 1;
                end;
                if Comprar = false then begin
                    "Cantidad a Comprar" := 0;
                end;
            end;
        }
        field(12; Tipo; Option)
        {
            OptionMembers = Cliente,Proveedor;
        }
        field(13; "Filtro fecha"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(14; "Cantidad enviada"; Decimal)
        {
            CalcFormula = sum("Sales Shipment Line".Quantity where("No." = field(Referencia),
                                                                    "Sell-to Customer No." = field(Código),
                                                                    "Shipment Date" = field("Filtro fecha")));
            FieldClass = FlowField;
        }
        field(15; Importe; Decimal)
        {
            CalcFormula = sum("Sales Shipment Line"."Item Charge Base Amount" where("No." = field(Referencia),
                                                                                     "Sell-to Customer No." = field(Código),
                                                                                     "Shipment Date" = field("Filtro fecha")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Tipo, "Código", Referencia)
        {
            Clustered = true;
        }
        key(Key2; Tipo, "Código", Comprar)
        {
        }
        key(Key3; Tipo, "Código", "Línea", Familia, Subfamilia)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin



        if Rec1.Get(Referencia) then begin
            Línea := Rec1."Gen. Prod. Posting Group";
            Familia := Rec1.Familia;
            Subfamilia := Rec1.Subfamilia;
        end;
        "Fecha ultimo pedido" := Today;
    end;

    var
        Rec1: Record Item;
}

