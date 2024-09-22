#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50100 "Fechas caducidad"
{
    PageType = List;
    SourceTable = Multitabla;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Producto;Rec.Producto)
                {
                    ApplicationArea = Basic;
                }
                field("Descripción";Rec.Descripción)
                {
                    ApplicationArea = Basic;
                }
                field("<6 meses";Rec."<6 meses")
                {
                    ApplicationArea = Basic;
                }
                field(">6 meses";Rec.">6 meses")
                {
                    ApplicationArea = Basic;
                }
                field(">7 meses";Rec.">7 meses")
                {
                    ApplicationArea = Basic;
                }
                field(">8 meses a 9 meses";Rec.">8 meses a 9 meses")
                {
                    ApplicationArea = Basic;
                }
                field("9 a 12 meses";Rec."9 a 12 meses")
                {
                    ApplicationArea = Basic;
                }
                field("12 a 18 meses";Rec."12 a 18 meses")
                {
                    ApplicationArea = Basic;
                }
                field("mas de 18 meses";Rec."mas de 18 meses")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        ClearAll;



        Multitabla.Reset;
        Multitabla.SetRange(Tabla,Multitabla.Tabla::Ubicaciones);
        if Multitabla.FindFirst then repeat
            Multitabla.Validate(Cantidad);
            Multitabla.">6 meses":=0;
            Multitabla."6 a 9 meses":=0;
            Multitabla."9 a 12 meses":=0;
            Multitabla."12 a 18 meses":=0;
            Multitabla."mas de 18 meses":=0;
            Multitabla."<6 meses":=0;
            Multitabla.">7 meses":=0;
            Multitabla.">8 meses a 9 meses":=0;
            Multitabla.Modify;
        until Multitabla.Next=0;


        Multitabla.Reset;
        Multitabla.SetRange(Tabla,Multitabla.Tabla::Ubicaciones);
        if Multitabla.FindFirst then repeat
            Multitabla.Validate(Cantidad);
            Multitabla.Modify;
        until Multitabla.Next=0;


        /////TextoSalida1:='ref;descripcion;< 6 meses;6 a 9 meses;9 a 12 meses;12 a 18 meses;mas de 18 meses';


        Item.Reset;
        Item.SetRange("Criterio rotación",Item."criterio rotación"::FC);
        if Item.FindSet then repeat
          D1:=0;
          D2:=0;
          D3:=0;
          D4:=0;
          D5:=0;
          D6:=0;
          D7:=0;
          D8:=0;


            Multitabla.Reset;
            Multitabla.SetRange(Multitabla.Producto,Item."No.");
            Multitabla.SetRange(Tabla,Multitabla.Tabla::Ubicaciones);
            if Multitabla.FindFirst then repeat
                D1:=D1+Multitabla.">6 meses";
                D2:=D2+Multitabla."6 a 9 meses";
                D3:=D3+Multitabla."9 a 12 meses";
                D4:=D4+Multitabla."12 a 18 meses";
                D5:=D5+Multitabla."mas de 18 meses";
                D6:=D6+Multitabla."<6 meses";
                D7:=D7+Multitabla.">7 meses";
                D8:=D8+Multitabla.">8 meses a 9 meses";
            until Multitabla.Next=0;




        if (D1<>0) or
           (D2<>0) or
           (D3<>0) or
           (D4<>0) or
           (D5<>0) or
           (D6<>0) or
           (D7<>0) or
           (D8<>0) then begin





        Rec.Init;
        Rec.Tabla:=Rec.Tabla::Ubicaciones;
        Rec.Código:=Item."No.";
        Rec.Producto:=Item."No.";
        Rec.Descripción:=Item.Description;
        Rec.">6 meses":=D1;
        Rec."6 a 9 meses":=D2;
        Rec."9 a 12 meses":=D3;
        Rec."12 a 18 meses":=D4;
        Rec."mas de 18 meses":=D5;
        Rec."<6 meses":=D6;
        Rec.">7 meses":=D7;
        Rec.">8 meses a 9 meses":=D8;
        Rec.Insert;



                      end;

        until Item.Next=0;
    end;

    var
        Item: Record Item;
        Multitabla: Record Multitabla;
        D1: Integer;
        D2: Integer;
        D3: Integer;
        D4: Integer;
        D5: Integer;
        D6: Integer;
        D7: Integer;
        D8: Integer;
}

