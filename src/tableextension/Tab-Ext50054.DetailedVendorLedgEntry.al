tableextension 50054 DetailedVendorLedgEntry extends "Detailed Vendor Ledg. Entry"
{
    keys
    {
        key(Key50011; "Vendor No.", "Entry Type", "Posting Date", "Initial Document Type")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
        key(Key50012; "Vendor No.", "Currency Code", "Excluded from calculation")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
    }
}
