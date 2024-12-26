pageextension 50030 ShippingAgents extends "Shipping Agents"
{
    layout
    {
        addafter("Name")
        {
         field( "IDTRANS SCAC. EDICOM"	; Rec."IDTRANS SCAC. EDICOM") { ApplicationArea = All; }
        field( "ETAPATRANS EDICON"	; Rec."ETAPATRANS EDICON") { ApplicationArea = All; }
        field( "ID web"	; Rec."ID web") { ApplicationArea = All; }	 
        field( "MEDIOTRANS EDICOM"	; Rec."MEDIOTRANS EDICOM") { ApplicationArea = All; }	 
        field( "No incluir portes"	; Rec."No incluir portes") { ApplicationArea = All; }	 
        field( "Envia fichero para etiquetas"	; Rec."Envia fichero para etiquetas") { ApplicationArea = All; } 
        field( "Decremento kilo"	; Rec."Decremento kilo") { ApplicationArea = All; }	 
        field( "Sacar etiqueta envio PEQ"	; Rec."Sacar etiqueta envio PEQ") { ApplicationArea = All; } 
        field( "Sacar etiqueta envio GRA"	; Rec."Sacar etiqueta envio GRA") { ApplicationArea = All; } 
        field( "Conversion Volumen/kilos"	; Rec."Conversion Volumen/kilos") { ApplicationArea = All; } 
        field( "Ruta fichero"	; Rec."Ruta fichero") { ApplicationArea = All; }	 
        field( "Cobrar portes entre empresas"	; Rec."Cobrar portes entre empresas") { ApplicationArea = All; } 
        field( "Fichero estandar"	; Rec."Fichero estandar") { ApplicationArea = All; }	 
        field( "Link transporte"	; Rec."Link transporte") { ApplicationArea = All; }	 
        field( "Añadir"; Rec."Añadir") { ApplicationArea = All; }	 
        field( "Texto final fichero"	; Rec."Texto final fichero") { ApplicationArea = All; } 
        field( "Super Urgente"	; Rec."Super Urgente") { ApplicationArea = All; }	 
        field( "No agrupar"	; Rec."No agrupar") { ApplicationArea = All; } 
        field( "Paises"; Rec."Paises") { ApplicationArea = All; }	 
        field( "Codigo externo"	; Rec."Codigo externo") { ApplicationArea = All; } 
        field( "Shopyfi"; Rec."Shopyfi") { ApplicationArea = All; } 
        field( "Potyugal"; Rec."Potyugal") { ApplicationArea = All; }	 
        field( "Codigo Hagen"; Rec."Codigo Hagen") { ApplicationArea = All; } 
        field( "Codigo Cliente Hagen"; Rec."Codigo Cliente Hagen") { ApplicationArea = All; } 
        field( "Grupo clientes"	; Rec."Grupo clientes") { ApplicationArea = All; }	 
        field( "Carta Tamaño A4"	; Rec."Carta Tamaño A4") { ApplicationArea = All; }	 

        }

    }

    actions
    {

        /*
        Expanded	Type	SubType	Name	Caption
0	Action		Zonas	Zonas
0	Action		Transportistas-Zonas	<Transportistas-Zonas>   Page Tarifas transp.- Transp-Zonas
0	Action		Provincia-Transp-Zona	<Provincia-Transp-Zona>
0	Action		Tarifa	<Tarifa>
        */
        addlast(Processing)
        {
            action(Zonas)
            {
                ApplicationArea = All;
                Caption = 'Zonas';


                trigger OnAction()
                var
                PTarifastransp:  Page "Tarifas transp.- Zonas";
                    
                begin
                    Clear(PTarifastransp);
                    PTarifastransp.RunModal();
                end;

            }
            action(TransportistasZonas)
            {
                ApplicationArea = All;
                Caption = 'Transportistas-Zonas';


                trigger OnAction()
                var                 
                PTarifastranspTranspZonas: Page "Tarifas transp.- Transp-Zonas";
                    
                begin
                    Clear(PTarifastranspTranspZonas);
                    PTarifastranspTranspZonas.RunModal();
                end;

            }
            action(ProvinciaTranspZona)
            {
                ApplicationArea = All;
                Caption = 'Provincia-Transp-Zona';


                trigger OnAction()
                var
                PTarifastranspProvTransp: Page "Tarifas transp.- Prov-Transp-z";
                    
                begin
                    Clear(PTarifastranspProvTransp);
                    PTarifastranspProvTransp.RunModal();
                end;

            }
            action(Tarifa)
            {
                ApplicationArea = All;
                Caption = 'Tarifa';


                trigger OnAction()
                var                 
                PTarifastranspTarifa: Page "Tarifas transp.- Tarifa";
                    
                begin
                    Clear(PTarifastranspTarifa);
                    PTarifastranspTarifa.RunModal();
                end;

            }

            }
            
    }    
}