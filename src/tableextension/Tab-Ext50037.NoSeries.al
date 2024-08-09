tableextension 50037 "NoSeries" extends "No. Series"
{
    fields
    {
        field(59013; Base; Decimal)
        {
        }
        field(59014; Importe; Decimal)
        {
        }
        field(59016; "Excluir en Modelo 340?"; Boolean)
        {
        }
        field(66000; "Clave operación"; Option)
        {
            InitValue = "01-Regimen común";
            OptionCaption = '01-Regimen común,02-Exportacion/REAGYP,03-Arte,04-Oro,05-Viajes,06-Especial Avanzado,07-Caja,08-IPSI/IGIC,09-Mediador viajes/Adquis.Intrac.,10-cobros de terceros,11-Local con retencion/Local de negocio,12-Local sin retencion,13-Local sin/con retencion/Importacion sin DUA,14-IVA pdte Certif.Obra AAPP/Primer semestre 2017,15-IVA pdte Tracto sucesivo,16-Primer semestre 2017';
            OptionMembers = "01-Regimen común","02-Exportacion/REAGYP","03-Arte","04-Oro","05-Viajes","06-Especial Avanzado","07-Caja","08-IPSI/IGIC","09-Mediador viajes/Adquis.Intrac.","10-cobros de terceros","11-Local con retencion/Local de negocio","12-Local sin retencion","13-Local sin/con retencion/Importacion sin DUA","14-IVA pdte Certif.Obra AAPP/Primer semestre 2017","15-IVA pdte Tracto sucesivo","16-Primer semestre 2017";
        }
        field(66001; "Inversion del Sujeto Pasivo"; Boolean)
        {
        }
        field(66002; "Bloquear Envio SII"; Boolean)
        {
        }
        field(66003; "No SII"; Boolean)
        {
        }
    }
}
