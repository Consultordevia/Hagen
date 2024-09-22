#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50146 "Alto prod"
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

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(nuevoprod;nuevoprod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Nuevo codigo';
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
                action(Copiar)
                {
                    ApplicationArea = Basic;
                    Caption = 'Copiar';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin


                        RecItem2.Get(codprod);
                        MODIFICA;
                        CurrPage.Close;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

        def(codprod);
    end;

    var
        Rec37: Record "Sales Line";
        TLinea: Decimal;
        RecCV: Record "Sales Header";
        TOTALPedido: Decimal;
        RecCusto: Record Customer;
        RecLS: Record "No. Series Line";
        NPEDIDO: Code[10];
        RecCV2: Record "Sales Header";
        RecCV3: Record "Sales Header";
        RecCV33: Record "Sales Header";
        CODPED: Code[10];
        /////- CUADAIAI: Codeunit UnknownCodeunit50015;
        ACTIVO: Boolean;
        /////-CUADAIA: Codeunit UnknownCodeunit50010;
        Commenta: Boolean;
        RecLV: Record "Sales Line";
        RecCV4: Record "Sales Header";
        RecCV5: Record "Sales Header";
        npedidos: Integer;
        PESOREAL: Decimal;
        peso: Decimal;
        Rec36: Record "Sales Header";
        Rec362: Record "Sales Header";
        /////-RecAcc: Record UnknownRecord50006;
        INCIDENCIASPDTES: Integer;
        RecCVP: Record "Sales & Receivables Setup";
        /////-CU: Codeunit UnknownCodeunit50010;
        RecTA: Record "Extended Text Header";
        /////-RepEti: Report UnknownReport50054;
        X: Integer;
        CUENTAPT: Integer;
        CUENTAES: Integer;
        /////-RecMT: Record UnknownRecord50005;
        RecItem: Record Item;
        CUENTAECI: Integer;
        REC2: Record "Sales Header";
        REC3: Record "Sales Header";
        /////-RecpEtiEci: Report UnknownReport50085;
        /////-CU_Exporta: Codeunit UnknownCodeunit50010;
        ventana: Dialog;
        nexpediexp: Code[10];
        nbultos: Integer;
        Rec110: Record "Sales Shipment Header";
        Rec1102: Record "Sales Shipment Header";
        /////-CU50001: Codeunit UnknownCodeunit50010;
        ELPESO: Decimal;
        REC1112: Record "Sales Shipment Line";
        TOTALPALE: Decimal;
        DECRE: Decimal;
        RecTra: Record "Shipping Agent";
        CODTRAS: Code[10];
        npalets: Integer;
        Rec36Pepe: Record "Sales Header";
        /////-RepETAD: Report UnknownReport50009;
        /////-RecMtU: Record UnknownRecord50005;
        /////-RepDropShi: Report UnknownReport50013;
        tipopalet: Code[10];
        tipopalet2: Code[10];
        tipopalet3: Code[10];
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
        sumavol: array [10] of Decimal;
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
        contadordeagrup: Code[10];
        RecCV22: Record "Sales Header";
        /////-EtiAgrppeque: Report UnknownReport50025;
        RecCV222: Record "Sales Header";
        /////-RepEtieci: Report UnknownReport50026;
        eslargo4: Integer;
        esancho4: Integer;
        esalto4: Integer;
        tipopalet4: Code[10];
        eslargo5: Integer;
        esancho5: Integer;
        esalto5: Integer;
        tipopalet5: Code[10];
        eslargo6: Integer;
        esancho6: Integer;
        esalto6: Integer;
        tipopalet6: Code[10];
        eslargo7: Integer;
        esancho7: Integer;
        esalto7: Integer;
        tipopalet7: Code[10];
        eslargo8: Integer;
        esancho8: Integer;
        esalto8: Integer;
        tipopalet8: Code[10];
        eslargo9: Integer;
        esancho9: Integer;
        esalto9: Integer;
        tipopalet9: Code[10];
        eslargo10: Integer;
        esancho10: Integer;
        esalto10: Integer;
        tipopalet10: Code[10];
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
        CodServicio: Code[10];
        ShippingAgentServices: Record "Shipping Agent Services";
        codprod: Code[20];
        RecItem2: Record Item;
        RecSP: Record "Sales Price";
        RecSP2: Record "Sales Price";
        RecUMP: Record "Item Unit of Measure";
        RecUMP2: Record "Item Unit of Measure";
        /////-RecMT22: Record UnknownRecord50020;
        /////-RecMT2: Record UnknownRecord50020;
        nuevoprod: Code[20];


    procedure MODIFICA()
    begin



        if nuevoprod<>'' then begin
             RecItem:=RecItem2;
             RecItem."No.":=nuevoprod;
             RecItem.ean:='';
             RecItem."Fecha Alta":=Today;
             RecItem."Fecha Lanzamiento":=0D;
             RecItem."Unit Cost":=0;
             RecItem."Standard Cost":=0;
             RecItem."Last Direct Cost":=0;
             RecItem."Indirect Cost %":=0;
             RecItem.ean:='';
             RecItem.Insert(true);
             RecSP.Reset;
             RecSP.SetRange(RecSP."Item No.",RecItem2."No.");
             if RecSP.FindFirst then repeat
                  RecSP2.Init;
                  RecSP2:=RecSP;
                  RecSP2."Item No.":=nuevoprod;
                  RecSP2.Insert(true);
             until RecSP.Next=0;
             RecUMP.Reset;
             RecUMP.SetRange(RecUMP."Item No.",RecItem2."No.");
             if RecUMP.FindFirst then repeat
            ///      RecUMP2.RESET;
              ///    RecUMP2.SETRANGE(RecUMP2."Item No.",RecUMP."Item No.");
               ///   RecUMP2.SETRANGE(RecUMP2.Code,RecUMP.Code);
               ///   IF NOT RecUMP2.FINDFIRST THEN BEGIN
                       RecUMP2.Init;
                       RecUMP2:=RecUMP;
                       RecUMP2."Item No.":=nuevoprod;
                       if RecUMP2.Insert(true) then;
                 /// END;
             until RecUMP.Next=0;


/*  /////-
             RecMT22.Reset;        
             RecMT22.SetRange(RecMT22."Código 1",RecItem2."No.");
             if RecMT22.FindFirst then repeat
                  RecMT2:=RecMT22;
                  RecMT22."Código 1":=nuevoprod;
                  RecMT2.Insert;
             until RecMT22.Next=0;
             */

             Message('Producto copiado.');
        end;
    end;


    procedure def(codp: Code[20])
    begin


        codprod:=codp;
    end;
}

