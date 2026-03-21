page 50100 "Training Items"
{
    Caption = 'Training Items';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Training Item";

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Completed; Rec.Completed)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
