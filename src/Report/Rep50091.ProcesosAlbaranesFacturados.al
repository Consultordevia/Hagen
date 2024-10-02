#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50091 "Procesos Albaranes Facturados"
{
    Permissions = TableData "Sales Shipment Header"=m;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Shipment Header";"Sales Shipment Header")
        {
            DataItemTableView = sorting("Posting Date") where("Albaran facturado"=const(No));
            RequestFilterFields = "No.","Posting Date";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Dialogo.Update(1,"Sales Shipment Header"."No.");
                Procesados := Procesados + 1 ;
                Dialogo.Update(4,Procesados);
                TodoF := true;
                LinAlba.SetRange(LinAlba."Document No.","Sales Shipment Header"."No.");
                ///LinAlba.SETRANGE(LinAlba.Type,2);
                if LinAlba.Find('-') then repeat
                   Dialogo.Update(2,LinAlba."Line No.");
                   if LinAlba.Quantity <> LinAlba."Quantity Invoiced" then begin
                     TodoF := false;
                   end;
                 until LinAlba.Next = 0;
                if TodoF then begin
                   CabAlba.Get("Sales Shipment Header"."No.");
                   CabAlba."Albaran facturado" := true;
                   CabAlba.Modify;
                   Commit;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Dialogo.Open('Nº de Albaran #1##########\'+
                     'Nº de Linea   #2##########\'+
                     'Nº Total      #3##########\'+
                     'Procesados    #4##########');
        Dialogo.Update(3,"Sales Shipment Header".Count);
    end;

    var
        CabAlba: Record "Sales Shipment Header";
        LinAlba: Record "Sales Shipment Line";
        TodoF: Boolean;
        Dialogo: Dialog;
        Procesados: Integer;
}

