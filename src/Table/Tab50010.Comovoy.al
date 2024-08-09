#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50010 "¿ Como voy ?."
{

    fields
    {
        field(1; Vendedor; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(2; Mes; Integer)
        {
        }
        field(3; "Año"; Integer)
        {
        }
        field(4; "Dias del mes"; Integer)
        {
        }
        field(5; Vacaciones; Integer)
        {

            trigger OnValidate()
            begin
                "Dias reales de venta" := "Dias del mes" - Vacaciones - "Dias no laborales";
            end;
        }
        field(6; "Dias no laborales"; Integer)
        {

            trigger OnValidate()
            begin

                "Dias reales de venta" := "Dias del mes" - Vacaciones - "Dias no laborales";
            end;
        }
        field(7; "Cliente HAGEN"; Decimal)
        {
        }
        field(8; "Cliente *"; Decimal)
        {
        }
        field(10; "Objetivo Visitas"; Decimal)
        {
        }
        field(11; "Visitas Minimas mensual"; Decimal)
        {
        }
        field(12; "Efectividad visitas Pedidos"; Decimal)
        {
        }
        field(13; "Pedidos del mes"; Decimal)
        {
        }
        field(14; "Pedidos Hagendirect"; Decimal)
        {
        }
        field(15; "Pedidos pendientes comercial"; Decimal)
        {
        }
        field(16; "Pedidos retenido"; Decimal)
        {
        }
        field(17; "Pedidos para preparar"; Decimal)
        {
        }
        field(18; "Rotura de stock"; Decimal)
        {
        }
        field(19; "Incidencia Transporte"; Decimal)
        {
        }
        field(20; "Incidencia Oficina"; Decimal)
        {
        }
        field(21; "Incidencia Almacen"; Decimal)
        {
        }
        field(22; "Incidencia Cliente"; Decimal)
        {
        }
        field(23; "Incidencia Producto"; Decimal)
        {
        }
        field(24; "Incidencia Comerial"; Decimal)
        {
        }
        field(25; "Suma Potencialidad clientes"; Decimal)
        {
        }
        field(26; "Objetivos nuevos clientes"; Decimal)
        {
        }
        field(27; "Objetivos rappel trimestral"; Decimal)
        {
        }
        field(28; "Objetivos rappel semestral"; Decimal)
        {
        }
        field(29; "Objetivos rappel anual"; Decimal)
        {
        }
        field(30; "Objetivos venta diaria"; Decimal)
        {
        }
        field(31; "Objetivos venta mensual"; Decimal)
        {
        }
        field(32; "Objetivos venta trimestral"; Decimal)
        {
        }
        field(33; "Objetivos venta anual"; Decimal)
        {
        }
        field(34; "Objetivos oferta aplicada"; Decimal)
        {
        }
        field(35; "Objetivos descatalogados"; Decimal)
        {
        }
        field(36; "Objetivos Articulos"; Decimal)
        {
        }
        field(37; "Objetivos Familia"; Decimal)
        {
        }
        field(38; "Objetivos cobros vencidos"; Decimal)
        {
        }
        field(39; "Objetivos impagados"; Decimal)
        {
        }
        field(40; Total; Decimal)
        {
        }
        field(41; Bonificacion; Decimal)
        {
        }
        field(42; "Comision acumulada"; Decimal)
        {
        }
        field(43; "Comision efectiva"; Decimal)
        {
        }
        field(45; "Nº Pedidos del mes"; Decimal)
        {
        }
        field(46; "Nº Pedidos Hagendirect"; Decimal)
        {
        }
        field(47; "Nº Pedidos pendientes comercia"; Decimal)
        {
        }
        field(48; "Nº Pedidos retenido"; Decimal)
        {
        }
        field(49; "Nº Pedidos para preparar"; Decimal)
        {
        }
        field(50; "Nº Pedidos servidos"; Decimal)
        {
        }
        field(51; "Pedidos servidos"; Decimal)
        {
        }
        field(52; "Tanto % rotura"; Decimal)
        {
        }
        field(53; "Nombre comercial"; Text[50])
        {
            CalcFormula = lookup("Salesperson/Purchaser".Name where(Code = field(Vendedor)));
            FieldClass = FlowField;
        }
        field(54; Desde; Date)
        {
        }
        field(55; Hasta; Date)
        {
        }
        field(56; "Pedidos de abonos"; Decimal)
        {
        }
        field(57; "Nº Pedidos de abonos"; Decimal)
        {
        }
        field(58; "Importe Abonos"; Decimal)
        {
        }
        field(59; "Nº de abonos"; Decimal)
        {
        }
        field(60; "Importe albaranes"; Decimal)
        {
        }
        field(61; "Nº albaranes"; Decimal)
        {
        }
        field(62; "Nº Cliente HAGEN"; Decimal)
        {
        }
        field(63; "Nº Cliente *"; Decimal)
        {
        }
        field(64; "% Cliente HAGEN"; Decimal)
        {
        }
        field(65; "% Cliente *"; Decimal)
        {
        }
        field(66; "% Visitas/Objetivos"; Decimal)
        {
        }
        field(67; "Dias reales de venta"; Decimal)
        {
        }
        field(68; "1"; Boolean)
        {
        }
        field(69; "2"; Boolean)
        {
        }
        field(70; "3"; Boolean)
        {
        }
        field(71; "4"; Boolean)
        {
        }
        field(72; "5"; Boolean)
        {
        }
        field(73; "6"; Boolean)
        {
        }
        field(74; "7"; Boolean)
        {
        }
        field(75; "8"; Boolean)
        {
        }
        field(76; "9"; Boolean)
        {
        }
        field(77; "10"; Boolean)
        {
        }
        field(78; "11"; Boolean)
        {
        }
        field(79; "12"; Boolean)
        {
        }
        field(80; "13"; Boolean)
        {
        }
        field(81; "14"; Boolean)
        {
        }
        field(82; "15"; Boolean)
        {
        }
        field(83; "16"; Boolean)
        {
        }
        field(84; "17"; Boolean)
        {
        }
        field(85; "18"; Boolean)
        {
        }
        field(86; "19"; Boolean)
        {
        }
        field(87; "20"; Boolean)
        {
        }
        field(88; "21"; Boolean)
        {
        }
        field(89; "22"; Boolean)
        {
        }
        field(90; "23"; Boolean)
        {
        }
        field(91; "24"; Boolean)
        {
        }
        field(92; "25"; Boolean)
        {
        }
        field(93; "26"; Boolean)
        {
        }
        field(94; "27"; Boolean)
        {
        }
        field(95; "28"; Boolean)
        {
        }
        field(96; "29"; Boolean)
        {
        }
        field(97; "30"; Boolean)
        {
        }
        field(98; "31"; Boolean)
        {
        }
        field(99; "Efectividad visitas/factura"; Decimal)
        {
        }
        field(100; "Objetivo 1"; Text[50])
        {

            trigger OnValidate()
            begin
                /*
                Rec91.GET(USERID);
                IF NOT Rec91."Permite modif. objetivos" THEN BEGIN
                     ERROR('No puede modificar.');
                END;
                */

            end;
        }
        field(101; "Objetivo 2"; Text[50])
        {

            trigger OnValidate()
            begin
                /*
                Rec91.GET(USERID);
                IF NOT Rec91."Permite modif. objetivos" THEN BEGIN
                     ERROR('No puede modificar.');
                END;
                */

            end;
        }
        field(102; "Objetivo 3"; Text[50])
        {

            trigger OnValidate()
            begin
                /*
                Rec91.GET(USERID);
                IF NOT Rec91."Permite modif. objetivos" THEN BEGIN
                     ERROR('No puede modificar.');
                END;
                */

            end;
        }
        field(103; "Objetivo 4"; Text[50])
        {

            trigger OnValidate()
            begin
                /*
                Rec91.GET(USERID);
                IF NOT Rec91."Permite modif. objetivos" THEN BEGIN
                     ERROR('No puede modificar.');
                END;
                */

            end;
        }
        field(104; "Objetivo 5"; Text[50])
        {

            trigger OnValidate()
            begin
                /*
                Rec91.GET(USERID);
                IF NOT Rec91."Permite modif. objetivos" THEN BEGIN
                     ERROR('No puede modificar.');
                END;
                */

            end;
        }
        field(105; "Resultado 1"; Text[100])
        {
        }
        field(106; "Resultado 2"; Text[100])
        {
        }
        field(107; "Resultado 3"; Text[100])
        {
        }
        field(108; "Resultado 4"; Text[100])
        {
        }
        field(109; "Resultado 5"; Text[100])
        {
        }
        field(110; "Suma pb"; Decimal)
        {
        }
        field(111; "Suma pf"; Decimal)
        {
        }
        field(112; "Descuento aplicado"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Vendedor, Desde, Hasta)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        FECHA: Date;
        Rec91: Record "User Setup";
}

