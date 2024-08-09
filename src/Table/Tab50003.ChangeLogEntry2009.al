#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50003 "Change Log Entry-2009"
{
    Caption = 'Change Log Entry-2009';

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Date and Time"; DateTime)
        {
            Caption = 'Date and Time';
        }
        field(3; Time; Time)
        {
            Caption = 'Time';
        }
        field(4; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = "User Setup"."User ID";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                //UserMgt.loo
            end;
        }
        field(5; "Table No."; Integer)
        {
            Caption = 'Table No.';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
        }
        field(6; "Table Caption"; Text[250])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Table),
                                                                           "Object ID" = field("Table No.")));
            Caption = 'Table Caption';
            FieldClass = FlowField;
        }
        field(7; "Field No."; Integer)
        {
            Caption = 'Field No.';
            TableRelation = Field."No." where(TableNo = field("Table No."));
        }
        field(8; "Field Caption"; Text[80])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Table No."),
                                                              "No." = field("Field No.")));
            Caption = 'Field Caption';
            FieldClass = FlowField;
        }
        field(9; "Type of Change"; Option)
        {
            Caption = 'Type of Change';
            OptionCaption = 'Insertion,Modification,Deletion';
            OptionMembers = Insertion,Modification,Deletion;
        }
        field(10; "Old Value"; Text[250])
        {
            Caption = 'Old Value';
        }
        field(11; "New Value"; Text[250])
        {
            Caption = 'New Value';
        }
        field(12; "Primary Key"; Text[250])
        {
            Caption = 'Primary Key';
        }
        field(13; "Primary Key Field 1 No."; Integer)
        {
            Caption = 'Primary Key Field 1 No.';
            TableRelation = Field."No." where(TableNo = field("Table No."));
        }
        field(14; "Primary Key Field 1 Caption"; Text[80])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Table No."),
                                                              "No." = field("Primary Key Field 1 No.")));
            Caption = 'Primary Key Field 1 Caption';
            FieldClass = FlowField;
        }
        field(15; "Primary Key Field 1 Value"; Text[50])
        {
            Caption = 'Primary Key Field 1 Value';
        }
        field(16; "Primary Key Field 2 No."; Integer)
        {
            Caption = 'Primary Key Field 2 No.';
            TableRelation = Field."No." where(TableNo = field("Table No."));
        }
        field(17; "Primary Key Field 2 Caption"; Text[80])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Table No."),
                                                              "No." = field("Primary Key Field 2 No.")));
            Caption = 'Primary Key Field 2 Caption';
            FieldClass = FlowField;
        }
        field(18; "Primary Key Field 2 Value"; Text[50])
        {
            Caption = 'Primary Key Field 2 Value';
        }
        field(19; "Primary Key Field 3 No."; Integer)
        {
            Caption = 'Primary Key Field 3 No.';
            TableRelation = Field."No." where(TableNo = field("Table No."));
        }
        field(20; "Primary Key Field 3 Caption"; Text[80])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Table No."),
                                                              "No." = field("Primary Key Field 3 No.")));
            Caption = 'Primary Key Field 3 Caption';
            FieldClass = FlowField;
        }
        field(21; "Primary Key Field 3 Value"; Text[50])
        {
            Caption = 'Primary Key Field 3 Value';
        }
        field(22; "Record ID"; RecordID)
        {
            Caption = 'Record ID';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Table No.", "Primary Key Field 1 Value")
        {
        }
        key(Key3; "Table No.", "Date and Time")
        {
        }
    }

    fieldgroups
    {
    }


    procedure GetPrimaryKeyFriendlyName(): Text[250]
    var
        RecRef: RecordRef;
        FriendlyName: Text[250];
        p: Integer;
    begin
        if "Primary Key" = '' then
            exit('');

        // Retain existing formatting of old data
        if (StrPos("Primary Key", 'CONST(') = 0) and (StrPos("Primary Key", '0(') = 0) then
            exit("Primary Key");

        RecRef.Open("Table No.");
        RecRef.SetPosition("Primary Key");
        FriendlyName := RecRef.GetPosition(true);
        RecRef.Close;

        FriendlyName := DelChr(FriendlyName, '=', '()');
        p := StrPos(FriendlyName, 'CONST');
        while p > 0 do begin
            FriendlyName := DelStr(FriendlyName, p, 5);
            p := StrPos(FriendlyName, 'CONST');
        end;
        exit(FriendlyName);
    end;

}

