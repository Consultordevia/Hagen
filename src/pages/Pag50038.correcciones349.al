#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50038 "correcciones 349"
{
    /*
    DeleteAllowed = false;    
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Customer/Vendor Warning 349";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field("Customer/Vendor No.";"Customer/Vendor No.")
                {
                    ApplicationArea = Basic;
                }
                field("Customer/Vendor Name";"Customer/Vendor Name")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Document No.";"Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Previous Declared Amount";"Previous Declared Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Original Declaration FY";"Original Declaration FY")
                {
                    ApplicationArea = Basic;
                }
                field("Original Declaration Period";"Original Declaration Period")
                {
                    ApplicationArea = Basic;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Declaracion349.Reset;
                        Declaracion349.SetRange(Declaracion349.CIF,VAT);
                        Declaracion349.SetRange(Registrada,true);
                        if Page.RunModal(50039,Declaracion349) = Action::LookupOK then begin
                          "Original Declaration FY" := Declaracion349.Declaracion;
                          case Declaracion349.Period of
                            Declaracion349.Period::"01": "Original Declaration Period" := '01';
                            Declaracion349.Period::"02": "Original Declaration Period" := '02';
                            Declaracion349.Period::"03": "Original Declaration Period" := '03';
                            Declaracion349.Period::"04": "Original Declaration Period" := '04';
                            Declaracion349.Period::"05": "Original Declaration Period" := '05';
                            Declaracion349.Period::"06": "Original Declaration Period" := '06';
                            Declaracion349.Period::"07": "Original Declaration Period" := '07';
                            Declaracion349.Period::"08": "Original Declaration Period" := '08';
                            Declaracion349.Period::"09": "Original Declaration Period" := '09';
                            Declaracion349.Period::"10": "Original Declaration Period" := '10';
                            Declaracion349.Period::"11": "Original Declaration Period" := '11';
                            Declaracion349.Period::"12": "Original Declaration Period" := '12';
                          end;
                          "Previous Declared Amount" := Declaracion349."Importe Actual Corregido";
                          "Original Declared Amount" := Declaracion349."Importe Actual Corregido" - Importe;
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        Declaracion349.Reset;
                        Declaracion349.SetRange(Declaracion349.CIF,VAT);
                        Declaracion349.SetRange(Registrada,true);
                        Declaracion349.SetRange(Declaracion,"Original Declaration FY");
                        case "Original Declaration Period" of
                          '01' : Declaracion349.SetRange(Period,Declaracion349.Period::"01");
                          '02' : Declaracion349.SetRange(Period,Declaracion349.Period::"02");
                          '03' : Declaracion349.SetRange(Period,Declaracion349.Period::"03");
                          '04' : Declaracion349.SetRange(Period,Declaracion349.Period::"04");
                          '05' : Declaracion349.SetRange(Period,Declaracion349.Period::"05");
                          '06' : Declaracion349.SetRange(Period,Declaracion349.Period::"06");
                          '07' : Declaracion349.SetRange(Period,Declaracion349.Period::"07");
                          '08' : Declaracion349.SetRange(Period,Declaracion349.Period::"08");
                          '09' : Declaracion349.SetRange(Period,Declaracion349.Period::"09");
                          '10' : Declaracion349.SetRange(Period,Declaracion349.Period::"10");
                          '11' : Declaracion349.SetRange(Period,Declaracion349.Period::"11");
                          '12' : Declaracion349.SetRange(Period,Declaracion349.Period::"12");
                        end;

                        if Declaracion349.FindFirst then begin
                          "Previous Declared Amount" := Declaracion349."Importe Actual Corregido";
                          "Original Declared Amount" := Declaracion349."Importe Actual Corregido" - Importe;
                        end else begin
                          "Previous Declared Amount" := 0;
                          "Original Declared Amount" := 0;
                        end;
                    end;
                }
                field("Original Declared Amount";"Original Declared Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Original Declared Amount';
                }
                field(Importe;Importe)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        Declaracion349: Record UnknownRecord50015;
        */
}

