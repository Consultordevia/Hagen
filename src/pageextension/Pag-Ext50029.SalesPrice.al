pageextension 50029 SalesPrice extends "Sales Prices"
{
    layout
    {
    }
    actions
    {
        addlast(reporting)
        {
            action(Altapreciosgrupos)
            {
                ApplicationArea = All;
                Caption = 'Alta precios grupos';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Order;

                trigger OnAction()
                var                     
                    XmlPortAltaprecios: XmlPort "Alta precios";
                begin
                    clear(XmlPortAltaprecios);
                    XmlPortAltaprecios.run;
                END;
            }
        }
    }
}
