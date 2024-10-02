#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50165 "LISTADO FACTURAS RECIBIDAS"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/LISTADO FACTURAS RECIBIDAS.rdlc';

    dataset
    {
        dataitem("VAT Entry";"VAT Entry")
        {
            DataItemTableView = sorting("No. Series","Posting Date","Document No.","VAT Bus. Posting Group","VAT Prod. Posting Group","VAT %","EC %");
            RequestFilterFields = "No. Series","Posting Date","Document No.","VAT Bus. Posting Group","VAT Prod. Posting Group","VAT %","EC %";
            column(ReportForNavId_72004; 72004)
            {
            }
            column(VATEntry_EntryNo;"VAT Entry"."Entry No.")
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
            column(N_documento;'Nº documento')
            {
            }
            column(Proveedor;'Proveedor')
            {
            }
            column(Nombre_proveedor;'Nombre proveedor')
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
            column(Importe;'Importe')
            {
            }
            column(Gr_IVA_neg;'Gr. IVA neg.')
            {
            }
            column(Gr_IVA_prod;'Gr. IVA prod.')
            {
            }
            column(Total_Fra;'Total Fra.')
            {
            }
            column(Fecha_fra;'Fecha fra.')
            {
            }
            column(F_opera;'F. opera.')
            {
            }
            column(Num;'Num.')
            {
            }
            column(FILTROFECHA;FILTROFECHA)
            {
            }
            column(Label_1000000011;Lbl_Label_1000000011)
            {
            }
            column(Label_1000000099;Lbl_Label_1000000099)
            {
            }
            column(Label_1000000103;Lbl_Label_1000000103)
            {
            }
            column(No_Series;"No. Series")
            {
            }
            column(No_Series_1;'No. Series')
            {
            }
            column(Posting_Date;"Posting Date")
            {
            }
            column(VAT_Entry_External_Document_No;"VAT Entry"."External Document No.")
            {
            }
            column(Bill_to_Pay_to_No;"Bill-to/Pay-to No.")
            {
            }
            column(Base_1;Base)
            {
            }
            column(VAT_Entry_Amount;"VAT Entry".Amount)
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
            column(NOMBRECLIENTE;NOMBRECLIENTE)
            {
            }
            column(VAT_Entry_Amount_Base_Irpf;"VAT Entry".Amount+Base+Irpf)
            {
            }
            column(Document_Date;"Document Date")
            {
            }
            column(fechaope;fechaope)
            {
            }
            column(VAT_Entry_Document_No;"VAT Entry"."Document No.")
            {
            }
            column(irpf2;irpf2)
            {
            }
            column(VAT_Entry_Amount_Base;"VAT Entry".Amount+Base)
            {
            }
            column(VAT_Entry_No_Series;"VAT Entry"."No. Series")
            {
            }
            column(Base_2;Base)
            {
            }
            column(Amount;Amount)
            {
            }
            column(Label_1000000033;Lbl_Label_1000000033)
            {
            }
            column(Base_VAT_Entry_Amount;Base+"VAT Entry".Amount)
            {
            }
            column(Base_VAT_Entry_Amount_Tirpf;Base+"VAT Entry".Amount+Tirpf)
            {
            }
            column(Tirpf;Tirpf)
            {
            }
            column(No_Series_2;"No. Series")
            {
            }
            column(Posting_Date_1;"Posting Date")
            {
            }
            column(Document_No;"Document No.")
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
            column(EC;"EC %")
            {
            }

            trigger OnAfterGetRecord()
            begin
                /// ,Compra,Venta,Liquidación
                if ("VAT Entry".Type=2) then begin
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
                     Timprecargo:=0;
                end;
                NOMBRECLIENTE:='';
                if "VAT Entry".Type=2 then begin
                     if RecClie.Get("VAT Entry"."Bill-to/Pay-to No.") then begin
                          NOMBRECLIENTE:=CopyStr(RecClie.Name,1,30);
                     end;
                end;
                if "VAT Entry".Type=1 then begin
                     if RecProv.Get("VAT Entry"."Bill-to/Pay-to No.") then begin
                          NOMBRECLIENTE:=CopyStr(RecProv.Name,1,30);
                     end;
                end;
                
                
                imprecargo:=0;
                /*
                IF "VAT Entry"."EC %"<>0 THEN BEGIN
                     imprecargo:=ROUND("VAT Entry".Base*"VAT Entry"."EC %"/100,0.01);
                     Timprecargo:=Timprecargo+imprecargo;
                END;
                */
                // CAC - Movido mas bajo para que tengo el Irpf presente
                // Rec325.RESET;
                // Rec325.SETRANGE(Rec325."VAT Bus. Posting Group","VAT Entry"."VAT Bus. Posting Group");
                // Rec325.SETRANGE(Rec325."VAT Prod. Posting Group","VAT Entry"."VAT Prod. Posting Group");
                // IF Rec325.FINDFIRST THEN BEGIN
                //     Rec325.Base:=Rec325.Base + "VAT Entry".Base;
                //     Rec325.Importe:=Rec325.Importe + "VAT Entry".Amount;
                //     Rec325.MODIFY;
                // END;
                // RecSer.RESET;
                // RecSer.SETRANGE(RecSer.Code,"VAT Entry"."No. Series");
                // IF RecSer.FINDFIRST THEN BEGIN
                //  RecSer.Base += "VAT Entry".Base + Irpf;
                //  RecSer.Importe += "VAT Entry".Amount + Irpf;
                //  RecSer.MODIFY;
                // END;
                
                // Rec254.RESET;
                // Rec254.SETRANGE(Rec254."VAT Bus. Posting Group","VAT Entry"."VAT Bus. Posting Group");
                // Rec254.SETRANGE(Rec254."VAT Prod. Posting Group","VAT Entry"."VAT Prod. Posting Group");
                // Rec254.SETRANGE(Rec254."No. Series","VAT Entry"."No. Series");
                // Rec254.SETRANGE(Rec254."VAT %","VAT Entry"."VAT %");
                // Rec254.SETRANGE(Rec254."EC %","VAT Entry"."EC %");
                // IF Rec254.FINDFIRST THEN BEGIN
                //  Rec254.Base:=Rec254.Base+"VAT Entry".Base;
                //  Rec254.Amount:=Rec254.Amount+"VAT Entry".Amount;
                //  Rec254.MODIFY;
                // END;
                // IF NOT Rec254.FINDFIRST THEN BEGIN
                //  Rec254.INIT;
                //  Rec254."VAT Bus. Posting Group":="VAT Entry"."VAT Bus. Posting Group";
                //  Rec254."VAT Prod. Posting Group":="VAT Entry"."VAT Prod. Posting Group";
                //  Rec254."No. Series":="VAT Entry"."No. Series";
                //  Rec254."VAT %":="VAT Entry"."VAT %";
                //  Rec254."EC %":="VAT Entry"."EC %";
                //  CONTA += 1;
                //  Rec254."Entry No.":=CONTA;
                //  Rec254.Base:="VAT Entry".Base;
                //  Rec254.Amount:="VAT Entry".Amount;
                //  Rec254.INSERT;
                // END;
                // ----- FIN CAC
                if not docirpf.Get("VAT Entry"."Document No.") then begin
                
                  Irpf:=0;
                  irpf2:=0;
                  GLAccount.Reset;
                  GLAccount.SetRange("Linea Retencion IRPF",true);
                  if GLAccount.FindFirst then begin
                    Rec17.Reset;
                    Rec17.SetCurrentkey(Rec17."Transaction No.");
                    Rec17.SetRange(Rec17."Transaction No.","VAT Entry"."Transaction No.");
                    Rec17.SetRange(Rec17."Document No.","VAT Entry"."Document No.");
                    Rec17.SetFilter(Rec17."G/L Account No.",GLAccount."No.");
                    //Rec17.SETFILTER(Rec17."G/L Account No.",'4751000001');
                    if Rec17.FindFirst then begin
                      Irpf:=Rec17.Amount;
                      irpf2:=Rec17.Amount;
                    end;
                  end;
                  docirpf.Init;
                  docirpf."No.":="VAT Entry"."Document No.";
                  docirpf.Insert;
                end;
                
                //CAC Presection
                
                // TEC1 (16/11/10) (Obtener la fecha de operación)
                fechaope := 0D;
                if "Document Type" = "document type"::Invoice then
                  begin
                  if RecCabFac.Get("Document No.") then
                    fechaope := RecCabFac."Document Date"; ///// "Fecha Operacion (Mod.340)";
                  end
                else
                  if "Document Type" = "document type"::"Credit Memo" then
                    begin
                    if RecCabFacAbo.Get("Document No.") then
                      fechaope := RecCabFacAbo."Document Date"; ///// "Fecha Operacion (Mod.340)";
                    end;
                
                if fechaope = 0D then
                  fechaope := "Posting Date";
                // TEC1 (16/11/10) (Obtener la fecha de operación)
                
                Irpf:=0;
                irpf2:=0;
                Rec17.Reset;
                Rec17.SetCurrentkey(Rec17."Transaction No.");
                Rec17.SetRange(Rec17."Transaction No.","VAT Entry"."Transaction No.");
                Rec17.SetRange(Rec17."Document No.","VAT Entry"."Document No.");
                Rec17.SetFilter(Rec17."G/L Account No.",'4751000001');
                if Rec17.FindFirst then begin
                  Irpf:=Rec17.Amount;
                  irpf2:=Rec17.Amount;
                end;
                //movido
                Rec254.Reset;
                Rec254.SetRange(Rec254."VAT Bus. Posting Group","VAT Entry"."VAT Bus. Posting Group");
                Rec254.SetRange(Rec254."VAT Prod. Posting Group","VAT Entry"."VAT Prod. Posting Group");
                Rec254.SetRange(Rec254."No. Series","VAT Entry"."No. Series");
                Rec254.SetRange(Rec254."VAT %","VAT Entry"."VAT %");
                Rec254.SetRange(Rec254."EC %","VAT Entry"."EC %");
                if Rec254.FindFirst then begin
                  Rec254.Base += "VAT Entry".Base; //+ Irpf; //CAC Se le suma el IRPF tal y como me ha indicado Oscar
                  Rec254.Amount += "VAT Entry".Amount;
                  Rec254.Modify;
                end;
                if not Rec254.FindFirst then begin
                  Rec254.Init;
                  Rec254."VAT Bus. Posting Group":="VAT Entry"."VAT Bus. Posting Group";
                  Rec254."VAT Prod. Posting Group":="VAT Entry"."VAT Prod. Posting Group";
                  Rec254."No. Series":="VAT Entry"."No. Series";
                  Rec254."VAT %":="VAT Entry"."VAT %";
                  Rec254."EC %":="VAT Entry"."EC %";
                  CONTA += 1;
                  Rec254."Entry No.":=CONTA;
                  Rec254.Base:="VAT Entry".Base; //+ Irpf; //CAC Se le suma el IRPF tal y como me ha indicado Oscar
                  Rec254.Amount:="VAT Entry".Amount;
                  Rec254.Insert;
                end;
                Rec325.Reset;
                Rec325.SetRange(Rec325."VAT Bus. Posting Group","VAT Entry"."VAT Bus. Posting Group");
                Rec325.SetRange(Rec325."VAT Prod. Posting Group","VAT Entry"."VAT Prod. Posting Group");
                if Rec325.FindFirst then begin
                     Rec325.Base += "VAT Entry".Base; //+ Irpf; //CAC Se le suma el IRPF tal y como me ha indicado Oscar
                     Rec325.Importe += "VAT Entry".Amount;
                     Rec325.Modify;
                end;
                RecSer.Reset;
                RecSer.SetRange(RecSer.Code,"VAT Entry"."No. Series");
                if RecSer.FindFirst then begin
                  RecSer.Base += "VAT Entry".Base;// + Irpf; //CAC Se le suma el IRPF tal y como me ha indicado Oscar
                  RecSer.Importe += "VAT Entry".Amount;
                  RecSer.Modify;
                end;
                
                
                ///IF (Irpf<>0) AND ( "VAT %"=0 ) AND ("Sales Tax Connection No."=2) THEN BEGIN
                if (Irpf<>0) and ( "VAT %"=0 ) then begin
                  irpf2:=0;
                  Irpf:=0;
                end;
                
                if CurrReport.SHOWOUTPUT then begin
                  Tirpf:=Tirpf+irpf2;
                end;
                
                //CAC FIN

            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("EC %");
                Tirpf:=0;
            end;
        }
        dataitem("Purch. Inv. Header";"Purch. Inv. Header")
        {
            DataItemTableView = sorting("Posting Date") where("Fecha DUA"=filter(<>""));
            PrintOnlyIfDetail = false;
            column(ReportForNavId_72149; 72149)
            {
            }
            column(Purch_Inv_Header_Fecha_DUA;"Purch. Inv. Header"."Importe Pdte. pedido")
            {
            }
            column(Purch_Inv_Header_DUA;"Purch. Inv. Header"."Importe factura")
            {
            }
            column(Purch_Inv_Header_Pay_to_Name;"Purch. Inv. Header"."Pay-to Name")
            {
            }
            column(Purch_Inv_Header_Vendor_Invoice_No;"Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(Label_1000000144;Lbl_Label_1000000144)
            {
            }
            column(Label_1000000145;Lbl_Label_1000000145)
            {
            }
            column(N_factura;'Nº factura')
            {
            }
            column(Nombre_proveedor_1;'Nombre proveedor')
            {
            }
            dataitem("Purch. Inv. Line";"Purch. Inv. Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.","Line No.");
                PrintOnlyIfDetail = false;
                column(ReportForNavId_72121; 72121)
                {
                }
                column(PURCHLINE;PURCHLINE)
                {
                }
                column(IVA_importaci_n;Referencia)
                {
                }
                column(Proveedor_Importaci_n;"Cantidad a pasar")
                {
                }
                column(Base_IVA_Aduanas;"Pedido compra")
                {
                }
                column(NOMBREPROV;NOMBREPROV)
                {
                }
                column(NDUA;NDUA)
                {
                }
                column(FECHADUA;FECHADUA)
                {
                }
                column(VATEntry8_Amount;decCuota)
                {
                }
                column(Label_1000000083;Lbl_Label_1000000083)
                {
                }
                column(Label_1000000085;Lbl_Label_1000000085)
                {
                }
                column(Label_1000000086;Lbl_Label_1000000086)
                {
                }
                column(Label_1000000087;Lbl_Label_1000000087)
                {
                }
                column(Label_1000000107;Lbl_Label_1000000107)
                {
                }
                column(Label_1000000108;Lbl_Label_1000000108)
                {
                }
                column(Label_1000000109;Lbl_Label_1000000109)
                {
                }
                column(Base_IVA_Aduanas_1;"Pedido compra")
                {
                }
                column(TCUOTA;TCUOTA)
                {
                }
                column(VATEntrry8_DocumentNo;"Document No.")
                {
                }
                column(PurchInvLine_Amount;Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PURCHLINE := 'PURCHLINE';
                    
                    Ocultar := false;
                    PurchInvHeader.Reset;
                    PurchInvHeader.SetRange("No.","Document No.");
                    if PurchInvHeader.FindFirst then begin
                         if PurchInvHeader.DUA='' then begin
                              Ocultar := true;
                              CurrReport.Skip;
                         end;
                    end;
                    /////IF (VATEntry8."Base IVA Aduanas"=0) AND (VATEntry8."Proveedor Importación"='') THEN BEGIN
                    /////     Ocultar := TRUE;
                    /////     CurrReport.SKIP;
                    /////END;
                    ///// CUOTA:=ROUND(VATEntry8."% IVA importación"*VATEntry8."Base IVA Aduanas"/100,0.01);
                    
                    /*
                    PurchInvLine.RESET;
                    PurchInvLine.SETRANGE("Document No.","Document No.");
                    PurchInvLine.SETFILTER("Pedido compra",'<>0');
                    IF PurchInvLine.FINDFIRST THEN BEGIN
                         CUOTA:=ROUND(PurchInvHeader.BL*PurchInvLine."Pedido compra"/100,0.01);
                    END;
                    
                    //GPC 130918 D4B
                    IF "Purch. Inv. Line"."Pedido compra" > 0 THEN BEGIN
                      decCuota += "Amount Including VAT";
                      TCUOTA := TCUOTA + decCuota;
                    END;
                    */
                    //FIN GPC
                    
                    NOMBREPROV:='';
                    NDUA:='';
                    FECHADUA:=0D;
                    if RecProv.Get("Purch. Inv. Line"."Buy-from Vendor No.") then begin
                         NOMBREPROV:=RecProv.Name;
                         if RECHFC.Get("Document No.") then begin
                    /////          NDUA:=RECHFC."Importe factura";
                              /////FECHADUA:=RECHFC."Importe Pdte. pedido";
                         end;
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    decCuota := 0;
                    
                    //VATEntry8.SETRANGE(VATEntry8."Posting Date",desde,hasta); GPC 130918 D4B
                    
                    /*
                    IF GETFILTER("Posting Date") = '' THEN
                      Prevdata := 0D
                    ELSE
                      Prevdata := GETRANGEMIN("Posting Date");
                    i := 1;
                    IF SortPostDate THEN
                      VATEntry8.SETCURRENTKEY(Type,"Posting Date","Document Type","Document No.","Bill-to/Pay-to No.")
                    ELSE
                      SETCURRENTKEY("No. Series","Posting Date","Document No.");
                    */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                
                /*
                SALTA:=FALSE;
                Rec2542.RESET;
                Rec2542.SETRANGE(Rec2542."Document No.","Purch. Inv. Header"."No.");
                IF Rec2542.FINDFIRST THEN REPEAT
                     IF Rec2542."Proveedor Importación"<>'' THEN BEGIN
                          SALTA:=TRUE;
                     END;
                UNTIL Rec2542.NEXT=0;
                
                IF SALTA THEN BEGIN
                     CurrReport.SKIP;
                END;
                */

            end;

            trigger OnPreDataItem()
            begin


                "Purch. Inv. Header".SetRange("Purch. Inv. Header"."Posting Date",desde,hasta);
            end;
        }
        dataitem("No. Series";"No. Series")
        {
            DataItemTableView = sorting(Code);
            PrintOnlyIfDetail = false;
            column(ReportForNavId_72161; 72161)
            {
            }
            column("Code";Code)
            {
            }
            column(Base_3;Base)
            {
            }
            column(Importe_1;Importe)
            {
            }
            column(RESUMEN_SERIES;'RESUMEN SERIES')
            {
            }
            column(Lbl_Importe;"No. Series".FieldCaption(Importe))
            {
            }
            column(Lbl_Base;"No. Series".FieldCaption(Base))
            {
            }
            column(FORMAT_TODAY_0_4_1;Format(Today,0,4))
            {
            }
            column(USERID_1;UserId)
            {
            }
            column(CurrReport_PAGENO_1;'%PAGENO')
            {
            }
            column(Lbl_CurrReport_PAGENO_1;Lbl_CurrReport_PAGENO_1)
            {
            }
            column(Label_1000000119;Lbl_Label_1000000119)
            {
            }
            column(COMPANYNAME_1;COMPANYNAME)
            {
            }
            column(FILTROFECHA_1;FILTROFECHA)
            {
            }
            column(Lbl_Code;"No. Series".FieldCaption(Code))
            {
            }
            column(Importe_2;Importe)
            {
            }
            column(Base_4;Base)
            {
            }
            column(FORMAT_Base_Importe;' = ' +Format( Base + Importe))
            {
            }
            column(TextBox_1000000034;'+')
            {
            }

            trigger OnAfterGetRecord()
            begin

                if (Base=0) and (Importe=0) then begin
                     CurrReport.Skip;
                     VarImpCab := false;
                end
                // TEC2 (16/11/10) (Modificar formato informe (saltos página,...)
                else
                  if VarPrimReg then
                    begin
                    VarImpCab := true;
                    CurrReport.Newpage;
                    VarPrimReg := false;
                    end;
                // TEC2 (16/11/10) (Modificar formato informe (saltos página,...);
            end;

            trigger OnPreDataItem()
            begin
                // TEC2 (16/11/10) (Modificar formato informe (saltos página,...)
                //CurrReport.NEWPAGE;
                VarPrimReg := true;
                // TEC2 (16/11/10) (Modificar formato informe (saltos página,...)

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


                XX:=X;
            end;
        }
        dataitem("VAT Posting Setup";"VAT Posting Setup")
        {
            DataItemTableView = sorting("VAT Bus. Posting Group","VAT Prod. Posting Group");
            PrintOnlyIfDetail = false;
            column(ReportForNavId_72186; 72186)
            {
            }
            column(VATPostingGroup_Base;"VAT Posting Setup".Base)
            {
            }
            column(VATPostingGroup_Importe;"VAT Posting Setup".Importe)
            {
            }
            column(Importe_3;Importe)
            {
            }
            column(Base_5;Base)
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
            column(Label_1000000040;Lbl_Label_1000000040)
            {
            }
            column(Label_1000000041;Lbl_Label_1000000041)
            {
            }
            column(RESUMEN_I_V_A;'RESUMEN I.V.A.')
            {
            }
            column(Importe_4;Importe)
            {
            }
            column(Base_6;Base)
            {
            }
            column(TextBox_1000000123;'+')
            {
            }
            column(FORMAT_Base_Importe_1;' = ' +Format( Base + Importe))
            {
            }
            column(Base_7;Base)
            {
            }
            column(Importe_5;Importe)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if ("VAT Posting Setup".Base=0) and ("VAT Posting Setup".Importe=0) then begin
                  CurrReport.Skip;
                end;
                /*
                Base := "VAT Posting Setup".Base;
                Importe := "VAT Posting Setup".Importe;
                */

            end;
        }
        dataitem("Integer";"Integer")
        {
            DataItemTableView = sorting(Number);
            PrintOnlyIfDetail = false;
            column(ReportForNavId_72207; 72207)
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
            column(USERID_2;UserId)
            {
            }
            column(FORMAT_TODAY_0_4_2;Format(Today,0,4))
            {
            }
            column(Label_1000000126;Lbl_Label_1000000126)
            {
            }
            column(CurrReport_PAGENO_2;'%PAGENO')
            {
            }
            column(TIMPIMP;TIMPIMP)
            {
            }
            column(TIMPBASE;TIMPBASE)
            {
            }
            column(TextBox_1000000125;'+')
            {
            }
            column(FORMAT_TIMPBASE_TIMPIMP;' = '+Format(TIMPBASE + TIMPIMP))
            {
            }

            trigger OnAfterGetRecord()
            begin

                Y:=Y+1;
                if Y>XX then begin
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
                TIMPBASE += IMPBASE[Y];
                TIMPIMP += IMPIMP[Y];
            end;

            trigger OnPreDataItem()
            begin
                Integer.SetRange(Number,0,XX);//CAC Añadido
                Y:=0;
            end;
        }
        dataitem("G/L Entry";"G/L Entry")
        {
            DataItemTableView = sorting("G/L Account No.","Posting Date") where("G/L Account No."=const('4751000001'),"Document Type"=filter(Invoice|"Credit Memo"));
            PrintOnlyIfDetail = false;
            column(ReportForNavId_72240; 72240)
            {
            }
            column(Posting_Date_2;"Posting Date")
            {
            }
            column(Document_Type;"Document Type")
            {
            }
            column(Document_No_1;"Document No.")
            {
            }
            column(NOMBREPROVEE;NOMBREPROVEE)
            {
            }
            column(Amount_1;Amount)
            {
            }
            column(Lbl__Posting_Date;"G/L Entry".FieldCaption("Posting Date"))
            {
            }
            column(Lbl__Document_Type;"G/L Entry".FieldCaption("Document Type"))
            {
            }
            column(Lbl__Document_No;"G/L Entry".FieldCaption("Document No."))
            {
            }
            column(Lbl_NOMBREPROVEE;Lbl_NOMBREPROVEE)
            {
            }
            column(Lbl_Amount;"G/L Entry".FieldCaption(Amount))
            {
            }
            column(DETALLE_I_R_P_F;'DETALLE I.R.P.F.')
            {
            }
            column(Amount_2;Amount)
            {
            }
            column(Total_IRPF;'Total IRPF:')
            {
            }

            trigger OnAfterGetRecord()
            begin
                NOMBREPROVEE:='';
                if RecPRove.Get("G/L Entry"."Source No.") then begin
                     NOMBREPROVEE:=RecPRove.Name;
                end;
            end;

            trigger OnPreDataItem()
            begin
                "G/L Entry".SetRange("G/L Entry"."Posting Date",desde,hasta);
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

        FILTROFECHA:="VAT Entry".GetFilters;
        if Rec325.FindFirst then repeat
             Rec325.Base:=0;
             Rec325.Importe:=0;
             Rec325.Modify;
        until Rec325.Next = 0;

        if RecSer.FindFirst then repeat
             RecSer.Base:=0;
             RecSer.Importe:=0;
             RecSer.Modify;
        until RecSer.Next = 0;

        desde:="VAT Entry".GetRangeMin("VAT Entry"."Posting Date");
        hasta:="VAT Entry".GetRangemax("VAT Entry"."Posting Date");

        CompanyInformation.Get;
        Empresa := CompanyInformation.Name;
    end;

    var
        irpf2: Decimal;
        Tirpf: Decimal;
        Irpf: Decimal;
        Rec17: Record "G/L Entry";
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
        CUOTA: Decimal;
        TCUOTA: Decimal;
        decCuota: Decimal;
        Prevdata: Date;
        i: Integer;
        SortPostDate: Boolean;
        fechaope: Date;
        NOMBREPROV: Text[50];
        RECHFC: Record "Purch. Inv. Header";
        NDUA: Code[30];
        FECHADUA: Date;
        desde: Date;
        hasta: Date;
        FILTROFECHA: Text[250];
        Rec122: Record "Purch. Inv. Header";
        Rec123: Record "Purch. Inv. Line";
        Rec124: Record "Purch. Cr. Memo Hdr.";
        Rec125: Record "Purch. Cr. Memo Line";
        Rec120: Record "Purch. Rcpt. Header";
        Rec121: Record "Purch. Rcpt. Line";
        VarPrimReg: Boolean;
        VarImpCab: Boolean;
        RecCabFac: Record "Purch. Inv. Header";
        RecCabFacAbo: Record "Purch. Cr. Memo Hdr.";
        solodetalle: Boolean;
        XX: Integer;
        CONTA1: Integer;
        docirpf: Record Customer temporary;
        PRIMERA: Boolean;
        CODDOCUMENT: Code[20];
        DESDEF: Date;
        HASTAF: Date;
        NOMBREPROVEE: Text[60];
        RecPRove: Record Vendor;
        Rec2542: Record "VAT Entry";
        SALTA: Boolean;
        Lbl_Label_1000000001: label 'IVA SOPORTADO';
        Lbl_CurrReport_PAGENO: label 'Pág.';
        Lbl_Label_1000000011: label 'Fecha registro';
        Lbl_Label_1000000099: label 'IRPF';
        Lbl_Label_1000000103: label 'Total';
        Lbl_Label_1000000033: label 'TOTAL:';
        Lbl_Label_1000000083: label '% IVA importación';
        Lbl_Label_1000000085: label 'Proveedor Importación';
        Lbl_Label_1000000086: label 'Base IVA Aduanas';
        Lbl_Label_1000000087: label 'Cuota';
        Lbl_Label_1000000107: label 'Nombre proveedor';
        Lbl_Label_1000000108: label 'DUA';
        Lbl_Label_1000000109: label 'Fecha DUA';
        Lbl_Label_1000000144: label 'Fecha DUA';
        Lbl_Label_1000000145: label 'DUA';
        Lbl_CurrReport_PAGENO_1: label 'Pág.';
        Lbl_Label_1000000119: label 'IVA SOPORTADO';
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
        Lbl_Label_1000000126: label 'Pág.';
        Lbl_NOMBREPROVEE: label 'Nombre proveedor';
        RecVatPostGrup: Record "VAT Posting Setup" temporary;
        Base: Decimal;
        Importe: Decimal;
        DATOC1: Text;
        DATOC2: Text;
        DATOC3: Text;
        DATOC4: Code[10];
        DATOC5: Code[10];
        IMPBASEC: Decimal;
        TIMPIMPC: Decimal;
        Ocultar: Boolean;
        Empresa: Text;
        NombreClienteSub: Text;
        CompanyInformation: Record "Company Information";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        GLAccount: Record "G/L Account";
        PURCHLINE: Text;


    procedure GetShipmentDate(DocumentNo: Code[20]): Date
    var
        PurchInvLine: Record "Purch. Inv. Line";
        ValueEntry: Record "Value Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        PurchInvLine.Reset;
        PurchInvLine.SetRange("Document No.",DocumentNo);
        if PurchInvLine.FindFirst then
          repeat
            ValueEntry.Reset;
            ValueEntry.SetCurrentkey("Document No.");
            ValueEntry.SetRange("Document No.",PurchInvLine."Document No.");
            ValueEntry.SetRange("Document Type",ValueEntry."document type"::"Purchase Invoice");
            ValueEntry.SetRange("Document Line No.",PurchInvLine."Line No.");
            ValueEntry.SetFilter("Invoiced Quantity",'<>0');
            if ValueEntry.FindFirst then
              repeat
              // TEC (Apaño temporal. Existen Movs. Valor sin Movs. Producto)
              //ItemLedgEntry.GET(ValueEntry."Item Ledger Entry No.");
              if ItemLedgEntry.Get(ValueEntry."Item Ledger Entry No.") then
                if ItemLedgEntry."Document Type" = ItemLedgEntry."document type"::"Purchase Receipt" then
                  if PurchRcptLine.Get(ItemLedgEntry."Document No.",ItemLedgEntry."Document Line No.") then begin
                    if PurchRcptHeader.Get(PurchRcptLine."Document No.") then begin
                      if PurchRcptHeader."Order No." <> '' then begin
                        PurchRcptHeader.SetCurrentkey("Posting Date");
                        PurchRcptHeader.SetRange("Order No.", PurchRcptHeader."Order No.");
                          if PurchRcptHeader.FindFirst then
                            // TEC4 (20/10/10)
                            //EXIT(PurchRcptHeader."Posting Date");
                            exit(PurchRcptHeader."Document Date");
                            // TEC4 (20/10/10)
                      end else
                        exit(PurchRcptHeader."Posting Date");
                        // TEC4 (20/10/10)
                        //EXIT(PurchRcptHeader."Posting Date");
                        exit(PurchRcptHeader."Document Date");
                        // TEC4 (20/10/10);
                    end;
                  end;
              until ValueEntry.Next = 0;
          until PurchInvLine.Next = 0;
    end;
}

