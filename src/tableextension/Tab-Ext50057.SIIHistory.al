tableextension 50057 "SII History" extends "SII History"
{
    fields
    {
        field(50000; TipoDocumento; Enum "SII Doc. Upload State Document Type")
        {
            Caption = 'TipoDocumento';
            FieldClass = FlowField;
            CalcFormula = lookup("SII Doc. Upload State"."Document Type" where(Id = field("Document State Id")));
            //DataClassification = ToBeClassified;
        }
        field(50001; NDocumento; Code[35])
        {
            Caption = 'N Documento';
            FieldClass = FlowField;
            CalcFormula = lookup("SII Doc. Upload State"."Document No." where(Id = field("Document State Id")));
            //DataClassification = ToBeClassified;
        }
        field(50002; ClienteProveedor; Code[35])
        {
            Caption = 'Cliente Proveedor';
            FieldClass = FlowField;
            CalcFormula = lookup("SII Doc. Upload State"."CV Name" where(Id = field("Document State Id")));
            //DataClassification = ToBeClassified;
        }
        field(50003; FechaReg; Date)
        {
            Caption = 'Fecha Reg.';
            FieldClass = FlowField;
            CalcFormula = lookup("SII Doc. Upload State"."Posting Date" where(Id = field("Document State Id")));
            //DataClassification = ToBeClassified;
        }
    }
}
