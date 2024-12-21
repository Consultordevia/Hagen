pageextension 50044 LisatFActurasVenta extends "Posted Sales Invoices"
{

    layout
    {

        addafter("Posting Date")
        {
            field(GLN; Rec.GLN) { ApplicationArea = All; }

        }
    }
}

