page 50114 CamposLevel
{
    ApplicationArea = All;
    Caption = 'CamposLevel';
    PageType = List;
    SourceTable = Item;
    UsageCategory = Lists;



    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field(Level1; Rec.Level1)
                {
                }
                field(Level2; Rec.Level2)
                {
                }
                field(Level3; Rec.Level3)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Producto PADRE"; Rec."Producto PADRE")
                {
                }
                field("Descripcion web"; Rec."Descripcion web")
                {
                }
                field(Etiquetas1;Rec.Etiquetas1)
                {
                }
                field(Etiquetas2;Rec.Etiquetas2)
                {                                   
                }
                field(Etiquetas3;Rec.Etiquetas3)
                {                       
                }
                field(Etiquetas4;Rec.Etiquetas4)
                {                                  
                }
                field(Etiquetas5;Rec.Etiquetas5)
                {                                   
                }
                field(Etiquetas6;Rec.Etiquetas6)
                {                                   
                }
                field(Gama;Rec.Gama)
                {                                   
                }
                field("Producto web"; Rec."Producto web")
                {                                   
                }
                field("Unidades venta";Rec."Unidades venta")
                {                                   
                }
                field("Stock para Catit";Rec."Stock para Catit")
                {                                   
                }
                field(ean;Rec.ean)
                {                                   
                }
                field(GTIN;Rec.GTIN)
                {                                   
                }
                
                






            }
        }
    }
}
