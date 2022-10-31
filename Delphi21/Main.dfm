object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = '2-1-By-Bershadsky'
  ClientHeight = 662
  ClientWidth = 1040
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 15
  object im_Cnvs: TImage
    Left = 0
    Top = 0
    Width = 1040
    Height = 582
    Align = alClient
    ExplicitLeft = 320
    ExplicitTop = 216
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object Panel1: TPanel
    Left = 0
    Top = 582
    Width = 1040
    Height = 80
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 23
      Top = 16
      Width = 108
      Height = 15
      Caption = #1056#1072#1076#1080#1091#1089' '#1086#1082#1088#1091#1078#1085#1086#1089#1090#1080
    end
    object Label2: TLabel
      Left = 264
      Top = 16
      Width = 112
      Height = 15
      Caption = #1063#1072#1089#1090#1086#1090#1072' ('#1096#1072#1075#1086#1074'/'#1089#1077#1082')'
      WordWrap = True
    end
    object lbl_Step: TLabel
      Left = 701
      Top = 16
      Width = 6
      Height = 15
      Caption = '1'
    end
    object Label3: TLabel
      Left = 535
      Top = 16
      Width = 156
      Height = 15
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1075#1088#1072#1076#1091#1089#1086#1074' '#1079#1072' '#1096#1072#1075
      WordWrap = True
    end
    object lbl_tick: TLabel
      Left = 396
      Top = 16
      Width = 24
      Height = 15
      Caption = '1000'
    end
    object Button1: TButton
      Left = 153
      Top = 29
      Width = 89
      Height = 33
      Action = ToggleMove
      TabOrder = 0
    end
    object edt_Radius: TEdit
      Left = 23
      Top = 37
      Width = 105
      Height = 23
      Alignment = taCenter
      NumbersOnly = True
      TabOrder = 1
      Text = '5'
      OnChange = edt_RadiusChange
    end
    object tbr_Step: TTrackBar
      Left = 264
      Top = 37
      Width = 265
      Height = 30
      Max = 50
      Min = 1
      Position = 1
      TabOrder = 2
      OnChange = tbr_StepChange
    end
    object tbr_smoothness: TTrackBar
      Left = 535
      Top = 37
      Width = 250
      Height = 45
      Max = 45
      Min = 1
      Position = 1
      TabOrder = 3
      OnChange = tbr_smoothnessChange
    end
  end
  object tmr: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrTimer
    Left = 1000
    Top = 608
  end
  object Actions: TActionList
    Left = 960
    Top = 614
    object ToggleMove: TAction
      Caption = #1047#1072#1087#1091#1089#1082
      OnExecute = ToggleMoveExecute
    end
  end
end
