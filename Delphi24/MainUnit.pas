unit MainUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
    Vcl.StdCtrls, ComObj, Vcl.Grids, Vcl.ExtCtrls, System.Threading, ActiveX;

{$DEFINE ShowWindow_}
{$DEFINE UpdateOnFill}

type



//¬Õ»Ã¿Õ»≈
//ƒ¿ÕÕ€…  Œƒ≈÷ ﬂ «¿œ”— ¿À ¬ ARCHITECT(—œ»–¿◊≈ÕÕ¿ﬂ, œÀ¿“Õ¿ﬂ) ¬≈–—»» ƒ≈À‘» 11.4.
//Õ¿  ŒÃœ¿’ »Õ—“»“”“¿ ƒ¿ÕÕ€…  Œƒ≈÷ Õ≈  ŒÃœÀ»À—ﬂ(¬€ƒ¿¬¿À Œÿ»¡ ”)
//¬ —¬ﬂ«» — ◊≈Ã –≈ ŒÃ≈Õƒ”ﬁ «¿œ”—“»“‹ ≈√Œ ” —≈¡ﬂ
//«¿…“» ¬ œ¿œ ”, √ƒ≈ ’–¿Õ»“—ﬂ œ–Œ≈ “, «¿…“» ¬ œ¿œ ” win32
//» Õ¿…“» .EXE ‘¿…À » œ–»Õ≈—“» ≈√Œ ¬ »Õ—“»“”“ (≈√Œ » œŒ ¿«¿“‹, ”ƒ»¬»¬ œ–» ›“ŒÃ Ã¿√»◊≈— » –¿¡Œ“¿ﬁŸ»Ã  ŒƒŒÃ)
//À»¡Œ ∆≈ (ﬂ Õ≈ œ–Œ¡Œ¬¿À) ÃŒ∆ÕŒ ”¡–¿“‹ ¬—≈ ".VALUE" »« ƒŒ ”Ã≈Õ“¿

//«‡ÏÂ˜Û, ˜ÚÓ ÔË ‚˚ÔÓÎÌÂÌËË Á‡‰‡ÌËˇ ÔÓ ‚‡Ë‡ÌÚ‡Ï
//‚˚ÎÂÁÎÓ, ÚÓ ˜ÚÓ ÒÚ‡˚Â ‚ÂÒËË Excel ÚÛÔÓ ÌÂ ÔÓ‰‰ÂÊË‚‡ÎË ÌÛÊÌ˚Â ÙË˜Ë
//ÕÓ Á‰ÂÒ¸ ‚Ò∏ ‰ÓÎÊÌÓ ‡·ÓÚ‡Ú¸.

    TMainForm = class(TForm)
        ButtonLaunch: TButton;
        acList: TActionList;
        acRunExcel: TAction;
        op_FileDialog: TOpenDialog;
        ButtonOpen: TButton;
        acOpenFile: TAction;
        acSolve: TAction;
        acCloseApp: TAction;
        ButtonSolve: TButton;
        ButtonClose: TButton;
        sg_RootsDisplay: TStringGrid;
        edt_x1: TEdit;
        edt_x2: TEdit;
        edt_x3: TEdit;
        edt_y3: TEdit;
        edt_y2: TEdit;
        edt_y1: TEdit;
        edt_z1: TEdit;
        edt_res1: TEdit;
        edt_z2: TEdit;
        edt_res2: TEdit;
        edt_z3: TEdit;
        edt_res3: TEdit;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        Label6: TLabel;
        Label7: TLabel;
        Label8: TLabel;
        Label9: TLabel;
        Panel1: TPanel;
        Button1: TButton;
        acFillTable: TAction;
    Label10: TLabel;
        procedure acRunExcelExecute(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure acOpenFileExecute(Sender: TObject);
        procedure acSolveExecute(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure acCloseAppExecute(Sender: TObject);
        procedure acFillTableExecute(Sender: TObject);
    private
        FExcel: variant;

        FX1: string;
        FX2: string;
        FX3: string;

        FY1: string;
        FY2: string;
        FY3: string;

        FZ1: string;
        FZ2: string;
        FZ3: string;

        FR1: string;
        FR2: string;
        FR3: string;

        FRoot1: string;
        FRoot2: string;
        FRoot3: string;

        function InvalidateVariables(): Boolean;
        function AddWorkBook(): variant;
        function IsExcelOpened(): Boolean;
        procedure PassVariables();
        procedure StartExcel();
        procedure Solve();
        procedure ShowEditWarning(const edit: TEdit);
        procedure RetrieveResults();
        procedure RetrieveVariables();
        procedure InvalidateResults();
        procedure InvalidateVisuals();
    end;

const
    ExDeterminant: string = '=ÃŒœ–≈ƒ(A1:C3)';
    ExInvertMatrix: string = '=ÃŒ¡–(A1:C3)';
    ExMatrixMult: string = '=Ã”ÃÕŒ∆(C5:E7;D1:D3)';
    ExNumError: string = '!◊»—ÀŒ';
var
    MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.acCloseAppExecute(Sender: TObject);
begin
    if (not IsExcelOpened()) then
        Exit;
    FExcel.Workbooks[1].Close(False);
    FExcel.Quit;
    FExcel := Unassigned;
    ButtonClose.Visible := False;
end;

procedure TMainForm.acFillTableExecute(Sender: TObject);
var
    i: integer;
begin
    Randomize();
    if (not IsExcelOpened()) then
    begin
        StartExcel();
        AddWorkBook();
    end;

    FExcel.Range['A1'] := Random(10).ToString;
    FExcel.Range['A2'] := Random(10).ToString;
    FExcel.Range['A1:A2'].AutoFill(FExcel.Range['A1:A12'], 2);

    FX1 := FExcel.Range['A1'].Value;
    FX2 := FExcel.Range['A2'].Value;
    FX3 := FExcel.Range['A3'].Value;

    FY1 := FExcel.Range['A4'].Value;
    FY2 := FExcel.Range['A5'].Value;
    FY3 := FExcel.Range['A6'].Value;

    FZ1 := FExcel.Range['A7'].Value;
    FZ2 := FExcel.Range['A8'].Value;
    FZ3 := FExcel.Range['A9'].Value;

    FR1 := FExcel.Range['A10'].Value;
    FR2 := FExcel.Range['A11'].Value;
    FR3 := FExcel.Range['A12'].Value;

    InvalidateVisuals();

{$IFDEF UpdateOnFill}
    acSolve.Execute();
{$ENDIF}
end;

procedure TMainForm.InvalidateVisuals;
begin
    edt_x1.Text := FX1;
    edt_x2.Text := FX2;
    edt_x3.Text := FX3;

    edt_y1.Text := FY1;
    edt_y2.Text := FY2;
    edt_y3.Text := FY3;

    edt_z1.Text := FZ1;
    edt_z2.Text := FZ2;
    edt_z3.Text := FZ3;

    edt_res1.Text := FR1;
    edt_res2.Text := FR2;
    edt_res3.Text := FR3;
end;

procedure TMainForm.acOpenFileExecute(Sender: TObject);
begin
    if (op_FileDialog.Execute() <> true) then
        Exit;
    if (not(IsExcelOpened())) then
    begin
        StartExcel();
    end
    else begin
        acCloseApp.Execute();
        StartExcel();
    end;
    FExcel.Workbooks.Open(op_FileDialog.FileName);
    RetrieveResults();
    RetrieveVariables();
    InvalidateResults();
    InvalidateVisuals();
end;

procedure TMainForm.acRunExcelExecute(Sender: TObject);
begin
    StartExcel();
    AddWorkBook();
end;

procedure TMainForm.acSolveExecute(Sender: TObject);
var
    i: integer;
    opening: Itask;
begin
    if (not IsExcelOpened()) then
    begin
        StartExcel();
        AddWorkBook;
    end;
    InvalidateVariables();
    PassVariables();
    Solve();
    RetrieveResults();
    InvalidateResults();
end;

function TMainForm.AddWorkBook: variant;
begin
    FExcel.Workbooks.Add();
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    if (IsExcelOpened()) then
    begin
        acCloseApp.Execute();
    end;
    CanClose := true;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    ButtonLaunch.TabOrder := 0;
    ButtonOpen.TabOrder := 1;
    ButtonSolve.TabOrder := 2;
    ButtonClose.TabOrder := 3;
    edt_x1.TabOrder := 4;
    edt_x2.TabOrder := 5;
    edt_x3.TabOrder := 6;
    edt_y1.TabOrder := 7;
    edt_y2.TabOrder := 8;
    edt_y3.TabOrder := 9;
    edt_z1.TabOrder := 10;
    edt_z2.TabOrder := 11;
    edt_z3.TabOrder := 12;
    edt_res1.TabOrder := 13;
    edt_res2.TabOrder := 14;
    edt_res3.TabOrder := 15;
end;

function TMainForm.IsExcelOpened: Boolean;
begin
    Result := not VarIsClear(FExcel);
    if (not Result) then
        Exit();
    try
        FExcel.Range['A1'];
    except
        Exit(False);
    end;
end;

procedure TMainForm.PassVariables;
begin
    if (not IsExcelOpened()) then
        StartExcel;
    try
        FExcel.Range['A1'].Value := FX1;
        FExcel.Range['A2'].Value := FX2;
        FExcel.Range['A3'].Value := FX3;

        FExcel.Range['B1'].Value := FY1;
        FExcel.Range['B2'].Value := FY2;
        FExcel.Range['B3'].Value := FY3;

        FExcel.Range['C1'].Value := FZ1;
        FExcel.Range['C2'].Value := FZ2;
        FExcel.Range['C3'].Value := FZ3;

        FExcel.Range['D1'].Value := FR1;
        FExcel.Range['D2'].Value := FR2;
        FExcel.Range['D3'].Value := FR3;
    except

    end;
end;

procedure TMainForm.RetrieveResults;
begin
    if (VarType(FExcel.Range['G5'].Value) <> varError) then
    begin
        FRoot1 := FExcel.Range['G5'].Value;
    end
    else
        FRoot1 := ExNumError;

    if (VarType(FExcel.Range['G6'].Value) <> varError) then
    begin
        FRoot2 := FExcel.Range['G6'].Value;
    end
    else
        FRoot2 := ExNumError;

    if (VarType(FExcel.Range['G7'].Value) <> varError) then
    begin
        FRoot3 := FExcel.Range['G7'].Value;
    end
    else
        FRoot3 := ExNumError;
end;

procedure TMainForm.RetrieveVariables;
begin
    FX1 := FExcel.Range['A1'].Value;
    FX2 := FExcel.Range['A2'].Value;
    FX3 := FExcel.Range['A3'].Value;

    FY1 := FExcel.Range['B1'].Value;
    FY2 := FExcel.Range['B2'].Value;
    FY3 := FExcel.Range['B3'].Value;

    FZ1 := FExcel.Range['C1'].Value;
    FZ2 := FExcel.Range['C2'].Value;
    FZ3 := FExcel.Range['C3'].Value;

    FR1 := FExcel.Range['D1'].Value;
    FR2 := FExcel.Range['D2'].Value;
    FR3 := FExcel.Range['D3'].Value;
end;

procedure TMainForm.InvalidateResults;
begin
    sg_RootsDisplay.Cells[0, 1] := FRoot1;
    sg_RootsDisplay.Cells[1, 1] := FRoot2;
    sg_RootsDisplay.Cells[2, 1] := FRoot3;
end;

function TMainForm.InvalidateVariables: Boolean;
var
    temp: double;
begin
    Result := False;
{$REGION 'X edits'}
    if (not double.TryParse(edt_x1.Text, temp)) then
    begin
        ShowEditWarning(edt_x1);
        Exit;
    end;
    if (not double.TryParse(edt_x2.Text, temp)) then
    begin
        ShowEditWarning(edt_x2);
        Exit;
    end;
    if (not double.TryParse(edt_x3.Text, temp)) then
    begin
        ShowEditWarning(edt_x3);
        Exit;
    end;

{$ENDREGION}
{$REGION 'Y edits'}
    if (not double.TryParse(edt_y1.Text, temp)) then
    begin
        ShowEditWarning(edt_y1);
        Exit;
    end;
    if (not double.TryParse(edt_y2.Text, temp)) then
    begin
        ShowEditWarning(edt_y2);
        Exit;
    end;
    if (not double.TryParse(edt_y3.Text, temp)) then
    begin
        ShowEditWarning(edt_y3);
        Exit;
    end;
{$ENDREGION}
{$REGION 'Z edits'}
    if (not double.TryParse(edt_z1.Text, temp)) then
    begin
        ShowEditWarning(edt_z1);
        Exit;
    end;
    if (not double.TryParse(edt_z2.Text, temp)) then
    begin
        ShowEditWarning(edt_z2);
        Exit;
    end;
    if (not double.TryParse(edt_z3.Text, temp)) then
    begin
        ShowEditWarning(edt_z3);
        Exit;
    end;
{$ENDREGION}
{$REGION 'Result edits'}
    if (not double.TryParse(edt_res1.Text, temp)) then
    begin
        ShowEditWarning(edt_res1);
        Exit;
    end;
    if (not double.TryParse(edt_res2.Text, temp)) then
    begin
        ShowEditWarning(edt_res2);
        Exit;
    end;
    if (not double.TryParse(edt_res3.Text, temp)) then
    begin
        ShowEditWarning(edt_res3);
        Exit;
    end;
{$ENDREGION}
    FX1 := edt_x1.Text;
    FX2 := edt_x2.Text;
    FX3 := edt_x3.Text;

    FY1 := edt_y1.Text;
    FY2 := edt_y2.Text;
    FY3 := edt_y3.Text;

    FZ1 := edt_z1.Text;
    FZ2 := edt_z2.Text;
    FZ3 := edt_z3.Text;

    FR1 := edt_res1.Text;
    FR2 := edt_res2.Text;
    FR3 := edt_res3.Text;
    Result := true;
end;

procedure TMainForm.ShowEditWarning(const edit: TEdit);
begin
    if (string.IsNullOrEmpty(edit.Text)) then
        ShowMessage('¬‚Â‰ÂÌÓ ÔÛÒÚÓÂ ÁÌ‡˜ÂÌËÂ.')
    else
        ShowMessage(Format('ÕÂÍÓÂÍÚÌÓ ‚‚Â‰ÂÌÌÓÂ ÁÌ‡˜ÂÌËÂ "%s".',
          [edit.Text]));
    edit.SetFocus;
end;

procedure TMainForm.Solve();
begin
    if (not IsExcelOpened()) then
    begin
        StartExcel;
        if (not InvalidateVariables) then
            Exit;
        PassVariables;
    end;
    FExcel.Range['A5'].FormulaArray := ExDeterminant;
    FExcel.Range['C5:E7'].FormulaArray := ExInvertMatrix;
    FExcel.Range['G5:G7'].FormulaArray := ExMatrixMult;
end;

procedure TMainForm.StartExcel;
begin
    FExcel := CreateOleObject('Excel.Application');
{$IFDEF ShowWindow}
    FExcel.Visible := true;
{$ELSE}
    FExcel.Visible := False;
{$ENDIF}
    ButtonClose.Visible := true;
end;

end.
