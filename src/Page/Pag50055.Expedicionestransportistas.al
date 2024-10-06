#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50055 "Expediciones transportistas"
{
    Caption = 'Expediciones transportistas';
    CardPageID = "Posted Sales Shipment";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sales Shipment Header";
    SourceTableView = sorting("Shipping Agent Code", "Posting Date", "Nº expedición")
                      order(descending)
                      where("Nº expedición" = filter(<> ''));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Nº expedición"; Rec."Nº expedición")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Advanced;
                    Editable = false;
                    ToolTip = 'Specifies the number of the customer the items were shipped to.';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the name of the customer that you shipped the items in the shipment to.';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ApplicationArea = Basic;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field(NBULTOS; NBULTOS)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nº bultos';
                    Editable = false;
                }
                field(NPALETS; NPALETS)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nº Palets';
                    Editable = false;
                }
                field(DIMENSIONES; DIMENSIONES)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensiones';
                    Editable = false;
                }
                field(CODZONA; CODZONA)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cód. Zona';
                }
                field(KILOS; KILOS)
                {
                    ApplicationArea = Basic;
                    Caption = 'Kilos';
                }
                field(Volumen; Volumen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Kilos del Volumen';
                    Editable = false;
                }
                field("Modif."; MODIF)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Modif.';
                    Editable = false;
                }
                field(PRECIO; PRECIO)
                {
                    ApplicationArea = Basic;
                    Caption = 'Precio';
                }
                field(TEXTOALBARANES; TEXTOALBARANES)
                {
                    ApplicationArea = Basic;
                    Caption = 'Albaranes';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin



        NBULTOS := 0;
        NPALETS := 0;
        TEXTOALBARANES := '';
        KILOS := 0;
        Volumen := 0;
        Rec110.Reset;
        Rec110.SetCurrentkey(Rec110."Nº expedición");
        Rec110.SetRange(Rec110."Nº expedición", Rec."Nº expedición");
        if Rec110.FindSet then
            repeat
                Rec111.Reset;
                Rec111.SetRange(Rec111."Document No.", Rec110."No.");
                if Rec111.FindFirst then
                    repeat
                        KILOS := KILOS + Rec111."Gross Weight" * Rec111.Quantity;
                        Volumen := Volumen + Rec111."Unit Volume" * Rec111.Quantity;
                    until Rec111.Next = 0;
                if StrLen(TEXTOALBARANES) < 900 then begin
                    TEXTOALBARANES := TEXTOALBARANES + Rec110."No." + ' ';
                end;
                NBULTOS := NBULTOS + Rec110."Nº bultos";
                NPALETS := NPALETS + Rec110."Nº Palets";
            until Rec110.Next = 0;


        KILOS := ROUND(KILOS, 0.01);
        Volumen := ROUND(Volumen * RecCE."Baremo Volumen" * (1 + (RecCE."% hueco palet") / 100), 0.01);

        PRECIO := 0;
        CODZONA := '';
        RecCP.Reset;
        RecCP.SetRange(RecCP.Code, Rec."Ship-to Post Code");
        if RecCP.FindFirst then begin
            RecMT3.Reset;
            RecMT3.SetRange(RecMT3.Tabla, 2);
            RecMT3.SetRange(RecMT3.Provincia, RecCP."County Code");
            RecMT3.SetRange(RecMT3."Transportista-Cliente", Rec."Shipping Agent Code");
            if RecMT3.FindFirst then begin
                CODZONA := RecMT3."Zona transportistas-Cliente";
                BUSCA := KILOS;
                if Volumen > KILOS then begin
                    BUSCA := Volumen;
                end;
                RecMT3.Reset;
                RecMT3.SetRange(RecMT3.Tabla, 3);
                RecMT3.SetRange(RecMT3."Transportista tarifa", Rec."Shipping Agent Code");
                RecMT3.SetRange(RecMT3."Zona tarifa", CODZONA);
                RecMT3.SetRange(RecMT3."Hasta Kilos", BUSCA, 9999999999.0);
                if RecMT3.FindFirst then begin
                    PRECIO := RecMT3.Precio;
                end;
            end;
        end;


        MODIF := '';
        if Rec."Total peso" <> 0 then begin
            Volumen := Rec."Total peso";
            MODIF := '***';

        end;
    end;

    trigger OnOpenPage()
    var
        OfficeMgt: Codeunit "Office Management";
        HasFilters: Boolean;
    begin
        ///HasFilters := GETFILTERS <> '';
        ///SetSecurityFilterOnRespCenter;
        ///IF HasFilters THEN
        ///IF FINDFIRST THEN;
        ///IsOfficeAddin := OfficeMgt.IsAvailable;
    end;

    var
        IsOfficeAddin: Boolean;
        RecTra: Record "Shipping Agent";
        Rec110: Record "Sales Shipment Header";
        AutomaticosAdaia: Codeunit "Automaticos Cartas";
        /////- REP50030: Report UnknownReport50030;
        Customer: Record Customer;
        /////- OKAlbaranValoradoECI: Report UnknownReport50905;
        paginaweb: Text[500];
        ZONA: Decimal;
        KILOS: Decimal;
        VOLUMEN: Decimal;
        PRECIO: Decimal;
        BULTOS: Decimal;
        RecMT3: Record "Multitabla 3";
        CODZONA: Code[20];
        Rec111: Record "Sales Shipment Line";
        RecArea: Record "Area";
        RecCP: Record "Post Code";
        BUSCA: Decimal;
        TEXTOALBARANES: Text[1000];
        DIMENSIONES: Text[1000];
        MODIF: Code[3];
        NBULTOS: Decimal;
        NPALETS: Decimal;
        RecCE: Record "Sales & Receivables Setup";
}

