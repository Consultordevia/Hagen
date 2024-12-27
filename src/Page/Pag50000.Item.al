#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50000 Item
{
    PageType = List;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(f9)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var 
                    Rec1: record Item;
                    codprod: code[20];
                    url: Text[1000];
                    Item: Record Item;
                    Client: HttpClient;
                    Content: HttpContent;
                    Response: HttpResponseMessage;
                    InStr: InStream;
                    PictureURL: Text;
                begin

                    PictureURL:=url;
                Client.Get(PictureURL, Response);                         
                Response.Content.ReadAs(InStr);
        Clear(Rec1.Picture);                        
        Rec1.Picture.ImportStream(InStr, Format(Rec1."No."));     
                    v.Open('#1####################################');
                    Item.Reset;
                    if Item.FindFirst then repeat
                      Item.Modify(true);
                      v.Update(1,Item."No.");
                      until Item.Next=0;

                    v.Close;
                    Message('hecho');

                end;
            }
        }
    }

    var
        Item: Record Item;
        v: Dialog;
}

