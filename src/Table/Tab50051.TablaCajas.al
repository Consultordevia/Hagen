table 50051 TablaCajas
{
    Caption = 'TablaCajas';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Sku; Code[20])
        {
            Caption = ' Sku';
        }
        field(2; "Producto web"; Boolean)
        {
            Caption = 'Producto web';
        }
        field(3; "El producto es Caja"; Boolean)
        {
            Caption = 'El producto es Caja';
        }
        field(4; "Descripcion"; Text[100])
        {
            Caption = 'Descripcion';
        }
        field(5; "Unidad de medida"; code[20])
        {
            Caption = 'Unidad de medida';
        }
        field(6; "Precio unitario"; Decimal)
        {
            Caption = 'Precio unitario';
        }
        field(7; "Ean"; code[20])
        {
            Caption = 'Ean';
        }
        field(8; "Stock"; Decimal)
        {
            Caption = 'Stock"';
            DecimalPlaces = 0 : 0;
        }
        field(9; "Unidades venta"; Decimal)
        {
            Caption = 'Unidades venta';
        }
        field(10; "Cantidad x caja"; Decimal)
        {
            Caption = 'Cantidad x caja';
        }
        field(11; "Criterio de Rotacion"; code[20])
        {
            Caption = 'Criterio de Rotacion';
        }
        field(12; "Proxima fecha de llegada"; Date)
        {
            Caption = 'Proxima fecha de llegada';
        }
        field(13; "Producto padre"; code[20])
        {
            Caption = 'Producto padre';
        }
        field(14; "Estado web Inactivo"; Boolean)
        {
            Caption = 'Estado web Inactivo';
        }
        field(15; "Voluminoso web"; Decimal)
        {
            Caption = 'Voluminoso web';
        }
        field(16; "IVA IGIC Canario"; code[20])
        {
            Caption = 'IVA IGIC Canario';
        }
        field(17; "Alto"; Decimal)
        {
            Caption = 'Alto';
        }
        field(18; "Ancho"; Decimal)
        {
            Caption = 'Ancho';
        }
        field(19; "Largo"; Decimal)
        {
            Caption = 'Largo';
        }
        field(20; "Peso"; Decimal)
        {
            Caption = 'Peso';
        }
        field(21; "Volumen"; Decimal)
        {
            Caption = 'Volumen';
        }
        field(22; "Descricion marca"; Text[100])
        {
            Caption = 'Descricion marca';
        }
        field(23; "Iva"; Decimal)
        {
            Caption = 'Iva';
        }
        field(24; "NombreUtem Categoria"; Text[100])
        {
            Caption = 'NombreUtem Categoria';
        }
        field(25; "Atributo Variante1"; Text[100])
        {
            Caption = 'Atributo Variante1';
        }
        field(26; "Valor Atributo Variante1"; Text[100])
        {
            Caption = 'Valor Atributo Variante1';
        }
        field(27; "Atributo Variante2"; Text[100])
        {
            Caption = 'Atributo Variante2';
        }
        field(28; "Valor Atributo Variante2"; Text[100])
        {
            Caption = 'Valor Atributo Variante2';
        }

        field(29; "Umbral de Stock"; Text[100])
        {
            Caption = 'Umbral de Stock';
        }
        field(30; "Criterio Rotacion"; Option)
        {
            Caption = 'Criterio Rotacion';
            InitValue = FE;
            OptionMembers = FC,FE,FF,LO;
        }
        field(31; "Umbral Stock"; Decimal)
        {
            Caption = 'Umbral Stock';
        }
        field(32; "Voluminoso  web"; Boolean)
        {
            Caption = 'Voluminoso web';
        }



    }
    keys
    {
        key(Key1; Sku)
        {
            Clustered = true;
        }
    }
}
