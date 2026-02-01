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
        area(Creation)
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
                    ObjetivoVendrdorComi.SetRange(Tipo, ObjetivoVendrdorComi.tipo::"Comi-dto");
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

            action(RepComisionesNuevas)
            {
                ApplicationArea = Suite;
                Caption = 'Comisiones Nuevas';
                trigger OnAction()
                begin
                    SalespersonPurchaser.Reset();
                    SalespersonPurchaser.SetRange(Code, Rec."No.");
                    if SalespersonPurchaser.FindSet then begin
                        clear(RepComisionesNuevas);
                        RepComisionesNuevas.SetTableView(ObjetivoVendrdorComi);
                        RepComisionesNuevas.Run();
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
                    ObjetivoVendrdorComi.SetRange(Tipo, ObjetivoVendrdorComi.tipo::Descuento);
                    if ObjetivoVendrdorComi.FindSet then begin
                        clear(PageDescuentoAzul);
                        PageDescuentoAzul.SetTableView(ObjetivoVendrdorComi);
                        PageDescuentoAzul.Run();
                    end;
                end;


            }

            action(EscaladoComercial)
            {
                ApplicationArea = Suite;
                Caption = 'Escalado Comercial';
                trigger OnAction()
                begin
                    EscaladoComercial.Reset();
                    EscaladoComercial.SetRange(Vendedor, Rec."No.");
                    if EscaladoComercial.FindSet then begin
                        clear(PageEscaladoComercial);
                        PageEscaladoComercial.SetTableView(EscaladoComercial);
                        PageEscaladoComercial.Run();
                    end;
                end;


            }
            action(ClasifiacionComercial)
            {
                ApplicationArea = Suite;
                Caption = 'Clasifiacion Comercial';
                trigger OnAction()
                begin
                    ClasifiacionComercial.Reset();
                    ClasifiacionComercial.SetRange(Vendedor, Rec."No.");
                    if ClasifiacionComercial.FindSet then begin
                        clear(PageClasifiacio);
                        PageClasifiacio.SetTableView(ClasifiacionComercial);
                        PageClasifiacio.Run();
                    end;
                end;
            }
            action(BonusBuenos)
            {
                ApplicationArea = Suite;
                Caption = 'Bonus Buenos';
                trigger OnAction()
                begin
                    RecBonusBuenos.Reset();
                    RecBonusBuenos.SetRange(Vendedor, Rec."No.");
                    if RecBonusBuenos.FindSet then begin
                        clear(PageBonusBuenos);
                        PageBonusBuenos.SetTableView(RecBonusBuenos);
                        PageBonusBuenos.Run();
                    end;
                end;


            }
            action(BonusMalos)
            {
                ApplicationArea = Suite;
                Caption = 'Bonus Malos';
                trigger OnAction()
                begin
                    RecBuenosMalos.Reset();
                    RecBuenosMalos.SetRange(Vendedor, Rec."No.");
                    if RecBuenosMalos.FindSet then begin
                        clear(PAgeBuenosMalos);
                        PAgeBuenosMalos.SetTableView(RecBuenosMalos);
                        PAgeBuenosMalos.Run();
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
        RepComisionesNuevas: Report NuevasComisiones;
        EscaladoComercial: Record EscaladoComercial;
        PageEscaladoComercial: page EscaladoComercial;
        ClasifiacionComercial: Record ClasificacionComercial;
        PageClasifiacio: page ClasifiacionComercial;
        RecBonusBuenos: Record BonusBuenos;
        RecBuenosMalos: Record BonusMalos;
        PageBonusBuenos: page BonusBuenos;
        PAgeBuenosMalos: page BonusMalos;



}


