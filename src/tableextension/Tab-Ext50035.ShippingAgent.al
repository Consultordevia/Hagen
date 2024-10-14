tableextension 50035 ShippingAgent extends "Shipping Agent"
{
    fields
    {
        field(50000; "No incluir portes"; Boolean)
        {
        }
        field(50001; "Envia fichero para etiquetas"; Boolean)
        {
        }
        field(50002; "Decremento kilo"; Decimal)
        {
        }
        field(50003; "Sacar etiqueta envio PEQ"; Boolean)
        {
        }
        field(50004; "Conversion Volumen/kilos"; Decimal)
        {
        }
        field(50005; "Ruta fichero"; Text[250])
        {
        }
        field(50006; "Cobrar portes entre empresas"; Boolean)
        {
        }
        field(50007; "Sacar etiqueta envio GRA"; Boolean)
        {
        }
        field(50008; "Fichero estandar"; Boolean)
        {
        }
        field(50009; "Link transporte"; Text[250])
        {
        }
        field(50010; "Añadir"; Option)
        {
            OptionCaption = 'Nº expedicion,Nº expedicion+Cod. postal ,Nº expedicion/Cod. postal,Nº expedicion+Año';
            OptionMembers = "Nº expedicion","Nº expedicion+Cod. postal ","Nº expedicion/Cod. postal","Nº expedicion+Año";
        }
        field(50011; "Texto final fichero"; Text[30])
        {
        }
        field(50012; "Super Urgente"; Boolean)
        {
        }
        field(50013; "No agrupar"; Boolean)
        {
        }
        field(50014; Paises; Code[30])
        {
        }
        field(50015; "IDTRANS SCAC. EDICOM"; Code[17])
        {
        }
        field(50016; "ETAPATRANS EDICON"; Option)
        {
            OptionCaption = '20-Transporte principal,25-Transportista del envio, responsable de todo el transporte';
            OptionMembers = "20-Transporte principal","25-Transportista del envio"," responsable de todo el transporte";
        }
        field(50017; "MEDIOTRANS EDICOM"; Option)
        {
            OptionCaption = ' ,13-Buque oceanico,25-Ferrocaril urgente,31-Camion,41-Transporte aereo';
            OptionMembers = " ","13-Buque oceanico","25-Ferrocaril urgente","31-Camion","41-Transporte aereo";
        }
        field(50018; "Codigo externo"; Text[20])
        {
        }
        field(50020; "ID web"; Integer)
        {
        }
        field(50021; Shopyfi; Boolean)
        {
        }
        field(50022; "Url seguimiento"; Text[80])
        {
        }
        field(50023; Potyugal; Boolean)
        {
        }
        field(50024; "Codigo Hagen"; Code[20])
        {
        }
        field(50025; "Codigo Cliente Hagen"; Code[20])
        {
        }
        field(50029; "Grupo clientes"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const("Grupo de clientes"));
        }
        field(50030; "Carta Tamaño A4"; Boolean)
        {
        }
    }
}
