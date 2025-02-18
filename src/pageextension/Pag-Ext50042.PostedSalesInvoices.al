pageextension 50042 PostedSalesInvoices extends "Posted Sales Invoices"

{


    layout

    {



        addafter("Posting Date")
        {
            field("Your Reference"; Rec."Your Reference") { ApplicationArea = All; }
            field("Nº expedición";Rec."Nº expedición") { ApplicationArea = All; }
            field("Nº expedición dropshp";Rec."Nº expedición dropshp") { ApplicationArea = All; }
            field("EDI factueas enviar";Rec."EDI factueas enviar") { ApplicationArea = All; }
            field("EDI factueas enviado";Rec."EDI factueas enviado") { ApplicationArea = All; }
            field("EDI Facturas Fecha enviado";Rec."EDI Facturas Fecha enviado") { ApplicationArea = All; }

        }

    }

    actions
    {
        addlast(navigation)
        {

            action(MarcaCanarias)
            {

                ApplicationArea = Suite;
                Caption = 'MarcaCanarias';
                ShortCutKey = 'F9';
                trigger OnAction()
                var

                    CUAC: Codeunit "Automaticos Cartas";


                begin


                    CUAC.ModifCanarias(Rec);


                end;
            }

            action(EDICOMFacturas)
            {

                ApplicationArea = Suite;
                Caption = 'EDICOM Facturas';
                ShortCutKey = 'F9';
                trigger OnAction()
                var
                    AutomaticosEDICOM: Codeunit "Automaticos EDICOM facturas";

                begin

                    AutomaticosEDICOM.GrabaEDICOM(Rec."No.");


                end;
            }
            action(EDICOMAlbaran)
            {

                ApplicationArea = Suite;
                Caption = 'EDICOM Albaran';
                ShortCutKey = 'F9';
                trigger OnAction()
                var
                    AutomaticosEDICOMalb: Codeunit "Automaticos EDICOM albaran";

                begin



                    AutomaticosEDICOMalb.GrabaEDICOM(Rec."No.");


                end;
            }




            ///AutomaticosEDICOMalbaran.GrabaEDICOM("No.");

        }
    }


}
