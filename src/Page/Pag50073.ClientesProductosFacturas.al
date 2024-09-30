#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50073 "Clientes-Productos-Facturas"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Sales Invoice Line"=rim;
    SourceTable = "Sales Invoice Line";
    SourceTableView = sorting("Sell-to Customer No.","No.")
                      where(Quantity=filter(<>0),
                            Type=const(Item));

    layout
    {
        area(content)
        {
            group(Control1000000005)
            {
                field(codalma;codalma)
                {
                    ApplicationArea = Basic;
                    Caption = 'Almacen';
                    TableRelation = Location;
                }
                field("Nº doc. externo";yourref)
                {
                    ApplicationArea = Basic;
                    Caption = 'Nº doc. externo';
                }
            }
            repeater(Group)
            {
                field("Document No.";Rec."Document No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shipment Date";Rec."Shipment Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Location Code";Rec."Location Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Quantity;Rec.Quantity)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unit Price";Rec."Unit Price")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Line Discount %";Rec."Line Discount %")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Control1000000011;Rec.Abonar)
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad a abonar";Rec."Cantidad a abonar")
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
            action(Abonar)
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = CreditMemo;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    AAbonar;
                end;
            }
        }
    }

    var
        RecItem: Record Item;
        Descripprod: Text[50];
        Precio: Decimal;
        Dto: Decimal;
        Importe: Decimal;
        RecLAV: Record "Sales Shipment Line";
        RecLFV: Record "Sales Invoice Line";
        RecLAB: Record "Sales Cr.Memo Line";
        RecCAV: Record "Sales Shipment Header";
        codalma: Code[10];
        RecCV: Record "Sales Header";
        RecLV: Record "Sales Line";
        Rec113: Record "Sales Invoice Line";
        RecHLAV: Record "Sales Shipment Line";
        RecLV2: Record "Sales Line";
        lin: Integer;
        FormAbono: Page "Sales Credit Memo";
        RecCVa: Record "Sales Header";
        yourref: Code[20];

    local procedure AAbonar()
    begin




        if codalma='' then begin
             Error('Falta almacen.');
        end;


          RecCV.Init;
          RecCV."No.":= '';
          RecCV."Document Type" := 3;
          RecCV."Sell-to Customer No." := Rec."Sell-to Customer No.";
          RecCV."Order Date" := WorkDate;
          RecCV."Posting Date" := WorkDate;
          RecCV."Shipment Date" := WorkDate;
          RecCV."Document Date" := WorkDate;
          RecCV."Due Date" := WorkDate;
          RecCV.Insert(true);
          RecCV.Validate(RecCV."Sell-to Customer No.");
        ///  RecCV."Pmt. Discount Date":=0D;
        ///  RecCV."Payment Terms Code":='0D';
          RecCV."Payment Method Code":='ABONO';
          RecCV."Location Code":=codalma;
          RecCV."Your Reference":=yourref;
          RecCAV."External Document No.":=yourref;
          RecCV.Modify;

        Rec113.Reset;
        Rec113.SetCurrentkey(Rec113."Sell-to Customer No.",Rec113."No.");
        Rec113.SetRange(Rec113."Sell-to Customer No.",Rec."Sell-to Customer No.");
        if Rec113.FindFirst then repeat
             if Rec113.Abonar then begin
                       RecLV2.Init;
                       RecLV2."Document No.":=RecCV."No.";
                       lin:=lin+10000;
                       RecLV2."Line No.":=lin;
                       RecLV2."Document Type":=3;
                       RecLV2.Type:=2;
                       RecLV2.Validate(RecLV2."No.",Rec113."No.");
                       RecLV2."Customer Price Group":=Rec113."Customer Price Group";
                       RecLV2.Validate(RecLV2.Quantity,Rec113."Cantidad a abonar");
                       RecLV2.Validate(RecLV2."Unit Price",ROUND(Rec113.Amount/Rec113.Quantity,0.01));
                       RecLV2."Corrected Invoice No.":=Rec113."Document No.";
                       RecLV2."Linea correccion":=Rec113."Line No.";
                       RecLV2."Location Code":=codalma;
                       RecLV2.Insert;
                       Rec113."Cantidad a abonar":=0;
                       Rec113.Abonar:=false;
                       Rec113.Modify;
              end;

        until Rec113.Next = 0;

          RecCV."Corrected Invoice No.":=Rec113."Document No.";
          RecCV.Modify;


        RecCVa.Reset;
        RecCVa.SetRange(RecCVa."Document Type",RecCV."Document Type");
        RecCVa.SetRange(RecCVa."No.",RecCV."No.");
        if RecCVa.FindFirst then begin
             FormAbono.SetTableview(RecCVa);
             FormAbono.Run;
        end;
    end;
}

