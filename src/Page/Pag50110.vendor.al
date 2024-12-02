#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50110 vendor
{
    PageType = List;
    SourceTable = Vendor;

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
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = Basic;
                }
            }
        }




    }

    actions
    {
        area(creation)
        {
            action(Objetivocomisiones)
            {
                ApplicationArea = Suite;
                Caption = 'Objetivo comisiones';
                trigger OnAction()
                begin
                    ObjetivoVendrdorComi.Reset();
                    ;
                    ObjetivoVendrdorComi.SetRange(Vendedor, Rec."No.");
                    ObjetivoVendrdorComi.SetRange(Tipo, ObjetivoVendrdorComi.tipo::Vendedor);
                    if ObjetivoVendrdorComi.FindSet then begin
                        clear(PageObjetivosvendedorcomision);
                        PageObjetivosvendedorcomision.SetTableView(ObjetivoVendrdorComi);
                        PageObjetivosvendedorcomision.Run();
                    end;
                end;
            }
            
            action(GrupoDescuentos)
            {
                ApplicationArea = Suite;
                Caption = 'Grupo Descuentos';
                trigger OnAction()
                begin
                    ObjetivoVendrdorComi.Reset();
                    ;
                    ObjetivoVendrdorComi.SetRange(Vendedor, Rec."No.");
                    ObjetivoVendrdorComi.SetRange(Tipo, ObjetivoVendrdorComi.tipo ::"Comi-dto");
                    if ObjetivoVendrdorComi.FindSet then begin
                        clear(PageObjetivosvendedorcomision);
                        PageObjetivosvendedorcomision.SetTableView(ObjetivoVendrdorComi);
                        PageObjetivosvendedorcomision.Run();
                    end;
                end;


            }

            action(RepComisiones)
            {
                ApplicationArea = Suite;
                Caption = 'Recp. Comisiones';
                trigger OnAction()
                begin
                    SalespersonPurchaser.Reset();
                    SalespersonPurchaser.SetRange(Code, Rec."No.");                     
                    if SalespersonPurchaser.FindSet then begin
                        clear(RepComisiones);
                        RepComisiones.SetTableView(ObjetivoVendrdorComi);
                        RepComisiones.Run();
                    end;
                end;


            }

            action(DescuentoAzul)
            {
                ApplicationArea = Suite;
                Caption = 'Descuento Azul';
                trigger OnAction()
                begin
                    ObjetivoVendrdorComi.Reset();
                    ObjetivoVendrdorComi.SetRange(Vendedor, Rec."No.");                     
                    ObjetivoVendrdorComi.SetRange(Tipo, ObjetivoVendrdorComi.tipo ::Descuento);
                    if ObjetivoVendrdorComi.FindSet then begin
                        clear(PageDescuentoAzul);
                        PageDescuentoAzul.SetTableView(ObjetivoVendrdorComi);
                        PageDescuentoAzul.Run();
                    end;
                end;


            }



        }
    }
    var
        PageObjetivosvendedorcomision: Page "Objetivos vendedor comision";
        ObjetivoVendrdorComi: Record "Objetivos vendedores";
        RepComisiones: Report "Comisiones";
        PageDescuentoAzul: Page "Descuento Azul";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
}

