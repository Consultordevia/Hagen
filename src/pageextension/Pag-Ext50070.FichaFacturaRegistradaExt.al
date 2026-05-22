pageextension 50070 FichaFacturaRegistradaExt extends "Posted Sales Invoice"
{
    actions
    {
        addlast(navigation)
        {
            action(ConvertirTicketAFactura)
            {
                ApplicationArea = All;
                Caption = 'Ticket a Factura';
                ToolTip = 'Convierte esta factura simplificada (ticket) en una factura ordinaria asociada a un cliente.';
                Image = Invoice;
                trigger OnAction()
                var
                    CU: Codeunit "Convertir Ticket Factura";
                begin
                    CU.ConvertirTicket(Rec);
                end;
            }
        }
    }
}
