pageextension 50067 histabonoventa extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = all;
            }
        }
    }
}
