#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50050 "Log envios web clientes"
{

    fields
    {
        field(1;contador;Integer)
        {
            AutoIncrement = true;
        }
        field(2;tipo;Code[20])
        {
        }
        field(3;fecha;DateTime)
        {
        }
        field(4;dato;Code[30])
        {
        }
        field(5;envio;Text[250])
        {
        }
        field(6;respuesta;Text[250])
        {
        }
        field(7;envio2;Text[250])
        {
        }
        field(8;envio3;Text[250])
        {
        }
        field(9;envio4;Text[250])
        {
        }
        field(10;envio5;Text[250])
        {
        }
        field(11;envio6;Text[250])
        {
        }
        field(12;respuesta2;Text[250])
        {
        }
        field(13;respuesta3;Text[250])
        {
        }
    }

    keys
    {
        key(Key1;contador)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        conta:=1;
        if Logenviosweb.FindLast then begin
          conta:=Logenviosweb.contador+1;
        end;
        contador:=conta;
    end;

    var
        Logenviosweb: Record "Log envios web clientes";
        conta: Integer;
}

