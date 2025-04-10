#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50079 "Proveedor Lista"
{
    PageType = List;
    SourceTable = Vendor;
    ApplicationArea = All;
    Caption = 'Proveedor Lista';
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Shipment Method Code";Rec."Shipment Method Code")
                {
                    ApplicationArea = Basic;
                }
                field("Exit Point";Rec."Exit Point")
                {
                    ApplicationArea = Basic;
                }
                 field("Invoice Type";Rec."Invoice Type"){ ApplicationArea = All; }
                field("Cr. Memo Type";Rec."Cr. Memo Type"){ ApplicationArea = All; }
                 field("Special Scheme Code";Rec."Special Scheme Code"){ ApplicationArea = All; }
                field("Correction Type";Rec."Correction Type"){ ApplicationArea = All; }
        
                field("Do Not Send To SII";Rec."Do Not Send To SII"){ ApplicationArea = All; }        

                field("Area";Rec.Area)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Specification";Rec."Transaction Specification")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Transport Method";Rec."Transport Method")
                {
                    ApplicationArea = Basic;
                }
                field("Search Name";Rec."Search Name")
                {
                    ApplicationArea = Basic;
                }
                field("Name 2";Rec."Name 2")
                {
                    ApplicationArea = Basic;
                }
                field(Address;Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field("Address 2";Rec."Address 2")
                {
                    ApplicationArea = Basic;
                }
                field(City;Rec.City)
                {
                    ApplicationArea = Basic;
                }
                field(Contact;Rec.Contact)
                {
                    ApplicationArea = Basic;
                }
                field("Phone No.";Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Telex No.";Rec."Telex No.")
                {
                    ApplicationArea = Basic;
                }
                field("Our Account No.";Rec."Our Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Territory Code";Rec."Territory Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Budgeted Amount";Rec."Budgeted Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Posting Group";Rec."Vendor Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code";Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Language Code";Rec."Language Code")
                {
                    ApplicationArea = Basic;
                }
                field("Statistics Group";Rec."Statistics Group")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Terms Code";Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Method Code";Rec."Payment Method Code")
                {
                    ApplicationArea = Basic;
                }
                field("Fin. Charge Terms Code";Rec."Fin. Charge Terms Code")
                {
                    ApplicationArea = Basic;
                }
                field("Purchaser Code";Rec."Purchaser Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shipping Agent Code";Rec."Shipping Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field("Invoice Disc. Code";Rec."Invoice Disc. Code")
                {
                    ApplicationArea = Basic;
                }
                field("Country/Region Code";Rec."Country/Region Code")
                {
                    ApplicationArea = Basic;
                }
                field(Comment;Rec.Comment)
                {
                    ApplicationArea = Basic;
                }
                field(Blocked;Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field("Pay-to Vendor No.";Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = Basic;
                }
                field(Priority;Rec.Priority)
                {
                    ApplicationArea = Basic;
                }
                field("VAT Registration No.";Rec."VAT Registration No.")
                {
                    ApplicationArea = Basic;
                }
                field("Gen. Bus. Posting Group";Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Tipo operación";Rec."Tipo operación")
                {
                    ApplicationArea = Basic;
                }
                field("Creado por";Rec."Creado por")
                {
                    ApplicationArea = Basic;
                }
                field("Fecha creación";Rec."Fecha creación")
                {
                    ApplicationArea = Basic;
                }
                field("Importe albaranado";Rec."Importe albaranado")
                {
                    ApplicationArea = Basic;
                }
                field("Importe facturado";Rec."Importe facturado")
                {
                    ApplicationArea = Basic;
                }
                field("Importe abonado";Rec."Importe abonado")
                {
                    ApplicationArea = Basic;
                }
                field("Proveedor de almacen";Rec."Proveedor de almacen")
                {
                    ApplicationArea = Basic;
                }
                field("Banco previsión";Rec."Banco previsión")
                {
                    ApplicationArea = Basic;
                }
                field("Importe minimo pedido compra";Rec."Importe minimo pedido compra")
                {
                    ApplicationArea = Basic;
                }
                field("Tiene refencias asignadas";Rec."Tiene refencias asignadas")
                {
                    ApplicationArea = Basic;
                }
                field("Tipo proveedor";Rec."Tipo proveedor")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified";Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field("Date Filter";Rec."Date Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Filter";Rec."Global Dimension 1 Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Filter";Rec."Global Dimension 2 Filter")
                {
                    ApplicationArea = Basic;
                }
                field(Balance;Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Balance (LCY)";Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Net Change";Rec."Net Change")
                {
                    ApplicationArea = Basic;
                }
                field("Net Change (LCY)";Rec."Net Change (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Purchases (LCY)";Rec."Purchases (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Inv. Discounts (LCY)";Rec."Inv. Discounts (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Pmt. Discounts (LCY)";Rec."Pmt. Discounts (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Due";Rec."Balance Due")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Due (LCY)";Rec."Balance Due (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Payments;Rec.Payments)
                {
                    ApplicationArea = Basic;
                }
                field("Invoice Amounts";Rec."Invoice Amounts")
                {
                    ApplicationArea = Basic;
                }
                field("Cr. Memo Amounts";Rec."Cr. Memo Amounts")
                {
                    ApplicationArea = Basic;
                }
                field("Finance Charge Memo Amounts";Rec."Finance Charge Memo Amounts")
                {
                    ApplicationArea = Basic;
                }
                field("Payments (LCY)";Rec."Payments (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Inv. Amounts (LCY)";Rec."Inv. Amounts (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Cr. Memo Amounts (LCY)";Rec."Cr. Memo Amounts (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Fin. Charge Memo Amounts (LCY)";Rec."Fin. Charge Memo Amounts (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Orders";Rec."Outstanding Orders")
                {
                    ApplicationArea = Basic;
                }
                field("Amt. Rcd. Not Invoiced";Rec."Amt. Rcd. Not Invoiced")
                {
                    ApplicationArea = Basic;
                }
                field("Application Method";Rec."Application Method")
                {
                    ApplicationArea = Basic;
                }
                field("Prices Including VAT";Rec."Prices Including VAT")
                {
                    ApplicationArea = Basic;
                }
                field("Fax No.";Rec."Fax No.")
                {
                    ApplicationArea = Basic;
                }
                field("Telex Answer Back";Rec."Telex Answer Back")
                {
                    ApplicationArea = Basic;
                }
                /////- field(Picture;Picture)
                /////-{
                    /////-ApplicationArea = Basic;
                /////-}
                field(GLN;Rec.GLN)
                {
                    ApplicationArea = Basic;
                }
                field("Post Code";Rec."Post Code")
                {
                    ApplicationArea = Basic;
                }
                field(County;Rec.County)
                {
                    ApplicationArea = Basic;
                }
                field("Debit Amount";Rec."Debit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Amount";Rec."Credit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Debit Amount (LCY)";Rec."Debit Amount (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Amount (LCY)";Rec."Credit Amount (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail";Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Home Page";Rec."Home Page")
                {
                    ApplicationArea = Basic;
                }
                field("Reminder Amounts";Rec."Reminder Amounts")
                {
                    ApplicationArea = Basic;
                }
                field("Reminder Amounts (LCY)";Rec."Reminder Amounts (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Tax Area Code";Rec."Tax Area Code")
                {
                    ApplicationArea = Basic;
                }
                field("Tax Liable";Rec."Tax Liable")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Bus. Posting Group";Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Filter";Rec."Currency Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Orders (LCY)";Rec."Outstanding Orders (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Amt. Rcd. Not Invoiced (LCY)";Rec."Amt. Rcd. Not Invoiced (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Block Payment Tolerance";Rec."Block Payment Tolerance")
                {
                    ApplicationArea = Basic;
                }
                field("Pmt. Disc. Tolerance (LCY)";Rec."Pmt. Disc. Tolerance (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Pmt. Tolerance (LCY)";Rec."Pmt. Tolerance (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("IC Partner Code";Rec."IC Partner Code")
                {
                    ApplicationArea = Basic;
                }
                field(Refunds;Rec.Refunds)
                {
                    ApplicationArea = Basic;
                }
                field("Refunds (LCY)";Rec."Refunds (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Other Amounts";Rec."Other Amounts")
                {
                    ApplicationArea = Basic;
                }
                field("Other Amounts (LCY)";Rec."Other Amounts (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Prepayment %";Rec."Prepayment %")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Invoices";Rec."Outstanding Invoices")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Invoices (LCY)";Rec."Outstanding Invoices (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Pay-to No. Of Archived Doc.";Rec."Pay-to No. Of Archived Doc.")
                {
                    ApplicationArea = Basic;
                }
                field("Buy-from No. Of Archived Doc.";Rec."Buy-from No. Of Archived Doc.")
                {
                    ApplicationArea = Basic;
                }
                field("Partner Type";Rec."Partner Type")
                {
                    ApplicationArea = Basic;
                }
                field(Image;Rec.Image)
                {
                    ApplicationArea = Basic;
                }
                field("Creditor No.";Rec."Creditor No.")
                {
                    ApplicationArea = Basic;
                }
                field("Preferred Bank Account Code";Rec."Preferred Bank Account Code")
                {
                    ApplicationArea = Basic;
                }
                field("Cash Flow Payment Terms Code";Rec."Cash Flow Payment Terms Code")
                {
                    ApplicationArea = Basic;
                }
                field("Primary Contact No.";Rec."Primary Contact No.")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Location Code";Rec."Location Code")
                {
                    ApplicationArea = Basic;
                }
                field("Lead Time Calculation";Rec."Lead Time Calculation")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Pstd. Receipts";Rec."No. of Pstd. Receipts")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Pstd. Invoices";Rec."No. of Pstd. Invoices")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Pstd. Return Shipments";Rec."No. of Pstd. Return Shipments")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Pstd. Credit Memos";Rec."No. of Pstd. Credit Memos")
                {
                    ApplicationArea = Basic;
                }
                field("Pay-to No. of Orders";Rec."Pay-to No. of Orders")
                {
                    ApplicationArea = Basic;
                }
                field("Pay-to No. of Invoices";Rec."Pay-to No. of Invoices")
                {
                    ApplicationArea = Basic;
                }
                field("Pay-to No. of Return Orders";Rec."Pay-to No. of Return Orders")
                {
                    ApplicationArea = Basic;
                }
                field("Pay-to No. of Credit Memos";Rec."Pay-to No. of Credit Memos")
                {
                    ApplicationArea = Basic;
                }
                field("Pay-to No. of Pstd. Receipts";Rec."Pay-to No. of Pstd. Receipts")
                {
                    ApplicationArea = Basic;
                }
                field("Pay-to No. of Pstd. Invoices";Rec."Pay-to No. of Pstd. Invoices")
                {
                    ApplicationArea = Basic;
                }
                field("Pay-to No. of Pstd. Return S.";Rec."Pay-to No. of Pstd. Return S.")
                {
                    ApplicationArea = Basic;
                }
                field("Pay-to No. of Pstd. Cr. Memos";Rec."Pay-to No. of Pstd. Cr. Memos")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Quotes";Rec."No. of Quotes")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Blanket Orders";Rec."No. of Blanket Orders")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Orders";Rec."No. of Orders")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Invoices";Rec."No. of Invoices")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Return Orders";Rec."No. of Return Orders")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Credit Memos";Rec."No. of Credit Memos")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Order Addresses";Rec."No. of Order Addresses")
                {
                    ApplicationArea = Basic;
                }
                field("Pay-to No. of Quotes";Rec."Pay-to No. of Quotes")
                {
                    ApplicationArea = Basic;
                }
                field("Pay-to No. of Blanket Orders";Rec."Pay-to No. of Blanket Orders")
                {
                    ApplicationArea = Basic;
                }
                field("Base Calendar Code";Rec."Base Calendar Code")
                {
                    ApplicationArea = Basic;
                }
                field("Document Sending Profile";Rec."Document Sending Profile")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Days Code";Rec."Payment Days Code")
                {
                    ApplicationArea = Basic;
                }
                field("Non-Paymt. Periods Code";Rec."Non-Paymt. Periods Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

