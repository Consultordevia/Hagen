tableextension 50040 InventorySetup extends "Inventory Setup"
{
    fields
    {
        field(50000; "% Venta Clasificación A"; Decimal)
        {
        }
        field(50001; "% Venta Clasificación B"; Decimal)
        {
        }
        field(50002; "% Venta Clasificación C"; Decimal)
        {
        }
        field(50003; "Ruta salida de_gestion"; Code[250])
        {
        }
        field(50004; "Ruta salida a_gestion"; Code[250])
        {
        }
        field(50005; "Ruta salida a_gestion copia"; Code[250])
        {
        }
        field(50006; "Producto cajas"; Code[20])
        {
            TableRelation = Item;
        }
        field(50007; "Producto palets"; Code[20])
        {
            TableRelation = Item;
        }
        field(50008; "Producto kilos"; Code[20])
        {
            TableRelation = Item;
        }
        field(50009; "Almacen ADAIA"; Code[2])
        {
        }
        field(50010; "Ruta pepe"; Code[250])
        {
        }
        field(50011; "ID."; Integer)
        {
        }
        field(50012; "Ultimo pedido importado"; Code[10])
        {
        }
        field(50013; "Recalcula permite pedido/Hora"; Integer)
        {
        }
        field(50014; "Hora proximo recalculo"; Time)
        {
        }
        field(50015; "Peso expedición pequeña PEPE"; Decimal)
        {
        }
        field(50016; "Peso expedición mediana PEPE"; Decimal)
        {
        }
        field(50017; "Peso expedición grande PEPE"; Decimal)
        {
        }
        field(50018; "Lineas ids"; Text[250])
        {
        }
        field(50019; "Volumen WEB"; Decimal)
        {
        }
        field(50083; "Ruta fichero COVALDROPER"; Text[80])
        {
        }
        field(50084; "Ruta fichero COVALDROPER COPIA"; Text[80])
        {
        }
        field(50500; "Log. cambios adaia"; Integer)
        {
        }
        field(50501; "Ruta salida incial adaia"; Code[250])
        {
        }
        field(50502; "Ruta edi-eci"; Code[250])
        {
        }
        field(50504; "Ruta edi-eci copia"; Code[250])
        {
        }
    }
}
