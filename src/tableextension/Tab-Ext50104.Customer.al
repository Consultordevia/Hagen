tableextension 50104 Customer extends "Customer"
{

    fields
    {
        modify("Search Name")
        {
            trigger OnAfterValidate()
            begin
                Nombre_Cliente := "Search Name" + '-' + "No.";
            end;
        }
        modify("Post Code")
        {
            trigger OnAfterValidate()
            var
                RecPc: Record "Post Code";
                RecArea: Record "Area";
            begin
                RecPc.Reset;
                RecPc.SetRange(RecPc.Code, Rec."Post Code");
                RecPc.SetRange(RecPc.City, Rec.City);
                if RecPc.FindFirst then begin
                    if RecArea.Get(RecPc."County Code") then begin
                        Rec.Comunidad := RecArea.Comunidad;
                    end;
                    "Zona de ventas" := RecPc."Zona Venta";
                    //"Country/Region Code" := RecPc.Pais;
                end;
                if not RecPc.FindFirst then begin
                    RecPc.Reset;
                    RecPc.SetRange(RecPc.Code, Rec."Post Code");
                    if RecPc.FindFirst then begin
                        if RecArea.Get(RecPc."County Code") then begin
                            Rec.Comunidad := RecArea.Comunidad;
                        end;
                    end;
                end;
            end;
        }
        field(50000; "Permite seguir adelante"; Boolean)
        {
        }
        field(50001; "Clasificación A,B,C Hagen"; Option)
        {
            Editable = false;
            InitValue = " ";
            OptionMembers = A,B,C," ";
        }
        field(50002; "Fecha alta"; Date)
        {
            Editable = false;
        }
        field(50003; "Modificado por"; Code[20])
        {
            Editable = false;
            TableRelation = User;
        }
        field(50004; "Fecha de Modificación"; Date)
        {
            Editable = false;
        }
        field(50005; "No enviar excel"; Boolean)
        {
        }
        field(50006; "Tipo facturación"; Option)
        {
            OptionMembers = Diaria,Semanal,Mensual;
        }
        field(50007; "Aviso Notas"; Boolean)
        {
        }
        field(50008; "% clasi A,B,C"; Decimal)
        {
        }
        field(50009; "Acumu. A,B,C"; Decimal)
        {
        }
        field(50010; "Albaran valorado"; Boolean)
        {
        }
        field(50011; "Código EDI"; Code[17])
        {
        }
        field(50012; "Enviar etiqueta grande"; Boolean)
        {
        }
        field(50014; "Frecuencia visita comercial"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const("Frecuencia visita"));
        }
        field(50015; "No enviar cartas contables"; Boolean)
        {
            Caption = 'No enviar cartas contables';
        }
        field(50017; Televendedor; Code[10])
        {
            TableRelation = User;
        }
        field(50018; "Enviar pdfs a WEB"; Boolean)
        {

            trigger OnValidate()
            begin
                //ZZXAVI
                // if "Enviar pdfs a WEB" = true then begin
                //     FileManagement.CreateClientDirectory('F:\documentosweb\abonosweb\' + Format("No."));
                //     FileManagement.CreateClientDirectory('F:\documentosweb\albaranes\' + Format("No."));
                //     FileManagement.CreateClientDirectory('F:\documentosweb\facturasweb\' + Format("No."));
                // end;
            end;
        }
        field(50020; "Codigo Analisis"; Code[20])
        {
            TableRelation = "Grupos analisis".Codigo;
        }
        field(50021; "Nº pedido obligatorio"; Boolean)
        {
        }
        field(50022; "Servicio email"; Boolean)
        {
        }
        field(50023; "Usuario alta"; Code[20])
        {
            Editable = false;
            TableRelation = User;
        }
        field(50024; "Grupo dto. cliente 2"; Code[10])
        {
            Caption = 'Grupo dto. cliente 2';
            TableRelation = "Customer Discount Group";
        }
        field(50025; "Grupo dto. cliente 3"; Code[10])
        {
            Caption = 'Grupo dto. cliente 3';
            TableRelation = "Customer Discount Group";
        }
        field(50026; "Grupo dto. cliente 4"; Code[10])
        {
            Caption = 'Grupo dto. cliente 4';
            TableRelation = "Customer Discount Group";
        }
        field(50027; "Grupo dto. cliente 5"; Code[10])
        {
            Caption = 'Grupo dto. cliente 5';
            TableRelation = "Customer Discount Group";
        }
        field(50028; "Fecha clasificación A,B,C"; Date)
        {
            Editable = false;
        }
        field(50029; "Grupo clientes"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const("Grupo de clientes"));
        }
        field(50030; "Zona de ventas"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const("Zona de ventas"));
        }
        field(50031; "Observación para ALMACEN"; Text[60])
        {
        }
        field(50032; "Observación PDA"; Text[40])
        {
        }
        field(50036; "Clasificacion CRM"; Option)
        {
            OptionMembers = " ",A,B,C,D,E;
        }
        field(50037; "Nombre vendedor"; Text[50])
        {
            CalcFormula = lookup("Salesperson/Purchaser".Name where(Code = field("Salesperson Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50038; Borrado; Boolean)
        {
        }
        field(50041; "Telefono 2"; Text[20])
        {
        }
        field(50042; "Nº movil"; Text[20])
        {
        }
        field(50043; "Observación para transporte"; Text[80])
        {
        }
        field(50044; "Albaran sin detalle"; Boolean)
        {
        }
        field(50045; "Clasificación A,B,C Vendedor"; Option)
        {
            Editable = false;
            InitValue = " ";
            OptionMembers = A,B,C," ";
        }
        field(50046; "Fecha Clasi. A,B,C Vendedor"; Date)
        {
            Editable = false;
        }
        field(50048; "Contacto en factura"; Boolean)
        {
            InitValue = true;
        }
        field(50049; "No Enviar factura en exp."; Boolean)
        {
        }
        field(50050; "No Enviar albaran en exp."; Boolean)
        {
        }
        field(50052; "Correo elect. Comercial"; Text[50])
        {
            Caption = 'Correo elect. Comercial';
        }
        field(50054; "Estatus del cliente"; Option)
        {
            OptionCaption = 'Activo,Posible cliente,Transformado,Cerrado,Posible cliente WEB';
            OptionMembers = Activo,"Posible cliente",Transformado,Cerrado,"Posible cliente WEB";

            trigger OnValidate()
            begin

                /*
                IF (xRec."Estatus del cliente"<>0) AND ("Estatus del cliente"=0) THEN BEGIN
                     RecCust.RESET;
                     RecCust.SETCURRENTKEY(RecCust."VAT Registration No.");
                     RecCust.SETRANGE(RecCust."VAT Registration No.","VAT Registration No.");
                     IF RecCust.FINDFIRST THEN REPEAT
                          IF RecCust."No."<>"No." THEN BEGIN
                               IF CONFIRM('Este cliente ya existe en el codigo %1 %2, desea continuar ?',
                               FALSE,RecCust."No.",RecCust.Name) THEN BEGIN
                
                               END ELSE BEGIN
                                ERROR('Cambio no realizado. ');
                               END;
                          END;
                     UNTIL RecCust.NEXT=0;
                END;
                */

            end;
        }
        field(50055; "Incluir en propaganda"; Boolean)
        {
            InitValue = true;
        }
        field(50056; "No incluir portes"; Boolean)
        {
        }
        field(50058; "No enviar a EDICOM"; Boolean)
        {
        }
        field(50059; "Respeta agencia transporte"; Boolean)
        {
        }
        field(50060; "Importe impagado"; Decimal)
        {
            CalcFormula = sum("Cartera Doc."."Remaining Amt. (LCY)" where("Account No." = field("No."),
                                                                           "Bill Gr./Pmt. Order No." = filter(''),
                                                                           "Category Code" = const('IMPAGADO')));
            FieldClass = FlowField;
        }
        field(50061; "Importe vencido"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Remaining Amount (LCY) stats." where("Customer No." = field("No."),
                                                                                          "Due Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50062; "Tipo Factura SII"; Option)
        {
            OptionCaption = 'F1,F2';
            OptionMembers = F1,F2;
        }
        field(50064; "Respeta Tipo facturacion"; Boolean)
        {
        }
        field(50076; "No imprimir facturas"; Boolean)
        {
        }
        field(50082; "Email albaran sin detalle 2"; Text[50])
        {
        }
        field(50083; "Tipo de documento EDICOM"; Option)
        {
            OptionCaption = '351-Aviso de expedicion,35E-Aviso de devolucion,YA5-Expedicion CrossDocking';
            OptionMembers = "351-Aviso de expedicion","35E-Aviso de devolucion","YA5-Expedicion CrossDocking";
        }
        field(50084; "Funcion del mensaje EDICOM"; Option)
        {
            OptionCaption = '9-Original,1-Cancelacion,7-Duplicado,31-Copia,4-Cambio,5-Sustitucion';
            OptionMembers = "9-Original","1-Cancelacion","7-Duplicado","31-Copia","4-Cambio","5-Sustitucion";
        }
        field(50085; "Tipo transporte EDICOM"; Option)
        {
            OptionCaption = ' ,10-Transporte maritimo,20-Transporte ferroviario,30-Transporte por carretera,40-Transporte aereo,60-Transporte muitimodo';
            OptionMembers = " ","10-Transporte maritimo","20-Transporte ferroviario","30-Transporte por carretera","40-Transporte aereo","60-Transporte muitimodo";
        }
        field(50086; "IDENTIF EDICOM"; Option)
        {
            OptionCaption = 'X7-No viene identificado,X6-Sí esta identificado';
            OptionMembers = "X7-No viene identificado","X6-Sí esta identificado";
        }
        field(50100; "Email facturacion 1"; Text[60])
        {
        }
        field(50101; "Email facturacion 2"; Text[60])
        {
        }
        field(50102; "Email facturacion 3"; Text[60])
        {
        }
        field(50103; "Dias tolerancias fecha vto."; Integer)
        {
        }
        field(50104; "Mas comerciales"; Code[60])
        {
        }
        field(50105; "Grupo descuento mensual"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const("Grupo descuento mensual"));
        }
        field(50110; "No enviar emial de preparacion"; Boolean)
        {
        }
        field(50111; "Email albaran sin detalle 1"; Text[60])
        {
        }
        field(50112; "Factura ordenada"; Boolean)
        {
            InitValue = true;
        }
        field(50113; "Email abono 1"; Text[60])
        {
        }
        field(50114; "Email abono 2"; Text[60])
        {
        }
        field(50116; "Email pedido 1"; Text[60])
        {
        }
        field(50117; "Email pedido 2"; Text[60])
        {
        }
        field(50118; "Adjuntar pub. facturacion 1"; Boolean)
        {
        }
        field(50119; "Adjuntar pub. facturacion 2"; Boolean)
        {
        }
        field(50120; "Adjuntar pub. facturacion 3"; Boolean)
        {
        }
        field(50121; "Adjuntar pub. albaran sin det."; Boolean)
        {
        }
        field(50122; "Adjuntar pub. abono 1"; Boolean)
        {
        }
        field(50123; "Adjuntar pub. abono 2"; Boolean)
        {
        }
        field(50124; "Adjuntar pub. pedido 1"; Boolean)
        {
        }
        field(50125; "Adjuntar pub. pedido 2"; Boolean)
        {
        }
        field(50126; "Adjuntar pub. albaran 1"; Boolean)
        {
        }
        field(50127; "Adjuntar pub. albaran 2"; Boolean)
        {
        }
        field(50128; "Adjuntar pub. albaran 3"; Boolean)
        {
        }
        field(50129; "No imprimir albaran valorado"; Boolean)
        {
        }
        field(50130; "Nº serie factura registro"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50133; "Impresion fact. sin dto."; Boolean)
        {
        }
        field(50136; "Centro ECI"; Code[4])
        {
        }
        field(50137; "Factura con PVP"; Boolean)
        {
        }
        field(50140; Latitud; Text[30])
        {

            trigger OnValidate()
            begin

                ///ActualizazaMT2;
            end;
        }
        field(50141; Longitud; Text[30])
        {

            trigger OnValidate()
            begin

                /////ActualizazaMT2;
            end;
        }
        field(50144; Comunidad; Code[10])
        {
        }
        field(50145; "Factura CSV"; Boolean)
        {
        }
        field(50146; "Albaran CSV"; Boolean)
        {
        }
        field(50147; "Codigo cliente externo"; Code[20])
        {
        }
        field(50148; "Ruta envio CSV"; Text[70])
        {
        }
        field(50149; "Grupo ventas"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(GV));
        }
        field(50150; Nombre_Cliente; Text[70])
        {
        }
        field(50151; "Localizacion tienda"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(LT));
        }
        field(50152; "Tipo negocio"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(TN));
        }
        field(50153; "Año apertura"; Date)
        {
        }
        field(50154; "Ruta comercial"; Code[10])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const("Ruta comercial"));
        }
        field(50160; "A quien se factura"; Code[13])
        {
        }
        field(50161; "Quien pide"; Code[13])
        {
        }
        field(50162; "Central compradora"; Code[13])
        {
        }
        field(50163; "Quien paga"; Code[13])
        {
        }
        field(50164; "Sucrusal entrega"; Code[13])
        {
        }
        field(50165; "Ruta Pedido"; Text[50])
        {
        }
        field(50166; "Ruta Albaran"; Text[50])
        {
        }
        field(50167; "Ruta Factura"; Text[50])
        {
        }
        field(50168; "Check Clientes FTP"; Boolean)
        {
        }
        field(50169; "Receptor de la mercancía"; Code[13])
        {
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
        field(50175; "No agrupar en ADAIA"; Boolean)
        {
        }
        field(50176; "Permite fraccionar unidad de venta"; Boolean)
        {
        }
        field(50200; "Top produccto 1"; Code[12])
        {
            TableRelation = Item;
        }
        field(50201; "Top produccto 2"; Code[12])
        {
            TableRelation = Item;
        }
        field(50202; "Top produccto 3"; Code[12])
        {
            TableRelation = Item;
        }
        field(50203; "Top produccto 4"; Code[12])
        {
            TableRelation = Item;
        }
        field(50204; "Top produccto 5"; Code[12])
        {
            TableRelation = Item;
        }
        field(50205; "Top produccto 6"; Code[12])
        {
            TableRelation = Item;
        }
        field(50206; "Top produccto 7"; Code[12])
        {
            TableRelation = Item;
        }
        field(50207; "Top produccto 8"; Code[12])
        {
            TableRelation = Item;
        }
        field(50208; "Top produccto 9"; Code[12])
        {
            TableRelation = Item;
        }
        field(50209; "Top produccto 10"; Code[12])
        {
            TableRelation = Item;
        }
        field(50210; "Vta. Acuariofilia"; Decimal)
        {
        }
        field(50211; "Vta.Reptiles"; Decimal)
        {
        }
        field(50212; "Vta.Gatos"; Decimal)
        {
        }
        field(50213; "Vta.Perro"; Decimal)
        {
        }
        field(50214; "Vta.Roedores"; Decimal)
        {
        }
        field(50215; "Vta.Pajaros"; Decimal)
        {
        }
        field(50216; "Comentario factura"; Text[30])
        {
        }
        field(50294; "Importe ABC"; Decimal)
        {
        }
        field(50295; "Importe total ABC"; Decimal)
        {
        }
        field(50296; "% clasi A,B,C vendedor"; Decimal)
        {
        }
        field(50297; "Acumu. A,B,C vendedor"; Decimal)
        {
        }
        field(50298; "Importe ABC vendedor"; Decimal)
        {
        }
        field(50299; "Importe total ABC vendedor"; Decimal)
        {
        }
        field(50758; "NULO Tipo socio"; Option)
        {
            OptionCaption = 'Persona,Organizacion';
            OptionMembers = Persona,Organizacion;
        }
        field(50759; "Contraseña WEB"; Text[30])
        {

            trigger OnValidate()
            begin

                ///       Rec.VALIDATE(Rec."Enviar a Web",TRUE);
            end;
        }
        field(50760; "Nº proveedor"; Code[20])
        {
        }
        field(50761; "Usuario Web"; Text[60])
        {

            trigger OnValidate()
            begin
                /*
                
                IF Rec."Usuario Web"<>'' THEN BEGIN
                     RecCust.RESET;
                     RecCust.SETCURRENTKEY(RecCust."Usuario Web");
                     RecCust.SETRANGE(RecCust."Usuario Web",Rec."Usuario Web");
                     IF RecCust.FINDFIRST THEN BEGIN
                          ERROR('Este usuario WEB ya existe en el cliente nº %1.',RecCust."No.");
                     END;
                     Rec.VALIDATE(Rec."Enviar a Web",TRUE);
                END;
                */

            end;
        }
        field(50763; "Nombre para email"; Text[20])
        {
        }
        field(50764; "No email chimp"; Boolean)
        {
        }
        field(50766; "No incluir en ruta CRM"; Boolean)
        {
        }
        field(50767; "Atencion comercial"; Option)
        {
            OptionCaption = '1-Vista,2-Telefono,3-Telefono/Visita';
            OptionMembers = "1-Vista","2-Telefono","3-Telefono/Visita";
        }
        field(50768; "Catalogo Shopify"; Text[250])

        {
            CalcFormula = lookup("Customer Discount Group"."Catalogo Shopify" where(code = field("Customer Disc. Group")));
            FieldClass = FlowField;

        }
        field(50769; AlmaTenerife; Boolean)

        {

        }

        field(50770; "Discount%"; Decimal)
        {
            CalcFormula = lookup("Payment Terms"."Discount %" where(code = field("Payment Terms Code")));
            FieldClass = FlowField;



        }



        field(50999; "ContactoAInsertar"; code[100])
        {
            Caption = 'ContactoAInsertar', comment = 'NLB="YourLanguageText"';
            DataClassification = SystemMetadata;
        }
        field(60000; "Actualizar WEB"; Boolean)
        {
            Description = 'WEB1.00';
        }
        field(60001; "Enviar a Web"; Boolean)
        {
            Description = 'WEB1.00';
        }
        field(60004; "Enviar a Web Distribuidor"; Boolean)
        {
            Description = 'WEB1.00';

            trigger OnValidate()
            begin

                ///ActualizazaMT2;
            end;
        }
        field(60005; "Direccion Envio Habitual Store"; Boolean)
        {
        }
        field(60006; "Metros Establecimiento"; Option)
        {
            OptionCaption = ' ,20-50 Mts.,50-100 Mts.,100-300 Mts.,300-500 Mts.,Más de 500 mts.';
            OptionMembers = " ","20-50 Mts.","50-100 Mts.","100-300 Mts.","300-500 Mts.","Más de 500 mts.";
        }
        field(60007; "Números de Empleados"; Option)
        {
            OptionCaption = ' ,1,2,3,Más de 3';
            OptionMembers = " ","1","2","3","Más de 3";
        }
        field(60008; N1; Integer)
        {
            CalcFormula = count(Contact where("Company No." = field("No.")));
            FieldClass = FlowField;
        }
        field(60009; N2; Integer)
        {
            CalcFormula = count(Contact where("Company No." = field("Primary Contact No.")));
            FieldClass = FlowField;
        }
        field(60010; "Como nos conocio"; Code[2])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(WebComoCono));
        }
        field(60011; Perros; Code[2])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(WGI1));
        }
        field(60012; Gatos; Code[2])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(WGI2));
        }
        field(60013; Pajaros; Code[2])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(WGI3));
        }
        field(60014; Acuariofilia; Code[2])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(WGI4));
        }
        field(60015; Reptiles; Code[2])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(WGI5));
        }
        field(60016; "Pequeños animales"; Code[2])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(WGI6));
        }
        field(60017; Estanques; Code[2])
        {
            TableRelation = Multitabla.Codigo where(Tabla = const(WGI7));
        }
        field(66000; "Emite nuestras facturas"; Boolean)
        {
        }
        field(66001; "Cliente Inversion Sujeto Pasiv"; Boolean)
        {
        }
        field(50900; FechaHoraModificacionWeb; DateTime) { }

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

        field(50725; Plantilla_Cliente; Code[20])
        {
            TableRelation = "Customer Templ.";
            trigger OnValidate()

            Var
                RecCT: Record "Customer Templ.";
                CustomerTemplMgt: Codeunit "Customer Templ. Mgt.";

            Begin
                RecCT.Reset();
                RecCT.SetRange(Code, Plantilla_Cliente);
                IF RecCT.FindFirst() THEN BEGIN
                    CustomerTemplMgt.ApplyCustomerTemplate(Rec, RecCT);
                END;
            end;

        }




    }
    fieldgroups
    {
        addlast(DropDown; "Search Name") { }
        addlast(Brick; "Search Name") { }
    }
}