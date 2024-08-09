#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50002 Tareas
{

    fields
    {
        field(1;Tarea;Integer)
        {
            AutoIncrement = true;
        }
        field(2;"Descripcion tarea";Text[60])
        {
        }
        field(3;Supervison;Option)
        {
            OptionCaption = ' ,Alexis,Ventas,Compras,Administración,Almacen';
            OptionMembers = " ",Alexis,Ventas,Compras,"Administración",Almacen;
        }
        field(4;Realizado;Boolean)
        {

            trigger OnValidate()
            begin
                if Realizado then begin
                     "Fecha realizado":=CreateDatetime(Today,Time);
                end;

                if not Realizado then begin
                     "Fecha realizado":=CreateDatetime(0D,0T);
                end;
            end;
        }
        field(5;"Datos transpasados";Boolean)
        {

            trigger OnValidate()
            begin

                if "Datos transpasados" then begin
                     "Fecha datos":=CreateDatetime(Today,Time);
                end;

                if not "Datos transpasados" then begin
                     "Fecha datos":=CreateDatetime(0D,0T);
                end;
            end;
        }
        field(6;Pruebas;Boolean)
        {

            trigger OnValidate()
            begin


                if Pruebas then begin
                     "Fecha pruebas":=CreateDatetime(Today,Time);
                end;

                if not Pruebas then begin
                     "Fecha pruebas":=CreateDatetime(0D,0T);
                end;
            end;
        }
        field(7;OK;Boolean)
        {

            trigger OnValidate()
            begin


                if OK then begin
                     "Fecha Ok":=CreateDatetime(Today,Time);
                end;

                if not OK then begin
                     "Fecha Ok":=CreateDatetime(0D,0T);
                end;
            end;
        }
        field(8;"Fecha creacion";DateTime)
        {
        }
        field(10;"Fecha realizado";DateTime)
        {
        }
        field(11;"Fecha datos";DateTime)
        {
        }
        field(12;"Fecha pruebas";DateTime)
        {
        }
        field(13;"Fecha Ok";DateTime)
        {
        }
        field(14;Observacion;Text[200])
        {
        }
    }

    keys
    {
        key(Key1;Tarea)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        "Fecha creacion":=CreateDatetime(Today,Time);
    end;
}

