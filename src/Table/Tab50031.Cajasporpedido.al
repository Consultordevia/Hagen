#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50031 "Cajas por pedido"
{

    fields
    {
        field(1;"Código 1";Code[20])
        {
        }
        field(2;"Código 2";Code[20])
        {
            TableRelation = "Tipo caja"."Tipo caja";

            trigger OnValidate()
            begin
                /*
                
                IF Tabla<>6 THEN BEGIN
                IF RecItem.GET("Código 2") THEN BEGIN
                     "Descripcion tecnica":=RecItem.Description;
                END;
                END;
                
                
                
                IF "Código 2"<>'' THEN BEGIN
                     RecMT22.CHANGECOMPANY('PEPE');
                     RecMT22.RESET;
                     RecMT22.SETRANGE(RecMT22.Tabla,4);
                     RecMT22.SETRANGE(RecMT22."Código 1",Rec."Código 1");
                     RecMT22.SETRANGE(RecMT22."Código 2",Rec."Código 2");
                     IF NOT RecMT22.FINDFIRST THEN REPEAT
                ///          RecMT22:=Rec;
                ///          RecMT22.INSERT;
                     UNTIL RecMT22.NEXT=0;
                
                END;
                
                IF Tabla=11 THEN BEGIN
                     IF "Código 2"<>'' THEN BEGIN
                          Customer.RESET;
                          Customer.SETCURRENTKEY(Customer."Post Code");
                          Customer.SETRANGE(Customer."Post Code","Código 2");
                          IF Customer.FINDFIRST THEN REPEAT
                               Customer."Ruta comercial":="Código 1";
                               Customer.MODIFY;
                          UNTIL Customer.NEXT=0;
                     END;
                END;
                */

            end;
        }
        field(3;"Cantidad caja";Integer)
        {
        }
    }

    keys
    {
        key(Key1;"Código 1","Código 2","Cantidad caja")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

