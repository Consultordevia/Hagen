tableextension 50038 "Sales&ReceivablesSetup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "% Venta Clasificación A"; Decimal)
        {
        }
        field(50001; "% Venta Clasificación B"; Decimal)
        {
        }
        field(50002; "% Venta Clasificación C"; Decimal)
        {
        }
        field(50003; "Serie de Actividades"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50004; "Serie de Incidencias"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50005; "Cuenta cont. portes"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50006; "Forma pago PAGADO"; Code[10])
        {
            TableRelation = "Payment Method";
        }
        field(50007; "Grupo de precios ofertas"; Code[10])
        {
            TableRelation = "Customer Price Group";
        }
        field(50008; "Porte minimo"; Decimal)
        {
        }
        field(50011; "Dias aviso falta pago"; Integer)
        {
        }
        field(50012; "Ruta doc. AQUAROFILA"; Code[200])
        {
        }
        field(50013; "Ruta doc. REPTILES"; Code[200])
        {
        }
        field(50014; "Ruta doc. GATOS"; Code[200])
        {
        }
        field(50015; "Fecha inicio pub. 1"; Date)
        {
        }
        field(50016; "Fecha inicio pub. 2"; Date)
        {
        }
        field(50017; "Fecha inicio pub. 3"; Date)
        {
        }
        field(50018; "Fecha fin pub. 1"; Date)
        {
        }
        field(50019; "Fecha fin pub. 2"; Date)
        {
        }
        field(50020; "Fecha fin pub. 3"; Date)
        {
        }
        field(50021; "Descuento CASH"; Decimal)
        {
        }
        field(50022; "Importe portes A"; Decimal)
        {
        }
        field(50023; "Importe portes B"; Decimal)
        {
        }
        field(50024; "Importe portes C"; Decimal)
        {
        }
        field(50025; "Baremo Volumen"; Decimal)
        {
        }
        field(50026; "% hueco palet"; Decimal)
        {
        }
        field(50027; "Importe para cobrar porte"; Decimal)
        {
        }
        field(50028; "Desde 1"; Decimal)
        {
        }
        field(50029; "Hasta 1"; Decimal)
        {
        }
        field(50030; "Desde 2"; Decimal)
        {
        }
        field(50031; "Hasta 2"; Decimal)
        {
        }
        field(50032; "Desde 3"; Decimal)
        {
        }
        field(50033; "Hasta 3"; Decimal)
        {
        }
        field(50034; "Desde 4"; Decimal)
        {
        }
        field(50035; "Hasta 4"; Decimal)
        {
        }
        field(50036; "Desde 5"; Decimal)
        {
        }
        field(50037; "Hasta 5"; Decimal)
        {
        }
        field(50038; "Tarifa vigente"; Code[10])
        {
            TableRelation = "Customer Price Group";
        }
        field(50039; "Nº serie SEPA"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50040; "Tarifa vigente anterior"; Code[10])
        {
        }
        field(50041; "Ruta fiche. pedido KIWOKO"; Text[80])
        {
        }
        field(50042; "Ruta fiche. pedido KIWOKO COPI"; Text[80])
        {
        }
        field(50043; "Ruta fiche. pedido OTROS"; Text[80])
        {
        }
        field(50044; "Ruta fiche. pedido OTROS COPIA"; Text[80])
        {
        }
        field(50045; "Ruta fiche. dropbox"; Text[80])
        {
        }
        field(50046; "Ruta fiche. pedido KIWOKO nuev"; Text[80])
        {
        }
        field(50047; "Multi-picking kilos"; Decimal)
        {
        }
        field(50048; "Multi-picking lineas"; Integer)
        {
        }
        field(50049; "Ruta fiche. FTP"; Text[80])
        {
        }
        field(50050; "Ruta doc. PAJAROS"; Text[80])
        {
        }
        field(50051; "Ruta doc. PEQ.ANIMALES"; Text[80])
        {
        }
        field(50052; "Ruta doc. PERROS"; Text[80])
        {
        }
        field(50053; "Ruta doc. ESTANQUES"; Text[80])
        {
        }
        field(50054; "Fecha inicio pub. 4"; Date)
        {
        }
        field(50055; "Fecha inicio pub. 5"; Date)
        {
        }
        field(50056; "Fecha inicio pub. 6"; Date)
        {
        }
        field(50057; "Fecha fin pub. 4"; Date)
        {
        }
        field(50058; "Fecha fin pub. 5"; Date)
        {
        }
        field(50059; "Fecha fin pub. 6"; Date)
        {
        }
        field(50060; "Fecha inicio pub. 7"; Date)
        {
        }
        field(50061; "Fecha fin pub. 7"; Date)
        {
        }
        field(50062; "Ruta fiche. pedido Leroy Merli"; Text[80])
        {
        }
        field(50063; NULO; Text[80])
        {
        }
        field(50064; "Ruta fiche. pedido catit"; Text[80])
        {
        }
        field(50065; "Ruta fiche. pedido catit COPIA"; Text[80])
        {
        }
        field(50066; "Ruta fiche. pedido AMAZON2"; Text[80])
        {
        }
        field(50067; "Ruta fiche. pedido AMZON2COPIA"; Text[80])
        {
        }
        field(50068; "Ruta fiche. ENVIO A EDICOM"; Text[80])
        {
        }
        field(50070; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(50071; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(50072; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(50073; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(50074; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(50075; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(50076; "Ultima letra"; Integer)
        {
        }
        field(50077; "Ruta fiche. pedido TAMK"; Text[60])
        {
        }
        field(50078; "Ruta fiche. pedido TAMKt COPIA"; Text[60])
        {
        }
        field(50079; "Ruta fichero sending"; Text[60])
        {
        }
        field(50080; "Ruta fichero sending COPIA"; Text[60])
        {
        }
        field(50081; "Ruta fichero TRANSAHER"; Text[60])
        {
        }
        field(50082; "Ruta fichero TRANSAHER COPIA"; Text[60])
        {
        }
        field(50083; "Ruta fiche. pedido MASKOKOTAS"; Text[60])
        {
        }
        field(50084; "Ruta fiche. pedido MASKO-COPIA"; Text[60])
        {
        }
        field(50085; "Ruta fiche. pedido NAV0211"; Text[60])
        {
        }
        field(50086; "Ruta fiche. pedido NAV0211-COP"; Text[60])
        {
        }
        field(50087; "Ruta fiche. pedido catit nuevo"; Text[80])
        {
        }
        field(50088; "Ruta fiche. pedido catit COPnu"; Text[80])
        {
        }
        field(50089; "Ruta fiche. pedido Verdecora"; Text[60])
        {
        }
        field(50090; "Ruta fiche. Stock Leroy Merlin"; Text[60])
        {
        }
        field(50091; "Ruta fiche. Stock mano mano pe"; Text[60])
        {
        }
    }
}
