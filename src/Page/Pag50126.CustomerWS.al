page 50126 CustomerWS
{
    ApplicationArea = All;
    Caption = 'CustomerWS';
    PageType = List;
    UsageCategory = Administration;
    SourceTable = CustomerWebService;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';
                // 1
                field("Tipo_plantilla"; Rec."Tipo plantilla")
                {
                    ToolTip = 'Specifies the value of the Tipo plantilla field.', Comment = '%';
                }
                field("Nombre_fiscal"; Rec."Nombre fiscal")
                {
                    ToolTip = 'Specifies the value of the Nombre fiscal field.', Comment = '%';
                }
                field(CIF; Rec.CIF)
                {
                    ToolTip = 'Specifies the value of the CIF field.', Comment = '%';
                }
                field(Direccion; Rec.Direccion)
                {
                    ToolTip = 'Specifies the value of the Direccion field.', Comment = '%';
                }
                field(Poblacion; Rec.Poblacion)
                {
                    ToolTip = 'Specifies the value of the Poblacion field.', Comment = '%';
                }
                field("Codigo_postal"; Rec."Codigo postal")
                {
                    ToolTip = 'Specifies the value of the Codigo postal field.', Comment = '%';
                }
                field(Provincia; Rec.Provincia)
                {
                    ToolTip = 'Specifies the value of the Provincia field.', Comment = '%';
                }
                field(Telefono; Rec.Telefono)
                {
                    ToolTip = 'Specifies the value of the Telefono field.', Comment = '%';
                }

                // 2
                field("Nombre_comercial"; Rec."Nombre comercial")
                {
                    ToolTip = 'Specifies the value of the Nombre comercial field.', Comment = '%';
                }

                // 3
                field("Nombre_contacto"; Rec."Nombre contacto")
                {
                    ToolTip = 'Specifies the value of the Nombre contacto field.', Comment = '%';
                }
                field("Email_acceso"; Rec."Email acceso")
                {
                    ToolTip = 'Specifies the value of the Email acceso field.', Comment = '%';
                }
                field("Email_facturas"; Rec."Email facturas")
                {
                    ToolTip = 'Specifies the value of the Email facturas field.', Comment = '%';
                }
                field("Movil_whatsapp"; Rec."Movil whatsapp")
                {
                    ToolTip = 'Specifies the value of the Movil whatsapp field.', Comment = '%';
                }

                // 4
                field("Direccion_envio"; Rec."Direccion envio")
                {
                    ToolTip = 'Specifies the value of the Direccion envio field.', Comment = '%';
                }
                field("Poblacion_envio"; Rec."Poblacion envio")
                {
                    ToolTip = 'Specifies the value of the Poblacion envio field.', Comment = '%';
                }
                field("Codigo_postal_envio"; Rec."Codigo postal envio")
                {
                    ToolTip = 'Specifies the value of the Codigo postal envio field.', Comment = '%';
                }
                field("Provincia_envio"; Rec."Provincia envio")
                {
                    ToolTip = 'Specifies the value of the Provincia envio field.', Comment = '%';
                }
                field("Contacto_envio"; Rec."Contacto envio")
                {
                    ToolTip = 'Specifies the value of the Contacto envio field.', Comment = '%';
                }
                field("Telefono_envio"; Rec."Telefono envio")
                {
                    ToolTip = 'Specifies the value of the Telefono envio field.', Comment = '%';
                }
                field("Email_envio"; Rec."Email envio")
                {
                    ToolTip = 'Specifies the value of the Email envio field.', Comment = '%';
                }

                field("Cod. vendedor"; Rec."Cod. vendedor") { }
                field("Forma pago"; Rec."Forma pago") { }
                field(IBAN; Rec.IBAN) { }
                field(fileContent; FileContentBase64)
                {
                    Caption = 'Fichero (Base64)';

                    trigger OnValidate()
                    var
                        Convert: Codeunit "Base64 Convert";
                        OutStr: OutStream;
                    begin
                        Clear(Rec.Fichero);

                        if FileContentBase64 = '' then
                            exit;

                        Rec.Fichero.CreateOutStream(OutStr);
                        Convert.FromBase64(FileContentBase64, OutStr);
                        Rec.Modify(true);
                    end;
                }

                field("Nombre fichero"; Rec."Nombre fichero")
                {
                    Caption = 'Nombre fichero';
                    ToolTip = 'Nombre del fichero adjunto.';
                }
                field("Email notificacion envio"; Rec."Email notificacion envio") { }
                field("Direccion habitual"; Rec."Direccion habitual") { }
            }
        }
    }
    var
        FileContentBase64: Text;

}
