pageextension 50052 CrearAsiento extends "Cash Receipt Journal"
{

    ///(30124)

    actions
    {
        addlast(navigation)
        {

            action(CrearAsiento)
            {

                ApplicationArea = Suite;
                Caption = 'Crear Asiento';
                ShortCutKey = 'F9';
                trigger OnAction()
                var

                    Rec30124: Record "Shpfy Payment Transaction";


                begin





                end;
            }
        }
    }

}
