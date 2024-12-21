pageextension 50045 "PurchInvoiceSubform " extends "Purch. Invoice Subform"
{
     layout
    {

        addafter(Quantity)
        {
            field("Base IVA aduanas";Rec."Base IVA aduanas") { ApplicationArea = All; }
            field("Proveedor Importación";Rec."Proveedor Importación") { ApplicationArea = All; }
            field("% IVA Importación";Rec."% IVA Importación" ) { ApplicationArea = All; }
        }
    }
}
