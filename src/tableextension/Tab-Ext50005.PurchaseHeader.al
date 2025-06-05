tableextension 50005 PurchaseHeader extends "Purchase Header"
{

    
    fields
    {

         modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            var
                RecVendor: Record Vendor;
            begin
                if RecVendor.get("Buy-from Vendor No.") then begin                     
                    if PurchHeader."Document Type" <> PurchHeader."Document Type"::"Credit Memo" then begin
                        
                        Rec."Invoice Type" := RecVendor."Invoice Type";
                    end;
                    if PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo" then begin
                        
                        Rec."Cr. Memo Type" := RecVendor."Cr. Memo Type";
                    end;
                    Rec."Special Scheme Code" := RecVendor."Special Scheme Code";
                    Rec."Correction Type" := RecVendor."Correction Type";
                    Rec."Do Not Send To SII" := RecVendor."Do Not Send To SII";
                    Rec."Entry Point":=RecVendor."Entry Point";



                end;

            end;
        }
        field(50000; "Importe pedido"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Line Amount" where("Document Type" = field("Document Type"),
                                                                   "Document No." = field("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Importe Pdte. pedido"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Amount (LCY)" where("Document Type" = field("Document Type"),
                                                                                "Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50002; BL; Code[20])
        {
        }
        field(50003; "Nº contenedor"; Code[20])
        {
        }
        field(50004; Kilos; Decimal)
        {
        }
        field(50006; "E.T.Departure"; Date)
        {
        }
        field(50007; "E.T.Arrival"; Date)
        {

            trigger OnValidate()
            begin

                /////VALIDATE("Expected Receipt Date","E.T.Arrival");
            end;
        }
        field(50008; "Recepción Documentos"; Boolean)
        {

            trigger OnValidate()
            begin

                "Fecha recepción docs." := Today;
            end;
        }
        field(50009; "Fecha recepción docs."; Date)
        {
            Editable = false;
        }
        field(50010; "Envio docs. aduana"; Boolean)
        {

            trigger OnValidate()
            begin

                "Fecha envio docs. aduana" := Today;
            end;
        }
        field(50011; "Fecha envio docs. aduana"; Date)
        {
            Editable = false;
        }
        field(50012; "Fletes estimado"; Decimal)
        {
        }
        field(50013; "Fecha de despacho"; Date)
        {
        }
        field(50014; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(50015; "Código importación"; Code[10])
        {
        }
        field(50016; DUA; Text[30])
        {
        }
        field(50017; "Fecha dua"; Date)
        {
        }
        field(50018; "Nº meses a periodificar"; Integer)
        {
        }
        field(50020; "TIEN LI"; Boolean)
        {
            CalcFormula = exist("Purchase Line" where("Document Type" = field("Document Type"),
                                                       "Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50021; "Nº doc. factura proveedor"; Code[20])
        {

            trigger OnValidate()
            begin
                "Vendor Invoice No." := "Nº doc. factura proveedor";
            end;
        }
        field(50022; "Fecha llegada puerto"; Date)
        {
        }
        field(50035; "Permite multiplos distintos"; Boolean)
        {
            trigger OnValidate()
            var
                usersetup: Record "User Setup";
            begin

                UserSetup.Get(UserId);
                if not UserSetup."Permite fraccionar uni. venta" then begin
                    Error('No se puede modificar este campo.');
                end;
            end;
        }
        field(50050; "Enviado adaia"; Boolean)
        {
        }
        field(50051; "Fecha enviado adaia"; Date)
        {
        }
        field(50052; "Usuario enviado adaia"; Code[20])
        {
        }
        field(50053; "Puerto salida"; Text[30])
        {
        }
        field(50054; "nulo Dua."; Text[30])
        {
        }
        field(50055; "nulp Base IVA aduanas"; Decimal)
        {
        }
        field(50056; "nulo % iva importacion"; Decimal)
        {
        }
        field(50116; "Incremento flete euros"; Decimal)
        {
        }
        field(50117; "Incremento aduana euros"; Decimal)
        {
        }
        field(50118; "tiene lineas"; Boolean)
        {
            CalcFormula = exist("Purchase Line" where("Document Type" = field("Document Type"),
                                                       "Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50119; "cantidad pdte"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Quantity" where("Document Type" = field("Document Type"),
                                                                            "Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50120; "Oferta para permite pedido"; Boolean)
        {
        }
        field(59008; "Base imponible"; Decimal)
        {
            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
            begin



                // -AQ16.ORA.00020.01-08-16.ORA: T38 Cab. Compra-Campo 59008 - Base imponible - Creamos la linea 10000 en la T39 Lin. Compra, con la cuanta que tiene asociado dicho proveedor



                if "Document Type" = "document type"::Invoice then begin

                    if "Vendor Invoice No." = '' then begin

                        Error('No tiene nº de documento');

                    end;

                end;

                "No cuenta gasto" := TestCuentaproveedor("No cuenta gasto");

                if "No cuenta gasto" = '' then
                    exit;



                if PurchaseLine.Get("Document Type", "No.", 10000) then begin

                    if PurchaseLine."Outstanding Quantity" = PurchaseLine.Quantity then begin

                        PurchaseLine.Delete;

                    end;

                end;



                PurchaseLine.Init;

                PurchaseLine."Document Type" := "Document Type";

                PurchaseLine."Document No." := "No.";

                PurchaseLine."Line No." := 10000;

                PurchaseLine."Buy-from Vendor No." := "Buy-from Vendor No.";

                PurchaseLine.Validate(Type, 1);//Rec39.Type::"G/L Account"

                PurchaseLine.Validate(PurchaseLine."No.", "No cuenta gasto");

                PurchaseLine.Validate(PurchaseLine.Quantity, 1);

                PurchaseLine.Validate(PurchaseLine."Direct Unit Cost", "Base imponible");

                PurchaseLine.Insert;



                // +AQ16.ORA.00020.01-08-1
            end;

        }
        field(59009; "No cuenta gasto"; Code[20])
        {
            trigger OnValidate()
            var
                LINEANUEVA: Integer;
                PurchaseLine: Record "Purchase Line";
            begin


                if "Document Type" = "document type"::Invoice then begin
                    if "Vendor Invoice No." = '' then begin
                        Error('No tiene nº de documento');
                    end;
                end;

                TestCuentaproveedor("No cuenta gasto");

                LINEANUEVA := 0;
                PurchaseLine.Reset;
                PurchaseLine.SetRange("Document Type", "Document Type");
                PurchaseLine.SetRange("Document No.", "No.");
                if PurchaseLine.FindLast then begin
                    LINEANUEVA := PurchaseLine."Line No." + 10000;

                end;


                PurchaseLine.Init;
                PurchaseLine."Document Type" := "Document Type";
                PurchaseLine."Document No." := "No.";
                PurchaseLine."Line No." := LINEANUEVA;
                PurchaseLine."Buy-from Vendor No." := "Buy-from Vendor No.";
                PurchaseLine.Validate(Type, 1);//Rec39.Type::"G/L Account"
                PurchaseLine.Validate(PurchaseLine."No.", Rec."No cuenta gasto");
                PurchaseLine.Validate(PurchaseLine.Quantity, 1);
                PurchaseLine.Validate(PurchaseLine."Direct Unit Cost", "Base imponible");
                PurchaseLine.Insert;
            end;

        }
    }

    local procedure TestCuentaproveedor(NoCuenta: Code[20]): Code[20]
    var
        Cuentasdeproveedores: Record "Cuentas de proveedores";
        Vendor: Record Vendor;
    begin

        if NoCuenta <> '' then
            exit(NoCuenta);
        Vendor.Get("Buy-from Vendor No.");
        Cuentasdeproveedores.SetRange(Proveedor, "Buy-from Vendor No.");

        if (Vendor."Cuenta de gasto" = '') and not Cuentasdeproveedores.FindLast then begin
            Message('Este proveedor no tiene cuenta de gasto asociada.');

        end else if

          Vendor."Cuenta de gasto" <> '' then
                exit(Vendor."Cuenta de gasto")

        else
            exit(Cuentasdeproveedores.Cuenta);
    end;
}
