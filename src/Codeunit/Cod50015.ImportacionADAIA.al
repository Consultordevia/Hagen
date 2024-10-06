#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50015 "Importacion ADAIA"
{

    trigger OnRun()
    var
        FicherosHagen: Codeunit FicherosHagen;
        Tipo: enum Ficherets;
        adaia: Record adaia;
    begin



        RecCP.Get;
        nomdir := RecCP."Ruta salida a_gestion";
        RUTACOPIA := RecCP."Ruta salida a_gestion copia";
        ruta2 := RecCP."Ruta salida de_gestion";
        Commit;


        ADAIA.Reset();
        ADAIA.SetRange(texto, 'ADAIA-IMPORTACION TRSTOMOV');
        IF ADAIA.FindSet() THEN begin
            nomdir := ADAIA.Ruta;
            RUTACOPIA := ADAIA.Ruta + 'copia/';
        end;
        Commit;
        tipo := Tipo::TRSTOMOV;
        FicherosHagen.LeerArchivosCarpeta(nomdir, RUTACOPIA, Tipo)


        /*
        
WORKDATED:=WORKDATE;
FechaFichero:= FORMAT(WORKDATED);



RecMT.RESET;
RecMT.SETRANGE(RecMT.Tabla,17);
IF RecMT.FINDFIRST THEN REPEAT
     RecMT.DELETE;
UNTIL RecMT.NEXT=0;




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







{
Enabled	SourceExpr	StartPos	Width
Yes	UNO	0	0
Yes	DOS	0	0
Yes	UBICA	0	0
Yes	PROD	0	0
Yes	CANTI	0	0
Yes	UNO	0	0
Yes	UNO	0	0
Yes	UNO	0	0
Yes	fc	0	0
Yes	UNO	0	0
Yes	UNO	0	0
Yes	codlote	0	0
Yes	UNO	0	0
Yes	UNO	0	0
Yes	UNO	0	0
Yes	UNO	0	0
Yes	UNO	0	0
Yes	UNO	0	0
Yes	UNO	0	0
}

///// 12345678
///// STSI|MO|010A00101|S7927|000000008|UD|00000001|000000000||20100924|||OK|010A00101||EU|||E130|

ArchExt:=NombreFichero;
FICHERO.TEXTMODE(TRUE);
FICHERO.OPEN(ArchExt);
PosInicial := FICHERO.POS;
FICHERO.READ(Linea);
REPEAT
     IF COPYSTR(Linea,1,4)='STSI' THEN BEGIN
          POS:=9;
          SALE:=FALSE;
          UBICA:='';
          REPEAT
               UBICA:=UBICA+COPYSTR(Linea,POS,1);
               POS:=POS+1;
               IF COPYSTR(Linea,POS,1)='|' THEN BEGIN
                    SALE:=TRUE;
               END;
          UNTIL SALE;
          ///// STSI|MO|010A00101|S7927|000000008|UD|00000001|000000000||20100924|||OK|010A00101||EU|||E130|

          POS:=POS+1;      
          SALE:=FALSE;     
          REF:='';
          REPEAT
               IF (COPYSTR(Linea,POS,1)='-') THEN BEGIN
               SALE:=TRUE;POS:=POS+4;
               END;
               IF NOT SALE THEN BEGIN
                    REF:=REF+COPYSTR(Linea,POS,1);
                    POS:=POS+1;
                    IF (COPYSTR(Linea,POS,1)='|') THEN BEGIN
                         SALE:=TRUE;
                    END;
               END;
          UNTIL SALE;
          ///// STSI|MO|010A00101|S7927|000000008|UD|00000001|000000000||20100924|||OK|010A00101||EU|||E130|
          POS:=POS+1;      
          SALE:=FALSE;     
          CANTI:='';
          REPEAT
               CANTI:=CANTI+COPYSTR(Linea,POS,1);
               POS:=POS+1;
               IF COPYSTR(Linea,POS,1)='|' THEN BEGIN
                    SALE:=TRUE;
               END;
          UNTIL SALE;
          EVALUATE(DCanti,CANTI);                              
          ///// STSI|MO|010A00101|S7927|000000008
          SALE:=FALSE;      
          REPEAT                
               POS:=POS+1;
               IF COPYSTR(Linea,POS,1)='|' THEN BEGIN
                    SALE:=TRUE;
               END;
          UNTIL SALE;
          ///// STSI|MO|010A00101|S7927|000000008|UD
          SALE:=FALSE;      
          REPEAT                
               POS:=POS+1;
               IF COPYSTR(Linea,POS,1)='|' THEN BEGIN
                    SALE:=TRUE;
               END;
          UNTIL SALE;
          ///// STSI|MO|010A00101|S7927|000000008|UD|00000001
          SALE:=FALSE;      
          REPEAT                
               POS:=POS+1;
               IF COPYSTR(Linea,POS,1)='|' THEN BEGIN
                    SALE:=TRUE;
               END;
          UNTIL SALE;
          ///// STSI|MO|010A00101|S7927|000000008|UD|00000001|000000000||20100924|||OK|010A00101||EU|||E130|
          SALE:=FALSE;                
          FC:='';
          POS:=POS+1;
          REPEAT
           IF COPYSTR(Linea,POS,1)<>'|' THEN BEGIN
               FC:=FC+COPYSTR(Linea,POS,1);
               END;
               POS:=POS+1;
               IF COPYSTR(Linea,POS,1)='|' THEN BEGIN
                    SALE:=TRUE;
               END;
          UNTIL SALE;
          SALE:=FALSE;      
          REPEAT                
               POS:=POS+1;
               IF COPYSTR(Linea,POS,1)='|' THEN BEGIN
                    SALE:=TRUE;
               END;
          UNTIL SALE;
           SALE:=FALSE;      
          REPEAT                
               POS:=POS+1;
               IF COPYSTR(Linea,POS,1)='|' THEN BEGIN
                    SALE:=TRUE;
               END;
          UNTIL SALE;
          SALE:=FALSE;      
          REPEAT                
               POS:=POS+1;
               IF COPYSTR(Linea,POS,1)='|' THEN BEGIN
                    SALE:=TRUE;
               END;
          UNTIL SALE;
          SALE:=FALSE;      
          REPEAT                
               POS:=POS+1;
               IF COPYSTR(Linea,POS,1)='|' THEN BEGIN
                    SALE:=TRUE;
               END;
          UNTIL SALE;
          SALE:=FALSE;
          POS:=POS+1;
          codlote:='';
          REPEAT
               codlote:=codlote+COPYSTR(Linea,POS,1);
               POS:=POS+1;
               IF COPYSTR(Linea,POS,1)='|' THEN BEGIN
                    SALE:=TRUE;
               END;
          UNTIL SALE;
          
          IF FC<>'' THEN BEGIN
           IF FC<>'|' THEN BEGIN
              a1:=COPYSTR(FC,1,4);
              m1:=COPYSTR(FC,5,2);
              d1:=COPYSTR(FC,7,2);
              EVALUATE(a2,a1);
              EVALUATE(m2,m1);
              EVALUATE(d2,d1);
              fechacadu:=DMY2DATE(d2,m2,a2);
          END;
          END;
          IF RecItem2.GET(REF) THEN BEGIN
              conta:=conta+1;
              RecMT.INIT;
              RecMT.Tabla:=17;
              RecMT.Código:=FORMAT(conta);
              RecMT.Producto:=REF;
              RecMT.Ubicacion:=UBICA;
              RecMT.Cantidad:=DCanti;
              RecMT."Fecha caducidad":=fechacadu;
              RecMT.Lote:=codlote;
              RecMT.INSERT;
          END;
      END;
       IF Item.GET(REF) THEN BEGIN
        IF Item.Blocked=FALSE THEN BEGIN      
          ItemUnitofMeasure.RESET;
          ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure."Item No.",REF);
          ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure.Code,'UDS');
          IF NOT ItemUnitofMeasure.FINDFIRST THEN BEGIN          
               ItemUnitofMeasure.INIT;
               ItemUnitofMeasure."Item No.":=REF;
               ItemUnitofMeasure.Code:='UDS';
               ItemUnitofMeasure."Qty. per Unit of Measure":=1;
               ItemUnitofMeasure.INSERT;
          END;
          Rec83.RESET;
          Rec83.SETRANGE(Rec83."Journal Template Name",'INVENT. FÍ');
          Rec83.SETRANGE(Rec83."Journal Batch Name",FechaFichero);
          Rec83.SETRANGE(Rec83."Item No.",REF);
          IF Rec83.FINDFIRST THEN BEGIN
               Rec83.VALIDATE(Rec83."Qty. (Phys. Inventory)",Rec83."Qty. (Phys. Inventory)"+DCanti);
               Rec83.MODIFY;
               COMMIT;
          END;
      END;
     END;

UNTIL FICHERO.READ(Linea) = 0;
FICHERO.CLOSE;


RecSDP.RESET;                                   
RecSDP.SETRANGE(RecSDP."Journal Template Name",'INVENT. FÍ');
RecSDP.SETRANGE(RecSDP.Name,FechaFichero);
IF RecSDP.FINDFIRST THEN BEGIN      
     Rec83.RESET;
     Rec83.SETRANGE(Rec83."Journal Template Name",RecSDP."Journal Template Name");
     Rec83.SETRANGE(Rec83."Journal Batch Name",RecSDP.Name);
     IF Rec83.FIND('-') THEN REPEAT
          IF Rec83.Quantity=0 THEN BEGIN
               Rec83.DELETE;
          END;
     UNTIL Rec83.NEXT=0;
END;


        */





        /*
                            if CopyStr(NOM,1,8)='TRSTOMOV' then begin
                                 Clear(ImportaADAIA);
                                 ImportaADAIA.ImportaTRSTOMOV(nomfich);
                                 FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                 FILE.Erase(nomfich);
                                 Rec83.Reset;
                                 Rec83.SetRange(Rec83."Journal Template Name",'ELEMENTO');
                                 Rec83.SetRange(Rec83."Journal Batch Name",'ADAIA');
                                 if Rec83.FindFirst then begin
                                      CURegMov.Run(Rec83);
                                 end;
                            end;
                            if CopyStr(NOM,1,9)='TRUNITCON' then begin
                                 FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                 FILE.Erase(nomfich);
                            end;
                            if CopyStr(NOM,1,6)='TRAREA' then begin
                                 FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                 FILE.Erase(nomfich);
                            end;
                            if CopyStr(NOM,1,8)='TRSTOART' then begin
                                 Clear(ImportaADAIA);
                                 ImportaADAIA.ImportaTRSTOART(nomfich);
                                 FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                 FILE.Erase(nomfich);
                            end;
                            if CopyStr(NOM,1,6)='TRSTO.' then begin
                                 Clear(ImportaADAIA);
                                 ImportaADAIA.ImportaTRSTO(nomfich);
                                 FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                 FILE.Erase(nomfich);
                            end;
                            if CopyStr(NOM,1,5)='TRREC' then begin
                                 Clear(ImportaADAIA);
                                 ImportaADAIA.ImportaTRREC(nomfich);
                                 FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                 FILE.Erase(nomfich);
                            end;
        
        
                            if CopyStr(NOM,1,5)='TREXP' then begin
                                 Clear(ImportaADAIA);
                                 ImportaADAIA.ImportaTREXP(nomfich);
                                 ///JobQueueLogEntry.RESET;
                                 ///JobQueueLogEntry.SETRANGE("Object ID to Run",50015);
                                 ///IF JobQueueLogEntry.FINDLAST THEN BEGIN
                                 ///IF JobQueueLogEntry.Status=JobQueueLogEntry.Status::Success THEN BEGIN
                                      FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                      FILE.Erase(nomfich);
                                 //END;
                                 //END;
        
                            end;
        
                            Commit;
                       end;
                  end;
             */




    end;

    var
        varXmlFile: File;
        varInputStream: InStream;
        NombreFichero: Code[200];
        lon1: Decimal;
        NOMFIC: Code[200];
        QUETIENDAES: Code[10];
        QUETIENDAESNAVISION: Code[10];
        NOMBRE: Code[20];
        SAL: Boolean;
        NOM: Text[200];
        NOM2: Text[200];
        Tienedolar: Boolean;
        nomfich: Code[200];
        fichero: File;
        VENTANA: Dialog;
        X: Decimal;
        SALEDOLAR: Boolean;
        lonfic: Decimal;
        SALE: Boolean;
        EXTEN: Code[3];
        HORA: Time;
        DESDEHORA: Time;
        HASTAHORA: Time;
        NuevaExtension: Code[10];
        nomdir: Text[200];
        nomdir2: Text[200];
        nomdirPlani: Text[200];
        nomdir2Plani: Text[200];
        ExtensionFPlani: Code[10];
        NuevaExtensionFPlani: Code[10];
        lanzado: Boolean;
        RecCP: Record "Inventory Setup";
        ExtensionF: Code[10];
        NuevaExtensionF: Code[10];
        TxtFecha: Code[10];
        texto: Code[80];
        RUTACOPIA: Text[80];
        Rec83: Record "Item Journal Line";
        Codeunit50010: Codeunit "Automaticos Cartas";
        ruta2: Text[255];
        VENTANA2: Dialog;
        ArchSalida: File;
        ArchExt: Text[250];
        TextoSalida: Text[250];
        TextoSalida2: Text[250];
        TextoSalida3: Text[250];
        DESDEFECHA: Date;
        CANO: Integer;
        Rec1: Record "Sales Invoice Header";
        Rec2: Record "Sales Invoice Line";
        Rec3: Record "Sales Cr.Memo Header";
        Rec4: Record "Sales Cr.Memo Line";
        TRIMESTRE: Code[10];
        Semana: Decimal;
        MES: Decimal;
        ANO: Decimal;
        codemesano: Code[10];
        RecClie: Record Customer;
        RecItem: Record Item;
        RecCE: Record "Inventory Setup";
        RecUser: Record "User Setup";
        codacti: Code[20];
        RecCV: Record "Sales Header";
        SalesSetup: Record "Sales & Receivables Setup";
        Rec832: Record "Item Journal Line";
        RecLV: Record "Sales Line";
        LIN2: Integer;
        npedi: Code[20];
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        CodeCV: Codeunit "Automaticos Cartas";
        TIENE: Boolean;
        /////-DATAIMPLEUTEROM: XmlPort UnknownXmlPort50127;
        /////-DATAIMPLEUTEREXP: XmlPort UnknownXmlPort50008;
        /////-DATAIMPLEUTERSTOART: XmlPort UnknownXmlPort50005;
        ImportaADAIA: Codeunit "Conecta ADAIA";
        CURegMov: Codeunit "Item Jnl.-Post Batch";
        /////-ImportacionPEDIDOSKIWOKO2: XmlPort UnknownXmlPort50022;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        /////-ImportacionPEDIDOSAMAZON: XmlPort UnknownXmlPort50023;
        JobQueueLogEntry: Record "Job Queue Log Entry";
        v: Dialog;



}

