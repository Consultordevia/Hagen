#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50130 "Amazon prevision"
{
    
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Amazon prevision";
/* /////-
    layout 
    {
        area(content)
        {
            repeater(Group)
            {
                field(d1;d1)
                {
                    ApplicationArea = Basic;
                }
                field(d2;d2)
                {
                    ApplicationArea = Basic;
                }
                field(d3;d3)
                {
                    ApplicationArea = Basic;
                }
                field(d4;d4)
                {
                    ApplicationArea = Basic;
                }
                field(d5;d5)
                {
                    ApplicationArea = Basic;
                }
                field(d6;d6)
                {
                    ApplicationArea = Basic;
                }
                field(d7;d7)
                {
                    ApplicationArea = Basic;
                }
                field(d8;d8)
                {
                    ApplicationArea = Basic;
                }
                field(d9;d9)
                {
                    ApplicationArea = Basic;
                }
                field(d10;d10)
                {
                    ApplicationArea = Basic;
                }
                field(d11;d11)
                {
                    ApplicationArea = Basic;
                }
                field(d12;d12)
                {
                    ApplicationArea = Basic;
                }
                field(d13;d13)
                {
                    ApplicationArea = Basic;
                }
                field(d14;d14)
                {
                    ApplicationArea = Basic;
                }
                field(d15;d15)
                {
                    ApplicationArea = Basic;
                }
                field(d16;d16)
                {
                    ApplicationArea = Basic;
                }
                field(d17;d17)
                {
                    ApplicationArea = Basic;
                }
                field(d18;d18)
                {
                    ApplicationArea = Basic;
                }
                field(d19;d19)
                {
                    ApplicationArea = Basic;
                }
                field(d20;d20)
                {
                    ApplicationArea = Basic;
                }
                field(d21;d21)
                {
                    ApplicationArea = Basic;
                }
                field(d22;d22)
                {
                    ApplicationArea = Basic;
                }
                field(d23;d23)
                {
                    ApplicationArea = Basic;
                }
                field(d24;d24)
                {
                    ApplicationArea = Basic;
                }
                field(d25;d25)
                {
                    ApplicationArea = Basic;
                }
                field(d26;d26)
                {
                    ApplicationArea = Basic;
                }
                field(d27;d27)
                {
                    ApplicationArea = Basic;
                }
                field(d28;d28)
                {
                    ApplicationArea = Basic;
                }
                field(d29;d29)
                {
                    ApplicationArea = Basic;
                }
                field(d30;d30)
                {
                    ApplicationArea = Basic;
                }
                field(d31;d31)
                {
                    ApplicationArea = Basic;
                }
                field(d32;d32)
                {
                    ApplicationArea = Basic;
                }
                field(d33;d33)
                {
                    ApplicationArea = Basic;
                }
                field(d34;d34)
                {
                    ApplicationArea = Basic;
                }
                field(d35;d35)
                {
                    ApplicationArea = Basic;
                }
                field(d36;d36)
                {
                    ApplicationArea = Basic;
                }
                field(d37;d37)
                {
                    ApplicationArea = Basic;
                }
                field(d38;d38)
                {
                    ApplicationArea = Basic;
                }
                field(d39;d39)
                {
                    ApplicationArea = Basic;
                }
                field(d40;d40)
                {
                    ApplicationArea = Basic;
                }
                field(d41;d41)
                {
                    ApplicationArea = Basic;
                }
                field(d42;d42)
                {
                    ApplicationArea = Basic;
                }
                field(d43;d43)
                {
                    ApplicationArea = Basic;
                }
                field(d44;d44)
                {
                    ApplicationArea = Basic;
                }
                field(d45;d45)
                {
                    ApplicationArea = Basic;
                }
                field(d46;d46)
                {
                    ApplicationArea = Basic;
                }
                field(d47;d47)
                {
                    ApplicationArea = Basic;
                }
                field(d48;d48)
                {
                    ApplicationArea = Basic;
                }
                field(d49;d49)
                {
                    ApplicationArea = Basic;
                }
                field(d50;d50)
                {
                    ApplicationArea = Basic;
                }
                field(d51;d51)
                {
                    ApplicationArea = Basic;
                }
                field(d52;d52)
                {
                    ApplicationArea = Basic;
                }
                field(d53;d53)
                {
                    ApplicationArea = Basic;
                }
                field(d54;d54)
                {
                    ApplicationArea = Basic;
                }
                field(d55;d55)
                {
                    ApplicationArea = Basic;
                }
                field(d56;d56)
                {
                    ApplicationArea = Basic;
                }
                field(d57;d57)
                {
                    ApplicationArea = Basic;
                }
                field(d58;d58)
                {
                    ApplicationArea = Basic;
                }
                field(d59;d59)
                {
                    ApplicationArea = Basic;
                }
                field(d60;d60)
                {
                    ApplicationArea = Basic;
                }
                field(d61;d61)
                {
                    ApplicationArea = Basic;
                }
                field(d62;d62)
                {
                    ApplicationArea = Basic;
                }
                field(d63;d63)
                {
                    ApplicationArea = Basic;
                }
                field(d64;d64)
                {
                    ApplicationArea = Basic;
                }
                field(d65;d65)
                {
                    ApplicationArea = Basic;
                }
                field(d66;d66)
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
            action(Recalcula)
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Add;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin


                    Amazonprevision.Reset;
                    if Amazonprevision.FindFirst then repeat
                        if Amazonprevision.conta=10000 then begin
                        end;



                        if Amazonprevision.conta>10000 then begin
                            if Amazonprevision.d3<>'' then begin Evaluate(Amazonprevision.dd1,Amazonprevision.d3);end;
                            if Amazonprevision.d4<>'' then begin Evaluate(Amazonprevision.dd2,Amazonprevision.d4);end;
                            if Amazonprevision.d5<>'' then begin Evaluate(Amazonprevision.dd3,Amazonprevision.d5);end;

                            if Amazonprevision.d15<>'' then begin Evaluate(Amazonprevision.c1,Amazonprevision.d15);end;
                            if Amazonprevision.d16<>'' then begin Evaluate(Amazonprevision.c2,Amazonprevision.d16);end;
                            if Amazonprevision.d17<>'' then begin Evaluate(Amazonprevision.c3,Amazonprevision.d17);end;
                            if Amazonprevision.d18<>'' then begin Evaluate(Amazonprevision.c4,Amazonprevision.d18);end;
                            if Amazonprevision.d19<>'' then begin Evaluate(Amazonprevision.c5,Amazonprevision.d19);end;
                            if Amazonprevision.d20<>'' then begin Evaluate(Amazonprevision.c6,Amazonprevision.d20);end;
                            if Amazonprevision.d21<>'' then begin Evaluate(Amazonprevision.c7,Amazonprevision.d21);end;
                            if Amazonprevision.d22<>'' then begin Evaluate(Amazonprevision.c8,Amazonprevision.d22);end;
                            if Amazonprevision.d23<>'' then begin Evaluate(Amazonprevision.c9,Amazonprevision.d23);end;
                            if Amazonprevision.d24<>'' then begin Evaluate(Amazonprevision.c10,Amazonprevision.d24);end;
                            if Amazonprevision.d25<>'' then begin Evaluate(Amazonprevision.c11,Amazonprevision.d25);end;


                            if Amazonprevision.d26<>'' then begin Evaluate(Amazonprevision.c12,Amazonprevision.d26);end;
                            if Amazonprevision.d27<>'' then begin Evaluate(Amazonprevision.c13,Amazonprevision.d27);end;
                            if Amazonprevision.d28<>'' then begin Evaluate(Amazonprevision.c14,Amazonprevision.d28);end;
                            if Amazonprevision.d29<>'' then begin Evaluate(Amazonprevision.c15,Amazonprevision.d29);end;
                            if Amazonprevision.d30<>'' then begin Evaluate(Amazonprevision.c16,Amazonprevision.d30);end;
                            if Amazonprevision.d31<>'' then begin Evaluate(Amazonprevision.c17,Amazonprevision.d31);end;
                            if Amazonprevision.d32<>'' then begin Evaluate(Amazonprevision.c18,Amazonprevision.d32);end;
                            if Amazonprevision.d33<>'' then begin Evaluate(Amazonprevision.c19,Amazonprevision.d33);end;
                            if Amazonprevision.d34<>'' then begin Evaluate(Amazonprevision.c20,Amazonprevision.d34);end;
                            if Amazonprevision.d35<>'' then begin Evaluate(Amazonprevision.c21,Amazonprevision.d35);end;


                            if Amazonprevision.d36<>'' then begin Evaluate(Amazonprevision.c22,Amazonprevision.d36);end;
                            if Amazonprevision.d37<>'' then begin Evaluate(Amazonprevision.c23,Amazonprevision.d37);end;
                            if Amazonprevision.d38<>'' then begin Evaluate(Amazonprevision.c24,Amazonprevision.d38);end;
                            if Amazonprevision.d39<>'' then begin Evaluate(Amazonprevision.c25,Amazonprevision.d39);end;
                            if Amazonprevision.d40<>'' then begin Evaluate(Amazonprevision.c26,Amazonprevision.d40);end;
                            if Amazonprevision.d41<>'' then begin Evaluate(Amazonprevision.c27,Amazonprevision.d41);end;
                            if Amazonprevision.d42<>'' then begin Evaluate(Amazonprevision.c28,Amazonprevision.d42);end;
                            if Amazonprevision.d43<>'' then begin Evaluate(Amazonprevision.c29,Amazonprevision.d43);end;
                            if Amazonprevision.d44<>'' then begin Evaluate(Amazonprevision.c30,Amazonprevision.d44);end;
                            if Amazonprevision.d45<>'' then begin Evaluate(Amazonprevision.c31,Amazonprevision.d45);end;


                            if Amazonprevision.d46<>'' then begin Evaluate(Amazonprevision.c32,Amazonprevision.d46);end;
                            if Amazonprevision.d47<>'' then begin Evaluate(Amazonprevision.c33,Amazonprevision.d47);end;
                            if Amazonprevision.d48<>'' then begin Evaluate(Amazonprevision.c34,Amazonprevision.d48);end;
                            if Amazonprevision.d49<>'' then begin Evaluate(Amazonprevision.c35,Amazonprevision.d49);end;
                            if Amazonprevision.d50<>'' then begin Evaluate(Amazonprevision.c36,Amazonprevision.d50);end;
                            if Amazonprevision.d51<>'' then begin Evaluate(Amazonprevision.c37,Amazonprevision.d51);end;
                            if Amazonprevision.d52<>'' then begin Evaluate(Amazonprevision.c38,Amazonprevision.d52);end;
                            if Amazonprevision.d53<>'' then begin Evaluate(Amazonprevision.c39,Amazonprevision.d53);end;
                            if Amazonprevision.d54<>'' then begin Evaluate(Amazonprevision.c40,Amazonprevision.d54);end;
                            if Amazonprevision.d55<>'' then begin Evaluate(Amazonprevision.c41,Amazonprevision.d55);end;


                            if Amazonprevision.d56<>'' then begin Evaluate(Amazonprevision.c42,Amazonprevision.d56);end;
                            if Amazonprevision.d57<>'' then begin Evaluate(Amazonprevision.c43,Amazonprevision.d57);end;
                            if Amazonprevision.d58<>'' then begin Evaluate(Amazonprevision.c44,Amazonprevision.d58);end;
                            if Amazonprevision.d59<>'' then begin Evaluate(Amazonprevision.c45,Amazonprevision.d59);end;
                            if Amazonprevision.d60<>'' then begin Evaluate(Amazonprevision.c46,Amazonprevision.d60);end;
                            if Amazonprevision.d61<>'' then begin Evaluate(Amazonprevision.c47,Amazonprevision.d61);end;
                            if Amazonprevision.d62<>'' then begin Evaluate(Amazonprevision.c48,Amazonprevision.d62);end;
                            if Amazonprevision.d63<>'' then begin Evaluate(Amazonprevision.c49,Amazonprevision.d63);end;
                            if Amazonprevision.d64<>'' then begin Evaluate(Amazonprevision.c50,Amazonprevision.d64);end;
                            if Amazonprevision.d65<>'' then begin Evaluate(Amazonprevision.c51,Amazonprevision.d65);end;
                            if Amazonprevision.d66<>'' then begin Evaluate(Amazonprevision.c52,Amazonprevision.d66);end;


                            DSUMATEN60:=0;
                            DSUMATEN90:=0;
                            DSUMATEN180:=0;
                            DSUMATEN360:=0;
                            Amazonprevision2.Reset;
                            if Amazonprevision2.FindFirst then begin
                                FechaCod:=Amazonprevision2.d15;DatoCod:=Amazonprevision.d15;Prevision;
                                FechaCod:=Amazonprevision2.d16;DatoCod:=Amazonprevision.d16;Prevision;
                                FechaCod:=Amazonprevision2.d17;DatoCod:=Amazonprevision.d17;Prevision;
                                FechaCod:=Amazonprevision2.d18;DatoCod:=Amazonprevision.d18;Prevision;
                                FechaCod:=Amazonprevision2.d19;DatoCod:=Amazonprevision.d19;Prevision;
                                FechaCod:=Amazonprevision2.d20;DatoCod:=Amazonprevision.d20;Prevision;
                                FechaCod:=Amazonprevision2.d21;DatoCod:=Amazonprevision.d21;Prevision;
                                FechaCod:=Amazonprevision2.d22;DatoCod:=Amazonprevision.d22;Prevision;
                                FechaCod:=Amazonprevision2.d23;DatoCod:=Amazonprevision.d23;Prevision;
                                FechaCod:=Amazonprevision2.d24;DatoCod:=Amazonprevision.d24;Prevision;
                                FechaCod:=Amazonprevision2.d25;DatoCod:=Amazonprevision.d25;Prevision;
                                FechaCod:=Amazonprevision2.d26;DatoCod:=Amazonprevision.d26;Prevision;
                                FechaCod:=Amazonprevision2.d27;DatoCod:=Amazonprevision.d27;Prevision;
                                FechaCod:=Amazonprevision2.d28;DatoCod:=Amazonprevision.d28;Prevision;
                                FechaCod:=Amazonprevision2.d29;DatoCod:=Amazonprevision.d29;Prevision;
                                FechaCod:=Amazonprevision2.d30;DatoCod:=Amazonprevision.d30;Prevision;
                                FechaCod:=Amazonprevision2.d31;DatoCod:=Amazonprevision.d31;Prevision;
                                FechaCod:=Amazonprevision2.d32;DatoCod:=Amazonprevision.d32;Prevision;
                                FechaCod:=Amazonprevision2.d33;DatoCod:=Amazonprevision.d33;Prevision;
                                FechaCod:=Amazonprevision2.d34;DatoCod:=Amazonprevision.d34;Prevision;
                                FechaCod:=Amazonprevision2.d35;DatoCod:=Amazonprevision.d35;Prevision;
                                FechaCod:=Amazonprevision2.d36;DatoCod:=Amazonprevision.d36;Prevision;
                                FechaCod:=Amazonprevision2.d37;DatoCod:=Amazonprevision.d37;Prevision;
                                FechaCod:=Amazonprevision2.d38;DatoCod:=Amazonprevision.d38;Prevision;
                                FechaCod:=Amazonprevision2.d39;DatoCod:=Amazonprevision.d39;Prevision;
                                FechaCod:=Amazonprevision2.d40;DatoCod:=Amazonprevision.d40;Prevision;
                                FechaCod:=Amazonprevision2.d41;DatoCod:=Amazonprevision.d41;Prevision;
                                FechaCod:=Amazonprevision2.d42;DatoCod:=Amazonprevision.d42;Prevision;
                                FechaCod:=Amazonprevision2.d43;DatoCod:=Amazonprevision.d43;Prevision;
                                FechaCod:=Amazonprevision2.d44;DatoCod:=Amazonprevision.d44;Prevision;
                                FechaCod:=Amazonprevision2.d45;DatoCod:=Amazonprevision.d45;Prevision;
                                FechaCod:=Amazonprevision2.d46;DatoCod:=Amazonprevision.d46;Prevision;
                                FechaCod:=Amazonprevision2.d47;DatoCod:=Amazonprevision.d47;Prevision;
                                FechaCod:=Amazonprevision2.d48;DatoCod:=Amazonprevision.d48;Prevision;
                                FechaCod:=Amazonprevision2.d49;DatoCod:=Amazonprevision.d49;Prevision;
                                FechaCod:=Amazonprevision2.d50;DatoCod:=Amazonprevision.d50;Prevision;
                                FechaCod:=Amazonprevision2.d51;DatoCod:=Amazonprevision.d51;Prevision;
                                FechaCod:=Amazonprevision2.d52;DatoCod:=Amazonprevision.d52;Prevision;
                                FechaCod:=Amazonprevision2.d53;DatoCod:=Amazonprevision.d53;Prevision;
                                FechaCod:=Amazonprevision2.d54;DatoCod:=Amazonprevision.d54;Prevision;
                                FechaCod:=Amazonprevision2.d55;DatoCod:=Amazonprevision.d55;Prevision;
                                FechaCod:=Amazonprevision2.d56;DatoCod:=Amazonprevision.d56;Prevision;
                                FechaCod:=Amazonprevision2.d57;DatoCod:=Amazonprevision.d57;Prevision;
                                FechaCod:=Amazonprevision2.d58;DatoCod:=Amazonprevision.d58;Prevision;
                                FechaCod:=Amazonprevision2.d59;DatoCod:=Amazonprevision.d59;Prevision;
                                FechaCod:=Amazonprevision2.d60;DatoCod:=Amazonprevision.d60;Prevision;
                                FechaCod:=Amazonprevision2.d61;DatoCod:=Amazonprevision.d61;Prevision;
                                FechaCod:=Amazonprevision2.d62;DatoCod:=Amazonprevision.d62;Prevision;
                                FechaCod:=Amazonprevision2.d63;DatoCod:=Amazonprevision.d63;Prevision;
                                FechaCod:=Amazonprevision2.d64;DatoCod:=Amazonprevision.d64;Prevision;
                                FechaCod:=Amazonprevision2.d65;DatoCod:=Amazonprevision.d65;Prevision;
                                FechaCod:=Amazonprevision2.d66;DatoCod:=Amazonprevision.d66;Prevision;
                            end;
                            Amazonprevision.SUMATEN60:=DSUMATEN60;
                            Amazonprevision.SUMATEN90:=DSUMATEN90;
                            Amazonprevision.SUMATEN180:=DSUMATEN180;
                            Amazonprevision.SUMATEN360:=DSUMATEN360;



                            if Item.Get(Amazonprevision.Producto) then begin
                            Item.CalcFields(Inventory);
                            Item.CalcFields(Inventory,"Existencia FOB",Item."Existencia SILLA",Item."Qty. on Sales Order");
                            stockdis:=Item.Inventory-Item."Existencia FOB"-Item."Qty. on Sales Order"-Item."Stock para Catit";
                            Amazonprevision.d6:=Format(stockdis);
                            Calcula60dias;Amazonprevision.d7:=Format(CANTIDAD60);
                            Calcula90dias;Amazonprevision.d8:=Format(CANTIDAD90);
                            Calcula180dias;Amazonprevision.d9:=Format(CANTIDAD180);
                            Calcula360dias;Amazonprevision.d10:=Format(CANTIDAD360);
                            Evaluate(dd5,Amazonprevision.d5);
                            Amazonprevision.d11:=Format(dd5+stockdis+CANTIDAD60-DSUMATEN60);
                            Amazonprevision.d12:=Format(dd5+stockdis+CANTIDAD60+CANTIDAD90-DSUMATEN60-DSUMATEN90);
                            Amazonprevision.d13:=Format(dd5+stockdis+CANTIDAD60+CANTIDAD90+CANTIDAD180-DSUMATEN60-DSUMATEN90-DSUMATEN180);
                            Amazonprevision.d14:=Format(dd5+stockdis+CANTIDAD60+CANTIDAD90+CANTIDAD180+CANTIDAD360
                            -DSUMATEN60-DSUMATEN90-DSUMATEN180-DSUMATEN360);
                            end;

                        end;
                        Amazonprevision.Modify;
                    until Amazonprevision.Next=0;

                    Commit;
                end;
            }
        }
    }

    var
        Amazonprevision: Record UnknownRecord50048;
        Amazonprevision2: Record UnknownRecord50048;
        Item: Record Item;
        stockdis: Decimal;
        PurchaseLine: Record "Purchase Line";
        RecLC: Record "Purchase Line";
        DIAS60: Date;
        DIAS90: Date;
        DIAS180: Date;
        DIAS360: Date;
        CANTIDAD60: Decimal;
        CANTIDAD90: Decimal;
        CANTIDAD180: Decimal;
        CANTIDAD360: Decimal;
        FFCAD: Date;
        DIFDIAS: Decimal;
        "FAÑO": Code[10];
        "DAÑO": Decimal;
        FMES: Code[10];
        DMES: Decimal;
        FDIA: Code[10];
        DDIA: Decimal;
        SUMA60: Decimal;
        SUMA90: Decimal;
        SUMA180: Decimal;
        SUMA360: Decimal;
        CDD: Code[10];
        CMM: Code[10];
        CAA: Code[10];
        DD: Integer;
        MM: Integer;
        AA: Integer;
        FECHADESDE: Date;
        FECHAHASTA: Date;
        DSUMATEN60: Decimal;
        DSUMATEN90: Decimal;
        DSUMATEN180: Decimal;
        DSUMATEN360: Decimal;
        FechaCod: Code[100];
        DatoCod: Code[40];
        DatoDec: Decimal;
        salir: Boolean;
        dd5: Decimal;

    local procedure Calcula60dias()
    begin

            CANTIDAD60:=0;
            DIAS60:=CalcDate('+60D',Today);
            RecLC.SetCurrentkey(RecLC."Document Type",RecLC.Type,RecLC."No.");
            RecLC.SetRange(RecLC."Document Type",1);
            RecLC.SetRange(RecLC."No.",Item."No.");
            RecLC.SetRange("Expected Receipt Date",0D,DIAS60);
            if RecLC.FindFirst then repeat
                if RecLC."Outstanding Quantity"<>0 then begin
                    CANTIDAD60:=CANTIDAD60+RecLC."Outstanding Quantity";
                end;
            until RecLC.Next = 0;
            RecLC.SetCurrentkey(RecLC."Document Type",RecLC.Type,RecLC."No.");
            RecLC.SetRange(RecLC."Document Type",0);
            RecLC.SetRange(RecLC."No.",Item."No.");
            RecLC.SetRange("Expected Receipt Date",0D,DIAS60);
            if RecLC.FindFirst then repeat
                if RecLC."Outstanding Quantity"<>0 then begin
                    CANTIDAD60:=CANTIDAD60+RecLC."Outstanding Quantity";
                end;
            until RecLC.Next = 0;



    end;

    local procedure Calcula90dias()
    begin

            CANTIDAD90:=0;
            DIAS90:=CalcDate('+90D',Today);
            RecLC.SetCurrentkey(RecLC."Document Type",RecLC.Type,RecLC."No.");
            RecLC.SetRange(RecLC."Document Type",1);
            RecLC.SetRange(RecLC."No.",Item."No.");
            RecLC.SetRange("Expected Receipt Date",0D,DIAS90);
            if RecLC.FindFirst then repeat
                if RecLC."Outstanding Quantity"<>0 then begin
                    CANTIDAD90:=CANTIDAD90+RecLC."Outstanding Quantity";
                end;
            until RecLC.Next = 0;
            RecLC.SetCurrentkey(RecLC."Document Type",RecLC.Type,RecLC."No.");
            RecLC.SetRange(RecLC."Document Type",0);
            RecLC.SetRange(RecLC."No.",Item."No.");
            RecLC.SetRange("Expected Receipt Date",0D,DIAS90);
            if RecLC.FindFirst then repeat
                if RecLC."Outstanding Quantity"<>0 then begin
                    CANTIDAD90:=CANTIDAD90+RecLC."Outstanding Quantity";
                end;
            until RecLC.Next = 0;

             CANTIDAD90:=CANTIDAD90-CANTIDAD60;


    end;

    local procedure Calcula180dias()
    begin

            CANTIDAD180:=0;
            DIAS180:=CalcDate('+180D',Today);
            RecLC.SetCurrentkey(RecLC."Document Type",RecLC.Type,RecLC."No.");
            RecLC.SetRange(RecLC."Document Type",1);
            RecLC.SetRange(RecLC."No.",Item."No.");
            RecLC.SetRange("Expected Receipt Date",0D,DIAS180);
            if RecLC.FindFirst then repeat
                if RecLC."Outstanding Quantity"<>0 then begin
                    CANTIDAD180:=CANTIDAD180+RecLC."Outstanding Quantity";
                end;
            until RecLC.Next = 0;
            RecLC.SetCurrentkey(RecLC."Document Type",RecLC.Type,RecLC."No.");
            RecLC.SetRange(RecLC."Document Type",0);
            RecLC.SetRange(RecLC."No.",Item."No.");
            RecLC.SetRange("Expected Receipt Date",0D,DIAS180);
            if RecLC.FindFirst then repeat
                if RecLC."Outstanding Quantity"<>0 then begin
                    CANTIDAD180:=CANTIDAD180+RecLC."Outstanding Quantity";
                end;
            until RecLC.Next = 0;

            CANTIDAD180:=CANTIDAD180-CANTIDAD90;



    end;

    local procedure Calcula360dias()
    begin

            CANTIDAD360:=0;
            DIAS360:=CalcDate('+360D',Today);
            RecLC.SetCurrentkey(RecLC."Document Type",RecLC.Type,RecLC."No.");
            RecLC.SetRange(RecLC."Document Type",1);
            RecLC.SetRange(RecLC."No.",Item."No.");
            RecLC.SetRange("Expected Receipt Date",0D,DIAS360);
            if RecLC.FindFirst then repeat
                if RecLC."Outstanding Quantity"<>0 then begin
                    CANTIDAD360:=CANTIDAD360+RecLC."Outstanding Quantity";
                end;
            until RecLC.Next = 0;
            RecLC.SetCurrentkey(RecLC."Document Type",RecLC.Type,RecLC."No.");
            RecLC.SetRange(RecLC."Document Type",0);
            RecLC.SetRange(RecLC."No.",Item."No.");
            RecLC.SetRange("Expected Receipt Date",0D,DIAS360);
            if RecLC.FindFirst then repeat
                if RecLC."Outstanding Quantity"<>0 then begin
                    CANTIDAD360:=CANTIDAD360+RecLC."Outstanding Quantity";
                end;
            until RecLC.Next = 0;

            CANTIDAD360:=CANTIDAD360-CANTIDAD180;

    end;

    local procedure Prevision()
    begin


        if FechaCod<>'' then begin
        /// 04/16/2023 - 04/22/2023
        /// 12345678901234567890123

        salir:=false;

              CMM := CopyStr(FechaCod,1,2);
              CDD := CopyStr(FechaCod,4,2);
              CAA := CopyStr(FechaCod,7,4);
              Evaluate(DD,CDD);
              Evaluate(MM,CMM);
              Evaluate(AA,CAA);
              FECHADESDE:=Dmy2date(DD,MM,AA);
              CMM := CopyStr(FechaCod,14,2);
              CDD := CopyStr(FechaCod,17,2);
              CAA := CopyStr(FechaCod,20,4);
              Evaluate(DD,CDD);
              Evaluate(MM,CMM);
              Evaluate(AA,CAA);
              FECHAHASTA:=Dmy2date(DD,MM,AA);
              ///MESSAGE('%1 %2',(CALCDATE('+60D',TODAY)),FECHADESDE);
              if (CalcDate('+60D',Today))>FECHADESDE then begin
                  Evaluate(DatoDec,DatoCod);
                  DSUMATEN60:=DSUMATEN60+DatoDec;
                  salir:=true;
              end;
              if not salir then begin
                  if (CalcDate('+90D',Today))>FECHADESDE then begin
                      Evaluate(DatoDec,DatoCod);
                      DSUMATEN90:=DSUMATEN90+DatoDec;
                      salir:=true;
                  end;
              end;
              if not salir then begin
                  if (CalcDate('+180D',Today))>FECHADESDE then begin
                      Evaluate(DatoDec,DatoCod);
                      DSUMATEN180:=DSUMATEN180+DatoDec;
                      salir:=true;
                  end;
              end;
              if not salir then begin
                  if (CalcDate('+360D',Today))>FECHADESDE then begin
                      Evaluate(DatoDec,DatoCod);
                      DSUMATEN360:=DSUMATEN360+DatoDec;
                      salir:=true;
                  end;
              end;

        end;
    end;
    */
}

