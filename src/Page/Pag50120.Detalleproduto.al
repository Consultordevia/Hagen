#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50120 "Detalle produto"
{
    Caption = 'Supra Oferta';
    Editable = false;
    PageType = CardPart;
    SourceTable = "Sales Header";

    layout
    {
        area(content)
        {
            group(Escalado)
            {
                Caption = 'No. of Bills';
                field("1";'> a '+Format(Imp[1])+' '+Format(Tanto[1])+'%')
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Open Bills';
                    Editable = false;
                }
                field("2";'> a '+Format(Imp[2])+' '+Format(Tanto[2])+'%')
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Open Bills in Bill Gr.';
                    Editable = false;
                }
                field("3";'> a '+Format(Imp[3])+' '+Format(Tanto[3])+'%')
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Open Bills in Post. Bill Gr.';
                    Editable = false;
                }
                field("4";'> a '+Format(Imp[4])+' '+Format(Tanto[4])+'%')
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Hon. Bills in Post. Bill Gr.';
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
        UpdateDocStatistics;

        Consegido:='';
        SalesHeader.Get(Rec."Document Type",Rec."No.");
        SalesHeader.CalcFields(SalesHeader.Amount);
        ImpBase:=SalesHeader.Amount;
        //// TotalLin:=SalesHeader.ImpBase;


        Diferencia:=0;
        TotalBase:=0;
        CustInvoiceDisc.Reset;
        CustInvoiceDisc.SetRange(CustInvoiceDisc.Code,'SUPRAOFERTA');
        if CustInvoiceDisc.FindSet then repeat
             if ImpBase>CustInvoiceDisc."Minimum Amount" then begin
                  Consegido:=Format(CustInvoiceDisc."Discount %")+'%';
                  TotalBase:=TotalLin-ROUND(TotalLin*CustInvoiceDisc."Discount %"/100,0.01);
                  Diferencia:=TotalBase-ImpBase;
             end;
        until CustInvoiceDisc.Next=0;


    end;

    trigger OnOpenPage()
    begin



        I:=0;
        CustInvoiceDisc.SetRange(CustInvoiceDisc.Code,'SUPRAOFERTA');
        if CustInvoiceDisc.FindSet then repeat
             I:=I+1;
             Imp[I]:=CustInvoiceDisc."Minimum Amount";
             Tanto[I]:=CustInvoiceDisc."Discount %"
        until CustInvoiceDisc.Next=0;
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
        I: Integer;
        SalesHeader: Record "Sales Header";
        ImpBase: Decimal;
        Consegido: Text;
        SalesLine: Record "Sales Line";
        TotalLin: Decimal;
        Impdto: Decimal;
        TotalBase: Decimal;
        Diferencia: Decimal;
        SalesLineDiscountPadre: Record "Sales Line Discount Padre";


    procedure UpdateDocStatistics()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        DocumentSituationFilter[1] := Documentsituationfilter::Cartera;
        DocumentSituationFilter[2] := Documentsituationfilter::"BG/PO";
        DocumentSituationFilter[3] := Documentsituationfilter::"Posted BG/PO";

        with CustLedgEntry do begin
          SetCurrentkey("Customer No.","Document Type","Document Situation","Document Status");
          SetRange("Customer No.",Rec."No.");
          for j := 1 to 5 do begin
            case j of
              4: // Closed Bill Group and Closed Documents
                begin
                  SetRange("Document Type","document type"::Bill);
                  SetFilter("Document Situation",'%1|%2',
                    "document situation"::"Closed BG/PO",
                    "document situation"::"Closed Documents");
                end;
              5: // Invoices
                begin
                  SetRange("Document Type","document type"::Invoice);
                  SetFilter("Document Situation",'<>0');
                end;
              else begin
                SetRange("Document Type","document type"::Bill);
                SetRange("Document Situation",DocumentSituationFilter[j]);
              end;
            end;
            SetRange("Document Status","document status"::Open);
            CalcSums("Amount (LCY) stats.","Remaining Amount (LCY) stats.");
            OpenAmtLCY[j] := "Amount (LCY) stats.";
            OpenRemainingAmtLCY[j] := "Remaining Amount (LCY) stats.";
            NoOpen[j] := Count;
            SetRange("Document Status");

            SetRange("Document Status","document status"::Honored);
            CalcSums("Amount (LCY) stats.","Remaining Amount (LCY) stats.");
            HonoredAmtLCY[j] := "Amount (LCY) stats.";
            HonoredRemainingAmtLCY[j] := "Remaining Amount (LCY) stats.";
            NoHonored[j] := Count;
            SetRange("Document Status");

            SetRange("Document Status","document status"::Rejected);
            CalcSums("Amount (LCY) stats.","Remaining Amount (LCY) stats.");
            RejectedAmtLCY[j] := "Amount (LCY) stats.";
            RejectedRemainingAmtLCY[j] := "Remaining Amount (LCY) stats.";
            NoRejected[j] := Count;
            SetRange("Document Status");

            SetRange("Document Status","document status"::Redrawn);
            CalcSums("Amount (LCY) stats.","Remaining Amount (LCY) stats.");
            RedrawnAmtLCY[j] := "Amount (LCY) stats.";
            RedrawnRemainingAmtLCY[j] := "Remaining Amount (LCY) stats.";
            NoRedrawn[j] := Count;
            SetRange("Document Status");

            SetRange("Document Situation");
          end;
        end;
    end;


    procedure DrillDownOpen(Situation: Option " ","Posted BG/PO","Closed BG/PO","BG/PO",Cartera,"Closed Documents";DocType: Option Invoice,Bill)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntriesForm: Page "Customer Ledger Entries";
    begin
        with CustLedgEntry do begin
          SetCurrentkey("Customer No.","Document Type","Document Situation","Document Status");
          SetRange("Customer No.",Rec."No.");
          case Situation of
            Situation::Cartera:
              SetRange("Document Situation","document situation"::Cartera);
            Situation::"BG/PO":
              SetRange("Document Situation","document situation"::"BG/PO");
            Situation::"Posted BG/PO":
              SetRange("Document Situation","document situation"::"Posted BG/PO");
            Situation::"Closed BG/PO":
              SetFilter("Document Situation",'%1|%2',
                "document situation"::"Closed BG/PO",
                "document situation"::"Closed Documents");
            else
              SetFilter("Document Situation",'<>0');
          end;
          case DocType of
            Doctype::Invoice:
              SetRange("Document Type","document type"::Invoice);
            Doctype::Bill:
              SetRange("Document Type","document type"::Bill);
          end;

          SetRange("Document Status","document status"::Open);
          CustLedgEntriesForm.SetTableview(CustLedgEntry);
          CustLedgEntriesForm.SetRecord(CustLedgEntry);
          CustLedgEntriesForm.RunModal;
          SetRange("Document Status");
          SetRange("Document Situation");
        end;
    end;


    procedure DrillDownHonored(Situation: Option " ","Posted BG/PO","Closed BG/PO","BG/PO",Cartera,"Closed Documents";DocType: Option Invoice,Bill)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntriesForm: Page "Customer Ledger Entries";
    begin
        with CustLedgEntry do begin
          SetCurrentkey("Customer No.","Document Type","Document Situation","Document Status");
          SetRange("Customer No.",Rec."No.");
          case Situation of
            Situation::Cartera:
              SetRange("Document Situation","document situation"::Cartera);
            Situation::"BG/PO":
              SetRange("Document Situation","document situation"::"BG/PO");
            Situation::"Posted BG/PO":
              SetRange("Document Situation","document situation"::"Posted BG/PO");
            Situation::"Closed BG/PO":
              SetFilter("Document Situation",'%1|%2',
                "document situation"::"Closed BG/PO",
                "document situation"::"Closed Documents");
            else
              SetFilter("Document Situation",'<>0');
          end;
          case DocType of
            Doctype::Invoice:
              SetRange("Document Type","document type"::Invoice);
            Doctype::Bill:
              SetRange("Document Type","document type"::Bill);
          end;

          SetRange("Document Status","document status"::Honored);
          CustLedgEntriesForm.SetTableview(CustLedgEntry);
          CustLedgEntriesForm.SetRecord(CustLedgEntry);
          CustLedgEntriesForm.RunModal;
          SetRange("Document Status");
          SetRange("Document Situation");
        end;
    end;


    procedure DrillDownRejected(Situation: Option " ","Posted BG/PO","Closed BG/PO","BG/PO",Cartera,"Closed Documents";DocType: Option Invoice,Bill)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntriesForm: Page "Customer Ledger Entries";
    begin
        with CustLedgEntry do begin
          SetCurrentkey("Customer No.","Document Type","Document Situation","Document Status");
          SetRange("Customer No.",Rec."No.");
          case Situation of
            Situation::Cartera:
              SetRange("Document Situation","document situation"::Cartera);
            Situation::"BG/PO":
              SetRange("Document Situation","document situation"::"BG/PO");
            Situation::"Posted BG/PO":
              SetRange("Document Situation","document situation"::"Posted BG/PO");
            Situation::"Closed BG/PO":
              SetFilter("Document Situation",'%1|%2',
                "document situation"::"Closed BG/PO",
                "document situation"::"Closed Documents");
            else
              SetFilter("Document Situation",'<>0');
          end;
          case DocType of
            Doctype::Invoice:
              SetRange("Document Type","document type"::Invoice);
            Doctype::Bill:
              SetRange("Document Type","document type"::Bill);
          end;

          SetRange("Document Status","document status"::Rejected);
          CustLedgEntriesForm.SetTableview(CustLedgEntry);
          CustLedgEntriesForm.SetRecord(CustLedgEntry);
          CustLedgEntriesForm.RunModal;
          SetRange("Document Status");
          SetRange("Document Situation");
        end;
    end;


    procedure DrillDownRedrawn(Situation: Option " ","Posted BG/PO","Closed BG/PO","BG/PO",Cartera,"Closed Documents";DocType: Option Invoice,Bill)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntriesForm: Page "Customer Ledger Entries";
    begin
        with CustLedgEntry do begin
          SetCurrentkey("Customer No.","Document Type","Document Situation","Document Status");
          SetRange("Customer No.",Rec."No.");
          case Situation of
            Situation::Cartera:
              SetRange("Document Situation","document situation"::Cartera);
            Situation::"BG/PO":
              SetRange("Document Situation","document situation"::"BG/PO");
            Situation::"Posted BG/PO":
              SetRange("Document Situation","document situation"::"Posted BG/PO");
            Situation::"Closed BG/PO",Situation::"Closed Documents":
              SetFilter("Document Situation",'%1|%2',
                "document situation"::"Closed BG/PO",
                "document situation"::"Closed Documents");
            else
              SetFilter("Document Situation",'<>0');
          end;
          case DocType of
            Doctype::Invoice:
              SetRange("Document Type","document type"::Invoice);
            Doctype::Bill:
              SetRange("Document Type","document type"::Bill);
          end;
          SetRange("Document Status","document status"::Redrawn);
          CustLedgEntriesForm.SetTableview(CustLedgEntry);
          CustLedgEntriesForm.SetRecord(CustLedgEntry);
          CustLedgEntriesForm.RunModal;
          SetRange("Document Status");
          SetRange("Document Situation");
        end;
    end;
}

