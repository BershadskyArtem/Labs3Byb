object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = '2-2-By-Bershadsky'
  ClientHeight = 581
  ClientWidth = 765
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Padding.Left = 10
  Padding.Top = 10
  Padding.Right = 10
  Padding.Bottom = 10
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 13
    Top = 13
    Width = 244
    Height = 92
    Caption = #1044#1080#1072#1087#1072#1079#1086#1085
    TabOrder = 0
    object edt_Min: TLabeledEdit
      Left = 16
      Top = 42
      Width = 75
      Height = 23
      EditLabel.Width = 56
      EditLabel.Height = 15
      EditLabel.Caption = #1052#1080#1085#1080#1084#1091#1084
      TabOrder = 0
      Text = ''
    end
    object edt_Max: TLabeledEdit
      Left = 134
      Top = 42
      Width = 75
      Height = 23
      EditLabel.Width = 60
      EditLabel.Height = 15
      EditLabel.Caption = #1052#1072#1082#1089#1080#1084#1091#1084
      TabOrder = 1
      Text = ''
    end
  end
  object edt_ArrSize: TLabeledEdit
    Left = 294
    Top = 55
    Width = 75
    Height = 23
    EditLabel.Width = 65
    EditLabel.Height = 15
    EditLabel.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
    TabOrder = 1
    Text = ''
  end
  object m_ListDisplay: TMemo
    Left = 456
    Top = 10
    Width = 299
    Height = 561
    Align = alRight
    Lines.Strings = (
      '')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object Button1: TButton
    Left = 29
    Top = 128
    Width = 91
    Height = 34
    Action = acCreateList
    TabOrder = 3
  end
  object gbx_EditArray: TGroupBox
    Left = 13
    Top = 200
    Width = 340
    Height = 153
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1089#1087#1080#1089#1086#1082
    TabOrder = 4
    Visible = False
    object edt_Digit: TLabeledEdit
      Left = 16
      Top = 40
      Width = 75
      Height = 23
      EditLabel.Width = 35
      EditLabel.Height = 15
      EditLabel.Caption = #1063#1080#1089#1083#1086
      TabOrder = 0
      Text = ''
      OnChange = edt_DigitChange
    end
    object edt_Number: TLabeledEdit
      Left = 113
      Top = 40
      Width = 75
      Height = 23
      EditLabel.Width = 38
      EditLabel.Height = 15
      EditLabel.Caption = #1053#1086#1084#1077#1088
      TabOrder = 1
      Text = ''
      OnChange = edt_NumberChange
    end
    object Button2: TButton
      Left = 16
      Top = 88
      Width = 91
      Height = 34
      Action = acAdd
      TabOrder = 2
    end
    object Button3: TButton
      Left = 113
      Top = 88
      Width = 91
      Height = 33
      Action = acDelete
      TabOrder = 3
    end
    object Button4: TButton
      Left = 215
      Top = 88
      Width = 91
      Height = 33
      Action = acInsert
      TabOrder = 4
    end
  end
  object acList: TActionList
    Left = 32
    Top = 528
    object acCreateList: TAction
      Caption = #1057#1087#1080#1089#1086#1082
      OnExecute = acCreateListExecute
    end
    object acAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Enabled = False
      OnExecute = acAddExecute
    end
    object acDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      OnExecute = acDeleteExecute
    end
    object acInsert: TAction
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Enabled = False
      OnExecute = acInsertExecute
    end
  end
end
