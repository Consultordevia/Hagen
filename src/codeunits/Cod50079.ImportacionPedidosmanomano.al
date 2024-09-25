#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50079 "Importacion Pedidos mano mano"
{

    trigger OnRun()
    begin


        RecCP.Get;
        nomdir :=RecCP."Ruta salida a_gestion";
        RUTACOPIA:=RecCP."Ruta salida a_gestion copia";
        ruta2:=RecCP."Ruta salida de_gestion";
        Commit;


        ////////////
        ///// catit
        ////////////



        SalesReceivablesSetup.Get;
        nomdir:=SalesReceivablesSetup."Ruta fiche. Stock mano mano pe";
        RUTACOPIA:=SalesReceivablesSetup."Ruta fiche. Stock mano mano pe"+'copia\';
        Commit;

                  Clear(recFicheros);
                  recFicheros.SetRange(Path,nomdir);
                  if recFicheros.Find('-') then repeat
                       if recFicheros."Is a file" then begin
                            lon1:=StrLen(recFicheros.Name);
                            NOMFIC:=recFicheros.Name;
                            NOM:=recFicheros.Name;
                            NombreFichero:=recFicheros.Name;
                            nomfich:=nomdir+recFicheros.Name;
                            ///IF COPYSTR(NOM,1,1)<>'C' THEN BEGIN
                            if fichero.Open(nomfich) then begin
                                 fichero.Close;
                                   varXmlFile.Open(nomfich);
                                   varXmlFile.CreateInstream(varInputStream);                                                          ;
                                   Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", varInputStream);
                                   varXmlFile.Close;
                                   FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                   FILE.Erase(nomfich);
                             ///END;
                             Commit;
                             end;
                        end;
                   until recFicheros.Next = 0;
                  Commit;


        exit;



          Clear(recFicheros);
                  recFicheros.SetRange(Path,ruta2);
                  if recFicheros.Find('-') then repeat
                  until recFicheros.Next = 0;
                  Commit;
    end;

    var
        varXmlFile: File;
        varInputStream: InStream;
        NombreFichero: Code[200];
        recFicheros: Record File;
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
        CU_1: Codeunit ApplicationManagement;
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
        DATAIMPLEUTEROM: XmlPort UnknownXmlPort50127;
        DATAIMPLEUTEREXP: XmlPort UnknownXmlPort50008;
        DATAIMPLEUTERSTOART: XmlPort UnknownXmlPort50005;
        ImportaADAIA: Codeunit "Conecta ADAIA";
        CURegMov: Codeunit "Item Jnl.-Post Batch";
        ImportacionPEDIDOSKIWOKO2: XmlPort UnknownXmlPort50022;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        ImportacionPEDIDOSAMAZON: XmlPort UnknownXmlPort50023;
        JobQueueLogEntry: Record "Job Queue Log Entry";
        ImportacionPEDIDOScatit: XmlPort UnknownXmlPort50003;
        ImportacionPEDIDOScatittnew: XmlPort UnknownXmlPort50055;


    procedure Buscaadaia()
    begin
        
        
                  Clear(recFicheros);
                  recFicheros.SetRange(Path,nomdir);
                  if recFicheros.Find('-') then repeat
                       if recFicheros."Is a file" then begin
                            lon1:=StrLen(recFicheros.Name);
                            NOMFIC:=recFicheros.Name;
                            NOM:=recFicheros.Name;
                            NombreFichero:=recFicheros.Name;
                            ///Control;
                            Tienedolar:=false;
                            if not Tienedolar then begin
                                 nomfich:=nomdir+recFicheros.Name;
                                 if fichero.Open(nomfich) then begin
                                      fichero.Close;
                                      if CopyStr(NOM,1,9)='TRUNITCON' then begin
                                           ///CLEAR(DATAIMPLEUTEROM);
                                          /// DATAIMPLEUTEROM.FILENAME(nomfich);
                                           //7DATAIMPLEUTEROM.RUN;
                                           FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                           FILE.Erase(nomfich);
                                          /// Codeunit50010.MODIFCLIENTES(Rec83);
                                      end;
        
                                      if CopyStr(NOM,1,8)='TRSTOMOV' then begin
                                        varXmlFile.Open(nomfich);
                                        varXmlFile.CreateInstream(varInputStream);
                                        Xmlport.Import(Xmlport::"ADAIA_Ajustes adaia", varInputStream);
                                        varXmlFile.Close;
                                        FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                        FILE.Erase(nomfich);
                                        Codeunit50010.REGISTRATSTMOV(Rec83);
                                      end;
                                      if CopyStr(NOM,1,8)='TRSTOART' then begin
                                           ///CLEAR(DATAIMPLEUTERSTOART);
                                           ///DATAIMPLEUTERSTOART.FILENAME(nomfich);
                                           ///DATAIMPLEUTERSTOART.RUN;
                                           FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                           FILE.Erase(nomfich);
                                      end;
                                      if CopyStr(NOM,1,6)='TRSTO.' then begin
                                           ///CLEAR(DATAIMPLEUTERSTO);
                                           ///DATAIMPLEUTERSTO.FILENAME(nomfich);
                                           ///DATAIMPLEUTERSTO.RUN;
                                           FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                           FILE.Erase(nomfich);
                                      end;
        
                                      if CopyStr(NOM,1,5)='TRARE' then begin
                                           ///CLEAR(DATAPEAN);
                                           ///DATAPEAN.FILENAME(nomfich);
                                           ///DATAPEAN.RUN;
                                           FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                           FILE.Erase(nomfich);
                                      end;
        
                                      if CopyStr(NOM,1,5)='TRREC' then begin
                                           ///CLEAR(DATAIMPLEUTERREC);
                                           ///DATAIMPLEUTERREC.FILENAME(nomfich);
                                           ///DATAIMPLEUTERREC.RUN;
                                           FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                           FILE.Erase(nomfich);
                                      end;
        
                                      if CopyStr(NOM,1,5)='TREXP' then begin
        
                                           varXmlFile.Open(nomfich);
                                           varXmlFile.CreateInstream(varInputStream);
                                           Xmlport.Import(Xmlport::"ADAIA_Conf. Expediciones", varInputStream);
                                           varXmlFile.Close;
                                           FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                           FILE.Erase(nomfich);
                                           /*
                                           RecCV.RESET;
                                           RecCV.SETCURRENTKEY(RecCV."Document Type",RecCV."Nº expedición");
                                           RecCV.SETRANGE(RecCV."Document Type",1);
                                           RecCV.SETRANGE(RecCV."Nº expedición",'EXPE2');
                                           IF RecCV.FINDFIRST THEN REPEAT
                                                CLEAR(ReleaseSalesDoc);
                                                CLEAR(CodeCV);
                                                ReleaseSalesDoc.RUN(RecCV);
                                                CodeCV.REGISTRAEXPE(RecCV);
                                           UNTIL RecCV.NEXT=0;
                                           */
        
                                     end;
        
                                      /*
                                      IF COPYSTR(NOM,1,5)='TRCAM' THEN BEGIN
                                           CLEAR(DATATRCAM);
                                           DATATRCAM.FILENAME(nomfich);
                                           DATATRCAM.RUN;
                                           FILE.COPY(nomfich,RUTACOPIA+recFicheros.Name);
                                           FILE.ERASE(nomfich);
                                      END;
                                      */
        
                                      Commit;
                                 end;
                            end;
                       end;
                  until recFicheros.Next = 0;
                  Commit;
        
                  Clear(recFicheros);
                  recFicheros.SetRange(Path,ruta2);
                  if recFicheros.Find('-') then repeat
                  until recFicheros.Next = 0;
                  Commit;
        
          Clear(recFicheros);
                  recFicheros.SetRange(Path,ruta2);
                  if recFicheros.Find('-') then repeat
                       ///VENTANA.UPDATE(4,recFicheros.Name);
                  until recFicheros.Next = 0;
                  Commit;

    end;


    procedure importapedidoscompra()
    begin


        RecCP.Get;
        nomdir :='\\192.168.0.225\EXPORT\';
        RUTACOPIA:='\\192.168.0.225\EXPORT\COPIA\';
        ruta2:='\\192.168.0.225\EXPORT\COPIA\';
        Commit;

        VENTANA.Open('Automatico.:'+Format(WorkDate)+' a las:'+Format(Time) +'\'+
                    '\Acción....: #10################################### \'+
                    '\Ficheros..: #11################################### \'+
                    '\Ficheros..: #12################################### \'+
                    '\Fecha actual..: #1####################### \'+
                    '\Hora actual...: #2###### \'+
                    '\Fichero actual: #4################################');

        repeat

                  VENTANA.Update(1,Format(WorkDate));
                  VENTANA.Update(2,Format(Time));

                  Commit;

                  Buscapedi;




        until SALE;
    end;


    procedure Buscapedi()
    begin

                  Clear(recFicheros);
                  recFicheros.SetRange(Path,nomdir);
                  if recFicheros.Find('-') then repeat
                       if recFicheros."Is a file" then begin
                            lon1:=StrLen(recFicheros.Name);
                            NOMFIC:=recFicheros.Name;
                            VENTANA.Update(11,recFicheros.Name);
                            VENTANA.Update(10,'Integrando stock.');
                            VENTANA.Update(4,recFicheros.Name);
                            NOM:=recFicheros.Name;
                            NombreFichero:=recFicheros.Name;
                            Tienedolar:=false;
                            if not Tienedolar then begin
                                 nomfich:=nomdir+recFicheros.Name;
                                 if fichero.Open(nomfich) then begin
                                      fichero.Close;
                                      if CopyStr(NOM,1,7)='ALBARAN' then begin
                                           ///CLEAR(ALTAPEDIOCOMPRA);
                                           ///ALTAPEDIOCOMPRA.FILENAME(nomfich);
                                           ///ALTAPEDIOCOMPRA.RUN;
                                           FILE.Copy(nomfich,RUTACOPIA+recFicheros.Name);
                                           FILE.Erase(nomfich);
                                           Commit;

                                      end;
                                 end;

                            end;
                       end;
                  until recFicheros.Next = 0;
                  Commit;

                  Clear(recFicheros);
                  recFicheros.SetRange(Path,ruta2);
                  if recFicheros.Find('-') then repeat
                       VENTANA.Update(4,recFicheros.Name);
                  until recFicheros.Next = 0;
                  Commit;
    end;


    procedure QLIKVIEW()
    begin


        VENTANA2.Open('#1############################################################################################################');



                       ArchExt:='C:\QLIKVIEW_DATOS.TXT';
                       ArchSalida.TextMode := true;
                       ArchSalida.WriteMode := true;
                       ArchSalida.Create(ArchExt);

                           TextoSalida:=Format('Nun doc')+'#'+
                                        Format('Cod. Cliente')+'#'+
                                        Format('Producto')+'#'+
                                        Format('Fecha')+'#'+
                                        Format('Importe')+'#'+
                                        Format('Mes')+'#'+
                                        Format('Anyo')+'#';
                          TextoSalida2:=Format('Factura/Abono')+'#'+
                                        Format('Cantidad')+'#'+
                                        Format('Vendedor')+'#'+
                                        Format('NEGOCIO DESTINY')+'#'+
                                        Format('CENTRO EXPEDICION')+'#'+
                                        Format('Area de negocio')+'#'+
                                        Format('Mercado')+'#'+
                                        Format('DIVISION')+'#'+
                                        Format('Grupo Contable cliente')+'#'+
                                        Format('Grupo Contable producto')+'#'+
                                        Format('Provincia')+'#';
                          TextoSalida3:=Format('Poblacion')+'#'+
                                        Format('Pais')+'#'+
                                        Format('Descripcion producto')+'#'+
                                        Format('RAZON SOCIAL')+'#'+
                                        Format('DIRECCION')+'#'+
                                        Format('NOMBRE COMERCIAL')+'#'+
                                        Format('C.P.')+'#'+
                                        Format('Semana')+'#'+
                                        Format('Trimestre');


                                        ArchSalida.Write(TextoSalida+TextoSalida2+TextoSalida3);







        DESDEFECHA:=CalcDate('-3A',Today);
        CANO:=Date2dmy(DESDEFECHA,3);
        DESDEFECHA:=Dmy2date(1,1,CANO);


                           TextoSalida:=Format('DOCUMENTO')+'#'+
                                        Format('CLIENTE')+'#'+
                                        Format('NOMBRE CLIENTE')+'#'+
                                        Format('POBLACION')+'#'+
                                        Format('PROVINCIA')+'#'+
                                        Format('PAIS')+'#'+
                                        Format('VENDEDOR')+'#'+
                                        Format('TIPO')+'#'+
                                        Format('PRODUCTO')+'#'+
                                        Format('DESCRIPCION PRODUCTO')+'#'+
                                        Format('CANTIDAD')+'#'+
                                        Format('IMPORTE')+'#';
                          TextoSalida2:=Format('GRUPO CONT. CLIENTE')+'#'+
                                        Format('GRUPO CONT. PRODUCTO')+'#'+
                                        Format('IVA CLIENTE')+'#'+
                                        Format('IVA PRODUCTO')+'#'+
                                        Format('FAMILIA')+'#'+
                                        Format('SUBFAMILIA')+'#'+
                                        Format('CADENA')+'#'+
                                        Format('GRUPO CLIENTES')+'#'+
                                        Format('ZONA DE VENTAS')+'#'+
                                        Format('RUTA DE REPARTO')+'#'+
                                        Format('CLASIFICACION A,B,C HAGEN')+'#';
                          TextoSalida3:=Format('TIPO CLIENTE')+'#'+
                                        Format('CLASIFICACION COMERCIAL')+'#'+
                                        Format('CLASIFICACION A,B,C VENDEDOR')+'#'+
                                        Format('FECHA')+'#'+
                                        Format('SEMANA')+'#'+
                                        Format('ANO')+'#'+
                                        Format('MES')+'#'+
                                        Format('TRIMESTRE');
                                        ArchSalida.Write(TextoSalida+TextoSalida2+TextoSalida3);


        ///////////////////////////
        /////
        ///////////////////////////



             Rec1.SetRange(Rec1."Posting Date",DESDEFECHA,Today);
             if Rec1.Find('-') then repeat
                  VENTANA2.Update(1,Rec1);
                            Semana:=Date2dwy(Rec1."Posting Date", 2);
                            MES:=Date2dmy(Rec1."Posting Date",2);
                            ANO:=Date2dmy(Rec1."Posting Date",3);
                            codemesano:=Format(MES)+'-'+Format(ANO);
                            if (MES>=1) or (3<=MES) then begin
                                 TRIMESTRE:='1T'+'-'+Format(ANO);
                            end;
                            if (MES>=4) or (6<=MES) then begin
                                 TRIMESTRE:='2T'+'-'+Format(ANO);
                            end;
                            if (MES>=7) or (9<=MES) then begin
                                 TRIMESTRE:='3T'+'-'+Format(ANO);
                            end;
                            if (MES>=10) or (12<=MES) then begin
                                 TRIMESTRE:='4T'+'-'+Format(ANO);
                            end;
                           RecClie.Get(Rec1."Sell-to Customer No.");
                         Rec2.Reset;
                         Rec2.SetRange(Rec2."Document No.",Rec1."No.");
                         if Rec2.FindSet then repeat


                           TextoSalida:=Format(Rec1."No.")+'#'+
                                        Format(Rec1."Sell-to Customer No.")+'#'+
                                        Format(Rec1."Sell-to Customer Name")+'#'+
                                        Format(Rec1."Sell-to City")+'#'+
                                        Format(Rec1."Sell-to County")+'#'+
                                        Format(Rec1."Sell-to Country/Region Code")+'#'+
                                        Format(Rec1."Salesperson Code")+'#'+
                                        Format(Rec2.Type)+'#'+
                                        Format(Rec2."No.")+'#'+
                                        Format(Rec2.Description)+'#'+
                                        Format(Rec2.Quantity)+'#'+
                                        Format(Rec2.Amount)+'#';
                          TextoSalida2:=Format(Rec2."Gen. Bus. Posting Group")+'#'+
                                        Format(Rec2."Gen. Prod. Posting Group")+'#'+
                                        Format(Rec2."VAT Bus. Posting Group")+'#'+
                                        Format(Rec2."VAT Prod. Posting Group")+'#'+
                                        Format(Rec2.Familia)+'#'+
                                        Format(Rec2.Subfamilia)+'#'+
                                        Format(RecClie."Chain Name")+'#'+
                                        Format(RecClie."Grupo clientes")+'#'+
                                        Format(RecClie."Zona de ventas")+'#'+
                                        Format('')+'#'+
                                        Format(RecClie."Clasificación A,B,C Hagen")+'#';
                          TextoSalida3:=Format('')+'#'+
                                        Format(RecClie."Clasificacion CRM")+'#'+
                                        Format(RecClie."Clasificación A,B,C Vendedor")+'#'+
                                        Format(Rec1."Posting Date")+'#'+
                                        Format(Semana)+'#'+
                                        Format(ANO)+'#'+
                                        Format(MES)+'#'+
                                        Format(TRIMESTRE)+'#';
                                        ArchSalida.Write(TextoSalida+TextoSalida2+TextoSalida3);



                                 until Rec2.Next = 0;

             until Rec1.Next = 0;


             Rec3.SetRange(Rec3."Posting Date",DESDEFECHA,Today);
             if Rec3.Find('-') then repeat
                  VENTANA2.Update(1,Rec3);
                            Semana:=Date2dwy(Rec3."Posting Date", 2);
                            MES:=Date2dmy(Rec3."Posting Date",2);
                            ANO:=Date2dmy(Rec3."Posting Date",3);
                            codemesano:=Format(MES)+'-'+Format(ANO);
                            if (MES>=1) or (3<=MES) then begin
                                 TRIMESTRE:='1T'+'-'+Format(ANO);
                            end;
                            if (MES>=4) or (6<=MES) then begin
                                 TRIMESTRE:='2T'+'-'+Format(ANO);
                            end;
                            if (MES>=7) or (9<=MES) then begin
                                 TRIMESTRE:='3T'+'-'+Format(ANO);
                            end;
                            if (MES>=10) or (12<=MES) then begin
                                 TRIMESTRE:='4T'+'-'+Format(ANO);
                            end;
                           RecClie.Get(Rec3."Sell-to Customer No.");
                         Rec4.Reset;
                         Rec4.SetRange(Rec4."Document No.",Rec3."No.");
                         if Rec4.FindSet then repeat


                           TextoSalida:=Format(Rec3."No.")+'#'+
                                        Format(Rec3."Sell-to Customer No.")+'#'+
                                        Format(Rec3."Sell-to Customer Name")+'#'+
                                        Format(Rec3."Sell-to City")+'#'+
                                        Format(Rec3."Sell-to County")+'#'+
                                        Format(Rec3."Sell-to Country/Region Code")+'#'+
                                        Format(Rec3."Salesperson Code")+'#'+
                                        Format(Rec4.Type)+'#'+
                                        Format(Rec4."No.")+'#'+
                                        Format(Rec4.Description)+'#'+
                                        Format(Rec4.Quantity*-1)+'#'+
                                        Format(Rec4.Amount*-1)+'#';
                          TextoSalida2:=Format(Rec4."Gen. Bus. Posting Group")+'#'+
                                        Format(Rec4."Gen. Prod. Posting Group")+'#'+
                                        Format(Rec4."VAT Bus. Posting Group")+'#'+
                                        Format(Rec4."VAT Prod. Posting Group")+'#'+
                                        Format(Rec4.Familia)+'#'+
                                        Format(Rec4.Subfamilia)+'#'+
                                        Format(RecClie."Chain Name")+'#'+
                                        Format(RecClie."Grupo clientes")+'#'+
                                        Format(RecClie."Zona de ventas")+'#'+
                                        Format('')+'#'+
                                        Format(RecClie."Clasificación A,B,C Hagen")+'#';
                          TextoSalida3:=Format('')+'#'+
                                        Format(RecClie."Clasificacion CRM")+'#'+
                                        Format(RecClie."Clasificación A,B,C Vendedor")+'#'+
                                        Format(Rec3."Posting Date")+'#'+
                                        Format(Semana)+'#'+
                                        Format(ANO)+'#'+
                                        Format(MES)+'#'+
                                        Format(TRIMESTRE)+'#';
                                        ArchSalida.Write(TextoSalida+TextoSalida2+TextoSalida3);


                                 until Rec4.Next = 0;

             until Rec3.Next = 0;


        VENTANA2.Close;
    end;


    procedure RecalculaNoPermitirPedido()
    begin
    end;


    procedure funcionalidadPEPE()
    begin
    end;


    procedure CREARPVENHAGEN()
    begin
    end;


    procedure CREARPCPEPE()
    begin
    end;


    procedure ASUSTESENPEPE()
    begin
    end;

    local procedure TRSTOART()
    var
        CHA: Integer;
        String: Text[250];
        String1: Text[250];
        String2: Text[250];
        POSICION: Integer;
        CODPROD: Code[20];
        WORKDATED: Date;
        KIL: Decimal;
        CAN: Decimal;
        UNO: Code[20];
        DOS: Code[20];
        UBICA: Code[20];
        PROD: Code[20];
        CANTI: Code[20];
        POS: Decimal;
        LON: Decimal;
        REF: Code[20];
        SALE: Boolean;
        kilos: Code[20];
        fc: Code[10];
        frecp: Code[10];
        Item: Record Item;
        REFCONFOR: Code[20];
        LDP: Record "Item Journal Line";
        CANTIDECI: Decimal;
        KILOSDECI: Decimal;
        NL: Decimal;
        TiendaFichero: Code[10];
        FechaFichero: Code[10];
        ExisAlma: Decimal;
        Exis: Decimal;
        Documento: Code[10];
        FechaDoc: Date;
        Dif: Decimal;
        Difmayor: Decimal;
        Fecha: Record Date;
        Dialo: Dialog;
        RecCuenta: Record "G/L Account";
        VentaC: Decimal;
        VentaMP: Decimal;
        MP: Record "Item Ledger Entry";
        ArchSalida: File;
        ArchExt: Text[250];
        Ascii: Boolean;
        Ventana: Dialog;
        CodDFecha: Date;
        CodHFecha: Date;
        TextoSalida: Text[250];
        Recproducto: Record Item;
        "RecAlmacén": Record Location;
        Importe: Decimal;
        RecIVA: Record "VAT Posting Setup";
        Dia: Code[2];
        Mes: Code[2];
        Dia1: Decimal;
        Mes1: Decimal;
        Ventana2: Dialog;
        opc: Integer;
        ArchExt1: Text[30];
        ArchExt2: Text[30];
        TextoSalida1: Text[250];
        TextoSalida2: Text[250];
        ArchSalida1: File;
        ArchSalida2: File;
        CodDTienda: Code[10];
        CodHTienda: Code[10];
        RecSDP: Record "Item Journal Batch";
        lin: Decimal;
        Rec83: Record "Item Journal Line";
        RecItem: Record Item;
        RecUMP: Record "Item Unit of Measure";
        STOCCAL: Decimal;
        RecItem2: Record Item;
        LOTE: Code[30];
        RecPP: Record "Purchase Price";
        Rec32: Record "Item Ledger Entry";
        ItemUnitofMeasure: Record "Item Unit of Measure";
    begin


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




        RecItem.Reset;
        RecItem.SetRange(RecItem.Blocked,false);
        if RecItem.FindFirst then repeat
             ItemUnitofMeasure.Reset;
             ItemUnitofMeasure.SetRange(ItemUnitofMeasure."Item No.",RecItem."No.");
             ItemUnitofMeasure.SetRange(ItemUnitofMeasure.Code,'UDS');
             if not ItemUnitofMeasure.FindFirst then begin
                  ItemUnitofMeasure.Init;
                  ItemUnitofMeasure."Item No.":=RecItem."No.";
                  ItemUnitofMeasure.Code:='UDS';
                  ItemUnitofMeasure."Qty. per Unit of Measure":=1;
                  ItemUnitofMeasure.Insert;
             end;

              RecItem2.Get(RecItem."No.");
              RecItem2.SetRange(RecItem2."Location Filter",'SILLA','SILLA');
              RecItem2.CalcFields(RecItem2.Inventory);
              STOCCAL:=RecItem2.Inventory;
              Rec83.Init;
              Rec83."Journal Template Name":='INVENT. FÍ';
              Rec83."Journal Batch Name":=FechaFichero;
              lin:=lin+10000;
              Rec83."Line No.":=lin;
              Rec83."Phys. Inventory":=false;
              Rec83.Validate(Rec83."Item No.",RecItem."No.");
              Rec83."Phys. Inventory":=true;

              Rec83."Location Code":='SILLA';
              Rec83."Posting Date":=Today;
              Rec83."Unit of Measure Code":=RecItem."Base Unit of Measure";
              Rec83.Validate(Rec83."Qty. (Calculated)",STOCCAL);
              Rec83."Document No.":='AJUSTES';
              Rec83.Insert;
              Commit;



        until RecItem.Next=0;






        ArchExt:=nomfich;
        ArchSalida.TextMode := true;
        ArchSalida.Open(ArchExt);
        ///ArchSalida.READ(String);
        CHA := 9;
        ///VENTANA.OPEN('#1####################');
        repeat

             POSICION:=POSICION+1;
             ArchSalida.Read(String);
             CODPROD:='';
             if CopyStr(String,1,4)='STAR' then begin
                  POS:=8;
                  SALE:=false;
                  repeat
                       POS:=POS+1;
                       if CopyStr(String,POS,1)='|' then begin
                            SALE:=true;
                       end;
                  until SALE;
                  SALE:=false;
                  repeat
                       POS:=POS+1;
                       if CopyStr(String,POS,1)<>'|' then begin
                            CODPROD:=CODPROD+CopyStr(String,POS,1);
                       end;
                       if CopyStr(String,POS,1)='|' then begin
                            SALE:=true;
                       end;
                  until SALE;
                  SALE:=false;
                  CANTI:='';
                  repeat
                       POS:=POS+1;
                       if CopyStr(String,POS,1)<>'|' then begin
                            CANTI:=CANTI+CopyStr(String,POS,1);
                       end;
                       if CopyStr(String,POS,1)='|' then begin
                            SALE:=true;
                       end;
                  until SALE;
                  if CODPROD<>'' then begin
                       Evaluate(CAN,CANTI);
                       if Item.Get(CODPROD) then begin
                            ItemUnitofMeasure.Reset;
                            ItemUnitofMeasure.SetRange(ItemUnitofMeasure."Item No.",CODPROD);
                            ItemUnitofMeasure.SetRange(ItemUnitofMeasure.Code,'UDS');
                            if not ItemUnitofMeasure.FindFirst then begin
                                 ItemUnitofMeasure.Init;
                                 ItemUnitofMeasure."Item No.":=CODPROD;
                                 ItemUnitofMeasure.Code:='UDS';
                                 ItemUnitofMeasure."Qty. per Unit of Measure":=1;
                                 ItemUnitofMeasure.Insert;
                            end;
                            Rec83.Reset;
                            Rec83.SetRange(Rec83."Journal Template Name",'INVENT. FÍ');
                            Rec83.SetRange(Rec83."Journal Batch Name",FechaFichero);
                            Rec83.SetRange(Rec83."Item No.",REF);
                            if Rec83.FindLast then begin
                                 Evaluate(CANTIDECI,CANTI);
                                 Rec83.Validate(Rec83."Qty. (Phys. Inventory)",Rec83."Qty. (Phys. Inventory)"+CAN);
                                 Rec83.Modify;
                          end;
                       end;
                  end;
             end;



        until POSICION=9999;
    end;

    local procedure VARIOS()
    begin
        
         /*
                                      IF COPYSTR(NOM,1,9)='TRUNITCON' THEN BEGIN
                                           ///CLEAR(DATAIMPLEUTEROM);
                                          /// DATAIMPLEUTEROM.FILENAME(nomfich);
                                           //7DATAIMPLEUTEROM.RUN;
                                           FILE.COPY(nomfich,RUTACOPIA+recFicheros.Name);
                                           FILE.ERASE(nomfich);
                                          /// Codeunit50010.MODIFCLIENTES(Rec83);
                                      END;
                                      */
                                      /*
                                      IF COPYSTR(NOM,1,5)='TRARE' THEN BEGIN
                                           ///CLEAR(DATAPEAN);
                                           ///DATAPEAN.FILENAME(nomfich);
                                           ///DATAPEAN.RUN;
                                           FILE.COPY(nomfich,RUTACOPIA+recFicheros.Name);
                                           FILE.ERASE(nomfich);
                                      END;
                                      */
        
        /*
                                      IF COPYSTR(NOM,1,5)='TRCAM' THEN BEGIN
                                           CLEAR(DATATRCAM);
                                           DATATRCAM.FILENAME(nomfich);
                                           DATATRCAM.RUN;
                                           FILE.COPY(nomfich,RUTACOPIA+recFicheros.Name);
                                           FILE.ERASE(nomfich);
                                      END;
                                      */

    end;
}

