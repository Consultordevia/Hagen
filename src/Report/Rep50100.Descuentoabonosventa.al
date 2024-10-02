#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50100 "Descuento abonos venta"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Descuento abonos venta.rdlc';

    dataset
    {
        dataitem(Customer;Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.","Payment Method Code";
            column(ReportForNavId_72006; 72006)
            {
            }
            column(No;"No.")
            {
            }
            column(Name;Name)
            {
            }
            column(Lbl__No;Customer.FieldCaption("No."))
            {
            }
            column(Lbl_Name;Customer.FieldCaption(Name))
            {
            }
            dataitem(MovCli;"Cust. Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No.");
                DataItemTableView = sorting("Document Type","Customer No.","Posting Date","Currency Code") where("Document Type"=filter("Credit Memo"),Open=const(true));
                PrintOnlyIfDetail = false;
                column(ReportForNavId_72012; 72012)
                {
                }
                column(Document_Type;"Document Type")
                {
                }
                column(Document_No;"Document No.")
                {
                }
                column(Description;Description)
                {
                }
                column(Amount;Amount)
                {
                }
                column(Remaining_Amount;"Remaining Amount")
                {
                }
                column(Currency_Code;"Currency Code")
                {
                }
                column(Due_Date;"Due Date")
                {
                }
                column(Posting_Date;"Posting Date")
                {
                }
                column(Lbl__Document_Type;MovCli.FieldCaption("Document Type"))
                {
                }
                column(Lbl__Document_No;MovCli.FieldCaption("Document No."))
                {
                }
                column(Lbl_Description;MovCli.FieldCaption(Description))
                {
                }
                column(Lbl__Currency_Code;MovCli.FieldCaption("Currency Code"))
                {
                }
                column(Lbl_Amount;MovCli.FieldCaption(Amount))
                {
                }
                column(Lbl__Remaining_Amount;MovCli.FieldCaption("Remaining Amount"))
                {
                }
                column(Lbl__Posting_Date;MovCli.FieldCaption("Posting Date"))
                {
                }
                column(Lbl__Due_Date;MovCli.FieldCaption("Due Date"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                      if YaDescontado then
                       CurrReport.Skip
                      else
                      if DescontarAbono(MovCli) then begin
                        FVenci := MovCli."Due Date";
                        MCtemp.Reset;
                        MCtemp.SetCurrentkey("Customer No.","Posting Date","Currency Code");

                        if MCtemp.Find('-') then begin
                          totalfras := 0;
                          repeat
                            if PRIMERA then begin
                                 NASI:=NASI+1;
                                 ndoc:=Cu_next.GetNextNo(RecSD."Posting No. Series",Today,true);
                                 PRIMERA:=false;
                            end;

                            LD.Init;
                            LD."Journal Template Name" := 'CARTERA';
                            LD."Journal Batch Name" := confcar."Serie agrupacion";
                            lin := lin + 10000;
                            LD."Line No." := lin;
                            LD."Account Type" := LD."account type"::Customer;
                            LD.Validate("Account No.",MovCli."Customer No.");
                            LD."Posting Date" := WorkDate;
                            LD."Document Type" := LD."document type"::" ";
                            LD."Transaction No.":=NASI;
                            LD."Document No." := ndoc;
                            //microval 21 040302
                            //LD.Descripción := 'Descuento abono Nº '+MovCli."Nº documento";
                            LD.Description := 'Descuento abonos. ' + Format(MCtemp."Document Type") + ' Nº '+MCtemp."Document No.";
                            if MCtemp."Document Type" = MCtemp."document type"::Bill then begin
                              LD.Description := LD.Description + ' / ' + MCtemp."Bill No.";
                              if MCtemp."Due Date" > FVenci then
                                FVenci := MCtemp."Due Date";
                                FVenci := MCtemp."Due Date";
                            end;

                            //fin
                            LD."Applies-to Doc. Type" := MCtemp."Document Type";
                            LD.Validate("Applies-to Doc. No.",MCtemp."Document No.");
                            LD.Validate("Applies-to Bill No.",MCtemp."Bill No.");
                            MCtemp.CalcFields(MCtemp."Remaining Amt. (LCY)");
                            LD.Validate(Amount,-MCtemp."Remaining Amt. (LCY)");
                            RecDirPago.Reset;
                            RecDirPago.SetRange(RecDirPago."Customer No.",Customer."No.");
                            if RecDirPago.Find('-') then begin
                                 LD."Pmt. Address Code":=RecDirPago.Code;
                            end;
                            LD.Insert(true);
                            totalfras := totalfras - LD.Amount;
                          until MCtemp.Next = 0;
                          //microval 21 07/02/2002
                          if totalfras > 0 then begin
                          //fin
                            LD.Init;
                            LD."Journal Template Name" := 'CARTERA';
                            LD."Journal Batch Name" := confcar."Serie agrupacion";
                            lin := lin + 10000;
                            LD."Line No." := lin;
                            LD."Account Type" := LD."account type"::Customer;
                            LD.Validate("Account No.",MovCli."Customer No.");
                            LD."Posting Date" := WorkDate;
                            LD."Document Type" := LD."document type"::Bill;
                            LD."Transaction No.":=NASI;
                            LD."Document No." := ndoc;
                            LD."Bill No." := '1';
                            LD.Description := 'Descuento abonos. Nuevo efecto Nº '+Doc;
                            LD.Validate(Amount,totalfras);

                            //microval 21 030302
                            //LD.VALIDATE("Fecha vencimiento",MovCli."Fecha vencimiento");
                            LD.Validate("Due Date",FVenci);
                            //fin

                            LD.Insert(true);
                          //microval 21 07/02/2002
                          end else
                            //microval 21 040302
                            //Suman mas los abonos que las facturas, hay que dejar pendientes abonos
                            if totalfras < 0 then begin
                              LD.Reset;
                              LD.SetRange("Journal Template Name",'CARTERA');
                              LD.SetRange("Journal Batch Name",confcar."Serie agrupacion");
                              LD.SetRange(LD."Applies-to Doc. Type",LD."applies-to doc. type"::"Credit Memo");
                              if LD.Find('+') then begin
                                repeat
                                  if (LD.Amount > 0) then begin
                                    if (LD.Amount > -totalfras) then begin
                                      LD.Amount := LD.Amount + totalfras;
                                      LD.Validate(Amount);
                                      LD.Modify;
                                      totalfras := 0;
                                    end else begin
                                      totalfras := totalfras + LD.Amount;
                                      LD.Delete;
                                    end;
                                  end;
                                until (totalfras = 0) or (LD.Next(-1) = 0);
                              end;
                              //fin;
                            end;
                          //fin
                          Doc := IncStr(Doc);
                          YaDescontado := true;
                        end;
                      end;
                end;

                trigger OnPreDataItem()
                begin
                    MovCli.SetRange("Posting Date",fechaini,fechafin);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                YaDescontado := false;

                NASI:=NASI+1;
                ndoc:=Cu_next.GetNextNo(RecSD."Posting No. Series",Today,true);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Opciones)
                {
                    Caption = 'Opciones';
                    field(fechaini;fechaini)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Fecha inicio';
                    }
                    field(fechafin;fechafin)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Fecha fin';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if fechaini = 0D then
          Error('Falta introducir la fecha de inicio.');
        if fechafin = 0D then
          Error('Falta introducir la fecha de fin.');
        if fechaini > fechafin then
          Error('La fecha de inicio no puede ser mayor que la fecha de fin.');
        ndoc:='1';
        confcar.Get;
        if confcar."Contador descuento abonos"<>'' then begin
             ndoc := confcar."Contador descuento abonos";
        end;
        Commit;
        if not (SDG.Get('CARTERA',confcar."Serie agrupacion")) then
          Error('Falta crear la sección del diario de Cartera '+confcar."Serie agrupacion");
        LD.SetRange("Journal Template Name",'CARTERA');
        LD.SetRange("Journal Batch Name",confcar."Serie agrupacion");
        if LD.Find('-') then
          Error('Debe registrar o eliminar las líneas del diario cartera sección '+confcar."Serie agrupacion"+
            ' antes de preparar otro descuento de abonos.');
        lin := 0;
        Doc := ndoc;

        RecSD.Get('CARTERA',confcar."Serie agrupacion");
    end;

    var
        ndoc: Code[10];
        fechaini: Date;
        fechafin: Date;
        LD: Record "Gen. Journal Line";
        MCtemp: Record "Cust. Ledger Entry" temporary;
        confcar: Record "Cartera Setup";
        lin: Integer;
        totalfras: Decimal;
        YaDescontado: Boolean;
        LSer: Record "No. Series Line";
        Doc: Code[10];
        SDG: Record "Gen. Journal Batch";
        FVenci: Date;
        RecDirPago: Record "Customer Pmt. Address";
        NASI: Integer;
        RecSD: Record "Gen. Journal Batch";
        Cu_next: Codeunit NoSeriesManagement;
        PRIMERA: Boolean;


    procedure DescontarAbono(MC: Record "Cust. Ledger Entry") Descontar: Boolean
    var
        MC2: Record "Cust. Ledger Entry";
        total: Decimal;
    begin
        MCtemp.Reset;
        MCtemp.DeleteAll;

        MCtemp.SetCurrentkey(MCtemp."Customer No.",MCtemp.Open,MCtemp."Document Type",MCtemp."Posting Date");
        MC2.SetCurrentkey(MC2."Customer No.",MC2.Open,MC2."Document Type",MC2."Posting Date");
        MC2.SetRange("Customer No.",MC."Customer No.");
        MC2.SetRange(Open,true);
        MC2.SetRange("Document Type",MC2."document type"::Bill);
        MC2.SetRange("Posting Date",fechaini,fechafin);

        // MC2.SETRANGE(MC2."Forma de Pago",Customer."Payment Method Code"); CAC No existe campo
        MC2.SetRange("Payment Method Code",Customer."Payment Method Code");

        total := 0;
        if MC2.Find('-') then
          repeat
            //Quitar efectos remesados, impagos, etc...
            if ( (MC2."Document Status" = MC2."document status"::Open) and
                 (MC2."Document Situation" = MC2."document situation"::Cartera)
               ) then begin
              MCtemp.Init;
              MCtemp.TransferFields(MC2);
              MCtemp.Insert;
              MC2.CalcFields(MC2."Remaining Amt. (LCY)");
              total := total + MC2."Remaining Amt. (LCY)";
            end;
          until (MC2.Next = 0);
        MC.CalcFields(MC."Remaining Amt. (LCY)");
        Descontar := (total > Abs(MC."Remaining Amt. (LCY)"));


        if Descontar then begin
          //inserto el abono
          MCtemp.Init;
          MCtemp.TransferFields(MC);
          MCtemp.Insert;
          MC.CalcFields(MC."Remaining Amt. (LCY)");
          total := total + MC."Remaining Amt. (LCY)";

          //miro si se pueden descontar otros abonos
          MC2.Reset;
          MC2.SetCurrentkey(MC2."Customer No.",MC2.Open,MC2."Document Type",MC2."Posting Date");
          MC2.SetRange("Customer No.",MC."Customer No.");
          MC2.SetRange(Open,true);
          MC2.SetRange("Document Type",MC2."document type"::"Credit Memo");
          MC2.SetRange("Posting Date",fechaini,fechafin);
          MC2.SetFilter(MC2."Entry No.",'<> %1',MC."Entry No.");
          if MC2.Find('-') then
            repeat
                MCtemp.Init;
                MCtemp.TransferFields(MC2);
                MCtemp.Insert;
                MC2.CalcFields(MC2."Remaining Amt. (LCY)");
                total := total + MC2."Remaining Amt. (LCY)";
            until (total < 0) or (MC2.Next = 0);

          //Ahora quitar las facturas o efectos que sobren en el descuento
          if total > 0 then begin
            MCtemp.Reset;
            MCtemp.SetCurrentkey("Due Date","Customer No.",Positive,Open);
            MCtemp.SetFilter("Document Type",'%1 | %2',MCtemp."document type"::Invoice,MCtemp."document type"::Bill);
            if MCtemp.Find('+') then
              repeat
                MCtemp.CalcFields(MCtemp."Remaining Amt. (LCY)");
                if MCtemp."Remaining Amt. (LCY)" < total then begin
                  total := total - MCtemp."Remaining Amt. (LCY)";
                  MCtemp.Delete;
                end;
              until (MCtemp.Next(-1) = 0) or (total <= 0);
          end;
        end;
    end;
}

