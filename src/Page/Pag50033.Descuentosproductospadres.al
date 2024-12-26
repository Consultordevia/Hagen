#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50033 "Descuentos productos padres"

{
    ApplicationArea = All;
    Caption = 'Descuentos productos padres';
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Sales Line Discount Padre";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                /////-
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("Descripción"; Rec.Descripción)
                {
                    ApplicationArea = Basic;
                }
                field("Sales Code"; Rec."Sales Code")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = Basic;
                }
                field("Sales Type"; Rec."Sales Type")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = Basic;
                }
                field("Producto en promocion"; Rec."Producto en promocion")
                {
                    ApplicationArea = Basic;
                }
                field("+ Linea"; Rec."+ Linea")
                {
                    ApplicationArea = Basic;
                }
                field("+ Familia"; Rec."+ Familia")
                {
                    ApplicationArea = Basic;
                }
                field("+ Subfamilia"; Rec."+ Subfamilia")
                {
                    ApplicationArea = Basic;
                }
                field("+ Linea 1"; Rec."+ Linea 1")
                {
                    ApplicationArea = Basic;
                }
                field("+ Familia 1"; Rec."+ Familia 1")
                {
                    ApplicationArea = Basic;
                }
                field("+ Subfamilia 1"; Rec."+ Subfamilia 1")
                {
                    ApplicationArea = Basic;
                }
                field("+ Linea 2"; Rec."+ Linea 2")
                {
                    ApplicationArea = Basic;
                }
                field("+ Familia 2"; Rec."+ Familia 2")
                {
                    ApplicationArea = Basic;
                }
                field("+ Subfamilia 2"; Rec."+ Subfamilia 2")
                {
                    ApplicationArea = Basic;
                }
                field("+ Linea 3"; Rec."+ Linea 3")
                {
                    ApplicationArea = Basic;
                }
                field("+ Familia 3"; Rec."+ Familia 3")
                {
                    ApplicationArea = Basic;
                }
                field("+ Subfamilia 3"; Rec."+ Subfamilia 3")
                {
                    ApplicationArea = Basic;
                }
                field("+ Linea 4"; Rec."+ Linea 4")
                {
                    ApplicationArea = Basic;
                }
                field("+ Familia 4"; Rec."+ Familia 4")
                {
                    ApplicationArea = Basic;
                }
                field("+ Subfamilia 4"; Rec."+ Subfamilia 4")
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
            action("Recalcula DC00")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Promoted = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    MultitablaDTOS: Record "Multitabla DTOS";
                    SalesLineDiscountPadre: Record "Sales Line Discount Padre";
                    SalesLineDiscount2: Record "Sales Line Discount";
                    CustomerDiscountGroup: Record "Customer Discount Group";
                    VENTANA: Dialog;
                    Item: Record Item;

                begin

                    /////-Automaticos.DescuentosGrupos2;

                    VENTANA.OPEN('#1###################');


                    SalesLineDiscountPadre.RESET;
                    SalesLineDiscountPadre.SETRANGE("Sales Code", 'DC00');
                    IF SalesLineDiscountPadre.FINDSET THEN
                        REPEAT
                            SalesLineDiscount2.RESET;
                            SalesLineDiscount2.SETRANGE(Type, SalesLineDiscountPadre.Type);
                            SalesLineDiscount2.SETRANGE(Code, SalesLineDiscountPadre.Code);
                            SalesLineDiscount2.SETRANGE("Sales Type", SalesLineDiscountPadre."Sales Type");
                            SalesLineDiscount2.SETRANGE("Sales Code", SalesLineDiscountPadre."Sales Code");
                            IF SalesLineDiscount2.FINDFIRST THEN
                                REPEAT
                                    IF SalesLineDiscount2.Promocion = FALSE THEN BEGIN
                                        SalesLineDiscount2.DELETE;
                                    END;
                                    VENTANA.UPDATE(1, 'B1-' + SalesLineDiscount2.Code);
                                UNTIL SalesLineDiscount2.NEXT = 0;
                            CustomerDiscountGroup.RESET;
                            CustomerDiscountGroup.SETRANGE(CustomerDiscountGroup."Descuento %", 1, SalesLineDiscountPadre."Line Discount %");
                            IF CustomerDiscountGroup.FINDSET THEN
                                REPEAT
                                    IF CustomerDiscountGroup."Descuento %" <> 0 THEN BEGIN
                                        SalesLineDiscount2.RESET;
                                        SalesLineDiscount2.SETRANGE(Type, SalesLineDiscountPadre.Type);
                                        SalesLineDiscount2.SETRANGE(Code, SalesLineDiscountPadre.Code);
                                        SalesLineDiscount2.SETRANGE("Sales Type", SalesLineDiscountPadre."Sales Type");
                                        SalesLineDiscount2.SETRANGE("Sales Code", CustomerDiscountGroup.Code);
                                        IF SalesLineDiscount2.FINDFIRST THEN
                                            REPEAT
                                                IF SalesLineDiscount2.Promocion = FALSE THEN BEGIN
                                                    SalesLineDiscount2.DELETE;
                                                END;
                                                VENTANA.UPDATE(1, 'B1-' + SalesLineDiscount2.Code);
                                            UNTIL SalesLineDiscount2.NEXT = 0;
                                    END;
                                UNTIL CustomerDiscountGroup.NEXT = 0;
                            CustomerDiscountGroup.RESET;
                            CustomerDiscountGroup.SETFILTER(CustomerDiscountGroup."Descuento % especial", '<>0');
                            IF CustomerDiscountGroup.FINDSET THEN
                                REPEAT
                                    SalesLineDiscount2.RESET;
                                    SalesLineDiscount2.SETRANGE(Type, SalesLineDiscountPadre.Type);
                                    SalesLineDiscount2.SETRANGE(Code, SalesLineDiscountPadre.Code);
                                    SalesLineDiscount2.SETRANGE("Sales Type", SalesLineDiscountPadre."Sales Type");
                                    SalesLineDiscount2.SETRANGE("Sales Code", CustomerDiscountGroup.Code);
                                    IF SalesLineDiscount2.FINDFIRST THEN
                                        REPEAT
                                            IF SalesLineDiscount2.Promocion = FALSE THEN BEGIN
                                                SalesLineDiscount2.DELETE;
                                            END;
                                            VENTANA.UPDATE(1, 'B2-' + SalesLineDiscount2.Code);
                                        UNTIL SalesLineDiscount2.NEXT = 0;
                                UNTIL CustomerDiscountGroup.NEXT = 0;
                        UNTIL SalesLineDiscountPadre.NEXT = 0;





                    SalesLineDiscountPadre.RESET;
                    SalesLineDiscountPadre.SETRANGE("Sales Code", 'DC00');
                    IF SalesLineDiscountPadre.FINDSET THEN
                        REPEAT
                            CustomerDiscountGroup.RESET;
                            CustomerDiscountGroup.SETRANGE(CustomerDiscountGroup."Descuento %", 1, SalesLineDiscountPadre."Line Discount %");
                            IF CustomerDiscountGroup.FINDSET THEN
                                REPEAT
                                    IF CustomerDiscountGroup."Descuento %" <> 0 THEN BEGIN
                                        SalesLineDiscount2.RESET;
                                        SalesLineDiscount2.SETRANGE(Type, SalesLineDiscountPadre.Type);
                                        SalesLineDiscount2.SETRANGE(Code, SalesLineDiscountPadre.Code);
                                        SalesLineDiscount2.SETRANGE("Sales Type", SalesLineDiscountPadre."Sales Type");
                                        SalesLineDiscount2.SETRANGE("Sales Code", CustomerDiscountGroup.Code);
                                        SalesLineDiscount2.SETRANGE("Starting Date", SalesLineDiscountPadre."Starting Date");
                                        SalesLineDiscount2.SETRANGE("Currency Code", SalesLineDiscountPadre."Currency Code");
                                        SalesLineDiscount2.SETRANGE("Variant Code", SalesLineDiscountPadre."Variant Code");
                                        SalesLineDiscount2.SETRANGE("Unit of Measure Code", SalesLineDiscountPadre."Unit of Measure Code");
                                        SalesLineDiscount2.SETRANGE("Minimum Quantity", SalesLineDiscountPadre."Minimum Quantity");
                                        IF NOT SalesLineDiscount2.FINDFIRST THEN BEGIN
                                            SalesLineDiscount2.INIT;
                                            SalesLineDiscount2.Code := SalesLineDiscountPadre.Code;
                                            SalesLineDiscount2."Sales Type" := SalesLineDiscountPadre."Sales Type";
                                            SalesLineDiscount2."Sales Code" := CustomerDiscountGroup.Code;
                                            SalesLineDiscount2."Starting Date" := SalesLineDiscountPadre."Starting Date";
                                            SalesLineDiscount2."Currency Code" := SalesLineDiscountPadre."Currency Code";
                                            SalesLineDiscount2."Variant Code" := SalesLineDiscountPadre."Variant Code";
                                            SalesLineDiscount2."Unit of Measure Code" := SalesLineDiscountPadre."Unit of Measure Code";
                                            SalesLineDiscount2."Minimum Quantity" := SalesLineDiscountPadre."Minimum Quantity";
                                            SalesLineDiscount2."Ending Date" := SalesLineDiscountPadre."Ending Date";
                                            SalesLineDiscount2."Line Discount %" := SalesLineDiscountPadre."Line Discount %";
                                            SalesLineDiscount2."Fecha alta" := CREATEDATETIME(TODAY, TIME);
                                            SalesLineDiscount2.INSERT;
                                            VENTANA.UPDATE(1, 'A1' + SalesLineDiscount2.Code);
                                        END;
                                        SalesLineDiscount2.RESET;
                                        SalesLineDiscount2.SETRANGE(Type, SalesLineDiscountPadre.Type);
                                        SalesLineDiscount2.SETRANGE(Code, SalesLineDiscountPadre.Code);
                                        SalesLineDiscount2.SETRANGE("Sales Type", SalesLineDiscountPadre."Sales Type");
                                        SalesLineDiscount2.SETRANGE("Sales Code", CustomerDiscountGroup.Code);
                                        SalesLineDiscount2.SETRANGE("Starting Date", SalesLineDiscountPadre."Starting Date");
                                        SalesLineDiscount2.SETRANGE("Currency Code", SalesLineDiscountPadre."Currency Code");
                                        SalesLineDiscount2.SETRANGE("Variant Code", SalesLineDiscountPadre."Variant Code");
                                        SalesLineDiscount2.SETRANGE("Unit of Measure Code", SalesLineDiscountPadre."Unit of Measure Code");
                                        SalesLineDiscount2.SETRANGE("Minimum Quantity", 1);
                                        IF NOT SalesLineDiscount2.FINDFIRST THEN BEGIN
                                            SalesLineDiscount2.INIT;
                                            SalesLineDiscount2.Code := SalesLineDiscountPadre.Code;
                                            SalesLineDiscount2."Sales Type" := SalesLineDiscountPadre."Sales Type";
                                            SalesLineDiscount2."Sales Code" := CustomerDiscountGroup.Code;
                                            SalesLineDiscount2."Starting Date" := SalesLineDiscountPadre."Starting Date";
                                            SalesLineDiscount2."Currency Code" := SalesLineDiscountPadre."Currency Code";
                                            SalesLineDiscount2."Variant Code" := SalesLineDiscountPadre."Variant Code";
                                            SalesLineDiscount2."Unit of Measure Code" := SalesLineDiscountPadre."Unit of Measure Code";
                                            SalesLineDiscount2."Minimum Quantity" := 1;
                                            SalesLineDiscount2."Ending Date" := SalesLineDiscountPadre."Ending Date";
                                            SalesLineDiscount2."Line Discount %" := SalesLineDiscountPadre."Line Discount %";
                                            SalesLineDiscount2."Fecha alta" := CREATEDATETIME(TODAY, TIME);
                                            SalesLineDiscount2.INSERT;
                                            VENTANA.UPDATE(1, 'A2-' + SalesLineDiscount2.Code);
                                        END;
                                        SalesLineDiscount2.RESET;
                                        SalesLineDiscount2.SETRANGE(Type, SalesLineDiscountPadre.Type);
                                        SalesLineDiscount2.SETRANGE(Code, SalesLineDiscountPadre.Code);
                                        SalesLineDiscount2.SETRANGE("Sales Type", SalesLineDiscountPadre."Sales Type");
                                        SalesLineDiscount2.SETRANGE("Sales Code", SalesLineDiscountPadre."Sales Code");
                                        SalesLineDiscount2.SETRANGE("Starting Date", SalesLineDiscountPadre."Starting Date");
                                        SalesLineDiscount2.SETRANGE("Currency Code", SalesLineDiscountPadre."Currency Code");
                                        SalesLineDiscount2.SETRANGE("Variant Code", SalesLineDiscountPadre."Variant Code");
                                        SalesLineDiscount2.SETRANGE("Unit of Measure Code", SalesLineDiscountPadre."Unit of Measure Code");
                                        SalesLineDiscount2.SETRANGE("Minimum Quantity", SalesLineDiscountPadre."Minimum Quantity");
                                        IF NOT SalesLineDiscount2.FINDFIRST THEN BEGIN
                                            SalesLineDiscount2.INIT;
                                            SalesLineDiscount2.Code := SalesLineDiscountPadre.Code;
                                            SalesLineDiscount2."Sales Type" := SalesLineDiscountPadre."Sales Type";
                                            SalesLineDiscount2."Sales Code" := SalesLineDiscountPadre."Sales Code";
                                            SalesLineDiscount2."Starting Date" := SalesLineDiscountPadre."Starting Date";
                                            SalesLineDiscount2."Currency Code" := SalesLineDiscountPadre."Currency Code";
                                            SalesLineDiscount2."Variant Code" := SalesLineDiscountPadre."Variant Code";
                                            SalesLineDiscount2."Unit of Measure Code" := SalesLineDiscountPadre."Unit of Measure Code";
                                            SalesLineDiscount2."Minimum Quantity" := SalesLineDiscountPadre."Minimum Quantity";
                                            SalesLineDiscount2."Ending Date" := SalesLineDiscountPadre."Ending Date";
                                            SalesLineDiscount2."Line Discount %" := SalesLineDiscountPadre."Line Discount %";
                                            SalesLineDiscount2."Fecha alta" := CREATEDATETIME(TODAY, TIME);
                                            SalesLineDiscount2.INSERT;
                                            VENTANA.UPDATE(1, 'A2-' + SalesLineDiscount2.Code);
                                        END;
                                    END;
                                UNTIL CustomerDiscountGroup.NEXT = 0;
                            CustomerDiscountGroup.RESET;
                            CustomerDiscountGroup.SETFILTER(CustomerDiscountGroup."Descuento % especial", '<>0');
                            IF CustomerDiscountGroup.FINDSET THEN
                                REPEAT
                                    SalesLineDiscount2.RESET;
                                    SalesLineDiscount2.SETRANGE(Type, SalesLineDiscountPadre.Type);
                                    SalesLineDiscount2.SETRANGE(Code, SalesLineDiscountPadre.Code);
                                    SalesLineDiscount2.SETRANGE("Sales Type", SalesLineDiscountPadre."Sales Type");
                                    SalesLineDiscount2.SETRANGE("Sales Code", CustomerDiscountGroup.Code);
                                    SalesLineDiscount2.SETRANGE("Starting Date", SalesLineDiscountPadre."Starting Date");
                                    SalesLineDiscount2.SETRANGE("Currency Code", SalesLineDiscountPadre."Currency Code");
                                    SalesLineDiscount2.SETRANGE("Variant Code", SalesLineDiscountPadre."Variant Code");
                                    SalesLineDiscount2.SETRANGE("Unit of Measure Code", SalesLineDiscountPadre."Unit of Measure Code");
                                    SalesLineDiscount2.SETRANGE("Minimum Quantity", 1);
                                    IF NOT SalesLineDiscount2.FINDFIRST THEN BEGIN
                                        SalesLineDiscount2.INIT;
                                        SalesLineDiscount2.Code := SalesLineDiscountPadre.Code;
                                        SalesLineDiscount2."Sales Type" := SalesLineDiscountPadre."Sales Type";
                                        SalesLineDiscount2."Sales Code" := CustomerDiscountGroup.Code;
                                        SalesLineDiscount2."Starting Date" := SalesLineDiscountPadre."Starting Date";
                                        SalesLineDiscount2."Currency Code" := SalesLineDiscountPadre."Currency Code";
                                        SalesLineDiscount2."Variant Code" := SalesLineDiscountPadre."Variant Code";
                                        SalesLineDiscount2."Unit of Measure Code" := SalesLineDiscountPadre."Unit of Measure Code";
                                        SalesLineDiscount2."Minimum Quantity" := 1;
                                        SalesLineDiscount2."Ending Date" := SalesLineDiscountPadre."Ending Date";
                                        SalesLineDiscount2."Line Discount %" := CustomerDiscountGroup."Descuento % especial";
                                        SalesLineDiscount2."Fecha alta" := CREATEDATETIME(TODAY, TIME);
                                        SalesLineDiscount2.INSERT;
                                        VENTANA.UPDATE(1, 'A3-' + SalesLineDiscount2.Code);
                                    END;
                                UNTIL CustomerDiscountGroup.NEXT = 0;
                            CustomerDiscountGroup.RESET;
                            CustomerDiscountGroup.SETFILTER(CustomerDiscountGroup."Descuento %", '<>0');
                            IF CustomerDiscountGroup.FINDSET THEN
                                REPEAT
                                    SalesLineDiscount2.RESET;
                                    SalesLineDiscount2.SETRANGE(Type, SalesLineDiscountPadre.Type);
                                    SalesLineDiscount2.SETRANGE(Code, SalesLineDiscountPadre.Code);
                                    SalesLineDiscount2.SETRANGE("Sales Type", SalesLineDiscountPadre."Sales Type");
                                    SalesLineDiscount2.SETRANGE("Sales Code", CustomerDiscountGroup.Code);
                                    SalesLineDiscount2.SETRANGE("Starting Date", SalesLineDiscountPadre."Starting Date");
                                    SalesLineDiscount2.SETRANGE("Currency Code", SalesLineDiscountPadre."Currency Code");
                                    SalesLineDiscount2.SETRANGE("Variant Code", SalesLineDiscountPadre."Variant Code");
                                    SalesLineDiscount2.SETRANGE("Unit of Measure Code", SalesLineDiscountPadre."Unit of Measure Code");
                                    SalesLineDiscount2.SETRANGE("Minimum Quantity", 0);
                                    IF NOT SalesLineDiscount2.FINDFIRST THEN BEGIN
                                        SalesLineDiscount2.INIT;
                                        SalesLineDiscount2.Code := SalesLineDiscountPadre.Code;
                                        SalesLineDiscount2."Sales Type" := SalesLineDiscountPadre."Sales Type";
                                        SalesLineDiscount2."Sales Code" := CustomerDiscountGroup.Code;
                                        SalesLineDiscount2."Starting Date" := SalesLineDiscountPadre."Starting Date";
                                        SalesLineDiscount2."Currency Code" := SalesLineDiscountPadre."Currency Code";
                                        SalesLineDiscount2."Variant Code" := SalesLineDiscountPadre."Variant Code";
                                        SalesLineDiscount2."Unit of Measure Code" := SalesLineDiscountPadre."Unit of Measure Code";
                                        SalesLineDiscount2."Minimum Quantity" := 0;
                                        SalesLineDiscount2."Ending Date" := SalesLineDiscountPadre."Ending Date";
                                        SalesLineDiscount2."Line Discount %" := CustomerDiscountGroup."Descuento %";
                                        SalesLineDiscount2."Fecha alta" := CREATEDATETIME(TODAY, TIME);
                                        SalesLineDiscount2.INSERT;
                                        VENTANA.UPDATE(1, 'A3-' + SalesLineDiscount2.Code);
                                    END;
                                UNTIL CustomerDiscountGroup.NEXT = 0;

                        UNTIL SalesLineDiscountPadre.NEXT = 0;



                    Item.RESET;
                    IF Item.FINDFIRST THEN
                        REPEAT
                            ///     IF (Item."Producto PADRE"='') OR (Item."No."=Item."Producto PADRE") THEN BEGIN
                            VENTANA.UPDATE(1, 'A3-' + Item.Description);
                            SalesLineDiscountPadre.RESET;
                            SalesLineDiscountPadre.SETRANGE(Code, Item."No.");
                            IF NOT SalesLineDiscountPadre.FINDSET THEN BEGIN
                                CustomerDiscountGroup.RESET;
                                CustomerDiscountGroup.SETFILTER(CustomerDiscountGroup."Descuento %", '<>0');
                                IF CustomerDiscountGroup.FINDSET THEN
                                    REPEAT
                                        SalesLineDiscount2.RESET;
                                        SalesLineDiscount2.SETRANGE(Type, SalesLineDiscount2.Type::"Item Disc. Group");
                                        SalesLineDiscount2.SETRANGE(Code, Item."No.");
                                        SalesLineDiscount2.SETRANGE("Sales Type", SalesLineDiscountPadre."Sales Type");
                                        SalesLineDiscount2.SETRANGE("Sales Code", CustomerDiscountGroup.Code);
                                        SalesLineDiscount2.SETRANGE("Starting Date", 20180101D);
                                        SalesLineDiscount2.SETRANGE("Unit of Measure Code", Item."Base Unit of Measure");
                                        SalesLineDiscount2.SETRANGE("Minimum Quantity", 0);
                                        IF NOT SalesLineDiscount2.FINDFIRST THEN BEGIN
                                            SalesLineDiscount2.INIT;
                                            SalesLineDiscount2.Code := Item."No.";
                                            SalesLineDiscount2."Sales Type" := SalesLineDiscount2.Type::"Item Disc. Group";
                                            SalesLineDiscount2."Sales Code" := CustomerDiscountGroup.Code;
                                            SalesLineDiscount2."Starting Date" := 20180101D;
                                            SalesLineDiscount2."Unit of Measure Code" := Item."Base Unit of Measure";
                                            SalesLineDiscount2."Minimum Quantity" := 0;
                                            SalesLineDiscount2."Line Discount %" := CustomerDiscountGroup."Descuento %";
                                            SalesLineDiscount2."Fecha alta" := CREATEDATETIME(TODAY, TIME);
                                            IF SalesLineDiscount2.INSERT THEN;
                                            VENTANA.UPDATE(1, 'A3-' + SalesLineDiscount2.Code);
                                        END;
                                    UNTIL CustomerDiscountGroup.NEXT = 0;

                            END;

                        ///END;
                        UNTIL Item.NEXT = 0;



                    VENTANA.CLOSE;




                    Message('Hecho.');
                end;
            }
            action("Importa datos")
            {
                ApplicationArea = Basic;
                Caption = 'Importa datos';
                Ellipsis = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    Clear(ImportaDescuentosPadre);
                    ImportaDescuentosPadre.Run;
                end;
            }
        }
    }

    var
        Automaticos: Codeunit Automaticos;
        ImportaDescuentosPadre: XmlPort "Importa Descuentos Padre";

}
