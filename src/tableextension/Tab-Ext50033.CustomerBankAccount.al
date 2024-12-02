tableextension 50033 CustomerBankAccount extends "Customer Bank Account"
{
    fields
    {
        modify("CCC Bank No.")
        {
            trigger OnBeforeValidate()
            var
                RecMT: Record Multitabla;
            begin
                RecMT.Reset;
                RecMT.SetRange(RecMT.Tabla, 32);
                RecMT.SetRange(RecMT.Codigo, "CCC Bank No.");
                if RecMT.FindFirst then begin
                    "SWIFT Code" := RecMT.Descripcion;
                end;
            end;
        }
        modify("CCC Control Digits")
        {
            trigger OnAfterValidate()
            begin
                CalculaDC;
            end;
        }
        modify("CCC Bank Account No.")
        {
            trigger OnAfterValidate()
            begin
                CalculaDC;
            end;
        }
        modify("CCC No.")
        {
            trigger OnAfterValidate()
            begin
                CalculaDC;
            end;
        }
        field(50000; BIC; Code[12])
        {
        }
        field(50001; "COAP PAIS"; Code[10])
        {
            CalcFormula = lookup(Customer."Country/Region Code" where("No." = field("Customer No.")));
            FieldClass = FlowField;
        }
    }

    trigger OnBeforeInsert()
    var
        Customer: Record Customer;
    begin
        if Customer.Get("Customer No.") then begin
            "Country/Region Code" := Customer."Country/Region Code";
        end;
    end;

    trigger OnBeforeModify()
    var
        Customer: Record Customer;
    begin
        if Customer.Get("Customer No.") then begin
            Customer."Preferred Bank Account Code" := Code;
            Customer.Modify;
        end;
    end;

    procedure CalculaDC()
    var
        RecPais: Record "Country/Region";
        DIGITOS1: array[10] of Code[1];
        SUMA1: Decimal;
        DIGITOS2: array[10] of Decimal;
        SUMA2: Decimal;
        DIV1: Decimal;
        DIV2: Decimal;
        RESTO1: Decimal;
        RESTO2: Decimal;
        DC: Code[2];
        RecA: Record "Customer Bank Account";
        DCIBAN: Code[10];
        RecIE: Record "Company Information";
        Customer: Record customer;
    begin

        calculabic;


        if "CCC Bank Account No." <> '' then begin

            if Customer.Get("Customer No.") then begin
                RecPais.Get(Customer."Country/Region Code");
                if RecPais."Controla DC" then begin

                    DIGITOS1[1] := CopyStr("CCC Bank Branch No.", 4, 1);
                    DIGITOS1[2] := CopyStr("CCC Bank Branch No.", 3, 1);
                    DIGITOS1[3] := CopyStr("CCC Bank Branch No.", 2, 1);
                    DIGITOS1[4] := CopyStr("CCC Bank Branch No.", 1, 1);
                    DIGITOS1[5] := CopyStr("CCC Bank No.", 4, 1);
                    DIGITOS1[6] := CopyStr("CCC Bank No.", 3, 1);
                    DIGITOS1[7] := CopyStr("CCC Bank No.", 2, 1);
                    DIGITOS1[8] := CopyStr("CCC Bank No.", 1, 1);

                    Evaluate(DIGITOS2[1], DIGITOS1[1]);
                    Evaluate(DIGITOS2[2], DIGITOS1[2]);
                    Evaluate(DIGITOS2[3], DIGITOS1[3]);
                    Evaluate(DIGITOS2[4], DIGITOS1[4]);
                    Evaluate(DIGITOS2[5], DIGITOS1[5]);
                    Evaluate(DIGITOS2[6], DIGITOS1[6]);
                    Evaluate(DIGITOS2[7], DIGITOS1[7]);
                    Evaluate(DIGITOS2[8], DIGITOS1[8]);

                    SUMA1 := DIGITOS2[1] * 6 +
                           DIGITOS2[2] * 3 +
                           DIGITOS2[3] * 7 +
                           DIGITOS2[4] * 9 +
                           DIGITOS2[5] * 10 +
                           DIGITOS2[6] * 5 +
                           DIGITOS2[7] * 8 +
                           DIGITOS2[8] * 4;

                    DIGITOS1[1] := CopyStr("CCC Bank Account No.", 10, 1);
                    DIGITOS1[2] := CopyStr("CCC Bank Account No.", 9, 1);
                    DIGITOS1[3] := CopyStr("CCC Bank Account No.", 8, 1);
                    DIGITOS1[4] := CopyStr("CCC Bank Account No.", 7, 1);
                    DIGITOS1[5] := CopyStr("CCC Bank Account No.", 6, 1);
                    DIGITOS1[6] := CopyStr("CCC Bank Account No.", 5, 1);
                    DIGITOS1[7] := CopyStr("CCC Bank Account No.", 4, 1);
                    DIGITOS1[8] := CopyStr("CCC Bank Account No.", 3, 1);
                    DIGITOS1[9] := CopyStr("CCC Bank Account No.", 2, 1);
                    DIGITOS1[10] := CopyStr("CCC Bank Account No.", 1, 1);

                    Evaluate(DIGITOS2[1], DIGITOS1[1]);
                    Evaluate(DIGITOS2[2], DIGITOS1[2]);
                    Evaluate(DIGITOS2[3], DIGITOS1[3]);
                    Evaluate(DIGITOS2[4], DIGITOS1[4]);
                    Evaluate(DIGITOS2[5], DIGITOS1[5]);
                    Evaluate(DIGITOS2[6], DIGITOS1[6]);
                    Evaluate(DIGITOS2[7], DIGITOS1[7]);
                    Evaluate(DIGITOS2[8], DIGITOS1[8]);
                    Evaluate(DIGITOS2[9], DIGITOS1[9]);
                    Evaluate(DIGITOS2[10], DIGITOS1[10]);

                    SUMA2 := DIGITOS2[1] * 6 +
                           DIGITOS2[2] * 3 +
                           DIGITOS2[3] * 7 +
                           DIGITOS2[4] * 9 +
                           DIGITOS2[5] * 10 +
                           DIGITOS2[6] * 5 +
                           DIGITOS2[7] * 8 +
                           DIGITOS2[8] * 4 +
                           DIGITOS2[9] * 2 +
                           DIGITOS2[10] * 1;


                    DIV1 := ROUND(SUMA1 / 11, 1, '<');
                    RESTO1 := 11 - (SUMA1 - DIV1 * 11);
                    if RESTO1 = 10 then RESTO1 := 1;
                    if RESTO1 = 11 then RESTO1 := 0;



                    DIV2 := ROUND(SUMA2 / 11, 1, '<');
                    RESTO2 := 11 - (SUMA2 - DIV2 * 11);
                    if RESTO2 = 10 then RESTO2 := 1;
                    if RESTO2 = 11 then RESTO2 := 0;


                    DC := Format(RESTO1) + Format(RESTO2);

                    if DC <> "CCC Control Digits" then begin
                        Error('El DC exacto es %1 y no %2.', DC, "CCC Control Digits");
                    end;
                end;
            end;

        end;
    end;


    procedure calculabic()
    begin



        if "CCC Bank No." = '0156' then "SWIFT Code" := 'ABNAESMMXXX';
        if "CCC Bank No." = '3524' then "SWIFT Code" := 'AHCFESMMXXX';
        if "CCC Bank No." = '0188' then "SWIFT Code" := 'ALCLESMMXXX';
        if "CCC Bank No." = '0136' then "SWIFT Code" := 'AREBESMMXXX';
        if "CCC Bank No." = '0078' then "SWIFT Code" := 'BAPUES22XXX';
        if "CCC Bank No." = '0065' then "SWIFT Code" := 'BARCESMMXXX';
        if "CCC Bank No." = '2095' then "SWIFT Code" := 'BASKES2BXXX';
        if "CCC Bank No." = '0190' then "SWIFT Code" := 'BBPIESMMXXX';
        if "CCC Bank No." = '0168' then "SWIFT Code" := 'BBRUESMXXXX';
        if "CCC Bank No." = '0182' then "SWIFT Code" := 'BBVAESMMXXX';
        if "CCC Bank No." = '3081' then "SWIFT Code" := 'BCOEESMM081';
        if "CCC Bank No." = '0198' then "SWIFT Code" := 'BCOEESMMXXX';
        if "CCC Bank No." = '0131' then "SWIFT Code" := 'BESMESMMXXX';
        if "CCC Bank No." = '0488' then "SWIFT Code" := 'BFASESMMXXX';
        if "CCC Bank No." = '0186' then "SWIFT Code" := 'BFIVESBBXXX';
        if "CCC Bank No." = '0128' then "SWIFT Code" := 'BKBKESMMXXX';
        if "CCC Bank No." = '0138' then "SWIFT Code" := 'BKOAES22XXX';
        if "CCC Bank No." = '0061' then "SWIFT Code" := 'BMARES2MXXX';
        if "CCC Bank No." = '0219' then "SWIFT Code" := 'BMCEESMMXXX';
        if "CCC Bank No." = '0149' then "SWIFT Code" := 'BNPAESMHXXX';
        if "CCC Bank No." = '0058' then "SWIFT Code" := 'BNPAESMZXXX';
        if "CCC Bank No." = '0160' then "SWIFT Code" := 'BOTKESMXXXX';
        if "CCC Bank No." = '0152' then "SWIFT Code" := 'BPLCESMMXXX';
        if "CCC Bank No." = '0155' then "SWIFT Code" := 'BRASESMMXXX';
        if "CCC Bank No." = '0081' then "SWIFT Code" := 'BSABESBBXXX';
        if "CCC Bank No." = '0049' then "SWIFT Code" := 'BSCHESMMXXX';
        if "CCC Bank No." = '0154' then "SWIFT Code" := 'BSUIESMMXXX';
        if "CCC Bank No." = '0094' then "SWIFT Code" := 'BVALESMMXXX';
        if "CCC Bank No." = '2080' then "SWIFT Code" := 'CAGLESMMVIG';
        if "CCC Bank No." = '2038' then "SWIFT Code" := 'CAHMESMMXXX';
        if "CCC Bank No." = '2100' then "SWIFT Code" := 'CAIXESBBXXX';
        if "CCC Bank No." = '3604' then "SWIFT Code" := 'CAPIESMMXXX';
        if "CCC Bank No." = '3183' then "SWIFT Code" := 'CASDESBBXXX';
        if "CCC Bank No." = '2085' then "SWIFT Code" := 'CAZRES2ZXXX';
        if "CCC Bank No." = '0234' then "SWIFT Code" := 'CCOCESMMXXX';
        if "CCC Bank No." = '3058' then "SWIFT Code" := 'CCRIES2AXXX';
        if "CCC Bank No." = '3025' then "SWIFT Code" := 'CDENESBBXXX';
        if "CCC Bank No." = '2045' then "SWIFT Code" := 'CECAESMM045';
        if "CCC Bank No." = '2048' then "SWIFT Code" := 'CECAESMM048';
        if "CCC Bank No." = '2056' then "SWIFT Code" := 'CECAESMM056';
        if "CCC Bank No." = '2086' then "SWIFT Code" := 'CECAESMM086';
        if "CCC Bank No." = '2000' then "SWIFT Code" := 'CECAESMMXXX';
        if "CCC Bank No." = '2013' then "SWIFT Code" := 'CESCESBBXXX';
        if "CCC Bank No." = '0130' then "SWIFT Code" := 'CGDIESMMXXX';
        if "CCC Bank No." = '0122' then "SWIFT Code" := 'CITIES2XXXX';
        if "CCC Bank No." = '1474' then "SWIFT Code" := 'CITIESMXSEC';
        if "CCC Bank No." = '3035' then "SWIFT Code" := 'CLPEES2MXXX';
        if "CCC Bank No." = '0159' then "SWIFT Code" := 'COBAESMXTMA';
        if "CCC Bank No." = '1460' then "SWIFT Code" := 'CRESESMMXXX';
        if "CCC Bank No." = '2108' then "SWIFT Code" := 'CSPAES2L108';
        if "CCC Bank No." = '3656' then "SWIFT Code" := 'CSSOES2SFIN';
        if "CCC Bank No." = '0237' then "SWIFT Code" := 'CSURES2CXXX';
        if "CCC Bank No." = '0019' then "SWIFT Code" := 'DEUTESBBASS';
        if "CCC Bank No." = '0231' then "SWIFT Code" := 'DSBLESMMXXX';
        if "CCC Bank No." = '1467' then "SWIFT Code" := 'EHYPESMXXXX';
        if "CCC Bank No." = '9000' then "SWIFT Code" := 'ESPBESMMXXX';
        if "CCC Bank No." = '1497' then "SWIFT Code" := 'ESSIESMMXXX';
        if "CCC Bank No." = '0031' then "SWIFT Code" := 'ETCHES2GXXX';
        if "CCC Bank No." = '0046' then "SWIFT Code" := 'GALEES2GXXX';
        if "CCC Bank No." = '0487' then "SWIFT Code" := 'GBMNESMMXXX';
        if "CCC Bank No." = '0167' then "SWIFT Code" := 'GEBAESMMBIL';
        if "CCC Bank No." = '3682' then "SWIFT Code" := 'GVCBESBBETB';
        if "CCC Bank No." = '9096' then "SWIFT Code" := 'IBRCESMMXXX';
        if "CCC Bank No." = '1000' then "SWIFT Code" := 'ICROESMMXXX';
        if "CCC Bank No." = '1465' then "SWIFT Code" := 'INGDESMMXXX';
        if "CCC Bank No." = '3575' then "SWIFT Code" := 'INSGESMMXXX';
        if "CCC Bank No." = '0232' then "SWIFT Code" := 'INVLESMMXXX';
        if "CCC Bank No." = '9020' then "SWIFT Code" := 'IPAYESMMXXX';
        if "CCC Bank No." = '3669' then "SWIFT Code" := 'IVALESMMXXX';
        if "CCC Bank No." = '3641' then "SWIFT Code" := 'LISEESMMXXX';
        if "CCC Bank No." = '0236' then "SWIFT Code" := 'LOYIESMMXXX';
        if "CCC Bank No." = '0059' then "SWIFT Code" := 'MADRESMMXXX';
        if "CCC Bank No." = '9094' then "SWIFT Code" := 'MEFFESBBXXX';
        if "CCC Bank No." = '0162' then "SWIFT Code" := 'MIDLESMXXXX';
        if "CCC Bank No." = '3563' then "SWIFT Code" := 'MISVESMMXXX';
        if "CCC Bank No." = '3661' then "SWIFT Code" := 'MLCEESMMXXX';
        if "CCC Bank No." = '0169' then "SWIFT Code" := 'NACNESMMXXX';
        if "CCC Bank No." = '1479' then "SWIFT Code" := 'NATXESMMXXX';
        if "CCC Bank No." = '0144' then "SWIFT Code" := 'PARBESMHXXX';
        if "CCC Bank No." = '0216' then "SWIFT Code" := 'POHIESMMXXX';
        if "CCC Bank No." = '0233' then "SWIFT Code" := 'POPIESMMXXX';
        if "CCC Bank No." = '0229' then "SWIFT Code" := 'POPLESMMXXX';
        if "CCC Bank No." = '0075' then "SWIFT Code" := 'POPUESMMXXX';
        if "CCC Bank No." = '1459' then "SWIFT Code" := 'PRABESMMXXX';
        if "CCC Bank No." = '0211' then "SWIFT Code" := 'PROAESMMXXX';
        if "CCC Bank No." = '0083' then "SWIFT Code" := 'RENBESMMXXX';
        if "CCC Bank No." = '3501' then "SWIFT Code" := 'RENTESMMXXX';
        if "CCC Bank No." = '0108' then "SWIFT Code" := 'SOGEESMMAGM';
        if "CCC Bank No." = '1524' then "SWIFT Code" := 'UBIBESMMXXX';
        if "CCC Bank No." = '0226' then "SWIFT Code" := 'UBSWESMMNPB';
        if "CCC Bank No." = '2103' then "SWIFT Code" := 'UCJAES2MXXX';
        if "CCC Bank No." = '0196' then "SWIFT Code" := 'WELAESMMFUN';
        if "CCC Bank No." = '9091' then "SWIFT Code" := 'XBCNESBBXXX';
        if "CCC Bank No." = '9092' then "SWIFT Code" := 'XRBVES2BXXX';
        if "CCC Bank No." = '9093' then "SWIFT Code" := 'XRVVESVVXXX';
    end;
}
