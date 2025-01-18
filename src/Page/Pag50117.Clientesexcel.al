page 50117 Clientesexcel
{
    ApplicationArea = All;
    Caption = 'ClienteEexcel';
    PageType = List;
    SourceTable = Customer;  
    
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies a unique number that identifies the customer. The number can be generated automatically from a number series, or you can number each of them manually.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the customer''s address. This address will appear on all sales documents for the customer.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the state, province or county as a part of the address.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region of the address.';
                }
                field("Enviar a Web"; Rec."Enviar a Web")
                {
                    ToolTip = 'Specifies the value of the Enviar a Web field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the customer''s name that appears on all related documents. For companies, specify the company''s name here, and then add the relevant people as contacts that you link to this customer.';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies an additional part of the name.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the customer''s telephone number.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field("Nº movil"; Rec."Nº movil")
                {
                    ToolTip = 'Specifies the value of the Nº movil field.', Comment = '%';
                }
            }
        }
    }
}
