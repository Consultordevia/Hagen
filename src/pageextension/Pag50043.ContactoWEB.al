page 50043 ContactoWEB
{
    ApplicationArea = All;
    Caption = 'ContactoWEB';
    PageType = List;
    SourceTable = Contact;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the contact. If the contact is a person, you can click the field to see the Name Details window.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the contact''s address.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field("Calcd. Current Value (LCY)"; Rec."Calcd. Current Value (LCY)")
                {
                    ToolTip = 'Specifies the total calculated current value of all the opportunities involving the contact. The field is not editable.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the city where the contact is located.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the name of the company. If the contact is a person, Specifies the name of the company for which this contact works. This field is not editable.';
                }
                field("Company No."; Rec."Company No.")
                {
                    ToolTip = 'Specifies the number for the contact''s company.';
                }
                field("Contact Business Relation"; Rec."Contact Business Relation")
                {
                    ToolTip = 'Specifies the type of the existing business relation.';
                }
                field("Correspondence Type"; Rec."Correspondence Type")
                {
                    ToolTip = 'Specifies the preferred type of correspondence for the interaction.';
                }
                field("Cost (LCY)"; Rec."Cost (LCY)")
                {
                    ToolTip = 'Specifies the total cost of all the interactions involving the contact. The field is not editable.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region of the address.';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the county of the address.';
                }
                field("Coupled to CRM"; Rec."Coupled to CRM")
                {
                    ToolTip = 'Specifies that the contact is coupled to a contact in Dataverse.';
                }
                field("Coupled to Dataverse"; Rec."Coupled to Dataverse")
                {
                    ToolTip = 'Specifies that the contact is coupled to a contact in Dataverse.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code for the contact.';
                }
                field("Date of Last Interaction"; Rec."Date of Last Interaction")
                {
                    ToolTip = 'Specifies the date of the last interaction involving the contact, for example, a received or sent mail, e-mail, or phone call. This field is not editable.';
                }
                field("Duration (Min.)"; Rec."Duration (Min.)")
                {
                    ToolTip = 'Specifies the total duration of all the interactions involving the contact. The field is not editable.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the email address of the contact.';
                }
                field("E-Mail 2"; Rec."E-Mail 2")
                {
                    ToolTip = 'Specifies the value of the Email 2 field.', Comment = '%';
                }
                field("Estimated Value (LCY)"; Rec."Estimated Value (LCY)")
                {
                    ToolTip = 'Specifies the total estimated value of all the opportunities involving the contact. The field is not editable.';
                }
                field("Exclude from Segment"; Rec."Exclude from Segment")
                {
                    ToolTip = 'Specifies if the contact should be excluded from segments:';
                }
                field("Extension No."; Rec."Extension No.")
                {
                    ToolTip = 'Specifies the value of the Extension No. field.', Comment = '%';
                }
                field("External ID"; Rec."External ID")
                {
                    ToolTip = 'Specifies the value of the External ID field.', Comment = '%';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ToolTip = 'Specifies the contact''s fax number.';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the contact''s first name and is valid for contact persons only.';
                }
                field("Format Region"; Rec."Format Region")
                {
                    ToolTip = 'Specifies the format region that is used when formatting dates and numbers on documents to foreign business partner, such as an total amount on an order date.';
                }
                field("Home Page"; Rec."Home Page")
                {
                    ToolTip = 'Specifies the contact''s web site.';
                }
                field(Image; Rec.Image)
                {
                    ToolTip = 'Specifies the picture of the contact, for example, a photograph if the contact is a person, or a logo if the contact is a company.';
                }
                field(Initials; Rec.Initials)
                {
                    ToolTip = 'Specifies the contact''s initials, when the contact is a person.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the contact''s job title.';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ToolTip = 'Specifies the language that is used when translating specified text on documents to foreign business partner, such as an item description on an order confirmation.';
                }
                field("Last Date Attempted"; Rec."Last Date Attempted")
                {
                    ToolTip = 'Specifies the date when the contact was last contacted, for example, when you tried to call the contact, with or without success. This field is not editable.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field.', Comment = '%';
                }
                field("Last Time Modified"; Rec."Last Time Modified")
                {
                    ToolTip = 'Specifies the value of the Last Time Modified field.', Comment = '%';
                }
                field("Lookup Contact No."; Rec."Lookup Contact No.")
                {
                    ToolTip = 'Specifies the value of the Lookup Contact No. field.', Comment = '%';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the contact''s middle name and is valid for contact persons only.';
                }
                field(Minor; Rec.Minor)
                {
                    ToolTip = 'Specifies that the person''s age is below the definition of adulthood as recognized by law. Data for minors is blocked until a parent or guardian of the minor provides parental consent. You unblock the data by choosing the Parental Consent Received check box.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ToolTip = 'Specifies the contact''s mobile telephone number.';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies an additional part of the name.';
                }
                field("Next Task Date"; Rec."Next Task Date")
                {
                    ToolTip = 'Specifies the date of the next task involving the contact.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.', Comment = '%';
                }
                field("No. of Business Relations"; Rec."No. of Business Relations")
                {
                    ToolTip = 'Specifies the value of the No. of Business Relations field.', Comment = '%';
                }
                field("No. of Industry Groups"; Rec."No. of Industry Groups")
                {
                    ToolTip = 'Specifies the number of industry groups to which the contact belongs. When the contact is a person, this field contains the number of industry groups for the contact''s company. This field is not editable.';
                }
                field("No. of Interactions"; Rec."No. of Interactions")
                {
                    ToolTip = 'Specifies the number of interactions created for this contact. The field is not editable.';
                }
                field("No. of Job Responsibilities"; Rec."No. of Job Responsibilities")
                {
                    ToolTip = 'Specifies the number of job responsibilities for this contact. This field is valid for persons only and is not editable.';
                }
                field("No. of Mailing Groups"; Rec."No. of Mailing Groups")
                {
                    ToolTip = 'Specifies the number of mailing groups for this contact.';
                }
                field("No. of Opportunities"; Rec."No. of Opportunities")
                {
                    ToolTip = 'Specifies the number of open opportunities involving the contact. The field is not editable.';
                }
                field("Opportunity Entry Exists"; Rec."Opportunity Entry Exists")
                {
                    ToolTip = 'Specifies the value of the Opportunity Entry Exists field.', Comment = '%';
                }
                field("Organizational Level Code"; Rec."Organizational Level Code")
                {
                    ToolTip = 'Specifies the organizational code for the contact, for example, top management. This field is valid for persons only.';
                }
                field(Pager; Rec.Pager)
                {
                    ToolTip = 'Specifies the value of the Pager field.', Comment = '%';
                }
                field("Parental Consent Received"; Rec."Parental Consent Received")
                {
                    ToolTip = 'Specifies that a parent or guardian of the minor has provided their consent to allow the minor to use this service. When this check box is selected, data for the minor can be processed.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the contact''s phone number.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field("Privacy Blocked"; Rec."Privacy Blocked")
                {
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                }
                field("Registration Number"; Rec."Registration Number")
                {
                    ToolTip = 'Specifies the registration number of the contact. You can enter a maximum of 20 characters, both numbers and letters.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the code of the salesperson who normally handles this contact.';
                }
                field("Salutation Code"; Rec."Salutation Code")
                {
                    ToolTip = 'Specifies the salutation code that will be used when you interact with the contact. The salutation code is only used in Word documents. To see a list of the salutation codes already defined, click the field.';
                }
                field("Search E-Mail"; Rec."Search E-Mail")
                {
                    ToolTip = 'Specifies the value of the Search Email field.', Comment = '%';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the contact''s surname and is valid for contact persons only.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
                field("Task Entry Exists"; Rec."Task Entry Exists")
                {
                    ToolTip = 'Specifies the value of the Task Entry Exists field.', Comment = '%';
                }
                field("Telex Answer Back"; Rec."Telex Answer Back")
                {
                    ToolTip = 'Specifies the value of the Telex Answer Back field.', Comment = '%';
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ToolTip = 'Specifies the value of the Telex No. field.', Comment = '%';
                }
                field("Territory Code"; Rec."Territory Code")
                {
                    ToolTip = 'Specifies the territory code for the contact.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the type of contact, either company or person.';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ToolTip = 'Specifies the contact''s VAT registration number. This field is valid for companies only.';
                }
                field("Xrm Id"; Rec."Xrm Id")
                {
                    ToolTip = 'Specifies the value of the Xrm Id field.', Comment = '%';
                }
            }
        }
    }
}
