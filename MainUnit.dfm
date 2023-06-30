object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1085#1086#1077' '#1089#1088#1077#1076#1089#1090#1074#1086' '#1091#1095#1105#1090#1072' '#1076#1074#1080#1078#1077#1085#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
  ClientHeight = 464
  ClientWidth = 1004
  Color = clCream
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Trebuchet MS'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object CreateNew: TButton
    Left = 826
    Top = 384
    Width = 170
    Height = 49
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = CreateNewClick
  end
  object ChooseAuthor: TComboBox
    Left = 384
    Top = 39
    Width = 281
    Height = 24
    Style = csDropDownList
    TabOrder = 1
    OnChange = ChooseAuthorChange
    Items.Strings = (
      #1074#1089#1077)
  end
  object ChooseType: TComboBox
    Left = 384
    Top = 100
    Width = 281
    Height = 24
    Style = csDropDownList
    TabOrder = 2
    OnChange = ChooseTypeChange
  end
  object StaticText1: TStaticText
    Left = 384
    Top = 16
    Width = 148
    Height = 17
    Caption = #1040#1074#1090#1086#1088' ('#1082#1077#1084' '#1087#1086#1076#1087#1080#1089#1072#1085')'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object StaticText2: TStaticText
    Left = 384
    Top = 77
    Width = 104
    Height = 17
    Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object SearchName: TEdit
    Left = 16
    Top = 39
    Width = 225
    Height = 24
    TabOrder = 5
    OnKeyPress = SearchNameKeyPress
  end
  object Search: TButton
    Left = 831
    Top = 39
    Width = 154
    Height = 56
    Caption = #1055#1086#1080#1089#1082
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'MS Reference Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = SearchClick
  end
  object ToArchive: TButton
    Left = 826
    Top = 239
    Width = 170
    Height = 48
    Caption = #1055#1086#1083#1086#1078#1080#1090#1100' '#1074' '#1072#1088#1093#1080#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = ToArchiveClick
  end
  object GoWork: TButton
    Left = 826
    Top = 166
    Width = 170
    Height = 50
    Caption = #1056#1072#1073#1086#1090#1072' '#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1084
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = GoWorkClick
  end
  object ArcOrCur: TRadioGroup
    Left = 16
    Top = 77
    Width = 225
    Height = 49
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100':'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      #1076#1077#1081#1089#1090#1074#1091#1102#1097#1080#1077
      #1072#1088#1093#1080#1074)
    ParentFont = False
    TabOrder = 9
    StyleElements = []
    OnClick = ArcOrCurClick
  end
  object GoDelete: TButton
    Left = 826
    Top = 312
    Width = 170
    Height = 49
    Caption = #1059#1076#1072#1083#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    OnClick = GoDeleteClick
  end
  object StaticText3: TStaticText
    Left = 120
    Top = 16
    Width = 28
    Height = 17
    Caption = #1048#1084#1103
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
  end
  object StaticText4: TStaticText
    Left = 673
    Top = 140
    Width = 136
    Height = 20
    Caption = #1057#1087#1080#1089#1086#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
  end
  object StaticText5: TStaticText
    Left = 64
    Top = 143
    Width = 212
    Height = 17
    Caption = #1041#1083#1080#1078#1072#1081#1096#1072#1103' '#1076#1072#1090#1072' '#1086#1079#1085#1072#1082#1086#1084#1083#1077#1085#1080#1103
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
  end
  object StaticText6: TStaticText
    Left = 328
    Top = 143
    Width = 28
    Height = 17
    Caption = #1048#1084#1103
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
  end
  object DocsToWatch: TListBox
    Left = 16
    Top = 166
    Width = 793
    Height = 267
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ItemHeight = 18
    ParentFont = False
    TabOrder = 15
  end
end
