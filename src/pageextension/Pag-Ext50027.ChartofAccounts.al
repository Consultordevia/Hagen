pageextension 50027 "Chart of Accounts" extends "Chart of Accounts"
{
    layout
    {
    }
    actions
    {
        addlast(reporting)
        {
            action(SII)
            {
                ApplicationArea = All;
                Caption = 'SII';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Order;

                trigger OnAction()
                var
                    cusii2: Codeunit sii2;
                begin
                    clear(cusii2);
                    cusii2.run;
                END;
            }
            action(LISTADOFACTURASRECIBIDAS)
            {
                ApplicationArea = All;
                Caption = 'LISTADO FACTURAS RECIBIDAS';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Order;

                trigger OnAction()
                var
                    LFR: Report "LISTADO FACTURAS RECIBIDAS";
                begin
                    clear(LFR);
                    LFR.run;
                END;
            }
            action(LISTADOFACTURASEMITIDAS)
            {
                ApplicationArea = All;
                Caption = 'LISTADO FACTURAS EMITIDAS';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Order;

                trigger OnAction()
                var
                    LFE: Report "LISTADO DE FACTURAS EMITIDAS";
                begin
                    clear(LFE);
                    LFE.run;
                END;
            }
            action(ANALISISMARGENES)
            {
                ApplicationArea = All;
                Caption = 'ANALISIS MARGENES';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Order;

                trigger OnAction()
                var
                    PPA: Page"Parrilas Analisis";
                begin
                    clear(PPA);
                    PPA.run;
                END;
            }
            action(DATOSPRESUPUESTOS)
            {
                ApplicationArea = All;
                Caption = 'DATOS PRESUPUESTOS';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Order;

                trigger OnAction()
                var
                    DP: Page "Datos Presupuesto";
                begin
                    clear(DP);
                    DP.run;
                END;
            }
        
        
        
        }
    }
}
