pageextension 50016 "User Setup" extends "User Setup"
{

    layout
    {
        addafter(PhoneNo)
        {
            field("Serie actividades"; Rec."Serie actividades") { ApplicationArea = All; }
            field("Serie incidencias"; Rec."Serie incidencias") { ApplicationArea = All; }
            field("Serie pedidos"; Rec."Serie pedidos") { ApplicationArea = All; }
            field("Permiso pedidos urgentes"; Rec."Permiso pedidos urgentes") { ApplicationArea = All; }
            field("Cambia estado pedido"; Rec."Cambia estado pedido") { ApplicationArea = All; }
            field("Editar tabla Clientes/Comercia"; Rec."Editar tabla Clientes/Comercia") { ApplicationArea = All; }
            field("Comercial"; Rec."Comercial") { ApplicationArea = All; }
            field("Permite modificar estado lin.p"; Rec."Permite modificar estado lin.p") { ApplicationArea = All; }
            field("Editar tabla productos"; Rec."Editar tabla productos") { ApplicationArea = All; }
            field("Nº cliente"; Rec."Nº cliente") { ApplicationArea = All; }
            field("Nº pedido"; Rec."Nº pedido") { ApplicationArea = All; }
            field("Editar ofertas"; Rec."Editar ofertas") { ApplicationArea = All; }
            field("Grupo cliente"; Rec."Grupo cliente") { ApplicationArea = All; }
            field("Linea"; Rec."Linea") { ApplicationArea = All; }
            field("Cambio de Activo a Retenido"; Rec."Cambio de Activo a Retenido") { ApplicationArea = All; }
            field("Cliente a crear tarifa"; Rec."Cliente a crear tarifa") { ApplicationArea = All; }
            field("Permite fraccionar uni. venta"; Rec."Permite fraccionar uni. venta") { ApplicationArea = All; }
            field("Es el cliente nº"; Rec."Es el cliente nº") { ApplicationArea = All; }
            field("Permite modificar precios tari"; Rec."Permite modificar precios tari") { ApplicationArea = All; }
            field("Usuario HAGEN DIRECT"; Rec."Usuario HAGEN DIRECT") { ApplicationArea = All; }
            field("Permite editar PC -> adaia"; Rec."Permite editar PC -> adaia") { ApplicationArea = All; }
            field("Permite alta pedido con impago"; Rec."Permite alta pedido con impago") { ApplicationArea = All; }
            field("Grupo clientes"; Rec."Grupo clientes") { ApplicationArea = All; }
            field("Permite modif. objetivos"; Rec."Permite modif. objetivos") { ApplicationArea = All; }
            field("Permite env.  ANTICIPOS"; Rec."Permite env.  ANTICIPOS") { ApplicationArea = All; }
            field("Es pedido o oferta"; Rec."Es pedido o oferta") { ApplicationArea = All; }
            field("Directorio compartido para doc"; Rec."Directorio compartido para doc") { ApplicationArea = All; }
            field("Edita lista envio a direccion"; Rec."Edita lista envio a direccion") { ApplicationArea = All; }
            field("Departamento"; Rec."Departamento") { ApplicationArea = All; }
            field("Porte por usuario"; Rec."Porte por usuario") { ApplicationArea = All; }
            field("Porte minimo"; Rec."Porte minimo") { ApplicationArea = All; }
            field("Direccion .PDF"; Rec."Direccion .PDF") { ApplicationArea = All; }
            field("Importe calculo portes"; Rec."Importe calculo portes") { ApplicationArea = All; }
            field("Super"; Rec."Super") { ApplicationArea = All; }
            field("Forma pago CASH"; Rec."Forma pago CASH") { ApplicationArea = All; }
            field("Comidas"; Rec."Comidas") { ApplicationArea = All; }
            field("Permiso Defectuoso"; Rec."Permiso Defectuoso") { ApplicationArea = All; }
            field("Ruta dropbox"; Rec."Ruta dropbox") { ApplicationArea = All; }
            field("Ruta dropbox2"; Rec."Ruta dropbox2") { ApplicationArea = All; }
            field("Enviar email recep. compra"; Rec."Enviar email recep. compra") { ApplicationArea = All; }
            field("E-Mail envio notificaciones"; Rec."E-Mail envio notificaciones") { ApplicationArea = All; }
            field("Año"; Rec."Año") { ApplicationArea = All; }
            field("Cod. Analisis"; Rec."Cod. Analisis") { ApplicationArea = All; }
            field("Analisis margenes"; Rec."Analisis margenes") { ApplicationArea = All; }
            field("hasta mes"; Rec."hasta mes") { ApplicationArea = All; }
            field("hasta fecha"; Rec."hasta fecha") { ApplicationArea = All; }
        }
    }
    actions
    {
        addfirst(Creation)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                Caption = 'Caption', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Image;
                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    reportSales: Report "OK Nueva Factura Venta";
                    TempBlob: Codeunit "Temp Blob";
                    OutStream: OutStream;
                    InStream: InStream;
                    Base64Text: Text;
                    Base64Convert: Codeunit "Base64 Convert";
                    fileName: Text;
                    FicheroHagen: Codeunit FicherosHagen;
                begin
                    SalesInvoiceHeader.reset;
                    SalesInvoiceHeader.SetRange("No.", '24FV100000');
                    SalesInvoiceHeader.FindFirst();
                    Clear(reportSales);
                    reportSales.SetTableView(SalesInvoiceHeader);
                    TempBlob.CreateOutStream(OutStream);
                    TempBlob.CreateInStream(InStream);
                    reportSales.SaveAs('', ReportFormat::Pdf, OutStream);
                    fileName := SalesInvoiceHeader."No." + '.PDF';
                    FicheroHagen.CrearFicheroFTP('', fileName, InStream);
                    //Base64Text := Base64Convert.ToBase64(InStream);
                    //Message(Base64Text);
                end;
            }
        }
    }
}
