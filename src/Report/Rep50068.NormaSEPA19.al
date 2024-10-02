#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50068 "_Norma SEPA 19"
{
    Caption = 'Norma SEPA 19';
    Permissions = TableData "Bill Group"=m;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Bill Group";"Bill Group")
        {
            DataItemTableView = sorting("No.") where(Factoring=const(" "));
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            dataitem("Cartera Doc.";"Cartera Doc.")
            {
                DataItemLink = "Bill Gr./Pmt. Order No."=field("No.");
                DataItemTableView = sorting(Type,"Bill Gr./Pmt. Order No.","Account No.","Due Date") where(Type=const(Receivable));
                column(ReportForNavId_2; 2)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DocType := DocMisc.DocType("Cartera Doc."."Payment Method Code");
                    CustLedgEntry.Get("Cartera Doc."."Entry No.");
                    Customer.Get(CustLedgEntry."Customer No.");
                    if not CustBankAcc.Get(CustLedgEntry."Customer No.","Cartera Doc."."Cust./Vendor Bank Acc. Code") then begin
                      Error(Text1100007,
                            CustBankAcc.TableCaption,
                            "Cartera Doc."."Cust./Vendor Bank Acc. Code",
                            Customer.TableCaption,
                            CustLedgEntry."Customer No.");
                    end else begin
                      CustCCCBankCode := CustBankAcc."CCC Bank No.";
                      CustCCCBankBranchNo := CustBankAcc."CCC Bank Branch No.";
                      CustCCCControlDigits := CustBankAcc."CCC Control Digits";
                      CustCCCAccNo := CustBankAcc."CCC Bank Account No.";
                      if CheckErrors then begin
                        DocMisc.CheckControlDigit(CustCCCControlDigits,CustCCCBankCode,CustCCCAccNo,CustCCCBankBranchNo);
                        if (CustBankAcc."CCC Control Digits" <> CustCCCControlDigits) and
                           (CustCCCControlDigits <> '**')
                        then begin
                          CustBankAcc."CCC Control Digits" := CustCCCControlDigits;
                          CustBankAcc.Modify;
                        end;
                      end;
                    end;
                    if (CustCCCBankCode = '') or (CustCCCBankBranchNo = '') or
                       (CustCCCControlDigits = '') or (CustCCCAccNo = '')
                    then begin
                      CustCCCBankCode := '0000';
                      CustCCCBankBranchNo := '0000';
                      CustCCCControlDigits := '00';
                      CustCCCAccNo := '0000000000';
                    end;
                    CustAddress[1] := CopyStr(Customer.Name,1,30);
                    CustAddress[2] := CopyStr(Customer.Address,1,30);
                    CustAddress[3] := CopyStr(Customer.City,1,30);
                    CustAddress[4] := CopyStr(Customer."Post Code",1,30);
                    CustNoNIF:=Customer."VAT Registration No.";
                    AdditionalInfo := Text1100008 + "Cartera Doc."."Document No." + '/' + "Cartera Doc."."No.";
                    AdditionalInfo2 := "Cartera Doc."."Document No." + '/' + "Cartera Doc."."No.";
                    if Accepted = Accepted::Yes then
                      IsAccepted := '1'
                    else
                      IsAccepted := '0';
                    TotalDocs := TotalDocs + 1;
                    TotalDocsCust := TotalDocsCust + 1;
                    TotalPrintedCust := TotalPrintedCust + 1;
                    TotalPosted := TotalPosted + 3;
                    case true of
                      LCY = Lcy::Peseta:
                        if IsEuro then
                          DocAmount := EuroAmount("Remaining Amount")
                        else
                          DocAmount := ConvertStr(Format("Cartera Doc."."Remaining Amt. (LCY)",10,Text1100009),' ','0');
                      LCY = Lcy::Euro:
                        if IsEuro then
                          DocAmount := EuroAmount("Remaining Amt. (LCY)")
                        else
                          DocAmount := ConvertStr(Format("Cartera Doc."."Remaining Amount",10,Text1100009),' ','0');
                      LCY = Lcy::Other:
                        if IsEuro then
                          DocAmount := EuroAmount("Remaining Amount")
                        else
                          DocAmount := ConvertStr(Format("Cartera Doc."."Remaining Amount",10,Text1100009),' ','0');
                    end;
                    RegisterCode2 := RegisterCode + 6;
                    DLDACurrency;
                    if codfecha<>"Cartera Doc."."Due Date" then begin
                       if suma2fecimp<>0 then begin
                            t1:=ConvertStr(Format(suma2fecimp*100,17,Text1100006),' ','0');
                            t2:=ConvertStr(Format(suma2fecreg,8,Text1100006),' ','0');
                            t3:=ConvertStr(Format(suma2fecade+2,10,Text1100006),' ','0');
                            Clear(OutText);
                            OutText :=Format('04',2)+
                                      Format(identificador,35)+
                                      Format(fechafi,8)+
                                      Format(t1,17)+
                                      Format(t2,8)+
                                      Format(t3,10)+
                                      Format(' ',520);
                             OutText:=Format(OutText,600);
                            OutFile.Write(OutText);
                       end;
                         suma2fecimp:=0;
                         suma2fecreg:=0;
                         suma2fecade:=0;
                         codfecha:="Cartera Doc."."Due Date";
                         suma3totalade:=suma3totalade+1;
                    end;
                    if codacre<>"Cartera Doc."."Account No." then begin
                       if suma1acrimp<>0 then begin
                            t1:=ConvertStr(Format(suma2fecimp*100,17,Text1100006),' ','0');
                            t2:=ConvertStr(Format(suma2fecreg,8,Text1100006),' ','0');
                            t3:=ConvertStr(Format(suma2fecade+2,10,Text1100006),' ','0');
                            Clear(OutText);
                            OutText :=Format('04',2)+
                                      Format(identificador,35)+
                                      Format(fechafi,8)+
                                      Format(t1,17)+
                                      Format(t2,8)+
                                      Format(t3,10)+
                                      Format(' ',520);
                             OutText:=Format(OutText,600);
                            OutFile.Write(OutText);
                            suma2fecimp:=0;
                             suma2fecreg:=0;
                             suma2fecade:=0;
                             codfecha:="Cartera Doc."."Due Date";
                             suma3totalade:=suma3totalade+1;
                            t1:=ConvertStr(Format(suma1acrimp*100,17,Text1100006),' ','0');
                            t2:=ConvertStr(Format(suma1acrreg,8,Text1100006),' ','0');
                            t3:=ConvertStr(Format(suma1acrade+3,10,Text1100006),' ','0');
                            Clear(OutText);
                            OutText :=Format('05',2)+
                                      Format(identificador,35)+
                                      Format(t1,17)+
                                      Format(t2,8)+
                                      Format(t3,10)+
                                      Format(' ',528);
                             OutText:=Format(OutText,600);
                            OutFile.Write(OutText);
                       end;
                       suma1acrimp:=0;
                       suma1acrreg:=0;
                       suma1acrade:=0;
                       codacre:="Cartera Doc."."Account No.";
                       suma3totalade:=suma3totalade+1;
                    Clear(OutText);
                    OutText :='02'+
                              '19143'+
                              '002'+
                              Format(identificador,35)+
                              Format(fechafi,8)+
                              Format(CompanyInfo.Name,70)+
                              Format(CompanyInfo.Address,50)+
                              Format(CompanyInfo."Post Code"+' '+CompanyInfo.City,50)+
                              Format(CompanyInfo.County,40)+
                              Format('ES',2)+
                              Format(BankAcc.Iban,34)+
                              Format(' ',301);
                              OutText:=Format(OutText,600);
                    OutFile.Write(OutText);
                    suma3totalade:=suma3totalade+1;
                    end;
                    suma1acrimp:=suma1acrimp+"Cartera Doc."."Remaining Amt. (LCY)";
                    suma2fecimp:=suma2fecimp+"Cartera Doc."."Remaining Amt. (LCY)";
                    suma3totalimp:=suma3totalimp+"Cartera Doc."."Remaining Amt. (LCY)";
                    suma1acrreg:=suma1acrreg+1;
                    suma2fecreg:=suma2fecreg+1;
                    suma3totalreg:=suma3totalreg+1;
                    suma1acrade:=suma1acrade+1;
                    suma2fecade:=suma2fecade+1;
                    suma3totalade:=suma3totalade+1;
                    CustAddress[1] := CopyStr(Customer.Name,1,30);
                    CustAddress[2] := CopyStr(Customer.Address,1,30);
                    CustAddress[3] := CopyStr(Customer.City,1,30);
                    CustAddress[4] := CopyStr(Customer."Post Code",1,30);
                    CustAddress[5] := CopyStr(Customer.County,1,30);
                    /*
                    CustAddress[1]:=CU_AS.Ascii2Ansi(CustAddress[1]);
                    CustAddress[2]:=CU_AS.Ascii2Ansi(CustAddress[2]);
                    CustAddress[3]:=CU_AS.Ascii2Ansi(CustAddress[3]);
                    CustAddress[4]:=CU_AS.Ascii2Ansi(CustAddress[4]);
                    CustAddress[5]:=CU_AS.Ascii2Ansi(CustAddress[5]);
                    */
                    BillGrAmount := ConvertStr(Format("Cartera Doc."."Remaining Amt. (LCY)"*100,11,Text1100006),' ','0');
                    tipoIDENT:='A';
                    tipoIDENTDEUDOR:='2';
                    if Customer."Tipo socio"=0 then begin
                         tipoIDENTDEUDOR:='1';
                    end;
                    OutText :=Format('03',2)+
                              Format('19143',5)+
                              Format('003',3)+
                              Format("Cartera Doc."."Document No.",35)+
                              Format("Cartera Doc."."Document No.",35)+
                              Format('RCUR',4)+
                              Format(' ',4)+
                              Format(BillGrAmount,11)+
                              Format(fechafi,8)+
                              Format(CustBankAcc."SWIFT Code",11)+
                              Format(CustAddress[1],70)+
                              Format(CustAddress[2],50)+
                              Format(CustAddress[4]+' '+CustAddress[3],50)+
                              Format(CustAddress[5],40)+
                              Format(Customer."Country/Region Code",2)+
                              Format(tipoIDENTDEUDOR,1)+
                              ///FORMAT(CustBankAcc.BIC,36)+
                              ///FORMAT(CustBankAcc.IBAN,35)+
                              Format(' ',36)+
                              Format(' ',35)+
                              Format(tipoIDENT,1)+
                              Format(CustBankAcc.Iban,34)+
                              Format('   ',4)+
                              Format(' ',140)+
                              Format(' ',19);
                             OutText:=Format(OutText,600);
                    OutFile.Write(OutText);
                    /*
                    CLEAR(OutText);
                    OutText :=FORMAT('04',2)+
                              FORMAT('02',5)+
                              FORMAT('02',3)+
                              FORMAT('02',35)+
                              FORMAT('02',35)+
                              FORMAT('02',70)+
                              FORMAT('02',1)+
                              FORMAT('02',36)+
                              FORMAT('02',35)+
                              FORMAT('02',70)+
                              FORMAT('02',1)+
                              FORMAT('02',36)+
                              FORMAT('02',35)+
                              FORMAT('02',236);
                              {
                      RegisterString + '80' + FORMAT(CompanyInfo."VAT Registration No.",9) + PADSTR(BankSuffix,3,' ') +
                      PADSTR(FORMAT(CustNoNIF),12,' ') + PADSTR(FORMAT(Customer.Name),40,' ') +
                      CONVERTSTR(PADSTR(CustCCCBankCode,4,' '),' ','0') + CONVERTSTR(PADSTR(CustCCCBankBranchNo,4,' '),' ','0') +
                      PADSTR(CustCCCControlDigits,2,' ') + CONVERTSTR(PADSTR(CustCCCAccNo,10,' '),' ','0') +
                      DocAmount + Text1100010 + PADSTR(AdditionalInfo2,10,' ') + PADSTR(AdditionalInfo,40,' ') + PADSTR('',8,' ');
                      }
                    OutFile.WRITE(OutText);
                    CLEAR(OutText);
                    OutText :=FORMAT('05',2)+
                              FORMAT('02',5)+
                              FORMAT('02',3)+
                              FORMAT('02',35)+
                              FORMAT('02',35)+
                              FORMAT('02',2)+
                              FORMAT('02',6)+
                              FORMAT('02',2)+
                              FORMAT('02',9)+
                              FORMAT('02',8)+
                              FORMAT('02',12)+
                              FORMAT('02',481);
                              {
                      RegisterString + '80' + FORMAT(CompanyInfo."VAT Registration No.",9) + PADSTR(BankSuffix,3,' ') +
                      PADSTR(FORMAT(CustNoNIF),12,' ') + PADSTR(FORMAT(Customer.Name),40,' ') +
                      CONVERTSTR(PADSTR(CustCCCBankCode,4,' '),' ','0') + CONVERTSTR(PADSTR(CustCCCBankBranchNo,4,' '),' ','0') +
                      PADSTR(CustCCCControlDigits,2,' ') + CONVERTSTR(PADSTR(CustCCCAccNo,10,' '),' ','0') +
                      DocAmount + Text1100010 + PADSTR(AdditionalInfo2,10,' ') + PADSTR(AdditionalInfo,40,' ') + PADSTR('',8,' ');
                               }
                    OutFile.WRITE(OutText);
                    CLEAR(OutText);
                    OutText :=FORMAT('06',2)+
                              FORMAT('02',5)+
                              FORMAT('02',3)+
                              FORMAT('02',35)+
                              FORMAT('02',35)+
                              FORMAT('02',35)+
                              FORMAT('02',70)+
                              FORMAT('02',35)+
                              FORMAT('02',34)+
                              FORMAT('02',5)+
                              FORMAT('02',341);
                              {
                      RegisterString + '80' + FORMAT(CompanyInfo."VAT Registration No.",9) + PADSTR(BankSuffix,3,' ') +
                      PADSTR(FORMAT(CustNoNIF),12,' ') + PADSTR(FORMAT(Customer.Name),40,' ') +
                      CONVERTSTR(PADSTR(CustCCCBankCode,4,' '),' ','0') + CONVERTSTR(PADSTR(CustCCCBankBranchNo,4,' '),' ','0') +
                      PADSTR(CustCCCControlDigits,2,' ') + CONVERTSTR(PADSTR(CustCCCAccNo,10,' '),' ','0') +
                      DocAmount + Text1100010 + PADSTR(AdditionalInfo2,10,' ') + PADSTR(AdditionalInfo,40,' ') + PADSTR('',8,' ');
                               }
                    OutFile.WRITE(OutText);
                    */

                end;

                trigger OnPostDataItem()
                begin
                    Clear(OutText);
                    TotalPrintedCust := TotalPrintedCust + 1;
                    case true of
                      LCY = Lcy::Peseta:
                        if IsEuro then begin
                          "Bill Group".CalcFields(Amount);
                          TotalAmount := "Bill Group".Amount + TotalAmount;
                          BillGrAmount := EuroAmount("Bill Group".Amount)
                        end else begin
                          "Bill Group".CalcFields("Bill Group"."Amount (LCY)");
                          TotalAmount := "Bill Group"."Amount (LCY)" + TotalAmount;
                          BillGrAmount := ConvertStr(Format("Bill Group"."Amount (LCY)",10,Text1100006),' ','0')
                        end;
                      LCY = Lcy::Euro:
                        if IsEuro then begin
                          "Bill Group".CalcFields("Bill Group"."Amount (LCY)");
                          TotalAmount := "Bill Group"."Amount (LCY)" + TotalAmount;
                          BillGrAmount := EuroAmount("Bill Group"."Amount (LCY)")
                        end else begin
                          "Bill Group".CalcFields("Bill Group".Amount);
                          TotalAmount := "Bill Group".Amount + TotalAmount;
                          BillGrAmount := ConvertStr(Format("Bill Group".Amount,10,Text1100006),' ','0')
                        end;
                      LCY = Lcy::Other:
                        if IsEuro then begin
                          "Bill Group".CalcFields(Amount);
                          TotalAmount := "Bill Group".Amount + TotalAmount;
                          BillGrAmount := EuroAmount("Bill Group".Amount)
                        end else begin
                          "Bill Group".CalcFields("Bill Group".Amount);
                          TotalAmount := "Bill Group".Amount + TotalAmount;
                          BillGrAmount := ConvertStr(Format("Bill Group".Amount,10,Text1100006),' ','0')
                        end;
                    end;
                    RegisterCode2 := RegisterCode + 8;
                    DLDACurrency;
                    TotalDocsCust := 0;
                     TotalPrinted := TotalPrinted + TotalPrintedCust;
                    TotalPrintedCust := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                BillGrNo := CopyStr("Bill Group"."No.",7,3);
                CCCBankNo := BankAcc."CCC Bank No.";
                CCCBankBranchNo := BankAcc."CCC Bank Branch No.";
                CCCControlDigits := BankAcc."CCC Control Digits";
                CCCAccNo := BankAcc."CCC Bank Account No.";
                if (CCCBankNo = '') or (CCCBankBranchNo = '') or
                   (CCCControlDigits = '') or (CCCAccNo = '')
                then
                  Error(Text1100005,BankAcc."No.");
                RegisterCode2 := RegisterCode + 3;
                DLDACurrency;
                TotalPrintedCust := TotalPrintedCust + 1;
            end;

            trigger OnPostDataItem()
            begin
                "No. Printed" := "No. Printed" + 1;
                TotalPrinted := TotalPrinted + 2;
                RegisterCode2 := RegisterCode + 9;
                DLDACurrency;
                if IsEuro then
                  GeneralTotal := EuroAmount(TotalAmount)
                else
                  GeneralTotal := ConvertStr(Format(TotalAmount,10,Text1100006),' ','0');
                   if suma2fecimp<>0 then begin
                        t1:=ConvertStr(Format(suma2fecimp*100,17,Text1100006),' ','0');
                        t2:=ConvertStr(Format(suma2fecreg,8,Text1100006),' ','0');
                        t3:=ConvertStr(Format(suma2fecade+2,10,Text1100006),' ','0');
                        Clear(OutText);
                        OutText :=Format('04',2)+
                                  Format(identificador,35)+
                                  Format(fechafi,8)+
                                  Format(t1,17)+
                                  Format(t2,8)+
                                  Format(t3,10)+
                                  Format(' ',520);
                         OutText:=Format(OutText,600);
                        OutFile.Write(OutText);
                   end;
                   if suma1acrimp<>0 then begin
                        t1:=ConvertStr(Format(suma1acrimp*100,17,Text1100006),' ','0');
                        t2:=ConvertStr(Format(suma1acrreg,8,Text1100006),' ','0');
                        t3:=ConvertStr(Format(suma1acrade+3,10,Text1100006),' ','0');
                        Clear(OutText);
                        OutText :=Format('05',2)+
                                  Format(identificador,35)+
                                  Format(t1,17)+
                                  Format(t2,8)+
                                  Format(t3,10)+
                                  Format(' ',528);
                         OutText:=Format(OutText,600);
                        OutFile.Write(OutText);
                   end;
                suma3totalade:=suma3totalade+1;
                  t1:=ConvertStr(Format(suma3totalimp*100,17,Text1100006),' ','0');
                  t2:=ConvertStr(Format(suma3totalreg,8,Text1100006),' ','0');
                  t3:=ConvertStr(Format(suma3totalade,10,Text1100006),' ','0');
                Clear(OutText);
                OutText :=Format('99',2)+
                          Format(t1,17)+
                          Format(t2,8)+
                          Format(t3,10)+
                          Format(' ',563);
                         OutText:=Format(OutText,600);
                OutFile.Write(OutText);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                "Bill Group".Find('-');
                BankAcc.Get("Bill Group"."Bank Account No.");
                if BankSufixBankAcc = '' then begin
                  Sufix.SetRange (Suffix,BankSufix);
                  if Sufix.Find ('-') then
                    BankSufixBankAcc := Sufix."Bank Acc. Code";
                end;
                IsEuro := DocMisc.GetRegisterCode("Currency Code",RegisterCode,RegisterString);
                RegisterCode2 := RegisterCode + 1;
                DLDACurrency;
                      aa := Date2dmy(WorkDate,3);
                      mm := Date2dmy(WorkDate,2);
                      dd := Date2dmy(WorkDate,1);
                      a1 := Format(aa);
                      m1 := Format(mm);
                      d1 := Format(dd);
                      if d1='0' then d1:='00';
                      if d1='1' then d1:='01';
                      if d1='2' then d1:='02';
                      if d1='3' then d1:='03';
                      if d1='4' then d1:='04';
                      if d1='5' then d1:='05';
                      if d1='6' then d1:='06';
                      if d1='7' then d1:='07';
                      if d1='8' then d1:='08';
                      if d1='9' then d1:='09';
                      if m1='0' then m1:='00';
                      if m1='1' then m1:='01';
                      if m1='2' then m1:='02';
                      if m1='3' then m1:='03';
                      if m1='4' then m1:='04';
                      if m1='5' then m1:='05';
                      if m1='6' then m1:='06';
                      if m1='7' then m1:='07';
                      if m1='8' then m1:='08';
                      if m1='9' then m1:='09';
                fechafi:=a1+m1+d1;
                formatohora;
                contadorref:='0000000000001';
                REF:=contadorref;
                identificador:=CompanyInfo."Identificador empresa bancos";
                Clear(OutText);
                OutText :='01'+
                          '19143'+
                          '001'+
                          Format(identificador,35)+
                          PadStr(CompanyInfo.Name,70,' ')+
                          Format(fechafi,8)+
                          'PRE'+Format(fechafi,8)+
                          Format(HH,2)+
                          Format(MI,2)+
                          Format(SE,2)+
                          Format(mil,5)+Format(REF,13)+
                          ConvertStr(BankAcc."CCC Bank No.",' ','0') +
                          ConvertStr(BankAcc."CCC Bank Branch No.",' ','0');
                          OutText:=Format(OutText,600);
                OutFile.Write(OutText);
                suma3totalade:=suma3totalade+1;
                /*
                CLEAR(OutText);
                OutText :='02'+
                          '19143'+
                          '002'+
                          FORMAT(identificador,35)+
                          FORMAT(fechafi,8)+
                          FORMAT(CompanyInfo.Name,70)+
                          FORMAT(CompanyInfo.Address,50)+
                          FORMAT(CompanyInfo."Post Code"+' '+CompanyInfo.City,50)+
                          FORMAT(CompanyInfo.County,40)+
                          FORMAT('ES',2)+
                          FORMAT(BankAcc.IBAN,34)+
                          FORMAT(' ',301);
                          OutText:=FORMAT(OutText,600);
                OutFile.WRITE(OutText);
                suma3totalade:=suma3totalade+1;
                */

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ExternalFile;ExternalFile)
                    {
                        ApplicationArea = Basic;
                        Caption = 'External file';
                    }
                    field(ChargDate;ChargDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Charging Date';
                    }
                    field(CheckErrors;CheckErrors)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Check Errors';
                    }
                    field(BankSufix;BankSufix)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Bank Sufix';
                        TableRelation = Suffix.Suffix;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Sufix: Record Suffix;
                            Sufixes: Page Suffixes;
                        begin
                            Sufixes.SetTableview(Sufix);
                            Sufixes.SetRecord(Sufix);
                            Sufixes.LookupMode(true);
                            Sufixes.Editable(false);
                            if Sufixes.RunModal = Action::LookupOK then begin
                              Sufixes.GetRecord(Sufix);
                              BankSufixBankAcc := Sufix."Bank Acc. Code";
                              BankSufix := Sufix.Suffix;
                            end;
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if ExternalFile = '' then
              ExternalFile := Text1100011;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        VATRegNo := CopyStr(DelChr(CompanyInfo."VAT Registration No.",'=',' .-/'),1,9);
    end;

    trigger OnPreReport()
    begin
        // IF ChargDate = 0D THEN
        //     ChargDate:=;
        if WithExpenses then
          Expenses := '1'
        else
          Expenses := '0';
        if PrintedDocs then
          PrintedDocs2 := '0'
        else
          PrintedDocs2 := '1';
        Clear(FILE);
        OutFile.TextMode := true;
        OutFile.WriteMode := true;
        OutFile.Create(ExternalFile);
    end;

    var
        Text1100000: label 'Bank Sufix cannot be blank.';
        Text1100001: label 'The Bank Sufix selected belongs to a %1  different than the %2. \';
        Text1100002: label 'Do you want to continue?.';
        Text1100003: label 'Process cancelled by request of user.';
        Text1100005: label 'Some data for Bank Account %1 are missing.';
        Text1100006: label '<integer>';
        Text1100007: label 'There is not %1 %2 for %3 %4.';
        Text1100008: label 'Bill';
        Text1100009: label '<Integer>';
        Text1100010: label 'DEVOL.';
        Text1100011: label 'A:\EFECTOS.ASC';
        CompanyInfo: Record "Company Information";
        Customer: Record Customer;
        CustLedgEntry: Record "Cust. Ledger Entry";
        ShipToAddress: Record "Ship-to Address";
        BankAcc: Record "Bank Account";
        CustBankAcc: Record "Customer Bank Account";
        PaymentMethod: Record "Payment Method";
        DocMisc: Codeunit "Document-Misc";
        OutFile: File;
        ExternalFile: Text[255];
        Posted: Boolean;
        WithExpenses: Boolean;
        PrintedDocs: Boolean;
        CheckErrors: Boolean;
        VATRegNo: Text[9];
        CCCBankNo: Text[4];
        CustCCCBankCode: Text[4];
        CCCBankBranchNo: Text[4];
        CustCCCBankBranchNo: Text[4];
        CCCControlDigits: Text[2];
        CustCCCControlDigits: Text[2];
        CCCAccNo: Text[10];
        CustCCCAccNo: Text[10];
        BillGrNo: Code[4];
        DocNo: Code[15];
        DocType: Code[1];
        AdditionalInfo: Text[30];
        AdditionalInfo2: Text[30];
        CustAddress: array [12] of Text[30];
        TotalPosted: Decimal;
        TotalDocs: Decimal;
        TotalDocsCust: Decimal;
        TotalPrintedCust: Decimal;
        TotalPrinted: Decimal;
        TotalAmount: Decimal;
        Expenses: Code[1];
        IsAccepted: Code[1];
        PrintedDocs2: Code[1];
        OutText: Text[1000];
        BillGrNo2: Code[15];
        Weight: Text[30];
        Cad1: Text[30];
        Cad2: Text[30];
        Par1: Integer;
        Par2: Integer;
        Tot1: Integer;
        Tot2: Integer;
        cont: Integer;
        ChargDate: Date;
        RegisterCode: Integer;
        RegisterCode2: Integer;
        RegisterString: Text[2];
        DocAmount: Text[10];
        BillGrAmount: Text[11];
        GeneralTotal: Text[10];
        CustNoNIF: Text[30];
        Doc2: Record "Cartera Doc.";
        DateMaxEfe: Date;
        IsEuro: Boolean;
        LCY: Option Peseta,Euro,Other;
        BankSufix: Code[3];
        BankSufixBankAcc: Code[20];
        Sufix: Record Suffix;
        ToFile: Text[1024];
        CommonDialogMgt: Codeunit UnknownCodeunit412;
        [InDataSet]
        FileNameControlVisible: Boolean;
        identificador: Code[35];
        REF: Code[13];
        aa: Integer;
        mm: Integer;
        dd: Integer;
        a1: Code[4];
        m1: Code[2];
        d1: Code[2];
        fechafi: Code[8];
        HH: Code[2];
        MI: Code[2];
        SE: Code[2];
        CRITERIO: Option FC,FE,FF,LO;
        PESO: Code[1];
        TIEMPO: Code[20];
        LONG: Code[4];
        PESO2: Code[10];
        ENCONTRADO: Boolean;
        PUNTO: Code[10];
        CUANTOS: Decimal;
        DESDE: Decimal;
        mil: Code[10];
        contadorref: Code[13];
        t1: Code[17];
        t2: Code[8];
        t3: Code[10];
        suma1acrimp: Decimal;
        suma2fecimp: Decimal;
        suma3totalimp: Decimal;
        suma1acrreg: Integer;
        suma2fecreg: Integer;
        suma3totalreg: Integer;
        suma1acrade: Integer;
        suma2fecade: Integer;
        suma3totalade: Integer;
        codfecha: Date;
        codacre: Code[10];
        CU_AS: Codeunit UnknownCodeunit50011;
        tipoIDENT: Code[1];
        tipoIDENTDEUDOR: Code[1];


    procedure DLDACurrency()
    begin
        if StrLen(Format(RegisterCode)) = 1 then
          RegisterString := '0' + Format(RegisterCode2)
        else
          RegisterString := Format(RegisterCode2);
    end;


    procedure EuroAmount(Amount: Decimal): Text[10]
    var
        TextAmount: Text[15];
    begin
        TextAmount := ConvertStr(Format(Amount),' ','0');
        if StrPos(TextAmount,',') = 0 then
          TextAmount := TextAmount + '00'
        else begin
          if StrLen(CopyStr(TextAmount,StrPos(TextAmount,','),StrLen(TextAmount))) = 2 then
            TextAmount := TextAmount + '0';
          TextAmount := DelChr(TextAmount,'=',',');
        end;
        if StrPos(TextAmount,'.') = 0 then
          TextAmount := TextAmount
        else
          TextAmount := DelChr(TextAmount,'=','.');
        while StrLen(TextAmount) < 10 do
          TextAmount := '0' + TextAmount;
        exit(TextAmount);
    end;


    procedure DateMax() Datemax: Date
    begin
        Doc2.SetRange(Doc2.Type,0);
        Doc2.SetRange(Doc2."Bill Gr./Pmt. Order No.","Bill Group"."No.");
        Doc2.Find('-');
        Datemax:=Doc2."Posting Date";
        repeat
        if Datemax < Doc2."Posting Date" then
             Datemax:=Doc2."Posting Date";
        until Doc2.Next=0;
        Doc2.Reset;
        exit(Datemax);
    end;


    procedure formatohora()
    begin
              TIEMPO := Format(Time);
              ENCONTRADO:=false;
              CUANTOS:=0;
              repeat
              CUANTOS:=CUANTOS+1;
              PUNTO:=CopyStr(TIEMPO,CUANTOS,1);
              if PUNTO=':' then begin
                   ENCONTRADO:=true;
              end;
              until ENCONTRADO;
              HH := CopyStr(TIEMPO,1,CUANTOS-1);
              if HH='0' then HH:='00';
              if HH='1' then HH:='01';
              if HH='2' then HH:='02';
              if HH='3' then HH:='03';
              if HH='4' then HH:='04';
              if HH='5' then HH:='05';
              if HH='6' then HH:='06';
              if HH='7' then HH:='07';
              if HH='8' then HH:='08';
              if HH='9' then HH:='09';
              ENCONTRADO:=false;
              DESDE:=CUANTOS+1;
              CUANTOS:=0;
              repeat
              CUANTOS:=CUANTOS+1;
              PUNTO:=CopyStr(TIEMPO,CUANTOS,1);
              if PUNTO=':' then begin
                   ENCONTRADO:=true;
              end;
              until ENCONTRADO;
              MI := CopyStr(TIEMPO,DESDE,CUANTOS-1);
              if MI='0' then MI:='00';
              if MI='1' then MI:='01';
              if MI='2' then MI:='02';
              if MI='3' then MI:='03';
              if MI='4' then MI:='04';
              if MI='5' then MI:='05';
              if MI='6' then MI:='06';
              if MI='7' then MI:='07';
              if MI='8' then MI:='08';
              if MI='9' then MI:='09';
              DESDE:=DESDE+CUANTOS+1;
              CUANTOS:=0;
              repeat
              CUANTOS:=CUANTOS+1;
              PUNTO:=CopyStr(TIEMPO,CUANTOS,1);
              if PUNTO=':' then begin
                   ENCONTRADO:=true;
              end;
              until ENCONTRADO;
              SE := CopyStr(TIEMPO,DESDE,2);
              if SE='0' then SE:='00';
              if SE='1' then SE:='01';
              if SE='2' then SE:='02';
              if SE='3' then SE:='03';
              if SE='4' then SE:='04';
              if SE='5' then SE:='05';
              if SE='6' then SE:='06';
              if SE='7' then SE:='07';
              if SE='8' then SE:='08';
              if SE='9' then SE:='09';
              mil:='00000'
    end;
}

