pageextension 50066 FichaClientesExt extends "Customer List"
{
    layout
    {
        addafter(GLN)
        {
            field(Plantilla_Cliente; Rec.Plantilla_Cliente)
            {
                ApplicationArea = all;
            }
        }
    }
}
