pageextension 50006 "Vendor Card" extends "Vendor Card"
{


    layout
    {
        addlast(content)
        {
            group(Hagen)
            {

      

                  field("Invoice Type";Rec."Invoice Type"){ ApplicationArea = All; }
                field("Cr. Memo Type";Rec."Cr. Memo Type"){ ApplicationArea = All; }
         field("Special Scheme Code";Rec."Special Scheme Code"){ ApplicationArea = All; }
        field("Correction Type";Rec."Correction Type"){ ApplicationArea = All; }
        
        field("Do Not Send To SII";Rec."Do Not Send To SII"){ ApplicationArea = All; }
        





                //field("Tipo operación"; Rec."Tipo operación") { ApplicationArea = All; }
                //field("Creado por"; Rec."Creado por") { ApplicationArea = All; }
                //field("Fecha creación"; Rec."Fecha creación") { ApplicationArea = All; }
                //field("Importe albaranado"; Rec."Importe albaranado") { ApplicationArea = All; }
                //field("Importe facturado"; Rec."Importe facturado") { ApplicationArea = All; }
                //field("Importe abonado"; Rec."Importe abonado") { ApplicationArea = All; }
                field("Proveedor de almacen"; Rec."Proveedor de almacen") { ApplicationArea = All; }
                field("Banco previsión"; Rec."Banco previsión") { ApplicationArea = All; }
                field("Importe minimo pedido compra"; Rec."Importe minimo pedido compra") { ApplicationArea = All; }
                //field("Tiene refencias asignadas"; Rec."Tiene refencias asignadas") { ApplicationArea = All; }
                field("Tipo proveedor"; Rec."Tipo proveedor") { ApplicationArea = All; }
                field("Entry Point"; Rec."Entry Point") { ApplicationArea = All; }
                field("Area"; Rec."Area") { ApplicationArea = All; }
                field("Transaction Specification"; Rec."Transaction Specification") { ApplicationArea = All; }
                field("Transaction Type"; Rec."Transaction Type") { ApplicationArea = All; }
                field("Transport Method"; Rec."Transport Method") { ApplicationArea = All; }
                field("Cuenta de gasto"; Rec."Cuenta de gasto") { ApplicationArea = All; }
            }
        }
    }
}
