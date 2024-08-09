tableextension 50009 CompanyInformation extends "Company Information"
{
    fields
    {
        field(50000; "Identificador empresa bancos"; Text[35])
        {
        }
        field(50001; "Eliminar Caracteres"; Text[50])
        {
            Description = 'WEB';
        }
        field(50002; "Categoria Raiz"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50003; "Identificador Datos Tecnicos"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50004; "Identificador Idioma"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50005; "Identificador Peso"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50006; "Identificador Volumen"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50007; "Identificador Grupos Categoria"; Text[50])
        {
            Description = 'WEB';
        }
        field(50008; "Identificador Clientes Categor"; Text[50])
        {
            Description = 'WEB';
        }
        field(50009; "Identificador Pais"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50010; "Identificador Empleado Perfil"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50011; "Identificador Recargo Eq"; Text[50])
        {
            Description = 'WEB';
        }
        field(50014; "Tarifa WEB"; Code[10])
        {
            Caption = 'Tarifa WEB';
            Description = 'WEB';
            TableRelation = "Customer Price Group";
        }
        field(50015; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            Description = 'WEB';
            TableRelation = "Gen. Business Posting Group";
        }
        field(50016; "Producto Opcion Combinacion"; Code[50])
        {
            Description = 'WEB';
        }
        field(50018; "Ultimo Pedido"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50019; "Comision Reembolso"; Code[20])
        {
            Description = 'WEB';
            TableRelation = Item."No.";
        }
        field(50020; "Cobro Transporte"; Code[20])
        {
            Description = 'WEB';
            TableRelation = Item."No.";
        }
        field(50021; "Forma Pago Comision Reembolso"; Code[10])
        {
            Description = 'WEB';
            TableRelation = "Payment Method".Code;
        }
        field(50022; "Identificador Pago Pedido"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50023; "Identificador Enviado Pedido"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50024; "Identificador Preparacion Pedi"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50025; "Nº Serie Web"; Code[10])
        {
            Description = 'WEB';
            Editable = true;
            TableRelation = "No. Series";
        }
        field(50026; "Identificador Envio Gratis"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50027; "Cod. Transporte Gratis"; Code[20])
        {
            Description = 'WEB';
            TableRelation = "Shipping Agent".Code;
        }
        field(50028; "Ruta pdfs"; Text[250])
        {
        }
        field(50029; "Identificador Envio Canarias"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50030; "Cod. Transporte Web"; Code[20])
        {
            Description = 'WEB';
            TableRelation = "Shipping Agent".Code;
        }
        field(50031; "Identificador Envio Gratis 2"; BigInteger)
        {
            Description = 'WEB';
        }
        field(50032; "Cod. Transporte Gratis 2"; Code[20])
        {
            Description = 'WEB';
            TableRelation = "Shipping Agent".Code;
        }
        field(50033; NumLogCambio; Integer)
        {
        }
        field(50034; pdf; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;

            trigger OnValidate()
            begin
                //PictureUpdated := true;
            end;
        }
    }
}
