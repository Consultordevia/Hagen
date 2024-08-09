#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50041 "Datos mailchip"
{

    fields
    {
        field(1;"Email Address";Text[250])
        {
        }
        field(2;"First Name";Text[70])
        {
        }
        field(3;"Last Name";Text[70])
        {
        }
        field(4;Nombre;Text[70])
        {
        }
        field(5;Navision;Text[20])
        {
        }
        field(6;Tienda;Text[70])
        {
        }
        field(7;"Grupo Des Web";Text[20])
        {
        }
        field(8;Pais;Text[30])
        {
        }
        field(9;Provincia;Text[30])
        {
        }
        field(10;ACUARIOFIL;Text[10])
        {
        }
        field(11;ESTANQUES;Text[10])
        {
        }
        field(12;GATOS;Text[10])
        {
        }
        field(13;PAJAROS;Text[10])
        {
        }
        field(14;"PEQ ANIMAL";Text[10])
        {
        }
        field(15;PERROS;Text[10])
        {
        }
        field(16;REPTILES;Text[10])
        {
        }
        field(17;"Alta Web";Text[10])
        {
        }
        field(18;"Pedido web";Text[10])
        {
        }
        field(19;"Pedido 2 meses";Text[10])
        {
        }
        field(20;Comercial;Text[30])
        {
        }
        field(21;ABC;Text[10])
        {
        }
        field(22;"Estatus cliente";Text[10])
        {
        }
        field(23;"Tipo cliente";Text[10])
        {
        }
        field(24;"Total venta";Text[20])
        {
        }
        field(25;Comunidad;Text[30])
        {
        }
        field(26;"Cod Clasificacion Web";Text[30])
        {
        }
        field(27;Promocion;Text[30])
        {
        }
        field(28;MEMBER_RATING;Text[30])
        {
        }
        field(29;OPTIN_TIME;Text[30])
        {
        }
        field(30;OPTIN_IP;Text[30])
        {
        }
        field(31;CONFIRM_TIME;Text[30])
        {
        }
        field(32;CONFIRM_IP;Text[30])
        {
        }
        field(33;LATITUDE;Text[30])
        {
        }
        field(34;LONGITUDE;Text[30])
        {
        }
        field(35;GMTOFF;Text[30])
        {
        }
        field(36;DSTOFF;Text[30])
        {
        }
        field(37;TimeZone;Text[30])
        {
        }
        field(38;CC;Text[30])
        {
        }
        field(39;REGION;Text[30])
        {
        }
        field(40;LAST_CHANGED;Text[30])
        {
        }
        field(41;LEID;Text[30])
        {
        }
        field(42;EUID;Text[30])
        {
        }
        field(43;NOTES;Text[30])
        {
        }
        field(44;TAGS;Text[30])
        {
        }
        field(45;"Diferente email";Boolean)
        {
        }
        field(46;Diferencias;Text[250])
        {
        }
        field(50;"Nav-Email Address";Text[250])
        {
        }
        field(51;"Nav-Tienda";Text[70])
        {
        }
        field(52;"Nav-Grupo Des Web";Text[10])
        {
        }
        field(53;"Nav-Pais";Text[30])
        {
        }
        field(54;"Nav-Provincia";Text[30])
        {
        }
        field(55;"Nav-ACUARIOFIL";Text[10])
        {
        }
        field(56;"Nav-ESTANQUES";Text[10])
        {
        }
        field(57;"Nav-GATOS";Text[10])
        {
        }
        field(58;"Nav-PAJAROS";Text[10])
        {
        }
        field(59;"Nav-PEQ ANIMAL";Text[10])
        {
        }
        field(60;"Nav-PERROS";Text[10])
        {
        }
        field(61;"Nav-REPTILES";Text[10])
        {
        }
        field(62;"Nav-Alta Web";Text[10])
        {
        }
        field(63;"Nav-Pedido web";Text[10])
        {
        }
        field(64;"Nav-Pedido 2 meses";Text[10])
        {
        }
        field(65;"Nav-Comercial";Text[30])
        {
        }
        field(66;"Nav-ABC";Text[10])
        {
        }
        field(67;"Nav-Estatus cliente";Text[10])
        {
        }
        field(68;"Nav-Tipo cliente";Text[10])
        {
        }
        field(69;"Nav-Comunidad";Text[30])
        {
        }
        field(70;"Nav-Cod Clasificacion Web";Text[30])
        {
        }
    }

    keys
    {
        key(Key1;"Email Address",Navision)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

