page 50128 CaducidadesProductos
{
    ApplicationArea = All;
    Caption = '';
    PageType = List;
    SourceTable = Item;
    UsageCategory = Lists;









    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                { }
                field(Description; Rec.Description)
                { }
                field(cuantos0; cuantos0)
                {
                }
                field(cuantos30; cuantos30)
                { }
                field(cuantos60; cuantos60)
                { }
                field(cuantos90; cuantos90)
                { }
                field(cuantos120; cuantos120)
                { }




            }
        }

    }
    var
        cuantos30: Decimal;
        cuantos60: Decimal;
        cuantos90: Decimal;
        cuantos120: Decimal;
        cuantos0: Decimal;
        RecMT: Record Multitabla;
        dias: Integer;

    trigger OnAfterGetRecord()
    begin
        cuantos30 := 0;
        cuantos60 := 0;
        cuantos90 := 0;
        cuantos120 := 0;
        cuantos0 := 0;

        RecMT.Reset();
        RecMT.SetRange(Tabla, RecMT.Tabla::Ubicaciones);
        RecMT.SetRange(Producto, Rec."No.");
        if RecMT.FindSet() then
            repeat
                if RecMT."Fecha caducidad" <> 0D THEN begin
                    dias := RecMT."Fecha caducidad" - Today;
                    if dias < 0 then begin
                        cuantos0 := cuantos0 + RecMT.Cantidad;
                    end;
                    if (dias > 0) and (dias <= 30) then begin
                        cuantos30 := cuantos30 + RecMT.Cantidad;
                    end;
                    if (dias > 30) and (dias <= 60) then begin
                        cuantos60 := cuantos60 + RecMT.Cantidad;
                    end;
                    if (dias > 60) and (dias <= 90) then begin
                        cuantos90 := cuantos90 + RecMT.Cantidad;
                    end;
                    if (dias > 90) and (dias <= 120) then begin
                        cuantos120 := cuantos120 + RecMT.Cantidad;
                    end;




                end;

            until RecMT.next = 0;



    end;


}
