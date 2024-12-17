pageextension 50039 "ReceivablesCarteraDocs " extends "Receivables Cartera Docs"
{
      layout
    {
         
    }

      actions
    {
        addlast(navigation)
        {

            action(Descuentoabonventa)
            {

                ApplicationArea = Suite;
                Caption = 'Descuento abonos venta';
                 ShortCutKey = 'F9';
                trigger OnAction()
                var            
                 
                RepDescuentoabonosventa: Report "Descuento abonos venta";

                begin

                    Clear(RepDescuentoabonosventa);
                    RepDescuentoabonosventa.Run();                      
                    

                end;
            }
        }
    }
}
