#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50083 "Productos Lista ubicaciones"
{
    PageType = List;
    SourceTable = Item;
    SourceTableView = sorting("Search Description")
                      where("Estado Producto" = filter(Activo | Descatalogado | "Sin actualizar"));
    /////- where("Estado Producto"=filter(Activo|Descatalogado|"Sin actualizar"|4|5));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Existencia SILLA"; Rec."Existencia SILLA")
                {
                    ApplicationArea = Basic;
                }
                field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
                {
                    ApplicationArea = Basic;
                }
                field("""Existencia SILLA""-""Qty. on Sales Order"""; Rec."Existencia SILLA" - Rec."Qty. on Sales Order")
                {
                    ApplicationArea = Basic;
                }
                field("Etiqueta portugues"; Rec."Etiqueta portugues")
                {
                    ApplicationArea = Basic;
                }
                field("Producto almacenable"; Rec."Producto almacenable")
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad palets"; Rec."Cantidad palets")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin

                        EnviaAadaia;
                    end;
                }
                field("Unidad compra"; Rec."Unidad compra")
                {
                    ApplicationArea = Basic;
                }
                field("NO MULTIPEDIDO"; Rec."NO MULTIPEDIDO")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Unidad expedicion ECI"; Rec."Unidad expedicion ECI")
                {
                    ApplicationArea = Basic;
                }
                field(ean; Rec.ean)
                {
                    ApplicationArea = Basic;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = Basic;
                }
                field("No permite pedido"; Rec."No permite pedido")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Basic;
                }
                field("Texto no permite pedido"; Rec."Texto no permite pedido")
                {
                    ApplicationArea = Basic;
                }
                field("Estado Producto"; Rec."Estado Producto")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field("Fecha Alta"; Rec."Fecha Alta")
                {
                    ApplicationArea = Basic;
                }
            }
            /////- part(Control1000000021;"Unidades medida producto')
            /////-{
            /////- SubPageLink = "Item No."=field("No.");
            /////-}
        }
    }

    actions
    {
        area(processing)
        {
            action("Inners/Masters especiales")
            {
                ApplicationArea = Basic;
                Caption = 'Inner/Masters especiales';
                Ellipsis = true;
                Image = UnitOfMeasure;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                /////- RunObject = Page "Amazon master_inner";
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin



        EnviaAadaia;
    end;

    var
        CUADAIA: Codeunit "Automaticos Cartas";

    local procedure EnviaAadaia()
    begin




        if CopyStr(COMPANYNAME, 1, 4) = 'ROLF' then begin
            CUADAIA.MODIFPROD(Rec);
        end;
    end;
}

