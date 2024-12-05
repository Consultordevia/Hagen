#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50069 sii2
{
    // 
    // 7,18,19
    // 
    // ///DESDEFECHA:= InputDlg.InputBox('Desde fecha: ','Desde fecha:','',100,100);
    // 
    // DESDEFECHA:=CALCDATE('-2M',TODAY);
    // HASTAFECHA:=TODAY;


    trigger OnRun()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        FileName: Text;
        InStream: InStream;
        FicherosHagen: Codeunit FicherosHagen;
        CarriageReturn: Char;
        LineFeed: Char;
        Data: BigText;
        OutTxt: Text;

    begin



        Clear(DesdehastaSII);
        DesdehastaSII.RunModal;
        Commit;

         CarriageReturn := 13; // 13 es el valor ASCII para Carriage Return (CR)
        LineFeed := 10;       // 10 es el valor ASCII para Line Feed (LF)

        Clear(TempBlob);
        TempBlob.CreateOutStream(OutStream, TextEncoding::Windows);

        ///TempBlob.CreateOutStream(OutStream);
        ///OutStream.Write(TextoSalida1);



        GeneralLedgerSetup.Get;
        DESDEFECHA := GeneralLedgerSetup."Desde fecha SII";
        HASTAFECHA := GeneralLedgerSetup."Hasta fecha SII";
        desdendocsii := GeneralLedgerSetup."Desde Numero documento SII";
        hastandocsii := GeneralLedgerSetup."Hasta Numero documento SII";

        if (desdendocsii <> '') and (hastandocsii = '') then begin
            Error('Falta el hasta documento.');
        end;
        nseriesii := GeneralLedgerSetup."Serie SII";
        CompanyInformation.Get;


        datet := CreateDatetime(Today, Time);

        textodatat := ConvertStr(Format(datet), '/', '_');
        textodatat := ConvertStr(Format(textodatat), ':', '_');
        textodatat := ConvertStr(Format(textodatat), '-', '_');
        textodatat := ConvertStr(Format(textodatat), ' ', '_');



        ///ArchExt := '\\192.168.0.66\documentos_sii\SII_' + Format(textodatat) + '.CSV';

        ///     ArchSalida.TextMode := true;
        ///ArchSalida.WriteMode := true;
        ///ArchSalida.Create(ArchExt);


        ///REC91.Get(UserId);


        VENTANA.Open('#1############');


        OutTxt := 'Emi/Rec;' + ///1
                        'Factura;' +  ///2
                        'FechaFactura;' +  ///3
                        'FechaOperacion;' +  ///4
                        'FechaContable;' +  ///5
                        'ClaveFactura;' +  ///6
                        'Nombre;' +  ///7
                        'Nif/Identificador Pais;' +  ///8
                        'NifRpte;' +  ///9
                        'Pais;' +  ///10
                        'TipoNif;' +  ///11
                        'TipoFactura;' + /// 12
                        'Calificacion;' +  ///13
                        'Descripcion;' +  ///14
                        'TotalFactura;';  ///15
                         data.AddText(OutTxt);
        OutTxt := 'Base1;' + ///16
                        'IVA1;' +  ///17
                        'Cuota1;' +  ///18
                        'Rec1;' +  ///19
                        'CuotaRec1;' + /// 20
                        'Base2;' +  ///21
                        'IVA2;' +  ///22
                        'Cuota2;' +  ///23
                        'Rec2;' +  ///24
                        'CuotaRec2;' +  ///25
                        'Base3;' +  ///26
                        'IVA3;' +  ///27
                        'Cuota3;' + ///28
                        'Rec3;' +  ///29
                        'CuotaRec3;' +  ///30
                        'CausaExencion;' +  ///31
                        'BaseImpExenta;' +  ///32
                        'BaseImpCoste;';  ///33
                         data.AddText(OutTxt);
        OutTxt := 'SituacionCatastral;' + ///34
                        'ReferenciaCatastral;' +  ///35
                        'TipoNoSujetoIVA;' +  ///36
                        'ImpNoSujetoIVA;' + /// 36
                        'ImpTransmisiones;' +  ///37
                        'TipoRectificativa;' +  ///39
                        'FacturaRectificativa;' + /// 40
                        'FechaRectificativa;' +  ///41
                        'BaseRectificada;' +  ///42
                        'CuotaRectificada;' +  ///43
                        'PrestacionServicios;' + /// 44
                        'FacturaTerceros;' +  ///45
                        'Ejercicio;' +  ///46
                        'Periodo;' +  ///47
                        'CuotaDeducible;' +  ///48
                        'BienInversion1;' +  ///49
                        'BienInversion2;' +  ///50
                        'BienInversion3;';  ///51
                         data.AddText(OutTxt);
        OutTxt := 'DeduccionPosterior;' +/// 52
                        'EjercicioDeduccion;' +  ///53
                        'PeriodoDeduccion;' +  ///54
                        'VariosDestinatarios;' + /// 55
                        'Autorizacion;' +  ///56
                        'ReferenciaExterna;' +  ///57
                        'NombreEntidadSucedida;' + /// 58
                        'NIFEntidadSucedida;' +  ///59
                        'Macrodato;' +  ///60
                        'FacturaGas;' +  ///61
                        'FacturaSinDestinatario;' +  ///62
                        'PrevioGGEEREDEME;' +  ///63
                        'FacturaSimplificada_72_73';  ///64
                        OutTxt += Format(CarriageReturn) + Format(LineFeed);
                        data.AddText(OutTxt);

        /////ArchSalida.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4);


        ///OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4);

        Rec112.Reset;
        Rec112.SetCurrentkey(Rec112."Posting Date");
        Rec112.SetRange(Rec112."Posting Date", DESDEFECHA, HASTAFECHA);
        if desdendocsii <> '' then begin
            Rec112.SetRange("No.", desdendocsii, hastandocsii);
        end;
        if nseriesii <> '' then begin
            Rec112.SetRange(Rec112."No. Series", nseriesii);
        end;
        if Rec112.FindFirst then
            repeat
                VENTANA.Update(1, Rec112."No.");
                if RecNS.Get(Rec112."No. Series") then begin
                    if RecNS."No SII" = false then begin
                        Rec112.CalcFields(Rec112."Amount Including VAT");
                        RecClie.Get(Rec112."Sell-to Customer No.");
                        Nif := RecClie."VAT Registration No.";
                        if RecClie."Tipo Factura SII" = RecClie."tipo factura sii"::F1 then begin
                            TipoFactura := 'F1';
                        end;
                        if RecClie."Tipo Factura SII" = RecClie."tipo factura sii"::F2 then begin
                            TipoFactura := 'F2';
                            Nif := '';
                        end;


                        BASE1 := 0;
                        IVA1 := 0;
                        CUOTA1 := 0;
                        REC1 := 0;
                        CUOTAREC1 := 0;

                        BASE2 := 0;
                        IVA2 := 0;
                        CUOTA2 := 0;
                        REC2 := 0;
                        CUOTAREC2 := 0;

                        BASE3 := 0;
                        IVA3 := 0;
                        CUOTA3 := 0;
                        REC3 := 0;
                        CUOTAREC3 := 0;

                        Rec254.Reset;
                        Rec254.SetRange(Rec254."Document No.", Rec112."No.");
                        Rec254.SetRange(Rec254."VAT %", 21);
                        if Rec254.FindSet then
                            repeat
                                BASE1 := BASE1 + Rec254.Base;
                                REC1 := Rec254."EC %";
                                IVA1 := Rec254."VAT %";
                                ///IF REC1=0 THEN BEGIN
                                CUOTA1 := CUOTA1 + Rec254.Amount;
                            ///END;
                            until Rec254.Next = 0;
                        if REC1 <> 0 then begin
                            CUOTAREC1 := ROUND(BASE1 * REC1 / 100, 0.01);
                            CUOTA1 := ROUND(BASE1 * IVA1 / 100, 0.01);
                        end;
                        Rec254.Reset;
                        Rec254.SetRange(Rec254."Document No.", Rec112."No.");
                        Rec254.SetRange(Rec254."VAT %", 10);
                        if Rec254.FindSet then
                            repeat
                                BASE2 := BASE2 + Rec254.Base;
                                REC2 := Rec254."EC %";
                                IVA2 := Rec254."VAT %";
                                ///IF REC2=0 THEN BEGIN
                                CUOTA2 := CUOTA2 + Rec254.Amount;
                            ///END;
                            until Rec254.Next = 0;
                        if REC2 <> 0 then begin
                            CUOTAREC2 := ROUND(BASE2 * REC2 / 100, 0.01);
                            CUOTA2 := ROUND(BASE2 * IVA2 / 100, 0.01);
                        end;
                        if BASE1 <> 0 then begin
                            Rec254.Reset;
                            Rec254.SetRange(Rec254."Document No.", Rec112."No.");
                            Rec254.SetRange(Rec254."VAT %", 0);
                            if Rec254.FindSet then
                                repeat
                                    BASE3 := BASE3 + Rec254.Base;
                                    REC3 := Rec254."EC %";
                                    IVA3 := Rec254."VAT %";
                                    /// IF REC3=0 THEN BEGIN
                                    CUOTA3 := CUOTA3 + Rec254.Amount;
                                ///END;
                                until Rec254.Next = 0;
                            if REC3 <> 0 then begin
                                CUOTAREC3 := ROUND(BASE3 * REC3 / 100, 0.01);
                                CUOTA3 := ROUND(BASE3 * IVA3 / 100, 0.01);
                            end;
                        end;
                        if BASE1 = 0 then begin
                            Rec254.Reset;
                            Rec254.SetRange(Rec254."Document No.", Rec112."No.");
                            Rec254.SetRange(Rec254."VAT %", 0);
                            if Rec254.FindSet then
                                repeat
                                    BASE1 := BASE1 + Rec254.Base;
                                    REC1 := Rec254."EC %";
                                    IVA1 := Rec254."VAT %";
                                    ///IF REC1=0 THEN BEGIN
                                    CUOTA1 := CUOTA1 + Rec254.Amount;
                                ///END;
                                until Rec254.Next = 0;
                            if REC1 <> 0 then begin
                                CUOTAREC1 := ROUND(BASE1 * REC1 / 100, 0.01);
                                CUOTA1 := ROUND(BASE1 * IVA1 / 100, 0.01);
                            end;
                        end;


                        BASE1 := BASE1 * -1;
                        CUOTA1 := CUOTA1 * -1;
                        CUOTAREC1 := CUOTAREC1 * -1;
                        BASE2 := BASE2 * -1;
                        CUOTA2 := CUOTA2 * -1;
                        CUOTAREC2 := CUOTAREC2 * -1;
                        BASE3 := BASE3 * -1;
                        CUOTA3 := CUOTA3 * -1;
                        CUOTAREC3 := CUOTAREC3 * -1;


                        EJERCICIO := Date2dmy(Rec112."Posting Date", 3);
                        PERIODO := Date2dmy(Rec112."Posting Date", 2);

                        Calificacion := 'S1';
                        CLAVEFAC := '01';
                        if (Rec112."Bill-to Country/Region Code" <> 'ES') and (RecClie."Country/Region Code" <> 'ES') then begin
                            CLAVEFAC := '01';
                            Calificacion := 'E2';
                        end;



                        if CountryRegion.Get(Rec112."Bill-to Country/Region Code") then begin
                            if (CountryRegion."EU Country/Region Code" <> '') and (Rec112."Bill-to Country/Region Code" <> 'ES') and (RecClie."Country/Region Code" <> 'ES') then begin
                                Calificacion := 'E5';
                            end;
                            if (CountryRegion."EU Country/Region Code" = '') and (Rec112."Bill-to Country/Region Code" <> 'ES') and (RecClie."Country/Region Code" <> 'ES') then begin
                                CLAVEFAC := '02';
                            end;
                        end;

                        if Rec112."Bill-to Country/Region Code" = 'AD' then begin
                            Calificacion := 'E2';
                        end;
                        if RecClie."Country/Region Code" = 'AD' then begin
                            Calificacion := 'E2';
                        end;

                        Area.Reset;
                        Area.SetRange(Area.Text, Rec112."Bill-to County");
                        if Area.FindSet then begin
                            if (Area.Comunidad = '7') or (Area.Comunidad = '18') or (Area.Comunidad = '19') then begin
                                CLAVEFAC := '02';
                                Calificacion := 'E2';
                            end;
                        end;


                        if BASE3 = 0.01 then begin BASE1 := BASE1 + BASE3; BASE3 := 0; end;




                        CuotaDeducible := CUOTA1 + CUOTA2 + CUOTA3 + CUOTAREC1 + CUOTAREC2 + CUOTAREC3;


                        textonombre := Rec112."Bill-to Name";




                        textonombre := ANSIASCIIconverter2.Ascii2Ansi(textonombre);
                        ////textonombre:=ANSIASCIIconverter2.Ansi2Ascii(textonombre);





                        OutTxt := 'E;' +
                                        Format(Rec112."No.") + ';' +
                                        Format(Rec112."Posting Date") + ';' +
                                        Format(Rec112."Posting Date") + ';' +
                                        Format(Rec112."Posting Date") + ';' +
                                        CLAVEFAC + ';' +
                                        Format(CopyStr(textonombre, 1, 30)) + ';' +
                                        Format(Nif) + ';' +
                                        ';' + ///9
                                        Format(Rec112."Bill-to Country/Region Code") + ';' +
                                        '1;' + ///11
                                        TipoFactura + ';' + ///12
                                        Calificacion + ';' + ///13
                                'VENTAS;' + ///14
                                Format(Rec112."Amount Including VAT") + ';';
                        OutTxt := Format(BASE1) + ';' + ///16
                                        Format(IVA1) + ';' + ///17
                                        Format(CUOTA1) + ';' +/// 18
                                        Format(REC1) + ';' + ///19
                                        Format(CUOTAREC1) + ';' + ///20
                                        Format(BASE2) + ';' + ///21
                                        Format(IVA2) + ';' + ///22
                                        Format(CUOTA2) + ';' + ///23
                                        Format(REC2) + ';' + ///24
                                        Format(CUOTAREC2) + ';' + ///25
                                        Format(BASE3) + ';' + ///26
                                        Format(IVA3) + ';' + ///27
                                        Format(CUOTA3) + ';' + ///28
                                        Format(REC3) + ';' + ///29
                                        Format(CUOTAREC3) + ';' + ///30
                                        Format(CausaExencion) + ';' + ///31
                                        Format(BaseImpExenta) + ';' + ///32
                                        Format(BaseImpCoste) + ';';  ///33
                        OutTxt := Format(SituacionCatastral) + ';' + ///34
                                        Format(ReferenciaCatastral) + ';' + ///35
                                        Format(TipoNoSujetoIVA) + ';' + ///36
                                        Format(ImpNoSujetoIVA) + ';' + ///36
                                        Format(ImpTransmisiones) + ';' + ///37
                                        Format(TipoRectificativa) + ';' + ///39
                                        Format(FacturaRectificativa) + ';' + ///40
                                        Format(FechaRectificativa) + ';' + ///41
                                        Format(BaseRectificada) + ';' +/// 42
                                        Format(CuotaRectificada) + ';' + ///43
                                        Format(PrestacionServicios) + ';' + ///44
                                        Format(FacturaTerceros) + ';' + ///45
                                        Format(EJERCICIO) + ';' + ///46
                                        Format(PERIODO) + ';' + ///47
                                        Format(CuotaDeducible) + ';' + ///48
                                        Format(BienInversion1) + ';' + ///49
                                        Format(BienInversion2) + ';' + ///50
                                        Format(BienInversion3) + ';';  ///51
                        OutTxt := Format(DeduccionPosterior) + ';' + ///52
                                        Format(EjercicioDeduccion) + ';' + ///53
                                        Format(PeriodoDeduccion) + ';' + ///54
                                        Format(VariosDestinatarios) + ';' + ///55
                                        Format(Autorizacion) + ';' + ///56
                                        Format(ReferenciaExterna) + ';' + ///57
                                        Format(NombreEntidadSucedida) + ';' + ///58
                                        Format(NIFEntidadSucedida) + ';' + ///59
                                        Format(Macrodato) + ';' + ///60
                                        Format(FacturaGas) + ';' + ///61
                                        Format(FacturaSinDestinatario) + ';' + ///62
                                        Format(PrevioGGEEREDEME) + ';' + ///63
                                        Format(FacturaSimplificada_72_73);  ///64
                        if Rec112."Amount Including VAT" <> 0 then begin
                            /////ArchSalida.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4);
                            ///OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4);
                            OutTxt += Format(CarriageReturn) + Format(LineFeed);
                            data.AddText(OutTxt);
                        end;

                    end;
                end;
            until Rec112.Next = 0;

        Rec114.Reset;
        Rec114.SetCurrentkey(Rec114."Posting Date");
        Rec114.SetRange(Rec114."Posting Date", DESDEFECHA, HASTAFECHA);
        if desdendocsii <> '' then begin
            Rec114.SetRange("No.", desdendocsii, hastandocsii);
        end;
        if nseriesii <> '' then begin
            Rec114.SetRange("No. Series", nseriesii);
        end;
        if Rec114.FindFirst then
            repeat
                if RecNS.Get(Rec114."No. Series") then begin
                    if RecNS."No SII" = false then begin
                        VENTANA.Update(1, Rec114."No.");
                        Rec114.CalcFields(Rec114."Amount Including VAT");

                        RecClie.Get(Rec114."Sell-to Customer No.");
                        Nif := RecClie."VAT Registration No.";
                        if RecClie."Tipo Factura SII" = RecClie."tipo factura sii"::F1 then begin
                            TipoFactura := 'R1';
                        end;
                        if RecClie."Tipo Factura SII" = RecClie."tipo factura sii"::F2 then begin
                            TipoFactura := 'R5';
                            Nif := '';
                        end;

                        EJERCICIO := Date2dmy(Rec114."Posting Date", 3);
                        PERIODO := Date2dmy(Rec114."Posting Date", 2);

                        BASE1 := 0;
                        IVA1 := 0;
                        CUOTA1 := 0;
                        REC1 := 0;
                        CUOTAREC1 := 0;

                        BASE2 := 0;
                        IVA2 := 0;
                        CUOTA2 := 0;
                        REC2 := 0;
                        CUOTAREC2 := 0;

                        BASE3 := 0;
                        IVA3 := 0;
                        CUOTA3 := 0;
                        REC3 := 0;
                        CUOTAREC3 := 0;


                        Rec254.Reset;
                        Rec254.SetRange(Rec254."Document No.", Rec114."No.");
                        Rec254.SetRange(Rec254."VAT %", 21);
                        if Rec254.FindSet then
                            repeat
                                BASE1 := BASE1 + Rec254.Base;
                                REC1 := Rec254."EC %";
                                IVA1 := Rec254."VAT %";
                                ///IF REC1=0 THEN BEGIN
                                CUOTA1 := CUOTA1 + Rec254.Amount;
                            ///END;
                            until Rec254.Next = 0;
                        if REC1 <> 0 then begin
                            CUOTAREC1 := ROUND(BASE1 * REC1 / 100, 0.01);
                            CUOTA1 := ROUND(BASE1 * IVA1 / 100, 0.01);
                        end;
                        Rec254.Reset;
                        Rec254.SetRange(Rec254."Document No.", Rec114."No.");
                        Rec254.SetRange(Rec254."VAT %", 10);
                        if Rec254.FindSet then
                            repeat
                                BASE2 := BASE2 + Rec254.Base;
                                REC2 := Rec254."EC %";
                                IVA2 := Rec254."VAT %";
                                ///IF REC2=0 THEN BEGIN
                                CUOTA2 := CUOTA2 + Rec254.Amount;
                            ///END;
                            until Rec254.Next = 0;
                        if REC2 <> 0 then begin
                            CUOTAREC2 := ROUND(BASE2 * REC2 / 100, 0.01);
                            CUOTA2 := ROUND(BASE2 * IVA2 / 100, 0.01);
                        end;
                        if BASE1 <> 0 then begin
                            Rec254.Reset;
                            Rec254.SetRange(Rec254."Document No.", Rec114."No.");
                            Rec254.SetRange(Rec254."VAT %", 0);
                            if Rec254.FindSet then
                                repeat
                                    BASE3 := BASE3 + Rec254.Base;
                                    REC3 := Rec254."EC %";
                                    IVA3 := Rec254."VAT %";
                                    /// IF REC3=0 THEN BEGIN
                                    CUOTA3 := CUOTA3 + Rec254.Amount;
                                ///END;
                                until Rec254.Next = 0;
                            if REC3 <> 0 then begin
                                CUOTAREC3 := ROUND(BASE3 * REC3 / 100, 0.01);
                                CUOTA3 := ROUND(BASE3 * IVA3 / 100, 0.01);
                            end;
                        end;
                        if BASE1 = 0 then begin
                            Rec254.Reset;
                            Rec254.SetRange(Rec254."Document No.", Rec114."No.");
                            Rec254.SetRange(Rec254."VAT %", 0);
                            if Rec254.FindSet then
                                repeat
                                    BASE1 := BASE1 + Rec254.Base;
                                    REC1 := Rec254."EC %";
                                    IVA1 := Rec254."VAT %";
                                    ///IF REC1=0 THEN BEGIN
                                    CUOTA1 := CUOTA1 + Rec254.Amount;
                                ///END;
                                until Rec254.Next = 0;
                            if REC1 <> 0 then begin
                                CUOTAREC1 := ROUND(BASE1 * REC1 / 100, 0.01);
                                CUOTA1 := ROUND(BASE1 * IVA1 / 100, 0.01);
                            end;
                        end;


                        BASE1 := BASE1 * -1;
                        CUOTA1 := CUOTA1 * -1;
                        CUOTAREC1 := CUOTAREC1 * -1;
                        BASE2 := BASE2 * -1;
                        CUOTA2 := CUOTA2 * -1;
                        CUOTAREC2 := CUOTAREC2 * -1;
                        BASE3 := BASE3 * -1;
                        CUOTA3 := CUOTA3 * -1;
                        CUOTAREC3 := CUOTAREC3 * -1;


                        Calificacion := 'S1';
                        CLAVEFAC := '01';
                        if (Rec114."Bill-to Country/Region Code" <> 'ES') and (RecClie."Country/Region Code" <> 'ES') then begin
                            CLAVEFAC := '01';
                            Calificacion := 'E2';
                        end;

                        if CountryRegion.Get(Rec114."Bill-to Country/Region Code") then begin
                            if (CountryRegion."EU Country/Region Code" <> '') and (Rec114."Bill-to Country/Region Code" <> 'ES') and (RecClie."Country/Region Code" <> 'ES') then begin
                                Calificacion := 'E5';
                            end;
                            if (CountryRegion."EU Country/Region Code" = '') and (Rec114."Bill-to Country/Region Code" <> 'ES') and (RecClie."Country/Region Code" <> 'ES') then begin
                                CLAVEFAC := '02';
                            end;

                        end;

                        Area.Reset;
                        Area.SetRange(Area.Text, Rec114."Bill-to County");
                        if Area.FindSet then begin
                            if (Area.Comunidad = '7') or (Area.Comunidad = '18') or (Area.Comunidad = '19') then begin
                                CLAVEFAC := '02';
                                Calificacion := 'E2';
                            end;
                        end;

                        if Rec114."Bill-to Country/Region Code" = 'AD' then begin
                            Calificacion := 'E2';
                        end;
                        if RecClie."Country/Region Code" = 'AD' then begin
                            Calificacion := 'E2';
                        end;



                        if BASE3 = 0.01 then begin BASE1 := BASE1 + BASE3; BASE3 := 0; end;


                        CuotaDeducible := CUOTA1 + CUOTA2 + CUOTA3 + CUOTAREC1 + CUOTAREC2 + CUOTAREC3;

                        OutTxt := 'E;' + ///1
                                       Format(Rec114."No.") + ';' +
                                       Format(Rec114."Posting Date") + ';' +
                                       Format(Rec114."Posting Date") + ';' +
                                       Format(Rec114."Posting Date") + ';' +
                                       CLAVEFAC + ';' +
                                       Format(CopyStr(Rec114."Bill-to Name", 1, 30)) + ';' +
                                       Format(Nif) + ';' +
                                       ';' + ///9
                                       Format(Rec114."Bill-to Country/Region Code") + ';' +
                                       '1;' + ///11
                                       TipoFactura + ';' + ///12
                                       Calificacion + ';' + ///13
                                'VENTAS;' +  ///14
                                Format(Rec114."Amount Including VAT" * -1) + ';';
                        OutTxt := Format(BASE1) + ';' + ///16
                                       Format(IVA1) + ';' + ///17
                                       Format(CUOTA1) + ';' + ///18
                                       Format(REC1) + ';' + ///19
                                       Format(CUOTAREC1) + ';' +/// 20
                                       Format(BASE2) + ';' + ///21
                                       Format(IVA2) + ';' + ///22
                                       Format(CUOTA2) + ';' + ///23
                                       Format(REC2) + ';' +/// 24
                                       Format(CUOTAREC2) + ';' +/// 25
                                       Format(BASE3) + ';' + ///26
                                       Format(IVA3) + ';' +/// 27
                                       Format(CUOTA3) + ';' + ///28
                                       Format(REC3) + ';' +/// 29
                                       Format(CUOTAREC3) + ';' + ///30
                                       Format(CausaExencion) + ';' + ///31
                                       Format(BaseImpExenta) + ';' + ///32
                                       Format(BaseImpCoste) + ';';  ///33
                        OutTxt := Format(SituacionCatastral) + ';' + ///34
                                       Format(ReferenciaCatastral) + ';' +/// 35
                                       Format(TipoNoSujetoIVA) + ';' + ///36
                                       Format(ImpNoSujetoIVA) + ';' + ///36
                                       Format(ImpTransmisiones) + ';' + ///37
                                       Format(TipoRectificativa) + ';' + ///39
                                       Format(FacturaRectificativa) + ';' + ///40
                                       Format(FechaRectificativa) + ';' + ///41
                                       Format(BaseRectificada) + ';' + ///42
                                       Format(CuotaRectificada) + ';' + ///43
                                       Format(PrestacionServicios) + ';' +/// 44
                                       Format(FacturaTerceros) + ';' + ///45
                                       Format(EJERCICIO) + ';' + ///46
                                       Format(PERIODO) + ';' +/// 47
                                       Format(CuotaDeducible) + ';' +/// 48
                                       Format(BienInversion1) + ';' + ///49
                                       Format(BienInversion2) + ';' + ///50
                                       Format(BienInversion3) + ';';  ///51
                        OutTxt := Format(DeduccionPosterior) + ';' + ///52
                                       Format(EjercicioDeduccion) + ';' + ///53
                                       Format(PeriodoDeduccion) + ';' + ///54
                                       Format(VariosDestinatarios) + ';' + ///55
                                       Format(Autorizacion) + ';' + ///56
                                       Format(ReferenciaExterna) + ';' + ///57
                                       Format(NombreEntidadSucedida) + ';' + ///58
                                       Format(NIFEntidadSucedida) + ';' + ///59
                                       Format(Macrodato) + ';' + ///60
                                       Format(FacturaGas) + ';' + ///61
                                       Format(FacturaSinDestinatario) + ';' + ///62
                                       Format(PrevioGGEEREDEME) + ';' + ///63
                                       Format(FacturaSimplificada_72_73);  ///64
                        if Rec114."Amount Including VAT" <> 0 then begin
                            ///ArchSalida.Write(TextoSalida1+TextoSalida2+TextoSalida3+TextoSalida4);
                            ///OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4);
                            OutTxt += Format(CarriageReturn) + Format(LineFeed);
                            data.AddText(OutTxt);

                        end;

                    end;
                end;

            until Rec114.Next = 0;

        /////////////////////////
        ///// compras
        /////////////////////////

        Rec122.Reset;
        Rec122.SetCurrentkey(Rec122."Posting Date");
        Rec122.SetRange(Rec122."Posting Date", DESDEFECHA, HASTAFECHA);
        if desdendocsii <> '' then begin
            Rec122.SetRange("No.", desdendocsii, hastandocsii);
        end;
        if nseriesii <> '' then begin
            Rec122.SetRange("No. Series", nseriesii);
        end;
        if Rec122.FindFirst then
            repeat
                VENTANA.Update(1, Rec122."No.");
                if RecNS.Get(Rec122."No. Series") then begin
                    if RecNS."No SII" = false then begin
                        Rec122.CalcFields(Rec122."Amount Including VAT");
                        Vendor.Get(Rec122."Buy-from Vendor No.");
                        Nif := Vendor."VAT Registration No.";



                        TipoFactura := 'F1';
                        if Rec122.DUA <> '' then begin
                            /////TipoFactura:='F5';
                        end;


                        BASE1 := 0;
                        IVA1 := 0;
                        CUOTA1 := 0;
                        REC1 := 0;
                        CUOTAREC1 := 0;

                        BASE2 := 0;
                        IVA2 := 0;
                        CUOTA2 := 0;
                        REC2 := 0;
                        CUOTAREC2 := 0;

                        BASE3 := 0;
                        IVA3 := 0;
                        CUOTA3 := 0;
                        REC3 := 0;
                        CUOTAREC3 := 0;

                        Rec254.Reset;
                        Rec254.SetRange(Rec254."Document No.", Rec122."No.");
                        Rec254.SetRange(Rec254."VAT %", 21);
                        if Rec254.FindSet then
                            repeat
                                BASE1 := BASE1 + Rec254.Base;
                                REC1 := Rec254."EC %";
                                IVA1 := Rec254."VAT %";
                                if REC1 = 0 then begin
                                    CUOTA1 := CUOTA1 + Rec254.Amount;
                                end;
                                if REC1 <> 0 then begin
                                    CUOTAREC1 := CUOTAREC1 + ROUND(BASE1 * REC1 / 100, 0.01);
                                    CUOTA1 := CUOTA1 + Rec254.Amount - ROUND(BASE1 * REC1 / 100, 0.01);
                                end;
                            until Rec254.Next = 0;
                        Rec254.Reset;
                        Rec254.SetRange(Rec254."Document No.", Rec122."No.");
                        Rec254.SetRange(Rec254."VAT %", 10);
                        if Rec254.FindSet then
                            repeat
                                BASE2 := BASE2 + Rec254.Base;
                                REC2 := Rec254."EC %";
                                IVA2 := Rec254."VAT %";
                                if REC2 = 0 then begin
                                    CUOTA2 := CUOTA2 + Rec254.Amount;
                                end;
                                if REC2 <> 0 then begin
                                    CUOTAREC2 := CUOTAREC2 + ROUND(BASE1 * REC2 / 100, 0.01);
                                    CUOTA2 := CUOTA2 + Rec254.Amount - ROUND(BASE2 * REC2 / 100, 0.01);
                                end;
                            until Rec254.Next = 0;
                        if BASE1 <> 0 then begin
                            Rec254.Reset;
                            Rec254.SetRange(Rec254."Document No.", Rec122."No.");
                            Rec254.SetRange(Rec254."VAT %", 0);
                            if Rec254.FindSet then
                                repeat
                                    BASE3 := BASE3 + Rec254.Base;
                                    REC3 := Rec254."EC %";
                                    IVA3 := Rec254."VAT %";
                                    if REC3 = 0 then begin
                                        CUOTA3 := CUOTA3 + Rec254.Amount;
                                    end;
                                    if REC3 <> 0 then begin
                                        CUOTAREC3 := CUOTAREC3 + ROUND(BASE3 * REC3 / 100, 0.01);
                                        CUOTA3 := CUOTA3 + Rec254.Amount - ROUND(BASE3 * REC3 / 100, 0.01);
                                    end;
                                until Rec254.Next = 0;
                        end;
                        if BASE1 = 0 then begin
                            Rec254.Reset;
                            Rec254.SetRange(Rec254."Document No.", Rec122."No.");
                            Rec254.SetRange(Rec254."VAT %", 0);
                            if Rec254.FindSet then
                                repeat
                                    BASE1 := BASE1 + Rec254.Base;
                                    REC1 := Rec254."EC %";
                                    IVA1 := Rec254."VAT %";
                                    if REC1 = 0 then begin
                                        CUOTA1 := CUOTA1 + Rec254.Amount;
                                    end;
                                    if REC1 <> 0 then begin
                                        CUOTAREC1 := CUOTAREC1 + ROUND(BASE1 * REC1 / 100, 0.01);
                                        CUOTA1 := CUOTA1 + Rec254.Amount - ROUND(BASE1 * REC1 / 100, 0.01);
                                    end;
                                until Rec254.Next = 0;
                        end;
                        totalfac := BASE1 + BASE2 + BASE3 + CUOTA1 + CUOTA2 + CUOTA3 + CUOTAREC1 + CUOTAREC2 + CUOTAREC3;
                        if Rec122.DUA <> '' then begin
                            BASE3 := 0;
                            CUOTA3 := 0;
                            CUOTAREC3 := 0;
                            totalfac := BASE1 + BASE2 + CUOTA1 + CUOTA2;
                        end;



                        EJERCICIO := Date2dmy(Rec122."Posting Date", 3);
                        PERIODO := Date2dmy(Rec122."Posting Date", 2);

                        Calificacion := 'S1';
                        CLAVEFAC := '01';


                        CuotaDeducible := CUOTA1 + CUOTA2 + CUOTA3 + CUOTAREC1 + CUOTAREC2 + CUOTAREC3;

                        OutTxt := 'R;' + ///1
                                        Format(Rec122."Vendor Invoice No.") + ';' +
                                        Format(Rec122."Document Date") + ';' +
                                        Format(Rec122."Posting Date") + ';' +
                                        Format(Rec122."Posting Date") + ';' +
                                        CLAVEFAC + ';' +
                                        Format(CopyStr(Rec122."Pay-to Name", 1, 30)) + ';' +
                                        Format(Nif) + ';' +
                                        ';' + ///9
                                        Format(Rec122."Pay-to Country/Region Code") + ';' +
                                        '1;' + ///11
                                        TipoFactura + ';' + ///12
                                        Calificacion + ';' + ///13
                                'COMPRAS;' +  ///14
                                Format(totalfac) + ';';
                        OutTxt := Format(BASE1) + ';' + ///16
                                        Format(IVA1) + ';' + ///17
                                        Format(CUOTA1) + ';' + ///18
                                        Format(REC1) + ';' +/// 19
                                        Format(CUOTAREC1) + ';' +/// 20
                                        Format(BASE2) + ';' + ///21
                                        Format(IVA2) + ';' +/// 22
                                        Format(CUOTA2) + ';' + ///23
                                        Format(REC2) + ';' + ///24
                                        Format(CUOTAREC2) + ';' + ///25
                                        Format(BASE3) + ';' + ///26
                                        Format(IVA3) + ';' + ///27
                                        Format(CUOTA3) + ';' + ///28
                                        Format(REC3) + ';' +/// 29
                                        Format(CUOTAREC3) + ';' + ///30
                                        Format(CausaExencion) + ';' +/// 31
                                        Format(BaseImpExenta) + ';' + ///32
                                        Format(BaseImpCoste) + ';';  ///33
                        OutTxt := Format(SituacionCatastral) + ';' + ///34
                                        Format(ReferenciaCatastral) + ';' + ///35
                                        Format(TipoNoSujetoIVA) + ';' + ///36
                                        Format(ImpNoSujetoIVA) + ';' + ///36
                                        Format(ImpTransmisiones) + ';' + ///37
                                        Format(TipoRectificativa) + ';' + ///39
                                        Format(FacturaRectificativa) + ';' + ///40
                                        Format(FechaRectificativa) + ';' +/// 41
                                        Format(BaseRectificada) + ';' +/// 42
                                        Format(CuotaRectificada) + ';' + ///43
                                        Format(PrestacionServicios) + ';' +/// 44
                                        Format(FacturaTerceros) + ';' +/// 45
                                        Format(EJERCICIO) + ';' + ///46
                                        Format(PERIODO) + ';' + ///47
                                        Format(CuotaDeducible) + ';' +/// 48
                                        Format(BienInversion1) + ';' + ///49
                                        Format(BienInversion2) + ';' + ///50
                                        Format(BienInversion3) + ';';  ///51
                        OutTxt := Format(DeduccionPosterior) + ';' + ///52
                                        Format(EjercicioDeduccion) + ';' + ///53
                                        Format(PeriodoDeduccion) + ';' +/// 54
                                        Format(VariosDestinatarios) + ';' + ///55
                                        Format(Autorizacion) + ';' +/// 56
                                        Format(ReferenciaExterna) + ';' +/// 57
                                        Format(NombreEntidadSucedida) + ';' +/// 58
                                        Format(NIFEntidadSucedida) + ';' + ///59
                                        Format(Macrodato) + ';' +/// 60
                                        Format(FacturaGas) + ';' + ///61
                                        Format(FacturaSinDestinatario) + ';' + ///62
                                        Format(PrevioGGEEREDEME) + ';' + ///63
                                        Format(FacturaSimplificada_72_73);  ///64
                        /////ArchSalida.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4);
                        ///OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4);
                        OutTxt += Format(CarriageReturn) + Format(LineFeed);
                            data.AddText(OutTxt);


                        if Rec122.DUA <> '' then begin


                            BASE1 := 0;
                            IVA1 := 0;
                            CUOTA1 := 0;
                            REC1 := 0;
                            CUOTAREC1 := 0;

                            BASE2 := 0;
                            IVA2 := 0;
                            CUOTA2 := 0;
                            REC2 := 0;
                            CUOTAREC2 := 0;

                            BASE3 := 0;
                            IVA3 := 0;
                            CUOTA3 := 0;
                            REC3 := 0;
                            CUOTAREC3 := 0;



                            PurchInvLine.Reset;
                            PurchInvLine.SetRange("Document No.", Rec122."No.");
                            PurchInvLine.SetFilter(PurchInvLine."% IVA Importación", '<>0');
                            if PurchInvLine.FindFirst then begin
                                BASE1 := PurchInvLine."Base IVA aduanas";
                                CUOTA1 := ROUND(BASE1 * PurchInvLine."% IVA Importación" / 100, 0.01);
                                IVA1 := PurchInvLine."% IVA Importación";
                            end;
                            totalfac := BASE1 + CUOTA1;
                            CuotaDeducible := CUOTA1 + CUOTA2 + CUOTA3 + CUOTAREC1 + CUOTAREC2 + CUOTAREC3;

                            OutTxt := 'R;' + ///1
                                            Format(Rec122.DUA) + ';' +
                                            Format(Rec122."Document Date") + ';' +
                                            Format(Rec122."Posting Date") + ';' +
                                            Format(Rec122."Posting Date") + ';' +
                                            CLAVEFAC + ';' +
                                            Format(CopyStr(CompanyInformation.Name, 1, 30)) + ';' +
                                            Format(CompanyInformation."VAT Registration No.") + ';' +
                                            ';' + ///9
                                            Format(Rec122."Pay-to Country/Region Code") + ';' +
                                            '1;' + ///11
                                'F5' + ';' +  ///12
                                'S1' + ';' +  ///13
                                'COMPRAS;' +  ///14
                                Format(totalfac) + ';';
                            OutTxt := Format(BASE1) + ';' + ///16
                                            Format(IVA1) + ';' + ///17
                                            Format(CUOTA1) + ';' + ///18
                                            Format(REC1) + ';' + ///19
                                            Format(CUOTAREC1) + ';' + ///20
                                            Format(BASE2) + ';' + ///21
                                            Format(IVA2) + ';' + ///22
                                            Format(CUOTA2) + ';' + ///23
                                            Format(REC2) + ';' + ///24
                                            Format(CUOTAREC2) + ';' + ///25
                                            Format(BASE3) + ';' + ///26
                                            Format(IVA3) + ';' + ///27
                                            Format(CUOTA3) + ';' + ///28
                                            Format(REC3) + ';' + ///29
                                            Format(CUOTAREC3) + ';' +/// 30
                                            Format(CausaExencion) + ';' +/// 31
                                            Format(BaseImpExenta) + ';' + ///32
                                            Format(BaseImpCoste) + ';';  ///33
                            OutTxt := Format(SituacionCatastral) + ';' + ///34
                                            Format(ReferenciaCatastral) + ';' + ///35
                                            Format(TipoNoSujetoIVA) + ';' + ///36
                                            Format(ImpNoSujetoIVA) + ';' + ///36
                                            Format(ImpTransmisiones) + ';' + ///37
                                            Format(TipoRectificativa) + ';' + ///39
                                            Format(FacturaRectificativa) + ';' +/// 40
                                            Format(FechaRectificativa) + ';' + ///41
                                            Format(BaseRectificada) + ';' + ///42
                                            Format(CuotaRectificada) + ';' + ///43
                                            Format(PrestacionServicios) + ';' +/// 44
                                            Format(FacturaTerceros) + ';' + ///45
                                            Format(EJERCICIO) + ';' + ///46
                                            Format(PERIODO) + ';' + ///47
                                            Format(CuotaDeducible) + ';' +/// 48
                                            Format(BienInversion1) + ';' + ///49
                                            Format(BienInversion2) + ';' + ///50
                                            Format(BienInversion3) + ';';  ///51
                            OutTxt := Format(DeduccionPosterior) + ';' + ///52
                                            Format(EjercicioDeduccion) + ';' + ///53
                                            Format(PeriodoDeduccion) + ';' + ///54
                                            Format(VariosDestinatarios) + ';' + ///55
                                            Format(Autorizacion) + ';' + ///56
                                            Format(ReferenciaExterna) + ';' +/// 57
                                            Format(NombreEntidadSucedida) + ';' + ///58
                                            Format(NIFEntidadSucedida) + ';' + ///59
                                            Format(Macrodato) + ';' + ///60
                                            Format(FacturaGas) + ';' + ///61
                                            Format(FacturaSinDestinatario) + ';' + ///62
                                            Format(PrevioGGEEREDEME) + ';' + ///63
                                            Format(FacturaSimplificada_72_73);  ///64
                            /////ArchSalida.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4);
                            ///OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4);
                            OutTxt += Format(CarriageReturn) + Format(LineFeed);
                            data.AddText(OutTxt);


                        end;


                    end;
                end;
            until Rec122.Next = 0;


        Rec124.Reset;
        Rec124.SetCurrentkey(Rec124."Posting Date");
        Rec124.SetRange(Rec124."Posting Date", DESDEFECHA, HASTAFECHA);
        if desdendocsii <> '' then begin
            Rec124.SetRange("No.", desdendocsii, hastandocsii);
        end;
        if nseriesii <> '' then begin
            Rec124.SetRange("No. Series", nseriesii);
        end;
        if Rec124.FindFirst then
            repeat
                if RecNS.Get(Rec124."No. Series") then begin
                    if RecNS."No SII" = false then begin
                        VENTANA.Update(1, Rec124."No.");
                        Rec124.CalcFields(Rec124."Amount Including VAT");

                        Vendor.Get(Rec124."Buy-from Vendor No.");
                        Nif := Vendor."VAT Registration No.";

                        TipoFactura := 'F1';

                        EJERCICIO := Date2dmy(Rec124."Posting Date", 3);
                        PERIODO := Date2dmy(Rec124."Posting Date", 2);

                        BASE1 := 0;
                        IVA1 := 0;
                        CUOTA1 := 0;
                        REC1 := 0;
                        CUOTAREC1 := 0;

                        BASE2 := 0;
                        IVA2 := 0;
                        CUOTA2 := 0;
                        REC2 := 0;
                        CUOTAREC2 := 0;

                        BASE3 := 0;
                        IVA3 := 0;
                        CUOTA3 := 0;
                        REC3 := 0;
                        CUOTAREC3 := 0;

                        Rec254.Reset;
                        Rec254.SetRange(Rec254."Document No.", Rec124."No.");
                        Rec254.SetRange(Rec254."VAT %", 21);
                        if Rec254.FindSet then
                            repeat
                                BASE1 := BASE1 + Rec254.Base;
                                REC1 := Rec254."EC %";
                                IVA1 := Rec254."VAT %";
                                if REC1 = 0 then begin
                                    CUOTA1 := CUOTA1 + Rec254.Amount;
                                end;
                                if REC1 <> 0 then begin
                                    CUOTAREC1 := CUOTAREC1 + ROUND(BASE1 * REC1 / 100, 0.01);
                                    CUOTA1 := CUOTA1 + Rec254.Amount - ROUND(BASE1 * REC1 / 100, 0.01);
                                end;
                            until Rec254.Next = 0;
                        Rec254.Reset;
                        Rec254.SetRange(Rec254."Document No.", Rec124."No.");
                        Rec254.SetRange(Rec254."VAT %", 10);
                        if Rec254.FindSet then
                            repeat
                                BASE2 := BASE2 + Rec254.Base;
                                REC2 := Rec254."EC %";
                                IVA2 := Rec254."VAT %";
                                if REC2 = 0 then begin
                                    CUOTA2 := CUOTA2 + Rec254.Amount;
                                end;
                                if REC2 <> 0 then begin
                                    CUOTAREC2 := CUOTAREC2 + ROUND(BASE1 * REC2 / 100, 0.01);
                                    CUOTA2 := CUOTA2 + Rec254.Amount - ROUND(BASE2 * REC2 / 100, 0.01);
                                end;
                            until Rec254.Next = 0;


                        if BASE1 <> 0 then begin
                            Rec254.Reset;
                            Rec254.SetRange(Rec254."Document No.", Rec124."No.");
                            Rec254.SetRange(Rec254."VAT %", 0);
                            if Rec254.FindSet then
                                repeat
                                    BASE3 := BASE3 + Rec254.Base;
                                    REC3 := Rec254."EC %";
                                    IVA3 := Rec254."VAT %";
                                    if REC3 = 0 then begin
                                        CUOTA3 := CUOTA3 + Rec254.Amount;
                                    end;
                                    if REC3 <> 0 then begin
                                        CUOTAREC3 := CUOTAREC3 + ROUND(BASE3 * REC3 / 100, 0.01);
                                        CUOTA3 := CUOTA3 + Rec254.Amount - ROUND(BASE3 * REC3 / 100, 0.01);
                                    end;
                                until Rec254.Next = 0;
                            Rec254.Reset;
                            Rec254.SetRange(Rec254."Document No.", Rec124."No.");
                            Rec254.SetRange(Rec254."VAT %", 4);
                            if Rec254.FindSet then
                                repeat
                                    BASE2 := BASE2 + Rec254.Base;
                                    REC2 := Rec254."EC %";
                                    IVA2 := Rec254."VAT %";
                                    if REC2 = 0 then begin
                                        CUOTA2 := CUOTA2 + Rec254.Amount;
                                    end;
                                    if REC2 <> 0 then begin
                                        CUOTAREC2 := CUOTAREC2 + ROUND(BASE1 * REC2 / 100, 0.01);
                                        CUOTA2 := CUOTA2 + Rec254.Amount - ROUND(BASE2 * REC2 / 100, 0.01);
                                    end;
                                until Rec254.Next = 0;

                        end;
                        if BASE1 = 0 then begin
                            Rec254.Reset;
                            Rec254.SetRange(Rec254."Document No.", Rec124."No.");
                            Rec254.SetRange(Rec254."VAT %", 0);
                            if Rec254.FindSet then
                                repeat
                                    BASE1 := BASE1 + Rec254.Base;
                                    REC1 := Rec254."EC %";
                                    IVA1 := Rec254."VAT %";
                                    if REC1 = 0 then begin
                                        CUOTA1 := CUOTA1 + Rec254.Amount;
                                    end;
                                    if REC1 <> 0 then begin
                                        CUOTAREC1 := CUOTAREC1 + ROUND(BASE1 * REC1 / 100, 0.01);
                                        CUOTA1 := CUOTA1 + Rec254.Amount - ROUND(BASE1 * REC1 / 100, 0.01);
                                    end;
                                until Rec254.Next = 0;
                        end;

                        BASE1 := BASE1;
                        CUOTA1 := CUOTA1;
                        CUOTAREC1 := CUOTAREC1;
                        BASE2 := BASE2;
                        CUOTA2 := CUOTA2;
                        CUOTAREC2 := CUOTAREC2;
                        BASE3 := BASE3;
                        CUOTA3 := CUOTA3;
                        CUOTAREC3 := CUOTAREC3;


                        Calificacion := 'S1';
                        CLAVEFAC := '01';

                        CuotaDeducible := CUOTA1 + CUOTA2 + CUOTA3 + CUOTAREC1 + CUOTAREC2 + CUOTAREC3;

                        totalfac := BASE1 + BASE2 + BASE3 + CUOTA1 + CUOTA2 + CUOTA3 + CUOTAREC1 + CUOTAREC2 + CUOTAREC3;




                        OutTxt := 'R;' + ///1
                                       Format(Rec124."No.") + ';' +
                                       Format(Rec124."Posting Date") + ';' +
                                       Format(Rec124."Posting Date") + ';' +
                                       Format(Rec124."Posting Date") + ';' +
                                       CLAVEFAC + ';' +
                                       Format(CopyStr(Rec124."Pay-to Name", 1, 30)) + ';' +
                                       Format(Nif) + ';' +
                                       ';' + ///9
                                       Format(Rec124."Pay-to Country/Region Code") + ';' +
                                       '1;' + ///11
                                       TipoFactura + ';' + ///12
                                       Calificacion + ';' + ///13
                                'COMPRAS;' +  ///14
                                Format(totalfac) + ';';
                        OutTxt := Format(BASE1) + ';' + ///16
                                       Format(IVA1) + ';' +/// 17
                                       Format(CUOTA1) + ';' +/// 18
                                       Format(REC1) + ';' + ///19
                                       Format(CUOTAREC1) + ';' +/// 20
                                       Format(BASE2) + ';' + ///21
                                       Format(IVA2) + ';' + ///22
                                       Format(CUOTA2) + ';' +/// 23
                                       Format(REC2) + ';' + ///24
                                       Format(CUOTAREC2) + ';' + ///25
                                       Format(BASE3) + ';' +/// 26
                                       Format(IVA3) + ';' + ///27
                                       Format(CUOTA3) + ';' + ///28
                                       Format(REC3) + ';' + ///29
                                       Format(CUOTAREC3) + ';' +/// 30
                                       Format(CausaExencion) + ';' +/// 31
                                       Format(BaseImpExenta) + ';' + ///32
                                       Format(BaseImpCoste) + ';';  ///33
                        OutTxt := Format(SituacionCatastral) + ';' + ///34
                                       Format(ReferenciaCatastral) + ';' + ///35
                                       Format(TipoNoSujetoIVA) + ';' +/// 36
                                       Format(ImpNoSujetoIVA) + ';' +/// 36
                                       Format(ImpTransmisiones) + ';' + ///37
                                       Format(TipoRectificativa) + ';' + ///39
                                       Format(FacturaRectificativa) + ';' + ///40
                                       Format(FechaRectificativa) + ';' +/// 41
                                       Format(BaseRectificada) + ';' + ///42
                                       Format(CuotaRectificada) + ';' + ///43
                                       Format(PrestacionServicios) + ';' + ///44
                                       Format(FacturaTerceros) + ';' + ///45
                                       Format(EJERCICIO) + ';' + ///46
                                       Format(PERIODO) + ';' +/// 47
                                       Format(CuotaDeducible) + ';' + ///48
                                       Format(BienInversion1) + ';' + ///49
                                       Format(BienInversion2) + ';' + ///50
                                       Format(BienInversion3) + ';';  ///51
                        OutTxt := Format(DeduccionPosterior) + ';' +/// 52
                                       Format(EjercicioDeduccion) + ';' + ///53
                                       Format(PeriodoDeduccion) + ';' + ///54
                                       Format(VariosDestinatarios) + ';' +/// 55
                                       Format(Autorizacion) + ';' + ///56
                                       Format(ReferenciaExterna) + ';' +/// 57
                                       Format(NombreEntidadSucedida) + ';' +/// 58
                                       Format(NIFEntidadSucedida) + ';' + ///59
                                       Format(Macrodato) + ';' +/// 60
                                       Format(FacturaGas) + ';' + ///61
                                       Format(FacturaSinDestinatario) + ';' + ///62
                                       Format(PrevioGGEEREDEME) + ';' + ///63
                                       Format(FacturaSimplificada_72_73);  ///64
                        /////ArchSalida.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4);
                        ///OutStream.Write(TextoSalida1 + TextoSalida2 + TextoSalida3 + TextoSalida4);
                        OutTxt += Format(CarriageReturn) + Format(LineFeed);
                        data.AddText(OutTxt);


                    end;
                end;

            until Rec124.Next = 0;


        ///ArchSalida.Close;
        VENTANA.Close;

        nomdir := '';
        ADAIA.Reset();
        ADAIA.SetRange(texto, 'AUTOMATICOS SII-CU-50069');
        IF ADAIA.FindSet() THEN begin
            nomdir := ADAIA.Ruta;
        end;

        Data.Write(OutStream);

        TempBlob.CreateInStream(InStream, TextEncoding::Windows);
        FicherosHagen.CrearFichero(nomdir, 'SII_' + Format(textodatat) + '.CSV', InStream);


         


    end;

    var
        tar: Decimal;
        precio1: Code[20];
        entero: Decimal;
        decimal: Decimal;
        precio2: Code[10];
        TARI: Decimal;
        preciototal: Code[11];
        codprod: Code[10];
        RecProd: Record Item;
        CODTAR: Code[10];
        ArchExt: Text[200];
        ArchSalida: File;
        TextoSalida: Text[250];
        VENTANA: Dialog;
        T1: Record "G/L Account";
        Rec112: Record "Sales Invoice Header";
        Rec114: Record "Sales Cr.Memo Header";
        Rec122: Record "Purch. Inv. Header";
        Rec124: Record "Purch. Cr. Memo Hdr.";
        Rec254: Record "VAT Entry";
        DESDEFECHA: Date;
        HASTAFECHA: Date;
        iva: Decimal;
        rec: Decimal;
        RecNS: Record "No. Series";
        TANTOIVA: Decimal;
        TANTOREC: Decimal;
        REC91: Record "User Setup";
        AsciiStr: Text[250];
        AnsiStr: Text[250];
        CharVar: array[32] of Char;
        WindowStyle: Integer;
        WaitForEnd: Boolean;
        ReturnValue: Integer;
        SalesShptHeader: Record "Sales Shipment Header";
        RecClie: Record Customer;
        RecTransp: Record "Shipping Agent";
        PAGINAWEB: Text;
        SalesHeader: Record "Sales Header";
        ShiptoAddress: Record "Ship-to Address";
        Customer: Record Customer;
        Rec123: Record "Purch. Inv. Line";
        PurchInvLine2: Record "Purch. Inv. Line";
        BaseIVAaduanas: Decimal;
        TANTOIVAIM: Decimal;
        CODPROVDUA: Code[10];
        TextoSalida1: Text;
        TextoSalida2: Text;
        TextoSalida3: Text;
        TextoSalida4: Text;
        BASE1: Decimal;
        IVA1: Decimal;
        CUOTA1: Decimal;
        REC1: Decimal;
        CUOTAREC1: Decimal;
        BASE2: Decimal;
        IVA2: Decimal;
        CUOTA2: Decimal;
        REC2: Decimal;
        CUOTAREC2: Decimal;
        BASE3: Decimal;
        IVA3: Decimal;
        CUOTA3: Decimal;
        REC3: Decimal;
        CUOTAREC3: Decimal;
        EJERCICIO: Integer;
        PERIODO: Integer;
        CausaExencion: Text;
        BaseImpExenta: Decimal;
        BaseImpCoste: Decimal;
        SituacionCatastral: Text;
        ReferenciaCatastral: Text;
        TipoNoSujetoIVA: Text;
        ImpNoSujetoIVA: Decimal;
        ImpTransmisiones: Decimal;
        TipoRectificativa: Text;
        FacturaRectificativa: Text;
        FechaRectificativa: Date;
        BaseRectificada: Decimal;
        CuotaRectificada: Decimal;
        PrestacionServicios: Text;
        FacturaTerceros: Text;
        CuotaDeducible: Decimal;
        BienInversion1: Decimal;
        BienInversion2: Decimal;
        BienInversion3: Decimal;
        DeduccionPosterior: Decimal;
        EjercicioDeduccion: Integer;
        PeriodoDeduccion: Integer;
        VariosDestinatarios: Text;
        Autorizacion: Text;
        ReferenciaExterna: Text;
        NombreEntidadSucedida: Text;
        NIFEntidadSucedida: Text;
        Macrodato: Text;
        FacturaGas: Text;
        FacturaSinDestinatario: Text;
        PrevioGGEEREDEME: Text;
        FacturaSimplificada_72_73: Text;
        CLAVEFAC: Code[10];
        Nif: Text;
        TipoFactura: Code[10];
        Calificacion: Code[10];
        Vendor: Record Vendor;
        totalfac: Decimal;
        CountryRegion: Record "Country/Region";
        nfac: Text;
        CompanyInformation: Record "Company Information";
        PurchInvLine: Record "Purch. Inv. Line";
        v: Dialog;
        ANSIASCIIconverter2: Codeunit "ANSI <-> ASCII converter2";
        textonombre: Text;
        datet: DateTime;
        textodatat: Text;
        GeneralLedgerSetup: Record "General Ledger Setup";
        DesdehastaSII: Page "Desde hasta SII";
        "Area": Record "Area";
        desdendocsii: Code[20];
        nseriesii: Code[20];
        hastandocsii: Code[20];
        ADAIA: Record adaia;
        NOMDIR: TEXT;


}

