#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50022 "Conecta ADAIA"
{

    trigger OnRun()
    var
        Fichero: Text[250];
    begin

    end;

    var
        RecFile: File;
        ArchExt: Text[250];
        ArchExt1: Text[250];
        ArchExt2: Text[250];
        ArchExt3: Text[250];
        ArchExt4: Text[250];
        TextoSalida: Text[250];
        TextoSalida2: Text[250];
        TextoSalida3: Text[250];
        TextoSalida4: Text[250];
        ArchSalida: File;
        FICHERO: File;
        PosInicial: Integer;
        Linea: Text;
        FechaFichero: Code[20];
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        NALBARAN: Code[20];
        Customer: Record Customer;
        LAFECHA: Code[20];
        DD: Integer;
        MM: Integer;
        AA: Integer;
        M1: Code[10];
        D1: Code[10];
        numpedi: Code[20];
        nomdir: Text[255];
        suref: Code[10];
        Rec112: Record "Sales Invoice Header";

        Rec113: Record "Sales Invoice Line";

        SalesInvoiceHeader2: Record "Sales Invoice Header";
        SalesShipmentHeader2: Record "Sales Shipment Header";
        enviar: Boolean;

    /*
        procedure ImportaTRSTOART(NombreFichero: Text[250])
        var
            POS: Integer;
            SALE: Boolean;
            REF: Code[20];
            CANTI: Code[20];
            DCanti: Decimal;
            Item: Record Item;
            ItemUnitofMeasure: Record "Item Unit of Measure";
            Rec83: Record "Item Journal Line";
            WORKDATED: Date;
            ArchSalida: File;
            RecSDP: Record "Item Journal Batch";
            lin: Decimal;
            RecUMP: Record "Item Unit of Measure";
            STOCCAL: Decimal;
            RecItem2: Record Item;
            RecPP: Record "Purchase Price";
            Rec32: Record "Item Ledger Entry";
            RecFile: File;
            ArchExt: Text[250];
            ArchExt1: Text[250];
            ArchExt2: Text[250];
            ArchExt3: Text[250];
            ArchExt4: Text[250];
            TextoSalida: Text[250];
            TextoSalida2: Text[250];
            TextoSalida3: Text[250];
            TextoSalida4: Text[250];
            FICHERO: File;
            PosInicial: Integer;
            Linea: Text;
            FechaFichero: Code[20];
        begin



            WORKDATED:=WORKDATE;
            FechaFichero:= FORMAT(WORKDATED);
            RecSDP.RESET;
            RecSDP.SETRANGE(RecSDP."Journal Template Name",'INVENT. FÍ');
            RecSDP.SETRANGE(RecSDP.Name,FechaFichero);
            IF RecSDP.FINDFIRST THEN BEGIN
                 Rec83.RESET;
                 Rec83.SETRANGE(Rec83."Journal Template Name",RecSDP."Journal Template Name");
                 Rec83.SETRANGE(Rec83."Journal Batch Name",RecSDP.Name);
                 IF Rec83.FIND('-') THEN BEGIN
                      Rec83.DELETEALL;
                 END;
            END;

            IF NOT RecSDP.FINDFIRST THEN BEGIN
                 RecSDP."Journal Template Name":='INVENT. FÍ';
                 RecSDP.Name:=FechaFichero;
                 RecSDP.Description:='INVENTARIO '+FechaFichero;
                 RecSDP.INSERT;

            END;



            Item.RESET;
            Item.SETRANGE(Blocked,FALSE);
            Item.SETRANGE(Item."Producto almacenable",TRUE);
            IF Item.FINDSET THEN REPEAT
                  ItemUnitofMeasure.RESET;
                  ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure."Item No.",Item."No.");
                  ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure.Code,'UDS');
                  IF NOT ItemUnitofMeasure.FINDFIRST THEN BEGIN
                       ItemUnitofMeasure.INIT;
                       ItemUnitofMeasure."Item No.":=Item."No.";
                       ItemUnitofMeasure.Code:='UDS';
                       ItemUnitofMeasure."Qty. per Unit of Measure":=1;
                       ItemUnitofMeasure.INSERT;
                  END;

                  RecItem2.GET(Item."No.");
                  RecItem2.SETRANGE(RecItem2."Location Filter",'SILLA','SILLA');
                  RecItem2.CALCFIELDS(RecItem2.Inventory);
                  STOCCAL:=RecItem2.Inventory;
                  Rec83.INIT;
                  Rec83."Journal Template Name":='INVENT. FÍ';
                  Rec83."Journal Batch Name":=FechaFichero;
                  lin:=lin+10000;
                  Rec83."Line No.":=lin;
                  Rec83."Phys. Inventory":=FALSE;
                  Rec83.VALIDATE(Rec83."Item No.",Item."No.");
                  Rec83."Phys. Inventory":=TRUE;
                  Rec83."Location Code":='SILLA';
                  Rec83."Posting Date":=TODAY;
                  Rec83."Unit of Measure Code":=Item."Base Unit of Measure";
                  Rec83.VALIDATE(Rec83."Qty. (Calculated)",STOCCAL);
                  Rec83."Document No.":='AJUSTES';
                  Rec83.INSERT;

            UNTIL Item.NEXT=0;







            ///// STAR|MO||00060|000000000|UD|00000001|000000000|HAGEN|||
            ///// 12345678

            ArchExt:=NombreFichero;
            repeat
              if CopyStr(Linea,1,4)='STAR' then begin

                 POS:=8;
                 SALE:=false;
                 repeat
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 SALE:=false;
                 POS:=POS+1;
                 REF:='';
                 repeat
                      REF:=REF+CopyStr(Linea,POS,1);
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 POS:=POS+1;
                 SALE:=false;
                 CANTI:='';
                 repeat
                      CANTI:=CANTI+CopyStr(Linea,POS,1);
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;

                 /////
                 Evaluate(DCanti,CANTI);
                 if Item.Get(REF) then begin
                    if Item.Blocked=false then begin
                      ItemUnitofMeasure.Reset;
                      ItemUnitofMeasure.SetRange(ItemUnitofMeasure."Item No.",REF);
                      ItemUnitofMeasure.SetRange(ItemUnitofMeasure.Code,'UDS');
                      if not ItemUnitofMeasure.FindFirst then begin
                           ItemUnitofMeasure.Init;
                           ItemUnitofMeasure."Item No.":=REF;
                           ItemUnitofMeasure.Code:='UDS';
                           ItemUnitofMeasure."Qty. per Unit of Measure":=1;
                           ItemUnitofMeasure.Insert;
                      end;
                      ////Rec83.RESET;
                      ////Rec83.SETRANGE(Rec83."Journal Template Name",'INVENT. FÍ');
                      ////Rec83.SETRANGE(Rec83."Journal Batch Name",FechaFichero);
                      ////Rec83.SETRANGE(Rec83."Item No.",REF);
                      ////IF Rec83.FINDFIRST THEN BEGIN
                           /////Rec83.VALIDATE(Rec83."Qty. (Phys. Inventory)",Rec83."Qty. (Phys. Inventory)"+DCanti);
                        /////   Rec83.MODIFY;
                          //// COMMIT;
                      ////END;
                  end;
                 end;
                 /////




              end;

            Commit;


            ///RecSDP.RESET;
            ///RecSDP.SETRANGE(RecSDP."Journal Template Name",'INVENT. FÍ');
            ///RecSDP.SETRANGE(RecSDP.Name,FechaFichero);
            ///IF RecSDP.FINDFIRST THEN BEGIN
                 ///Rec83.RESET;
                 ///Rec83.SETRANGE(Rec83."Journal Template Name",RecSDP."Journal Template Name");
                 ///Rec83.SETRANGE(Rec83."Journal Batch Name",RecSDP.Name);
                 ///IF Rec83.FIND('-') THEN REPEAT
                      ///IF Rec83.Quantity=0 THEN BEGIN
                           ///Rec83.DELETE;
                      ///END;
                 ///UNTIL Rec83.NEXT=0;
            ////END;




    /*
        procedure ImportaTRSTO(NombreFichero: Text[250])
        var
            POS: Integer;
            SALE: Boolean;
            REF: Code[20];
            CANTI: Code[20];
            DCanti: Decimal;
            Item: Record Item;
            ItemUnitofMeasure: Record "Item Unit of Measure";
            Rec83: Record "Item Journal Line";
            WORKDATED: Date;
            ArchSalida: File;
            RecSDP: Record "Item Journal Batch";
            lin: Decimal;
            RecUMP: Record "Item Unit of Measure";
            STOCCAL: Decimal;
            RecItem2: Record Item;
            RecPP: Record "Purchase Price";
            Rec32: Record "Item Ledger Entry";
            RecFile: File;
            ArchExt: Text[250];
            ArchExt1: Text[250];
            ArchExt2: Text[250];
            ArchExt3: Text[250];
            ArchExt4: Text[250];
            TextoSalida: Text[250];
            TextoSalida2: Text[250];
            TextoSalida3: Text[250];
            TextoSalida4: Text[250];
            FICHERO: File;
            PosInicial: Integer;
            Linea: Text;
            FechaFichero: Code[20];
            UBICA: Code[20];
            FC: Code[10];
            conta: Integer;
            codlote: Code[30];
            d1: Code[10];
            d2: Integer;
            m1: Code[10];
            m2: Integer;
            a1: Code[10];
            a2: Integer;
            fechacadu: Date;
        begin




            WORKDATED:=WorkDate;
            FechaFichero:= Format(WORKDATED);



            RecMT.Reset;
            RecMT.SetRange(RecMT.Tabla,17);
            if RecMT.FindFirst then repeat
                 RecMT.Delete;
            until RecMT.Next=0;




            WORKDATED:=WorkDate;
            FechaFichero:= Format(WORKDATED);
            RecSDP.Reset;
            RecSDP.SetRange(RecSDP."Journal Template Name",'INVENT. FÍ');
            RecSDP.SetRange(RecSDP.Name,FechaFichero);
            if RecSDP.FindFirst then begin
                 Rec83.Reset;
                 Rec83.SetRange(Rec83."Journal Template Name",RecSDP."Journal Template Name");
                 Rec83.SetRange(Rec83."Journal Batch Name",RecSDP.Name);
                 if Rec83.Find('-') then begin
                      Rec83.DeleteAll;
                 end;
            end;

            if not RecSDP.FindFirst then begin
                 RecSDP."Journal Template Name":='INVENT. FÍ';
                 RecSDP.Name:=FechaFichero;
                 RecSDP.Description:='INVENTARIO '+FechaFichero;
                 RecSDP.Insert;

            end;



            Item.Reset;
            Item.SetRange(Blocked,false);
            Item.SetRange(Item."Producto almacenable",true);
            if Item.FindSet then repeat
                  ItemUnitofMeasure.Reset;
                  ItemUnitofMeasure.SetRange(ItemUnitofMeasure."Item No.",Item."No.");
                  ItemUnitofMeasure.SetRange(ItemUnitofMeasure.Code,'UDS');
                  if not ItemUnitofMeasure.FindFirst then begin
                       ItemUnitofMeasure.Init;
                       ItemUnitofMeasure."Item No.":=Item."No.";
                       ItemUnitofMeasure.Code:='UDS';
                       ItemUnitofMeasure."Qty. per Unit of Measure":=1;
                       ItemUnitofMeasure.Insert;
                  end;

                  RecItem2.Get(Item."No.");
                  RecItem2.SetRange(RecItem2."Location Filter",'SILLA','SILLA');
                  RecItem2.CalcFields(RecItem2.Inventory);
                  STOCCAL:=RecItem2.Inventory;
                  Rec83.Init;
                  Rec83."Journal Template Name":='INVENT. FÍ';
                  Rec83."Journal Batch Name":=FechaFichero;
                  lin:=lin+10000;
                  Rec83."Line No.":=lin;
                  Rec83."Phys. Inventory":=false;
                  Rec83.Validate(Rec83."Item No.",Item."No.");
                  Rec83."Phys. Inventory":=true;
                  Rec83."Location Code":='SILLA';
                  Rec83."Posting Date":=Today;
                  Rec83."Unit of Measure Code":=Item."Base Unit of Measure";
                  Rec83.Validate(Rec83."Qty. (Calculated)",STOCCAL);
                  Rec83."Document No.":='AJUSTES';
                  Rec83.Insert;

            until Item.Next=0;







            /*
            EnabledSourceExprStartPosWidth
            YesUNO00
            YesDOS00
            YesUBICA00
            YesPROD00
            YesCANTI00
            YesUNO00
            YesUNO00
            YesUNO00
            Yesfc00
            YesUNO00
            YesUNO00
            Yescodlote00
            YesUNO00
            YesUNO00
            YesUNO00
            YesUNO00
            YesUNO00
            YesUNO00
            YesUNO00


            ///// 12345678
            ///// STSI|MO|010A00101|S7927|000000008|UD|00000001|000000000||20100924|||OK|010A00101||EU|||E130|

            ArchExt:=NombreFichero;
            repeat
                 if CopyStr(Linea,1,4)='STSI' then begin
                      POS:=9;
                      SALE:=false;
                      UBICA:='';
                      repeat
                           UBICA:=UBICA+CopyStr(Linea,POS,1);
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      ///// STSI|MO|010A00101|S7927|000000008|UD|00000001|000000000||20100924|||OK|010A00101||EU|||E130|

                      POS:=POS+1;
                      SALE:=false;
                      REF:='';
                      repeat
                           if (CopyStr(Linea,POS,1)='-') then begin
                           SALE:=true;POS:=POS+4;
                           end;
                           if not SALE then begin
                                REF:=REF+CopyStr(Linea,POS,1);
                                POS:=POS+1;
                                if (CopyStr(Linea,POS,1)='|') then begin
                                     SALE:=true;
                                end;
                           end;
                      until SALE;
                      ///// STSI|MO|010A00101|S7927|000000008|UD|00000001|000000000||20100924|||OK|010A00101||EU|||E130|
                      POS:=POS+1;
                      SALE:=false;
                      CANTI:='';
                      repeat
                           CANTI:=CANTI+CopyStr(Linea,POS,1);
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      Evaluate(DCanti,CANTI);
                      ///// STSI|MO|010A00101|S7927|000000008
                      SALE:=false;
                      repeat
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      ///// STSI|MO|010A00101|S7927|000000008|UD
                      SALE:=false;
                      repeat
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      ///// STSI|MO|010A00101|S7927|000000008|UD|00000001
                      SALE:=false;
                      repeat
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      ///// STSI|MO|010A00101|S7927|000000008|UD|00000001|000000000||20100924|||OK|010A00101||EU|||E130|
                      SALE:=false;
                      FC:='';
                      POS:=POS+1;
                      repeat
                       if CopyStr(Linea,POS,1)<>'|' then begin
                           FC:=FC+CopyStr(Linea,POS,1);
                           end;
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      SALE:=false;
                      repeat
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                       SALE:=false;
                      repeat
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      SALE:=false;
                      repeat
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      SALE:=false;
                      repeat
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      SALE:=false;
                      POS:=POS+1;
                      codlote:='';
                      repeat
                           codlote:=codlote+CopyStr(Linea,POS,1);
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;

                      if FC<>'' then begin
                       if FC<>'|' then begin
                          a1:=CopyStr(FC,1,4);
                          m1:=CopyStr(FC,5,2);
                          d1:=CopyStr(FC,7,2);
                          Evaluate(a2,a1);
                          Evaluate(m2,m1);
                          Evaluate(d2,d1);
                          fechacadu:=Dmy2date(d2,m2,a2);
                      end;
                      end;
                      if RecItem2.Get(REF) then begin
                          conta:=conta+1;
                          RecMT.Init;
                          RecMT.Tabla:=17;
                          RecMT.Código:=Format(conta);
                          RecMT.Producto:=REF;
                          RecMT.Ubicacion:=UBICA;
                          RecMT.Cantidad:=DCanti;
                          RecMT."Fecha caducidad":=fechacadu;
                          RecMT.Lote:=codlote;
                          RecMT.Insert;
                      end;
                  end;
                   if Item.Get(REF) then begin
                    if Item.Blocked=false then begin
                      ItemUnitofMeasure.Reset;
                      ItemUnitofMeasure.SetRange(ItemUnitofMeasure."Item No.",REF);
                      ItemUnitofMeasure.SetRange(ItemUnitofMeasure.Code,'UDS');
                      if not ItemUnitofMeasure.FindFirst then begin
                           ItemUnitofMeasure.Init;
                           ItemUnitofMeasure."Item No.":=REF;
                           ItemUnitofMeasure.Code:='UDS';
                           ItemUnitofMeasure."Qty. per Unit of Measure":=1;
                           ItemUnitofMeasure.Insert;
                      end;
                      Rec83.Reset;
                      Rec83.SetRange(Rec83."Journal Template Name",'INVENT. FÍ');
                      Rec83.SetRange(Rec83."Journal Batch Name",FechaFichero);
                      Rec83.SetRange(Rec83."Item No.",REF);
                      if Rec83.FindFirst then begin
                           Rec83.Validate(Rec83."Qty. (Phys. Inventory)",Rec83."Qty. (Phys. Inventory)"+DCanti);
                           Rec83.Modify;
                           Commit;
                      end;
                  end;
                 end;

            until FICHERO.Read(Linea) = 0;
            FICHERO.Close;


            RecSDP.Reset;
            RecSDP.SetRange(RecSDP."Journal Template Name",'INVENT. FÍ');
            RecSDP.SetRange(RecSDP.Name,FechaFichero);
            if RecSDP.FindFirst then begin
                 Rec83.Reset;
                 Rec83.SetRange(Rec83."Journal Template Name",RecSDP."Journal Template Name");
                 Rec83.SetRange(Rec83."Journal Batch Name",RecSDP.Name);
                 if Rec83.Find('-') then repeat
                      if Rec83.Quantity=0 then begin
                           Rec83.Delete;
                      end;
                 until Rec83.Next=0;
            end;

        end;
    */
    /*
        procedure ImportaTRREC(NombreFichero: Text[250])
        var
            D: Date;
            "DECIAÑO": Integer;
            "Año": Code[10];
            Mes: Decimal;
            Dia: Decimal;
            DOC1: Code[255];
            SALE: Boolean;
            NPEDIDO: Code[10];
            REF: Code[10];
            POS: Decimal;
            CANTI: Code[10];
            PurchaseLine: Record "Purchase Line";
            DECI: Decimal;
            TIPOUNI: Code[10];
            NALBA: Code[20];
            PurchaseHeader: Record "Purchase Header";
            ImprInfor: Codeunit "Test Report-Print";
            ImprDocu: Codeunit "Document-Print";
            CabCompra: Record "Purchase Header";
            Seleccion: Integer;
            RegCompra: Codeunit "Purch.-Post";
            "PuntLínCompra": Record "Purchase Line";
            "ExistenLíneasPendientes": Boolean;
            Borrado: Boolean;
            LinCompra: Record "Purchase Line";
            Producto: Record Item;
            "<< SSG_DIST_VARS": Boolean;
            tabla_LinCompra: Record "Purchase Line";
            nuevas_unidades: Decimal;
            num_producto: Code[20];
            num_documento: Code[20];
            num_linea: Integer;
            ControlKilos: Decimal;
            Proveedor: Record Vendor;
            "cAlmacén": Code[250];
            Rec2: Record "Purchase Header";
            "tabla_almacén": Record Location;
            ventana: Dialog;
            codigoalmacen: Code[20];
            tabla_conf_exist: Record "Inventory Setup";
            T_InfoEmpresa: Record "Company Information";
            tabla_almacenes: Record Location;
            dFechaCaducidad: Date;
            cExpr1: Code[3];
            ha_ubicado: Boolean;
            P: Record Item;
            KILOSC: Code[10];
            KILOS: Decimal;
            OADAIA: Code[10];
            NOADAIA: Decimal;
            FEC: Code[8];
            CLITIEN: Decimal;
            todocero: Boolean;
            CodeCC: Codeunit "Automaticos Cartas";
            RecCC: Record "Purchase Header";
            Release: Codeunit "Release Purchase Document";
            TIPOPEDI: Code[20];
            CLIENTE: Code[10];
            SalesHeader: Record "Sales Header";
            SalesLine: Record "Sales Line";
            ndocdv: Code[20];
            lin: Integer;
            CODALMA: Code[10];
            DOCLIQ: Code[20];
            RecTL: Record "Transfer Line";
            RecTC: Record "Transfer Header";
            ESTRANSF: Boolean;
            ESPEDIDO: Boolean;
            CodeCV: Codeunit "Automaticos Cartas";
            Rec832: Record "Item Journal Line";
            ESPEPE: Boolean;
            LIN2: Integer;
            RecCV: Record "Sales Header";
        begin

            ///// trrec

            ArchExt:=NombreFichero;
            FICHERO.TextMode(true);
            FICHERO.Open(ArchExt);
            PosInicial := FICHERO.POS;
            FICHERO.Read(Linea);
            repeat
                 if CopyStr(Linea,1,4)='CRCA' then begin
                      POS:=22;
                      if CopyStr(Linea,POS,1)<>'|' then begin
                           repeat
                                NPEDIDO:=NPEDIDO+CopyStr(Linea,POS,1);
                                POS:=POS+1;
                                if CopyStr(Linea,POS,1)='|' then begin
                                     SALE:=true;
                                end;
                           until SALE;
                      end;
                      if  CopyStr(Linea,POS,1)='|' then begin
                      end;
                      POS:=POS+1;
                      SALE:=false;
                      CLIENTE:='';
                      repeat
                           CLIENTE:=CLIENTE+CopyStr(Linea,POS,1);
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      POS:=POS+2;
                      SALE:=false;
                      TIPOPEDI:='';
                      repeat
                           TIPOPEDI:=TIPOPEDI+CopyStr(Linea,POS,1);
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      POS:=POS+1;
                      SALE:=false;
                      DOCLIQ:='';
                      repeat
                           DOCLIQ:=DOCLIQ+CopyStr(Linea,POS,1);
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      POS:=POS+1;
                      D:=Today;
                      if TIPOPEDI='ENPR' then begin
                           ESPEDIDO:=false;
                           ESTRANSF:=true;
                           if PurchaseHeader.Get(1,NPEDIDO) then begin
                                OADAIA:=CopyStr(Linea,9,9);
                                Evaluate(NOADAIA,OADAIA);
                                ESPEDIDO:=true;
                                ESTRANSF:=false;
                                ESPEPE:=false;
                           end;
                           if not PurchaseHeader.Get(1,NPEDIDO) then begin
                                OADAIA:=CopyStr(Linea,9,9);
                                Evaluate(NOADAIA,OADAIA);
                                ESPEDIDO:=true;
                                ESTRANSF:=false;
                                ESPEPE:=true;
                           end;
                           if ESPEDIDO and (not ESPEPE) then begin
                                PurchaseHeader.Validate("Posting Date",D);
                                PurchaseHeader.Validate("Document Date",D);
                                PurchaseHeader.Ship := true;
                                PurchaseHeader.Invoice := false;
                                PurchaseHeader.Modify;
                                PurchaseLine.Reset;
                                PurchaseLine.SetRange("Document Type",1);
                                PurchaseLine.SetRange("Document No.",NPEDIDO);
                                if PurchaseLine.FindFirst then repeat
                                     PurchaseLine.Validate("Qty. to Receive",0);
                                     PurchaseLine.Modify;
                                until PurchaseLine.Next = 0;
                           end;
                           if ESTRANSF then begin
                                RecTL.SetRange(RecTL."Document No.",NPEDIDO);
                                if RecTL.Find('-') then repeat
                                     RecTL.Validate(RecTL."Qty. to Ship",0);
                                     RecTL.Modify;
                                until RecTL.Next = 0;
                           end;
                      end;
                      if TIPOPEDI='DVCL' then begin
                           SalesHeader.Init;
                           SalesHeader."Document Type":=3;
                           SalesHeader."Order Date":=Today;
                           SalesHeader."Posting Date":=Today;
                           SalesHeader."Shipment Date":=Today;
                           SalesHeader."Document Date":=Today;
                           SalesHeader.Validate("Sell-to Customer No.",CLIENTE);
                           SalesHeader."Applies-to Doc. Type":=2;
                           SalesHeader."Applies-to Doc. No.":=DOCLIQ;
                           SalesHeader.Insert(true);
                           ndocdv:=SalesHeader."No.";
                      end;
                 end;
                 SALE:=false;
                 REF:='';
                 CANTI:='';
                 KILOSC:='';
                 TIPOUNI:='';
                 if CopyStr(Linea,1,4)='CRLI' then begin
                      POS:=9;
                      NPEDIDO:='';
                      if CopyStr(Linea,POS,1)<>'|' then begin
                           repeat
                                NPEDIDO:=NPEDIDO+CopyStr(Linea,POS,1);
                                POS:=POS+1;
                                if CopyStr(Linea,POS,1)='|' then begin
                                     SALE:=true;
                                end;
                           until SALE;
                      end;
                      SALE:=false;
                      POS:=POS+1;
                      repeat
                           REF:=REF+CopyStr(Linea,POS,1);
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      SALE:=false;
                      POS:=POS+1;
                      repeat
                           CANTI:=CANTI+CopyStr(Linea,POS,1);
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      SALE:=false;
                      POS:=POS+2;
                      repeat
                           TIPOUNI:=TIPOUNI+CopyStr(Linea,POS,1);
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      SALE:=false;
                      POS:=POS+2;
                      repeat
                           KILOSC:=KILOSC+CopyStr(Linea,POS,1);
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                      KILOS:=0;
                      if KILOSC<>'000000000' then begin
                 ///          EVALUATE(KILOS,KILOSC);
                 ///          KILOS:=KILOS/1000;
                      end;
                      if TIPOPEDI='ENPR' then begin
                           if ESPEDIDO and (not ESPEPE) then begin
                                PurchaseLine.Reset;
                                PurchaseLine.SetRange("Document Type",1);
                                PurchaseLine.SetRange("Document No.",NPEDIDO);
                                PurchaseLine.SetRange("No.",REF);
                                if PurchaseLine.FindFirst then begin
                                     Evaluate(DECI,CANTI);
                                     DECI:=ROUND(DECI/PurchaseLine."Qty. per Unit of Measure",0.01);
                                     PurchaseLine.Validate("Qty. to Receive",DECI);
                                     if KILOS<>0 then begin
                                          P.Get(PurchaseLine."No.");
                                          PurchaseLine."Unit of Measure":=P."Base Unit of Measure";
                                          PurchaseLine.Validate(Quantity,KILOS);
                                     end;
                                     PurchaseLine.Modify;
                                end;
                           end;
                           if ESPEDIDO and (ESPEPE) then begin
                                Evaluate(DECI,CANTI);
                                DECI:=ROUND(DECI/PurchaseLine."Qty. per Unit of Measure",0.01);
                                if DECI<>0 then begin
                                end;
                           end;
                           if ESTRANSF then begin
                                RecTL.SetRange(RecTL."Document No.",NPEDIDO);
                                RecTL.SetRange(RecTL."Item No.",REF);
                                if RecTL.Find('-') then begin
                                     Evaluate(DECI,CANTI);
                                     DECI:=ROUND(DECI/RecTL."Qty. per Unit of Measure",0.01);
                                     RecTL.Validate(RecTL."Qty. to Ship",DECI);
                                     RecTL.Modify;
                                     if KILOS<>0 then begin
                                          P.Get(RecTL."Item No.");
                                          RecTL."Unit of Measure":=P."Base Unit of Measure";
                                          RecTL.Validate(RecTL.Quantity,KILOS);
                                          RecTL.Modify;
                                     end;
                                     PurchaseLine.Modify;
                                end;
                          end;


                 end;
                 if TIPOPEDI='DVCL' then begin
                      SalesLine.Init;
                      SalesLine."Document Type":=3;
                      SalesLine."Document No.":=ndocdv;
                      lin:=lin+10000;
                      SalesLine."Line No.":=lin;
                      SalesLine.Type:=2;
                      SalesLine.Validate("No.",REF);
                      Evaluate(DECI,CANTI);
                      SalesLine.Validate(Quantity,DECI);
                      if KILOS<>0 then begin
                           P.Get(PurchaseLine."No.");
                           SalesLine."Unit of Measure":=P."Base Unit of Measure";
                           SalesLine.Validate(SalesLine.Quantity,KILOS);
                      end;
                      SalesLine.Insert(true);


              end;
            end;

            until FICHERO.Read(Linea) = 0;
            FICHERO.Close;




            if TIPOPEDI='ENPR' then begin
                 if ESPEDIDO and (not ESPEPE) then begin
                      PurchaseHeader.Get(1,NPEDIDO);
                      PurchaseHeader.Receive:=true;
                      PurchaseHeader.Invoice:=false;
                      PurchaseHeader.Modify;
                      Release.Reopen(PurchaseHeader);
                      CodeCC.REGISTRARECEP(PurchaseHeader);
                 end;
                 if ESTRANSF then begin
                      RecTC.Get(NPEDIDO);
                      CodeCV.REGISTRAEXPETRANF(RecTC);
                 end;

            end;

            if TIPOPEDI='DVCL' then begin

                      RecCV.Get(3,ndocdv);
                      CodeCC.REGISTRAEXPEDEV(RecCV);



            end;
        end;


        procedure ImportaTREXP(NombreFichero: Text[250])
        var
            D: Date;
            "DECIAÑO": Integer;
            "Año": Code[10];
            Mes: Decimal;
            Dia: Decimal;
            DOC1: Code[255];
            SALE: Boolean;
            NPEDIDO: Code[20];
            REF: Code[10];
            POS: Decimal;
            CANTI: Code[10];
            LC: Record "Sales Line";
            DECI: Decimal;
            TIPOUNI: Code[10];
            NALBA: Code[20];
            CC: Record "Sales Header";
            ImprInfor: Codeunit "Test Report-Print";
            ImprDocu: Codeunit "Document-Print";
            CabCompra: Record "Sales Header";
            Seleccion: Integer;
            RegCompra: Codeunit "Purch.-Post";
            "PuntLínCompra": Record "Sales Line";
            "ExistenLíneasPendientes": Boolean;
            Borrado: Boolean;
            LinCompra: Record "Sales Line";
            Producto: Record Item;
            "<< SSG_DIST_VARS": Boolean;
            tabla_LinCompra: Record "Sales Line";
            nuevas_unidades: Decimal;
            num_producto: Code[20];
            num_documento: Code[20];
            num_linea: Integer;
            ControlKilos: Decimal;
            Proveedor: Record Vendor;
            "cAlmacén": Code[250];
            Rec2: Record "Sales Header";
            "tabla_almacén": Record Location;
            ventana: Dialog;
            codigoalmacen: Code[20];
            tabla_conf_exist: Record "Inventory Setup";
            T_InfoEmpresa: Record "Company Information";
            tabla_almacenes: Record Location;
            dFechaCaducidad: Date;
            cExpr1: Code[3];
            ha_ubicado: Boolean;
            P: Record Item;
            KILOSC: Code[10];
            KILOS: Decimal;
            OADAIA: Code[10];
            NOADAIA: Decimal;
            FEC: Code[8];
            CLITIEN: Decimal;
            todocero: Boolean;
            CodeCV: Codeunit "Automaticos Cartas";
            RecCV: Record "Sales Header";
            ESPEDIDO: Boolean;
            ESTRANSF: Boolean;
            CLIENTE: Code[10];
            TIPOPEDI: Code[10];
            RecComp: Record "Purchase Header";
            RecCompL: Record "Purchase Line";
            ndocdv: Code[20];
            lin: Integer;
            RecAlma: Record Location;
            CODALMA: Code[10];
            ReleaseSalesDoc: Codeunit "Release Sales Document";
            RESTO: Decimal;
            RecUDM: Record "Item Unit of Measure";
            CUMV: Code[10];
            PORUNMV: Decimal;
            TDIVISION: Decimal;
            CLIN: Code[10];
            RecCV2: Record "Sales Header";
            MESH: Decimal;
            MESDE: Decimal;
            "AÑODE": Decimal;
            PEDIDONAV: Code[20];
            RecSDP: Record "Item Journal Batch";
            Rec83: Record "Item Journal Line";
            RecItem: Record Item;
            cantideci: Decimal;
            Codeunit50010: Codeunit "Automaticos Cartas";
            DOC: Code[20];
            RecCusto: Record Customer;
            RecItem2: Record Item;
            FECHACAD: Code[20];
            NLOTE: Code[20];
            FDIA: Code[2];
            FMES: Code[2];
            "FAÑO": Code[4];
            DDIA: Integer;
            DMES: Integer;
            "DAÑO": Integer;
            FFCAD: Date;
            RecTra: Record "Shipping Agent";
            decre: Decimal;
            REC110: Record "Sales Shipment Header";
            REC111: Record "Sales Shipment Line";
            EXPEDI: Code[20];
            PESO: Decimal;
            CUEXP: Codeunit "Automaticos Cartas";
            Rec36Pepe: Record "Sales Header";
            Rec832: Record "Item Journal Line";
            LIN2: Integer;
            REC36PE: Record "Sales Header";
            NOMFICHERO: Text[100];
            DD: Code[2];
            MM: Code[2];
            AA: Code[2];
            FECHAFEC: Date;
            DDD: Integer;
            DMM: Integer;
            DAA: Integer;
            RecLVSuma: Record "Sales Line";
            Rec1102: Record "Sales Shipment Header";
            FICHERO: File;
            PosInicial: Integer;
            Linea: Text;
            FechaFichero: Code[20];
            LLINEA: Integer;
        begin

            RecSDP.Reset;
            RecSDP.SetRange(RecSDP."Journal Template Name",'ELEMENTO');
            RecSDP.SetRange(RecSDP.Name,'KITS');
            if not RecSDP.FindFirst then begin
                 RecSDP."Journal Template Name":='ELEMENTO';
                 RecSDP.Name:='KITS';
                 RecSDP.Insert;
            end;



            ArchExt:=NombreFichero;
            FICHERO.TextMode(true);
            FICHERO.Open(ArchExt);
            PosInicial := FICHERO.POS;
            FICHERO.Read(Linea);
            repeat
            if CopyStr(Linea,1,4)='CECA' then begin
                 POS:=9;
                 if CopyStr(Linea,POS,1)<>'|' then begin
                      repeat
                           NPEDIDO:=NPEDIDO+CopyStr(Linea,POS,1);
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                 end;
                 if  CopyStr(Linea,POS,1)='|' then begin
                 end;
                 POS:=POS+1;
                 SALE:=false;
                 CLIENTE:='';
                 repeat
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 POS:=POS+1;
                 SALE:=false;
                 CLIENTE:='';
                 repeat
                      CLIENTE:=CLIENTE+CopyStr(Linea,POS,1);
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 POS:=POS+2;
                 SALE:=false;
                 TIPOPEDI:='';
                 repeat
                      TIPOPEDI:=TIPOPEDI+CopyStr(Linea,POS,1);
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;

                 D:=Today;

                 if (TIPOPEDI<>'DVPR') and (TIPOPEDI<>'NORM') then begin
                   if CC.Get(1,NPEDIDO) then begin
                           ESPEDIDO:=true;
                           ESTRANSF:=false;
                           ReleaseSalesDoc.Reopen(CC);
                      end;
                      ESPEDIDO:=true;
                      RecCV.SetCurrentkey(RecCV."Document Type",RecCV."Nº expedición");
                      RecCV.SetRange(RecCV."Document Type",1);
                      RecCV.SetRange(RecCV."Nº expedición",NPEDIDO);
                      if RecCV.FindSet then repeat
                           RecCV."Recibido de adaia":=true;
                           PEDIDONAV:=RecCV."No.";
                           RecCV."Posting Date":=Today;
                           RecCV."Document Date":=Today;
                           RecCV.Validate(RecCV."Posting Date");
                           RecCV.Validate(RecCV."Document Date");
                           if RecCusto.Get(RecCV."Sell-to Customer No.") then begin
                                if RecCusto."Estatus del cliente"=1 then begin
                                     RecCusto."Estatus del cliente":=0;
                                     RecCusto.Modify;
                                end;
                           end;
                           if RecCV."Incrementa bultos"<>0 then begin
                              RecCV."Nº bultos":=RecCV."Nº bultos"+RecCV."Incrementa bultos";
                           end;
                           RecCV.Modify;

                      until RecCV.Next=0;
                      if ESPEDIDO then begin
                           ///CC.VALIDATE(CC."Posting Date",D);
                           ///CC.VALIDATE(CC."Document Date",D);
                           ///CC.MODIFY;
                           LC.SetCurrentkey(LC."Document Type",LC."Nº expedición",LC."Linea Nº expedición");
                           LC.SetRange(LC."Document Type",1);
                           LC.SetRange(LC."Nº expedición",NPEDIDO);
                           if LC.FindSet then repeat
                                LC.Validate(LC."Qty. to Ship",0);
                                if RecItem2.Get(LC."No.") then begin
                                     if RecItem2."Enviar siempre"=true then begin
                                          LC.Validate(LC."Qty. to Ship",LC.Quantity);
                                     end;
                                end;
                                LC.Modify;
                           until LC.Next = 0;
                      end;
                  end;
                  if TIPOPEDI='DVPR' then begin
                      CODALMA:='SILLA';
                      RecComp.Init;
                      RecComp."Document Type":=3;
                      RecComp."Order Date":=Today;
                      RecComp."Posting Date":=Today;
                      RecComp."Document Date":=Today;
                      RecComp.Validate(RecComp."Buy-from Vendor No.",CLIENTE);
                      RecComp.Insert(true);
                      RecComp."Location Code":=CODALMA;
                      RecComp.Modify(true);
                      ndocdv:=RecComp."No.";
                      lin:=10000;
                 end;
                  if TIPOPEDI='NORM' then begin
                      CODALMA:='SILLA';
                 end;

            end;
            SALE:=false;
            REF:='';
            CANTI:='';
            KILOSC:='';
            TIPOUNI:='';
            CLIN:='';

            if CopyStr(Linea,1,4)='CELI' then begin
                 POS:=9;
                 NPEDIDO:='';
                 if CopyStr(Linea,POS,1)<>'|' then begin
                      repeat
                           NPEDIDO:=NPEDIDO+CopyStr(Linea,POS,1);
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                 end;
                 SALE:=false;
                 POS:=POS+1;
                 repeat
                      CLIN:=CLIN+CopyStr(Linea,POS,1);
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 Evaluate(LLINEA,CLIN);
                 SALE:=false;
                 POS:=POS+1;
                 repeat
                      REF:=REF+CopyStr(Linea,POS,1);
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='-' then begin
                           SALE:=true;
                           POS:=POS+3;
                      end;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 SALE:=false;
                 POS:=POS+2;
                 repeat
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 SALE:=false;
                 POS:=POS+2;
                 repeat
                      CANTI:=CANTI+CopyStr(Linea,POS,1);
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 SALE:=false;
                 POS:=POS+1;
                 repeat
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 SALE:=false;
                 POS:=POS+1;
            ///     REPEAT
            ///          KILOSC:=KILOSC+COPYSTR(Linea,POS,1);
            ///          POS:=POS+1;
            ///          IF COPYSTR(Linea,POS,1)='|' THEN BEGIN
            ///               SALE:=TRUE;
            ///          END;
            ///     UNTIL SALE;
                 KILOS:=0;

            if TIPOPEDI<>'DVPR' then begin
                 if ESPEDIDO then begin
                      LC.SetRange(LC."Document Type",1);
                      LC.SetRange(LC."Nº expedición",NPEDIDO);
                      LC.SetRange(LC."Linea Nº expedición",LLINEA);
                      LC.SetRange(LC."No.",REF);
                      if LC.Find('-') then begin
                           LC.CalcFields(LC."Suma cdad. por envio");

                           if LC."Suma cdad. por envio"=LC."Outstanding Quantity" then begin
                                Evaluate(DECI,CANTI);
                                if KILOS=0 then begin
                                     DECI:=DECI/LC."Qty. per Unit of Measure";
                                     LC.Validate(LC."Qty. to Ship",DECI);
                                end;
                                LC.Modify;
                           end;
                           if LC."Suma cdad. por envio">LC."Outstanding Quantity" then begin

                                Evaluate(DECI,CANTI);
                                DECI:=DECI/LC."Qty. per Unit of Measure";
                                RecLVSuma.Reset;
                                RecLVSuma.SetCurrentkey(RecLVSuma."Nº expedición",RecLVSuma."No.");
                                RecLVSuma.SetRange(RecLVSuma."Nº expedición",NPEDIDO);
                                RecLVSuma.SetRange(RecLVSuma."No.",REF);
                                RecLVSuma.SetRange(RecLVSuma."Linea Nº expedición",LLINEA);
                                if RecLVSuma.FindFirst then repeat
                                     if RecLVSuma."Outstanding Quantity"<=DECI then begin
                                          if RecLVSuma."Document No."<>LC."Document No." then begin
                                               if CC.Get(1,RecLVSuma."Document No.") then begin
                                                    ReleaseSalesDoc.Reopen(CC);
                                               end;
                                          end;
                                          RecLVSuma.Validate(RecLVSuma."Qty. to Ship",RecLVSuma."Outstanding Quantity");
                                          RecLVSuma.Modify;
                                          DECI:=DECI-RecLVSuma."Outstanding Quantity";
                                     end else begin
                                          if DECI>0 then begin
                                               if RecLVSuma."Document No."<>LC."Document No." then begin
                                                    if CC.Get(1,RecLVSuma."Document No.") then begin
                                                         ReleaseSalesDoc.Reopen(CC);
                                                    end;
                                               end;
                                               RecLVSuma.Validate(RecLVSuma."Qty. to Ship",DECI);
                                               RecLVSuma.Modify;
                                               DECI:=0;
                                          end;

                                     end;
                                until RecLVSuma.Next=0;
                           end;
                      end;
            /////          grabapepe;


                      if REF='10' then begin
                           Evaluate(DECI,CANTI);
                           RecCV2.Reset;
                           RecCV2.SetCurrentkey(RecCV2."Document Type",RecCV2."Nº expedición");
                           RecCV2.SetRange(RecCV2."Document Type",1);
                           RecCV2.SetRange(RecCV2."Nº expedición",NPEDIDO);
                           if RecCV2.FindSet then begin
                                RecCV2.Validate(RecCV2."Nº bultos",DECI);
                                if RecCV2."Incrementa bultos"<>0 then begin
                                    RecCV2.Validate(RecCV2."Nº bultos",RecCV2."Nº bultos"+RecCV."Incrementa bultos");
                                end;
                                RecCV2.Modify;
                           end;


                      end;
                      if REF='11' then begin
                           Evaluate(DECI,CANTI);
                           RecCV2.Reset;
                           RecCV2.SetCurrentkey(RecCV2."Document Type",RecCV2."Nº expedición");
                           RecCV2.SetRange(RecCV2."Document Type",1);
                           RecCV2.SetRange(RecCV2."Nº expedición",NPEDIDO);
                           if RecCV2.FindSet then begin
                                RecCV2.Validate(RecCV2."Nº Palets",DECI);
                                RecCV2.Modify;
                           end;
                      end;
                      if REF='15' then begin
                           POS:=1;
                           repeat
                                POS:=POS+1;
                                if (CopyStr(CANTI,POS,1)='0') or
                                   (CopyStr(CANTI,POS,1)='1') or
                                   (CopyStr(CANTI,POS,1)='2') or
                                   (CopyStr(CANTI,POS,1)='3') or
                                   (CopyStr(CANTI,POS,1)='4') or
                                   (CopyStr(CANTI,POS,1)='5') or
                                   (CopyStr(CANTI,POS,1)='6') or
                                   (CopyStr(CANTI,POS,1)='7') or
                                   (CopyStr(CANTI,POS,1)='8') or
                                   (CopyStr(CANTI,POS,1)='9') then begin
                                     SALE:=true;
                                end;
                           until SALE;
                           CANTI:=CopyStr(CANTI,POS);

                           RecCV2.Reset;
                           RecCV2.SetCurrentkey(RecCV2."Document Type",RecCV2."Nº expedición");
                           RecCV2.SetRange(RecCV2."Document Type",1);
                           RecCV2.SetRange(RecCV2."Nº expedición",NPEDIDO);
                           if RecCV2.FindSet then begin
                                RecCV2.Preparador:=CANTI;
                                RecCV2.Modify;
                           end;
                      end;


                      if REF='12' then begin
                           Evaluate(DECI,CANTI);
                           RecCV2.Reset;
                           RecCV2.SetCurrentkey(RecCV2."Document Type",RecCV2."Nº expedición");
                           RecCV2.SetRange(RecCV2."Document Type",1);
                           RecCV2.SetRange(RecCV2."Nº expedición",NPEDIDO);
                           if RecCV2.FindSet then begin
                                decre:=1;
                                if RecTra.Get(RecCV2."Shipping Agent Code") then begin
                                     if RecTra."Decremento kilo"<>0 then begin
                                          decre:=(100-RecTra."Decremento kilo")/100;
                                     end;
                                end;
                                RecCV2."Total peso":=ROUND(DECI*decre,1);
                                RecCV2.Modify;
                           end;
                      end;
                      if REF='13' then begin
                           Evaluate(DECI,CANTI);
                           RecCV2.Reset;
                           RecCV2.SetCurrentkey(RecCV2."Document Type",RecCV2."Nº expedición");
                           RecCV2.SetRange(RecCV2."Document Type",1);
                           RecCV2.SetRange(RecCV2."Nº expedición",NPEDIDO);
                           if RecCV2.FindSet then begin
                                if DECI=1 then begin
                                     RecCV2."Shipping Agent Code":='DHL';
                                     RecCV2.Modify;
                                end;
                                if DECI=3 then begin
                                     RecCV2."Shipping Agent Code":='TIPSA';
                                     RecCV2.Modify;
                                end;
                                if DECI=2 then begin
                                     RecCV2."Shipping Agent Code":='SEUR';
                                     RecCV2.Modify;
                                end;
                           end;
                      end;

                 end;



            end;
            end;


            if CopyStr(Linea,1,4)='CECN' then begin
                 POS:=9;
                 DOC:='';
                 if CopyStr(Linea,POS,1)<>'|' then begin
                      repeat
                           DOC:=DOC+CopyStr(Linea,POS,1);
                           POS:=POS+1;
                           if CopyStr(Linea,POS,1)='|' then begin
                                SALE:=true;
                           end;
                      until SALE;
                 end;
                 SALE:=false;
                 POS:=POS+1;
                 repeat
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 SALE:=false;
                 POS:=POS+1;
                 repeat
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 SALE:=false;
                 POS:=POS+2;
                  REF:='';
                 repeat
                      REF:=REF+CopyStr(Linea,POS,1);
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 SALE:=false;
                 POS:=POS+3;
                 CANTI:='';
                 repeat
                      CANTI:=CANTI+CopyStr(Linea,POS,1);

                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
            ///     ERROR('%1 %2',REF,CANTI);
                 POS:=POS+1;
                 repeat
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 SALE:=false;
                 POS:=POS+1;
                 repeat
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 SALE:=false;
                 POS:=POS+1;
                 repeat
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 SALE:=false;
                 POS:=POS+1;
                 repeat
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 SALE:=false;
                 /////
                 POS:=POS+1;
                 FECHACAD:='';
                 repeat
                      FECHACAD:=FECHACAD+CopyStr(Linea,POS,1);
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 POS:=POS+1;
                 SALE:=false;
                 repeat
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 POS:=POS+1;
                 SALE:=false;
                 repeat
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 POS:=POS+1;
                 repeat
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 /////
                 SALE:=false;
                 NLOTE:='';
                 repeat
                      NLOTE:=NLOTE+CopyStr(Linea,POS,1);
                      POS:=POS+1;
                      if CopyStr(Linea,POS,1)='|' then begin
                           SALE:=true;
                      end;
                 until SALE;
                 if RecItem.Get(REF) then begin
                      if RecItem."Criterio rotación"=0 then begin
                           if FECHACAD<>'|' then begin
                           FAÑO:=CopyStr(FECHACAD,1,4);
                           Evaluate(DAÑO,FAÑO);
                           FMES:=CopyStr(FECHACAD,6,2);
                           Evaluate(DMES,FMES);
                           FDIA:=CopyStr(FECHACAD,9,2);
                           Evaluate(DDIA,FDIA);
                           FFCAD:=Dmy2date(DDIA,DMES,DAÑO);
                           LC.Reset;
                           LC.SetCurrentkey("Document Type","Nº expedición");
                           LC.SetRange(LC."Document Type",1);
                           LC.SetRange(LC."Nº expedición",NPEDIDO);
                           LC.SetRange(LC."No.",REF);
                           if LC.Find('-') then begin
                                LC."Nº lote":=NLOTE;
                                LC."Fecha caducidad":=FFCAD;
                                LC.Modify;
                           end;
                           end;
                      end;
                 end;

            end;

            until FICHERO.Read(Linea) = 0;
            FICHERO.Close;


            /*

            IF  CLIENTE='HAGEN01' THEN BEGIN
                 lin:=10000;
                 Rec83.RESET;
                 Rec83.SETRANGE(Rec83."Journal Template Name",'ELEMENTO');
                 Rec83.SETRANGE(Rec83."Journal Batch Name",'KITS');
                 IF Rec83.FINDLAST THEN BEGIN
                      lin:=Rec83."Line No."+10000;
                 END;
                 RecItem.GET(REF);
                 EVALUATE(cantideci,CANTI);
                  Rec83."Journal Template Name":='ELEMENTO';
                  Rec83."Journal Batch Name":='KITS';
                  Rec83."Line No.":=lin;
                  Rec83.VALIDATE(Rec83."Item No.",REF);
                  Rec83."Posting Date":=TODAY;
                  Rec83.VALIDATE(Rec83."Entry Type",3);
                  Rec83.VALIDATE(Rec83.Quantity,cantideci);
                  Rec83."Document No.":='KIT:'+FORMAT(DOC,16);
                  Rec83."Location Code":='SILLA';
                  Rec83.INSERT;
            END;

            ///////7



            if (TIPOPEDI<>'DVPR') and (TIPOPEDI<>'NORM') then begin
                 if ESPEDIDO then begin
                      ///RecCV.GET(1,PEDIDONAV);
                      ///ReleaseSalesDoc.RUN(RecCV);
                      ///CodeCV.REGISTRAEXPE(RecCV);

                      RecCV.Reset;
                      RecCV.SetCurrentkey(RecCV."Document Type",RecCV."Nº expedición");
                      RecCV.SetRange(RecCV."Document Type",1);
                      RecCV.SetRange(RecCV."Nº expedición",NPEDIDO);
                      if RecCV.FindFirst then repeat
                           Clear(ReleaseSalesDoc);
                           Clear(CodeCV);
                           ReleaseSalesDoc.Run(RecCV);
                           CodeCV.REGISTRAEXPE(RecCV);
                      until RecCV.Next=0;
                      ///

                      enviar:=true;
                      EXPEDI:=NPEDIDO;
                      REC110.SetCurrentkey(REC110."Nº expedición");
                      REC110.SetFilter(REC110."Nº expedición",NPEDIDO+'*');
                      if REC110.FindSet then repeat
                        if REC110.Dropshipping=false then begin
                            if REC110."Albaran sin detalle"=true then begin
                                if REC110."No. Printed"=0 then begin
                                    enviar:=false;
                                end;
                            end;
                        end;
                    until REC110.Next=0;




            if enviar then begin



                           EXPEDI:=NPEDIDO;
                           REC110.Reset;
                           REC110.SetCurrentkey(REC110."Nº expedición");
                           REC110.SetFilter(REC110."Nº expedición",NPEDIDO+'*');
                           if REC110.FindFirst then repeat
                                NALBARAN:=REC110."No.";
                                Rec1102.Reset;
                                Rec1102.SetRange(Rec1102."No.",REC110."No.");
                                if Rec1102.FindFirst then repeat
                                     if Rec1102."Nº Palets"=0 then begin
                                          if RecTra.Get(Rec1102."Shipping Agent Code") then begin
                                               if RecTra."Fichero estandar"=true then begin
                                                    CUEXP.ETISTD(Rec1102);
                                               end;
                                               if RecTra."Fichero estandar"=false then begin
                                                    ///IF Rec1102."Shipping Agent Code"='DHL' THEN BEGIN
                                                         ///CUEXP.EtiDHL2NUEVA(Rec1102);
                                                    //END;
                                                    if Rec1102."Shipping Agent Code"='TIPSA' then begin
                                                         CUEXP.Etitipsa2NUEVA(Rec1102);
                                                    end;
                                                    if Rec1102."Shipping Agent Code"='CORR' then begin
                                                         CUEXP.EtiCORRa2NUEVA(Rec1102);
                                                    end;
                                                    if Rec1102."Shipping Agent Code"='CRON' then begin
                                                         CUEXP.EtiCRON2NUEVA(Rec1102);
                                                    end;
                                                    if Rec1102."Shipping Agent Code"='SEUR' then begin
                                                         CUEXP.EtiSEURNUEVA(Rec1102);
                                                    end;
                                                    if Rec1102."Shipping Agent Code"='TNT' then begin
                                                         ///CUEXP.EtiTNT2NUEVA(Rec1102);
                                                         CUEXP.EtiTNT2(Rec1102);
                                                    end;
                                               end;
                                               if Rec1102."Shipping Agent Code"='ECI' then begin
                                              ///     CUEXP.ETIECI(Rec1102);
                                               end;
                                          end;
                                     end;
                                     if Rec1102."Bill-to Customer No."='6445' then begin
                                          ///REPORT.RUNMODAL(50035,FALSE,FALSE,Rec1102);
                                          ///REPORT.RUNMODAL(50039,FALSE,FALSE,Rec1102);
                                     end;
                                until Rec1102.Next=0;
                                if Rec1102."Bill-to Customer No."='10925' then begin
                                     ficehrocovaldroper;
                                end;
                                if Customer.Get(REC110."Sell-to Customer No.") then begin
                                    if Customer."Enviar etiqueta grande" then begin
                                        Report.RunModal(50039,false,false,REC110);
                                    end;
                                end;
                           until REC110.Next=0;






                           ///// etiqueta edi

                           Rec112.Reset;
                           Rec112.SetCurrentkey(Rec112."Nº expedición");
                           Rec112.SetFilter(Rec112."Nº expedición",NPEDIDO+'*');
                           if Rec112.FindFirst then begin
                                if Rec112."Nº bultos"=1 then begin
                                     Rec113.Reset;
                                     Rec113.SetRange("Document No.",Rec112."No.");
                                     Rec113.SetRange(Type,Rec113.Type::Item);
                                     if Rec113.FindFirst then repeat
                                          CabCompra.Init;
                                          Cajasporenvio.Nfac:=Rec113."Document No.";
                                          Cajasporenvio.nlin:=Rec113."Line No.";
                                          Cajasporenvio.Producto:=Rec113."No.";
                                          Cajasporenvio."Caja num":=1;
                                          Cajasporenvio.Cantidad:=Rec113.Quantity;
                                          Cajasporenvio."nº expedicion":=NPEDIDO;
                                          if Cajasporenvio.Insert then;
                                          Rec113."Cantidad caja":=1;
                                          Rec113.Modify;
                                     until Rec113.Next=0;
                                     Cajasporenvio.Reset;
                                     Cajasporenvio.SetRange(Nfac,Rec112."No.");
                                     if Cajasporenvio.FindFirst then repeat
                                          Cajasporenvio.CreaSSCC;
                                          Cajasporenvio.Modify;
                                     until Cajasporenvio.Next=0;
                                     SalesShipmentHeader.Reset;
                                     SalesShipmentHeader.SetRange("Nº expedición",Rec112."Nº expedición");
                                     if SalesShipmentHeader.FindFirst then begin
                                          SalesShipmentHeader2.Reset;
                                          SalesShipmentHeader2.SetRange("No.",SalesShipmentHeader."No.");
                                          if SalesShipmentHeader2.FindFirst then begin
                                               ///CLEAR(EtiquetaECINUEVAALB);
                                               ///EtiquetaECINUEVAALB.Pasadatos(Cajasporenvio."Caja num",Rec113."Cantidad caja",Cajasporenvio.SSCC);
                                               ///EtiquetaECINUEVAALB.SETTABLEVIEW(SalesShipmentHeader2);
                                               ///EtiquetaECINUEVAALB.RUNMODAL;
                                               //// REPORT.RUN(50105,FALSE,FALSE,SalesShipmentHeader2);
                                           end;
                                      end;




                                end;
                           end;





                      ///
                 end;
            end;

            end;


            /*

            IF TIPOPEDI='NORM' THEN BEGIN

             Codeunit50010.REGISTRAkits(Rec83);

            END;
            IF TIPOPEDI='DVPR' THEN BEGIN

            ///          RecComp.GET(3,ndocdv);
            ///          CodeCV.REGISTRARECEPDEV(RecComp);

            END;




        local procedure ficehrocovaldroper()
        begin


            SalesShipmentHeader.Get(NALBARAN);
              Customer.Get(SalesShipmentHeader."Sell-to Customer No.");

            nomdir:='\\192.168.0.225\compartido\Covaldroper\respuestas_mayoristas\';


            ///// numpedi:=COPYSTR(SalesShipmentHeader."Your Reference",STRLEN(SalesShipmentHeader."Your Reference")-5,6);

            suref:=CopyStr(SalesShipmentHeader."Your Reference",1,10);
            numpedi:=CopyStr(suref,StrLen(suref)-5,6);

                           ArchExt:=nomdir+'albventa'+numpedi+'_'+Customer."Codigo cliente externo"+'.txt';



                  AA := Date2dmy(SalesShipmentHeader."Posting Date",3);
                  MM := Date2dmy(SalesShipmentHeader."Posting Date",2);
                  DD := Date2dmy(SalesShipmentHeader."Posting Date",1);
                  M1 := Format(MM);
                  D1 := Format(DD);

                  if D1='0' then D1:='00';
                  if D1='1' then D1:='01';
                  if D1='2' then D1:='02';
                  if D1='3' then D1:='03';
                  if D1='4' then D1:='04';
                  if D1='5' then D1:='05';
                  if D1='6' then D1:='06';
                  if D1='7' then D1:='07';
                  if D1='8' then D1:='08';
                  if D1='9' then D1:='09';

                  if M1='0' then M1:='00';
                  if M1='1' then M1:='01';
                  if M1='2' then M1:='02';
                  if M1='3' then M1:='03';
                  if M1='4' then M1:='04';
                  if M1='5' then M1:='05';
                  if M1='6' then M1:='06';
                  if M1='7' then M1:='07';
                  if M1='8' then M1:='08';
                  if M1='9' then M1:='09';

            LAFECHA:=D1+M1+Format(AA);

            SalesShipmentLine.Reset;
            SalesShipmentLine.SetRange(SalesShipmentLine."Document No.",NALBARAN);
            if SalesShipmentLine.FindFirst then repeat
                 if SalesShipmentLine.Quantity<>0 then begin

                      TextoSalida:=Format(suref)+';'+
                                            Format(SalesShipmentLine."Linea pedido externo")+';_HG0-'+Format(SalesShipmentLine."No.")+';'+
                                            Format(SalesShipmentLine.Quantity)+';'+
                                            Format(SalesShipmentLine."Your Reference 2")+';'+
                                            Format(LAFECHA);


            end;
                 until SalesShipmentLine.Next = 0;
        end;

        */



}
