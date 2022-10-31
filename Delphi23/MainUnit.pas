unit MainUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Math, System.Character, Vcl.ExtCtrls,
    Vcl.StdCtrls, System.Actions, Vcl.ActnList, Vcl.ExtDlgs, System.IOUtils,
    System.Generics.Collections;

type

    // Принимает в себя текстовые файлы следующего вида "10,5 6,4"
    // Где 10.5 - X, а 6,4 - Y
    // Глотает и по строкам и в одну строчку
    // Отделение токенов с помощью tab не пробовал
    // Токенизацию текста можно сделать чуть проще, добавив дополнительный цикл  ,но мне лень переделывать

    TVarSort = (vsX = 0, vsY = 1, vsDistance = 2);
    TSortType = (tsAsc = 0, tsDesc = 1);

    TToken = record
        start: integer;
        length: integer;
    public
        class function CreateToken(st, ln: integer): TToken; static;
    end;

    TPoint = class
    private
        isFirstTimeCalculaing: boolean;
        distanceChache: double;
    public
        X: double;
        Y: double;
        constructor Create(X, Y: double); overload;
        constructor Create(s: string); overload;
        function GetDistance(): double;
        function toString(): string; override;
    end;

    TCompareFunction = function(const first, other: TPoint): boolean of object;

    // Размывание ответственности. Лист и создает и хранит. Создание следует производить вне класса TPointList
    // В этаком случае методы Add(x,y) и Add(s) существовать не должны
    // Но задание есть задание.
    TPointList = class(TList)
    private
        function CompareX(const first, other: TPoint): boolean;
        function CompareY(const first, other: TPoint): boolean;
        function CompareDst(const first, other: TPoint): boolean;
    public
        procedure Add(X, Y: double); overload;
        procedure Add(s: string); overload;
        procedure Add(p: TPoint); overload;
        procedure Delete(index: integer);
        procedure Clear(); override;
        procedure Sort(vs: TVarSort; ts: TSortType);
    end;

    TMainForm = class(TForm)
        Panel1: TPanel;
        gb_SortList: TGroupBox;
        GroupBox2: TGroupBox;
        GroupBox3: TGroupBox;
        GroupBox4: TGroupBox;
        m_InitialList: TMemo;
        m_InitialDist: TMemo;
        m_SortDist: TMemo;
        m_SortList: TMemo;
        Button1: TButton;
        Button2: TButton;
        rg_SortType: TRadioGroup;
        rg_SortBy: TRadioGroup;
        ac_List: TActionList;
        op_TextFileDialog: TOpenTextFileDialog;
        acSort: TAction;
        acOpen: TAction;
        procedure acOpenExecute(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure acSortExecute(Sender: TObject);
    private
        FPointList: TPointList;
        FSortType: TSortType;
        FSortBy: TVarSort;
        procedure InvalidateDistances();
        procedure InvalidateList();
        procedure InvalidateVisuals();
        procedure InvalidateSorting();
    end;

var
    MainForm: TMainForm;

implementation

{$R *.dfm}

const
    whitespace: char = ' ';
    dotseparator: char = '.';
    commaseparator: char = ',';
    { TPoint }
{$REGION 'Point'}

constructor TPoint.Create(s: string);
var
    newx, newy: double;
    tokens: TArray<string>;
begin
    s := s.Replace(commaseparator, dotseparator);
    tokens := s.Split(whitespace);
    if (length(tokens) <> 2) then
    begin
        raise Exception.Create
          (format('Ошибка парсинга строки. "%s". Слишком много значений для точки.',
          [s]));
    end;

    if (not double.TryParse(tokens[0], newx)) then
    begin
        raise Exception.Create
          (format('Ошибка парсинга строки "%s".! Неверный формат чилса. (Правильный формат "20.04").',
          [tokens[0]]));
    end;
    if (not double.TryParse(tokens[1], newy)) then
    begin
        raise Exception.Create
          (format('Ошибка парсинга строки "%s".! Неверный формат чилса. (Правильный формат "20.04").',
          [tokens[1]]));
    end;
    self.X := newx;
    self.Y := newy;
    SetLength(tokens, 0);
    isFirstTimeCalculaing := true;
end;

function TPoint.GetDistance: double;
begin
    if (isFirstTimeCalculaing) then
    begin
        distanceChache := sqrt(sqr(X) + sqr(Y));
        isFirstTimeCalculaing := false;
    end;
    Result := distanceChache;
end;

function TPoint.toString: string;
begin
    Result := format('X = %f, Y = %f', [X, Y]);
end;

constructor TPoint.Create(X, Y: double);
begin
    isFirstTimeCalculaing := true;
    self.X := X;
    self.Y := Y;
end;
{$ENDREGION}
{ TPointList }
{$REGION 'Point list'}

procedure TPointList.Add(X, Y: double);
var
    newPoint: TPoint;
begin
    newPoint := TPoint.Create(X, Y);
    Add(newPoint);
end;

procedure TPointList.Add(s: string);
var
    newPoint: TPoint;
begin
    try
        newPoint := TPoint.Create(s);
        Add(newPoint);
    except
        on E: Exception do
        begin
            ShowMessage(E.Message);
            newPoint.Free;
            Exit;
        end;
    end;
end;

procedure TPointList.Add(p: TPoint);
begin
    inherited Add(p);
end;

procedure TPointList.Clear;
var
    i: integer;
begin
    for i := 0 to self.Count - 1 do
    begin
        if ((self[i] = nil) or (TPoint(self[i]) = nil)) then
            continue;
        TPoint(self[i]).Free;
    end;
    inherited Clear();
end;

function TPointList.CompareDst(const first, other: TPoint): boolean;
begin
    Result := first.GetDistance() > other.GetDistance();
end;

function TPointList.CompareX(const first, other: TPoint): boolean;
begin
    Result := first.X > other.X;
end;

function TPointList.CompareY(const first, other: TPoint): boolean;
begin
    Result := first.Y > other.Y;
end;

procedure TPointList.Delete(index: integer);
begin
    if ((index < 0) or (index > self.Count - 1)) then
        Exit;
    if ((self[index] = nil) or (TPoint(self[index]) = nil)) then
        Exit;
    TPoint(self[index]).Free;
    Inherited Delete(index);
end;

procedure TPointList.Sort(vs: TVarSort; ts: TSortType);
var
    i, j, len: integer;
    isDesc, compareResult: boolean;
    temp: TPoint;
    sortFunction: TCompareFunction;
begin
    isDesc := ts = TSortType.tsDesc;
    case vs of
        TVarSort.vsX:
            sortFunction := self.CompareX;
        TVarSort.vsY:
            sortFunction := self.CompareY;
        TVarSort.vsDistance:
            sortFunction := self.CompareDst;
    end;
    len := self.Count;
    for i := 0 to len - 1 do
    begin
        for j := i to len - 1 do
        begin
            compareResult := sortFunction(TPoint(self[i]), TPoint(self[j]));
            if (isDesc) then
                compareResult := not compareResult;
            if (not compareResult) then
                continue;
            temp := self[i];
            self[i] := self[j];
            self[j] := temp;
        end;
    end;
end;
{$ENDREGION}
{ TMainForm }
{$REGION 'Main Form'}

procedure TMainForm.acOpenExecute(Sender: TObject);
var
    allText, tokenString: string;
    i, tokenStart, tokenLength, counter: integer;
    currentChar: char;
    currentToken: TToken;
    tokenList: TList<TToken>;
    tempList: TPointList;
begin
    FormatSettings.DecimalSeparator := dotseparator;
    if (op_TextFileDialog.Execute() <> true) then
        Exit;

    try
        allText := TFile.ReadAllText(op_TextFileDialog.FileName,
          TEncoding.GetEncoding(op_TextFileDialog.Encodings
          [op_TextFileDialog.EncodingIndex]));
    except
        ShowMessage
          ('Неправильно выбрана кодировака файла. Попробуйте ещё раз.');
        Exit;
    end;

    i := 1;
    currentToken.start := i;
    currentToken.length := 0;
    tokenList := TList<TToken>.Create;
    tokenLength := 0;
    tokenStart := 0;
    while i <= length(allText) do
    begin
        currentChar := allText[i];
        if (currentChar.IsWhiteSpace) then
        begin
            tokenList.Add(TToken.CreateToken(tokenStart, tokenLength));

            tokenStart := i;
            tokenLength := 0;
            inc(i);
            continue;
        end;

        inc(tokenLength, 1);
        inc(i);
        if (i > length(allText)) and (tokenLength <> 0) then
        begin
            tokenList.Add(TToken.CreateToken(tokenStart, tokenLength));
        end;

    end;

    if (tokenList.Count = 0) then
    begin
        ShowMessage
          ('Ошибка считывания файла. Файл пуст или невозможно разобрать числа.');
        Exit;
    end;

    tempList := TPointList.Create();

    i := 0;
    counter := tokenList.Count;
    while i < counter do
    begin
        tokenString := allText.Substring(tokenList[i].start,
          tokenList[i].length);
        if (string.IsNullOrWhiteSpace(tokenString)) or
          (string.IsNullOrEmpty(tokenString)) then
        begin
            tokenList.Delete(i);
            continue;
        end;
        counter := tokenList.Count;
        inc(i);
    end;

    if ((tokenList.Count mod 2) <> 0) then
    begin
        ShowMessage('Ошибка считывания файла. Не хватает одного значения.');
        Exit;
    end;

    i := 0;
    while i < tokenList.Count - 1 do
    begin
        tokenString := allText.Substring(tokenList[i].start,
          tokenList[i].length) + whitespace + allText.Substring
          (tokenList[i + 1].start, tokenList[i + 1].length);
        tempList.Add(tokenString);
        inc(i, 2);
    end;

    FPointList.Clear;
    FPointList.Free;
    FPointList := tempList;

    InvalidateVisuals();

    acSort.Enabled := true;

    // В задании по варианта пришлось закоментить это дело
    acSort.Execute;
    if (self.FSortBy = TVarSort.vsX) or (FSortBy = TVarSort.vsY) then
    begin
        FPointList.Sort(TVarSort.vsDistance, FSortType);
        InvalidateDistances;
    end
    else
    begin
        FPointList.Sort(TVarSort.vsX, FSortType);
        InvalidateList;
    end;
end;

procedure TMainForm.acSortExecute(Sender: TObject);
begin
    FSortBy := TVarSort(rg_SortBy.ItemIndex);
    FSortType := TSortType(rg_SortType.ItemIndex);
    self.InvalidateSorting;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    FPointList := TPointList.Create;
end;

procedure TMainForm.InvalidateDistances;
var
    i: integer;
    msg: string;
begin
    m_SortDist.LockDrawing;
    m_SortDist.Lines.Clear;
    for i := 0 to FPointList.Count - 1 do
    begin
        msg := TPoint(FPointList[i]).GetDistance()
          .toString(TFloatFormat.ffNumber, 5, 3);
        m_SortDist.Lines.Add(format('%d) %s', [i + 1, msg]));
    end;
    m_SortDist.UnlockDrawing;
end;

procedure TMainForm.InvalidateList;
var
    i: integer;
    msg: string;
begin
    m_SortList.LockDrawing;
    m_SortList.Lines.Clear;
    for i := 0 to FPointList.Count - 1 do
    begin
        msg := TPoint(FPointList[i]).toString;
        m_SortList.Lines.Add(format('%d) %s', [i + 1, msg]));
    end;
    m_SortList.UnlockDrawing;
end;

procedure TMainForm.InvalidateSorting;
var
    i: integer;
    target: TMemo;
begin
    FPointList.Sort(FSortBy, FSortType);
    case FSortBy of
        vsX:
            InvalidateList;
        vsY:
            InvalidateList;
        vsDistance:
            InvalidateDistances;
    end;

end;

procedure TMainForm.InvalidateVisuals;
var
    i: integer;
    msg: string;
begin
    m_InitialList.Lines.Clear;
    m_InitialDist.Lines.Clear;
    m_SortDist.Lines.Clear;
    m_SortList.Lines.Clear;
    m_InitialList.LockDrawing;
    m_InitialDist.LockDrawing;
    for i := 0 to FPointList.Count - 1 do
    begin
        msg := TPoint(FPointList[i]).toString;
        m_InitialList.Lines.Add(format('%d) %s', [i + 1, msg]));
        msg := TPoint(FPointList[i]).GetDistance()
          .toString(TFloatFormat.ffNumber, 5, 3);
        m_InitialDist.Lines.Add(format('%d) %s', [i + 1, msg]));
    end;
    m_InitialList.UnlockDrawing;
    m_InitialDist.UnlockDrawing;
end;

{$ENDREGION}

{ TToken }
class function TToken.CreateToken(st, ln: integer): TToken;
begin
    Result.start := st;
    Result.length := ln;
end;

end.
