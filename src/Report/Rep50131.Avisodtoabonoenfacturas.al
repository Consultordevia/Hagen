#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50131 "Aviso dto. abono en facturas"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Aviso dto. abono en facturas.rdlc';

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = sorting("Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.") where("Applies-to Doc. No." = filter(<> ''));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Account Type", "Account No.";
            column(ReportForNavId_72004; 72004)
            {
            }
            column(Label_1; Lbl_Label_1)
            {
            }
            column(P_gina_FORMAT_CurrReport_PAGENO; 'Página ' + Format('%PAGENO'))
            {
            }
            column(Muro_del_Alcoy_FORMAT_TODAY_0_4; 'SILLA, ' + Format(Today, 0, 4))
            {
            }
            column(Label_4; Lbl_Label_4)
            {
            }
            column(Label_5; Lbl_Label_5)
            {
            }
            column(Label_6; Lbl_Label_6)
            {
            }
            column(Label_8; Lbl_Label_8)
            {
            }
            column(Label_10; Lbl_Label_10)
            {
            }
            column(Label_12; Lbl_Label_12)
            {
            }
            column(Label_13; Lbl_Label_13)
            {
            }
            column(Label_15; Lbl_Label_15)
            {
            }
            column(Label_16; Lbl_Label_16)
            {
            }
            column(DirClie_1; DirClie[1])
            {
            }
            column(DirClie_3; DirClie[3])
            {
            }
            column(DirClie_4; DirClie[4])
            {
            }
            column(Clie_VAT_Registration_No; Clie."VAT Registration No.")
            {
            }
            column(DirClie_5; DirClie[5])
            {
            }
            column(DirClie_6; DirClie[6])
            {
            }
            column(DirClie_7; DirClie[7])
            {
            }
            column(DirClie_2; DirClie[2])
            {
            }
            column(Account_No; "Account No.")
            {
            }
            column(Lbl__Account_No; Lbl__Account_No)
            {
            }
            column(Document_No; "Gen. Journal Line"."Applies-to Doc. No.")
            {
            }
            column(Label_27; Lbl_Label_27)
            {
            }
            column(Label_28; Lbl_Label_28)
            {
            }
            column(Label_29; Lbl_Label_29)
            {
            }
            column(Label_30; Lbl_Label_30)
            {
            }
            column(Label_31; Lbl_Label_31)
            {
            }
            column(infoemp_Name; infoemp.Name)
            {
            }
            column(TxtFooter1; TxtFooter1)
            {
            }
            column(TxtFooter2; TxtFooter2)
            {
            }
            column(Account_Type; "Account Type")
            {
            }
            column(Account_No_1; "Account No.")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Document No." = field("Applies-to Doc. No."), "Bill No." = field("Applies-to Bill No."), "Document Type" = field("Applies-to Doc. Type");
                DataItemTableView = sorting("Document Type", "Document No.", "Customer No.") where(Open = const(true));
                PrintOnlyIfDetail = false;
                column(ReportForNavId_72061; 72061)
                {
                }
                column(Posting_Date; "Posting Date")
                {
                }
                column(Document_Type; "Document Type")
                {
                }
                column(Document_No_1; "Document No.")
                {
                }
                column(TxtDesc; TxtDesc)
                {
                }
                column(Remaining_Amt_LCY; "Remaining Amt. (LCY)")
                {
                }
                column(Due_Date; "Due Date")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    total := total + "Cust. Ledger Entry"."Remaining Amt. (LCY)";

                    LDG.Reset;
                    LDG.SetRange("Journal Template Name", 'CARTERA');
                    LDG.SetRange("Journal Batch Name", confcar."Serie agrupacion");
                    LDG.SetRange("Account Type", "Gen. Journal Line"."Account Type");
                    LDG.SetRange("Account No.", "Gen. Journal Line"."Account No.");
                    LDG.SetRange("Applies-to Doc. No.", '');
                    if not LDG.Find('-') then
                        LDG.Init;
                    if LDG."Amount (LCY)" <> 0 then begin
                        TxtFooter1 := 'Lo que arroja un saldo a n/favor de ' + Format(LDG."Amount (LCY)") + ' ░';
                        TxtFooter2 := 'por lo que se pone un giro en circulación al vencimiento del ' + Format(LDG."Due Date");
                    end else begin
                        if total < 0 then begin
                            TxtFooter1 := 'Lo que arroja un saldo a s/favor de ' + Format(-total) + ' ░';
                            TxtFooter2 := '';
                        end else begin
                            TxtFooter1 := 'Se le compensan las citadas facturas y abonos quedando saldado el importe pendiente.';
                            TxtFooter2 := '';
                        end;
                    end;

                    TxtDesc := "Cust. Ledger Entry".Description;
                    if "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."document type"::"Credit Memo" then
                        TxtDesc := 'Abono';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                for i := 1 to 8
                do DirClie[i] := '';
                Clie.Init;
                if "Gen. Journal Line"."Account Type" = "Gen. Journal Line"."account type"::Customer then begin
                    if Clie.Get("Gen. Journal Line"."Account No.") then;
                    //DirecPago.Reset;
                    //DirecPago.SetRange("Customer No.", "Gen. Journal Line"."Account No.");
                    ///  IF DirecPago.FIND('-') THEN
                    ///    FormatDire.DirPagoCliente(DirClie,DirecPago)
                    ///  ELSE
                    ///    IF Clie.GET("Gen. Journal Line"."Account No.") THEN
                    FormatDire.Customer(DirClie, Clie);
                end;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Account No.");
                SetRange("Journal Template Name", 'CARTERA');
                SetRange("Journal Batch Name", confcar."Serie agrupacion");
                total := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        infoemp.Get;
        confcar.Find('-');
        confcar.TestField(confcar."Serie agrupacion");
        if not (SDG.Get('CARTERA', confcar."Serie agrupacion")) then
            Error('Falta crear la sección del diario de Cartera ' + confcar."Serie agrupacion");
        ///SDG.TESTFIELD(SDG."No. Series");
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        infoemp: Record "Company Information";
        confcar: Record "Cartera Setup";
        SDG: Record "Gen. Journal Batch";
        total: Decimal;
        LDG: Record "Gen. Journal Line";
        TxtFooter1: Text[200];
        TxtFooter2: Text[200];
        DirClie: array[8] of Text[50];
        FormatDire: Codeunit "Format Address";
        Clie: Record Customer;
        Prove: Record Vendor;
        i: Integer;
        TxtDesc: Text[50];
        //DirecPago: Record "Customer Pmt. Address";
        Lbl_Label_1: label 'NOTIFICACIÓN CONTABLE';
        Lbl_Label_4: label 'Estimado cliente:';
        Lbl_Label_5: label 'Por la presente pasamos a comunicarle que los documentos que a continuación se relacionan han';
        Lbl_Label_6: label 'sido compensados en su estimada cuenta:';
        Lbl_Label_8: label 'Fecha vencimiento';
        Lbl_Label_10: label 'Importe ░';
        Lbl_Label_12: label 'Descripción';
        Lbl_Label_13: label 'Nº documento';
        Lbl_Label_15: label 'Tipo documento';
        Lbl_Label_16: label 'Fecha registro';
        Lbl__Account_No: label 'Nº cliente';
        Lbl_Label_27: label 'lo que ponemos en su conocimiento para la posterior gestión de cobros y pagos.';
        Lbl_Label_28: label 'Sin otro particular y quedando a su disposición para cualquier aclaración al respecto, ';
        Lbl_Label_29: label 'reciba nuestro más cordial saludo.';
        Lbl_Label_30: label 'Atentamente,';
        Lbl_Label_31: label 'Dpto. Contabilidad';
}

