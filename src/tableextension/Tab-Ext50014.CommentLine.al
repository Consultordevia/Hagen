tableextension 50014 CommentLine extends "Comment Line"
{
    fields
    {
        field(50000; "Fecha alta"; Date)
        {
            Editable = false;
        }
        field(50001; "Usuario alta"; Code[10])
        {
            Editable = false;
            TableRelation = User;
        }
        field(50002; "Hora alta"; Time)
        {
            Editable = false;
        }
    }
}
