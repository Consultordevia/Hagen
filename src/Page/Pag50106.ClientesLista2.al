#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50106 "Clientes Lista2"
{
    PageType = List;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Last Modified Date Time"; Rec."Last Modified Date Time")
                {
                    ApplicationArea = Basic;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Catalogo Shopify";Rec."Catalogo Shopify")
                {
                    ApplicationArea = Basic;
                }
                field("Email facturacion 1"; Rec."Email facturacion 1")
                {
                    ApplicationArea = Basic;
                }
                field("Email facturacion 2"; Rec."Email facturacion 2")
                {
                    ApplicationArea = Basic;
                }
                field("Email facturacion 3"; Rec."Email facturacion 3")
                {
                    ApplicationArea = Basic;
                }
                field("Email abono 1"; Rec."Email abono 1")
                {
                    ApplicationArea = Basic;
                }
                field("Email abono 2"; Rec."Email abono 2")
                {
                    ApplicationArea = Basic;
                }
                field("Email albaran sin detalle 1"; Rec."Email albaran sin detalle 1")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = Basic;
                }
                field("Estatus del cliente"; Rec."Estatus del cliente")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ASD)
            {
                ApplicationArea = Basic;
                ShortCutKey = 'F9';

                trigger OnAction()
                begin



                    Rec."Email albaran sin detalle 1" := 'info@catit.es';
                    Rec."Email facturacion 1" := 'info@catit.es';
                    Rec."Email facturacion 2" := '';
                    Rec."Email facturacion 3" := '';
                    Rec."Email abono 1" := 'info@catit.es';
                    Rec."Email abono 2" := '';
                    Rec.Modify;

                    /////VALIDATE("Search Name");
                    /////MODIFY;

                    /////C50000.RUN;

                    /////"Customer Disc. Group":='KIWOKO';
                    ///Rec."VAT Registration No.":="Country/Region Code"+Rec."VAT Registration No.";
                    /////MODIFY;
                end;
            }
        }
    }

    var
    /////- C50000: Codeunit UnknownCodeunit50000;
}

