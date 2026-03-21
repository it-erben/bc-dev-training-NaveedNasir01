table 50100 "Training Item"
{
    Caption = 'Training Item';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'Nr.';
            AutoIncrement = true;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Beschreibung';
        }
        field(3; "Completed"; Boolean)
        {
            Caption = 'Erledigt';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
