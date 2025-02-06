#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50049 "Envio emails Facturas canarias"
{

    trigger OnRun()
    var
        SalesInvHeader: Record "Sales Invoice Header";
        RecClie: Record Customer;
    begin





        SalesInvHeader.Reset;
        SalesInvHeader.SetCurrentkey(SalesInvHeader."Enviar email", SalesInvHeader."Email enviado");
        SalesInvHeader.SetRange(SalesInvHeader."Enviar email", true);
        SalesInvHeader.SETRANGE("Posting Date", 20250205D, TODAY);
        SalesInvHeader.SetRange(SalesInvHeader."Email enviado", false);
        if SalesInvHeader.FindFirst() then
            repeat
                if RecClie.geT(SalesInvHeader."Bill-to Customer No.") then begin
                    if RecClie."Servicio email" then begin
                        Clear(Codeunit50010);
                        Codeunit50010.ENVIAREMIALFACTURASCANARIAS(SalesInvHeader);
                    end;
                end;
            until SalesInvHeader.next = 0;


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
        ImportaADAIA: Codeunit "Conecta ADAIA";
        CURegMov: Codeunit "Item Jnl.-Post Batch";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        JobQueueLogEntry: Record "Job Queue Log Entry";
}

