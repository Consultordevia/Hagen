tableextension 50034 PaymentMethod extends "Payment Method"
{
    fields
    {
        field(50000; Reembolso; Boolean)
        {
        }
        field(50001; "Pago anticipado"; Boolean)
        {

            trigger OnValidate()
            begin
                /*Rec91.GET(USERID);
                IF NOT Rec91."Permite env.  ANTICIPOS" THEN BEGIN
                     ERROR('No tiene permiso para modificar esta forma de pago.');
                END;
                */

            end;
        }
        field(50002; "Cuenta gastos"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50003; "% gastos"; Decimal)
        {
        }
        field(50004; "Id Presta Shop"; Code[100])
        {
            Description = 'WEB';
        }
        field(50009; "Transferencia WEB"; Boolean)
        {
        }
        field(50010; "ID web"; Integer)
        {
        }
        field(50011; Shopyfi; Text[30])
        {
        }
    }
}
