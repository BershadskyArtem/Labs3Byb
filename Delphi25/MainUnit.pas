unit MainUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Actions,
    Vcl.ActnList, Vcl.Grids, System.Generics.Collections, Math;

type
    TIntArray = array of integer;

    TMainForm = class(TForm)
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        m_Display: TMemo;
        Button1: TButton;
        acList: TActionList;
        stg_Results: TStringGrid;
        ac_Calculate: TAction;
        edt_Count: TEdit;
        edt_Min: TEdit;
        edt_Max: TEdit;
        procedure ac_CalculateExecute(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure FormShow(Sender: TObject);
    private
        FArray: TIntArray;
        FMinBound: integer;
        FMaxBound: integer;
        FDesiredCount: integer;
        function InvalidateVariables(): boolean;
        function MaxIter(var arr: TIntArray): integer;
        function MaxRecEnd(var arr: TIntArray; k: integer): integer;
        function MaxRecMiddle(var arr: TIntArray;
          startIndex, endIndex: integer): integer;
        procedure RefillArray(var arr: TIntArray; desiredCount: integer);
        procedure ShowArray(var arr: TIntArray);
    public
        { Public declarations }
    end;

var
    MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.ac_CalculateExecute(Sender: TObject);
var
    maxValue: integer;
begin
    if (not InvalidateVariables()) then
        Exit();
    RefillArray(FArray, FDesiredCount);
    ShowArray(FArray);
    maxValue := MaxIter(FArray);
    stg_Results.Cells[1, 1] := maxValue.ToString();
    maxValue := MaxRecEnd(FArray, Length(FArray));
    stg_Results.Cells[1, 2] := maxValue.ToString();
    maxValue := MaxRecMiddle(FArray, 0, Length(FArray) - 1);
    stg_Results.Cells[1, 3] := maxValue.ToString();
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    SetLength(FArray, 0);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
    stg_Results.Cells[0, 0] := 'Метод';
    stg_Results.Cells[1, 0] := 'Значение';
    stg_Results.Cells[0, 1] := 'Итеративный';
    stg_Results.Cells[0, 2] := 'Рекурсивный';
    stg_Results.Cells[0, 3] := 'Бинарный';

end;

function TMainForm.InvalidateVariables: boolean;
var
    newMax, newMin, newCount, temp: integer;
    tempString: string;
begin
    if (not integer.TryParse(edt_Max.Text, newMax)) then
    begin
        ShowMessage(Format('Невозможно преобразовать в число "%s".',
          [edt_Max.Text]));
        edt_Max.SetFocus();
        Exit(false);
    end;

    if (not integer.TryParse(edt_Min.Text, newMin)) then
    begin
        ShowMessage(Format('Невозможно преобразовать в число "%s".',
          [edt_Min.Text]));
        edt_Min.SetFocus();
        Exit(false);
    end;

    if (not integer.TryParse(edt_Count.Text, newCount)) then
    begin
        ShowMessage(Format('Невозможно преобразовать "%s" в число.',
          [edt_Count.Text]));
        edt_Count.SetFocus();
        Exit(false);
    end;

    if (newCount <= 0) then
    begin
        ShowMessage('Количество элементов не должно быть меньше или равно 0.');
        edt_Count.SetFocus();
        Exit(false);
    end;

    if (newMin > newMax) then
    begin
        temp := newMin;
        newMin := newMax;
        newMax := newMin;
        tempString := edt_Min.Text;
        edt_Min.Text := edt_Max.Text;
        edt_Max.Text := tempString;
    end;

    FDesiredCount := newCount;
    FMaxBound := newMax;
    FMinBound := newMin;
    Result := true;
end;

function TMainForm.MaxIter(var arr: TIntArray): integer;
var
    i: integer;
begin
    Result := arr[0];
    for i := 0 to Length(arr) - 1 do
    begin
        if (arr[i] > Result) then
            Result := arr[i];
    end;
end;

function TMainForm.MaxRecEnd(var arr: TIntArray; k: integer): integer;
begin
    if (k = 0) then
        Result := arr[0]
    else
        Result := max(arr[k - 1], MaxRecEnd(arr, k - 1));
end;

function TMainForm.MaxRecMiddle(var arr: TIntArray;
  startIndex, endIndex: integer): integer;
var
    nextCenter: integer;
begin
    if (startIndex = endIndex) then
        Result := arr[startIndex]
    else
    begin
        nextCenter := startIndex + (endIndex - startIndex) div 2;
        Result := max(MaxRecMiddle(arr, startIndex, nextCenter),
          MaxRecMiddle(arr, nextCenter + 1, endIndex));
    end;
end;

procedure TMainForm.RefillArray(var arr: TIntArray; desiredCount: integer);
var
    i: integer;
begin
    SetLength(arr, desiredCount);
    for i := 0 to FDesiredCount - 1 do
    begin
        arr[i] := RandomRange(FMinBound, FMaxBound + 1);
    end;
end;

procedure TMainForm.ShowArray(var arr: TIntArray);
var
    i: integer;
begin
    m_Display.Lines.Clear();
    for i := 0 to Length(arr) - 1 do
    begin
        m_Display.Lines.Add(arr[i].ToString());
    end;
end;

end.
