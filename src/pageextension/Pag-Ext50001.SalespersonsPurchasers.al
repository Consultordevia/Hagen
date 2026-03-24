pageextension 50001 "Salespersons/Purchasers" extends "Salespersons/Purchasers"
{
    layout
    {

        addlast(content)
        {
            group(Hagen)
            {


                field("Estado vendedor"; Rec."Estado vendedor")
                {
                    ApplicationArea = All;
                }
                field("Importe"; Rec."Importe")
                {
                    ApplicationArea = All;
                }
                field("Importe Acumulado Dto."; Rec."Importe Acumulado Dto.")
                {
                    ApplicationArea = All;
                }
                field("Comision ROJO"; Rec."Comision ROJO")
                {
                    ApplicationArea = All;
                }
                field("Comision MORADO"; Rec."Comision MORADO")
                {
                    ApplicationArea = All;
                }
                field("Comision AMARILLO"; Rec."Comision AMARILLO")
                {
                    ApplicationArea = All;
                }
                field("Comision AZUL"; Rec."Comision AZUL")
                {
                    ApplicationArea = All;
                }
                field("Comision VERDE"; Rec."Comision VERDE")
                {
                    ApplicationArea = All;
                }
                field("Comision impagado"; Rec."Comision impagado")
                {
                    ApplicationArea = All;
                }
                field("Clave Web"; Rec."Clave Web")
                {
                    ApplicationArea = All;
                }
                field("E-Mail Web"; Rec."E-Mail Web")
                {
                    ApplicationArea = All;
                }
                field("Comision ROJO Hagen"; Rec."Comision ROJO Hagen")
                {
                    ApplicationArea = All;
                }
                field("Comision MORADO Hagen"; Rec."Comision MORADO Hagen")
                {
                    ApplicationArea = All;
                }
                field("Comision AMARILLO Hagen"; Rec."Comision AMARILLO Hagen")
                {
                    ApplicationArea = All;
                }
                field("Comision AZUL Hagen"; Rec."Comision AZUL Hagen")
                {
                    ApplicationArea = All;
                }
                field("Comision VERDE Hagen"; Rec."Comision VERDE Hagen")
                {
                    ApplicationArea = All;
                }
                field("Comision ROJO NO Hagen"; Rec."Comision ROJO NO Hagen")
                {
                    ApplicationArea = All;
                }
                field("Comision MORADO NO Hagen"; Rec."Comision MORADO NO Hagen")
                {
                    ApplicationArea = All;
                }
                field("Comision AMARILLO NO Hagen"; Rec."Comision AMARILLO NO Hagen")
                {
                    ApplicationArea = All;
                }
                field("Comision AZUL NO Hagen"; Rec."Comision AZUL NO Hagen")
                {
                    ApplicationArea = All;
                }
                field("Comision VERDE NO Hagen"; Rec."Comision VERDE NO Hagen")
                {
                    ApplicationArea = All;
                }
                field("% Comisión Hagen"; Rec."% Comisión Hagen")
                {
                    ApplicationArea = All;
                }
                field("% Comisión NO Hagen"; Rec."% Comisión NO Hagen")
                {
                    ApplicationArea = All;
                }
                field("Importe Venta Anterior"; Rec."Importe Venta Anterior")
                {
                    ApplicationArea = All;
                }
                field("Importe Objetivo Anterior"; Rec."Importe Objetivo Anterior")
                {
                    ApplicationArea = All;
                }
                field("Importe Venta Actual"; Rec."Importe Venta Actual")
                {
                    ApplicationArea = All;
                }
                field("Importe Objetivo Actual"; Rec."Importe Objetivo Actual")
                {
                    ApplicationArea = All;
                }
                field("Minimo objetivo plus"; Rec."Minimo objetivo plus")
                {
                    ApplicationArea = All;
                }
                field("Autonomo"; Rec."Autonomo")
                {
                    ApplicationArea = All;
                }
                field("Importe Acumulado Dto.2"; Rec."Importe Acumulado Dto.2")
                {
                    ApplicationArea = All;
                }

            }
        }
    }


    actions
    {
        addlast(processing)
        {
            action(Objetivocomisiones)
            {
                ApplicationArea = Suite;
                Caption = 'Objetivo comisiones';
                trigger OnAction()
                begin
                    ObjetivoVendrdorComi.Reset();
                    ;
                    ObjetivoVendrdorComi.SetRange(Vendedor, Rec.Code);
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
                    ObjetivoVendrdorComi.SetRange(Vendedor, Rec.Code);
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
                    SalespersonPurchaser.SetRange(Code, Rec.Code);
                    if SalespersonPurchaser.FindSet then begin
                        clear(RepComisiones);
                        RepComisiones.SetTableView(SalespersonPurchaser);
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
                    ObjetivoVendrdorComi.SetRange(Vendedor, Rec.Code);
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
                    EscaladoComercial.SetRange(Vendedor, Rec.Code);
                    if EscaladoComercial.FindSet then begin
                        clear(PageEscaladoComercial);
                        PageEscaladoComercial.SetTableView(EscaladoComercial);
                        PageEscaladoComercial.Run();
                    end;
                    if not EscaladoComercial.FindSet then begin
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
                    ClasifiacionComercial.SetRange(Vendedor, Rec.Code);
                    if ClasifiacionComercial.FindSet then begin
                        clear(PageClasifiacio);
                        PageClasifiacio.SetTableView(ClasifiacionComercial);
                        PageClasifiacio.Run();
                    end;
                    if not ClasifiacionComercial.FindSet then begin
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
                    RecBonusBuenos.SetRange(Vendedor, Rec.Code);
                    if RecBonusBuenos.FindSet then begin
                        clear(PageBonusBuenos);
                        PageBonusBuenos.SetTableView(RecBonusBuenos);
                        PageBonusBuenos.Run();
                    end;
                    if not RecBonusBuenos.FindSet then begin
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
                    RecBuenosMalos.SetRange(Vendedor, Rec.Code);
                    if RecBuenosMalos.FindSet then begin
                        clear(PAgeBuenosMalos);
                        PAgeBuenosMalos.SetTableView(RecBuenosMalos);
                        PAgeBuenosMalos.Run();
                    end;
                    if not RecBuenosMalos.FindSet then begin
                        clear(PAgeBuenosMalos);
                        PAgeBuenosMalos.SetTableView(RecBuenosMalos);
                        PAgeBuenosMalos.Run();
                    end;

                end;


            }
            action(ReportNuevo)
            {
                ApplicationArea = Suite;
                Caption = 'Comisiones 2026';
                trigger OnAction()
                begin
                    clear(RepCominuevo);
                    RepCominuevo.SetTableView(Rec);
                    RepCominuevo.Run();

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
        RepCominuevo: report NuevasComisiones2;

}

