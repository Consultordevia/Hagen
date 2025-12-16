table 50012 CustomerWebService
{
    Caption = 'Customer WebService';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Integer)
        {
            Caption = 'Id';
            AutoIncrement = true;
        }
        field(2; "Tipo plantilla"; Code[20])
        {
            Caption = 'Tipo plantilla';
            tableRelation = "Customer Templ.";
        }
        field(3; "Nombre fiscal"; Text[150]) { Caption = 'Nombre fiscal'; }
        field(4; CIF; Text[20]) { Caption = 'CIF'; }
        field(5; Direccion; Text[250]) { Caption = 'Direccion'; }
        field(6; Poblacion; Text[100]) { Caption = 'Poblacion'; }
        field(7; "Codigo postal"; Code[20]) { Caption = 'Codigo postal'; }
        field(8; Provincia; Text[30]) { Caption = 'Provincia'; }
        field(9; Telefono; Text[30]) { Caption = 'Telefono'; }
        field(10; "Nombre comercial"; Text[150]) { Caption = 'Nombre comercial'; }
        field(11; "Nombre contacto"; Text[150]) { Caption = 'Nombre contacto'; }
        field(12; "Email acceso"; Text[150]) { Caption = 'Email acceso'; }
        field(13; "Email facturas"; Text[150]) { Caption = 'Email facturas'; }
        field(14; "Movil whatsapp"; Text[30]) { Caption = 'Movil whatsapp'; }
        field(15; "Direccion envio"; Text[150]) { Caption = 'Direccion envio'; }
        field(16; "Poblacion envio"; Text[50]) { Caption = 'Poblacion envio'; }
        field(17; "Codigo postal envio"; Code[20]) { Caption = 'Codigo postal envio'; }
        field(18; "Provincia envio"; Text[50]) { Caption = 'Provincia envio'; }
        field(19; "Contacto envio"; Text[150]) { Caption = 'Contacto envio'; }
        field(20; "Telefono envio"; Text[30]) { Caption = 'Telefono envio'; }
        field(21; "Email envio"; Text[150]) { Caption = 'Email envio'; }
        field(22; "Cod. vendedor"; Code[20]) { }
        field(23; "Cliente creado"; Boolean) { InitValue = false; Editable = false; }
        field(24; "Forma pago"; Option)
        {
            OptionMembers = "1","2";
        }
        field(25; IBAN; Code[50]) { }
    }

    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
    }

}
