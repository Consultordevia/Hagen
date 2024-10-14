#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50014 "Objetivos vendedores"
{

    fields
    {
        field(1; Vendedor; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(2; Tipo; Option)
        {
            OptionCaption = 'Vendedor,Zonas,Lineas,Referencia,Familia,Descuento,Visitas,Entregas a cuentas,Imp DATOS,Recu.imp DATOS,Por impa,Por impa-recu,Vendedor-meses,Vendedordia,Hagen,NoHagen,Vendedor-mesesNoHagen,Comi-dto,Plus';
            OptionMembers = Vendedor,Zonas,Lineas,Referencia,Familia,Descuento,Visitas,"Entregas a cuentas","Imp DATOS","Recu.imp DATOS","Por impa","Por impa-recu","Vendedor-meses",Vendedordia,Hagen,NoHagen,"Vendedor-mesesNoHagen","Comi-dto",Plus;
        }
        field(3; "Código"; Code[30])
        {
            TableRelation = if (Tipo = const(Vendedor)) "Salesperson/Purchaser".Code where(Code = field(Código))
            else if (Tipo = const(Lineas)) "Gen. Product Posting Group".Code where(Code = field(Código))
            else if (Tipo = const(Referencia)) Item."No." where("No." = field(Código))
            else if (Tipo = const(Zonas)) Multitabla.Codigo where(Tabla = const("Zona de ventas"),
                                                                                 Codigo = field(Código))
            else if (Tipo = const(Familia)) Familias.Familia where(Familia = field(Código))
            else if (Tipo = const(Descuento)) "Salesperson/Purchaser".Code where(Code = field(Código))
            else if (Tipo = const(Hagen)) "Salesperson/Purchaser".Code where(Code = field(Código))
            else if (Tipo = const(NoHagen)) "Salesperson/Purchaser".Code where(Code = field(Código))
            else if (Tipo = const("Comi-dto")) "Customer Discount Group".Code where(Code = field(Código))
            else if (Tipo = const(Plus)) Item."No." where("No." = field(Código));
        }
        field(4; "Año"; Integer)
        {
        }
        field(5; Enero; Integer)
        {

            trigger OnValidate()
            begin



                SUMA;
                /*
                
                IF Tipo=0 THEN BEGIN
                     CODM:=FORMAT('1')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,12);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Enero;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=12;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Enero;
                          Rec1.DiaObje:=DMY2DATE(1,1,Año);
                          Rec1.INSERT;
                     END;
                     aldia:=ROUND(Enero/31,1);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,13);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN REPEAT
                          Rec1.DELETE;
                     UNTIL Rec1.NEXT=0;
                     XX:=0;
                     REPEAT
                          XX:=XX+1;
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=13;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=aldia;
                          Rec1.DiaObje:=DMY2DATE(XX,1,Año);
                          Rec1.INSERT;
                     UNTIL XX=31;
                END;
                
                IF Tipo=15 THEN BEGIN
                     CODM:=FORMAT('1')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,16);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Enero;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=16;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Enero;
                          Rec1.DiaObje:=DMY2DATE(1,1,Año);
                          Rec1.INSERT;
                     END;
                END;
                */

            end;
        }
        field(6; Febrero; Integer)
        {

            trigger OnValidate()
            begin

                SUMA;
                /*
                
                IF Tipo=0 THEN BEGIN
                     CODM:=FORMAT('2')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,12);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Febrero;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=12;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Febrero;
                          Rec1.DiaObje:=DMY2DATE(1,2,Año);
                          Rec1.INSERT;
                     END;
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,13);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN REPEAT
                          Rec1.DELETE;
                     UNTIL Rec1.NEXT=0;
                
                     aldia:=ROUND(Febrero/28,1);
                     XX:=0;
                     REPEAT
                          XX:=XX+1;
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=13;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=aldia;
                          Rec1.DiaObje:=DMY2DATE(XX,2,Año);
                          Rec1.INSERT;
                     UNTIL XX=28;
                END;
                
                IF Tipo=15 THEN BEGIN
                     CODM:=FORMAT('2')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,16);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Febrero;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=16;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Febrero;
                          Rec1.DiaObje:=DMY2DATE(1,2,Año);
                          Rec1.INSERT;
                     END;
                END;
                */

            end;
        }
        field(7; Marzo; Integer)
        {

            trigger OnValidate()
            begin

                SUMA;
                /*
                
                IF Tipo=0 THEN BEGIN
                     CODM:=FORMAT('3')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,12);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Marzo;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=12;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Marzo;
                          Rec1.DiaObje:=DMY2DATE(1,3,Año);
                          Rec1.INSERT;
                     END;
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,13);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN REPEAT
                          Rec1.DELETE;
                     UNTIL Rec1.NEXT=0;
                
                     aldia:=ROUND(Marzo/31,1);
                     XX:=0;
                     REPEAT
                          XX:=XX+1;
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=13;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=aldia;
                          Rec1.DiaObje:=DMY2DATE(XX,3,Año);
                          Rec1.INSERT;
                     UNTIL XX=31;
                END;
                IF Tipo=15 THEN BEGIN
                     CODM:=FORMAT('3')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,16);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Marzo;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=16;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Marzo;
                          Rec1.DiaObje:=DMY2DATE(1,3,Año);
                          Rec1.INSERT;
                     END;
                END;
                */

            end;
        }
        field(8; Abril; Integer)
        {

            trigger OnValidate()
            begin


                SUMA;
                /*
                
                IF Tipo=0 THEN BEGIN
                     CODM:=FORMAT('4')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,12);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Abril;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=12;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Abril;
                          Rec1.DiaObje:=DMY2DATE(1,4,Año);
                          Rec1.INSERT;
                     END;
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,13);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN REPEAT
                          Rec1.DELETE;
                     UNTIL Rec1.NEXT=0;
                
                     aldia:=ROUND(Abril/30,1);
                     XX:=0;
                     REPEAT
                          XX:=XX+1;
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=13;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=aldia;
                          Rec1.DiaObje:=DMY2DATE(XX,4,Año);
                          Rec1.INSERT;
                     UNTIL XX=30;
                
                END;
                
                IF Tipo=15 THEN BEGIN
                     CODM:=FORMAT('4')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,16);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Abril;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=16;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Abril;
                          Rec1.DiaObje:=DMY2DATE(1,4,Año);
                          Rec1.INSERT;
                     END;
                END;
                */

            end;
        }
        field(9; Mayo; Integer)
        {

            trigger OnValidate()
            begin

                SUMA;
                /*
                
                IF Tipo=0 THEN BEGIN
                     CODM:=FORMAT('5')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,12);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Mayo;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=12;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Mayo;
                          Rec1.DiaObje:=DMY2DATE(1,5,Año);
                          Rec1.INSERT;
                     END;
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,13);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN REPEAT
                          Rec1.DELETE;
                     UNTIL Rec1.NEXT=0;
                
                     aldia:=ROUND(Mayo/31,1);
                     XX:=0;
                     REPEAT
                          XX:=XX+1;
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=13;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=aldia;
                          Rec1.DiaObje:=DMY2DATE(XX,5,Año);
                          Rec1.INSERT;
                     UNTIL XX=31;
                
                END;
                
                IF Tipo=15 THEN BEGIN
                     CODM:=FORMAT('5')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,16);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Mayo;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=16;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Mayo;
                          Rec1.DiaObje:=DMY2DATE(1,5,Año);
                          Rec1.INSERT;
                     END;
                END;
                */

            end;
        }
        field(10; Junio; Integer)
        {

            trigger OnValidate()
            begin

                SUMA;
                /*
                
                IF Tipo=0 THEN BEGIN
                     CODM:=FORMAT('6')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,12);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Junio;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=12;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Junio;
                          Rec1.DiaObje:=DMY2DATE(1,6,Año);
                          Rec1.INSERT;
                     END;
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,13);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN REPEAT
                          Rec1.DELETE;
                     UNTIL Rec1.NEXT=0;
                
                     aldia:=ROUND(Junio/30,1);
                     XX:=0;
                     REPEAT
                          XX:=XX+1;
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=13;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=aldia;
                          Rec1.DiaObje:=DMY2DATE(XX,6,Año);
                          Rec1.INSERT;
                     UNTIL XX=30;
                
                END;
                
                IF Tipo=15 THEN BEGIN
                     CODM:=FORMAT('6')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,16);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Junio;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=16;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Junio;
                          Rec1.DiaObje:=DMY2DATE(1,6,Año);
                          Rec1.INSERT;
                     END;
                
                END;
                */

            end;
        }
        field(11; Julio; Integer)
        {

            trigger OnValidate()
            begin

                SUMA;
                /*
                
                IF Tipo=0 THEN BEGIN
                     CODM:=FORMAT('7')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,12);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Julio;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=12;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Julio;
                          Rec1.DiaObje:=DMY2DATE(1,7,Año);
                          Rec1.INSERT;
                     END;
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,13);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN REPEAT
                          Rec1.DELETE;
                     UNTIL Rec1.NEXT=0;
                
                     aldia:=ROUND(Julio/31,1);
                     XX:=0;
                     REPEAT
                          XX:=XX+1;
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=13;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=aldia;
                          Rec1.DiaObje:=DMY2DATE(XX,7,Año);
                          Rec1.INSERT;
                     UNTIL XX=31;
                END;
                IF Tipo=15 THEN BEGIN
                     CODM:=FORMAT('7')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,16);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Julio;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=16;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Julio;
                          Rec1.DiaObje:=DMY2DATE(1,7,Año);
                          Rec1.INSERT;
                     END;
                END;
                */

            end;
        }
        field(12; Agosto; Integer)
        {

            trigger OnValidate()
            begin


                SUMA;

                /*
                IF Tipo=0 THEN BEGIN
                     CODM:=FORMAT('8')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,12);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Agosto;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=12;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Agosto;
                          Rec1.DiaObje:=DMY2DATE(1,8,Año);
                          Rec1.INSERT;
                     END;
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,13);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN REPEAT
                          Rec1.DELETE;
                     UNTIL Rec1.NEXT=0;
                
                     aldia:=ROUND(Agosto/31,1);
                     XX:=0;
                     REPEAT
                          XX:=XX+1;
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=13;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=aldia;
                          Rec1.DiaObje:=DMY2DATE(XX,8,Año);
                          Rec1.INSERT;
                     UNTIL XX=31;
                END;
                IF Tipo=15 THEN BEGIN
                     CODM:=FORMAT('8')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,16);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Agosto;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=16;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Agosto;
                          Rec1.DiaObje:=DMY2DATE(1,8,Año);
                          Rec1.INSERT;
                     END;
                END;
                */

            end;
        }
        field(13; Septiembre; Integer)
        {

            trigger OnValidate()
            begin


                SUMA;

                /*
                
                
                IF Tipo=0 THEN BEGIN
                     CODM:=FORMAT('9')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,12);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Septiembre;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=12;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Septiembre;
                          Rec1.DiaObje:=DMY2DATE(1,9,Año);
                          Rec1.INSERT;
                     END;
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,13);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN REPEAT
                          Rec1.DELETE;
                     UNTIL Rec1.NEXT=0;
                
                     aldia:=ROUND(Septiembre/30,1);
                     XX:=0;
                     REPEAT
                          XX:=XX+1;
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=13;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=aldia;
                          Rec1.DiaObje:=DMY2DATE(XX,9,Año);
                          Rec1.INSERT;
                     UNTIL XX=30;
                
                
                END;
                
                IF Tipo=15 THEN BEGIN
                     CODM:=FORMAT('9')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,16);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Septiembre;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=16;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Septiembre;
                          Rec1.DiaObje:=DMY2DATE(1,9,Año);
                          Rec1.INSERT;
                     END;
                
                END;
                */

            end;
        }
        field(14; Octubre; Integer)
        {

            trigger OnValidate()
            begin

                SUMA;
                /*
                
                IF Tipo=0 THEN BEGIN
                     CODM:=FORMAT('10')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,12);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Octubre;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=12;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Octubre;
                          Rec1.DiaObje:=DMY2DATE(1,10,Año);
                          Rec1.INSERT;
                     END;
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,13);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN REPEAT
                          Rec1.DELETE;
                     UNTIL Rec1.NEXT=0;
                
                     aldia:=ROUND(Octubre/31,1);
                     XX:=0;
                     REPEAT
                          XX:=XX+1;
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=13;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=aldia;
                          Rec1.DiaObje:=DMY2DATE(XX,10,Año);
                          Rec1.INSERT;
                     UNTIL XX=31;
                
                END;
                
                IF Tipo=15 THEN BEGIN
                     CODM:=FORMAT('10')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,16);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Octubre;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=16;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Octubre;
                          Rec1.DiaObje:=DMY2DATE(1,10,Año);
                          Rec1.INSERT;
                     END;
                
                END;
                */

            end;
        }
        field(15; Noviembre; Integer)
        {

            trigger OnValidate()
            begin

                SUMA;
                /*
                
                IF Tipo=0 THEN BEGIN
                     CODM:=FORMAT('11')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,12);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Noviembre;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=12;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Noviembre;
                          Rec1.DiaObje:=DMY2DATE(1,11,Año);
                          Rec1.INSERT;
                     END;
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,13);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN REPEAT
                          Rec1.DELETE;
                     UNTIL Rec1.NEXT=0;
                
                     aldia:=ROUND(Noviembre/30,1);
                     XX:=0;
                     REPEAT
                          XX:=XX+1;
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=13;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=aldia;
                          Rec1.DiaObje:=DMY2DATE(XX,11,Año);
                          Rec1.INSERT;
                     UNTIL XX=30;
                END;
                IF Tipo=15 THEN BEGIN
                     CODM:=FORMAT('11')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,16);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Noviembre;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=16;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Noviembre;
                          Rec1.DiaObje:=DMY2DATE(1,11,Año);
                          Rec1.INSERT;
                     END;
                END;
                */

            end;
        }
        field(16; Diciembre; Integer)
        {

            trigger OnValidate()
            begin


                SUMA;
                /*
                
                IF Tipo=0 THEN BEGIN
                     CODM:=FORMAT('12')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,12);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Diciembre;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=12;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Diciembre;
                          Rec1.DiaObje:=DMY2DATE(1,12,Año);
                          Rec1.INSERT;
                     END;
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,13);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN REPEAT
                          Rec1.DELETE;
                     UNTIL Rec1.NEXT=0;
                
                     aldia:=ROUND(Diciembre/31,1);
                     XX:=0;
                     REPEAT
                          XX:=XX+1;
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=13;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=aldia;
                          Rec1.DiaObje:=DMY2DATE(XX,12,Año);
                          Rec1.INSERT;
                     UNTIL XX=31;
                END;
                
                IF Tipo=15 THEN BEGIN
                     CODM:=FORMAT('12')+'-'+FORMAT(Año);
                     Rec1.RESET;
                     Rec1.SETRANGE(Rec1.Vendedor,Vendedor);
                     Rec1.SETRANGE(Rec1.Tipo,16);
                     Rec1.SETRANGE(Rec1.Código,CODM);
                     Rec1.SETRANGE(Rec1.Año,Año);
                     IF Rec1.FINDFIRST THEN BEGIN
                          Rec1.Enero:=Diciembre;
                          Rec1.MODIFY;
                     END;
                     IF NOT Rec1.FINDFIRST THEN BEGIN
                          Rec1.INIT;
                          Rec1.Vendedor:=Vendedor;
                          Rec1.Tipo:=16;
                          Rec1.Código:=CODM;
                          Rec1.Año:=Año;
                          Rec1.Enero:=Diciembre;
                          Rec1.DiaObje:=DMY2DATE(1,12,Año);
                          Rec1.INSERT;
                     END;
                END;
                */

            end;
        }
        field(17; Anual; Integer)
        {
            Editable = false;
        }
        field(18; Texto; Text[50])
        {
            Enabled = false;
            FieldClass = FlowField;
        }
        field(20; "Importe tramos"; Decimal)
        {
        }
        field(21; "% Incremento por tramo"; Decimal)
        {
        }
        field(22; "% Decremento 1"; Decimal)
        {
        }
        field(23; "% Decremento 2"; Decimal)
        {
        }
        field(24; Desde; Date)
        {
        }
        field(25; "Decremento comisión"; Decimal)
        {
        }
        field(26; Porcentaje; Decimal)
        {
        }
        field(27; Importe; Decimal)
        {
        }
        field(28; "Descripicon producto"; Text[60])
        {
            CalcFormula = lookup(Item.Description where("No." = field(Código)));
            FieldClass = FlowField;
        }
        field(29; Cantidad; Integer)
        {
        }
        field(30; "Cantidad vendida"; Decimal)
        {
        }
        field(31; Hasta; Date)
        {
        }
        field(32; "Importe conseguido"; Decimal)
        {
        }
        field(33; "% objetivo conseguido"; Decimal)
        {
        }
        field(34; "% para calculo comision"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Vendedor, Tipo, "Código", "Año", Desde)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    local procedure SUMA()
    begin


        Anual := Enero + Febrero + Marzo + Abril + Mayo + Junio + Julio + Agosto + Septiembre + Octubre + Noviembre + Diciembre;
    end;
}

