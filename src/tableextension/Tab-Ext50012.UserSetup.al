tableextension 50012 UserSetup extends "User Setup"
{
    fields
    {
        field(50000; "Serie actividades"; Code[10])
        {
        }
        field(50001; "Serie incidencias"; Code[10])
        {
        }
        field(50002; "Serie pedidos"; Code[10])
        {
        }
        field(50003; "Permiso pedidos urgentes"; Boolean)
        {
        }
        field(50004; "Cambia estado pedido"; Boolean)
        {
        }
        field(50005; "Editar tabla Clientes/Comercia"; Boolean)
        {
        }
        field(50006; Comercial; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(50007; "Permite modificar estado lin.p"; Boolean)
        {
        }
        field(50009; "Editar tabla productos"; Boolean)
        {
        }
        field(50010; "Nº cliente"; Code[10])
        {
        }
        field(50011; "Nº pedido"; Code[10])
        {
        }
        field(50012; "Editar ofertas"; Boolean)
        {
        }
        field(50013; "Grupo cliente"; Code[10])
        {
        }
        field(50014; Linea; Integer)
        {
        }
        field(50015; "Cambio de Activo a Retenido"; Boolean)
        {
        }
        field(50016; "Cliente a crear tarifa"; Code[10])
        {
        }
        field(50017; "Permite fraccionar uni. venta"; Boolean)
        {
        }
        field(50018; "Es el cliente nº"; Code[10])
        {
            TableRelation = Customer;
        }
        field(50019; "Permite modificar precios tari"; Boolean)
        {
        }
        field(50020; "Usuario HAGEN DIRECT"; Boolean)
        {
        }
        field(50021; "Permite editar PC -> adaia"; Boolean)
        {
        }
        field(50022; "Permite alta pedido con impago"; Boolean)
        {
        }
        field(50024; "Grupo clientes"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const("Grupo de clientes"));
        }
        field(50025; "Permite modif. objetivos"; Boolean)
        {
        }
        field(50026; "Permite env.  ANTICIPOS"; Boolean)
        {
        }
        field(50027; "Es pedido o oferta"; Option)
        {
            OptionMembers = Oferta,Pedido;
        }
        field(50028; "Directorio compartido para doc"; Text[250])
        {
        }
        field(50029; "Edita lista envio a direccion"; Boolean)
        {
        }
        field(50030; Departamento; Option)
        {
            OptionMembers = "Hagen Direct",Almacen,Comercial,Contabilidad,Gerencia;
        }
        field(50031; "Porte por usuario"; Decimal)
        {
        }
        field(50032; "Porte minimo"; Decimal)
        {
        }
        field(50033; "Direccion .PDF"; Code[250])
        {
        }
        field(50034; "Importe calculo portes"; Decimal)
        {
        }
        field(50035; Super; Boolean)
        {
        }
        field(50036; "Forma pago CASH"; Code[10])
        {
            TableRelation = "Payment Method";
        }
        field(50037; Comidas; Boolean)
        {
        }
        field(50038; "Permiso Defectuoso"; Boolean)
        {
        }
        field(50039; "Ruta dropbox"; Text[250])
        {
        }
        field(50040; "Ruta dropbox2"; Text[250])
        {
        }
        field(50041; "Enviar email recep. compra"; Boolean)
        {
        }
        field(50042; "E-Mail envio notificaciones"; Text[100])
        {
            Caption = 'E-Mail envio notificaciones';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                //UpdateSalesPerson;
                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(50043; "Año"; Integer)
        {
        }
        field(50044; "Cod. Analisis"; Code[20])
        {
            TableRelation = "Grupos analisis".Codigo;
        }
        field(50045; "Analisis margenes"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const("Grupo de clientes"));
        }
        field(50046; "hasta mes"; Integer)
        {
        }
        field(50047; "hasta fecha"; Date)
        {
        }
        field(50048; "No Permite pasar pedido a preparar"; Boolean)
        {
        }
    }
}
