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



        }
    }

var
        PageObjetivosvendedorcomision: Page "Objetivos vendedor comision";
        ObjetivoVendrdorComi: Record "Objetivos vendedores";
        RepComisiones: Report "Comisiones";
        PageDescuentoAzul: Page "Descuento Azul";
        SalespersonPurchaser: Record "Salesperson/Purchaser";

}

