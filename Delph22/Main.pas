unit Main;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
    System.Actions, Vcl.ActnList, Math, System.Generics.Collections;

type
    TMainForm = class(TForm)
        GroupBox1: TGroupBox;
        edt_Min: TLabeledEdit;
        edt_Max: TLabeledEdit;
        edt_ArrSize: TLabeledEdit;
        m_ListDisplay: TMemo;
        acList: TActionList;
        acCreateList: TAction;
        Button1: TButton;
        gbx_EditArray: TGroupBox;
        edt_Digit: TLabeledEdit;
        edt_Number: TLabeledEdit;
        Button2: TButton;
        Button3: TButton;
        Button4: TButton;
        acAdd: TAction;
        acDelete: TAction;
        acInsert: TAction;
        procedure acCreateListExecute(Sender: TObject);
        procedure acAddExecute(Sender: TObject);
        procedure acDeleteExecute(Sender: TObject);
        procedure acInsertExecute(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure edt_NumberChange(Sender: TObject);
        procedure edt_DigitChange(Sender: TObject);
    private
        FArray: array of integer;
        FArraySize: integer;
        FMinValue: integer;
        FMaxValue: integer;
        FAddValue: integer;
        FIndexValue: integer;
        function InvalidateCreateVariables(): Boolean;
        function InvalidateInsertVariables(): Boolean;
        function InvalidateAddVariables(): Boolean;
        function InvalidateDeleteVariables(): Boolean;
        procedure InvalidateVisuals();
        procedure GenerateArray();
    end;

var
    MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.acAddExecute(Sender: TObject);
begin
    if (not InvalidateAddVariables()) then
    begin
        Exit;
    end;

    inc(FArraySize, 1);
    SetLength(FArray, FArraySize);
    FArray[FArraySize - 1] := FAddValue;

    InvalidateVisuals;
end;

procedure TMainForm.acDeleteExecute(Sender: TObject);
var
    i: integer;
    tempArray: array of integer;
begin
    if (not InvalidateDeleteVariables) then
    begin
        Exit;
    end;

    SetLength(tempArray, FArraySize - 1);

    for i := 0 to FIndexValue - 2 do
    begin
        tempArray[i] := FArray[i];
    end;

    for i := FIndexValue to (FArraySize - 1) do
    begin
        tempArray[i - 1] := FArray[i];
    end;

    dec(FArraySize, 1);
    SetLength(FArray, FArraySize);

    if (FArraySize <> 0) then
        TArray.Copy<integer>(tempArray, FArray, FArraySize);

    SetLength(tempArray, 0);
    // Из методички работает с багом дальше я читать её не стал
    // dec(FArraySize, 1);
    // SetLength(FArray, FArraySize);
    // for i := (FIndexValue - 1) to (FArraySize - 2) do
    // FArray[i] := FArray[i + 1];

    InvalidateVisuals;
end;

procedure TMainForm.acInsertExecute(Sender: TObject);
var
    i: integer;
    tempArray: array of integer;
begin
    if (not InvalidateInsertVariables) then
        Exit;
    SetLength(tempArray, FArraySize + 1);

    for i := 0 to FIndexValue - 2 do
    begin
        tempArray[i] := FArray[i];
    end;

    for i := FIndexValue - 1 to FArraySize - 1 do
    begin
        tempArray[i + 1] := FArray[i];
    end;

    inc(FArraySize, 1);
    SetLength(FArray, FArraySize);
    tempArray[FIndexValue - 1] := FAddValue;
    TArray.Copy<integer>(tempArray, FArray, FArraySize);
    SetLength(tempArray, 0);
    InvalidateVisuals;
end;

procedure TMainForm.edt_DigitChange(Sender: TObject);
var
    text: string;
begin
    text := edt_Digit.text;
    acAdd.Enabled := not string.IsNullOrEmpty(text.Trim());
end;

procedure TMainForm.edt_NumberChange(Sender: TObject);
var
    text: string;
begin
    text := edt_Number.text;
    acDelete.Enabled := not string.IsNullOrEmpty(text.Trim());
    acInsert.Enabled := acDelete.Enabled;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    SetLength(FArray, 0);
    FArray := nil;
end;

procedure TMainForm.acCreateListExecute(Sender: TObject);
begin
    if (not InvalidateCreateVariables) then
        Exit;
    GenerateArray;
    InvalidateVisuals;
    gbx_EditArray.Visible := true;
end;

procedure TMainForm.GenerateArray;
var
    i: integer;
begin
    Randomize;
    SetLength(FArray, FArraySize);
    for i := 0 to FArraySize - 1 do
    begin
        FArray[i] := RandomRange(FMinValue, FMaxValue + 1);
    end;

end;

function TMainForm.InvalidateAddVariables: Boolean;
var
    newAddValue: integer;
begin
    if (not integer.TryParse(edt_Digit.text, newAddValue)) then
    begin
        ShowMessage(Format('Значение "%s" не явялется подходящим числом',
          [edt_Digit.text]));
        edt_Digit.SetFocus;
        Exit(false);
    end;
    FAddValue := newAddValue;
    Exit(true);
end;

function TMainForm.InvalidateDeleteVariables: Boolean;
var
    newIndexValue: integer;
begin
    if ((not integer.TryParse(edt_Number.text, newIndexValue)) or
      (newIndexValue < 1) or (newIndexValue > FArraySize)) then
    begin
        ShowMessage(Format('Значение "%s" не явялется подходящим индексом',
          [edt_Number.text]));
        edt_Number.SetFocus;
        Exit(false);
    end;
    FIndexValue := newIndexValue;
    Exit(true);
end;

function TMainForm.InvalidateInsertVariables: Boolean;
begin
    if (not InvalidateAddVariables) then
        Exit(false);
    if (not InvalidateDeleteVariables) then
        Exit(false);
    Exit(true);
end;

function TMainForm.InvalidateCreateVariables: Boolean;
var
    newMin, newMax, newSize, temp: integer;
begin
    if (not integer.TryParse(edt_Min.text, newMin)) then
    begin
        ShowMessage(Format('Значение "%s" не является подходящим числом.',
          [edt_Min.text]));
        edt_Min.SetFocus;
        Exit(false);
    end;

    if (not integer.TryParse(edt_Max.text, newMax)) then
    begin
        ShowMessage(Format('Значение "%s" не является подходящим числом.',
          [edt_Max.text]));
        edt_Max.SetFocus;
        Exit(false);
    end;

    if ((not integer.TryParse(edt_ArrSize.text, newSize)) or (newSize <= 0))
    then
    begin
        ShowMessage(Format('Значение "%s" не является подходящим числом.',
          [edt_ArrSize.text]));
        edt_ArrSize.SetFocus;
        Exit(false);
    end;

    if (newMin > newMax) then
    begin
        temp := newMin;
        newMin := newMax;
        newMax := temp;
        edt_Min.text := newMin.ToString;
        edt_Max.text := newMax.ToString;
    end;
    FArraySize := newSize;
    FMaxValue := newMax;
    FMinValue := newMin;
    Exit(true);
end;

procedure TMainForm.InvalidateVisuals;
var
    i: integer;
begin
    m_ListDisplay.Lines.Clear;
    m_ListDisplay.LockDrawing;
    for i := 0 to self.FArraySize - 1 do
    begin
        m_ListDisplay.Lines.Add(Format('%d) %d', [i + 1, FArray[i]]));
    end;
    m_ListDisplay.UnlockDrawing;
end;

end.
