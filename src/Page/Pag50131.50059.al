page 50131 "50059"
{
    ApplicationArea = All;
    Caption = 'OrdenesCompra';
    PageType = List;
    SourceTable = OrdenesCompra;
    UsageCategory = Lists;
    LinksAllowed = false;



    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(Col1; Rec.Col1)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Col2; Rec.Col2)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Col3; Rec.Col3)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Col4; Rec.Col4)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Col5; Rec.Col5)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Col6; Rec.Col6)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Col7; Rec.Col7)
                {
                    ApplicationArea = All;
                    Editable = false;
                }




            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CreaOferta)
            {
                ApplicationArea = Basic;
                ShortCutKey = 'F9';
                ///Caption = 'Crea Oferta';

                trigger OnAction()
                begin
                    PurchasesPayablesSetup.get;
                    primero := true;
                    RecOC.Reset();
                    IF RecOC.FindFirst() THEN
                        repeat
                            IF RecOC.Col1 <> '' THEN begin
                                RecItem.Reset();
                                ;
                                RecItem.SetRange("Vendor Item No.", CopyStr(RecOC.Col1, 1, 20));
                                IF RecItem.FindFirst() THEN BEGIN
                                    if Primero then begin
                                        Primero := false;
                                        npedido := CuNext.GetNextNo(PurchasesPayablesSetup."Quote Nos.", Today, true);
                                        RecCC.INIT;
                                        RecCC."Document Type" := RecCC."Document Type"::Quote;
                                        RecCC."No." := npedido;
                                        RecCC.VALIDATE("Order Date", TODAY);
                                        RecCC.VALIDATE("Posting Date", TODAY);
                                        RecCC.VALIDATE(RecCC."Buy-from Vendor No.", RecItem."Vendor No.");
                                        RecCC."No. Series" := PurchasesPayablesSetup."Order Nos.";
                                        RecCC."Posting No. Series" := PurchasesPayablesSetup."Posted Invoice Nos.";
                                        RecCC."Receiving No. Series" := PurchasesPayablesSetup."Posted Receipt Nos.";
                                        RecCC."Prepayment No. Series" := PurchasesPayablesSetup."Posted Prepmt. Inv. Nos.";
                                        RecCC."Prepmt. Cr. Memo No." := PurchasesPayablesSetup."Posted Prepmt. Cr. Memo Nos.";
                                        RecCC."Expected Receipt Date" := TODAY;
                                        RecCC.INSERT(TRUE);
                                    end;

                                    LINEAS := LINEAS + 10000;
                                    RecLC."Document Type" := RecLC."Document Type"::Quote;
                                    RecLC."Document No." := npedido;
                                    RecLC."Line No." := LINEAS;
                                    RecLC.Type := 2;
                                    RecLC.Validate(RecLC."No.", RecItem."No.");
                                    Evaluate(CANTIDE, RecOC.Col5);
                                    RecLC.Validate(RecLC.Quantity, CANTIDE);
                                    Evaluate(CANTIDE, RecOC.Col6);
                                    RecLC.Validate(RecLC."Direct Unit Cost", CANTIDE);
                                    RecLC.Insert(true);


                                END;
                            end;
                        UNTIL RecOC.Next = 0;

                    Message('Oferta creada %1', npedido);


                end;
            }
        }
    }
    var

        RecCC: Record "Purchase Header";
        RecLC: Record "Purchase Line";

        RecItem: Record Item;
        RecOC: Record OrdenesCompra;
        Primero: Boolean;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        LINEAS: Integer;
        CANTIDE: Decimal;

        CuNext: Codeunit "No. Series"; // v27
        npedido: Code[20];


}
