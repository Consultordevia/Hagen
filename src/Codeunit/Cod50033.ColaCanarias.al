#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50033 "ColaCanarias"
{

    trigger OnRun()
    begin

        Productos;
        PreciosVenta;
        Descuentos;





        exit;
    end;

    var
        VENTANA: Dialog;
        RecItemE: Record Item;
        RecItemC: Record Item;
        RecSPE: Record "Sales Price";
        RecSPC: Record "Sales Price";
        RecSLDE: Record "Sales Line Discount";
        RecSLDC: Record "Sales Line Discount";
        RecUMPE: Record "Item Unit of Measure";
        RecUMPC: Record "Item Unit of Measure";
        Rec83: Record "Item Journal Line";
        Rec32: Record "Item Ledger Entry";
        ITEM: Record Item;
        Existencia: Decimal;
        atraspasar: Decimal;
        CURegMov: Codeunit "Item Jnl.-Post Batch";
        RecItem1E: Record item;
        RecItem2C: Record item;
        ExistenciaE: Decimal;
        ExistenciaC: Decimal;
        lin: Decimal;
        RecSDP: Record "Item Journal Batch";






    local procedure Productos()
    begin

        VENTANA.Open('#1#################');
        RecUMPE.ChangeCompany('ROLF C HAGEN ESPAÑA S.A.');
        if RecUMPE.FindFirst then
            repeat
                VENTANA.Update(1, FORMAT('UMP') + '-' + FORMAT(RecUMPE."Item No."));
                RecUMPC.ChangeCompany('HAGEN CANARIAS S.C.');
                RecUMPC.SetRange("Item No.", RecUMPE."Item No.");
                RecUMPC.SetRange(Code, RecUMPE.Code);
                IF RecUMPC.FindFirst() THEN begin
                    RecUMPC."Qty. per Unit of Measure" := RecUMPE."Qty. per Unit of Measure";
                    RecUMPC."Qty. Rounding Precision" := RecUMPE."Qty. Rounding Precision";
                    RecUMPC."Coupled to Dataverse" := RecUMPE."Coupled to Dataverse";
                    RecUMPC.Length := RecUMPE.Length;
                    RecUMPC.Width := RecUMPE.Width;
                    RecUMPC.Height := RecUMPE.Height;
                    RecUMPC.Cubage := RecUMPE.Cubage;
                    RecUMPC.Weight := RecUMPE.Weight;
                    RecUMPC.Description := RecUMPE.Description;
                    RecUMPC.ean := RecUMPE.ean;
                    RecUMPC.EXISTE := RecUMPE.EXISTE;
                    RecUMPC."enviar a adaia" := RecUMPE."enviar a adaia";
                    RecUMPC."ean PROD" := RecUMPE."ean PROD";
                    RecUMPC.EXISTE2 := RecUMPE.EXISTE2;
                    RecUMPC."Kgs/Volumen WEB" := RecUMPE."Kgs/Volumen WEB";
                    RecUMPC."fecha modif" := RecUMPE."fecha modif";
                    RecUMPC.Modify;
                end;
                IF NOT RecUMPC.FindFirst() THEN begin
                    RecUMPC := RecUMPE;
                    RecUMPC.Insert;
                end;
            UNTIL RecUMPE.NEXT = 0;



        VENTANA.Close;


        VENTANA.Open('#1#################');
        RecItemE.ChangeCompany('ROLF C HAGEN ESPAÑA S.A.');
        if RecItemE.FindFirst then
            repeat
                VENTANA.Update(1, FORMAT('PROD') + '-' + FORMAT(RecItemE."No."));
                RecItemC.ChangeCompany('HAGEN CANARIAS S.C.');
                RecItemC.SetRange("No.", RecItemE."No.");
                IF RecItemC.FindFirst() THEN begin
                    RecItemC."No. 2" := RecItemE."No. 2";
                    RecItemC.Description := RecItemE.Description;
                    RecItemC."Search Description" := RecItemE."Search Description";
                    RecItemC."Description 2" := RecItemE."Description 2";
                    RecItemC."Assembly BOM" := RecItemE."Assembly BOM";
                    RecItemC."Base Unit of Measure" := RecItemE."Base Unit of Measure";
                    RecItemC."Price Unit Conversion" := RecItemE."Price Unit Conversion";
                    RecItemC.Type := RecItemE.Type;
                    RecItemC."Inventory Posting Group" := RecItemE."Inventory Posting Group";
                    RecItemC."Shelf No." := RecItemE."Shelf No.";
                    RecItemC."Item Disc. Group" := RecItemE."Item Disc. Group";
                    RecItemC."Allow Invoice Disc." := RecItemE."Allow Invoice Disc.";
                    RecItemC."Statistics Group" := RecItemE."Statistics Group";
                    RecItemC."Commission Group" := RecItemE."Commission Group";
                    RecItemC."Unit Price" := RecItemE."Unit Price";
                    RecItemC."Price/Profit Calculation" := RecItemE."Price/Profit Calculation";
                    RecItemC."Profit %" := RecItemE."Profit %";
                    RecItemC."Costing Method" := RecItemE."Costing Method";
                    RecItemC."Unit Cost" := RecItemE."Unit Cost";
                    RecItemC."Standard Cost" := RecItemE."Standard Cost";
                    RecItemC."Last Direct Cost" := RecItemE."Last Direct Cost";
                    RecItemC."Indirect Cost %" := RecItemE."Indirect Cost %";
                    RecItemC."Cost is Adjusted" := RecItemE."Cost is Adjusted";
                    RecItemC."Allow Online Adjustment" := RecItemE."Allow Online Adjustment";
                    RecItemC."Vendor No." := RecItemE."Vendor No.";
                    RecItemC."Vendor Item No." := RecItemE."Vendor Item No.";
                    RecItemC."Lead Time Calculation" := RecItemE."Lead Time Calculation";
                    RecItemC."Reorder Point" := RecItemE."Reorder Point";
                    RecItemC."Maximum Inventory" := RecItemE."Maximum Inventory";
                    RecItemC."Reorder Quantity" := RecItemE."Reorder Quantity";
                    RecItemC."Alternative Item No." := RecItemE."Alternative Item No.";
                    RecItemC."Unit List Price" := RecItemE."Unit List Price";
                    RecItemC."Duty Due %" := RecItemE."Duty Due %";
                    RecItemC."Duty Code" := RecItemE."Duty Code";
                    RecItemC."Gross Weight" := RecItemE."Gross Weight";
                    RecItemC."Net Weight" := RecItemE."Net Weight";
                    RecItemC."Units per Parcel" := RecItemE."Units per Parcel";
                    RecItemC."Unit Volume" := RecItemE."Unit Volume";
                    RecItemC.Durability := RecItemE.Durability;
                    RecItemC."Freight Type" := RecItemE."Freight Type";
                    RecItemC."Tariff No." := RecItemE."Tariff No.";
                    RecItemC."Duty Unit Conversion" := RecItemE."Duty Unit Conversion";
                    RecItemC."Country/Region Purchased Code" := RecItemE."Country/Region Purchased Code";
                    RecItemC."Budget Quantity" := RecItemE."Budget Quantity";
                    RecItemC."Budgeted Amount" := RecItemE."Budgeted Amount";
                    RecItemC."Budget Profit" := RecItemE."Budget Profit";
                    RecItemC.Comment := RecItemE.Comment;
                    RecItemC.Blocked := RecItemE.Blocked;
                    RecItemC."Cost is Posted to G/L" := RecItemE."Cost is Posted to G/L";
                    RecItemC."Block Reason" := RecItemE."Block Reason";
                    RecItemC."Last DateTime Modified" := RecItemE."Last DateTime Modified";
                    RecItemC."Last Date Modified" := RecItemE."Last Date Modified";
                    RecItemC."Last Time Modified" := RecItemE."Last Time Modified";
                    RecItemC."Price Includes VAT" := RecItemE."Price Includes VAT";
                    RecItemC."VAT Bus. Posting Gr. (Price)" := RecItemE."VAT Bus. Posting Gr. (Price)";
                    RecItemC."Gen. Prod. Posting Group" := RecItemE."Gen. Prod. Posting Group";
                    RecItemC.Picture := RecItemE.Picture;
                    RecItemC."Country/Region of Origin Code" := RecItemE."Country/Region of Origin Code";
                    RecItemC."Automatic Ext. Texts" := RecItemE."Automatic Ext. Texts";
                    RecItemC."No. Series" := RecItemE."No. Series";
                    RecItemC."Tax Group Code" := RecItemE."Tax Group Code";
                    RecItemC."VAT Prod. Posting Group" := RecItemE."VAT Prod. Posting Group";
                    RecItemC.Reserve := RecItemE.Reserve;
                    RecItemC."Global Dimension 1 Code" := RecItemE."Global Dimension 1 Code";
                    RecItemC."Global Dimension 2 Code" := RecItemE."Global Dimension 2 Code";
                    RecItemC."Stockout Warning" := RecItemE."Stockout Warning";
                    RecItemC."Prevent Negative Inventory" := RecItemE."Prevent Negative Inventory";
                    RecItemC."Variant Mandatory if Exists" := RecItemE."Variant Mandatory if Exists";
                    RecItemC."Cost of Open Production Orders" := RecItemE."Cost of Open Production Orders";
                    RecItemC."Application Wksh. User ID" := RecItemE."Application Wksh. User ID";
                    // RecItemC."Coupled to CRM" := RecItemE."Coupled to CRM";
                    RecItemC."Coupled to Dataverse" := RecItemE."Coupled to Dataverse";
                    RecItemC."Assembly Policy" := RecItemE."Assembly Policy";
                    RecItemC.GTIN := RecItemE.GTIN;
                    RecItemC."Default Deferral Template Code" := RecItemE."Default Deferral Template Code";
                    RecItemC."Low-Level Code" := RecItemE."Low-Level Code";
                    RecItemC."Lot Size" := RecItemE."Lot Size";
                    RecItemC."Serial Nos." := RecItemE."Serial Nos.";
                    RecItemC."Last Unit Cost Calc. Date" := RecItemE."Last Unit Cost Calc. Date";
                    RecItemC."Rolled-up Material Cost" := RecItemE."Rolled-up Material Cost";
                    RecItemC."Rolled-up Capacity Cost" := RecItemE."Rolled-up Capacity Cost";
                    RecItemC."Scrap %" := RecItemE."Scrap %";
                    RecItemC."Inventory Value Zero" := RecItemE."Inventory Value Zero";
                    RecItemC."Discrete Order Quantity" := RecItemE."Discrete Order Quantity";
                    RecItemC."Minimum Order Quantity" := RecItemE."Minimum Order Quantity";
                    RecItemC."Maximum Order Quantity" := RecItemE."Maximum Order Quantity";
                    RecItemC."Safety Stock Quantity" := RecItemE."Safety Stock Quantity";
                    RecItemC."Order Multiple" := RecItemE."Order Multiple";
                    RecItemC."Safety Lead Time" := RecItemE."Safety Lead Time";
                    RecItemC."Flushing Method" := RecItemE."Flushing Method";
                    RecItemC."Replenishment System" := RecItemE."Replenishment System";
                    RecItemC."Rounding Precision" := RecItemE."Rounding Precision";
                    RecItemC."Sales Unit of Measure" := RecItemE."Sales Unit of Measure";
                    RecItemC."Purch. Unit of Measure" := RecItemE."Purch. Unit of Measure";
                    RecItemC."Time Bucket" := RecItemE."Time Bucket";
                    RecItemC."Reordering Policy" := RecItemE."Reordering Policy";
                    RecItemC."Include Inventory" := RecItemE."Include Inventory";
                    RecItemC."Manufacturing Policy" := RecItemE."Manufacturing Policy";
                    RecItemC."Rescheduling Period" := RecItemE."Rescheduling Period";
                    RecItemC."Lot Accumulation Period" := RecItemE."Lot Accumulation Period";
                    RecItemC."Dampener Period" := RecItemE."Dampener Period";
                    RecItemC."Dampener Quantity" := RecItemE."Dampener Quantity";
                    RecItemC."Overflow Level" := RecItemE."Overflow Level";
                    RecItemC."Stockkeeping Unit Exists" := RecItemE."Stockkeeping Unit Exists";
                    RecItemC."Manufacturer Code" := RecItemE."Manufacturer Code";
                    RecItemC."Item Category Code" := RecItemE."Item Category Code";
                    RecItemC."Created From Nonstock Item" := RecItemE."Created From Nonstock Item";
                    ///RecItemC.GROUP     "   ProductGroup Code" := RecItemE."ProductGroup Code";
                    RecItemC."Substitutes Exist" := RecItemE."Substitutes Exist";
                    RecItemC."Purchasing Code" := RecItemE."Purchasing Code";
                    RecItemC."Excluded from Cost Adjustment" := RecItemE."Excluded from Cost Adjustment";
                    RecItemC."Item Tracking Code" := RecItemE."Item Tracking Code";
                    RecItemC."Lot Nos." := RecItemE."Lot Nos.";
                    RecItemC."Expiration Calculation" := RecItemE."Expiration Calculation";
                    RecItemC."Warehouse Class Code" := RecItemE."Warehouse Class Code";
                    RecItemC."Special Equipment Code" := RecItemE."Special Equipment Code";
                    RecItemC."Put-away Template Code" := RecItemE."Put-away Template Code";
                    RecItemC."Put-away Unit of Measure Code" := RecItemE."Put-away Unit of Measure Code";
                    RecItemC."Phys Invt Counting Period Code" := RecItemE."Phys Invt Counting Period Code";
                    RecItemC."Last Counting Period Update" := RecItemE."Last Counting Period Update";
                    RecItemC."Last Phys. Invt. Date" := RecItemE."Last Phys. Invt. Date";
                    RecItemC."Use Cross-Docking" := RecItemE."Use Cross-Docking";
                    RecItemC."Next Counting Start Date" := RecItemE."Next Counting Start Date";
                    RecItemC."Next Counting End Date" := RecItemE."Next Counting End Date";
                    RecItemC."Unit Group Exists" := RecItemE."Unit Group Exists";
                    RecItemC."Identifier Code" := RecItemE."Identifier Code";
                    RecItemC."Unit of Measure Id" := RecItemE."Unit of Measure Id";
                    RecItemC."Tax Group Id" := RecItemE."Tax Group Id";
                    RecItemC."Sales Blocked" := RecItemE."Sales Blocked";
                    RecItemC."Purchasing Blocked" := RecItemE."Purchasing Blocked";
                    RecItemC."Item Category Id" := RecItemE."Item Category Id";
                    RecItemC."Inventory Posting Group Id" := RecItemE."Inventory Posting Group Id";
                    RecItemC."Gen. Prod. Posting Group Id" := RecItemE."Gen. Prod. Posting Group Id";
                    RecItemC."Service Blocked" := RecItemE."Service Blocked";
                    RecItemC."Over-Receipt Code" := RecItemE."Over-Receipt Code";
                    RecItemC."Cost Regulation %" := RecItemE."Cost Regulation %";
                    RecItemC."Routing No." := RecItemE."Routing No.";
                    RecItemC."Production BOM No." := RecItemE."Production BOM No.";
                    RecItemC."Single-Level Material Cost" := RecItemE."Single-Level Material Cost";
                    RecItemC."Single-Level Capacity Cost" := RecItemE."Single-Level Capacity Cost";
                    RecItemC."Single-Level Subcontrd. Cost" := RecItemE."Single-Level Subcontrd. Cost";
                    RecItemC."Single-Level Cap. Ovhd Cost" := RecItemE."Single-Level Cap. Ovhd Cost";
                    RecItemC."Single-Level Mfg. Ovhd Cost" := RecItemE."Single-Level Mfg. Ovhd Cost";
                    RecItemC."Overhead Rate" := RecItemE."Overhead Rate";
                    RecItemC."Rolled-up Subcontracted Cost" := RecItemE."Rolled-up Subcontracted Cost";
                    RecItemC."Rolled-up Mfg. Ovhd Cost" := RecItemE."Rolled-up Mfg. Ovhd Cost";
                    RecItemC."Rolled-up Cap. Overhead Cost" := RecItemE."Rolled-up Cap. Overhead Cost";
                    RecItemC."Order Tracking Policy" := RecItemE."Order Tracking Policy";
                    RecItemC."Production Forecast Name" := RecItemE."Production Forecast Name";
                    RecItemC."Component Forecast" := RecItemE."Component Forecast";
                    RecItemC.Critical := RecItemE.Critical;
                    RecItemC."Common Item No." := RecItemE."Common Item No.";
                    RecItemC."Service Item Group" := RecItemE."Service Item Group";
                    RecItemC.asd := RecItemE.asd;
                    RecItemC."Clasificación A,B,C" := RecItemE."Clasificación A,B,C";
                    RecItemC."Fecha asignada clasificación" := RecItemE."Fecha asignada clasificación";
                    RecItemC."Fecha Descatalogación" := RecItemE."Fecha Descatalogación";
                    RecItemC."% clasi A,B,C" := RecItemE."% clasi A,B,C";
                    RecItemC."Usuario última modificación" := RecItemE."Usuario última modificación";
                    RecItemC."Fecha Alta" := RecItemE."Fecha Alta";
                    RecItemC."Fecha Lanzamiento" := RecItemE."Fecha Lanzamiento";
                    RecItemC."Fecha última modificación" := RecItemE."Fecha última modificación";
                    RecItemC."Acumu. A,B,C" := RecItemE."Acumu. A,B,C";
                    RecItemC."Fecha recalcula no permitir" := RecItemE."Fecha recalcula no permitir";
                    RecItemC."Clase logistica" := RecItemE."Clase logistica";
                    RecItemC."Prohibido Amazon" := RecItemE."Prohibido Amazon";
                    RecItemC."Producto FRAGIL" := RecItemE."Producto FRAGIL";
                    RecItemC."Observaciones AMAZON" := RecItemE."Observaciones AMAZON";
                    RecItemC."Estado Producto" := RecItemE."Estado Producto";
                    RecItemC."Fecha prohibido Amazon" := RecItemE."Fecha prohibido Amazon";
                    RecItemC."Usuario modificación" := RecItemE."Usuario modificación";
                    RecItemC."Hora modificación" := RecItemE."Hora modificación";
                    RecItemC."Stock para Catit" := RecItemE."Stock para Catit";
                    RecItemC."Precio recomendado" := RecItemE."Precio recomendado";
                    RecItemC.Familia := RecItemE.Familia;
                    RecItemC.Subfamilia := RecItemE.Subfamilia;
                    RecItemC.ean := RecItemE.ean;
                    RecItemC."Tipo proveedor" := RecItemE."Tipo proveedor";
                    RecItemC."Criterio rotacion" := RecItemE."Criterio rotacion";
                    RecItemC."Unidades venta" := RecItemE."Unidades venta";
                    RecItemC."Permite fraccionar venta" := RecItemE."Permite fraccionar venta";
                    RecItemC."Exit Point" := RecItemE."Exit Point";
                    RecItemC."Stock Bloqueo Amz" := RecItemE."Stock Bloqueo Amz";
                    RecItemC."Kgs. de plástico" := RecItemE."Kgs. de plástico";
                    RecItemC."Pdte. Enviar a WEB" := RecItemE."Pdte. Enviar a WEB";
                    RecItemC."Ref. AMAZON" := RecItemE."Ref. AMAZON";
                    RecItemC."RII-AAEE" := RecItemE."RII-AAEE";
                    RecItemC."Cantidad palets" := RecItemE."Cantidad palets";
                    RecItemC."Cantidad master" := RecItemE."Cantidad master";
                    RecItemC."Cantidad inner" := RecItemE."Cantidad inner";
                    RecItemC."Fecha proxima recepción conten" := RecItemE."Fecha proxima recepción conten";
                    RecItemC."Tipo producto" := RecItemE."Tipo producto";
                    RecItemC."Unidad compra" := RecItemE."Unidad compra";
                    RecItemC."Fecha proxima recepción pedido" := RecItemE."Fecha proxima recepción pedido";
                    RecItemC."Comentario para pedido1" := RecItemE."Comentario para pedido1";
                    RecItemC."Comentario para pedido2" := RecItemE."Comentario para pedido2";
                    RecItemC."Tipo palet" := RecItemE."Tipo palet";
                    RecItemC."Tipo preparacion" := RecItemE."Tipo preparacion";
                    RecItemC."Existencia TENERIFE" := RecItemE."Existencia TENERIFE";
                    RecItemC."Producto almacenable" := RecItemE."Producto almacenable";
                    RecItemC."Tiene productos asociados" := RecItemE."Tiene productos asociados";
                    RecItemC."Enviar siempre" := RecItemE."Enviar siempre";
                    RecItemC."No permite pedido" := RecItemE."No permite pedido";
                    RecItemC."Texto no permite pedido" := RecItemE."Texto no permite pedido";
                    RecItemC."Existencia CATIT" := RecItemE."Existencia CATIT";
                    RecItemC."Producto NO automatico" := RecItemE."Producto NO automatico";
                    RecItemC."Fecha en picking" := RecItemE."Fecha en picking";
                    RecItemC."Ref. hagen" := RecItemE."Ref. hagen";
                    RecItemC."Fecha disponible Web" := RecItemE."Fecha disponible Web";
                    RecItemC."Producto PADRE" := RecItemE."Producto PADRE";
                    RecItemC.Marca := RecItemE.Marca;
                    RecItemC."Descripcion web" := RecItemE."Descripcion web";
                    RecItemC."Enviar a web" := RecItemE."Enviar a web";
                    RecItemC."Producto con reserva" := RecItemE."Producto con reserva";
                    RecItemC."Metros Cúbicos Master" := RecItemE."Metros Cúbicos Master";
                    RecItemC."Kilos Master" := RecItemE."Kilos Master";
                    RecItemC."EAN INNER" := RecItemE."EAN INNER";
                    RecItemC."EAN MASTER" := RecItemE."EAN MASTER";
                    RecItemC."Etiqueta portugues" := RecItemE."Etiqueta portugues";
                    RecItemC."Tamaño etiqueta" := RecItemE."Tamaño etiqueta";
                    RecItemC."Alto master" := RecItemE."Alto master";
                    RecItemC."Ancho master" := RecItemE."Ancho master";
                    RecItemC."Largo master" := RecItemE."Largo master";
                    RecItemC.Alto := RecItemE.Alto;
                    RecItemC.Ancho := RecItemE.Ancho;
                    RecItemC.Largo := RecItemE.Largo;
                    RecItemC.Ventas := RecItemE.Ventas;
                    RecItemC.Promedio := RecItemE.Promedio;
                    RecItemC.Rotacion := RecItemE.Rotacion;
                    RecItemC.Dias := RecItemE.Dias;
                    RecItemC."Producto web" := RecItemE."Producto web";
                    RecItemC."Unidad expedicion ECI" := RecItemE."Unidad expedicion ECI";
                    RecItemC."+ Linea" := RecItemE."+ Linea";
                    RecItemC."+ Familia" := RecItemE."+ Familia";
                    RecItemC."+ Familia 2" := RecItemE."+ Familia 2";
                    RecItemC."+ Familia 3" := RecItemE."+ Familia 3";
                    RecItemC."+ Familia 4" := RecItemE."+ Familia 4";
                    RecItemC."+ Subfamilia" := RecItemE."+ Subfamilia";
                    RecItemC."+ Subfamilia 2" := RecItemE."+ Subfamilia 2";
                    RecItemC."+ Subfamilia 3" := RecItemE."+ Subfamilia 3";
                    RecItemC."+ Subfamilia 4" := RecItemE."+ Subfamilia 4";
                    RecItemC."+ Familia 1" := RecItemE."+ Familia 1";
                    RecItemC."+ Subfamilia 1" := RecItemE."+ Subfamilia 1";
                    RecItemC."+ Linea 1" := RecItemE."+ Linea 1";
                    RecItemC."+ Linea 2" := RecItemE."+ Linea 2";
                    RecItemC."+ Linea 3" := RecItemE."+ Linea 3";
                    RecItemC."+ Linea 4" := RecItemE."+ Linea 4";
                    RecItemC."Estado WEB Inactivo" := RecItemE."Estado WEB Inactivo";
                    RecItemC."Producto Hagen" := RecItemE."Producto Hagen";
                    RecItemC."Largo producto" := RecItemE."Largo producto";
                    RecItemC."Ancho producto" := RecItemE."Ancho producto";
                    RecItemC."Alto producto" := RecItemE."Alto producto";
                    RecItemC."Ref. Catit" := RecItemE."Ref. Catit";
                    RecItemC."Coste Catit" := RecItemE."Coste Catit";
                    RecItemC."Familia Catit" := RecItemE."Familia Catit";
                    RecItemC."Subfamilia Catit" := RecItemE."Subfamilia Catit";
                    RecItemC."Estatus Web" := RecItemE."Estatus Web";
                    RecItemC."Atributo 1" := RecItemE."Atributo 1";
                    RecItemC."Atributo 2" := RecItemE."Atributo 2";
                    RecItemC."Atributo 3" := RecItemE."Atributo 3";
                    RecItemC."Valor Atributo 1" := RecItemE."Valor Atributo 1";
                    RecItemC."Valor Atributo 2" := RecItemE."Valor Atributo 2";
                    RecItemC."Valor Atributo 3" := RecItemE."Valor Atributo 3";
                    RecItemC."NO-Rotura de Stock" := RecItemE."NO-Rotura de Stock";
                    RecItemC."Clasificacion CANADA" := RecItemE."Clasificacion CANADA";
                    RecItemC."Fecha modif" := RecItemE."Fecha modif";
                    RecItemC."Fecha sub web" := RecItemE."Fecha sub web";
                    RecItemC.Temporalidad := RecItemE.Temporalidad;
                    RecItemC."Objetivo Anual" := RecItemE."Objetivo Anual";
                    RecItemC."Objetivo trimestre 1" := RecItemE."Objetivo trimestre 1";
                    RecItemC."Objetivo trimestre 2" := RecItemE."Objetivo trimestre 2";
                    RecItemC."Objetivo trimestre 3" := RecItemE."Objetivo trimestre 3";
                    RecItemC."Objetivo trimestre 4" := RecItemE."Objetivo trimestre 4";
                    RecItemC."Filtro Pais" := RecItemE."Filtro Pais";
                    RecItemC."Existencia SILLA SALDO" := RecItemE."Existencia SILLA SALDO";
                    RecItemC."Filtro Cliente" := RecItemE."Filtro Cliente";
                    RecItemC."Alto CAJA" := RecItemE."Alto CAJA";
                    RecItemC."Ancho CAJA" := RecItemE."Ancho CAJA";
                    RecItemC."Largo CAJA" := RecItemE."Largo CAJA";
                    RecItemC."Volumen CAJA" := RecItemE."Volumen CAJA";
                    RecItemC."Alto INNER" := RecItemE."Alto INNER";
                    RecItemC."Ancho INNER" := RecItemE."Ancho INNER";
                    RecItemC."Largo INNER" := RecItemE."Largo INNER";
                    RecItemC."Volumen INNER" := RecItemE."Volumen INNER";
                    RecItemC."Imagen Articulo WEB" := RecItemE."Imagen Articulo WEB";
                    RecItemC."Filtro Grupo clientes" := RecItemE."Filtro Grupo clientes";
                    RecItemC."NO MULTIPEDIDO" := RecItemE."NO MULTIPEDIDO";
                    RecItemC."Importe ABC" := RecItemE."Importe ABC";
                    RecItemC."Importe total ABC" := RecItemE."Importe total ABC";
                    RecItemC."Cantidad colchon web" := RecItemE."Cantidad colchon web";
                    RecItemC."Stock para la web" := RecItemE."Stock para la web";
                    RecItemC."Stock en HAGEN" := RecItemE."Stock en HAGEN";
                    RecItemC."Tarifa 2019" := RecItemE."Tarifa 2019";
                    RecItemC."PVP Recomendado 2019" := RecItemE."PVP Recomendado 2019";
                    RecItemC."CUANTOS UDS EANS" := RecItemE."CUANTOS UDS EANS";
                    RecItemC."Tarifa 2021" := RecItemE."Tarifa 2021";
                    RecItemC."PVP Recomendado 2021" := RecItemE."PVP Recomendado 2021";
                    RecItemC."Voluminoso web" := RecItemE."Voluminoso web";
                    RecItemC."IVA IGIC" := RecItemE."IVA IGIC";
                    RecItemC."Excluir de dropbox" := RecItemE."Excluir de dropbox";
                    RecItemC."FIJO Excluir de dropbox" := RecItemE."FIJO Excluir de dropbox";
                    RecItemC."Tarifa 2021-2" := RecItemE."Tarifa 2021-2";
                    RecItemC."PVP Recomendado 2021-2" := RecItemE."PVP Recomendado 2021-2";
                    RecItemC."Tarifa 2021 amazon21" := RecItemE."Tarifa 2021 amazon21";
                    RecItemC."PVP Recomendado 2021 amazon21" := RecItemE."PVP Recomendado 2021 amazon21";
                    RecItemC."Tarifa 2021 AMZ2021-3" := RecItemE."Tarifa 2021 AMZ2021-3";
                    RecItemC."PVP Recomendado 2021 AMZ2021-3" := RecItemE."PVP Recomendado 2021 AMZ2021-3";
                    RecItemC."Tarifa 2022" := RecItemE."Tarifa 2022";
                    RecItemC."PVP Recomendado 2022" := RecItemE."PVP Recomendado 2022";
                    RecItemC."Tarifa 2022-2" := RecItemE."Tarifa 2022-2";
                    RecItemC."PVP-Web" := RecItemE."PVP-Web";
                    RecItemC."PVP-Web2" := RecItemE."PVP-Web2";
                    RecItemC."Tarifa AMZ2023" := RecItemE."Tarifa AMZ2023";
                    RecItemC."PVP Recomendado AMZ2023" := RecItemE."PVP Recomendado AMZ2023";
                    RecItemC."Precio inv 2009" := RecItemE."Precio inv 2009";
                    RecItemC."URL IMAGEN 1" := RecItemE."URL IMAGEN 1";
                    RecItemC.Agosto := RecItemE.Agosto;
                    RecItemC.Septiembre := RecItemE.Septiembre;
                    RecItemC.Octubre := RecItemE.Octubre;
                    RecItemC.Noviembre := RecItemE.Noviembre;
                    RecItemC.Diciembre := RecItemE.Diciembre;
                    RecItemC."Umbral stock" := RecItemE."Umbral stock";
                    RecItemC.Variante1 := RecItemE.Variante1;
                    RecItemC.Variante2 := RecItemE.Variante2;
                    RecItemC."Dato Variante1" := RecItemE."Dato Variante1";
                    RecItemC."Dato Variante2" := RecItemE."Dato Variante2";
                    RecItemC.CodVariante1 := RecItemE.CodVariante1;
                    RecItemC.CodVariante2 := RecItemE.CodVariante2;
                    RecItemC."PVP Recomendado 2022-2" := RecItemE."PVP Recomendado 2022-2";
                    RecItemC."PVP 2025DC00" := RecItemE."PVP 2025DC00";
                    RecItemC.subido := RecItemE.subido;
                    RecItemC."Actualizar WEB" := RecItemE."Actualizar WEB";
                    RecItemC."Imagen Articulo WEB 2" := RecItemE."Imagen Articulo WEB 2";
                    RecItemC."Imagen Articulo WEB 3" := RecItemE."Imagen Articulo WEB 3";
                    RecItemC."Imagen Articulo WEB 4" := RecItemE."Imagen Articulo WEB 4";
                    RecItemC."Actualizar WEB Imagenes" := RecItemE."Actualizar WEB Imagenes";
                    RecItemC."Actualizar WEB Descripcion" := RecItemE."Actualizar WEB Descripcion";
                    RecItemC."Producto en promocion WEB" := RecItemE."Producto en promocion WEB";
                    RecItemC."Fecha inicio promocion WEB" := RecItemE."Fecha inicio promocion WEB";
                    RecItemC."Fecha fin promocion WEB" := RecItemE."Fecha fin promocion WEB";
                    RecItemC."No enviar precio especial" := RecItemE."No enviar precio especial";
                    RecItemC."Inventory 2" := RecItemE."Inventory 2";
                    RecItemC."Net Change 2" := RecItemE."Net Change 2";
                    RecItemC."coste ult" := RecItemE."coste ult";
                    RecItemC.Level1 := RecItemE.Level1;
                    RecItemC.Level2 := RecItemE.Level2;
                    RecItemC.Level3 := RecItemE.Level3;
                    RecItemC.Etiquetas1 := RecItemE.Etiquetas1;
                    RecItemC.Etiquetas2 := RecItemE.Etiquetas2;
                    RecItemC.Etiquetas3 := RecItemE.Etiquetas3;
                    RecItemC.Etiquetas4 := RecItemE.Etiquetas4;
                    RecItemC.Etiquetas5 := RecItemE.Etiquetas5;
                    RecItemC.Etiquetas6 := RecItemE.Etiquetas6;
                    RecItemC.Gama := RecItemE.Gama;
                    RecItemC.FechaHoraModificacionWeb := RecItemE.FechaHoraModificacionWeb;
                    RecItemC."VAT Prod. Posting Group" := RecItemE."IVA IGIC";
                    RecItemC.Modify;
                end;
                IF NOT RecItemC.FindFirst() THEN begin
                    RecItemC := RecItemE;
                    RecItemC.Insert;
                end;
            UNTIL RecItemE.NEXT = 0;


        VENTANA.CLOSE;
    end;

    local procedure PreciosVenta()
    begin

        VENTANA.Open('#1#################');
        RecSPE.ChangeCompany('ROLF C HAGEN ESPAÑA S.A.');
        if RecSPE.FindFirst then
            repeat
                VENTANA.Update(1, FORMAT('SP') + '-' + FORMAT(RecSPE."Item No."));
                RecSPC.ChangeCompany('HAGEN CANARIAS S.C.');
                RecSPC.SetRange("Item No.", RecSPE."Item No.");
                RecSPC.SetRange("Sales Code", RecSPE."Sales Code");
                RecSPC.SetRange("Currency Code", RecSPE."Currency Code");
                RecSPC.SetRange("Starting Date", RecSPE."Starting Date");
                RecSPC.SetRange("Sales Type", RecSPE."Sales Type");
                RecSPC.SetRange("Minimum Quantity", RecSPE."Minimum Quantity");
                RecSPC.SetRange("Unit of Measure Code", RecSPE."Unit of Measure Code");
                RecSPC.SetRange("Variant Code", RecSPE."Variant Code");
                IF RecSPC.FindFirst() THEN begin
                    RecSPC."Unit Price" := RecSPE."Unit Price";
                    RecSPC."Price Includes VAT" := RecSPE."Price Includes VAT";
                    RecSPC."Allow Invoice Disc." := RecSPE."Allow Invoice Disc.";
                    RecSPC."VAT Bus. Posting Gr. (Price)" := RecSPE."VAT Bus. Posting Gr. (Price)";
                    RecSPC."Ending Date" := RecSPE."Ending Date";
                    // RecSPC."Coupled to CRM" := RecSPE."Coupled to CRM";
                    RecSPC."Coupled to Dataverse" := RecSPE."Coupled to Dataverse";
                    RecSPC."Allow Line Disc." := RecSPE."Allow Line Disc.";
                    RecSPC."Precio recomendado" := RecSPE."Precio recomendado";
                    RecSPC."Descripción" := RecSPE."Descripción";
                    RecSPC.EXISTE := RecSPE.EXISTE;
                    RecSPC.INCREMENTO := RecSPE.INCREMENTO;
                    RecSPC."Unidades Venta" := RecSPE."Unidades Venta";
                    RecSPC."EXISTE COD PADRE" := RecSPE."EXISTE COD PADRE";
                    RecSPC.NETO := RecSPE.NETO;
                    RecSPC."EXISTE 2012" := RecSPE."EXISTE 2012";
                    RecSPC."Precio incial" := RecSPE."Precio incial";
                    RecSPC.Dto1 := RecSPE.Dto1;
                    RecSPC.Dto2 := RecSPE.Dto2;
                    RecSPC.Dto3 := RecSPE.Dto3;
                    RecSPC."Ref. hagen" := RecSPE."Ref. hagen";
                    RecSPC."Ref. hagen 2" := RecSPE."Ref. hagen 2";
                    RecSPC.cuantos := RecSPE.cuantos;
                    RecSPC."Fecha modif" := RecSPE."Fecha modif";
                    RecSPC."Hora modif" := RecSPE."Hora modif";
                    RecSPC."Fecha hora modif" := RecSPE."Fecha hora modif";
                    RecSPC."Fecha hora modif web" := RecSPE."Fecha hora modif web";
                    RecSPC."Codigo INNER o MASTET" := RecSPE."Codigo INNER o MASTET";
                    RecSPC."Codigo concatenado" := RecSPE."Codigo concatenado";
                    RecSPC.ean := RecSPE.ean;
                    RecSPC."Cantidad unidades medida" := RecSPE."Cantidad unidades medida";
                    RecSPC.Producto_web := RecSPE.Producto_web;
                    RecSPC.WebB2B := RecSPE.WebB2B;
                    RecSPC.FechaHoraModificacionWeb := RecSPE.FechaHoraModificacionWeb;
                    RecSPC.Modify;
                end;
                IF NOT RecSPC.FindFirst() THEN begin
                    RecSPC := RecSPE;
                    RecSPC.Insert;
                end;
            UNTIL RecSPE.NEXT = 0;



        VENTANA.Close;


    end;

    local procedure Descuentos()
    begin
        VENTANA.Open('#1#################');
        RecSLDE.ChangeCompany('ROLF C HAGEN ESPAÑA S.A.');
        if RecSLDE.FindFirst then
            repeat
                VENTANA.Update(1, FORMAT('SLD') + '-' + FORMAT(RecSLDE.Code));
                RecSLDC.ChangeCompany('HAGEN CANARIAS S.C.');
                RecSLDC.SetRange(Code, RecSLDE.Code);
                RecSLDC.SetRange("Sales Code", RecSLDE."Sales Code");
                RecSLDC.SetRange("Currency Code", RecSLDE."Currency Code");
                RecSLDC.SetRange("Starting Date", RecSLDE."Starting Date");
                RecSLDC.SetRange("Sales Type", RecSLDE."Sales Type");
                RecSLDC.SetRange("Minimum Quantity", RecSLDE."Minimum Quantity");
                RecSLDC.SetRange(Type, RecSLDE.Type);
                RecSLDC.SetRange("Unit of Measure Code", RecSLDE."Unit of Measure Code");
                RecSLDC.SetRange("Variant Code", RecSLDE."Variant Code");
                IF RecSLDC.FindFirst() THEN begin
                    RecSLDC."Line Discount %" := RecSLDE."Line Discount %";
                    RecSLDC."Ending Date" := RecSLDE."Ending Date";
                    RecSLDC."Descripción" := RecSLDE."Descripción";
                    RecSLDC."Oferta de descuento" := RecSLDE."Oferta de descuento";
                    RecSLDC.Vigente := RecSLDE.Vigente;
                    RecSLDC."Fecha alta" := RecSLDE."Fecha alta";
                    RecSLDC."Producto padre" := RecSLDE."Producto padre";
                    RecSLDC.Promocion := RecSLDE.Promocion;
                    RecSLDC."Fecha modif" := RecSLDE."Fecha modif";
                    RecSLDC."Hora modif" := RecSLDE."Hora modif";
                    RecSLDC."Fecha hora modif" := RecSLDE."Fecha hora modif";
                    RecSLDC."Fecha hora modif web" := RecSLDE."Fecha hora modif web";
                    RecSLDC."Pdte. Enviar a WEB" := RecSLDE."Pdte. Enviar a WEB";
                    RecSLDC.Modify;
                end;
                IF NOT RecSLDC.FindFirst() THEN begin
                    RecSLDC := RecSLDE;
                    RecSLDC.Insert;
                end;
            UNTIL RecSLDE.NEXT = 0;



        VENTANA.Close;

    end;

    local procedure StockTenerife()
    begin


        RecSDP.Reset;
        RecSDP.SetRange(RecSDP."Journal Template Name", 'PRODUCTO');
        RecSDP.SetRange(RecSDP.Name, 'TENERIFE');
        if not RecSDP.FindFirst then begin
            RecSDP."Journal Template Name" := 'PRODUCTO';
            RecSDP.Name := 'TENERIFE';
            RecSDP.Insert;
        end;
        lin := 10000;
        Rec83.Reset;
        Rec83.SetRange(Rec83."Journal Template Name", 'PRODUCTO');
        Rec83.SetRange(Rec83."Journal Batch Name", 'TENERIFE');
        if Rec83.FindFirst THEN
            repeat
                Rec83.DELETE;
            UNTIL Rec83.Next = 0;





        RecItem2C.RESET;
        RecItem2C.ChangeCompany('HAGEN CANARIAS S.C.');
        RecItem2C.SetFilter("Location Filter", 'CAN', 'CAN');
        if RecItem2C.FindSet then
            repeat
                RecItem2C.CalcFields(Inventory);
                ExistenciaC := RecItem2C.Inventory;

                ExistenciaE := 0;
                RecItem1E.RESET;
                RecItem1E.ChangeCompany('ROLF C HAGEN ESPAÑA S.A.');
                RecItem1E.SetFilter("Location Filter", 'TENERIFE', 'TENERIFE');
                RecItem1E.SetFilter("No.", RecItem2C."No.");
                if RecItem1E.FindSet then BEGIN
                    RecItem1E.CalcFields(Inventory);
                    ExistenciaE := RecItem1E.Inventory
                END;


                atraspasar := ExistenciaC - ExistenciaE;
                if atraspasar > 0 then begin
                    Rec83.ChangeCompany('ROLF C HAGEN ESPAÑA S.A.');
                    Rec83.Init;
                    Rec83."Journal Template Name" := 'PRODUCTO';
                    Rec83."Journal Batch Name" := 'TENERIFE';
                    lin := lin + 10000;
                    Rec83."Line No." := lin;
                    Rec83.Validate(Rec83."Item No.", RecItem2C."No.");
                    Rec83."Posting Date" := Today;
                    Rec83.Validate(Rec83."Entry Type", Rec83."Entry Type"::"Positive Adjmt.");
                    Rec83.Validate(Rec83.Quantity, atraspasar);
                    Rec83."Document No." := 'AJUSTES TENERIFE';
                    Rec83."Location Code" := 'CATIT';
                    Rec83.Insert;
                    Rec83.Init;
                    Rec83."Journal Template Name" := 'PRODUCTO';
                    Rec83."Journal Batch Name" := 'TENERIFE';
                    lin := lin + 10000;
                    Rec83."Line No." := lin;
                    Rec83.Validate(Rec83."Item No.", RecItem2C."No.");
                    Rec83."Posting Date" := Today;
                    Rec83.Validate(Rec83."Entry Type", Rec83."Entry Type"::"Negative Adjmt.");
                    Rec83.Validate(Rec83.Quantity, atraspasar);
                    Rec83."Document No." := 'AJUSTES TENERIFE';
                    Rec83."Location Code" := 'TENERIFE';
                    Rec83.Insert;
                end;


            until RecItem2C.next = 0;


        Rec83.Reset;
        Rec83.SetRange(Rec83."Journal Template Name", 'PRODUCTO');
        Rec83.SetRange(Rec83."Journal Batch Name", 'TENERIFE');
        if Rec83.FindFirst then begin
            CURegMov.Run(Rec83);
        end;

    END;


}

