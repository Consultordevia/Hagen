tableextension 50106 RequisitionLine extends "Requisition Line"
{
    fields
    {
        field(50000; "Dispo.actual"; Code[10])
        {
        }
        field(50001; "Dispo.futura"; Code[10])
        {
        }
        field(50002; "Línea"; Code[10])
        {
        }
        field(50003; Clasificacion; Code[10])
        {
        }
        field(50004; "Intervalo-12"; Decimal)
        {
        }
        field(50005; "Intervalo-11"; Decimal)
        {
        }
        field(50006; "Intervalo-10"; Decimal)
        {
        }
        field(50007; "Intervalo-9"; Decimal)
        {
        }
        field(50008; "Intervalo-8"; Decimal)
        {
        }
        field(50009; "Intervalo-7"; Decimal)
        {
        }
        field(50010; "Intervalo-6"; Decimal)
        {
        }
        field(50011; "Intervalo-5"; Decimal)
        {
        }
        field(50012; "Intervalo-4"; Decimal)
        {
        }
        field(50013; "Intervalo-3"; Decimal)
        {
        }
        field(50014; "Intervalo-2"; Decimal)
        {
        }
        field(50015; "Intervalo-1"; Decimal)
        {
        }
        field(50016; Total; Decimal)
        {
        }
        field(50017; Coste; Decimal)
        {
        }
        field(50018; Stock; Decimal)
        {
        }
        field(50019; Contenedor; Decimal)
        {
        }
        field(50020; Fecha; Date)
        {
        }
        field(50021; Pedido; Decimal)
        {
        }
        field(50022; Fecha2; Date)
        {
        }
        field(50023; Media; Decimal)
        {
        }
        field(50024; "Tot.disp.mes"; Decimal)
        {
        }
        field(50025; "Tot.disp.fut."; Decimal)
        {
        }
        field(50026; "Unidad de compra"; Decimal)
        {
        }
        field(50027; "Cantidad palet"; Decimal)
        {
        }
        field(50028; Propuesta; Decimal)
        {
        }
        field(50029; "Fecha lanzamiento"; Date)
        {
        }
        field(50030; "Sin stock"; Code[10])
        {
        }
        field(50031; "Meses media"; Decimal)
        {
        }
        field(50032; "Stock Futuro"; Decimal)
        {
        }
        field(50033; "Para dias stock"; Decimal)
        {
        }
        field(50034; "Para dias futuro"; Decimal)
        {
        }
        field(50035; "Para dias propuesta"; Decimal)
        {
        }
        field(50036; "Media dia de ult. x meses"; Decimal)
        {
        }
        field(50037; "Dias rearov."; DateFormula)
        {
        }
        field(50038; Pedir; Boolean)
        {
        }
        field(50039; "Cantidad master"; Decimal)
        {
        }
        field(50040; "Cantidad en presupuestos"; Decimal)
        {
        }
        field(50041; "Presupuesto-12"; Decimal)
        {
        }
        field(50042; "Presupuesto-11"; Decimal)
        {
        }
        field(50043; "Presupuesto-10"; Decimal)
        {
        }
        field(50044; "Presupuesto-9"; Decimal)
        {
        }
        field(50045; "Presupuesto-8"; Decimal)
        {
        }
        field(50046; "Presupuesto-7"; Decimal)
        {
        }
        field(50047; "Presupuesto-6"; Decimal)
        {
        }
        field(50048; "Presupuesto-5"; Decimal)
        {
        }
        field(50049; "Presupuesto-4"; Decimal)
        {
        }
        field(50050; "Presupuesto-3"; Decimal)
        {
        }
        field(50051; "Presupuesto-2"; Decimal)
        {
        }
        field(50052; "Presupuesto-1"; Decimal)
        {
        }
        field(50053; "Canridad en pedidos venta"; Decimal)
        {
        }
        field(50054; "Fecha oferta 1"; Date)
        {
        }
        field(50055; "Pedido oferta 1"; Decimal)
        {
        }
        field(50056; "Fecha oferta 2"; Date)
        {
        }
        field(50057; "Pedido oferta 2"; Decimal)
        {
        }
        field(50058; "Fecha oferta 3"; Date)
        {
        }
        field(50059; "Pedido oferta 3"; Decimal)
        {
        }
        field(50060; "Fecha oferta 4"; Date)
        {
        }
        field(50061; "Pedido oferta 4"; Decimal)
        {
        }
        field(50062; "Fecha contenedor 1"; Date)
        {
        }
        field(50063; "Pedido contenedor 1"; Decimal)
        {
        }
        field(50064; "Fecha contenedor 2"; Date)
        {
        }
        field(50065; "Pedido contenedor 2"; Decimal)
        {
        }
        field(50117; "Observaciones AMAZON"; Text[40])
        {
            CalcFormula = lookup(Item."Observaciones AMAZON" where("No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }

    }
}
