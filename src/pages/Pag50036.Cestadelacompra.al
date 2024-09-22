#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50036 "Cesta de la compra"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Cesta compra";
    SourceTableView = sorting(Tipo,Código,Línea,Familia,Subfamilia);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Subfamilia;Rec.Subfamilia)
                {
                    ApplicationArea = Basic;
                    Caption = 'Subfamilia';
                    Editable = false;
                }
                field(Referencia;Rec.Referencia)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Descripción";Rec.Descripción)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Clasificación A,B,C";Item."Clasificación A,B,C")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Estado Producto";Item."Estado Producto")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Stock;Stock)
                {
                    ApplicationArea = Basic;
                    Caption = 'Stock';
                    Editable = false;
                }
                field(Comprar;Rec.Comprar)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comprar';
                }
                field("Cantidad a Comprar";Rec."Cantidad a Comprar")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cantidad a Comprar';
                }
                field("M[1]+M[2]+M[3]+M[4]+M[5]+M[6]+M[7]+M[8]+M[9]+M[10]+M[11]+M[12]";M[1]+M[2]+M[3]+M[4]+M[5]+M[6]+M[7]+M[8]+M[9]+M[10]+M[11]+M[12])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = 'Total';
                    DecimalPlaces = 0:0;
                    Editable = false;
                }
                field("M[1]";M[1])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = '-11 meses';
                    DecimalPlaces = 0:0;
                    Editable = false;
                }
                field("M[2]";M[2])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = '-10 meses';
                    DecimalPlaces = 0:0;
                    Editable = false;
                }
                field("M[3]";M[3])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = '-9 meses';
                    DecimalPlaces = 0:0;
                    Editable = false;
                }
                field("M[4]";M[4])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = '-8 meses';
                    DecimalPlaces = 0:0;
                    Editable = false;
                }
                field("M[5]";M[5])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = '-7 meses';
                    DecimalPlaces = 0:0;
                    Editable = false;
                }
                field("M[6]";M[6])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = '-6 meses';
                    DecimalPlaces = 0:0;
                    Editable = false;
                }
                field("M[7]";M[7])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = '-5 meses';
                    DecimalPlaces = 0:0;
                    Editable = false;
                }
                field("M[8]";M[8])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = '-4 meses';
                    DecimalPlaces = 0:0;
                    Editable = false;
                }
                field("M[9]";M[9])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = '-3 meses';
                    DecimalPlaces = 0:0;
                    Editable = false;
                }
                field("M[10]";M[10])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = '-2 meses';
                    DecimalPlaces = 0:0;
                    Editable = false;
                }
                field("M[11]";M[11])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = '-1 meses';
                    DecimalPlaces = 0:0;
                    Editable = false;
                }
                field("M[12]";M[12])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = 'mes actual';
                    DecimalPlaces = 0:0;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Quote")
            {
                Caption = '&Quote';
                Image = Quote;
                action(Comprar_)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comprar';
                    Ellipsis = true;
                    Image = Purchase;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        Rec91.Get(UserId);

                        if RecCV.Get(Rec91."Es pedido o oferta",Rec91."Nº pedido") then begin
                             lin:=10000;
                             RecLV.Reset;
                             RecLV.SetRange(RecLV."Document Type",RecCV."Document Type");
                             RecLV.SetRange(RecLV."Document No.",Rec91."Nº pedido");
                             if RecLV.FindLast then begin
                                  lin:=RecLV."Line No.";
                             end;

                             Rec2.Reset;
                             Rec2.SetCurrentkey(Rec2.Tipo,Rec2.Código,Rec2.Comprar);
                             Rec2.SetRange(Rec2.Tipo,0);
                             Rec2.SetRange(Rec2.Código,Rec.Código);
                             Rec2.SetRange(Rec2.Comprar,true);
                             if Rec2.FindFirst then repeat
                                  RecLV."Document Type":=RecCV."Document Type";
                                  RecLV."Document No.":=Rec91."Nº pedido";
                                  lin:=lin+10000;
                                  RecLV."Line No.":=lin;
                                  RecLV.Type:=2;
                                  RecLV.Validate(RecLV."No.",Rec2.Referencia);
                                  RecLV.Validate(RecLV.Quantity,Rec2."Cantidad a Comprar");
                                  RecLV.Insert(true);
                                  Rec2.Comprar:=false;
                                  Rec2."Cantidad a Comprar":=0;
                                  Rec2.Modify;
                             until Rec2.Next = 0;

                        end;
                        CurrPage.Close;
                    end;
                }
                action(Salir)
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = Edit;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin




                        botoncorrecto:=true;
                        CurrPage.Close;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin


        if Item.Get(Rec.Referencia) then begin
             Item.CalcFields("Existencia SILLA","Qty. on Sales Order");
             Stock:=Item."Existencia SILLA"-Item."Qty. on Sales Order";

        I:=0;
        Clear(M);
        repeat
             I:=I+1;
             Rec111.Reset;
             Rec111.SetCurrentkey(Rec111."Sell-to Customer No.",Rec111."No.",Rec111."Shipment Date");
             Rec111.SetRange(Rec111."Sell-to Customer No.",Rec.Código);
             Rec111.SetRange(Rec111."No.",Rec.Referencia);
             Rec111.SetRange(Rec111."Shipment Date",INTERVALOD[I],INTERVALOH[I]);
             if Rec111.FindFirst then repeat
                  M[I]:=M[I]+Rec111.Quantity;
             until Rec111.Next = 0;
        until I=12;

        end;
    end;

    trigger OnOpenPage()
    begin

        botoncorrecto:=false;


        DESDEI:=CalcDate('-1A',Today);
        Rec.SetRange("Filtro fecha",DESDEI,Today);
        INTERVALOD[1]:=Today;
        MES1:=Date2dmy(INTERVALOD[1],2);
        año:=Date2dmy(INTERVALOD[1],3);
        INTERVALOD[1]:=Dmy2date(1,MES1,año);

        INTERVALOD[2]:=CalcDate('-1M',Today);
        MES1:=Date2dmy(INTERVALOD[2],2);
        año:=Date2dmy(INTERVALOD[2],3);
        INTERVALOD[2]:=Dmy2date(1,MES1,año);


        INTERVALOD[3]:=CalcDate('-2M',Today);
        MES1:=Date2dmy(INTERVALOD[3],2);
        año:=Date2dmy(INTERVALOD[3],3);
        INTERVALOD[3]:=Dmy2date(1,MES1,año);

        INTERVALOD[4]:=CalcDate('-3M',Today);
        MES1:=Date2dmy(INTERVALOD[4],2);
        año:=Date2dmy(INTERVALOD[4],3);
        INTERVALOD[4]:=Dmy2date(1,MES1,año);

        INTERVALOD[5]:=CalcDate('-4M',Today);
        MES1:=Date2dmy(INTERVALOD[5],2);
        año:=Date2dmy(INTERVALOD[5],3);
        INTERVALOD[5]:=Dmy2date(1,MES1,año);

        INTERVALOD[6]:=CalcDate('-5M',Today);
        MES1:=Date2dmy(INTERVALOD[6],2);
        año:=Date2dmy(INTERVALOD[6],3);
        INTERVALOD[6]:=Dmy2date(1,MES1,año);

        INTERVALOD[7]:=CalcDate('-6M',Today);
        MES1:=Date2dmy(INTERVALOD[7],2);
        año:=Date2dmy(INTERVALOD[7],3);
        INTERVALOD[7]:=Dmy2date(1,MES1,año);

        INTERVALOD[8]:=CalcDate('-7M',Today);
        MES1:=Date2dmy(INTERVALOD[8],2);
        año:=Date2dmy(INTERVALOD[8],3);
        INTERVALOD[8]:=Dmy2date(1,MES1,año);

        INTERVALOD[9]:=CalcDate('-8M',Today);
        MES1:=Date2dmy(INTERVALOD[9],2);
        año:=Date2dmy(INTERVALOD[9],3);
        INTERVALOD[9]:=Dmy2date(1,MES1,año);

        INTERVALOD[10]:=CalcDate('-9M',Today);
        MES1:=Date2dmy(INTERVALOD[10],2);
        año:=Date2dmy(INTERVALOD[10],3);
        INTERVALOD[10]:=Dmy2date(1,MES1,año);

        INTERVALOD[11]:=CalcDate('-10M',Today);
        MES1:=Date2dmy(INTERVALOD[11],2);
        año:=Date2dmy(INTERVALOD[11],3);
        INTERVALOD[11]:=Dmy2date(1,MES1,año);

        INTERVALOD[12]:=CalcDate('-11M',Today);
        MES1:=Date2dmy(INTERVALOD[12],2);
        año:=Date2dmy(INTERVALOD[12],3);

        INTERVALOD[12]:=Dmy2date(1,MES1,año);




        INTERVALOH[1]:=CalcDate('+1M-1D',INTERVALOD[1]);
        INTERVALOH[2]:=CalcDate('+1M-1D',INTERVALOD[2]);
        INTERVALOH[3]:=CalcDate('+1M-1D',INTERVALOD[3]);
        INTERVALOH[4]:=CalcDate('+1M-1D',INTERVALOD[4]);
        INTERVALOH[5]:=CalcDate('+1M-1D',INTERVALOD[5]);
        INTERVALOH[6]:=CalcDate('+1M-1D',INTERVALOD[6]);
        INTERVALOH[7]:=CalcDate('+1M-1D',INTERVALOD[7]);
        INTERVALOH[8]:=CalcDate('+1M-1D',INTERVALOD[8]);
        INTERVALOH[9]:=CalcDate('+1M-1D',INTERVALOD[9]);
        INTERVALOH[10]:=CalcDate('+1M-1D',INTERVALOD[10]);
        INTERVALOH[11]:=CalcDate('+1M-1D',INTERVALOD[11]);
        INTERVALOH[12]:=CalcDate('+1M-1D',INTERVALOD[12]);
    end;

    trigger OnQueryClosePage(CloseAction: action): Boolean
    begin


        if botoncorrecto=false then begin
             Error('Debe de salir por el icono de Pedido o Salir');
        end;
    end;

    var
        Item: Record Item;
        Stock: Decimal;
        I: Integer;
        M: array [12] of Decimal;
        Rec111: Record "Sales Shipment Line";
        INTERVALOD: array [12] of Date;
        MES1: Integer;
        "año": Integer;
        INTERVALOH: array [12] of Date;
        DESDEI: Date;
        RecCV: Record "Sales Header";
        Rec91: Record "User Setup";
        lin: Integer;
        RecLV: Record "Sales Line";
        Rec2: Record "Cesta compra";
        botoncorrecto: Boolean;
}

