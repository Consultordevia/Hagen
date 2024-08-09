tableextension 50023 PurchInvHeader extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "Importe factura"; Decimal)
        {
            CalcFormula = sum("Purch. Inv. Line"."Unit Cost (LCY)" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50001; "Importe Pdte. pedido"; Decimal)
        {
        }
        field(50002; BL; Code[20])
        {
        }
        field(50003; "Nº contenedor"; Code[20])
        {
        }
        field(50004; Kilos; Decimal)
        {
        }
        field(50006; "E.T.Departure"; Date)
        {
        }
        field(50007; "E.T.Arrival"; Date)
        {
        }
        field(50008; "Recepción Documentos"; Boolean)
        {
        }
        field(50009; "Fecha recepción docs."; Date)
        {
            Editable = false;
        }
        field(50010; "Envio docs. aduana"; Boolean)
        {
        }
        field(50011; "Fecha envio docs. aduana"; Date)
        {
            Editable = false;
        }
        field(50012; "Fletes estimado"; Decimal)
        {
        }
        field(50013; "Fecha de despacho"; Date)
        {
        }
        field(50014; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(50015; "Código importación"; Code[10])
        {
        }
        field(50016; DUA; Text[30])
        {
        }
        field(50017; "Fecha DUA"; Date)
        {
        }
        field(50018; "Nº meses a periodificar"; Integer)
        {
        }
        field(50035; "Permite multiplos distintos"; Boolean)
        {
        }
        field(50053; "Puerto salida"; Text[30])
        {
        }
        field(50054; "nulo Dua."; Text[30])
        {
        }
        field(50055; "nullo Base IVA aduanas"; Decimal)
        {
        }
        field(50056; "nulo % iva importacion"; Decimal)
        {
        }
        field(50058; "nulo Fecha dua-"; Date)
        {
        }
        field(50116; "Incremento flete"; Decimal)
        {
        }
        field(50117; "Incremento aduana"; Decimal)
        {
        }
        field(50215; "Tipo proveedor"; Option)
        {
            CalcFormula = lookup(Vendor."Tipo proveedor" where("No." = field("Buy-from Vendor No.")));
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
    }
}
