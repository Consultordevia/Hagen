#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50164 "diariocontabilidad"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/diariocontabilidad.rdlc';

    dataset
    {
        dataitem("GLEntry"; "G/L Entry")
        {

            RequestFilterFields = "No. Series", "Posting Date", "Document No.", "VAT Bus. Posting Group", "VAT Prod. Posting Group";
            column(ReportForNavId_72004; 72004)
            {
            }
            column(GLEntryDescription; GLEntry.Description) { }
            column(GLEntryDocumentNo; GLEntry."Document No.") { }
            column(GLEntryGLAccountNo; GLEntry."G/L Account No.") { }
            column(GLEntryPostingDate; GLEntry."Posting Date") { }
            column(GLEntryDocumentType; GLEntry."Document Type") { }
            column(GLEntryAmount; GLEntry.Amount) { }
            column(GLEntryDebitAmount; GLEntry."Debit Amount") { }
            column(GLEntryCreditAmount; GLEntry."Credit Amount") { }
            column(GLEntryTransactionNo; GLEntry."Transaction No.") { }
            column(GLEntrySourceType; GLEntry."Source Type") { }
            column(GLEntrySourceNo; GLEntry."Source No.") { }
            column(NombreCuenta; NombreCuenta) { }
            column(Label_1000000001; Lbl_Label_1000000001)
            {
            }
            column(FORMAT_TODAY_0_4; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; Empresa)
            {
            }
            column(CurrReport_PAGENO; '%PAGENO')
            {
            }
            column(Lbl_CurrReport_PAGENO; Lbl_CurrReport_PAGENO)
            {
            }
            column(USERID; UserId)
            {
            }
            column(N_documento; 'Nº documento')
            {
            }
            column(Proveedor; 'Proveedor')
            {
            }
            column(Nombre_proveedor; 'Nombre proveedor')
            {
            }
            column(CIF_NIF; 'CIF/NIF')
            {
            }
            column(Base; 'Base')
            {
            }
            column(IVA; '% IVA')
            {
            }
            column(Importe; 'Importe')
            {
            }
            column(Gr_IVA_neg; 'Gr. IVA neg.')
            {
            }
            column(Gr_IVA_prod; 'Gr. IVA prod.')
            {
            }
            column(Total_Fra; 'Total Fra.')
            {
            }
            column(Fecha_fra; 'Fecha fra.')
            {
            }
            column(F_opera; 'F. opera.')
            {
            }
            column(Num; 'Num.')
            {
            }
            column(FILTROFECHA; FILTROFECHA)
            {
            }
            column(Label_1000000011; Lbl_Label_1000000011)
            {
            }
            column(Label_1000000099; Lbl_Label_1000000099)
            {
            }
            column(Label_1000000103; Lbl_Label_1000000103)
            {
            }
            column(No_Series; "No. Series")
            {
            }
            column(No_Series_1; 'No. Series')
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Base_1; Base)
            {
            }
            trigger OnAfterGetRecord()
            begin

                NombreCuenta := '';
                if RecPRove.Get(GLEntry."Source No.") then begin
                    NombreCuenta := RecPRove.Name;
                end;
                if RecClie.Get(GLEntry."Source No.") then begin
                    NombreCuenta := RecClie.Name;
                end;
                if RecBank.Get(GLEntry."Source No.") then begin
                    NombreCuenta := RecBank.Name;
                end;


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
        RecBank: Record "Bank Account";
        CODSERIE: Code[20];
        imprecargo: Decimal;
        Timprecargo: Decimal;
        Rec325: Record "VAT Posting Setup";
        RecSer: Record "No. Series";
        RecProv: Record Vendor;
        Rec254: Record "VAT Entry" temporary;
        CONTA: Integer;
        DATO1: array[999] of Code[20];
        DATO2: array[999] of Code[20];
        DATO3: array[999] of Code[20];
        DATO4: array[999] of Code[20];
        DATO5: array[999] of Code[20];
        IMPBASE: array[999] of Decimal;
        IMPIMP: array[999] of Decimal;
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
        NombreCuenta: Text;

    /*
               trigger OnAfterGetRecord()
                begin
                    NombreCuenta := '';
                    if RecPRove.Get("G/L Entry"."Source No.") then begin
                        NombreCuenta := RecPRove.Name;
                    end;  
                    if RecClie.Get("G/L Entry"."Source No.") then begin
                        NombreCuenta := RecClie.Name;
                    end;
                    if RecBank.Get("G/L Entry"."Source No.") then begin
                        NombreCuenta := RecBank.Name;
                    end;


                end;

    */

}

