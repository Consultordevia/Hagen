#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50008 Modifica
{
    // 
    //                                         1234567891234561212312345612
    //                                         1234567890123456789012345678
    //   RecCV."Observación para transporte":='Entregar:'+FORMAT(COPYSTR(D11,1,6)+COPYSTR(D11,9,2))+' - '+FORMAT(COPYSTR(D12,1,6)+COPYSTR(D12,9,2));
    // 
    // EnabledField No.Field NameData TypeLengthDescription
    // Yes12Ship-to CodeCode10
    // Yes13Ship-to NameText50
    // Yes14Ship-to Name 2Text50
    // Yes15Ship-to AddressText50
    // Yes16Ship-to Address 2Text50
    // Yes17Ship-to CityText50
    // Yes18Ship-to ContactText50
    // Yes91Ship-to Post CodeCode20
    // Yes92Ship-to CountyText50
    // Yes93Ship-to Country/Region CodeCode10

    Caption = 'Modifica EXPEDICIONES';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Integer";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(nexpediexp; nexpediexp)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme nº expedicion';

                    trigger OnValidate()
                    begin

                        Rec110.SetCurrentkey(Rec110."Nº expedición");
                        Rec110.SetRange(Rec110."Nº expedición", nexpediexp);
                        if Rec110.FindSet then begin
                            if Rec110."Posting Date" <> Today then begin
                                Message('Cuidado esta espedicion no es de hoy');
                            end;
                            EnvioCodigo := Rec110."Ship-to Code";
                            EnvíoaNombre := Rec110."Ship-to Name";
                            EnvíoaNombre2 := Rec110."Ship-to Name 2";
                            EnvíoaDirección := Rec110."Ship-to Address";
                            EnvíoaDirección2 := Rec110."Ship-to Address 2";
                            EnvíoaPoblación := Rec110."Ship-to City";
                            EnvíoaAtención := Rec110."Ship-to Contact";
                            EnvíoaCP := Rec110."Ship-to Post Code";
                            EnvioaTelefono := Rec110."Envio a-Nº Telefono";
                            EnvíoaProvincia := Rec110."Ship-to County";
                            EnvíoaCdpaísregión := Rec110."Ship-to Country/Region Code";
                            ELPESO := Rec110."Total peso";
                            nbultos := Rec110."Nº bultos";
                            npalets := Rec110."Nº Palets";
                            CODTRAS := Rec110."Shipping Agent Code";
                            CodServicio := Rec110."Shipping Agent Service Code";
                            Observacion := Rec110."Observación para transporte";
                            YourReference := Rec110."Your Reference";
                            CASN := Rec110.ASN;
                            PESOREAL := 0;
                            peso := 0;
                            TOTALPALE := 0;
                            YourReferencetotal := '';
                            Rec1102.Reset;
                            Rec1102.SetCurrentkey(Rec1102."Nº expedición");
                            Rec1102.SetRange(Rec1102."Nº expedición", nexpediexp);
                            if Rec1102.FindSet then
                                repeat
                                    YourReferencetotal := YourReferencetotal + ' ' + Rec1102."Your Reference";
                                    TOTALPALE := TOTALPALE + Rec1102."Nº Palets";
                                    REC1112.Reset;
                                    REC1112.SetRange(REC1112."Document No.", Rec1102."No.");
                                    if REC1112.FindSet then
                                        repeat
                                            peso := peso + REC1112.Quantity * REC1112."Gross Weight";
                                        until REC1112.Next = 0;
                                until Rec1102.Next = 0;
                            /////MESSAGE('%1 %2 %3',Rec110."Grupo clientes",YourReferencetotal,Observacion);
                            Rec110.CalcFields("Grupo clientes");
                            if Rec110."Grupo clientes" = 'G10' then begin
                                Observacion := CopyStr(CopyStr(Observacion, 1, 28) + ' ' + YourReferencetotal, 1, 60);
                            end;
                            if TOTALPALE <> 0 then begin
                                peso := peso + 10 * TOTALPALE;
                            end;
                            PESOREAL := peso;
                            DECRE := 1;
                            if RecTra.Get(Rec110."Shipping Agent Code") then begin
                                if RecTra."Decremento kilo" <> 0 then begin
                                    DECRE := (100 - RecTra."Decremento kilo") / 100;
                                end;
                            end;
                            peso := ROUND(peso * DECRE, 1);
                            if peso < 1 then begin
                                peso := 1;
                            end;
                        end;
                        if not Rec110.FindSet then begin
                            Rec110.Reset;
                            Rec110.SetCurrentkey(Rec110."Nº expedición dropshp");
                            Rec110.SetRange(Rec110."Nº expedición dropshp", nexpediexp);
                            if Rec110.FindSet then begin
                                if Rec110."Posting Date" <> Today then begin
                                    Message('Cuidado esta espedicion no es de hoy');
                                end;
                                EnvíoaNombre := Rec110."Ship-to Name";
                                EnvíoaNombre2 := Rec110."Ship-to Name 2";
                                EnvíoaDirección := Rec110."Ship-to Address";
                                EnvíoaDirección2 := Rec110."Ship-to Address 2";
                                EnvíoaPoblación := Rec110."Ship-to City";
                                EnvíoaAtención := Rec110."Ship-to Contact";
                                EnvíoaCP := Rec110."Ship-to Post Code";
                                EnvíoaProvincia := Rec110."Ship-to County";
                                EnvioaTelefono := Rec110."Envio a-Nº Telefono";
                                EnvíoaCdpaísregión := Rec110."Ship-to Country/Region Code";
                                ELPESO := Rec110."Total peso";
                                nbultos := Rec110."Nº bultos";
                                YourReference := Rec110."Your Reference";
                                CODTRAS := Rec110."Shipping Agent Code";
                                CodServicio := Rec110."Shipping Agent Service Code";
                                Observacion := Rec110."Observación para transporte";
                                CASN := Rec110.ASN;
                                PESOREAL := 0;
                                peso := 0;
                                TOTALPALE := 0;
                                Rec1102.Reset;
                                Rec1102.SetCurrentkey(Rec1102."Nº expedición dropshp");
                                Rec1102.SetRange(Rec1102."Nº expedición dropshp", nexpediexp);
                                if Rec1102.FindSet then
                                    repeat
                                        TOTALPALE := TOTALPALE + Rec1102."Nº Palets";
                                        REC1112.Reset;
                                        REC1112.SetRange(REC1112."Document No.", Rec1102."No.");
                                        if REC1112.FindSet then
                                            repeat
                                                peso := peso + REC1112.Quantity * REC1112."Gross Weight";
                                            until REC1112.Next = 0;
                                    until Rec1102.Next = 0;
                                if TOTALPALE <> 0 then begin
                                    peso := peso + 10 * TOTALPALE;
                                end;
                                PESOREAL := peso;
                                DECRE := 1;
                                if RecTra.Get(Rec110."Shipping Agent Code") then begin
                                    if RecTra."Decremento kilo" <> 0 then begin
                                        DECRE := (100 - RecTra."Decremento kilo") / 100;
                                    end;
                                end;
                                peso := ROUND(peso * DECRE, 1);
                                if peso < 1 then begin
                                    peso := 1;
                                end;
                            end;
                            if not Rec110.FindSet then begin
                                Error('Expedicion %1 NO ENCONTRADO', nexpediexp);
                            end;
                        end;
                        Clear(sumavol);
                        sumavolT := 0;
                        volpalet := 0;
                        PESOVOL := 0;
                    end;
                }
                field(CODTRAS; CODTRAS)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme TRANSPORTISTA';
                    TableRelation = "Shipping Agent";

                    trigger OnValidate()
                    begin


                        if not RecTra.Get(CODTRAS) then begin
                            Error('No existe transportista.');
                        end;
                    end;
                }
                field(nbultos; nbultos)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme nº bultos';
                }
                field(npalets; npalets)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme nº palets';
                }
                field(peso; peso)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme PESO';
                }
                field(sumavolT; sumavolT)
                {
                    ApplicationArea = Basic;
                    Caption = 'SUMA VOLUMEN';
                    Editable = false;
                }
                field(Observacion; Observacion)
                {
                    ApplicationArea = Basic;
                    Caption = 'Observacion para transporte';
                }
                field(ASN; CASN)
                {
                    ApplicationArea = Basic;
                    Caption = 'ASN';

                    trigger OnValidate()
                    begin



                        Rec110.SetCurrentkey(Rec110."Nº expedición");
                        Rec110.SetRange(Rec110."Nº expedición", nexpediexp);
                        if Rec110.FindSet then
                            repeat
                                Rec110.ASN := CASN;
                                Rec110."Your Reference" := YourReference;
                                Rec110.Modify;
                            until Rec110.Next = 0;
                    end;
                }
                field(CodServicio; CodServicio)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme Cod. Servicio';
                    TableRelation = "Shipping Agent Services".Code;
                }
            }
            group(Control1000000023)
            {
                field(tipopalet; tipopalet)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme tipo palet 1';

                    trigger OnValidate()
                    begin


                        RecMtU.Reset;
                        RecMtU.SetRange(RecMtU.Tabla, 29);
                        RecMtU.SetRange(RecMtU.Código, tipopalet);
                        if not RecMtU.FindSet then begin
                            Error('Este tipo palet no existe');
                        end;
                        if RecMtU.FindSet then begin
                            if RecMtU.Largo <> 0 then begin
                                eslargo := RecMtU.Largo;
                            end;
                            if RecMtU.Ancho <> 0 then begin
                                esancho := RecMtU.Ancho;
                            end;
                            if RecMtU.Alto <> 0 then begin
                                esalto := RecMtU.Alto;
                            end;
                        end;

                    end;
                }
                field(eslargo; eslargo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme largo 1';
                    Editable = false;
                }
                field(esancho; esancho)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme ancho 1';
                    Editable = false;
                }
                field(esalto; esalto)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme alto 1';

                    trigger OnValidate()
                    begin

                        sumavol[1] := (eslargo * esancho * esalto / 1000000);
                        CALCULATOTAL;

                    end;
                }
                field(tipopalet2; tipopalet2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme tipo palets 2';

                    trigger OnValidate()
                    begin

                        RecMtU.Reset;
                        RecMtU.SetRange(RecMtU.Tabla, 29);
                        RecMtU.SetRange(RecMtU.Código, tipopalet2);
                        if not RecMtU.FindSet then begin
                            Error('Este tipo palet no existe');
                        end;
                        if RecMtU.FindSet then begin
                            if RecMtU.Largo <> 0 then begin
                                eslargo2 := RecMtU.Largo;
                            end;
                            if RecMtU.Ancho <> 0 then begin
                                esancho2 := RecMtU.Ancho;
                            end;
                            if RecMtU.Alto <> 0 then begin
                                esalto2 := RecMtU.Alto;
                            end;
                        end;

                    end;
                }
                field(eslargo2; eslargo2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme largo 2';
                    Editable = false;
                }
                field(esancho2; esancho2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme ancho 2';
                    Editable = false;
                }
                field(esalto2; esalto2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme alto 2';

                    trigger OnValidate()
                    begin

                        sumavol[2] := (eslargo2 * esancho2 * esalto2 / 1000000);
                        CALCULATOTAL;
                    end;
                }
                field(tipopalet3; tipopalet3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme tipo palets 3';

                    trigger OnValidate()
                    begin

                        RecMtU.Reset;
                        RecMtU.SetRange(RecMtU.Tabla, 29);
                        RecMtU.SetRange(RecMtU.Código, tipopalet3);
                        if not RecMtU.FindSet then begin
                            Error('Este tipo palet no existe');
                        end;
                        if RecMtU.FindSet then begin
                            if RecMtU.Largo <> 0 then begin
                                eslargo3 := RecMtU.Largo;
                            end;
                            if RecMtU.Ancho <> 0 then begin
                                esancho3 := RecMtU.Ancho;
                            end;
                            if RecMtU.Alto <> 0 then begin
                                esalto3 := RecMtU.Alto;
                            end;
                        end;

                    end;
                }
                field(eslargo3; eslargo3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme largo 3';
                    Editable = false;
                }
                field(esancho3; esancho3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme ancho 3';
                    Editable = false;
                }
                field(esalto3; esalto3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme alto 3';

                    trigger OnValidate()
                    begin

                        sumavol[3] := (eslargo3 * esancho3 * esalto3 / 1000000);
                        CALCULATOTAL;
                    end;
                }
                field(tipopalet4; tipopalet4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme tipo palets 3';

                    trigger OnValidate()
                    begin

                        RecMtU.Reset;
                        RecMtU.SetRange(RecMtU.Tabla, 29);
                        RecMtU.SetRange(RecMtU.Código, tipopalet4);
                        if not RecMtU.FindSet then begin
                            Error('Este tipo palet no existe');
                        end;
                        if RecMtU.FindSet then begin
                            if RecMtU.Largo <> 0 then begin
                                eslargo4 := RecMtU.Largo;
                            end;
                            if RecMtU.Ancho <> 0 then begin
                                esancho4 := RecMtU.Ancho;
                            end;
                            if RecMtU.Alto <> 0 then begin
                                esalto4 := RecMtU.Alto;
                            end;
                        end;

                    end;
                }
                field(eslargo4; eslargo4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme largo 3';
                    Editable = false;
                }
                field(esancho4; esancho4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme ancho 3';
                    Editable = false;
                }
                field(esalto4; esalto4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme alto 3';

                    trigger OnValidate()
                    begin

                        sumavol[4] := (eslargo4 * esancho4 * esalto4 / 1000000);
                        CALCULATOTAL;
                    end;
                }
                field(tipopalet5; tipopalet5)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme tipo palets 3';

                    trigger OnValidate()
                    begin

                        RecMtU.Reset;
                        RecMtU.SetRange(RecMtU.Tabla, 29);
                        RecMtU.SetRange(RecMtU.Código, tipopalet5);
                        if not RecMtU.FindSet then begin
                            Error('Este tipo palet no existe');
                        end;
                        if RecMtU.FindSet then begin
                            if RecMtU.Largo <> 0 then begin
                                eslargo5 := RecMtU.Largo;
                            end;
                            if RecMtU.Ancho <> 0 then begin
                                esancho5 := RecMtU.Ancho;
                            end;
                            if RecMtU.Alto <> 0 then begin
                                esalto5 := RecMtU.Alto;
                            end;
                        end;

                    end;
                }
                field(eslargo5; eslargo5)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme largo 3';
                    Editable = false;
                }
                field(esancho5; esancho5)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme ancho 3';
                    Editable = false;
                }
                field(esalto5; esalto5)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme alto 3';

                    trigger OnValidate()
                    begin

                        sumavol[5] := (eslargo5 * esancho5 * esalto5 / 1000000);
                        CALCULATOTAL;
                    end;
                }
                field(tipopalet6; tipopalet6)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme tipo palets 3';

                    trigger OnValidate()
                    begin

                        RecMtU.Reset;
                        RecMtU.SetRange(RecMtU.Tabla, 29);
                        RecMtU.SetRange(RecMtU.Código, tipopalet6);
                        if not RecMtU.FindSet then begin
                            Error('Este tipo palet no existe');
                        end;
                        if RecMtU.FindSet then begin
                            if RecMtU.Largo <> 0 then begin
                                eslargo6 := RecMtU.Largo;
                            end;
                            if RecMtU.Ancho <> 0 then begin
                                esancho6 := RecMtU.Ancho;
                            end;
                            if RecMtU.Alto <> 0 then begin
                                esalto6 := RecMtU.Alto;
                            end;
                        end;

                    end;
                }
                field(eslargo6; eslargo6)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme largo 3';
                    Editable = false;
                }
                field(esancho6; esancho6)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme ancho 3';
                    Editable = false;
                }
                field(esalto6; esalto6)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme alto 3';

                    trigger OnValidate()
                    begin

                        sumavol[6] := (eslargo6 * esancho6 * esalto6 / 1000000);
                        CALCULATOTAL;
                    end;
                }
                field(tipopalet7; tipopalet7)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme tipo palets 3';

                    trigger OnValidate()
                    begin

                        RecMtU.Reset;
                        RecMtU.SetRange(RecMtU.Tabla, 29);
                        RecMtU.SetRange(RecMtU.Código, tipopalet7);
                        if not RecMtU.FindSet then begin
                            Error('Este tipo palet no existe');
                        end;
                        if RecMtU.FindSet then begin
                            if RecMtU.Largo <> 0 then begin
                                eslargo7 := RecMtU.Largo;
                            end;
                            if RecMtU.Ancho <> 0 then begin
                                esancho7 := RecMtU.Ancho;
                            end;
                            if RecMtU.Alto <> 0 then begin
                                esalto7 := RecMtU.Alto;
                            end;
                        end;

                    end;
                }
                field(eslargo7; eslargo7)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme largo 3';
                    Editable = false;
                }
                field(esancho7; esancho7)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme ancho 3';
                    Editable = false;
                }
                field(esalto7; esalto7)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme alto 3';

                    trigger OnValidate()
                    begin

                        sumavol[7] := (eslargo7 * esancho7 * esalto7 / 1000000);
                        CALCULATOTAL;
                    end;
                }
                field(tipopalet8; tipopalet8)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme tipo palets 3';

                    trigger OnValidate()
                    begin

                        RecMtU.Reset;
                        RecMtU.SetRange(RecMtU.Tabla, 29);
                        RecMtU.SetRange(RecMtU.Código, tipopalet8);
                        if not RecMtU.FindSet then begin
                            Error('Este tipo palet no existe');
                        end;
                        if RecMtU.FindSet then begin
                            if RecMtU.Largo <> 0 then begin
                                eslargo8 := RecMtU.Largo;
                            end;
                            if RecMtU.Ancho <> 0 then begin
                                esancho8 := RecMtU.Ancho;
                            end;
                            if RecMtU.Alto <> 0 then begin
                                esalto8 := RecMtU.Alto;
                            end;
                        end;

                    end;
                }
                field(eslargo8; eslargo8)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme largo 3';
                    Editable = false;
                }
                field(esancho8; esancho8)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme ancho 3';
                    Editable = false;
                }
                field(esalto8; esalto8)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme alto 3';

                    trigger OnValidate()
                    begin

                        sumavol[8] := (eslargo8 * esancho8 * esalto8 / 1000000);
                        CALCULATOTAL;
                    end;
                }
                field(tipopalet9; tipopalet9)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme tipo palets 3';

                    trigger OnValidate()
                    begin

                        RecMtU.Reset;
                        RecMtU.SetRange(RecMtU.Tabla, 29);
                        RecMtU.SetRange(RecMtU.Código, tipopalet9);
                        if not RecMtU.FindSet then begin
                            Error('Este tipo palet no existe');
                        end;
                        if RecMtU.FindSet then begin
                            if RecMtU.Largo <> 0 then begin
                                eslargo9 := RecMtU.Largo;
                            end;
                            if RecMtU.Ancho <> 0 then begin
                                esancho9 := RecMtU.Ancho;
                            end;
                            if RecMtU.Alto <> 0 then begin
                                esalto9 := RecMtU.Alto;
                            end;
                        end;

                    end;
                }
                field(eslargo9; eslargo9)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme largo 3';
                    Editable = false;
                }
                field(esancho9; esancho9)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme ancho 3';
                    Editable = false;
                }
                field(esalto9; esalto9)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme alto 3';

                    trigger OnValidate()
                    begin

                        sumavol[9] := (eslargo9 * esancho9 * esalto9 / 1000000);
                        CALCULATOTAL;
                    end;
                }
                field(tipopalet10; tipopalet10)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme tipo palets 3';

                    trigger OnValidate()
                    begin

                        RecMtU.Reset;
                        RecMtU.SetRange(RecMtU.Tabla, 29);
                        RecMtU.SetRange(RecMtU.Código, tipopalet10);
                        if not RecMtU.FindSet then begin
                            Error('Este tipo palet no existe');
                        end;
                        if RecMtU.FindSet then begin
                            if RecMtU.Largo <> 0 then begin
                                eslargo10 := RecMtU.Largo;
                            end;
                            if RecMtU.Ancho <> 0 then begin
                                esancho10 := RecMtU.Ancho;
                            end;
                            if RecMtU.Alto <> 0 then begin
                                esalto10 := RecMtU.Alto;
                            end;
                        end;

                    end;
                }
                field(eslargo10; eslargo10)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme largo 3';
                    Editable = false;
                }
                field(esancho10; esancho10)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme ancho 3';
                    Editable = false;
                }
                field(esalto10; esalto10)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deme alto 3';

                    trigger OnValidate()
                    begin

                        sumavol[10] := (eslargo10 * esancho10 * esalto10 / 1000000);
                        CALCULATOTAL;
                    end;
                }
            }
            group("Envio a ")
            {
                Caption = 'Envio a ';
                field("Envio a codigo"; EnvioCodigo)
                {
                    ApplicationArea = Basic;

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        ShiptoAddress.Reset;
                        ShiptoAddress.SetRange(ShiptoAddress."Customer No.", Rec110."Sell-to Customer No.");
                        if ShiptoAddress.FindFirst then begin
                            Clear(ShiptoAddressList);
                            ShiptoAddressList.SetTableview(ShiptoAddress);
                            ShiptoAddressList.RunModal;
                            ShiptoAddressList.GetRecord(ShiptoAddress);
                            EnvioCodigo := ShiptoAddress.Code;
                            EnvíoaNombre := ShiptoAddress.Name;
                            EnvíoaNombre2 := ShiptoAddress."Name 2";
                            EnvíoaDirección := ShiptoAddress.Address;
                            EnvíoaDirección2 := ShiptoAddress."Address 2";
                            EnvíoaPoblación := ShiptoAddress.City;
                            EnvíoaAtención := ShiptoAddress.Contact;
                            EnvíoaCP := ShiptoAddress."Post Code";
                            EnvíoaProvincia := ShiptoAddress.County;
                            EnvíoaCdpaísregión := ShiptoAddress."Country/Region Code";
                            EnvioaTelefono := ShiptoAddress."Phone No.";
                        end;
                    end;
                }
                field("EnvíoaNombre"; EnvíoaNombre)
                {
                    ApplicationArea = Basic;
                    Caption = 'EnvíoaNombre';

                    trigger OnValidate()
                    begin

                        ModificaDirEnvio;
                    end;
                }
                field("EnvíoaNombre2"; EnvíoaNombre2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Envío a-Nombre 2';

                    trigger OnValidate()
                    begin

                        ModificaDirEnvio;
                    end;
                }
                field("EnvíoaDirección"; EnvíoaDirección)
                {
                    ApplicationArea = Basic;
                    Caption = 'Envío a-Dirección';

                    trigger OnValidate()
                    begin

                        ModificaDirEnvio;
                    end;
                }
                field("EnvíoaDirección2"; EnvíoaDirección2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Envío a-Dirección 2';

                    trigger OnValidate()
                    begin
                        ModificaDirEnvio;
                    end;
                }
                field("EnvíoaPoblación"; EnvíoaPoblación)
                {
                    ApplicationArea = Basic;
                    Caption = 'Envío a-Población';

                    trigger OnValidate()
                    begin
                        ModificaDirEnvio;
                    end;
                }
                field("EnvíoaAtención"; EnvíoaAtención)
                {
                    ApplicationArea = Basic;
                    Caption = 'Envío a-Atención';

                    trigger OnValidate()
                    begin
                        ModificaDirEnvio;
                    end;
                }
                field("EnvíoaCP"; EnvíoaCP)
                {
                    ApplicationArea = Basic;
                    Caption = 'Envío a-C.P.';

                    trigger OnValidate()
                    begin

                        ModificaDirEnvio;
                    end;
                }
                field("EnvíoaProvincia"; EnvíoaProvincia)
                {
                    ApplicationArea = Basic;
                    Caption = 'Envío a-Provincia';

                    trigger OnValidate()
                    begin
                        ModificaDirEnvio;
                    end;
                }
                field("EnvíoaCdpaísregión"; EnvíoaCdpaísregión)
                {
                    ApplicationArea = Basic;
                    Caption = 'Envío a-Cód. país/región';

                    trigger OnValidate()
                    begin
                        ModificaDirEnvio;
                    end;
                }
                field("Envio a Telefono"; EnvioaTelefono)
                {
                    ApplicationArea = Basic;
                    Caption = 'Envio a Telefono';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(Confirmar)
                {
                    ApplicationArea = Basic;
                    Caption = 'Confirmar';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin


                        MODIFICA;
                    end;
                }
            }
        }
    }

    var
        Rec37: Record "Sales Line";
        TLinea: Decimal;
        RecCV: Record "Sales Header";
        TOTALPedido: Decimal;
        RecCusto: Record Customer;
        RecLS: Record "No. Series Line";
        NPEDIDO: Code[20];
        RecCV2: Record "Sales Header";
        RecCV3: Record "Sales Header";
        RecCV33: Record "Sales Header";
        CODPED: Code[20];
        CUADAIAI: Codeunit "Importacion ADAIA";
        ACTIVO: Boolean;
        CUADAIA: Codeunit "Automaticos Cartas";
        Commenta: Boolean;
        RecLV: Record "Sales Line";
        RecCV4: Record "Sales Header";
        RecCV5: Record "Sales Header";
        npedidos: Integer;
        PESOREAL: Decimal;
        peso: Decimal;
        Rec36: Record "Sales Header";
        Rec362: Record "Sales Header";
        RecAcc: Record "Comisiones por grupo";
        INCIDENCIASPDTES: Integer;
        RecCVP: Record "Sales & Receivables Setup";
        CU: Codeunit "Automaticos Cartas";
        RecTA: Record "Extended Text Header";
        RepEti: Report "ETI. PORTUGES";
        X: Integer;
        CUENTAPT: Integer;
        CUENTAES: Integer;
        RecMT: Record Multitabla;
        RecItem: Record Item;
        CUENTAECI: Integer;
        REC2: Record "Sales Header";
        REC3: Record "Sales Header";
        RecpEtiEci: Report "Etiqueta ECI NUEVA";
        CU_Exporta: Codeunit "Automaticos Cartas";
        ventana: Dialog;
        nexpediexp: Code[20];
        nbultos: Integer;
        Rec110: Record "Sales Shipment Header";
        Rec1102: Record "Sales Shipment Header";
        CU50001: Codeunit "Automaticos Cartas";
        ELPESO: Decimal;
        REC1112: Record "Sales Shipment Line";
        TOTALPALE: Decimal;
        DECRE: Decimal;
        RecTra: Record "Shipping Agent";
        CODTRAS: Code[20];
        npalets: Integer;
        Rec36Pepe: Record "Sales Header";
        RepETAD: Report "ETI. envio";
        RecMtU: Record Multitabla;
        RepDropShi: Report "Etiqueta DROPSHIPPING";
        tipopalet: Code[20];
        tipopalet2: Code[20];
        tipopalet3: Code[20];
        XP: Integer;
        eslargo: Integer;
        esancho: Integer;
        esalto: Integer;
        eslargo2: Integer;
        esancho2: Integer;
        esalto2: Integer;
        eslargo3: Integer;
        esancho3: Integer;
        esalto3: Integer;
        sumavol: array[10] of Decimal;
        sumavolT: Decimal;
        volpalet: Decimal;
        PESOVOL: Decimal;
        RecTrans: Record "Shipping Agent";
        CUENTAEScana: Integer;
        RecLV5: Record "Sales Line";
        nlineas: Decimal;
        nkilos: Decimal;
        RecLV3: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
        contadordeagrup: Code[20];
        RecCV22: Record "Sales Header";
        EtiAgrppeque: Report "ETI. envio agrupado";
        RecCV222: Record "Sales Header";
        RepEtieci: Report "ETI. ECI";
        eslargo4: Integer;
        esancho4: Integer;
        esalto4: Integer;
        tipopalet4: Code[20];
        eslargo5: Integer;
        esancho5: Integer;
        esalto5: Integer;
        tipopalet5: Code[20];
        eslargo6: Integer;
        esancho6: Integer;
        esalto6: Integer;
        tipopalet6: Code[20];
        eslargo7: Integer;
        esancho7: Integer;
        esalto7: Integer;
        tipopalet7: Code[20];
        eslargo8: Integer;
        esancho8: Integer;
        esalto8: Integer;
        tipopalet8: Code[20];
        eslargo9: Integer;
        esancho9: Integer;
        esalto9: Integer;
        tipopalet9: Code[20];
        eslargo10: Integer;
        esancho10: Integer;
        esalto10: Integer;
        tipopalet10: Code[20];
        Observacion: Text[60];
        SalesShipmentHeader: Record "Sales Shipment Header";
        RecTransp: Record "Shipping Agent";
        Rec1103: Record "Sales Shipment Header";
        "EnvíoaNombre": Text;
        "EnvíoaNombre2": Text;
        "EnvíoaDirección": Text;
        "EnvíoaDirección2": Text;
        "EnvíoaPoblación": Text;
        "EnvíoaAtención": Text;
        EnvioaTelefono: Text;
        "EnvíoaCP": Text;
        "EnvíoaProvincia": Text;
        "EnvíoaCdpaísregión": Text;
        CASN: Text[40];
        EnvioCodigo: Code[20];
        ShiptoAddress: Record "Ship-to Address";
        ShiptoAddressList: Page "Ship-to Address List";
        YourReference: Text;
        YourReferencetotal: Text;
        CodServicio: Code[20];
        ShippingAgentServices: Record "Shipping Agent Services";
    /////-OKAlbaranElmosca: Report UnknownReport50917;


    procedure MODIFICA()
    begin


        Rec110.Reset;
        Rec110.SetCurrentkey(Rec110."Nº expedición");
        Rec110.SetRange(Rec110."Nº expedición", nexpediexp);
        if Rec110.FindSet then
            repeat
                if Rec110.Dropshipping = false then begin
                    if Rec110."Albaran sin detalle" = true then begin
                        if Rec110."No. Printed" = 0 then begin
                            Error('El albaran %1 no esta impreso.', Rec110."No.");
                        end;
                    end;
                end;
            until Rec110.Next = 0;



        Rec110.Reset;
        Rec110.SetCurrentkey(Rec110."Nº expedición");
        Rec110.SetRange(Rec110."Nº expedición", nexpediexp);
        if Rec110.FindSet then
            repeat
                Rec110."Nº bultos" := 0;
                Rec110."Nº Palets" := 0;
                Rec110.Modify;
            until Rec110.Next = 0;

        Rec110.Reset;
        Rec110.SetCurrentkey(Rec110."Nº expedición dropshp");
        Rec110.SetRange(Rec110."Nº expedición dropshp", nexpediexp);
        if Rec110.FindSet then
            repeat
                Rec110."Nº bultos" := 0;
                Rec110."Nº Palets" := 0;
                Rec110.Modify;
            until Rec110.Next = 0;





        Rec110.Reset;
        Rec110.SetCurrentkey(Rec110."Nº expedición");
        Rec110.SetRange(Rec110."Nº expedición", nexpediexp);
        if Rec110.FindSet then begin
            Rec110."Nº bultos" := nbultos;
            Rec110."Nº Palets" := npalets;
            Rec110."Total bultos" := Rec110."Nº bultos" + Rec110."Nº Palets";
            Rec110."Total peso" := peso;
            Rec110."Shipping Agent Code" := CODTRAS;
            Rec110."Shipping Agent Service Code" := CodServicio;
            Rec110.Volumen := sumavolT;
            Rec110."Observación para transporte" := Observacion;
            Rec110.ASN := CASN;
            Rec110.Modify;
            if RecTra.Get(CODTRAS) then begin
                if RecTra."Fichero estandar" = true then begin
                    Rec1102.Reset;
                    Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                    if Rec1102.FindSet then begin
                        CU50001.ETISTD(Rec1102);
                    end;
                end;
                if RecTra."Fichero estandar" = false then begin
                    ///IF Rec110."Shipping Agent Code"='DHL' THEN BEGIN
                    ///Rec1102.RESET;
                    ///Rec1102.SETRANGE(Rec1102."No.",Rec110."No.");
                    ///IF Rec1102.FINDSET THEN BEGIN
                    ///CU50001.EtiDHL2(Rec1102);
                    ///END;
                    ///END;
                    if Rec110."Shipping Agent Code" = 'TNT' then begin
                        Rec1102.Reset;
                        Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                        if Rec1102.FindSet then begin
                            CU50001.EtiTNT2(Rec1102);
                        end;
                    end;
                    if Rec110."Shipping Agent Code" = 'CRON' then begin
                        Rec1102.Reset;
                        Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                        if Rec1102.FindSet then begin
                            CU50001.Eticrono2(Rec1102);
                        end;
                    end;
                    if Rec110."Shipping Agent Code" = 'SEUR' then begin
                        Rec1102.Reset;
                        Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                        if Rec1102.FindSet then begin
                            CU50001.EtiSEUR(Rec1102);
                        end;
                    end;
                    if Rec110."Shipping Agent Code" = 'TIPSA' then begin
                        Rec1102.Reset;
                        Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                        if Rec1102.FindSet then begin
                            CU50001.EtiTIPSA2(Rec1102);
                        end;
                    end;
                    if Rec110."Shipping Agent Code" = 'CORR' then begin
                        Rec1102.Reset;
                        Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                        if Rec1102.FindSet then begin
                            CU50001.EtiTCORR2(Rec1102);
                        end;
                    end;
                end;
            end;
        end;

        Rec110.Reset;
        Rec110.SetCurrentkey(Rec110."Nº expedición dropshp");
        Rec110.SetRange(Rec110."Nº expedición dropshp", nexpediexp);
        if Rec110.FindSet then begin
            Rec110."Nº bultos" := nbultos;
            Rec110."Nº Palets" := npalets;
            Rec110."Total bultos" := Rec110."Nº bultos" + Rec110."Nº Palets";
            Rec110."Total peso" := peso;
            Rec110."Shipping Agent Code" := CODTRAS;
            Rec110."Shipping Agent Service Code" := CodServicio;
            Rec110.Volumen := sumavolT;
            Rec110."Observación para transporte" := Observacion;
            Rec110.ASN := CASN;
            Rec110.Modify;
            if RecTra.Get(CODTRAS) then begin
                if RecTra."Fichero estandar" = true then begin
                    Rec1102.Reset;
                    Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                    if Rec1102.FindSet then begin
                        CU50001.ETISTD(Rec1102);
                    end;
                end;
                if RecTra."Fichero estandar" = false then begin
                    if Rec110."Shipping Agent Code" = 'DHL' then begin
                        Rec1102.Reset;
                        Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                        if Rec1102.FindSet then begin
                            CU50001.EtiDHL2(Rec1102);
                        end;
                    end;
                    if Rec110."Shipping Agent Code" = 'TNT' then begin
                        Rec1102.Reset;
                        Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                        if Rec1102.FindSet then begin
                            CU50001.EtiTNT2(Rec1102);
                        end;
                    end;
                    if Rec110."Shipping Agent Code" = 'CRON' then begin
                        Rec1102.Reset;
                        Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                        if Rec1102.FindSet then begin
                            CU50001.Eticrono2(Rec1102);
                        end;
                    end;
                    if Rec110."Shipping Agent Code" = 'SEUR' then begin
                        Rec1102.Reset;
                        Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                        if Rec1102.FindSet then begin
                            CU50001.EtiSEUR(Rec1102);
                        end;
                    end;
                    if Rec110."Shipping Agent Code" = 'TIPSA' then begin
                        Rec1102.Reset;
                        Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                        if Rec1102.FindSet then begin
                            CU50001.EtiTIPSA2(Rec1102);
                        end;
                    end;
                    if Rec110."Shipping Agent Code" = 'CORR' then begin
                        Rec1102.Reset;
                        Rec1102.SetRange(Rec1102."No.", Rec110."No.");
                        if Rec1102.FindSet then begin
                            CU50001.EtiTCORR2(Rec1102);
                        end;
                    end;
                end;
            end;
        end;




        Commit;

        Rec110.Reset;
        Rec110.SetCurrentkey(Rec110."Nº expedición");
        Rec110.SetRange(Rec110."Nº expedición", nexpediexp);
        if Rec110.FindFirst then begin
            if RecTransp.Get(CODTRAS) then begin
                if RecTransp."Carta Tamaño A4" then begin
                    Report.Run(50917, false, false, Rec110);
                    Report.Run(50917, false, false, Rec110);
                end;
            end;
        end;

        Rec110.Reset;
        Rec110.SetCurrentkey(Rec110."Nº expedición dropshp");
        Rec110.SetRange(Rec110."Nº expedición dropshp", nexpediexp);
        if Rec110.FindFirst then begin
            if RecTransp.Get(CODTRAS) then begin
                if RecTransp."Carta Tamaño A4" then begin
                    Report.Run(50917, false, false, Rec110);
                    Report.Run(50917, false, false, Rec110);
                end;
            end;
        end;

        ETIQUETAS;


        Message('Expedicion %1 modificada a %2 bultos y %3 palets', nexpediexp, nbultos, npalets);

        ClearAll;
        nexpediexp := '';
        nbultos := 0;
        npalets := 0;
        peso := 0;

        /*
        IF npalets>0 THEN BEGIN
        REPEAT
             XP:=XP+1;
             ventana.OPEN('Deme tipo palets #1############');
             ventana.INPUT(1,tipopalet);
             ventana.CLOSE;
             RecMtU.RESET;
             RecMtU.SETRANGE(RecMtU.Tabla,29);
             RecMtU.SETRANGE(RecMtU.Código,tipopalet);
             IF NOT RecMtU.FINDSET THEN BEGIN
                  ERROR('Este tipo palet no existe');
             END;
             IF RecMtU.FINDSET THEN BEGIN
                  IF RecMtU.Largo<>0 THEN BEGIN
                       eslargo:=RecMtU.Largo;
                  END;
                  IF RecMtU.Ancho<>0 THEN BEGIN
                       esancho:=RecMtU.Ancho;
                  END;
                  IF RecMtU.Alto<>0 THEN BEGIN
                       esalto:=RecMtU.Alto;
                  END;
                  IF RecMtU.Largo=0 THEN BEGIN
                       ventana.OPEN('Deme largo #1############');
                       ventana.INPUT(1,eslargo);
                       ventana.CLOSE;
                  END;
                  IF RecMtU.Ancho=0 THEN BEGIN
                       ventana.OPEN('Deme ancho #1############');
                       ventana.INPUT(1,esancho);
                       ventana.CLOSE;
                  END;
                  IF RecMtU.Alto=0 THEN BEGIN
                       ventana.OPEN('Deme alto #1############');
                       ventana.INPUT(1,esalto);
                       ventana.CLOSE;
                  END;
                  sumavol:=sumavol+(eslargo*esancho*esalto/1000000)
             END;
        UNTIL XP=npalets;
        
        
        */

    end;

    local procedure CALCULATOTAL()
    begin


        sumavolT := sumavol[1] + sumavol[2] + sumavol[3] + sumavol[4] +
                  sumavol[5] + sumavol[6] + sumavol[7] + sumavol[8] +
                  sumavol[9] + sumavol[10];


        RecTrans.Get(CODTRAS);
        PESOVOL := ROUND(sumavolT * RecTrans."Conversion Volumen/kilos", 0.01);
        if PESOVOL > peso then begin
            peso := PESOVOL;
        end;
    end;

    local procedure ETIQUETAS()
    begin



        if nexpediexp <> '' then begin

            SalesShipmentHeader.Reset;
            SalesShipmentHeader.SetRange("Nº expedición", nexpediexp);
            if SalesShipmentHeader.FindSet then
                repeat
                    if RecTransp.Get(SalesShipmentHeader."Shipping Agent Code") then begin
                        if RecTransp."Sacar etiqueta envio GRA" then begin
                            Rec1102.Reset;
                            Rec1102.SetRange(Rec1102."No.", SalesShipmentHeader."No.");
                            if Rec1102.FindFirst then begin
                                Report.RunModal(50039, false, false, Rec1102);
                            end;
                        end;
                    end;
                until SalesShipmentHeader.Next = 0;


            SalesShipmentHeader.Reset;
            SalesShipmentHeader.SetRange("Nº expedición", nexpediexp);
            if SalesShipmentHeader.FindSet then
                repeat
                    if RecTransp.Get(SalesShipmentHeader."Shipping Agent Code") then begin
                        if RecTransp."Sacar etiqueta envio PEQ" then begin
                            Rec1102.Reset;
                            Rec1102.SetRange(Rec1102."No.", SalesShipmentHeader."No.");
                            if Rec1102.FindFirst then begin
                                Report.RunModal(50033, false, false, Rec1102);
                            end;
                        end;
                    end;
                until SalesShipmentHeader.Next = 0;


            SalesShipmentHeader.Reset;
            SalesShipmentHeader.SetRange("Nº expedición dropshp", nexpediexp);
            if SalesShipmentHeader.FindSet then
                repeat
                    if RecTransp.Get(SalesShipmentHeader."Shipping Agent Code") then begin
                        if RecTransp."Sacar etiqueta envio GRA" then begin
                            Rec1102.Reset;
                            Rec1102.SetRange(Rec1102."No.", SalesShipmentHeader."No.");
                            if Rec1102.FindFirst then begin
                                Report.RunModal(50039, false, false, Rec1102);
                            end;
                        end;
                    end;
                until SalesShipmentHeader.Next = 0;


            SalesShipmentHeader.Reset;
            SalesShipmentHeader.SetRange("Nº expedición dropshp", nexpediexp);
            if SalesShipmentHeader.FindSet then
                repeat
                    if RecTransp.Get(SalesShipmentHeader."Shipping Agent Code") then begin
                        if RecTransp."Sacar etiqueta envio PEQ" then begin
                            Rec1102.Reset;
                            Rec1102.SetRange(Rec1102."No.", SalesShipmentHeader."No.");
                            if Rec1102.FindFirst then begin
                                Report.RunModal(50033, false, false, Rec1102);
                            end;
                        end;
                    end;
                until SalesShipmentHeader.Next = 0;




        end;
    end;

    local procedure ModificaDirEnvio()
    begin




        Rec110.SetCurrentkey(Rec110."Nº expedición");
        Rec110.SetRange(Rec110."Nº expedición", nexpediexp);
        if Rec110.FindSet then
            repeat
                Rec110."Ship-to Code" := EnvioCodigo;
                Rec110."Ship-to Name" := EnvíoaNombre;
                Rec110."Ship-to Name 2" := EnvíoaNombre2;
                Rec110."Ship-to Address" := EnvíoaDirección;
                Rec110."Ship-to Address 2" := EnvíoaDirección2;
                Rec110."Ship-to City" := EnvíoaPoblación;
                Rec110."Ship-to Contact" := EnvíoaAtención;
                Rec110."Ship-to Post Code" := EnvíoaCP;
                Rec110."Ship-to County" := EnvíoaProvincia;
                Rec110."Ship-to Country/Region Code" := EnvíoaCdpaísregión;
                Rec110."Envio a-Nº Telefono" := EnvioaTelefono;
                Rec110.Modify;
            until Rec110.Next = 0;
    end;
}

