#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50143 "Post code"
{
    PageType = List;
    SourceTable = "Post Code";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(City;Rec.City)
                {
                    ApplicationArea = Basic;
                }
                field("Search City";Rec."Search City")
                {
                    ApplicationArea = Basic;
                }
                field("Country/Region Code";Rec."Country/Region Code")
                {
                    ApplicationArea = Basic;
                }
                field(County;Rec.County)
                {
                    ApplicationArea = Basic;
                }
                field("County Code";Rec."County Code")
                {
                    ApplicationArea = Basic;
                }
                field("Zona Venta";Rec."Zona Venta")
                {
                    ApplicationArea = Basic;
                }
                field(Pais;Rec.Pais)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(asd)
            {
                ApplicationArea = Basic;
                ShortCutKey = 'F9';

                trigger OnAction()
                begin
                    
                    
                    ventana.Open('#1####################');
                    
                    PostCode2.SetRange(PostCode2."Country/Region Code",'PT');
                    if PostCode2.FindFirst then repeat
                        if CopyStr(PostCode2.Code,5,1)=' ' then begin
                          ventana.Update(1,PostCode2.Code);
                            PostCode.Init;
                            PostCode:=PostCode2;
                            PostCode.Code:=CopyStr(PostCode2.Code,1,4)+'-'+CopyStr(PostCode2.Code,6);
                            if PostCode.Insert then;
                        end;
                    until PostCode2.Next=0;
                    
                    Message('HECHO');
                    
                    /*
                    IF SEPADirectDebitMandate.FINDFIRST THEN REPEAT
                    SEPADirectDebitMandate."Valid To":=20593112D;
                      SEPADirectDebitMandate.MODIFY;
                      UNTIL SEPADirectDebitMandate.NEXT=0;
                    
                    
                    
                    
                    ventana.OPEN('#1##################');
                    IF PostCode.FINDFIRST THEN REPEAT
                      ventana.UPDATE(1,PostCode.Code);
                         ///PostCode.VALIDATE("County Code");
                         ///PostCode.MODIFY;
                         ///COMMIT;
                         IF (PostCode."County Code"='01') OR
                            (PostCode."County Code"='02') OR
                             (PostCode."County Code"='03') OR
                      (PostCode."County Code"='04') OR
                      (PostCode."County Code"='05') OR
                      (PostCode."County Code"='06') OR
                      (PostCode."County Code"='07') OR
                      (PostCode."County Code"='08') OR
                      (PostCode."County Code"='09') OR
                      (PostCode."County Code"='10') OR
                      (PostCode."County Code"='11') OR
                      (PostCode."County Code"='12') OR
                      (PostCode."County Code"='13') OR
                      (PostCode."County Code"='14') OR
                      (PostCode."County Code"='15') OR
                      (PostCode."County Code"='16') OR
                      (PostCode."County Code"='17') OR
                      (PostCode."County Code"='18') OR
                      (PostCode."County Code"='19') OR
                      (PostCode."County Code"='20') OR
                      (PostCode."County Code"='21') OR
                      (PostCode."County Code"='22') OR
                      (PostCode."County Code"='23') OR
                      (PostCode."County Code"='24') OR
                      (PostCode."County Code"='25') OR
                      (PostCode."County Code"='26') OR
                      (PostCode."County Code"='27') OR
                      (PostCode."County Code"='28') OR
                      (PostCode."County Code"='29') OR
                      (PostCode."County Code"='30') OR
                      (PostCode."County Code"='31') OR
                      (PostCode."County Code"='32') OR
                      (PostCode."County Code"='33') OR
                      (PostCode."County Code"='34') OR
                      (PostCode."County Code"='35') OR
                      (PostCode."County Code"='36') OR
                      (PostCode."County Code"='37') OR
                      (PostCode."County Code"='38') OR
                      (PostCode."County Code"='39') OR
                      (PostCode."County Code"='40') OR
                      (PostCode."County Code"='41') OR
                      (PostCode."County Code"='42') OR
                      (PostCode."County Code"='43') OR
                      (PostCode."County Code"='44') OR
                      (PostCode."County Code"='45') OR
                      (PostCode."County Code"='46') OR
                      (PostCode."County Code"='47') OR
                      (PostCode."County Code"='48') OR
                      (PostCode."County Code"='49') OR
                      (PostCode."County Code"='50') OR
                      (PostCode."County Code"='51') OR
                      (PostCode."County Code"='52') THEN BEGIN
                    PostCode."Country/Region Code"  :='ES';
                    PostCode.MODIFY;
                      END;
                    
                    
                    
                    UNTIL PostCode.NEXT=0;
                    
                    ventana.CLOSE;
                    
                    
                    
                    
                    ventana.OPEN('#1##################');
                    IF PostCode.FINDFIRST THEN REPEAT
                      ventana.UPDATE(1,PostCode.Code);
                         ///PostCode.VALIDATE("County Code");
                         ///PostCode.MODIFY;
                         ///COMMIT;
                         IF (COPYSTR(PostCode."County Code",1,1)='P') THEN  BEGIN
                    PostCode."Country/Region Code"  :='PT';
                    PostCode.MODIFY;
                      END;
                    
                    
                    
                    UNTIL PostCode.NEXT=0;
                    
                    ventana.CLOSE;
                    
                    
                    
                    MESSAGE('asd');
                    
                    */

                end;
            }
        }
    }

    var
        PostCode: Record "Post Code";
        ventana: Dialog;
        SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
        PostCode2: Record "Post Code";
}

