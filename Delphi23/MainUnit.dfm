object MainForm: TMainForm
  Left = 449
  Top = 145
  BorderStyle = bsDialog
  Caption = '2-3-By-Bershadsky'
  ClientHeight = 614
  ClientWidth = 1182
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
  OnCreate = FormCreate
  TextHeight = 15
  object Panel1: TPanel
    Left = 5
    Top = 5
    Width = 211
    Height = 604
    Align = alLeft
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 0
    object Button1: TButton
      Left = 56
      Top = 304
      Width = 81
      Height = 33
      Action = acSort
      TabOrder = 1
    end
    object Button2: TButton
      Left = 56
      Top = 255
      Width = 81
      Height = 33
      Action = acOpen
      TabOrder = 0
    end
    object rg_SortType: TRadioGroup
      Left = 0
      Top = 0
      Width = 211
      Height = 96
      Align = alTop
      Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1080
      ItemIndex = 0
      Items.Strings = (
        #1055#1086' '#1074#1086#1079#1088#1072#1089#1090#1072#1085#1080#1102
        #1055#1086' '#1091#1073#1099#1074#1072#1085#1080#1102)
      TabOrder = 2
    end
    object rg_SortBy: TRadioGroup
      Left = 0
      Top = 96
      Width = 211
      Height = 128
      Align = alTop
      Caption = #1057#1087#1086#1089#1086#1073' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1080
      ItemIndex = 0
      Items.Strings = (
        #1055#1086' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1077' X'
        #1055#1086' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1077' Y'
        #1055#1086' '#1088#1072#1089#1089#1090#1086#1103#1085#1080#1102' '#1086#1090' '#1094#1077#1085#1090#1088#1072)
      TabOrder = 3
    end
  end
  object gb_SortList: TGroupBox
    Left = 936
    Top = 5
    Width = 240
    Height = 604
    Align = alLeft
    Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1085#1085#1099#1081' '#1089#1087#1080#1089#1086#1082
    TabOrder = 1
    object m_SortList: TMemo
      Left = 2
      Top = 17
      Width = 236
      Height = 585
      TabStop = False
      Align = alClient
      Lines.Strings = (
        '')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 456
    Top = 5
    Width = 240
    Height = 604
    Align = alLeft
    Caption = #1048#1089#1093#1086#1076#1085#1099#1077' '#1088#1072#1089#1089#1090#1086#1103#1085#1080#1103
    TabOrder = 2
    object m_InitialDist: TMemo
      Left = 2
      Top = 17
      Width = 236
      Height = 585
      TabStop = False
      Align = alClient
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 696
    Top = 5
    Width = 240
    Height = 604
    Align = alLeft
    Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1085#1085#1099#1077' '#1088#1072#1089#1089#1090#1086#1103#1085#1080#1103
    TabOrder = 3
    object m_SortDist: TMemo
      Left = 2
      Top = 17
      Width = 236
      Height = 585
      TabStop = False
      Align = alClient
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object GroupBox4: TGroupBox
    Left = 216
    Top = 5
    Width = 240
    Height = 604
    Align = alLeft
    Caption = #1048#1089#1093#1086#1076#1085#1099#1081' '#1089#1087#1080#1089#1086#1082
    TabOrder = 4
    object m_InitialList: TMemo
      Left = 2
      Top = 17
      Width = 236
      Height = 585
      TabStop = False
      Align = alClient
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object ac_List: TActionList
    Left = 152
    Top = 544
    object acSort: TAction
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Enabled = False
      OnExecute = acSortExecute
    end
    object acOpen: TAction
      Caption = #1054#1090#1082#1088#1099#1090#1100
      OnExecute = acOpenExecute
    end
  end
  object op_TextFileDialog: TOpenTextFileDialog
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' (*.txt)|*.TXT'
    Left = 56
    Top = 544
  end
end
