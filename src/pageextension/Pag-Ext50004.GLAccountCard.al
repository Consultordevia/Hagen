pageextension 50004 "G/L Account Card" extends "G/L Account Card"
{
    layout
    {
        addlast(content)
        {
            group(Hagen)
            {


                field("Linea Retencion IRPF"; Rec."Linea Retencion IRPF")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}
