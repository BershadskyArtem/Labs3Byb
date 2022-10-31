object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = '2-4-By-Bershadsky'
  ClientHeight = 387
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Padding.Left = 5
  Padding.Top = 5
  Padding.Right = 5
  Padding.Bottom = 5
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 15
  object Label10: TLabel
    Left = 60
    Top = 209
    Width = 125
    Height = 15
    Caption = '* !'#1063#1048#1057#1051#1054' - '#1085#1077#1090' '#1082#1086#1088#1085#1077#1081
  end
  object ButtonLaunch: TButton
    Left = 324
    Top = 153
    Width = 121
    Height = 33
    Action = acRunExcel
    TabOrder = 0
    Visible = False
  end
  object ButtonOpen: TButton
    Left = 8
    Top = 16
    Width = 121
    Height = 33
    Action = acOpenFile
    TabOrder = 1
  end
  object ButtonSolve: TButton
    Left = 8
    Top = 55
    Width = 121
    Height = 33
    Action = acSolve
    TabOrder = 2
  end
  object ButtonClose: TButton
    Left = 8
    Top = 134
    Width = 121
    Height = 33
    Action = acCloseApp
    TabOrder = 3
    Visible = False
  end
  object sg_RootsDisplay: TStringGrid
    Left = 143
    Top = 17
    Width = 310
    Height = 120
    TabStop = False
    ColCount = 3
    DefaultColWidth = 100
    DefaultColAlignment = taCenter
    DefaultRowHeight = 37
    FixedCols = 0
    RowCount = 3
    FixedRows = 0
    GridLineWidth = 2
    ScrollBars = ssNone
    TabOrder = 4
  end
  object Panel1: TPanel
    Left = 40
    Top = 230
    Width = 389
    Height = 124
    BevelOuter = bvNone
    TabOrder = 5
    object Label1: TLabel
      Left = 86
      Top = 85
      Width = 15
      Height = 15
      Caption = 'X+'
    end
    object Label2: TLabel
      Left = 86
      Top = 55
      Width = 15
      Height = 15
      Caption = 'X+'
    end
    object Label3: TLabel
      Left = 86
      Top = 25
      Width = 15
      Height = 15
      Caption = 'X+'
    end
    object Label4: TLabel
      Left = 183
      Top = 55
      Width = 15
      Height = 15
      Caption = 'Y+'
    end
    object Label5: TLabel
      Left = 183
      Top = 25
      Width = 15
      Height = 15
      Caption = 'Y+'
    end
    object Label6: TLabel
      Left = 183
      Top = 85
      Width = 15
      Height = 15
      Caption = 'Y+'
    end
    object Label7: TLabel
      Left = 284
      Top = 25
      Width = 15
      Height = 15
      Caption = 'Z='
    end
    object Label8: TLabel
      Left = 284
      Top = 85
      Width = 15
      Height = 15
      Caption = 'Z='
    end
    object Label9: TLabel
      Left = 284
      Top = 55
      Width = 15
      Height = 15
      Caption = 'Z='
    end
    object edt_z1: TEdit
      Left = 218
      Top = 25
      Width = 60
      Height = 23
      Alignment = taCenter
      TabOrder = 8
      Text = '1'
    end
    object edt_z2: TEdit
      Left = 218
      Top = 55
      Width = 60
      Height = 23
      Alignment = taCenter
      TabOrder = 10
      Text = '-1'
    end
    object edt_z3: TEdit
      Left = 218
      Top = 85
      Width = 60
      Height = 23
      Alignment = taCenter
      TabOrder = 11
      Text = '0'
    end
    object edt_res1: TEdit
      Left = 311
      Top = 25
      Width = 60
      Height = 23
      Alignment = taCenter
      TabOrder = 7
      Text = '4'
    end
    object edt_res2: TEdit
      Left = 311
      Top = 55
      Width = 60
      Height = 23
      Alignment = taCenter
      TabOrder = 9
      Text = '1'
    end
    object edt_res3: TEdit
      Left = 311
      Top = 85
      Width = 60
      Height = 23
      Alignment = taCenter
      TabOrder = 3
      Text = '1'
    end
    object edt_x1: TEdit
      Left = 20
      Top = 25
      Width = 60
      Height = 23
      Alignment = taCenter
      TabOrder = 0
      Text = '1'
    end
    object edt_x2: TEdit
      Left = 20
      Top = 55
      Width = 60
      Height = 23
      Alignment = taCenter
      TabOrder = 1
      Text = '0'
    end
    object edt_x3: TEdit
      Left = 20
      Top = 85
      Width = 60
      Height = 23
      Alignment = taCenter
      TabOrder = 2
      Text = '3'
    end
    object edt_y1: TEdit
      Left = 117
      Top = 25
      Width = 60
      Height = 23
      Alignment = taCenter
      TabOrder = 4
      Text = '0'
    end
    object edt_y2: TEdit
      Left = 117
      Top = 55
      Width = 60
      Height = 23
      Alignment = taCenter
      TabOrder = 5
      Text = '2'
    end
    object edt_y3: TEdit
      Left = 117
      Top = 85
      Width = 60
      Height = 23
      Alignment = taCenter
      TabOrder = 6
      Text = '-1'
    end
  end
  object Button1: TButton
    Left = 8
    Top = 94
    Width = 121
    Height = 34
    Action = acFillTable
    TabOrder = 6
  end
  object acList: TActionList
    Left = 240
    Top = 144
    object acRunExcel: TAction
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' Excel'
      OnExecute = acRunExcelExecute
    end
    object acOpenFile: TAction
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
      OnExecute = acOpenFileExecute
    end
    object acSolve: TAction
      Caption = #1056#1077#1096#1080#1090#1100
      OnExecute = acSolveExecute
    end
    object acCloseApp: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1087#1088#1086#1075#1088#1072#1084#1084#1091
      OnExecute = acCloseAppExecute
    end
    object acFillTable: TAction
      Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100
      OnExecute = acFillTableExecute
    end
  end
  object op_FileDialog: TOpenDialog
    Filter = 'Excel '#1092#1072#1081#1083#1099'|*.xlsx|'#1057#1090#1072#1088#1099#1077' Excel '#1092#1072#1081#1083#1099'|*.xls'
    Left = 168
    Top = 144
  end
end
