tableextension 50010 GenJournalLine extends "Gen. Journal Line"
{
    fields
    {
        field(50000; Periodificado; Boolean)
        {
        }
        field(50001; "Fecha vto. periodificación"; Date)
        {
        }
        field(50010; "Nº pedido pago anticipado"; Code[10])
        {
            TableRelation = "Sales Header"."No." where("Sell-to Customer No." = field("Account No."),
                                                        "Document Type" = const(Order));
        }
        field(50011; Agrp; Boolean)
        {
        }
        field(50200; "Logo cabecera"; Blob)
        {
        }
    }
}
