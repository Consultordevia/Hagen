pageextension 50057 PostedSalesShipmentLines extends "Posted Sales Shipment Lines"
{
    
    layout
    {
        addafter("Sell-to Customer No.")
        {
        field("Excluir del exel amazon";Rec."Excluir del exel amazon") { ApplicationArea = All; }            

        }
    }
     actions
    {
        addlast(navigation)
        {
            action(Marcar)
            {
                ApplicationArea = Suite;
                Caption = 'Marcar Excluir del excel AMAZON';                 
                trigger OnAction()
                var
                    Rec111: Record "Sales Shipment Line";
                    CodeAuto: Codeunit Automaticos;
                begin
                        Rec111.CopyFilters(Rec);
                        if Rec111.FindSet() then
                        repeat
                            CodeAuto.MarcarcomonoexcelAMAZONSINMENSAJE(Rec111);                             
                        until Rec111.Next() = 0;
                end;
            }
            action(DesMarcar)
            {
                ApplicationArea = Suite;
                Caption = 'Desmarcar Excluir del excel AMAZON';                 
                trigger OnAction()
                var
                    Rec111: Record "Sales Shipment Line";
                    CodeAuto: Codeunit Automaticos;
                begin
                        Rec111.CopyFilters(Rec);
                        if Rec111.FindSet() then
                        repeat
                            CodeAuto.DesmarcarcomonoexcelAMAZONSINMENSAJE(Rec111);                                                          
                        until Rec111.Next() = 0;
                end;
            }
       
        }
    }
}
