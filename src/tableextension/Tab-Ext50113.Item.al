tableextension 50113 Item extends Item
{
    fields
    {
        field(50000; asd; Code[20])
        {
        }
        field(50001; "Clasificación A,B,C"; Option)
        {
            InitValue = C;
            OptionCaption = 'A,B,C';
            OptionMembers = A,B,C;
        }
        field(50002; "Fecha asignada clasificación"; Date)
        {
        }
        field(50003; "Fecha Descatalogación"; Date)
        {
        }
        field(50004; "% clasi A,B,C"; Decimal)
        {
        }
        field(50005; "Usuario última modificación"; Code[20])
        {
            TableRelation = User;
        }
        field(50006; "Fecha Alta"; Date)
        {
        }
        field(50007; "Fecha Lanzamiento"; Date)
        {
        }
        field(50008; "Fecha última modificación"; Date)
        {
        }
        field(50009; "Acumu. A,B,C"; Decimal)
        {
        }
        field(50010; "Fecha recalcula no permitir"; DateTime)
        {
        }
        field(50011; "Clase logistica"; Code[2])
        {
        }
        field(50012; "Envíos (cdad.)"; Decimal)
        {
            CalcFormula = - sum("Item Ledger Entry".Quantity where("Entry Type" = const(Sale),
                                                                   "Item No." = field("No."),
                                                                   "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                   "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                   "Location Code" = field("Location Filter"),
                                                                   "Drop Shipment" = field("Drop Shipment Filter"),
                                                                   "Variant Code" = field("Variant Filter"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Lot No." = field("Lot No. Filter"),
                                                                   "Serial No." = field("Serial No. Filter")));
            Caption = 'Envíos (cdad.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50013; "Ajustes (cdad.)"; Decimal)
        {
            CalcFormula = - sum("Item Ledger Entry".Quantity where("Entry Type" = const("Negative Adjmt."),
                                                                   "Item No." = field("No."),
                                                                   "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                   "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                   "Location Code" = field("Location Filter"),
                                                                   "Drop Shipment" = field("Drop Shipment Filter"),
                                                                   "Variant Code" = field("Variant Filter"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Lot No." = field("Lot No. Filter"),
                                                                   "Serial No." = field("Serial No. Filter")));
            Caption = 'Negative Adjmt. (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50014; "Pro.Ped.Compra (cdad.)"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Qty. (Base)" where("Document Type" = const(Quote),
                                                                               Type = const(Item),
                                                                               "No." = field("No."),
                                                                               "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                               "Location Code" = field("Location Filter"),
                                                                               "Drop Shipment" = field("Drop Shipment Filter"),
                                                                               "Variant Code" = field("Variant Filter"),
                                                                               "Bin Code" = field("Bin Filter"),
                                                                               "Expected Receipt Date" = field("Date Filter")));
            Caption = 'Qty. on Purch. Order';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50015; "Prohibido Amazon"; Boolean)
        {
        }
        field(50016; "Producto FRAGIL"; Boolean)
        {
        }
        field(50017; "Observaciones AMAZON"; Text[40])
        {
        }
        field(50018; "Estado Producto"; Option)
        {
            OptionCaption = 'Activo,Descatalogado,Anulado,Sin actualizar';
            OptionMembers = Activo,Descatalogado,Anulado,"Sin actualizar";

            trigger OnValidate()
            begin
                /*
                     RecITEMPepe.CHANGECOMPANY('PEPE');
                     IF RecITEMPepe.GET("No.") THEN BEGIN
                          RecITEMPepe."Estado Producto":=Rec."Estado Producto";
                          RecITEMPepe.MODIFY;
                     END;
                     IF "Estado Producto"=1 THEN BEGIN
                          "Fecha Descatalogación":=TODAY;
                     END;
                     IF "Estado Producto"=0 THEN BEGIN
                          "Fecha Descatalogación":=0D;
                     END;
                     */

            end;
        }
        field(50019; "Fecha prohibido Amazon"; Date)
        {
        }
        field(50020; "Usuario modificación"; Code[20])
        {
        }
        field(50021; "Hora modificación"; Time)
        {
        }
        field(50022; "Stock para Catit"; Decimal)
        {
        }
        field(50023; "Precio recomendado"; Decimal)
        {
        }
        field(50024; Familia; Code[50])
        {
            TableRelation = Familias.Familia where(Línea = field("Gen. Prod. Posting Group"));
        }
        field(50025; Subfamilia; Code[50])
        {
            TableRelation = Familias.Subfamilia where(Línea = field("Gen. Prod. Posting Group"),
                                                       Familia = field(Familia));
        }
        field(50026; ean; Code[20])
        {

            trigger OnValidate()
            begin


                if ean <> '' then begin
                    RecUMP.Reset;
                    RecUMP.SetCurrentkey(RecUMP.ean);
                    RecUMP.SetRange(RecUMP.ean, ean);
                    if RecUMP.FindSet then
                        repeat
                            if RecUMP."Item No." <> "No." then begin
                                Error('Este ean ya existe en la referencia %1', RecUMP."Item No.");
                            end;
                        until RecUMP.Next = 0;
                end;


                RecUMP.Reset;
                RecUMP.SetRange(RecUMP."Item No.", "No.");
                RecUMP.SetRange(RecUMP.Code, 'UDS');
                if RecUMP.FindFirst then begin
                    RecUMP.ean := ean;
                    RecUMP.Modify;
                    Commit;
                end;

                /////Item No.,Variant Code,Unit of Measure,Cross-Reference Type,Cross-Reference Type No.,Cross-Reference No.


                RecRefCruz.Reset;
                RecRefCruz.SetRange(RecRefCruz."Item No.", "No.");
                RecRefCruz.SetRange(RecRefCruz."Unit of Measure", 'UDS');
                RecRefCruz.SetRange(RecRefCruz."Reference Type", 3);
                RecRefCruz.SetRange(RecRefCruz."Reference No.", ean);
                if RecRefCruz.FindFirst then begin
                    RecRefCruz."Reference No." := ean;
                    RecRefCruz.Modify;
                    Commit;
                end;
                RecRefCruz.Reset;
                RecRefCruz.SetRange(RecRefCruz."Item No.", "No.");
                RecRefCruz.SetRange(RecRefCruz."Unit of Measure", 'UDS');
                RecRefCruz.SetRange(RecRefCruz."Reference Type", 3);
                RecRefCruz.SetRange(RecRefCruz."Reference No.", ean);
                if not RecRefCruz.FindFirst then begin
                    RecRefCruz."Item No." := "No.";
                    RecRefCruz."Unit of Measure" := 'UDS';
                    RecRefCruz."Reference Type" := 3;
                    RecRefCruz."Reference No." := ean;
                    RecRefCruz.Insert;
                    Commit;
                end;
            end;
        }
        field(50027; "Tipo proveedor"; Option)
        {
            CalcFormula = lookup(Vendor."Tipo proveedor" where("No." = field("Vendor No.")));
            FieldClass = FlowField;
            OptionCaption = 'Hagen,No Hagen,Acreedor';
            OptionMembers = Hagen,"No Hagen",Acreedor;

            trigger OnValidate()
            begin
                /*
                VENTANA.OPEN('#1#########################################################################################################');
                
                     ////// Hagen,No Hagen,Acreedor
                     Item.RESET;
                     Item.SETCURRENTKEY(Item."Vendor No.");
                     Item.SETRANGE(Item."Vendor No.","No.");
                     cuantos:=Item.COUNTAPPROX;
                     IF Item.FINDFIRST THEN REPEAT
                     cuenta:=cuenta+1;
                     VENTANA.UPDATE(1,FORMAT(cuenta)+'/'+FORMAT(cuantos)+' '+Item."No.");
                          IF Rec."Tipo proveedor"=0 THEN BEGIN
                               Item."Producto Hagen":=TRUE;
                               Item.MODIFY;
                               Rec115.RESET;
                               Rec115.SETCURRENTKEY(Rec115."No.");
                               Rec115.SETRANGE(Rec115."No.",Item."No.");
                               IF Rec115.FINDFIRST THEN REPEAT
                                    VENTANA.UPDATE(1,FORMAT(cuenta)+'/'+FORMAT(cuantos)+' '+Item."No."+'115'+FORMAT(Rec115."Fecha alta"));
                                    Rec115."Producto Hagen":=TRUE;
                                    Rec115.MODIFY;
                               UNTIL Rec115.NEXT=0;
                               Rec111.RESET;
                               Rec111.SETCURRENTKEY(Rec111."No.");
                               Rec111.SETRANGE(Rec111."No.",Item."No.");
                               IF Rec111.FINDFIRST THEN REPEAT
                                    VENTANA.UPDATE(1,FORMAT(cuenta)+'/'+FORMAT(cuantos)+' '+Item."No."+'111'+FORMAT(Rec111."Fecha alta"));
                                    Rec111."Producto Hagen":=TRUE;
                                    Rec111.MODIFY;
                               UNTIL Rec111.NEXT=0;
                               Rec113.RESET;
                               Rec113.SETCURRENTKEY(Rec113."No.");
                               Rec113.SETRANGE(Rec113."No.",Rec."No.");
                               IF Rec113.FINDFIRST THEN REPEAT
                                    VENTANA.UPDATE(1,FORMAT(cuenta)+'/'+FORMAT(cuantos)+' '+Item."No."+'113'+FORMAT(Rec113."Fecha alta"));
                                    Rec113."Producto Hagen":=TRUE;
                                    Rec113.MODIFY;
                               UNTIL Rec113.NEXT=0;
                               Rec37.RESET;
                               Rec37.SETCURRENTKEY(Rec37."No.");
                               Rec37.SETRANGE(Rec37."No.",Item."No.");
                               IF Rec37.FINDFIRST THEN REPEAT
                                     VENTANA.UPDATE(1,FORMAT(cuenta)+'/'+FORMAT(cuantos)+' '+Item."No."+'37'+FORMAT(Rec37."Fecha alta"));
                                     Rec37."Producto Hagen":=TRUE;
                                     Rec37.MODIFY;
                               UNTIL Rec37.NEXT=0;
                          END;
                          IF Rec."Tipo proveedor"=1 THEN BEGIN
                               Item."Producto Hagen":=FALSE;
                               Item.MODIFY;
                               Rec115.RESET;
                               Rec115.SETCURRENTKEY(Rec115."No.");
                               Rec115.SETRANGE(Rec115."No.",Item."No.");
                               IF Rec115.FINDFIRST THEN REPEAT
                                    VENTANA.UPDATE(1,FORMAT(cuenta)+'/'+FORMAT(cuantos)+' '+Item."No."+'115'+FORMAT(Rec115."Fecha alta"));
                                    Rec115."Producto Hagen":=FALSE;
                                    Rec115.MODIFY;
                               UNTIL Rec115.NEXT=0;
                               Rec111.RESET;
                               Rec111.SETCURRENTKEY(Rec111."No.");
                               Rec111.SETRANGE(Rec111."No.",Item."No.");
                               IF Rec111.FINDFIRST THEN REPEAT
                                    VENTANA.UPDATE(1,FORMAT(cuenta)+'/'+FORMAT(cuantos)+' '+Item."No."+'111'+FORMAT(Rec111."Fecha alta"));
                                    Rec111."Producto Hagen":=FALSE;
                                    Rec111.MODIFY;
                               UNTIL Rec111.NEXT=0;
                               Rec113.RESET;
                               Rec113.SETCURRENTKEY(Rec113."No.");
                               Rec113.SETRANGE(Rec113."No.",Item."No.");
                               IF Rec113.FINDFIRST THEN REPEAT
                                    VENTANA.UPDATE(1,FORMAT(cuenta)+'/'+FORMAT(cuantos)+' '+Item."No."+'113'+FORMAT(Rec113."Fecha alta"));
                                    Rec113."Producto Hagen":=FALSE;
                                    Rec113.MODIFY;
                               UNTIL Rec113.NEXT=0;
                               Rec37.RESET;
                               Rec37.SETCURRENTKEY(Rec37."No.");
                               Rec37.SETRANGE(Rec37."No.",Item."No.");
                               IF Rec37.FINDFIRST THEN REPEAT
                                    VENTANA.UPDATE(1,FORMAT(cuenta)+'/'+FORMAT(cuantos)+' '+Item."No."+'37'+FORMAT(Rec37."Fecha alta"));
                                    Rec37."Producto Hagen":=FALSE;
                                    Rec37.MODIFY;
                               UNTIL Rec37.NEXT=0;
                          END;
                          IF Rec."Tipo proveedor"=2 THEN BEGIN
                               Item."Producto Hagen":=FALSE;
                               Item.MODIFY;
                               Rec115.RESET;
                               Rec115.SETCURRENTKEY(Rec115."No.");
                               Rec115.SETRANGE(Rec115."No.",Item."No.");
                               IF Rec115.FINDFIRST THEN REPEAT
                                    VENTANA.UPDATE(1,FORMAT(cuenta)+'/'+FORMAT(cuantos)+' '+Item."No."+'115'+FORMAT(Rec115."Fecha alta"));
                                    Rec115."Producto Hagen":=FALSE;
                                    Rec115.MODIFY;
                               UNTIL Rec115.NEXT=0;
                               Rec111.RESET;
                               Rec111.SETCURRENTKEY(Rec111."No.");
                               Rec111.SETRANGE(Rec111."No.",Item."No.");
                               IF Rec111.FINDFIRST THEN REPEAT
                                    VENTANA.UPDATE(1,FORMAT(cuenta)+'/'+FORMAT(cuantos)+' '+Item."No."+'111'+FORMAT(Rec111."Fecha alta"));
                                    Rec111."Producto Hagen":=FALSE;
                                    Rec111.MODIFY;
                               UNTIL Rec111.NEXT=0;
                               Rec113.RESET;
                               Rec113.SETCURRENTKEY(Rec113."No.");
                               Rec113.SETRANGE(Rec113."No.",Item."No.");
                               IF Rec113.FINDFIRST THEN REPEAT
                                    VENTANA.UPDATE(1,FORMAT(cuenta)+'/'+FORMAT(cuantos)+' '+Item."No."+'113'+FORMAT(Rec115."Fecha alta"));
                                    Rec113."Producto Hagen":=FALSE;
                                    Rec113.MODIFY;
                               UNTIL Rec113.NEXT=0;
                               Rec37.RESET;
                               Rec37.SETCURRENTKEY(Rec37."No.");
                               Rec37.SETRANGE(Rec37."No.",Item."No.");
                               IF Rec37.FINDFIRST THEN REPEAT
                                    VENTANA.UPDATE(1,FORMAT(cuenta)+'/'+FORMAT(cuantos)+' '+Item."No."+'37'+FORMAT(Rec37."Fecha alta"));
                                    Rec37."Producto Hagen":=FALSE;
                                    Rec37.MODIFY;
                               UNTIL Rec37.NEXT=0;
                          END;
                          COMMIT;
                     UNTIL Item.NEXT=0;
                
                VENTANA.CLOSE;
                
                MESSAGE('hecho');
                */

            end;
        }
        field(50028; "Criterio rotacion"; Option)
        {
            InitValue = FE;
            OptionMembers = FC,FE,FF,LO;
        }
        field(50029; "Unidades venta"; Decimal)
        {
        }
        field(50030; "Permite fraccionar venta"; Boolean)
        {
        }
        field(50031; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(50032; "Stock Bloqueo Amz"; Decimal)
        {
        }
        field(50033; "Kgs. de plástico"; Decimal)
        {
        }
        field(50034; "Pdte. Enviar a WEB"; Boolean)
        {
        }
        field(50038; "Ref. AMAZON"; Code[20])
        {

            trigger OnValidate()
            begin
                /*
                RecSP.RESET;
                RecSP.SETRANGE(RecSP."Item No.","No.");
                RecSP.SETRANGE(RecSP."Sales Code",'AMAZON');
                IF RecSP.FINDFIRST THEN REPEAT
                     RecSP."Ref. hagen":="Ref. AMAZON";
                     RecSP.MODIFY;
                UNTIL RecSP.NEXT=0;
                */

            end;
        }
        field(50039; "RII-AAEE"; Code[20])
        {
        }
        field(50050; "Cantidad palets"; Decimal)
        {
        }
        field(50051; "Cantidad master"; Decimal)
        {
            CalcFormula = lookup("Item Unit of Measure"."Qty. per Unit of Measure" where("Item No." = field("No."),
                                                                                          Code = const('MA')));
            FieldClass = FlowField;
        }
        field(50052; "Cantidad inner"; Decimal)
        {
            CalcFormula = lookup("Item Unit of Measure"."Qty. per Unit of Measure" where("Item No." = field("No."),
                                                                                          Code = const('IN')));
            FieldClass = FlowField;
        }
        field(50053; "Fecha proxima recepción conten"; Date)
        {
            CalcFormula = lookup("Purchase Line"."Expected Receipt Date" where("Document Type" = const(Order),
                                                                                "No." = field("No."),
                                                                                "Outstanding Quantity" = filter(<> 0)));
            FieldClass = FlowField;
        }
        field(50054; "Cantidad facturada"; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line".Quantity where("No." = field("No."),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Sell-to Country/Region Code" = field("Filtro Pais"),
                                                                   "Sell-to Customer No." = field("Filtro Cliente")/*,
                                                                   "Grupo clientes" = field("Filtro Grupo clientes")*/));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50055; "Cantidad abonada"; Decimal)
        {
            CalcFormula = - sum("Sales Cr.Memo Line".Quantity where("No." = field("No."),
                                                                    "Posting Date" = field("Date Filter"),
                                                                    "Sell-to Country/Region Code" = field("Filtro Pais"),
                                                                    "Sell-to Customer No." = field("Filtro Cliente")/*,
                                                                    "Grupo clientes" = field("Filtro Grupo clientes")*/));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50056; "Importe facturado"; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line".Amount where("No." = field("No."),
                                                                 "Posting Date" = field("Date Filter"),
                                                                 "Sell-to Country/Region Code" = field("Filtro Pais"),
                                                                 "Sell-to Customer No." = field("Filtro Cliente")/*,
                                                                 "Grupo clientes" = field("Filtro Grupo clientes")*/));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50057; "Importe abonado"; Decimal)
        {
            CalcFormula = - sum("Sales Cr.Memo Line".Amount where("No." = field("No."),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Sell-to Country/Region Code" = field("Filtro Pais"),
                                                                  "Sell-to Customer No." = field("Filtro Cliente")/*,
                                                                  "Grupo clientes" = field("Filtro Grupo clientes")*/));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50058; "Cantidad fabricada"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Entry Type" = filter("Positive Adjmt." | "Negative Adjmt.")));
            FieldClass = FlowField;
        }
        field(50059; "Tipo producto"; Option)
        {
            OptionMembers = Producto,Contable;
        }
        field(50062; "Unidad compra"; Decimal)
        {
        }
        field(50064; "Fecha proxima recepción pedido"; Date)
        {
            CalcFormula = lookup("Purchase Line"."Expected Receipt Date" where("Document Type" = const(Quote),
                                                                                "No." = field("No."),
                                                                                "Outstanding Quantity" = filter(<> 0)));
            FieldClass = FlowField;
        }
        field(50065; "Comentario para pedido1"; Text[30])
        {
        }
        field(50066; "Comentario para pedido2"; Text[30])
        {
        }
        field(50069; "Tipo palet"; Option)
        {
            OptionMembers = E80,A100;
        }
        field(50070; "Tipo preparacion"; Option)
        {
            OptionCaption = ' ,0-Sin Caja,1-Muy pequeño,2-Pequeño,3-Mediano,4-Grande,5- Extra Grande,6-Tubo,7-Alargado,8-Cuadrado,9-Gateras,10-Arena';
            OptionMembers = " ","0-Sin Caja","1-Muy pequeño","2-Pequeño","3-Mediano","4-Grande","5- Extra Grande","6-Tubo","7-Alargado","8-Cuadrado","9-Gateras","10-Arena";
        }
        field(50071; "Existencia TENERIFE"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Location Code" = const('TENERIFE'),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter")));
            Caption = 'Existencia TENERIFE';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50072; "Producto almacenable"; Boolean)
        {
        }
        field(50076; "Tiene productos asociados"; Boolean)
        {
        }
        field(50077; "Existencia TRANS"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Location Code" = const('TRANS'),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter")));
            Caption = 'Existencia TRANS';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50078; "Existencia OPER"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Location Code" = const('OPER'),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter")));
            Caption = 'Existencia OPER';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50079; "Existencia FOB"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Location Code" = const('FOB'),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter")));
            Caption = 'Existencia FOB';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50080; "Existencia SILLA"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Location Code" = const('SILLA'),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter")));
            Caption = 'Existencia SILLA';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50081; "Cdad. en oferta compra"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Qty. (Base)" where("Document Type" = const(Quote),
                                                                               Type = const(Item),
                                                                               "No." = field("No."),
                                                                               "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                               "Location Code" = field("Location Filter"),
                                                                               "Drop Shipment" = field("Drop Shipment Filter"),
                                                                               "Variant Code" = field("Variant Filter"),
                                                                               "Bin Code" = field("Bin Filter"),
                                                                               "Expected Receipt Date" = field("Date Filter")));
            Caption = 'Cdad. en oferta compra';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50082; "Enviar siempre"; Boolean)
        {
        }
        field(50083; "Cantidad palet transporte alma"; Integer)
        {
        }
        field(50084; "Cantidad palet americano"; Integer)
        {
        }
        field(50085; "Existencia VCD"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Location Code" = const('VCD'),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter")));
            Caption = 'Existencia VCD';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50088; "No permite pedido"; Boolean)
        {

            trigger OnValidate()
            begin
                /*
                IF "No permite pedido"=FALSE THEN BEGIN
                     "Texto no permite pedido":='';
                END;
                */

            end;
        }
        field(50089; "Texto no permite pedido"; Text[30])
        {

            trigger OnValidate()
            begin
                /*
                IF NOT "No permite pedido" THEN BEGIN
                     IF "Texto no permite pedido"<>'' THEN BEGIN
                          ERROR('Falta click de "No permite pedido"');
                     END;
                END;
                */

            end;
        }
        field(50092; "Producto NO automatico"; Boolean)
        {
        }
        field(50097; "Fecha en picking"; Date)
        {
        }
        field(50098; "Ref. hagen"; Code[20])
        {
        }
        field(50099; "Fecha disponible Web"; Date)
        {
        }
        field(50100; "Producto PADRE"; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                /*
                
                     RecITEMPepe.CHANGECOMPANY('PEPE');
                     IF RecITEMPepe.GET("No.") THEN BEGIN
                          RecITEMPepe."Producto PADRE":=Rec."Producto PADRE";
                          RecITEMPepe.MODIFY;
                     END;
                     */

            end;
        }
        field(50101; Marca; Code[20])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(Marcas));
        }
        field(50107; "Descripcion web"; Text[200])
        {

            trigger OnValidate()
            begin

                /*
                     RecITEMPepe.CHANGECOMPANY('PEPE');
                     IF RecITEMPepe.GET("No.") THEN BEGIN
                          RecITEMPepe."Descripcion web":=Rec."Descripcion web";
                          RecITEMPepe.MODIFY;
                     END;
                     */

            end;
        }
        field(50109; "Enviar a web"; Boolean)
        {
        }
        field(50111; "Producto con reserva"; Boolean)
        {
        }
        field(50113; "Metros Cúbicos Master"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(50114; "Kilos Master"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(50115; "EAN INNER"; Code[50])
        {
            CalcFormula = lookup("Item Reference"."Reference No." where("Item No." = field("No."),
                                                                                     "Unit of Measure" = const('IN')));
            FieldClass = FlowField;
        }
        field(50116; "EAN MASTER"; Code[50])
        {
            CalcFormula = lookup("Item Reference"."Reference No." where("Item No." = field("No."),
                                                                                     "Unit of Measure" = const('MA')));
            FieldClass = FlowField;
        }
        field(50119; "Etiqueta portugues"; Boolean)
        {
        }
        field(50120; "Tamaño etiqueta"; Option)
        {
            OptionCaption = 'Pequeña,Mediana,Grande';
            OptionMembers = "Pequeña",Mediana,Grande;
        }
        field(50121; "Alto master"; Decimal)
        {
        }
        field(50122; "Ancho master"; Decimal)
        {
        }
        field(50123; "Largo master"; Decimal)
        {
        }
        field(50124; Alto; Decimal)
        {
        }
        field(50125; Ancho; Decimal)
        {
        }
        field(50126; Largo; Decimal)
        {
        }
        field(50128; Ventas; Decimal)
        {
        }
        field(50129; Promedio; Decimal)
        {
        }
        field(50130; Rotacion; Decimal)
        {
        }
        field(50131; Dias; Decimal)
        {
        }
        field(50132; "Producto web"; Boolean)
        {
            InitValue = true;
        }
        field(50134; "Unidad expedicion ECI"; Integer)
        {
        }
        field(50135; "+ Linea"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50136; "+ Familia"; BigInteger)
        {

            trigger OnValidate()
            begin
                //"Actualizar WEB" := TRUE;
            end;
        }
        field(50137; "+ Familia 2"; BigInteger)
        {

            trigger OnValidate()
            begin

                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50138; "+ Familia 3"; BigInteger)
        {

            trigger OnValidate()
            begin

                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50139; "+ Familia 4"; BigInteger)
        {

            trigger OnValidate()
            begin

                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50140; "+ Subfamilia"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50141; "+ Subfamilia 2"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50142; "+ Subfamilia 3"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50143; "+ Subfamilia 4"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50144; "+ Familia 1"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50145; "+ Subfamilia 1"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50146; "+ Linea 1"; BigInteger)
        {

            trigger OnValidate()
            begin
                /////"Actualizar WEB" := TRUE;
            end;
        }
        field(50147; "+ Linea 2"; BigInteger)
        {

            trigger OnValidate()
            begin
                ///"Actualizar WEB" := TRUE;
            end;
        }
        field(50148; "+ Linea 3"; BigInteger)
        {

            trigger OnValidate()
            begin
                ////"Actualizar WEB" := TRUE;
            end;
        }
        field(50149; "+ Linea 4"; BigInteger)
        {

            trigger OnValidate()
            begin
                ////"Actualizar WEB" := TRUE;
            end;
        }
        field(50150; "Estado WEB Inactivo"; Boolean)
        {
        }
        field(50152; "Producto Hagen"; Boolean)
        {
        }
        field(50155; "Largo producto"; Decimal)
        {
        }
        field(50156; "Ancho producto"; Decimal)
        {
        }
        field(50157; "Alto producto"; Decimal)
        {
        }
        field(50160; "Ref. Catit"; Code[20])
        {
        }
        field(50161; "Coste Catit"; Decimal)
        {
        }
        field(50162; "Familia Catit"; Code[30])
        {
            TableRelation = "Familias catit"."Familia Catit" where("Subfamilia Catit" = const(''));
        }
        field(50163; "Subfamilia Catit"; Code[30])
        {
            TableRelation = "Familias catit"."Subfamilia Catit" where("Familia Catit" = field("Familia Catit"));
        }
        field(50164; "Estatus Web"; Option)
        {
            OptionCaption = 'Activo,Inactivo';
            OptionMembers = Activo,Inactivo;
        }
        field(50165; "Atributo 1"; Code[10])
        {
            TableRelation = "Mul.atributos".Codigo1 where(Tabla = const(Atributos));
        }
        field(50166; "Atributo 2"; Code[10])
        {
            TableRelation = "Mul.atributos".Codigo1 where(Tabla = const(Atributos));
        }
        field(50167; "Atributo 3"; Code[10])
        {
            TableRelation = "Mul.atributos".Codigo1 where(Tabla = const(Atributos));
        }
        field(50168; "Valor Atributo 1"; Code[10])
        {
            TableRelation = "Mul.atributos".Codigo2 where(Tabla = const("Valor Atributo"),
                                                           Codigo1 = field("Atributo 1"));
        }
        field(50169; "Valor Atributo 2"; Code[10])
        {
            TableRelation = "Mul.atributos".Codigo2 where(Tabla = const("Valor Atributo"),
                                                           Codigo1 = field("Atributo 2"));
        }
        field(50170; "Valor Atributo 3"; Code[10])
        {
            TableRelation = "Mul.atributos".Codigo2 where(Tabla = const("Valor Atributo"),
                                                           Codigo1 = field("Atributo 3"));
        }
        field(50171; "NO-Rotura de Stock"; Boolean)
        {
        }
        field(50172; "Clasificacion CANADA"; Option)
        {
            OptionCaption = ' ,Catit,Catit 2.0,Catit Food,Catit Treats,Catit Ltter,Catit Vesper';
            OptionMembers = " ",Catit,"Catit 2.0","Catit Food","Catit Treats","Catit Ltter","Catit Vesper";
        }
        field(50173; "Fecha modif"; DateTime)
        {
        }
        field(50174; "Fecha sub web"; DateTime)
        {
        }
        field(50200; Temporalidad; Option)
        {
            OptionCaption = '1-Todo el año,2-Invierno,3- Verano';
            OptionMembers = "1-Todo el año","2-Invierno","3- Verano";
        }
        field(50201; "Objetivo Anual"; Decimal)
        {
        }
        field(50202; "Objetivo trimestre 1"; Decimal)
        {
        }
        field(50203; "Objetivo trimestre 2"; Decimal)
        {
        }
        field(50204; "Objetivo trimestre 3"; Decimal)
        {
        }
        field(50205; "Objetivo trimestre 4"; Decimal)
        {
        }
        field(50279; "Filtro Pais"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Country/Region";
        }
        field(50280; "Existencia SILLA SALDO"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Location Code" = const('SILLA'),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter"),
                                                                  "Posting Date" = field("Date Filter")));
            Caption = 'Existencia SILLA SALDO';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50281; "Filtro Cliente"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Customer;
        }
        field(50282; "Alto CAJA"; Decimal)
        {
        }
        field(50283; "Ancho CAJA"; Decimal)
        {
        }
        field(50284; "Largo CAJA"; Decimal)
        {
        }
        field(50285; "Volumen CAJA"; Decimal)
        {
        }
        field(50286; "Alto INNER"; Decimal)
        {
        }
        field(50287; "Ancho INNER"; Decimal)
        {
        }
        field(50288; "Largo INNER"; Decimal)
        {
        }
        field(50289; "Volumen INNER"; Decimal)
        {
        }
        field(50291; "Imagen Articulo WEB"; Text[200])
        {
        }
        field(50292; "Filtro Grupo clientes"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Multitabla.Codigo where(Tabla = const("Grupo de clientes"));
        }
        field(50293; "NO MULTIPEDIDO"; Boolean)
        {
        }
        field(50294; "Importe ABC"; Decimal)
        {
        }
        field(50295; "Importe total ABC"; Decimal)
        {
        }
        field(50301; "nulo  Descripcion Hijo"; Text[1])
        {

            trigger OnValidate()
            begin


                /*
                     RecITEMPepe.CHANGECOMPANY('PEPE');
                     IF RecITEMPepe.GET("No.") THEN BEGIN
                          RecITEMPepe."Descripcion Hijo":=Rec."Descripcion Hijo";
                          RecITEMPepe.MODIFY;
                     END;
                     */

            end;
        }
        field(50306; "Cantidad colchon web"; Decimal)
        {
        }
        field(50307; "Stock para la web"; Decimal)
        {
        }
        field(50308; "Stock en HAGEN"; Decimal)
        {
        }
        field(50309; "Tarifa 2019"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Unit Price" where("Item No." = field("No."),
                                                                   "Sales Code" = const('2019')));
            Caption = 'Tarifa 2019';
            FieldClass = FlowField;
        }
        field(50310; "PVP Recomendado 2019"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Precio recomendado" where("Item No." = field("No."),
                                                                           "Sales Code" = const('2019')));
            Caption = 'PVP Recomendado 2019';
            FieldClass = FlowField;
        }
        field(50311; "CUANTOS UDS EANS"; Integer)
        {
            CalcFormula = count("Item Cross Reference" where("Item No." = field("No."),
                                                              "Unit of Measure" = const('UDS')));
            FieldClass = FlowField;
        }
        field(50312; "Tarifa 2021"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Unit Price" where("Item No." = field("No."),
                                                                   "Sales Code" = const('2021')));
            Caption = 'Tarifa 2021';
            FieldClass = FlowField;
        }
        field(50313; "PVP Recomendado 2021"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Precio recomendado" where("Item No." = field("No."),
                                                                           "Sales Code" = const('2021')));
            Caption = 'PVP Recomendado 2021';
            FieldClass = FlowField;
        }
        field(50314; "Voluminoso web"; Boolean)
        {

            trigger OnValidate()
            begin

                /*
                IF "Voluminoso web" THEN BEGIN
                     RecCE.GET;
                     RecUMPWeb.RESET;
                     RecUMPWeb.SETRANGE(RecUMPWeb."Item No.","No.");
                     IF RecUMPWeb.FINDSET THEN REPEAT
                          RecUMPWeb."Kgs/Volumen WEB":=RecUMPWeb.Cubage*RecCE."Volumen WEB";
                          RecUMPWeb.MODIFY;
                     UNTIL RecUMPWeb.NEXT=0;
                END;
                IF "Voluminoso web"=FALSE THEN BEGIN
                     RecUMPWeb.RESET;
                     RecUMPWeb.SETRANGE(RecUMPWeb."Item No.","No.");
                     IF RecUMPWeb.FINDSET THEN REPEAT
                          RecUMPWeb."Kgs/Volumen WEB":=0;
                          RecUMPWeb.MODIFY;
                     UNTIL RecUMPWeb.NEXT=0;
                END;
                */

            end;
        }
        field(50315; "IVA IGIC"; Code[10])
        {
            Caption = 'IVA IGIC';
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                ///VALIDATE("Price/Profit Calculation");
            end;
        }
        field(50316; "Excluir de dropbox"; Boolean)
        {
        }
        field(50317; "FIJO Excluir de dropbox"; Boolean)
        {
        }
        field(50318; "Tarifa 2021-2"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Unit Price" where("Item No." = field("No."),
                                                                   "Sales Code" = const('2021-2')));
            Caption = 'Tarifa 2021-2';
            FieldClass = FlowField;
        }
        field(50319; "PVP Recomendado 2021-2"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Precio recomendado" where("Item No." = field("No."),
                                                                           "Sales Code" = const('2021-2')));
            Caption = 'PVP Recomendado 2021-2';
            FieldClass = FlowField;
        }
        field(50320; "Tarifa 2021 amazon21"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Unit Price" where("Item No." = field("No."),
                                                                   "Sales Code" = const('AMZ2021')));
            Caption = 'Tarifa 2021 amazon21';
            FieldClass = FlowField;
        }
        field(50321; "PVP Recomendado 2021 amazon21"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Precio recomendado" where("Item No." = field("No."),
                                                                           "Sales Code" = const('AMZ2021')));
            Caption = 'PVP Recomendado 2021 amazon21';
            FieldClass = FlowField;
        }
        field(50322; "Tarifa 2021 AMZ2021-3"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Unit Price" where("Item No." = field("No."),
                                                                   "Sales Code" = const('AMZ2021-3')));
            Caption = 'Tarifa 2021 AMZ2021-3';
            FieldClass = FlowField;
        }
        field(50323; "PVP Recomendado 2021 AMZ2021-3"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Precio recomendado" where("Item No." = field("No."),
                                                                           "Sales Code" = const('AMZ2021-3')));
            Caption = 'PVP Recomendado 2021 AMZ2021-3';
            FieldClass = FlowField;
        }
        field(50324; "Tarifa 2022"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Unit Price" where("Item No." = field("No."),
                                                                   "Sales Code" = const('2022')));
            Caption = 'Tarifa 2022';
            FieldClass = FlowField;
        }
        field(50325; "PVP Recomendado 2022"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Precio recomendado" where("Item No." = field("No."),
                                                                           "Sales Code" = const('2022')));
            Caption = 'PVP Recomendado 2022';
            FieldClass = FlowField;
        }
        field(50326; "Tarifa 2022-2"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Unit Price" where("Item No." = field("No."),
                                                                   "Sales Code" = const('2022-2')));
            Caption = 'Tarifa 2022-2';
            FieldClass = FlowField;
        }
        field(50327; "PVP Recomendado 2022-2"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Precio recomendado" where("Item No." = field("No."),
                                                                           "Sales Code" = const('2022-2')));
            Caption = 'PVP Recomendado 2022-2';
            FieldClass = FlowField;
        }
        field(50328; "Tarifa AMZ2023"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Unit Price" where("Item No." = field("No."),
                                                                   "Sales Code" = const('AMZ2023')));
            Caption = 'Tarifa AMZ2023';
            FieldClass = FlowField;
        }
        field(50329; "PVP Recomendado AMZ2023"; Decimal)
        {
            CalcFormula = lookup("Sales Price"."Precio recomendado" where("Item No." = field("No."),
                                                                           "Sales Code" = const('AMZ2023')));
            Caption = 'PVP Recomendado AMZ2023';
            FieldClass = FlowField;
        }
        field(50330; "Precio inv 2009"; Decimal)
        {
        }
        field(50331; "URL IMAGEN 1"; Text[250])
        {
        }
        field(50332; Agosto; Decimal)
        {
        }
        field(50333; Septiembre; Decimal)
        {
        }
        field(50334; Octubre; Decimal)
        {
        }
        field(50335; Noviembre; Decimal)
        {
        }
        field(50336; Diciembre; Decimal)
        {
        }
        field(50337; "Umbral stock"; Decimal)
        {
        }
        field(50338; "Variante1"; Decimal)
        {
        }
        field(50339; "Variante2"; Decimal)
        {
        }
        field(50340; "Dato Variante1"; Code[20])
        {
            TableRelation = "Multitabla 2"."Codigo 2" where(Tabla = const(Variante), "Codigo 1" = field(CodVariante1));
        }
        field(50341; "Dato Variante2"; Code[20])
        {
            TableRelation = "Multitabla 2"."Codigo 2" where(Tabla = const(Variante), "Codigo 1" = field(CodVariante2));
        }
        field(50342; "CodVariante1"; Code[20])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(Variante));
        }
        field(50343; "CodVariante2"; Code[20])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(Variante));
        }

        field(60000; "Actualizar WEB"; Boolean)
        {
        }
        field(60001; "Imagen Articulo WEB 2"; Text[200])
        {
        }
        field(60002; "Imagen Articulo WEB 3"; Text[200])
        {
        }
        field(60003; "Imagen Articulo WEB 4"; Text[200])
        {
        }
        field(60004; "Actualizar WEB Imagenes"; Boolean)
        {
        }
        field(60005; "Actualizar WEB Descripcion"; Boolean)
        {
        }
        field(60008; "nulo Producto Opcion"; Code[1])
        {
            Description = 'WEB';
        }
        field(60009; "Producto en promocion WEB"; Boolean)
        {

            trigger OnValidate()
            begin
                /*
                     "Actualizar WEB":=TRUE;
                     */

            end;
        }
        field(60010; "Fecha inicio promocion WEB"; Date)
        {

            trigger OnValidate()
            begin
                /*
                
                IF ("Fecha inicio promocion WEB">=TODAY) AND
                   (TODAY<="Fecha fin promocion WEB") THEN BEGIN
                     "Producto en promocion WEB":=TRUE;
                
                END;
                
                "Actualizar WEB":=TRUE;
                */

            end;
        }
        field(60011; "Fecha fin promocion WEB"; Date)
        {

            trigger OnValidate()
            begin
                /*
                IF ("Fecha inicio promocion WEB">=TODAY) AND
                   (TODAY<="Fecha fin promocion WEB") THEN BEGIN
                     "Producto en promocion WEB":=TRUE;
                
                END;
                "Actualizar WEB":=TRUE;
                */

            end;
        }
        field(60012; "No enviar precio especial"; Boolean)
        {
        }
        field(60050; "Inventory 2"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry-COPIA".Quantity where("Item No." = field("No."),
                                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                        "Location Code" = field("Location Filter"),
                                                                        "Drop Shipment" = field("Drop Shipment Filter"),
                                                                        "Variant Code" = field("Variant Filter"),
                                                                        "Lot No." = field("Lot No. Filter"),
                                                                        "Serial No." = field("Serial No. Filter")));
            Caption = 'Inventory 2';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(60051; "Net Change 2"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry-COPIA".Quantity where("Item No." = field("No."),
                                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                        "Location Code" = field("Location Filter"),
                                                                        "Drop Shipment" = field("Drop Shipment Filter"),
                                                                        "Posting Date" = field("Date Filter"),
                                                                        "Variant Code" = field("Variant Filter"),
                                                                        "Lot No." = field("Lot No. Filter"),
                                                                        "Serial No." = field("Serial No. Filter")));
            Caption = 'Net Change 2';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(60052; "coste ult"; Decimal)
        {
        }
        field(50555; "Level1"; Text[100]) { }
        field(50556; "Level2"; Text[100]) { }
        field(50557; "Level3"; Text[100]) { }
        field(50558; "Level4"; Text[100]) { }
        field(50559; "Level5"; Text[100]) { }
        field(50560; "Level6"; Text[100]) { }
        field(50561; "Level7"; Text[100]) { }
        field(50562; "Level8"; Text[100]) { }
        field(50563; "Level9"; Text[100]) { }
        field(50564; "Level10"; Text[100]) { }

    }

    var
        RecUMP: Record "Item Unit of Measure";
        RecRefCruz: Record "Item Reference";

        itemcategory: Record "Item Category";

}
