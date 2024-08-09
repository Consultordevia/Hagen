tableextension 50107 IntrastatJnlLine extends "Intrastat Jnl. Line"
{
    fields
    {
        /// VER revisar
        /// field(11;"Source Type";Option)
        ///{
        ///    BlankZero = true;
        ///    Caption = 'Source Type';
        ///    OptionCaption = ',Item Entry,Job Entry';
        ///    OptionMembers = ,"Item Entry","Job Entry";
        ///
        ///    trigger OnValidate()
        ///    begin
        ///    
        ///        if Type = Type::Shipment then begin
        ///          "Country/Region of Origin Code" := GetCountryOfOriginCode;
        ///            "Partner VAT ID" := GetPartnerID;
        ///        end;
        ///    end;
        ///}
        /// 
        ///  field(10703;"Statistical System";Option)
        ///{
        ///    Caption = 'Statistical System';
        ///    InitValue = "1-Final Destination";
        ///    OptionCaption = ' ,1-Final Destination,2-Temporary Destination,3-Temporary Destination+Transformation,4-Return,5-Return+Transformation';
        ///    OptionMembers = " ","1-Final Destination","2-Temporary Destination","3-Temporary Destination+Transformation","4-Return","5-Return+Transformation";
        ///}
        field(50000; "Partner VAT ID2"; Text[50])
        {
            Caption = 'Partner VAT ID';
        }

        /*
        procedure GetCountryOfOriginCode(): Code[10]
    var
        Item: Record Item;
    begin
        if not Item.Get("Item No.") then
          exit('');
        exit(Item."Country/Region of Origin Code");
    end;


    procedure GetPartnerID(): Text[50]
    begin
        case "Source Type" of
          "source type"::"Item Entry":
            exit(GetPartnerIDFromItemEntry);
        end;
    end;

    local procedure GetPartnerIDFromItemEntry(): Text[50]
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        ReturnReceiptHeader: Record "Return Receipt Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        ReturnShipmentHeader: Record "Return Shipment Header";
        ServiceShipmentHeader: Record "Service Shipment Header";
        ServiceInvoiceHeader: Record "Service Invoice Header";
        ServiceCrMemoHeader: Record "Service Cr.Memo Header";
        Customer: Record Customer;
        Vendor: Record Vendor;
    begin
        ItemLedgerEntry.Get("Source Entry No.");
        case ItemLedgerEntry."Document Type" of
          ItemLedgerEntry."document type"::"Sales Invoice":
            if SalesInvoiceHeader.Get(ItemLedgerEntry."Document No.") then
              exit(
                GetPartnerIDForCountry(
                  SalesInvoiceHeader."Bill-to Country/Region Code",SalesInvoiceHeader."VAT Registration No.",
                  IsCustomerPrivatePerson(SalesInvoiceHeader."Bill-to Customer No."),SalesInvoiceHeader."EU 3-Party Trade"));
          ItemLedgerEntry."document type"::"Sales Credit Memo":
            if SalesCrMemoHeader.Get(ItemLedgerEntry."Document No.") then
              exit(
                GetPartnerIDForCountry(
                  SalesCrMemoHeader."Bill-to Country/Region Code",SalesCrMemoHeader."VAT Registration No.",
                  IsCustomerPrivatePerson(SalesCrMemoHeader."Bill-to Customer No."),SalesCrMemoHeader."EU 3-Party Trade"));
          ItemLedgerEntry."document type"::"Sales Shipment":
            if SalesShipmentHeader.Get(ItemLedgerEntry."Document No.") then
              exit(
                GetPartnerIDForCountry(
                  SalesShipmentHeader."Bill-to Country/Region Code",SalesShipmentHeader."VAT Registration No.",
                  IsCustomerPrivatePerson(SalesShipmentHeader."Bill-to Customer No."),SalesShipmentHeader."EU 3-Party Trade"));
          ItemLedgerEntry."document type"::"Sales Return Receipt":
            if ReturnReceiptHeader.Get(ItemLedgerEntry."Document No.") then
              exit(
                GetPartnerIDForCountry(
                  ReturnReceiptHeader."Bill-to Country/Region Code",ReturnReceiptHeader."VAT Registration No.",
                  IsCustomerPrivatePerson(ReturnReceiptHeader."Bill-to Customer No."),ReturnReceiptHeader."EU 3-Party Trade"));
          ItemLedgerEntry."document type"::"Purchase Credit Memo":
            if PurchCrMemoHdr.Get(ItemLedgerEntry."Document No.") then
              exit(
                GetPartnerIDForCountry(
                  PurchCrMemoHdr."Pay-to Country/Region Code",PurchCrMemoHdr."VAT Registration No.",
                  IsVendorPrivatePerson(PurchCrMemoHdr."Pay-to Vendor No."),false));
          ItemLedgerEntry."document type"::"Purchase Return Shipment":
            if ReturnShipmentHeader.Get(ItemLedgerEntry."Document No.") then
              exit(
                GetPartnerIDForCountry(
                  ReturnShipmentHeader."Pay-to Country/Region Code",ReturnShipmentHeader."VAT Registration No.",
                  IsVendorPrivatePerson(ReturnShipmentHeader."Pay-to Vendor No."),false));
          ItemLedgerEntry."document type"::"Purchase Receipt":
            if PurchRcptHeader.Get(ItemLedgerEntry."Document No.") then
              exit(
                GetPartnerIDForCountry(
                  PurchRcptHeader."Pay-to Country/Region Code",PurchRcptHeader."VAT Registration No.",
                  IsVendorPrivatePerson(PurchRcptHeader."Pay-to Vendor No."),false));
          ItemLedgerEntry."document type"::"Service Shipment":
            if ServiceShipmentHeader.Get(ItemLedgerEntry."Document No.") then begin
              Customer.Get(ServiceShipmentHeader."Bill-to Customer No.");
              exit(
                GetPartnerIDForCountry(
                  ServiceShipmentHeader."Bill-to Country/Region Code",ServiceShipmentHeader."VAT Registration No.",
                  IsCustomerPrivatePerson(ServiceShipmentHeader."Bill-to Customer No."),ServiceShipmentHeader."EU 3-Party Trade"));
            end;
          ItemLedgerEntry."document type"::"Service Invoice":
            if ServiceInvoiceHeader.Get(ItemLedgerEntry."Document No.") then begin
              Customer.Get(ServiceInvoiceHeader."Bill-to Customer No.");
              exit(
                GetPartnerIDForCountry(
                  ServiceInvoiceHeader."Bill-to Country/Region Code",ServiceInvoiceHeader."VAT Registration No.",
                  IsCustomerPrivatePerson(ServiceInvoiceHeader."Bill-to Customer No."),ServiceInvoiceHeader."EU 3-Party Trade"));
            end;
          ItemLedgerEntry."document type"::"Service Credit Memo":
            if ServiceCrMemoHeader.Get(ItemLedgerEntry."Document No.") then begin
              Customer.Get(ServiceCrMemoHeader."Bill-to Customer No.");
              exit(
                GetPartnerIDForCountry(
                  ServiceCrMemoHeader."Bill-to Country/Region Code",ServiceCrMemoHeader."VAT Registration No.",
                  IsCustomerPrivatePerson(ServiceCrMemoHeader."Bill-to Customer No."),ServiceCrMemoHeader."EU 3-Party Trade"));
            end;
        end;

        case ItemLedgerEntry."Source Type" of
          ItemLedgerEntry."source type"::Customer:
            begin
              Customer.Get(ItemLedgerEntry."Source No.");
              exit(
                GetPartnerIDForCountry(
                  ItemLedgerEntry."Country/Region Code",Customer."VAT Registration No.",
                  Customer."Partner Type" = Customer."partner type"::Person,false));
            end;
          ItemLedgerEntry."source type"::Vendor:
            begin
              Vendor.Get(ItemLedgerEntry."Source No.");
              exit(
                GetPartnerIDForCountry(
                  ItemLedgerEntry."Country/Region Code",Vendor."VAT Registration No.",
                  Vendor."Partner Type" = Vendor."partner type"::Person,false));
            end;
        end;
    end;

    local procedure GetPartnerIDFromJobEntry(): Text[50]
    var
        Job: Record Job;
        JobLedgerEntry: Record "Job Ledger Entry";
        Customer: Record Customer;
    begin
        JobLedgerEntry.Get("Source Entry No.");
        Job.Get(JobLedgerEntry."Job No.");
        Customer.Get(Job."Bill-to Customer No.");

        exit(
          GetPartnerIDForCountry(
            Customer."Country/Region Code",Customer."VAT Registration No.",
            Customer."Partner Type" = Customer."partner type"::Person,false));
    end;

    local procedure GetPartnerIDForCountry(CountryRegionCode: Code[10];VATRegistrationNo: Code[20];IsPrivatePerson: Boolean;IsThirdPartyTrade: Boolean): Text
    var
        CountryRegion: Record "Country/Region";
    begin
        if IsPrivatePerson then
          exit('QV999999999999');

        if IsThirdPartyTrade then
          exit('QV999999999999');

        if CountryRegion.Get(CountryRegionCode) then
          if CountryRegion.IsEUCountry(CountryRegionCode) then
            if VATRegistrationNo <> '' then
              exit(VATRegistrationNo);

        exit('QV999999999999');
    end;

    local procedure IsCustomerPrivatePerson(CustomerNo: Code[20]): Boolean
    var
        Customer: Record Customer;
    begin
        if Customer.Get(CustomerNo) then
          exit(Customer."Partner Type" = Customer."partner type"::Person);
        exit(false);
    end;

    local procedure IsVendorPrivatePerson(VendorNo: Code[20]): Boolean
    var
        Vendor: Record Vendor;
    begin
        if Vendor.Get(VendorNo) then
          exit(Vendor."Partner Type" = Vendor."partner type"::Person);
        exit(false);
    end;

    local procedure AssertBatchIsNotReported(IntrastatJnlLine: Record "Intrastat Jnl. Line")
    begin
        IntrastatJnlBatch.Get(IntrastatJnlLine."Journal Template Name",IntrastatJnlLine."Journal Batch Name");
        IntrastatJnlBatch.TestField(Reported,false);
    end;
    }
    */

    }
}
