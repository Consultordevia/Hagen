#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50079 "Importacion Pedidos mano mano"
{

    trigger OnRun()
    var
        FicherosHagen: Codeunit FicherosHagen;
        Tipo: enum Ficherets;
    begin


        RecCP.Get;
        nomdir := RecCP."Ruta salida a_gestion";
        RUTACOPIA := RecCP."Ruta salida a_gestion copia";
        ruta2 := RecCP."Ruta salida de_gestion";
        Commit;


        ////////////
        ///// catit
        ////////////



        SalesReceivablesSetup.Get;
        //nomdir := SalesReceivablesSetup."Ruta fiche. Stock mano mano pe";
        //RUTACOPIA := SalesReceivablesSetup."Ruta fiche. Stock mano mano pe" + 'copia/';

        ADAIA.Reset();
        ADAIA.SetRange(texto, 'IMPORTACION MANOMANO-CU-50079');
        IF ADAIA.FindSet() THEN begin
            nomdir := ADAIA.Ruta;
            RUTACOPIA := ADAIA.Ruta + 'copia/';
        end;
        Commit;
        tipo := Tipo::PedidosManoMano;


        FicherosHagen.LeerArchivosCarpeta(nomdir, RUTACOPIA, Tipo)

        /*Clear(recFicheros);
        recFicheros.SetRange(Path, nomdir);
        if recFicheros.Find('-') then
            repeat
                if recFicheros."Is a file" then begin
                    lon1 := StrLen(recFicheros.Name);
                    NOMFIC := recFicheros.Name;
                    NOM := recFicheros.Name;
                    NombreFichero := recFicheros.Name;
                    nomfich := nomdir + recFicheros.Name;
                    ///IF COPYSTR(NOM,1,1)<>'C' THEN BEGIN
                    if fichero.Open(nomfich) then begin
                        fichero.Close;
                        varXmlFile.Open(nomfich);
                        varXmlFile.CreateInstream(varInputStream);
                        ;
                        Xmlport.Import(Xmlport::"Importacion PEDIDOS mano mano", varInputStream);
                        varXmlFile.Close;
                        FILE.Copy(nomfich, RUTACOPIA + recFicheros.Name);
                        FILE.Erase(nomfich);
                        ///END;
                        Commit;
                    end;
                end;
            until recFicheros.Next = 0;
        Commit;
        */

        //exit;

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


        CURegMov: Codeunit "Item Jnl.-Post Batch";

        SalesReceivablesSetup: Record "Sales & Receivables Setup";

        JobQueueLogEntry: Record "Job Queue Log Entry";

        ADAIA: Record adaia;




}

