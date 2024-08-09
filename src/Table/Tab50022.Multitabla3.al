#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50022 "Multitabla 3"
{
    // 
    // "Multitabla 3"."Zona transportistas" WHERE (Tabla=CONST(Transportistas-Zonas),Transportista=FIELD(Transportista-Cliente))


    fields
    {
        field(1;Tabla;Option)
        {
            OptionCaption = 'Zonas,Transportistas-Zonas,Provincia-Transp-Zona,Tarifa';
            OptionMembers = Zonas,"Transportistas-Zonas","Provincia-Transp-Zona",Tarifa;
        }
        field(2;Codigo;Integer)
        {
            AutoIncrement = true;
        }
        field(3;Zona;Code[20])
        {
        }
        field(4;Transportista;Code[20])
        {
            TableRelation = "Shipping Agent";
        }
        field(5;"Zona transportistas";Code[20])
        {
            TableRelation = "Multitabla 3".Zona where (Tabla=const(Zonas));
        }
        field(6;Provincia;Code[20])
        {
            TableRelation = Area;
        }
        field(7;"Transportista-Cliente";Code[20])
        {
            TableRelation = "Shipping Agent";
        }
        field(8;"Zona transportistas-Cliente";Code[20])
        {
        }
        field(9;"Transportista tarifa";Code[20])
        {
            TableRelation = "Shipping Agent";
        }
        field(10;"Zona tarifa";Code[20])
        {
            TableRelation = "Multitabla 3"."Zona transportistas" where (Tabla=const("Transportistas-Zonas"),
                                                                        Transportista=field("Transportista tarifa"));
        }
        field(11;"Hasta Kilos";Decimal)
        {
        }
        field(12;Precio;Decimal)
        {
        }
    }

    keys
    {
        key(Key1;Tabla,Zona,"Zona transportistas",Codigo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

