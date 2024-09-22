#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50176 "Listado carga"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Sales Shipment Header";
    SourceTableView = sorting("Posting Date","Shipping Agent Code","No.")
                      order(descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                /*  /////-
                field("Marcar para listado carga";"Marcar para listado carga")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marca';
                }
                field("Shipping Agent Code";"Shipping Agent Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Shipping Agent Code';
                    Editable = false;
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sell-to Customer No.';
                    Editable = false;
                }
                field("Ship-to Name";"Ship-to Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ship-to Name';
                    Editable = false;
                }
                field("Ship-to Address";"Ship-to Address")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ship-to Address';
                    Editable = false;
                }
                field("Ship-to City";"Ship-to City")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ship-to City';
                    Editable = false;
                }
                field("Ship-to County";"Ship-to County")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ship-to County';
                    Editable = false;
                }
                field("Ship-to Post Code";"Ship-to Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ship-to Post Code';
                    Editable = false;
                }
                field("Ship-to Country/Region Code";"Ship-to Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ship-to Country/Region Code';
                    Editable = false;
                }
                field("Nº bultos";"Nº bultos")
                {
                    ApplicationArea = Basic;
                }
                field("Nº Palets";"Nº Palets")
                {
                    ApplicationArea = Basic;
                }
                field("""Nº bultos""+""Nº Palets""";"Nº bultos"+"Nº Palets")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total bultos';
                }
                field("Total peso";"Total peso")
                {
                    ApplicationArea = Basic;
                }
                field(Volumen;Volumen)
                {
                    ApplicationArea = Basic;
                }
                field("Nº expedición";"Nº expedición")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                */
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin


         /////-SetRange("Posting Date",Today);
    end;
}

