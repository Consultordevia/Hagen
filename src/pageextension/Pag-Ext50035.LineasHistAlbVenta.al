pageextension 50035 LineasHistAlbVenta extends "Posted Sales Shpt. Subform"

{





    layout
    {

    }


    actions
    {
        addlast("&Line")
        {

            action(MarcarcomonoexcelAMAZON)
            {

                ApplicationArea = Suite;
                Caption = 'Marcar como no excel AMAZON';
                trigger OnAction()
                var
                    CodeAuto: Codeunit Automaticos;
                begin

                    CodeAuto.MarcarcomonoexcelAMAZON(Rec);


                end;
            }
            action(DesmarcarcomonoexcelAMAZON)
            {
                ApplicationArea = Suite;
                Caption = 'Desmarcar como no excel AMAZON';
                trigger OnAction()
                var
                    CodeAuto: Codeunit Automaticos;
                begin
                    CodeAuto.DesmarcarcomonoexcelAMAZON(Rec);

                end;
            }

        }


    }
}
