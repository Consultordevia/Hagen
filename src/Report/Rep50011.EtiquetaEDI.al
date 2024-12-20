
Report 50011 "Etiqueta EDI"
{
    Caption = 'Etiqueta EDI';
    RDLCLayout = './Layouts/EtiquetaEDI.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sales Header"; "Cajas por envio")
        {
            RequestFilterHeading = 'Sales Order';
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(Number);
                MaxIteration = 2;
                column(ReportForNavId_3; 3) { } // Autogenerated by ForNav - Do not delete
                column(No_SalesLine; "Sales Header".Nfac)
                {
                }
                column(SalesHeaderNoexpedicion; "Sales Header".Nfac)
                {
                }
                column(Ship_toName_SalesHeader; "Sales Header".Nfac)
                {
                }
                column(Picture_PROD1; PROD1.Picture)
                {
                }
                column(CANTI; CANTI)
                {
                }
                column(NALBA; NALBA)
                {
                }
                column(NBUL___FORMAT_SUNABUL; Format(NBUL) + ' / ' + Format(SUNABUL))
                {
                }
                column(Sell_toAddress_SalesHeader; SalesInvoiceHeader."Ship-to Address")
                {
                }
                column(Sell_toCustomerName_SalesHeader; SalesInvoiceHeader."Ship-to Name")
                {
                }
                column(Ship_toCounty_SalesHeader; SalesInvoiceHeader."Ship-to City")
                {
                }
                column(Ship_toAddress_SalesHeader; SalesInvoiceHeader."Ship-to Address 2")
                {
                }
                column(SalesHeaderShip_toPostCode__SalesHeaderShip_toCity; SalesInvoiceHeader."Ship-to City")
                {
                }
                column(Cantidad_; 'Cantidad:')
                {
                }
                column(ALBARAN; 'ALBARAN')
                {
                }
                column(Sell_toCounty_SalesHeader; SalesInvoiceHeader."Ship-to City")
                {
                }
                column(SalesHeaderShip_toPostCode__SalesHeaderSell_toCity; SalesInvoiceHeader."Ship-to City")
                {
                }
                column(Picture_PROD2; PROD2.Picture)
                {
                }
                column(CODART_; 'COD.ART:')
                {
                }
                column(YourReference_SalesHeader; SalesInvoiceHeader."Your Reference")
                {
                }
                column(REFECI_; 'REF. ECI:')
                {
                }
                column(PEDIDO; 'PEDIDO')
                {
                }
                column(V219_00; '219-00')
                {
                }
                column(DPTOPVENTA; 'DPTO.P.VENTA')
                {
                }
                column(CENTRO; CENTRO)
                {
                }
                column(Picture_PROD3; PROD3.Picture)
                {
                }
                trigger OnAfterGetRecord();
                begin
                    /*
					CONTAETI:=CONTAETI+1;
								   IF "Sales Line".Quantity>RecItem."Unidad expedicion ECI" THEN BEGIN
										 CANTI:=RecItem."Unidad expedicion ECI";
										 IF CONTAETI=NUMETIQ THEN BEGIN
											  CANTI:="Sales Line".Quantity-(NUMETIQ-1)*RecItem."Unidad expedicion ECI";
										 END;
								   END;
								   IF "Sales Line".Quantity<=RecItem."Unidad expedicion ECI" THEN BEGIN
										 CANTI:="Sales Line".Quantity;
								   END;
					IF CONTAETI>NUMETIQ THEN BEGIN
						 CurrReport.BREAK;
					END;
					NBUL:=NBUL+1;
					*/

                end;

            }
            trigger OnAfterGetRecord();
            begin
                /*
				CompanyInfo.GET;
				
				SalesInvoiceHeader.GET("Sales Header".Nfac);
				
				FormatAddr.SalesShptShipTo(CustAddr,"Sales Header");
				FormatAddr.Company(InfoEmpresa,CompanyInfo);
				CONTAETI:=0;
				CODIGO:='1001201230400263080001';
				nombreprepara:='';
				TELEFONO:='';
				IF RecCusto.GET("Sales Header"."Sell-to Customer No.") THEN BEGIN
					 TELEFONO:=RecCusto."Phone No.";
				END;
				transport:='';
				IF RecTra.GET("Sales Header"."Shipping Agent Code") THEN BEGIN
					 transport:=RecTra.Name;
				END;
				vendedor:='';
				IF RecVende.GET("Sales Header"."Salesperson Code") THEN BEGIN
					 vendedor:=RecVende.Name;
				END;
				tlinea:=0;
				;
				Rec37.SETRANGE(Rec37."Document No.","No.");
				IF Rec37.FINDFIRST THEN REPEAT
					 IF Rec37.Quantity>0 THEN BEGIN
						  tlinea:=tlinea+1;
					 END;
				UNTIL Rec37.NEXT = 0;
				CENTRO1:='01';
				IF RecEAD.GET("Sales Header"."Sell-to Customer No.","Sales Header"."Ship-to Code") THEN BEGIN
					 CENTRO1:=RecEAD."Cod. entrega ECI";
				END;
				CENTRO:=RecCusto."Centro ECI";
				DPTO:='21900';
				NPEDIDO:=COPYSTR("Sales Header"."Your Reference",1,8);
				////NALBA:=COPYSTR("Sales Header"."Order No.",2,3)+COPYSTR("Sales Header"."Order No.",6,4);
				NALBA:=COPYSTR("Sales Header"."Order No.",3,2)+COPYSTR("Sales Header"."Order No.",6,5);
				NALBA:=COPYSTR("Sales Header"."No.",1,2)+COPYSTR("Sales Header"."No.",3,5);
				
				IF STRLEN(NALBA)<7 THEN BEGIN
					 NALBA:='0'+NALBA;
				END;
				contador:=NALBA+'00';
				CODBAR:='98'+DPTO+NPEDIDO+NALBA;
				DESCODBAR:='(98) '+DPTO+NPEDIDO+NALBA;
				dcentro:='91'+CENTRO1+CENTRO;
				dcentro1:='(91) '+CENTRO1+CENTRO;
				SUNABUL:=0;
				REC371.RESET;
				///REC371.SETRANGE(REC371."Document Type","Sales Header"."Document Type");
				REC371.SETRANGE(REC371."Document No.","Sales Header"."No.");
				IF REC371.FINDFIRST THEN REPEAT
				IF REC371.Quantity<>0 THEN BEGIN
					 IF RecItem.GET(REC371."No.") THEN BEGIN
						  IF RecItem."Unidad expedicion ECI"<>0 THEN BEGIN
							   IF REC371.Quantity>RecItem."Unidad expedicion ECI" THEN BEGIN
									SUNABUL:=SUNABUL+ROUND(REC371.Quantity/RecItem."Unidad expedicion ECI",1,'>');
							   END;
							   IF REC371.Quantity<=RecItem."Unidad expedicion ECI" THEN BEGIN
									 SUNABUL:=SUNABUL+1;
							   END;
						  END;
					 END;
				END;
				UNTIL REC371.NEXT=0;
				*/

            end;

        }
    }
    requestpage
    {
        SaveValues = false;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ForNavOpenDesigner; ReportForNavOpenDesigner)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Design';
                        Visible = ReportForNavAllowDesign;
                    }
                }
            }
        }

    }

    trigger OnInitReport()
    begin



    end;

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin

    end;

    var
        Text000: label 'Work Order';
        Text001: label 'Sales Order No.';
        Text002: label 'Quantity used during work (Posted with the Sales Order)';
        Text003: label 'Quantity Used';
        Text004: label 'Comments';
        Text005: label 'Extra Item/Resource used during work (Posted with Item or Resource Journals)';
        ExcelBuf: Record "Excel Buffer" temporary;
        FormatAddr: Codeunit "Format Address";
        CustAddr: array[8] of Text[50];
        InfoEmpresa: array[8] of Text[30];
        PrintToExcel: Boolean;
        Text006: label 'Date';
        ESTANTE: Code[20];
        RecItem: Record Item;
        STOCK: Decimal;
        CompanyInfo: Record "Company Information";
        nombreprepara: Text[30];
        RecMulti: Record Multitabla;
        TELEFONO: Text[30];
        RecCusto: Record Customer;
        transport: Text[30];
        RecTra: Record "Shipping Agent";
        vendedor: Text[30];
        RecVende: Record "Salesperson/Purchaser";
        RecLC: Record "Sales Comment Line";
        Tex: array[4] of Text[255];
        conta: Integer;
        Rec37: Record "Sales Shipment Line";
        REC371: Record "Sales Shipment Line";
        tlinea: Decimal;
        CODIGO: Code[80];
        codebar: Code[23];
        ok: Integer;
        C1: Code[2];
        CENTRO: Code[4];
        DPTO: Code[5];
        NPEDIDO: Code[8];
        NALBA: Code[7];
        CODBAR: Code[28];
        DESCODBAR: Code[50];
        NBUL: Integer;
        TOTALBUL: Integer;
        prod: Record Item;
        RecEAD: Record "Ship-to Address";
        CENTRO1: Code[2];
        dcentro: Code[20];
        dcentro1: Code[20];
        nueva: Code[30];
        nueva1: Code[30];
        cantidad: Decimal;
        contador: Code[9];
        dc: Code[1];
        DIG1: array[17] of Code[1];
        DIG2: array[17] of Integer;
        SUMA1: Integer;
        XX: Integer;
        SUMA2: Integer;
        RESTO: Integer;
        SUNABUL: Decimal;
        PROD1: Record Item;
        PROD2: Record Item;
        PROD3: Record Item;
        rut: Text[255];
        NUMETIQ: Integer;
        CONTAETI: Integer;
        CANTI: Decimal;
        WindowStyle: Integer;
        WaitForEnd: Boolean;
        ReturnValue: Integer;
        SalesInvoiceHeader: Record "Sales Invoice Header";

    procedure EncodeBarcode128(pText: Text[250]) RetVal: Text[250]
    var
        Checksum: Integer;
        i: Integer;
        currentchar: Char;
        StartChar: Char;
        StopChar: Char;
        ChecksumChar: Char;
    begin
        // How to encode a 128 barcode:
        //
        // Each character has a value ranging from 0 to 105. This value is used to calculate the check
        // character for each symbol.
        //
        // The check character is a Modulus 103 Checksum that is calculated by summing the start code
        // value plus the product of each character position (most significant character position equals 1)
        // and the character value of the character at that position. This sum is divided by 103. The
        // remainder of the answer is the value of the Check Character (which can be looked up from the
        // table). Every encoded character is included except the Stop and Check Character.
        //
        //
        // Example: BarCode 1
        // Message : Start B   B   a   r   C   o   d   e	  1
        // Value	  104	  34  65  82  35  79  68  69  0  17
        // Position:   -	   1   2   3   4   5   6   7   8  9
        // Calculate Total: 104 + (34x1) + (65x2) + (82x3) + (35x4) + (79x5) +
        //				  (68x6) + (69x7) + (0x8) + (17x9) = 2093
        // 2093/103 = 20 remainder 33
        // 33 = A
        // Final message: (Start B)BarCode 1(A)(STOP)
        StartChar := '┌';
        StopChar := '▄';
        Checksum := 104;
        for i := 1 to StrLen(pText) do begin
            currentchar := pText[i];
            Checksum := Checksum + (i * (currentchar - 32));
        end;
        ChecksumChar := Checksum MOD 103;
        ChecksumChar := ChecksumChar + 32;
        // convert SPACE to ALT+0128
        pText := ConvertStr(pText, ' ', '░');
        RetVal := StrSubstNo('%1%2%3%4', StartChar, pText, ChecksumChar, StopChar);
        exit(RetVal);
    end;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        ReportForNavOpenDesigner: Boolean;
        ReportForNavAllowDesign: Boolean;

}
