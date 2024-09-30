#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50031 "Clientes canarias"
{

    trigger OnRun()
    begin

        ClientesHagenCanarias;




        exit;
    end;

    var
        ExistenciaHAGEN: Decimal;
        Item2: Record Item;
        ELMIN: Decimal;
        RecBom: Record "BOM Component";
        RecItem4: Record Item;
        InventorySetup: Record "Inventory Setup";
        ArchSalida: File;
        ArchExt: Text[250];
        TextoSalida: Text[250];
        dispo: Decimal;
        dispoc: Code[20];
        Text1100009: label '<Integer>';
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentHeader2: Record "Sales Shipment Header";
        SalesShipmentHeader3: Record "Sales Shipment Header";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        ArchSalida4: File;
        ArchExt4: Text[250];
        Item: Record Item;
        TextoSalida1: Text[250];
        TextoSalida2: Text[250];
        TextoSalida3: Text[250];
        RecGP: Record "Gen. Product Posting Group";
        DISPONI: Decimal;
        ENTRA: Boolean;
        RecItem221: Record Item;
        UNIMEDAD: Decimal;
        FECHARECEP: Date;
        Rec39: Record "Purchase Line";
        Rec38: Record "Purchase Header";
        CMARCA: Text[30];
        RecMt: Record Multitabla;
        RecUMP: Record "Item Unit of Measure";
        RecMT2: Record "Multitabla 2";
        dtext1: Text[200];
        CASCII: Codeunit "ANSI <-> ASCII converter2";
        BOMComponent: Record "BOM Component";
        DESDEA: Date;
        Customer: Record Customer;
        Rec32: Record "Item Ledger Entry";
        DESDE: Date;
        diascompara: Decimal;
        primera: Boolean;
        RecLC: Record "Purchase Line";
        suma: Decimal;
        para1: Decimal;
        para2: Decimal;
        dato1: Decimal;
        dato2: Decimal;
        DIASPARALLEGADA: Decimal;
        RecProve: Record Vendor;
        diablo: Code[20];
        diasprov: Decimal;
        CHA: Integer;
        String: Text[250];
        POS: Integer;
        String1: Text[250];
        String2: Text[250];
        POSICION: Integer;
        CODPROD: Code[20];
        SALE: Boolean;
        VENTANA: Dialog;
        TAcumu: Decimal;
        Tcanti: Decimal;
        SalesHeader: Record "Sales Header";
        RecItem3: Record Item;
        RecItem2: Record Item;
        conta: Integer;
        Item5: Record Item;
        RecBCH: Record "Customer Bank Account";
        RecCli: Record Customer;
        RecClieH: Record Customer;
        codclie: Code[20];
        RecClieC: Record Customer;
        RecClie: Record Customer;
        RecBCC: Record "Customer Bank Account";


    local procedure ClientesHagenCanarias()
    begin
        if COMPANYNAME = 'ROLF C HAGEN ESPAÑA S.A.' then begin
            VENTANA.Open('#1#################');
            RecCli.SetRange(RecCli.Comunidad, '7');
            if RecCli.FindFirst then
                repeat
                    codclie := RecCli."No.";
                    if RecClieH.Get(codclie) then begin
                        VENTANA.Update(1, RecClie."No.");
                        RecClieC.ChangeCompany('HAGEN CANARIAS S.C.');
                        if RecClieC.Get(codclie) then begin
                            RecClieC.Name := RecClieH.Name;
                            RecClieC."Search Name" := RecClieH."Search Name";
                            RecClieC."Name 2" := RecClieH."Name 2";
                            RecClieC.Address := RecClieH.Address;
                            RecClieC."Address 2" := RecClieH."Address 2";
                            RecClieC.City := RecClieH.City;
                            RecClieC.Contact := RecClieH.Contact;
                            RecClieC."Phone No." := RecClieH."Phone No.";
                            RecClieC."Telex No." := RecClieH."Telex No.";
                            RecClieC."Our Account No." := RecClieH."Our Account No.";
                            RecClieC."Territory Code" := RecClieH."Territory Code";
                            RecClieC."Chain Name" := RecClieH."Chain Name";
                            RecClieC."Customer Posting Group" := RecClieH."Customer Posting Group";
                            RecClieC."Currency Code" := RecClieH."Currency Code";
                            RecClieC."Customer Price Group" := RecClieH."Customer Price Group";
                            RecClieC."Language Code" := RecClieH."Language Code";
                            RecClieC."Statistics Group" := RecClieH."Statistics Group";
                            RecClieC."Payment Terms Code" := RecClieH."Payment Terms Code";
                            RecClieC."Fin. Charge Terms Code" := RecClieH."Fin. Charge Terms Code";
                            RecClieC."Salesperson Code" := RecClieH."Salesperson Code";
                            RecClieC."Shipment Method Code" := RecClieH."Shipment Method Code";
                            ;
                            RecClieC."Shipping Agent Code" := RecClieH."Shipping Agent Code";
                            RecClieC."Place of Export" := RecClieH."Place of Export";
                            RecClieC."Invoice Disc. Code" := RecClieH."Invoice Disc. Code";
                            RecClieC."Customer Disc. Group" := RecClieH."Customer Disc. Group";
                            RecClieC."Country/Region Code" := RecClieH."Country/Region Code";
                            RecClieC."Collection Method" := RecClieH."Collection Method";
                            RecClieC.Blocked := RecClieH.Blocked;
                            RecClieC."Invoice Copies" := RecClieH."Invoice Copies";
                            RecClieC."Last Statement No." := RecClieH."Last Statement No.";
                            RecClieC."Print Statements" := RecClieH."Print Statements";
                            RecClieC."Bill-to Customer No." := RecClieH."Bill-to Customer No.";
                            RecClieC.Priority := RecClieH.Priority;
                            RecClieC."Payment Method Code" := RecClieH."Payment Method Code";
                            RecClieC."Last Date Modified" := RecClieH."Last Date Modified";
                            RecClieC."Application Method" := RecClieH."Application Method";
                            RecClieC."Prices Including VAT" := RecClieH."Prices Including VAT";
                            RecClieC."Location Code" := RecClieH."Location Code";
                            RecClieC."Fax No." := RecClieH."Fax No.";
                            RecClieC."Telex Answer Back" := RecClieH."Telex Answer Back";
                            RecClieC."VAT Registration No." := RecClieH."VAT Registration No.";
                            RecClieC."Combine Shipments" := RecClieH."Combine Shipments";
                            RecClieC."Gen. Bus. Posting Group" := RecClieH."Gen. Bus. Posting Group";
                            RecClieC."Post Code" := RecClieH."Post Code";
                            RecClieC.County := RecClieH.County;
                            RecClieC."E-Mail" := RecClieH."E-Mail";
                            RecClieC."Home Page" := RecClieH."Home Page";
                            RecClieC."Reminder Terms Code" := RecClieH."Reminder Terms Code";
                            RecClieC."No. Series" := RecClieH."No. Series";
                            RecClieC."Tax Area Code" := RecClieH."Tax Area Code";
                            RecClieC."Tax Liable" := RecClieH."Tax Liable";
                            RecClieC."VAT Bus. Posting Group" := RecClieH."VAT Bus. Posting Group";
                            RecClieC."Block Payment Tolerance" := RecClieH."Block Payment Tolerance";
                            RecClieC."IC Partner Code" := RecClieH."IC Partner Code";
                            RecClieC."Prepayment %" := RecClieH."Prepayment %";
                            RecClieC."Primary Contact No." := RecClieH."Primary Contact No.";
                            RecClieC."Responsibility Center" := RecClieH."Responsibility Center";
                            RecClieC."Shipping Advice" := RecClieH."Shipping Advice";
                            RecClieC."Shipping Time" := RecClieH."Shipping Time";
                            RecClieC."Shipping Agent Service Code" := RecClieH."Shipping Agent Service Code";
                            RecClieC."Service Zone Code" := RecClieH."Service Zone Code";
                            RecClieC."Allow Line Disc." := RecClieH."Allow Line Disc.";
                            RecClieC."Base Calendar Code" := RecClieH."Base Calendar Code";
                            RecClieC."Copy Sell-to Addr. to Qte From" := RecClieH."Copy Sell-to Addr. to Qte From";
                            RecClieC."Payment Days Code" := RecClieH."Payment Days Code";
                            RecClieC."Non-Paymt. Periods Code" := RecClieH."Non-Paymt. Periods Code";
                            RecClieC."Clasificación A,B,C Hagen" := RecClieH."Clasificación A,B,C Hagen";
                            RecClieC."Fecha alta" := RecClieH."Fecha alta";
                            RecClieC."Modificado por" := RecClieH."Modificado por";
                            RecClieC."Fecha de Modificación" := RecClieH."Fecha de Modificación";
                            RecClieC."Tipo facturación" := RecClieH."Tipo facturación";
                            RecClieC."Aviso Notas" := RecClieH."Aviso Notas";
                            RecClieC."Albaran valorado" := RecClieH."Albaran valorado";
                            RecClieC."Frecuencia visita comercial" := RecClieH."Frecuencia visita comercial";
                            RecClieC.Televendedor := RecClieH.Televendedor;
                            RecClieC."Nº pedido obligatorio" := RecClieH."Nº pedido obligatorio";
                            RecClieC."Servicio email" := RecClieH."Servicio email";
                            RecClieC."Usuario alta" := RecClieH."Usuario alta";
                            RecClieC."Fecha clasificación A,B,C" := RecClieH."Fecha clasificación A,B,C";
                            RecClieC."Grupo clientes" := RecClieH."Grupo clientes";
                            RecClieC."Zona de ventas" := RecClieH."Zona de ventas";
                            RecClieC."Clasificacion CRM" := RecClieH."Clasificacion CRM";
                            RecClieC.Borrado := RecClieH.Borrado;
                            RecClieC."Telefono 2" := RecClieH."Telefono 2";
                            RecClieC."Nº movil" := RecClieH."Nº movil";
                            RecClieC."Observación para transporte" := RecClieH."Observación para transporte";
                            RecClieC."Albaran sin detalle" := RecClieH."Albaran sin detalle";
                            RecClieC."Clasificación A,B,C Vendedor" := RecClieH."Clasificación A,B,C Vendedor";
                            RecClieC."Fecha Clasi. A,B,C Vendedor" := RecClieH."Fecha Clasi. A,B,C Vendedor";
                            RecClieC."Contacto en factura" := RecClieH."Contacto en factura";
                            RecClieC."Correo elect. Comercial" := RecClieH."Correo elect. Comercial";
                            RecClieC."Estatus del cliente" := RecClieH."Estatus del cliente";
                            RecClieC."Incluir en propaganda" := RecClieH."Incluir en propaganda";
                            RecClieC."No incluir portes" := RecClieH."No incluir portes";
                            RecClieC."Respeta agencia transporte" := RecClieH."Respeta agencia transporte";
                            RecClieC."Respeta Tipo facturacion" := RecClieH."Respeta Tipo facturacion";
                            RecClieC."No imprimir facturas" := RecClieH."No imprimir facturas";
                            RecClieC."Email facturacion 1" := RecClieH."Email facturacion 1";
                            RecClieC."Email facturacion 2" := RecClieH."Email facturacion 2";
                            RecClieC."Email facturacion 3" := RecClieH."Email facturacion 3";
                            RecClieC."Dias tolerancias fecha vto." := RecClieH."Dias tolerancias fecha vto.";
                            RecClieC."Mas comerciales" := RecClieH."Mas comerciales";
                            RecClieC."Grupo descuento mensual" := RecClieH."Grupo descuento mensual";
                            RecClieC."No enviar emial de preparacion" := RecClieH."No enviar emial de preparacion";
                            RecClieC."Email albaran sin detalle 1" := RecClieH."Email albaran sin detalle 1";
                            RecClieC."Factura ordenada" := RecClieH."Factura ordenada";
                            RecClieC."Email abono 1" := RecClieH."Email abono 1";
                            RecClieC."Email abono 2" := RecClieH."Email abono 2";
                            RecClieC."Email pedido 1" := RecClieH."Email pedido 1";
                            RecClieC."Email pedido 2" := RecClieH."Email pedido 2";
                            RecClieC."Adjuntar pub. facturacion 1" := RecClieH."Adjuntar pub. facturacion 1";
                            RecClieC."Adjuntar pub. facturacion 2" := RecClieH."Adjuntar pub. facturacion 2";
                            RecClieC."Adjuntar pub. facturacion 3" := RecClieH."Adjuntar pub. facturacion 3";
                            RecClieC."Adjuntar pub. albaran sin det." := RecClieH."Adjuntar pub. albaran sin det.";
                            RecClieC."Adjuntar pub. abono 1" := RecClieH."Adjuntar pub. abono 1";
                            RecClieC."Adjuntar pub. abono 2" := RecClieH."Adjuntar pub. abono 2";
                            RecClieC."Adjuntar pub. pedido 1" := RecClieH."Adjuntar pub. pedido 1";
                            RecClieC."Adjuntar pub. pedido 2" := RecClieH."Adjuntar pub. pedido 2";
                            RecClieC."Adjuntar pub. albaran 1" := RecClieH."Adjuntar pub. albaran 1";
                            RecClieC."Adjuntar pub. albaran 2" := RecClieH."Adjuntar pub. albaran 2";
                            RecClieC."Adjuntar pub. albaran 3" := RecClieH."Adjuntar pub. albaran 3";
                            RecClieC."No imprimir albaran valorado" := RecClieH."No imprimir albaran valorado";
                            RecClieC."Impresion fact. sin dto." := RecClieH."Impresion fact. sin dto.";

                            RecClieC."Centro ECI" := RecClieH."Centro ECI";
                            RecClieC."Factura con PVP" := RecClieH."Factura con PVP";
                            RecClieC.Latitud := RecClieH.Latitud;
                            RecClieC.Longitud := RecClieH.Longitud;
                            RecClieC.Comunidad := RecClieH.Comunidad;
                            RecClieC."Factura CSV" := RecClieH."Factura CSV";
                            RecClieC."Albaran CSV" := RecClieH."Albaran CSV";
                            RecClieC."Codigo cliente externo" := RecClieH."Codigo cliente externo";
                            RecClieC."Ruta envio CSV" := RecClieH."Ruta envio CSV";
                            RecClieC."Grupo ventas" := RecClieH."Grupo ventas";
                            RecClieC.Nombre_Cliente := RecClieH.Nombre_Cliente;
                            RecClieC."Localizacion tienda" := RecClieH."Localizacion tienda";
                            RecClieC."Tipo negocio" := RecClieH."Tipo negocio";
                            RecClieC."Año apertura" := RecClieH."Año apertura";
                            RecClieC."Contraseña WEB" := RecClieH."Contraseña WEB";
                            RecClieC."Nº proveedor" := RecClieH."Nº proveedor";
                            RecClieC."Usuario Web" := RecClieH."Usuario Web";
                            RecClieC."Nombre para email" := RecClieH."Nombre para email";
                            RecClieC."No email chimp" := RecClieH."No email chimp";
                            RecClieC."Actualizar WEB" := RecClieH."Actualizar WEB";
                            RecClieC."Enviar a Web" := RecClieH."Enviar a Web";
                            RecClieC."Enviar a Web Distribuidor" := RecClieH."Enviar a Web Distribuidor";
                            RecClieC."Direccion Envio Habitual Store" := RecClieH."Direccion Envio Habitual Store";
                            RecClieC."Metros Establecimiento" := RecClieH."Metros Establecimiento";
                            RecClieC."VAT Bus. Posting Group" := 'IGIC';
                            RecClieC."Bill-to Customer No." := '';
                            RecClieC."Tipo facturación" := 0;
                            RecClieC.Modify;
                            Commit;

                            RecBCH.Reset;
                            RecBCH.SetRange(RecBCH."Customer No.", codclie);
                            if RecBCH.FindFirst then
                                repeat
                                    RecBCC.Reset;
                                    RecBCC.ChangeCompany('HAGEN CANARIAS S.C.');
                                    if RecBCC.Get(RecBCH."Customer No.", RecBCH.Code) then begin
                                        RecBCC."Bank Branch No." := RecBCH."Bank Branch No.";
                                        RecBCC."Bank Account No." := RecBCH."Bank Account No.";
                                        RecBCC."Transit No." := RecBCH."Transit No.";
                                        RecBCC."Currency Code" := RecBCH."Currency Code";
                                        RecBCC."Country/Region Code" := RecBCH."Country/Region Code";
                                        RecBCC.County := RecBCH.County;
                                        RecBCC.Iban := RecBCH.Iban;
                                        RecBCC."SWIFT Code" := RecBCH."SWIFT Code";
                                        RecBCC."CCC Bank No." := RecBCH."CCC Bank No.";
                                        RecBCC."CCC Bank Branch No." := RecBCH."CCC Bank Branch No.";
                                        RecBCC."CCC Control Digits" := RecBCH."CCC Control Digits";
                                        RecBCC."CCC Bank Account No." := RecBCH."CCC Bank Account No.";
                                        RecBCC."CCC No." := RecBCH."CCC No.";
                                        RecBCC.BIC := RecBCH.BIC;
                                        RecBCC.Modify;
                                        Commit;
                                    end;
                                    if not RecBCC.Get(RecBCH."Customer No.", RecBCH.Code) then begin
                                        RecBCC := RecBCH;
                                        RecBCC.Insert;
                                        Commit;
                                    end;

                                until RecBCH.Next = 0;
                        end;
                        if not RecClieC.Get(codclie) then begin
                            RecClieC.Init;
                            RecClieC := RecClieH;
                            RecClieC."VAT Bus. Posting Group" := 'IGIC';
                            RecClieC."Bill-to Customer No." := '';
                            RecClieC."Tipo facturación" := 0;
                            RecClieC.Insert;
                            Commit;
                            RecBCH.Reset;
                            RecBCH.SetRange(RecBCH."Customer No.", codclie);
                            if RecBCH.FindFirst then
                                repeat
                                    RecBCC.Reset;
                                    RecBCC.ChangeCompany('HAGEN CANARIAS S.C.');
                                    if RecBCC.Get(RecBCH."Customer No.", RecBCH.Code) then begin
                                        RecBCC."Bank Branch No." := RecBCH."Bank Branch No.";
                                        RecBCC."Bank Account No." := RecBCH."Bank Account No.";
                                        RecBCC."Transit No." := RecBCH."Transit No.";
                                        RecBCC."Currency Code" := RecBCH."Currency Code";
                                        RecBCC."Country/Region Code" := RecBCH."Country/Region Code";
                                        RecBCC.County := RecBCH.County;
                                        RecBCC.Iban := RecBCH.Iban;
                                        RecBCC."SWIFT Code" := RecBCH."SWIFT Code";
                                        RecBCC."CCC Bank No." := RecBCH."CCC Bank No.";
                                        RecBCC."CCC Bank Branch No." := RecBCH."CCC Bank Branch No.";
                                        RecBCC."CCC Control Digits" := RecBCH."CCC Control Digits";
                                        RecBCC."CCC Bank Account No." := RecBCH."CCC Bank Account No.";
                                        RecBCC."CCC No." := RecBCH."CCC No.";
                                        RecBCC.BIC := RecBCH.BIC;
                                        RecBCC.Modify;
                                        Commit;
                                    end;
                                    if not RecBCC.Get(RecBCH."Customer No.", RecBCH.Code) then begin
                                        RecBCC := RecBCH;
                                        RecBCC.Insert;
                                        Commit;
                                    end;
                                until RecBCH.Next = 0;
                        end;
                    end;
                until RecCli.Next = 0;
            VENTANA.Close;

        end;
    end;
}

