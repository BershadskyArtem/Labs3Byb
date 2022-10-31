unit Main;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
    System.Actions, Vcl.ActnList, Math, Vcl.ComCtrls;

type
    TMainForm = class(TForm)
        Panel1: TPanel;
        tmr: TTimer;
        im_Cnvs: TImage;
        Button1: TButton;
        Actions: TActionList;
        ToggleMove: TAction;
        edt_Radius: TEdit;
        Label1: TLabel;
        tbr_Step: TTrackBar;
        Label2: TLabel;
        lbl_Step: TLabel;
        tbr_smoothness: TTrackBar;
        Label3: TLabel;
        lbl_tick: TLabel;
        procedure FormCreate(Sender: TObject);
        procedure ToggleMoveExecute(Sender: TObject);
        procedure tmrTimer(Sender: TObject);
        procedure tbr_StepChange(Sender: TObject);
        procedure edt_RadiusChange(Sender: TObject);
        procedure tbr_smoothnessChange(Sender: TObject);
    private
        FCanvas: TCanvas;

        // circle
        FCircleRadius: integer;
        FCirclePos: TPoint;
        FPointAngleDeg: double;

        // point
        FPointPos: TPoint;
        FPointRadius: integer;
        FRotationStepDeg: double;
        FPointColor: TColor;

        FIsMoving: boolean;
        FTickTime: cardinal;

        function InvalidateVariables(): boolean;
        procedure InvalidateVisuals();

    public
        { Public declarations }
    end;

var
    MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.edt_RadiusChange(Sender: TObject);
begin
    InvalidateVariables();
    InvalidateVisuals();
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    FTickTime := 10;
    FCanvas := im_Cnvs.Canvas;
    FPointAngleDeg := 0;
    FCircleRadius := 100;
    FPointRadius := 5;
    FRotationStepDeg := 1;
    FCirclePos.X := im_Cnvs.Width div 2;
    FCirclePos.Y := im_Cnvs.Height div 2;
    FPointPos.X := FCirclePos.X;
    FPointPos.Y := FCirclePos.Y;
    FPointColor := clRed;
    FCanvas.Pen.Color := FPointColor;
    FCanvas.Brush.Color := FPointColor;
    InvalidateVariables();
    InvalidateVisuals();
end;

function TMainForm.InvalidateVariables(): boolean;
var
    newRadius: integer;
begin
    if (not integer.TryParse(edt_Radius.Text, newRadius) or (newRadius = 0))
    then
    begin
        ToggleMove.Caption := 'Запустить';
        FIsMoving := not FIsMoving;
        tmr.Enabled := FIsMoving;
        Exit(false);
    end;

    // FRotationStepDeg := 45 * (tbr_Smoothness.Max + 1 - tbr_Smoothness.Position)/tbr_Smoothness.Max;
    FRotationStepDeg := tbr_smoothness.Position;
    FPointRadius := newRadius;

    FPointPos.X := Trunc(FCircleRadius * cos(DegToRad(FPointAngleDeg)) +
      FCirclePos.X);
    FPointPos.Y := Trunc(FCircleRadius * sin(DegToRad(FPointAngleDeg)) +
      FCirclePos.Y);

    //ХЗ почему, но увеличение этой штуки до 1000 шагов в секунду особо не даёт прирост в скорости
    FTickTime := (tbr_Step.Max + 1) - tbr_Step.Position;
    lbl_tick.Caption := Round((1000 / FTickTime)).ToString();
    tmr.Interval := FTickTime;
    lbl_Step.Caption := FRotationStepDeg.ToString();
    Exit(true);
end;

procedure TMainForm.InvalidateVisuals;
var
    prevColor: TColor;
begin
    prevColor := FCanvas.Brush.Color;
    FCanvas.Brush.Color := clWhite;

    FCanvas.FillRect(FCanvas.ClipRect);

    FCanvas.Brush.Color := prevColor;

    FCanvas.Ellipse(FPointPos.X - FPointRadius, FPointPos.Y - FPointRadius,
      FPointPos.X + FPointRadius, FPointPos.Y + FPointRadius);
end;

procedure TMainForm.tbr_smoothnessChange(Sender: TObject);
begin
    InvalidateVariables();
end;

procedure TMainForm.tbr_StepChange(Sender: TObject);
begin
    InvalidateVariables();
end;

procedure TMainForm.tmrTimer(Sender: TObject);
begin
    if (not InvalidateVariables()) then
    begin
        Exit;
    end;
    if (not FIsMoving) then
        Exit;
    FPointAngleDeg := FPointAngleDeg + FRotationStepDeg;
    if (FPointAngleDeg >= 360) then
        FPointAngleDeg := 0;

    InvalidateVisuals();
end;

procedure TMainForm.ToggleMoveExecute(Sender: TObject);
begin

    if (FIsMoving) then
    begin
        // Stop
        ToggleMove.Caption := 'Запустить';
    end
    else
    begin
        // Start
        if (not InvalidateVariables()) then
        begin
            ShowMessage('Что-то пошло не так...');
            Exit;
        end;
        InvalidateVisuals;
        ToggleMove.Caption := 'Остановить';
    end;

    FIsMoving := not FIsMoving;
    tmr.Enabled := FIsMoving;
end;

end.
