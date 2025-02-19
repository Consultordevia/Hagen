#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50082 "Parrilas Analisis"
{
    // 
    // 0,4412
    // 
    // 
    // X:=0;
    // Date.RESET;
    // Date.SETRANGE(Date."Period Start",DESDEINI,HASTAINI);
    // Date.SETRANGE(Date."Period Type",Date."Period Type"::Month);
    // IF Date.FINDFIRST THEN REPEAT
    //     X:=X+1;
    //     DESDEFECHA[X]:=Date."Period Start";
    //     HASTAFECHA[X]:=Date."Period End";
    // UNTIL Date.NEXT=0;
    // 
    // WHERE(Inventory Posting Group=CONST(GASTOSPARRILLA))

    PageType = List;
    SourceTable = Item;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Block Reason";Rec."Block Reason")
                {
                    ApplicationArea = Basic;
                    Caption = 'Descripción';
                }
                field("%";Rec."Single-Level Material Cost")
                {
                    ApplicationArea = All;
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = '%';
                    Editable = false;
                }
                field(Total;Rec."Single-Level Capacity Cost")
                {
                    ApplicationArea = All;
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = 'Total';
                    Editable = false;
                }
                field(Enero;Rec."Single-Level Subcontrd. Cost")
                {
                    ApplicationArea = All;
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = 'Enero';
                    Editable = false;
                }
                field(Febrero;Rec."Single-Level Cap. Ovhd Cost")
                {
                    ApplicationArea = All;
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = 'Febrero';
                    Editable = false;
                }
                field(Marzo;Rec."Single-Level Mfg. Ovhd Cost")
                {
                    ApplicationArea = All;
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = 'Marzo';
                    Editable = false;
                }
                field(Abril;Rec."Overhead Rate")
                {
                    ApplicationArea = All;
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = 'Abril';
                    Editable = false;
                }
                field(Mayo;Rec."Rolled-up Subcontracted Cost")
                {
                    ApplicationArea = All;
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = 'Mayo';
                    Editable = false;
                }
                field(Junio;Rec."Rolled-up Mfg. Ovhd Cost")
                {
                    ApplicationArea = All;
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = 'Junio';
                    Editable = false;
                }
                field(Julio;Rec."Rolled-up Cap. Overhead Cost")
                {
                    ApplicationArea = All;
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = 'Julio';
                    Editable = false;
                }
                field(Agosto;Rec.Agosto)
                {
                    ApplicationArea = All;
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = 'Agosto';
                    Editable = false;
                }
                field(Septiembre;Rec.Septiembre)
                {
                    ApplicationArea = All;
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = 'Septiembre';
                    Editable = false;
                }
                field(Octubre;Rec.Octubre)
                {
                    ApplicationArea = All;
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = 'Octubre';
                    Editable = false;
                }
                field(Noviembre;Rec.Noviembre)
                {
                    ApplicationArea = All;
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = 'Noviembre';
                    Editable = false;
                }
                field(Diciembre;Rec.Diciembre)
                {
                    ApplicationArea = All;
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = 'Diciembre';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Filtros)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    UserSetup.Reset;
                    UserSetup.SetRange(UserSetup."User ID",UserId);
                    if UserSetup.FindFirst then begin
                         Clear(ParrilasGastosAMAZON);
                         ParrilasGastosAMAZON.SetTableview(UserSetup);
                         ParrilasGastosAMAZON.RunModal;
                    end;



                    UserSetup.Get(UserId);

                    AÑO:=UserSetup.Año;
                    CodAnalisis:=UserSetup."Cod. Analisis";
                    DESDEINI:=Dmy2date(1,1,AÑO);
                    HASTAINI:=Dmy2date(31,12,AÑO);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*
        X:=0;
        Date.RESET;
        Date.SETRANGE(Date."Period Start",DESDEINI,HASTAINI);
        Date.SETRANGE(Date."Period Type",Date."Period Type"::Month);
        IF Date.FINDFIRST THEN REPEAT
            X:=X+1;
            DESDEFECHA[X]:=Date."Period Start";
            HASTAFECHA[X]:=Date."Period End";
        UNTIL Date.NEXT=0;
        
        CLEAR(MATRIX_CellData);
        X:=0;
        REPEAT
            X:=X+1;
            PurchInvLine.RESET;
            PurchInvLine.SETRANGE("No.","No. 2");
            PurchInvLine.SETRANGE("Posting Date",DESDEFECHA[X],HASTAFECHA[X]);
            PurchInvLine.SETRANGE("Codigo Analisis",CodAnalisis);
            IF PurchInvLine.FINDFIRST THEN REPEAT
                MATRIX_CellData[X]:=MATRIX_CellData[X]+PurchInvLine."Amount Including VAT";
                MATRIX_CellData[13]:=MATRIX_CellData[13]+PurchInvLine."Amount Including VAT";
            UNTIL PurchInvLine.NEXT=0;
        UNTIL X=12;
        */
        
        
        if CopyStr(Rec."No.",1,1)='B' then begin
             Rec."Single-Level Material Cost":=ROUND((Rec."Single-Level Capacity Cost"/TOTALSALES)*100,0.01);
        end;

    end;

    trigger OnOpenPage()
    begin


        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID",UserId);
        if UserSetup.FindFirst then begin
             Clear(ParrilasGastosAMAZON);
             ParrilasGastosAMAZON.SetTableview(UserSetup);
             ParrilasGastosAMAZON.RunModal;
        end;






        V.Open('#1#################################');

        Recalcula;

        V.Close;
    end;

    var
        MATRIX_CellDataPortes: array [14] of Decimal;
        MATRIX_CellData: array [14] of Decimal;
        MATRIX_CellDataImporte: array [14] of Decimal;
        MATRIX_CellDataDescuento: array [14] of Decimal;
        MATRIX_CellDataCoste: array [14] of Decimal;
        MATRIX_CellDataCosteTranspor: array [14] of Decimal;
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        DESDEFECHA: array [12] of Date;
        HASTAFECHA: array [12] of Date;
        X: Integer;
        Date: Record Date;
        "AÑO": Integer;
        CodAnalisis: Code[20];
        DESDEINI: Date;
        HASTAINI: Date;
        YYYY: Integer;
        UserSetup: Record "User Setup";
        ParrilasGastosAMAZON: Page "Filtro Analisis";
        Item: Record Item;
        CONTA: Code[3];
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Customer: Record Customer;
        V: Dialog;
        TOTALSALES: Decimal;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        Rec115: Record "Sales Cr.Memo Line";
        HASTAFEC: Date;
        DATOSCOSTE: Decimal;
        SalesShipmentHeader: Record "Sales Shipment Header";
        MATRIX2: array [13] of Decimal;
        MATRIX3: array [13] of Decimal;
        InventarioPMP: Record "Inventario PMP";

    local procedure Recalcula()
    begin
        
        
        
        
        UserSetup.Get(UserId);
        
        
        if UserSetup.Año<>0 then begin
            AÑO:=UserSetup.Año;
            CodAnalisis:=UserSetup."Analisis margenes";
            DESDEINI:=Dmy2date(1,1,AÑO);
            HASTAINI:=UserSetup."hasta fecha";
        end;
        X:=0;
        Date.Reset;
        Date.SetRange(Date."Period Start",DESDEINI,HASTAINI);
        Date.SetRange(Date."Period Type",Date."period type"::Month);
        if Date.FindSet() then repeat
            X:=X+1;
            DESDEFECHA[X]:=Date."Period Start";
            HASTAFECHA[X]:=Date."Period End";
        until (Date.Next=0);
        
        
        
        ///// ERROR('%1 %2',DESDEFECHA[8],HASTAFECHA[8]);
        
        
        Rec.Init;Rec."No.":='A';Rec."Block Reason":=Format(HASTAFECHA[X]);Rec.Insert;
        Rec.Init;Rec."No.":='A0';Rec."Block Reason":=CodAnalisis;Rec.Insert;
        Rec.Init;Rec."No.":='A00';Rec."Block Reason":='--------------';Rec.Insert;
        
        Rec.Init;Rec."No.":='A001';Rec."Block Reason":='Portes';
        
        Clear(MATRIX_CellData);
        Clear(MATRIX_CellDataDescuento);
        Clear(MATRIX_CellDataImporte);
        Clear(MATRIX_CellDataCoste);
        
        Customer.Reset;
        Customer.SetCurrentKey("Grupo clientes");
        Customer.SetRange("Grupo clientes",CodAnalisis);
        if Customer.FindSet() then repeat
             VerVentasPortes;
             VerCostePortes;
        until Customer.Next=0;
        
        
        Rec."Single-Level Material Cost":=0;
        Rec."Single-Level Capacity Cost":=MATRIX_CellDataPortes[13];
        Rec."Single-Level Subcontrd. Cost":=MATRIX_CellDataPortes[1];
        Rec."Single-Level Cap. Ovhd Cost":=MATRIX_CellDataPortes[2];
        Rec."Single-Level Mfg. Ovhd Cost":=MATRIX_CellDataPortes[3];
        Rec."Overhead Rate":=MATRIX_CellDataPortes[4];
        Rec."Rolled-up Subcontracted Cost":=MATRIX_CellDataPortes[5];
        Rec."Rolled-up Mfg. Ovhd Cost":=MATRIX_CellDataPortes[6];
        Rec."Rolled-up Cap. Overhead Cost":=MATRIX_CellDataPortes[7];
        Rec.Agosto:=MATRIX_CellDataPortes[8];
        Rec.Septiembre:=MATRIX_CellDataPortes[9];
        Rec.Octubre:=MATRIX_CellDataPortes[10];
        Rec.Noviembre:=MATRIX_CellDataPortes[11];
        Rec.Diciembre:=MATRIX_CellDataPortes[12];
        Rec.Insert;
        
        Rec.Init;Rec."No.":='A01';Rec."Block Reason":='Ventas Brutas / Sales';
        
        Clear(MATRIX_CellData);
        Clear(MATRIX_CellDataDescuento);
        Clear(MATRIX_CellDataImporte);
        Clear(MATRIX_CellDataCoste);
        
        Customer.Reset;
        Customer.SetCurrentKey("Grupo clientes");
        Customer.SetRange("Grupo clientes",CodAnalisis);
        if Customer.FindSet then repeat
             VerVentas;
        until Customer.Next=0;
        
        
        Rec."Single-Level Material Cost":=0;
        Rec."Single-Level Capacity Cost":=MATRIX_CellData[13]-MATRIX_CellDataPortes[13];;
        Rec."Single-Level Subcontrd. Cost":=MATRIX_CellData[1]-MATRIX_CellDataPortes[1];;
        Rec."Single-Level Cap. Ovhd Cost":=MATRIX_CellData[2]-MATRIX_CellDataPortes[2];;
        Rec."Single-Level Mfg. Ovhd Cost":=MATRIX_CellData[3]-MATRIX_CellDataPortes[3];;
        Rec."Overhead Rate":=MATRIX_CellData[4]-MATRIX_CellDataPortes[4];;
        Rec."Rolled-up Subcontracted Cost":=MATRIX_CellData[5]-MATRIX_CellDataPortes[5];;
        Rec."Rolled-up Mfg. Ovhd Cost":=MATRIX_CellData[6]-MATRIX_CellDataPortes[6];;
        Rec."Rolled-up Cap. Overhead Cost":=MATRIX_CellData[7]-MATRIX_CellDataPortes[7];;
        Rec.Agosto:=MATRIX_CellData[8]-MATRIX_CellDataPortes[8];;
        Rec.Septiembre:=MATRIX_CellData[9]-MATRIX_CellDataPortes[9];;
        Rec.Octubre:=MATRIX_CellData[10]-MATRIX_CellDataPortes[10];;
        Rec.Noviembre:=MATRIX_CellData[11]-MATRIX_CellDataPortes[11];;
        Rec.Diciembre:=MATRIX_CellData[12]-MATRIX_CellDataPortes[12];;
        Rec.Insert;
        
        Rec.Init;Rec."No.":='A02';Rec."Block Reason":='Descuentos en factura / invoice discounts';
        Rec."Single-Level Material Cost":=0;
        Rec."Single-Level Capacity Cost":=MATRIX_CellData[13]-MATRIX_CellDataImporte[13];
        Rec."Single-Level Subcontrd. Cost":=MATRIX_CellData[1]-MATRIX_CellDataImporte[1];
        Rec."Single-Level Cap. Ovhd Cost":=MATRIX_CellData[2]-MATRIX_CellDataImporte[2];
        Rec."Single-Level Mfg. Ovhd Cost":=MATRIX_CellData[3]-MATRIX_CellDataImporte[3];
        Rec."Overhead Rate":=MATRIX_CellData[4]-MATRIX_CellDataImporte[4];
        Rec."Rolled-up Subcontracted Cost":=MATRIX_CellData[5]-MATRIX_CellDataImporte[5];
        Rec."Rolled-up Mfg. Ovhd Cost":=MATRIX_CellData[6]-MATRIX_CellDataImporte[6];
        Rec."Rolled-up Cap. Overhead Cost":=MATRIX_CellData[7]-MATRIX_CellDataImporte[7];
        Rec.Agosto:=MATRIX_CellData[8]-MATRIX_CellDataImporte[8];
        Rec.Septiembre:=MATRIX_CellData[9]-MATRIX_CellDataImporte[9];
        Rec.Octubre:=MATRIX_CellData[10]-MATRIX_CellDataImporte[10];
        Rec.Noviembre:=MATRIX_CellData[11]-MATRIX_CellDataImporte[11];
        Rec.Diciembre:=MATRIX_CellData[12]-MATRIX_CellDataImporte[12];
        Rec.Insert;
        
        Rec.Init;Rec."No.":='A03';Rec."Block Reason":='Venta neta / net sales';
        Rec."Single-Level Material Cost":=0;
        Rec."Single-Level Capacity Cost":=MATRIX_CellDataImporte[13];
        TOTALSALES:=MATRIX_CellDataImporte[13];
        Rec."Single-Level Subcontrd. Cost":=MATRIX_CellDataImporte[1];
        Rec."Single-Level Cap. Ovhd Cost":=MATRIX_CellDataImporte[2];
        Rec."Single-Level Mfg. Ovhd Cost":=MATRIX_CellDataImporte[3];
        Rec."Overhead Rate":=MATRIX_CellDataImporte[4];
        Rec."Rolled-up Subcontracted Cost":=MATRIX_CellDataImporte[5];
        Rec."Rolled-up Mfg. Ovhd Cost":=MATRIX_CellDataImporte[6];
        Rec."Rolled-up Cap. Overhead Cost":=MATRIX_CellDataImporte[7];
        Rec.Agosto:=MATRIX_CellDataImporte[8];
        Rec.Septiembre:=MATRIX_CellDataImporte[9];
        Rec.Octubre:=MATRIX_CellDataImporte[10];
        Rec.Noviembre:=MATRIX_CellDataImporte[11];
        Rec.Diciembre:=MATRIX_CellDataImporte[12];
        
        Rec.Insert;
        
        
        
        
        Rec.Init;Rec."No.":='A04';Rec."Block Reason":='--------------';Rec.Insert;
        
        Rec.Init;Rec."No.":='A05';Rec."Block Reason":='COGS';
        Rec."Single-Level Material Cost":=0;
        Rec."Single-Level Capacity Cost":=ROUND(MATRIX_CellDataCoste[13],0.01);
        Rec."Single-Level Subcontrd. Cost":=ROUND(MATRIX_CellDataCoste[1],0.01);
        Rec."Single-Level Cap. Ovhd Cost":=ROUND(MATRIX_CellDataCoste[2],0.01);
        Rec."Single-Level Mfg. Ovhd Cost":=ROUND(MATRIX_CellDataCoste[3],0.01);
        Rec."Overhead Rate":=ROUND(MATRIX_CellDataCoste[4],0.01);
        Rec."Rolled-up Subcontracted Cost":=ROUND(MATRIX_CellDataCoste[5],0.01);
        Rec."Rolled-up Mfg. Ovhd Cost":=ROUND(MATRIX_CellDataCoste[6],0.01);
        Rec."Rolled-up Cap. Overhead Cost":=ROUND(MATRIX_CellDataCoste[7],0.01);
        Rec.Agosto:=ROUND(MATRIX_CellDataCoste[8],0.01);
        Rec.Septiembre:=ROUND(MATRIX_CellDataCoste[9],0.01);
        Rec.Octubre:=ROUND(MATRIX_CellDataCoste[10],0.01);
        Rec.Noviembre:=ROUND(MATRIX_CellDataCoste[11],0.01);
        Rec.Diciembre:=ROUND(MATRIX_CellDataCoste[12],0.01);
        Rec.Insert;
        
        
        
        
        
        
        Rec.Init;Rec."No.":='A06';Rec."Block Reason":='Gross Profit';
        
        Rec."Single-Level Material Cost":=0;
        Rec."Single-Level Capacity Cost":=MATRIX_CellDataImporte[13]-ROUND(MATRIX_CellDataCoste[13],0.01);
        Rec."Single-Level Subcontrd. Cost":=MATRIX_CellDataImporte[1]-ROUND(MATRIX_CellDataCoste[1],0.01);
        Rec."Single-Level Cap. Ovhd Cost":=MATRIX_CellDataImporte[2]-ROUND(MATRIX_CellDataCoste[2],0.01);
        Rec."Single-Level Mfg. Ovhd Cost":=MATRIX_CellDataImporte[3]-ROUND(MATRIX_CellDataCoste[3],0.01);
        Rec."Overhead Rate":=MATRIX_CellDataImporte[4]-ROUND(MATRIX_CellDataCoste[4],0.01);
        Rec."Rolled-up Subcontracted Cost":=MATRIX_CellDataImporte[5]-ROUND(MATRIX_CellDataCoste[5],0.01);
        Rec."Rolled-up Mfg. Ovhd Cost":=MATRIX_CellDataImporte[6]-ROUND(MATRIX_CellDataCoste[6],0.01);
        Rec."Rolled-up Cap. Overhead Cost":=MATRIX_CellDataImporte[7]-ROUND(MATRIX_CellDataCoste[7],0.01);
        Rec.Agosto:=MATRIX_CellDataImporte[8]-ROUND(MATRIX_CellDataCoste[8],0.01);
        Rec.Septiembre:=MATRIX_CellDataImporte[9]-ROUND(MATRIX_CellDataCoste[9],0.01);
        Rec.Octubre:=MATRIX_CellDataImporte[10]-ROUND(MATRIX_CellDataCoste[10],0.01);
        Rec.Noviembre:=MATRIX_CellDataImporte[11]-ROUND(MATRIX_CellDataCoste[11],0.01);
        Rec.Diciembre:=MATRIX_CellDataImporte[12]-ROUND(MATRIX_CellDataCoste[12],0.01);
        
            MATRIX3[1]:=MATRIX3[1]+MATRIX_CellDataImporte[1]-ROUND(MATRIX_CellDataCoste[1]);
            MATRIX3[2]:=MATRIX3[2]+MATRIX_CellDataImporte[2]-ROUND(MATRIX_CellDataCoste[2]);
            MATRIX3[3]:=MATRIX3[3]+MATRIX_CellDataImporte[3]-ROUND(MATRIX_CellDataCoste[3]);
            MATRIX3[4]:=MATRIX3[4]+MATRIX_CellDataImporte[4]-ROUND(MATRIX_CellDataCoste[4]);
            MATRIX3[5]:=MATRIX3[5]+MATRIX_CellDataImporte[5]-ROUND(MATRIX_CellDataCoste[5]);
            MATRIX3[6]:=MATRIX3[6]+MATRIX_CellDataImporte[6]-ROUND(MATRIX_CellDataCoste[6]);
            MATRIX3[7]:=MATRIX3[7]+MATRIX_CellDataImporte[7]-ROUND(MATRIX_CellDataCoste[7]);
            MATRIX3[8]:=MATRIX3[8]+MATRIX_CellDataImporte[8]-ROUND(MATRIX_CellDataCoste[8]);
            MATRIX3[9]:=MATRIX3[9]+MATRIX_CellDataImporte[9]-ROUND(MATRIX_CellDataCoste[9]);
            MATRIX3[10]:=MATRIX3[10]+MATRIX_CellDataImporte[10]-ROUND(MATRIX_CellDataCoste[10]);
            MATRIX3[11]:=MATRIX3[11]+MATRIX_CellDataImporte[11]-ROUND(MATRIX_CellDataCoste[11]);
            MATRIX3[12]:=MATRIX3[12]+MATRIX_CellDataImporte[12]-ROUND(MATRIX_CellDataCoste[12]);
            MATRIX3[13]:=MATRIX3[13]+MATRIX_CellDataImporte[13]-ROUND(MATRIX_CellDataCoste[13]);
        
        Rec.Insert;
        
        
        Rec.Init;Rec."No.":='A07';Rec."Block Reason":='           %';
        Rec."Single-Level Material Cost":=0;
        if MATRIX_CellDataImporte[13]<>0 then begin Rec."Single-Level Capacity Cost":=ROUND(((MATRIX_CellDataImporte[13]-ROUND(MATRIX_CellDataCoste[13],0.01))/MATRIX_CellDataImporte[13])*100,0.01);end;
        if MATRIX_CellDataImporte[1]<>0 then begin Rec."Single-Level Subcontrd. Cost":=ROUND(((MATRIX_CellDataImporte[1]-ROUND(MATRIX_CellDataCoste[1],0.01))/MATRIX_CellDataImporte[1])*100,0.01);end;
        if MATRIX_CellDataImporte[2]<>0 then begin Rec."Single-Level Cap. Ovhd Cost":=ROUND(((MATRIX_CellDataImporte[2]-ROUND(MATRIX_CellDataCoste[2],0.01))/MATRIX_CellDataImporte[2])*100,0.01);end;
        if MATRIX_CellDataImporte[3]<>0 then begin Rec."Single-Level Mfg. Ovhd Cost":=ROUND(((MATRIX_CellDataImporte[3]-ROUND(MATRIX_CellDataCoste[3],0.01))/MATRIX_CellDataImporte[3])*100,0.01);end;
        if MATRIX_CellDataImporte[4]<>0 then begin Rec."Overhead Rate":=ROUND(((MATRIX_CellDataImporte[4]-ROUND(MATRIX_CellDataCoste[4],0.01))/MATRIX_CellDataImporte[4])*100,0.01);end;
        if MATRIX_CellDataImporte[5]<>0 then begin  Rec."Rolled-up Subcontracted Cost":=ROUND(((MATRIX_CellDataImporte[5]-ROUND(MATRIX_CellDataCoste[5],0.01))/MATRIX_CellDataImporte[5])*100,0.01);end;
        if MATRIX_CellDataImporte[6]<>0 then begin Rec."Rolled-up Mfg. Ovhd Cost":=ROUND(((MATRIX_CellDataImporte[6]-ROUND(MATRIX_CellDataCoste[6],0.01))/MATRIX_CellDataImporte[6])*100,0.01);end;
        if MATRIX_CellDataImporte[7]<>0 then begin Rec."Rolled-up Cap. Overhead Cost":=ROUND(((MATRIX_CellDataImporte[7]-ROUND(MATRIX_CellDataCoste[7],0.01))/MATRIX_CellDataImporte[7])*100,0.01);end;
        if MATRIX_CellDataImporte[8]<>0 then begin Rec.Agosto:=ROUND(((MATRIX_CellDataImporte[8]-ROUND(MATRIX_CellDataCoste[8],0.01))/MATRIX_CellDataImporte[8])*100,0.01);end;
        if MATRIX_CellDataImporte[9]<>0 then begin Rec.Septiembre:=ROUND(((MATRIX_CellDataImporte[9]-ROUND(MATRIX_CellDataCoste[9],0.01))/MATRIX_CellDataImporte[9])*100,0.01);end;
        if MATRIX_CellDataImporte[10]<>0 then begin Rec.Octubre:=ROUND(((MATRIX_CellDataImporte[10]-ROUND(MATRIX_CellDataCoste[10],0.01))/MATRIX_CellDataImporte[10])*100,0.01);end;
        if MATRIX_CellDataImporte[11]<>0 then begin Rec.Noviembre:=ROUND(((MATRIX_CellDataImporte[11]-ROUND(MATRIX_CellDataCoste[11],0.01))/MATRIX_CellDataImporte[11])*100,0.01);end;
        if MATRIX_CellDataImporte[12]<>0 then begin Rec.Diciembre:=ROUND(((MATRIX_CellDataImporte[12]-ROUND(MATRIX_CellDataCoste[12],0.01))/MATRIX_CellDataImporte[12])*100,0.01);end;
        
        
        Rec.Insert;
        
        
        Rec.Init;Rec."No.":='A08';Rec."Block Reason":='--------------';Rec.Insert;
        Rec.Init;Rec."No.":='A09';Rec."Block Reason":='';Rec.Insert;
        Rec.Init;Rec."No.":='A10';Rec."Block Reason":='--------------';Rec.Insert;
        
        
        
        
        CONTA:='000';
        Item.Reset;
        Item.SetCurrentKey("Inventory Posting Group");
        Item.SetRange("Inventory Posting Group",'GASTOSPARRILLA');
        if Item.FindSet then repeat
            CONTA:=IncStr(CONTA);
            Rec.Init;Rec."No.":='B'+Format(CONTA);Rec."Block Reason":=Item.Description+' ('+Format(Item."No.")+')';
            Clear(MATRIX_CellData);
            X:=0;
            repeat
                X:=X+1;
                PurchInvLine.Reset;
                PurchInvLine.SetCurrentKey("No.","Posting Date","Analisis margenes");
                PurchInvLine.SetRange("No.",Item."No.");
                PurchInvLine.SetRange("Posting Date",DESDEFECHA[X],HASTAFECHA[X]);
                PurchInvLine.SetRange("Analisis margenes",CodAnalisis);
                if PurchInvLine.FindSet then repeat
                    MATRIX_CellData[X]:=MATRIX_CellData[X]+PurchInvLine.Amount;
                    MATRIX_CellData[13]:=MATRIX_CellData[13]+PurchInvLine.Amount;
                until PurchInvLine.Next=0;
                PurchCrMemoLine.Reset;
                PurchCrMemoLine.SetCurrentKey("No.","Posting Date","Analisis margenes");
                PurchCrMemoLine.SetRange("No.",Item."No.");
                PurchCrMemoLine.SetRange("Posting Date",DESDEFECHA[X],HASTAFECHA[X]);
                PurchCrMemoLine.SetRange("Analisis margenes",CodAnalisis);
                if PurchCrMemoLine.FindSet then repeat
                    MATRIX_CellData[X]:=MATRIX_CellData[X]+PurchCrMemoLine.Amount*-1;
                    MATRIX_CellData[13]:=MATRIX_CellData[13]+PurchCrMemoLine.Amount*-1;
                until PurchCrMemoLine.Next=0;
            until X=12;
            Rec."Single-Level Material Cost":=0;
            Rec."Single-Level Capacity Cost":=MATRIX_CellData[13];
            Rec."Single-Level Subcontrd. Cost":=MATRIX_CellData[1];
            Rec."Single-Level Cap. Ovhd Cost":=MATRIX_CellData[2];
            Rec."Single-Level Mfg. Ovhd Cost":=MATRIX_CellData[3];
            Rec."Overhead Rate":=MATRIX_CellData[4];
            Rec."Rolled-up Subcontracted Cost":=MATRIX_CellData[5];
            Rec."Rolled-up Mfg. Ovhd Cost":=MATRIX_CellData[6];
            Rec."Rolled-up Cap. Overhead Cost":=MATRIX_CellData[7];
            Rec.Agosto:=MATRIX_CellData[8];
            Rec.Septiembre:=MATRIX_CellData[9];
            Rec.Octubre:=MATRIX_CellData[10];
            Rec.Noviembre:=MATRIX_CellData[11];
            Rec.Diciembre:=MATRIX_CellData[12];
            MATRIX2[1]:=MATRIX2[1]+MATRIX_CellData[1];
            MATRIX2[2]:=MATRIX2[2]+MATRIX_CellData[2];
            MATRIX2[3]:=MATRIX2[3]+MATRIX_CellData[3];
            MATRIX2[4]:=MATRIX2[4]+MATRIX_CellData[4];
            MATRIX2[5]:=MATRIX2[5]+MATRIX_CellData[5];
            MATRIX2[6]:=MATRIX2[6]+MATRIX_CellData[6];
            MATRIX2[7]:=MATRIX2[7]+MATRIX_CellData[7];
            MATRIX2[8]:=MATRIX2[8]+MATRIX_CellData[8];
            MATRIX2[9]:=MATRIX2[9]+MATRIX_CellData[9];
            MATRIX2[10]:=MATRIX2[10]+MATRIX_CellData[10];
            MATRIX2[11]:=MATRIX2[11]+MATRIX_CellData[11];
            MATRIX2[12]:=MATRIX2[12]+MATRIX_CellData[12];
            MATRIX2[13]:=MATRIX2[13]+MATRIX_CellData[13];
        
            MATRIX3[1]:=MATRIX3[1]-MATRIX_CellData[1];
            MATRIX3[2]:=MATRIX3[2]-MATRIX_CellData[2];
            MATRIX3[3]:=MATRIX3[3]-MATRIX_CellData[3];
            MATRIX3[4]:=MATRIX3[4]-MATRIX_CellData[4];
            MATRIX3[5]:=MATRIX3[5]-MATRIX_CellData[5];
            MATRIX3[6]:=MATRIX3[6]-MATRIX_CellData[6];
            MATRIX3[7]:=MATRIX3[7]-MATRIX_CellData[7];
            MATRIX3[8]:=MATRIX3[8]-MATRIX_CellData[8];
            MATRIX3[9]:=MATRIX3[9]-MATRIX_CellData[9];
            MATRIX3[10]:=MATRIX3[10]-MATRIX_CellData[10];
            MATRIX3[11]:=MATRIX3[11]-MATRIX_CellData[11];
            MATRIX3[12]:=MATRIX3[12]-MATRIX_CellData[12];
            MATRIX3[13]:=MATRIX3[13]-MATRIX_CellData[13];
        
            Rec.Insert;
        
        
        
        
        until Item.Next=0;
        
        
        
        
        
        
        
        Rec.Init;Rec."No.":='B999';Rec."Block Reason":='--------------';
        /*
        Item.RESET;
        Item.SETRANGE("Inventory Posting Group",'GASTOSPARRILLA');
        IF Item.FINDFIRST THEN REPEAT
            X:=0;
            REPEAT
                X:=X+1;
                PurchInvLine.RESET;
                PurchInvLine.SETRANGE("No.",Item."No.");
                PurchInvLine.SETRANGE("Posting Date",DESDEFECHA[X],HASTAFECHA[X]);
                PurchInvLine.SETRANGE("Analisis margenes",CodAnalisis);
                IF PurchInvLine.FINDFIRST THEN REPEAT
                    MATRIX_CellData[X]:=MATRIX_CellData[X]+PurchInvLine.Amount;
                    MATRIX_CellData[13]:=MATRIX_CellData[13]+PurchInvLine.Amount;
                UNTIL PurchInvLine.NEXT=0;
                PurchCrMemoLine.RESET;
                PurchCrMemoLine.SETRANGE("No.",Item."No.");
                PurchCrMemoLine.SETRANGE("Posting Date",DESDEFECHA[X],HASTAFECHA[X]);
                PurchCrMemoLine.SETRANGE("Analisis margenes",CodAnalisis);
                IF PurchCrMemoLine.FINDFIRST THEN REPEAT
                    MATRIX_CellData[X]:=MATRIX_CellData[X]+PurchCrMemoLine.Amount*-1;
                    MATRIX_CellData[13]:=MATRIX_CellData[13]+PurchCrMemoLine.Amount*-1;
                UNTIL PurchCrMemoLine.NEXT=0;
            UNTIL X=12;
        
        UNTIL Item.NEXT=0;
        */
            Rec."Single-Level Material Cost":=0;
            Rec."Single-Level Capacity Cost":=MATRIX2[13];
            Rec."Single-Level Subcontrd. Cost":=MATRIX2[1];
            Rec."Single-Level Cap. Ovhd Cost":=MATRIX2[2];
            Rec."Single-Level Mfg. Ovhd Cost":=MATRIX2[3];
            Rec."Overhead Rate":=MATRIX2[4];
            Rec."Rolled-up Subcontracted Cost":=MATRIX2[5];
            Rec."Rolled-up Mfg. Ovhd Cost":=MATRIX2[6];
            Rec."Rolled-up Cap. Overhead Cost":=MATRIX2[7];
            Rec.Agosto:=MATRIX2[8];
            Rec.Septiembre:=MATRIX2[9];
            Rec.Octubre:=MATRIX2[10];
            Rec.Noviembre:=MATRIX2[11];
            Rec.Diciembre:=MATRIX2[12];
            Rec.Insert;
        
        
        
        
        Rec.Init;Rec."No.":='C001';Rec."Block Reason":='Adj. Gross Profit';
        
        Rec."Single-Level Material Cost":=0;
        Rec."Single-Level Capacity Cost":=MATRIX3[13];
            Rec."Single-Level Subcontrd. Cost":=MATRIX3[1];
            Rec."Single-Level Cap. Ovhd Cost":=MATRIX3[2];
            Rec."Single-Level Mfg. Ovhd Cost":=MATRIX3[3];
            Rec."Overhead Rate":=MATRIX3[4];
            Rec."Rolled-up Subcontracted Cost":=MATRIX3[5];
            Rec."Rolled-up Mfg. Ovhd Cost":=MATRIX3[6];
            Rec."Rolled-up Cap. Overhead Cost":=MATRIX3[7];
            Rec.Agosto:=MATRIX3[8];
            Rec.Septiembre:=MATRIX3[9];
            Rec.Octubre:=MATRIX3[10];
            Rec.Noviembre:=MATRIX3[11];
            Rec.Diciembre:=MATRIX3[12];
        
        Rec.Insert;
        
        
        
        
        Rec.Init;Rec."No.":='C002';Rec."Block Reason":='                %';
        
        Rec."Single-Level Material Cost":=0;
        if MATRIX_CellDataImporte[13]<>0 then begin Rec."Single-Level Capacity Cost":=ROUND(((MATRIX3[13])/MATRIX_CellDataImporte[13])*100,0.01);end;
        if MATRIX_CellDataImporte[1]<>0 then begin Rec."Single-Level Subcontrd. Cost":=ROUND(((MATRIX3[1])/MATRIX_CellDataImporte[1])*100,0.01);end;
        if MATRIX_CellDataImporte[2]<>0 then begin Rec."Single-Level Cap. Ovhd Cost":=ROUND(((MATRIX3[2])/MATRIX_CellDataImporte[2])*100,0.01);end;
        if MATRIX_CellDataImporte[3]<>0 then begin Rec."Single-Level Mfg. Ovhd Cost":=ROUND(((MATRIX3[3])/MATRIX_CellDataImporte[3])*100,0.01);end;
        if MATRIX_CellDataImporte[4]<>0 then begin Rec."Overhead Rate":=ROUND(((MATRIX3[4])/MATRIX_CellDataImporte[4])*100,0.01);end;
        if MATRIX_CellDataImporte[5]<>0 then begin Rec."Rolled-up Subcontracted Cost":=ROUND(((MATRIX3[5])/MATRIX_CellDataImporte[5])*100,0.01);end;
        if MATRIX_CellDataImporte[6]<>0 then begin Rec."Rolled-up Mfg. Ovhd Cost":=ROUND(((MATRIX3[6])/MATRIX_CellDataImporte[6])*100,0.01);end;
        if MATRIX_CellDataImporte[7]<>0 then begin Rec."Rolled-up Cap. Overhead Cost":=ROUND(((MATRIX3[7])/MATRIX_CellDataImporte[7])*100,0.01);end;
        if MATRIX_CellDataImporte[8]<>0 then begin Rec.Agosto:=ROUND(((MATRIX3[8])/MATRIX_CellDataImporte[8])*100,0.01);end;
        if MATRIX_CellDataImporte[9]<>0 then begin Rec.Septiembre:=ROUND(((MATRIX3[9])/MATRIX_CellDataImporte[9])*100,0.01);end;
        if MATRIX_CellDataImporte[10]<>0 then begin Rec.Octubre:=ROUND(((MATRIX3[10])/MATRIX_CellDataImporte[10])*100,0.01);end;
        if MATRIX_CellDataImporte[11]<>0 then begin Rec.Noviembre:=ROUND(((MATRIX3[11])/MATRIX_CellDataImporte[11])*100,0.01);end;
        if MATRIX_CellDataImporte[12]<>0 then begin Rec.Diciembre:=ROUND(((MATRIX3[12])/MATRIX_CellDataImporte[12])*100,0.01);end;
        
        
        
        
        Rec.Insert;
        
        
        
        
        
        
        
        Rec.Init;Rec."No.":='C003';Rec."Block Reason":='Coste transporte';
        
        Rec."Single-Level Material Cost":=0;
        Rec."Single-Level Capacity Cost":=MATRIX_CellDataCosteTranspor[13];
        Rec."Single-Level Subcontrd. Cost":=MATRIX_CellDataCosteTranspor[1];
        Rec."Single-Level Cap. Ovhd Cost":=MATRIX_CellDataCosteTranspor[2];
        Rec."Single-Level Mfg. Ovhd Cost":=MATRIX_CellDataCosteTranspor[3];
        Rec."Overhead Rate":=MATRIX_CellDataCosteTranspor[4];
        Rec."Rolled-up Subcontracted Cost":=MATRIX_CellDataCosteTranspor[5];
        Rec."Rolled-up Mfg. Ovhd Cost":=MATRIX_CellDataCosteTranspor[6];
        Rec."Rolled-up Cap. Overhead Cost":=MATRIX_CellDataCosteTranspor[7];
        Rec.Agosto:=MATRIX_CellDataCosteTranspor[8];
        Rec.Septiembre:=MATRIX_CellDataCosteTranspor[9];
        Rec.Octubre:=MATRIX_CellDataCosteTranspor[10];
        Rec.Noviembre:=MATRIX_CellDataCosteTranspor[11];
        Rec.Diciembre:=MATRIX_CellDataCosteTranspor[12];
        Rec.Insert;
        
        Rec.Init;Rec."No.":='C004';Rec."Block Reason":='% Portes/Ventas';
        
        
        Rec."Single-Level Material Cost":=0;
        if MATRIX_CellDataImporte[13]<>0 then begin Rec."Single-Level Capacity Cost":=ROUND((MATRIX_CellDataCosteTranspor[13]/MATRIX_CellDataImporte[13]*100),0.01);end;
        if MATRIX_CellDataImporte[1]<>0 then begin Rec."Single-Level Subcontrd. Cost":=ROUND((MATRIX_CellDataCosteTranspor[1]/MATRIX_CellDataImporte[1]*100),0.01);end;
        if MATRIX_CellDataImporte[2]<>0 then begin Rec."Single-Level Cap. Ovhd Cost":=ROUND((MATRIX_CellDataCosteTranspor[2]/MATRIX_CellDataImporte[2]*100),0.01);end;
        if MATRIX_CellDataImporte[3]<>0 then begin Rec."Single-Level Mfg. Ovhd Cost":=ROUND((MATRIX_CellDataCosteTranspor[3]/MATRIX_CellDataImporte[3]*100),0.01);end;
        if MATRIX_CellDataImporte[4]<>0 then begin Rec."Overhead Rate":=ROUND((MATRIX_CellDataCosteTranspor[4]/MATRIX_CellDataImporte[4]*100),0.01);end;
        if MATRIX_CellDataImporte[5]<>0 then begin Rec."Rolled-up Subcontracted Cost":=ROUND((MATRIX_CellDataCosteTranspor[5]/MATRIX_CellDataImporte[5]*100),0.01);end;
        if MATRIX_CellDataImporte[6]<>0 then begin Rec."Rolled-up Mfg. Ovhd Cost":=ROUND((MATRIX_CellDataCosteTranspor[6]/MATRIX_CellDataImporte[6]*100),0.01);end;
        if MATRIX_CellDataImporte[7]<>0 then begin Rec."Rolled-up Cap. Overhead Cost":=ROUND((MATRIX_CellDataCosteTranspor[7]/MATRIX_CellDataImporte[7]*100),0.01);end;
        if MATRIX_CellDataImporte[8]<>0 then begin Rec.Agosto:=ROUND((MATRIX_CellDataCosteTranspor[8]/MATRIX_CellDataImporte[8]*100),0.01);end;
        if MATRIX_CellDataImporte[9]<>0 then begin Rec.Septiembre:=ROUND((MATRIX_CellDataCosteTranspor[9]/MATRIX_CellDataImporte[9]*100),0.01);end;
        if MATRIX_CellDataImporte[10]<>0 then begin Rec.Octubre:=ROUND((MATRIX_CellDataCosteTranspor[10]/MATRIX_CellDataImporte[10]*100),0.01);end;
        if MATRIX_CellDataImporte[11]<>0 then begin Rec.Noviembre:=ROUND((MATRIX_CellDataCosteTranspor[11]/MATRIX_CellDataImporte[11]*100),0.01);end;
        if MATRIX_CellDataImporte[12]<>0 then begin Rec.Diciembre:=ROUND((MATRIX_CellDataCosteTranspor[12]/MATRIX_CellDataImporte[12]*100),0.01);end;
        
        
        Rec.Insert;

    end;

    local procedure VerVentas()
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        DocExchStatusStyle: Text;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        DocExchStatusVisible: Boolean;
        IsOfficeAddin: Boolean;
        IsPostedSalesInvoicesEmpty: Boolean;
        IsFoundationEnabled: Boolean;
        [InDataSet]
        StyleText: Text;
        [InDataSet]
        SIIStateVisible: Boolean;
        Margen: Decimal;
        /////- AutomaticosEDICOM: Codeunit UnknownCodeunit50038;
        /////- LineasAlbaranEDI: Page "Lineas Albaran EDI";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvHeader: Record "Sales Invoice Header";
        CU: Integer;
        SUMA: Boolean;
        SUMAPB: Decimal;
        SUMAPF: Decimal;
        Rec113: Record "Sales Invoice Line";
        DTOAPLICADO: Decimal;
        imptarifa: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        SalesInvLine: Record "Sales Invoice Line";
        Cust: Record Customer;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        currency: Record Currency;
        TotalAdjCostLCY: Decimal;
        CustAmount: Decimal;
        AmountInclVAT: Decimal;
        InvDiscAmount: Decimal;
        VATAmount: Decimal;
        CostLCY: Decimal;
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        AdjProfitLCY: Decimal;
        AdjProfitPct: Decimal;
        LineQty: Decimal;
        TotalNetWeight: Decimal;
        TotalGrossWeight: Decimal;
        TotalVolume: Decimal;
        TotalParcels: Decimal;
        AmountLCY: Decimal;
        CreditLimitLCYExpendedPct: Decimal;
        VATPercentage: Decimal;
        VATAmountText: Text[30];
        PmtDiscAmount: Decimal;
        CostCalcMgt: Codeunit "Cost Calculation Management";
        NALBA: Code[20];
        color: Code[10];
        margenlin: Decimal;
        TDESDE: array [5] of Decimal;
        CUANTALIN: Integer;
        RecConfV: Record "Sales & Receivables Setup";
        THASTA: array [5] of Decimal;
        sumacostes: Decimal;
        sumaventas: Decimal;
        portescobrados: Decimal;
        TANTOPORTES: Decimal;
        DIFPORTES: Decimal;
        esmedia: Decimal;
        COSTEFAC: Decimal;
        RecPMP: Record "Inventario PMP";
        PMP: Decimal;
            
            
    begin
        
        
        
        X:=0;
        repeat
            X:=X+1;
            SalesInvoiceHeader.Reset;
            SalesInvoiceHeader.SetCurrentKey("Sell-to Customer No.","Posting Date");
            SalesInvoiceHeader.SetRange("Sell-to Customer No.",Customer."No.");
            SalesInvoiceHeader.SetRange("Posting Date",DESDEFECHA[X],HASTAFECHA[X]);
            if SalesInvoiceHeader.FindSet then repeat
              V.Update(1,'ventas:'+SalesInvoiceHeader."Sell-to Customer No."+' '+Format(SalesInvoiceHeader."Posting Date"));
                Margen:=0;
                COSTEFAC:=0;
                margenlin:=0;
                CUANTALIN:=0;
                imptarifa:=0;
                SUMA:=false;
                SUMAPB:=0;
                SUMAPF:=0;
                sumaventas:=0;
                sumacostes:=0;
                portescobrados:=0;
                Rec113.Reset;
                Rec113.SetCurrentKey("Document No.",Type);
                Rec113.SetRange(Rec113."Document No.",SalesInvoiceHeader."No.");
                Rec113.SetRange(Rec113.Type,2);
                if Rec113.Findset then repeat
                    if Rec113."No."='TRAN' then begin
                        portescobrados:=Rec113.Amount;
                    end;
                    SUMA:=true;
                    if (Rec113."Line Discount %"=100) and (Rec113.Regalo=false) then begin
                        SUMA:=false;
                    end;
                    if SUMA then begin
                        if Rec113."Precio base"<>0 then begin
                            SUMAPB:=SUMAPB+Rec113.Quantity*Rec113."Precio base";
                        end;
                        if Rec113."Precio base"=0 then begin
                            SUMAPB:=SUMAPB+Rec113.Quantity*Rec113."Unit Price";
                        end;
                        SUMAPF:=SUMAPF+Rec113.Amount;
                    end;
                    CUANTALIN:=CUANTALIN+1;
                    if Rec113."VAT Base Amount"<>0 then begin                        
                        PMP:=0;
                        RecPMP.RESET;
                        RecPMP.SETCURRENTKEY(RecPMP."Item No.",RecPMP."Posting Date");                         
                        RecPMP.SETRANGE(RecPMP."Item No.",rec113."No.");
                        RecPMP.SETRANGE(RecPMP."Posting Date",0D,Rec113."Posting Date"); 
                        IF RecPMP.FINDLAST THEN BEGIN
                            PMP:=RecPMP."Unit Cost";
                        END;
                        margenlin:=margenlin+(100-(100*(PMP*Rec113.Quantity)/(Rec113."VAT Base Amount")));
                    end;
                    sumaventas:=sumaventas+Rec113."VAT Base Amount";
                    HASTAFEC:=HASTAFECHA[X];
                    DATOSCOSTE:=CalculaCoste(Rec113."No.");
                    sumacostes:=sumacostes+DATOSCOSTE*Rec113.Quantity;
                    COSTEFAC:=COSTEFAC+DATOSCOSTE*Rec113.Quantity;
                until Rec113.Next=0;
                if SalesInvoiceHeader.Amount<>0 then begin
                    Margen:=ROUND((SalesInvoiceHeader.Amount-COSTEFAC)/SalesInvoiceHeader.Amount*100,0.01);
                end;
                Rec113.Reset;
                Rec113.SetCurrentKey("Document No.",Type);
                Rec113.SetRange(Rec113."Document No.",SalesInvoiceHeader."No.");
                Rec113.SetRange(Rec113.Type,1);
                if Rec113.Findset then begin
                    if Rec113."No."='62400000' then begin
                        portescobrados:=Rec113.Amount;
                    end;
                end;
        
                if sumaventas<>0 then begin
                    esmedia:=100*((sumaventas-sumacostes)/sumaventas);
                end;
        
                imptarifa:=SUMAPB;
                MATRIX_CellData[X]:=MATRIX_CellData[X]+ SUMAPB;
                MATRIX_CellData[13]:=MATRIX_CellData[13]+SUMAPB;
                DTOAPLICADO:=0;
                if SUMAPB<>0 then begin
                    DTOAPLICADO:=ROUND(((SUMAPB-SUMAPF)/SUMAPB)*100,0.01);
                end;
                MATRIX_CellDataDescuento[X]:=MATRIX_CellDataDescuento[X]+DTOAPLICADO;
                MATRIX_CellDataDescuento[13]:=MATRIX_CellDataDescuento[13]+DTOAPLICADO;
                SalesInvoiceHeader.CalcFields(Amount);
                MATRIX_CellDataImporte[X]:=MATRIX_CellDataImporte[X]+SalesInvoiceHeader.Amount;
                MATRIX_CellDataImporte[13]:=MATRIX_CellDataImporte[13]+SalesInvoiceHeader.Amount;
        
        
                MATRIX_CellDataCoste[X]:=MATRIX_CellDataCoste[X]+COSTEFAC;
                MATRIX_CellDataCoste[13]:=MATRIX_CellDataCoste[13]+COSTEFAC;
        
            until SalesInvoiceHeader.Next=0;
        
        
        ///// abonos
        
            SalesCrMemoHeader.Reset;
            SalesCrMemoHeader.SetCurrentKey("Sell-to Customer No.","Posting Date");
            SalesCrMemoHeader.SetRange("Sell-to Customer No.",Customer."No.");
            SalesCrMemoHeader.SetRange("Posting Date",DESDEFECHA[X],HASTAFECHA[X]);
            if SalesCrMemoHeader.FindSet then repeat
              V.Update(1,SalesCrMemoHeader."No."+' '+Format(SalesCrMemoHeader."Posting Date"));
                Margen:=0;
                COSTEFAC:=0;
                margenlin:=0;
                CUANTALIN:=0;
                imptarifa:=0;
                SUMA:=false;
                SUMAPB:=0;
                SUMAPF:=0;
                sumaventas:=0;
                sumacostes:=0;
                portescobrados:=0;
                Rec115.Reset;
                Rec115.SetCurrentKey("Document No.",Type);
                Rec115.SetRange(Rec115."Document No.",SalesCrMemoHeader."No.");
                Rec115.SetRange(Rec115.Type,2);
                if Rec115.Findset then repeat
                    if Rec115."No."='TRAN' then begin
                        portescobrados:=Rec115.Amount;
                    end;
                    SUMA:=true;
                    if (Rec115."Line Discount %"=100) then begin
                        SUMA:=false;
                    end;
                    if SUMA then begin
                        if Rec115."Precio base"<>0 then begin
                            SUMAPB:=SUMAPB+Rec115.Quantity*Rec115."Precio base";
                        end;
                        if Rec115."Precio base"=0 then begin
                            SUMAPB:=SUMAPB+Rec115.Quantity*Rec115."Unit Price";
                        end;
                        SUMAPF:=SUMAPF+Rec115.Amount;
                    end;
                    CUANTALIN:=CUANTALIN+1;
                    if Rec115."VAT Base Amount"<>0 then begin
                        PMP:=0;
                        RecPMP.RESET;
                        RecPMP.SETCURRENTKEY(RecPMP."Item No.",RecPMP."Posting Date");
                        RecPMP.SETRANGE(RecPMP."Item No.",rec115."No.");
                        RecPMP.SETRANGE(RecPMP."Posting Date",0D,Rec115."Posting Date"); 
                        IF RecPMP.FINDLAST THEN BEGIN
                            PMP:=RecPMP."Unit Cost";
                        END;

                        margenlin:=margenlin+(100-(100*(pmp*Rec115.Quantity)/(Rec115."VAT Base Amount")));
                    end;
                    sumaventas:=sumaventas+Rec115."VAT Base Amount";
        
                    HASTAFEC:=HASTAFECHA[X];
                    DATOSCOSTE:=CalculaCoste(Rec115."No.");
                    sumacostes:=sumacostes+DATOSCOSTE*Rec115.Quantity;
                    COSTEFAC:=COSTEFAC+DATOSCOSTE*Rec115.Quantity;
                until Rec115.Next=0;
                if SalesCrMemoHeader.Amount<>0 then begin
                    Margen:=ROUND((SalesCrMemoHeader.Amount-COSTEFAC)/SalesCrMemoHeader.Amount*100,0.01);
                end;
                Rec115.Reset;
                Rec115.SetCurrentKey("Document No.",Type);
                Rec115.SetRange(Rec115."Document No.",SalesCrMemoHeader."No.");
                Rec115.SetRange(Rec115.Type,1);
                if Rec115.FindSet then begin
                    if Rec115."No."='62400000' then begin
                        portescobrados:=Rec115.Amount;
                    end;
                end;
        
                if sumaventas<>0 then begin
                    esmedia:=100*((sumaventas-sumacostes)/sumaventas);
                end;
        
                imptarifa:=SUMAPB*-1;
                MATRIX_CellData[X]:=MATRIX_CellData[X]+SUMAPB*-1;
                MATRIX_CellData[13]:=MATRIX_CellData[13]+SUMAPB*-1;
                DTOAPLICADO:=0;
                if SUMAPB*-1<>0 then begin
                    DTOAPLICADO:=ROUND(((SUMAPB*-1-SUMAPF*-1)/SUMAPB*-1)*100,0.01);
                end;
                MATRIX_CellDataDescuento[X]:=MATRIX_CellDataDescuento[X]+DTOAPLICADO*-1;
                MATRIX_CellDataDescuento[13]:=MATRIX_CellDataDescuento[13]+DTOAPLICADO*-1;
                SalesCrMemoHeader.CalcFields(Amount);
                MATRIX_CellDataImporte[X]:=MATRIX_CellDataImporte[X]+SalesCrMemoHeader.Amount*-1;
                MATRIX_CellDataImporte[13]:=MATRIX_CellDataImporte[13]+SalesCrMemoHeader.Amount*-1;
        
        
                MATRIX_CellDataCoste[X]:=MATRIX_CellDataCoste[X]+COSTEFAC*-1;
                MATRIX_CellDataCoste[13]:=MATRIX_CellDataCoste[13]+COSTEFAC*-1;
        
        
        
        
            until SalesCrMemoHeader.Next=0;
        /////
        
        
        
        
        
        
        until X=12;
        
        
        
        
        /*
            TotalAdjCostLCY:=0;
            CustAmount:=0;
            AmountInclVAT:=0;
            InvDiscAmount:=0;
            VATAmount:=0;
            CostLCY:=0;
            ProfitLCY:=0;
            ProfitPct:=0;
            AdjProfitLCY:=0;
            AdjProfitPct:=0;
            LineQty:=0;
            TotalNetWeight:=0;
            TotalGrossWeight:=0;
            TotalVolume:=0;
            TotalParcels:=0;
            AmountLCY:=0;
            CreditLimitLCYExpendedPct:=0;
            VATPercentage:=0;
            PmtDiscAmount:=0;
            IF SalesInvoiceHeader."Currency Code" = '' THEN
                currency.InitRoundingPrecision
            ELSE
                currency.GET(SalesInvoiceHeader."Currency Code");
        
            SalesInvLine.SETRANGE("Document No.",SalesInvoiceHeader."No.");
            IF SalesInvLine.FIND('-') THEN REPEAT
                CustAmount := CustAmount + SalesInvLine.Amount;
                AmountInclVAT := AmountInclVAT + SalesInvLine."Amount Including VAT";
                PmtDiscAmount := PmtDiscAmount + SalesInvLine."Pmt. Disc. Given Amount";
                IF SalesInvoiceHeader."Prices Including VAT" THEN
                    InvDiscAmount := InvDiscAmount + SalesInvLine."Inv. Discount Amount" /
                    (1+ (SalesInvLine."VAT %" + SalesInvLine."EC %") / 100)
                ELSE
                    InvDiscAmount := InvDiscAmount + SalesInvLine."Inv. Discount Amount";
                CostLCY := CostLCY + (SalesInvLine.Quantity * SalesInvLine."Unit Cost (LCY)");
                LineQty := LineQty + SalesInvLine.Quantity;
                TotalNetWeight := TotalNetWeight + (SalesInvLine.Quantity * SalesInvLine."Net Weight");
                TotalGrossWeight := TotalGrossWeight + (SalesInvLine.Quantity * SalesInvLine."Gross Weight");
                TotalVolume := TotalVolume + (SalesInvLine.Quantity * SalesInvLine."Unit Volume");
                IF SalesInvLine."Units per Parcel" > 0 THEN
                    TotalParcels := TotalParcels + ROUND(SalesInvLine.Quantity / SalesInvLine."Units per Parcel",1,'>');
                IF SalesInvLine."VAT %" <> VATPercentage THEN
                    IF VATPercentage = 0 THEN
                        VATPercentage := SalesInvLine."VAT %" + SalesInvLine."EC %"
                    ELSE
                        VATPercentage := -1;
                TotalAdjCostLCY := TotalAdjCostLCY + CostCalcMgt.CalcSalesInvLineCostLCY(SalesInvLine);
            UNTIL SalesInvLine.NEXT = 0;
            VATAmount := AmountInclVAT - CustAmount;
            InvDiscAmount := ROUND(InvDiscAmount,currency."Amount Rounding Precision");
            IF SalesInvoiceHeader."Currency Code" = '' THEN
                AmountLCY := CustAmount
            ELSE
                AmountLCY :=
            CurrExchRate.ExchangeAmtFCYToLCY(
            WORKDATE,SalesInvoiceHeader."Currency Code",CustAmount,SalesInvoiceHeader."Currency Factor");
        
            ProfitLCY := AmountLCY - CostLCY;
            IF AmountLCY <> 0 THEN
                ProfitPct := ROUND(100 * ProfitLCY / AmountLCY,0.1);
        
            AdjProfitLCY := AmountLCY - TotalAdjCostLCY;
            IF AmountLCY <> 0 THEN
                AdjProfitPct := ROUND(100 * AdjProfitLCY / AmountLCY,0.1);
        
            IF Cust.GET(SalesInvoiceHeader."Bill-to Customer No.") THEN
                Cust.CALCFIELDS("Balance (LCY)")
            ELSE
                CLEAR(Cust);
        
            IF Cust."Credit Limit (LCY)" = 0 THEN
                CreditLimitLCYExpendedPct := 0
            ELSE
                CreditLimitLCYExpendedPct := ROUND(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000,1);
        
            SalesInvLine.CalcVATAmountLines(SalesInvoiceHeader,TempVATAmountLine);
        
            DIFPORTES:=portescobrados; /////-"Importe optimo transporte";
        
            TANTOPORTES:=0;
            IF SalesInvoiceHeader.Amount<>0 THEN BEGIN
                TANTOPORTES:=100-((SalesInvoiceHeader."Importe coste Real"-DIFPORTES)/SalesInvoiceHeader.Amount*100);
            END;
        UNTIL SalesInvoiceHeader.NEXT=0;
        */

    end;

    local procedure CalculaCoste(codprod: Code[20]) COSTEMED: Decimal
    var
        Rec32: Record "Item Ledger Entry";
        coste: Decimal;
        valor: Decimal;
        filtro: Text[250];
        DESDE: Date;
        HASTA: Date;
        coste2: Decimal;
        sincargos: Boolean;
        total: Decimal;
        RecItem: Record Item;
        RecItem2: Record Item;
        ventana: Dialog;
        COSTEMEDIO: Decimal;
        VALORMEDIO: Decimal;
        CANTPENDIENTE: Decimal;
        STOCKACT: Decimal;
        SALE: Boolean;
        CANTIDADAVALORAR: Decimal;
        SUMAMEDIA: Decimal;
        Rec32Temp: Record "Item Ledger Entry" temporary;
        CONTADOR: Integer;
        VALORSTOC: Decimal;
        vMEDIA: Decimal;
        Unfavorable: Text;
        InventarioPMP: Record "Inventario PMP";
        PMP: Decimal;
        RecPMP: Record "Inventario PMP";
    begin




        coste:=0;
        coste2:=0;


        HASTA:=HASTAFEC;


        vMEDIA:=0;

        Rec32Temp.Reset;
        if Rec32Temp.FindFirst then repeat
             Rec32Temp.Delete;
        until Rec32Temp.Next=0;
        RecItem.Get(codprod);

        VALORMEDIO:=0;
        COSTEMEDIO:=0;
        CANTPENDIENTE:=0;
        SALE:=false;
        RecItem.Get(codprod);
        RecItem.SetRange("Date Filter",20000101D,HASTA);
        RecItem.CalcFields(RecItem."Net Change");
        STOCKACT:=RecItem."Net Change";
        CONTADOR:=99999999;
        Rec32.Reset;
        Rec32.SetCurrentkey("Item No.","Entry Type","Location Code","Posting Date");
        Rec32.SetRange(Rec32."Item No.",codprod);
        Rec32.SetRange(Rec32."Entry Type",0);
        Rec32.SetRange(Rec32."Location Code",'SILLA');
        Rec32.SetRange(Rec32."Posting Date",DESDE,HASTA);
        if Rec32.FindSet then repeat
             Rec32Temp:=Rec32;
             CONTADOR:=CONTADOR-1;
             Rec32Temp."Entry No.":=CONTADOR;
             Rec32.CalcFields(Rec32."Cost Amount (Actual)",Rec32."Tiene cargos");
             PMP:=0;
             RecPMP.RESET;
             RecPMP.SETCURRENTKEY(RecPMP."Item No.",RecPMP."Posting Date");
             RecPMP.SETRANGE(RecPMP."Item No.",codprod);
             RecPMP.SETRANGE(RecPMP."Posting Date",0D,Rec32."Posting Date");
             IF RecPMP.FINDLAST THEN BEGIN
                 PMP:=RecPMP."Unit Cost";
             END;
             Rec32Temp."Invoiced Quantity":=PMP*Rec32.Quantity;
             Rec32Temp.Insert;
        until (Rec32.Next=0);



        vMEDIA:=0;
        VALORMEDIO:=0;
        COSTEMEDIO:=0;
        CANTPENDIENTE:=0;
        SALE:=false;
        RecItem.SetRange("Date Filter",20000101D,HASTA);
        RecItem.CalcFields("Net Change");
        STOCKACT:=RecItem."Net Change";

        Rec32Temp.Reset;
        if Rec32Temp.Findset then repeat
              vMEDIA:=Rec32Temp."Invoiced Quantity"/Rec32Temp.Quantity;

              if STOCKACT<Rec32Temp.Quantity then begin
                   VALORMEDIO:=VALORMEDIO+(vMEDIA*STOCKACT);
                   SUMAMEDIA:=(vMEDIA*STOCKACT);
                   STOCKACT:=0;
              end;

              if STOCKACT>=Rec32Temp.Quantity then begin
                   VALORMEDIO:=VALORMEDIO+(vMEDIA*Rec32Temp.Quantity);
                   SUMAMEDIA:=(vMEDIA*Rec32Temp.Quantity);
                   STOCKACT:=STOCKACT-Rec32Temp.Quantity;
              end;
                 if STOCKACT<=0 then begin
                     SALE:=true;
              end;
        until (Rec32Temp.Next=0) or (SALE);



        COSTEMEDIO:=0;
        if RecItem."Net Change"<>0 then begin
             COSTEMEDIO:=VALORMEDIO/RecItem."Net Change";
        end;


        if COSTEMEDIO=0 then begin
             COSTEMEDIO:=RecItem."Precio inv 2009";
             if VALORMEDIO=0 then begin
                  VALORMEDIO:=COSTEMEDIO*RecItem."Net Change";
             end;
        end;




        ///// valor:=Inventory*COSTEMEDIO;
        exit(COSTEMEDIO);
    end;

    local procedure VerVentasPortes()
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        DocExchStatusStyle: Text;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        DocExchStatusVisible: Boolean;
        IsOfficeAddin: Boolean;
        IsPostedSalesInvoicesEmpty: Boolean;
        IsFoundationEnabled: Boolean;
        [InDataSet]
        StyleText: Text;
        [InDataSet]
        SIIStateVisible: Boolean;
        Margen: Decimal;
        /////- AutomaticosEDICOM: Codeunit UnknownCodeunit50038;
        /////- LineasAlbaranEDI: Page "Lineas Albaran EDI";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvHeader: Record "Sales Invoice Header";
        CU: Integer;
        SUMA: Boolean;
        SUMAPB: Decimal;
        SUMAPF: Decimal;
        Rec113: Record "Sales Invoice Line";
        DTOAPLICADO: Decimal;
        imptarifa: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        SalesInvLine: Record "Sales Invoice Line";
        Cust: Record Customer;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        currency: Record Currency;
        TotalAdjCostLCY: Decimal;
        CustAmount: Decimal;
        AmountInclVAT: Decimal;
        InvDiscAmount: Decimal;
        VATAmount: Decimal;
        CostLCY: Decimal;
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        AdjProfitLCY: Decimal;
        AdjProfitPct: Decimal;
        LineQty: Decimal;
        TotalNetWeight: Decimal;
        TotalGrossWeight: Decimal;
        TotalVolume: Decimal;
        TotalParcels: Decimal;
        AmountLCY: Decimal;
        CreditLimitLCYExpendedPct: Decimal;
        VATPercentage: Decimal;
        VATAmountText: Text[30];
        PmtDiscAmount: Decimal;
        CostCalcMgt: Codeunit "Cost Calculation Management";
        NALBA: Code[20];
        color: Code[10];
        margenlin: Decimal;
        TDESDE: array [5] of Decimal;
        CUANTALIN: Integer;
        RecConfV: Record "Sales & Receivables Setup";
        THASTA: array [5] of Decimal;
        sumacostes: Decimal;
        sumaventas: Decimal;
        portescobrados: Decimal;
        TANTOPORTES: Decimal;
        DIFPORTES: Decimal;
        esmedia: Decimal;
        COSTEFAC: Decimal;
        InventarioPMP: Record "Inventario PMP";
    begin



        X:=0;
        repeat
            portescobrados:=0;
            X:=X+1;
            SalesInvoiceHeader.Reset;
            SalesInvoiceHeader.SetCurrentKey("Sell-to Customer No.","Posting Date");
            SalesInvoiceHeader.SetRange("Sell-to Customer No.",Customer."No.");
            SalesInvoiceHeader.SetRange("Posting Date",DESDEFECHA[X],HASTAFECHA[X]);
            if SalesInvoiceHeader.FindSet then repeat
              V.Update(1,SalesInvoiceHeader."No."+' '+Format(SalesInvoiceHeader."Posting Date"));
                Margen:=0;
                COSTEFAC:=0;
                margenlin:=0;
                CUANTALIN:=0;
                imptarifa:=0;
                SUMA:=false;
                SUMAPB:=0;
                SUMAPF:=0;
                sumaventas:=0;
                sumacostes:=0;
                portescobrados:=0;
                Rec113.Reset;
                Rec113.SetCurrentKey("Document No.",Type);
                Rec113.SetRange(Rec113."Document No.",SalesInvoiceHeader."No.");
                Rec113.SetRange(Rec113.Type,2);
                if Rec113.Findset then repeat
                    if Rec113."No."='TRAN' then begin
                        MATRIX_CellDataPortes[X]:=MATRIX_CellDataPortes[X]+Rec113.Amount;
                        MATRIX_CellDataPortes[13]:=MATRIX_CellDataPortes[13]+Rec113.Amount;
                    end;
                until Rec113.Next=0;
                Rec113.Reset;
                Rec113.SetCurrentKey("Document No.",Type);
                Rec113.SetRange(Rec113."Document No.",SalesInvoiceHeader."No.");
                Rec113.SetRange(Rec113.Type,1);
                if Rec113.Findset then begin
                    if Rec113."No."='62400000' then begin
                        MATRIX_CellDataPortes[X]:=MATRIX_CellDataPortes[X]+Rec113.Amount;
                        MATRIX_CellDataPortes[13]:=MATRIX_CellDataPortes[13]+Rec113.Amount;
                    end;
                end;





            until SalesInvoiceHeader.Next=0;


        ///// abonos

            SalesCrMemoHeader.Reset;
            SalesCrMemoHeader.SetCurrentKey("Sell-to Customer No.","Posting Date");
            SalesCrMemoHeader.SetRange("Sell-to Customer No.",Customer."No.");
            SalesCrMemoHeader.SetRange("Posting Date",DESDEFECHA[X],HASTAFECHA[X]);
            if SalesCrMemoHeader.Findset then repeat
              V.Update(1,SalesCrMemoHeader."No."+' '+Format(SalesCrMemoHeader."Posting Date"));
                Margen:=0;
                COSTEFAC:=0;
                margenlin:=0;
                CUANTALIN:=0;
                imptarifa:=0;
                SUMA:=false;
                SUMAPB:=0;
                SUMAPF:=0;
                sumaventas:=0;
                sumacostes:=0;
                portescobrados:=0;

                Rec115.Reset;
                Rec115.SetCurrentKey("Document No.",Type);
                Rec115.SetRange(Rec115."Document No.",SalesCrMemoHeader."No.");
                Rec115.SetRange(Rec115.Type,2);
                if Rec115.Findset then repeat
                    if Rec115."No."='TRAN' then begin
                        MATRIX_CellDataPortes[X]:=MATRIX_CellDataPortes[X]+Rec115.Amount*-1;
                        MATRIX_CellDataPortes[13]:=MATRIX_CellDataPortes[13]+Rec115.Amount*-1;
                    end;
                until Rec115.Next=0;
                Rec115.Reset;
                Rec115.SetCurrentKey("Document No.",Type);
                Rec115.SetRange(Rec115."Document No.",SalesCrMemoHeader."No.");
                Rec115.SetRange(Rec115.Type,1);
                if Rec115.Findset then begin
                    if Rec115."No."='62400000' then begin
                        MATRIX_CellDataPortes[X]:=MATRIX_CellDataPortes[X]+Rec115.Amount*-1;
                        MATRIX_CellDataPortes[13]:=MATRIX_CellDataPortes[13]+Rec115.Amount*-1;
                    end;
                end;

            until SalesCrMemoHeader.Next=0;
        /////






        until X=12;



    end;

    local procedure VerCostePortes()
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        DocExchStatusStyle: Text;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        DocExchStatusVisible: Boolean;
        IsOfficeAddin: Boolean;
        IsPostedSalesInvoicesEmpty: Boolean;
        IsFoundationEnabled: Boolean;
        [InDataSet]
        StyleText: Text;
        [InDataSet]
        SIIStateVisible: Boolean;
        Margen: Decimal;
        /////- AutomaticosEDICOM: Codeunit UnknownCodeunit50038;
        /////- LineasAlbaranEDI: Page "Lineas Albaran EDI";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvHeader: Record "Sales Invoice Header";
        CU: Integer;
        SUMA: Boolean;
        SUMAPB: Decimal;
        SUMAPF: Decimal;
        Rec113: Record "Sales Invoice Line";
        DTOAPLICADO: Decimal;
        imptarifa: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        SalesInvLine: Record "Sales Invoice Line";
        Cust: Record Customer;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        currency: Record Currency;
        TotalAdjCostLCY: Decimal;
        CustAmount: Decimal;
        AmountInclVAT: Decimal;
        InvDiscAmount: Decimal;
        VATAmount: Decimal;
        CostLCY: Decimal;
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        AdjProfitLCY: Decimal;
        AdjProfitPct: Decimal;
        LineQty: Decimal;
        TotalNetWeight: Decimal;
        TotalGrossWeight: Decimal;
        TotalVolume: Decimal;
        TotalParcels: Decimal;
        AmountLCY: Decimal;
        CreditLimitLCYExpendedPct: Decimal;
        VATPercentage: Decimal;
        VATAmountText: Text[30];
        PmtDiscAmount: Decimal;
        CostCalcMgt: Codeunit "Cost Calculation Management";
        NALBA: Code[20];
        color: Code[10];
        margenlin: Decimal;
        TDESDE: array [5] of Decimal;
        CUANTALIN: Integer;
        RecConfV: Record "Sales & Receivables Setup";
        THASTA: array [5] of Decimal;
        sumacostes: Decimal;
        sumaventas: Decimal;
        portescobrados: Decimal;
        TANTOPORTES: Decimal;
        DIFPORTES: Decimal;
        esmedia: Decimal;
        COSTEFAC: Decimal;
        InventarioPMP: Record "Inventario PMP";
    begin



        X:=0;
        repeat
            X:=X+1;            
            SalesShipmentHeader.Reset;
            SalesShipmentHeader.SetCurrentKey("Sell-to Customer No.","Posting Date");
            SalesShipmentHeader.SetRange("Sell-to Customer No.",Customer."No.");
            SalesShipmentHeader.SetRange("Posting Date",DESDEFECHA[X],HASTAFECHA[X]);
            if SalesShipmentHeader.Findset then repeat
                V.Update(1,SalesShipmentHeader."No."+' '+Format(SalesShipmentHeader."Posting Date"));

                MATRIX_CellDataCosteTranspor[X]:=MATRIX_CellDataCosteTranspor[X] + SalesShipmentHeader."Importe transporte";
                MATRIX_CellDataCosteTranspor[13]:=MATRIX_CellDataCosteTranspor[13] + SalesShipmentHeader."Importe transporte";

            until SalesShipmentHeader.Next=0;





        until X=12;



    end;
}

