object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = '2-5-By-Bershadsky'
  ClientHeight = 522
  ClientWidth = 698
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 127
    Height = 15
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1101#1083#1077#1084#1077#1085#1090#1086#1074
  end
  object Label2: TLabel
    Left = 24
    Top = 59
    Width = 134
    Height = 15
    Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
  end
  object Label3: TLabel
    Left = 24
    Top = 96
    Width = 138
    Height = 15
    Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
  end
  object Label4: TLabel
    Left = 24
    Top = 192
    Width = 62
    Height = 15
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099
  end
  object Label5: TLabel
    Left = 376
    Top = 16
    Width = 42
    Height = 15
    Caption = #1052#1072#1089#1089#1080#1074
  end
  object m_Display: TMemo
    Left = 376
    Top = 37
    Width = 308
    Height = 471
    Lines.Strings = (
      '')
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 24
    Top = 144
    Width = 98
    Height = 33
    Action = ac_Calculate
    TabOrder = 1
  end
  object stg_Results: TStringGrid
    Left = 24
    Top = 213
    Width = 320
    Height = 295
    ColCount = 2
    DefaultColWidth = 160
    RowCount = 4
    TabOrder = 2
  end
  object edt_Count: TEdit
    Left = 184
    Top = 21
    Width = 121
    Height = 23
    NumbersOnly = True
    TabOrder = 3
    Text = '10'
  end
  object edt_Min: TEdit
    Left = 184
    Top = 56
    Width = 121
    Height = 23
    TabOrder = 4
    Text = '1'
  end
  object edt_Max: TEdit
    Left = 184
    Top = 93
    Width = 121
    Height = 23
    TabOrder = 5
    Text = '10'
  end
  object acList: TActionList
    Left = 224
    Top = 128
    object ac_Calculate: TAction
      Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100
      OnExecute = ac_CalculateExecute
    end
  end
end
