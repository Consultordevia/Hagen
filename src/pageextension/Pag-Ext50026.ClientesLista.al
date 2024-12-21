pageextension 50026 ClientesLista extends "Customer List"
{

    layout
    {


        addafter("Salesperson Code")
        {
            field("Document Sending Profile"; Rec."Document Sending Profile")
            {
                ApplicationArea = All;
            }

            field("Codigo cliente externo"; Rec."Codigo cliente externo") { ApplicationArea = All; }
            field("Payment Method Code"; Rec."Payment Method Code") { ApplicationArea = All; }
            field("VAT Registration No."; Rec."VAT Registration No.") { ApplicationArea = All; }
            field(NombreVendedor; NombreVendedor) { ApplicationArea = All; }
            field("Top produccto.1"; Rec."Top produccto 1") { ApplicationArea = All; }
            field("Top produccto.2"; Rec."Top produccto 2") { ApplicationArea = All; }
            field("Top produccto.3"; Rec."Top produccto 3") { ApplicationArea = All; }
            field("Top produccto.4"; Rec."Top produccto 4") { ApplicationArea = All; }
            field("Top produccto.5"; Rec."Top produccto 5") { ApplicationArea = All; }
            field("Top produccto.6"; Rec."Top produccto 6") { ApplicationArea = All; }
            field("Top produccto.7"; Rec."Top produccto 7") { ApplicationArea = All; }
            field("Top produccto.8"; Rec."Top produccto 8") { ApplicationArea = All; }
            field("Top produccto.9"; Rec."Top produccto 9") { ApplicationArea = All; }
            field("Top produccto.10"; Rec."Top produccto 10") { ApplicationArea = All; }
            field("Usuario Web"; Rec."Usuario Web") { ApplicationArea = All; }
            field("Grupo clientes"; Rec."Grupo clientes") { ApplicationArea = All; }
            field(Latitud; Rec.Latitud) { ApplicationArea = All; }
            field(Longitud; Rec.Longitud) { ApplicationArea = All; }
            field(City; Rec.city) { ApplicationArea = All; }
            field(County; Rec.County) { ApplicationArea = All; }
            field(Address; Rec.Address) { ApplicationArea = All; }
            field("Address 2"; Rec."Address 2") { ApplicationArea = All; }
            field("Enviar a Web"; Rec."Enviar a Web") { ApplicationArea = All; }
            field("Enviar a Web Distribuidor"; Rec."Enviar a Web Distribuidor") { ApplicationArea = All; }
            field("Estatus del cliente"; Rec."Estatus del cliente") { ApplicationArea = All; }
        }
    }
    actions
    {
        addlast(processing)
        {
            action(CopiarCliente)
            {
                ApplicationArea = All;
                Caption = 'Copiar Clientes';
                Image = Order;


                trigger OnAction()
                var
                    RecCusto: Record Customer;
                    SalesSetup: Record "Sales & Receivables Setup";
                    codclie: code[20];
                    NoSeriesManagement: Codeunit NoSeriesManagement;
                    ShiptoAddress: Record "Ship-to Address";
                    ShiptoAddress2: Record "Ship-to Address";
                begin


                    RecCusto.INIT;
                    RecCusto := Rec;
                    SalesSetup.GET;
                    SalesSetup.TESTFIELD("Customer Nos.");
                    codclie := NoSeriesManagement.GetNextNo('C-NAV', TODAY, TRUE);

                    RecCusto."No." := codclie;
                    RecCusto."Fecha alta" := TODAY;
                    RecCusto."Usuario alta" := USERID;
                    RecCusto.Name := 'COPIA ' + COPYSTR(Rec.Name, 1, 53);
                    RecCusto."Usuario Web" := '';
                    RecCusto."Contraseña WEB" := '';
                    RecCusto.INSERT;


                    ShiptoAddress.RESET;
                    ShiptoAddress.SETRANGE(ShiptoAddress."Customer No.", Rec."No.");
                    IF ShiptoAddress.FINDFIRST THEN
                        REPEAT
                            ShiptoAddress2 := ShiptoAddress;
                            ShiptoAddress2."Customer No." := codclie;
                            ShiptoAddress2.INSERT;
                        UNTIL ShiptoAddress.NEXT = 0;


                    MESSAGE('El nuevo clientes es %1', codclie);


                END;

            }
        }
    }


    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.GET(USERID);
        IF UserSetup."Salespers./Purch. Code" <> '' THEN BEGIN
            rec.SETRANGE("Salesperson Code", UserSetup."Salespers./Purch. Code");
        END;
        rec.SETFILTER("Estatus del cliente", 'Activo|Posible cliente|Posible cliente WEB');
    end;





    trigger OnAfterGetRecord()
    var
        UserSetup: Record "User Setup";
    begiN
        NombreVendedor := '';
        IF RecVendedores.get(Rec."Salesperson Code") then begin
            NombreVendedor := RecVendedores.Name;
        end;

        if UserSetup.GET(USERID) then
            IF UserSetup."Salespers./Purch. Code" <> '' THEN BEGIN
                rec.SETRANGE("Salesperson Code", UserSetup."Salespers./Purch. Code");
            END;
        ///IF UserSetup.Comercial<>'' THEN BEGIN
        ///SETRANGE("Salesperson Code",UserSetup.Comercial);
        ///END;


        rec.SETFILTER("Estatus del cliente", 'Activo|Posible cliente|Posible cliente WEB');

    end;

    var

        RecVendedores: Record "Salesperson/Purchaser";
        NombreVendedor: text;


}
