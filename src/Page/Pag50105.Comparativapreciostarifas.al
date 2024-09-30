#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50105 "Comparativa precios-tarifas"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sales Invoice Line";
    SourceTableView = where(Type=const(Item));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sell-to Customer No.";Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document No.";Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Line No.";Rec."Line No.")
                {
                    ApplicationArea = Basic;
                }
                field(Type;Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Location Code";Rec."Location Code")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Group";Rec."Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Description 2";Rec."Description 2")
                {
                    ApplicationArea = Basic;
                }
                field("Unit of Measure";Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(Quantity;Rec.Quantity)
                {
                    ApplicationArea = Basic;
                }
                field("Unit Price";Rec."Unit Price")
                {
                    ApplicationArea = Basic;
                }
                field("Precio Original";PrecioOrig)
                {
                    ApplicationArea = Basic;
                }
                field(Diferencia;Dif)
                {
                    ApplicationArea = Basic;
                    StyleExpr = ESTILOLINEA;
                }
                field("Line Discount %";Rec."Line Discount %")
                {
                    ApplicationArea = Basic;
                }
                field("Line Discount Amount";Rec."Line Discount Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount Including VAT";Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic;
                }
                field("Allow Invoice Disc.";Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Price Group";Rec."Customer Price Group")
                {
                    ApplicationArea = Basic;
                }
                field("Inv. Discount Amount";Rec."Inv. Discount Amount")
                {
                    ApplicationArea = Basic;
                }
                /////-field("Grupo clientes";"Grupo clientes")
                /////-{
                /////-    ApplicationArea = Basic;
                /////-}
                field("Posting Date";Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Shipment No.";Rec."Shipment No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin


        PrecioOrig:=0;
        Dif:=0;
        SalesPrice.Reset;
        SalesPrice.SetRange(SalesPrice."Item No.",Rec."No.");
        SalesPrice.SetRange(SalesPrice."Sales Code",Rec."Customer Price Group");
        SalesPrice.SetRange("Starting Date",0D,Rec."Posting Date");
        if SalesPrice.FindLast then begin
            PrecioOrig:=SalesPrice."Unit Price";
          Dif:=Rec."Unit Price"-PrecioOrig;
        end;

        ESTILOLINEA:='';
        if Dif<0 then begin
            ESTILOLINEA:='Attention';
        end;
    end;

    var
        SalesPrice: Record "Sales Price";
        PrecioOrig: Decimal;
        Dif: Decimal;
        ESTILOLINEA: Text;
}

