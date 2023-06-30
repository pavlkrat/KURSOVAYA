object CreateForm: TCreateForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
  ClientHeight = 323
  ClientWidth = 512
  Color = clInactiveCaption
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Trebuchet MS'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object EnterName: TEdit
    Left = 118
    Top = 8
    Width = 286
    Height = 24
    MaxLength = 33
    TabOrder = 0
  end
  object StaticText1: TStaticText
    Left = 8
    Top = 8
    Width = 104
    Height = 17
    Caption = #1048#1084#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object StaticText2: TStaticText
    Left = 8
    Top = 71
    Width = 28
    Height = 17
    Caption = #1058#1080#1087
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object EnterType: TComboBox
    Left = 118
    Top = 67
    Width = 286
    Height = 24
    Style = csDropDownList
    TabOrder = 3
  end
  object StaticText3: TStaticText
    Left = 8
    Top = 100
    Width = 92
    Height = 17
    Caption = #1055#1091#1090#1100' '#1082' '#1092#1072#1081#1083#1091
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object GoAddAg: TButton
    Left = 159
    Top = 263
    Width = 192
    Height = 42
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077' '#1083#1080#1094#1086
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = GoAddAgClick
  end
  object AgentList: TListBox
    Left = 118
    Top = 128
    Width = 230
    Height = 67
    TabOrder = 6
  end
  object StaticText4: TStaticText
    Left = 8
    Top = 128
    Width = 84
    Height = 17
    Caption = #1054#1079#1085#1072#1082#1086#1084#1080#1090#1100
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object EnterFIO: TEdit
    Left = 8
    Top = 211
    Width = 329
    Height = 24
    MaxLength = 20
    TabOrder = 8
  end
  object StaticText5: TStaticText
    Left = 8
    Top = 193
    Width = 64
    Height = 17
    Caption = #1060#1048#1054' '#1083#1080#1094#1072
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
  end
  object StaticText6: TStaticText
    Left = 8
    Top = 240
    Width = 196
    Height = 17
    Caption = #1050#1088#1072#1081#1085#1080#1081' '#1089#1088#1086#1082' '#1086#1079#1085#1072#1082#1086#1084#1083#1077#1085#1080#1103
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
  end
  object GoPickDate: TDatePicker
    Left = 8
    Top = 271
    Width = 145
    Height = 24
    Date = 45041.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    TabOrder = 11
  end
  object GoCreateDoc: TButton
    Left = 366
    Top = 211
    Width = 131
    Height = 95
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    OnClick = GoCreateDocClick
  end
  object GoDelDoc: TButton
    Left = 366
    Top = 137
    Width = 131
    Height = 42
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    OnClick = GoDelDocClick
  end
  object StaticText7: TStaticText
    Left = 8
    Top = 40
    Width = 96
    Height = 17
    Caption = #1050#1077#1084' '#1087#1086#1076#1087#1080#1089#1072#1085
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
  end
  object EnterAuthor: TEdit
    Left = 118
    Top = 40
    Width = 286
    Height = 24
    MaxLength = 33
    TabOrder = 15
  end
  object EnterPath: TButton
    Left = 118
    Top = 94
    Width = 94
    Height = 28
    Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1091#1090#1100
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 16
    OnClick = EnterPathClick
  end
  object PathDialog: TOpenDialog
    Left = 456
    Top = 16
  end
end
