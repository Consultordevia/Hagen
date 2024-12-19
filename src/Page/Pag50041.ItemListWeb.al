page 50041 ItemListWeb
{
    ApplicationArea = All;
    Caption = 'ItemListWeb';
    PageType = List;
    SourceTable = Item;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the item.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item.';
                }
                field("PVP-Web"; Rec."PVP-Web")
                {
                    ToolTip = 'Specifies a description of the item.';
                }
                field("Ref. AMAZON";Rec."Ref. AMAZON")
                {
                    ToolTip = 'Specifies a description of the item.';
                }
                field("Permite fraccionar venta"; Rec."Permite fraccionar venta")
                {
                    ToolTip = 'Specifies the value of the Permite fraccionar venta field.', Comment = '%';
                }
                field("Fecha Lanzamiento"; Rec."Fecha Lanzamiento")
                {
                    ToolTip = 'Specifies the value of the Fecha Lanzamiento field.', Comment = '%';
                }
                field("Producto FRAGIL"; Rec."Producto FRAGIL")
                {
                    ToolTip = 'Specifies the value of the Producto FRAGIL field.', Comment = '%';
                }
                field("Criterio rotacion"; Rec."Criterio rotacion")
                {
                    ToolTip = 'Specifies the value of the Criterio rotacion field.', Comment = '%';
                }
                field("Unidades venta"; Rec."Unidades venta")
                {
                    ToolTip = 'Specifies the value of the Unidades venta field.', Comment = '%';
                }
                field("Fecha en picking"; Rec."Fecha en picking")
                {
                    ToolTip = 'Specifies the value of the Fecha en picking field.', Comment = '%';
                }
                field("Fecha disponible Web"; Rec."Fecha disponible Web")
                {
                    ToolTip = 'Specifies the value of the Fecha disponible Web field.', Comment = '%';
                }
                field("Producto PADRE"; Rec."Producto PADRE")
                {
                    ToolTip = 'Specifies the value of the Producto PADRE field.', Comment = '%';
                }
                field("Producto web"; Rec."Producto web")
                {
                    ToolTip = 'Specifies the value of the Producto web field.', Comment = '%';
                }
                field("Estado WEB Inactivo"; Rec."Estado WEB Inactivo")
                {
                    ToolTip = 'Specifies the value of the Estado WEB Inactivo field.', Comment = '%';
                }
                field("Estado Producto"; Rec."Estado Producto")
                {
                    ToolTip = 'Specifies the value of the Estado Producto field.', Comment = '%';
                }
                field("Voluminoso web"; Rec."Voluminoso web")
                {
                    ToolTip = 'Specifies the value of the Voluminoso web field.', Comment = '%';
                }
                field(ean; Rec.ean)
                {
                    ToolTip = 'Specifies the value of the ean field.', Comment = '%';
                }
                field("IVA IGIC"; Rec."IVA IGIC")
                {
                    ToolTip = 'Specifies the value of the IVA IGIC field.', Comment = '%';
                }
                field(Alto; Rec.Alto)
                {
                    ToolTip = 'Specifies the value of the Alto field.', Comment = '%';
                }
                field(Ancho; Rec.Ancho)
                {
                    ToolTip = 'Specifies the value of the Ancho field.', Comment = '%';
                }
                field(Largo; Rec.Largo)
                {
                    ToolTip = 'Specifies the value of the Largo field.', Comment = '%';
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ToolTip = 'Specifies the gross weight of the item.';
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                    ToolTip = 'Specifies the volume of one unit of the item.';
                }
                field(Marca; Rec.Marca)
                {
                    ToolTip = 'Specifies the value of the Marca field.', Comment = '%';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the VAT specification of the involved item or resource to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                }
                field("Umbral stock"; Rec."Umbral stock")
                {
                    ToolTip = 'Specifies the value of the Umbral stock field.', Comment = '%';
                }
                field(CodVariante1; Rec.CodVariante1)
                {
                    ToolTip = 'Specifies the value of the CodVariante1 field.', Comment = '%';
                }
                field("Dato Variante1"; Rec."Dato Variante1")
                {
                    ToolTip = 'Specifies the value of the Dato Variante1 field.', Comment = '%';
                }
                field(CodVariante2; Rec.CodVariante2)
                {
                    ToolTip = 'Specifies the value of the CodVariante2 field.', Comment = '%';
                }
                field("Dato Variante2"; Rec."Dato Variante2")
                {
                    ToolTip = 'Specifies the value of the Dato Variante2 field.', Comment = '%';
                }
                field(Disponible; dispo)
                {
                    ApplicationArea = ALL;
                }
                field(DescripMarca; DescripMarca)
                {
                    ApplicationArea = All;
                }

                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }

                field(NombreItemCategoria; NombreItemCategoria)
                {
                    ApplicationArea = All;
                }
                field("Descripcion web"; Rec."Descripcion web")
                {
                    ApplicationArea = All;
                }
                field(Level1; Rec.Level1)
                {
                    ApplicationArea = All;
                }
                field(Level2; Rec.Level2)
                {
                    ApplicationArea = All;
                }
                field(Level3; Rec.Level3)
                {
                    ApplicationArea = All;
                }
                field(Etiquetas1; Rec.Etiquetas1)
                {
                    ApplicationArea = All;
                }
                field(Etiquetas2; Rec.Etiquetas2)
                {
                    ApplicationArea = All;
                }
                field(Etiquetas3; Rec.Etiquetas3)
                {
                    ApplicationArea = All;
                }
                field(Etiquetas4; Rec.Etiquetas4)
                {
                    ApplicationArea = All;
                }
                field(Etiquetas5; Rec.Etiquetas5)
                {
                    ApplicationArea = All;
                }
                field(Etiquetas6; Rec.Etiquetas6)
                {
                    ApplicationArea = All;
                }
                field(Gama; Rec.Gama)
                {
                    ApplicationArea = All;
                }
                field("Imagen Articulo WEB 2"; Rec."Imagen Articulo WEB 2")
                {
                    ApplicationArea = All;
                }

                field("Imagen Articulo WEB 3"; Rec."Imagen Articulo WEB 3")
                {
                    ApplicationArea = All;
                }

                field("Imagen Articulo WEB 4"; Rec."Imagen Articulo WEB 4")
                {
                    ApplicationArea = All;
                }







            }
        }
    }
    trigger OnAfterGetRecord()
    var
        pmp: Decimal;
        InventarioPMP: Record "Inventario PMP";

    begin
        DescripMarca := '';
        IF RecMulti.GET(RecMulti.Tabla::Marcas, Rec.Marca) then begin
            DescripMarca := RecMulti."Descripcion";
        end;
        rec.CalcFields("Existencia SILLA", "Qty. on Sales Order");
        dispo := rec."Existencia SILLA" - rec."Qty. on Sales Order" - rec."Stock para Catit";

        NombreItemCategoria := '';
        if itemcat.get(Rec."Item Category Code") then begin
            NombreItemCategoria := itemcat.Description;
        end;

        pmp := 0;
        InventarioPMP.RESET;
        InventarioPMP.SETRANGE(InventarioPMP."Item No.", Rec."No.");
        IF InventarioPMP.FINDLAST THEN BEGIN
            pmp := InventarioPMP."Unit Cost";
        end;
    end;

    var
        dispo: Decimal;
        RecMulti: Record Multitabla;
        DescripMarca: Text;


        itemcat: Record "Item Category";
        NombreItemCategoria: text;
        pmp: Decimal;
        InventarioPMP: Record "Inventario PMP";



}
