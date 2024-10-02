#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50166 "LISTADO DE FACTURAS EMITIDAS"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/LISTADO DE FACTURAS EMITIDAS.rdlc';

    dataset
    {
        dataitem("VAT Entry";"VAT Entry")
        {
            DataItemTableView = sorting("No. Series","Posting Date","Document No.","VAT Bus. Posting Group","VAT Prod. Posting Group","VAT %","EC %") where("Document Type"=filter(=Invoice|"Credit Memo"));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No. Series","Posting Date","Document No.","VAT Bus. Posting Group","VAT Prod. Posting Group","VAT %","EC %";
            column(ReportForNavId_72004; 72004)
            {
            }
            column(Label_1000000001;Lbl_Label_1000000001)
            {
            }
            column(FORMAT_TODAY_0_4;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;Empresa)
            {
            }
            column(CurrReport_PAGENO;'%PAGENO')
            {
            }
            column(Lbl_CurrReport_PAGENO;Lbl_CurrReport_PAGENO)
            {
            }
            column(USERID;UserId)
            {
            }
            column(Fecha_registro;'Fecha registro')
            {
            }
            column(N_documento;'Nº documento')
            {
            }
            column(Cliente;'Cliente')
            {
            }
            column(Nombre_cliente;'Nombre cliente')
            {
            }
            column(CIF_NIF;'CIF/NIF')
            {
            }
            column(Base;'Base')
            {
            }
            column(IVA;'% IVA')
            {
            }
            column(RE;'% RE')
            {
            }
            column(Importe;'Importe')
            {
            }
            column(Gr_IVA_neg;'Gr. IVA neg.')
            {
            }
            column(Gr_IVA_prod;'Gr. IVA prod.')
            {
            }
            column(Importe_1;'Importe')
            {
            }
            column(Fecha_fra;'Fecha. fra.')
            {
            }
            column(FILTROFECHA;FILTROFECHA)
            {
            }
            column(Fecha_Ope;'Fecha. Ope.')
            {
            }
            column(Label_1000000094;Lbl_Label_1000000094)
            {
            }
            column(Label_1000000096;Lbl_Label_1000000096)
            {
            }
            column(VAT_Entry_No_Series;"VAT Entry"."No. Series")
            {
            }
            column(No_Series;'No. Series')
            {
            }
            column(Posting_Date;"Posting Date")
            {
            }
            column(Document_No;"Document No.")
            {
            }
            column(VatEntry_EntryNo;"VAT Entry"."Entry No.")
            {
            }
            column(Bill_to_Pay_to_No;"Bill-to/Pay-to No.")
            {
            }
            column(Base_1;Base)
            {
            }
            column(VAT_Entry_Amount_imprecargo;"VAT Entry".Amount-imprecargo)
            {
            }
            column(VAT_Bus_Posting_Group;"VAT Bus. Posting Group")
            {
            }
            column(VAT_Prod_Posting_Group;"VAT Prod. Posting Group")
            {
            }
            column(VAT_Registration_No;"VAT Registration No.")
            {
            }
            column(VAT;"VAT %")
            {
            }
            column(EC;"EC %")
            {
            }
            column(NOMBRECLIENTE;NOMBRECLIENTE)
            {
            }
            column(imprecargo;imprecargo)
            {
            }
            column(Document_Date;"Document Date")
            {
            }
            column(FechaOpe;FechaOpe)
            {
            }
            column(VAT_Entry_Base_Amount_imprecargo;"VAT Entry".Base+Amount-imprecargo)
            {
            }
            column(VATEntry_Amount;"VAT Entry".Amount)
            {
            }
            column(VAT_Entry_Base_Amount;"VAT Entry".Base+Amount)
            {
            }
            column(Base_2;Base)
            {
            }
            column(Amount_Base_Timprecargo;Amount+Base-Timprecargo)
            {
            }
            column(Label_1000000033;Lbl_Label_1000000033)
            {
            }
            column(Timprecargo;Timprecargo)
            {
            }
            column(Base_Amount;Base+Amount)
            {
            }
            column(Amount_Timprecargo;Amount-Timprecargo)
            {
            }
            column(VAT_Entry_No_Series_1;"VAT Entry"."No. Series")
            {
            }
            column(No_Series_1;"No. Series")
            {
            }
            column(Posting_Date_1;"Posting Date")
            {
            }
            column(Document_No_1;"Document No.")
            {
            }
            column(VAT_Bus_Posting_Group_1;"VAT Bus. Posting Group")
            {
            }
            column(VAT_Prod_Posting_Group_1;"VAT Prod. Posting Group")
            {
            }
            column(VAT_1;"VAT %")
            {
            }
            column(EC_1;"EC %")
            {
            }

            trigger OnAfterGetRecord()
            begin
                /// ,Compra,Venta,Liquidación
                if ("VAT Entry".Type=1) and ("VAT Entry"."Generated Autodocument"=false) then begin
                     CurrReport.Skip;
                end;
                if ("VAT Entry".Type=0) then begin
                     CurrReport.Skip;
                end;
                if ("VAT Entry".Type=3) then begin
                     CurrReport.Skip;
                end;
                
                if "VAT Entry"."No. Series"<>CODSERIE then begin
                     if CODSERIE <> '' then // TEC2 (16/11/10) (Modificar formato informe (saltos página,...)
                       CurrReport.Newpage;
                     CODSERIE:="VAT Entry"."No. Series";
                    // Timprecargo:=0;
                end;
                
                
                NOMBRECLIENTE:='';
                if "VAT Entry".Type=2 then begin
                     if RecClie.Get("VAT Entry"."Bill-to/Pay-to No.") then begin
                          NOMBRECLIENTE:=RecClie.Name;
                     end;
                end;
                if "VAT Entry".Type=1 then begin
                     if RecProv.Get("VAT Entry"."Bill-to/Pay-to No.") then begin
                          NOMBRECLIENTE:=RecProv.Name;
                     end;
                end;
                
                
                imprecargo:=0;
                /*
                IF "VAT Entry"."EC %"<>0 THEN BEGIN
                     imprecargo:=ROUND("VAT Entry".Base*"VAT Entry"."EC %"/100,0.01);
                    // Timprecargo:=Timprecargo+imprecargo;
                END;
                */
                Rec325.Reset;
                Rec325.SetRange(Rec325."VAT Bus. Posting Group","VAT Entry"."VAT Bus. Posting Group");
                Rec325.SetRange(Rec325."VAT Prod. Posting Group","VAT Entry"."VAT Prod. Posting Group");
                if Rec325.FindFirst then begin
                     Rec325.Base += "VAT Entry".Base;
                     Rec325.Importe += "VAT Entry".Amount;
                        if "VAT Entry"."EC %"<>0 then begin
                //         imprecargo:=ROUND(Rec325."EC %"*"VAT Entry"."EC %"/100,0.01);
                         imprecargo:=ROUND(Rec325.Base*"VAT Entry"."EC %"/100,0.01);
                       //  Timprecargo:=Timprecargo+imprecargo;
                        end;
                
                     Rec325.Modify;
                end;
                
                
                RecSer.Reset;
                RecSer.SetRange(RecSer.Code,"VAT Entry"."No. Series");
                if RecSer.FindFirst then begin
                     RecSer.Base:=RecSer.Base+"VAT Entry".Base;
                     RecSer.Importe:=RecSer.Importe+"VAT Entry".Amount;
                     RecSer.Modify;
                end;
                
                Rec254.Reset;
                Rec254.SetRange(Rec254."VAT Bus. Posting Group","VAT Entry"."VAT Bus. Posting Group");
                Rec254.SetRange(Rec254."VAT Prod. Posting Group","VAT Entry"."VAT Prod. Posting Group");
                Rec254.SetRange(Rec254."No. Series","VAT Entry"."No. Series");
                Rec254.SetRange(Rec254."VAT %","VAT Entry"."VAT %");
                Rec254.SetRange(Rec254."EC %","VAT Entry"."EC %");
                if Rec254.FindFirst then begin
                     Rec254.Base:=Rec254.Base+"VAT Entry".Base;
                     Rec254.Amount:=Rec254.Amount+"VAT Entry".Amount;
                     Rec254.Modify;
                end;
                if not Rec254.FindFirst then begin
                     Rec254.Init;
                     Rec254."VAT Bus. Posting Group":="VAT Entry"."VAT Bus. Posting Group";
                     Rec254."VAT Prod. Posting Group":="VAT Entry"."VAT Prod. Posting Group";
                     Rec254."No. Series":="VAT Entry"."No. Series";
                     Rec254."VAT %":="VAT Entry"."VAT %";
                     Rec254."EC %":="VAT Entry"."EC %";
                     CONTA:=CONTA+1;
                     Rec254."Entry No.":=CONTA;
                     Rec254.Base:="VAT Entry".Base;
                     Rec254.Amount:="VAT Entry".Amount;
                     Rec254.Insert;
                
                end;
                
                // TEC1 (16/11/10) (Obtener la fecha de operación)
                //CAC Falta campo, REVISAR - Necesario para campo FechaOpe
                FechaOpe := 0D;
                
                /*
                IF "Document Type" = "Document Type"::Invoice THEN
                  BEGIN
                  IF RecCabFac.GET("Document No.") THEN
                    /////FechaOpe := RecCabFac."Fecha Operacion (Mod.340)";
                  END
                ELSE
                  IF "Document Type" = "Document Type"::"Credit Memo" THEN
                    BEGIN
                    IF RecCabFacAbo.GET("Document No.") THEN
                      /////FechaOpe := RecCabFacAbo."Fecha Operacion (Mod.340)";
                    END;
                IF FechaOpe = 0D THEN
                  FechaOpe := "Posting Date";
                // TEC1 (16/11/10) (Obtener la fecha de operación)
                */
                //CAC REVISAR
                Rec325.Reset;
                Rec325.SetRange(Rec325."VAT Bus. Posting Group","VAT Entry"."VAT Bus. Posting Group");
                Rec325.SetRange(Rec325."VAT Prod. Posting Group","VAT Entry"."VAT Prod. Posting Group");
                if Rec325.FindFirst then begin
                     Rec325.Base := 0;
                     Rec325.Modify;
                end;
                //
                Timprecargo:=Timprecargo+imprecargo;

            end;

            trigger OnPreDataItem()
            begin


                FILTROFECHA:="VAT Entry".GetFilters;
                LastFieldNo := FieldNo("EC %");
                "VAT Entry".SetFilter("VAT Entry"."Document Type",'=%1|%2',"VAT Entry"."document type"::Invoice,"VAT Entry"."document type"::"Credit Memo");
                if "VAT Entry".FindSet then;
            end;
        }
        dataitem("No. Series";"No. Series")
        {
            DataItemTableView = sorting(Code);
            PrintOnlyIfDetail = false;
            column(ReportForNavId_72123; 72123)
            {
            }
            column("Code";Code)
            {
            }
            column(Base_3;Base)
            {
            }
            column(Importe_2;Importe)
            {
            }
            column(RESUMEN_SERIES;'RESUMEN SERIES')
            {
            }
            column(Lbl_Code;"No. Series".FieldCaption(Code))
            {
            }
            column(Lbl_Base;"No. Series".FieldCaption(Base))
            {
            }
            column(Lbl_Importe;"No. Series".FieldCaption(Importe))
            {
            }
            column(FORMAT_TODAY_0_4_1;Format(Today,0,4))
            {
            }
            column(CurrReport_PAGENO_1;'%PAGENO')
            {
            }
            column(Lbl_CurrReport_PAGENO_1;Lbl_CurrReport_PAGENO_1)
            {
            }
            column(USERID_1;UserId)
            {
            }
            column(Label_1000000085;Lbl_Label_1000000085)
            {
            }
            column(COMPANYNAME_1;COMPANYNAME)
            {
            }
            column(FILTROFECHA_1;FILTROFECHA)
            {
            }
            column(FORMAT_Importe;Format(Importe)+' = ')
            {
            }
            column(FORMAT_Base;Format(Base)+'  +  ' )
            {
            }
            column(Base_Importe;Base+Importe)
            {
            }

            trigger OnAfterGetRecord()
            begin

                if (Base=0) and (Importe=0) then begin
                     CurrReport.Skip;
                end;
            end;

            trigger OnPreDataItem()
            begin
                X:=0;
                Rec254.Reset;
                Rec254.SetCurrentkey(Rec254."VAT Bus. Posting Group",Rec254."VAT Prod. Posting Group");
                if Rec254.FindFirst then repeat
                     X:=X+1;
                     DATO1[X]:=Rec254."VAT Bus. Posting Group";
                     DATO2[X]:=Rec254."VAT Prod. Posting Group";
                     DATO3[X]:=Rec254."No. Series";
                     DATO4[X]:=Format(Rec254."VAT %");
                     DATO5[X]:=Format(Rec254."EC %");
                     IMPBASE[X]:=Rec254.Base;
                     IMPIMP[X]:=Rec254.Amount;
                until Rec254.Next=0;
            end;
        }
        dataitem("VAT Posting Setup";"VAT Posting Setup")
        {
            DataItemTableView = sorting("VAT Bus. Posting Group","VAT Prod. Posting Group");
            PrintOnlyIfDetail = false;
            column(ReportForNavId_72144; 72144)
            {
            }
            column(Importe_3;"VAT Posting Setup".Importe)
            {
            }
            column(Base_4;"VAT Posting Setup".Base)
            {
            }
            column(VAT_Prod_Posting_Group_2;"VAT Prod. Posting Group")
            {
            }
            column(VAT_Bus_Posting_Group_2;"VAT Bus. Posting Group")
            {
            }
            column(Label_1000000036;Lbl_Label_1000000036)
            {
            }
            column(Label_1000000038;Lbl_Label_1000000038)
            {
            }
            column(RESUMEN_I_V_A;'RESUMEN I.V.A.')
            {
            }
            column(Label_1000000040;Lbl_Label_1000000040)
            {
            }
            column(Label_1000000041;Lbl_Label_1000000041)
            {
            }
            column(Base_Importe_1;"VAT Posting Setup"."EC %" +   "VAT Posting Setup"."VAT %")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if ("VAT Posting Setup"."EC %" = 0) and ("VAT Posting Setup"."VAT %" = 0) then begin
                     CurrReport.Skip;
                end;
            end;
        }
        dataitem("Integer";"Integer")
        {
            DataItemTableView = sorting(Number);
            PrintOnlyIfDetail = false;
            column(ReportForNavId_72164; 72164)
            {
            }
            column(DATOC1;DATOC1)
            {
            }
            column(DATOC2;DATOC2)
            {
            }
            column(DATOC3;DATOC3)
            {
            }
            column(DATOC4;DATOC4)
            {
            }
            column(DATOC5;DATOC5)
            {
            }
            column(IMPBASEC;IMPBASEC)
            {
            }
            column(TIMPIMPC;TIMPIMPC)
            {
            }
            column(IMPIMP_Y;IMPIMP[Y])
            {
            }
            column(IMPBASE_Y;IMPBASE[Y])
            {
            }
            column(DATO2_Y;DATO2[Y])
            {
            }
            column(DATO1_Y;DATO1[Y])
            {
            }
            column(DATO3_Y;DATO3[Y])
            {
            }
            column(DATO4_Y;DATO4[Y])
            {
            }
            column(DATO5_Y;DATO5[Y])
            {
            }
            column(Label_1000000066;Lbl_Label_1000000066)
            {
            }
            column(Label_1000000068;Lbl_Label_1000000068)
            {
            }
            column(RESUMEN_I_V_A_SERIE;'RESUMEN I.V.A.-SERIE')
            {
            }
            column(Label_1000000070;Lbl_Label_1000000070)
            {
            }
            column(Label_1000000071;Lbl_Label_1000000071)
            {
            }
            column(Label_1000000072;Lbl_Label_1000000072)
            {
            }
            column(Label_1000000073;Lbl_Label_1000000073)
            {
            }
            column(Label_1000000074;Lbl_Label_1000000074)
            {
            }
            column(FORMAT_TIMPIMP;Format(TIMPIMP)+'  =  ')
            {
            }
            column(FORMAT_TIMPBASE;Format(TIMPBASE)+'  +  ')
            {
            }
            column(TIMPBASE_TIMPIMP;TIMPBASE+TIMPIMP)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Y:=Y+1;
                if Y>X then begin
                     CurrReport.Skip;
                end;

                //CAC Añadido
                DATOC1 := DATO1[Y];
                DATOC2 := DATO2[Y];
                DATOC3 := DATO3[Y];
                DATOC4 := DATO4[Y];
                DATOC5 := DATO5[Y];
                IMPBASEC := IMPBASE[Y];
                TIMPIMPC := IMPIMP[Y];
                //CAC FIN
                TIMPBASE:=TIMPBASE+IMPBASE[Y];
                TIMPIMP:=TIMPIMP+IMPIMP[Y];
            end;

            trigger OnPreDataItem()
            begin
                Integer.SetRange(Number,0,X);//CAC Añadido
                Integer.FindSet;
                Y:=0;
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

    trigger OnPreReport()
    begin


        if Rec325.FindFirst then repeat
             Rec325.Base := 0;
             Rec325.Importe := 0;
             Rec325.Modify;
        until Rec325.Next = 0;


        if RecSer.FindFirst then repeat
             RecSer.Base:=0;
             RecSer.Importe:=0;
             RecSer.Modify;
        until RecSer.Next = 0;
        CompanyInformation.Get;
        Empresa := CompanyInformation.Name;
    end;

    var
        Serie: Code[20];
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: label 'Total para ';
        NOMBRECLIENTE: Text[50];
        RecClie: Record Customer;
        CODSERIE: Code[20];
        imprecargo: Decimal;
        Timprecargo: Decimal;
        Rec325: Record "VAT Posting Setup";
        RecSer: Record "No. Series";
        RecProv: Record Vendor;
        Rec254: Record "VAT Entry" temporary;
        CONTA: Integer;
        DATO1: array [999] of Code[20];
        DATO2: array [999] of Code[20];
        DATO3: array [999] of Code[20];
        DATO4: array [999] of Code[20];
        DATO5: array [999] of Code[20];
        IMPBASE: array [999] of Decimal;
        IMPIMP: array [999] of Decimal;
        X: Integer;
        Y: Integer;
        TIMPBASE: Decimal;
        TIMPIMP: Decimal;
        FILTROFECHA: Text[250];
        RecCabFac: Record "Sales Invoice Header";
        RecCabFacAbo: Record "Sales Cr.Memo Header";
        FechaOpe: Date;
        Lbl_Label_1000000001: label 'IVA REPERCUTIDO';
        Lbl_CurrReport_PAGENO: label 'Pág.';
        Lbl_Label_1000000094: label 'Total';
        Lbl_Label_1000000096: label 'Total Fra.';
        Lbl_Label_1000000033: label 'TOTAL:';
        Lbl_CurrReport_PAGENO_1: label 'Pág.';
        Lbl_Label_1000000085: label 'IVA REPERCUTIDO';
        Lbl_Label_1000000036: label 'Importe';
        Lbl_Label_1000000038: label 'Base';
        Lbl_Label_1000000040: label 'Grupo IVA prod.';
        Lbl_Label_1000000041: label 'Grupo IVA neg.';
        Lbl_Label_1000000066: label 'Importe';
        Lbl_Label_1000000068: label 'Base';
        Lbl_Label_1000000070: label 'Nº serie';
        Lbl_Label_1000000071: label 'Grupo IVA neg.';
        Lbl_Label_1000000072: label 'Grupo IVA prod.';
        Lbl_Label_1000000073: label '% IVA';
        Lbl_Label_1000000074: label '% REC';
        DATOC1: Text;
        DATOC2: Text;
        DATOC3: Text;
        DATOC4: Code[10];
        DATOC5: Code[10];
        IMPBASEC: Decimal;
        TIMPIMPC: Decimal;
        Empresa: Text;
        CompanyInformation: Record "Company Information";
}

