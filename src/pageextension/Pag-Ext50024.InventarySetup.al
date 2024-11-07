pageextension 50024 "Inventary Setup" extends "Inventory Setup"
{
    layout
    {
        addlast(content)
        {
            group(Hagen)
            {
                field("Ruta edi-eci"; Rec."Ruta edi-eci") { ApplicationArea = All; }
                field("Ruta edi-eci copia"; Rec."Ruta edi-eci copia") { ApplicationArea = All; }
                field("Ruta fichero COVALDROPER"; Rec."Ruta fichero COVALDROPER") { ApplicationArea = All; }
                field("Ruta fichero COVALDROPER COPIA"; Rec."Ruta fichero COVALDROPER COPIA") { ApplicationArea = All; }
                field("Ruta salida a_gestion"; Rec."Ruta salida a_gestion") { ApplicationArea = All; }
                field("Ruta salida a_gestion copia"; Rec."Ruta salida a_gestion copia") { ApplicationArea = All; }
                field("Ruta salida de_gestion"; Rec."Ruta salida de_gestion") { ApplicationArea = All; }
                field("Ruta salida incial adaia"; Rec."Ruta salida incial adaia") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        addafter("Import Item Pictures")
        {
            action(Prueba)
            {
                ApplicationArea = All;
                Caption = 'Caption', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Image;
                trigger OnAction()
                var
                    Customer: Record Customer;
                begin
                    Customer.Init();
                    Customer.Name := 'Prueba';
                    Customer.ContactoAInsertar := 'Prueba';
                    Customer.Insert(true);
                end;
            }
        }
    }

}
