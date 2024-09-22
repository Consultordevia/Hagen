#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50126 "Cesta compra"
{
    Caption = 'Cesta compra';
    Editable = false;
    PageType = CardPart;
    SourceTable = "Cesta compra";

    layout
    {
        area(content)
        {
            group("Cesta compra")
            {
                Caption = 'No. of Bills';
                field("1";'Mes actual - Cantidad:  '+Format(M[12])+'  precio: '+PRECIO[12])
                {
                    ApplicationArea = Basic;
                    Caption = '1';
                }
                field("2";'Mes -1  - Cantidad:  '+Format(M[11])+'  precio: '+PRECIO[11])
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Open Bills';
                    Editable = false;
                }
                field("3";'Mes -2  - Cantidad:  '+Format(M[10])+'  precio: '+PRECIO[10])
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Open Bills in Bill Gr.';
                    Editable = false;
                }
                field("4";'Mes -3  - Cantidad:  '+Format(M[9])+'  precio: '+PRECIO[9])
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Open Bills in Post. Bill Gr.';
                    Editable = false;
                }
                field("5";'Mes -4  - Cantidad: '+Format(M[8])+'  precio: '+PRECIO[8])
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Hon. Bills in Post. Bill Gr.';
                    Editable = false;
                }
                field("6";'Mes -5  - Cantidad:  '+Format(M[7])+'  precio: '+PRECIO[7])
                {
                    ApplicationArea = Basic;
                    Caption = '6';
                }
                field("7";'Mes -6  - Cantidad:  '+Format(M[6])+'  precio: '+PRECIO[6])
                {
                    ApplicationArea = Basic;
                    Caption = '7';
                }
                field("8";'Mes -7  - Cantidad: '+Format(M[5])+'  precio: '+PRECIO[5])
                {
                    ApplicationArea = Basic;
                    Caption = '8';
                }
                field("9";'Mes -8  - Cantidad:  '+Format(M[4])+'  precio: '+PRECIO[4])
                {
                    ApplicationArea = Basic;
                    Caption = '9';
                }
                field("10";'Mes -9 - Cantidad:  '+Format(M[3])+'  precio: '+PRECIO[3])
                {
                    ApplicationArea = Basic;
                    Caption = '10';
                }
                field("11";'Mes -10 - Cantidad:  '+Format(M[2])+'  precio: '+PRECIO[2])
                {
                    ApplicationArea = Basic;
                    Caption = '11';
                }
                field("12";'Mes -11 - Cantidad: '+Format(M[1])+'  precio: '+PRECIO[1])
                {
                    ApplicationArea = Basic;
                    Caption = '12';
                }
                field(Total;'Total 12 Meses '+Format(M[12]+M[11]+M[10]+M[9]+M[8]+M[7]+M[6]+M[5]+M[4]+M[3]+M[2]+M[1]))
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
        I:=0;
        Clear(M);
        Clear(PRECIO);
        repeat
             I:=I+1;
             REC111.Reset;
             REC111.SetCurrentkey(REC111."Sell-to Customer No.",REC111."No.");
             REC111.SetRange(REC111."Sell-to Customer No.",Rec.Código);
             REC111.SetRange(REC111."No.",Rec.Referencia);
             REC111.SetRange(REC111."Shipment Date",INTERVALOD[I],INTERVALOH[I]);
             if REC111.FindFirst then repeat
                  M[I]:=M[I]+REC111.Quantity;
                  PRECIO[I]:=PRECIO[I]+Format(REC111.Quantity)+' a '+Format(REC111."Unit Price")+'/';
             until REC111.Next = 0;
        until I=12;
    end;

    trigger OnOpenPage()
    begin

        DESDEI:=CalcDate('-1A',Today);
        Rec.SetRange(Rec."Filtro fecha",DESDEI,Today);
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

    var
        DocumentSituationFilter: array [3] of Option " ","Posted BG/PO","Closed BG/PO","BG/PO",Cartera,"Closed Documents";
        NoOpen: array [5] of Integer;
        NoHonored: array [5] of Integer;
        NoRejected: array [5] of Integer;
        NoRedrawn: array [5] of Integer;
        OpenAmtLCY: array [5] of Decimal;
        HonoredAmtLCY: array [5] of Decimal;
        RejectedAmtLCY: array [5] of Decimal;
        RedrawnAmtLCY: array [5] of Decimal;
        OpenRemainingAmtLCY: array [5] of Decimal;
        RejectedRemainingAmtLCY: array [5] of Decimal;
        HonoredRemainingAmtLCY: array [5] of Decimal;
        RedrawnRemainingAmtLCY: array [5] of Decimal;
        j: Integer;
        CustInvoiceDisc: Record "Cust. Invoice Disc.";
        Imp: array [12] of Decimal;
        Acum: array [12] of Decimal;
        Tanto: array [12] of Decimal;
        SalesHeader: Record "Sales Header";
        ImpBase: Decimal;
        Consegido: Text;
        SalesLine: Record "Sales Line";
        TotalLin: Decimal;
        Impdto: Decimal;
        TotalBase: Decimal;
        Diferencia: Decimal;
        fecha: array [10] of Date;
        canti: array [10] of Integer;
        Cestacompra: Record "Cesta compra";
        RecLV: Record "Sales Line";
        Rec2: Record "Cesta compra";
        LIN: Decimal;
        RecCV: Record "Sales Header";
        M: array [12] of Decimal;
        DESDEI: Date;
        INTERVALOD: array [12] of Date;
        MES1: Integer;
        "año": Integer;
        INTERVALOH: array [12] of Date;
        I: Integer;
        REC111: Record "Sales Shipment Line";
        mesc: array [12] of Code[10];
        stocksilla: Decimal;
        Recitem: Record Item;
        botoncorrecto: Boolean;
        PRECIO: array [12] of Text;


    procedure UpdateDocStatistics()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
    end;


    procedure DrillDownOpen(Situation: Option " ","Posted BG/PO","Closed BG/PO","BG/PO",Cartera,"Closed Documents";DocType: Option Invoice,Bill)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        /////-CustLedgEntriesForm: Page "Customer Ledger Entries";
    begin
    end;


    procedure DrillDownHonored(Situation: Option " ","Posted BG/PO","Closed BG/PO","BG/PO",Cartera,"Closed Documents";DocType: Option Invoice,Bill)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        /////-CustLedgEntriesForm: Page "Customer Ledger Entries";
    begin
    end;


    procedure DrillDownRejected(Situation: Option " ","Posted BG/PO","Closed BG/PO","BG/PO",Cartera,"Closed Documents";DocType: Option Invoice,Bill)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntriesForm: Page "Customer Ledger Entries";
    begin
    end;


    procedure DrillDownRedrawn(Situation: Option " ","Posted BG/PO","Closed BG/PO","BG/PO",Cartera,"Closed Documents";DocType: Option Invoice,Bill)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntriesForm: Page "Customer Ledger Entries";
    begin
    end;
}

