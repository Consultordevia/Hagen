#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50049 "Franquicia Abonos"
{
    PageType = List;
    SourceTable = "Sales Cr.Memo Line";

    layout
    {
        area(content)
        {
            group(Control1000000007)
            {
                field(GrupoCliente; GrupoCliente)
                {
                    ApplicationArea = Basic;
                    Caption = 'Grupo Cliente';

                    trigger OnValidate()
                    begin



                        Customer.Reset;
                        Customer.SetRange("Grupo clientes", GrupoCliente);
                        if Customer.FindSet then
                            repeat
                                FILTRO := FILTRO + Customer."No." + '|';
                            until Customer.Next = 0;

                        FILTRO := CopyStr(FILTRO, 1, StrLen(FILTRO) - 1);

                        Rec.SetFilter(Rec."Sell-to Customer No.", FILTRO);
                    end;
                }
                field(DescuentoApli; DescuentoApli)
                {
                    ApplicationArea = Basic;
                    Caption = 'Descuento';
                }
                field(ComisionApli; ComisionApli)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comision';
                }
            }
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Diferencia; Diferencia)
                {
                    ApplicationArea = Basic;
                    Caption = 'Diferencia';
                    Editable = false;
                }
                field(Resto; Resto)
                {
                    ApplicationArea = Basic;
                    Caption = 'A comisionar';
                    Editable = false;
                }
                field(Comision; Comision)
                {
                    ApplicationArea = Basic;
                    Caption = 'Importe Comision';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin


        ///Diferencia:=Quantity*"Unit Price"*0.7;
        ///Resto:=Amount-Diferencia;
        ///Comision:=Resto+Resto*0.1*-1;



        Diferencia := ROUND(Rec.Quantity * Rec."Unit Price" * ((100 - DescuentoApli) / 100), 0.01);
        Resto := Rec.Amount - Diferencia;
        Comision := Resto + ROUND(Resto * (ComisionApli / 100), 0.01);
        Comision := Comision * -1;

        if Rec."Line Discount %" = 100 then begin
            Diferencia := 0;
            Resto := 0;
            Comision := 0;
        end;

        if Rec."Line Discount %" >= DescuentoApli then begin
            Diferencia := 0;
            Resto := 0;
            Comision := ROUND(Rec.Amount * (ComisionApli / 100), 0.01) * -1;
        end;
    end;

    var
        Diferencia: Decimal;
        Resto: Decimal;
        Comision: Decimal;
        Customer: Record Customer;
        FILTRO: Text;
        GrupoCliente: Code[10];
        DescuentoApli: Decimal;
        ComisionApli: Decimal;
}

