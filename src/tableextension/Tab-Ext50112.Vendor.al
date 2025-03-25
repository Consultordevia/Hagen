tableextension 50112 Vendor extends "Vendor"
{
    fields
    {
        field(50003; "Tipo operación"; Option)
        {
            OptionMembers = Ordinarias,"Bienes usados","Agencias Viajes","Inversión","Intracomunitarias Bienes Corrientes","Intracomunitarias bienes Inversión","Importación Bienes Corrientes","Importación Bienes Inversión","Interiores Bienes Corrientes","Interiores Bienes Inversión";
        }
        field(50004; "Creado por"; Code[20])
        {
            TableRelation = User;
        }
        field(50005; "Fecha creación"; Date)
        {
        }
        field(50006; "Importe albaranado"; Decimal)
        {
            CalcFormula = sum("Purch. Rcpt. Line"."Unit Cost (LCY)" where("Buy-from Vendor No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50007; "Importe facturado"; Decimal)
        {
            CalcFormula = sum("Purch. Inv. Line"."Unit Cost (LCY)" where("Buy-from Vendor No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50008; "Importe abonado"; Decimal)
        {
            CalcFormula = sum("Purch. Cr. Memo Line"."Unit Cost (LCY)" where("Buy-from Vendor No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50009; "Proveedor de almacen"; Boolean)
        {
        }
        field(50010; "Banco previsión"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(50011; "Importe minimo pedido compra"; Decimal)
        {
        }
        field(50012; "Tiene refencias asignadas"; Boolean)
        {
            CalcFormula = exist(Item where("Vendor No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50015; "Tipo proveedor"; Option)
        {
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
        field(50170; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(50171; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(50172; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(50173; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(50174; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(59001; "Cuenta de gasto"; Code[20])
        {
            TableRelation = "G/L Account"."No." where("Account Type" = const(Posting));
        }
        field(50707; "Invoice Type"; Enum "SII Sales Invoice Type")
        {
            Caption = 'Invoice Type';
        }
        field(50708; "Cr. Memo Type"; Enum "SII Sales Credit Memo Type")
        {
            Caption = 'Cr. Memo Type';
        }
         field(50709; "Special Scheme Code"; Enum "SII Sales Special Scheme Code")
        {
            Caption = 'Special Scheme Code';
        }
        field(50711; "Correction Type"; Option)
        {
            Caption = 'Correction Type';
            OptionCaption = ' ,Replacement,Difference,Removal';
            OptionMembers = " ",Replacement,Difference,Removal;
            
        }
        field(50724; "Do Not Send To SII"; Boolean)
        {
            Caption = 'Do Not Send To SII';
        }
        

    }
    fieldgroups
    {
        addlast(DropDown; "Search Name")
        { }
        addlast(Brick; "Search Name")
        { }
    }
}
