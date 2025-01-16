tableextension 50115 SalesLine extends "Sales Line"
{
    fields
    {

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                SalesCommentLine: Record "Sales Comment Line";
                codpadre: code[20];
                SalesLineDiscountPadre: Record "Sales Line Discount Padre";
                LINL: integer;
                PrecioPROD: Decimal;
                RecItemPadre: Record Item;
            begin
                if ("Document Type" = "document type"::Order) then begin
                    if Rec."Customer Disc. Group" = '' then begin
                        if Type = Type::Item then begin
                            Error('No se pueden añadir mas referencias a este pedido, devuelvalo a Presupuesto.');
                        end;
                    end;
                end;

                /*SalesCommentLine.Reset;
                SalesCommentLine.SetRange("Document Type", SalesCommentLine."document type"::DetalleProd);
                SalesCommentLine.SetRange("No.", Rec."Document No.");
                if SalesCommentLine.FindFirst then
                    repeat
                        SalesCommentLine.Delete;
                    until SalesCommentLine.Next = 0;*/


                codpadre := Rec."Producto Padre";



                /*SalesLineDiscountPadre.Reset;
                SalesLineDiscountPadre.SetRange(SalesLineDiscountPadre.Code, codpadre);
                if SalesLineDiscountPadre.FindFirst then
                    repeat
                        SalesCommentLine.Init;
                        SalesCommentLine."Document Type" := SalesCommentLine."document type"::DetalleProd;
                        SalesCommentLine."No." := Rec."Document No.";
                        LINL := LINL + 1000;
                        SalesCommentLine."Line No." := LINL;
                        PrecioPROD := Rec."Unit Price" - ROUND((Rec."Unit Price" * SalesLineDiscountPadre."Line Discount %" / 100), 0.01);
                        SalesCommentLine.Comment := 'Por: ' + Format(SalesLineDiscountPadre."Minimum Quantity") + ' dto%: ' + Format(SalesLineDiscountPadre."Line Discount %") +
                        ' Precio unitario:' + Format(PrecioPROD);
                        SalesCommentLine.Insert;
                    until SalesLineDiscountPadre.Next = 0;


                RecItemPadre.Reset;
                RecItemPadre.SetCurrentkey("Producto PADRE");
                RecItemPadre.SetRange("Producto PADRE", codpadre);
                if RecItemPadre.FindFirst then
                    repeat
                        if RecItemPadre."No." <> Rec."No." then begin
                            SalesCommentLine.Init;
                            SalesCommentLine."Document Type" := SalesCommentLine."document type"::DetalleProd;
                            SalesCommentLine."No." := Rec."Document No.";
                            LINL := LINL + 1000;
                            SalesCommentLine."Line No." := LINL;
                            SalesCommentLine.Comment := RecItemPadre."No." + ' ' + RecItemPadre.Description;
                            SalesCommentLine.Insert;
                        end;
                    until RecItemPadre.Next = 0;
            end;*/
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
                Item: Record Item;
                DIVI: Decimal;
                cantidadok: Decimal;
                Recitem4: Record Item;
                RecLV22: Record "Sales Line";
                LIN: Integer;
                LINASO: Integer;
                RecBom: Record "BOM Component";
                ResItem2: Record Item;
                RecLV2: Record "Sales Line";
            begin
                SalesHeader.Get("Document Type", "Document No.");
                if SalesHeader."Usuario alta" <> 'USERNWS' then begin
                    if ("Document Type" = 1) or ("Document Type" = 0) then begin
                        /// VER MULTIPO
                        IF Item.get(Rec."No.") then begin
                            if (Item."Unidades venta" > 1) and (Item."Permite fraccionar venta" = false) and
                                 (SalesHeader."Permite fraccionar uni. venta" = false) then begin
                                DIVI := ROUND(Quantity / Item."Unidades venta", 1, '>');
                                if DIVI * Item."Unidades venta" <> Quantity then begin
                                    cantidadok := DIVI * Item."Unidades venta";
                                    Message('%4 ,cantidad %1 no es multipo %2, la cantidad correcta es %3.', Quantity, Item."Unidades venta", cantidadok, Item.Description);
                                    Rec.Validate(Rec.Quantity, cantidadok);
                                end;
                            end;
                        end;
                    end;
                end;


                if SalesHeader."Usuario alta" <> 'USERNWS' then begin
                    if ("Document Type" = 1) or ("Document Type" = 0) then begin
                        if Rec.Quantity <> 0 then begin
                            Rec."Precio final" := ROUND("Line Amount" / Rec.Quantity, 0.001);
                        end;
                        if Quantity <> 0 then begin
                            if Recitem4.Get("No.") then begin
                                if Recitem4."Tiene productos asociados" then begin
                                    if xRec.Quantity <> Quantity then begin
                                        if "Line No." <> 0 then begin
                                            RecLV22.Reset;
                                            RecLV22.SetRange(RecLV22."Document Type", "Document Type");
                                            RecLV22.SetRange(RecLV22."Document No.", "Document No.");
                                            RecLV22.SetRange(RecLV22."Producto asociado", "Line No.");
                                            if RecLV22.FindFirst then
                                                repeat
                                                    RecLV22.Delete;
                                                until RecLV22.Next = 0;
                                        end;
                                    end;
                                    LIN := "Line No.";
                                    RecLV22.Reset;
                                    RecLV22.SetRange(RecLV22."Document Type", "Document Type");
                                    RecLV22.SetRange(RecLV22."Document No.", "Document No.");
                                    if RecLV22.FindLast then begin
                                        LIN := RecLV22."Line No.";
                                        LINASO := RecLV22."Line No." + 10000;
                                    end;
                                    if not RecLV22.FindLast then begin
                                        LIN := 10000;
                                        LINASO := 10000;
                                    end;
                                    /////                IF (COMPANYNAME<>'PEPE') THEN BEGIN
                                    RecBom.Reset;
                                    RecBom.SetRange(RecBom."Parent Item No.", "No.");
                                    if RecBom.FindFirst then
                                        repeat
                                            SalesHeader."Permite fraccionar uni. venta" := true;
                                            SalesHeader.Modify;
                                            ResItem2.Get(RecBom."No.");
                                            ResItem2.CalcFields(ResItem2."Qty. on Sales Order", ResItem2."Existencia SILLA");
                                            /////                     IF ResItem2."Existencia SILLA"-ResItem2."Qty. on Sales Order"<=Quantity THEN BEGIN
                                            if ResItem2."Existencia SILLA" <= Quantity then begin
                                                if (COMPANYNAME <> 'PEPE') and GuiAllowed then begin
                                                    Error('No hay stock del producto %1', RecBom."No.");
                                                end;
                                            end;
                                            if (RecBom.Desde = 0D) and (RecBom.Hasta = 0D) then begin
                                                ///RecLV22.RESET;
                                                ///RecLV22.SETRANGE("No.",RecBom."No.");
                                                ///RecLV22.SETRANGE("Producto asociado","Line No.");
                                                ///IF NOT RecLV22.FINDFIRST THEN BEGIN
                                                RecLV22.Reset;
                                                RecLV22.SetRange(RecLV22."Document Type", "Document Type");
                                                RecLV22.SetRange(RecLV22."Document No.", "Document No.");
                                                if RecLV22.FindLast then begin
                                                    LIN := RecLV22."Line No.";
                                                end;
                                                RecLV22 := Rec;
                                                LIN := LIN + 100;
                                                RecLV22."Line No." := LIN;
                                                RecLV22.Validate(RecLV22."No.", RecBom."No.");
                                                RecLV22.Validate(RecLV22.Quantity, Rec.Quantity * RecBom."Quantity per");
                                                RecLV22.Validate(RecLV22."Line Discount %", RecBom."% descuento");
                                                RecLV22."Producto asociado" := LINASO;
                                                ///RecLV22."NO imprimir en albaran":=RecBom."NO imprimir en albaran";
                                                ///RecLV22."NO imprimir en factura":=RecBom."NO imprimir en factura";
                                                RecLV22."Description 2" := 'Componente de:' + "No.";
                                                RecLV22.Insert(true);
                                                ///END;
                                            end;
                                            if (RecBom.Desde <> 0D) and (RecBom.Hasta <> 0D) then begin
                                                if (Today >= RecBom.Desde) and (Today <= RecBom.Hasta) then begin
                                                    /// RecLV22.RESET;
                                                    ///RecLV22.SETRANGE("No.",RecBom."No.");
                                                    ///RecLV22.SETRANGE("Producto asociado","Line No.");
                                                    ///IF NOT RecLV22.FINDFIRST THEN BEGIN
                                                    RecLV22.Reset;
                                                    RecLV22.SetRange(RecLV22."Document Type", "Document Type");
                                                    RecLV22.SetRange(RecLV22."Document No.", "Document No.");
                                                    if RecLV22.FindLast then begin
                                                        LIN := RecLV22."Line No.";
                                                    end;
                                                    RecLV22 := Rec;
                                                    LIN := LIN + 100;
                                                    RecLV22."Line No." := LIN;
                                                    RecLV22.Validate(RecLV22."No.", RecBom."No.");
                                                    RecLV22.Validate(RecLV22.Quantity, Rec.Quantity * RecBom."Quantity per");
                                                    RecLV22.Validate(RecLV22."Line Discount %", RecBom."% descuento");
                                                    RecLV22."Producto asociado" := LINASO;
                                                    ///RecLV22."NO imprimir en albaran":=RecBom."NO imprimir en albaran";
                                                    ///RecLV22."NO imprimir en factura":=RecBom."NO imprimir en factura";
                                                    RecLV22."Description 2" := 'Componente de:' + "No.";
                                                    RecLV22.Insert(true);
                                                    ///END;
                                                end;
                                            end;

                                        until RecBom.Next = 0;
                                end;
                            end;
                        end;
                    end;
                end;
                if SalesHeader."Usuario alta" = 'USERNWS' then begin
                    if ("Document Type" = 1) or ("Document Type" = 0) then begin
                        if Quantity <> 0 then begin
                            if Recitem4.Get("No.") then begin
                                if Recitem4."Tiene productos asociados" then begin
                                    if xRec.Quantity <> Quantity then begin
                                        if "Line No." <> 0 then begin
                                            RecLV22.Reset;
                                            RecLV22.SetRange(RecLV22."Document Type", "Document Type");
                                            RecLV22.SetRange(RecLV22."Document No.", "Document No.");
                                            RecLV22.SetRange(RecLV22."Producto asociado", "Line No.");
                                            if RecLV22.FindFirst then
                                                repeat
                                                    RecLV22.Delete;
                                                until RecLV22.Next = 0;
                                        end;
                                    end;
                                    LIN := "Line No.";
                                    RecLV22.Reset;
                                    RecLV22.SetRange(RecLV22."Document Type", "Document Type");
                                    RecLV22.SetRange(RecLV22."Document No.", "Document No.");
                                    if RecLV22.FindLast then begin
                                        LIN := RecLV22."Line No.";
                                        LINASO := RecLV22."Line No." + 10000;
                                    end;
                                    if RecLV22.FindLast then begin
                                        LIN := 10000;
                                        LINASO := 10000;
                                    end;
                                    /////                IF (COMPANYNAME<>'PEPE') THEN BEGIN
                                    RecBom.Reset;
                                    RecBom.SetRange(RecBom."Parent Item No.", "No.");
                                    if RecBom.FindFirst then
                                        repeat
                                            SalesHeader."Permite fraccionar uni. venta" := true;
                                            SalesHeader.Modify;
                                            ResItem2.Get(RecBom."No.");
                                            ResItem2.CalcFields(ResItem2."Qty. on Sales Order", ResItem2."Existencia SILLA");
                                            /////                     IF ResItem2."Existencia SILLA"-ResItem2."Qty. on Sales Order"<=Quantity THEN BEGIN
                                            if ResItem2."Existencia SILLA" <= Quantity then begin
                                                if (COMPANYNAME <> 'PEPE') and GuiAllowed then begin
                                                    Error('No hay stock del producto %1', RecBom."No.");
                                                end;
                                            end;

                                            if (RecBom.Desde = 0D) and (RecBom.Hasta = 0D) then begin
                                                ///RecLV22.RESET;
                                                ///RecLV22.SETRANGE("No.",RecBom."No.");
                                                ///RecLV22.SETRANGE("Producto asociado","Line No.");
                                                ///IF NOT RecLV22.FINDFIRST THEN BEGIN
                                                RecLV22.Reset;
                                                RecLV22.SetRange(RecLV22."Document Type", "Document Type");
                                                RecLV22.SetRange(RecLV22."Document No.", "Document No.");
                                                if RecLV22.FindLast then begin
                                                    LIN := RecLV22."Line No.";
                                                end;
                                                RecLV22 := Rec;
                                                LIN := LIN + 100;
                                                RecLV22."Line No." := LIN;
                                                RecLV22.Validate(RecLV22."No.", RecBom."No.");
                                                RecLV22.Validate(RecLV22.Quantity, Rec.Quantity * RecBom."Quantity per");
                                                RecLV22.Validate(RecLV22."Line Discount %", RecBom."% descuento");
                                                RecLV22."Producto asociado" := LINASO;
                                                ///RecLV22."NO imprimir en albaran":=RecBom."NO imprimir en albaran";
                                                ///RecLV22."NO imprimir en factura":=RecBom."NO imprimir en factura";
                                                RecLV22."Description 2" := 'Componente de:' + "No.";
                                                RecLV22.Insert(true);
                                                ///END;
                                            end;
                                            if (RecBom.Desde <> 0D) and (RecBom.Hasta <> 0D) then begin
                                                if (Today >= RecBom.Desde) and (Today <= RecBom.Hasta) then begin
                                                    /// RecLV22.RESET;
                                                    ///RecLV22.SETRANGE("No.",RecBom."No.");
                                                    ///RecLV22.SETRANGE("Producto asociado","Line No.");
                                                    ///IF NOT RecLV22.FINDFIRST THEN BEGIN
                                                    RecLV22.Reset;
                                                    RecLV22.SetRange(RecLV22."Document Type", "Document Type");
                                                    RecLV22.SetRange(RecLV22."Document No.", "Document No.");
                                                    if RecLV22.FindLast then begin
                                                        LIN := RecLV22."Line No.";
                                                    end;
                                                    RecLV22 := Rec;
                                                    LIN := LIN + 100;
                                                    RecLV22."Line No." := LIN;
                                                    RecLV22.Validate(RecLV22."No.", RecBom."No.");
                                                    RecLV22.Validate(RecLV22.Quantity, Rec.Quantity * RecBom."Quantity per");
                                                    RecLV22.Validate(RecLV22."Line Discount %", RecBom."% descuento");
                                                    RecLV22."Producto asociado" := LINASO;
                                                    ///RecLV22."NO imprimir en albaran":=RecBom."NO imprimir en albaran";
                                                    ///RecLV22."NO imprimir en factura":=RecBom."NO imprimir en factura";
                                                    RecLV22."Description 2" := 'Componente de:' + "No.";
                                                    RecLV22.Insert(true);
                                                    ///END;
                                                end;
                                            end;
                                        until RecBom.Next = 0;

                                end;
                            end;
                        end;
                    end;

                end;

                /*
                ControlFecha:=CALCDATE('-1D',TODAY);
                RecLV2.SETCURRENTKEY(RecLV2."Document Type",RecLV2."Sell-to Customer No.",RecLV2."No.",RecLV2."Fecha alta");
                RecLV2.SETRANGE(RecLV2."Document Type","Document Type");
                RecLV2.SETRANGE(RecLV2."Sell-to Customer No.","Sell-to Customer No.");
                RecLV2.SETRANGE(RecLV2."No.","No.");
                RecLV2.SETRANGE(RecLV2."Fecha alta",ControlFecha,TODAY);
                IF RecLV2.FIND('-') THEN REPEAT
                          IF NOT CONFIRM('Este mismo producto %1 esta pedido en el pedido %2 de fecha %3. Para seguir pulse Sí. ',FALSE,
                          RecLV2.Description,RecLV2."Document No.",RecLV2."Fecha alta") THEN BEGIN
                          ERROR('Deberia haber pulsado Sí');
                          END;
                UNTIL RecLV2.NEXT = 0;
                */

                if SalesHeader."Usuario alta" <> 'USERNWS' then begin
                    if ("Document Type" = 1) or ("Document Type" = 0) then begin
                        if COMPANYNAME <> 'PEPE' then begin
                            if Rec."No." <> 'TRAN' then begin
                                RecLV2.Reset;
                                RecLV2.SetCurrentkey(RecLV2."Document Type", RecLV2."Document No.");
                                RecLV2.SetRange(RecLV2."Document Type", "Document Type");
                                RecLV2.SetRange(RecLV2."Document No.", "Document No.");
                                RecLV2.SetRange(RecLV2."No.", "No.");
                                if RecLV2.Find('-') then
                                    repeat
                                        if RecLV2."Line No." <> "Line No." then begin
                                            // WEB1.00
                                            if GuiAllowed then  // FIN
                                                if not Confirm('Este mismo producto %1 esta pedido en el pedido %2 de fecha %3. Para seguir pulse Sí. ', false,
                                                RecLV2.Description, RecLV2."Document No.", RecLV2."Fecha alta") then begin
                                                    Error('Deberia haber pulsado Sí');
                                                end;
                                        end;
                                    until RecLV2.Next = 0;
                            end;
                        end;
                    end;


                    if ("Document Type" = 1) or ("Document Type" = 0) then begin
                        "Estado linea" := 2;
                        if "Unit Price" <> 0 then begin
                            if "Unit Price" <= Item."Unit Cost" then begin
                                "Estado linea" := 4;
                                if COMPANYNAME <> 'PEPE' then begin
                                    /////               MESSAGE('El precio de venta esta por debajo del coste, la linea se bloquea.');
                                end;
                            end;
                        end;
                    end;


                    "Precio base" := "Unit Price";

                    if ("Document Type" = 0) or ("Document Type" = 1) then begin
                        "Shortcut Dimension 1 Code" := SalesHeader."Salesperson Code";
                    end;

                end;

                /////



                /*
                
                IF ("Document Type"=1) OR ("Document Type"=0) THEN BEGIN
                    SalesLineDiscount.RESET;
                    SalesLineDiscount.SETRANGE(SalesLineDiscount.Code,Rec."No.");
                    SalesLineDiscount.SETRANGE(SalesLineDiscount."Sales Code","Sell-to Customer No.");
                    SalesLineDiscount.SETRANGE(SalesLineDiscount."Sales Type",SalesLineDiscount."Sales Type"::Regalo);
                    IF SalesLineDiscount.FINDFIRST THEN BEGIN
                        IF Quantity<>0 THEN BEGIN
                            IF xRec.Quantity<>Quantity THEN BEGIN
                                IF "Line No."<>0 THEN BEGIN
                                    RecLV22.RESET;
                                    RecLV22.SETRANGE(RecLV22."Document Type","Document Type");
                                    RecLV22.SETRANGE(RecLV22."Document No.","Document No.");
                                    RecLV22.SETRANGE(RecLV22."Producto asociado","Line No.");
                                    IF RecLV22.FINDFIRST THEN REPEAT
                                        RecLV22.DELETE;
                                    UNTIL RecLV22.NEXT=0;
                                    SalesLineDiscount.RESET;
                                    SalesLineDiscount.SETRANGE(SalesLineDiscount.Code,Rec."No.");
                                    SalesLineDiscount.SETRANGE(SalesLineDiscount."Sales Code","Sell-to Customer No.");
                                    SalesLineDiscount.SETRANGE(SalesLineDiscount."Sales Type",SalesLineDiscount."Sales Type"::Regalo);
                                    IF SalesLineDiscount.FINDFIRST THEN REPEAT
                                        RecLV22.RESET;
                                        RecLV22.SETRANGE(RecLV22."Document Type","Document Type");
                                        RecLV22.SETRANGE(RecLV22."Document No.","Document No.");
                                        IF RecLV22.FINDLAST THEN BEGIN
                                            LIN:=RecLV22."Line No.";
                                        END;
                                        RecLV22:=Rec;
                                        LIN:=LIN+100;
                                        RecLV22."Line No.":=LIN;
                                        RecLV22.VALIDATE(RecLV22."No.",SalesLineDiscount.Code);
                                        RecLV22.VALIDATE(RecLV22.Quantity,SalesLineDiscount."Minimum Quantity");
                                        RecLV22.VALIDATE(RecLV22."Line Discount %",SalesLineDiscount."Line Discount %");
                                        RecLV22."Producto asociado":=Rec."Line No.";
                                        RecLV22.INSERT(TRUE);
                                    UNTIL SalesLineDiscount.NEXT=0;
                                END;
                            END;
                        END;
                    END;
                END;
                
                */
            end;
        }


        field(50003; "Precio base"; Decimal)
        {
            Editable = false;
        }
        field(50004; "Precio final"; Decimal)
        {
            Editable = false;
        }
        field(50005; "Usuario alta"; Code[30])
        {
            Editable = false;
        }
        field(50006; "Fecha alta"; Date)
        {
            Editable = false;
        }
        field(50007; "Hora alta"; Time)
        {
            Editable = false;
        }
        field(50008; "Estado linea"; Option)
        {
            Editable = false;
            InitValue = Pendiente;
            OptionMembers = Pendiente,Servida,Cancelada,Resto;

            trigger OnValidate()
            begin
                /*
                IF "Estado linea"=4 THEN BEGIN
                     Rec91.GET(USERID);
                     IF NOT Rec91."Permite modificar estado lin.p" THEN BEGIN
                          ERROR('No tiene permiso para cambiar el estado linea.');
                     END;
                END;
                */

            end;
        }
        field(50017; Defectuosos; Boolean)
        {

            trigger OnValidate()
            begin
                /*
                
                Rec91.GET(USERID);
                IF NOT Rec91."Permiso Defectuoso" THEN BEGIN
                     ERROR('No puede utilizar este campo.');
                END;
                IF Defectuosos=TRUE THEN BEGIN
                     "Line Discount %":=100;
                      VALIDATE("Unit Price");
                     "Precio final":=0;
                END;
                IF Defectuosos=FALSE THEN BEGIN
                     "Line Discount %":=0;
                     VALIDATE("Unit Price");
                END;
                
                */

            end;
        }
        field(50019; "Dto 2009"; Decimal)
        {
        }
        field(50021; "Corrected Invoice No."; Code[20])
        {
            Caption = 'Corrected Invoice No.';

            trigger OnLookup()
            var
                SalesInvoiceHeader: Record "Sales Invoice Header";
                PostedSalesInvoices: Page "Posted Sales Invoices";
            begin
            end;

            trigger OnValidate()
            var
                SalesInvoiceHeader: Record "Sales Invoice Header";
            begin
            end;
        }
        field(50022; "Linea correccion"; Integer)
        {
        }
        field(50023; Vendedor; Code[10])
        {
        }
        field(50024; "Importe dto. vendedor"; Decimal)
        {
        }
        field(50027; "Nº expedición"; Code[10])
        {
        }
        field(50028; "Linea Nº expedición"; Integer)
        {
            Caption = 'Linea Nº expedición';
        }
        field(50029; "Producto asociado"; Integer)
        {
        }
        field(50031; "Precio final sin dto.comer"; Decimal)
        {
        }
        field(50032; "Acumula Importe dto. comer"; Decimal)
        {
            Editable = false;
        }
        field(50057; "Cantidad a pasar pedido"; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                IF "Cantidad a pasar a pedido">Quantity THEN BEGIN
                     ERROR('No es posible pasar mas de las pedidas.');
                END;
                */

            end;
        }
        field(50062; "Nº lote"; Code[20])
        {
        }
        field(50063; "Fecha caducidad"; Date)
        {
        }
        field(50068; "Cantidad anulada"; Decimal)
        {
            Editable = false;
        }
        field(50075; "Your Reference 2"; Code[10])
        {
            Caption = 'Your Reference';
        }
        field(50080; "Precio importado"; Decimal)
        {
        }
        field(50082; "id linea externo"; Code[100])
        {
        }
        field(50119; ean; Code[20])
        {
            CalcFormula = lookup(Item.ean where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50120; Referencia; Code[20])
        {
            trigger OnValidate()
            var
                noexiste: Boolean;
                Item22: Record Item;
            begin

                noexiste := false;
                Item22.Reset;
                Item22.SetCurrentkey("No.");
                Item22.SetRange("No.", Referencia);
                if Item22.FindSet then begin
                    Validate("No.", Referencia)
                end;
                if not Item22.FindSet then begin
                    noexiste := true;
                end;

                /*IF noexiste THEN BEGIN
                     Item22.RESET;
                     Item22.SETRANGE(ean,Referencia);
                     IF Item22.FINDSET THEN BEGIN
                         VALIDATE("No.",Item22."No.");
                         noexiste:=FALSE;
                    END;
                END;
                */
                if noexiste then begin
                    Error('No existe esta referencia.');
                end;

            end;
        }
        field(50125; "Cantidad master"; Decimal)
        {
            CalcFormula = lookup("Item Unit of Measure"."Qty. per Unit of Measure" where("Item No." = field("No."),
                                                                                          Code = const('MA')));
            FieldClass = FlowField;
        }
        field(50126; "Cantidad inner"; Decimal)
        {
            CalcFormula = lookup("Item Unit of Measure"."Qty. per Unit of Measure" where("Item No." = field("No."),
                                                                                          Code = const('IN')));
            FieldClass = FlowField;
        }
        field(50129; "Unidades venta"; Decimal)
        {
            CalcFormula = lookup(Item."Unidades venta" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50267; "Enviar a ADAIA"; Boolean)
        {
        }
        field(50510; "Descuento sin vendedor"; Decimal)
        {
        }
        field(50511; "Importe sin dto vendedor"; Decimal)
        {
        }
        field(50514; "Importe acumulado pedido"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Line Amount" where("Document Type" = field("Document Type"),
                                                                "Document No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50515; "% Dto. vendedor"; Decimal)
        {
            trigger OnValidate()
            var
                dtoantes: Decimal;
                sumadto: Decimal;
            begin


                if ("% Dto. vendedor" <> xRec."% Dto. vendedor") and (xRec."% Dto. vendedor" <> 0) then begin
                    Error('No se puede modificar, elimine la linea');
                end;



                dtoantes := Rec."Importe dto. vendedor";
                if ("Document Type" = 1) or ("Document Type" = 0) then begin
                    if "% Dto. vendedor" <> 0 then begin
                        ///IF ("% Dto. vendedor"<>xRec."% Dto. vendedor") AND (xRec."% Dto. vendedor"<>0) THEN BEGIN
                        ///ERROR('No se puede modificar, elimine la linea');
                        ///END;
                        if "Descuento sin vendedor" = 0 then begin
                            "Descuento sin vendedor" := "Line Discount %";
                            "Importe sin dto vendedor" := Amount;
                        end;
                        sumadto := "Descuento sin vendedor" + "% Dto. vendedor";
                        if sumadto > 100 then begin
                            sumadto := 100;
                        end;
                        Validate("Line Discount %", sumadto);
                        "Importe dto. vendedor" := "Importe sin dto vendedor" - Amount;
                    end;
                end;

                BUSCADTOCOMER;
                if "% Dto. vendedor" <> 0 then begin
                    // WEB1.00
                    if GuiAllowed then  // FIN
                        if not Confirm('Este descuento del %1 supone %2 euros,¿ Desea continuar ?', false,
                        "% Dto. vendedor", "Importe dto. vendedor") then begin
                            Error('Cancelado.');
                            "% Dto. vendedor" := 0;
                            "Importe dto. vendedor" := 0;
                        end;
                end;
            end;
        }
        field(50581; "Tipo preparacion"; Option)
        {
            CalcFormula = lookup(Item."Tipo preparacion" where("No." = field("No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,0-Sin Caja,1-Muy pequeño,2-Pequeño,3-Mediano,4-Grande,5- Extra Grande,6- Tubo';
            OptionMembers = " ","0-Sin Caja","1-Muy pequeño","2-Pequeño","3-Mediano","4-Grande","5- Extra Grande","6- Tubo";
        }
        field(50582; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
        }
        field(50584; "Precio Tarifa"; Decimal)
        {
        }
        field(50585; "Suma cdad padre_hijos"; Decimal)
        {
        }
        field(50586; "Dto% apli. lin."; Decimal)
        {
            Editable = false;
        }
        field(50587; "Incremento dto%"; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                IF "Line Discount % original"=0 THEN BEGIN
                     "Line Discount % original":="Line Discount %";
                END;
                
                IF "Inv. Discount Amount"=0 THEN BEGIN
                     PF2:="Precio final"*(100-"Incremento dto%")/100;
                     DTO:=(("Unit Price"-PF2)*100)/("Unit Price");
                     VALIDATE("Line Discount %",DTO);
                END;
                
                IF "Inv. Discount Amount"<>0 THEN BEGIN
                     PF2:=("Precio final"+"Inv. Discount Amount")*(100-"Incremento dto%")/100;
                     DTO:=(("Unit Price"-PF2)*100)/("Unit Price");
                     VALIDATE("Line Discount %",DTO);
                END;
                */

            end;
        }
        field(50588; "Line Discount % original"; Decimal)
        {
        }
        field(50590; "Importe inicial vendedor"; Decimal)
        {
            Editable = false;
        }
        field(50591; ImpLinea; Decimal)
        {
        }
        field(50592; "Producto Padre"; Code[20])
        {
        }
        field(50593; "Suma cdad. por envio"; Decimal)
        {

            CalcFormula = sum("Sales Line"."Outstanding Qty. (Base)" where("Nº expedición" = field("Nº expedición"),
                                                                         "No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50594; "Cantidad padre"; Decimal)
        {
            CalcFormula = sum("Sales Line".Quantity where("Document Type" = field("Document Type"),
                                                           "Document No." = field("Document No."),
                                                           "Producto Padre" = field("Producto Padre")));
            FieldClass = FlowField;
        }
        field(50595; "ean canarias"; Code[20])
        {
        }
        field(50596; "prod canarias"; Code[20])
        {
        }
        field(50597; "Linea pedido externo"; Code[20])
        {
        }
        field(50598; "Producto con reserva"; Boolean)
        {
            CalcFormula = lookup(Item."Producto con reserva" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50599; "Grupo clientes"; Code[20])
        {
            CalcFormula = lookup(Customer."Grupo clientes" where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
        }
        field(50600; "Fecha cabecera ofer/ped"; Date)
        {
            CalcFormula = lookup("Sales Header"."Order Date" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50601; "Estado presupuesto"; Option)
        {
            CalcFormula = lookup("Sales Header"."Estado presupuesto" where("No." = field("Document No.")));
            FieldClass = FlowField;
            OptionMembers = Activo,"Parcialmente procesado",Procesado;
        }
        field(50602; existe; Boolean)
        {
            CalcFormula = exist("Sales Header" where("Document Type" = field("Document Type"),
                                                      "No." = field("Document No.")));
            FieldClass = FlowField;
        }

        field(50503; "Estado"; Text[10])
        {
        }

        field(50504; RefLinProdWeb; Code[20])
        {
            trigger OnValidate()
            var
                RecProd: Record Item;
                CodProd: Code[20];
                RecRefCruz: Record "Item Reference";

            begin
                if RecProd.Get(RefLinProdWeb) then begin
                    CodProd := RecProd."No.";
                    rec.Validate(type, Rec.Type::Item);
                    Rec.Validate("No.", CodProd);
                end;
                if not RecProd.Get(RefLinProdWeb) then begin
                    RecRefCruz.Reset;
                    RecRefCruz.SetCurrentkey(RecRefCruz."Reference No.");
                    RecRefCruz.SetRange(RecRefCruz."Reference No.", RefLinProdWeb);
                    if RecRefCruz.FindFirst then begin
                        CodProd := RecRefCruz."Item No.";
                        rec.Validate(type, Rec.Type::Item);
                        Rec.Validate("No.", CodProd);
                        Rec.Validate("Unit of Measure Code", RecRefCruz."Unit of Measure");
                    end;
                end;
            end;


        }



    }


    keys
    {
        key(Key25; "Document Type", "No.", "Outstanding Quantity")
        {
        }
        key(Key26; "Document Type", "Outstanding Quantity")
        {
        }
        //key(Key27; "Document Type", "Usuario alta", "Sell-to Customer No.", "Outstanding Quantity")
        //{
        //}
        key(Key28; "Document Type", "Sell-to Customer No.", "Outstanding Quantity")
        {
        }
        //key(Key29; "Document Type", "No.", "Fecha alta")
        //{
        //}
    }

    procedure BUSCADTOCOMER()
    var
        SalesHeader: Record "Sales Header";
        AÑO: Integer;
        desded1: date;
        MES: Integer;
        RecFecha: Record date;
        hastad31: date;
        RecVende: Record "Salesperson/Purchaser";
        Rec3: Record "Objetivos vendedores";
        totaldtocomer: Decimal;
        dtoantes: Decimal;
    begin


        SalesHeader.Get("Document Type", "Document No.");
        AÑO := Date2dmy(SalesHeader."Order Date", 3);

        MES := Date2dmy(SalesHeader."Order Date", 2);
        desded1 := Dmy2date(1, MES, AÑO);
        RecFecha.Reset;
        RecFecha.SetRange(RecFecha."Period Type", 2);
        RecFecha.SetRange(RecFecha."Period Start", desded1);
        if RecFecha.FindFirst then begin
            hastad31 := RecFecha."Period End";
        end;


        RecVende.Get(SalesHeader."Salesperson Code");
        RecVende.SetRange(RecVende."Date Filter", desded1, hastad31);
        RecVende.CalcFields(RecVende."Importe Acumulado Dto.");

        Rec3.Reset;
        Rec3.SetRange(Rec3.Vendedor, SalesHeader."Salesperson Code");
        Rec3.SetRange(Rec3.Año, AÑO);
        Rec3.SetRange(Rec3.Tipo, 5);
        if Rec3.FindFirst then begin
            if MES = 1 then totaldtocomer := Rec3.Enero;
            if MES = 2 then totaldtocomer := Rec3.Febrero;
            if MES = 3 then totaldtocomer := Rec3.Marzo;
            if MES = 4 then totaldtocomer := Rec3.Abril;
            if MES = 5 then totaldtocomer := Rec3.Mayo;
            if MES = 6 then totaldtocomer := Rec3.Junio;
            if MES = 7 then totaldtocomer := Rec3.Julio;
            if MES = 8 then totaldtocomer := Rec3.Agosto;
            if MES = 9 then totaldtocomer := Rec3.Septiembre;
            if MES = 10 then totaldtocomer := Rec3.Octubre;
            if MES = 11 then totaldtocomer := Rec3.Noviembre;
            if MES = 12 then totaldtocomer := Rec3.Diciembre;
        end;
        if not Rec3.FindFirst then begin
            Error('No tiene tabla de descuentos aplicada.');
        end;
        if totaldtocomer = 0 then begin
            Error('No tiene tabla de descuentos aplicada.');
        end;

        if (RecVende."Importe Acumulado Dto." + "Importe dto. vendedor" - dtoantes) > totaldtocomer then begin
            Error('Supera el maximo permitido para este mes que es %1, y ya tiene %2 aplicado',
            totaldtocomer, RecVende."Importe Acumulado Dto.");
        end;
    end;

    trigger OnAfterModify()
    var
        SalesHeader: Record "Sales Header";
        UserSetup: Record "User Setup";
    begin
        if "Document Type" = 1 then begin
            UserSetup.Get(UserId);
            if UserSetup.Comercial <> '' then begin
                SalesHeader.Get("Document Type", "Document No.");
                if SalesHeader."Estado pedido" <> 2 then begin
                    Error('El pedido no se puede modificar.');
                end;
            end;
        end;


        if "Document Type" = 0 then begin
            SalesHeader.Get("Document Type", "Document No.");
            if SalesHeader."Estado presupuesto" <> 0 then begin
                Error('Ya no se pueden introducir nuevas lineas, porque su estado es Parcialmente procesado. %1 %2', SalesHeader."No.", SalesHeader."Estado presupuesto");
            end;
        end;

        if "Producto asociado" <> 0 then begin
            if xRec."Line Discount %" <> Rec."Line Discount %" then begin
                Error('Es una linea asociada, no se puede modificar.');
            end;
        end;
    end;

    trigger OnAfterInsert()
    var
        SalesHeader: Record "Sales Header";
    begin
        "Usuario alta" := UserId;
        "Fecha alta" := Today;
        "Hora alta" := Time;




        if ("Document Type" = 1) or ("Document Type" = 0) then begin
            SalesHeader.Get("Document Type", "Document No.");
            "Shortcut Dimension 1 Code" := SalesHeader."Salesperson Code";
            Vendedor := SalesHeader."Salesperson Code";
        end;
    end;

    trigger OnAfterDelete()
    var
        RecLCV: Record "Sales Comment Line";
        Item: Record item;
        RecBom: Record "BOM Component";
        RecLV22: Record "Sales Line";
    begin
        if ("Document Type" = 1) or ("Document Type" = 0) then begin
            RecLCV.Reset;
            RecLCV.SetRange(RecLCV."Document Type", "Document Type");
            RecLCV.SetRange(RecLCV."No.", "Document No.");
            if RecLCV.FindLast then begin
                RecLCV."Document Type" := "Document Type";
                RecLCV."No." := "Document No.";
                RecLCV."Line No." := RecLCV."Line No." + 10000;
                RecLCV.Comment := copystr('Ref. eliminada: ' + Format("No.") + ' ' + Format(Description) + ' Cantidad:' + Format(Quantity) +
                ' Por: ' + Format(UserId) + ' ' + Format(Today) + ' ' + Format(Time), 1, 80);
                RecLCV."No se puede eliminar" := true;
                RecLCV."Usuario alta" := UserId;
                RecLCV."Fecha alta" := Today;
                RecLCV."Hora alta" := Time;
                RecLCV.Date := Today;
                RecLCV.Insert;
            end;
            if not RecLCV.FindLast then begin
                RecLCV."Document Type" := "Document Type";
                RecLCV."No." := "Document No.";
                RecLCV."Line No." := 10000;
                RecLCV.Comment := copystr('Ref. eliminada: ' + Format("No.") + ' ' + Format(Description) + ' Cantidad:' + Format(Quantity) +
                ' Por: ' + Format(UserId) + ' ' + Format(Today) + ' ' + Format(Time), 1, 80);
                RecLCV."No se puede eliminar" := true;
                RecLCV."Usuario alta" := UserId;
                RecLCV."Fecha alta" := Today;
                RecLCV."Hora alta" := Time;
                RecLCV.Date := Today;
                RecLCV.Insert;
            end;

        end;

        if Type = 2 then begin
            if Item.Get("No.") then begin
                if Item."Tiene productos asociados" then begin
                    RecBom.Reset;
                    RecBom.SetRange(RecBom."Parent Item No.", "No.");
                    if RecBom.FindFirst then
                        repeat
                            RecLV22.Reset;
                            RecLV22.SetCurrentkey(RecLV22."Document Type", RecLV22."Document No.");
                            RecLV22.SetRange(RecLV22."Document Type", "Document Type");
                            RecLV22.SetRange(RecLV22."Document No.", "Document No.");
                            RecLV22.SetRange(RecLV22."No.", RecBom."No.");
                            if RecLV22.FindFirst then
                                repeat
                                    RecLV22.Delete(true);
                                until RecLV22.Next = 0;
                        until RecBom.Next = 0;
                end;

            end;
        end;
    end;
}
