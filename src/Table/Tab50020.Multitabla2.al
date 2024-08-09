#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50020 "Multitabla 2"
{

    fields
    {
        field(1; Tabla; Option)
        {
            OptionCaption = 'Referenciado,Permitir pedido,Estadistica cliente,Ficha web,Repuestos web,Relacionado web,ClasificaCliente,ProductoCliente,ProductoAtributo,LineasNegoWEB,VariosRepres,RutaCodPost,URLImagenes,WebGradoInt,WebMarca,GDC,FamiliaCatit,SubfailiaCatit,CajasPedido,Venta cruzada WEB';
            OptionMembers = Referenciado,"Permitir pedido","Estadistica cliente","Ficha web","Repuestos web","Relacionado web",ClasificaCliente,ProductoCliente,ProductoAtributo,LineasNegoWEB,VariosRepres,RutaCodPost,URLImagenes,WebGradoInt,WebMarca,GDC,FamiliaCatit,SubfailiaCatit,CajasPedido,"Venta cruzada WEB";
        }
        field(2; "Código 1"; Code[20])
        {
            TableRelation = if (Tabla = const(Referenciado)) Item."No."
            else if (Tabla = const("Permitir pedido")) Item."No."
            else if (Tabla = const("Estadistica cliente")) Customer."No."
            else if (Tabla = const("Ficha web")) Item."No."
            else if (Tabla = const("Repuestos web")) Item."No."
            else if (Tabla = const("Relacionado web")) Item."No."
            else if (Tabla = const(ClasificaCliente)) Customer."No."
            else if (Tabla = const(RutaCodPost)) Multitabla.Código where(Tabla = const("Ruta comercial"))
            else if (Tabla = const(WebGradoInt)) Customer."No."
            else if (Tabla = const(WebMarca)) Customer."No."
            else if (Tabla = const(GDC)) Customer."No.";
        }
        field(3; "Código 2"; Code[20])
        {
            TableRelation = if (Tabla = const(Referenciado)) Multitabla.Código where(Tabla = const("Grupo de clientes"))
            else if (Tabla = const("Permitir pedido")) Multitabla.Código where(Tabla = const("Grupo de clientes"))
            else if (Tabla = const("Estadistica cliente")) "Gen. Product Posting Group".Code where(Estadistica = const(true))
            else if (Tabla = const("Repuestos web")) Item."No."
            else if (Tabla = const("Relacionado web")) Item."No."
            else if (Tabla = const(ClasificaCliente)) Multitabla.Código where(Tabla = const("Clasificacion WEB"))
            else if (Tabla = const(RutaCodPost)) "Post Code".Code
            else if (Tabla = const(GDC)) "Customer Discount Group".Code
            else if (Tabla = const(CajasPedido)) "Tipo caja"."Tipo caja"
            else if (Tabla = const("Venta cruzada WEB")) Item."No.";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;

            trigger OnValidate()
            begin
                /*
                
                IF Tabla<>6 THEN BEGIN
                IF RecItem.GET("Código 2") THEN BEGIN
                     "Descripcion tecnica":=RecItem.Description;
                END;
                END;
                
                
                
                IF "Código 2"<>'' THEN BEGIN
                     RecMT22.CHANGECOMPANY('PEPE');
                     RecMT22.RESET;
                     RecMT22.SETRANGE(RecMT22.Tabla,4);
                     RecMT22.SETRANGE(RecMT22."Código 1",Rec."Código 1");
                     RecMT22.SETRANGE(RecMT22."Código 2",Rec."Código 2");
                     IF NOT RecMT22.FINDFIRST THEN REPEAT
                ///          RecMT22:=Rec;
                ///          RecMT22.INSERT;
                     UNTIL RecMT22.NEXT=0;
                
                END;
                
                IF Tabla=11 THEN BEGIN
                     IF "Código 2"<>'' THEN BEGIN
                          Customer.RESET;
                          Customer.SETCURRENTKEY(Customer."Post Code");
                          Customer.SETRANGE(Customer."Post Code","Código 2");
                          IF Customer.FINDFIRST THEN REPEAT
                               Customer."Ruta comercial":="Código 1";
                               Customer.MODIFY;
                          UNTIL Customer.NEXT=0;
                     END;
                END;
                */

            end;
        }
        field(4; "Descripcion 1"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Código 1")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Descripcion 2"; Text[70])
        {
            CalcFormula = lookup(Multitabla.Descripción where(Código = field("Código 2"),
                                                               Tabla = const("Grupo de clientes")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Venta global"; Decimal)
        {
        }
        field(7; "Venta grupos"; Decimal)
        {
        }
        field(8; "Stock actual"; Decimal)
        {
        }
        field(9; "Para dias general"; Integer)
        {
        }
        field(10; "Para dias grupos"; Integer)
        {
        }
        field(11; "Pedido contenedor"; Decimal)
        {
        }
        field(12; "Fecha pedido contenedor"; Date)
        {
        }
        field(13; "Venta diaria general"; Decimal)
        {
        }
        field(14; "Venta diaria grupo"; Decimal)
        {
        }
        field(15; "Bloquear a dias"; DateFormula)
        {
        }
        field(16; "Proveedor ref."; Code[20])
        {
        }
        field(17; Reservar; Boolean)
        {
        }
        field(18; "No permite pedido"; Boolean)
        {
            CalcFormula = lookup(Item."No permite pedido" where("No." = field("Código 1")));
            FieldClass = FlowField;
        }
        field(19; "Dias para llegada"; Decimal)
        {
        }
        field(20; "Venta de contenedor"; Decimal)
        {
        }
        field(21; NombreAtributo; Text[64])
        {
        }
        field(22; ValorAtributo; Text[64])
        {
        }
        field(50000; Vendedor; Code[10])
        {
            TableRelation = Multitabla.Vendedor where(Tabla = const("Ruta comercial"),
                                                       Código = field("Código 1"));
        }
        field(50005; "Importe minimo para descuento"; Decimal)
        {
        }
        field(50006; "Descuento a aplicar"; Decimal)
        {
        }
        field(50018; "Estado Producto"; Option)
        {
            CalcFormula = lookup(Item."Estado Producto" where("No." = field("Código 1")));
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = Activo,Descatalogado,Anulado,Liquidacion,"Disminución",Toxico;
        }
        field(50019; "Porcentaje encuesta"; Decimal)
        {
        }
        field(50020; "Importe Venta"; Decimal)
        {
        }
        field(50021; "Porcentaje Real"; Decimal)
        {
        }
        field(50022; "Descripcion tecnica"; Text[250])
        {
        }
        field(50023; "Descripcion WEB"; Text[250])
        {
        }
        field(50024; "Descripcion WEB2"; Text[250])
        {
        }
        field(50025; "Por defecto"; Boolean)
        {
        }
        field(50026; "Nombre cliente"; Code[100])
        {
            CalcFormula = lookup(Customer."Search Name" where("No." = field("Código 2")));
            FieldClass = FlowField;
        }
        field(60000; "Actualizar WEB"; Boolean)
        {
        }
        field(60001; Linea; Integer)
        {
        }
        field(60002; "Eliminar de WEB"; Boolean)
        {
        }
        field(60004; "Fecha eliminar"; Date)
        {
        }
        field(60005; "Orden de LineasNegoWEB"; Integer)
        {
        }
        field(60006; "URL IMAGEN 1"; Text[250])
        {
        }
        field(60007; "URL IMAGEN 2"; Text[250])
        {
        }
        field(60008; "URL IMAGEN 3"; Text[250])
        {
        }
        field(60009; "URL IMAGEN 4"; Text[250])
        {
        }
        field(60010; "Valor Grado interes"; Integer)
        {
        }
        field(60011; "Descripcion Grado interes"; Text[50])
        {
            CalcFormula = lookup(Multitabla.Descripción where(Tabla = const(WebGradoInt),
                                                               Código = field("Código 2")));
            FieldClass = FlowField;
        }
        field(60012; "Descripcion Marca"; Text[50])
        {
            CalcFormula = lookup(Multitabla.Descripción where(Tabla = const(WebMarca),
                                                               Código = field("Código 2")));
            FieldClass = FlowField;
        }
        field(60013; "Marca Interes"; Boolean)
        {
        }
        field(60014; "Cantidad en pedido"; Decimal)
        {
        }
        field(60015; "Cantidad caja"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; Tabla, "Código 1", "Código 2")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

