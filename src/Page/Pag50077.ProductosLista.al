#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50077 "Productos Lista"
{
    PageType = List;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = Basic;
                }
                field("Kgs. de plástico"; Rec."Kgs. de plástico")
                {
                    ApplicationArea = Basic;
                    Caption = 'Gramos de plástico';
                }
                field("RII-AAEE"; Rec."RII-AAEE")
                {
                    ApplicationArea = Basic;
                }
                field("Existencia TENERIFE"; Rec."Existencia TENERIFE")
                {
                    ApplicationArea = Basic;
                }
                field("Observaciones AMAZON"; Rec."Observaciones AMAZON")
                {
                    ApplicationArea = Basic;
                }
                field("Stock Bloqueo Amz"; Rec."Stock Bloqueo Amz")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha Lanzamiento"; Rec."Fecha Lanzamiento")
                {
                    ApplicationArea = Basic;
                }
                field(ean; Rec.ean)
                {
                    ApplicationArea = Basic;
                }
                field("Producto PADRE"; Rec."Producto PADRE")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field("Clasificacion CANADA"; Rec."Clasificacion CANADA")
                {
                    ApplicationArea = Basic;
                }
                field("Tarifa AMZ2023"; Rec."Tarifa AMZ2023")
                {
                    ApplicationArea = Basic;
                }
                field("PVP Recomendado AMZ2023"; Rec."PVP Recomendado AMZ2023")
                {
                    ApplicationArea = Basic;
                }
                field("Tarifa 2022-2"; Rec."Tarifa 2022-2")
                {
                    ApplicationArea = Basic;
                }
                field("PVP Recomendado 2022-2"; Rec."PVP Recomendado 2022-2")
                {
                    ApplicationArea = Basic;
                }
                field("Tarifa 2021 amazon21"; Rec."Tarifa 2021 amazon21")
                {
                    ApplicationArea = Basic;
                }
                field("PVP Recomendado 2021 amazon21"; Rec."PVP Recomendado 2021 amazon21")
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad palet transporte alma"; Rec."Cantidad palet transporte alma")
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad palet americano"; Rec."Cantidad palet americano")
                {
                    ApplicationArea = Basic;
                }
                field("NO-Rotura de Stock"; Rec."NO-Rotura de Stock")
                {
                    ApplicationArea = Basic;
                }
                field("Stock para Catit"; Rec."Stock para Catit")
                {
                    ApplicationArea = Basic;
                }
                field("FIJO Excluir de dropbox"; Rec."FIJO Excluir de dropbox")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Item.""Existencia VCD"""; Item."Existencia VCD")
                {
                    ApplicationArea = Basic;
                }
                field("Tipo preparacion"; Rec."Tipo preparacion")
                {
                    ApplicationArea = Basic;
                }
                field("Prohibido Amazon"; Rec."Prohibido Amazon")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha prohibido Amazon"; Rec."Fecha prohibido Amazon")
                {
                    ApplicationArea = Basic;
                }
                field("Enviar a web"; Rec."Enviar a web")
                {
                    ApplicationArea = Basic;
                }
                field("Estado WEB Inactivo"; Rec."Estado WEB Inactivo")
                {
                    ApplicationArea = Basic;
                }
                field("Clase logistica"; Rec."Clase logistica")
                {
                    ApplicationArea = Basic;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = Basic;
                }
                field("Alto Uds"; AltoUds)
                {
                    ApplicationArea = Basic;
                    Caption = 'Alto Uds';
                    Editable = false;
                }
                field("Ancho Uds"; AnchoUds)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ancho Uds';
                    Editable = false;
                }
                field("Longuitud Uds"; LonguiUds)
                {
                    ApplicationArea = Basic;
                    Caption = 'Longuitud Uds';
                    Editable = false;
                }
                field("Largo producto"; Rec."Largo producto")
                {
                    ApplicationArea = Basic;
                }
                field("Ancho producto"; Rec."Ancho producto")
                {
                    ApplicationArea = Basic;
                }
                field("Alto producto"; Rec."Alto producto")
                {
                    ApplicationArea = Basic;
                }
                field("Atributo 1"; Rec."Atributo 1")
                {
                    ApplicationArea = Basic;
                }
                field("Valor Atributo 1"; Rec."Valor Atributo 1")
                {
                    ApplicationArea = Basic;
                }
                field("Atributo 2"; Rec."Atributo 2")
                {
                    ApplicationArea = Basic;
                }
                field("Valor Atributo 2"; Rec."Valor Atributo 2")
                {
                    ApplicationArea = Basic;
                }
                field("Atributo 3"; Rec."Atributo 3")
                {
                    ApplicationArea = Basic;
                }
                field("Valor Atributo 3"; Rec."Valor Atributo 3")
                {
                    ApplicationArea = Basic;
                }
                field("URL IMAGEN 1"; Rec."URL IMAGEN 1")
                {
                    ApplicationArea = Basic;
                }
                field("Producto con reserva"; Rec."Producto con reserva")
                {
                    ApplicationArea = Basic;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = Basic;
                }
                field("Stock en HAGEN"; Rec."Stock en HAGEN")
                {
                    ApplicationArea = Basic;
                }
                field("Tarifa 2019"; Rec."Tarifa 2019")
                {
                    ApplicationArea = Basic;
                }
                field("PVP Recomendado 2019"; Rec."PVP Recomendado 2019")
                {
                    ApplicationArea = Basic;
                }
                field("No permite pedido"; Rec."No permite pedido")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha recalcula no permitir"; Rec."Fecha recalcula no permitir")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Familia; Rec.Familia)
                {
                    ApplicationArea = Basic;
                }
                field(Subfamilia; Rec.Subfamilia)
                {
                    ApplicationArea = Basic;
                }
                field("Ref. Catit"; Rec."Ref. Catit")
                {
                    ApplicationArea = Basic;
                }
                field("Familia Catit"; Rec."Familia Catit")
                {
                    ApplicationArea = Basic;
                }
                field("Subfamilia Catit"; Rec."Subfamilia Catit")
                {
                    ApplicationArea = Basic;
                }
                field("Estatus Web"; Rec."Estatus Web")
                {
                    ApplicationArea = Basic;
                }
                field("Coste Catit"; Rec."Coste Catit")
                {
                    ApplicationArea = Basic;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad facturada"; Rec."Cantidad facturada")
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad abonada"; Rec."Cantidad abonada")
                {
                    ApplicationArea = Basic;
                }
                field("Importe facturado"; Rec."Importe facturado")
                {
                    ApplicationArea = Basic;
                }
                field("Importe abonado"; Rec."Importe abonado")
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad fabricada"; Rec."Cantidad fabricada")
                {
                    ApplicationArea = Basic;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = Basic;
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    ApplicationArea = Basic;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field("Price Unit Conversion"; Rec."Price Unit Conversion")
                {
                    ApplicationArea = Basic;
                }
                field("Tariff No."; Rec."Tariff No.")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    ApplicationArea = Basic;
                }
                field("Item Disc. Group"; Rec."Item Disc. Group")
                {
                    ApplicationArea = Basic;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = Basic;
                }
                field("Statistics Group"; Rec."Statistics Group")
                {
                    ApplicationArea = Basic;
                }
                field("Commission Group"; Rec."Commission Group")
                {
                    ApplicationArea = Basic;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic;
                }
                field("Price/Profit Calculation"; Rec."Price/Profit Calculation")
                {
                    ApplicationArea = Basic;
                }
                field("Profit %"; Rec."Profit %")
                {
                    ApplicationArea = Basic;
                }
                field("Costing Method"; Rec."Costing Method")
                {
                    ApplicationArea = Basic;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Standard Cost"; Rec."Standard Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Last Direct Cost"; Rec."Last Direct Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = Basic;
                }
                field("Cost is Adjusted"; Rec."Cost is Adjusted")
                {
                    ApplicationArea = Basic;
                }
                field("Allow Online Adjustment"; Rec."Allow Online Adjustment")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    ApplicationArea = Basic;
                }
                field("Reorder Point"; Rec."Reorder Point")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Inventory"; Rec."Maximum Inventory")
                {
                    ApplicationArea = Basic;
                }
                field("Reorder Quantity"; Rec."Reorder Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Alternative Item No."; Rec."Alternative Item No.")
                {
                    ApplicationArea = Basic;
                }
                field("Unit List Price"; Rec."Unit List Price")
                {
                    ApplicationArea = Basic;
                }
                field("Duty Due %"; Rec."Duty Due %")
                {
                    ApplicationArea = Basic;
                }
                field("Duty Code"; Rec."Duty Code")
                {
                    ApplicationArea = Basic;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = Basic;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = Basic;
                }
                field("Units per Parcel"; Rec."Units per Parcel")
                {
                    ApplicationArea = Basic;
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                    ApplicationArea = Basic;
                }
                field(Durability; Rec.Durability)
                {
                    ApplicationArea = Basic;
                }
                field("Freight Type"; Rec."Freight Type")
                {
                    ApplicationArea = Basic;
                }
                field("Duty Unit Conversion"; Rec."Duty Unit Conversion")
                {
                    ApplicationArea = Basic;
                }
                field("Country/Region Purchased Code"; Rec."Country/Region Purchased Code")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Quantity"; Rec."Budget Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Profit"; Rec."Budget Profit")
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                }
                field("Cost is Posted to G/L"; Rec."Cost is Posted to G/L")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field("Last Time Modified"; Rec."Last Time Modified")
                {
                    ApplicationArea = Basic;
                }
                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Filter"; Rec."Global Dimension 1 Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Filter"; Rec."Global Dimension 2 Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Location Filter"; Rec."Location Filter")
                {
                    ApplicationArea = Basic;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = Basic;
                }
                field("Net Invoiced Qty."; Rec."Net Invoiced Qty.")
                {
                    ApplicationArea = Basic;
                }
                field("Net Change"; Rec."Net Change")
                {
                    ApplicationArea = Basic;
                }
                field("Purchases (Qty.)"; Rec."Purchases (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Sales (Qty.)"; Rec."Sales (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Positive Adjmt. (Qty.)"; Rec."Positive Adjmt. (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Negative Adjmt. (Qty.)"; Rec."Negative Adjmt. (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Purchases (LCY)"; Rec."Purchases (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Sales (LCY)"; Rec."Sales (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Positive Adjmt. (LCY)"; Rec."Positive Adjmt. (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Negative Adjmt. (LCY)"; Rec."Negative Adjmt. (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("COGS (LCY)"; Rec."COGS (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
                {
                    ApplicationArea = Basic;
                }
                field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
                {
                    ApplicationArea = Basic;
                }
                field("Price Includes VAT"; Rec."Price Includes VAT")
                {
                    ApplicationArea = Basic;
                }
                field("Drop Shipment Filter"; Rec."Drop Shipment Filter")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Bus. Posting Gr. (Price)"; Rec."VAT Bus. Posting Gr. (Price)")
                {
                    ApplicationArea = Basic;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field("Transferred (Qty.)"; Rec."Transferred (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Transferred (LCY)"; Rec."Transferred (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
                {
                    ApplicationArea = Basic;
                }
                field("Automatic Ext. Texts"; Rec."Automatic Ext. Texts")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = Basic;
                }
                field("Reserved Qty. on Inventory"; Rec."Reserved Qty. on Inventory")
                {
                    ApplicationArea = Basic;
                }
                field("Reserved Qty. on Purch. Orders"; Rec."Reserved Qty. on Purch. Orders")
                {
                    ApplicationArea = Basic;
                }
                field("Reserved Qty. on Sales Orders"; Rec."Reserved Qty. on Sales Orders")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Res. Qty. on Outbound Transfer"; Rec."Res. Qty. on Outbound Transfer")
                {
                    ApplicationArea = Basic;
                }
                field("Res. Qty. on Inbound Transfer"; Rec."Res. Qty. on Inbound Transfer")
                {
                    ApplicationArea = Basic;
                }
                field("Res. Qty. on Sales Returns"; Rec."Res. Qty. on Sales Returns")
                {
                    ApplicationArea = Basic;
                }
                field("Res. Qty. on Purch. Returns"; Rec."Res. Qty. on Purch. Returns")
                {
                    ApplicationArea = Basic;
                }
                field("Stockout Warning"; Rec."Stockout Warning")
                {
                    ApplicationArea = Basic;
                }
                field("Prevent Negative Inventory"; Rec."Prevent Negative Inventory")
                {
                    ApplicationArea = Basic;
                }
                field("Cost of Open Production Orders"; Rec."Cost of Open Production Orders")
                {
                    ApplicationArea = Basic;
                }
                field("Application Wksh. User ID"; Rec."Application Wksh. User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Assembly Policy"; Rec."Assembly Policy")
                {
                    ApplicationArea = Basic;
                }
                field("Res. Qty. on Assembly Order"; Rec."Res. Qty. on Assembly Order")
                {
                    ApplicationArea = Basic;
                }
                field("Res. Qty. on  Asm. Comp."; Rec."Res. Qty. on  Asm. Comp.")
                {
                    ApplicationArea = Basic;
                }
                field("Qty. on Assembly Order"; Rec."Qty. on Assembly Order")
                {
                    ApplicationArea = Basic;
                }
                field("Qty. on Asm. Component"; Rec."Qty. on Asm. Component")
                {
                    ApplicationArea = Basic;
                }
                field("Qty. on Job Order"; Rec."Qty. on Job Order")
                {
                    ApplicationArea = Basic;
                }
                field("Res. Qty. on Job Order"; Rec."Res. Qty. on Job Order")
                {
                    ApplicationArea = Basic;
                }
                field(GTIN; Rec.GTIN)
                {
                    ApplicationArea = Basic;
                }
                field("Default Deferral Template Code"; Rec."Default Deferral Template Code")
                {
                    ApplicationArea = Basic;
                }
                field("Low-Level Code"; Rec."Low-Level Code")
                {
                    ApplicationArea = Basic;
                }
                field("Lot Size"; Rec."Lot Size")
                {
                    ApplicationArea = Basic;
                }
                field("Serial Nos."; Rec."Serial Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Last Unit Cost Calc. Date"; Rec."Last Unit Cost Calc. Date")
                {
                    ApplicationArea = Basic;
                }
                field("Rolled-up Material Cost"; Rec."Rolled-up Material Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Rolled-up Capacity Cost"; Rec."Rolled-up Capacity Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Scrap %"; Rec."Scrap %")
                {
                    ApplicationArea = Basic;
                }
                field("Inventory Value Zero"; Rec."Inventory Value Zero")
                {
                    ApplicationArea = Basic;
                }
                field("Discrete Order Quantity"; Rec."Discrete Order Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Order Quantity"; Rec."Minimum Order Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Order Quantity"; Rec."Maximum Order Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Order Multiple"; Rec."Order Multiple")
                {
                    ApplicationArea = Basic;
                }
                field("Safety Lead Time"; Rec."Safety Lead Time")
                {
                    ApplicationArea = Basic;
                }
                field("Flushing Method"; Rec."Flushing Method")
                {
                    ApplicationArea = Basic;
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Receipt (Qty.)"; Rec."Scheduled Receipt (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Need (Qty.)"; Rec."Scheduled Need (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ApplicationArea = Basic;
                }
                field("Bin Filter"; Rec."Bin Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Variant Filter"; Rec."Variant Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field("Time Bucket"; Rec."Time Bucket")
                {
                    ApplicationArea = Basic;
                }
                field("Reserved Qty. on Prod. Order"; Rec."Reserved Qty. on Prod. Order")
                {
                    ApplicationArea = Basic;
                }
                field("Res. Qty. on Prod. Order Comp."; Rec."Res. Qty. on Prod. Order Comp.")
                {
                    ApplicationArea = Basic;
                }
                field("Res. Qty. on Req. Line"; Rec."Res. Qty. on Req. Line")
                {
                    ApplicationArea = Basic;
                }
                field("Reordering Policy"; Rec."Reordering Policy")
                {
                    ApplicationArea = Basic;
                }
                field("Include Inventory"; Rec."Include Inventory")
                {
                    ApplicationArea = Basic;
                }
                field("Manufacturing Policy"; Rec."Manufacturing Policy")
                {
                    ApplicationArea = Basic;
                }
                field("Rescheduling Period"; Rec."Rescheduling Period")
                {
                    ApplicationArea = Basic;
                }
                field("Lot Accumulation Period"; Rec."Lot Accumulation Period")
                {
                    ApplicationArea = Basic;
                }
                field("Dampener Period"; Rec."Dampener Period")
                {
                    ApplicationArea = Basic;
                }
                field("Dampener Quantity"; Rec."Dampener Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Overflow Level"; Rec."Overflow Level")
                {
                    ApplicationArea = Basic;
                }
                field("Planning Transfer Ship. (Qty)."; Rec."Planning Transfer Ship. (Qty).")
                {
                    ApplicationArea = Basic;
                }
                field("Planning Worksheet (Qty.)"; Rec."Planning Worksheet (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Stockkeeping Unit Exists"; Rec."Stockkeeping Unit Exists")
                {
                    ApplicationArea = Basic;
                }
                field("Manufacturer Code"; Rec."Manufacturer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = Basic;
                }
                field("Created From Nonstock Item"; Rec."Created From Nonstock Item")
                {
                    ApplicationArea = Basic;
                }
                field("Substitutes Exist"; Rec."Substitutes Exist")
                {
                    ApplicationArea = Basic;
                }
                field("Qty. in Transit"; Rec."Qty. in Transit")
                {
                    ApplicationArea = Basic;
                }
                field("Trans. Ord. Receipt (Qty.)"; Rec."Trans. Ord. Receipt (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Trans. Ord. Shipment (Qty.)"; Rec."Trans. Ord. Shipment (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Qty. Assigned to ship"; Rec."Qty. Assigned to ship")
                {
                    ApplicationArea = Basic;
                }
                field("Qty. Picked"; Rec."Qty. Picked")
                {
                    ApplicationArea = Basic;
                }
                field("Service Item Group"; Rec."Service Item Group")
                {
                    ApplicationArea = Basic;
                }
                field("Qty. on Service Order"; Rec."Qty. on Service Order")
                {
                    ApplicationArea = Basic;
                }
                field("Res. Qty. on Service Orders"; Rec."Res. Qty. on Service Orders")
                {
                    ApplicationArea = Basic;
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    ApplicationArea = Basic;
                }
                field("Lot Nos."; Rec."Lot Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Expiration Calculation"; Rec."Expiration Calculation")
                {
                    ApplicationArea = Basic;
                }
                field("Lot No. Filter"; Rec."Lot No. Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Serial No. Filter"; Rec."Serial No. Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Qty. on Purch. Return"; Rec."Qty. on Purch. Return")
                {
                    ApplicationArea = Basic;
                }
                field("Qty. on Sales Return"; Rec."Qty. on Sales Return")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Substitutes"; Rec."No. of Substitutes")
                {
                    ApplicationArea = Basic;
                }
                field("Warehouse Class Code"; Rec."Warehouse Class Code")
                {
                    ApplicationArea = Basic;
                }
                field("Special Equipment Code"; Rec."Special Equipment Code")
                {
                    ApplicationArea = Basic;
                }
                field("Put-away Template Code"; Rec."Put-away Template Code")
                {
                    ApplicationArea = Basic;
                }
                field("Put-away Unit of Measure Code"; Rec."Put-away Unit of Measure Code")
                {
                    ApplicationArea = Basic;
                }
                field("Phys Invt Counting Period Code"; Rec."Phys Invt Counting Period Code")
                {
                    ApplicationArea = Basic;
                }
                field("Last Counting Period Update"; Rec."Last Counting Period Update")
                {
                    ApplicationArea = Basic;
                }
                field("Last Phys. Invt. Date"; Rec."Last Phys. Invt. Date")
                {
                    ApplicationArea = Basic;
                }
                field("Use Cross-Docking"; Rec."Use Cross-Docking")
                {
                    ApplicationArea = Basic;
                }
                field("Next Counting Start Date"; Rec."Next Counting Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Next Counting End Date"; Rec."Next Counting End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Identifier Code"; Rec."Identifier Code")
                {
                    ApplicationArea = Basic;
                }
                field("Cost Regulation %"; Rec."Cost Regulation %")
                {
                    ApplicationArea = Basic;
                }
                /*
                field("Clasificación A,B,C"; Rec."Clasificación A,B,C")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha asignada clasificación"; Rec."Fecha asignada clasificación")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha Descatalogación"; Rec."Fecha Descatalogación")
                {
                    ApplicationArea = Basic;
                }
                field("Usuario última modificación"; Rec."Usuario última modificación")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha Alta"; Rec."Fecha Alta")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha última modificación"; Rec."Fecha última modificación")
                {
                    ApplicationArea = Basic;
                }
                field("Envíos (cdad.)"; Rec."Envíos (cdad.)")
                {
                    ApplicationArea = Basic;
                }
                field("Ajustes (cdad.)"; Rec."Ajustes (cdad.)")
                {
                    ApplicationArea = Basic;
                }
                field("Pro.Ped.Compra (cdad.)"; Rec."Pro.Ped.Compra (cdad.)")
                {
                    ApplicationArea = Basic;
                }
                field("Producto FRAGIL"; Rec."Producto FRAGIL")
                {
                    ApplicationArea = Basic;
                }
                field("Estado Producto"; Rec."Estado Producto")
                {
                    ApplicationArea = Basic;
                }
                field("Usuario modificación"; Rec."Usuario modificación")
                {
                    ApplicationArea = Basic;
                }
                field("Hora modificación"; Rec."Hora modificación")
                {
                    ApplicationArea = Basic;
                }
                field("Criterio rotacion"; Rec."Criterio rotacion")
                {
                    ApplicationArea = Basic;
                }
                field("Unidades venta"; Rec."Unidades venta")
                {
                    ApplicationArea = Basic;
                }
                field("Permite fraccionar venta"; Rec."Permite fraccionar venta")
                {
                    ApplicationArea = Basic;
                }
                field("Ref. AMAZON"; Rec."Ref. AMAZON")
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad palets"; Rec."Cantidad palets")
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad master"; Rec."Cantidad master")
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad inner"; Rec."Cantidad inner")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha proxima recepción conten"; Rec."Fecha proxima recepción conten")
                {
                    ApplicationArea = Basic;
                }
                field("Tipo producto"; Rec."Tipo producto")
                {
                    ApplicationArea = Basic;
                }
                field("Unidad compra"; Rec."Unidad compra")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha proxima recepción pedido"; Rec."Fecha proxima recepción pedido")
                {
                    ApplicationArea = Basic;
                }
                field("Comentario para pedido1"; Rec."Comentario para pedido1")
                {
                    ApplicationArea = Basic;
                }
                field("Comentario para pedido2"; Rec."Comentario para pedido2")
                {
                    ApplicationArea = Basic;
                }
                field("Tipo palet"; Rec."Tipo palet")
                {
                    ApplicationArea = Basic;
                }
                field("Producto almacenable"; Rec."Producto almacenable")
                {
                    ApplicationArea = Basic;
                }
                field("Tiene productos asociados"; Rec."Tiene productos asociados")
                {
                    ApplicationArea = Basic;
                }
                field("Existencia SILLA"; Rec."Existencia SILLA")
                {
                    ApplicationArea = Basic;
                }
                field("Cdad. en oferta compra"; Rec."Cdad. en oferta compra")
                {
                    ApplicationArea = Basic;
                }
                field("Enviar siempre"; Rec."Enviar siempre")
                {
                    ApplicationArea = Basic;
                }
                field("Texto no permite pedido"; Rec."Texto no permite pedido")
                {
                    ApplicationArea = Basic;
                }
                field("Producto NO automatico"; Rec."Producto NO automatico")
                {
                    ApplicationArea = Basic;
                }
                field(Marca; Rec.Marca)
                {
                    ApplicationArea = Basic;
                }
                field("Descripcion web"; Rec."Descripcion web")
                {
                    ApplicationArea = Basic;
                }
                field("Metros Cúbicos Master"; Rec."Metros Cúbicos Master")
                {
                    ApplicationArea = Basic;
                }
                field("Kilos Master"; Rec."Kilos Master")
                {
                    ApplicationArea = Basic;
                }
                field("Etiqueta portugues"; Rec."Etiqueta portugues")
                {
                    ApplicationArea = Basic;
                }
                field("Tamaño etiqueta"; Rec."Tamaño etiqueta")
                {
                    ApplicationArea = Basic;
                }
                field("Alto master"; Rec."Alto master")
                {
                    ApplicationArea = Basic;
                }
                field("Ancho master"; Rec."Ancho master")
                {
                    ApplicationArea = Basic;
                }
                field("Largo master"; Rec."Largo master")
                {
                    ApplicationArea = Basic;
                }
                field(Alto; Rec.Alto)
                {
                    ApplicationArea = Basic;
                }
                field(Ancho; Rec.Ancho)
                {
                    ApplicationArea = Basic;
                }
                field(Largo; Rec.Largo)
                {
                    ApplicationArea = Basic;
                }
                field(Ventas; Rec.Ventas)
                {
                    ApplicationArea = Basic;
                }
                field(Promedio; Rec.Promedio)
                {
                    ApplicationArea = Basic;
                }
                field(Rotacion; Rec.Rotacion)
                {
                    ApplicationArea = Basic;
                }
                field(Dias; Rec.Dias)
                {
                    ApplicationArea = Basic;
                }
                field("Producto web"; Rec."Producto web")
                {
                    ApplicationArea = Basic;
                }
                field("Unidad expedicion ECI"; Rec."Unidad expedicion ECI")
                {
                    ApplicationArea = Basic;
                }
                field("+ Linea"; Rec."+ Linea")
                {
                    ApplicationArea = Basic;
                }
                field("+ Familia"; Rec."+ Familia")
                {
                    ApplicationArea = Basic;
                }
                field("+ Familia 2"; Rec."+ Familia 2")
                {
                    ApplicationArea = Basic;
                }
                field("+ Familia 3"; Rec."+ Familia 3")
                {
                    ApplicationArea = Basic;
                }
                field("+ Familia 4"; Rec."+ Familia 4")
                {
                    ApplicationArea = Basic;
                }
                field("+ Subfamilia"; Rec."+ Subfamilia")
                {
                    ApplicationArea = Basic;
                }
                field("+ Subfamilia 2"; Rec."+ Subfamilia 2")
                {
                    ApplicationArea = Basic;
                }
                field("+ Subfamilia 3"; Rec."+ Subfamilia 3")
                {
                    ApplicationArea = Basic;
                }
                field("+ Subfamilia 4"; Rec."+ Subfamilia 4")
                {
                    ApplicationArea = Basic;
                }
                field("+ Familia 1"; Rec."+ Familia 1")
                {
                    ApplicationArea = Basic;
                }
                field("+ Subfamilia 1"; Rec."+ Subfamilia 1")
                {
                    ApplicationArea = Basic;
                }
                field("+ Linea 1"; Rec."+ Linea 1")
                {
                    ApplicationArea = Basic;
                }
                field("+ Linea 2"; Rec."+ Linea 2")
                {
                    ApplicationArea = Basic;
                }
                field("+ Linea 3"; Rec."+ Linea 3")
                {
                    ApplicationArea = Basic;
                }
                field("+ Linea 4"; Rec."+ Linea 4")
                {
                    ApplicationArea = Basic;
                }
                field("Producto Hagen"; Rec."Producto Hagen")
                {
                    ApplicationArea = Basic;
                }
                field("Filtro Pais"; Rec."Filtro Pais")
                {
                    ApplicationArea = Basic;
                }
                field("Existencia SILLA SALDO"; Rec."Existencia SILLA SALDO")
                {
                    ApplicationArea = Basic;
                }
                field("Alto CAJA"; Rec."Alto CAJA")
                {
                    ApplicationArea = Basic;
                }
                field("Ancho CAJA"; Rec."Ancho CAJA")
                {
                    ApplicationArea = Basic;
                }
                field("Largo CAJA"; Rec."Largo CAJA")
                {
                    ApplicationArea = Basic;
                }
                field("Volumen CAJA"; Rec."Volumen CAJA")
                {
                    ApplicationArea = Basic;
                }
                field("Alto INNER"; Rec."Alto INNER")
                {
                    ApplicationArea = Basic;
                }
                field("Ancho INNER"; Rec."Ancho INNER")
                {
                    ApplicationArea = Basic;
                }
                field("Largo INNER"; Rec."Largo INNER")
                {
                    ApplicationArea = Basic;
                }
                field("Volumen INNER"; Rec."Volumen INNER")
                {
                    ApplicationArea = Basic;
                }
                field("Imagen Articulo WEB"; Rec."Imagen Articulo WEB")
                {
                    ApplicationArea = Basic;
                }
                field("NO MULTIPEDIDO"; Rec."NO MULTIPEDIDO")
                {
                    ApplicationArea = Basic;
                }
                field("nulo  Descripcion Hijo"; Rec."nulo  Descripcion Hijo")
                {
                    ApplicationArea = Basic;
                }
                field("Cantidad colchon web"; Rec."Cantidad colchon web")
                {
                    ApplicationArea = Basic;
                }
                field("CUANTOS UDS EANS"; Rec."CUANTOS UDS EANS")
                {
                    ApplicationArea = Basic;
                }
                field("Voluminoso web"; Rec."Voluminoso web")
                {
                    ApplicationArea = Basic;
                }
                field("IVA IGIC"; Rec."IVA IGIC")
                {
                    ApplicationArea = Basic;
                }
                field("Excluir de dropbox"; Rec."Excluir de dropbox")
                {
                    ApplicationArea = Basic;
                }
                field("Actualizar WEB"; Rec."Actualizar WEB")
                {
                    ApplicationArea = Basic;
                }
                field("Imagen Articulo WEB 2"; Rec."Imagen Articulo WEB 2")
                {
                    ApplicationArea = Basic;
                }
                field("Imagen Articulo WEB 3"; Rec."Imagen Articulo WEB 3")
                {
                    ApplicationArea = Basic;
                }
                field("Imagen Articulo WEB 4"; Rec."Imagen Articulo WEB 4")
                {
                    ApplicationArea = Basic;
                }
                field("Actualizar WEB Imagenes"; Rec."Actualizar WEB Imagenes")
                {
                    ApplicationArea = Basic;
                }
                field("Actualizar WEB Descripcion"; Rec."Actualizar WEB Descripcion")
                {
                    ApplicationArea = Basic;
                }
                field("nulo Producto Opcion"; Rec."nulo Producto Opcion")
                {
                    ApplicationArea = Basic;
                }
                field("Producto en promocion WEB"; Rec."Producto en promocion WEB")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha inicio promocion WEB"; Rec."Fecha inicio promocion WEB")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha fin promocion WEB"; Rec."Fecha fin promocion WEB")
                {
                    ApplicationArea = Basic;
                }
                field("No enviar precio especial"; Rec."No enviar precio especial")
                {
                    ApplicationArea = Basic;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = Basic;
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ApplicationArea = Basic;
                }
                field("Single-Level Material Cost"; Rec."Single-Level Material Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Single-Level Capacity Cost"; Rec."Single-Level Capacity Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Single-Level Subcontrd. Cost"; Rec."Single-Level Subcontrd. Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Single-Level Cap. Ovhd Cost"; Rec."Single-Level Cap. Ovhd Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Single-Level Mfg. Ovhd Cost"; Rec."Single-Level Mfg. Ovhd Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Rolled-up Subcontracted Cost"; Rec."Rolled-up Subcontracted Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Rolled-up Mfg. Ovhd Cost"; Rec."Rolled-up Mfg. Ovhd Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Rolled-up Cap. Overhead Cost"; Rec."Rolled-up Cap. Overhead Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Planning Issues (Qty.)"; Rec."Planning Issues (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Planning Receipt (Qty.)"; Rec."Planning Receipt (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Planned Order Receipt (Qty.)"; Rec."Planned Order Receipt (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("FP Order Receipt (Qty.)"; Rec."FP Order Receipt (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Rel. Order Receipt (Qty.)"; Rec."Rel. Order Receipt (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Planning Release (Qty.)"; Rec."Planning Release (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Planned Order Release (Qty.)"; Rec."Planned Order Release (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Purch. Req. Receipt (Qty.)"; Rec."Purch. Req. Receipt (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Purch. Req. Release (Qty.)"; Rec."Purch. Req. Release (Qty.)")
                {
                    ApplicationArea = Basic;
                }
                field("Order Tracking Policy"; Rec."Order Tracking Policy")
                {
                    ApplicationArea = Basic;
                }
                field("Prod. Forecast Quantity (Base)"; Rec."Prod. Forecast Quantity (Base)")
                {
                    ApplicationArea = Basic;
                }
                field("Production Forecast Name"; Rec."Production Forecast Name")
                {
                    ApplicationArea = Basic;
                }
                field("Component Forecast"; Rec."Component Forecast")
                {
                    ApplicationArea = Basic;
                }
                field("Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
                {
                    ApplicationArea = Basic;
                }
                field("Qty. on Component Lines"; Rec."Qty. on Component Lines")
                {
                    ApplicationArea = Basic;
                }
                field(Critical; Rec.Critical)
                {
                    ApplicationArea = Basic;
                }
                field("Common Item No."; Rec."Common Item No.")
                {
                    ApplicationArea = Basic;
                }
                field(Temporalidad; Rec.Temporalidad)
                {
                    ApplicationArea = Basic;
                }
                field("Objetivo Anual"; Rec."Objetivo Anual")
                {
                    ApplicationArea = Basic;
                }
                field("Objetivo trimestre 1"; Rec."Objetivo trimestre 1")
                {
                    ApplicationArea = Basic;
                }
                field("Objetivo trimestre 2"; Rec."Objetivo trimestre 2")
                {
                    ApplicationArea = Basic;
                }
                field("Objetivo trimestre 3"; Rec."Objetivo trimestre 3")
                {
                    ApplicationArea = Basic;
                }
                field("Objetivo trimestre 4"; Rec."Objetivo trimestre 4")
                {
                    ApplicationArea = Basic;
                }
                */
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Importa textos adic. PT")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                /////- RunObject = XMLport UnknownXMLport50039;
            }
            action("Alta Ref. Amazon")
            {
                ApplicationArea = Basic;
                Caption = 'Alta Ref. Amazon';
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                /////- RunObject = XMLport UnknownXMLport50013;
            }
            action("Precios ESPECIALES")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Price;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Precios especiales";
            }
            action("Recalcula Stock compuesto")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin



                    Item.Reset;
                    if Item.FindSet then
                        repeat
                        /////- Recalculanopermitirpedido.RecalculaStockCompuesto(Item."No.");
                        until Item.Next = 0;
                    Message('hecho');


                    ///"Lead Time Calculation":=FORMAT(asd);

                    /*
                    ventana.OPEN('#1############');
                    
                    IF Item.FINDFIRST THEN REPEAT
                    
                    TariffNumber."No.":=Item."Tariff No.";
                    TariffNumber.Description:=Item."Tariff No.";
                    IF TariffNumber.INSERT THEN;
                    
                    ///Item."Tariff No.":=CONVERTSTR(Item."Tariff No.",'.',' ');
                    ///Item.MODIFY;
                    ventana.UPDATE(1,Item."No.");
                    UNTIL Item.NEXT=0;
                    
                    ventana.CLOSE;
                    */

                end;
            }
            action("Importar URL")
            {
                ApplicationArea = Basic;
                /////-                 RunObject = XMLport UnknownXMLport50004;
            }
            action("Importar Clase logistica")
            {
                ApplicationArea = Basic;
                /////- RunObject = XMLport UnknownXMLport50033;
            }
            action(modif)
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Add;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin




                    if Item.FindFirst then
                        repeat

                            ///  IF Item."IVA IGIC"='IGIC7' THEN BEGIN
                            ///Item."IVA IGIC":='IGIC65';
                            Item.Modify(true);

                        until Item.Next = 0;


                    Message('HECHO');
                end;
            }
            action(asd)
            {
                ApplicationArea = Basic;
                Visible = false;

                trigger OnAction()
                begin
                    Rec."Ref. Catit" := CopyStr(Rec."No.", StrLen(Rec."No.") - 1);
                    Rec.Modify;
                end;
            }
            action(dd)
            {
                ApplicationArea = Basic;
                Visible = false;

                trigger OnAction()
                begin

                    Rec."Ref. Catit" := Rec."No.";
                    Rec.Modify;
                end;
            }
            action(ASASDASDAS)
            {
                ApplicationArea = Basic;
                ShortCutKey = 'F9';

                trigger OnAction()
                begin

                    Rec.Modify(true);

                    ///Item.SETRANGE("IVA IGIC",'IGIC65');
                    ///IF Item.FINDFIRST THEN REPEAT
                    ///Item."IVA IGIC":='IGIC7';
                    ///Item.MODIFY;
                    ///UNTIL Item.NEXT=0;

                    ////MESSAGE('asd2');
                end;
            }
            action("Importa Objetivos")
            {
                ApplicationArea = Basic;
                /////- RunObject = XMLport UnknownXMLport50045;
            }
            action("Importa gramos plastico")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin


                    /////- Clear(gramosplastico);
                    /////- gramosplastico.Run;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        AltoUds := 0;
        AnchoUds := 0;
        LonguiUds := 0;
        if ItemUnitofMeasure.Get(Rec."No.", 'UDS') then begin
            AltoUds := ItemUnitofMeasure.Height;
            AnchoUds := ItemUnitofMeasure.Width;
            LonguiUds := ItemUnitofMeasure.Length;

        end;
    end;

    var
        Item: Record Item;
        ventana: Dialog;
        TariffNumber: Record "Tariff Number";
        /////- Recalculanopermitirpedido: Codeunit UnknownCodeunit50031;
        AltoUds: Decimal;
        AnchoUds: Decimal;
        LonguiUds: Decimal;
        ItemUnitofMeasure: Record "Item Unit of Measure";
    /////- gramosplastico: XmlPort UnknownXmlPort50052;
}

