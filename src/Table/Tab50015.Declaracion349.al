#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50015 "Declaracion 349"
{

    fields
    {
        field(1;Declaracion;Code[6])
        {
        }
        field(2;Period;Option)
        {
            OptionMembers = "0A","01","02","03","04","05","06","07","08","09","10","11","12","1T","2T","3T","4T";
        }
        field(3;NLinea;Integer)
        {
        }
        field(100;NOperacion;Integer)
        {
        }
        field(199;Tipo;Option)
        {
            OptionMembers = Cliente,Proveedor;
        }
        field(200;FiscalYear;Code[4])
        {
        }
        field(201;VAT;Code[9])
        {
        }
        field(202;CIF;Code[20])
        {
        }
        field(203;Nombre;Text[40])
        {
        }
        field(204;Operacion;Code[1])
        {
        }
        field(205;Importe;Decimal)
        {
        }
        field(300;Facturas;Decimal)
        {
        }
        field(301;"Abonos del periodo";Decimal)
        {

            trigger OnLookup()
            begin
                /*
                CustomerVendorWarning349.RESET;
                CustomerVendorWarning349.SETRANGE(VAT,CIF);
                CustomerVendorWarning349.SETRANGE("Original Declaration Period",FORMAT(Period));
                CustomerVendorWarning349.SETRANGE("Original Declaration FY",FiscalYear);
                PAGE.RUNMODAL(PAGE::"correcciones 349",CustomerVendorWarning349);
                RecalculaImportes;
                */

            end;
        }
        field(402;"Importe Original";Decimal)
        {
        }
        field(403;"Importe Actual Corregido";Decimal)
        {
        }
        field(1000;"Abonos de otros periodos";Decimal)
        {

            trigger OnLookup()
            begin
                /*
                CustomerVendorWarning349.RESET;
                CustomerVendorWarning349.SETRANGE(VAT,CIF);
                CustomerVendorWarning349.SETFILTER("Original Declaration Period",'<>%1',FORMAT(Period));
                //CustomerVendorWarning349.SETFILTER("Original Declaration FY",'<>%1',FiscalYear);
                PAGE.RUNMODAL(PAGE::"correcciones 349",CustomerVendorWarning349);
                RecalculaImportes;
                */

            end;
        }
        field(1001;Registrada;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;Declaracion,Period,NLinea)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CustomerVendorWarning349: Record "Customer/Vendor Warning 349";

    local procedure RecalculaImportes()
    begin
        
        /*
        CustomerVendorWarning349.RESET;
        ///CustomerVendorWarning349.SETRANGE(VAT,CIF);
        CustomerVendorWarning349.SETRANGE("Original Declaration Period",FORMAT(Period));
        CustomerVendorWarning349.SETRANGE("Original Declaration FY",FiscalYear);
        IF CustomerVendorWarning349.FINDSET THEN;
        CustomerVendorWarning349.CALCSUMS(Importe);
        "Abonos del periodo" := CustomerVendorWarning349.Importe;
        Importe := Facturas - "Abonos del periodo";
        "Abonos de otros periodos" := 0;
        CustomerVendorWarning349.RESET;
        CustomerVendorWarning349.SETRANGE(VAT,CIF);
        IF CustomerVendorWarning349.FINDSET THEN
          REPEAT
            IF (CustomerVendorWarning349."Original Declaration FY" <> FiscalYear) OR
               (CustomerVendorWarning349."Original Declaration Period" <> FORMAT(Period)) THEN BEGIN
              "Abonos de otros periodos" += CustomerVendorWarning349.Importe;
            END;
          UNTIL CustomerVendorWarning349.NEXT = 0;
        MODIFY;
        
        
        
        */

    end;
}

