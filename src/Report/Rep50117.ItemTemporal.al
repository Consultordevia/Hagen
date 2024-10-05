#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50117 ItemTemporal
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ItemTemporal.rdlc';

    dataset
    {
        dataitem("Item temp"; "Item temp")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(Ean; "Item temp"."No. 2")
            {
            }
            column(Referencia; "Item temp"."No.")
            {
            }
            column(Descripcion; "Item temp".Description)
            {
            }
            column(Estado; "Item temp"."Description 2")
            {
            }
            column(Linea; "Item temp"."Gen. Prod. Posting Group")
            {
            }
            column(Familia; "Item temp".Familia)
            {
            }
            column(Tarifa; "Item temp"."Unit Price")
            {
            }
            column(PVPR; "Item temp"."Unit Cost")
            {
            }
            column(Disponibilidad; "Item temp"."Maximum Inventory")
            {
            }
            column(Unidad_minima_compra; "Item temp"."Unidad compra")
            {
            }
            column(Fecha_Prox; "Item temp"."Descripcion web")
            {
            }
            column(Pesos; "Item temp"."Units per Parcel")
            {
            }
            column(Largo; "Item temp"."Gross Weight")
            {
            }
            column(Alto; "Item temp"."Minimum Order Quantity")
            {
            }
            column(Ancho; "Item temp"."Maximum Order Quantity")
            {
            }
            column(Volumen; "Item temp"."Safety Stock Quantity")
            {
            }
            column(Marca; "Item temp"."Tariff No.")
            {
            }
            column(URL_imagen; "Item temp"."URL IMAGEN 1")
            {
            }
            column(Iva; "Item temp"."Vendor No.")
            {
            }
            column(Fecha_Lanzamiento; "Item temp"."Last Date Modified")
            {
            }
            column(grip; "Item temp"."IVA IGIC")
            {
            }
            column(Cantidad_1; "Item temp".Cantidad_1)
            {
            }
            column(Descuento_1; "Item temp".Descuento_1)
            {
            }
            column(Cantidad_2; "Item temp".Cantidad_2)
            {
            }
            column(Descuento_2; "Item temp".Descuento_2)
            {
            }
            column(Cantidad_3; "Item temp".Cantidad_3)
            {
            }
            column(Descuento_3; "Item temp".Descuento_3)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

